# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigmvits.prg] Indicador de pendencia: *   cmd_4c_Bot_Pendente
[Formsigmvits.prg] Indicador de pendencia: * Header="Valor". Bot_Pendente
[Formsigmvits.prg] Indicador de pendencia: *-- legado, Cnt_Pendencia.Bot_Pendente
[Formsigmvits.prg] Indicador de pendencia: * HaPagamentoPendente
[Formsigmvits.prg] Indicador de pendencia: * [F3]Pend. (cnt_4c__Pendencia.cmd_4c_Bot_Pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvits.prg):
*==============================================================================*
* Formsigmvits.prg - Formulario Operacional: Caixa (Frente de Loja / PDV)
*==============================================================================*
* Tipo: OPERACIONAL (layout customizado, containers flutuantes, multiplos grids)
* Migrado de: SIGMVITS.SCX
*
* Pilares:
*   UX   -> layout e comportamento o mais proximo possivel do legado (1280x750)
*   BD   -> SigMvCab/SigMvItn/SigOpFp/SigCdCli/SigCdOpe (ver sigmvitsBO.prg)
*   CODE -> arquitetura em camadas (FormBase / sigmvitsBO)
*
* FASE 3/8 - Estrutura Base: DEFINE CLASS, Init/InicializarForm/Destroy e os
* containers principais do layout legado, ainda VAZIOS (sem grids, campos
* ou botoes - essas pecas entram nas Fases 4 a 8). Nao ha PageFrame: o
* SIGMVITS legado NAO usa o padrao CRUD Page1(Lista)/Page2(Dados) - e um
* form OPERACIONAL de layout unico, com containers posicionados livremente
* (ver docs\FRAMEWORK_class_codigo_fonte.txt e tasks\task572\layout.json).
*
* FASE 4/8 - GRADES + BOTOES DE ACAO DAS GRADES + BARRA DE BOTOES PRINCIPAL.
* SIGMVITS.SCX e uma tela de Caixa (frente de venda), nao um cadastro: NAO
* tem Page1=Lista/Page2=Dados nem os 6 botoes CRUD canonicos (Incluir/
* Visualizar/Alterar/Excluir/Buscar/Encerrar), e nao tem grid de LISTAGEM de
* registros para o usuario selecionar. Inventar esses 6 botoes ou uma pagina
* de Lista violaria o PILAR 1 e a regra "NUNCA inventar funcionalidade que o
* legado nao tem" (mesma decisao ja tomada em FormSigMvExp.prg/Formsigmvitn.prg
* - form irmao migrado da mesma familia SIGMV*, com o MESMO Cnt_Pendencia.
* GradeMultiSubN). O que esta fase adiciona, fiel ao dump (layout.json/
* mapeamento.json/sigmvits_form_codigo_fonte_slim.txt):
*
*   AS TRES GRADES do legado e o seu bind:
*     grd_4c_SubNiveis  (Cnt_Pendencia.GradeMultiSubN) -> TmpOperacao
*     grd_4c_Cupom      (CntGrade.GrdCupom)            -> crTpmMvItnC
*     grd_4c_FormasPag  (GrdFP, filha direta do form, oculta/Enabled=.F.
*                        no legado - RecordSource "xParC" e populada por
*                        SQL dinamico dentro do Confirmar (Barra_Botoes.ok);
*                        a estrutura e criada aqui, o bind fica para a fase
*                        de eventos, quando o cursor realmente existir -
*                        CLAUDE.md #41)
*   Junto vao os botoes que o legado cola nas grades: cmd_4c_Proximo e
*   cmd_4c_Bot_Pendentes (Cnt_Pendencia), e os totais Cnt_subt/Get_Total e
*   cnt_tots/Get_total que ficam colados embaixo do GrdCupom.
*
*   OS CURSORES (CriarCursoresGrades): TmpOperacao e crTpmMvItnC nascem aqui,
*   com a estrutura transcrita do uso real no dump (comportamento.json) e da
*   mesma estrutura ja usada no form irmao Formsigmvitn.prg (identico
*   Cnt_Pendencia.GradeMultiSubN).
*
*   A BARRA DE BOTOES PRINCIPAL (cnt_4c_Barra_Botoes, criada vazia na Fase 3)
*   recebe aqui os 16 CommandButtons do legado (ConfigurarBotoesBarraPrincipal),
*   com Picture/Caption/posicao EXATOS do dump. Varios pares ocupam o MESMO
*   Left (Desconto/Acrescimo em Left=5,Top=45; CancPagto/apaga em Left=97,
*   Top=6; Financia/pendencia em Left=189,Top=6) porque a barra alterna qual
*   conjunto fica visivel conforme o estado da venda - a alternancia de
*   .Visible e os Click ficam para as Fases 7-8.
*
*   TextBoxes/ComboBox de dados (Fases 5-6) e eventos/handlers de Click/
*   KeyPress (Fases 7-8) NAO sao incluidos aqui.
*
* FASE 6/8 - CAMPOS RESTANTES (Cnt_Fpagto/Cnt_Identifica) + LOOKUPS.
* Completa os campos de dados que faltavam (segunda metade, apos a Fase 5):
*
*   cnt_4c__Fpagto (ConfigurarCamposPagamento): Desconto/Acrescimo da
*   venda, bloco Observacao, os 5 totalizadores (Total/Pagamentos/A Pagar/
*   Saldo Final/Desconto Promocional), cnt_forma (forma de pagamento/
*   parcelas/valor/vencimento - com LOOKUP de forma de pagamento) e os dois
*   paineis flutuantes ocultos Cnt_ChequepreTef (dados do cheque/TEF) e
*   cntnsu (NSU/Autorizacao/Adquirente - com LOOKUP de adquirente).
*
*   cnt_4c__Identifica (ConfigurarCamposIdentificacao + o factory
*   MontarBlocoIdentificacao): os 4 blocos IDENTICOS de identificacao de
*   conta (Destino/Responsavel/Vendedor/Origem - Grupo/Conta/Nome/CPF, cada
*   um com LOOKUP de grupo, conta e conta-por-CPF), Tab.Desconto/Lista de
*   Precos (com LOOKUP) e o bloco CodOperacao (Documento/Pedido Cliente).
*
*   LOOKUPS implementados (FormBuscaAuxiliar, contrato this_lAchouRegistro/
*   this_lSelecionou - CLAUDE.md #37): Forma de Pagamento (SigOpFp),
*   Adquirente (SigCdCad tipocads='ADQUIRENTE'), Tabela de Desconto
*   (SigOpTdz), Lista de Precos (SigCdLpc), Grupo de Contas (SigCdGrp),
*   Conta (SigCdCli por Iclis) e Conta por CPF/CNPJ (SigCdCli por Cpfs) -
*   os tres ultimos parametrizados por bloco (Destino/Responsavel/Vendedor/
*   Origem) via AbrirLookupGrupo/AbrirLookupConta/AbrirLookupContaPorCpf.
*
* CHAMADA:
*   loForm = CREATEOBJECT("Formsigmvits")
*   loForm.Show()
*==============================================================================*

DEFINE CLASS Formsigmvits AS FormBase

    *-- Dimensoes e comportamento identicos ao legado (SIGMVITS.SCX)
    Height       = 750
    Width        = 1280
    BorderStyle  = 0
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    KeyPreview   = .T.
    ShowTips     = .T.
    DataSession  = 2

    *-- Estado operacional do Caixa (equivalente as properties/PUBLIC do legado)
    this_cOpEscolha = ""   && Op_Escolha: "INSERIR"/"ALTERAR"/"CANCELAR" - modo atual do cupom
    this_nCItem     = 0    && CItem: numero sequencial do proximo item do cupom
    this_lIniciou   = .F.  && Inicia: indica se o cupom fiscal ja foi iniciado

    *-- FASE 7: estado consumido pelos eventos dos botoes. Cada property
    *-- corresponde a uma do form legado (nome entre parenteses) e e DECLARADA
    *-- aqui porque LEITURA de property nao declarada estoura "Property ... is
    *-- not found" na primeira vez, antes de qualquer atribuicao.
    this_cTelaAtual     = "ITENS"  && qual container de operacao esta visivel
    this_lValidaDesconto = .F.     && Validadesconto: desconto/acrescimo em edicao
    this_lAlteraQtd      = .F.     && lAlteraqtd: usuario pediu alteracao de quantidade
    this_lAlteraValor    = .F.     && lAlteraValor: usuario pediu alteracao de preco
    this_lCancelouItem   = .F.     && CancelouItem: houve cancelamento de item no cupom
    this_nUltimoCancel   = 0       && UltimoCancel: maior numero de item cancelado
    this_lEditaOrigem    = .F.     && EditaOrigem: bloco Origem liberado para edicao
    this_lEditaDestino   = .F.     && EditaDestino: bloco Destino liberado para edicao
    this_lLiberaIdent    = .F.     && LiberaIdent: identificacao liberada fora do fluxo
    this_nTotIte         = 0       && TotIte: total dos itens do cupom
    this_lLibTroco       = .F.     && Libtroco: troco liberado nesta operacao
    this_nBcds           = 0       && Bcds: bonus/credito acumulado nas parcelas

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("sigmvitsBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Falha ao criar sigmvitsBO", "Erro")
        ELSE
            *-- Toda vez que o Caixa abre, o cupom que esta sendo montado e
            *-- NOVO (nao ha tela de Buscar/Alterar aqui - regra #20 do
            *-- CLAUDE.md: sem isto this_lEmEdicao fica .F. e Salvar() falha
            *-- calado no primeiro IF).
            THIS.this_oBusinessObject.NovoRegistro()

            THIS.Caption   = "Caixa"
            THIS.BackColor = RGB(255, 255, 255)

            *-- DataSession = 2 da ao form uma datasession PRIVADA com os SETs
            *-- no DEFAULT do VFP, e o default de DELETED e OFF (mesma familia
            *-- da regra #9.4 do CLAUDE.md, que trata de SET DATE/CENTURY). O
            *-- legado rodava na datasession compartilhada, onde o config.prg
            *-- ja deixou SET DELETED ON - sem isto, o item cancelado (DELETE
            *-- em crTpmMvItn) continuaria aparecendo na grade do cupom e
            *-- entrando nos totais.
            SET DELETED ON

            *-- Os cursores das grades nascem ANTES dos controles: assim o
            *-- MontaGrade, mais abaixo, encontra os alias prontos. Ligar
            *-- Column.ControlSource a cursor inexistente derruba o Init
            *-- (CLAUDE.md #41).
            THIS.CriarCursoresGrades()

            THIS.ConfigurarContainerPrincipal()

            *-- Bind das grades (RecordSource/ControlSource/Width/cabecalhos).
            *-- Separado da criacao dos controles porque RecordSource reseta
            *-- Width, Header1.Caption, CurrentControl e Sparse - tudo isso
            *-- precisa vir DEPOIS dele (Problema 48 / CLAUDE.md #41).
            THIS.MontaGrade()

            *-- FASE 7: liga os Click/Timer. Vai DEPOIS de todo AddObject -
            *-- BINDEVENT contra objeto que ainda nao existe estoura no Init.
            THIS.RegistrarEventosPrincipais()

            *-- FASE 7: estado inicial da tela. O legado faz isso no proprio
            *-- Init ("Cnt_identifica.Visible = .f. / Cnt_pendencia.Visible =
            *-- .f. / Cnt_Fpagto.Visible = .f. / grdFP.Visible = .f."), deixando
            *-- so a tela de ITENS a mostra; sem esta chamada os quatro
            *-- containers de operacao, criados Visible = .T. nas Fases 3-6,
            *-- abrem empilhados na mesma area.
            THIS.AlternarTelaOperacao("ITENS")
            THIS.RecalcularTotais()

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerPrincipal
    *==========================================================================
    * Orquestra a criacao de TODOS os containers de topo do form, na mesma
    * ordem do dump do SCX legado (SECAO 1/2 de
    * tasks\task572\sigmvits_form_codigo_fonte_slim.txt). Cada container
    * nasce VAZIO nesta fase - os filhos (grids/campos/botoes) sao
    * adicionados nas Fases 4 a 8.
    *
    * O legado tem 14 objetos de topo; 13 sao criados aqui (12 na Fase 3 +
    * GrdFP na Fase 4). O 1 restante NAO esta esquecido - e peca de fase
    * posterior, registrado aqui para nao se perder silenciosamente:
    *   - READCOMM (Class readcomm de framework.vcx, container com OLE MSComm)
    *              -> leitora serial de cheque (ThisForm.ReadComm.leitura()).
    *              Depende de SET CLASSLIB do VCX legado e so faz sentido com
    *              os eventos do Cnt_ChequepreTef; entra nas FASES 7/8.
    *==========================================================================
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarAreaItem()
        THIS.ConfigurarCamposAreaItem()
        THIS.ConfigurarGrdFormasPagamento()
        THIS.ConfigurarAreaPendencia()
        THIS.ConfigurarGradeSubNiveis()
        THIS.ConfigurarAreaCancelamento()
        THIS.ConfigurarCamposCancelamento()
        THIS.ConfigurarAreaPagamento()
        THIS.ConfigurarCamposPagamento()
        THIS.ConfigurarAreaIdentificacao()
        THIS.ConfigurarCamposIdentificacao()
        THIS.ConfigurarBarraBotoes()
        THIS.ConfigurarBotoesBarraPrincipal()
        THIS.ConfigurarGradeCupom()
        THIS.ConfigurarGridCupomInterno()
        THIS.ConfigurarAreaMensagens()
        THIS.ConfigurarTimer()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
    * cnt_4c__Img4c (logo) + lbl_4c_TxtCaption (barra de titulo) +
    * cnt_4c__Mensagem (barra de mensagem/rodape) - mapeamento.json:
    * Cnt_Img4c / TxtCaption / Cnt_Mensagem
    *==========================================================================
        THIS.AddObject("cnt_4c__Img4c", "Container")
        WITH THIS.cnt_4c__Img4c
            .Top           = 28
            .Left          = 4
            .Width         = 291
            .Height        = 101
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .ForeColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_TxtCaption", "Label")
        WITH THIS.lbl_4c_TxtCaption
            .Top       = 0
            .Left      = -1
            .Width     = 1300
            .Height    = 19
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 1
            .ForeColor = RGB(255, 255, 255)
            .BackColor = RGB(90, 90, 90)
            .Caption   = "  Caixa"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("cnt_4c__Mensagem", "Container")
        WITH THIS.cnt_4c__Mensagem
            .Top           = 684
            .Left          = 97
            .Width         = 1004
            .Height        = 26
            .BackStyle     = 1
            .BorderWidth   = 0
            .SpecialEffect = 2
            .ForeColor     = RGB(255, 255, 255)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Os dois labels de cnt_4c__Mensagem - mapeamento.json:
        *-- Cnt_Mensagem.Mensagem / Cnt_Mensagem.Abertura. Nascem na FASE 7
        *-- porque e aqui que passam a ser escritos (Itens/Pagto.Click do
        *-- legado: "Cnt_mensagem.Mensagem.Caption = ' '" e
        *-- "Cnt_Mensagem.abertura.Caption = Substr(Ttoc(DataAbertura),12,5)").
        *-- O Caption de projeto no dump e vazio: o legado o preenche em
        *-- runtime.
        THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Mensagem", "Label")
        WITH THIS.cnt_4c__Mensagem.lbl_4c_Mensagem
            .Top       = 2
            .Left      = 3
            .Width     = 2
            .Height    = 18
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 10
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Abertura", "Label")
        WITH THIS.cnt_4c__Mensagem.lbl_4c_Abertura
            .Top       = 3
            .Left      = 317
            .Width     = 55
            .Height    = 19
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 10
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaItem
    *==========================================================================
    * cnt_4c_Item - area de digitacao/exibicao do item corrente (produto,
    * quantidade, valores) - mapeamento.json: cntItem
    *==========================================================================
        THIS.AddObject("cnt_4c_Item", "Container")
        WITH THIS.cnt_4c_Item
            .Top           = 140
            .Left          = 65
            .Width         = 1003
            .Height        = 499
            .BackStyle = 1
            .BorderWidth   = 0
            .SpecialEffect = 2
            .ForeColor     = RGB(255, 255, 255)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposAreaItem
    *==========================================================================
    * Sub-containers e campos de cnt_4c_Item (container ja criado em
    * ConfigurarAreaItem): o bloco de digitacao/exibicao do item corrente
    * (produto, quantidade, valor unitario, descontos/acrescimos e as duas
    * imagens flutuantes de produto/empresa) - mapeamento.json: filhos de
    * cntItem (Cnt_Prod, Cnt_Qtd, cnt_val, Cnt_ValU, Cnt_pDesc, Cnt_vdesc,
    * Cnt_pacre, Cnt_vacre, Cnt_imgProd, Cnt_ImgEmp, Proximo).
    *
    * FASE 5/8 - primeira metade dos campos principais do form.
    *==========================================================================
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        *-- Cnt_Prod: codigo do produto (Get_Produto) + botao de confirmacao
        *-- manual (cmdenviaprod, oculto por padrao - so aparece quando o
        *-- legado precisa que o operador confirme o produto digitado).
        THIS.cnt_4c_Item.AddObject("cnt_4c__Prod", "Container")
        WITH THIS.cnt_4c_Item.cnt_4c__Prod
            .Top           = 37
            .Left          = 797
            .Width         = 200
            .Height        = 50
            .BackStyle = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__Prod.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c_Item.cnt_4c__Prod.lbl_4c_Label2
            .Top       = 1
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "C" + CHR(243) + "digo"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__Prod.AddObject("txt_4c_Produto", "TextBox")
        WITH THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto
            .Top               = 15
            .Left              = 11
            .Width             = 178
            .Height            = 30
            .FontBold          = .T.
            .FontName          = "Tahoma"
            .FontSize          = 15
            .Alignment         = 2
            .BorderStyle       = 1
            .SpecialEffect     = 1
            .Format            = "K!"
            .InputMask         = "!!!!!!!!!!!!!!"
            .Value             = ""
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(128, 128, 128)
            .Visible           = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__Prod.AddObject("cmd_4c_Cmdenviaprod", "CommandButton")
        WITH THIS.cnt_4c_Item.cnt_4c__Prod.cmd_4c_Cmdenviaprod
            .Top             = 16
            .Left            = 42
            .Width           = 104
            .Height          = 29
            .FontBold        = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = loc_cIcones + "B_PRINT2.BMP"
            .Caption         = "\<Confirmar"
            .ToolTipText     = "Confirma o Produto Informado"
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .F.
        ENDWITH

        *-- cnt_val: valor unitario do item (Get_valor).
        THIS.cnt_4c_Item.AddObject("cnt_4c__val", "Container")
        WITH THIS.cnt_4c_Item.cnt_4c__val
            .Top           = 402
            .Left          = 797
            .Width         = 200
            .Height        = 50
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__val.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.cnt_4c_Item.cnt_4c__val.lbl_4c_Label4
            .Top       = 1
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Valor Unit" + CHR(225) + "rio"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__val.AddObject("txt_4c_Valor", "TextBox")
        WITH THIS.cnt_4c_Item.cnt_4c__val.txt_4c_Valor
            .Top           = 15
            .Left          = 11
            .Width         = 178
            .Height        = 30
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 15
            .Alignment     = 2
            .BorderStyle   = 1
            .SpecialEffect = 1
            .InputMask     = "9,999,999.99"
            .Value         = 0
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_Qtd: quantidade do item (Get_Qtds).
        THIS.cnt_4c_Item.AddObject("cnt_4c__Qtd", "Container")
        WITH THIS.cnt_4c_Item.cnt_4c__Qtd
            .Top           = 89
            .Left          = 797
            .Width         = 200
            .Height        = 50
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__Qtd.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.cnt_4c_Item.cnt_4c__Qtd.lbl_4c_Label3
            .Top       = 1
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Quantidade"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__Qtd.AddObject("txt_4c_Qtds", "TextBox")
        WITH THIS.cnt_4c_Item.cnt_4c__Qtd.txt_4c_Qtds
            .Top           = 15
            .Left          = 11
            .Width         = 178
            .Height        = 30
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 15
            .Alignment     = 2
            .BorderStyle   = 1
            .SpecialEffect = 1
            .InputMask     = "999.999"
            .Value         = 0
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_ValU: valor original do produto, antes de desconto/acrescimo
        *-- (Get_unival).
        THIS.cnt_4c_Item.AddObject("cnt_4c__ValU", "Container")
        WITH THIS.cnt_4c_Item.cnt_4c__ValU
            .Top           = 141
            .Left          = 797
            .Width         = 200
            .Height        = 50
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__ValU.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.cnt_4c_Item.cnt_4c__ValU.lbl_4c_Label4
            .Top       = 1
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Valor Original"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__ValU.AddObject("txt_4c_Unival", "TextBox")
        WITH THIS.cnt_4c_Item.cnt_4c__ValU.txt_4c_Unival
            .Top           = 15
            .Left          = 11
            .Width         = 178
            .Height        = 30
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 15
            .Alignment     = 2
            .BorderStyle   = 1
            .SpecialEffect = 1
            .InputMask     = "9,999,999.99"
            .Value         = 0
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_pDesc: percentual de desconto (Get_pvaldesc).
        THIS.cnt_4c_Item.AddObject("cnt_4c__pDesc", "Container")
        WITH THIS.cnt_4c_Item.cnt_4c__pDesc
            .Top           = 193
            .Left          = 797
            .Width         = 200
            .Height        = 50
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__pDesc.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.cnt_4c_Item.cnt_4c__pDesc.lbl_4c_Label5
            .Top       = 1
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Desconto (%)"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__pDesc.AddObject("txt_4c_Pvaldesc", "TextBox")
        WITH THIS.cnt_4c_Item.cnt_4c__pDesc.txt_4c_Pvaldesc
            .Top           = 15
            .Left          = 11
            .Width         = 178
            .Height        = 30
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 15
            .Alignment     = 2
            .BorderStyle   = 1
            .SpecialEffect = 1
            .InputMask     = "99.99"
            .Value         = 0
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_vdesc: desconto em valor (Get_valdesc).
        THIS.cnt_4c_Item.AddObject("cnt_4c__vdesc", "Container")
        WITH THIS.cnt_4c_Item.cnt_4c__vdesc
            .Top           = 245
            .Left          = 797
            .Width         = 200
            .Height        = 50
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__vdesc.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.cnt_4c_Item.cnt_4c__vdesc.lbl_4c_Label6
            .Top       = 1
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Desconto ($)"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__vdesc.AddObject("txt_4c_Valdesc", "TextBox")
        WITH THIS.cnt_4c_Item.cnt_4c__vdesc.txt_4c_Valdesc
            .Top           = 15
            .Left          = 11
            .Width         = 178
            .Height        = 30
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 15
            .Alignment     = 2
            .BorderStyle   = 1
            .SpecialEffect = 1
            .InputMask     = "999,999.99"
            .Value         = 0
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_pacre: percentual de acrescimo (get_pValAcre).
        THIS.cnt_4c_Item.AddObject("cnt_4c__pacre", "Container")
        WITH THIS.cnt_4c_Item.cnt_4c__pacre
            .Top           = 297
            .Left          = 797
            .Width         = 200
            .Height        = 50
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__pacre.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c_Item.cnt_4c__pacre.lbl_4c_Label1
            .Top       = 1
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Acr" + CHR(233) + "scimo (%)"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__pacre.AddObject("txt_4c__pValAcre", "TextBox")
        WITH THIS.cnt_4c_Item.cnt_4c__pacre.txt_4c__pValAcre
            .Top           = 15
            .Left          = 11
            .Width         = 178
            .Height        = 30
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 15
            .Alignment     = 2
            .BorderStyle   = 1
            .SpecialEffect = 1
            .InputMask     = "99.99"
            .Value         = 0
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_vacre: acrescimo em valor (Get_ValAcre).
        THIS.cnt_4c_Item.AddObject("cnt_4c__vacre", "Container")
        WITH THIS.cnt_4c_Item.cnt_4c__vacre
            .Top           = 349
            .Left          = 797
            .Width         = 200
            .Height        = 50
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__vacre.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.cnt_4c_Item.cnt_4c__vacre.lbl_4c_Label7
            .Top       = 1
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Acr" + CHR(233) + "scimo ($)"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__vacre.AddObject("txt_4c_ValAcre", "TextBox")
        WITH THIS.cnt_4c_Item.cnt_4c__vacre.txt_4c_ValAcre
            .Top           = 15
            .Left          = 11
            .Width         = 178
            .Height        = 30
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 15
            .Alignment     = 2
            .BorderStyle   = 1
            .SpecialEffect = 1
            .InputMask     = "999,999.99"
            .Value         = 0
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_imgProd / Cnt_ImgEmp: fotos flutuantes do produto e da
        *-- empresa. .Picture NAO e literal fixo - no legado (FigJpg.Picture
        *-- = "c:\fortyus\") o caminho ja e composto em runtime a partir do
        *-- codigo do produto/empresa corrente; aqui os Image nascem sem
        *-- Picture e ocultos, como no dump (Visible=.F.), e serao
        *-- preenchidos pelo metodo que carrega o item (fases de evento).
        THIS.cnt_4c_Item.AddObject("cnt_4c__imgProd", "Container")
        WITH THIS.cnt_4c_Item.cnt_4c__imgProd
            .Top           = 38
            .Left          = 9
            .Width         = 336
            .Height        = 220
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .ForeColor     = RGB(255, 255, 255)
            .BackColor     = RGB(126, 211, 226)
            .BorderColor   = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__imgProd.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.cnt_4c_Item.cnt_4c__imgProd.img_4c_FigJpg
            .Top       = 1
            .Left      = 3
            .Width     = 331
            .Height    = 218
            .Stretch   = 1
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        THIS.cnt_4c_Item.AddObject("cnt_4c__ImgEmp", "Container")
        WITH THIS.cnt_4c_Item.cnt_4c__ImgEmp
            .Top           = 274
            .Left          = 9
            .Width         = 336
            .Height        = 221
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .ForeColor     = RGB(255, 255, 255)
            .BackColor     = RGB(126, 211, 226)
            .BorderColor   = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Item.cnt_4c__ImgEmp.AddObject("img_4c_Figjpg", "Image")
        WITH THIS.cnt_4c_Item.cnt_4c__ImgEmp.img_4c_Figjpg
            .Top       = 1
            .Left      = 3
            .Width     = 331
            .Height    = 218
            .Stretch   = 1
            .BackStyle = 1
            .Visible   = .F.
        ENDWITH

        *-- Proximo: avanca para a proxima tela (filho direto de cnt_4c_Item).
        THIS.cnt_4c_Item.AddObject("cmd_4c_Proximo", "CommandButton")
        WITH THIS.cnt_4c_Item.cmd_4c_Proximo
            .Top         = 457
            .Left        = 888
            .Width       = 110
            .Height      = 38
            .FontName    = "Verdana"
            .FontSize    = 8
            .Picture     = loc_cIcones + "B_ARROW2.BMP"
            .Caption     = ""
            .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdFormasPagamento
    *==========================================================================
    * grd_4c_FormasPag (GrdFP no legado) - grade OCULTA/Enabled=.F. que exibe
    * o resumo das formas de pagamento lancadas quando a operacao permite
    * parcelamento automatico (crSigCdOpe.ParAutos = 1, Barra_Botoes.ok).
    * Filha DIRETA do form (nao de nenhum container) - mapeamento.json: GrdFP.
    *
    * RecordSource/ControlSource NAO sao setados aqui de proposito: no legado
    * o alias "xParC" e um SELECT dinamico (PADR(fpags,20)+... agrupando xPar
    * por forma de pagamento) montado dentro do proprio Confirmar - o cursor
    * so existe a partir da fase de eventos. Ligar ControlSource contra alias
    * inexistente derruba o Init (CLAUDE.md #41).
    *
    * Original: Top=20 Left=306 Width=445 Height=146 ColumnCount=1 Enabled=.F.
    * GridLines=0 GridLineWidth=1 HeaderHeight=20 Panel=1 RecordMark=.F.
    * ScrollBars=0 Visible=.F. GridLineColor=192,192,192. Column1:
    * FontName="Courier New" FontSize=8 Enabled=.F. Width=432 Visible=.F.
    * Header1: FontName="Verdana" FontSize=8 Alignment=2
    * Caption="Formas de Pagamento" ForeColor=36,84,155. Text1:
    * FontName="Courier New" FontSize=8 Alignment=3 BorderStyle=0 Enabled=.F.
    * Format="!" Margin=0 Visible=.F.
    *==========================================================================
        THIS.AddObject("grd_4c_FormasPag", "Grid")
        WITH THIS.grd_4c_FormasPag
            .Top           = 20
            .Left          = 306
            .Width         = 445
            .Height        = 146
            .ColumnCount   = 1
            .Enabled       = .F.
            .GridLines     = 0
            .GridLineWidth = 1
            .HeaderHeight  = 20
            .Panel         = 1
            .RecordMark    = .F.
            .DeleteMark    = .F.
            .ScrollBars    = 0
            .GridLineColor = RGB(192, 192, 192)
            .Visible       = .F.

            .Column1.FontName  = "Courier New"
            .Column1.FontSize  = 8
            .Column1.Enabled   = .F.
            .Column1.Width     = 432
            .Column1.Visible   = .F.
            .Column1.Header1.FontBold   = .F.
            .Column1.Header1.FontName   = "Verdana"
            .Column1.Header1.FontSize   = 8
            .Column1.Header1.Alignment  = 2
            .Column1.Header1.Caption    = "Formas de Pagamento"
            .Column1.Header1.ForeColor  = RGB(36, 84, 155)
            .Column1.Text1.FontBold     = .F.
            .Column1.Text1.FontName     = "Courier New"
            .Column1.Text1.FontSize     = 8
            .Column1.Text1.Alignment    = 3
            .Column1.Text1.BorderStyle  = 0
            .Column1.Text1.Enabled      = .F.
            .Column1.Text1.Format       = "!"
            .Column1.Text1.Margin       = 0
            .Column1.Text1.Visible      = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaPendencia
    *==========================================================================
    * cnt_4c__Pendencia - busca de pre-venda/pendencias - mapeamento.json:
    * Cnt_Pendencia
    *==========================================================================
        THIS.AddObject("cnt_4c__Pendencia", "Container")
        WITH THIS.cnt_4c__Pendencia
            .Top           = 20
            .Left          = 403
            .Width         = 346
            .Height        = 161
            .BackStyle     = 1
            .BorderWidth   = 0
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeSubNiveis
    *==========================================================================
    * grd_4c_SubNiveis (GradeMultiSubN no legado) - lista os sub-niveis/
    * pendencias vinculados a movimentacao corrente (cursor TmpOperacao),
    * mais o titulo e os dois botoes de navegacao que ficam dentro do mesmo
    * container cnt_4c__Pendencia (ja criado em ConfigurarAreaPendencia).
    * Nome DIFERENTE do generico "grd_4c_Dados" de mapeamento.json de
    * proposito - o JSON mapeia as tres grades do legado (GradeMultiSubN,
    * GrdFP, GrdCupom) para o mesmo nome, e virariam irmas homonimas; a
    * colisao foi resolvida no proprio mapeamento.json, nao aqui (mesmo
    * ajuste feito no form irmao Formsigmvitn.prg/task571 para a MESMA
    * GradeMultiSubN).
    *
    * RecordSource/ControlSource ficam para MontaGrade() - RecordSource
    * reseta Width/Header1.Caption/CurrentControl/Sparse (CLAUDE.md #41).
    *
    * Original: Label1 Top=0 Left=0 Width=347 Height=19 FontBold=.T.
    * FontSize=10 Alignment=2 Caption="Busca Pre Venda" ForeColor=255,255,255
    * BackColor=90,90,90. GradeMultiSubN Top=21 Left=36 Width=274 Height=91
    * ColumnCount=3 FontName="Tahoma" DeleteMark=.F. HeaderHeight=16
    * RecordMark=.F. ScrollBars=2 ForeColor=0,0,0 BackColor=255,255,255.
    * Column1(Codigos) Width=80 InputMask="9999999999" Header="Pendencias".
    * Column2(Notas) Width=80 Header="Notas". Column3(Valor) Width=90
    * Header="Valor". Bot_Pendentes Top=112 Left=36 W=110 H=40
    * Picture=date2.ico Caption="[F3]Pend." Proximo Top=112 Left=200 W=110
    * H=40 Picture=b_arrow2.bmp Caption="" ForeColor=36,84,155.
    *==========================================================================
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.cnt_4c__Pendencia.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c__Pendencia.lbl_4c_Label1
            .Top       = 0
            .Left      = 0
            .Width     = 347
            .Height    = 19
            .FontBold  = .T.
            .FontSize  = 10
            .Alignment = 2
            .BackStyle = 1
            .ForeColor = RGB(255, 255, 255)
            .BackColor = RGB(90, 90, 90)
            .Caption   = "Busca Pre Venda"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Pendencia.AddObject("grd_4c_SubNiveis", "Grid")
        WITH THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
            .Top          = 21
            .Left         = 36
            .Width        = 274
            .Height       = 91
            .ColumnCount  = 3
            .FontName     = "Tahoma"
            .HeaderHeight = 16
            .ScrollBars   = 2
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ForeColor    = RGB(0, 0, 0)
            .BackColor    = RGB(255, 255, 255)
            .Visible      = .T.

            .Column1.FontName  = "Tahoma"
            .Column1.Width     = 80
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.InputMask = "9999999999"
            .Column1.ForeColor = RGB(0, 0, 0)
            .Column1.BackColor = RGB(255, 255, 255)
            .Column1.Header1.FontBold  = .T.
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.Caption   = "Pend" + CHR(234) + "ncias"
            .Column1.Text1.FontName    = "Tahoma"
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)

            .Column2.FontName  = "Tahoma"
            .Column2.Width     = 80
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ForeColor = RGB(0, 0, 0)
            .Column2.BackColor = RGB(255, 255, 255)
            .Column2.Header1.FontBold  = .T.
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Notas"
            .Column2.Text1.FontName    = "Tahoma"
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)

            .Column3.FontName  = "Tahoma"
            .Column3.Width     = 90
            .Column3.ForeColor = RGB(0, 0, 0)
            .Column3.BackColor = RGB(255, 255, 255)
            .Column3.Header1.FontBold  = .T.
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Header1.Caption   = "Valor"
            .Column3.Text1.FontName    = "Tahoma"
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- [F3]Pend. - abre a tela de pendencias do cliente (SigOpPen no
        *-- legado, Cnt_Pendencia.Bot_Pendentes.Click).
        THIS.cnt_4c__Pendencia.AddObject("cmd_4c_Bot_Pendentes", "CommandButton")
        WITH THIS.cnt_4c__Pendencia.cmd_4c_Bot_Pendentes
            .Top         = 112
            .Left        = 36
            .Width       = 110
            .Height      = 40
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = loc_cIcones + "date2.ico"
            .Caption     = "[F3]Pend."
            .ToolTipText = "Abre Tela de Pend" + CHR(234) + "ncias"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        *-- Avanca para a proxima tela (Cnt_Pendencia.Proximo.Click).
        THIS.cnt_4c__Pendencia.AddObject("cmd_4c_Proximo", "CommandButton")
        WITH THIS.cnt_4c__Pendencia.cmd_4c_Proximo
            .Top         = 112
            .Left        = 200
            .Width       = 110
            .Height      = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .Picture     = loc_cIcones + "b_arrow2.bmp"
            .Caption     = ""
            .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaCancelamento
    *==========================================================================
    * cnt_4c_CancelaItem - painel de cancelamento de item, flutuante e OCULTO
    * por padrao - mapeamento.json: CancelaItem (Visible = .F. no legado)
    *==========================================================================
        THIS.AddObject("cnt_4c_CancelaItem", "Container")
        WITH THIS.cnt_4c_CancelaItem
            .Top           = 20
            .Left          = 296
            .Width         = 462
            .Height        = 139
            .BackStyle     = 1
            .BorderWidth   = 0
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(190, 214, 235)
            .Visible       = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposCancelamento
    *==========================================================================
    * Campos do painel de cancelamento de item (cnt_4c_CancelaItem, ja criado
    * em ConfigurarAreaCancelamento, flutuante e Visible=.F. por padrao) -
    * mapeamento.json: filhos de CancelaItem.
    *
    * FASE 5/8 - primeira metade dos campos principais do form.
    *==========================================================================
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.cnt_4c_CancelaItem.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c_CancelaItem.lbl_4c_Label1
            .Top         = 0
            .Left        = 1
            .Width       = 462
            .Height      = 19
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontUnderline = .F.
            .Alignment   = 2
            .BackStyle   = 1
            .ForeColor   = RGB(255, 255, 255)
            .BackColor   = RGB(90, 90, 90)
            .Caption     = "Cancelamento de Item"
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_CancelaItem.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c_CancelaItem.lbl_4c_Label2
            .Top       = 33
            .Left      = 32
            .Width     = 31
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Item :"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CancelaItem.AddObject("txt_4c_Item", "TextBox")
        WITH THIS.cnt_4c_CancelaItem.txt_4c_Item
            .Top           = 31
            .Left          = 66
            .Width         = 31
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "999"
            .MaxLength     = 3
            .Value         = 0
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_CancelaItem.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.cnt_4c_CancelaItem.lbl_4c_Label3
            .Top       = 58
            .Left      = 16
            .Width     = 47
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Produto :"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CancelaItem.AddObject("txt_4c_Produto", "TextBox")
        WITH THIS.cnt_4c_CancelaItem.txt_4c_Produto
            .Top           = 56
            .Left          = 66
            .Width         = 105
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Format        = "K!"
            .InputMask     = "!!!!!!!!!!!!!!"
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_CancelaItem.AddObject("txt_4c__dpro", "TextBox")
        WITH THIS.cnt_4c_CancelaItem.txt_4c__dpro
            .Top           = 56
            .Left          = 172
            .Width         = 281
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_CancelaItem.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.cnt_4c_CancelaItem.lbl_4c_Label4
            .Top       = 84
            .Left      = 28
            .Width     = 35
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Barra :"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CancelaItem.AddObject("txt_4c_Cbarra", "TextBox")
        WITH THIS.cnt_4c_CancelaItem.txt_4c_Cbarra
            .Top           = 81
            .Left          = 66
            .Width         = 79
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "99999999"
            .MaxLength     = 8
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- ok: confirma o cancelamento do item exibido no painel.
        THIS.cnt_4c_CancelaItem.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cnt_4c_CancelaItem.cmd_4c_Ok
            .Top               = 89
            .Left              = 360
            .Width             = 45
            .Height            = 45
            .FontBold          = .T.
            .FontItalic        = .T.
            .Picture           = loc_cIcones + "Mouse4.ico"
            .Cancel            = .F.
            .Caption           = ""
            .ToolTipText       = "Confirmar"
            .ForeColor         = RGB(0, 128, 0)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- CancelaDisp: fecha o painel sem cancelar o item.
        THIS.cnt_4c_CancelaItem.AddObject("cmd_4c_CancelaDisp", "CommandButton")
        WITH THIS.cnt_4c_CancelaItem.cmd_4c_CancelaDisp
            .Top               = 89
            .Left              = 406
            .Width             = 45
            .Height            = 45
            .FontSize          = 8
            .Picture           = loc_cIcones + "shut down.ico"
            .Cancel            = .T.
            .Caption           = ""
            .ToolTipText       = "Cancelar"
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaPagamento
    *==========================================================================
    * cnt_4c__Fpagto - area de formas de pagamento - mapeamento.json:
    * Cnt_Fpagto
    *==========================================================================
        THIS.AddObject("cnt_4c__Fpagto", "Container")
        WITH THIS.cnt_4c__Fpagto
            .Top           = 175
            .Left          = -8
            .Width         = 424
            .Height        = 503
            .BackStyle     = 1
            .BorderWidth   = 0
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(190, 214, 240)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposPagamento
    *==========================================================================
    * Campos de cnt_4c__Fpagto (container ja criado em ConfigurarAreaPagamento):
    * Desconto/Acrescimo da venda, Observacao, os 5 totalizadores (Total,
    * Pagamentos, A Pagar, Saldo Final, Desconto Promocional), o bloco
    * cnt_forma (forma de pagamento/parcelas/vencimento - com lookup) e os
    * dois paineis flutuantes ocultos Cnt_ChequepreTef/cntnsu -
    * mapeamento.json: filhos de Cnt_Fpagto.
    *
    * FASE 6/8 - segunda metade dos campos principais do form + lookups.
    *==========================================================================
        LOCAL loc_cIcones, loc_oCnt
        loc_cIcones = gc_4c_CaminhoIcones

        *-- Desconto / Acrescimo: mesmo Left/Top (Top=202 Left=13) - so um
        *-- fica visivel por vez, alternancia fica para a Fase 7/8.
        THIS.cnt_4c__Fpagto.AddObject("cnt_4c_Desconto", "Container")
        WITH THIS.cnt_4c__Fpagto.cnt_4c_Desconto
            .Top           = 202
            .Left          = 13
            .Width         = 200
            .Height        = 48
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c_Desconto.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c__Fpagto.cnt_4c_Desconto.lbl_4c_Label2
            .Top       = 5
            .Left      = 11
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Desconto"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c_Desconto.AddObject("txt_4c_TotVariacao", "TextBox")
        WITH THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_TotVariacao
            .Top           = 18
            .Left          = 11
            .Width         = 180
            .Height        = 25
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 13
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999,999.99"
            .Value         = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.AddObject("cnt_4c_Acrescimo", "Container")
        WITH THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo
            .Top           = 202
            .Left          = 13
            .Width         = 200
            .Height        = 48
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .F.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.lbl_4c_Label2
            .Top       = 5
            .Left      = 11
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Acr" + CHR(233) + "scimo"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.AddObject("txt_4c_TotVariacao", "TextBox")
        WITH THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.txt_4c_TotVariacao
            .Top           = 18
            .Left          = 11
            .Width         = 180
            .Height        = 25
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 13
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999,999.99"
            .Value         = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- Observacao (label estatico visivel) + o bloco oculto Get_OBS/
        *-- GetObs/SayObs (transcritos EXATAMENTE como o dump, mesmo os tres
        *-- juntos representando a mesma ideia - o legado tem os tres).
        THIS.cnt_4c__Fpagto.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.cnt_4c__Fpagto.lbl_4c_Label9
            .Top       = 352
            .Left      = 13
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.AddObject("lbl_4c_Obs", "Label")
        WITH THIS.cnt_4c__Fpagto.lbl_4c_Obs
            .Top       = 301
            .Left      = 13
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .Visible   = .F.
        ENDWITH

        THIS.cnt_4c__Fpagto.AddObject("obj_4c_GetObs", "EditBox")
        WITH THIS.cnt_4c__Fpagto.obj_4c_GetObs
            .Top           = 315
            .Left          = 13
            .Width         = 291
            .Height        = 38
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .F.
        ENDWITH

        THIS.cnt_4c__Fpagto.AddObject("txt_4c_OBS", "TextBox")
        WITH THIS.cnt_4c__Fpagto.txt_4c_OBS
            .Top           = 365
            .Left          = 13
            .Width         = 150
            .Height        = 23
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .F.
        ENDWITH

        *-- Proximo (Cnt_Fpagto.Proximo) - avanca para a proxima tela.
        THIS.cnt_4c__Fpagto.AddObject("cmd_4c_Proximo", "CommandButton")
        WITH THIS.cnt_4c__Fpagto.cmd_4c_Proximo
            .Top         = 315
            .Left        = 307
            .Width       = 107
            .Height      = 38
            .FontName    = "Verdana"
            .FontSize    = 8
            .Picture     = loc_cIcones + "b_arrow1.bmp"
            .Caption     = ""
            .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
            .SpecialEffect = 0
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        *-- Cnt_tot: total original da venda (Get_valinic).
        THIS.cnt_4c__Fpagto.AddObject("cnt_4c__tot", "Container")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__tot
            .Top           = 152
            .Left          = 13
            .Width         = 200
            .Height        = 48
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c__tot.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__tot.lbl_4c_Label2
            .Top       = 5
            .Left      = 12
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Total"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c__tot.AddObject("txt_4c_Valinic", "TextBox")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__tot.txt_4c_Valinic
            .Top           = 18
            .Left          = 10
            .Width         = 180
            .Height        = 25
            .FontBold      = .T.
            .FontSize      = 13
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999,999.99"
            .Value         = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- cnt_pag: total ja pago com formas de pagamento (Get_TotForma).
        THIS.cnt_4c__Fpagto.AddObject("cnt_4c__pag", "Container")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__pag
            .Top           = 202
            .Left          = 214
            .Width         = 200
            .Height        = 48
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c__pag.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__pag.lbl_4c_Label2
            .Top       = 5
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Pagamentos"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c__pag.AddObject("txt_4c_TotForma", "TextBox")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__pag.txt_4c_TotForma
            .Top           = 18
            .Left          = 10
            .Width         = 180
            .Height        = 25
            .FontBold      = .T.
            .FontSize      = 13
            .Alignment     = 3
            .SpecialEffect = 1
            .Format        = "K"
            .InputMask     = "999,999,999.99"
            .Value         = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- cnt_apag: saldo que ainda falta pagar (Get_Saldo).
        THIS.cnt_4c__Fpagto.AddObject("cnt_4c__apag", "Container")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__apag
            .Top           = 252
            .Left          = 214
            .Width         = 200
            .Height        = 48
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c__apag.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__apag.lbl_4c_Label2
            .Top       = 5
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "A Pagar"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c__apag.AddObject("txt_4c_Saldo", "TextBox")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__apag.txt_4c_Saldo
            .Top           = 18
            .Left          = 10
            .Width         = 180
            .Height        = 25
            .FontBold      = .T.
            .FontSize      = 13
            .Alignment     = 3
            .SpecialEffect = 1
            .Format        = "K"
            .InputMask     = "999,999,999.99"
            .Value         = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- cnt_saldo: saldo final apos desconto/acrescimo (Get_TotLiquido).
        THIS.cnt_4c__Fpagto.AddObject("cnt_4c__saldo", "Container")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__saldo
            .Top           = 252
            .Left          = 13
            .Width         = 200
            .Height        = 48
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c__saldo.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__saldo.lbl_4c_Label2
            .Top       = 5
            .Left      = 13
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Saldo Final"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c__saldo.AddObject("txt_4c_TotLiquido", "TextBox")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__saldo.txt_4c_TotLiquido
            .Top           = 18
            .Left          = 11
            .Width         = 180
            .Height        = 25
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 13
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999,999.99"
            .Value         = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- cnt_descp: desconto promocional/campanha (Get_tvariacao).
        THIS.cnt_4c__Fpagto.AddObject("cnt_4c__descp", "Container")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__descp
            .Top           = 152
            .Left          = 214
            .Width         = 200
            .Height        = 48
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c__descp.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__descp.lbl_4c_Label2
            .Top       = 2
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Desconto Promocional"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Fpagto.cnt_4c__descp.AddObject("txt_4c_Tvariacao", "TextBox")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__descp.txt_4c_Tvariacao
            .Top           = 18
            .Left          = 10
            .Width         = 180
            .Height        = 25
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 13
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999,999.99"
            .Value         = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- Titulo do container (barra escura "Finaliza a Venda").
        THIS.cnt_4c__Fpagto.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c__Fpagto.lbl_4c_Label1
            .Top       = -1
            .Left      = 13
            .Width     = 401
            .Height    = 22
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 10
            .Alignment = 2
            .BackStyle = 1
            .ForeColor = RGB(255, 255, 255)
            .BackColor = RGB(90, 90, 90)
            .Caption   = "Finaliza a Venda"
            .Visible   = .T.
        ENDWITH

        *-- cnt_forma: forma de pagamento / parcelas / valor / vencimento.
        THIS.cnt_4c__Fpagto.AddObject("cnt_4c__forma", "Container")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__forma
            .Top           = 22
            .Left          = 13
            .Width         = 401
            .Height        = 128
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__forma

        loc_oCnt.AddObject("txt_4c_Fpg", "TextBox")
        WITH loc_oCnt.txt_4c_Fpg
            .Top           = 4
            .Left          = 93
            .Width         = 185
            .Height        = 29
            .FontBold      = .T.
            .FontSize      = 13
            .SpecialEffect = 1
            .MaxLength     = 12
            .Value         = ""
            .ToolTipText   = "Condi" + CHR(231) + CHR(227) + "o de pagamento"
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Npar", "TextBox")
        WITH loc_oCnt.txt_4c_Npar
            .Top           = 34
            .Left          = 93
            .Width         = 41
            .Height        = 29
            .FontBold      = .T.
            .FontSize      = 13
            .SpecialEffect = 1
            .InputMask     = "99"
            .Value         = 0
            .ToolTipText   = "N" + CHR(250) + "mero de Parcelas"
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Vpar", "TextBox")
        WITH loc_oCnt.txt_4c_Vpar
            .Top           = 64
            .Left          = 93
            .Width         = 185
            .Height        = 29
            .FontBold      = .T.
            .FontSize      = 13
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999,999.99"
            .Value         = 0
            .ToolTipText   = "Valor de cada Parcela"
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Fweditdata_venc", "TextBox")
        WITH loc_oCnt.txt_4c_Fweditdata_venc
            .Top           = 94
            .Left          = 93
            .Width         = 185
            .Height        = 29
            .FontBold      = .T.
            .FontSize      = 13
            .SpecialEffect = 1
            .Value         = {}
            .ToolTipText   = "Data de Vencimento"
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oCnt.lbl_4c_Label18
            .Top       = 100
            .Left      = 26
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Vencimento :"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oCnt.lbl_4c_Label13
            .Top       = 40
            .Left      = 41
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Parcelas :"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oCnt.lbl_4c_Label17
            .Top       = 70
            .Left      = 57
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Valor :"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oCnt.lbl_4c_Label12
            .Top       = 10
            .Left      = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Forma Pagto:"
            .Visible   = .T.
        ENDWITH

        *-- LOOKUP: forma de pagamento (SigOpFp) - F4/Enter/Tab abrem o
        *-- picker; ver AbrirLookupFormaPagamento().
        BINDEVENT(loc_oCnt.txt_4c_Fpg, "KeyPress", THIS, "FpgKeyPress")

        *-- Cnt_ChequepreTef: painel de dados do cheque pre-datado/TEF,
        *-- flutuante e oculto por padrao.
        THIS.cnt_4c__Fpagto.AddObject("cnt_4c__ChequepreTef", "Container")
        WITH THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef
            .Top           = 389
            .Left          = 13
            .Width         = 407
            .Height        = 62
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .F.
        ENDWITH

        loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef

        loc_oCnt.AddObject("cmd_4c_TefChq", "CommandButton")
        WITH loc_oCnt.cmd_4c_TefChq
            .Top         = 4
            .Left        = 268
            .Width       = 108
            .Height      = 20
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Caption     = "Consulta C\<heque"
            .ToolTipText = "Confirmar o Cheque"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Opc_cpf", "OptionGroup")
        WITH loc_oCnt.obj_4c_Opc_cpf
            .Top         = 5
            .Left        = 3
            .Width       = 118
            .Height      = 17
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "C.P.F."
                .Height    = 17
                .Left      = 5
                .Top       = 1
                .Width     = 49
            ENDWITH

            WITH .Buttons(2)
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "C.N.P.J."
                .Left      = 54
                .Top       = 1
            ENDWITH

            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cpf", "TextBox")
        WITH loc_oCnt.txt_4c_Cpf
            .Top           = 4
            .Left          = 125
            .Width         = 140
            .Height        = 20
            .SpecialEffect = 1
            .MaxLength     = 20
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top      = 25
            .Left     = 53
            .FontName = "Tahoma"
            .FontSize = 7
            .Caption  = "Banco"
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Bco", "TextBox")
        WITH loc_oCnt.txt_4c_Bco
            .Top           = 36
            .Left          = 53
            .Width         = 32
            .Height        = 22
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .Top      = 25
            .Left     = 85
            .FontName = "Tahoma"
            .FontSize = 7
            .Caption  = "Agencia  Dv"
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Age", "TextBox")
        WITH loc_oCnt.txt_4c_Age
            .Top           = 36
            .Left          = 86
            .Width         = 36
            .Height        = 22
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Agendc", "TextBox")
        WITH loc_oCnt.txt_4c_Agendc
            .Top           = 36
            .Left          = 123
            .Width         = 22
            .Height        = 22
            .SpecialEffect = 1
            .MaxLength     = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .Top      = 25
            .Left     = 147
            .FontName = "Tahoma"
            .FontSize = 7
            .Caption  = "Conta                            Dv"
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .Top           = 36
            .Left          = 146
            .Width         = 79
            .Height        = 22
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Contadc", "TextBox")
        WITH loc_oCnt.txt_4c_Contadc
            .Top           = 36
            .Left          = 226
            .Width         = 23
            .Height        = 22
            .SpecialEffect = 1
            .MaxLength     = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .Top      = 25
            .Left     = 250
            .FontName = "Tahoma"
            .FontSize = 7
            .Caption  = "N.Cheque     Dv"
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Num", "TextBox")
        WITH loc_oCnt.txt_4c_Num
            .Top           = 36
            .Left          = 250
            .Width         = 52
            .Height        = 22
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Numdc", "TextBox")
        WITH loc_oCnt.txt_4c_Numdc
            .Top           = 36
            .Left          = 303
            .Width         = 22
            .Height        = 22
            .SpecialEffect = 1
            .MaxLength     = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top      = 25
            .Left     = 18
            .FontName = "Tahoma"
            .FontSize = 7
            .Caption  = "Pca"
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Pca", "TextBox")
        WITH loc_oCnt.txt_4c_Pca
            .Top           = 36
            .Left          = 18
            .Width         = 34
            .Height        = 22
            .SpecialEffect = 1
            .MaxLength     = 34
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- cntnsu: NSU/Autorizacao/Adquirente do cartao (TEF), flutuante e
        *-- oculto por padrao.
        THIS.cnt_4c__Fpagto.AddObject("cnt_4c_nsu", "Container")
        WITH THIS.cnt_4c__Fpagto.cnt_4c_nsu
            .Top           = 315
            .Left          = 13
            .Width         = 291
            .Height        = 38
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .F.
        ENDWITH

        loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c_nsu

        loc_oCnt.AddObject("txt_4c_Nsu", "TextBox")
        WITH loc_oCnt.txt_4c_Nsu
            .Top           = 16
            .Left          = 5
            .Width         = 90
            .Height        = 20
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .InputMask     = "999999999999"
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c__Protocs", "Label")
        WITH loc_oCnt.lbl_4c__Protocs
            .Top       = 3
            .Left      = 5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "NSU"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oCnt.lbl_4c_Label9
            .Top       = 3
            .Left      = 98
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Autoriza" + CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Autoriza", "TextBox")
        WITH loc_oCnt.txt_4c_Autoriza
            .Top           = 16
            .Left          = 98
            .Width         = 70
            .Height        = 20
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .InputMask     = "!!!!!!"
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_label14", "Label")
        WITH loc_oCnt.lbl_4c_label14
            .Top       = 3
            .Left      = 179
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Adquirente"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__adquire", "TextBox")
        WITH loc_oCnt.txt_4c__adquire
            .Top           = 16
            .Left          = 179
            .Width         = 102
            .Height        = 20
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- LOOKUP: adquirente do cartao (SigCdCad, tipocads='ADQUIRENTE') -
        *-- ver AbrirLookupAdquirente().
        BINDEVENT(loc_oCnt.txt_4c__adquire, "KeyPress", THIS, "AdquireKeyPress")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaIdentificacao
    *==========================================================================
    * cnt_4c__Identifica - identificacao do cliente (Origem/Destino/Vendedor/
    * Responsavel) - mapeamento.json: Cnt_Identifica
    *==========================================================================
        THIS.AddObject("cnt_4c__Identifica", "Container")
        WITH THIS.cnt_4c__Identifica
            .Top           = 171
            .Left          = 5
            .Width         = 406
            .Height        = 475
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(190, 214, 240)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposIdentificacao
    *==========================================================================
    * Campos de cnt_4c__Identifica (container ja criado em
    * ConfigurarAreaIdentificacao): os quatro blocos de identificacao de
    * conta (Destino/Responsavel/Vendedor/Origem - grupo+conta+nome+cpf,
    * cada um com lookup proprio), Tab. Desconto/Lista de Precos (com
    * lookup), numero do Documento/Pedido Cliente e o titulo do container -
    * mapeamento.json: filhos de Cnt_Identifica.
    *
    * FASE 6/8 - segunda metade dos campos principais do form + lookups.
    *==========================================================================
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        *-- Destino: grupo/conta/nome/cpf do destinatario da operacao.
        THIS.MontarBlocoIdentificacao("Destino", 179, "TprMvCab.grupods", "TprMvCab.contads", .T., "Destino")

        *-- Responsavel: grupo/conta/nome/cpf do responsavel financeiro.
        THIS.MontarBlocoIdentificacao("Responsavel", 365, "TprMvCab.GrResps", "TprMvCab.Resps", .F., "Respons" + CHR(225) + "vel")

        *-- Vendedor: grupo/conta/nome/cpf do vendedor.
        THIS.MontarBlocoIdentificacao("Vendedor", 272, "TprMvCab.grvends", "TprMvCab.vends", .F., "Vendedor")

        *-- Origem: grupo/conta/nome/cpf da origem da operacao.
        THIS.MontarBlocoIdentificacao("Origem", 86, "TprMvCab.grupoos", "TprMvCab.contaos", .T., "Origem")

        *-- TabDesconto: tabela de desconto + lista de precos.
        THIS.cnt_4c__Identifica.AddObject("cnt_4c_TabDesconto", "Container")
        WITH THIS.cnt_4c__Identifica.cnt_4c_TabDesconto
            .Top           = 48
            .Left          = 0
            .Width         = 404
            .Height        = 41
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.lbl_4c_Label1
            .Top       = 4
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tab. Desconto"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.AddObject("txt_4c_Tabd", "TextBox")
        WITH THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_Tabd
            .Top           = 18
            .Left          = 10
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.AddObject("txt_4c_ListaPreco", "TextBox")
        WITH THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_ListaPreco
            .Top           = 18
            .Left          = 123
            .Width         = 220
            .Height        = 20
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .Format        = "K"
            .MaxLength     = 30
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.AddObject("lbl_4c__ListaPreco", "Label")
        WITH THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.lbl_4c__ListaPreco
            .Top       = 4
            .Left      = 124
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Lista de Pre" + CHR(231) + "os"
            .Visible   = .T.
        ENDWITH

        *-- LOOKUP: tabela de desconto (SigOpTdz) e lista de precos
        *-- (SigCdLpc) - ver AbrirLookupTabDesconto()/AbrirLookupListaPreco().
        BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_Tabd, "KeyPress", THIS, "TabdKeyPress")
        BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_ListaPreco, "KeyPress", THIS, "ListaPrecoKeyPress")

        *-- Proximo (Cnt_Identifica.Proximo) - oculto no legado.
        THIS.cnt_4c__Identifica.AddObject("cmd_4c_Proximo", "CommandButton")
        WITH THIS.cnt_4c__Identifica.cmd_4c_Proximo
            .Top         = 413
            .Left        = 319
            .Width       = 80
            .Height      = 38
            .FontName    = "Verdana"
            .FontSize    = 8
            .Picture     = loc_cIcones + "b_arrow2.bmp"
            .Caption     = ""
            .SpecialEffect = 0
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .F.
        ENDWITH

        *-- CodOperacao: numero do documento / pedido do cliente.
        THIS.cnt_4c__Identifica.AddObject("cnt_4c_CodOperacao", "Container")
        WITH THIS.cnt_4c__Identifica.cnt_4c_CodOperacao
            .Top           = 23
            .Left          = 0
            .Width         = 404
            .Height        = 31
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.lbl_4c_Label1
            .Top       = 8
            .Left      = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Documento : "
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.AddObject("txt_4c_Codigo", "TextBox")
        WITH THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.txt_4c_Codigo
            .Top           = 4
            .Left          = 94
            .Width         = 61
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 10
            .SpecialEffect = 1
            .MaxLength     = 6
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.lbl_4c_Label2
            .Top       = 8
            .Left      = 176
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Pedido Cliente: "
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.AddObject("txt_4c_PedCli", "TextBox")
        WITH THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.txt_4c_PedCli
            .Top           = 4
            .Left          = 260
            .Width         = 80
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 10
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Titulo do container (barra escura "Identificacao do Cliente").
        THIS.cnt_4c__Identifica.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c__Identifica.lbl_4c_Label1
            .Top       = 3
            .Left      = 0
            .Width     = 404
            .Height    = 21
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 10
            .Alignment = 2
            .BackStyle = 1
            .ForeColor = RGB(255, 255, 255)
            .BackColor = RGB(90, 90, 90)
            .Caption   = "Identifica" + CHR(231) + CHR(227) + "o do Cliente"
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE MontarBlocoIdentificacao(par_cNome, par_nTop, par_cCtrlGrupo, par_cCtrlConta, par_lCadastro, par_cTitulo)
    *==========================================================================
    * Fabrica os 4 blocos IDENTICOS de identificacao de conta (Destino,
    * Responsavel, Vendedor, Origem) - todos com a MESMA estrutura de campos
    * (Grupo/Conta/Nome/CPF) e so variando o Top e a presenca do botao de
    * atalho para o cadastro (btnCadastros - so em Destino/Origem no
    * legado). Nome do container gerado: "cnt_4c_" + par_cNome
    * (cnt_4c_Destino/cnt_4c_Responsavel/cnt_4c_Vendedor/cnt_4c_Origem).
    *
    * par_cCtrlGrupo/par_cCtrlConta NAO sao aplicados a nenhuma propriedade
    * aqui - documentam apenas o ControlSource legado (TprMvCab.grupods/
    * grvends/grupoos/GrResps e contads/vends/contaos/Resps) para a Fase
    * 7/8, quando FormParaBO/BOParaForm ligarem estes TextBox as
    * propriedades do BO (este form nao usa .ControlSource nativo em
    * nenhum outro campo, e nao seria diferente aqui).
    *==========================================================================
        LOCAL loc_cCnt, loc_oCnt, loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones
        loc_cCnt = "cnt_4c_" + par_cNome

        THIS.cnt_4c__Identifica.AddObject(loc_cCnt, "Container")
        loc_oCnt = EVALUATE("THIS.cnt_4c__Identifica." + loc_cCnt)
        WITH loc_oCnt
            .Top           = par_nTop
            .Left          = 0
            .Width         = 404
            .Height        = 94
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oCnt.lbl_4c_Label8
            .Top       = 18
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c__dConta", "Label")
        WITH loc_oCnt.lbl_4c__dConta
            .Top       = 51
            .Left      = 10
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c__CPF", "Label")
        WITH loc_oCnt.lbl_4c__CPF
            .Top       = 18
            .Left      = 176
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "CPF / CNPJ"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top       = 18
            .Left      = 93
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .Top           = 32
            .Left          = 10
            .Width         = 80
            .Height        = 21
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .Alignment     = 1
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .Top           = 32
            .Left          = 93
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oCnt.txt_4c_Dconta
            .Top           = 65
            .Left          = 10
            .Width         = 304
            .Height        = 21
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cpf", "TextBox")
        WITH loc_oCnt.txt_4c_Cpf
            .Top           = 32
            .Left          = 176
            .Width         = 139
            .Height        = 21
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        IF par_lCadastro
            loc_oCnt.AddObject("cmd_4c_BtnCadastros", "CommandButton")
            WITH loc_oCnt.cmd_4c_BtnCadastros
                .Top           = 53
                .Left          = 319
                .Width         = 80
                .Height        = 35
                .FontSize      = 7
                .Picture       = loc_cIcones + "binder03.ico"
                .Caption       = ""
                .ToolTipText   = "<F3> Acessa o Cadastro Desta Conta"
                .SpecialEffect = 2
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
        ENDIF

        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .Top       = 2
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = par_cTitulo
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lin_4c_Line1", "Line")
        WITH loc_oCnt.lin_4c_Line1
            .BorderWidth = 2
            .Top         = 17
            .Left        = 10
            .Width       = 323
            .Visible     = .T.
        ENDWITH

        *-- LOOKUP: grupo (SigCdGrp) e conta (SigCdCli) - um handler PUBLIC
        *-- dedicado por bloco (Grupo<Nome>KeyPress/Conta<Nome>KeyPress/
        *-- Cpf<Nome>KeyPress), criado logo abaixo desta procedure. Nomes
        *-- fixos (nao gerados via macro) para BINDEVENT sempre achar um
        *-- metodo PUBLIC existente (regra BINDEVENT so aceita PUBLIC).
        BINDEVENT(loc_oCnt.txt_4c_Grupo, "KeyPress", THIS, "Grupo" + par_cNome + "KeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Conta, "KeyPress", THIS, "Conta" + par_cNome + "KeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Cpf, "KeyPress", THIS, "Cpf" + par_cNome + "KeyPress")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBarraBotoes
    *==========================================================================
    * cnt_4c_Barra_Botoes - barra com os botoes funcionais do Caixa (Itens,
    * Pagto, Identifica, etc. - adicionados na Fase 4) - mapeamento.json:
    * Barra_Botoes
    *==========================================================================
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

        THIS.AddObject("cnt_4c_Barra_Botoes", "Container")
        WITH THIS.cnt_4c_Barra_Botoes
            .Top           = 15
            .Left          = 755
            .Width         = 536
            .Height        = 82
            .BackStyle = 1
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
            IF FILE(loc_cImg)
                .Picture = loc_cImg
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesBarraPrincipal
    *==========================================================================
    * Os 16 CommandButtons de cnt_4c_Barra_Botoes (container ja criado em
    * ConfigurarBarraBotoes). Varios pares OCUPAM O MESMO Left/Top porque a
    * barra alterna qual conjunto fica visivel conforme a tela ativa
    * (Desconto/Acrescimo em Left=5,Top=45; CancPagto/apaga em Left=97,Top=6;
    * Financia/pendencia em Left=189,Top=6) - a alternancia de .Visible e os
    * Click ficam para as Fases 7-8. Cada botao nasce com o .Visible EXATO do
    * dump (a maioria .T.; Financia e .F. - opcao desligada por padrao).
    * Propriedades comuns a TODOS (do dump): Height=36 Width=92 FontBold=.T.
    * FontItalic=.T. FontName="Comic Sans MS" FontSize=8 ForeColor=90,90,90
    * BackColor=255,255,255 DisabledForeColor=109,109,109
    * DisabledBackColor=240,240,240 Themes=.F. (Confirmar/Cancela sao os dois
    * botoes grandes 75x75, com PicturePosition=13).
    *==========================================================================
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        *-- [F2] Itens - tela padrao de lancamento de itens.
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Itens", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens
            .Top                = 6
            .Left               = 5
            .Width              = 92
            .Height             = 36
            .AutoSize           = .F.
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .WordWrap           = .T.
            .Picture            = loc_cIcones + "cadastro_inserir_26.jpg"
            .Caption            = "Itens-F2"
            .MousePointer       = 15
            .ToolTipText        = "[F2] Tela de Itens"
            .PicturePosition    = 1
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- [F3] Qtde - altera quantidade do item corrente.
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Alteraqtd", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Alteraqtd
            .Top                = 45
            .Left               = 5
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "geral_selecionar_26.jpg"
            .Caption            = "[F3]Qtde"
            .ToolTipText        = "[F3] Quantidades"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- [F3] Descontos do item corrente (mesmo Left/Top do Acrescimo -
        *-- so um dos dois fica visivel por vez).
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Desconto", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Desconto
            .Top                = 45
            .Left               = 5
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "geral_calculadora_60.jpg"
            .Caption            = "[F3]Descon."
            .ToolTipText        = "[F3] Descontos"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- [Ctrl+F3] Acrescimos do item corrente (mesmo Left/Top do
        *-- Desconto).
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Acrescimo", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Acrescimo
            .Top                = 45
            .Left               = 5
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "DESCONTO.ICO"
            .Caption            = "Ctrl+F3"
            .ToolTipText        = "[Ctrl + F3] Acr" + CHR(233) + "scimos"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- [F4] Canc - cancela a forma de pagamento lancada (mesmo Left/Top
        *-- do Apaga).
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_CancPagto", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_CancPagto
            .Top                = 6
            .Left               = 97
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "simbolosl_erro_60.jpg"
            .Caption            = "[F4]Canc"
            .ToolTipText        = "[F4] Cancelar Forma de Pagamento"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- [F4] Canc - cancela a operacao/venda inteira (mesmo Left/Top do
        *-- CancPagto).
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Apaga
            .Top                = 6
            .Left               = 97
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "cadastro_sair_26.jpg"
            .Caption            = "Canc - F4"
            .ToolTipText        = "[F4] Cancelar Opera" + CHR(231) + CHR(227) + "o"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- [F5] Alt.$ - alteracao de precos.
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_AltPreco", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_AltPreco
            .Top                = 6
            .Left               = 97
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .WordWrap           = .T.
            .Picture            = loc_cIcones + "ALTPRE.ICO"
            .Caption            = "[F5]Alt.$"
            .ToolTipText        = "[F5] Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- Identif-F6 - identificacao de contas (Origem/Destino/Vendedor/
        *-- Responsavel).
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Identifica", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Identifica
            .Top                = 45
            .Left               = 97
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "geral_contas_32.jpg"
            .Caption            = "Identif-F6"
            .ToolTipText        = "[F6] Identifica" + CHR(231) + CHR(227) + "o de Contas"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- Cred. - F7 - operacoes de credito.
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Credito", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Credito
            .Top                = 45
            .Left               = 97
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "geral_escudo_ok_32.jpg"
            .Caption            = "Cr" + CHR(233) + "d. - F7"
            .ToolTipText        = "[F7] Cr" + CHR(233) + "ditos"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- [F8] Crediario - financiamento (desligado por padrao no legado -
        *-- Visible=.F., mesmo Left/Top da Pendencia).
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Financia", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Financia
            .Top                = 6
            .Left               = 189
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "geral_calculadora_60.jpg"
            .Caption            = "[F8]Crediario"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .F.
        ENDWITH

        *-- Pend-F8 - sub-niveis/pendencias (mesmo Left/Top do Financia).
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Pendencia", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Pendencia
            .Top                = 6
            .Left               = 189
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "geral_selecionar_26.jpg"
            .Caption            = "Pend-F8"
            .ToolTipText        = "[F8] Pend" + CHR(234) + "ncias"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- Pagto-F11 - tela de formas de pagamento (mesmo Left do
        *-- Financia/Pendencia, Top diferente).
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Pagto", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Pagto
            .Top                = 45
            .Left               = 189
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .WordWrap           = .F.
            .Picture            = loc_cIcones + "geral_arquivo_26.jpg"
            .Caption            = "Pagto-F11"
            .ToolTipText        = "[F11] Tela de Formas de Pagamentos"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- <Ctrl+P> - consulta de preco.
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_VerPreco", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_VerPreco
            .Top                = 6
            .Left               = 281
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "geral_adicao_26.jpg"
            .Caption            = "<Ctrl+P>"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- Fiscal-F9 - impressora fiscal.
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Impfiscal", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Impfiscal
            .Top                = 45
            .Left               = 281
            .Width              = 92
            .Height             = 36
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "geral_boleto_26.jpg"
            .Caption            = "Fiscal-F9"
            .ToolTipText        = "[F9] Impressora Fiscal"
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- Confirmar - fecha a venda (botao grande 75x75).
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Ok
            .Top                = 6
            .Left               = 374
            .Width              = 75
            .Height             = 75
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "cadastro_salvar_60.jpg"
            .Caption            = "Confirmar"
            .ToolTipText        = "Confirmar"
            .PicturePosition    = 13
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- Cancelar - cancela a venda inteira, tecla ESC (botao grande
        *-- 75x75).
        THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Cancela
            .Top                = 6
            .Left               = 449
            .Width              = 75
            .Height             = 75
            .FontBold           = .T.
            .FontItalic         = .T.
            .FontName           = "Comic Sans MS"
            .FontSize           = 8
            .Picture            = loc_cIcones + "cadastro_cancelar_60.jpg"
            .Cancel             = .T.
            .Caption            = "Cancelar"
            .ToolTipText        = "[ESC] Cancelar"
            .PicturePosition    = 13
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(109, 109, 109)
            .DisabledBackColor  = RGB(240, 240, 240)
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeCupom
    *==========================================================================
    * cnt_4c_Grade - grade do cupom fiscal (itens ja impressos), flutuante e
    * OCULTA por padrao - mapeamento.json: CntGrade (Visible = .F. no legado)
    *==========================================================================
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

        THIS.AddObject("cnt_4c_Grade", "Container")
        WITH THIS.cnt_4c_Grade
            .Top           = 178
            .Left          = 412
            .Width         = 450
            .Height        = 415
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .BorderColor   = RGB(190, 214, 235)
            .Visible       = .F.
            IF FILE(loc_cImg)
                .Picture = loc_cImg
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridCupomInterno
    *==========================================================================
    * grd_4c_Cupom (GrdCupom no legado) - grade READONLY que lista as linhas
    * ja formatadas do cupom fiscal em andamento (cursor crTpmMvItnC), mais
    * os dois totais (Cnt_subt/Get_Total = Subtotal, cnt_tots/Get_total =
    * Total Geral) que ficam colados embaixo dela dentro do MESMO container
    * cnt_4c_Grade (ja criado em ConfigurarGradeCupom). Coluna unica sem
    * cabecalho visivel (HeaderHeight=0 - cada linha e uma string formatada,
    * padrao de cupom fiscal), fonte Cordia New roxa (ForeColor=58,44,126).
    *
    * RecordSource/ControlSource de grd_4c_Cupom ficam para MontaGrade() -
    * RecordSource reseta Width/Header1.Caption (CLAUDE.md #41).
    *
    * Original: GrdCupom Top=0 Left=3 Width=445 Height=360 ColumnCount=1
    * Enabled=.F. GridLines=0 HeaderHeight=0 ReadOnly=.T. RecordMark=.F.
    * ScrollBars=0 ForeColor=58,44,126. Column1 FontName="Cordia New"
    * Width=345 Movable=.F. ReadOnly=.T. Cnt_subt/cnt_tots Top=365
    * Width=221 Height=49 BackStyle=0 BorderWidth=1 SpecialEffect=2
    * BackColor=126,211,226; Say7 Caption="Subtotal"/"Total Geral"
    * FontBold=.T. FontSize=8 ForeColor=90,90,90; Get_Total/Get_total
    * FontBold=.T. FontSize=18 Alignment=2 BackStyle=0 BorderStyle=0
    * InputMask="9,999,999.99" Height=35 Width=218 ForeColor=0,0,0
    * BackColor=255,255,255.
    *==========================================================================
        THIS.cnt_4c_Grade.AddObject("grd_4c_Cupom", "Grid")
        WITH THIS.cnt_4c_Grade.grd_4c_Cupom
            .Top          = 0
            .Left         = 3
            .Width        = 445
            .Height       = 360
            .ColumnCount  = 1
            .Enabled      = .F.
            .GridLines    = 0
            .HeaderHeight = 0
            .ReadOnly     = .T.
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .ScrollBars   = 0
            .ForeColor    = RGB(58, 44, 126)
            .Visible      = .T.

            .Column1.FontBold   = .F.
            .Column1.FontName   = "Cordia New"
            .Column1.Enabled    = .F.
            .Column1.Width      = 345
            .Column1.Movable    = .F.
            .Column1.ReadOnly   = .T.
            .Column1.ForeColor  = RGB(58, 44, 126)
            .Column1.Header1.FontSize = 8
            .Column1.Header1.Caption  = "Header1"
            .Column1.Text1.FontBold    = .F.
            .Column1.Text1.FontName    = "Cordia New"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Enabled     = .F.
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .T.
            .Column1.Text1.ForeColor   = RGB(58, 44, 126)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Subtotal (soma bruta dos itens ja lancados no cupom).
        THIS.cnt_4c_Grade.AddObject("cnt_4c__subt", "Container")
        WITH THIS.cnt_4c_Grade.cnt_4c__subt
            .Top           = 365
            .Left          = 3
            .Width         = 221
            .Height        = 49
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Grade.cnt_4c__subt.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.cnt_4c_Grade.cnt_4c__subt.lbl_4c_Label7
            .Top       = 1
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Subtotal"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Grade.cnt_4c__subt.AddObject("txt_4c_Total", "TextBox")
        WITH THIS.cnt_4c_Grade.cnt_4c__subt.txt_4c_Total
            .Top           = 11
            .Left          = 1
            .Width         = 218
            .Height        = 35
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .Alignment     = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .InputMask     = "9,999,999.99"
            .Value         = 0
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- Total Geral (subtotal + variacoes de desconto/acrescimo).
        THIS.cnt_4c_Grade.AddObject("cnt_4c__tots", "Container")
        WITH THIS.cnt_4c_Grade.cnt_4c__tots
            .Top           = 365
            .Left          = 227
            .Width         = 221
            .Height        = 49
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(126, 211, 226)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Grade.cnt_4c__tots.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.cnt_4c_Grade.cnt_4c__tots.lbl_4c_Label7
            .Top       = 1
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Total Geral"
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Grade.cnt_4c__tots.AddObject("txt_4c_Total", "TextBox")
        WITH THIS.cnt_4c_Grade.cnt_4c__tots.txt_4c_Total
            .Top           = 11
            .Left          = 2
            .Width         = 218
            .Height        = 35
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .Alignment     = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .InputMask     = "9,999,999.99"
            .Value         = 0
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaMensagens
    *==========================================================================
    * cnt_4c__mensagems - mensagens grandes de status (ex.: instrucoes durante
    * a emissao fiscal) - mapeamento.json: Cnt_mensagems
    *==========================================================================
        THIS.AddObject("cnt_4c__mensagems", "Container")
        WITH THIS.cnt_4c__mensagems
            .Top           = 100
            .Left          = 100
            .Width         = 1000
            .Height        = 72
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(190, 214, 240)
            .Visible       = .T.
        ENDWITH

        *-- Os dois labels de cnt_4c__mensagems - mapeamento.json:
        *-- Cnt_mensagems.Mensage1 / Cnt_mensagems.Mensage2. O legado escreve
        *-- neles a identificacao e a quantidade x valor do item lancado
        *-- (Itens.Click: "xTexto1 = Padl(Cpros,14,'0')+' '+Dpros" /
        *-- "xTexto2 = Transform(Qtds,...)+' X '+Transform(Units,...)"). O
        *-- Caption "teste" do dump e placeholder de tempo de projeto -
        *-- nasce vazio, porque o legado o sobrescreve em runtime.
        THIS.cnt_4c__mensagems.AddObject("lbl_4c_Mensage1", "Label")
        WITH THIS.cnt_4c__mensagems.lbl_4c_Mensage1
            .Top       = 5
            .Left      = 6
            .Width     = 978
            .Height    = 25
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 13
            .Alignment = 2
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__mensagems.AddObject("lbl_4c_Mensage2", "Label")
        WITH THIS.cnt_4c__mensagems.lbl_4c_Mensage2
            .Top       = 28
            .Left      = 6
            .Width     = 978
            .Height    = 36
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .Alignment = 2
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTimer
    *==========================================================================
    * obj_4c_Timer1 - atualiza periodicamente a barra de titulo com
    * data/hora/documento/operador - mapeamento.json: Timer1. O Interval e o
    * do legado (1000 ms); o Procedure esta em TimerAtualizarTitulo() e e
    * ligado por BINDEVENT em RegistrarEventosPrincipais(), que tambem liga o
    * .Enabled - aqui ele nasce desligado para o Timer nao disparar no meio da
    * construcao dos controles, quando a barra de titulo ainda nao existe.
    *==========================================================================
        THIS.AddObject("obj_4c_Timer1", "Timer")
        WITH THIS.obj_4c_Timer1
            .Interval = 1000
            .Enabled  = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CriarCursoresGrades
    *==========================================================================
    * Cria, VAZIOS, os cursores locais que alimentam grd_4c_SubNiveis e
    * grd_4c_Cupom. No legado eles ja existiam - a tela de movimentacao (form
    * pai) os montava na datasession COMPARTILHADA, e o SIGMVITS.SCX apenas
    * fazia "Set DataSession To pnDatSes" e os enxergava prontos. Como este
    * form usa DataSession = 2 (isolado), eles nascem aqui.
    *
    * Roda ANTES de qualquer RecordSource/ControlSource (MontaGrade): ligar
    * coluna a alias inexistente estoura "Alias is not found" dentro do TRY
    * do InicializarForm e o form nao chega a abrir (CLAUDE.md #41).
    *
    * SET NULL ON antes do CREATE CURSOR porque, quando a fase de eventos
    * popular estes cursores via APPEND FROM DBF()/SQLEXEC, coluna nullable
    * do SQL Server recusa o append num cursor declarado NOT NULL. Estado
    * anterior restaurado no fim, para nao vazar SET para o resto da
    * datasession.
    *
    * Estruturas transcritas do uso real no dump legado (comportamento.json)
    * e IDENTICAS as ja usadas no form irmao Formsigmvitn.prg (task571), que
    * tem o MESMO Cnt_Pendencia.GradeMultiSubN. Nomes de campo PRESERVADOS:
    * sao chave de ControlSource e aparecem literalmente nas expressoes
    * Locate/Replace/Seek das fases de evento.
    *==========================================================================
        LOCAL loc_cNullAnt
        loc_cNullAnt = SET("NULL")
        SET NULL ON

        *-- TmpOperacao: sub-niveis/pendencias vinculados a esta movimentacao
        *-- (grd_4c_SubNiveis - Cnt_Pendencia.GradeMultiSubN).
        IF !USED("TmpOperacao")
            CREATE CURSOR TmpOperacao ( ;
                Emps      C(3)     NULL, ;
                Dopes     C(20)    NULL, ;
                Numes     N(6, 0)  NULL, ;
                Codigos   N(10, 0) NULL, ;
                Notas     C(6)     NULL, ;
                Valos     N(11, 2) NULL, ;
                VlValVars N(11, 2) NULL, ;
                EmpSubns  C(29)    NULL, ;
                ChkSubn   L        NULL, ;
                Validado  L        NULL, ;
                Saida     L        NULL)
            INDEX ON STR(Codigos, 10) TAG Codigos
            SET ORDER TO
        ENDIF

        *-- crTpmMvItn: o CARRINHO - um registro por item lancado no cupom.
        *-- Espelha as colunas de SigMvItn que o legado referencia MAIS duas
        *-- que so existem no cursor local (nao estao na tabela): ImpCupFis
        *-- (marca item ja impresso no cupom fiscal, testada em
        *-- ok/Cancela/Pagto/Itens.Click) e LPrecos (lista de preco aplicada).
        *-- Entra na FASE 7 porque e nesta fase que os eventos dos botoes
        *-- passam a ler e escrever o carrinho (cancelar item, recalcular
        *-- totais, contar itens lancados); sem ele todo handler viraria um
        *-- no-op silencioso preso no IF !USED(...).
        IF !USED("crTpmMvItn")
            CREATE CURSOR crTpmMvItn ( ;
                citens     N(10, 0) NULL, ;
                cpros      C(14)    NULL, ;
                dpros      C(65)    NULL, ;
                cunis      C(3)     NULL, ;
                codbarras  N(14, 0) NULL, ;
                codlprecs  N(6, 0)  NULL, ;
                empdopnums C(29)    NULL, ;
                etiesps    L        NULL, ;
                fators     N(8, 3)  NULL, ;
                fatvals    N(15, 6) NULL, ;
                moedas     C(3)     NULL, ;
                moefats    C(3)     NULL, ;
                moevals    N(15, 6) NULL, ;
                notas      C(6)     NULL, ;
                opers      C(1)     NULL, ;
                pesos      N(9, 3)  NULL, ;
                qtds       N(9, 3)  NULL, ;
                totas      N(11, 2) NULL, ;
                units      N(15, 6) NULL, ;
                univals    N(15, 6) NULL, ;
                utilizas   N(4, 0)  NULL, ;
                valdescs   N(9, 2)  NULL, ;
                obs        M        NULL, ;
                ImpCupFis  L        NULL, ;
                LPrecos    N(6, 0)  NULL)
            INDEX ON STR(citens, 10) TAG citens
            INDEX ON cpros TAG cpros
            SET ORDER TO
        ENDIF

        *-- xPar: as parcelas/formas de pagamento lancadas. Espelha as colunas
        *-- de SigMvPar que o legado referencia MAIS cinco que so existem no
        *-- cursor local: nChaves (agrupador do lancamento, usado no "Delete
        *-- For nChaves = lnChv" do CancPagto), Infos e Acumulas (copias do
        *-- cadastro da forma, SigOpFp), pDescs (percentual de desconto
        *-- aplicado) e Bcds (bonus/credito acumulado na parcela).
        IF !USED("xPar")
            CREATE CURSOR xPar ( ;
                Emps       C(3)     NULL, ;
                Dopes      C(20)    NULL, ;
                Numes      N(6, 0)  NULL, ;
                Datas      D        NULL, ;
                Parcs      N(2, 0)  NULL, ;
                tParcs     N(2, 0)  NULL, ;
                Vencs      D        NULL, ;
                Valos      N(11, 2) NULL, ;
                VPags      N(11, 2) NULL, ;
                ValDescs   N(11, 2) NULL, ;
                pDescs     N(9, 4)  NULL, ;
                FPags      C(12)    NULL, ;
                MoeFPgs    C(3)     NULL, ;
                CotFPgs    N(11, 4) NULL, ;
                Trocos     N(1, 0)  NULL, ;
                Infos      C(1)     NULL, ;
                Acumulas   N(1, 0)  NULL, ;
                InsChs     L        NULL, ;
                Empos      C(3)     NULL, ;
                EmpDopNums C(29)    NULL, ;
                Outros     C(20)    NULL, ;
                Obs        M        NULL, ;
                Bancos     C(3)     NULL, ;
                Agencias   C(4)     NULL, ;
                Contas     C(10)    NULL, ;
                Numeros    C(6)     NULL, ;
                NumChqs    C(8)     NULL, ;
                DigAgencs  C(1)     NULL, ;
                DigChqs    C(1)     NULL, ;
                DigContas  C(1)     NULL, ;
                Pracas     C(3)     NULL, ;
                Cpfs       C(20)    NULL, ;
                cnIdTefs   C(10)    NULL, ;
                nIdCheps   N(10, 0) NULL, ;
                nChaves    N(6, 0)  NULL, ;
                Bcds       N(11, 2) NULL)
            INDEX ON STR(nChaves, 6) TAG nChaves
            SET ORDER TO
        ENDIF

        *-- crTpmMvItnC: as LINHAS de texto do cupom mostradas na grade do
        *-- cupom (grd_4c_Cupom - GrdCupom). Texto ate 90 chars (linha mais
        *-- longa do legado tem 85 - "@Z 9999" + identificacao(14) +
        *-- descricao(65) + separadores). Cores e o indice do DynamicForeColor
        *-- legado (0 item .. 4 troco) - mantido como coluna de controle.
        IF !USED("crTpmMvItnC")
            CREATE CURSOR crTpmMvItnC ( ;
                cItens N(10, 0) NULL, ;
                Linha  N(2, 0)  NULL, ;
                Texto  C(90)    NULL, ;
                Cores  N(1, 0)  NULL)
            INDEX ON STR(cItens, 4) TAG cItens
            SET ORDER TO
        ENDIF

        IF loc_cNullAnt = "OFF"
            SET NULL OFF
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE MontaGrade
    *==========================================================================
    * Liga grd_4c_SubNiveis e grd_4c_Cupom aos seus cursores (criados em
    * CriarCursoresGrades) e REAPLICA tudo o que o VFP9 reseta quando
    * RecordSource muda: Column.Width e Header1.Caption (Problema 48 /
    * CLAUDE.md #41). Por isso a ordem dentro de cada WITH e sempre a mesma
    * e NAO pode ser trocada: RecordSource -> ControlSource -> Width ->
    * Header1.Caption.
    *
    * grd_4c_FormasPag NAO entra aqui: o cursor "xParC" e um SELECT dinamico
    * montado dentro do Confirmar (Barra_Botoes.ok, fase de eventos) - nao
    * existe ainda nesta fase (ver comentario de ConfigurarGrdFormasPagamento).
    *==========================================================================
        LOCAL loc_oGrd

        loc_oGrd = THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
        loc_oGrd.RecordSource = "TmpOperacao"
        loc_oGrd.Column1.ControlSource = "TmpOperacao.Codigos"
        loc_oGrd.Column2.ControlSource = "TmpOperacao.Notas"
        loc_oGrd.Column3.ControlSource = "TmpOperacao.Valos"
        loc_oGrd.Column1.Width = 80
        loc_oGrd.Column2.Width = 80
        loc_oGrd.Column3.Width = 90
        loc_oGrd.Column1.Header1.Caption = "Pend" + CHR(234) + "ncias"
        loc_oGrd.Column2.Header1.Caption = "Notas"
        loc_oGrd.Column3.Header1.Caption = "Valor"

        loc_oGrd = THIS.cnt_4c_Grade.grd_4c_Cupom
        loc_oGrd.RecordSource = "crTpmMvItnC"
        loc_oGrd.Column1.ControlSource = "crTpmMvItnC.Texto"
        loc_oGrd.Column1.Width = 345
        loc_oGrd.Column1.Header1.Caption = "Header1"
    ENDPROC

    *==========================================================================
    * LOOKUPS (FASE 6/8) - handlers KeyPress (PUBLIC, exigido por BINDEVENT -
    * CLAUDE.md #3) + os metodos AbrirLookupXxx() que efetivamente abrem o
    * FormBuscaAuxiliar. Todos seguem o contrato canonico do projeto
    * (CLAUDE.md #37): Show() SO quando !this_lAchouRegistro, atribuicao SO
    * sob this_lSelecionou, e Release() sempre no final.
    *==========================================================================

    *==========================================================================
    PROCEDURE FpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupFormaPagamento()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupFormaPagamento
    *==========================================================================
    * Get_fpg (Cnt_Fpagto.cnt_forma.Get_fpg) - forma de pagamento (SigOpFp,
    * chave Fpags). No legado a validacao e feita contra um cursor local
    * (ccSigOpFp) ja carregado pelas operacoes permitidas; aqui a consulta e
    * direto na tabela, que e o dado de origem daquele cursor.
    *==========================================================================
        LOCAL loc_oCnt, loc_oBusca
        loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__forma

        IF !loc_oCnt.txt_4c_Fpg.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpFp", ;
            "cursor_4c_BuscaFpg", ;
            "fpags", ;
            ALLTRIM(loc_oCnt.txt_4c_Fpg.Value), ;
            "Forma de Pagamento")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("fpags", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")

            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
                SELECT cursor_4c_BuscaFpg
                loc_oCnt.txt_4c_Fpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
            ENDIF

            IF USED("cursor_4c_BuscaFpg")
                USE IN cursor_4c_BuscaFpg
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE AdquireKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupAdquirente()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupAdquirente
    *==========================================================================
    * get_adquire (Cnt_Fpagto.cntnsu.get_adquire) - adquirente do cartao
    * (SigCdCad, tipocads = 'ADQUIRENTE'). O legado busca pelo NOME
    * (descads), nao por codigo - o campo guarda o texto do adquirente, nao
    * um codigo (CreateObject('fwbuscaint','crCad','descads',...)).
    *==========================================================================
        LOCAL loc_oCnt, loc_oBusca
        loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c_nsu

        IF !loc_oCnt.txt_4c__adquire.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCad", ;
            "cursor_4c_BuscaAdq", ;
            "descads", ;
            ALLTRIM(loc_oCnt.txt_4c__adquire.Value), ;
            "Adquirente", .F., .T., "tipocads = " + EscaparSQL("ADQUIRENTE"))

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("descads", "", "Descri" + CHR(231) + CHR(227) + "o")

            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAdq")
                SELECT cursor_4c_BuscaAdq
                loc_oCnt.txt_4c__adquire.Value = ALLTRIM(cursor_4c_BuscaAdq.descads)
            ENDIF

            IF USED("cursor_4c_BuscaAdq")
                USE IN cursor_4c_BuscaAdq
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE TabdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupTabDesconto()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupTabDesconto
    *==========================================================================
    * Get_tabd (Cnt_Identifica.TabDesconto.Get_tabd) - tabela de desconto
    * (SigOpTdz, chave Codigos).
    *==========================================================================
        LOCAL loc_oCnt, loc_oBusca
        loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_TabDesconto

        IF !loc_oCnt.txt_4c_Tabd.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpTdz", ;
            "cursor_4c_BuscaTabd", ;
            "codigos", ;
            ALLTRIM(loc_oCnt.txt_4c_Tabd.Value), ;
            "Tabelas de Desconto")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")

            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
                SELECT cursor_4c_BuscaTabd
                loc_oCnt.txt_4c_Tabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
            ENDIF

            IF USED("cursor_4c_BuscaTabd")
                USE IN cursor_4c_BuscaTabd
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ListaPrecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupListaPreco()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupListaPreco
    *==========================================================================
    * Get_ListaPreco (Cnt_Identifica.TabDesconto.Get_ListaPreco) - lista de
    * precos (SigCdLpc). SigCdLpc NAO tem coluna de descricao separada -
    * lprecos (char 30) e ao mesmo tempo chave e nome, igual SigCdOpe.Dopes
    * (CLAUDE.md regra sobre tabelas single-column). O filtro por Tipos do
    * legado (crSigCdOpe.tplprecs) so entra quando o cursor da operacao
    * corrente ja estiver carregado - sem ele, a lista sai completa.
    *==========================================================================
        LOCAL loc_oCnt, loc_oBusca, loc_cFiltro

        loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_TabDesconto

        IF !loc_oCnt.txt_4c_ListaPreco.Enabled
            RETURN
        ENDIF

        loc_cFiltro = ""
        IF USED("crSigCdOpe")
            loc_cFiltro = IIF(crSigCdOpe.tplprecs = 2, "tipos = 'C'", "tipos <> 'C'")
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdLpc", ;
            "cursor_4c_BuscaLpc", ;
            "lprecos", ;
            ALLTRIM(loc_oCnt.txt_4c_ListaPreco.Value), ;
            "Listas de Pre" + CHR(231) + "o", .F., .T., loc_cFiltro)

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("lprecos", "", "Descri" + CHR(231) + CHR(227) + "o")

            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLpc")
                SELECT cursor_4c_BuscaLpc
                loc_oCnt.txt_4c_ListaPreco.Value = ALLTRIM(cursor_4c_BuscaLpc.lprecos)
            ENDIF

            IF USED("cursor_4c_BuscaLpc")
                USE IN cursor_4c_BuscaLpc
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * Identificacao de conta (Destino/Responsavel/Vendedor/Origem) - os 4
    * blocos criados por MontarBlocoIdentificacao() tem a MESMA estrutura de
    * campos, entao os handlers abaixo so mudam no NOME do bloco (par_cBloco)
    * passado a AbrirLookupGrupo/AbrirLookupConta/AbrirLookupContaPorCpf.
    *==========================================================================

    *==========================================================================
    PROCEDURE GrupoDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo("Destino")
        ENDIF
    ENDPROC

    PROCEDURE ContaDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta("Destino")
        ENDIF
    ENDPROC

    PROCEDURE CpfDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaPorCpf("Destino")
        ENDIF
    ENDPROC

    PROCEDURE GrupoResponsavelKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo("Responsavel")
        ENDIF
    ENDPROC

    PROCEDURE ContaResponsavelKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta("Responsavel")
        ENDIF
    ENDPROC

    PROCEDURE CpfResponsavelKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaPorCpf("Responsavel")
        ENDIF
    ENDPROC

    PROCEDURE GrupoVendedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo("Vendedor")
        ENDIF
    ENDPROC

    PROCEDURE ContaVendedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta("Vendedor")
        ENDIF
    ENDPROC

    PROCEDURE CpfVendedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaPorCpf("Vendedor")
        ENDIF
    ENDPROC

    PROCEDURE GrupoOrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo("Origem")
        ENDIF
    ENDPROC

    PROCEDURE ContaOrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta("Origem")
        ENDIF
    ENDPROC

    PROCEDURE CpfOrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaPorCpf("Origem")
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGrupo(par_cBloco)
    *==========================================================================
    * Get_grupo (Destino/Responsavel/Vendedor/Origem) - grupo de contas
    * (SigCdGrp, chave cgrus). par_cBloco identifica o container concreto
    * (cnt_4c_Destino/cnt_4c_Responsavel/cnt_4c_Vendedor/cnt_4c_Origem).
    *==========================================================================
        LOCAL loc_oCnt, loc_oBusca

        loc_oCnt = EVALUATE("THIS.cnt_4c__Identifica.cnt_4c_" + par_cBloco)

        IF !loc_oCnt.txt_4c_Grupo.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", ;
            "cursor_4c_BuscaGrupo", ;
            "cgrus", ;
            ALLTRIM(loc_oCnt.txt_4c_Grupo.Value), ;
            "Grupo de Contas")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")

            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                SELECT cursor_4c_BuscaGrupo
                loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
            ENDIF

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupConta(par_cBloco)
    *==========================================================================
    * Get_conta (Destino/Responsavel/Vendedor/Origem) - conta (SigCdCli,
    * chave Iclis). Ao selecionar, preenche tambem o Nome (txt_4c_Dconta),
    * igual ao legado (fAcessoContas preenchia This.Parent.Get_DConta junto).
    *==========================================================================
        LOCAL loc_oCnt, loc_oBusca

        loc_oCnt = EVALUATE("THIS.cnt_4c__Identifica.cnt_4c_" + par_cBloco)

        IF !loc_oCnt.txt_4c_Conta.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", ;
            "cursor_4c_BuscaConta", ;
            "iclis", ;
            ALLTRIM(loc_oCnt.txt_4c_Conta.Value), ;
            "Contas")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("rclis", "", "Nome")

            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                SELECT cursor_4c_BuscaConta
                loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.iclis)
                loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
            ENDIF

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupContaPorCpf(par_cBloco)
    *==========================================================================
    * Get_cpf (Destino/Responsavel/Vendedor/Origem) - localiza a conta pelo
    * CPF/CNPJ (SigCdCli, campo Cpfs). Ao selecionar, preenche Conta e Nome
    * junto - mesmo comportamento do legado (o Valid de Get_cpf resolvia
    * Conta+DConta a partir do documento digitado).
    *==========================================================================
        LOCAL loc_oCnt, loc_oBusca

        loc_oCnt = EVALUATE("THIS.cnt_4c__Identifica.cnt_4c_" + par_cBloco)

        IF !loc_oCnt.txt_4c_Cpf.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", ;
            "cursor_4c_BuscaCpf", ;
            "cpfs", ;
            ALLTRIM(loc_oCnt.txt_4c_Cpf.Value), ;
            "Contas")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("cpfs", "", "CPF/CNPJ")
            loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("rclis", "", "Nome")

            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
                SELECT cursor_4c_BuscaCpf
                loc_oCnt.txt_4c_Cpf.Value    = ALLTRIM(cursor_4c_BuscaCpf.cpfs)
                loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCpf.iclis)
                loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCpf.rclis)
            ENDIF

            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES
    *==========================================================================
    * Todos os handlers ligados por BINDEVENT sao PUBLIC (sem PROTECTED):
    * metodo PROTECTED falha em SILENCIO no BINDEVENT (CLAUDE.md #3).
    *
    * SIGMVITS.SCX nao tem os 6 botoes CRUD canonicos (Incluir/Visualizar/
    * Alterar/Excluir/Buscar/Encerrar) nem pagina de Lista: e uma tela de
    * Caixa (frente de venda). Os "eventos principais" desta fase sao,
    * portanto, os Click dos 16 botoes que o legado REALMENTE tem na
    * Barra_Botoes, mais os botoes das telas de operacao, o KeyPress do form
    * (KeyPreview = .T., que e o atalho de teclado de cada um deles) e o
    * Timer da barra de titulo. Inventar botoes CRUD aqui violaria o PILAR 1.
    *==========================================================================

    *--------------------------------------------------------------------------
    * AlternarTelaOperacao - mostra EXATAMENTE um dos quatro containers de
    * operacao e esconde os outros tres. No legado cada Click comeca zerando a
    * visibilidade dos irmaos antes de mostrar o proprio (identifica.Click:
    * "ThisForm.CntItem.Visible=.f. / ThisForm.CntGrade.Visible=.f. /
    * Thisform.Cnt_pendencia.Visible=.f. / ThisForm.Cnt_fpagto.Visible=.f.").
    * Sem este metodo os quatro nascem Visible=.T. (Fases 3-6) empilhados na
    * mesma area da tela.
    *
    * cnt_4c_Grade (a grade do cupom) acompanha ITENS e FPAGTO - e o que o
    * legado faz ("ThisForm.CntGrade.Visible = .t." no fim de Itens.Click e de
    * Pagto.Click; identifica.Click a esconde).
    *
    * cnt_4c_CancelaItem e um painel sobreposto (aparece por cima da tela
    * ativa) - trocar de tela fecha ele, igual ao CancelaDisp legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarTelaOperacao(par_cTela)
        LOCAL loc_cTela
        loc_cTela = UPPER(ALLTRIM(par_cTela))

        THIS.this_cTelaAtual = loc_cTela

        THIS.cnt_4c_Item.Visible        = (loc_cTela == "ITENS")
        THIS.cnt_4c__Pendencia.Visible  = (loc_cTela == "PENDENCIA")
        THIS.cnt_4c__Identifica.Visible = (loc_cTela == "IDENTIFICA")
        THIS.cnt_4c__Fpagto.Visible     = (loc_cTela == "FPAGTO")

        THIS.cnt_4c_Grade.Visible = (loc_cTela == "ITENS" OR loc_cTela == "FPAGTO")

        IF loc_cTela != "ITENS"
            THIS.cnt_4c_CancelaItem.Visible = .F.
            THIS.cnt_4c_Item.Enabled        = .T.
        ENDIF

        *-- O container mostrado tem de ficar POR CIMA: os quatro ocupam a
        *-- mesma regiao e a ordem de AddObject define o z-order inicial
        *-- (legado: ".ZOrder(0)" no fim de cada Click).
        DO CASE
            CASE loc_cTela == "ITENS"
                THIS.cnt_4c_Item.ZOrder(0)
            CASE loc_cTela == "PENDENCIA"
                THIS.cnt_4c__Pendencia.ZOrder(0)
            CASE loc_cTela == "IDENTIFICA"
                THIS.cnt_4c__Identifica.ZOrder(0)
            CASE loc_cTela == "FPAGTO"
                THIS.cnt_4c__Fpagto.ZOrder(0)
        ENDCASE

        *-- Quem desabilita botao tem de reabilitar no FUNIL de volta: toda
        *-- troca de tela passa por aqui, entao o gate dos botoes e reaplicado
        *-- num lugar so e nao em cada Click (CLAUDE.md #40).
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - gate de disponibilidade dos botoes da barra,
    * transcrito dos blocos "Barra_Botoes.<X>.Enabled = ..." que o legado
    * repete no fim de CADA Click:
    *
    *   Itens.Click    -> Apaga/Alteraqtd/AltPreco .T. ; CancPagto/Desconto/
    *                     Acrescimo .F.
    *   Pagto.Click    -> CancPagto .T. ; Apaga/Alteraqtd/AltPreco .F. ;
    *                     Desconto/Acrescimo liberados (crSigCdOpe.Vars = 1)
    *   identifica/pendencia/credito/Financia.Click -> os seis .F.
    *
    * O legado condiciona Desconto/Acrescimo a crSigCdOpe.Vars = 1 e a
    * fChecaAcesso(...,"ACRESCIMO"); crSigCdOpe vive na datasession do form
    * pai (aqui DataSession = 2) e por isso e lido sob USED() - ausente, o
    * comportamento fica LIBERADO, como na operacao padrao, em vez de travar
    * a tela.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lItens, loc_lFpagto, loc_lVars, loc_oBarra

        loc_oBarra  = THIS.cnt_4c_Barra_Botoes
        loc_lItens  = (THIS.this_cTelaAtual == "ITENS")
        loc_lFpagto = (THIS.this_cTelaAtual == "FPAGTO")

        loc_lVars = .T.
        IF USED("crSigCdOpe")
            loc_lVars = (NVL(crSigCdOpe.Vars, 1) = 1)
        ENDIF

        loc_oBarra.cmd_4c_Apaga.Enabled     = loc_lItens
        loc_oBarra.cmd_4c_Alteraqtd.Enabled = loc_lItens
        loc_oBarra.cmd_4c_AltPreco.Enabled  = loc_lItens

        loc_oBarra.cmd_4c_CancPagto.Enabled = loc_lFpagto
        loc_oBarra.cmd_4c_Desconto.Enabled  = (loc_lFpagto AND loc_lVars)
        loc_oBarra.cmd_4c_Acrescimo.Enabled = (loc_lFpagto AND loc_lVars)

        *-- Impfiscal: o legado desliga o monitor da impressora tao logo o
        *-- cupom e aberto ("Barra_Botoes.Impfiscal.Enabled = .f." em
        *-- Itens/Pagto/identifica/pendencia.Click).
        loc_oBarra.cmd_4c_Impfiscal.Enabled = !THIS.this_lIniciou

        *-- Itens/Pagto/Identifica/Pendencia/Confirmar/Cancelar ficam sempre
        *-- disponiveis: no legado o gate deles e o When (Inicia/LiberaIdent),
        *-- que o BINDEVENT nao reproduz - o retorno de um When delegado e
        *-- DESCARTADO (CLAUDE.md #3). Por isso a mesma condicao do When e
        *-- checada DENTRO de cada Click, no inicio.
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarControle - SetFocus protegido. Falha de SetFocus aqui e sempre
    * problema de TIMING (controle que acabou de ficar invisivel no mesmo
    * ciclo de evento), nunca perda de dado: exibir MsgErro por causa de foco
    * de teclado seria pior do que nao exibir nada. E o unico CATCH silencioso
    * do form, e e silencioso de proposito.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FocarControle(par_oControle)
        LOCAL loc_oErro
        TRY
            IF VARTYPE(par_oControle) = "O" AND par_oControle.Visible AND par_oControle.Enabled
                par_oControle.SetFocus
            ENDIF
        CATCH TO loc_oErro
            * silencioso de proposito - ver comentario do metodo.
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ExibirMensagem - escreve na barra de mensagem do rodape
    * (Cnt_Mensagem.Mensagem no legado, usada em Itens/Pagto.Click:
    * "ThisForm.Cnt_mensagem.Mensagem.Caption = ' '").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExibirMensagem(par_cTexto)
        THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = par_cTexto
        THIS.cnt_4c__Mensagem.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * HaPagamentoPendente - .T. quando ha forma de pagamento lancada em xPar
    * ainda nao inserida. Transcricao da guarda que o legado repete em
    * Itens/Financia/pendencia/credito.Click: "Count to wxpar for Valos > 0
    * and not Empty(fpags) And Not xPar.InsChs / If wxpar > 0 /
    * MessageBox('Favor Excluir as Condicoes de Pagamento!!!')".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION HaPagamentoPendente()
        LOCAL loc_nQt, loc_nAreaAnt
        loc_nQt = 0

        IF USED("xPar")
            loc_nAreaAnt = SELECT()
            SELECT xPar
            COUNT FOR NVL(Valos, 0) > 0 AND !EMPTY(NVL(FPags, "")) AND !NVL(InsChs, .F.) ;
                AND !DELETED() TO loc_nQt
            IF loc_nAreaAnt > 0
                SELECT (loc_nAreaAnt)
            ENDIF
        ENDIF

        RETURN (loc_nQt > 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    * HaFormaPagamentoEmAberto - .T. quando o campo Forma de Pagamento esta
    * preenchido, isto e, ha lancamento de pagamento EM ANDAMENTO. Guarda
    * literal do legado ("If Not Empty(Cnt_Fpagto.cnt_forma.get_fpg.Value) /
    * Return 0") no inicio de Itens/Financia/pendencia/credito/identifica.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION HaFormaPagamentoEmAberto()
        RETURN !EMPTY(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg.Value)
    ENDFUNC

    *--------------------------------------------------------------------------
    * HaItemNaoImpresso - .T. quando existe item no carrinho que ainda nao foi
    * impresso no cupom fiscal. Guarda do legado em ok/Cancela/Pagto.Click:
    * "Locate For Not ImpCupFis And Not Empty(Cpros) / If Not Eof() And
    * Barra_Botoes.Itens.Enabled / MessageBox('Obrigatorio Impressao dos
    * Itens... Click <F2>')".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION HaItemNaoImpresso()
        LOCAL loc_lAchou, loc_nAreaAnt
        loc_lAchou = .F.

        IF USED("crTpmMvItn")
            loc_nAreaAnt = SELECT()
            SELECT crTpmMvItn
            LOCATE FOR !NVL(ImpCupFis, .F.) AND !EMPTY(NVL(cpros, ""))
            loc_lAchou = !EOF()
            IF loc_nAreaAnt > 0
                SELECT (loc_nAreaAnt)
            ENDIF
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *--------------------------------------------------------------------------
    * ContarItensLancados - quantas linhas do carrinho tem produto. O carrinho
    * mantem sempre uma linha EM BRANCO aberta para o proximo item
    * (LimparCamposItem), que nao conta como venda. Legado: "Count to
    * lnContaItems For Not IsEmpty( crTpmMvItn.Cpros )".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ContarItensLancados()
        LOCAL loc_nQt, loc_nAreaAnt
        loc_nQt = 0

        IF USED("crTpmMvItn")
            loc_nAreaAnt = SELECT()
            SELECT crTpmMvItn
            COUNT FOR !EMPTY(NVL(cpros, "")) AND !DELETED() TO loc_nQt
            IF loc_nAreaAnt > 0
                SELECT (loc_nAreaAnt)
            ENDIF
        ENDIF

        RETURN loc_nQt
    ENDFUNC

    *--------------------------------------------------------------------------
    * HaSubNivelInformado - .T. quando ha pendencia/sub-nivel selecionado.
    * Legado (repetido em ok/Cancela/Pagto/Itens/pendencia.Click): "Select
    * TmpOperacao / llSubNivel = .f. / Scan for !IsEmpty( Codigos ) /
    * llSubNivel = .t. / EndScan".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION HaSubNivelInformado()
        LOCAL loc_nQt, loc_nAreaAnt
        loc_nQt = 0

        IF USED("TmpOperacao")
            loc_nAreaAnt = SELECT()
            SELECT TmpOperacao
            COUNT FOR NVL(Codigos, 0) > 0 AND !DELETED() TO loc_nQt
            IF loc_nAreaAnt > 0
                SELECT (loc_nAreaAnt)
            ENDIF
        ENDIF

        RETURN (loc_nQt > 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCamposItem - equivalente ao mLimpaCntItem(plInsere) do legado:
    * com par_lInsere, remove do carrinho as linhas em branco, renumera o
    * proximo item e abre UMA linha nova em branco; depois zera os oito campos
    * do bloco de digitacao do item.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCamposItem(par_lInsere)
        LOCAL loc_nMax, loc_lInsere
        loc_lInsere = IIF(VARTYPE(par_lInsere) = "L", par_lInsere, .F.)

        IF loc_lInsere AND USED("crTpmMvItn")
            SELECT crTpmMvItn
            SET ORDER TO
            GO TOP
            DELETE FOR EMPTY(NVL(cpros, ""))

            *-- Legado: "ThisForm.Citem = Iif(UltimoCancel > Max(Citens),
            *-- UltimoCancel, Max(Citens)) + 1". O Max e apurado por SCAN e
            *-- nao por SELECT ... INTO CURSOR para nao trocar a area de
            *-- trabalho corrente no meio do metodo.
            loc_nMax = 0
            SCAN FOR !EMPTY(NVL(cpros, "")) AND !DELETED()
                IF NVL(citens, 0) > loc_nMax
                    loc_nMax = NVL(citens, 0)
                ENDIF
            ENDSCAN

            THIS.this_nCItem = MAX(THIS.this_nUltimoCancel, loc_nMax) + 1

            INSERT INTO crTpmMvItn (citens) VALUES (THIS.this_nCItem)
            SELECT crTpmMvItn
            SET ORDER TO
        ENDIF

        WITH THIS.cnt_4c_Item
            .cnt_4c__Prod.txt_4c_Produto.Value    = ""
            .cnt_4c__Qtd.txt_4c_Qtds.Value        = 0
            .cnt_4c__val.txt_4c_Valor.Value       = 0
            .cnt_4c__ValU.txt_4c_Unival.Value     = 0
            .cnt_4c__vdesc.txt_4c_Valdesc.Value   = 0
            .cnt_4c__pDesc.txt_4c_Pvaldesc.Value  = 0
            .cnt_4c__vacre.txt_4c_ValAcre.Value   = 0
            .cnt_4c__pacre.txt_4c__pValAcre.Value = 0
            .cnt_4c__Prod.txt_4c_Produto.Refresh()
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularTotais - refaz os totais exibidos, a partir do CARRINHO local
    * (crTpmMvItn) e das parcelas lancadas (xPar). Reune tres metodos do
    * legado que fazem a mesma conta em lugares diferentes:
    *
    *   calcsubt   -> "Sum(qtds*units) to cntGrade.cnt_subt.get_Total.Value"
    *   Total_item -> TotIte = fTotalizarItn(...) em cntGrade.cnt_tots
    *   AtuaTotal  -> TprMvCab.valinis + frete + seguro + despesa acessoria
    *
    * AtuaTotal do legado soma frete/seguro/despesa de CrSigMvNfi, cursor do
    * form pai: com DataSession = 2 ele nao existe aqui, e o total e o dos
    * itens - as tres parcelas acessorias entram na tela de movimentacao.
    *
    * "Popular cursor NAO repinta a grade": o legado sempre fecha com Go Top +
    * Refresh, e e por isso que o Refresh das grades vem no fim (CLAUDE.md
    * #21a).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularTotais()
        LOCAL loc_nSubTotal, loc_nTotal, loc_nFormas
        LOCAL loc_nDesc, loc_nAcre, loc_nDescP, loc_nLiquido

        loc_nSubTotal = 0
        loc_nTotal    = 0
        loc_nFormas   = 0

        IF USED("crTpmMvItn")
            SELECT crTpmMvItn
            *-- Ordem canonica do SUM: FOR vem ANTES do TO.
            SUM NVL(qtds, 0) * NVL(units, 0) FOR !DELETED() TO loc_nSubTotal
            SUM NVL(totas, 0) FOR !DELETED() TO loc_nTotal
            GO TOP
        ENDIF

        *-- O legado usa Totas (valor do item ja com desconto/acrescimo) no
        *-- Total Geral e qtds*units no Subtotal. Carrinho recem-aberto tem
        *-- Totas zerado - nesse caso o Total Geral acompanha o Subtotal, para
        *-- nao exibir 0,00 com itens na tela.
        IF loc_nTotal = 0
            loc_nTotal = loc_nSubTotal
        ENDIF

        THIS.cnt_4c_Grade.cnt_4c__subt.txt_4c_Total.Value = loc_nSubTotal
        THIS.cnt_4c_Grade.cnt_4c__tots.txt_4c_Total.Value = loc_nTotal
        THIS.this_nTotIte = loc_nTotal

        IF USED("xPar")
            SELECT xPar
            *-- Forma com Trocos = 1 ABATE (legado: "ctotal = Round(ctotal -
            *-- (valos * cotfpgs), 2)"), as demais SOMAM.
            SUM ROUND(NVL(Valos, 0) * NVL(CotFPgs, 1) * IIF(NVL(Trocos, 0) = 1, -1, 1), 2) ;
                FOR !DELETED() TO loc_nFormas
            GO BOTTOM
        ENDIF

        WITH THIS.cnt_4c__Fpagto
            loc_nDesc  = .cnt_4c_Desconto.txt_4c_TotVariacao.Value
            loc_nAcre  = .cnt_4c_Acrescimo.txt_4c_TotVariacao.Value
            loc_nDescP = .cnt_4c__descp.txt_4c_Tvariacao.Value

            loc_nLiquido = loc_nTotal + loc_nAcre - loc_nDesc - loc_nDescP

            .cnt_4c__tot.txt_4c_Valinic.Value      = loc_nTotal
            .cnt_4c__saldo.txt_4c_TotLiquido.Value = loc_nLiquido
            .cnt_4c__pag.txt_4c_TotForma.Value     = loc_nFormas
            .cnt_4c__apag.txt_4c_Saldo.Value       = loc_nLiquido - loc_nFormas
            .Refresh()
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Refresh()
        THIS.cnt_4c_Grade.grd_4c_Cupom.Refresh()
    ENDPROC

    *==========================================================================
    * HANDLERS - BARRA DE BOTOES PRINCIPAL (cnt_4c_Barra_Botoes)
    *==========================================================================

    *--------------------------------------------------------------------------
    * [F2] Itens (cmd_4c_Itens) - volta para a tela de lancamento de itens.
    *
    * Legado (Barra_Botoes.Itens.Click, 316 linhas): as duas guardas de
    * entrada (pagamento lancado / forma de pagamento em aberto), abertura do
    * cupom fiscal (IniciarCupom/GerarCupom), IMPRESSAO de cada item no ECF
    * (VenFis/RotStatus/VerSubt no driver da impressora), recalculo dos
    * totais, gate dos botoes, troca de tela e foco no campo Produto.
    *
    * O bloco de IMPRESSAO nao tem equivalente nesta migracao: VenFis/
    * RotStatus/VerSubt/LeituraNoCupom sao funcoes do driver do ECF fisico do
    * caixa (DECLARE DLL no legado) e nao vieram no acervo. Criar stub que
    * devolve "impresso com sucesso" marcaria ImpCupFis = .T. sem nada ter
    * sido impresso - exatamente a mentira silenciosa que a regra #27 do
    * CLAUDE.md proibe. A abertura/emissao fiscal continua sendo da tela de
    * movimentacao (form pai), que e quem fala com a impressora.
    *--------------------------------------------------------------------------
    PROCEDURE CmdItensClick()
        IF THIS.HaPagamentoPendente()
            MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", "Itens")
            RETURN
        ENDIF

        IF THIS.HaFormaPagamentoEmAberto()
            RETURN
        ENDIF

        THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto.Enabled = .T.
        THIS.ExibirMensagem(" ")

        THIS.AlternarTelaOperacao("ITENS")

        *-- Legado: as duas imagens (produto/empresa) voltam a aparecer ao
        *-- entrar na tela de itens e sao escondidas no Pagto.Click.
        THIS.cnt_4c_Item.cnt_4c__imgProd.Visible = .T.
        THIS.cnt_4c_Item.cnt_4c__ImgEmp.Visible  = .T.

        THIS.LimparCamposItem(.T.)
        THIS.RecalcularTotais()

        THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto)
    ENDPROC

    *--------------------------------------------------------------------------
    * [F3] Qtde (cmd_4c_Alteraqtd) - legado (9 linhas): "If Empty(Get_produto.
    * Value) / lAlteraqtd = .t. / Get_qtds.SetFocus / Else / Get_Produto.
    * SetFocus / Endif".
    *--------------------------------------------------------------------------
    PROCEDURE CmdAlteraqtdClick()
        LOCAL loc_oProd
        loc_oProd = THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto

        IF EMPTY(loc_oProd.Value)
            THIS.this_lAlteraQtd = .T.
            THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Qtd.txt_4c_Qtds)
        ELSE
            THIS.FocarControle(loc_oProd)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * [F3] Descon. (cmd_4c_Desconto) - legado (40 linhas): consulta a SITUACAO
    * da conta (destino e origem) em SigCdCli/SigCdCst e BLOQUEIA o desconto
    * quando SigCdCst.BlqDescs = 1; bloqueia tambem se ja houver acrescimo
    * informado ou o painel de acrescimo aberto; senao abre o painel de
    * desconto e o Saldo Final.
    *--------------------------------------------------------------------------
    PROCEDURE CmdDescontoClick()
        LOCAL loc_lOk

        loc_lOk = .T.

        IF THIS.DescontoBloqueadoPorSituacao()
            loc_lOk = .F.
        ENDIF

        IF THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.txt_4c_TotVariacao.Value > 0
            MsgAviso("Acr" + CHR(233) + "scimo j" + CHR(225) + " Informado. N" + CHR(227) + ;
                "o pode haver Desconto!!!", "Desconto")
            loc_lOk = .F.
        ENDIF

        IF THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.Visible
            loc_lOk = .F.
        ENDIF

        IF loc_lOk
            THIS.this_lValidaDesconto = .T.
            WITH THIS.cnt_4c__Fpagto
                .cnt_4c_Desconto.Visible                 = .T.
                .cnt_4c_Desconto.Enabled                 = .T.
                .cnt_4c__saldo.txt_4c_TotLiquido.Visible = .T.
            ENDWITH
            THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_TotVariacao)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DescontoBloqueadoPorSituacao - transcricao das duas consultas do
    * Desconto.Click legado: a situacao (SigCdCli.Situas) da conta DESTINO e
    * da conta ORIGEM e procurada em SigCdCst e, com BlqDescs = 1, o desconto
    * e bloqueado com a mensagem "<situacao> - <descricao> / Desconto
    * Bloqueado Pela Situacao da Conta".
    *
    * O legado le a conta de TprMvCab (cursor do form pai). Aqui as contas vem
    * dos campos da propria tela (blocos Destino/Origem de cnt_4c__Identifica),
    * que e o mesmo dado; sem conta informada nao ha o que checar.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION DescontoBloqueadoPorSituacao()
        LOCAL loc_lBloqueia, loc_cDestino, loc_cOrigem

        loc_lBloqueia = .F.
        loc_cDestino  = ALLTRIM(THIS.cnt_4c__Identifica.cnt_4c_Destino.txt_4c_Conta.Value)
        loc_cOrigem   = ALLTRIM(THIS.cnt_4c__Identifica.cnt_4c_Origem.txt_4c_Conta.Value)

        IF !EMPTY(loc_cDestino)
            loc_lBloqueia = THIS.ContaBloqueiaDesconto(loc_cDestino)
        ENDIF

        IF !loc_lBloqueia AND !EMPTY(loc_cOrigem)
            loc_lBloqueia = THIS.ContaBloqueiaDesconto(loc_cOrigem)
        ENDIF

        RETURN loc_lBloqueia
    ENDFUNC

    *--------------------------------------------------------------------------
    * ContaBloqueiaDesconto - uma conta. O legado faz em duas etapas
    * (CursorQuery SigCdCli -> CursorQuery SigCdCst); aqui o JOIN resolve as
    * duas de uma vez, contra as MESMAS tabelas e colunas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ContaBloqueiaDesconto(par_cConta)
        LOCAL loc_lBloqueia, loc_cSQL, loc_nRes, loc_cDesc, loc_oErro

        loc_lBloqueia = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT b.Codigos, b.Descrs, b.Descr2s, b.BlqDescs " + ;
                "FROM SigCdCli a " + ;
                "INNER JOIN SigCdCst b ON b.Codigos = a.Situas " + ;
                "WHERE a.Iclis = " + EscaparSQL(par_cConta)

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SitConta")

            IF loc_nRes > 0 AND USED("cursor_4c_SitConta")
                SELECT cursor_4c_SitConta
                IF RECCOUNT("cursor_4c_SitConta") > 0
                    GO TOP
                    IF NVL(cursor_4c_SitConta.BlqDescs, 0) = 1
                        loc_cDesc = ALLTRIM(NVL(cursor_4c_SitConta.Descr2s, ""))
                        IF EMPTY(loc_cDesc)
                            loc_cDesc = ALLTRIM(NVL(cursor_4c_SitConta.Descrs, ""))
                        ENDIF

                        MsgAviso(ALLTRIM(NVL(cursor_4c_SitConta.Codigos, "")) + " - " + loc_cDesc + CHR(13) + ;
                            "Desconto Bloqueado Pela Situa" + CHR(231) + CHR(227) + "o da Conta", ;
                            "Situa" + CHR(231) + CHR(227) + CHR(227))
                        loc_lBloqueia = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_SitConta")
                USE IN cursor_4c_SitConta
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao checar situa" + CHR(231) + CHR(227) + "o da conta")
        ENDTRY

        RETURN loc_lBloqueia
    ENDFUNC

    *--------------------------------------------------------------------------
    * [Ctrl+F3] Acrescimo (cmd_4c_Acrescimo) - legado (24 linhas): bloqueia se
    * ja houver desconto informado ou o painel de desconto aberto; senao abre
    * o painel de acrescimo e o Saldo Final.
    *--------------------------------------------------------------------------
    PROCEDURE CmdAcrescimoClick()
        LOCAL loc_lOk
        loc_lOk = .T.

        IF THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_TotVariacao.Value > 0
            MsgAviso("Desconto Informado. N" + CHR(227) + "o pode haver Acr" + CHR(233) + "scimo!!!", ;
                "Acr" + CHR(233) + "scimo")
            loc_lOk = .F.
        ENDIF

        IF THIS.cnt_4c__Fpagto.cnt_4c_Desconto.Visible
            loc_lOk = .F.
        ENDIF

        IF loc_lOk
            THIS.this_lValidaDesconto = .T.
            WITH THIS.cnt_4c__Fpagto
                .cnt_4c_Acrescimo.Visible                = .T.
                .cnt_4c_Acrescimo.Enabled                = .T.
                .cnt_4c__saldo.txt_4c_TotLiquido.Visible = .T.
            ENDWITH
            THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.txt_4c_TotVariacao)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * [F4] Canc (cmd_4c_CancPagto) - cancela a forma de pagamento lancada.
    *
    * Legado (Barra_Botoes.CancPagto.Click, 184 linhas): quando a forma e de
    * CARTAO (crSigOpFp.cCupomNvs = 'TEF'), consulta o gateway TEF no arquivo
    * local SigTef, chama TefImpr/VerifGP (driver do pinpad), grava
    * SigFiTef.cStatus = 'CNC' e so entao apaga a parcela; nas demais formas
    * apaga direto ("Delete For nChaves = lnChv" quando CrSigOpCdd.VarPs = 1,
    * senao "Delete"). No fim recalcula o total das formas, limpa os campos da
    * forma e devolve o foco.
    *
    * O trecho de TEF depende do pinpad fisico e de TefImpr/VerifGP/
    * DeleteSigTef (driver, nao portadas) - fica na tela de movimentacao, que
    * e quem conversa com o gateway. Aqui a parcela LOCAL e removida junto com
    * as demais da mesma chave de lancamento (nChaves), que e o caminho do
    * legado para forma NAO-cartao, e a pendencia no gateway e AVISADA ao
    * operador em vez de ser simulada em silencio (CLAUDE.md #27).
    *--------------------------------------------------------------------------
    PROCEDURE CmdCancPagtoClick()
        LOCAL loc_nChave, loc_cIdTef

        IF !THIS.cnt_4c__Fpagto.Visible
            RETURN
        ENDIF

        IF !USED("xPar")
            RETURN
        ENDIF

        SELECT xPar
        GO BOTTOM
        IF EOF() OR EMPTY(NVL(xPar.FPags, ""))
            THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
            RETURN
        ENDIF

        loc_nChave = NVL(xPar.nChaves, 0)
        loc_cIdTef = ALLTRIM(NVL(xPar.cnIdTefs, ""))

        IF !EMPTY(loc_cIdTef)
            MsgAviso("Esta forma de pagamento tem transa" + CHR(231) + CHR(227) + "o de cart" + CHR(227) + ;
                "o (TEF) associada." + CHR(13) + ;
                "O cancelamento no gateway TEF depende do pinpad do caixa e deve ser " + ;
                "feito na tela de movimenta" + CHR(231) + CHR(227) + "o.", "Cancelar Pagamento")
            THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
            RETURN
        ENDIF

        SELECT xPar
        DELETE FOR NVL(nChaves, 0) = loc_nChave
        GO BOTTOM

        WITH THIS.cnt_4c__Fpagto.cnt_4c__forma
            .txt_4c_Fpg.Value             = ""
            .txt_4c_Npar.Value            = 0
            .txt_4c_Vpar.Value            = 0
            .txt_4c_Fweditdata_venc.Value = {}
            .Visible     = .T.
        ENDWITH

        THIS.RecalcularTotais()
        THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
    ENDPROC

    *--------------------------------------------------------------------------
    * [F4] Canc (cmd_4c_Apaga) - cancelamento de ITEM.
    *
    * Legado (Barra_Botoes.apaga.Click, 45 linhas): com cupom fiscal (CupFis
    * em 1/5/6) abre o painel CancelaItem preenchido com o ULTIMO item
    * (Citem - 1); sem cupom fiscal apaga a linha direto do carrinho,
    * renumera os itens e devolve o foco. Os dois caminhos estao aqui; sem
    * crSigCdOpe (cursor do form pai) vale o do caixa fiscal, que e o unico
    * que pede confirmacao antes de apagar.
    *--------------------------------------------------------------------------
    PROCEDURE CmdApagaClick()
        LOCAL loc_nItem, loc_nCupFis, loc_nCont, loc_lAchou

        IF !EMPTY(THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto.Value)
            RETURN
        ENDIF

        IF !USED("crTpmMvItn")
            RETURN
        ENDIF

        loc_nCupFis = 1
        IF USED("crSigCdOpe")
            loc_nCupFis = NVL(crSigCdOpe.CupFis, 1)
        ENDIF

        IF INLIST(loc_nCupFis, 1, 5, 6)
            *-- Caminho do caixa fiscal: painel de cancelamento de item.
            SELECT crTpmMvItn
            SET ORDER TO
            loc_nItem = THIS.this_nCItem - 1

            LOCATE FOR NVL(citens, 0) = loc_nItem
            loc_lAchou = !EOF()
            IF !loc_lAchou
                loc_nItem = 0
            ENDIF

            WITH THIS.cnt_4c_CancelaItem
                .txt_4c_Item.Value    = loc_nItem
                .txt_4c_Produto.Value = IIF(loc_lAchou, ALLTRIM(NVL(crTpmMvItn.cpros, "")), "")
                .txt_4c__dpro.Value   = IIF(loc_lAchou, ALLTRIM(NVL(crTpmMvItn.dpros, "")), "")
                .txt_4c_Cbarra.Value  = IIF(loc_lAchou, ;
                    ALLTRIM(TRANSFORM(NVL(crTpmMvItn.codbarras, 0))), "")
                .Visible              = .T.
                .ZOrder(0)
                .Refresh()
            ENDWITH

            THIS.cnt_4c_Item.Enabled = .F.
            THIS.FocarControle(THIS.cnt_4c_CancelaItem.txt_4c_Item)
        ELSE
            *-- Caminho sem cupom fiscal: apaga a linha e renumera.
            SELECT crTpmMvItn
            IF !EMPTY(NVL(cpros, ""))
                DELETE
            ENDIF

            loc_nCont = 0
            SCAN FOR !DELETED()
                loc_nCont = loc_nCont + 1
                REPLACE citens WITH loc_nCont IN crTpmMvItn
            ENDSCAN
            THIS.this_nCItem = loc_nCont

            THIS.LimparCamposItem(.T.)
            THIS.RecalcularTotais()

            IF THIS.cnt_4c_Item.Visible
                THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto)
            ELSE
                THIS.FocarControle(THIS.cnt_4c_Barra_Botoes.cmd_4c_Ok)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * [F5] Alt.$ (cmd_4c_AltPreco) - legado (9 linhas): "If Not
    * IsEmpty(crTpmMvItn.CPros) / lAlteraValor = .t. / Get_ValDesc.Value = 0 /
    * Get_PValDesc.Value = 0 / Cnt_val.Get_Valor.SetFocus / EndIf".
    *--------------------------------------------------------------------------
    PROCEDURE CmdAltPrecoClick()
        IF !USED("crTpmMvItn")
            RETURN
        ENDIF

        SELECT crTpmMvItn
        IF EMPTY(NVL(crTpmMvItn.cpros, ""))
            RETURN
        ENDIF

        THIS.this_lAlteraValor = .T.
        WITH THIS.cnt_4c_Item
            .cnt_4c__vdesc.txt_4c_Valdesc.Value  = 0
            .cnt_4c__pDesc.txt_4c_Pvaldesc.Value = 0
            .Visible     = .T.
        ENDWITH

        THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__val.txt_4c_Valor)
    ENDPROC

    *--------------------------------------------------------------------------
    * [F6] Identif. (cmd_4c_Identifica) - abre a tela de identificacao das
    * contas (Origem/Destino/Vendedor/Responsavel).
    *
    * Legado (Barra_Botoes.identifica.Click, 167 linhas): guarda de forma de
    * pagamento em aberto; esconde as outras telas; zera o gate dos botoes;
    * libera a edicao de Origem/Destino quando ainda nao ha sub-nivel nem
    * devolucao lancados; CARREGA nome e CPF das quatro contas via SELECT em
    * SigCdCli; e escolhe qual campo recebe o foco, na ordem Documento ->
    * Pedido -> Tab.Desconto -> Lista de Precos -> Origem -> Destino ->
    * Vendedor -> Responsavel -> Proximo.
    *
    * A cascata de foco do legado e decidida por 12 flags de crSigCdOpe
    * (FixGOrigs/FixCOrigs/FixGDests/.../Numeras/PedClis/TabDescs/LPrecos),
    * cursor do form pai. Sob DataSession = 2 essas flags nao existem aqui: a
    * ordem e mantida, mas testando a VISIBILIDADE e o preenchimento de cada
    * campo, que e o efeito pratico daquelas flags nesta tela.
    *--------------------------------------------------------------------------
    PROCEDURE CmdIdentificaClick()
        IF THIS.HaFormaPagamentoEmAberto()
            RETURN
        ENDIF

        THIS.AlternarTelaOperacao("IDENTIFICA")
        THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Visible = .F.

        *-- Legado: Origem/Destino voltam a ser editaveis quando nao ha
        *-- sub-nivel lancado ("If CheckDup.Qt = 0 ... EditaDestino = .t. /
        *-- EditaOrigem = .t.").
        IF !THIS.HaSubNivelInformado()
            THIS.this_lEditaDestino = .T.
            THIS.this_lEditaOrigem  = .T.
        ENDIF

        THIS.CarregarDadosContasIdentifica()
        THIS.PosicionarFocoIdentifica()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosContasIdentifica - as quatro consultas do identifica.Click
    * legado ("Select Iclis, Rclis, Cpfs From SigCdCli Where Iclis =
    * '<conta>'" para Origem, Destino, Vendedor e Responsavel, preenchendo
    * Get_dconta e Get_cpf de cada bloco). Bloco com conta vazia tem nome e
    * CPF limpos, como no ELSE do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDadosContasIdentifica()
        THIS.CarregarContaBloco("Origem")
        THIS.CarregarContaBloco("Destino")
        THIS.CarregarContaBloco("Vendedor")
        THIS.CarregarContaBloco("Responsavel")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarContaBloco - um dos quatro blocos de identificacao. O nome do
    * container e montado em tempo de execucao ("cnt_4c_" + par_cBloco) e
    * resolvido por EVALUATE UMA VEZ, para uma referencia de objeto: dai em
    * diante os campos sao alcancados por ponto normal. EVALUATE com "=" na
    * string NAO atribuiria nada (CLAUDE.md #15) e Controls("<nome>") nao
    * existe (CLAUDE.md #34).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarContaBloco(par_cBloco)
        LOCAL loc_oCnt, loc_cConta, loc_cSQL, loc_nRes, loc_oErro

        loc_oCnt = EVALUATE("THIS.cnt_4c__Identifica.cnt_4c_" + par_cBloco)
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF

        loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)

        IF EMPTY(loc_cConta)
            loc_oCnt.txt_4c_Dconta.Value = ""
            loc_oCnt.txt_4c_Cpf.Value    = ""
            RETURN
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli " + ;
                "WHERE Iclis = " + EscaparSQL(loc_cConta)

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaIdent")

            IF loc_nRes > 0 AND USED("cursor_4c_ContaIdent")
                SELECT cursor_4c_ContaIdent
                IF RECCOUNT("cursor_4c_ContaIdent") > 0
                    GO TOP
                    loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_ContaIdent.Rclis, ""))
                    loc_oCnt.txt_4c_Cpf.Value    = ALLTRIM(NVL(cursor_4c_ContaIdent.Cpfs, ""))
                ENDIF
            ENDIF

            IF USED("cursor_4c_ContaIdent")
                USE IN cursor_4c_ContaIdent
            ENDIF

            loc_oCnt.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao carregar a conta do bloco " + par_cBloco)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarFocoIdentifica - cascata de foco do identifica.Click legado,
    * na MESMA ordem: Documento -> Pedido Cliente -> Tab. Desconto -> Lista de
    * Precos -> Origem -> Destino -> Vendedor -> Responsavel -> Proximo. O
    * primeiro campo visivel e ainda vazio leva o foco; nenhum vazio, o foco
    * vai para o botao Proximo, como no ELSE final do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PosicionarFocoIdentifica()
        LOCAL loc_oId
        loc_oId = THIS.cnt_4c__Identifica

        DO CASE
            CASE loc_oId.cnt_4c_CodOperacao.Visible AND ;
                    EMPTY(loc_oId.cnt_4c_CodOperacao.txt_4c_Codigo.Value)
                THIS.FocarControle(loc_oId.cnt_4c_CodOperacao.txt_4c_Codigo)

            CASE loc_oId.cnt_4c_CodOperacao.Visible AND ;
                    EMPTY(loc_oId.cnt_4c_CodOperacao.txt_4c_PedCli.Value)
                THIS.FocarControle(loc_oId.cnt_4c_CodOperacao.txt_4c_PedCli)

            CASE loc_oId.cnt_4c_TabDesconto.Visible AND ;
                    EMPTY(loc_oId.cnt_4c_TabDesconto.txt_4c_Tabd.Value)
                THIS.FocarControle(loc_oId.cnt_4c_TabDesconto.txt_4c_Tabd)

            CASE loc_oId.cnt_4c_TabDesconto.Visible AND ;
                    EMPTY(loc_oId.cnt_4c_TabDesconto.txt_4c_ListaPreco.Value)
                THIS.FocarControle(loc_oId.cnt_4c_TabDesconto.txt_4c_ListaPreco)

            CASE loc_oId.cnt_4c_Origem.Visible AND THIS.this_lEditaOrigem AND ;
                    EMPTY(loc_oId.cnt_4c_Origem.txt_4c_Conta.Value)
                THIS.FocarControle(loc_oId.cnt_4c_Origem.txt_4c_Grupo)

            CASE loc_oId.cnt_4c_Destino.Visible AND THIS.this_lEditaDestino AND ;
                    EMPTY(loc_oId.cnt_4c_Destino.txt_4c_Conta.Value)
                THIS.FocarControle(loc_oId.cnt_4c_Destino.txt_4c_Grupo)

            CASE loc_oId.cnt_4c_Vendedor.Visible AND ;
                    EMPTY(loc_oId.cnt_4c_Vendedor.txt_4c_Conta.Value)
                THIS.FocarControle(loc_oId.cnt_4c_Vendedor.txt_4c_Grupo)

            CASE loc_oId.cnt_4c_Responsavel.Visible AND ;
                    EMPTY(loc_oId.cnt_4c_Responsavel.txt_4c_Conta.Value)
                THIS.FocarControle(loc_oId.cnt_4c_Responsavel.txt_4c_Grupo)

            OTHERWISE
                THIS.FocarControle(loc_oId.cmd_4c_Proximo)
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * [F7] Cred. (cmd_4c_Credito) - creditos/devolucoes do cliente.
    *
    * Legado (Barra_Botoes.credito.Click, 48 linhas): guardas de forma de
    * pagamento em aberto e de pagamento lancado, esconde as outras telas,
    * zera o gate dos botoes - e o painel que deveria aparecer (Cnt_Credito,
    * com a GradeDevol) esta COMENTADO no proprio SCX desde 2015 ("mena -
    * 26/02/2015 - retirado para testes"). Cnt_Credito nao existe na arvore de
    * objetos de SIGMVITS.SCX (layout.json): o botao esconde tudo e nao mostra
    * nada.
    *
    * Reproduzir isso ao pe da letra deixaria a tela EM BRANCO e sem volta.
    * Aqui as guardas do legado sao mantidas, a tela ativa NAO e escondida e a
    * ausencia do painel fica VISIVEL para o operador em vez de virar um beco
    * sem saida silencioso (CLAUDE.md #27).
    *--------------------------------------------------------------------------
    PROCEDURE CmdCreditoClick()
        IF THIS.HaFormaPagamentoEmAberto()
            RETURN
        ENDIF

        IF THIS.HaPagamentoPendente()
            MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", ;
                "Cr" + CHR(233) + "dito")
            RETURN
        ENDIF

        MsgAviso("O painel de Cr" + CHR(233) + "ditos/Devolu" + CHR(231) + CHR(245) + "es foi retirado do " + ;
            "formul" + CHR(225) + "rio legado (SIGMVITS.SCX) e n" + CHR(227) + ;
            "o tem equivalente nesta tela.", "Cr" + CHR(233) + "dito")
    ENDPROC

    *--------------------------------------------------------------------------
    * [F8] Crediario (cmd_4c_Financia) - financiamento por carne.
    *
    * Legado (Barra_Botoes.Financia.Click, 42 linhas): mesmas guardas do
    * Credito, esconde as telas e desliga os botoes; o painel CntFinanc esta
    * COMENTADO no SCX e o proprio When do botao devolve .F. incondicional
    * ("PROCEDURE When / RETURN .f."), isto e, o recurso esta DESLIGADO no
    * legado - e por isso que o botao nasce com Visible = .F. (Fase 4).
    *
    * As guardas ficam transcritas e o Click continua ligado (o botao existe);
    * a ausencia do painel e avisada em vez de esvaziar a tela, mesmo criterio
    * do Credito acima.
    *--------------------------------------------------------------------------
    PROCEDURE CmdFinanciaClick()
        IF THIS.HaFormaPagamentoEmAberto()
            RETURN
        ENDIF

        IF THIS.HaPagamentoPendente()
            MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", ;
                "Credi" + CHR(225) + "rio")
            RETURN
        ENDIF

        MsgAviso("O painel de Credi" + CHR(225) + "rio foi retirado do formul" + CHR(225) + "rio legado " + ;
            "(SIGMVITS.SCX) e o recurso est" + CHR(225) + " desligado nesta opera" + CHR(231) + CHR(227) + "o.", ;
            "Credi" + CHR(225) + "rio")
    ENDPROC

    *--------------------------------------------------------------------------
    * [F8] Pend. (cmd_4c_Pendencia) - sub-niveis/pendencias da movimentacao.
    *
    * Legado (Barra_Botoes.pendencia.Click, 72 linhas): guardas de forma de
    * pagamento em aberto, de pagamento lancado e de item cancelado ("Existem
    * Itens Cancelados!!! Para Utilizar SubNivel Cancele a Operacao e informe
    * os subniveis primeiro"); esconde as outras telas; zera o gate dos
    * botoes; mostra o painel com a grade de sub-niveis e o botao [F3]Pend.; e
    * escolhe o foco entre a grade e o botao Proximo conforme a grade esteja
    * ou nao habilitada.
    *
    * A grade fica DESABILITADA quando ja existe sub-nivel informado E item ja
    * impresso no cupom ("GradeMultiSubn.Enabled = Not (llSubNivel And
    * llTemItem)") - transcrito. A visibilidade condicionada a
    * crSigCdOpe.SubNs/CrSigOpCdc.HabPends depende de cursores do form pai e,
    * ausentes, nao esconde nada (a tela abre completa, como na operacao que
    * usa sub-nivel).
    *--------------------------------------------------------------------------
    PROCEDURE CmdPendenciaClick()
        LOCAL loc_lSubNivel, loc_lTemItem, loc_lLibera

        IF THIS.HaFormaPagamentoEmAberto()
            RETURN
        ENDIF

        IF THIS.HaPagamentoPendente()
            MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", ;
                "Pend" + CHR(234) + "ncia")
            RETURN
        ENDIF

        IF THIS.this_lCancelouItem
            MsgAviso("Existem Itens Cancelados!!! Para Utilizar SubNivel Cancele a " + ;
                "Opera" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                "e informe os subniveis primeiro", "Pend" + CHR(234) + "ncia")
            RETURN
        ENDIF

        loc_lSubNivel = THIS.HaSubNivelInformado()
        loc_lTemItem  = .F.
        IF USED("crTpmMvItn")
            SELECT crTpmMvItn
            LOCATE FOR NVL(ImpCupFis, .F.) AND !EMPTY(NVL(cpros, ""))
            loc_lTemItem = !EOF()
        ENDIF

        loc_lLibera = !(loc_lSubNivel AND loc_lTemItem)

        THIS.AlternarTelaOperacao("PENDENCIA")

        WITH THIS.cnt_4c__Pendencia
            .grd_4c_SubNiveis.Visible     = .T.
            .grd_4c_SubNiveis.Enabled     = loc_lLibera
            .cmd_4c_Bot_Pendentes.Visible = .T.
            .cmd_4c_Bot_Pendentes.Enabled = loc_lLibera
        ENDWITH

        IF loc_lLibera
            THIS.FocarControle(THIS.cnt_4c__Pendencia.grd_4c_SubNiveis)
        ELSE
            THIS.FocarControle(THIS.cnt_4c__Pendencia.cmd_4c_Proximo)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * <Ctrl+P> VerPreco (cmd_4c_VerPreco) - consulta de preco.
    *
    * Legado (Barra_Botoes.VerPreco.Click): o corpo do metodo esta INTEIRO
    * comentado ("mena - 26/02/2015 - retirado para testes") e o painel que
    * ele abria (Cnt_Consulta, com Cnt_Prod/Get_Unit/Cnt_Resultado) nao existe
    * na arvore de objetos de SIGMVITS.SCX (layout.json). O botao continua na
    * barra mas, no legado, clicar nele nao faz absolutamente nada - e por
    * isso que o atalho Ctrl+P tambem esta comentado no KeyPress.
    *
    * Handler vazio para copiar esse no-op seria um stub; inventar um painel
    * de consulta violaria o PILAR 1. O Click fica ligado e a ausencia do
    * painel fica VISIVEL, mesmo criterio do Credito e do Crediario.
    *--------------------------------------------------------------------------
    PROCEDURE CmdVerPrecoClick()
        MsgAviso("A consulta de pre" + CHR(231) + "o foi retirada do formul" + CHR(225) + "rio legado " + ;
            "(SIGMVITS.SCX) e n" + CHR(227) + "o tem painel equivalente nesta tela.", ;
            "Consulta de Pre" + CHR(231) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * [F9] Fiscal (cmd_4c_Impfiscal) - legado (4 linhas): "If Not
    * Wexist('SIGMEFIS') / DO Form SIGMEFIS / Endif" - abre o monitor de
    * status da impressora fiscal. SIGMEFIS conversa direto com o driver do
    * ECF do caixa (nao migrado; e sem o hardware nao ha o que monitorar).
    *--------------------------------------------------------------------------
    PROCEDURE CmdImpfiscalClick()
        MsgAviso("O monitor de status da impressora fiscal (SIGMEFIS) depende do driver " + ;
            "ECF f" + CHR(237) + "sico do caixa, fora do escopo desta migra" + CHR(231) + CHR(227) + "o.", ;
            "Impressora Fiscal")
    ENDPROC

    *--------------------------------------------------------------------------
    * [F11] Pagto (cmd_4c_Pagto) - abre a tela de formas de pagamento.
    *
    * Legado (Barra_Botoes.Pagto.Click, 448 linhas): guardas de item nao
    * impresso e de subtotal do ECF (VerifSubTotal), exigencia de cadastro
    * completo do cliente quando o total passa de 10.000 em NFC-e/SAT,
    * abertura do cupom fiscal quando ainda nao aberto, recalculo de todos os
    * totais, montagem do desconto/acrescimo ja aplicado ao documento,
    * configuracao da leitora serial de cheque, carga das formas de pagamento
    * e das parcelas de TEF (xParTef/ParcTef), gate dos botoes, troca de tela
    * e foco na forma de pagamento.
    *
    * Fica nesta fase o que e da TELA: guardas, recalculo dos totais, limpeza
    * dos campos da forma, gate dos botoes e o foco. Abertura de cupom fiscal
    * (VerStatus/AbreCupom/GerarCupom), leitora serial de cheque (ReadComm, o
    * container readcomm do VCX legado) e as parcelas de TEF dependem de
    * hardware do caixa e continuam na tela de movimentacao.
    *--------------------------------------------------------------------------
    PROCEDURE CmdPagtoClick()
        IF THIS.ContarItensLancados() = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens lan" + CHR(231) + "ados para pagamento.", ;
                "Pagamento")
            RETURN
        ENDIF

        *-- Legado: com sub-nivel informado e ItAutos = 8, o item precisa ter
        *-- sido impresso antes de ir para o pagamento.
        IF THIS.HaSubNivelInformado() AND THIS.HaItemNaoImpresso() AND ;
                THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Enabled
            MsgAviso("Obrigat" + CHR(243) + "rio Impress" + CHR(227) + "o dos Itens... Click <F2>", ;
                "Pagamento")
            RETURN
        ENDIF

        *-- Legado: a imagem do produto e a da empresa saem da tela ao entrar
        *-- no pagamento ("thisform.cntItem.Cnt_imgProd.Visible = .f.").
        THIS.cnt_4c_Item.cnt_4c__imgProd.Visible = .F.
        THIS.cnt_4c_Item.cnt_4c__ImgEmp.Visible  = .F.

        THIS.AlternarTelaOperacao("FPAGTO")
        THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Visible = .F.

        *-- Desconto/acrescimo comecam fechados; quem os abre e o botao
        *-- correspondente da barra (legado: "Cnt_Fpagto.Desconto.Visible =
        *-- .F. / Cnt_Fpagto.Acrescimo.Visible = .f.").
        THIS.cnt_4c__Fpagto.cnt_4c_Desconto.Visible  = .F.
        THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.Visible = .F.

        WITH THIS.cnt_4c__Fpagto.cnt_4c__forma
            .txt_4c_Fpg.Enabled           = .T.
            .txt_4c_Npar.Enabled          = .T.
            .txt_4c_Vpar.Enabled          = .T.
            .txt_4c_Fpg.Value             = ""
            .txt_4c_Npar.Value            = 0
            .txt_4c_Vpar.Value            = 0
            .txt_4c_Fweditdata_venc.Value = {}
            .Visible     = .T.
        ENDWITH

        THIS.RecalcularTotais()
        THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
    ENDPROC

    *--------------------------------------------------------------------------
    * Confirmar (cmd_4c_Ok) - fecha a venda.
    *
    * Legado (Barra_Botoes.ok.Click, 76 linhas): exige impressao dos itens
    * quando ha sub-nivel; exige sub-nivel quando SubnObrigs esta em 1/3;
    * acumula o valor cancelado no form pai; e, conforme o modelo fiscal,
    * chama montaNFc()/montaSatD() (emissao de NFC-e/SAT) ou
    * ParentForm.AcioSalva(), que gravava o documento inteiro com TABLEUPDATE
    * na datasession COMPARTILHADA.
    *
    * Aqui as guardas ficam iguais e a GRAVACAO acontece NESTE form, pelo BO:
    * com DataSession = 2 o carrinho (crTpmMvItn) esta isolado do form pai, e
    * sem gravar aqui os itens morreriam na memoria ao fechar a tela - o
    * Confirmar anunciaria venda fechada sem nada no banco (CLAUDE.md #20 /
    * "sucesso anunciado sem gravar"). A emissao FISCAL (NFC-e/SAT/cupom)
    * continua na tela de movimentacao, que e quem tem a impressora.
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_nItens, loc_lTemPagamento

        loc_nItens = THIS.ContarItensLancados()

        *-- Sem item nenhum o Confirmar so encerra a tela: e o que o legado faz
        *-- com carrinho vazio, e evita gravar documento sem item.
        IF loc_nItens = 0
            THIS.Release()
            RETURN
        ENDIF

        IF THIS.HaSubNivelInformado() AND THIS.HaItemNaoImpresso() AND ;
                THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Enabled
            MsgAviso("Obrigat" + CHR(243) + "rio Impress" + CHR(227) + "o dos Itens... Click <F2>", ;
                "Confirmar")
            RETURN
        ENDIF

        loc_lTemPagamento = .F.
        IF USED("xPar")
            SELECT xPar
            LOCATE FOR !EMPTY(NVL(FPags, ""))
            loc_lTemPagamento = !EOF()
        ENDIF

        IF !loc_lTemPagamento
            MsgAviso("Informe a forma de pagamento antes de confirmar a venda.", "Confirmar")
            THIS.CmdPagtoClick()
            RETURN
        ENDIF

        *-- Falhando a gravacao, NAO fecha a tela e NAO anuncia sucesso: o
        *-- caixa fica com o carrinho na tela para corrigir e repetir.
        *-- BusinessBase.Salvar() ja exibiu o motivo (CLAUDE.md #20).
        IF !THIS.GravarDocumento()
            RETURN
        ENDIF

        MsgInfo("Venda gravada com sucesso." + CHR(13) + ;
            "A finaliza" + CHR(231) + CHR(227) + "o fiscal prossegue na tela de " + ;
            "movimenta" + CHR(231) + CHR(227) + "o.", "Confirmar")
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - leva os campos da tela (cabecalho do cupom) para as
    * propriedades do BO, na mesma nomenclatura de sigmvitsBO.prg. So os
    * campos que EXISTEM nesta tela (SIGMVITS e um container filho do PDV;
    * os demais campos de SigMvCab pertencem a tela de movimentacao, form
    * pai que ainda nao foi migrado) - o resto fica com o default do BO.
    *
    * Empresa/Data: SIGMVITS.SCX nao tem campo proprio para isso (vinham de
    * TprMvCab, cursor do form pai) - aqui usam go_4c_Sistema/DATETIME(),
    * unica fonte disponivel nesta tela isolada.
    *
    * Documento (txt_4c_Codigo): o ControlSource do legado (TprMvCab.mascnum)
    * e so o que o campo EXIBE - o Valid legado grava o digitado em
    * TprMvCab.Numes (Replace TprMvCab.Numes With fRetornaInt(This.Value)),
    * entao o valor numerico vai para this_nNumes, nao this_cMascnum.
    *
    * Desconto/Acrescimo/Vars: MESMA formula ja usada em RecalcularTotais()
    * (nao recalculada de outro jeito) - valvars negativo em desconto,
    * positivo em acrescimo (CLAUDE.md #17 - formula transcrita, nao
    * reescrita).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oId, loc_oFp, loc_nTotal, loc_nLiquido, loc_nFormas
        LOCAL loc_nDesc, loc_nAcre, loc_nDescP, loc_nVarLiq

        loc_oBO = THIS.this_oBusinessObject
        loc_oId = THIS.cnt_4c__Identifica
        loc_oFp = THIS.cnt_4c__Fpagto

        *-- Empresa / data do movimento (unica fonte disponivel nesta tela).
        loc_oBO.this_cEmps  = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)
        loc_oBO.this_cEmpds = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)
        loc_oBO.this_cNemps = LEFT(ALLTRIM(go_4c_Sistema.cEmpresa), 40)
        loc_oBO.this_dDatas = DATETIME()

        *-- Documento / Pedido Cliente (Cnt_Identifica.CodOperacao).
        loc_oBO.this_nNumes    = ALLTRIM(loc_oId.cnt_4c_CodOperacao.txt_4c_Codigo.Value)
        loc_oBO.this_nNpedclis = ALLTRIM(loc_oId.cnt_4c_CodOperacao.txt_4c_PedCli.Value)

        *-- Identificacao: Destino/Responsavel/Vendedor/Origem (grupo+conta).
        loc_oBO.this_cGrupods = LEFT(ALLTRIM(loc_oId.cnt_4c_Destino.txt_4c_Grupo.Value), 10)
        loc_oBO.this_cContads = LEFT(ALLTRIM(loc_oId.cnt_4c_Destino.txt_4c_Conta.Value), 10)
        loc_oBO.this_cGrresps = LEFT(ALLTRIM(loc_oId.cnt_4c_Responsavel.txt_4c_Grupo.Value), 10)
        loc_oBO.this_cResps   = LEFT(ALLTRIM(loc_oId.cnt_4c_Responsavel.txt_4c_Conta.Value), 10)
        loc_oBO.this_cGrvends = LEFT(ALLTRIM(loc_oId.cnt_4c_Vendedor.txt_4c_Grupo.Value), 10)
        loc_oBO.this_cVends   = LEFT(ALLTRIM(loc_oId.cnt_4c_Vendedor.txt_4c_Conta.Value), 10)
        loc_oBO.this_cGrupoos = LEFT(ALLTRIM(loc_oId.cnt_4c_Origem.txt_4c_Grupo.Value), 10)
        loc_oBO.this_cContaos = LEFT(ALLTRIM(loc_oId.cnt_4c_Origem.txt_4c_Conta.Value), 10)

        *-- Tabela de desconto / Lista de precos.
        loc_oBO.this_cTabds   = LEFT(ALLTRIM(loc_oId.cnt_4c_TabDesconto.txt_4c_Tabd.Value), 10)
        loc_oBO.this_cLprecos = LEFT(ALLTRIM(loc_oId.cnt_4c_TabDesconto.txt_4c_ListaPreco.Value), 30)

        *-- Totais (ja calculados por RecalcularTotais - so leitura aqui).
        loc_nDesc  = loc_oFp.cnt_4c_Desconto.txt_4c_TotVariacao.Value
        loc_nAcre  = loc_oFp.cnt_4c_Acrescimo.txt_4c_TotVariacao.Value
        loc_nDescP = loc_oFp.cnt_4c__descp.txt_4c_Tvariacao.Value
        loc_nTotal = loc_oFp.cnt_4c__tot.txt_4c_Valinic.Value
        loc_nLiquido = loc_oFp.cnt_4c__saldo.txt_4c_TotLiquido.Value
        loc_nFormas  = loc_oFp.cnt_4c__pag.txt_4c_TotForma.Value

        *-- valvars: negativo em desconto, positivo em acrescimo (legado:
        *-- "Replace TprMvCab.valvars With -This.Value" no Desconto e "With
        *-- This.Value" no Acrescimo - mutuamente exclusivos na tela).
        loc_nVarLiq = loc_nAcre - loc_nDesc

        loc_oBO.this_nValinis  = loc_nTotal
        loc_oBO.this_nValos    = loc_nLiquido
        loc_oBO.this_nValvars  = loc_nVarLiq
        loc_oBO.this_nVars     = IIF(loc_nTotal = 0, 0, ROUND(loc_nVarLiq / loc_nTotal * 100, 4))
        loc_oBO.this_nValvarps = -loc_nDescP

        *-- Quantidade de itens do carrinho (linhas com produto preenchido).
        loc_oBO.this_nQtdes = THIS.ContarItensLancados()

        *-- Flags de estado do documento.
        loc_oBO.this_lChksubn  = THIS.HaSubNivelInformado()
        loc_oBO.this_lChkpagos = (ROUND(loc_nFormas, 2) >= ROUND(loc_nLiquido, 2))
        loc_oBO.this_lLcancelas = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - inverso de FormParaBO: leva as propriedades do sigmvitsBO
    * para os campos do cabecalho do cupom. E o caminho usado quando o
    * documento ja existe no BO (CarregarPorCodigo / retorno do Salvar) e a
    * tela precisa espelhar o que esta gravado.
    *
    * Mapeamento simetrico ao de FormParaBO - mesmo par controle/propriedade,
    * na mesma ordem - para que uma mudanca em um lado seja vista no outro:
    *
    *   this_nNumes / this_nNpedclis   -> Cnt_Identifica.CodOperacao
    *   this_cGrupods / this_cContads  -> bloco Destino
    *   this_cGrresps / this_cResps    -> bloco Responsavel
    *   this_cGrvends / this_cVends    -> bloco Vendedor
    *   this_cGrupoos / this_cContaos  -> bloco Origem
    *   this_cTabds / this_cLprecos    -> Cnt_Identifica.TabDesconto
    *   this_nValvars / this_nValvarps -> Desconto / Acrescimo / Desc.Promocional
    *
    * valvars e UM campo do banco para DUAS caixas na tela (o legado grava
    * "-This.Value" no Desconto e "This.Value" no Acrescimo, mutuamente
    * exclusivos): negativo volta como Desconto, positivo como Acrescimo -
    * exatamente a inversa da conta feita em FormParaBO, sem reescrever a
    * formula (CLAUDE.md #17).
    *
    * Totais derivados (Total / Saldo Final / A Pagar) tem FONTE UNICA: o
    * carrinho, via RecalcularTotais(). Com o carrinho vazio - documento
    * recuperado do BO sem itens em memoria - nao ha o que recalcular e a tela
    * espelha o que esta gravado, em vez de zerar os campos.
    *
    * Descricao e CPF dos quatro blocos nao vem do BO (SigMvCab guarda so
    * grupo e conta): sao relidos de SigCdCli pelo mesmo
    * CarregarDadosContasIdentifica() que o botao Identifica ja usa - fonte
    * unica, sem uma segunda consulta que possa divergir.
    *
    * Escopo: PROTECTED por HERANCA - FormBase.prg declara "PROTECTED
    * PROCEDURE BOParaForm()" e o VFP9 nao deixa a subclasse alargar isso.
    * Medido: PEMSTATUS(oForm, "BOParaForm", 5) devolve .T. e a chamada de
    * FORA da classe estoura "Property BOPARAFORM is not found" (CLAUDE.md
    * #3). E o escopo certo - quem o chama e o proprio FormBase (linha 235),
    * de dentro da hierarquia; o harness de teste nao chama este metodo.
    *--------------------------------------------------------------------------
    FUNCTION BOParaForm()
        LOCAL loc_oBO, loc_oId, loc_oFp, loc_nVar, loc_lOk

        loc_lOk = .F.
        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"
            loc_oId = THIS.cnt_4c__Identifica
            loc_oFp = THIS.cnt_4c__Fpagto

            *-- Documento / Pedido Cliente. Zero e "documento ainda sem
            *-- numero": o legado exibe branco, nao o algarismo 0.
            loc_oId.cnt_4c_CodOperacao.txt_4c_Codigo.Value = ;
                IIF(loc_oBO.this_nNumes = 0, "", ALLTRIM(TRANSFORM(loc_oBO.this_nNumes)))
            loc_oId.cnt_4c_CodOperacao.txt_4c_PedCli.Value = ;
                IIF(loc_oBO.this_nNpedclis = 0, "", ALLTRIM(TRANSFORM(loc_oBO.this_nNpedclis)))

            *-- Identificacao: os quatro blocos (grupo + conta).
            loc_oId.cnt_4c_Destino.txt_4c_Grupo.Value     = ALLTRIM(loc_oBO.this_cGrupods)
            loc_oId.cnt_4c_Destino.txt_4c_Conta.Value     = ALLTRIM(loc_oBO.this_cContads)
            loc_oId.cnt_4c_Responsavel.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrresps)
            loc_oId.cnt_4c_Responsavel.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cResps)
            loc_oId.cnt_4c_Vendedor.txt_4c_Grupo.Value    = ALLTRIM(loc_oBO.this_cGrvends)
            loc_oId.cnt_4c_Vendedor.txt_4c_Conta.Value    = ALLTRIM(loc_oBO.this_cVends)
            loc_oId.cnt_4c_Origem.txt_4c_Grupo.Value      = ALLTRIM(loc_oBO.this_cGrupoos)
            loc_oId.cnt_4c_Origem.txt_4c_Conta.Value      = ALLTRIM(loc_oBO.this_cContaos)

            *-- Tabela de desconto / Lista de precos.
            loc_oId.cnt_4c_TabDesconto.txt_4c_Tabd.Value       = ALLTRIM(loc_oBO.this_cTabds)
            loc_oId.cnt_4c_TabDesconto.txt_4c_ListaPreco.Value = ALLTRIM(loc_oBO.this_cLprecos)

            *-- Variacao: um campo do banco, duas caixas na tela.
            loc_nVar = loc_oBO.this_nValvars
            loc_oFp.cnt_4c_Desconto.txt_4c_TotVariacao.Value  = IIF(loc_nVar < 0, -loc_nVar, 0)
            loc_oFp.cnt_4c_Acrescimo.txt_4c_TotVariacao.Value = IIF(loc_nVar > 0, loc_nVar, 0)
            loc_oFp.cnt_4c__descp.txt_4c_Tvariacao.Value      = -loc_oBO.this_nValvarps

            *-- Derivados: o carrinho manda; sem carrinho, espelha o gravado.
            IF THIS.ContarItensLancados() > 0
                THIS.RecalcularTotais()
            ELSE
                loc_oFp.cnt_4c__tot.txt_4c_Valinic.Value      = loc_oBO.this_nValinis
                loc_oFp.cnt_4c__saldo.txt_4c_TotLiquido.Value = loc_oBO.this_nValos
                loc_oFp.cnt_4c__apag.txt_4c_Saldo.Value       = ;
                    loc_oBO.this_nValos - loc_oFp.cnt_4c__pag.txt_4c_TotForma.Value
            ENDIF

            *-- Descricao e CPF dos blocos (SigCdCli), pela fonte unica que o
            *-- botao Identifica ja usa.
            THIS.CarregarDadosContasIdentifica()

            loc_oId.Refresh()
            loc_oFp.Refresh()

            loc_lOk = .T.
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarLista - repopula a GRADE do cupom (grd_4c_Cupom, ligada a
    * crTpmMvItnC) a partir do carrinho (crTpmMvItn) e das parcelas lancadas
    * (xPar), e repinta as duas grades da tela.
    *
    * Equivale ao AtuaCupom(vTipo, vnItem) do legado, o unico metodo que
    * escreve as LINHAS exibidas na grade do cupom. As duas metades do metodo
    * legado estao aqui na mesma ordem em que ele as produz:
    *
    *   vTipo = .F. -> por item do carrinho, a linha
    *                  "@Z 9999 <codigo(14)> <descricao>" e a linha
    *                  "    qtd un X  unitario  total". O legado insere so a
    *                  do item recem-lancado (sob "If Not
    *                  Seek(Str(cItens,4))"); "carregar" reconstroi a grade
    *                  inteira - linha a linha, o resultado exibido e o mesmo.
    *   vTipo = .T. -> o rodape: separador, total de itens ("TI:"), TOTAL, uma
    *                  linha por forma de pagamento agrupada (mais a linha de
    *                  desconto quando ValDescs e diferente de zero), Valor
    *                  Recebido e TROCO.
    *
    * A numeracao de cItens do rodape e TRANSCRITA (1001..1003 cabecalho,
    * 1004+ formas, 2000 recebido, 3000 troco): e ela que da a ORDEM das
    * linhas na grade. Cores e o indice do DynamicForeColor legado - 1 total,
    * 2 forma de pagamento, 3 recebido, 4 troco.
    *
    * Tres trechos do legado nao tem equivalente nesta tela isolada, e por
    * isso a linha do item usa o proprio carrinho como fonte: o SELECT em
    * SigCdPro (DescEcfs / CBars), o IdentPro de CrSigOpCdd e o SubCdProrF de
    * CrSigOpCdi decidem COMO o produto e identificado na IMPRESSORA FISCAL e
    * dependem de cursores que a tela de movimentacao (form pai) monta na
    * datasession COMPARTILHADA - com DataSession = 2 eles nao existem aqui. A
    * descricao (dpros) e o codigo de barras (codbarras) ja vem gravados no
    * carrinho no momento do lancamento do item, entao a linha exibida e a
    * mesma.
    *
    * SET SAFETY salvo e restaurado em volta do ZAP: DataSession = 2 nasce com
    * os SETs no DEFAULT do VFP, onde SAFETY esta ON e o ZAP abriria um
    * dialogo modal (mesma familia da regra #9.4 do CLAUDE.md).
    *
    * PUBLIC de proposito: TesteAutomatico.prg chama
    * THIS.oForm.CarregarLista() de fora da classe e PROTECTED falharia em
    * runtime mesmo passando no PEMSTATUS (CLAUDE.md #3).
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        LOCAL loc_nAreaAnt, loc_cSafetyAnt, loc_nItem, loc_cTexto
        LOCAL loc_cCodigo, loc_cDescr, loc_nQtItem, loc_nTotLiq
        LOCAL loc_nTotForma, loc_nTroco, loc_nBcd, loc_lOk
        LOCAL loc_nQtd, loc_cUni, loc_nUnit, loc_nTota
        LOCAL loc_cFpag, loc_nTParcs, loc_nPDescs, loc_nValos
        LOCAL loc_nValDescs, loc_nBcdLin, loc_nTrocos

        loc_lOk = .F.

        IF USED("crTpmMvItnC") AND USED("crTpmMvItn")
            loc_nAreaAnt = SELECT()

            *-- Grade reconstruida do zero (o legado limpa so o rodape, com
            *-- "Delete For cItens >= 1000", porque acrescenta um item por vez).
            loc_cSafetyAnt = SET("SAFETY")
            SET SAFETY OFF
            SELECT crTpmMvItnC
            SET ORDER TO
            ZAP
            IF loc_cSafetyAnt = "ON"
                SET SAFETY ON
            ENDIF

            *-- 1) Linhas dos ITENS do carrinho.
            SELECT crTpmMvItn
            SET ORDER TO
            GO TOP
            SCAN FOR !EMPTY(NVL(cpros, "")) AND !DELETED()
                *-- Cada campo lido para variavel local ANTES do primeiro
                *-- INSERT: "INSERT INTO <cursor>" TROCA a area de trabalho
                *-- corrente para o cursor de destino, e a partir dali um
                *-- nome de campo sem alias resolveria contra crTpmMvItnC -
                *-- "Variable 'QTDS' is not found" em runtime.
                loc_nItem  = NVL(citens, 0)
                loc_cDescr = ALLTRIM(NVL(dpros, ""))
                loc_nQtd   = NVL(qtds, 0)
                loc_cUni   = NVL(cunis, "")
                loc_nUnit  = NVL(units, 0)
                loc_nTota  = NVL(totas, 0)

                IF NVL(codbarras, 0) > 0
                    loc_cCodigo = PADL(ALLTRIM(TRANSFORM(NVL(codbarras, 0))), 14, "0")
                ELSE
                    loc_cCodigo = ALLTRIM(NVL(cpros, ""))
                ENDIF

                loc_cTexto = TRANSFORM(loc_nItem, "@Z 9999") + " " + ;
                    PADR(loc_cCodigo, 14) + " " + loc_cDescr
                INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                    VALUES (loc_nItem, 1, LEFT(loc_cTexto, 90), 0)

                loc_cTexto = "    " + TRANSFORM(loc_nQtd, "@Z 999.99") + " " + ;
                    loc_cUni + " X  " + ;
                    TRANSFORM(loc_nUnit, "@Z 999,999,999.99") + " " + ;
                    TRANSFORM(loc_nTota, "@Z 999,999,999.99")
                INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                    VALUES (loc_nItem, 2, LEFT(loc_cTexto, 90), 0)

                SELECT crTpmMvItn
            ENDSCAN

            *-- 2) Rodape: total de itens, TOTAL, formas, recebido e troco.
            loc_nQtItem = 0
            SELECT crTpmMvItn
            SUM NVL(qtds, 0) FOR !DELETED() TO loc_nQtItem

            loc_nTotLiq   = THIS.cnt_4c__Fpagto.cnt_4c__saldo.txt_4c_TotLiquido.Value
            loc_nTotForma = THIS.cnt_4c__Fpagto.cnt_4c__pag.txt_4c_TotForma.Value

            INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                VALUES (1001, 0, REPLICATE("-", 47), 0)
            INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                VALUES (1001, 1, "TI:" + TRANSFORM(loc_nQtItem, "@z 9,999.99"), 1)
            INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                VALUES (1002, 1, "", 1)
            INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                VALUES (1003, 2, PADR("..TOTAL", 33) + ;
                    TRANSFORM(loc_nTotLiq, "@Z 999,999,999.99"), 1)

            loc_nBcd  = 0
            loc_nItem = 1004

            IF USED("xPar")
                *-- Agrupamento transcrito do legado: mesmas chaves, mesmos
                *-- agregados, mesma ordenacao.
                SELECT nChaves, FPags, Trocos, cnIdTefs, Infos, ;
                       MAX(tParcs) AS tParcs, MAX(pDescs) AS pDescs, ;
                       SUM(Valos) AS Valos, SUM(ValDescs) AS ValDescs, ;
                       SUM(Bcds) AS Bcds ;
                    FROM xPar ;
                    INTO CURSOR xParECF READWRITE ;
                    GROUP BY 1, 2, 3, 4, 5 ;
                    ORDER BY nChaves, FPags

                IF USED("xParECF")
                    SELECT xParECF
                    GO TOP
                    SCAN
                        *-- Mesma razao do laco dos itens: os campos vao para
                        *-- locais ANTES do primeiro INSERT, que troca a area
                        *-- de trabalho corrente para crTpmMvItnC.
                        loc_cFpag     = ALLTRIM(NVL(FPags, ""))
                        loc_nTParcs   = NVL(tParcs, 0)
                        loc_nPDescs   = NVL(pDescs, 0)
                        loc_nValos    = NVL(Valos, 0)
                        loc_nValDescs = NVL(ValDescs, 0)
                        loc_nBcdLin   = NVL(Bcds, 0)
                        loc_nTrocos   = NVL(Trocos, 0)

                        loc_cTexto = PADR(".." + loc_cFpag + ;
                            IIF(loc_nTParcs = 1, "", ;
                                " (" + TRANSFORM(loc_nTParcs, "@L 99") + "x) " + ;
                                IIF(loc_nTParcs = 0, "", ;
                                    TRANSFORM(loc_nValos / MAX(loc_nTParcs, 1), ;
                                        "@Z 9999,999.99"))), 33) + ;
                            TRANSFORM(loc_nValos, "@Z 999,999,999.99")
                        INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                            VALUES (loc_nItem, 1, LEFT(loc_cTexto, 90), ;
                                IIF(loc_nTrocos = 1, 4, 2))
                        loc_nItem = loc_nItem + 1

                        IF loc_nValDescs <> 0
                            loc_cTexto = PADR(SPACE(10) + "Desconto " + ;
                                ALLTRIM(TRANSFORM(loc_nPDescs, "@Z 9999.9999%")), 33) + ;
                                TRANSFORM(loc_nValDescs, "@Z 999,999,999.99")
                            INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                                VALUES (loc_nItem, 1, LEFT(loc_cTexto, 90), 2)
                            loc_nItem = loc_nItem + 1
                        ENDIF

                        loc_nBcd = loc_nBcd + loc_nBcdLin
                        SELECT xParECF
                    ENDSCAN

                    USE IN xParECF
                ENDIF

                SELECT xPar
                GO BOTTOM
            ENDIF

            THIS.this_nBcds = loc_nBcd

            IF loc_nTotForma <> 0
                loc_cTexto = PADR("..Valor Recebido", 33) + ;
                    TRANSFORM(loc_nTotForma, "@Z 999,999,999.99")
                INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                    VALUES (2000, 1, LEFT(loc_cTexto, 90), 3)
            ENDIF

            *-- O troco so aparece com a operacao liberada para troco: e a
            *-- condicao do legado ("And ThisForm.Libtroco"), nao um detalhe.
            IF loc_nTotLiq < loc_nTotForma AND loc_nTotLiq > 0 AND THIS.this_lLibTroco
                loc_nTroco = loc_nTotForma - loc_nTotLiq
                loc_cTexto = PADR("..TROCO", 33) + ;
                    TRANSFORM(loc_nTroco, "@Z 999,999,999.99")
                INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                    VALUES (3000, 1, LEFT(loc_cTexto, 90), 4)
            ENDIF

            *-- Popular cursor NAO repinta a grade: Go Top + Refresh, como o
            *-- legado sempre faz (CLAUDE.md #21a).
            SELECT crTpmMvItnC
            SET ORDER TO
            GO TOP
            THIS.cnt_4c_Grade.grd_4c_Cupom.Refresh()
            THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Refresh()

            *-- Legado encerra o AtuaCupom limpando a linha de mensagem.
            THIS.ExibirMensagem("")

            IF loc_nAreaAnt > 0
                SELECT (loc_nAreaAnt)
            ELSE
                SELECT crTpmMvItn
            ENDIF

            loc_lOk = .T.
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarDocumento - leva a tela para o BO e grava. O cabecalho do
    * documento (SigMvCab, tabela do sigmvitsBO) vai pelo caminho canonico
    * BusinessBase.Salvar(), que ja reporta a falha sozinho (CLAUDE.md #20 -
    * o form nao repete a mensagem).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarDocumento()
        LOCAL loc_lOk, loc_oErro

        loc_lOk = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", "Confirmar")
            ELSE
                THIS.FormParaBO()
                loc_lOk = THIS.this_oBusinessObject.Salvar()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao gravar o documento")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * Cancelar (cmd_4c_Cancela, Cancel = .T. / ESC) - encerra o Caixa.
    *
    * Legado (Barra_Botoes.Cancela.Click, 29 linhas): fecha as telas
    * auxiliares SIGPRDFT/SigCrTef se estiverem abertas; bloqueia o
    * cancelamento enquanto ha produto sendo digitado ("If Not
    * Empty(Get_Produto.Value) / Return .f."); exige impressao dos itens
    * quando ha sub-nivel; acumula o valor cancelado; e chama
    * ParentForm.AcioCancela(.t.).
    *
    * AcioCancela e do form pai (estorna o documento e libera o caixa). Aqui o
    * cancelamento fecha esta tela e devolve o controle a tela de
    * movimentacao, com confirmacao do operador antes - o carrinho esta em
    * cursor local e sai da memoria junto.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF !EMPTY(THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto.Value)
            RETURN
        ENDIF

        IF THIS.HaSubNivelInformado() AND THIS.HaItemNaoImpresso() AND ;
                THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Enabled
            MsgAviso("Obrigat" + CHR(243) + "rio Impress" + CHR(227) + "o dos Itens... Click <F2>", ;
                "Cancelar")
            RETURN
        ENDIF

        IF MsgConfirma("Deseja realmente cancelar e encerrar o Caixa?", "Cancelar")
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - nome canonico de encerramento. SIGMVITS.SCX nao tem
    * botao Encerrar/Fechar/Sair: a saida e o proprio Cancelar
    * (Barra_Botoes.Cancela, Cancel = .T.). Nenhum botao novo e criado
    * (PILAR 1) - este metodo so da o nome canonico que TesteAutomatico.prg
    * procura por PEMSTATUS.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *==========================================================================
    * HANDLERS - BOTOES DAS TELAS DE OPERACAO
    *==========================================================================

    *--------------------------------------------------------------------------
    * [F3]Pend. (cnt_4c__Pendencia.cmd_4c_Bot_Pendentes) - legado (13 linhas):
    * exige conta de ORIGEM quando crSigOpCdi.OrigDest = 1; limpa as linhas
    * com codigo zerado ("Select TmpOperacao / Delete For Codigos = 0"); e
    * abre SigOpPen, a tela de selecao de pendencias do cliente, que nao tem
    * equivalente migrado. A limpeza local acontece de todo modo.
    *--------------------------------------------------------------------------
    PROCEDURE CmdBotPendentesClick()
        IF EMPTY(THIS.cnt_4c__Identifica.cnt_4c_Origem.txt_4c_Conta.Value)
            MsgAviso("Conta de Origem Obrigat" + CHR(243) + "ria!", "Aviso")
            THIS.CmdIdentificaClick()
            RETURN
        ENDIF

        IF !USED("TmpOperacao")
            RETURN
        ENDIF

        SELECT TmpOperacao
        DELETE FOR NVL(Codigos, 0) = 0
        GO TOP

        THIS.RecalcularTotais()
    ENDPROC

    *--------------------------------------------------------------------------
    * Painel de cancelamento de item - Ok (cnt_4c_CancelaItem.cmd_4c_Ok).
    *
    * Legado (CancelaItem.ok.Click, 52 linhas): pede senha de supervisor ("Do
    * Form SigOpSen With 'CANCITEM' ..."), chama ParentForm.Cancel_Item_Gen()
    * e replica o cancelamento em CQSigExMvi/CQSigExMvc (tabelas de exportacao
    * fiscal do PAF) antes de atualizar o cupom.
    *
    * SigOpSen (senha) nao tem equivalente migrado - MsgConfirma faz o papel do
    * gate. A replicacao nas tabelas de exportacao fiscal e do form pai. O que
    * e desta tela - remover o item do carrinho, marcar que houve cancelamento
    * (UltimoCancel/CancelouItem, que o legado usa para renumerar e para
    * bloquear sub-nivel depois) e recalcular - fica aqui.
    *--------------------------------------------------------------------------
    PROCEDURE CancelaItemOkClick()
        LOCAL loc_nItem

        loc_nItem = THIS.cnt_4c_CancelaItem.txt_4c_Item.Value

        IF loc_nItem <= 0 OR !USED("crTpmMvItn")
            THIS.FecharPainelCancelaItem()
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma o cancelamento do item " + ALLTRIM(TRANSFORM(loc_nItem)) + "?", ;
                "Cancelamento de Item")
            THIS.FecharPainelCancelaItem()
            RETURN
        ENDIF

        SELECT crTpmMvItn
        SET ORDER TO
        LOCATE FOR NVL(citens, 0) = loc_nItem
        IF EOF()
            MsgAviso("Item n" + CHR(227) + "o encontrado!!!", "Cancelamento de Item")
            THIS.FecharPainelCancelaItem()
            RETURN
        ENDIF

        DELETE

        *-- Legado: "UltimoCancel = Iif(Get_item.Value > UltimoCancel,
        *-- Get_item.Value, UltimoCancel)" - guarda o maior item cancelado
        *-- para a renumeracao nao reaproveitar o numero.
        THIS.this_nUltimoCancel = MAX(THIS.this_nUltimoCancel, loc_nItem)
        THIS.this_lCancelouItem = .T.

        *-- As linhas de texto do cupom daquele item saem da grade junto.
        IF USED("crTpmMvItnC")
            SELECT crTpmMvItnC
            DELETE FOR NVL(cItens, 0) = loc_nItem
            GO TOP
        ENDIF

        THIS.RecalcularTotais()
        THIS.FecharPainelCancelaItem()
    ENDPROC

    *--------------------------------------------------------------------------
    * Painel de cancelamento de item - CancelaDisp (cmd_4c_CancelaDisp).
    * Legado (6 linhas): "Select crTpmMvItn / Set Order To / CntItem.Enabled =
    * .T. / CancelaItem.Visible = .f. / Get_Produto.Setfocus" - fecha o painel
    * SEM cancelar nada.
    *--------------------------------------------------------------------------
    PROCEDURE CancelaItemCancelaDispClick()
        IF USED("crTpmMvItn")
            SELECT crTpmMvItn
            SET ORDER TO
        ENDIF
        THIS.FecharPainelCancelaItem()
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharPainelCancelaItem - fecha o painel e devolve o controle a tela de
    * itens. Compartilhado pelo Ok (apos processar) e pelo CancelaDisp.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharPainelCancelaItem()
        THIS.cnt_4c_CancelaItem.Visible = .F.
        THIS.cnt_4c_Item.Enabled        = .T.
        THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto)
    ENDPROC

    *--------------------------------------------------------------------------
    * Proximo - o mesmo botao "seta" existe em quatro telas (cnt_4c_Item,
    * cnt_4c__Pendencia, cnt_4c__Fpagto, cnt_4c__Identifica) e em todas ele
    * AVANCA para a etapa seguinte do fluxo do caixa. Legado:
    *
    *   CntItem.Proximo.Click        -> Barra_Botoes.Pagto.Click()
    *   Cnt_Identifica.Proximo.Click -> Itens.Click() e, com Itens
    *                                   desabilitado, Pagto.Click()
    *   Cnt_Pendencia.Proximo.Click  -> limpa o sub-nivel zerado e segue
    *   Cnt_Fpagto.Proximo.Click     -> foco no Confirmar quando o saldo esta
    *                                   zerado, senao volta para a forma
    *
    * Cada tela tem o seu handler porque o destino e diferente; a troca de
    * icone (b_arrow1/b_arrow2) tambem e do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ItemProximoClick()
        THIS.CmdPagtoClick()
    ENDPROC

    PROCEDURE IdentificaProximoClick()
        IF THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Enabled
            THIS.CmdItensClick()
        ELSE
            THIS.CmdPagtoClick()
        ENDIF
    ENDPROC

    PROCEDURE PendenciaProximoClick()
        *-- Legado (Cnt_Pendencia.Proximo.Click): limpa as linhas zeradas do
        *-- sub-nivel e segue para os itens.
        IF USED("TmpOperacao")
            SELECT TmpOperacao
            DELETE FOR NVL(Codigos, 0) = 0
            GO TOP
        ENDIF

        THIS.CmdItensClick()
    ENDPROC

    PROCEDURE FpagtoProximoClick()
        IF THIS.cnt_4c__Fpagto.cnt_4c__apag.txt_4c_Saldo.Value <= 0
            THIS.FocarControle(THIS.cnt_4c_Barra_Botoes.cmd_4c_Ok)
        ELSE
            THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
        ENDIF
    ENDPROC

    *==========================================================================
    * TIMER - barra de titulo
    *==========================================================================

    *--------------------------------------------------------------------------
    * TimerAtualizarTitulo - legado (Timer1.Procedure, 6 linhas): reescreve
    * TxtCaption a cada segundo com data/hora, operacao, numero do documento,
    * caixa e operador. O nome completo do operador vinha de SigCdUsu.nComps
    * por CursorQuery; aqui o operador e gc_4c_UsuarioLogado, e operacao/numero
    * vem do BO (as mesmas colunas dopes/numes que o legado lia de TprMvCab).
    * O numero do caixa estava em crSigFiMpf, cursor do form pai - ausente,
    * sai vazio, como no proprio Iif(Used(...)) do legado.
    *--------------------------------------------------------------------------
    PROCEDURE TimerAtualizarTitulo()
        LOCAL loc_cCaixa, loc_cDope, loc_nNume

        loc_cCaixa = ""
        IF USED("crSigFiMpf")
            loc_cCaixa = ALLTRIM(NVL(crSigFiMpf.cnCaixas, ""))
        ENDIF

        loc_cDope = ""
        loc_nNume = 0
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cDope = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
            loc_nNume = THIS.this_oBusinessObject.this_nNumes
        ENDIF

        THIS.lbl_4c_TxtCaption.Caption = "   [ " + DTOC(DATE()) + " " + TIME() + " ]   " + ;
            loc_cDope + "   [ No : " + STR(loc_nNume, 6) + " ] " + SPACE(10) + ;
            "Caixa: " + loc_cCaixa + SPACE(10) + ;
            "Operador(a) : " + ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
    ENDPROC

    *==========================================================================
    * KEYPRESS DO FORM (KeyPreview = .T.) - atalhos de teclado
    *==========================================================================

    *--------------------------------------------------------------------------
    * KeyPress - transcricao do SIGMVITS.KeyPress (143 linhas). O legado
    * despacha cada tecla para o Click do botao correspondente; aqui o
    * despacho vai para o METODO do Click - mesmo efeito, sem depender do
    * BINDEVENT para a chamada programatica.
    *
    * Codigos de tecla como no legado (form com KeyPreview = .T.): F2 = -1,
    * F3 = -2, F4 = -3, F5 = -4, F6 = -5, F8 = -7, F9 = -8, F11 = 133,
    * Ctrl+F3 = 96. F7 (-6, Credito), Ctrl+P (16, VerPreco) e Ctrl+K (11,
    * calculadora) estao COMENTADOS no legado e por isso NAO sao despachados
    * aqui - o botao continua clicavel, so nao tem atalho, igual ao legado.
    *
    * As guardas de cada Case sao as do legado: "Empty(lcItem)" (nada sendo
    * digitado no campo Produto), o botao habilitado e a tela certa visivel. O
    * bloco externo tambem e o do legado: nada e despachado enquanto o painel
    * do cheque/TEF ou o de cancelamento de item estiver aberto.
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBarra, loc_cItem, loc_lItemVisivel, loc_lFpagtoVisivel

        loc_oBarra = THIS.cnt_4c_Barra_Botoes
        loc_cItem  = THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto.Value

        IF THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Visible OR THIS.cnt_4c_CancelaItem.Visible
            RETURN
        ENDIF

        loc_lItemVisivel   = THIS.cnt_4c_Item.Visible
        loc_lFpagtoVisivel = THIS.cnt_4c__Fpagto.Visible

        DO CASE
            *-- F3 na tela de pendencias: [F3]Pend. (tratado ANTES do bloco
            *-- geral, como no primeiro Do Case do legado).
            CASE par_nKeyCode = -2 AND THIS.cnt_4c__Pendencia.Visible AND ;
                    THIS.cnt_4c__Pendencia.cmd_4c_Bot_Pendentes.Enabled
                NODEFAULT
                THIS.CmdBotPendentesClick()

            *-- F2 - Itens
            CASE par_nKeyCode = -1 AND loc_oBarra.cmd_4c_Itens.Enabled AND EMPTY(loc_cItem)
                NODEFAULT
                THIS.CmdItensClick()

            *-- F3 - Qtde (tela de itens)
            CASE par_nKeyCode = -2 AND loc_lItemVisivel AND loc_oBarra.cmd_4c_Alteraqtd.Enabled AND ;
                    THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto.Enabled AND EMPTY(loc_cItem)
                NODEFAULT
                THIS.CmdAlteraqtdClick()

            *-- F4 - Cancelar item (tela de itens)
            CASE par_nKeyCode = -3 AND loc_lItemVisivel AND loc_oBarra.cmd_4c_Apaga.Enabled AND ;
                    !THIS.this_lAlteraQtd AND EMPTY(loc_cItem)
                NODEFAULT
                THIS.CmdApagaClick()

            *-- F5 - Alterar preco (tela de itens)
            CASE par_nKeyCode = -4 AND loc_lItemVisivel AND loc_oBarra.cmd_4c_AltPreco.Enabled
                NODEFAULT
                THIS.CmdAltPrecoClick()

            *-- F4 - Cancelar forma de pagamento (tela de pagamento)
            CASE par_nKeyCode = -3 AND loc_lFpagtoVisivel AND loc_oBarra.cmd_4c_CancPagto.Enabled
                NODEFAULT
                THIS.CmdCancPagtoClick()

            *-- F3 - Desconto (tela de pagamento, com total diferente de zero)
            CASE par_nKeyCode = -2 AND loc_lFpagtoVisivel AND loc_oBarra.cmd_4c_Desconto.Enabled AND ;
                    THIS.cnt_4c__Fpagto.cnt_4c__tot.txt_4c_Valinic.Value <> 0
                NODEFAULT
                THIS.CmdDescontoClick()

            *-- Ctrl+F3 - Acrescimo (tela de pagamento, com total diferente de zero)
            CASE par_nKeyCode = 96 AND loc_lFpagtoVisivel AND loc_oBarra.cmd_4c_Acrescimo.Enabled AND ;
                    THIS.cnt_4c__Fpagto.cnt_4c__tot.txt_4c_Valinic.Value <> 0
                NODEFAULT
                THIS.CmdAcrescimoClick()

            *-- F6 - Identificacao
            CASE par_nKeyCode = -5 AND loc_oBarra.cmd_4c_Identifica.Enabled AND EMPTY(loc_cItem)
                NODEFAULT
                THIS.CmdIdentificaClick()

            *-- F8 - Pendencia / Crediario (o legado tem os dois no mesmo F8:
            *-- o Case de Pendencia vem primeiro e so cai no Crediario quando
            *-- Financia esta habilitado).
            CASE par_nKeyCode = -7 AND loc_oBarra.cmd_4c_Pendencia.Enabled AND EMPTY(loc_cItem)
                NODEFAULT
                THIS.CmdPendenciaClick()

            CASE par_nKeyCode = -7 AND loc_oBarra.cmd_4c_Financia.Enabled AND EMPTY(loc_cItem)
                NODEFAULT
                THIS.CmdFinanciaClick()

            *-- F9 - Impressora fiscal
            CASE par_nKeyCode = -8 AND loc_oBarra.cmd_4c_Impfiscal.Enabled AND EMPTY(loc_cItem)
                NODEFAULT
                THIS.CmdImpfiscalClick()

            *-- F11 - Pagamento
            CASE par_nKeyCode = 133 AND loc_oBarra.cmd_4c_Pagto.Enabled AND EMPTY(loc_cItem)
                NODEFAULT
                THIS.CmdPagtoClick()
        ENDCASE
    ENDPROC

    *==========================================================================
    * REGISTRO DOS EVENTOS (BINDEVENT)
    *==========================================================================

    *--------------------------------------------------------------------------
    * RegistrarEventosPrincipais - liga o Click de cada botao ao seu handler.
    * Chamado no fim do InicializarForm, quando TODOS os controles ja existem:
    * BINDEVENT contra objeto inexistente estoura no Init e o form nao abre.
    *
    * O When de cada botao NAO e ligado por BINDEVENT: o retorno de um When
    * delegado e DESCARTADO pelo VFP (CLAUDE.md #3) e nao bloqueia nada - por
    * isso a condicao do When legado e checada no inicio do proprio Click, e o
    * gate de Enabled vive em AjustarBotoesPorModo().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventosPrincipais
        LOCAL loc_oBarra

        *-- Barra de botoes principal (os 16 botoes do legado).
        loc_oBarra = THIS.cnt_4c_Barra_Botoes
        BINDEVENT(loc_oBarra.cmd_4c_Itens,      "Click", THIS, "CmdItensClick")
        BINDEVENT(loc_oBarra.cmd_4c_Alteraqtd,  "Click", THIS, "CmdAlteraqtdClick")
        BINDEVENT(loc_oBarra.cmd_4c_Desconto,   "Click", THIS, "CmdDescontoClick")
        BINDEVENT(loc_oBarra.cmd_4c_Acrescimo,  "Click", THIS, "CmdAcrescimoClick")
        BINDEVENT(loc_oBarra.cmd_4c_CancPagto,  "Click", THIS, "CmdCancPagtoClick")
        BINDEVENT(loc_oBarra.cmd_4c_Apaga,      "Click", THIS, "CmdApagaClick")
        BINDEVENT(loc_oBarra.cmd_4c_AltPreco,   "Click", THIS, "CmdAltPrecoClick")
        BINDEVENT(loc_oBarra.cmd_4c_Identifica, "Click", THIS, "CmdIdentificaClick")
        BINDEVENT(loc_oBarra.cmd_4c_Credito,    "Click", THIS, "CmdCreditoClick")
        BINDEVENT(loc_oBarra.cmd_4c_Financia,   "Click", THIS, "CmdFinanciaClick")
        BINDEVENT(loc_oBarra.cmd_4c_Pendencia,  "Click", THIS, "CmdPendenciaClick")
        BINDEVENT(loc_oBarra.cmd_4c_VerPreco,   "Click", THIS, "CmdVerPrecoClick")
        BINDEVENT(loc_oBarra.cmd_4c_Impfiscal,  "Click", THIS, "CmdImpfiscalClick")
        BINDEVENT(loc_oBarra.cmd_4c_Pagto,      "Click", THIS, "CmdPagtoClick")
        BINDEVENT(loc_oBarra.cmd_4c_Ok,         "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oBarra.cmd_4c_Cancela,    "Click", THIS, "BtnCancelarClick")

        *-- Painel de pendencias/sub-niveis.
        BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_Bot_Pendentes, "Click", THIS, "CmdBotPendentesClick")
        BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_Proximo,       "Click", THIS, "PendenciaProximoClick")

        *-- Painel de cancelamento de item.
        BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_Ok,          "Click", THIS, "CancelaItemOkClick")
        BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_CancelaDisp, "Click", THIS, "CancelaItemCancelaDispClick")

        *-- Botao "Proximo" das demais telas de operacao.
        BINDEVENT(THIS.cnt_4c_Item.cmd_4c_Proximo,        "Click", THIS, "ItemProximoClick")
        BINDEVENT(THIS.cnt_4c__Fpagto.cmd_4c_Proximo,     "Click", THIS, "FpagtoProximoClick")
        BINDEVENT(THIS.cnt_4c__Identifica.cmd_4c_Proximo, "Click", THIS, "IdentificaProximoClick")

        *-- Timer da barra de titulo (legado: Timer1.Interval = 1000).
        BINDEVENT(THIS.obj_4c_Timer1, "Timer", THIS, "TimerAtualizarTitulo")
        THIS.obj_4c_Timer1.Enabled = .T.
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvitsBO.prg):
*===============================================================================
* sigmvitsBO.prg - Business Object para Caixa (Frente de Loja / PDV)
* Tabela principal: SigMvCab (cabecalho do movimento/cupom em processamento)
* PK tecnica: empdopnums char(29) = Emps + Dopes + Str(Numes,6)
* Origem legado: SIGMVITS ("Caixa"), pagina/container filho do PDV completo
* Tabelas relacionadas usadas pelo legado (fases seguintes): crTpmMvItn (SigMvItn,
* itens do cupom), SigOpFp/SigOpFpi (formas de pagamento), SigFiFis/SigFiMpf
* (config. fiscal da impressora), SigCdCli (identificacao do cliente/conta),
* SigCdOpe (config. da operacao), SigCdPam (parametros gerais do sistema)
*===============================================================================
DEFINE CLASS sigmvitsBO AS BusinessBase

    *-- Identificacao da tabela (BusinessBase)
    this_cTabela     = "SigMvCab"
    this_cCampoChave = "empdopnums"

    *---------------------------------------------------------------------------
    * Propriedades - SigMvCab (cabecalho do movimento/cupom - TprMvCab no legado)
    *---------------------------------------------------------------------------
    this_cEmpdopnums = ""   && empdopnums char(29) NOT NULL - Chave tecnica (Emps+Dopes+Str(Numes,6))
    this_cEmps       = ""   && emps       char(3)  NOT NULL - Empresa
    this_cDopes      = ""   && dopes      char(20) NOT NULL - Codigo da operacao (tipo de movimento)
    this_nNumes      = 0    && numes      numeric(6,0) NOT NULL - Numero do documento/cupom
    this_cEmpds      = ""   && empds      char(3)  NOT NULL - Empresa do documento
    this_cNemps      = ""   && nemps      char(40) NOT NULL - Nome da empresa (grade/historico)
    this_dDatas      = {}   && datas      datetime NULL - Data do movimento
    this_cContads    = ""   && contads    char(10) NOT NULL - Conta destino (cliente)
    this_cContaos    = ""   && contaos    char(10) NOT NULL - Conta origem
    this_cGrupods    = ""   && grupods    char(10) NOT NULL - Grupo destino
    this_cGrupoos    = ""   && grupoos    char(10) NOT NULL - Grupo origem
    this_cResps      = ""   && resps      char(10) NOT NULL - Responsavel/vendedor destino
    this_cGrresps    = ""   && grresps    char(10) NOT NULL - Grupo do responsavel destino
    this_cVends      = ""   && vends      char(10) NOT NULL - Vendedor
    this_cGrvends    = ""   && grvends    char(10) NOT NULL - Grupo do vendedor
    this_cTabds      = ""   && tabds      char(10) NOT NULL - Tabela de desconto
    this_cLprecos    = ""   && lprecos    char(30) NOT NULL - Lista de precos
    this_cMascnum    = ""   && mascnum    char(10) NOT NULL - Mascara de numeracao do documento
    this_nNpedclis   = 0    && npedclis   numeric(11,0) NOT NULL - Numero do pedido do cliente
    this_cTpfats     = ""   && tpfats     char(3)  NOT NULL - Tipo de faturamento
    this_cEcfs       = ""   && ecfs       char(7)  NOT NULL - Numero de serie do ECF
    this_cNcupoms    = ""   && ncupoms    char(6)  NOT NULL - Numero do cupom fiscal
    this_cCodtrans   = ""   && codtrans   char(10) NOT NULL - Codigo da transacao (TEF/cartao)
    this_cMotdscs    = ""   && motdscs    char(10) NOT NULL - Motivo do desconto
    this_cEspes      = ""   && espes      char(10) NOT NULL - Especie (documento/moeda)
    this_cNotas      = ""   && notas      char(6)  NOT NULL - Numero da nota (impressao)
    this_cObses      = ""   && obses      text NULL - Observacoes (memo)
    this_dPrazoents  = {}   && prazoents  datetime NULL - Prazo de entrega
    this_dDtagends   = {}   && dtagends   datetime NULL - Data agendada
    this_nQtdes      = 0    && qtdes      numeric(6,0) NOT NULL - Quantidade de itens do cupom
    this_nPbrus      = 0    && pbrus      numeric(10,3) NULL - Peso bruto
    this_nPliqs      = 0    && pliqs      numeric(10,3) NULL - Peso liquido
    this_nUtilizados = 0    && utilizados numeric(1,0) NOT NULL - Flag de utilizacao
    this_nLocalents  = 0    && localents  numeric(10,0) NOT NULL - Local de entrega
    this_nValos      = 0    && valos      numeric(11,2) NOT NULL - Valor total do documento
    this_nValinis    = 0    && valinis    numeric(11,2) NOT NULL - Valor inicial (bruto dos itens)
    this_nValdevs    = 0    && valdevs    numeric(11,2) NOT NULL - Valor devolvido
    this_nValobxs    = 0    && valobxs    numeric(11,2) NOT NULL - Valor baixado
    this_nValservs   = 0    && valservs   numeric(11,2) NOT NULL - Valor de servicos
    this_nValvars    = 0    && valvars    numeric(11,2) NOT NULL - Valor de variacao (desconto/acrescimo)
    this_nValvarps   = 0    && valvarps   numeric(11,2) NOT NULL - Valor de variacao percentual
    this_nVars       = 0    && vars       numeric(9,4) NOT NULL - Percentual de variacao
    this_lChkpagos   = .F.  && chkpagos   bit NOT NULL - Flag pagamento conferido
    this_lChksubn    = .F.  && chksubn    bit NOT NULL - Flag possui sub-nivel
    this_lLcancelas  = .F.  && lcancelas  bit NOT NULL - Flag documento cancelado

    *---------------------------------------------------------------------------
    * Init - Configurar tabela e chave primaria
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "empdopnums"
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Para auditoria (BusinessBase override)
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpdopnums)
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Carrega do cursor SQL para as propriedades do BO.
    * SEMPRE usa SELECT (par_cAliasCursor) antes de acessar os campos -
    * "campo" e sintaxe invalida em VFP9 (regra #9 CLAUDE.md).
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_nNumes      = TratarNulo(numes, 0)
                THIS.this_cEmpds      = TratarNulo(empds, "")
                THIS.this_cNemps      = TratarNulo(nemps, "")
                THIS.this_dDatas      = TratarNulo(datas, {})
                THIS.this_cContads    = TratarNulo(contads, "")
                THIS.this_cContaos    = TratarNulo(contaos, "")
                THIS.this_cGrupods    = TratarNulo(grupods, "")
                THIS.this_cGrupoos    = TratarNulo(grupoos, "")
                THIS.this_cResps      = TratarNulo(resps, "")
                THIS.this_cGrresps    = TratarNulo(grresps, "")
                THIS.this_cVends      = TratarNulo(vends, "")
                THIS.this_cGrvends    = TratarNulo(grvends, "")
                THIS.this_cTabds      = TratarNulo(tabds, "")
                THIS.this_cLprecos    = TratarNulo(lprecos, "")
                THIS.this_cMascnum    = TratarNulo(mascnum, "")
                THIS.this_nNpedclis   = TratarNulo(npedclis, 0)
                THIS.this_cTpfats     = TratarNulo(tpfats, "")
                THIS.this_cEcfs       = TratarNulo(ecfs, "")
                THIS.this_cNcupoms    = TratarNulo(ncupoms, "")
                THIS.this_cCodtrans   = TratarNulo(codtrans, "")
                THIS.this_cMotdscs    = TratarNulo(motdscs, "")
                THIS.this_cEspes      = TratarNulo(espes, "")
                THIS.this_cNotas      = TratarNulo(notas, "")
                THIS.this_cObses      = TratarNulo(obses, "")
                THIS.this_dPrazoents  = TratarNulo(prazoents, {})
                THIS.this_dDtagends   = TratarNulo(dtagends, {})
                THIS.this_nQtdes      = TratarNulo(qtdes, 0)
                THIS.this_nPbrus      = TratarNulo(pbrus, 0)
                THIS.this_nPliqs      = TratarNulo(pliqs, 0)
                THIS.this_nUtilizados = TratarNulo(utilizados, 0)
                THIS.this_nLocalents  = TratarNulo(localents, 0)
                THIS.this_nValos      = TratarNulo(valos, 0)
                THIS.this_nValinis    = TratarNulo(valinis, 0)
                THIS.this_nValdevs    = TratarNulo(valdevs, 0)
                THIS.this_nValobxs    = TratarNulo(valobxs, 0)
                THIS.this_nValservs   = TratarNulo(valservs, 0)
                THIS.this_nValvars    = TratarNulo(valvars, 0)
                THIS.this_nValvarps   = TratarNulo(valvarps, 0)
                THIS.this_nVars       = TratarNulo(vars, 0)

                IF VARTYPE(chkpagos) = "L"
                    THIS.this_lChkpagos = chkpagos
                ELSE
                    THIS.this_lChkpagos = (NVL(chkpagos, 0) = 1)
                ENDIF

                IF VARTYPE(chksubn) = "L"
                    THIS.this_lChksubn = chksubn
                ELSE
                    THIS.this_lChksubn = (NVL(chksubn, 0) = 1)
                ENDIF

                IF VARTYPE(lcancelas) = "L"
                    THIS.this_lLcancelas = lcancelas
                ELSE
                    THIS.this_lLcancelas = (NVL(lcancelas, 0) = 1)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigMvCab (PROTECTED, chamado por
    * BusinessBase.Salvar() quando this_lNovoRegistro = .T.)
    *
    * SigMvCab tem 158 colunas, quase todas NOT NULL sem DEFAULT (regra #22
    * CLAUDE.md). Este BO so declara propriedade para as colunas que o
    * container "Caixa" (SIGMVITS) de fato le/grava - as demais colunas
    * NOT NULL recebem o default do TIPO (char="", numeric/bit=0) para nao
    * violar a constraint; colunas NULLABLE sem propriedade sao OMITIDAS da
    * lista (o SQL Server preenche NULL sozinho). cidchaves eh a PK real
    * (fUniqueIds()) - NUNCA string vazia, senao a inclusao inteira falha
    * por colisao/violacao da PRIMARY KEY.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cCidchaves, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cCidchaves = LEFT(fUniqueIds(), 20)

            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCab ("
            loc_cSQL = loc_cSQL + "npedclis, acres, antecs, chksubn, codpeds, contads, contaos, datas,"
            loc_cSQL = loc_cSQL + "desc2s, descs, devols, dopes, empds, emps, grresps, grupods,"
            loc_cSQL = loc_cSQL + "grupoos, grupos, grvends, iclis, ifors, locals, lotechqs, lprecos,"
            loc_cSQL = loc_cSQL + "mascnum, ncarnecs, nemps, nops, notas, nrcons, ntrans, numes,"
            loc_cSQL = loc_cSQL + "numolds, obses, opers, prazoents, resps, tabds, tpfats, transps,"
            loc_cSQL = loc_cSQL + "usuals, usuars, usulibs, valacres, valdes2s, valdescs, valdevs, valencs,"
            loc_cSQL = loc_cSQL + "valinis, valos, valservs, valvars, vars, vends, cotusus, espes,"
            loc_cSQL = loc_cSQL + "pbrus, pliqs, qtdes, lcancelas, cofs, livros, chkbxparcs, ecfs,"
            loc_cSQL = loc_cSQL + "codobs, dgopes, trfisicos, utilizados, valndevs, valobxs, noforms, auditors,"
            loc_cSQL = loc_cSQL + "cidchaves, empdopnums, empgopnums, contaes, dtagends, localents, localizas, chkpagos,"
            loc_cSQL = loc_cSQL + "chkpgs, codtrans, empdnbxs, empdncrds, obsagends, operadors, vcompensas, motdscs,"
            loc_cSQL = loc_cSQL + "ndeclaras, numbalds, numbals, priors, procbals, procdbal, protats, usupagos,"
            loc_cSQL = loc_cSQL + "ultgrvs, moeits, rnops, impress, pstatus, valvarps, cifccfs, cupfis,"
            loc_cSQL = loc_cSQL + "idconta, ncupoms, status, valtrans, impcpfs, ccfgnfs, fpubls, jobs,"
            loc_cSQL = loc_cSQL + "ptax1s, ptax2s, ptax3s, obscabmovs, codobs2, valserfix, perserfix, valosfix,"
            loc_cSQL = loc_cSQL + "chkencerra, perdesc, compet, pedidoweb, cdrastreio, identrega, idtransp, peracresc,"
            loc_cSQL = loc_cSQL + "tpmovs, empfats, numeronota, meiotrans, chavenota, contaccs, grupoccs, natend,"
            loc_cSQL = loc_cSQL + "nlivdg, presente, chaveexterna, empret, msgpresnte, ckoperpend, usuconfs"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNpedclis, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 4) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChksubn, 1, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContads, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContaos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 4) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNemps, 40)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObses) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dPrazoents) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cResps, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTabds, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValdevs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValinis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValservs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValvars, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVars, 4) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVends, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPbrus, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPliqs, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lLcancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUtilizados, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValobxs, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(loc_cCidchaves) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtagends) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nLocalents, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChkpagos, 1, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValvarps, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNcupoms, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResultado < 0
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigMvCab (WHERE empdopnums,
    * chave tecnica desta entidade - Emps+Dopes+Str(Numes,6) - regra #22).
    * cidchaves (PK real da tabela) NUNCA e regravado num UPDATE.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCab SET"
            loc_cSQL = loc_cSQL + " npedclis = " + FormatarNumeroSQL(THIS.this_nNpedclis, 0) + ","
            loc_cSQL = loc_cSQL + " chksubn = " + IIF(THIS.this_lChksubn, 1, 0) + ","
            loc_cSQL = loc_cSQL + " contads = " + EscaparSQL(LEFT(THIS.this_cContads, 10)) + ","
            loc_cSQL = loc_cSQL + " contaos = " + EscaparSQL(LEFT(THIS.this_cContaos, 10)) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " empds = " + EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grresps = " + EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + ","
            loc_cSQL = loc_cSQL + " grupods = " + EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + ","
            loc_cSQL = loc_cSQL + " grupoos = " + EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + ","
            loc_cSQL = loc_cSQL + " grvends = " + EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + ","
            loc_cSQL = loc_cSQL + " lprecos = " + EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + ","
            loc_cSQL = loc_cSQL + " mascnum = " + EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + ","
            loc_cSQL = loc_cSQL + " nemps = " + EscaparSQL(LEFT(THIS.this_cNemps, 40)) + ","
            loc_cSQL = loc_cSQL + " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " obses = " + EscaparSQL(THIS.this_cObses) + ","
            loc_cSQL = loc_cSQL + " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ","
            loc_cSQL = loc_cSQL + " resps = " + EscaparSQL(LEFT(THIS.this_cResps, 10)) + ","
            loc_cSQL = loc_cSQL + " tabds = " + EscaparSQL(LEFT(THIS.this_cTabds, 10)) + ","
            loc_cSQL = loc_cSQL + " tpfats = " + EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + ","
            loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ","
            loc_cSQL = loc_cSQL + " valdevs = " + FormatarNumeroSQL(THIS.this_nValdevs, 2) + ","
            loc_cSQL = loc_cSQL + " valinis = " + FormatarNumeroSQL(THIS.this_nValinis, 2) + ","
            loc_cSQL = loc_cSQL + " valos = " + FormatarNumeroSQL(THIS.this_nValos, 2) + ","
            loc_cSQL = loc_cSQL + " valservs = " + FormatarNumeroSQL(THIS.this_nValservs, 2) + ","
            loc_cSQL = loc_cSQL + " valvars = " + FormatarNumeroSQL(THIS.this_nValvars, 2) + ","
            loc_cSQL = loc_cSQL + " vars = " + FormatarNumeroSQL(THIS.this_nVars, 4) + ","
            loc_cSQL = loc_cSQL + " vends = " + EscaparSQL(LEFT(THIS.this_cVends, 10)) + ","
            loc_cSQL = loc_cSQL + " espes = " + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + " pbrus = " + FormatarNumeroSQL(THIS.this_nPbrus, 3) + ","
            loc_cSQL = loc_cSQL + " pliqs = " + FormatarNumeroSQL(THIS.this_nPliqs, 3) + ","
            loc_cSQL = loc_cSQL + " qtdes = " + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + " lcancelas = " + IIF(THIS.this_lLcancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + " ecfs = " + EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + ","
            loc_cSQL = loc_cSQL + " utilizados = " + FormatarNumeroSQL(THIS.this_nUtilizados, 0) + ","
            loc_cSQL = loc_cSQL + " valobxs = " + FormatarNumeroSQL(THIS.this_nValobxs, 2) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " dtagends = " + FormatarDataSQL(THIS.this_dDtagends) + ","
            loc_cSQL = loc_cSQL + " localents = " + FormatarNumeroSQL(THIS.this_nLocalents, 0) + ","
            loc_cSQL = loc_cSQL + " chkpagos = " + IIF(THIS.this_lChkpagos, 1, 0) + ","
            loc_cSQL = loc_cSQL + " codtrans = " + EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + ","
            loc_cSQL = loc_cSQL + " motdscs = " + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + " valvarps = " + FormatarNumeroSQL(THIS.this_nValvarps, 2) + ","
            loc_cSQL = loc_cSQL + " ncupoms = " + EscaparSQL(LEFT(THIS.this_cNcupoms, 6))
            loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

