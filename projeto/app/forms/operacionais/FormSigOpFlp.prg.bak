*==============================================================================
* FormSigOpFlp.prg
*
* Form OPERACIONAL - Consulta de FollowUp (historico de ocorrencias por
* Grupo/Conta). Layout CUSTOMIZADO - NAO segue o padrao Page1=Lista/Page2=Dados
* de cadastro: todos os containers ficam diretamente no Form, alternados por
* Visible conforme o fluxo do legado (SIGOPFLP).
*
* FASE 3/8: Estrutura base (classe, Init, InicializarForm, containers vazios,
* Destroy).
* FASE 4/8: Grade de FollowUp (grd_4c_Dados), grupos de botoes de acao
* (cmg_4c_Botoes com Incluir/Alterar/Excluir/Imprimir e cmg_4c_Encerrar) e a
* carga de dados que os alimenta (CarregarLista + VincularGrade).
* FASE 5/8: Campos (TextBoxes/Labels) dos containers de EXIBICAO - metade dos
* campos do form: cnt_4c_Agenda (Usuario/Agendamento da linha selecionada),
* cnt_4c_GruCon (Grupo/Conta/Razao Social, somente leitura), cnt_4c_Obs
* (Observacao da linha selecionada) e cnt_4c_Contato (Telefones/E-mail,
* container oculto por fChecaAcesso). Todos SOMENTE EXIBICAO nesta fase - a
* atualizacao de valor por linha de grade (AfterRowColChange) e a visibilidade
* condicional de cnt_4c_Contato ficam para a fase de eventos (Fases 7-8).
* Campos do painel de inclusao/alteracao (cnt_4c__Inserir) ficam para a
* Fase 6/8; eventos de Click/KeyPress dos botoes, para as Fases 7-8.
* FASE 7/8: Eventos dos botoes de acao sobre o historico selecionado na grade
* (cmg_4c_Botoes - cmdApagaitem do legado): BtnIncluirClick (cmdInserir),
* BtnAlterarClick (cmdAlterar), BtnExcluirClick (cmdApagar) e
* BtnImprimirClick (cmdListar), mais o funil de estado da tela
* (AjustarBotoesPorModo) e o bloco de permissoes do Init legado
* (AplicarAcessos / AjustarAcoesPorAcesso). O verbo Visualizar da barra CRUD
* do framework de cadastro NAO existe neste legado - a barra daqui eh de
* LINHA de grade (Incluir/Alterar/Apagar/Listar sobre a linha corrente), e
* inventar um botao a mais violaria o PILAR 1.
* Nesta fase tambem entraram os dois controles de Agendamento do painel
* (txt_4c_Agenda / lbl_4c_LblAgenda, legado Cnt_Inserir.GetAgenda e
* lblAgenda): a Fase 6 os perdeu e os Click de Incluir/Alterar que esta fase
* transcreve atribuem valor a eles.
* FASE 8/8 (FINAL): Confirmar (BtnSalvarClick, cobre INSERIR e ALTERAR via
* FormParaBO + NovoRegistro/EditarRegistro + BusinessBase.Salvar) e Cancelar
* (BtnCancelarClick) do painel, Encerrar (BtnEncerrarClick ->
* SigOpFlpBO.SalvarContato, grava Tel1s/Tel2s/DDDs/EMails em SigCdCli e fecha
* o form), BOParaForm (espelha Grupo/Conta/Razao Social em
* cnt_4c_GruCon e Telefones/E-mail em cnt_4c_Contato, chamado por
* CarregarLista), GridAfterRowColChange (cnt_4c_Obs/cnt_4c_Agenda seguem a
* linha corrente da grade) e GridColumnKeyPress (atalhos F2/F3/F4/F6 das
* celulas Column1/Column2.Text1, religados em TODA chamada de VincularGrade
* porque ColumnCount os recria). SigOpFlpBO ganhou LimparDados (reseta o
* historico ao NovoRegistro, evita vazar o registro do Alterar anterior para
* o proximo Incluir - regra #32) e SalvarContato.
* Validado em runtime contra o SQL Server real (192.168.200.10) em
* 2026-11-04: INSERT/UPDATE de SigCdClh e UPDATE idempotente de SigCdCli
* confirmados por releitura via SQL, sem deixar residuo (automation\
* probef8sigopflp734.prg).
*==============================================================================

DEFINE CLASS FormSigOpFlp AS FormBase

    *-- Propriedades da entidade/contexto (ClassInfo do legado: conta, grupo,
    *-- noper, placesso, tipo)
    this_cMensagemErro = ""
    this_cConta     = ""    && Codigo da conta/cliente (par_cConta do Init)
    this_dData      = {}    && Parametro par_dData do Init (recebido, nao usado pelo legado)
    this_cGrupo     = ""    && Grupo do cliente/conta (resolvido a partir da conta)
    this_nNoper     = 0     && Numero da operacao - filtra o historico de FollowUp
    this_lPlAcesso  = .F.   && Acesso de ALTERACAO ao SIGOPFLP (fChecaAcesso)
    this_cTipo      = ""    && Modo do painel de insercao: INSERIR / ALTERAR
    this_cCidChave  = ""    && Chave do registro em edicao no painel Cnt_Inserir

    *-- Os 4 campos de Cnt_Contato (telefones/DDD/e-mail) ja foram espelhados
    *-- do banco uma vez? No legado o bloco lcQryCli roda SO no Init e os
    *-- campos ficam ligados por ControlSource direto em crSigCdCli, entao
    *-- nada do legado os reescreve depois. Aqui CarregarLista roda de novo a
    *-- cada gravacao (reler o historico do banco e o equivalente, em camadas,
    *-- do Refresh do legado - regra #21a) e reexecuta a resolucao da conta;
    *-- sem esta flag, BOParaForm reescreveria os 4 campos com o valor do banco
    *-- e DESCARTARIA, em silencio, o que o usuario tivesse digitado neles
    *-- antes de Confirmar - e o Encerrar gravaria o valor revertido.
    this_lContatoCarregado = .F.

    *-- Configuracoes visuais do form (fieis ao SCX legado)
    DataSession  = 2
    ShowWindow = 1
    Width        = 1000
    Height       = 600
    Caption      = "Consulta de FollowUp"
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    WindowType   = 1
    Themes       = .F.

    *--------------------------------------------------------------------------
    * Init - DODEFAULT() chama FormBase.Init() -> THIS.InicializarForm()
    * Os parametros do legado (LParameters pConta, pData, pNoper) precisam
    * estar guardados ANTES de DODEFAULT(), pois InicializarForm() roda dentro
    * dele e as fases seguintes (carga de dados) dependem de this_cConta/this_nNoper.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cConta, par_dData, par_nNoper)
        THIS.this_cConta = IIF(VARTYPE(par_cConta) = "C", par_cConta, SPACE(10))
        THIS.this_dData  = IIF(VARTYPE(par_dData) = "D" OR VARTYPE(par_dData) = "T", par_dData, {})
        THIS.this_nNoper = IIF(VARTYPE(par_nNoper) = "N", par_nNoper, 0)

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init(). Cria o Business
    * Object e a estrutura visual basica do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpFlpBO")

            THIS.ConfigurarEstruturaBase()

            *-- Permissoes do Init legado (fChecaAcesso) - DEPOIS da estrutura,
            *-- porque TornarControlesVisiveis forca Visible = .T. em tudo o
            *-- que nao esta na lista de excecao e o estado por permissao tem
            *-- de ser a ultima palavra.
            THIS.AplicarAcessos()

            *-- Carga de dados: pulada quando o pipeline esta validando a UI ou
            *-- rodando o teste automatizado (sem conexao SQL disponivel).
            *-- Falha na carga NAO impede a tela de abrir - igual ao legado, que
            *-- so faz "Return" do Init quando a conta vem vazia.
            IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                 (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
                THIS.CarregarLista()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpFlp")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEstruturaBase - Cria a faixa do cabecalho e os containers
    * flutuantes vazios (sem campos internos ainda - Fases 5-6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEstruturaBase()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarContainerInserir()
        THIS.ConfigurarBotoesAcao()
        THIS.ConfigurarContainerContato()
        THIS.ConfigurarContainerAgenda()
        THIS.ConfigurarContainerGruCon()
        THIS.ConfigurarContainerObs()
        THIS.ConfigurarGrid()

        THIS.TornarControlesVisiveis(THIS)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra no legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .AutoSize   = .F.
            .Top        = 18
            .Left       = 10
            .Width      = 769
            .Height     = 40
            .ForeColor  = RGB(0, 0, 0)
            .Caption    = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .AutoSize   = .F.
            .Top        = 17
            .Left       = 10
            .Width      = 769
            .Height     = 46
            .ForeColor  = RGB(255, 255, 255)
            .Caption    = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerInserir - Painel de inclusao/alteracao de FollowUp
    * (Cnt_Inserir no legado). Comeca OCULTO - so aparece via cmdInserir/
    * cmdAlterar (Fase 7). Campos (Fase 6): Data/Hora, Usuario (somente
    * exibicao - legado: GetUsuario.When Return(.F.)), Historico (com lookup
    * para SigOpIns), Observacao (memo) e os 3 botoes do painel (Confirmar/
    * Cancelar/Historico). Logica de Click de BtnOk/BtnCancela (gravar/
    * cancelar o painel) fica para a Fase 7-8 - o botao de Historico (unico
    * lookup do form) e implementado aqui.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerInserir()
        THIS.AddObject("cnt_4c__Inserir", "Container")
        WITH THIS.cnt_4c__Inserir
            .Top         = 226
            .Left        = 8
            .Width       = 984
            .Height      = 371
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Data/Hora (GetData) - preenchido por codigo (DateTime() no Incluir,
        *-- CrSigCdClh.Datas no Alterar), nunca digitado em modo livre -
        *-- legado: When = (GetUsuario.Value = Usuar Or plAcesso)
        THIS.cnt_4c__Inserir.AddObject("txt_4c_Data", "TextBox")
        WITH THIS.cnt_4c__Inserir.txt_4c_Data
            .Top           = 5
            .Left          = 106
            .Width         = 150
            .Height        = 23
            .MaxLength     = 20
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Inserir.AddObject("lbl_4c_LblData", "Label")
        WITH THIS.cnt_4c__Inserir.lbl_4c_LblData
            .Caption   = "Data/Hora :"
            .Top       = 9
            .Left      = 45
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Usuario - SOMENTE EXIBICAO (legado: GetUsuario.When Return(.F.),
        *-- preenchido via codigo com Usuar no Incluir/Alterar)
        THIS.cnt_4c__Inserir.AddObject("txt_4c_Usuario", "TextBox")
        WITH THIS.cnt_4c__Inserir.txt_4c_Usuario
            .Top           = 5
            .Left          = 345
            .Width         = 78
            .Height        = 23
            .MaxLength     = 10
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Inserir.AddObject("lbl_4c_LblUsuario", "Label")
        WITH THIS.cnt_4c__Inserir.lbl_4c_LblUsuario
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Top       = 9
            .Left      = 298
            .Width     = 43
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Agendamento (GetAgenda do painel) - data/hora do proximo contato.
        *-- Preenchido por codigo no Incluir (fDtoSQL(Date(),"00:00:00")) e no
        *-- Alterar (DatAgens da linha), e editavel pelo usuario quando o
        *-- registro eh dele ou ele tem acesso de alteracao - legado:
        *-- When = (GetUsuario.Value = Usuar Or ThisForm.plAcesso).
        *-- Propriedades transcritas do dump (Top/Left/Width/Height/MaxLength/
        *-- Format); acrescentado na Fase 7 porque os Click de Incluir/Alterar
        *-- atribuem .GetAgenda.Value e a Fase 6 nao criou o controle.
        THIS.cnt_4c__Inserir.AddObject("txt_4c_Agenda", "TextBox")
        WITH THIS.cnt_4c__Inserir.txt_4c_Agenda
            .Top           = 30
            .Left          = 106
            .Width         = 150
            .Height        = 23
            .MaxLength     = 20
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Inserir.AddObject("lbl_4c_LblAgenda", "Label")
        WITH THIS.cnt_4c__Inserir.lbl_4c_LblAgenda
            .Caption   = "Agendamento :"
            .Top       = 31
            .Left      = 28
            .Width     = 74
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Historico - campo com LOOKUP (CmdHist abre busca em SigOpIns
        *-- Tipos = 3). Digitavel livremente; o botao Historico preenche a
        *-- partir do template escolhido.
        THIS.cnt_4c__Inserir.AddObject("txt_4c_Hist", "TextBox")
        WITH THIS.cnt_4c__Inserir.txt_4c_Hist
            .Top           = 55
            .Left          = 106
            .Width         = 871
            .Height        = 23
            .MaxLength     = 76
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Inserir.AddObject("lbl_4c_LblHist", "Label")
        WITH THIS.cnt_4c__Inserir.lbl_4c_LblHist
            .Caption   = "Hist" + CHR(243) + "rico :"
            .Top       = 55
            .Left      = 54
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Observacao (GetObs - fwmemo/EditBox)
        THIS.cnt_4c__Inserir.AddObject("obj_4c_GetObs", "EditBox")
        WITH THIS.cnt_4c__Inserir.obj_4c_GetObs
            .Top           = 80
            .Left          = 106
            .Width         = 871
            .Height        = 182
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Inserir.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c__Inserir.lbl_4c_Label1
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 79
            .Left      = 37
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Botao Historico (unico lookup do painel) - CORRESPONDE a CmdHist
        *-- do legado; Click implementado nesta fase (AbrirLookupHistorico)
        THIS.cnt_4c__Inserir.AddObject("cmd_4c_CmdHist", "CommandButton")
        WITH THIS.cnt_4c__Inserir.cmd_4c_CmdHist
            .Top       = 265
            .Left      = 107
            .Width     = 80
            .Height    = 100
            .FontName  = "Verdana"
            .FontSize  = 8
            .Picture   = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
            .Cancel    = .T.
            .Caption   = "Hist" + CHR(243) + "rico"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c__Inserir.cmd_4c_CmdHist, "Click", THIS, "AbrirLookupHistorico")

        *-- Botao Confirmar (BtnOk) - grava o painel (Case INSERIR/ALTERAR do
        *-- legado) via BtnSalvarClick
        THIS.cnt_4c__Inserir.AddObject("cmd_4c_BtnOk", "CommandButton")
        WITH THIS.cnt_4c__Inserir.cmd_4c_BtnOk
            .Top       = 265
            .Left      = 202
            .Width     = 80
            .Height    = 100
            .FontName  = "Verdana"
            .FontSize  = 8
            .Picture   = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Cancel    = .T.
            .Caption   = "Confirmar"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c__Inserir.cmd_4c_BtnOk, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (BtnCancela) - fecha o painel sem gravar via
        *-- BtnCancelarClick
        THIS.cnt_4c__Inserir.AddObject("cmd_4c_BtnCancela", "CommandButton")
        WITH THIS.cnt_4c__Inserir.cmd_4c_BtnCancela
            .Top       = 265
            .Left      = 283
            .Width     = 80
            .Height    = 100
            .FontName  = "Verdana"
            .FontSize  = 8
            .Picture   = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .Cancel    = .T.
            .Caption   = "Cancelar"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c__Inserir.cmd_4c_BtnCancela, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupHistorico - Lookup do campo Historico do painel de
    * inclusao/alteracao. Transcrito de SIGOPFLP.Cnt_Inserir.CmdHist.Click:
    *   SqlExecute([Select * From SigOpIns Where Tipos = 3],"crSigOpIns")
    *   Locate For Descrs = GetHist.Value
    *   If Eof(): abre fwBuscaInt (migrado: FormBuscaAuxiliar)
    *   Se nao ESC: GetHist.Value = Descrs / GetObs.Value = Mensas
    * O legado tenta o match exato ANTES de abrir o picker - FormBuscaAuxiliar
    * ja faz isso sozinho no Init (this_lAchouRegistro), entao nao duplicamos
    * a consulta de existencia aqui (regra #37 - FormBuscaAuxiliar tem
    * contrato).
    *
    * PUBLIC (chamado via BINDEVENT no Click do cmd_4c_CmdHist).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupHistorico()
        LOCAL loc_oBusca, loc_cValorDigitado, loc_oErro

        TRY
            loc_cValorDigitado = ALLTRIM(THIS.cnt_4c__Inserir.txt_4c_Hist.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpIns", ;
                "cursor_4c_BuscaHist", ;
                "descrs", ;
                loc_cValorDigitado, ;
                "Hist" + CHR(243) + "ricos", ;
                .F., .T., "tipos = " + FormatarNumeroSQL(3, 0))

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descrs", "", "Hist" + CHR(243) + "rico")
                    loc_oBusca.mAddColuna("mensas", "", "Mensagem")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaHist")
                    SELECT cursor_4c_BuscaHist
                    THIS.cnt_4c__Inserir.txt_4c_Hist.Value    = ALLTRIM(cursor_4c_BuscaHist.descrs)
                    THIS.cnt_4c__Inserir.obj_4c_GetObs.Value  = TratarNulo(cursor_4c_BuscaHist.mensas, "")
                ENDIF

                IF USED("cursor_4c_BuscaHist")
                    USE IN cursor_4c_BuscaHist
                ENDIF

                loc_oBusca.Release()
            ENDIF

            THIS.cnt_4c__Inserir.txt_4c_Hist.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao buscar Hist" + CHR(243) + "rico")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Grupos de botoes de acao do topo (CommandGroup1 e
    * cmdApagaitem no legado). CommandGroup1 tem 1 botao (Encerrar); o Click
    * nao e ligado aqui - o legado usa o evento Valid de Command1 para gravar
    * contato e fechar o form (logica real na fase de eventos).
    * cmdApagaitem tem 4 botoes de acao sobre o historico selecionado na
    * grade: Excluir, Imprimir, Incluir, Alterar (ordem exata do legado -
    * Command1..Command4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("cmg_4c_Encerrar", "CommandGroup")
        WITH THIS.cmg_4c_Encerrar
            .Top           = -2
            .Left          = 920
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.cmg_4c_Encerrar.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Cancel          = .T.
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        *-- Legado: CommandGroup1.Command1.Valid (grava telefones/e-mail da
        *-- conta em SigCdCli e encerra o form) - Valid de CommandGroup nao eh
        *-- confiavel via BINDEVENT; Click do unico botao do grupo reproduz o
        *-- mesmo gatilho (usuario aciona o botao).
        BINDEVENT(THIS.cmg_4c_Encerrar.Buttons(1), "Click", THIS, "BtnEncerrarClick")

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = -2
            .Left          = 620
            .Width         = 310
            .Height        = 85
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Buttons(1) = cmdApagar (Excluir)
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .ToolTipText     = "<F4> Excluir"
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        *-- Buttons(2) = cmdListar (Imprimir)
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Caption         = "Imprimir"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .PicturePosition = 13
            .ToolTipText     = "<F6> Imprimir"
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        *-- Buttons(3) = cmdInserir (Incluir)
        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Incluir"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .PicturePosition = 13
            .ToolTipText     = "<F2> Incluir"
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
            .WordWrap        = .T.
        ENDWITH

        *-- Buttons(4) = cmdAlterar (Alterar)
        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Alterar"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .ToolTipText     = "<F3> Alterar"
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
            .WordWrap        = .T.
        ENDWITH

        *-- Click dos 4 botoes de acao. Cada Buttons(N) segue a ordem de
        *-- declaracao do legado (Apagar=1, Listar=2, Inserir=3, Alterar=4),
        *-- que NAO eh a ordem visual esquerda-direita. Todos os handlers sao
        *-- PUBLIC - BINDEVENT ignora metodo PROTECTED em silencio (regra #3).
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnIncluirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnAlterarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnExcluirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerContato - Painel de telefones/e-mail do cliente
    * (CntContato no legado). Visibilidade real depende de fChecaAcesso
    * ('SIGOPFLP','CONTATO'), aplicado nas fases de dados/eventos. Gravacao
    * (CommandGroup1.Command1.Valid do legado - Update SigCdCli) tambem fica
    * para a fase de eventos (botao Encerrar).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerContato()
        THIS.AddObject("cnt_4c_Contato", "Container")
        WITH THIS.cnt_4c_Contato
            .Top         = 164
            .Left        = 8
            .Width       = 984
            .Height      = 57
            .BackStyle   = 0
            .BorderWidth = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        THIS.cnt_4c_Contato.AddObject("lbl_4c_LblFone", "Label")
        WITH THIS.cnt_4c_Contato.lbl_4c_LblFone
            .Caption   = "Telefones :"
            .Top       = 8
            .Left      = 48
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Contato.AddObject("txt_4c_DDDs", "TextBox")
        WITH THIS.cnt_4c_Contato.txt_4c_DDDs
            .Top           = 4
            .Left          = 106
            .Width         = 38
            .Height        = 23
            .MaxLength     = 4
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Contato.AddObject("txt_4c_Tel1", "TextBox")
        WITH THIS.cnt_4c_Contato.txt_4c_Tel1
            .Top           = 4
            .Left          = 146
            .Width         = 150
            .Height        = 23
            .MaxLength     = 20
            .Format        = "K!"
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Contato.AddObject("txt_4c_Tel2", "TextBox")
        WITH THIS.cnt_4c_Contato.txt_4c_Tel2
            .Top           = 4
            .Left          = 298
            .Width         = 150
            .Height        = 23
            .MaxLength     = 20
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Contato.AddObject("lbl_4c_LbleMail", "Label")
        WITH THIS.cnt_4c_Contato.lbl_4c_LbleMail
            .Caption   = "e-mail :"
            .Top       = 32
            .Left      = 67
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Contato.AddObject("txt_4c_Email", "TextBox")
        WITH THIS.cnt_4c_Contato.txt_4c_Email
            .Top           = 29
            .Left          = 106
            .Width         = 430
            .Height        = 23
            .MaxLength     = 50
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerAgenda - Usuario/Data de agendamento da linha
    * selecionada na grade (CntAgenda no legado). Os dois campos sao SOMENTE
    * LEITURA (legado: When retorna .F. nos dois) - o valor vem da linha
    * corrente da grade (AfterRowColChange), ligado na fase de eventos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerAgenda()
        THIS.AddObject("cnt_4c_Agenda", "Container")
        WITH THIS.cnt_4c_Agenda
            .Top         = 88
            .Left        = 8
            .Width       = 551
            .Height      = 33
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Agenda.AddObject("txt_4c_Usuario", "TextBox")
        WITH THIS.cnt_4c_Agenda.txt_4c_Usuario
            .Top           = 4
            .Left          = 136
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Agenda.AddObject("lbl_4c_LblUsuario", "Label")
        WITH THIS.cnt_4c_Agenda.lbl_4c_LblUsuario
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Top       = 8
            .Left      = 89
            .Width     = 43
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Agenda.AddObject("txt_4c_Agenda", "TextBox")
        WITH THIS.cnt_4c_Agenda.txt_4c_Agenda
            .Top           = 4
            .Left          = 328
            .Width         = 144
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Agenda.AddObject("lbl_4c_LblAgenda", "Label")
        WITH THIS.cnt_4c_Agenda.lbl_4c_LblAgenda
            .Caption   = "Agendamento :"
            .Top       = 8
            .Left      = 250
            .Width     = 74
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerGruCon - Grupo/Conta/Razao Social em consulta
    * (CntGruCon no legado). Os tres campos sao SOMENTE LEITURA (legado:
    * Enabled = .F., fundo amarelo claro de destaque) - o valor eh resolvido
    * uma vez por CarregarDadosCliente/CarregarLista, nunca digitado aqui.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerGruCon()
        THIS.AddObject("cnt_4c_GruCon", "Container")
        WITH THIS.cnt_4c_GruCon
            .Top         = 126
            .Left        = 8
            .Width       = 984
            .Height      = 33
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_GruCon.AddObject("lbl_4c_LblGrupo", "Label")
        WITH THIS.cnt_4c_GruCon.lbl_4c_LblGrupo
            .Caption   = "Grupo :"
            .Top       = 8
            .Left      = 66
            .Width     = 36
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_GruCon.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.cnt_4c_GruCon.txt_4c_Grupo
            .Top                = 5
            .Left               = 106
            .Width              = 80
            .Height             = 23
            .MaxLength          = 10
            .FontName           = "Tahoma"
            .FontSize           = 8
            .SpecialEffect      = 1
            .Enabled            = .F.
            .Themes             = .F.
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(251, 247, 170)
            .DisabledBackColor  = RGB(251, 247, 170)
            .DisabledForeColor  = RGB(0, 0, 0)
            .BorderColor        = RGB(100, 100, 100)
            .Value              = ""
            .Visible            = .T.
        ENDWITH

        THIS.cnt_4c_GruCon.AddObject("lbl_4c_LblConta", "Label")
        WITH THIS.cnt_4c_GruCon.lbl_4c_LblConta
            .Caption   = "Conta :"
            .Top       = 8
            .Left      = 200
            .Width     = 36
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_GruCon.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.cnt_4c_GruCon.txt_4c_Conta
            .Top                = 5
            .Left               = 240
            .Width              = 80
            .Height             = 23
            .MaxLength          = 10
            .FontName           = "Tahoma"
            .FontSize           = 8
            .SpecialEffect      = 1
            .Enabled            = .F.
            .Themes             = .F.
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(251, 247, 170)
            .DisabledBackColor  = RGB(251, 247, 170)
            .DisabledForeColor  = RGB(0, 0, 0)
            .BorderColor        = RGB(100, 100, 100)
            .Value              = ""
            .Visible            = .T.
        ENDWITH

        THIS.cnt_4c_GruCon.AddObject("txt_4c_DConta", "TextBox")
        WITH THIS.cnt_4c_GruCon.txt_4c_DConta
            .Top                = 5
            .Left               = 322
            .Width              = 397
            .Height             = 23
            .MaxLength          = 50
            .FontName           = "Tahoma"
            .FontSize           = 8
            .SpecialEffect      = 1
            .Enabled            = .F.
            .Themes             = .F.
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(251, 247, 170)
            .DisabledBackColor  = RGB(251, 247, 170)
            .DisabledForeColor  = RGB(0, 0, 0)
            .BorderColor        = RGB(100, 100, 100)
            .Value              = ""
            .Visible            = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerObs - Observacao da linha de historico selecionada
    * (CntObs no legado). Campo SOMENTE LEITURA (legado: When retorna .F.) -
    * o valor vem da linha corrente da grade (AfterRowColChange), ligado na
    * fase de eventos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerObs()
        THIS.AddObject("cnt_4c_Obs", "Container")
        WITH THIS.cnt_4c_Obs
            .Top         = 487
            .Left        = 8
            .Width       = 984
            .Height      = 110
            .BackStyle   = 0
            .BorderWidth = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Obs.AddObject("lbl_4c_LblObs", "Label")
        WITH THIS.cnt_4c_Obs.lbl_4c_LblObs
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 4
            .Left      = 37
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Obs.AddObject("txt_4c_Obs", "TextBox")
        WITH THIS.cnt_4c_Obs.txt_4c_Obs
            .Top           = 4
            .Left          = 106
            .Width         = 871
            .Height        = 101
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Grade de historico de FollowUp (GridFollowUp no
    * legado). Apenas 2 colunas, somente leitura (ReadOnly = .T. no legado - a
    * edicao se da pelo painel Cnt_Inserir, nunca na celula). RecordSource e
    * Column.ControlSource NAO sao ligados aqui: o cursor ainda nao existe
    * neste ponto do Init e ligar ControlSource a cursor inexistente derruba a
    * tela ("Alias not found") - o vinculo e feito em VincularGrade(), chamado
    * por CarregarLista() depois da consulta.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top         = 226
            .Left        = 8
            .Width       = 984
            .Height      = 239
            .HeaderHeight       = 0
            .ColumnCount = 2
            .FontName    = "Arial"
            .ReadOnly    = .T.
            .ScrollBars  = 2
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .Visible     = .T.
        ENDWITH

        *-- Column1 - Data / Hora
        WITH THIS.grd_4c_Dados.Column1
            .FontName   = "Courier New"
            .Alignment  = 2
            .Width      = 150
            .Movable    = .F.
            .Resizable  = .F.
            .ReadOnly   = .T.
            .Visible    = .T.
        ENDWITH
        WITH THIS.grd_4c_Dados.Column1.Header1
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Data / Hora"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH THIS.grd_4c_Dados.Column1.Text1
            .FontName    = "Courier New"
            .Alignment   = 2
            .BorderStyle = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column2 - Historico
        WITH THIS.grd_4c_Dados.Column2
            .FontName   = "Courier New"
            .Width      = 802
            .Movable    = .F.
            .Resizable  = .F.
            .ReadOnly   = .T.
            .Visible    = .T.
        ENDWITH
        WITH THIS.grd_4c_Dados.Column2.Header1
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Hist" + CHR(243) + "rico"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH THIS.grd_4c_Dados.Column2.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Legado: GridFollowUp.AfterRowColChange (With CntObs/CntAgenda) -
        *-- bind UMA vez aqui porque grd_4c_Dados.Objeto sobrevive a
        *-- VincularGrade (so ColumnCount recria as Columns, nao o Grid).
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carga de dados da grade de FollowUp. Reproduz a sequencia
    * do Init legado: resolve Grupo/Razao da conta recebida (lcQryCli), executa
    * a consulta do historico (lStrQuery -> TmpCliH -> CrSigCdClh) e so entao
    * vincula a grade.
    *
    * PUBLIC de proposito: o harness de teste automatizado chama
    * THIS.oForm.CarregarLista() de FORA da classe (PROTECTED falharia em
    * runtime com "Property CARREGARLISTA is not found").
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Legado: "If Empty(pConta) / Return" - sem conta nao ha o que
            *-- consultar; a tela abre vazia.
            IF EMPTY(ALLTRIM(THIS.this_cConta))
                loc_lSucesso = .F.
            ELSE
                IF THIS.this_oBusinessObject.CarregarDadosCliente(THIS.this_cConta)
                    *-- Legado: ThisForm.Grupo = CrSigCdCli.Grupos
                    *--         ThisForm.Conta = Padr(pConta,10)
                    THIS.this_cGrupo = THIS.this_oBusinessObject.this_cGrupos
                    THIS.this_cConta = PADR(THIS.this_cConta, 10)

                    *-- Legado: With ThisForm.CntGruCon / .GetGrupo.Value = ... /
                    *-- .GetConta.Value = ... / .GetDConta.Value = CrSigCdCli.RClis /
                    *-- .Refresh / EndWith - e os campos de CntContato, que o
                    *-- legado liga por ControlSource direto em crSigCdCli.
                    THIS.BOParaForm()

                    IF THIS.this_oBusinessObject.CarregarHistorico( ;
                            THIS.this_cGrupo, THIS.this_cConta, THIS.this_nNoper)
                        THIS.VincularGrade()
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    IF !EMPTY(THIS.this_oBusinessObject.ObterMensagemErro())
                        MsgAviso(THIS.this_oBusinessObject.ObterMensagemErro(), ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpFlp.CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGrade - Liga a grade ao cursor de historico. Transcrito do final
    * do Init legado:
    *   With ThisForm.GridFollowUp
    *       .RecordSource = 'CrSigCdClh'
    *       .Column1.ControlSource = 'CrSigCdClh.Datas'
    *       .Column2.ControlSource = 'CrSigCdClh.Hists'
    *       .Refresh
    *   EndWith
    *
    * ORDEM OBRIGATORIA: ColumnCount -> RecordSource -> ControlSource ->
    * Width/Header1.Caption/ReadOnly. Atribuir RecordSource faz o VFP9
    * recalcular as larguras para o default 90 e apagar os captions, por isso
    * eles sao reaplicados DEPOIS do vinculo. Fecha com GO TOP + Refresh, senao
    * a grade fica visualmente vazia com o cursor cheio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGrade()
        LOCAL loc_oGrid

        IF !USED("cursor_4c_Dados")
            RETURN .F.
        ENDIF

        loc_oGrid = THIS.grd_4c_Dados

        WITH loc_oGrid
            .RecordSource          = ""
            .ColumnCount           = 2
            .RecordSource          = "cursor_4c_Dados"
            .Column1.ControlSource = "cursor_4c_Dados.datas"
            .Column2.ControlSource = "cursor_4c_Dados.hists"
        ENDWITH

        *-- Reaplicacao pos-vinculo (RecordSource reseta Width e Caption)
        WITH loc_oGrid.Column1
            .Width     = 150
            .Alignment = 2
            .FontName  = "Courier New"
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        loc_oGrid.Column1.Header1.Caption = "Data / Hora"

        WITH loc_oGrid.Column2
            .Width     = 802
            .FontName  = "Courier New"
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        loc_oGrid.Column2.Header1.Caption = "Hist" + CHR(243) + "rico"

        *-- Grid.ReadOnly propaga para as colunas: o ReadOnly da COLUNA vai
        *-- depois (legado: Grid.ReadOnly = .T. e Column1/2.ReadOnly = .T.)
        loc_oGrid.ReadOnly         = .T.
        loc_oGrid.Column1.ReadOnly = .T.
        loc_oGrid.Column2.ReadOnly = .T.

        *-- Legado: GridFollowUp.Column1.Text1.KeyPress / Column2.Text1.KeyPress
        *-- (atalhos F2/F3/F4/F6 sobre a linha corrente). Column1/Column2 sao
        *-- RECRIADAS a cada ColumnCount reatribuido acima, entao o bind tem de
        *-- ser refeito em TODA chamada de VincularGrade - religar na mesma
        *-- instancia antiga seria religar em objeto ja destruido.
        BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress", THIS, "GridColumnKeyPress")
        BINDEVENT(loc_oGrid.Column2.Text1, "KeyPress", THIS, "GridColumnKeyPress")

        SELECT cursor_4c_Dados
        GO TOP
        loc_oGrid.Refresh()

        *-- Legado: .AfterRowColChange() chamado explicitamente apos o
        *-- Refresh, no fim do Init - sincroniza CntObs/CntAgenda com a
        *-- primeira linha sem esperar o usuario navegar na grade.
        THIS.GridAfterRowColChange(1)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Espelha no form os dados de SigCdCli resolvidos
    * por CarregarDadosCliente. Legado (SIGOPFLP.Init):
    *     With ThisForm.CntGruCon
    *         .GetGrupo.Value  = ThisForm.Grupo
    *         .GetConta.Value  = ThisForm.Conta
    *         .GetDConta.Value = CrSigCdCli.RClis
    *         .Refresh
    *     EndWith
    * Os 4 campos de CntContato (GetTel1/GetTel2/GetDDDs/GetEmail) sao ligados
    * por ControlSource direto em crSigCdCli no legado - aqui sao copiados dos
    * mesmos valores (this_cTel1s/this_cTel2s/this_cDDDs/this_cEmails).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) = "O"
            IF PEMSTATUS(THIS, "cnt_4c_GruCon", 5)
                WITH THIS.cnt_4c_GruCon
                    .txt_4c_Grupo.Value  = ALLTRIM(THIS.this_cGrupo)
                    .txt_4c_Conta.Value  = ALLTRIM(THIS.this_cConta)
                    .txt_4c_DConta.Value = ALLTRIM(loc_oBO.this_cRClis)
                ENDWITH
                THIS.cnt_4c_GruCon.Refresh()
            ENDIF

            *-- SO na PRIMEIRA carga (ver this_lContatoCarregado): depois dela
            *-- o valor na tela e o autoritativo, igual ao legado - onde o
            *-- lcQryCli roda uma unica vez, no Init. Reescrever aqui a cada
            *-- CarregarLista apagaria a digitacao do usuario sem aviso.
            IF PEMSTATUS(THIS, "cnt_4c_Contato", 5) AND !THIS.this_lContatoCarregado
                WITH THIS.cnt_4c_Contato
                    .txt_4c_Tel1.Value  = ALLTRIM(loc_oBO.this_cTel1s)
                    .txt_4c_Tel2.Value  = ALLTRIM(loc_oBO.this_cTel2s)
                    .txt_4c_DDDs.Value  = ALLTRIM(loc_oBO.this_cDDDs)
                    .txt_4c_Email.Value = ALLTRIM(loc_oBO.this_cEmails)
                ENDWITH
                THIS.cnt_4c_Contato.Refresh()
                THIS.this_lContatoCarregado = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarAcessos - Bloco de permissoes do Init legado (SIGOPFLP.Init),
    * transcrito:
    *     With ThisForm.CmdApagaItem
    *         .CmdInserir.Visible = fChecaAcesso('SIGOPFLP','INSERIR')
    *         .CmdAlterar.Visible = fChecaAcesso('SIGOPFLP','ALTERAR')
    *         .CmdApagar.Visible  = fChecaAcesso('SIGOPFLP','EXCLUIR')
    *         .CmdListar.Visible  = fChecaAcesso('SIGOPFLP','LISTAR')
    *         ... (reempilhamento - ver AjustarAcoesPorAcesso)
    *     EndWith
    *     ThisForm.CntContato.Visible = fChecaAcesso('SIGOPFLP','CONTATO')
    *     ThisForm.plAcesso = fChecaAcesso([SIGOPFLP],[ALTERAR])
    * Mesma ordem do legado: acesso de alteracao, barra de acao e painel de
    * contato.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarAcessos()
        LOCAL loc_oErro

        TRY
            *-- plAcesso ANTES do funil: HabilitarCampos o consulta para
            *-- reproduzir o When dos campos do painel.
            THIS.this_lPlAcesso = THIS.ObterAcesso("ALTERAR")

            *-- Estado inicial pelo FUNIL, nunca direto no
            *-- AjustarAcoesPorAcesso: com this_cTipo vazio ele deixa o painel
            *-- fechado, a grade e os containers de consulta visiveis, e
            *-- reempilha os botoes de acao por permissao (regra #40).
            THIS.AjustarBotoesPorModo()

            THIS.cnt_4c_Contato.Visible = THIS.ObterAcesso("CONTATO")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AplicarAcessos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterAcesso - fChecaAcesso('SIGOPFLP', <operacao>) do legado, com a
    * chamada de 2 argumentos que o legado usa (os outros 3 parametros tem
    * fallback proprio na funcao).
    * Quem responde em runtime eh a funcao do Framework legado
    * (Framework\sigacess.PRG), carregada DEPOIS de utils\functions.prg e por
    * isso vencedora: ela abre conexao propria e consulta SigCdAcu. Sem banco
    * - validacao de UI e teste automatizado - a chamada ficaria pendurada
    * DENTRO do Init, por isso nesses dois modos o acesso eh concedido, pelo
    * mesmo critario que InicializarForm ja usa para pular CarregarLista.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterAcesso(par_cOperacao)
        LOCAL loc_lAcesso, loc_uRetorno
        loc_lAcesso = .T.

        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            loc_uRetorno = fChecaAcesso("SIGOPFLP", par_cOperacao)
            loc_lAcesso  = IIF(VARTYPE(loc_uRetorno) = "L", loc_uRetorno, .T.)
        ENDIF

        RETURN loc_lAcesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarAcoesPorAcesso - Mostra/esconde e REEMPILHA os 4 botoes de acao
    * conforme a permissao. Legado (SIGOPFLP.Init, With ThisForm.CmdApagaItem):
    *     lcPos = 5 / lcLrg = 80
    *     ... .Visible = fChecaAcesso(...) para os quatro ...
    *     If .CmdInserir.Visible / .CmdInserir.Left = lcPos / lcPos = lcPos + lcLrg / EndIf
    *     (repete para CmdAlterar, CmdApagar e CmdListar - nesta ordem)
    *     If lcPos > 5 / .Width = lcPos + 5 / .Refresh / Else / .Visible = .F. / EndIf
    * A ordem do reempilhamento eh Inserir/Alterar/Apagar/Listar, que NAO eh a
    * ordem de declaracao dos Buttons (Apagar=1, Listar=2, Inserir=3,
    * Alterar=4). Com os quatro visiveis o resultado eh 5/85/165/245 e
    * Width = 325 - esse, e nao o Left estatico do SCX, eh o que o usuario ve,
    * porque o Init legado sobrescreve sempre.
    * WITH .Buttons(N) em UM nivel dentro do WITH do CommandGroup eh seguro:
    * Buttons(N) eh accessor de colecao, nao AddObject (regra #38).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarAcoesPorAcesso()
        LOCAL loc_nPos, loc_nLrg, loc_oErro

        TRY
            loc_nPos = 5
            loc_nLrg = 80

            WITH THIS.cmg_4c_Botoes
                *-- O legado nao precisa reexibir o grupo aqui porque so roda
                *-- este bloco no Init; aqui ele eh o caminho de VOLTA do funil
                *-- (que esconde a barra enquanto o painel esta aberto), entao
                *-- a reexibicao tem de ser explicita - quem esconde reabilita
                *-- no funil de volta (regra #40). O ELSE do fim continua
                *-- podendo ocultar tudo, quando nao ha acesso a nada.
                .Visible = .T.

                .Buttons(3).Visible = THIS.ObterAcesso("INSERIR")
                .Buttons(4).Visible = THIS.ObterAcesso("ALTERAR")
                .Buttons(1).Visible = THIS.ObterAcesso("EXCLUIR")
                .Buttons(2).Visible = THIS.ObterAcesso("LISTAR")

                IF .Buttons(3).Visible
                    .Buttons(3).Left = loc_nPos
                    loc_nPos = loc_nPos + loc_nLrg
                ENDIF
                IF .Buttons(4).Visible
                    .Buttons(4).Left = loc_nPos
                    loc_nPos = loc_nPos + loc_nLrg
                ENDIF
                IF .Buttons(1).Visible
                    .Buttons(1).Left = loc_nPos
                    loc_nPos = loc_nPos + loc_nLrg
                ENDIF
                IF .Buttons(2).Visible
                    .Buttons(2).Left = loc_nPos
                    loc_nPos = loc_nPos + loc_nLrg
                ENDIF

                IF loc_nPos > 5
                    .Width = loc_nPos + 5
                    .Refresh()
                ELSE
                    .Visible = .F.
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AjustarAcoesPorAcesso")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - FUNIL UNICO de estado da tela, derivado de
    * this_cTipo (legado: ThisForm.Tipo). Reproduz, de uma vez, o bloco que o
    * legado repete em cmdInserir.Click, cmdAlterar.Click, BtnOk.Click e
    * BtnCancela.Click:
    *     CntObs / CntAgenda / GridFollowUp / CmdApagaItem / CommandGroup1
    *         .Visible = .F.  (painel aberto)   /   = .T.  (painel fechado)
    *     Cnt_Inserir.Visible = .T. / .F.
    * O painel flutuante fica em Top = 226, sobre a grade - por isso o legado
    * esconde a grade e os dois containers de consulta enquanto edita.
    * Existir como FUNIL eh o que impede o defeito classico de modo: quem muda
    * o estado dentro de cada botao esquece o caminho de VOLTA e deixa a tela
    * travada (regra #40).
    * PUBLIC: o harness de teste chama THIS.oForm.AjustarBotoesPorModo() de
    * FORA da classe, e PEMSTATUS(..., 5) devolve .T. mesmo para metodo
    * PROTECTED - o teste entraria no branch e a chamada estouraria em runtime
    * com "Property ... is not found" (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEditando, loc_oErro

        TRY
            loc_lEditando = INLIST(UPPER(ALLTRIM(THIS.this_cTipo)), "INSERIR", "ALTERAR")

            IF PEMSTATUS(THIS, "cnt_4c__Inserir", 5)
                THIS.cnt_4c__Inserir.Visible = loc_lEditando
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Obs", 5)
                THIS.cnt_4c_Obs.Visible = !loc_lEditando
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Agenda", 5)
                THIS.cnt_4c_Agenda.Visible = !loc_lEditando
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Visible = !loc_lEditando
            ENDIF
            IF PEMSTATUS(THIS, "cmg_4c_Encerrar", 5)
                THIS.cmg_4c_Encerrar.Visible = !loc_lEditando
            ENDIF

            IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
                IF loc_lEditando
                    THIS.cmg_4c_Botoes.Visible = .F.
                ELSE
                    *-- Caminho de VOLTA: quem reexibe a barra eh o bloco de
                    *-- permissao, que tambem decide se ela aparece.
                    THIS.AjustarAcoesPorAcesso()
                ENDIF
            ENDIF

            THIS.HabilitarCampos(loc_lEditando)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Libera ou trava os campos EDITAVEIS do painel.
    * Legado (When de Cnt_Inserir.GetData / GetAgenda / GetHist / GetObs):
    *     Return(This.Parent.GetUsuario.Value = Usuar or ThisForm.plAcesso)
    * Ou seja: so o autor do registro - ou quem tem acesso de ALTERAR - edita.
    * txt_4c_Usuario fica de fora porque o When dele eh Return(.F.): nasce e
    * continua somente leitura.
    * Chamado SO pelo funil AjustarBotoesPorModo, com o MESMO valor que decide
    * a visibilidade do painel: painel visivel -> campos liberados. Assim nao
    * existe estado em que o painel aparece com os campos travados sem motivo,
    * e a travada no fechamento eh invisivel ao usuario (regra #40).
    * PUBLIC pelo mesmo motivo de AjustarBotoesPorModo (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_lDono, loc_cUsuarioPainel, loc_cUsuarioLogado

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)

        IF PEMSTATUS(THIS, "cnt_4c__Inserir", 5)
            loc_cUsuarioPainel = ALLTRIM(UPPER(THIS.cnt_4c__Inserir.txt_4c_Usuario.Value))
            loc_cUsuarioLogado = ALLTRIM(UPPER(IIF(VARTYPE(gc_4c_UsuarioLogado) = "C", ;
                gc_4c_UsuarioLogado, "")))

            loc_lDono      = (loc_cUsuarioPainel == loc_cUsuarioLogado) OR THIS.this_lPlAcesso
            loc_lHabilitar = loc_lHabilitar AND loc_lDono

            WITH THIS.cnt_4c__Inserir
                .txt_4c_Data.ReadOnly   = !loc_lHabilitar
                .txt_4c_Agenda.ReadOnly = !loc_lHabilitar
                .txt_4c_Hist.ReadOnly   = !loc_lHabilitar
                .obj_4c_GetObs.ReadOnly = !loc_lHabilitar
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparPainelInsercao - Zera os campos do painel flutuante. Legado
    * (cmdInserir.Click): .GetHist.Value = '' / .GetObs.Value = ''.
    * Existe como metodo porque o form, diferente do legado (modal, um
    * registro por vida), nao fecha entre uma operacao e outra: campo residual
    * de um Incluir/Alterar anterior reapareceria no seguinte (regra #32).
    * Nome proprio em vez do hook LimparCampos de FormBase: o hook da base eh
    * PROTECTED e PROTECTED na base vence o override (regra #51), o que
    * deixaria o metodo inalcancavel de fora sem nenhum aviso de compilacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparPainelInsercao()
        IF PEMSTATUS(THIS, "cnt_4c__Inserir", 5)
            WITH THIS.cnt_4c__Inserir
                .txt_4c_Data.Value    = {}
                .txt_4c_Agenda.Value  = {}
                .txt_4c_Usuario.Value = ""
                .txt_4c_Hist.Value    = ""
                .obj_4c_GetObs.Value  = ""
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TemLinhaSelecionada - A grade tem linha corrente utilizavel?
    * Legado: 'Select CrSigCdClh / If !Eof()' no cmdApagar.Click.
    * IFs ANINHADOS de proposito: VFP9 NAO faz short-circuit, entao
    * 'USED(x) AND RECCOUNT(x) > 0' avaliaria o RECCOUNT com o alias FECHADO e
    * estouraria "Alias is not found".
    * PUBLIC: usado pelos handlers e disponivel ao harness de teste (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE TemLinhaSelecionada()
        LOCAL loc_lTem
        loc_lTem = .F.

        IF USED("cursor_4c_Dados")
            IF RECCOUNT("cursor_4c_Dados") > 0
                IF !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                    loc_lTem = .T.
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lTem
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarCelulaDataHora - Devolve o foco para a celula "Data / Hora" da
    * grade. Legado, no fim do cmdApagar.Click, do BtnOk.Click e do
    * BtnCancela.Click: 'ThisForm.GridFollowUp.Column1.Text1.SetFocus'.
    * Guardas: SetFocus em controle invisivel ou em grade sem linha estoura -
    * e a grade fica OCULTA enquanto o painel de edicao esta aberto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FocarCelulaDataHora()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            IF THIS.grd_4c_Dados.Visible
                IF THIS.TemLinhaSelecionada()
                    THIS.grd_4c_Dados.Column1.Text1.SetFocus()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencherPainelDaLinhaSelecionada - Copia a linha corrente da grade para
    * os campos do painel. Legado (cmdAlterar.Click):
    *     .GetData.Value    = CrSigCdClh.Datas
    *     .GetUsuario.Value = CrSigCdClh.Usuars
    *     .GetAgenda.Value  = Iif(!Empty(CrSigCdClh.DatAgens),CrSigCdClh.DatAgens,fDtoSQL(Date(),'00:00:00'))
    *     .GetHist.Value    = CrSigCdClh.Hists
    *     .GetObs.Value     = CrSigCdClh.Obs
    *     .BtnOk.Enabled    = (CrSigCdClh.Usuars = Usuar or ThisForm.plAcesso)
    * Os valores sao os MESMOS que o legado le direto do cursor, so o caminho
    * respeita as camadas (PILAR 3): o chamador ja fez
    * CarregarDoCursor("cursor_4c_Dados") e aqui so se le o BO.
    * this_cCidChave guarda a chave da linha em edicao (legado: pCIdChave),
    * que eh o WHERE do UPDATE.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PreencherPainelDaLinhaSelecionada()
        LOCAL loc_oBO, loc_cUsuarioLogado, loc_lDono

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) = "O"
            loc_cUsuarioLogado = ALLTRIM(UPPER(IIF(VARTYPE(gc_4c_UsuarioLogado) = "C", ;
                gc_4c_UsuarioLogado, "")))
            loc_lDono = (ALLTRIM(UPPER(loc_oBO.this_cUsuars)) == loc_cUsuarioLogado) OR ;
                THIS.this_lPlAcesso

            THIS.this_cCidChave = ALLTRIM(loc_oBO.this_cCidchaves)

            WITH THIS.cnt_4c__Inserir
                .txt_4c_Data.Value    = loc_oBO.this_dDatas
                .txt_4c_Usuario.Value = ALLTRIM(loc_oBO.this_cUsuars)
                .txt_4c_Agenda.Value  = IIF(!EMPTY(loc_oBO.this_dDatagens), ;
                    loc_oBO.this_dDatagens, fDtoSQL(DATE(), "00:00:00"))
                .txt_4c_Hist.Value    = ALLTRIM(loc_oBO.this_cHists)
                .obj_4c_GetObs.Value  = loc_oBO.this_cObs
                .cmd_4c_BtnOk.Enabled = loc_lDono
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GridAfterRowColChange - Espelha a linha corrente da grade nos containers
    * de consulta. Legado (SIGOPFLP.GridFollowUp.AfterRowColChange):
    *     With ThisForm.CntObs
    *         .GetObs.Value = CrSigCdClh.Obs
    *         .Refresh
    *     EndWith
    *     With ThisForm.CntAGenda
    *         .GetUSuario.Value = CrSigCdClh.Usuars
    *         .GetAgenda.Value  = Nvl(CrSigCdClh.DatAgens,{})
    *         .Refresh
    *     EndWith
    * par_nColIndex e exigido pela assinatura do evento (regra #3), mas o
    * legado nao filtra por coluna - qualquer troca de linha ou coluna
    * repinta os dois containers.
    * PUBLIC: ligado por BINDEVENT (regra #3) e chamado manualmente por
    * VincularGrade apos o Refresh inicial.
    *--------------------------------------------------------------------------
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        IF USED("cursor_4c_Dados") AND THIS.TemLinhaSelecionada()
            SELECT cursor_4c_Dados

            IF PEMSTATUS(THIS, "cnt_4c_Obs", 5)
                THIS.cnt_4c_Obs.txt_4c_Obs.Value = TratarNulo(cursor_4c_Dados.obs, "")
                THIS.cnt_4c_Obs.Refresh()
            ENDIF

            IF PEMSTATUS(THIS, "cnt_4c_Agenda", 5)
                THIS.cnt_4c_Agenda.txt_4c_Usuario.Value = TratarNulo(cursor_4c_Dados.usuars, "")
                THIS.cnt_4c_Agenda.txt_4c_Agenda.Value   = TratarNulo(cursor_4c_Dados.datagens, {})
                THIS.cnt_4c_Agenda.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GridColumnKeyPress - Atalhos F2/F3/F4/F6 sobre a linha corrente da
    * grade. Legado (SIGOPFLP.GridFollowUp.Column1/Column2.Text1.KeyPress),
    * transcrito (nKeyCode dentro de celula de Grid usa os codigos negativos
    * do VFP9 para teclas de funcao - F2=-1, F3=-2, F4=-3, F6=-5 - DIFERENTE
    * do KeyPress de TextBox fora de Grid, que usa os codigos ASCII/virtuais
    * normais):
    *     Do Case
    *         Case nKeyCode = -1 And .CmdInserir.Enabled = .T. -> NoDefault / .CmdInserir.Click()
    *         Case nKeyCode = -2 And .CmdAlterar.Enabled = .T. -> NoDefault / .CmdAlterar.Click()
    *         Case nKeyCode = -3 And .CmdApagar.Enabled  = .T. -> NoDefault / .CmdApagar.Click()
    *         Case nKeyCode = -5 And .CmdListar.Enabled  = .T. -> NoDefault / .CmdListar.Click()
    *     EndCase
    * Mapeamento dos Buttons de cmg_4c_Botoes (ordem de declaracao, regra do
    * Click): CmdApagar=Buttons(1), CmdListar=Buttons(2), CmdInserir=Buttons(3),
    * CmdAlterar=Buttons(4).
    * PUBLIC: ligado por BINDEVENT em Column1.Text1/Column2.Text1 (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE GridColumnKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            DO CASE
                CASE par_nKeyCode = -1 AND THIS.cmg_4c_Botoes.Buttons(3).Enabled
                    NODEFAULT
                    THIS.cmg_4c_Botoes.Buttons(3).Click()
                CASE par_nKeyCode = -2 AND THIS.cmg_4c_Botoes.Buttons(4).Enabled
                    NODEFAULT
                    THIS.cmg_4c_Botoes.Buttons(4).Click()
                CASE par_nKeyCode = -3 AND THIS.cmg_4c_Botoes.Buttons(1).Enabled
                    NODEFAULT
                    THIS.cmg_4c_Botoes.Buttons(1).Click()
                CASE par_nKeyCode = -5 AND THIS.cmg_4c_Botoes.Buttons(2).Enabled
                    NODEFAULT
                    THIS.cmg_4c_Botoes.Buttons(2).Click()
            ENDCASE
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - cmdInserir.Click (Buttons(3) de cmg_4c_Botoes).
    * Legado (SIGOPFLP.cmdApagaitem.cmdInserir.Click), transcrito:
    *     ThisForm.Tipo = 'INSERIR'
    *     CntObs / CntAgenda / GridFollowUp / CmdApagaItem / CommandGroup1
    *         .Visible = .F.                      (-> AjustarBotoesPorModo)
    *     With ThisForm.Cnt_Inserir
    *         .Visible = .T. / .GetData.Value = DateTime()
    *         .GetUsuario.Value = Usuar
    *         .GetAgenda.Value = fDtoSQL(Date(),'00:00:00')
    *         .GetHist.Value = '' / .GetObs.Value = ''
    *         .Refresh / .GetData.SetFocus
    *     EndWith
    *     ThisForm.Draw
    * A gravacao eh do botao Confirmar do painel (Fase 8) - este botao so abre
    * o painel com os defaults do ramo INSERIR.
    * O guard de conta vazia nao esta no legado porque la o Init faz "Return"
    * sem conta e a tela nem monta; aqui ela abre, e sem conta o Incluir
    * gravaria um followup ORFAO (SigCdClh.iclis/grupos sao NOT NULL). Recusar
    * antes de abrir o painel eh mais claro que abrir e avisar depois
    * (regra #50). O BO repete a regra em ValidarDados - fonte unica.
    * PUBLIC: ligado por BINDEVENT e chamado pelo harness (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cConta))
                MsgAviso("Conta n" + CHR(227) + "o informada - abra o FollowUp a " + ;
                    "partir de uma conta.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.this_cTipo = "INSERIR"
                THIS.LimparPainelInsercao()

                *-- Usuario ANTES do funil: HabilitarCampos o compara com o
                *-- usuario logado para reproduzir o When dos campos.
                WITH THIS.cnt_4c__Inserir
                    .txt_4c_Data.Value    = DATETIME()
                    .txt_4c_Usuario.Value = IIF(VARTYPE(gc_4c_UsuarioLogado) = "C", ;
                        gc_4c_UsuarioLogado, "")
                    .txt_4c_Agenda.Value  = fDtoSQL(DATE(), "00:00:00")
                    .cmd_4c_BtnOk.Enabled = .T.
                ENDWITH

                *-- Abre o painel, esconde a consulta e libera os campos pelo
                *-- funil de modo (regra #40)
                THIS.AjustarBotoesPorModo()

                THIS.cnt_4c__Inserir.Refresh()
                THIS.cnt_4c__Inserir.txt_4c_Data.SetFocus()
                THIS.Draw()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - cmdAlterar.Click (Buttons(4) de cmg_4c_Botoes).
    * Legado (SIGOPFLP.cmdApagaitem.cmdAlterar.Click), transcrito:
    *     ThisForm.Tipo = 'ALTERAR'
    *     CntObs / CntAgenda / GridFollowUp / CmdApagaItem / CommandGroup1
    *         .Visible = .F.                      (-> AjustarBotoesPorModo)
    *     With ThisForm.Cnt_Inserir
    *         .Visible = .T. / campos da linha corrente
    *         (-> PreencherPainelDaLinhaSelecionada)
    *         .Refresh / .GetData.SetFocus
    *     EndWith
    *     ThisForm.Draw
    * O legado le CrSigCdClh sem guarda nenhuma; aqui a guarda contra grade
    * vazia eh necessaria porque sem linha corrente o painel abriria com tudo
    * em branco e a alteracao, no Confirmar, cairia num aviso tardio
    * (regra #50).
    * CancelarEdicao() ANTES de CarregarDoCursor normaliza this_lNovoRegistro:
    * se um Incluir anterior falhou ao gravar, a flag ficaria ligada e a
    * gravacao desta alteracao seria recusada (regra #32 - o form nao fecha
    * entre operacoes).
    * PUBLIC: ligado por BINDEVENT e chamado pelo harness (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oBO, loc_oErro

        TRY
            IF !THIS.TemLinhaSelecionada()
                MsgAviso("Selecione na grade o hist" + CHR(243) + "rico que deseja " + ;
                    "alterar.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_oBO = THIS.this_oBusinessObject
                IF VARTYPE(loc_oBO) = "O"
                    loc_oBO.CancelarEdicao()
                    loc_oBO.CarregarDoCursor("cursor_4c_Dados")
                ENDIF

                THIS.this_cTipo = "ALTERAR"
                THIS.LimparPainelInsercao()
                THIS.PreencherPainelDaLinhaSelecionada()

                *-- Abre o painel, esconde a consulta e aplica o When dos
                *-- campos pelo funil de modo (regra #40)
                THIS.AjustarBotoesPorModo()

                THIS.cnt_4c__Inserir.Refresh()
                THIS.cnt_4c__Inserir.txt_4c_Data.SetFocus()
                THIS.Draw()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - cmdApagar.Click (Buttons(1) de cmg_4c_Botoes).
    * Legado (SIGOPFLP.cmdApagaitem.cmdApagar.Click):
    *     Select CrSigCdClh
    *     If !Eof()
    *         If CrSigCdClh.Usuars <> Usuar -> 'Registro Inserido/Alterado por
    *             outro usuario !!!' e aborta
    *         If !CrSigCdClh.Autos Or Empty(Obs) Or Empty(Datas)
    *             If MessageBox('Deseja realmente excluir este registro ???',
    *                 4+32+256,'Confirma Exclusao') = 6
    *                 Delete From SigCdClh Where CIdChaves = ... / Commit /
    *                 Delete no cursor / Skip / Skip -1
    *         Else -> 'Historico Automatico !!!' e aborta
    *     Select CrSigCdClh / GridFollowUp.Refresh / Column1.Text1.SetFocus
    * As DUAS guardas (autor do registro e historico automatico) e suas
    * mensagens ja estao em SigOpFlpBO.AntesDeExcluir, que eh a fonte unica -
    * aqui so se carrega a linha no BO e se delega para Excluir(), que eh
    * PUBLIC (regra #51: ExecutarExclusao nunca eh chamado de fora do BO).
    * UNICO desvio conhecido: a confirmacao fica ANTES das duas guardas (no
    * legado ela vem depois), entao num registro nao-excluivel o usuario
    * confirma primeiro e so depois le o motivo da recusa. A ordem do legado
    * exigiria expor as guardas do BO ao form, duplicando regra de negocio.
    * PUBLIC: ligado por BINDEVENT e chamado pelo harness (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oBO, loc_oErro

        TRY
            *-- Legado: 'Select CrSigCdClh / If !Eof()' - sem linha corrente o
            *-- Click nao faz nada (nem avisa).
            IF THIS.TemLinhaSelecionada()
                IF MsgConfirma("Deseja realmente excluir este registro ???", ;
                        "Confirma Exclus" + CHR(227) + "o")
                    loc_oBO = THIS.this_oBusinessObject
                    IF VARTYPE(loc_oBO) = "O"
                        loc_oBO.CancelarEdicao()
                        loc_oBO.CarregarDoCursor("cursor_4c_Dados")

                        *-- Falha ou recusa NUNCA eh muda: BusinessBase.Excluir
                        *-- exibe a mensagem em todo caminho (regra #20), por
                        *-- isso nao ha ELSE aqui.
                        loc_oBO.Excluir()
                    ENDIF

                    *-- Legado: Delete no cursor + Skip/Skip -1. Aqui a lista
                    *-- eh relida do banco, que tambem reposiciona e repinta a
                    *-- grade (CarregarLista -> VincularGrade, regra #21a).
                    THIS.CarregarLista()
                ENDIF

                *-- Legado: SetFocus na celula SEMPRE, inclusive quando a
                *-- exclusao foi recusada ou cancelada.
                THIS.FocarCelulaDataHora()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - cmdListar.Click (Buttons(2) de cmg_4c_Botoes).
    * Legado (SIGOPFLP.cmdApagaitem.cmdListar.Click), integral:
    *     * Chamada da Impressao do FollowUp
    *     Do Form SigOpFlu With ThisForm.DataSessionId,
    *         ThisForm.CntGruCon.GetGrupo.Value, ThisForm.CntGruCon.GetConta.Value
    * DO FORM nao abre nada no projeto novo (nao existe .scx) e a classe filha
    * nem entraria no indice de carga sob demanda, que eh montado a partir dos
    * CREATEOBJECT - por isso a chamada eh CREATEOBJECT com o nome LITERAL da
    * classe migrada, e os tres argumentos do legado na mesma ordem.
    * SIGOPFLU ainda esta em origem\ (nao migrado): a ausencia fica VISIVEL no
    * CATCH, de proposito - guard de FILE()/PEMSTATUS silenciaria o botao e o
    * usuario clicaria sem nada acontecer. Quando o filho for migrado, este
    * handler passa a funcionar sem alteracao.
    * Show() FORA do TRY: o filho eh modal e, dentro do TRY, qualquer erro de
    * runtime dele cairia neste CATCH, derrubando a referencia LOCAL e
    * fechando a tela filha sozinha (regra #29).
    * PUBLIC: ligado por BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oForm, loc_oErro, loc_cGrupo, loc_cConta

        loc_oForm  = .NULL.
        loc_cGrupo = ALLTRIM(THIS.cnt_4c_GruCon.txt_4c_Grupo.Value)
        loc_cConta = ALLTRIM(THIS.cnt_4c_GruCon.txt_4c_Conta.Value)

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpFlu", THIS.DataSessionId, ;
                loc_cGrupo, loc_cConta)
        CATCH TO loc_oErro
            loc_oForm = .NULL.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao abrir a impress" + CHR(227) + "o do FollowUp")
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia os campos do painel de inclusao/alteracao para o
    * Business Object, antes de Salvar(). Legado (BtnOk.Click):
    *     Case Tipo = 'INSERIR': ldDatas/ldAgenda/lcHists/lmObs = GetData/
    *         GetAgenda/GetHist/GetObs, mais Grupos/IClis/GruContas/Nopers
    *         (This.Parent eh Cnt_Inserir - os 4 campos sao do painel)
    *     Case Tipo = 'ALTERAR': Replace so Datas/Usuars/DatAgens/Hists/Obs -
    *         Grupos/IClis/GruContas/Autos/Emps/Nopers/Ccargs/Tplancs/Codsits
    *         ja estao no BO (CarregarDoCursor, feito em BtnAlterarClick) e
    *         permanecem como gravados na inclusao.
    * Por isso Grupos/IClis/Nopers so sao atribuidos no ramo INSERIR; no
    * ALTERAR eles ficam intocados (SigOpFlpBO.Atualizar nem os usa no SQL).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) = "O"
            WITH THIS.cnt_4c__Inserir
                loc_oBO.this_dDatas    = .txt_4c_Data.Value
                loc_oBO.this_dDatagens = .txt_4c_Agenda.Value
                loc_oBO.this_cHists    = ALLTRIM(.txt_4c_Hist.Value)
                loc_oBO.this_cObs      = .obj_4c_GetObs.Value
            ENDWITH

            IF UPPER(ALLTRIM(THIS.this_cTipo)) == "INSERIR"
                loc_oBO.this_cGrupos    = THIS.this_cGrupo
                loc_oBO.this_cIclis     = ALLTRIM(THIS.this_cConta)
                loc_oBO.this_nNopers    = THIS.this_nNoper
                *-- Forca fUniqueIds() novo dentro de Inserir() - o registro em
                *-- edicao pode ter vindo de um Alterar anterior na mesma vida
                *-- do form (regra #32).
                loc_oBO.this_cCidchaves = ""
            ENDIF

            *-- Os 4 campos EDITAVEIS de Cnt_Contato. No legado eles chegam ao
            *-- banco por variavel lida na hora, dentro de
            *-- CommandGroup1.Valid (lcTel1 = CntContato.GetTel1.Value, ...);
            *-- aqui o BO e a fonte unica, entao o espelhamento tela -> BO
            *-- mora neste hook, junto com o do painel. Nao entram no SQL de
            *-- SigCdClh (Inserir/Atualizar nao os usam) - quem os persiste em
            *-- SigCdCli e SalvarContato, no Encerrar.
            IF PEMSTATUS(THIS, "cnt_4c_Contato", 5)
                WITH THIS.cnt_4c_Contato
                    loc_oBO.this_cTel1s  = ALLTRIM(.txt_4c_Tel1.Value)
                    loc_oBO.this_cTel2s  = ALLTRIM(.txt_4c_Tel2.Value)
                    loc_oBO.this_cDDDs   = ALLTRIM(.txt_4c_DDDs.Value)
                    loc_oBO.this_cEmails = ALLTRIM(.txt_4c_Email.Value)
                ENDWITH
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - BtnOk.Click (Confirmar) do painel de inclusao/alteracao.
    * Legado, transcrito (Insert/Replace ja estao em SigOpFlpBO.Inserir/
    * Atualizar - aqui so o funil de tela):
    *     Do Case / Case INSERIR: Insert Into CrSigCdClh (...) /
    *         Case ALTERAR: Replace Datas/Usuars/DatAgens/Hists/Obs / EndCase
    *     Select CrSigCdClh / Scatter MemVar Memo / Insert Into CrSigCdCliG
    *         From MemVar / poDataMgr.Update('CrSigCdCliG') / Commit
    *         (equivalente, em camadas: SQLEXEC real dentro de Inserir/
    *         Atualizar, e o cursor da grade e relido do banco por
    *         CarregarLista - regra #21a)
    *     Cnt_Inserir.Visible = .F. / CntObs/CntAgenda/GridFollowUp/
    *         CmdApagaItem/CommandGroup1.Visible = .T. (-> AjustarBotoesPorModo)
    *     GridFollowUp.Refresh / Column1.Text1.SetFocus
    * NovoRegistro()/EditarRegistro() ANTES de FormParaBO() e Salvar(): o
    * flag this_lNovoRegistro decide Inserir() x Atualizar() dentro de
    * BusinessBase.Salvar(), e EditarRegistro() exige !this_lNovoRegistro
    * (regra do CancelarEdicao ja feito em BtnAlterarClick).
    * Sem ELSE apos Salvar(): falha ja foi exibida pelo proprio BusinessBase
    * (regra #20) - o painel so fecha quando a gravacao realmente aconteceu.
    * PUBLIC: ligado por BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oBO, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O"
                DO CASE
                    CASE UPPER(ALLTRIM(THIS.this_cTipo)) == "INSERIR"
                        loc_oBO.NovoRegistro()
                    CASE UPPER(ALLTRIM(THIS.this_cTipo)) == "ALTERAR"
                        loc_oBO.EditarRegistro()
                ENDCASE

                THIS.FormParaBO()

                IF loc_oBO.Salvar()
                    THIS.this_cTipo = ""
                    THIS.AjustarBotoesPorModo()
                    THIS.CarregarLista()
                    THIS.FocarCelulaDataHora()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - BtnCancela.Click (Cancelar) do painel de inclusao/
    * alteracao. Legado, transcrito:
    *     This.Parent.Visible = .F.
    *     CntObs/CntAgenda/GridFollowUp/CmdApagaItem/CommandGroup1.Visible = .T.
    *         (-> AjustarBotoesPorModo)
    *     GridFollowUp.Column1.Text1.SetFocus
    * CancelarEdicao() normaliza this_lNovoRegistro/this_lEmEdicao no BO -
    * sem isso, abrir o painel de novo (Incluir/Alterar) herdaria o estado de
    * edicao anterior (regra #32 - o form nao fecha entre uma operacao e
    * outra, diferente do legado modal).
    * PUBLIC: ligado por BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oBO, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O"
                loc_oBO.CancelarEdicao()
            ENDIF

            THIS.this_cTipo = ""
            THIS.AjustarBotoesPorModo()
            THIS.FocarCelulaDataHora()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - CommandGroup1.Command1.Valid (botao Encerrar) do
    * legado, transcrito:
    *     lcTel1/lcTel2/lcDDDs/lcEMail = CntContato.GetTel1/GetTel2/GetDDDs/
    *         GetEMail.Value
    *     Update SigCdCli Set Tel1s=?,Tel2s=?,DDDs=?,EMails=? Where IClis = ...
    *         (-> SigOpFlpBO.SalvarContato)
    *     If lnErro > 0 / Commit / EndIf
    *     ThisForm.Release
    * O legado grava SEMPRE os 4 campos (mesmo com CntContato oculto por falta
    * de acesso - a Valid do grupo nao checa Visible) e encerra o form mesmo
    * que a gravacao falhe - transcrito fielmente; SigOpFlpBO.SalvarContato ja
    * exibe o erro antes de devolver, igual aos demais metodos de SQL do BO.
    * PUBLIC: ligado por BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oBO, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O" AND PEMSTATUS(THIS, "cnt_4c_Contato", 5)
                loc_oBO.SalvarContato( ;
                    THIS.cnt_4c_Contato.txt_4c_Tel1.Value, ;
                    THIS.cnt_4c_Contato.txt_4c_Tel2.Value, ;
                    THIS.cnt_4c_Contato.txt_4c_DDDs.Value, ;
                    THIS.cnt_4c_Contato.txt_4c_Email.Value)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnEncerrarClick")
        ENDTRY

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible = .F.
    * por padrao. Torna tudo visivel recursivamente, EXCETO os containers
    * flutuantes que o legado mantem ocultos por padrao (cnt_4c__Inserir e
    * cnt_4c_Contato) - cujos FILHOS, ainda assim, precisam ficar visiveis
    * (senao, quando o container for mostrado mais tarde, aparece vazio).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C__INSERIR", "CNT_4C_CONTATO")
                    *-- Preserva Visible = .F. do proprio container, mas desce
                    *-- a recursao para os filhos dele ficarem prontos.
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores do BO (legado: ThisForm.poDataMgr.Release no
    * Release) e delega para FormBase.Destroy(), que libera
    * this_oBusinessObject e restaura o menu principal.
    * DODEFAULT() por ULTIMO - sem ele FormBase.Destroy nao roda e os popups do
    * menu principal ficam com cache visual obsoleto.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.FecharCursores()
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
