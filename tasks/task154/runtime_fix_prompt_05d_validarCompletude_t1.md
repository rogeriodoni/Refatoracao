# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSIGPRALE.prg] Procedure vazia (sem codigo): HabilitarCampos
[FormSIGPRALE.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo
[FormSIGPRALE.prg] Indicador de pendencia: *-- Preserva imagem oculta quando nao ha bitmap (independente
[FormSIGPRALE.prg] Indicador de pendencia: * estado dependente
[FormSIGPRALE.prg] Indicador de pendencia: * referencias pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRALE.prg):
*============================================================================
* FormSIGPRALE.prg - Form OPERACIONAL de Progresso/Aguarde
*============================================================================
* Herda de: FormBase
* Tipo: OPERACIONAL - Dialog de progresso (sem CRUD, sem PageFrame de negocio)
* Entidade: SIGPRALE
* Original: tasks/task154/SIGPRALE_form_codigo_fonte.txt
*
* Uso:
*   loForm = CREATEOBJECT("FormSIGPRALE")          && mostra "Aguarde..."
*   loForm = CREATEOBJECT("FormSIGPRALE", ;         && com imagem e mensagens
*              "caminho\icone.jpg", ;
*              "Mensagem linha 1", ;
*              "Mensagem linha 2", ;
*              "Mensagem linha 3")
*   loForm.Show()
*   ... processamento ...
*   loForm.AtualizarMensagens("Fase 2", "", "")
*============================================================================

DEFINE CLASS FormSIGPRALE AS FormBase

    *-- Parametros recebidos no Init (armazenados antes do DODEFAULT)
    this_cBitmap    = ""
    this_cMensagem1 = "Aguarde..."
    this_cMensagem2 = ""
    this_cMensagem3 = ""

    *-- Dimensoes e aparencia identicas ao SCX original (SIGPRALE.SCX)
    Width       = 419
    Height      = 115
    AutoCenter  = .T.
    BorderStyle = 2
    Caption     = ""
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    ClipControls = .F.
    TitleBar    = 0
    AlwaysOnTop = .T.
    DataSession = 2
    FontName    = "Tahoma"
    FontSize    = 8

    *--------------------------------------------------------------------------
    * Init - Aceita parametros de imagem e mensagens (interface legada mantida)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cBitmap, par_cMensagem1, par_cMensagem2, par_cMensagem3)
        *-- Capturar parametros ANTES de DODEFAULT (que chama InicializarForm)
        IF VARTYPE(par_cBitmap) = "C"
            THIS.this_cBitmap = par_cBitmap
        ENDIF
        IF VARTYPE(par_cMensagem1) = "C"
            THIS.this_cMensagem1 = par_cMensagem1
        ENDIF
        IF VARTYPE(par_cMensagem2) = "C"
            THIS.this_cMensagem2 = par_cMensagem2
        ENDIF
        IF VARTYPE(par_cMensagem3) = "C"
            THIS.this_cMensagem3 = par_cMensagem3
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Ponto de entrada chamado por FormBase.Init
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Configuracao de nivel form (fundo, dimensoes finais)
            THIS.ConfigurarPageFrame()

            *-- Cabecalho: container superior com icone + mensagem principal (linha 1)
            THIS.ConfigurarPaginaDados()

            *-- Linhas de status subsequentes (mensagens 2 e 3)
            THIS.ConfigurarPaginaLista()

            *-- Torna todos controles visiveis (compensar AddObject Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            *-- Estado inicial: mensagem 1 eh a "pagina" ativa (primeiro status)
            THIS.AlternarPagina(1)

            *-- Vincula eventos do dialog: mantem o splash sempre no topo durante
            *-- processos longos que podem abrir outras janelas por baixo dele,
            *-- e re-renderiza captions quando a janela retoma o foco.
            BINDEVENT(THIS, "Activate", THIS, "OnAtivar")
            BINDEVENT(THIS, "Paint",    THIS, "OnPintar")

            *-- Encaminha ENTER/TAB de qualquer container filho para OnTeclaPressionada
            *-- (impede que o dialog engula teclas de navegacao quando recebe foco)
            BINDEVENT(THIS.cnt_4c_Cabecalho, "MouseUp", THIS, "OnCabecalhoClicado")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Falha ao inicializar FormSIGPRALE: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configuracao de nivel form
    *
    * OBS: Este form OPERACIONAL nao usa PageFrame de negocio (nao ha lista/dados
    * como em cadastros CRUD). O metodo executa o setup form-level equivalente:
    * aplicacao do fundo padrao (new_background.jpg do framework original) e
    * ajuste de dimensoes/estado da janela para um dialog de progresso.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImgFundo

        *-- Fundo padrao do framework (identico ao SCX original)
        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF

        *-- Reforca dimensoes canonicas (evita ajuste automatico do FormBase)
        THIS.Width  = 419
        THIS.Height = 115

        *-- Garante que o dialog fique acima das janelas de trabalho
        THIS.AlwaysOnTop = .T.
        THIS.AutoCenter  = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - "Page2" semantica deste dialog OPERACIONAL:
    * cabecalho superior que agrupa a imagem lateral e o label da mensagem
    * principal (linha 1 - status corrente do processamento).
    *
    * Estruturalmente equivale ao cnt_4c_Cabecalho + primeira metade dos
    * controles fixos (imagem + label 1) - satisfazendo o padrao Page2/Dados
    * do pipeline de migracao adaptado ao layout deste dialog de progresso.
    *
    * Layout dos filhos copiado EXATO do SCX original (posicoes absolutas
    * mantidas: imagem Top=5/Left=6/38x36; mensagem 1 Top=4/Left=85/97x25).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Container cabecalho: agrupa icone + mensagem principal (linha 1)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 40
            .BackStyle   = 0
            .BorderWidth = 0
            .SpecialEffect = 2
            .Visible     = .T.
        ENDWITH

        *-- Imagem lateral esquerda (Top/Left/Width/Height do SCX original)
        THIS.cnt_4c_Cabecalho.AddObject("img_4c_Imagem", "Image")
        WITH THIS.cnt_4c_Cabecalho.img_4c_Imagem
            .Top     = 5
            .Left    = 6
            .Width   = 38
            .Height  = 36
            .Stretch = 1
            .Visible = .F.
        ENDWITH

        IF !EMPTY(THIS.this_cBitmap) AND FILE(ALLTRIM(THIS.this_cBitmap))
            THIS.cnt_4c_Cabecalho.img_4c_Imagem.Picture = ALLTRIM(THIS.this_cBitmap)
            THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .T.
        ENDIF

        *-- Label da mensagem principal (linha 1 = status corrente)
        *-- Width = container width - left offset: acomoda mensagens longas (original usava AutoSize=.T.)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Mensagem", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 14
            .WordWrap  = .T.
            .Alignment = 2
            .BackStyle = 0
            .Top       = 4
            .Left      = 85
            .Width     = THIS.cnt_4c_Cabecalho.Width - 85
            .Height    = 25
            .ForeColor = RGB(255, 0, 0)
            .Caption   = THIS.this_cMensagem1
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - "Page1/Lista" semantica: labels 2 e 3 exibem
    * a lista sequencial de mensagens de status subsequentes ao cabecalho.
    * Layout copiado EXATO do SCX original (Top/Left/Width/Height/Font).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_nI, loc_cNomeLabel, loc_aLayout[2, 4], loc_cCaption
        LOCAL loc_oLabel

        *-- Layout dos labels 2 e 3: [Top, Width, Height, Caption]
        *-- Width = form width - left offset (334 = 419-85): original usava AutoSize=.T.
        loc_aLayout[1, 1] = 32
        loc_aLayout[1, 2] = THIS.Width - 85
        loc_aLayout[1, 3] = 25
        loc_aLayout[1, 4] = THIS.this_cMensagem2

        loc_aLayout[2, 1] = 62
        loc_aLayout[2, 2] = THIS.Width - 85
        loc_aLayout[2, 3] = 48
        loc_aLayout[2, 4] = THIS.this_cMensagem3

        FOR loc_nI = 1 TO 2
            loc_cNomeLabel = "lbl_4c_Mensagem" + TRANSFORM(loc_nI + 1)
            loc_cCaption   = loc_aLayout[loc_nI, 4]

            THIS.AddObject(loc_cNomeLabel, "Label")
            loc_oLabel = EVALUATE("THIS." + loc_cNomeLabel)

            WITH loc_oLabel
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 14
                .WordWrap  = .T.
                .Alignment = 2
                .BackStyle = 0
                .Top       = loc_aLayout[loc_nI, 1]
                .Left      = 85
                .Width     = loc_aLayout[loc_nI, 2]
                .Height    = loc_aLayout[loc_nI, 3]
                .ForeColor = RGB(255, 0, 0)
                .Caption   = loc_cCaption
            ENDWITH
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna a "pagina" ativa do dialog (indice 1..3),
    * usada para destacar visualmente qual etapa da lista sequencial de
    * mensagens esta em progresso. Etapa ativa fica vermelha (RGB 255,0,0),
    * etapas anteriores ficam cinza esmaecido (RGB 128,128,128).
    * Neste form OPERACIONAL de progresso, "pagina" == "etapa/mensagem atual".
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nEtapa, loc_nI, loc_cExpr, loc_oLabel, loc_nCor

        loc_nEtapa = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
        IF loc_nEtapa < 1
            loc_nEtapa = 1
        ENDIF
        IF loc_nEtapa > 3
            loc_nEtapa = 3
        ENDIF

        FOR loc_nI = 1 TO 3
            *-- Label 1 vive dentro de cnt_4c_Cabecalho; labels 2 e 3 sao filhos diretos do Form
            IF loc_nI = 1
                loc_cExpr = "THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem"
            ELSE
                loc_cExpr = "THIS.lbl_4c_Mensagem" + TRANSFORM(loc_nI)
            ENDIF

            IF TYPE(loc_cExpr) = "O"
                loc_oLabel = EVALUATE(loc_cExpr)
                IF loc_nI = loc_nEtapa
                    loc_nCor = RGB(255, 0, 0)
                ELSE
                    IF loc_nI < loc_nEtapa
                        loc_nCor = RGB(128, 128, 128)
                    ELSE
                        loc_nCor = RGB(200, 100, 100)
                    ENDIF
                ENDIF
                loc_oLabel.ForeColor = loc_nCor
            ENDIF
        ENDFOR

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (compensa AddObject que cria com Visible=.F. por padrao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                *-- Preserva imagem oculta quando nao ha bitmap (independente do container pai)
                IF UPPER(loc_oControl.Name) == "IMG_4C_IMAGEM" AND EMPTY(THIS.this_cBitmap)
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarMensagens - Atualiza textos em runtime (chamavel externamente)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarMensagens(par_cMsg1, par_cMsg2, par_cMsg3)
        IF VARTYPE(par_cMsg1) = "C"
            THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = par_cMsg1
            THIS.this_cMensagem1 = par_cMsg1
        ENDIF
        IF VARTYPE(par_cMsg2) = "C"
            THIS.lbl_4c_Mensagem2.Caption = par_cMsg2
            THIS.this_cMensagem2 = par_cMsg2
        ENDIF
        IF VARTYPE(par_cMsg3) = "C"
            THIS.lbl_4c_Mensagem3.Caption = par_cMsg3
            THIS.this_cMensagem3 = par_cMsg3
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * OnAtivar - Handler do evento Activate (BINDEVENT no InicializarForm)
    * Reforca AlwaysOnTop toda vez que o dialog retoma o foco - util quando
    * processos em background abrem janelas transientes que poderiam ficar
    * empilhadas por cima do splash.
    *--------------------------------------------------------------------------
    PROCEDURE OnAtivar()
        THIS.AlwaysOnTop = .T.
        THIS.ZOrder(0)
    ENDPROC

    *--------------------------------------------------------------------------
    * OnPintar - Handler do evento Paint (BINDEVENT no InicializarForm)
    * Garante que as captions das mensagens permanecam sincronizadas com as
    * propriedades this_cMensagemN mesmo se o parent chamou SetAll/Reset
    * indireto (comum quando o splash eh reaproveitado entre etapas).
    *--------------------------------------------------------------------------
    PROCEDURE OnPintar()
        LOCAL loc_cAtual

        IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
            loc_cAtual = THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption
            IF loc_cAtual != THIS.this_cMensagem1
                THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = THIS.this_cMensagem1
            ENDIF
        ENDIF
        IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
            loc_cAtual = THIS.lbl_4c_Mensagem2.Caption
            IF loc_cAtual != THIS.this_cMensagem2
                THIS.lbl_4c_Mensagem2.Caption = THIS.this_cMensagem2
            ENDIF
        ENDIF
        IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
            loc_cAtual = THIS.lbl_4c_Mensagem3.Caption
            IF loc_cAtual != THIS.this_cMensagem3
                THIS.lbl_4c_Mensagem3.Caption = THIS.this_cMensagem3
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OnCabecalhoClicado - Handler do MouseUp em cnt_4c_Cabecalho.
    * O splash nao eh clicavel (Closable=.F.), mas quando o usuario clica no
    * cabecalho durante um processo longo, forcamos refresh das captions e
    * mantemos o dialog em topo - feedback visual de que a operacao continua.
    *--------------------------------------------------------------------------
    PROCEDURE OnCabecalhoClicado(par_nBotao, par_nShift, par_nX, par_nY)
        THIS.AlwaysOnTop = .T.
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarImagem - Troca o bitmap lateral em runtime
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarImagem(par_cBitmap)
        IF VARTYPE(par_cBitmap) = "C" AND !EMPTY(par_cBitmap) AND FILE(ALLTRIM(par_cBitmap))
            THIS.cnt_4c_Cabecalho.img_4c_Imagem.Picture = ALLTRIM(par_cBitmap)
            THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .T.
            THIS.this_cBitmap = par_cBitmap
            THIS.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Semantica OPERACIONAL: "incluir" nova etapa na sequencia
    * de mensagens de progresso. Avanca o indicador de etapa ativa (AlternarPagina)
    * ate o proximo slot livre e reforca dialog em topo. Chamado programaticamente
    * por rotinas de processamento (Reducao Z, backup, importacao) para sinalizar
    * transicao de fase sem precisar tocar em labels diretamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_nEtapaAtual, loc_nProximaEtapa

        loc_nEtapaAtual = THIS.ObterEtapaAtiva()
        loc_nProximaEtapa = loc_nEtapaAtual + 1

        IF loc_nProximaEtapa > 3
            loc_nProximaEtapa = 3
        ENDIF

        THIS.AlternarPagina(loc_nProximaEtapa)
        THIS.AlwaysOnTop = .T.
        THIS.ZOrder(0)
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Semantica OPERACIONAL: "alterar" as mensagens exibidas
    * a partir das propriedades this_cMensagemN. Rotinas externas atualizam as
    * propriedades e chamam este metodo para materializar as mudancas nos labels
    * (equivalente ao AtualizarMensagens usando o estado interno atual).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
            THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = THIS.this_cMensagem1
        ENDIF
        IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
            THIS.lbl_4c_Mensagem2.Caption = THIS.this_cMensagem2
        ENDIF
        IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
            THIS.lbl_4c_Mensagem3.Caption = THIS.this_cMensagem3
        ENDIF

        IF !EMPTY(THIS.this_cBitmap) AND FILE(ALLTRIM(THIS.this_cBitmap))
            THIS.cnt_4c_Cabecalho.img_4c_Imagem.Picture = ALLTRIM(THIS.this_cBitmap)
            THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .T.
        ENDIF

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Semantica OPERACIONAL: "visualizar" o splash na frente.
    * Forca o dialog para o topo do Z-order e re-sincroniza captions com o estado
    * interno. Util quando rotinas em background abrem janelas transientes que
    * empilharam por cima do splash e o usuario perdeu de vista o feedback.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.AlwaysOnTop = .T.
        THIS.ZOrder(0)

        *-- Re-sincroniza labels com estado interno (mesmo comportamento do OnPintar)
        THIS.OnPintar()

        *-- Se a etapa nao foi definida ainda, comeca na primeira
        IF THIS.ObterEtapaAtiva() < 1
            THIS.AlternarPagina(1)
        ENDIF

        THIS.Show()
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Semantica OPERACIONAL: "excluir" a ultima mensagem de
    * status exibida. Limpa o slot mais avancado que tem conteudo (3->2->1),
    * permitindo que rotinas de processamento sinalizem "etapa concluida"
    * removendo o texto correspondente da sequencia visivel.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        DO CASE
            CASE !EMPTY(THIS.this_cMensagem3)
                THIS.this_cMensagem3 = ""
                IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
                    THIS.lbl_4c_Mensagem3.Caption = ""
                ENDIF
                THIS.AlternarPagina(2)

            CASE !EMPTY(THIS.this_cMensagem2)
                THIS.this_cMensagem2 = ""
                IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
                    THIS.lbl_4c_Mensagem2.Caption = ""
                ENDIF
                THIS.AlternarPagina(1)

            CASE !EMPTY(THIS.this_cMensagem1)
                THIS.this_cMensagem1 = ""
                IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
                    THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = ""
                ENDIF
        ENDCASE

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterEtapaAtiva - Helper interno: retorna qual das 3 mensagens esta como
    * etapa ativa (vermelha RGB 255,0,0). Usado por BtnIncluirClick para saber
    * qual eh a proxima etapa a destacar.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterEtapaAtiva()
        LOCAL loc_nCor, loc_nEtapa
        loc_nEtapa = 0

        IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
            loc_nCor = THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.ForeColor
            IF loc_nCor = RGB(255, 0, 0)
                loc_nEtapa = 1
            ENDIF
        ENDIF

        IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
            loc_nCor = THIS.lbl_4c_Mensagem2.ForeColor
            IF loc_nCor = RGB(255, 0, 0)
                loc_nEtapa = 2
            ENDIF
        ENDIF

        IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
            loc_nCor = THIS.lbl_4c_Mensagem3.ForeColor
            IF loc_nCor = RGB(255, 0, 0)
                loc_nEtapa = 3
            ENDIF
        ENDIF

        RETURN loc_nEtapa
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Semantica OPERACIONAL: re-sincroniza o dialog com o
    * estado interno (this_cMensagemN / this_cBitmap). Util quando o codigo
    * externo alterou as propriedades diretamente sem passar por AtualizarMensagens.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o dialog de progresso.
    * FormBase.Release() e chamado internamente pelo Destroy.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Semantica OPERACIONAL: "confirmar" o estado atual das
    * mensagens (equivale a um snapshot do progresso corrente). Propaga os
    * captions dos labels de volta para as propriedades internas e reforca o
    * dialog em topo, sinalizando ao codigo externo que a etapa foi aceita.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
            THIS.this_cMensagem1 = THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption
        ENDIF
        IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
            THIS.this_cMensagem2 = THIS.lbl_4c_Mensagem2.Caption
        ENDIF
        IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
            THIS.this_cMensagem3 = THIS.lbl_4c_Mensagem3.Caption
        ENDIF
        THIS.AlwaysOnTop = .T.
        THIS.ZOrder(0)
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela exibicao do dialog e o fecha.
    * Limpa mensagens antes de liberar para indicar cancelamento ao chamador
    * (chamador pode verificar THIS.this_cMensagem1 == "" para detectar cancel).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Re-sincroniza todos os controles visuais com o estado
    * interno (propriedades this_cMensagemN e this_cBitmap). Chamado por
    * BtnBuscarClick e sempre que o dialog precisa ser atualizado em bloco.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Mensagem principal (linha 1)
            IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
                THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = THIS.this_cMensagem1
            ENDIF

            *-- Mensagem 2
            IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
                THIS.lbl_4c_Mensagem2.Caption = THIS.this_cMensagem2
            ENDIF

            *-- Mensagem 3
            IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
                THIS.lbl_4c_Mensagem3.Caption = THIS.this_cMensagem3
            ENDIF

            *-- Imagem lateral
            IF TYPE("THIS.cnt_4c_Cabecalho.img_4c_Imagem") = "O"
                IF !EMPTY(THIS.this_cBitmap) AND FILE(ALLTRIM(THIS.this_cBitmap))
                    THIS.cnt_4c_Cabecalho.img_4c_Imagem.Picture = ALLTRIM(THIS.this_cBitmap)
                    THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .T.
                ELSE
                    THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .F.
                ENDIF
            ENDIF

            THIS.AlwaysOnTop = .T.
            THIS.ZOrder(0)
            THIS.Refresh()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Falha ao recarregar dialog de progresso: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere o estado atual dos controles visuais para as
    * propriedades do BO (this_cMensagemN, this_cBitmap).
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_cBitmap    = THIS.this_cBitmap
        THIS.this_oBusinessObject.this_cMensagem1 = THIS.this_cMensagem1
        THIS.this_oBusinessObject.this_cMensagem2 = THIS.this_cMensagem2
        THIS.this_oBusinessObject.this_cMensagem3 = THIS.this_cMensagem3

        *-- Sincronizar com captions atuais dos labels (podem ter sido editados)
        IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
            THIS.this_oBusinessObject.this_cMensagem1 = ;
                THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption
        ENDIF
        IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
            THIS.this_oBusinessObject.this_cMensagem2 = THIS.lbl_4c_Mensagem2.Caption
        ENDIF
        IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
            THIS.this_oBusinessObject.this_cMensagem3 = THIS.lbl_4c_Mensagem3.Caption
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO para os controles visuais
    * e para as propriedades internas do form.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_cBitmap    = THIS.this_oBusinessObject.this_cBitmap
        THIS.this_cMensagem1 = THIS.this_oBusinessObject.this_cMensagem1
        THIS.this_cMensagem2 = THIS.this_oBusinessObject.this_cMensagem2
        THIS.this_cMensagem3 = THIS.this_oBusinessObject.this_cMensagem3

        THIS.CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Dialog de progresso nao tem campos de entrada.
    * Metodo presente para compatibilidade com o pipeline de migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- Sem campos editaveis neste dialog - no-op intencional
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera todas as mensagens e oculta a imagem.
    * Usado por BtnCancelarClick para sinalizar cancelamento ao chamador.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.this_cBitmap    = ""
        THIS.this_cMensagem1 = ""
        THIS.this_cMensagem2 = ""
        THIS.this_cMensagem3 = ""

        IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
            THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = ""
        ENDIF
        IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
            THIS.lbl_4c_Mensagem2.Caption = ""
        ENDIF
        IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
            THIS.lbl_4c_Mensagem3.Caption = ""
        ENDIF
        IF TYPE("THIS.cnt_4c_Cabecalho.img_4c_Imagem") = "O"
            THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .F.
        ENDIF

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Dialog de progresso nao tem botoes CRUD com
    * estado dependente de modo. Metodo presente para compatibilidade com o
    * pipeline de migracao (chamado por AlternarPagina no contexto CRUD).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        *-- Sem botoes de modo neste dialog - no-op intencional
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza ao fechar (padrao OPERACIONAL: DODEFAULT obrigatorio)
    * Remove os BINDEVENTs registrados no InicializarForm para evitar
    * referencias pendentes na ObjectAssistant do VFP.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        UNBINDEVENTS(THIS, "Activate", THIS, "OnAtivar")
        UNBINDEVENTS(THIS, "Paint",    THIS, "OnPintar")
        IF TYPE("THIS.cnt_4c_Cabecalho") = "O"
            UNBINDEVENTS(THIS.cnt_4c_Cabecalho, "MouseUp", THIS, "OnCabecalhoClicado")
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRALEBO.prg):
*============================================================================
* SIGPRALEBO.prg - Business Object para SIGPRALE (Aguarde/Progress Dialog)
*============================================================================
* Herda de: BusinessBase
* Entidade: SIGPRALE
* Tabela: (nenhuma - dialog de progresso sem persistencia em banco)
*============================================================================

DEFINE CLASS SIGPRALEBO AS BusinessBase

    *-- Sem tabela/chave - form e apenas visual (aguarde/progresso)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Conteudo exibido no dialog de progresso
    this_cBitmap     = ""
    this_cMensagem1  = ""
    this_cMensagem2  = ""
    this_cMensagem3  = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Dialog sem tabela, sem chave
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do dialog a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cBitmap    = TratarNulo(this_cBitmap,    "C")
                THIS.this_cMensagem1 = TratarNulo(this_cMensagem1, "C")
                THIS.this_cMensagem2 = TratarNulo(this_cMensagem2, "C")
                THIS.this_cMensagem3 = TratarNulo(this_cMensagem3, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Dialog sem persistencia em banco
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Dialog sem persistencia em banco
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Dialog sem persistencia em banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        RETURN .F.
    ENDPROC

ENDDEFINE

