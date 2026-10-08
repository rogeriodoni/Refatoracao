*==============================================================================
* FormSigPrHpr.prg - Historico de Produtos
*==============================================================================
* Herda de: FormBase
* BO: SigPrHprBO
* Legado: SIGPRHPR.SCX
* Tipo: OPERACIONAL (form PLANO sem PageFrame - o dump nao tem Pagina.Lista/
*       Dados nem PageFrame nenhum: os objetos (cntSombra, as duas grades,
*       os GetGruOri/GetConOri/..., o chkAuditado, o Get_Data e os botoes
*       sair/Command1/btnDocumento) sao filhos diretos de SIGPRHPR ou de
*       cntSombra - ver tasks/task621/layout.json)
*
* Tela de CONSULTA aberta por um form pai via "Do Form SigPrHpr" (equivalente
* a "Parameters poform" do legado - aqui Init(par_oFormPai)). O form pai ja
* declara PRIVATE, ANTES de abrir esta tela, as variaveis pcCdGrupo/
* pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/pdDataFin (grupo, conta,
* produto e periodo cujo historico de movimentos sera exibido - dump
* SigPrHpr_form_codigo_fonte.txt, Procedure Init do objeto SIGPRHPR). Essas
* PRIVATE continuam visiveis por escopo de chamada dentro do Init() do form
* migrado (mesma regra do VFP9 para a cadeia original) - capturadas aqui com
* guarda TYPE() para o modo de teste (gb_4c_ModoTeste), onde elas nao
* existem.
*
* A tela mostra:
*   - a grade principal grd_4c_Dados (CrSigMvHst no legado) com o historico
*     de movimentos do produto no periodo;
*   - a grade secundaria grd_4c_Subniveis (crSubniveis no legado) com os
*     subniveis (SigMvPec x SigCdOpe) do documento selecionado;
*   - origem/destino (Grupo/Conta) do documento de movimento corrente;
*   - o checkbox de Auditado, que grava (UPDATE SigMvHst) auditors/dtaudits
*     do registro corrente - a UNICA escrita real deste form.
*
* NOTA SOBRE O ROTEIRO GENERICO DE 8 FASES: o template padrao da Fase 3
* pressupoe PageFrame com Page1 (Lista) e Page2 (Dados), igual aos forms
* CRUD (frmcadastro). SIGPRHPR NAO tem essa superficie - o dump legado prova
* PageFrame=0 (Secao 1 do .txt nao lista nenhum objeto baseClass=pageframe).
* Inventar um PageFrame Lista/Dados violaria o PILAR 1 (UX) e a regra "NUNCA
* inventar" do CLAUDE.md - mesma familia de caso ja documentada para
* SIGPRGST/SIGPRGLX/SIGMVEXP (formularios OPERACIONAL cuja superficie real
* nao casa com o template CRUD). Esta fase entrega, em vez disso, a
* superficie BASE real do legado: o cabecalho (cntSombra) - igual ao que
* FormSigPrGst/FormSigPrGlx fazem na propria Fase 3.
*
* Historico de montagem (migracao multi-fase):
*   Fase 1 (feita) - SigPrHprBO.prg: propriedades e Init
*   Fase 2 (feita) - SigPrHprBO.prg: metodos de dominio completos
*                     (CarregarHistorico, CarregarDoCursor,
*                     BuscarDocumentoMovimento, BuscarDescricoesGrupoConta,
*                     VerificarPermissaoAuditoria, CarregarSubniveis,
*                     AtualizarAuditoria, VerificarDocumentoCadastrado,
*                     ObterChavePrimaria, ObterTituloProduto)
*   Fase 3 (feita) - DEFINE CLASS, Init/Destroy, InicializarForm(),
*                     ConfigurarPageFrame() (orquestrador) ->
*                     ConfigurarCabecalho() (cnt_4c_Sombra),
*                     TornarControlesVisiveis()
*   Fase 4 (feita)  - grd_4c_Dados (CrSigMvHst, 7/9 colunas conforme
*                     this_cTipoEstoque) + grd_4c_Subniveis (crSubniveis, 3
*                     colunas), formatadas e carregadas via
*                     CarregarHistorico()/CarregarDoCursor() do BO (que ja
*                     chama CarregarSubniveis() internamente); lbl_4c_Label3
*                     (titulo da grade de subniveis - a unica label fora do
*                     bloco Say/fwget/chk da Fase 5-6 que ficaria soterrada
*                     se so fosse feita depois); botoes obj_4c_Sair
*                     (CommandGroup "sair" - Encerrar), cmd_4c_Command1
*                     (Procurar) e cmd_4c_BtnDocumento (Movimento)
*   Fase 5 (esta)   - lbl_4c_Lbl_produto (titulo do produto - Caption
*                     dinamico via ObterTituloProduto() do BO); os dois
*                     paineis de fundo cnt_4c_Container1/cnt_4c_Container2
*                     (Origem/Destino); lbl_4c_Say7/lbl_4c_Say8 ("Origem "/
*                     "Destino") e as linhas separadoras lin_4c_Line1/
*                     lin_4c_Line2; os 8 campos fwget de Grupo/Conta
*                     origem-destino (txt_4c_GruOri/ConOri/DesGruOri/
*                     DesConOri/GruDes/ConDes/DesGruDes/DesConDes -
*                     ReadOnly=.T., equivalente ao When Return(.F.) do
*                     legado) com os labels lbl_4c_Say1..4 ("Grupo :"/
*                     "Conta :"); AtualizarCamposDocumento(), que espelha
*                     this_cGrupoOrigem/this_cContaOrigem/
*                     this_cGrupoDestino/this_cContaDestino/this_cDescGrupo*
*                     /this_cDescConta* do BO nesses 8 campos - chamada ja
*                     agora em CarregarDados() (a mesma chamada
*                     sera reusada pelo AfterRowColChange na Fase 7-8)
*   Fase 6 (feita)  - ConfigurarAuditoria(): chk_4c_ChkAuditado
*                     (chkAuditado - graphical, Style=1, visibilidade
*                     decidida por this_lPodeAuditar do BO), txt_4c_DtAudits
*                     (Get_DtAudits) + lbl_4c_Lbl_Auditoria, txt_4c_Data
*                     (Get_Data) + lbl_4c_Label6 (Say6 - toggle de filtro
*                     por data disparado por cmd_4c_Command1/"Procurar",
*                     Visible=.F. por padrao - TornarControlesVisiveis()
*                     agora filtra os dois, igual ao legado), obj_4c_GetObs
*                     (getObs) + lbl_4c_Label5 (Say5), txt_4c_Auditors
*                     (Get_Auditors), txt_4c_Usuario (Get_Usuario),
*                     txt_4c_Nota (Get_nota) e os labels lbl_4c_Label1/
*                     lbl_4c_Label2/lbl_4c_LblAuditor; AtualizarCamposAuditoria()
*                     espelha this_cNotaAtual/this_cUsuarioMovAtual/
*                     this_cAuditorAtual/this_dDtAuditAtual/this_cObsAtual/
*                     this_lPodeAuditar do BO nesses campos - chamada ja
*                     agora em CarregarDados() (reusada pela Fase
*                     7-8 no AfterRowColChange); e o comportamento do UNICO
*                     campo digitavel do legado: ValidarData() (Get_Data.
*                     Valid - SET NEAR ON + SEEK no tag "datas" + Refresh da
*                     grade), DataLostFocus()/OcultarFiltroData()
*                     (Get_Data.LostFocus - esconde Get_Data/Say6 e devolve
*                     o foco a grd_historico.Column1), ligados por BINDEVENT
*                     em KeyPress (ENTER/TAB - "Valid" nao dispara em
*                     TextBox) e LostFocus
*
*                     NAO HA LOOKUP a implementar nesta fase: o dump legado
*                     nao tem fwBuscaExt/fwBuscaSel/mAddColuna/sigacess/
*                     Acesso* em nenhum dos 29 metodos - os 8 campos de
*                     Grupo/Conta origem-destino, os 4 de auditoria/
*                     documento e a Observacao sao TODOS somente-leitura
*                     (When Return(.F.) no legado, ReadOnly = .T. aqui),
*                     resolvidos pelo BO a partir do registro corrente da
*                     grade. Inventar um picker aqui violaria o PILAR 1 e a
*                     regra "NUNCA inventar tabelas de lookup".
*   Fase 7 (feita)  - GrdDadosAfterRowColChange() (BINDEVENT em
*                     AfterRowColChange de grd_4c_Dados - CarregarDoCursor()
*                     do BO + AtualizarGradeSubniveis/AtualizarCamposDocumento/
*                     AtualizarCamposAuditoria, reusando os metodos da Fase
*                     5-6) e ChkAuditadoClick() (BINDEVENT em Click de
*                     chk_4c_ChkAuditado - AtualizarAuditoria() do BO, com
*                     reversao visual do checkbox e MsgErro quando a
*                     transacao falha)
*   Fase 8 (esta)   - Consolidacao final. O roteiro generico de 8 fases
*                     pede, nesta etapa, BtnBuscarClick/BtnEncerrarClick/
*                     BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
*                     HabilitarCampos/LimparCampos/CarregarLista/
*                     AjustarBotoesPorModo - vocabulario do padrao CRUD
*                     (frmcadastro, Page1=Lista/Page2=Dados, modos INCLUIR/
*                     ALTERAR/VISUALIZAR/EXCLUIR). SIGPRHPR e um form
*                     OPERACIONAL de CONSULTA (mesma excecao ja registrada na
*                     nota da Fase 3, abaixo): nao tem registro para
*                     incluir/alterar/excluir, nem modo de edicao, nem
*                     Page1/Page2. Cada item do roteiro generico JA tem
*                     equivalente real, implementado nas fases anteriores:
*
*                       BtnBuscarClick     -> BtnProcurarClick() (Fase 4/7:
*                                             mostra txt_4c_Data/
*                                             lbl_4c_Label6 e reusa
*                                             ValidarData() para posicionar
*                                             a grade pela data digitada -
*                                             o "filtro" deste form)
*                       BtnEncerrarClick   -> BtnSairClick() (Fase 4/7:
*                                             reabilita this_oFormPai e
*                                             THIS.Release() - mesmo papel
*                                             do cnt_4c_Saida/cmd_4c_Encerrar
*                                             canonico CRUD, aqui como
*                                             CommandGroup porque e assim
*                                             que o legado desenhou)
*                       BtnSalvarClick     -> ChkAuditadoClick() (Fase 7: a
*                                             UNICA escrita real do form -
*                                             UPDATE SigMvHst.auditors/
*                                             dtaudits via
*                                             AtualizarAuditoria() do BO)
*                       BtnCancelarClick   -> nao existe no legado (nao ha
*                                             modo de edicao para cancelar -
*                                             inventar um botao Cancelar
*                                             violaria o PILAR 1 e a regra
*                                             "NUNCA inventar")
*                       FormParaBO/BOParaForm -> nao se aplicam: nao ha
*                                             INSERT/UPDATE de registro via
*                                             formulario completo. Os campos
*                                             sao TODOS somente-leitura e
*                                             espelhados do BO para a tela
*                                             (nunca o inverso) por
*                                             AtualizarCamposDocumento()/
*                                             AtualizarCamposAuditoria()
*                                             (Fase 5-6), chamados por
*                                             CarregarDados() e por
*                                             GrdDadosAfterRowColChange()
*                       HabilitarCampos    -> nao se aplica: todo campo
*                                             nasce ReadOnly=.T. (equivalente
*                                             ao When Return(.F.) do legado -
*                                             dump linhas 1980-2082, 2155-
*                                             2159, 2204-2236, 2290-2292) e
*                                             permanece assim sempre - nao
*                                             ha modo que os habilite
*                       LimparCampos       -> nao se aplica: nao ha modo
*                                             INCLUIR/"registro em branco" -
*                                             a troca de linha na grade (que
*                                             e a unica forma de "navegar"
*                                             entre registros) ja REESCREVE
*                                             os campos via
*                                             GrdDadosAfterRowColChange()
*                       CarregarLista      -> CarregarGradePrincipal() +
*                                             CarregarDados() (Fase
*                                             4: popula cursor_4c_Dados via
*                                             CarregarHistorico() do BO e
*                                             rebinda grd_4c_Dados - mesmo
*                                             papel de CarregarLista() no
*                                             padrao CRUD)
*                       AjustarBotoesPorModo -> nao se aplica: nao ha modos
*                                             (INCLUIR/ALTERAR/VISUALIZAR/
*                                             EXCLUIR) neste form - os 3
*                                             botoes de acao (Encerrar/
*                                             Movimento/Procurar) e o
*                                             checkbox de Auditado ficam
*                                             disponiveis o tempo todo,
*                                             exatamente como no legado
*
*                     Nenhum caller (nenhum "Do Form SigPrHpr"/
*                     "CREATEOBJECT('FormSigPrHpr'...)") existe ainda no
*                     codigo migrado nem nos dumps de tasks/ ja extraidos -
*                     o form pai que declara as PRIVATE pcCdGrupo/pcCdConta/
*                     pcCdProduto/pcDsProduto/pdDataIni/pdDataFin (ver nota
*                     do Init, abaixo) ainda nao foi migrado. Por isso NAO
*                     ha item novo em menu.prg: este form e um detalhe
*                     aberto programaticamente por outro form (mesma familia
*                     de FormSigMvExp/FormSigMvPdt, referenciados em
*                     BtnDocumentoClick), nao um cadastro/relatorio com
*                     entrada direta no menu principal.
*==============================================================================

DEFINE CLASS FormSigPrHpr AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGPRHPR.SCX: DataSession=2, BorderStyle=2,
    * Height=600, Width=1000, AutoCenter=.T., ControlBox=.F., Closable=.F.,
    * MaxButton=.F., MinButton=.F., KeyPreview=.T., TitleBar=0 - dump de
    * SigPrHpr_form_codigo_fonte.txt, linhas 392-411. DataSession=2 exige
    * que Init() chame DODEFAULT() para FormBase.Init() aplicar
    * SET DATE TO BRITISH + SET CENTURY ON - CLAUDE.md regra #9.4)
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    DataSession  = 2
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Movable      = .F.
    KeyPreview   = .T.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    Caption = "Hist" + CHR(243) + "rico de Produtos"

    *--------------------------------------------------------------------------
    * ThisForm.ParentForm do legado - form que ja declarou PRIVATE
    * pcCdGrupo/pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/pdDataFin antes
    * de abrir esta tela (ver cabecalho do arquivo). Guardado apenas para o
    * Click de "sair" reabilitar o form pai (ThisForm.ParentForm.Enabled =
    * .T. no legado) - nenhum outro metodo do dump le mais nada dele.
    *--------------------------------------------------------------------------
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * Guarda de reentrancia de OcultarFiltroData(): esconder txt_4c_Data e
    * devolver o foco a grade dispara de novo o LostFocus do proprio campo.
    * Sem a guarda, o handler se chamaria em cadeia (CLAUDE.md - LostFocus
    * dispara SEMPRE, inclusive por SetFocus de outro controle).
    *--------------------------------------------------------------------------
    this_lOcultandoFiltroData = .F.

    *--------------------------------------------------------------------------
    * Parametros recebidos do form pai (equivalente as PRIVATE pcCdGrupo/
    * pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/pdDataFin do legado -
    * capturados aqui no Init, consumidos pela Fase 4 ao chamar
    * THIS.this_oBusinessObject.CarregarHistorico(...)). Mesmos nomes/tipos
    * das properties espelho em SigPrHprBO, que e quem efetivamente os usa
    * nas regras de negocio (PILAR 3).
    *--------------------------------------------------------------------------
    this_cGrupo            = SPACE(10)
    this_cConta            = SPACE(10)
    this_cProduto          = SPACE(14)
    this_cDescricaoProduto = ""
    this_dDataIni          = {}
    this_dDataFin          = {}

    *--------------------------------------------------------------------------
    * Init - cria o Business Object, guarda o form pai e captura os
    * parametros do historico (equivalente a "Lparameters pFrm" + leitura
    * das PRIVATE do chamador no Init legado). DODEFAULT() ao final
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oFormPai
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrHprBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF PCOUNT() >= 1 AND VARTYPE(par_oFormPai) = "O"
                    THIS.this_oFormPai = par_oFormPai
                ENDIF

                *-- Equivalente a leitura direta de pcCdGrupo/pcCdConta/
                *-- pcCdProduto/pcDsProduto/pdDataIni/pdDataFin (PRIVATE do
                *-- form pai, visiveis por escopo de chamada). Guarda TYPE()
                *-- cobre o modo de teste, onde essas PRIVATE nao existem.
                THIS.this_cGrupo = IIF(TYPE("pcCdGrupo") = "C", PADR(pcCdGrupo, 10), SPACE(10))
                THIS.this_cConta = IIF(TYPE("pcCdConta") = "C", PADR(pcCdConta, 10), SPACE(10))
                THIS.this_cProduto = IIF(TYPE("pcCdProduto") = "C", PADR(pcCdProduto, 14), SPACE(14))
                THIS.this_cDescricaoProduto = IIF(TYPE("pcDsProduto") = "C", ALLTRIM(pcDsProduto), "")
                THIS.this_dDataIni = IIF(INLIST(TYPE("pdDataIni"), "D", "T"), pdDataIni, {})
                THIS.this_dDataFin = IIF(INLIST(TYPE("pdDataFin"), "D", "T"), pdDataFin, {})

                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Hist" + CHR(243) + "rico de Produtos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - encadeia direto para FormBase.Destroy() (libera
    * this_oBusinessObject e restaura o menu principal). this_oFormPai NAO
    * eh liberado aqui - pertence a quem o criou.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a tela via ConfigurarPageFrame() (cabecalho
    * nesta fase; grades/campos/botoes nas proximas) e torna tudo visivel.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cPicture
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrHprBO.", "Erro")
            ELSE
                loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
                IF FILE(loc_cPicture)
                    THIS.Picture = loc_cPicture
                ENDIF

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- Mesmo guard usado em FormSigPrGlx/FormSigPrGst: em modo
                *-- de teste de UI (sem gnConnHandle/dados de globalizacao
                *-- do form pai) pular o carregamento real evita o dialogo
                *-- "Favor reinicializar o processo" num contexto sem SQL.
                IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                     (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
                    THIS.CarregarDados()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrHpr.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestrador de montagem visual. SIGPRHPR nao
    * tem PageFrame no legado (layout flat: cntSombra + 2 grades + campos +
    * botoes no proprio form - ver nota no cabecalho do arquivo); o nome do
    * metodo e mantido apenas como ponto de entrada arquitetural padrao
    * (mesmo papel em FormSigPrGst/FormSigPrGlx). As proximas fases vao
    * acrescentar ConfigurarCamposDocumento()/ConfigurarAuditoria() a este
    * mesmo metodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGradePrincipal()
        THIS.ConfigurarGradeSubniveis()
        THIS.ConfigurarCamposDocumento()
        THIS.ConfigurarAuditoria()
        THIS.ConfigurarBotoesAcao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria cnt_4c_Sombra (cntSombra no legado) com os
    * dois labels de titulo (lbl_4c_LblSombra/lbl_4c_LblTitulo), geometria e
    * propriedades transcritas do dump (SigPrHpr_form_codigo_fonte.txt,
    * linhas 414-464). Width usa THIS.Width (dinamico, CLAUDE.md regra #11) -
    * NUNCA o literal 1100 do SCX legado, que e maior que o proprio form
    * (Width=1000) por artefato do designer original.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
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

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = 769
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
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
                .Width     = 769
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao; percorre recursivamente Controls (Containers/Grids/Pages de
    * eventuais PageFrames filhos) tornando tudo visivel.
    *
    * O legado tem DOIS controles que comecam Visible=.F. de proposito
    * (Get_Data/Say6 - toggle de filtro por data, ligado por Command1.Click -
    * BtnProcurarClick - e desligado no proprio Get_Data.LostFocus/Valid, que
    * a Fase 7-8 implementa). Criados na Fase 6 como txt_4c_Data/
    * lbl_4c_Label6 - este metodo os IGNORA explicitamente, senao apareceriam
    * abertos desde a inicializacao do form (CLAUDE.md - containers/
    * controles flutuantes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "TXT_4C_DATA", "LBL_4C_LABEL6")
                    LOOP
                ENDIF

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
    * ConfigurarGradePrincipal - cria grd_4c_Dados (grd_historico no legado),
    * so a geometria/propriedades de grade (SigPrHpr_form_codigo_fonte.txt,
    * linhas 546-561). RecordSource/ColumnCount/ControlSource/Width/Header
    * das colunas sao feitos em CarregarGradePrincipal() - fazer isso aqui
    * seria inutil, porque reatribuir RecordSource/ControlSource reseta
    * Width e Header1.Caption (CLAUDE.md - "Problema 2" / regra sobre Grid
    * rebind, FORMCOR_LICOES_APRENDIDAS.md).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradePrincipal()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top         = 148
                .Left        = 4
                .Width       = 730
                .Height      = 238
                .FontName    = "Arial"
                .DeleteMark  = .F.
                .RecordMark  = .F.
                .ScrollBars  = 2
                .ReadOnly    = .T.
                .ColumnCount = 9
                .Visible     = .T.
            ENDWITH

            *-- AfterRowColChange = AfterRowColChange do grd_historico legado
            *-- (dump linhas 579-728): troca de linha na grade principal
            *-- reposiciona documento/origem-destino/auditoria/subniveis do
            *-- registro agora corrente. BINDEVENT exige metodo PUBLIC e
            *-- parametro declarado (CLAUDE.md regra #3).
            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGradePrincipal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarColunaGradePrincipal - aplica a UMA coluna de grd_4c_Dados o
    * trio FontName/Width/Movable/Resizable/ReadOnly + Format/InputMask
    * (quando informados) + Header1 (FontName/FontSize/Alignment/Caption/
    * ForeColor), na ordem exigida (DEPOIS do ControlSource - ver chamador).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarColunaGradePrincipal(par_oColuna, par_cCaption, par_nWidth, par_cFormat, par_cInputMask)
        WITH par_oColuna
            .FontName  = "Courier New"
            .Width     = par_nWidth
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            IF !EMPTY(par_cFormat)
                .Format    = par_cFormat
                .InputMask = par_cInputMask
            ENDIF
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = par_cCaption
            .Header1.ForeColor = RGB(0, 0, 0)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradePrincipal - equivalente ao bloco do Init legado que
    * executa CrSigMvHst/TmpPro/TmpUni e liga grd_historico (linhas
    * 1541-1597 do dump): chama CarregarHistorico() do BO (que ja resolve
    * produto/unidade e deixa cursor_4c_Dados posicionado no ultimo
    * registro) e rebinda a grade. ColumnCount eh DINAMICO - 9 colunas
    * (com Peso/Saldo Peso) quando this_cTipoEstoque = "3", 7 nos demais
    * casos, exatamente como Iif(TmpUni.Cestos = '3', 9, 7) no legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarGradePrincipal()
        LOCAL loc_lSucesso, loc_oGrid, loc_nColunas, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.this_oBusinessObject.CarregarHistorico(THIS.this_cGrupo, THIS.this_cConta, ;
                    THIS.this_cProduto, THIS.this_cDescricaoProduto, THIS.this_dDataIni, THIS.this_dDataFin)

                loc_oGrid    = THIS.grd_4c_Dados
                loc_nColunas = IIF(THIS.this_oBusinessObject.this_cTipoEstoque == "3", 9, 7)

                loc_oGrid.RecordSource = ""
                loc_oGrid.ColumnCount  = loc_nColunas
                loc_oGrid.ColumnCount = 9
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.datas"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.numes"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.dopes"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cunis"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.qtds"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.opers"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.sqtds"
                IF loc_nColunas = 9
                    loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.pesos"
                    loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.spesos"
                ENDIF

                THIS.FormatarColunaGradePrincipal(loc_oGrid.Column1, "Data", 86, "", "")
                THIS.FormatarColunaGradePrincipal(loc_oGrid.Column2, "C" + CHR(243) + "digo", 57, "", "")
                THIS.FormatarColunaGradePrincipal(loc_oGrid.Column3, "Opera" + CHR(231) + CHR(227) + "o", 161, "", "")
                THIS.FormatarColunaGradePrincipal(loc_oGrid.Column4, "Un.", 31, "999,999.99", "999,999.99")
                THIS.FormatarColunaGradePrincipal(loc_oGrid.Column5, "Quantidade", 78, "999,999.999", "999,999.999")
                THIS.FormatarColunaGradePrincipal(loc_oGrid.Column6, "O", 24, "", "")
                THIS.FormatarColunaGradePrincipal(loc_oGrid.Column7, "Saldo  Q", 93, "9,999,999.999", "9,999,999.999")
                IF loc_nColunas = 9
                    THIS.FormatarColunaGradePrincipal(loc_oGrid.Column8, "Peso", 80, "999,999.999", "999,999.999")
                    THIS.FormatarColunaGradePrincipal(loc_oGrid.Column9, "Saldo P", 80, "999,999.999", "999,999.999")
                ENDIF

                *-- Verde claro na linha ja auditada - SetAll("DynamicBackColor", ...)
                *-- do legado (linha 1669 do dump).
                loc_oGrid.SetAll("DynamicBackColor", ;
                    "IIF(!EMPTY(cursor_4c_Dados.auditors), RGB(220,255,220), RGB(255,255,255))", "Column")

                *-- GO BOTTOM (nao GO TOP) - CarregarHistorico() ja deixa o
                *-- cursor no ULTIMO registro (Go Bottom legado); reforcar a
                *-- mesma posicao aqui so garante o repaint da grade (regra
                *-- "popular cursor nao repinta a grade") sem desfazer a
                *-- selecao inicial esperada pelo usuario.
                IF USED("cursor_4c_Dados")
                    GO BOTTOM IN cursor_4c_Dados
                ENDIF
                loc_oGrid.Refresh()

                loc_lSucesso = .T.
            ELSE
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarGradePrincipal")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarGradeSubniveis - cria grd_4c_Subniveis (grdSubniveis no
    * legado - SigPrHpr_form_codigo_fonte.txt linhas 1256-1272) e
    * lbl_4c_Label3 ("Movimentacoes com subnivel" - Label3, linhas
    * 1367-1382), titulo estatico da grade. So geometria aqui - igual a
    * ConfigurarGradePrincipal, o rebind de ControlSource/Width/Header fica
    * em AtualizarGradeSubniveis(), chamado toda vez que o BO recria
    * cursor_4c_Subniveis (CarregarSubniveis faz USE IN + CREATE CURSOR a
    * cada linha selecionada na grade principal - regra do rebind de grid).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeSubniveis()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_Subniveis", "Grid")
            WITH THIS.grd_4c_Subniveis
                .Top         = 148
                .Left        = 738
                .Width       = 261
                .Height      = 238
                .FontName    = "Arial"
                .DeleteMark  = .F.
                .RecordMark  = .F.
                .ScrollBars  = 2
                .ReadOnly    = .T.
                .ColumnCount = 3
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontItalic = .F.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Alignment  = 0
                .Caption    = "Movimenta" + CHR(231) + CHR(245) + "es com subn" + CHR(237) + "vel"
                .Height     = 15
                .Left       = 747
                .Top        = 130
                .Width      = 169
                .ForeColor  = RGB(90, 90, 90)
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGradeSubniveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarGradeSubniveis - rebinda grd_4c_Subniveis a cursor_4c_Subniveis
    * (crSubniveis no legado - RecordSource estatico, linha 1266 do dump,
    * porque o cursor e SEMPRE recriado com a MESMA estrutura por
    * CarregarSubniveis()/CarregarDoCursor() do BO). Precisa ser chamado de
    * NOVO toda vez que o BO recriar o cursor - Width/Header1.Caption se
    * perdem no rebind (mesma familia do "Problema 2" / regra sobre Grid
    * Column.ControlSource resetar Header/Width). Reusado pela Fase 7-8 no
    * AfterRowColChange da grade principal.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarGradeSubniveis()
        LOCAL loc_oGrid, loc_oErro

        TRY
            loc_oGrid = THIS.grd_4c_Subniveis

            loc_oGrid.RecordSource = ""
            loc_oGrid.ColumnCount  = 3
            loc_oGrid.RecordSource = "cursor_4c_Subniveis"

            loc_oGrid.Column1.ControlSource = "cursor_4c_Subniveis.Emps"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Subniveis.Dopes"
            loc_oGrid.Column3.ControlSource = "cursor_4c_Subniveis.Numes"

            WITH loc_oGrid.Column1
                .FontName  = "Courier New"
                .Width     = 31
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.Caption   = "Emp"
            ENDWITH

            WITH loc_oGrid.Column2
                .FontName  = "Courier New"
                .Width     = 156
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            ENDWITH

            WITH loc_oGrid.Column3
                .FontName  = "Courier New"
                .Width     = 51
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.Caption   = "C" + CHR(243) + "digo"
            ENDWITH

            IF USED("cursor_4c_Subniveis")
                GO TOP IN cursor_4c_Subniveis
            ENDIF
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarGradeSubniveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposDocumento - cria o bloco Origem/Destino do documento de
    * movimento corrente (dump linhas 467-1051 e 1419-1471): os dois paineis
    * de fundo cnt_4c_Container1 (Origem, Left=7)/cnt_4c_Container2 (Destino,
    * Left=504), os titulos lbl_4c_Say7 "Origem "/lbl_4c_Say8 "Destino" com
    * as linhas separadoras lin_4c_Line1/lin_4c_Line2, o titulo dinamico
    * lbl_4c_Lbl_produto (Caption montado por ObterTituloProduto() do BO em
    * CarregarDados - AutoSize=.T. no SCX eh NO-OP em Label criado
    * por AddObject, CLAUDE.md regra #23, por isso .AutoSize=.F. + Width
    * explicita) e os 8 campos fwget somente-leitura de Grupo/Conta (os dois
    * paineis e as linhas sao criados ANTES dos campos/labels para ficarem
    * no fundo). Os 8 campos tem ReadOnly=.T. porque o legado trava entrada
    * com When Return(.F.) (dump linhas 1980-2082) - nao ha equivalente
    * direto de When num TextBox criado por AddObject, e ReadOnly reproduz o
    * mesmo efeito (campo so-leitura). Valor eh atribuido por
    * AtualizarCamposDocumento(), chamado por CarregarDados() nesta
    * fase e reusado pelo AfterRowColChange na Fase 7-8.
    *
    * Nomes dos labels Say1/Say2/Say3/Say4/Say7/Say8 usam o sufixo numerico
    * do legado (lbl_4c_SayN) em vez do nome gerico "lbl_4c_LabelN" do
    * mapeamento.json: o proprio mapeamento.json colide Say3 com Label3 (o
    * titulo "Movimentacoes com subnivel" da Fase 4, que ja ocupa
    * lbl_4c_Label3) - usar o nome colidido estouraria "object already
    * exists" no Init (CLAUDE.md - diferenca bloqueante por colisao de nome
    * no mapeamento.json, nao no .prg).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposDocumento()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Container1", "Container")
            WITH THIS.cnt_4c_Container1
                .Top           = 426
                .Left          = 7
                .Width         = 478
                .Height        = 74
                .SpecialEffect = 0
                .BackStyle     = 1
                .BackColor     = RGB(255, 255, 255)
                .BorderWidth   = 0
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("cnt_4c_Container2", "Container")
            WITH THIS.cnt_4c_Container2
                .Top           = 426
                .Left          = 504
                .Width         = 478
                .Height        = 74
                .SpecialEffect = 0
                .BackStyle     = 1
                .BackColor     = RGB(255, 255, 255)
                .BorderWidth   = 0
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Say7", "Label")
            WITH THIS.lbl_4c_Say7
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Origem "
                .Left      = 17
                .Top       = 428
                .Width     = 60
                .Height    = 13
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Say8", "Label")
            WITH THIS.lbl_4c_Say8
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Destino"
                .Left      = 513
                .Top       = 428
                .Width     = 60
                .Height    = 13
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lin_4c_Line1", "Line")
            WITH THIS.lin_4c_Line1
                .BorderWidth = 2
                .Height      = 0
                .Left        = 18
                .Top         = 442
                .Width       = 340
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("lin_4c_Line2", "Line")
            WITH THIS.lin_4c_Line2
                .BorderWidth = 2
                .Height      = 0
                .Left        = 515
                .Top         = 442
                .Width       = 340
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH

            *-- Origem: Grupo (txt_4c_GruOri + descricao txt_4c_DesGruOri)
            THIS.AddObject("lbl_4c_Say1", "Label")
            WITH THIS.lbl_4c_Say1
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Grupo :"
                .Left      = 62
                .Top       = 451
                .Width     = 40
                .Height    = 13
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_GruOri", "TextBox")
            WITH THIS.txt_4c_GruOri
                .Top           = 447
                .Left          = 106
                .Width         = 80
                .Height        = 23
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DesGruOri", "TextBox")
            WITH THIS.txt_4c_DesGruOri
                .Top           = 447
                .Left          = 187
                .Width         = 290
                .Height        = 23
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Origem: Conta (txt_4c_ConOri + descricao txt_4c_DesConOri)
            THIS.AddObject("lbl_4c_Say2", "Label")
            WITH THIS.lbl_4c_Say2
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Conta :"
                .Left      = 63
                .Top       = 475
                .Width     = 40
                .Height    = 13
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_ConOri", "TextBox")
            WITH THIS.txt_4c_ConOri
                .Top           = 471
                .Left          = 106
                .Width         = 80
                .Height        = 23
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DesConOri", "TextBox")
            WITH THIS.txt_4c_DesConOri
                .Top           = 471
                .Left          = 187
                .Width         = 290
                .Height        = 23
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Destino: Grupo (txt_4c_GruDes + descricao txt_4c_DesGruDes)
            THIS.AddObject("lbl_4c_Say3", "Label")
            WITH THIS.lbl_4c_Say3
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Grupo :"
                .Left      = 557
                .Top       = 451
                .Width     = 40
                .Height    = 13
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_GruDes", "TextBox")
            WITH THIS.txt_4c_GruDes
                .Top           = 447
                .Left          = 601
                .Width         = 80
                .Height        = 23
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DesGruDes", "TextBox")
            WITH THIS.txt_4c_DesGruDes
                .Top           = 447
                .Left          = 682
                .Width         = 290
                .Height        = 23
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Destino: Conta (txt_4c_ConDes + descricao txt_4c_DesConDes)
            THIS.AddObject("lbl_4c_Say4", "Label")
            WITH THIS.lbl_4c_Say4
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Conta :"
                .Left      = 558
                .Top       = 475
                .Width     = 40
                .Height    = 13
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_ConDes", "TextBox")
            WITH THIS.txt_4c_ConDes
                .Top           = 471
                .Left          = 601
                .Width         = 80
                .Height        = 23
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DesConDes", "TextBox")
            WITH THIS.txt_4c_DesConDes
                .Top           = 471
                .Left          = 682
                .Width         = 290
                .Height        = 23
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Lbl_produto", "Label")
            WITH THIS.lbl_4c_Lbl_produto
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Hist" + CHR(243) + "rico de Produtos"
                .Left      = 15
                .Top       = 130
                .Width     = 700
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposDocumento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAuditoria - cria o bloco de auditoria/observacao do registro
    * corrente da grade principal (dump linhas 1055-1196, 1198-1252,
    * 1116-1144, 1474-1484): os 4 campos fwget somente-leitura Documento
    * (txt_4c_Nota)/Usuario (txt_4c_Usuario)/Auditoria (txt_4c_DtAudits)/
    * Auditor (txt_4c_Auditors) com seus labels (lbl_4c_Label2/
    * lbl_4c_Label1/lbl_4c_Lbl_Auditoria/lbl_4c_LblAuditor - nomes "Label1"/
    * "Label2" livres porque a Fase 5 usou lbl_4c_Say1..4 para os Say1..4
    * que colidiriam no mapeamento.json, CLAUDE.md regra sobre colisao de
    * nome), o checkbox chk_4c_ChkAuditado (chkAuditado no legado -
    * CheckBox grafico Style=1, visibilidade decidida por this_lPodeAuditar
    * do BO em AtualizarCamposAuditoria - comeca oculto), o campo de filtro
    * por data txt_4c_Data + label lbl_4c_Label6 (Get_Data/Say6 - toggle
    * flutuante disparado por cmd_4c_Command1/"Procurar" - Fase 4 -,
    * Visible=.F. por padrao igual ao legado - TornarControlesVisiveis()
    * ignora os dois) e o EditBox de observacao obj_4c_GetObs (getObs) com
    * seu label lbl_4c_Label5 (Say5 - unico Say deste form com
    * ForeColor=RGB(90,90,90) em vez de RGB(0,0,0), igual ao dump).
    *
    * Os 4 campos fwget (Nota/Usuario/DtAudits/Auditors) e o getObs sao
    * ReadOnly=.T. (equivalente ao When Return(.F.) do legado - dump linhas
    * 2155-2159, 2204-2236, 2290-2292). txt_4c_DtAudits tem Alignment=3
    * (right, igual ao dump) e .Value = {} (campo DATA; os demais campos
    * fwget sao char, .Value = "").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAuditoria()
        LOCAL loc_oErro

        TRY
            *-- Documento : (Get_nota)
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Documento :"
                .Left      = 27
                .Top       = 396
                .Width     = 73
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Nota", "TextBox")
            WITH THIS.txt_4c_Nota
                .Top               = 392
                .Left              = 102
                .Width             = 80
                .Height            = 23
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(90, 90, 90)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            *-- Usuario : (Get_Usuario)
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Usu" + CHR(225) + "rio :"
                .Left      = 197
                .Top       = 396
                .Width     = 51
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Usuario", "TextBox")
            WITH THIS.txt_4c_Usuario
                .Top               = 392
                .Left              = 250
                .Width             = 96
                .Height            = 23
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(90, 90, 90)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            *-- Auditoria : (Get_DtAudits)
            THIS.AddObject("lbl_4c_Lbl_Auditoria", "Label")
            WITH THIS.lbl_4c_Lbl_Auditoria
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Auditoria :"
                .Left      = 403
                .Top       = 396
                .Width     = 60
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DtAudits", "TextBox")
            WITH THIS.txt_4c_DtAudits
                .Top           = 392
                .Left          = 465
                .Width         = 80
                .Height        = 23
                .Alignment     = 3
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(90, 90, 90)
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            *-- Auditor : (Get_Auditors)
            THIS.AddObject("lbl_4c_LblAuditor", "Label")
            WITH THIS.lbl_4c_LblAuditor
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Auditor :"
                .Left      = 556
                .Top       = 396
                .Width     = 50
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Auditors", "TextBox")
            WITH THIS.txt_4c_Auditors
                .Top               = 392
                .Left              = 608
                .Width             = 96
                .Height            = 23
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(90, 90, 90)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            *-- A\<uditado (chkAuditado) - checkbox grafico (Style=1).
            *-- Visivel/marcado apenas depois que AtualizarCamposAuditoria()
            *-- resolver this_lPodeAuditar do registro corrente (Fase 7-8
            *-- liga o Click -> AtualizarAuditoria do BO).
            THIS.AddObject("chk_4c_ChkAuditado", "CheckBox")
            WITH THIS.chk_4c_ChkAuditado
                .Top        = 3
                .Left       = 700
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Alignment  = 0
                .Caption    = "A\<uditado"
                .Style      = 1
                .Value      = 0
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .F.
                IF FILE(gc_4c_CaminhoIcones + "geral_chaves_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
                ENDIF
            ENDWITH

            *-- chkAuditado.Click do legado (dump: "Private lcDtHis / With
            *-- ThisForm.poDataMgr / If This.Value = 1 / ... Replace
            *-- CrSigMvHst.auditors With Usuar / .SqlExecute(Update SigMvHst
            *-- Set auditors...) / ... Replace CrSigMvHst.dtaudits With
            *-- Date()...") - equivalente encapsulado em
            *-- AtualizarAuditoria() do BO (Fase 2), que ja faz a transacao
            *-- BEGIN/UPDATE auditors/UPDATE dtaudits/COMMIT ou ROLLBACK.
            BINDEVENT(THIS.chk_4c_ChkAuditado, "Click", THIS, "ChkAuditadoClick")

            *-- Data : / campo de filtro por data (Say6/Get_Data) - toggle
            *-- flutuante disparado por cmd_4c_Command1 ("Procurar", Fase
            *-- 4), comeca oculto igual ao legado (dump: ThisForm.Get_Data.
            *-- Visible = .f. / ThisForm.Say6.Visible = .f. no Init).
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Data :"
                .Left      = 441
                .Top       = 102
                .Width     = 40
                .Height    = 13
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .F.
            ENDWITH

            THIS.AddObject("txt_4c_Data", "TextBox")
            WITH THIS.txt_4c_Data
                .Top           = 98
                .Left          = 478
                .Width         = 80
                .Height        = 23
                .Alignment     = 3
                .MaxLength     = 10
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = {}
                .Visible       = .F.
            ENDWITH

            *-- Get_Data eh o UNICO campo digitavel do legado: Valid (SEEK na
            *-- data) + LostFocus (esconde e devolve o foco a grade). BINDEVENT
            *-- em "Valid" NAO dispara em TextBox (CLAUDE.md regra #3): o Valid
            *-- eh reproduzido no KeyPress, em ENTER/TAB - as duas teclas que
            *-- encerram a digitacao e, no legado, disparavam o Valid.
            BINDEVENT(THIS.txt_4c_Data, "KeyPress",  THIS, "ValidarData")
            BINDEVENT(THIS.txt_4c_Data, "KeyPress", THIS, "DataLostFocus")

            *-- Observacao : (getObs)
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
                .Left      = 29
                .Top       = 517
                .Width     = 70
                .Height    = 13
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_GetObs", "EditBox")
            WITH THIS.obj_4c_GetObs
                .Top           = 514
                .Left          = 106
                .Width         = 875
                .Height        = 55
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAuditoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCamposDocumento - espelha nos 8 campos fwget (legado:
    * ThisForm.GetGruOri.Value = CrSigMvCab.grupoos e demais, dump linhas
    * 1610-1663/1753-1813) as properties que BuscarDocumentoMovimento()/
    * BuscarDescricoesGrupoConta() do BO ja resolveram para o registro
    * corrente. Chamado por CarregarDados() nesta fase; a Fase 7-8
    * reusa este mesmo metodo no AfterRowColChange da grade principal.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarCamposDocumento()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_GruOri.Value    = ALLTRIM(loc_oBO.this_cGrupoOrigem)
        THIS.txt_4c_ConOri.Value    = ALLTRIM(loc_oBO.this_cContaOrigem)
        THIS.txt_4c_DesGruOri.Value = ALLTRIM(loc_oBO.this_cDescGrupoOrigem)
        THIS.txt_4c_DesConOri.Value = ALLTRIM(loc_oBO.this_cDescContaOrigem)
        THIS.txt_4c_GruDes.Value    = ALLTRIM(loc_oBO.this_cGrupoDestino)
        THIS.txt_4c_ConDes.Value    = ALLTRIM(loc_oBO.this_cContaDestino)
        THIS.txt_4c_DesGruDes.Value = ALLTRIM(loc_oBO.this_cDescGrupoDestino)
        THIS.txt_4c_DesConDes.Value = ALLTRIM(loc_oBO.this_cDescContaDestino)
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCamposAuditoria - espelha nos campos de auditoria/observacao
    * (legado: ThisForm.Get_nota/Get_usuario/get_Auditors/get_DtAudits/
    * getObs.Value = ... e o bloco llSupervis/llVisAudit/chkAuditado.Value,
    * dump linhas 1794-1798 e 1818-1846) as properties que CarregarDoCursor()/
    * VerificarPermissaoAuditoria() do BO ja resolveram para o registro
    * corrente. this_lPodeAuditar decide Visible; .Value do checkbox so eh
    * atribuido quando visivel, igual ao "If ThisForm.chkAuditado.Visible"
    * do legado. Chamado por CarregarDados() nesta fase; a Fase 7-8
    * reusa este mesmo metodo no AfterRowColChange da grade principal.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarCamposAuditoria()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_Nota.Value     = ALLTRIM(loc_oBO.this_cNotaAtual)
        THIS.txt_4c_Usuario.Value  = ALLTRIM(loc_oBO.this_cUsuarioMovAtual)
        THIS.txt_4c_Auditors.Value = ALLTRIM(loc_oBO.this_cAuditorAtual)
        THIS.txt_4c_DtAudits.Value = loc_oBO.this_dDtAuditAtual
        THIS.obj_4c_GetObs.Value   = loc_oBO.this_cObsAtual

        THIS.chk_4c_ChkAuditado.Visible = loc_oBO.this_lPodeAuditar
        IF THIS.chk_4c_ChkAuditado.Visible
            THIS.chk_4c_ChkAuditado.Value = IIF(EMPTY(loc_oBO.this_cAuditorAtual), 0, 1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - equivalente ao restante do Init legado: depois de
    * CarregarGradePrincipal() (CrSigMvHst + TmpPro/TmpUni), monta o titulo
    * do produto (ObterTituloProduto() do BO - equivalente a
    * ThisForm.lbl_Produto.Caption do Init legado) e resolve o registro
    * corrente (GO BOTTOM feito dentro de CarregarHistorico) via
    * CarregarDoCursor() do BO - que ja encapsula BuscarDocumentoMovimento/
    * BuscarDescricoesGrupoConta/VerificarPermissaoAuditoria/
    * CarregarSubniveis, igual ao AfterRowColChange - e rebinda
    * grd_4c_Subniveis e os 8 campos de Origem/Destino com o resultado.
    * PUBLIC (sem PROTECTED) - e o ponto de entrada de carga de dados deste
    * form OPERACIONAL, equivalente a CarregarLista/MontaGrade/
    * CarregarSaldos nos demais forms OPERACIONAL do projeto.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        IF THIS.CarregarGradePrincipal()
            THIS.lbl_4c_Lbl_produto.Caption = THIS.this_oBusinessObject.ObterTituloProduto()

            IF THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
                THIS.AtualizarGradeSubniveis()
                THIS.AtualizarCamposDocumento()
                THIS.AtualizarCamposAuditoria()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - AfterRowColChange de grd_4c_Dados (legado:
    * grd_historico.AfterRowColChange, dump linhas 579-728): troca de linha/
    * coluna na grade principal reposiciona documento de origem/destino,
    * auditoria/observacao e a grade de subniveis para o registro agora
    * corrente, via CarregarDoCursor() do BO (que ja encapsula
    * BuscarDocumentoMovimento/BuscarDescricoesGrupoConta/
    * VerificarPermissaoAuditoria/CarregarSubniveis - mesmo metodo usado por
    * CarregarDados()). LPARAMETERS par_nColIndex e PUBLIC - exigidos
    * por BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            IF THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
                THIS.AtualizarGradeSubniveis()
                THIS.AtualizarCamposDocumento()
                THIS.AtualizarCamposAuditoria()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkAuditadoClick - chkAuditado.Click do legado (dump:
    * "Private lcDtHis / With ThisForm.poDataMgr / If This.Value = 1 /
    * Select CrSigMvHst / Replace CrSigMvHst.auditors With Usuar /
    * .SqlExecute([Update SigMvHst Set auditors = "]+Usuar+...) / If
    * lnQueryOk < 1 / MessageBox('Favor reinicializar o processo.',16,
    * 'Falha na Conex?o') / .RollBack() / Return(.F.) / EndIf / Replace
    * CrSigMvHst.dtaudits With Date()..."): marca/desmarca a auditoria do
    * registro corrente. THIS.this_oBusinessObject.AtualizarAuditoria() (BO,
    * Fase 2) encapsula a transacao BEGIN/UPDATE auditors/UPDATE dtaudits/
    * COMMIT-ou-ROLLBACK equivalente. Falhando, o checkbox volta ao estado
    * anterior (o legado tambem reverte - o UPDATE nunca commitou) e exibe o
    * MESMO texto do legado ("Favor reinicializar o processo."), que ja vem
    * em THIS.this_cMensagemErro. Sucedendo, reconsulta o registro para
    * refletir o auditors/dtaudits gravados (RegistrarAuditoria do proprio
    * BO fica fora deste fluxo - jah chamado dentro de AtualizarAuditoria) e
    * repinta a grade (auditors alimenta o DynamicBackColor verde-claro da
    * Fase 7). PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ChkAuditadoClick()
        LOCAL loc_lMarcar

        loc_lMarcar = (THIS.chk_4c_ChkAuditado.Value = 1)

        IF THIS.this_oBusinessObject.AtualizarAuditoria(loc_lMarcar)
            THIS.AtualizarCamposAuditoria()
            THIS.grd_4c_Dados.Refresh()
        ELSE
            THIS.chk_4c_ChkAuditado.Value = IIF(loc_lMarcar, 0, 1)
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - cria os 3 botoes de acao do form (dump linhas
    * 492-524 e 1386-1416): obj_4c_Sair (CommandGroup "sair", ButtonCount=1,
    * botao "Encerrar" - mesmo papel do cnt_4c_Saida/cmd_4c_Encerrar
    * canonico CRUD, aqui como CommandGroup porque e assim que o legado
    * desenhou este form OPERACIONAL), cmd_4c_BtnDocumento ("Movimento") e
    * cmd_4c_Command1 ("Procurar"). Os dois standalone usam Themes=.T. +
    * DisabledPicture (CLAUDE.md - standalone CommandButton com Picture).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("obj_4c_Sair", "CommandGroup")
            WITH THIS.obj_4c_Sair
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
                WITH .Buttons(1)
                    .Top        = 5
                    .Left       = 5
                    .Width      = 75
                    .Height     = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Comic Sans MS"
                    .FontSize   = 8
                    .WordWrap   = .T.
                    .Cancel     = .T.
                    .Caption    = "Encerrar"
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                    IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
                        .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    ENDIF
                ENDWITH
            ENDWITH
            BINDEVENT(THIS.obj_4c_Sair, "Click", THIS, "BtnSairClick")

            THIS.AddObject("cmd_4c_BtnDocumento", "CommandButton")
            WITH THIS.cmd_4c_BtnDocumento
                .Top        = 3
                .Left       = 775
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Caption    = "\<Movimento"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .T.
                .Visible    = .T.
                IF FILE(gc_4c_CaminhoIcones + "geral_pastas_60.jpg")
                    .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
                ENDIF
            ENDWITH
            BINDEVENT(THIS.cmd_4c_BtnDocumento, "Click", THIS, "BtnDocumentoClick")

            THIS.AddObject("cmd_4c_Command1", "CommandButton")
            WITH THIS.cmd_4c_Command1
                .Top        = 3
                .Left       = 850
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Caption    = "\<Procurar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .T.
                .Visible    = .T.
                IF FILE(gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg")
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                ENDIF
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Command1, "Click", THIS, "BtnProcurarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Click de obj_4c_Sair (legado: sair.Click, dump linhas
    * 1700-1707): reabilita o form pai e libera esta tela. this_oFormPai
    * substitui ThisForm.ParentForm; nao ha poDataMgr para liberar (a
    * conexao SQL do sistema novo e gnConnHandle, global). Nome bate com o
    * candidato BtnSairClick do harness TesteAutomatico (teste
    * BtnEncerrarExiste - CLAUDE.md, mesmo padrao de FormSigPrGst/
    * FormSigPrGlx). PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcurarClick - Click de cmd_4c_Command1 ("Procurar", legado:
    * Command1.Click, dump linhas 2248-2253): mostra o campo de filtro por
    * data (txt_4c_Data/lbl_4c_Label6 - Get_Data/Say6 no legado, criados na
    * Fase 5-6) com a data corrente e foca nele. PEMSTATUS guarda a
    * referencia-futura ate a Fase 5-6 criar esses controles - sem ela, um
    * clique antes da Fase 5-6 estourar "Property TXT_4C_DATA is not
    * found" em vez de simplesmente nao fazer nada. PUBLIC - exigido para
    * BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcurarClick()
        IF PEMSTATUS(THIS, "txt_4c_Data", 5)
            THIS.this_lOcultandoFiltroData = .F.
            THIS.txt_4c_Data.Visible = .T.
            IF PEMSTATUS(THIS, "lbl_4c_Label6", 5)
                THIS.lbl_4c_Label6.Visible = .T.
            ENDIF
            THIS.txt_4c_Data.Value = DATE()
            THIS.txt_4c_Data.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Click de cmd_4c_BtnDocumento ("Movimento", legado:
    * btnDocumento.Click, dump linhas 2265-2278): abre o documento de
    * movimento da linha corrente de grd_4c_Dados - FormSigMvExp quando ja
    * efetivado (SigMvCab/EmpDopNums) ou FormSigMvPdt quando ainda e
    * necessidade ainda em aberto (SigCdNec/EmpDnPs), replicando
    * ThisForm.poDataMgr.ChkRegister(...) com
    * VerificarDocumentoCadastrado() do BO (Fase 2). As chaves EmpDopNums
    * (29) e EmpDnPs (33) sao POSICIONAIS - PADR explicito, nunca ALLTRIM
    * nas partes (CLAUDE.md regra #42). Show() FORA do TRY - os dois forms
    * sao modais (CLAUDE.md regra #29). PUBLIC - exigido para BINDEVENT
    * (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_cEmps, loc_cEmpos, loc_cDopes, loc_nNumes, loc_cEmpDoc, loc_cClasseForm, loc_oForm, loc_oErro
        loc_cClasseForm = ""

        IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cEmpsAtual)) ;
                OR EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cDopesAtual)) ;
                OR THIS.this_oBusinessObject.this_nNumesAtual = 0
            MsgAviso("Selecione uma Etiqueta em uma das listas para visualizar o Documento!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_cEmps   = PADR(THIS.this_oBusinessObject.this_cEmpsAtual, 3)
        loc_cEmpos  = PADR(THIS.this_oBusinessObject.this_cEmposAtual, 3)
        loc_cDopes  = PADR(THIS.this_oBusinessObject.this_cDopesAtual, 20)
        loc_nNumes  = THIS.this_oBusinessObject.this_nNumesAtual
        loc_cEmpDoc = IIF(!EMPTY(loc_cEmpos), loc_cEmpos, loc_cEmps)

        IF THIS.this_oBusinessObject.VerificarDocumentoCadastrado("SigMvCab", "EmpDopNums", ;
                loc_cEmpDoc + loc_cDopes + STR(loc_nNumes, 6))
            loc_cClasseForm = "FormSigMvExp"
        ELSE
            IF THIS.this_oBusinessObject.VerificarDocumentoCadastrado("SigCdNec", "EmpDnPs", ;
                    loc_cEmps + loc_cDopes + STR(loc_nNumes, 10))
                loc_cClasseForm = "FormSigMvPdt"
            ENDIF
        ENDIF

        IF EMPTY(loc_cClasseForm)
            RETURN
        ENDIF

        loc_oForm = .NULL.
        TRY
            IF loc_cClasseForm == "FormSigMvExp"
                loc_oForm = CREATEOBJECT(loc_cClasseForm, ALLTRIM(loc_cDopes), "C", loc_nNumes, ALLTRIM(loc_cEmpDoc), .T.)
            ELSE
                loc_oForm = CREATEOBJECT(loc_cClasseForm, ALLTRIM(loc_cDopes), "C", loc_nNumes, ALLTRIM(loc_cEmps), .T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir documento:" + CHR(13) + loc_oErro.Message, "Movimento")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarData - Get_Data.Valid do legado (dump linhas 2180-2195):
    *
    *     If IsEmpty(This.Value)
    *         This.Visible = .F. / ThisForm.Say6.Visible = .F. / Return(.T.)
    *     EndIf
    *     Select CrSigMvHst / Set Near On
    *     =Seek(DTOS(This.Value),"CrSigMvHst","datas")
    *     Set Near Off / ThisForm.grd_historico.Refresh / Return(.T.)
    *
    * Valor vazio: esconde o campo e a label e sai (mesmo corpo do LostFocus).
    * Valor preenchido: posiciona cursor_4c_Dados (CrSigMvHst) na data
    * informada e repinta a grade - SET NEAR ON faz o SEEK parar no registro
    * mais PROXIMO quando a data exata nao existe, que e o comportamento de
    * "procurar" esperado pelo usuario. O tag "datas" e criado pelo BO com
    * INDEX ON DTOS(datas) (SigPrHprBO.CarregarHistorico), por isso a chave do
    * SEEK tambem e DTOS() - a forma de 3 argumentos dispensa SET ORDER.
    * SET NEAR e RESTAURADO ao valor anterior (nao chutado para OFF): sem
    * isso o metodo mudaria um SET da datasession em vez de so usa-lo.
    * ConverterParaData() normaliza DATE/DATETIME/CHAR - .Value nasce {}
    * (DATE) mas o campo e digitado pelo usuario (CLAUDE.md regra #16).
    * PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarData(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_dData, loc_cNearAnterior, loc_oErro

        *-- Guarda obrigatoria do handler de KeyPress: so age nas teclas que
        *-- encerram a digitacao (CLAUDE.md - KeyPress handler com guard).
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_dData = ConverterParaData(THIS.txt_4c_Data.Value)

        IF EMPTY(loc_dData)
            THIS.OcultarFiltroData()
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_Dados")
                loc_cNearAnterior = SET("NEAR")

                SELECT cursor_4c_Dados
                SET NEAR ON
                =SEEK(DTOS(loc_dData), "cursor_4c_Dados", "datas")

                IF loc_cNearAnterior == "OFF"
                    SET NEAR OFF
                ENDIF

                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarData")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DataLostFocus - Get_Data.LostFocus do legado (dump linhas 2171-2175).
    * BINDEVENT em LostFocus e seguro AQUI porque o handler nao executa SQL
    * nem remonta grade - so esconde dois controles e move o foco; a recursao
    * que a regra do CLAUDE.md adverte e tratada pela guarda
    * this_lOcultandoFiltroData dentro de OcultarFiltroData().
    * PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE DataLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.OcultarFiltroData()
    ENDPROC

    *--------------------------------------------------------------------------
    * OcultarFiltroData - corpo comum ao LostFocus e ao ramo "data vazia" do
    * Valid do legado: esconde txt_4c_Data/lbl_4c_Label6 (Get_Data/Say6) e
    * devolve o foco a primeira coluna da grade. O SetFocus so e tentado com
    * a grade visivel/habilitada e com registro no cursor - grade vazia nao
    * tem celula para receber o foco (o legado nunca chega aqui sem registro,
    * porque o campo so aparece depois do "Procurar" sobre a grade montada).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE OcultarFiltroData()
        IF THIS.this_lOcultandoFiltroData
            RETURN
        ENDIF

        THIS.this_lOcultandoFiltroData = .T.

        THIS.txt_4c_Data.Visible   = .F.
        THIS.lbl_4c_Label6.Visible = .F.

        IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled AND ;
                USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            THIS.grd_4c_Dados.Column1.SetFocus()
        ENDIF

        THIS.this_lOcultandoFiltroData = .F.
    ENDPROC

ENDDEFINE
