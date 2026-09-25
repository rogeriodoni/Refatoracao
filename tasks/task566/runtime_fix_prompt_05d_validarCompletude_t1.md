# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SIGMVCTHBO.prg] Indicador de pendencia: * classe base (retornam .F. com mensagem de metodo nao implement

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVCTH.prg):
*==============================================================================
* FormSIGMVCTH.prg - Form Operacional: Historico de Cotacoes
* Migrado de: tasks/task566/SIGMVCTH.SCX
* BO: SIGMVCTHBO
*
* Visualizador SOMENTE LEITURA (sem PageFrame Lista/Dados - o legado eh um
* form "flat" unico): grade com o historico de cotacoes de um produto dentro
* de uma proposta, mais os campos de aprovacao (Comprador/Aprovador/Data/
* Observacao) da linha selecionada na grade. Recebe a proposta (CPros) e o
* codigo do produto atual (Codigos, excluido do historico) como parametros.
*==============================================================================

DEFINE CLASS FormSIGMVCTH AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity, valores EXATOS do SCX legado)
    Height      = 590
    Width       = 1000
    Caption     = "Hist" + CHR(243) + "rico de Cota" + CHR(231) + CHR(245) + "es"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    TitleBar    = 1
    Themes      = .F.
    BorderStyle = 2

    *-- Parametros recebidos no Init (equivalentes a pPro/pCod do legado)
    this_cCPros   = ""
    this_nCodigos = 0

    *--------------------------------------------------------------------------
    * Init - Recebe par_cCPros (proposta) e par_nCodigos (produto atual, a
    * ser excluido do historico) antes de delegar a FormBase.Init (que chama
    * InicializarForm). A conexao SQL (pCnx no legado) nao eh mais recebida
    * por parametro - usa o handle global gnConnHandle.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_cCPros, par_nCodigos

        IF VARTYPE(par_cCPros) = "C"
            THIS.this_cCPros = PADR(par_cCPros, 14)
        ENDIF
        IF VARTYPE(par_nCodigos) = "N"
            THIS.this_nCodigos = par_nCodigos
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object, repassa os parametros e monta
    * a estrutura visual do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        *-- Guardas do Init legado (parametro de conexao invalido / pnIdConn
        *-- <= 0): o legado RECUSA abrir a tela nesses casos. RETURN fora de
        *-- TRY/CATCH (regra #1).
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGMVCTHBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SIGMVCTHBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ELSE
                *-- Repassa o filtro (proposta + produto atual) do form para o
                *-- BO pelo MESMO caminho usado por CarregarLista, para o BO
                *-- nunca consultar com filtro desatualizado.
                THIS.FormParaBO()

                *-- Monta a estrutura visual primeiro (grade ja ligada ao
                *-- cursor vazio de partida) e so depois carrega os dados -
                *-- CarregarLista() refaz o vinculo da grade, que o BO quebra
                *-- ao recriar o cursor. Mesma ordem do Init legado, que faz o
                *-- SetAll no grdCotacoes e so entao chama .CarregaPedidos.
                THIS.ConfigurarPageFrame()

                *-- Falha aqui nao impede a abertura do form - CarregarHistorico
                *-- ja exibe o proprio MostrarErro quando falha
                THIS.CarregarLista()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Transcricao das DUAS guardas do Init legado, que
    * RECUSAM abrir a tela (Return .f.) quando a conexao nao esta utilizavel:
    *
    *   If (Type([pCnx]) <> [O])
    *       =Messagebox([O Parametro de Conexao Passado Nao e Valido...], 0+48, ...)
    *       Return .f.
    *   EndIf
    *   If (.poDataMgr.pnIdconn > 0) ... Else
    *       =Messagebox('Impossivel Efetuar Conexao Com o Servidor de Banco de Dados...', 0+48, ...)
    *       Return .f.
    *   EndIf
    *
    * Na nova arquitetura a conexao nao vem mais por parametro (pCnx): eh o
    * handle global gnConnHandle. As duas guardas do legado colapsam nas duas
    * checagens abaixo - handle ausente/nao-numerico (equivale a pCnx que nao
    * eh objeto) e handle <= 0 (equivale a pnIdConn <= 0) - preservando a
    * mensagem de cada caso.
    *
    * NAO valida CPros: o legado tambem nao valida (faz apenas Padr(pPro, 10)),
    * e com proposta vazia a consulta simplesmente nao casa nada e a tela abre
    * com a grade vazia. Recusar a abertura aqui divergiria do legado.
    *
    * PUBLIC (sem PROTECTED): alem de ser chamado por THIS. no InicializarForm,
    * eh alcancavel pelo harness de teste automatizado, que chama metodos do
    * form de FORA da classe (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido
        loc_lValido = .T.

        *-- Em modo de teste automatizado nao ha conexao SQL: as guardas do
        *-- legado nao se aplicam (o form precisa instanciar para ser inspecionado)
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        DO CASE
            CASE TYPE("gnConnHandle") != "N"
                MsgErro("O Par" + CHR(226) + "metro de Conex" + CHR(227) + "o Passado N" + ;
                        CHR(227) + "o " + CHR(233) + " Valido...", ;
                        "Par" + CHR(226) + "metros Inv" + CHR(225) + "lidos!!!")
                loc_lValido = .F.

            CASE gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                        "o Com o Servidor de Banco de Dados...", ;
                        "Par" + CHR(226) + "metros Inv" + CHR(225) + "lidos!!!")
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (o legado eh um form unico, sem abas Lista/Dados).
    * Fundo identico ao legado; campos de aprovacao (Comprador/Aprovador/
    * Data/Observacao, ligados a linha corrente da grade) sao adicionados
    * nas proximas fases (5-6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        THIS.ConfigurarGrid()
        THIS.ConfigurarCamposAprovacao()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Cria grd_4c_Dados (equivalente a grdCotacoes do
    * legado), com as 8 colunas EXATAS do SCX (Data/Adquirida/Uni/Valor
    * Adq./Unitario/Total/Codigo/Fornecedor), ligado a cursor_4c_HistPeds
    * (equivalente a crHistPeds). Posicao/tamanho/formatos IDENTICOS ao
    * SCX legado (PILAR 1). Coluna 1 = Data, 2 = QtdAdqs, 3 = CUnis,
    * 4 = ValAdqs, 5 = Units, 6 = Totas, 7 = IClis, 8 = Fornecs.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .Top           = 7
            .Left          = 9
            .Width         = 891
            .Height        = 499
            .HeaderHeight       = 0
            .FontSize      = 8
            .ReadOnly      = .F.
            .RecordMark    = .F.
            .DeleteMark    = .F.
            .RowHeight     = 18
            .ScrollBars    = 2
            .GridLineColor = RGB(128,128,128)
        ENDWITH

        *-- Liga a grade ao cursor e aplica a configuracao das colunas
        THIS.VincularGridDados()

        *-- AfterRowColChange do legado: ao mudar de linha, os campos de
        *-- aprovacao (Comprador/Aprovador/Data/Observacao), que espelham a
        *-- linha corrente do cursor, precisam ser repintados.
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGridDados - Liga grd_4c_Dados a cursor_4c_HistPeds e aplica a
    * configuracao COMPLETA das 8 colunas (ControlSource, Width, Format,
    * Header e DynamicForeColor).
    *
    * Fica separado de ConfigurarGrid porque o BO FECHA e RECRIA o cursor a
    * cada CarregarHistorico(): isso quebra o vinculo do Grid, e reatribuir
    * RecordSource/ControlSource reseta Column.Width e Header1.Caption para
    * os defaults (Problema 48). Toda a configuracao de coluna mora aqui e eh
    * reaplicada em CADA caminho que repopula o cursor.
    *
    * ColumnCount eh reatribuido com o MESMO valor (8) para impedir que o Grid
    * auto-expanda para os 13 campos do cursor; como nenhuma coluna usa
    * AddObject, reatribuir o mesmo valor eh inofensivo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGridDados()
        *-- Cursor placeholder = cursor real (mesma estrutura criada em
        *-- SIGMVCTHBO.CarregarHistorico) - garante que o Grid sempre encontre
        *-- o RecordSource, mesmo se CarregarHistorico falhou antes de criar
        *-- o cursor.
        IF !USED("cursor_4c_HistPeds")
            CREATE CURSOR cursor_4c_HistPeds (Situas N(1), Datas D(8), QtdAdqs N(12,2), ;
                CUnis C(3), ValAdqs N(12,2), Units N(12,2), Totas N(12,2), IClis C(10), ;
                Fornecs C(50), Comprador C(10), Aprovador C(10), DtAprovs D(8), ObsAprovs M(4))
        ENDIF

        WITH THIS.grd_4c_Dados
            .ColumnCount   = 8
            .RecordSource  = "cursor_4c_HistPeds"

            .Column1.ControlSource = "cursor_4c_HistPeds.Datas"
            .Column2.ControlSource = "cursor_4c_HistPeds.QtdAdqs"
            .Column3.ControlSource = "cursor_4c_HistPeds.CUnis"
            .Column4.ControlSource = "cursor_4c_HistPeds.ValAdqs"
            .Column5.ControlSource = "cursor_4c_HistPeds.Units"
            .Column6.ControlSource = "cursor_4c_HistPeds.Totas"
            .Column7.ControlSource = "cursor_4c_HistPeds.IClis"
            .Column8.ControlSource = "cursor_4c_HistPeds.Fornecs"

            *-- Coluna 1: Data
            .Column1.Width             = 75
            .Column1.FontSize          = 8
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.Alignment         = 2
            .Column1.ReadOnly          = .F.
            .Column1.Header1.Caption   = "Data"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.FontSize  = 8
            .Column1.Text1.FontSize    = 8
            .Column1.Text1.Alignment   = 2
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ForeColor   = RGB(0,0,0)

            *-- Coluna 2: Adquirida
            .Column2.Width             = 88
            .Column2.FontSize          = 8
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.Format            = "999,999.99"
            .Column2.InputMask         = "999,999.99"
            .Column2.ReadOnly          = .F.
            .Column2.Header1.Caption   = "Adquirida"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.FontSize  = 8
            .Column2.Text1.FontSize    = 8
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Format      = "999,999.99"
            .Column2.Text1.InputMask   = "999,999.99"
            .Column2.Text1.Margin      = 0
            .Column2.Text1.BackColor   = RGB(255,255,255)

            *-- Coluna 3: Uni
            .Column3.Width             = 35
            .Column3.FontSize          = 8
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.Header1.Caption   = "Uni"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.FontSize  = 8
            .Column3.Text1.FontSize    = 8
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0

            *-- Coluna 4: Valor Adq.
            .Column4.Width             = 87
            .Column4.FontSize          = 8
            .Column4.Movable           = .F.
            .Column4.Resizable         = .F.
            .Column4.Format            = "999,999.99"
            .Column4.InputMask         = "999,999.99"
            .Column4.ReadOnly          = .F.
            .Column4.Header1.Caption   = "Valor Adq."
            .Column4.Header1.Alignment = 2
            .Column4.Header1.FontSize  = 8
            .Column4.Text1.FontSize    = 8
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Format      = "999,999.99"
            .Column4.Text1.InputMask   = "999,999.99"
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ForeColor   = RGB(0,0,0)
            .Column4.Text1.BackColor   = RGB(255,255,255)

            *-- Coluna 5: Unitario
            .Column5.Width             = 87
            .Column5.FontSize          = 8
            .Column5.Movable           = .F.
            .Column5.Resizable         = .F.
            .Column5.Format            = "999,999.99"
            .Column5.InputMask         = "999,999.99"
            .Column5.ReadOnly          = .F.
            .Column5.Header1.Caption   = "Unit" + CHR(225) + "rio"
            .Column5.Header1.Alignment = 2
            .Column5.Header1.FontSize  = 8
            .Column5.Text1.FontSize    = 8
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Format      = "999,999.99"
            .Column5.Text1.InputMask   = "999,999.99"
            .Column5.Text1.Margin      = 0
            .Column5.Text1.ForeColor   = RGB(0,0,0)
            .Column5.Text1.BackColor   = RGB(255,255,255)

            *-- Coluna 6: Total
            .Column6.Width             = 85
            .Column6.FontSize          = 8
            .Column6.Movable           = .F.
            .Column6.Resizable         = .F.
            .Column6.Format            = "999,999.99"
            .Column6.InputMask         = "999,999.99"
            .Column6.ReadOnly          = .F.
            .Column6.Header1.Caption   = "Total"
            .Column6.Header1.Alignment = 2
            .Column6.Header1.FontSize  = 8
            .Column6.Text1.FontSize    = 8
            .Column6.Text1.BorderStyle = 0
            .Column6.Text1.Format      = "999,999.99"
            .Column6.Text1.InputMask   = "999,999.99"
            .Column6.Text1.Margin      = 0
            .Column6.Text1.ReadOnly    = .F.
            .Column6.Text1.ForeColor   = RGB(0,0,0)
            .Column6.Text1.BackColor   = RGB(255,255,255)

            *-- Coluna 7: Codigo (do fornecedor vencedor)
            .Column7.Width             = 90
            .Column7.FontSize          = 8
            .Column7.Movable           = .F.
            .Column7.Resizable         = .F.
            .Column7.ReadOnly          = .F.
            .Column7.Header1.Caption   = "C" + CHR(243) + "digo"
            .Column7.Header1.Alignment = 2
            .Column7.Header1.FontSize  = 8
            .Column7.Text1.FontSize    = 8
            .Column7.Text1.BorderStyle = 0
            .Column7.Text1.Margin      = 0
            .Column7.Text1.ReadOnly    = .F.

            *-- Coluna 8: Fornecedor
            .Column8.Width             = 315
            .Column8.FontSize          = 8
            .Column8.Movable           = .F.
            .Column8.Resizable         = .F.
            .Column8.ReadOnly          = .F.
            .Column8.Header1.Caption   = "Fornecedor"
            .Column8.Header1.Alignment = 2
            .Column8.Header1.FontSize  = 8
            .Column8.Text1.FontSize    = 8
            .Column8.Text1.BorderStyle = 0
            .Column8.Text1.Margin      = 0
            .Column8.Text1.ReadOnly    = .F.

            *-- Destaca em azul as linhas ja aprovadas (Situas > 0), igual ao
            *-- SetAll("DynamicForeColor", ...) do Init do legado
            .SetAll("DynamicForeColor", ;
                "IIF(cursor_4c_HistPeds.Situas > 0, RGB(0,0,255), RGB(0,0,0))", "Column")
        ENDWITH

        *-- Popular cursor nao repinta a grade sozinho - GO TOP + Refresh
        *-- (mesmo padrao do "Select crHistPeds / Go Top / grdCotacoes.Refresh"
        *-- no final do CarregaPedidos legado)
        IF USED("cursor_4c_HistPeds")
            SELECT cursor_4c_HistPeds
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposAprovacao - Cria os labels estaticos, o indicador de
    * legenda (Say10/Say5/Say1/Say2/Shape6/Say12 do legado) e os 3 TextBox +
    * 1 EditBox ligados a cursor_4c_HistPeds (getComprador/getAprovador/
    * getDtAprovs/getObsAprovs) que espelham a linha corrente da grade.
    *
    * ForeColor do legado (224,235,235) eh quase-branco e fica INVISIVEL sobre
    * o fundo claro (new_background.jpg) - todos os labels desta faixa
    * compartilham essa mesma cor quase-branca (sem irma com cor legivel para
    * herdar), entao escurecido para o canonico RGB(90,90,90) (regra #12).
    *
    * Os 4 campos tem PROCEDURE When / RETURN .f. no legado - nunca recebem
    * foco, sao APENAS espelho visual da linha corrente (repintados por
    * BOParaForm/GrdDadosAfterRowColChange). Equivalente aqui eh
    * .Enabled = .F. - BINDEVENT em "When" NAO serviria, porque o retorno do
    * delegate eh DESCARTADO e o .F. nunca bloquearia o foco.
    *
    * Mas .Enabled = .F. e When / RETURN .f. RENDERIZAM DIFERENTE: o When do
    * legado nao esmaece o controle (o campo aparece normal, preto no branco,
    * so nao aceita foco), enquanto o Enabled = .F. do VFP9 pinta com as cores
    * de desabilitado. Por isso os 4 campos declaram DisabledBackColor/
    * DisabledForeColor iguais ao que o legado exibe - o proprio SCX ja faz
    * isso em getObsAprovs (255,255,255 / 0,0,128); os outros tres, que nao
    * declaram cor nenhuma, recebem o padrao que o legado exibiria (branco
    * com texto preto). Sem isso a faixa de aprovacao sairia cinza.
    *
    * Format "K"/"K!" transcritos do SCX (PILAR 1). Sao inertes com o controle
    * desabilitado (K = seleciona o conteudo ao ENTRAR no campo, e esses campos
    * nunca recebem foco), mas ficam registrados para nao se perderem caso o
    * campo volte a ser editavel. ZOrderSet do SCX NAO eh transcrito: eh
    * propriedade so do Form Designer e derruba o Init (regra #33).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposAprovacao()
        *-- Say10 "Comprador"
        THIS.AddObject("lbl_4c_Label10", "Label")
        WITH THIS.lbl_4c_Label10
            .Top       = 516
            .Left      = 9
            .Width     = 74
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Comprador"
        ENDWITH

        *-- Say5 "Aprovador"
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 516
            .Left      = 93
            .Width     = 71
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Aprovador"
        ENDWITH

        *-- Say1 "Data"
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 516
            .Left      = 177
            .Width     = 32
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Data"
        ENDWITH

        *-- Say2 "Observacao"
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 516
            .Left      = 261
            .Width     = 79
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- getComprador (mirror da linha corrente - nunca recebe foco)
        THIS.AddObject("txt_4c_Comprador", "TextBox")
        WITH THIS.txt_4c_Comprador
            .Top               = 532
            .Left              = 9
            .Width             = 80
            .Height            = 20
            .FontName          = "Arial"
            .FontSize          = 8
            .MaxLength         = 10
            .SpecialEffect     = 1
            .BorderColor       = RGB(0,0,128)
            .Format            = "K"
            .Enabled           = .F.
            .DisabledBackColor = RGB(255,255,255)
            .DisabledForeColor = RGB(0,0,0)
            .ControlSource     = "cursor_4c_HistPeds.Comprador"
        ENDWITH

        *-- getAprovador (mirror da linha corrente - nunca recebe foco)
        THIS.AddObject("txt_4c_Aprovador", "TextBox")
        WITH THIS.txt_4c_Aprovador
            .Top               = 532
            .Left              = 93
            .Width             = 80
            .Height            = 20
            .FontName          = "Arial"
            .FontSize          = 8
            .MaxLength         = 10
            .SpecialEffect     = 1
            .BorderColor       = RGB(0,0,128)
            .Format            = "K"
            .Enabled           = .F.
            .DisabledBackColor = RGB(255,255,255)
            .DisabledForeColor = RGB(0,0,0)
            .ControlSource     = "cursor_4c_HistPeds.Aprovador"
        ENDWITH

        *-- getDtAprovs (mirror da linha corrente - nunca recebe foco)
        THIS.AddObject("txt_4c_DtAprovs", "TextBox")
        WITH THIS.txt_4c_DtAprovs
            .Top               = 532
            .Left              = 177
            .Width             = 80
            .Height            = 20
            .FontName          = "Arial"
            .FontSize          = 8
            .MaxLength         = 10
            .SpecialEffect     = 1
            .BorderColor       = RGB(0,0,128)
            .Format            = "K"
            .Enabled           = .F.
            .DisabledBackColor = RGB(255,255,255)
            .DisabledForeColor = RGB(0,0,0)
            .ControlSource     = "cursor_4c_HistPeds.DtAprovs"
        ENDWITH

        *-- getObsAprovs (mirror da linha corrente - nunca recebe foco). SCX
        *-- declara DisabledBackColor/DisabledForeColor explicitos - overrida
        *-- o cinza padrao do VFP9 para Enabled = .F.
        THIS.AddObject("obj_4c_GetObsAprovs", "EditBox")
        WITH THIS.obj_4c_GetObsAprovs
            .Top               = 532
            .Left              = 261
            .Width             = 640
            .Height            = 20
            .FontName          = "Arial"
            .FontSize          = 8
            .SpecialEffect     = 1
            .BorderColor       = RGB(0,0,128)
            .Format            = "K!"
            .Enabled           = .F.
            .DisabledBackColor = RGB(255,255,255)
            .DisabledForeColor = RGB(0,0,128)
            .ControlSource     = "cursor_4c_HistPeds.ObsAprovs"
        ENDWITH

        *-- Shape6 - indicador da legenda (quadrado azul), pareado com Say12
        THIS.AddObject("shp_4c_Shape6", "Shape")
        WITH THIS.shp_4c_Shape6
            .Top           = 562
            .Left          = 9
            .Width         = 19
            .Height        = 19
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .BackColor     = RGB(0,0,255)
            .BorderColor   = RGB(90,90,90)
        ENDWITH

        *-- Say12 "Pedidos Gerados" - legenda do Shape6
        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .Top       = 565
            .Left      = 34
            .Width     = 111
            .Height    = 15
            .AutoSize  = .T.
            .WordWrap  = .F.
            .BackStyle = 0
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Pedidos Gerados"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Cria cmg_4c_Botoes (equivalente a cmdSalva do
    * legado), CommandGroup com UM UNICO botao "Retornar" que fecha o form
    * (ThisForm.Release no legado). O legado NAO tem botoes de Incluir/
    * Alterar/Excluir/Buscar - este form eh um visualizador de historico
    * somente leitura (ver comentario em SIGMVCTHBO.prg).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")

        WITH THIS.cmg_4c_Botoes
            .ButtonCount   = 1
            .Top           = 5
            .Left          = 908
            .Width         = 90
            .Height        = 110
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0

            WITH .Buttons(1)
                .Name          = "cmd_4c_Retornar"
                .Top           = 5
                .Left          = 5
                .Width         = 80
                .Height        = 100
                .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Cancel        = .T.
                .Caption       = "Retornar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .SpecialEffect = 0
                .ForeColor     = RGB(36,84,155)
                .BackColor     = RGB(255,255,255)
                .ToolTipText   = "Sair"
                .Themes        = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Handler do UNICO botao do form (cmg_4c_Botoes.Buttons(1),
    * rotulado "Retornar"). Equivalente a cmdSalva.btnSair.Click do legado, que
    * faz apenas ThisForm.Release.
    *
    * O nome canonico eh BtnCancelarClick (e nao BtnSalvarClick/BtnConfirmarClick)
    * porque esse botao eh literalmente o botao de CANCELAR da tela: o SCX legado
    * declara btnSair.Cancel = .T., entao ESC tambem dispara este Click. O form
    * eh somente leitura - nao ha nada para gravar, e o legado nao tem nenhum
    * botao de acao alem deste (ver comentario em SIGMVCTHBO.prg).
    *
    * PUBLIC porque eh alvo de BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Repassa ao Business Object o filtro que o form recebeu por
    * parametro no Init: a proposta (this_cCPros / pPro do legado) e o codigo do
    * produto corrente (this_nCodigos / pCod), que CarregarHistorico EXCLUI do
    * historico.
    *
    * Equivale ao trecho do Init legado
    *     .CPros   = Padr(pPro, 10)
    *     .Codigos = pCod
    * que guardava o filtro em propriedades do proprio form antes de chamar
    * .CarregaPedidos. Na arquitetura em camadas quem consulta eh o BO, entao o
    * filtro tem de ser empurrado para la.
    *
    * Chamado no InicializarForm E em TODO CarregarLista: como o form eh a fonte
    * unica do filtro, repassa-lo a cada carga impede o BO de consultar com valor
    * desatualizado.
    *
    * Este form NAO grava (somente leitura), entao FormParaBO mapeia o filtro -
    * nao ha campo editavel para mapear.
    *
    * ESCOPO: PROTECTED por HERANCA - FormBase declara PROTECTED PROCEDURE
    * FormParaBO, e em VFP9 a subclasse NAO consegue alargar o escopo do pai
    * (medido em 2026-09-24: redeclarar sem modificador continua estourando
    * "Property FORMPARABO is not found" na chamada externa, enquanto
    * PEMSTATUS(...,5) mente devolvendo .T. - CLAUDE.md regra #3). So eh
    * chamavel por THIS., que eh como InicializarForm e CarregarLista chamam.
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cCPros   = THIS.this_cCPros
            THIS.this_oBusinessObject.this_nCodigos = THIS.this_nCodigos
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Espelha no form a linha CORRENTE do historico.
    *
    * Duas etapas, nesta ordem:
    *   1. Carrega a linha corrente de cursor_4c_HistPeds nas propriedades
    *      this_* do BO (SIGMVCTHBO.CarregarDoCursor) - assim o BO eh a fonte
    *      unica do registro selecionado.
    *   2. Repinta os 4 campos de aprovacao (Comprador/Aprovador/Data/
    *      Observacao - getComprador/getAprovador/getDtAprovs/getObsAprovs no
    *      legado), transcrevendo o AfterRowColChange do grdCotacoes legado:
    *          ThisForm.getComprador.Refresh
    *          ThisForm.getAprovador.Refresh
    *          ThisForm.getDtAprovs.Refresh
    *          ThisForm.getObsAprovs.Refresh
    *
    * Os 4 controles tem .ControlSource apontando para o cursor (igual ao
    * legado), por isso aqui se chama Refresh() e NUNCA se atribui .Value:
    * atribuir .Value em controle com ControlSource escreveria de volta no
    * cursor, alterando o historico exibido.
    *
    * O guard PEMSTATUS mantem o metodo inocuo se ele for chamado antes de
    * ConfigurarCamposAprovacao ter criado os controles.
    *
    * ESCOPO: PROTECTED por HERANCA, pelo mesmo motivo de FormParaBO (FormBase
    * declara PROTECTED PROCEDURE BOParaForm). Chamado por THIS. em
    * CarregarLista e em GrdDadosAfterRowColChange - este ultimo eh o alvo do
    * BINDEVENT e esse sim eh PUBLIC, como a regra #3 exige.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_nI, loc_cNome, loc_oControle, loc_aCampos[4]

        IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
                AND USED(THIS.this_oBusinessObject.this_cCursorDados) ;
                AND !EOF(THIS.this_oBusinessObject.this_cCursorDados)
            THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorDados)
        ENDIF

        loc_aCampos[1] = "txt_4c_Comprador"
        loc_aCampos[2] = "txt_4c_Aprovador"
        loc_aCampos[3] = "txt_4c_DtAprovs"
        loc_aCampos[4] = "obj_4c_GetObsAprovs"

        FOR loc_nI = 1 TO ALEN(loc_aCampos)
            loc_cNome = loc_aCampos[loc_nI]

            IF PEMSTATUS(THIS, loc_cNome, 5)
                *-- Acesso por NOME: EVALUATE devolve a REFERENCIA do controle
                *-- (Controls() eh indexado por numero, nao por nome). O
                *-- Refresh() eh chamado sobre a referencia, nao dentro da
                *-- string - EVALUATE avalia expressao, nao executa comando.
                loc_oControle = EVALUATE("THIS." + loc_cNome)

                IF VARTYPE(loc_oControle) = "O"
                    loc_oControle.Refresh()
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Repopula o historico de cotacoes e repinta a grade.
    * Equivalente ao PROCEDURE CarregaPedidos do form legado (a consulta em si
    * mora no BO, em SIGMVCTHBO.CarregarHistorico).
    *
    * Como o BO fecha e recria cursor_4c_HistPeds, o vinculo do Grid tem de ser
    * REFEITO depois de cada carga (VincularGridDados) - sem isso a grade fica
    * visualmente vazia com o cursor cheio.
    *
    * PUBLIC (sem PROTECTED): eh chamada de fora da classe pelo harness de
    * teste automatizado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- FormParaBO devolve .F. quando o BO nao existe - preserva a
            *-- guarda que antes era VARTYPE(THIS.this_oBusinessObject) = "O"
            IF THIS.FormParaBO()
                loc_lSucesso = THIS.this_oBusinessObject.CarregarHistorico()
            ENDIF

            *-- Refaz o vinculo mesmo quando a carga falha: o cursor pode ter
            *-- sido fechado/recriado antes do erro, e a grade nao pode ficar
            *-- apontando para um alias morto.
            THIS.VincularGridDados()
            THIS.BOParaForm()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Handler de AfterRowColChange de grd_4c_Dados.
    * Transcrito do AfterRowColChange do grdCotacoes legado, que repinta os 4
    * campos de aprovacao ao mudar a linha corrente. Declara par_nColIndex
    * porque o evento passa esse parametro. PUBLIC porque eh alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        THIS.BOParaForm()
    ENDPROC


    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
    * criados via AddObject (que nascem com Visible = .F.).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                loc_oObjeto.Visible = .T.
            ENDIF

            IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oObjeto)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha o cursor de historico antes de delegar a FormBase.Destroy
    * (que faz o restauro do menu principal - DODEFAULT() OBRIGATORIO).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_HistPeds")
            USE IN cursor_4c_HistPeds
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGMVCTHBO.prg):
*====================================================================
* SIGMVCTHBO.prg
*
* Business Object para Historico de Cotacoes (consulta de cotacoes
* anteriores de um produto dentro de uma proposta de compra)
* Tabelas: SigCtTCt (itens de cotacao), SigCtTDc (documento/aprovacao
*          da cotacao), SigCtTFn (fornecedor vencedor por cotacao)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGMVCTHBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para SigCtTCt/SigCtTDc/SigCtTFn)
    this_cCPros       = ""   && cpros char(14) - SigCtTCt - proposta filtrada
    this_nCodigos     = 0    && codigos numeric(6,0) - SigCtTCt - produto atual (excluido do historico)
    this_cCursorDados = ""   && nome do cursor de resultado exibido na grade (equivalente a crHistPeds do legado)

    *-- Propriedades espelhando a linha corrente de THIS.this_cCursorDados
    *-- (mapeadas por CarregarDoCursor - TODAS as colunas de cursor_4c_HistPeds)
    this_nSituas      = 0    && Situas n(1) - situacao da aprovacao (SigCtTDc.situas)
    this_dDatas       = {}   && Datas d(8) - data da cotacao (SigCtTDc.dtcotas)
    this_nQtdAdqs     = 0    && QtdAdqs n(12,2) - quantidade adquirida (SigCtTCt.qtdadqs)
    this_cCUnis       = ""   && CUnis c(3) - unidade (SigCtTCt.cunis)
    this_nValAdqs     = 0    && ValAdqs n(12,2) - valor adquirido (SigCtTCt.valadqs)
    this_nUnits       = 0    && Units n(12,2) - valor unitario da marca vencedora (unit01..unit06)
    this_nTotas       = 0    && Totas n(12,2) - valor total da marca vencedora (tota01..tota06)
    this_cIClis       = ""   && IClis c(10) - codigo do fornecedor vencedor (SigCtTFn.iclis)
    this_cFornecs     = ""   && Fornecs c(50) - nome do fornecedor vencedor (SigCtTFn.fornecs)
    this_cComprador   = ""   && Comprador c(10) - comprador responsavel (SigCtTDc.comprador)
    this_cAprovador   = ""   && Aprovador c(10) - aprovador responsavel (SigCtTDc.aprovador)
    this_dDtAprovs    = {}   && DtAprovs d(8) - data da aprovacao (SigCtTDc.dtaprovs)
    this_cObsAprovs   = ""   && ObsAprovs m(4) - observacao da aprovacao (SigCtTDc.obsaprovs)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela      = "SigCtTCt"
            THIS.this_cCampoChave  = "cidchaves"
            THIS.this_cCPros       = ""
            THIS.this_nCodigos     = 0
            THIS.this_cCursorDados = "cursor_4c_HistPeds"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarHistorico - Busca o historico de cotacoes do produto dentro
    * da proposta filtrada (THIS.this_cCPros / THIS.this_nCodigos).
    *
    * Porta o metodo "CarregaPedidos" do legado: para cada linha de
    * SigCtTCt (itens cotados) casada com SigCtTDc (documento/aprovacao),
    * resolve qual das 6 marcas (Marca01..Marca06) foi a vencedora e busca
    * o fornecedor correspondente em SigCtTFn (chave Codigos+Grades).
    *
    * Popula THIS.this_cCursorDados (cursor_4c_HistPeds), com a MESMA
    * estrutura de campos que o Load() do legado criava para crHistPeds.
    *====================================================================
    PROCEDURE CarregarHistorico()
        LOCAL loc_cSQL, loc_cSQLFn, loc_nResultado, loc_nResultadoFn
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cLetra, loc_nUnit, loc_nTotal
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorDados) (Situas N(1), Datas D(8), QtdAdqs N(12,2), ;
                CUnis C(3), ValAdqs N(12,2), Units N(12,2), Totas N(12,2), IClis C(10), ;
                Fornecs C(50), Comprador C(10), Aprovador C(10), DtAprovs D(8), ObsAprovs M(4))

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Modo de validacao de UI (sem conexao SQL) - cursor fica vazio e o form abre normalmente
                loc_lSucesso = .T.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cCPros))
                    MostrarErro("Proposta n" + CHR(227) + "o informada.", "SIGMVCTHBO.CarregarHistorico")
                    loc_lProsseguir = .F.
                ENDIF

                IF loc_lProsseguir
                    loc_cSQL = "SELECT a.Codigos, b.DtCotas AS Datas, b.Situas, a.QtdAdqs, a.CUnis, a.ValAdqs, " + ;
                        "a.Marca01, a.Unit01, a.Tota01, a.Marca02, a.Unit02, a.Tota02, " + ;
                        "a.Marca03, a.Unit03, a.Tota03, a.Marca04, a.Unit04, a.Tota04, " + ;
                        "a.Marca05, a.Unit05, a.Tota05, a.Marca06, a.Unit06, a.Tota06, " + ;
                        "b.Comprador, b.Aprovador, b.DtAprovs, b.ObsAprovs " + ;
                        "FROM SigCtTCt a, SigCtTDc b " + ;
                        "WHERE a.CPros = " + EscaparSQL(THIS.this_cCPros) + " " + ;
                        "AND a.Codigos <> " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + " " + ;
                        "AND a.Codigos = b.Codigos " + ;
                        "ORDER BY b.DtCotas DESC, a.Codigos ASC"

                    IF USED("cursor_4c_HistPedsCt")
                        USE IN cursor_4c_HistPedsCt
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistPedsCt")

                    IF loc_nResultado < 0
                        MostrarErro("Falha ao carregar hist" + CHR(243) + "rico de cota" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF

                IF loc_lProsseguir
                    SELECT cursor_4c_HistPedsCt
                    SCAN
                        loc_cLetra = " "
                        loc_nUnit  = 0
                        loc_nTotal = 0

                        DO CASE
                            CASE cursor_4c_HistPedsCt.Marca01
                                loc_cLetra = "A"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit01
                                loc_nTotal = cursor_4c_HistPedsCt.Tota01
                            CASE cursor_4c_HistPedsCt.Marca02
                                loc_cLetra = "B"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit02
                                loc_nTotal = cursor_4c_HistPedsCt.Tota02
                            CASE cursor_4c_HistPedsCt.Marca03
                                loc_cLetra = "C"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit03
                                loc_nTotal = cursor_4c_HistPedsCt.Tota03
                            CASE cursor_4c_HistPedsCt.Marca04
                                loc_cLetra = "D"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit04
                                loc_nTotal = cursor_4c_HistPedsCt.Tota04
                            CASE cursor_4c_HistPedsCt.Marca05
                                loc_cLetra = "E"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit05
                                loc_nTotal = cursor_4c_HistPedsCt.Tota05
                            CASE cursor_4c_HistPedsCt.Marca06
                                loc_cLetra = "F"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit06
                                loc_nTotal = cursor_4c_HistPedsCt.Tota06
                        ENDCASE

                        IF !EMPTY(loc_cLetra)
                            INSERT INTO (THIS.this_cCursorDados) ;
                                (Situas, Datas, QtdAdqs, CUnis, ValAdqs, Comprador, Aprovador, DtAprovs, ObsAprovs, Units, Totas) ;
                                VALUES ( ;
                                    cursor_4c_HistPedsCt.Situas, ;
                                    ConverterParaData(cursor_4c_HistPedsCt.Datas), ;
                                    cursor_4c_HistPedsCt.QtdAdqs, ;
                                    cursor_4c_HistPedsCt.CUnis, ;
                                    cursor_4c_HistPedsCt.ValAdqs, ;
                                    cursor_4c_HistPedsCt.Comprador, ;
                                    cursor_4c_HistPedsCt.Aprovador, ;
                                    ConverterParaData(cursor_4c_HistPedsCt.DtAprovs), ;
                                    TratarNulo(cursor_4c_HistPedsCt.ObsAprovs, ""), ;
                                    loc_nUnit, ;
                                    loc_nTotal)

                            loc_cSQLFn = "SELECT a.IClis, a.Fornecs FROM SigCtTFn a " + ;
                                "WHERE a.Codigos = " + FormatarNumeroSQL(cursor_4c_HistPedsCt.Codigos, 0) + " " + ;
                                "AND a.Grades = " + EscaparSQL(loc_cLetra)

                            IF USED("cursor_4c_HistPedsFn")
                                USE IN cursor_4c_HistPedsFn
                            ENDIF
                            loc_nResultadoFn = SQLEXEC(gnConnHandle, loc_cSQLFn, "cursor_4c_HistPedsFn")

                            IF loc_nResultadoFn < 0
                                MostrarErro("Falha ao carregar fornecedor vencedor da cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lProsseguir = .F.
                            ELSE
                                IF RECCOUNT("cursor_4c_HistPedsFn") > 0
                                    SELECT (THIS.this_cCursorDados)
                                    GO BOTTOM
                                    REPLACE IClis   WITH cursor_4c_HistPedsFn.IClis, ;
                                            Fornecs WITH cursor_4c_HistPedsFn.Fornecs
                                ENDIF
                                IF USED("cursor_4c_HistPedsFn")
                                    USE IN cursor_4c_HistPedsFn
                                ENDIF
                            ENDIF
                        ENDIF

                        IF !loc_lProsseguir
                            EXIT
                        ENDIF

                        SELECT cursor_4c_HistPedsCt
                    ENDSCAN

                    IF USED("cursor_4c_HistPedsCt")
                        USE IN cursor_4c_HistPedsCt
                    ENDIF
                    IF USED("cursor_4c_HistPedsFn")
                        USE IN cursor_4c_HistPedsFn
                    ENDIF
                ENDIF

                loc_lSucesso = loc_lProsseguir
            ENDIF

            IF loc_lSucesso AND USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.CarregarHistorico")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia a linha CORRENTE de par_cAliasCursor
    * (tipicamente THIS.this_cCursorDados, a linha selecionada na grade)
    * para as propriedades this_* do Business Object.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nSituas    = TratarNulo(Situas, 0)
                THIS.this_dDatas     = ConverterParaData(TratarNulo(Datas, {}))
                THIS.this_nQtdAdqs   = TratarNulo(QtdAdqs, 0)
                THIS.this_cCUnis     = TratarNulo(CUnis, "")
                THIS.this_nValAdqs   = TratarNulo(ValAdqs, 0)
                THIS.this_nUnits     = TratarNulo(Units, 0)
                THIS.this_nTotas     = TratarNulo(Totas, 0)
                THIS.this_cIClis     = TratarNulo(IClis, "")
                THIS.this_cFornecs   = TratarNulo(Fornecs, "")
                THIS.this_cComprador = TratarNulo(Comprador, "")
                THIS.this_cAprovador = TratarNulo(Aprovador, "")
                THIS.this_dDtAprovs  = ConverterParaData(TratarNulo(DtAprovs, {}))
                THIS.this_cObsAprovs = TratarNulo(ObsAprovs, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir/Atualizar/ExecutarExclusao/ObterChavePrimaria/RegistrarAuditoria
    * NAO sao sobrescritos propositalmente: o formulario legado
    * (SIGMVCTH.SCX) e um visualizador de historico SOMENTE LEITURA - as
    * tres consultas acima (SELECT em SigCtTCt/SigCtTDc/SigCtTFn) sao TODO
    * o SQL que ele executa. O unico botao (cmdSalva.btnSair, rotulado
    * "Retornar") apenas fecha a tela (ThisForm.Release) - nao ha
    * INSERT/UPDATE/DELETE no legado para portar. THIS.Salvar()/Excluir()
    * (BusinessBase) nunca sao chamados por este form; os defaults da
    * classe base (retornam .F. com mensagem de metodo nao implementado)
    * ja refletem esse comportamento com fidelidade.
    *====================================================================

ENDDEFINE

