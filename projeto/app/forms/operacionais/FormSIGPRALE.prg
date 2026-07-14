*==============================================================================
* FormSIGPRALE.prg - Dialogo de progresso/aguarde exibido durante processamentos
* Equivalente ao SIGPRALE.SCX do legado
* Uso: loForm = CREATEOBJECT("FormSIGPRALE", cBitmap, cMsg1, cMsg2, cMsg3)
*      loForm.Show()
*      ... processamento ...
*==============================================================================

DEFINE CLASS FormSIGPRALE AS FormBase

    *-- Parametros de exibicao (populados no Init antes de DODEFAULT)
    *-- Defaults refletem captions hardcoded do SCX legado SIGPRALE
    this_cBitmap    = ""
    this_cMensagem1 = "Aguarde..."
    this_cMensagem2 = "Finalizando Reducao Z."
    this_cMensagem3 = ""

    *-- Flag de cancelamento (setada por ESC; consumidor le entre iteracoes)
    this_lCancelou  = .F.

    *-- Propriedades visuais (PILAR 1: identico ao legado)
    Width        = 419
    Height       = 115
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = ""
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    AlwaysOnTop  = .T.
    ClipControls = .F.
    DataSession  = 2

    *--------------------------------------------------------------------------
    * Init - Aceita parametros opcionais de bitmap e mensagens
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cBitmap, par_cMsg1, par_cMsg2, par_cMsg3)
        LOCAL loc_lSucesso

        *-- Default do legado (CHR necessario: acento nao permitido em literal .prg)
        THIS.this_cMensagem3 = "Por Favor. N" + CHR(227) + "o Desligue a impressora Fiscal."

        *-- Armazenar parametros ANTES de DODEFAULT (que chama InicializarForm)
        IF TYPE("par_cBitmap") = "C"
            THIS.this_cBitmap = par_cBitmap
        ENDIF

        IF TYPE("par_cMsg1") = "C" OR TYPE("par_cMsg2") = "C" OR TYPE("par_cMsg3") = "C"
            IF TYPE("par_cMsg1") = "C"
                THIS.this_cMensagem1 = par_cMsg1
            ELSE
                THIS.this_cMensagem1 = ""
            ENDIF
            IF TYPE("par_cMsg2") = "C"
                THIS.this_cMensagem2 = par_cMsg2
            ENDIF
            IF TYPE("par_cMsg3") = "C"
                THIS.this_cMensagem3 = par_cMsg3
            ENDIF
        ENDIF

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Aparencia base do dialogo (OPERACIONAL sem PageFrame)
    * Form SIGPRALE eh um dialogo plano de progresso; sem PageFrame/Pages.
    * Este metodo configura fundo, fontes e cor de base do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .F.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)

        *-- Fundo do dialogo (new_background.jpg do legado)
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria e configura todos os controles do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Business Object (sem tabela - form nao persiste dados)
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRALEBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Configura aparencia base do form (fundo, fontes, cores)
                THIS.ConfigurarPageFrame()

                *-- Criar imagem (icone/bitmap passado como parametro)
                THIS.AddObject("img_4c_Imagem", "Image")
                WITH THIS.img_4c_Imagem
                    .Top     = 5
                    .Left    = 6
                    .Width   = 38
                    .Height  = 36
                    IF !EMPTY(THIS.this_cBitmap) AND FILE(THIS.this_cBitmap)
                        .Picture = THIS.this_cBitmap
                        .Visible = .T.
                    ELSE
                        .Visible = .F.
                    ENDIF
                ENDWITH

                *-- Linha 1 da mensagem (principal, ex: "Aguarde...")
                THIS.AddObject("lbl_4c_Mensagem", "Label")
                WITH THIS.lbl_4c_Mensagem
                    .Top       = 4
                    .Left      = 85
                    .Width     = 97
                    .Height    = 25
                    .AutoSize  = .F.
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 14
                    .WordWrap  = .T.
                    .Alignment = 2
                    .BackStyle = 0
                    .ForeColor = RGB(255, 0, 0)
                    .Caption   = THIS.this_cMensagem1
                    .Visible   = .T.
                ENDWITH

                *-- Linha 2 da mensagem
                THIS.AddObject("lbl_4c_Mensagem2", "Label")
                WITH THIS.lbl_4c_Mensagem2
                    .Top       = 32
                    .Left      = 85
                    .Width     = 221
                    .Height    = 25
                    .AutoSize  = .F.
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 14
                    .WordWrap  = .T.
                    .Alignment = 2
                    .BackStyle = 0
                    .ForeColor = RGB(255, 0, 0)
                    .Caption   = THIS.this_cMensagem2
                    .Visible   = .T.
                ENDWITH

                *-- Linha 3 da mensagem (mais alta para texto longo)
                THIS.AddObject("lbl_4c_Mensagem3", "Label")
                WITH THIS.lbl_4c_Mensagem3
                    .Top       = 62
                    .Left      = 85
                    .Width     = 248
                    .Height    = 48
                    .AutoSize  = .F.
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 14
                    .WordWrap  = .T.
                    .Alignment = 2
                    .BackStyle = 0
                    .ForeColor = RGB(255, 0, 0)
                    .Caption   = THIS.this_cMensagem3
                    .Visible   = .T.
                ENDWITH

                *-- Handler de ESC para sinalizar cancelamento (Closable=.F.,
                *-- consumidor loop de processamento verifica this_lCancelou)
                BINDEVENT(THIS, "KeyPress", THIS, "FormKeyPress")

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SIGPRALEBO.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormKeyPress - Handler bindado a KeyPress do form
    * ESC (27) sinaliza cancelamento; consumidor deve verificar this_lCancelou
    * entre iteracoes do processamento e abortar/liberar o dialogo se .T.
    *--------------------------------------------------------------------------
    PROCEDURE FormKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.this_lCancelou = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarMensagens - Atualiza textos do dialogo em tempo de execucao
    * Permite que o chamador altere as mensagens sem recriar o form
    * par_cMsg1/2/3: nova mensagem (passar "" para limpar, .NULL. para nao alterar)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarMensagens(par_cMsg1, par_cMsg2, par_cMsg3)
        LOCAL loc_oErro
        TRY
            IF TYPE("par_cMsg1") = "C"
                THIS.lbl_4c_Mensagem.Caption  = par_cMsg1
                THIS.this_cMensagem1          = par_cMsg1
            ENDIF
            IF TYPE("par_cMsg2") = "C"
                THIS.lbl_4c_Mensagem2.Caption = par_cMsg2
                THIS.this_cMensagem2          = par_cMsg2
            ENDIF
            IF TYPE("par_cMsg3") = "C"
                THIS.lbl_4c_Mensagem3.Caption = par_cMsg3
                THIS.this_cMensagem3          = par_cMsg3
            ENDIF
            THIS.Refresh()
            DOEVENTS
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarBitmap - Troca a imagem exibida no dialogo
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarBitmap(par_cBitmap)
        LOCAL loc_oErro
        TRY
            IF TYPE("par_cBitmap") = "C" AND !EMPTY(par_cBitmap) AND FILE(par_cBitmap)
                THIS.img_4c_Imagem.Picture = par_cBitmap
                THIS.img_4c_Imagem.Visible = .T.
                THIS.this_cBitmap = par_cBitmap
            ELSE
                THIS.img_4c_Imagem.Visible = .F.
            ENDIF
            THIS.Refresh()
            DOEVENTS
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - N/A (form OPERACIONAL de dialogo, sem PageFrame)
    * SIGPRALE eh um dialogo modal de progresso (419x115) sem Page1/Grid/Botoes CRUD.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Sem-operacao: form nao possui PageFrame nem grid de lista.
        *-- Layout do dialogo eh totalmente construido em InicializarForm().
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - N/A (form OPERACIONAL de dialogo, sem Page2)
    * SIGPRALE eh um dialogo modal de progresso (419x115) sem campos de entrada.
    * Todos os controles (img_4c_Imagem, lbl_4c_Mensagem/2/3) sao criados
    * diretamente em InicializarForm(), nao em paginas separadas.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 5).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Sem-operacao: form nao possui Page2 nem campos de entrada.
        *-- Controles de exibicao estao em InicializarForm().
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - N/A (form OPERACIONAL de dialogo, sem PageFrame)
    * SIGPRALE nao alterna entre paginas; sempre exibe imagem + 3 mensagens.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        *-- Sem-operacao: dialogo nao possui paginas para alternar.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - N/A (form OPERACIONAL de dialogo, sem CRUD)
    * SIGPRALE eh um dialogo modal de progresso exibido durante processamentos
    * (ex: Reducao Z). Nao inclui/altera/visualiza/exclui registros - apenas
    * exibe status ao usuario enquanto o processamento em background executa.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    * Consumidor tipico: DO WHILE processando / oProg.AtualizarMensagens(...) / ENDDO
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        *-- Sem-operacao: dialogo de progresso nao suporta inclusao de registros.
        *-- Ver AtualizarMensagens() / AtualizarBitmap() para uso pretendido.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - N/A (form OPERACIONAL de dialogo, sem CRUD)
    * SIGPRALE nao possui campos editaveis nem grid de lista para alterar.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        *-- Sem-operacao: dialogo de progresso nao suporta alteracao de registros.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - N/A (form OPERACIONAL de dialogo, sem CRUD)
    * SIGPRALE ja eh o proprio dialogo de exibicao - nao ha registros
    * secundarios para visualizar (imagem + 3 labels ja sao o conteudo).
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        *-- Sem-operacao: dialogo ja eh visual por natureza; sem grid/registros.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - N/A (form OPERACIONAL de dialogo, sem CRUD)
    * SIGPRALE nao persiste dados; encerramento eh via Release() do chamador
    * apos concluir o processamento em background. Nao ha registros para excluir.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        *-- Sem-operacao: dialogo de progresso nao suporta exclusao de registros.
        *-- Para encerrar o dialogo, o chamador deve invocar THIS.Release().
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - N/A (dialogo de progresso sem busca de registros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        *-- Sem-operacao: dialogo de progresso nao possui grade nem busca.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o dialogo de progresso
    * Chamado pelo consumidor ou por tecla ESC (via FormKeyPress)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.this_lCancelou = .T.
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - N/A (dialogo nao-persistente, sem campos editaveis)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        *-- Sem-operacao: form de progresso nao persiste dados.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela processamento em curso e fecha o dialogo
    * Sinaliza cancelamento para o consumidor atraves de this_lCancelou
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_lCancelou = .T.
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia estado atual do form para o BO
    * Para SIGPRALE: sincroniza as mensagens e bitmap exibidos com o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cBitmap    = THIS.this_cBitmap
                THIS.this_oBusinessObject.this_cMensagem1 = THIS.this_cMensagem1
                THIS.this_oBusinessObject.this_cMensagem2 = THIS.this_cMensagem2
                THIS.this_oBusinessObject.this_cMensagem3 = THIS.this_cMensagem3
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia dados do BO de volta para os controles do form
    * Para SIGPRALE: atualiza as labels com as mensagens do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.lbl_4c_Mensagem.Caption  = THIS.this_oBusinessObject.this_cMensagem1
                THIS.lbl_4c_Mensagem2.Caption = THIS.this_oBusinessObject.this_cMensagem2
                THIS.lbl_4c_Mensagem3.Caption = THIS.this_oBusinessObject.this_cMensagem3
                THIS.this_cMensagem1 = THIS.this_oBusinessObject.this_cMensagem1
                THIS.this_cMensagem2 = THIS.this_oBusinessObject.this_cMensagem2
                THIS.this_cMensagem3 = THIS.this_oBusinessObject.this_cMensagem3

                IF !EMPTY(THIS.this_oBusinessObject.this_cBitmap) AND ;
                   FILE(THIS.this_oBusinessObject.this_cBitmap)
                    THIS.img_4c_Imagem.Picture = THIS.this_oBusinessObject.this_cBitmap
                    THIS.img_4c_Imagem.Visible = .T.
                    THIS.this_cBitmap = THIS.this_oBusinessObject.this_cBitmap
                ELSE
                    THIS.img_4c_Imagem.Visible = .F.
                ENDIF

                THIS.Refresh()
                DOEVENTS
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - N/A (dialogo sem campos de entrada editaveis)
    * SIGPRALE exibe informacao read-only; nao ha campos para habilitar/desabilitar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- Sem-operacao: form de progresso nao possui campos editaveis.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa as mensagens exibidas no dialogo
    * Util para reutilizacao do dialogo em fases distintas de processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            THIS.this_cMensagem1 = ""
            THIS.this_cMensagem2 = ""
            THIS.this_cMensagem3 = ""
            THIS.lbl_4c_Mensagem.Caption  = ""
            THIS.lbl_4c_Mensagem2.Caption = ""
            THIS.lbl_4c_Mensagem3.Caption = ""
            THIS.img_4c_Imagem.Visible    = .F.
            THIS.this_cBitmap             = ""
            THIS.Refresh()
            DOEVENTS
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - N/A (dialogo de progresso sem grade de registros)
    * SIGPRALE nao exibe lista; conteudo e definido via parametros do Init
    * ou via AtualizarMensagens() durante o processamento em andamento.
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        *-- Sem-operacao: dialogo de progresso nao possui grade de lista.
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - N/A (dialogo de progresso sem modos CRUD)
    * SIGPRALE nao possui botoes CRUD nem modos INCLUIR/ALTERAR/VISUALIZAR.
    * O dialogo e exibido enquanto processamento externo executa e e encerrado
    * pelo chamador via THIS.Release() apos conclusao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        *-- Sem-operacao: dialogo de progresso nao possui modos nem botoes CRUD.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            UNBINDEVENTS(THIS)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
