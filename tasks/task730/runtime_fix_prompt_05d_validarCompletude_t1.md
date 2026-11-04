# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigOpEnc.prg] Indicador de pendencia: * que a Fase 6 deixou documentado como pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEnc.prg):
*==============================================================================
* FormSigOpEnc.prg - Encerramento de Contas
* Origem: SIGOPENC.SCX (task730)
* Herda de: FormBase
* Tipo: OPERACIONAL (flat layout - sem PageFrame/paginas; Container1 do legado
*       concentra o filtro + contra-partida e a grade de saldos fica solta
*       no form, dentro de uma moldura Shape)
*
* FASE 5/8 - Campos principais: bloco "Filtro" do Container1 legado
* (Label1 / lbl_grupo / Get_Grupo / Get_DGrupo / Say1 / Get_Conta /
* get_Dconta), com a dependencia entre eles (os "Procedure When" do legado)
* e o funil que repassa o filtro ao BO e recarrega a grade (as chamadas a
* ThisForm.MontaTela() dos Valid).
*
* FASE 6/8 - Campos restantes e lookups: bloco "Contra-Partida" (Label4 /
* Say4 / Get_GrupoC / Get_DgrupoC / Say5 / Get_contaC / Get_DcontaC) e bloco
* "Operacao" (Shape1 / Label2 / Get_Dope, lido de SigCdPac.DopZers no Init).
*
* A resolucao codigo <-> descricao NAO chama fAcessoContab/fAcessoContas
* direto: essas funcoes (utils\functions.prg) reexibem o picker legado
* (FormBuscaSimples) e, apos ele fechar, leem o REGISTRO CORRENTE do cursor
* de apoio para preencher o TextBox - sem distinguir "usuario selecionou" de
* "usuario cancelou", o mesmo defeito que a memoria do projeto documenta para
* fAcessoContas em lookup de UI (auto-preenche com o 1o registro). Em troca,
* THIS.ResolverCodigoDescricao() usa o padrao canonico do projeto: busca
* EXATA pelo valor digitado e, so se ela falhar, abre o picker por
* THIS.AbrirLookupCanonico() (herdado de FormBase), que so atribui o valor
* quando this_lSelecionou confirma a escolha do usuario.
*
* FASE 7/8 - Este form NAO tem CRUD (o legado nao declara Incluir/Alterar/
* Visualizar/Excluir - comportamento.json nao lista nenhum desses verbos; os
* unicos botoes sao SelTudo/Apaga/Processar/Encerrar, ja cobertos nas fases
* anteriores). O trabalho real desta fase e completar BtnProcessarClick com
* os 4 guards do cmdProcessa.Click legado e com a geracao dos lancamentos de
* encerramento em si (THIS.this_oBusinessObject.ProcessarEncerramento()),
* que a Fase 6 deixou documentado como pendente.
*
* FASE 8/8 - CONSOLIDACAO FINAL: os nomes genericos de form CRUD que um
* checklist padrao cobraria (BtnBuscarClick, BtnSalvarClick, BtnCancelarClick,
* FormParaBO/BOParaForm, Habilitar/LimparCampos, CarregarLista,
* AjustarBotoesPorModo) NAO se aplicam aqui, pela mesma razao da Fase 7: o
* legado SIGOPENC nao tem Page1=Lista/Page2=Dados, nao tem registro unico em
* edicao e nao grava por Inserir/Atualizar/Excluir - e um dialogo de
* PROCESSAMENTO EM LOTE (marca contas na grade de saldos e gera, de uma vez,
* os lancamentos de encerramento de todas as marcadas). Os equivalentes reais
* ja existem sob os nomes do dominio do form:
*   CarregarLista()        -> CarregarDados() (recarrega grd_4c_Dados)
*   LimparCampos()         -> LimparFiltro() (zera os 8 campos do Container1)
*   BtnSalvarClick()       -> BtnProcessarClick() (acao principal, com os 4
*                             guards do legado e ProcessarEncerramento())
*   BtnCancelarClick()     -> nao existe no legado (nao ha edicao para
*                             cancelar; LimparFiltro() e o "reset" ja usado
*                             dentro do proprio BtnProcessarClick ao concluir)
*   BtnBuscarClick()       -> nao existe no legado (a consulta de saldos e
*                             automatica via AplicarFiltro(), nos LostFocus
*                             dos campos de Grupo/Conta - nao ha botao
*                             "Buscar" no dump)
*   HabilitarCampos()/
*   AjustarBotoesPorModo() -> nao existem no legado (nao ha modo
*                             INCLUIR/ALTERAR/VISUALIZAR; os campos do filtro
*                             ficam sempre editaveis, e o unico Enabled
*                             condicional e cmd_4c_CmdProcessa, ja tratado em
*                             CarregarDados())
*
* O "Procedure Load" do legado (=fConfigGeral()) fica de fora pela mesma
* decisao ja documentada em FormSIGPRMEI.prg/FormSigMvExp.prg/
* FormSigOpCcl.prg: fConfigGeral era funcao GLOBAL do legado (sig.prg/
* SIGFUNCS.PRG) que nao veio no acervo; o wrapper NO-OP em
* projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX legado
* continuar resolvendo o nome, e em codigo NOSSO nunca se chama fConfigGeral.
*
* "Procedure fazcontra" do legado (gera a entrada espelhada/contra-partida a
* partir do registro CORRENTE de CrSigMvCcr) nao virou metodo separado: esta
* dobrada dentro do SCAN de THIS.this_oBusinessObject.ProcessarEncerramento(),
* no bloco "Entrada CONTRA-PARTIDA", que troca Grupos/Contas/Opers pelos
* campos S* na mesma iteracao em que a entrada direta e montada - evita
* depender de releitura de "registro corrente" (que nesta arquitetura nao
* existe um cursor crSigMvCcr com Append Blank, e sim um INSERT INTO
* SigMvCcr por SQLEXEC).
*==============================================================================

DEFINE CLASS FormSigOpEnc AS FormBase

    Width        = 800
    Height       = 600
    AutoCenter   = .T.
    Caption      = "Encerramento de Contas"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    DataSession  = 1

    *-- Guarda de reentrancia dos lookups (regra CLAUDE.md #37/#47): o picker
    *-- FormBuscaAuxiliar e MODAL e e aberto de DENTRO de um LostFocus; ao
    *-- tomar o foco ele faz o proprio LostFocus do campo disparar de novo, o
    *-- que empilharia um segundo dialogo sobre o primeiro. Ligada no FUNIL
    *-- (AbrirLookup<X>) e liberada DEPOIS que ele retorna.
    this_lEmLookup = .F.

    *==========================================================================
    * Init - DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object e monta a estrutura visual base
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpEncBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar SigOpEncBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigOpEnc.InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- SigCdPac.DopZers precisa estar lido ANTES de
                *-- ConfigurarContainerFiltro(), que copia o valor para
                *-- txt_4c_Dope.Value dentro de ConfigurarCamposOperacao()
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.this_oBusinessObject.CarregarParametros()
                ENDIF

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarContainerFiltro()
                THIS.ConfigurarAreaSaldo()
                THIS.ConfigurarBotoesAcao()

                THIS.TornarControlesVisiveis(THIS)

                *-- Carga inicial da grade. Com o filtro de Grupo vazio o
                *-- sentinela ZYWZYWZYWZ do legado nao casa nada e a grade
                *-- abre VAZIA, de proposito (regra #35a).
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarDados()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado) com o
    * titulo do form duplicado (sombra preta + texto branco por cima)
    *==========================================================================
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
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
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
            .Caption   = THIS.Caption
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = 769
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerFiltro - Moldura "Filtro / Contra-Partida" (Container1
    * do legado) e, dentro dela, os tres blocos de campos: Filtro,
    * Contra-Partida e Operacao (com o Shape1 que destaca a Operacao).
    *
    * AjustarTabIndexContainer1() roda por ULTIMO, so depois que os 16
    * controles com TabIndex no dump (labels inclusive) ja existem no
    * container - setar o TabIndex de um rotulo (9, 10, 11, 13..16) ANTES
    * disso reduziria o valor ao ControlCount corrente (regra do VFP9 que
    * limita TabIndex ao numero de controles ja existentes).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerFiltro()
        THIS.AddObject("cnt_4c_Filtro", "Container")
        WITH THIS.cnt_4c_Filtro
            .Top         = 106
            .Left        = 60
            .Width       = 679
            .Height      = 132
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarCamposFiltro()
        THIS.ConfigurarCamposContraPartida()
        THIS.ConfigurarCamposOperacao()
        THIS.AjustarTabIndexContainer1()
    ENDPROC

    *==========================================================================
    * ConfigurarCamposFiltro - Bloco "Filtro" do Container1 legado, transcrito
    * objeto a objeto do dump (Top/Left/Width/Height/Font/ForeColor/Format/
    * MaxLength). Os Top/Left ficam IGUAIS aos do dump porque sao relativos ao
    * Container, que ja esta posicionado em 106,60 - nao ha PageFrame com
    * Top = -29 neste form (layout FLAT), logo nao ha compensacao a aplicar.
    *
    * Mapa legado -> migrado:
    *   Label1     "Filtro"  -> lbl_4c_Filtro
    *   lbl_grupo  "Grupo :" -> lbl_4c_Grupo
    *   Get_Grupo            -> txt_4c_Grupo    (SigCdGcr.codigos char(10))
    *   Get_DGrupo           -> txt_4c_DGrupo   (SigCdGcr.descrs  char(40))
    *   Say1       "Conta :" -> lbl_4c_Conta
    *   Get_Conta            -> txt_4c_Conta    (SigCdCli.iclis   char(10))
    *   get_Dconta           -> txt_4c_DConta   (SigCdCli.rclis   char(50))
    *
    * ForeColor dos rotulos: Label1 declara 255,0,0 EXPLICITO no dump (titulo
    * de secao em Verdana 10 bold, igual ao Label4/Label2 do mesmo container);
    * lbl_grupo e Say1 declaram 90,90,90, que tambem e o canonico da classe
    * say sobre a textura clara do form (regra CLAUDE.md #12). Nenhum deles
    * leva branco.
    *
    * AutoSize: lbl_grupo declara AutoSize = .T. no dump, mas AutoSize e
    * NO-OP em Label criado por AddObject (regra CLAUDE.md #23) - por isso
    * .AutoSize = .F. com Width/Height transcritos do dump, que JA SAO o
    * auto-size calculado pelo Form Designer. Alignment NAO e declarado em
    * rotulo nenhum deste bloco: fica 0 (esquerda), como a classe say.
    *
    * Alignment dos TextBox: o dump NAO declara Alignment em nenhum dos quatro
    * getters, entao a propriedade NAO e tocada - TextBox criado por AddObject
    * nasce com Alignment = 3, e inventar 0 aqui seria divergencia visual.
    *
    * Format/MaxLength (regras CLAUDE.md #49 e #19):
    *   Get_Grupo   Format = "!"  (maiuscula)      MaxLength = 10
    *   Get_DGrupo  Format = ""   -> override VAZIO do Form Designer, NAO se
    *                               transcreve                MaxLength = 20
    *   Get_Conta   classe fwget -> Format = "K" por heranca  MaxLength = 10
    *   get_Dconta  classe fwget -> Format = "K" por heranca  MaxLength = 50
    * MaxLength vem da largura da COLUNA no schema, nunca do Width em pixels:
    * SigCdGcr.codigos/SigCdCli.iclis sao char(10) e SigCdCli.rclis e char(50)
    * (os dois ultimos conferem com o MaxLength = 50 declarado no dump).
    * Get_DGrupo mantem o 20 do dump: e o limite de digitacao que o legado
    * impoe na busca por descricao, nao a largura de SigCdGcr.descrs.
    *
    * Propriedades herdadas da classe fwget (framework.vcx) que o TextBox base
    * do VFP9 nao traz, transcritas nos dois getters de classe fwget:
    * Height = 23, Themes = .F., DisabledBackColor = 192,192,192,
    * DisabledForeColor = 0,0,0. Get_Conta nao declara Height no dump porque
    * herda esse 23 - os irmaos fwget do mesmo container o declaram.
    *
    * TabIndex: so os quatro getters o recebem aqui (1..4, exatamente os do
    * dump). Os rotulos deste bloco tambem declaram TabIndex no dump (9, 10 e
    * 15), mas Label nao e ponto de parada do Tab e o VFP9 LIMITA o TabIndex
    * ao numero de controles ja existentes no container: gravar 15 num
    * container com 7 controles o reduziria a 7 e renumeraria os getters,
    * trocando a ordem de navegacao. Os TabIndex dos rotulos e dos demais
    * getters (5..8 e 12) sao aplicados por AjustarTabIndexContainer1(), no
    * final de ConfigurarContainerFiltro(), quando os 16 controles do dump
    * (Contra-Partida e Operacao inclusive) ja existem no container.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtro

        *-- Label1 "Filtro" (titulo da secao)
        loc_oCnt.AddObject("lbl_4c_Filtro", "Label")
        WITH loc_oCnt.lbl_4c_Filtro
            .Top       = 2
            .Left      = 3
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(255, 0, 0)
            .Caption   = "Filtro"
            .Visible   = .T.
        ENDWITH

        *-- lbl_grupo "Grupo :"
        loc_oCnt.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oCnt.lbl_4c_Grupo
            .Top       = 7
            .Left      = 83
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo :"
            .Visible   = .T.
        ENDWITH

        *-- Get_Grupo - codigo do Grupo de Contas do filtro (SigCdGcr.codigos)
        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .Top       = 3
            .Left      = 123
            .Width     = 80
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "!"
            .MaxLength = 10
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 1
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Get_DGrupo - descricao do Grupo do filtro (SigCdGcr.descrs)
        loc_oCnt.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oCnt.txt_4c_DGrupo
            .Top       = 3
            .Left      = 204
            .Width     = 290
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 20
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 2
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say1 "Conta :"
        loc_oCnt.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oCnt.lbl_4c_Conta
            .Top       = 32
            .Left      = 83
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta :"
            .Visible   = .T.
        ENDWITH

        *-- Get_Conta - codigo da Conta do filtro (SigCdCli.iclis)
        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .Top               = 29
            .Left              = 123
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .MaxLength         = 10
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .TabIndex          = 3
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- get_Dconta - descricao da Conta do filtro (SigCdCli.rclis)
        loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oCnt.txt_4c_DConta
            .Top               = 29
            .Left              = 204
            .Width             = 290
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .MaxLength         = 50
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .TabIndex          = 4
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- DEPENDENCIA entre os campos (os "Procedure When" do legado, que
        *-- bloqueiam o foco enquanto a dependencia nao e satisfeita).
        *-- BINDEVENT "When" funciona de forma confiavel em TextBox - ao
        *-- contrario de "Valid", que NAO e (regra CLAUDE.md).
        BINDEVENT(loc_oCnt.txt_4c_DGrupo, "When", THIS, "DGrupoWhen")
        BINDEVENT(loc_oCnt.txt_4c_Conta,  "When", THIS, "ContaWhen")
        BINDEVENT(loc_oCnt.txt_4c_DConta, "When", THIS, "DContaWhen")

        *-- O Valid do legado roda ao SAIR do campo; o gancho equivalente e
        *-- "LostFocus" (BINDEVENT "Valid" nao e confiavel em TextBox).
        BINDEVENT(loc_oCnt.txt_4c_Grupo,  "LostFocus", THIS, "GrupoLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_DGrupo, "LostFocus", THIS, "DGrupoLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_Conta,  "LostFocus", THIS, "ContaLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_DConta, "LostFocus", THIS, "DContaLostFocus")
    ENDPROC

    *==========================================================================
    * ConfigurarCamposContraPartida - Bloco "Contra-Partida" do Container1
    * legado, transcrito do dump: Label4 (titulo da secao) / Get_GrupoC +
    * Get_DgrupoC + Say4 (par Grupo) / Get_contaC + Get_DcontaC + Say5 (par
    * Conta). Os quatro getters sao classe fwget (framework.vcx), igual aos
    * da fase anterior: Height = 23, Themes = .F., DisabledBackColor/
    * DisabledForeColor.
    *
    * Mapa legado -> migrado:
    *   Label4     "Contra-Partida" -> lbl_4c_ContraPartida
    *   Say4       "Grupo :"        -> lbl_4c_GrupoC
    *   Get_GrupoC                  -> txt_4c_GrupoC   (SigCdGcr.codigos char(10))
    *   Get_DgrupoC                 -> txt_4c_DGrupoC  (SigCdGcr.descrs  char(40))
    *   Say5       "Conta :"        -> lbl_4c_ContaC
    *   Get_contaC                  -> txt_4c_ContaC   (SigCdCli.iclis   char(10))
    *   Get_DcontaC                 -> txt_4c_DContaC  (SigCdCli.rclis   char(50))
    *
    * ForeColor: Label4 declara 255,0,0 (mesmo vermelho de Label1, titulo de
    * secao); Say4/Say5 declaram 90,90,90 (classe say sobre a textura clara
    * do form, regra CLAUDE.md #12). AutoSize = .T. de Label4 e NO-OP em
    * Label por AddObject (regra #23) - fica .F. com Width/Height do dump.
    *
    * MaxLength (regra #19): Get_GrupoC/Get_contaC usam o default herdado da
    * classe fwget (sem MaxLength no dump); Get_DcontaC declara 50, que
    * confere com SigCdCli.rclis char(50). Get_DgrupoC nao declara MaxLength
    * no dump.
    *
    * TabIndex: fica para AjustarTabIndexContainer1() - ver comentario em
    * ConfigurarContainerFiltro().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposContraPartida()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtro

        *-- Label4 "Contra-Partida" (titulo da secao)
        loc_oCnt.AddObject("lbl_4c_ContraPartida", "Label")
        WITH loc_oCnt.lbl_4c_ContraPartida
            .Top       = 53
            .Left      = 2
            .Width     = 110
            .Height    = 18
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(255, 0, 0)
            .Caption   = "Contra-Partida"
            .Visible   = .T.
        ENDWITH

        *-- Say4 "Grupo :" (rotulo do par GrupoC/DgrupoC)
        loc_oCnt.AddObject("lbl_4c_GrupoC", "Label")
        WITH loc_oCnt.lbl_4c_GrupoC
            .Top       = 78
            .Left      = 83
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo :"
            .Visible   = .T.
        ENDWITH

        *-- Get_GrupoC - codigo do Grupo contra-partida (SigCdGcr.codigos)
        loc_oCnt.AddObject("txt_4c_GrupoC", "TextBox")
        WITH loc_oCnt.txt_4c_GrupoC
            .Top               = 75
            .Left              = 123
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .MaxLength         = 10
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Get_DgrupoC - descricao do Grupo contra-partida (SigCdGcr.descrs)
        loc_oCnt.AddObject("txt_4c_DGrupoC", "TextBox")
        WITH loc_oCnt.txt_4c_DGrupoC
            .Top               = 75
            .Left              = 204
            .Width             = 290
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .MaxLength         = 40
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Say5 "Conta :" (rotulo do par ContaC/DContaC)
        loc_oCnt.AddObject("lbl_4c_ContaC", "Label")
        WITH loc_oCnt.lbl_4c_ContaC
            .Top       = 102
            .Left      = 83
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta :"
            .Visible   = .T.
        ENDWITH

        *-- Get_contaC - codigo da Conta contra-partida (SigCdCli.iclis)
        loc_oCnt.AddObject("txt_4c_ContaC", "TextBox")
        WITH loc_oCnt.txt_4c_ContaC
            .Top               = 99
            .Left              = 123
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .MaxLength         = 10
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Get_DcontaC - descricao da Conta contra-partida (SigCdCli.rclis)
        loc_oCnt.AddObject("txt_4c_DContaC", "TextBox")
        WITH loc_oCnt.txt_4c_DContaC
            .Top               = 99
            .Left              = 204
            .Width             = 290
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .MaxLength         = 50
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- DEPENDENCIA entre os campos (os "Procedure When" do legado).
        *-- Get_GrupoC e Get_contaC NAO tem "Procedure When" no dump - ficam
        *-- sempre habilitados, sem depender do par Grupo/Conta do Filtro.
        BINDEVENT(loc_oCnt.txt_4c_DGrupoC, "When", THIS, "DGrupoCWhen")
        BINDEVENT(loc_oCnt.txt_4c_DContaC, "When", THIS, "DContaCWhen")

        *-- O Valid do legado roda ao SAIR do campo (regra LostFocus, como no
        *-- bloco Filtro). Nenhum dos quatro chama MontaTela() - a
        *-- Contra-Partida nao afeta a consulta da grade de saldos.
        BINDEVENT(loc_oCnt.txt_4c_GrupoC,  "LostFocus", THIS, "GrupoCLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_DGrupoC, "LostFocus", THIS, "DGrupoCLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_ContaC,  "LostFocus", THIS, "ContaCLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_DContaC, "LostFocus", THIS, "DContaCLostFocus")
    ENDPROC

    *==========================================================================
    * ConfigurarCamposOperacao - Bloco "Operacao" do Container1 legado:
    * Shape1 (moldura) + Label2 (titulo da secao) + Get_Dope (valor lido de
    * SigCdPac.DopZers no Init - this_cOperacao do BO, ja carregado por
    * CarregarParametros() antes deste metodo rodar).
    *
    * Get_Dope.When do legado devolve .F. incondicional: o campo nunca recebe
    * foco, e por isso nunca e digitado pelo usuario - e so exibicao do
    * parametro do sistema. BackColor 255,255,215 (amarelo palido) e o padrao
    * do framework legado para esse tipo de campo informativo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposOperacao()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtro

        loc_oCnt.AddObject("shp_4c_Operacao", "Shape")
        WITH loc_oCnt.shp_4c_Operacao
            .Top         = 72
            .Left        = 509
            .Width       = 166
            .Height      = 57
            .BackStyle   = 0
            .Curvature   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Label2 "Operacao" (titulo da secao)
        loc_oCnt.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oCnt.lbl_4c_Operacao
            .Top       = 78
            .Left      = 517
            .Width     = 72
            .Height    = 18
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(255, 0, 0)
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        *-- Get_Dope - operacao de movimento de estoque (SigCdPac.DopZers)
        loc_oCnt.AddObject("txt_4c_Dope", "TextBox")
        WITH loc_oCnt.txt_4c_Dope
            .Top       = 99
            .Left      = 516
            .Width     = 151
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .MaxLength = 20
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 215)
            .Value     = THIS.this_oBusinessObject.this_cOperacao
            .Visible   = .T.
        ENDWITH

        *-- Get_Dope.When devolve .F. incondicional no legado
        BINDEVENT(loc_oCnt.txt_4c_Dope, "When", THIS, "DopeWhen")
    ENDPROC

    *==========================================================================
    * AjustarTabIndexContainer1 - Aplica o TabIndex dos rotulos e dos getters
    * de Contra-Partida/Operacao, transcritos do dump (regra CLAUDE.md #
    * explicada em ConfigurarCamposFiltro). Roda por ULTIMO, quando os 16
    * controles ja existem no container - so assim o VFP9 aceita os valores
    * altos (9..16) sem renumerar/limitar.
    *==========================================================================
    PROTECTED PROCEDURE AjustarTabIndexContainer1()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtro

        loc_oCnt.txt_4c_GrupoC.TabIndex         = 5
        loc_oCnt.txt_4c_DGrupoC.TabIndex        = 6
        loc_oCnt.txt_4c_ContaC.TabIndex         = 7
        loc_oCnt.txt_4c_DContaC.TabIndex        = 8
        loc_oCnt.lbl_4c_Grupo.TabIndex          = 9
        loc_oCnt.lbl_4c_Filtro.TabIndex         = 10
        loc_oCnt.lbl_4c_ContraPartida.TabIndex  = 11
        loc_oCnt.txt_4c_Dope.TabIndex           = 12
        loc_oCnt.lbl_4c_GrupoC.TabIndex         = 13
        loc_oCnt.lbl_4c_ContaC.TabIndex         = 14
        loc_oCnt.lbl_4c_Conta.TabIndex          = 15
        loc_oCnt.lbl_4c_Operacao.TabIndex       = 16
    ENDPROC

    *==========================================================================
    * DGrupoWhen / ContaWhen / DContaWhen - equivalentes aos "Procedure When"
    * do legado, transcritos um a um:
    *
    *   Get_DGrupo.When  -> IsEmpty(Get_Grupo.Value)
    *   Get_Conta.When   -> Not IsEmpty(Get_Grupo.Value)
    *   get_Dconta.When  -> IsEmpty(Get_Conta.Value) And
    *                       Not IsEmpty(Get_Grupo.Value)
    *
    * Isto e, cada par codigo/descricao aceita digitacao por UM lado so, e a
    * Conta so abre depois que o Grupo esta preenchido.
    *
    * DGrupoCWhen / DContaCWhen seguem o mesmo padrao para a Contra-Partida -
    * Get_GrupoC e Get_contaC NAO tem When no dump (sempre habilitados):
    *
    *   Get_DgrupoC.When -> IsEmpty(Get_GrupoC.Value)
    *   Get_DcontaC.When -> IsEmpty(Get_ContaC.Value)
    *
    * DopeWhen e o Get_Dope.When do legado - devolve .F. incondicional, o
    * campo nunca recebe foco (e so exibicao do parametro do sistema).
    *
    * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
    *==========================================================================
    FUNCTION DGrupoWhen()
        RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
    ENDFUNC

    FUNCTION ContaWhen()
        RETURN !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
    ENDFUNC

    FUNCTION DContaWhen()
        RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)) AND ;
               !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
    ENDFUNC

    FUNCTION DGrupoCWhen()
        RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value))
    ENDFUNC

    FUNCTION DContaCWhen()
        RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value))
    ENDFUNC

    FUNCTION DopeWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * ResolverCodigoDescricao - Substitui fAcessoContab()/fAcessoContas() na
    * resolucao codigo <-> descricao dos quatro pares de campos deste form
    * (Grupo/DGrupo, GrupoC/DgrupoC, Conta/DConta, ContaC/DContaC).
    *
    * As duas funcoes legado (utils\functions.prg) reexibem o picker
    * FormBuscaSimples e, ao fechar, leem o REGISTRO CORRENTE do cursor de
    * apoio para preencher o par - sem distinguir "usuario selecionou" de
    * "usuario cancelou o dialogo". E exatamente o defeito que a memoria do
    * projeto documenta para fAcessoContas em lookup de UI (auto-preenche com
    * o 1o registro do cursor ao cancelar). Aqui, em troca, busca-se o valor
    * EXATO primeiro; so na falta dele abre-se THIS.AbrirLookupCanonico()
    * (herdado de FormBase), que SO atribui quando o usuario confirma a
    * escolha (this_lSelecionou) - nunca apaga o que foi digitado (regra
    * CLAUDE.md #50).
    *
    * Resolve por CODIGO se par_oTxtCod estiver preenchido (gancho dos
    * LostFocus de Grupo/GrupoC/Conta/ContaC); por DESCRICAO caso contrario
    * (gancho dos LostFocus de DGrupo/DgrupoC/DConta/DContaC) - a mutua
    * exclusividade e garantida pelos When acima, que so liberam o campo de
    * descricao quando o de codigo esta vazio.
    *
    * PROTECTED: nenhum BINDEVENT aponta direto para este metodo (so para os
    * *LostFocus que o chamam).
    *==========================================================================
    PROTECTED PROCEDURE ResolverCodigoDescricao(par_oTxtCod, par_oTxtDesc, ;
            par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
        LOCAL loc_cCod, loc_cDesc, loc_cCursor, loc_cSQL, loc_nResult, loc_oErro
        loc_cCursor = "cursor_4c_ResolverCodDesc"

        TRY
            loc_cCod  = ALLTRIM(par_oTxtCod.Value)
            loc_cDesc = ALLTRIM(par_oTxtDesc.Value)

            IF !EMPTY(loc_cCod)
                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF

                loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
                    " FROM " + par_cTabela + ;
                    " WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cCod) + ;
                    IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                    SELECT (loc_cCursor)
                    par_oTxtDesc.Value = ALLTRIM(Descs)
                ELSE
                    THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
                        par_cTitulo, loc_cCod, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)
                ENDIF

                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF
            ELSE
                IF !EMPTY(loc_cDesc)
                    IF USED(loc_cCursor)
                        USE IN (loc_cCursor)
                    ENDIF

                    loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
                        " FROM " + par_cTabela + ;
                        " WHERE " + par_cCampoDesc + " = " + EscaparSQL(loc_cDesc) + ;
                        IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                    IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                        SELECT (loc_cCursor)
                        par_oTxtCod.Value = ALLTRIM(Cods)
                    ELSE
                        THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
                            par_cTitulo, loc_cDesc, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)
                    ENDIF

                    IF USED(loc_cCursor)
                        USE IN (loc_cCursor)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.ResolverCodigoDescricao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupo / AbrirLookupConta / AbrirLookupGrupoC / AbrirLookupContaC
    * - FUNIL de lookup dos quatro pares codigo/descricao do form. Um metodo
    * por PAR (nao por campo): no legado o mesmo fAcessoContab/fAcessoContas
    * atende o Valid do codigo E o da descricao, decidindo pelo argumento
    * 'C'/'D'; aqui quem decide e ResolverCodigoDescricao, olhando qual dos
    * dois TextBox do par esta preenchido.
    *
    * Tabelas e colunas transcritas do legado (NUNCA adivinhadas):
    *   fAcessoContab -> SigCdGcr (codigos / descrs)  - grupos contabeis
    *   fAcessoContas -> SigCdCli (iclis  / rclis )   - contas correntes,
    *                    restritas ao grupo do bloco (pGrp do legado)
    *
    * A guarda this_lEmLookup mora AQUI, no funil, e nao em cada LostFocus:
    * assim cobre tambem qualquer outra entrada futura (F3/DblClick) com uma
    * unica trava. Como ResolverCodigoDescricao envolve todo o corpo em
    * TRY/CATCH e nao tem RETURN antecipado, a linha que libera a flag roda
    * sempre - inclusive quando o CATCH dispara (regra CLAUDE.md #47).
    *
    * PUBLIC (sem PROTECTED): sao chamados pelos *LostFocus e podem ser
    * acionados de FORA da classe (harness de teste) - regra CLAUDE.md #3/#51.
    *==========================================================================
    PROCEDURE AbrirLookupGrupo()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_Grupo, ;
            THIS.cnt_4c_Filtro.txt_4c_DGrupo, ;
            "SigCdGcr", "codigos", "descrs", ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE AbrirLookupConta()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_Conta, ;
            THIS.cnt_4c_Filtro.txt_4c_DConta, ;
            "SigCdCli", "iclis", "rclis", ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
            THIS.FiltroGrupoParaConta())
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE AbrirLookupGrupoC()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_GrupoC, ;
            THIS.cnt_4c_Filtro.txt_4c_DGrupoC, ;
            "SigCdGcr", "codigos", "descrs", ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo (Contra-Partida)", "")
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE AbrirLookupContaC()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_ContaC, ;
            THIS.cnt_4c_Filtro.txt_4c_DContaC, ;
            "SigCdCli", "iclis", "rclis", ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta (Contra-Partida)", ;
            THIS.FiltroGrupoCParaConta())
        THIS.this_lEmLookup = .F.
    ENDPROC

    *==========================================================================
    * GrupoLostFocus / DGrupoLostFocus / ContaLostFocus / DContaLostFocus -
    * o que o Valid do legado faz ao sair de cada campo do Filtro:
    *
    *   Get_Grupo.Valid  -> fAcessoContab('C',...) / lcGrupo = This.Value /
    *                       ThisForm.MontaTela() / Refreshes
    *   Get_DGrupo.Valid -> fAcessoContab('D',...) / ThisForm.MontaTela()
    *   Get_Conta.Valid  -> fAcessoContas('C',...) / ThisForm.MontaTela()
    *   get_Dconta.Valid -> fAcessoContas('D',...) / ThisForm.MontaTela()
    *
    * O lookup fica no funil THIS.AbrirLookup<X>() (ver comentario acima), que
    * substitui as chamadas a fAcessoContab/fAcessoContas. O MontaTela() esta
    * no funil UNICO AplicarFiltro, que repassa o filtro ao BO e chama
    * CarregarDados.
    *
    * O IF de reentrancia aqui, alem do que ja existe no AbrirLookup<X>,
    * suprime tambem o AplicarFiltro() quando o LostFocus redispara com o
    * picker modal aberto - recarregar a grade por baixo do dialogo nao e o
    * que o legado faz.
    *
    * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
    *==========================================================================
    PROCEDURE GrupoLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.AbrirLookupGrupo()
        THIS.AplicarFiltro()
    ENDPROC

    PROCEDURE DGrupoLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.AbrirLookupGrupo()
        THIS.AplicarFiltro()
    ENDPROC

    PROCEDURE ContaLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.AbrirLookupConta()
        THIS.AplicarFiltro()
    ENDPROC

    PROCEDURE DContaLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.AbrirLookupConta()
        THIS.AplicarFiltro()
    ENDPROC

    *==========================================================================
    * FiltroGrupoParaConta - expressao "grupos = '<Grupo>'" usada como
    * par_cFiltroExtra de ResolverCodigoDescricao() para a Conta do Filtro -
    * equivalente ao "grupo" lido no inicio de Get_Conta.Valid/get_Dconta.Valid
    * do legado (ThisForm.Container1.Get_Grupo.Value), que fAcessoContas
    * usava para restringir a busca ao grupo do filtro.
    *==========================================================================
    PROTECTED PROCEDURE FiltroGrupoParaConta()
        LOCAL loc_cGrupo
        loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
        RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
    ENDPROC

    *==========================================================================
    * GrupoCLostFocus / DGrupoCLostFocus / ContaCLostFocus / DContaCLostFocus
    * - o que o Valid do legado faz ao sair de cada campo da Contra-Partida:
    *
    *   Get_GrupoC.Valid  -> fAcessoContab('C',...) / sem MontaTela()
    *   Get_DgrupoC.Valid -> fAcessoContab('D',...) / sem MontaTela()
    *   Get_contaC.Valid  -> fAcessoContas('C', Get_GrupoC.Value, ...) / sem MontaTela()
    *   Get_DcontaC.Valid -> fAcessoContas('D', Get_GrupoC.Value, ...) / sem MontaTela()
    *
    * Nenhum dos quatro recarrega a grade - a Contra-Partida nao faz parte do
    * filtro de saldos, so e usada no Processar (fase 7/8).
    *
    * O lookup fica no funil THIS.AbrirLookupGrupoC()/AbrirLookupContaC(),
    * que ja carrega a guarda de reentrancia do picker modal.
    *
    * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
    *==========================================================================
    PROCEDURE GrupoCLostFocus()
        THIS.AbrirLookupGrupoC()
    ENDPROC

    PROCEDURE DGrupoCLostFocus()
        THIS.AbrirLookupGrupoC()
    ENDPROC

    PROCEDURE ContaCLostFocus()
        THIS.AbrirLookupContaC()
    ENDPROC

    PROCEDURE DContaCLostFocus()
        THIS.AbrirLookupContaC()
    ENDPROC

    *==========================================================================
    * FiltroGrupoCParaConta - mesma ideia de FiltroGrupoParaConta(), mas para
    * a Conta da Contra-Partida: o legado usa Get_GrupoC.Value (nao
    * Get_Grupo.Value) como grupo de referencia em Get_contaC.Valid/
    * Get_DcontaC.Valid.
    *==========================================================================
    PROTECTED PROCEDURE FiltroGrupoCParaConta()
        LOCAL loc_cGrupo
        loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
        RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
    ENDPROC

    *==========================================================================
    * AplicarFiltro - funil UNICO do MontaTela() legado no que diz respeito ao
    * filtro: le os dois codigos digitados, guarda-os no BO (de onde o
    * CarregarSaldos monta o WHERE a.grupos / a.contas) e recarrega a grade.
    *
    * So recarrega quando o par Grupo/Conta MUDOU em relacao ao que o BO ja
    * tem: mesma consulta devolveria o mesmo resultado, e o LostFocus dispara
    * a cada saida de campo, inclusive em Tab de passagem. A semantica do
    * legado e preservada - o que muda e so a consulta repetida.
    *
    * O ALLTRIM aqui e no par descricao e seguro porque o WHERE compara
    * coluna char com literal (blank-padding ANSI do SQL Server); nao e chave
    * posicional concatenada (regra CLAUDE.md #42).
    *
    * PUBLIC (sem PROTECTED) porque e chamado dos handlers de BINDEVENT e pelo
    * harness de teste, de FORA da classe - regra CLAUDE.md #3.
    *==========================================================================
    PROCEDURE AplicarFiltro()
        LOCAL loc_cGrupo, loc_cConta, loc_oErro

        TRY
            loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
            loc_cConta = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)

            IF loc_cGrupo == ALLTRIM(THIS.this_oBusinessObject.this_cGrupoFiltro) AND ;
               loc_cConta == ALLTRIM(THIS.this_oBusinessObject.this_cContaFiltro)
                *-- Filtro inalterado: a grade ja reflete esta consulta
            ELSE
                THIS.this_oBusinessObject.this_cGrupoFiltro = loc_cGrupo
                THIS.this_oBusinessObject.this_cContaFiltro = loc_cConta

                THIS.this_oBusinessObject.this_cDescGrupoFiltro = ;
                    ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupo.Value)
                THIS.this_oBusinessObject.this_cDescContaFiltro = ;
                    ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DConta.Value)

                THIS.CarregarDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.AplicarFiltro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparFiltro - "Procedure iniciar" legado completo, que zera os OITO
    * campos do Filtro e da Contra-Partida:
    *
    *   With ThisForm.Container1
    *       .Get_GrupoC.Value = ' ' / .Get_grupo.Value = ' '
    *       .Get_DgrupoC.Value = ' ' / .Get_DGrupo.Value = ' '
    *       .Get_DcontaC.Value = ' ' / .get_dconta.Value = ' '
    *       .Get_contaC.Value = ' ' / .Get_conta.Value = ' '
    *   EndWith
    *   ThisForm.MontaTela()
    *
    * O legado usa um ESPACO, nao string vazia; aqui fica "" porque todos os
    * campos passam por ALLTRIM em todo consumidor (AplicarFiltro, os When e o
    * CarregarSaldos do BO), e o espaco solo so existia para o Empty() legado
    * dar verdadeiro - resultado identico. Get_Dope NAO entra aqui: o legado
    * "iniciar" nao o zera (e so exibicao do parametro do sistema).
    *
    * Zera tambem os pares guardados no BO, senao a guarda de "filtro
    * inalterado" do AplicarFiltro impediria a recarga.
    *
    * PUBLIC (sem PROTECTED): e o encerramento do Processar e o harness de
    * teste o chama de FORA da classe - regra CLAUDE.md #3.
    *==========================================================================
    PROCEDURE LimparFiltro()
        LOCAL loc_oErro

        TRY
            WITH THIS.cnt_4c_Filtro
                .txt_4c_Grupo.Value   = ""
                .txt_4c_DGrupo.Value  = ""
                .txt_4c_Conta.Value   = ""
                .txt_4c_DConta.Value  = ""
                .txt_4c_GrupoC.Value  = ""
                .txt_4c_DGrupoC.Value = ""
                .txt_4c_ContaC.Value  = ""
                .txt_4c_DContaC.Value = ""
            ENDWITH

            THIS.this_oBusinessObject.this_cGrupoFiltro     = ""
            THIS.this_oBusinessObject.this_cDescGrupoFiltro = ""
            THIS.this_oBusinessObject.this_cContaFiltro     = ""
            THIS.this_oBusinessObject.this_cDescContaFiltro = ""
            THIS.this_oBusinessObject.this_cGrupoContra     = ""
            THIS.this_oBusinessObject.this_cDescGrupoContra = ""
            THIS.this_oBusinessObject.this_cContaContra     = ""
            THIS.this_oBusinessObject.this_cDescContaContra = ""

            THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.LimparFiltro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAreaSaldo - Moldura, rotulo e grade da area de saldos
    * (shp_saldo + lbl_saldo + grd_saldo do legado). Cria tambem, via
    * CriarCursorSaldosPlaceholder, o cursor vazio com a MESMA estrutura que a
    * carga via SQL vai usar mais adiante (SigMvSlc + SigCdCli no MontaTela
    * legado), para o Grid ja nascer ligado - regra "cursor placeholder =
    * cursor real" do CLAUDE.md.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaSaldo()
        THIS.AddObject("shp_4c_Saldo", "Shape")
        WITH THIS.shp_4c_Saldo
            .Top         = 262
            .Left        = 81
            .Width       = 613
            .Height      = 254
            .BackStyle   = 0
            .Curvature   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Saldo", "Label")
        WITH THIS.lbl_4c_Saldo
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = " Contas / Saldos "
            .Top       = 248
            .Left      = 90
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.CriarCursorSaldosPlaceholder()
        THIS.ConfigurarGridSaldo()
    ENDPROC

    *==========================================================================
    * CriarCursorSaldosPlaceholder - Cursor vazio com a mesma estrutura que a
    * carga por SQL vai popular depois (equivalente ao
    * Select a.emps, a.grupos, a.contas, a.moedas, a.saldos, b.Rclis,
    * b.Situas, 0 as Flag, 0 as Marcas do MontaTela() legado, sobre
    * SigMvSlc/SigCdCli). Indices iguais aos do legado (Index On Rclis /
    * Index On Contas), que o Ingrid1 das colunas 1/2 usava para busca
    * incremental.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorSaldosPlaceholder()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        SET NULL ON
        CREATE CURSOR (loc_cCursor) ;
            (emps C(3), grupos C(10), contas C(10), moedas C(3), ;
             saldos N(13,2), rclis C(50), situas C(3), flag N(1,0), marcas N(1,0))
        SET NULL OFF

        SELECT (loc_cCursor)
        INDEX ON contas TAG Contas
        INDEX ON rclis TAG Rclis
    ENDPROC

    *==========================================================================
    * ConfigurarGridSaldo - grd_saldo do legado: Conta/Descricao/Moeda/Saldo
    * mais a coluna de marcacao (Column5.Check1 do dump, ligada direto a
    * Marcas - sem handler extra, o proprio binding da Column grava no
    * cursor ao clicar, igual ao legado). DynamicBackColor verde claro
    * destaca a linha ja processada (Flag = 1), igual ao SetAll do
    * MontaTela().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridSaldo()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos

        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top           = 268
            .Left          = 87
            .Width         = 601
            .Height        = 244
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
            .ColumnCount   = 5
            .RecordSource  = loc_cCursor

            .Column1.ControlSource     = loc_cCursor + ".contas"
            .Column1.Width             = 80
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .T.
            .Column1.Header1.Caption   = "Conta "
            .Column1.Header1.Alignment = 2

            .Column2.ControlSource     = loc_cCursor + ".rclis"
            .Column2.Width             = 320
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.Alignment = 2

            .Column3.ControlSource     = loc_cCursor + ".moedas"
            .Column3.Alignment         = 3
            .Column3.Width             = 40
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .T.
            .Column3.Header1.Caption   = "Moeda"
            .Column3.Header1.Alignment = 2

            .Column4.ControlSource      = loc_cCursor + ".saldos"
            .Column4.Width              = 94
            .Column4.Movable            = .F.
            .Column4.Resizable          = .F.
            .Column4.ReadOnly           = .T.
            .Column4.Text1.InputMask    = "999,999,999.99"
            .Column4.Header1.Caption    = "Saldo"
            .Column4.Header1.Alignment  = 2

            .Column5.AddObject("Check1", "CheckBox")
            .Column5.Check1.Caption    = ""
            .Column5.Check1.Value      = 0
            .Column5.CurrentControl    = "Check1"
            .Column5.Sparse            = .F.
            .Column5.ReadOnly          = .F.
            .Column5.Width             = 21
            .Column5.ControlSource     = loc_cCursor + ".marcas"
            .Column5.Header1.Caption   = ""

            .SetAll("DynamicBackColor", ;
                "IIF(" + loc_cCursor + ".Flag = 1, RGB(220,255,220), RGB(255,255,255))", ;
                "Column")

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - SelTudo/Apaga (manipulam o cursor_4c_Saldos),
    * cmd_4c_CmdProcessa (cmdProcessa.Click do legado) e cmd_4c_Encerrar
    * (cmdGprocessa.cmdSair do legado). O CommandGroup de 1 botao do dump
    * (BackStyle=0, BorderStyle=0 - sem efeito visual nenhum) foi achatado
    * para um CommandButton avulso, seguindo o padrao ja usado em outros
    * forms OPERACIONAIS do projeto (ex.: FormDCC.cmd_4c_Encerrar).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 519
            .Left        = 90
            .Width       = 40
            .Height      = 40
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .ToolTipText = "Seleciona tudo"
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top         = 519
            .Left        = 132
            .Width       = 40
            .Height      = 40
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Desmarca tudo"
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_CmdProcessa", "CommandButton")
        WITH THIS.cmd_4c_CmdProcessa
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_SelTudo,     "Click", THIS, "BtnSelTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga,       "Click", THIS, "BtnApagaClick")
        BINDEVENT(THIS.cmd_4c_CmdProcessa, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * CarregarDados - MontaTela() do legado: recarrega a grade de saldos a
    * partir do filtro corrente (Grupo / Conta, guardados no BO) e habilita o
    * Processar so quando ha linha para processar.
    *
    * Funil UNICO de recarga da grade. O legado chama MontaTela() em todo
    * ponto que muda o filtro (Get_Grupo.Valid, Get_Conta.Valid,
    * Get_DGrupo.Valid, get_Dconta.Valid e o limpa-campos); as fases
    * seguintes, que criam esses campos, chamam ESTE metodo - nunca repetem a
    * consulta.
    *
    * O cursor da grade NAO e fechado nem reaberto: o BO recarrega por
    * ZAP + APPEND FROM DBF(), entao RecordSource, ControlSource, Width,
    * Header, DynamicBackColor e o Check1 da Column5 sobrevivem - por isso
    * aqui nao se repete o rebind que o legado faz no fim do MontaTela()
    * (ele rebinda porque FECHA e RECRIA o cursor; refazer o bind aqui
    * destruiria o Check1 posto por AddObject - regra #18/#41).
    *
    * O GO TOP + Refresh e obrigatorio: popular o cursor NAO repinta a grade
    * (regra #21a) - sem ele a grade fica visualmente vazia com o cursor
    * cheio, e o sintoma ("a tela nao traz dados") manda o diagnostico para
    * SQL/permissao.
    *
    * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama os
    * metodos de carga direto no objeto do form, de FORA da classe (regra #3).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_cCursor, loc_nLinhas, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos

            IF !USED(loc_cCursor)
                THIS.CriarCursorSaldosPlaceholder()
            ENDIF

            loc_lSucesso = THIS.this_oBusinessObject.CarregarSaldos()

            loc_nLinhas = 0
            IF USED(loc_cCursor)
                loc_nLinhas = RECCOUNT(loc_cCursor)
                SELECT (loc_cCursor)
                GO TOP
            ENDIF

            *-- MontaTela(): If Reccount('CrSigMvSlc') > 0 /
            *-- CmdProcessa.Enabled = .t. / Else / .Enabled = .f. / EndIf
            THIS.cmd_4c_CmdProcessa.Enabled = (loc_nLinhas > 0)

            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnSelTudoClick - Marca todas as linhas da grade (equivalente a
    * Update CrSigMvSlc Set Marcas = 1 do legado)
    *==========================================================================
    PROCEDURE BtnSelTudoClick()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
                UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 1
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnSelTudoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnApagaClick - Desmarca todas as linhas da grade (equivalente a
    * Update CrSigMvSlc Set Marcas = 0 do legado)
    *==========================================================================
    PROCEDURE BtnApagaClick()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
                UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 0
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnApagaClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - cmdProcessa.Click do legado: os 4 guards do topo
    * (With ThisForm.Container1 / If Empty(...) / MessageBox / Return 0),
    * depois a checagem "Nenhuma Conta Selecionada" (Select CrSigMvSlc /
    * Count To x For Marcas = 1) e, so entao, o SCAN que gera os dois
    * lancamentos de encerramento por conta marcada - delegado a
    * THIS.this_oBusinessObject.ProcessarEncerramento(), que concentra o que
    * no legado era FazContra/fGerUniqueKey/fBuscarCotacao/fRecalculaS e o
    * Update/Commit/RollBack de ThisForm.poDataMgr.
    *
    * Os 4 guards ficam no FORM (lem textbox, nao property de BO) - mesmas
    * mensagens do legado, na mesma ordem. Guardados numa unica variavel
    * (loc_cErro) em vez de 4 IFs encaixados, para nao passar de 3 niveis de
    * aninhamento (regra de legibilidade; a ordem de avaliacao e idêntica aos
    * 4 "If Empty(...) / Return 0" sequenciais do legado).
    *
    * Sucesso encerra igual ao legado (ThisForm.Iniciar() no fim do Click):
    * THIS.LimparFiltro() zera os 8 campos do Container1 e recarrega a grade
    * (que fica vazia, porque o sentinela de grupo vazio nao casa nada -
    * regra CLAUDE.md #35a).
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope, loc_cErro, ;
            loc_nSelecionadas, loc_oErro

        loc_cErro = ""

        TRY
            loc_cGrupo  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
            loc_cGrupoC = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
            loc_cContaC = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value)
            loc_cDope   = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Dope.Value)

            IF EMPTY(loc_cGrupo)
                loc_cErro = "Obrigat" + CHR(243) + "rio Informar o Grupo de Filtro!!!"
            ENDIF
            IF EMPTY(loc_cErro) AND EMPTY(loc_cGrupoC)
                loc_cErro = "Grupo de Contra-Partida n" + CHR(227) + "o Informado!!!"
            ENDIF
            IF EMPTY(loc_cErro) AND EMPTY(loc_cContaC)
                loc_cErro = "Conta de Contra-Partida n" + CHR(227) + "o informada!!!"
            ENDIF
            IF EMPTY(loc_cErro) AND EMPTY(loc_cDope)
                loc_cErro = "Opera" + CHR(231) + CHR(227) + "o de Mov.Estoque n" + CHR(227) + ;
                    "o cadastrada nos Par" + CHR(226) + "metros do Sistema!!!"
            ENDIF

            IF !EMPTY(loc_cErro)
                MsgAviso(loc_cErro, "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_nSelecionadas = 0

                IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
                    SELECT (THIS.this_oBusinessObject.this_cCursorSaldos)
                    COUNT TO loc_nSelecionadas FOR marcas = 1
                ENDIF

                IF loc_nSelecionadas = 0
                    MsgAviso("Nenhuma Conta Selecionada!", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.this_oBusinessObject.this_nContasSelecionadas = loc_nSelecionadas

                    IF THIS.this_oBusinessObject.ProcessarEncerramento(loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope)
                        MsgInfo("Encerramento processado com sucesso!", "Confirmar")
                        THIS.LimparFiltro()
                    ELSE
                        IF !THIS.this_oBusinessObject.this_lErroExibido
                            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel processar o encerramento.", "Confirmar")
                        ENDIF
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - cmdGprocessa.cmdSair.Click do legado (fecha o form)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles criados via
    * AddObject (nascem com Visible = .F.), percorrendo Pages e Controls
    * recursivamente.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oObjeto

        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) == "PAGEFRAME"
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

    *==========================================================================
    * Destroy - Libera os cursores de trabalho do BO (equivalente ao
    * ThisForm.poDataMgr.Release do legado)
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
                    USE IN (THIS.this_oBusinessObject.this_cCursorSaldos)
                ENDIF
                IF USED(THIS.this_oBusinessObject.this_cCursorLancamentos)
                    USE IN (THIS.this_oBusinessObject.this_cCursorLancamentos)
                ENDIF
                IF USED(THIS.this_oBusinessObject.this_cCursorCabecalhos)
                    USE IN (THIS.this_oBusinessObject.this_cCursorCabecalhos)
                ENDIF
                IF USED(THIS.this_oBusinessObject.this_cCursorParametros)
                    USE IN (THIS.this_oBusinessObject.this_cCursorParametros)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormSigOpEnc.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpEncBO.prg):
*==============================================================================
* SigOpEncBO.prg - Business Object para Encerramento de Contas
*
* Legado           : SIGOPENC.SCX (form OPERACIONAL, task730)
* Tabela principal : SigMvCcr (PK: cidchaves char(20)) - lancamentos de conta
*                    corrente gerados pelo encerramento
* Tabela auxiliar  : SigMvCab (PK: cidchaves char(20)) - cabecalho do movimento,
*                    criado apenas quando ainda nao existe para Emps+Dopes
* Tabelas de leitura: SigMvSlc (saldos por grupo/conta/moeda) + SigCdCli (razao
*                    social e situacao da conta)
* Parametros       : SigCdPac (sigkeys e dopzers)
* Lookup grupo     : SigCdGcr (codigos char(10) / descrs char(40)) via
*                    fAcessoContab
* Lookup conta     : SigCdCli (iclis char(10) / rclis char(50)) via
*                    fAcessoContas
*
* OBSERVACAO SOBRE A TABELA PRINCIPAL
* -----------------------------------
* O analise.json desta task aponta SigMvCab como tabela principal, porque o
* Init do legado faz dois AddCursor e SigMvCab e o segundo deles. O alvo real
* do processamento, porem, e SigMvCcr: o Click do cmdProcessa gera UM
* lancamento de encerramento mais a sua contra-partida para cada conta marcada
* na grade, e so toca em SigMvCab quando o cabecalho Emps+Dopes ainda nao
* existe. Por isso this_cTabela = "SigMvCcr", espelhando o sigopaccBO (mesma
* familia de telas de conta corrente).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpEncBO AS BusinessBase

    *==========================================================================
    * FILTRO DA TELA - bloco "Filtro" do Container1 do legado
    * (Get_Grupo / Get_DGrupo / Get_Conta / get_Dconta)
    *==========================================================================
    this_cGrupoFiltro     = ""   && char(10) SigCdGcr.codigos - Grupo do filtro
    this_cDescGrupoFiltro = ""   && char(40) SigCdGcr.descrs
    this_cContaFiltro     = ""   && char(10) SigCdCli.iclis - Conta do filtro
    this_cDescContaFiltro = ""   && char(50) SigCdCli.rclis

    *==========================================================================
    * CONTRA-PARTIDA - bloco "Contra-Partida" do Container1 do legado
    * (Get_GrupoC / Get_DgrupoC / Get_contaC / Get_DcontaC)
    *==========================================================================
    this_cGrupoContra     = ""   && char(10) SigCdGcr.codigos - Grupo contra-partida
    this_cDescGrupoContra = ""   && char(40) SigCdGcr.descrs
    this_cContaContra     = ""   && char(10) SigCdCli.iclis - Conta contra-partida
    this_cDescContaContra = ""   && char(50) SigCdCli.rclis

    *==========================================================================
    * PARAMETROS DO SISTEMA - SigCdPac (lidos no Init do legado)
    * Get_Dope e somente leitura (o When do legado devolve .F.) e recebe DopZers
    *==========================================================================
    this_cOperacao = ""   && char(20) SigCdPac.dopzers - Operacao de Mov.Estoque
    this_cSigKey   = ""   && char(3)  SigCdPac.sigkeys - sufixo da PK cidchaves

    *==========================================================================
    * CONTEXTO DA SESSAO - no legado vinham das PUBLIC _Empr e Usuar
    *==========================================================================
    this_cEmpresa = ""   && char(3)  Empresa corrente (go_4c_Sistema.cCodEmpresa)
    this_cUsuario = ""   && char(10) Usuario logado (gc_4c_UsuarioLogado)

    *==========================================================================
    * CURSORES DE TRABALHO - equivalentes aos cursores do legado
    *   crSigMvSlc -> saldos exibidos na grade (com as colunas Flag e Marcas)
    *   crSigMvCcr -> lancamentos montados antes da gravacao
    *   crSigMvCab -> cabecalhos de movimento montados antes da gravacao
    *   crSigCdPac -> parametros do sistema
    *==========================================================================
    this_cCursorSaldos      = "cursor_4c_Saldos"
    this_cCursorLancamentos = "cursor_4c_Lancamentos"
    this_cCursorCabecalhos  = "cursor_4c_Cabecalhos"
    this_cCursorParametros  = "cursor_4c_Parametros"

    *==========================================================================
    * ESTADO DO PROCESSAMENTO
    *==========================================================================
    this_lProcessando        = .F.  && Guarda de reentrancia do Processar
    this_nContasSelecionadas = 0    && Linhas com Marcas = 1 na grade
    this_nContasProcessadas  = 0    && Linhas efetivamente encerradas
    this_nLancamentosGerados = 0    && Registros gravados em SigMvCcr
    this_nCabecalhosGerados  = 0    && Registros gravados em SigMvCab

    *==========================================================================
    * LINHA CORRENTE DE SigMvSlc - o saldo que esta sendo encerrado no SCAN
    *==========================================================================
    this_cSaldoEmps   = ""  && char(3)       SigMvSlc.emps
    this_cSaldoGrupos = ""  && char(10)      SigMvSlc.grupos
    this_cSaldoContas = ""  && char(10)      SigMvSlc.contas
    this_cSaldoMoedas = ""  && char(3)       SigMvSlc.moedas
    this_nSaldoSaldos = 0   && numeric(13,2) SigMvSlc.saldos

    *==========================================================================
    * COLUNAS DE SigMvCcr
    *
    * Todas as 86 colunas da tabela estao declaradas, nao apenas as que a tela
    * preenche: o INSERT tem de cobrir TODA coluna NOT NULL sem DEFAULT (regra
    * #22 do CLAUDE.md), e no legado isso acontecia de graca porque o AddCursor
    * trazia o registro em branco inteiro e o TableUpdate gravava tudo.
    * Os nomes espelham as colunas do schema (docs/schema.sql).
    *==========================================================================
    this_lAutos      = .F.  && bit           - autos (lancamento automatico)
    this_lConcs      = .F.  && bit           - concs
    this_cContages   = ""   && char(10)      - contages
    this_cContas     = ""   && char(10)      - contas
    this_cContems    = ""   && char(10)      - contems
    this_nCotacaos   = 0    && numeric(15,7) - cotacaos
    this_dDatalts    = {}   && datetime NULL - datalts
    this_dDatas      = {}   && datetime NULL - datas
    this_dDataconcs  = {}   && datetime NULL - dataconcs
    this_dDatatrans  = {}   && datetime NULL - datatrans
    this_dDatexcs    = {}   && datetime NULL - datexcs
    this_cDocus      = ""   && char(10)      - docus
    this_cDopes      = ""   && char(20)      - dopes
    this_dDtemis     = {}   && datetime NULL - dtemis
    this_cEmps       = ""   && char(3)       - emps
    this_cGrupages   = ""   && char(10)      - grupages
    this_cGrupems    = ""   && char(10)      - grupems
    this_cGrupos     = ""   && char(10)      - grupos
    this_cHists      = ""   && char(60) NULL - hists
    this_cLocals     = ""   && char(10)      - locals
    this_cMoedas     = ""   && char(3)       - moedas
    this_cNfs        = ""   && char(10)      - nfs
    this_nNlancs     = 0    && numeric(6,0)  - nlancs
    this_nNopers     = 0    && numeric(7,0)  - nopers
    this_nNtrans     = 0    && numeric(6,0)  - ntrans
    this_nNumes      = 0    && numeric(6,0)  - numes
    this_cOpers      = ""   && char(1)       - opers (D/C)
    this_nSaldocs    = 0    && numeric(15,2) - saldocs
    this_nSaldons    = 0    && numeric(15,2) - saldons
    this_nSaldos     = 0    && numeric(15,2) - saldos
    this_cScontas    = ""   && char(10)      - scontas
    this_nScotacaos  = 0    && numeric(15,7) - scotacaos
    this_cSgrupos    = ""   && char(10)      - sgrupos
    this_cShists     = ""   && char(40)      - shists
    this_cSmoedas    = ""   && char(3)       - smoedas
    this_cSopers     = ""   && char(1)       - sopers (D/C invertido)
    this_nSvalors    = 0    && numeric(11,2) - svalors
    this_cTipos      = ""   && char(1)       - tipos
    this_cTitbans    = ""   && char(12)      - titbans
    this_cTitulos    = ""   && char(10)      - titulos
    this_cUsualts    = ""   && char(10)      - usualts
    this_cUsuexcs    = ""   && char(10)      - usuexcs
    this_nValliqs    = 0    && numeric(11,2) - valliqs
    this_nValocurs   = 0    && numeric(11,2) - valocurs
    this_nValors     = 0    && numeric(11,2) - valors
    this_nValpags    = 0    && numeric(11,2) - valpags
    this_dVencs      = {}   && datetime NULL - vencs
    this_cVlancs     = ""   && char(10)      - vlancs
    this_cVopers     = ""   && char(13)      - vopers
    this_nContapgs   = 0    && numeric(1,0)  - contapgs
    this_cDopcs      = ""   && char(20)      - dopcs
    this_nNumcs      = 0    && numeric(6,0)  - numcs
    this_cCotusus    = ""   && char(10)      - cotusus
    this_cBcontas    = ""   && char(10)      - bcontas
    this_cBgrupos    = ""   && char(10)      - bgrupos
    this_nBorderos   = 0    && numeric(6,0)  - borderos
    this_cHist2s     = ""   && char(80) NULL - hist2s
    this_nIntconts   = 0    && numeric(6,0)  - intconts
    this_cUsuconcs   = ""   && char(10)      - usuconcs
    this_cAuditors   = ""   && char(10)      - auditors
    this_dDtaudits   = {}   && datetime NULL - dtaudits
    this_nValprev    = 0    && numeric(11,2) - valprev
    this_cCidchaves  = ""   && char(20)      - cidchaves (PK)
    this_cEmpdopncs  = ""   && char(29)      - empdopncs (emps+dopcs+numcs)
    this_cEmpdopnums = ""   && char(29)      - empdopnums (emps+dopes+numes)
    this_cGruconmoes = ""   && char(23)      - gruconmoes (grupos+contas+moedas)
    this_cPagos      = ""   && char(1)       - pagos
    this_cDopotps    = ""   && char(23)      - dopotps
    this_cUsupagos   = ""   && char(10)      - usupagos
    this_nTitcancs   = 0    && numeric(1,0)  - titcancs
    this_dDtconfs    = {}   && datetime NULL - dtconfs
    this_cUsuconfs   = ""   && char(10)      - usuconfs
    this_nNopercancs = 0    && numeric(7,0)  - nopercancs
    this_cEspecienfs = ""   && char(6)       - especienfs
    this_cJobs       = ""   && char(10)      - jobs
    this_nImpostos   = 0    && numeric(11,2) - impostos
    this_nTpimpostos = 0    && numeric(2,0)  - tpimpostos
    this_cTitpais    = ""   && char(10)      - titpais
    this_cEmpccs     = ""   && char(3)       - empccs
    this_nRecor      = 0    && numeric(1,0)  - recor
    this_cCompet     = ""   && char(7)       - compet
    this_cEmpos      = ""   && char(3)       - empos
    this_cOridopnums = ""   && char(29)      - oridopnums
    this_cPastas     = ""   && text NULL     - pastas
    this_cRcontas    = ""   && char(10)      - rcontas
    this_cTpdocnf    = ""   && char(2)       - tpdocnf

    *==========================================================================
    * COLUNAS DE SigMvCab preenchidas pelo legado quando cria o cabecalho do
    * movimento (Insert Into CrSigMvCab do Click do cmdProcessa).
    * Prefixo Cab para nao colidir com as colunas homonimas de SigMvCcr -
    * emps, dopes, numes, datas e cidchaves existem nas DUAS tabelas.
    *==========================================================================
    this_cCabEmps       = ""  && char(3)       SigMvCab.emps
    this_cCabDopes      = ""  && char(20)      SigMvCab.dopes
    this_nCabNumes      = 0   && numeric(6,0)  SigMvCab.numes (fGerUniqueKey)
    this_cCabUsuars     = ""  && char(10)      SigMvCab.usuars
    this_dCabDatars     = {}  && datetime NULL SigMvCab.datars
    this_dCabDatas      = {}  && datetime NULL SigMvCab.datas
    this_cCabMascnum    = ""  && char(10)      SigMvCab.mascnum (fGerMascara)
    this_cCabEmpdopnums = ""  && char(29)      SigMvCab.empdopnums
    this_cCabCidchaves  = ""  && char(20)      SigMvCab.cidchaves (fUniqueIds)
    this_dCabDtalts     = {}  && datetime NULL SigMvCab.dtalts

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *
    * A tabela VAI no DODEFAULT: BusinessBase.Init() so instancia
    * this_oDataAccess quando recebe o parametro pcTabela. Com DODEFAULT() sem
    * argumento o objeto de acesso a dados fica .NULL. e todo metodo herdado
    * que depende dele devolve .F. reclamando que o acesso a dados nao foi
    * inicializado.
    *
    * Empresa e usuario sao resolvidos aqui porque no legado eram as variaveis
    * PUBLIC _Empr e Usuar, lidas direto dentro do Click do cmdProcessa.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigMvCcr")

            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"

            *-- Contexto da sessao (equivalente as PUBLIC _Empr e Usuar)
            IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                THIS.this_cEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF

            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEncBO.Init")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave usada por RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigMvCcr (SELECT * FROM
    * SigMvCcr) para as propriedades do BO. SEMPRE usar SELECT (par_cAliasCursor)
    * antes de acessar os campos (regra #8 CLAUDE.md).
    *
    * Carrega UM lancamento de SigMvCcr - usado quando a Fase 7/8 precisar
    * reler um lancamento ja gravado (ex.: conferencia apos o Processar()).
    * As colunas de SigMvCab (this_cCab*) e os filtros da tela NAO entram aqui -
    * tem fonte propria (CarregarParametros/CarregarSaldos, Fase 4).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                IF VARTYPE(autos) = "L"
                    THIS.this_lAutos = autos
                ELSE
                    THIS.this_lAutos = (NVL(autos, 0) = 1)
                ENDIF
                IF VARTYPE(concs) = "L"
                    THIS.this_lConcs = concs
                ELSE
                    THIS.this_lConcs = (NVL(concs, 0) = 1)
                ENDIF
                THIS.this_cContages = TratarNulo(contages, "")
                THIS.this_cContas = TratarNulo(contas, "")
                THIS.this_cContems = TratarNulo(contems, "")
                THIS.this_nCotacaos = TratarNulo(cotacaos, 0)
                THIS.this_dDatalts = TratarNulo(datalts, {})
                THIS.this_dDatas = TratarNulo(datas, {})
                THIS.this_dDataconcs = TratarNulo(dataconcs, {})
                THIS.this_dDatatrans = TratarNulo(datatrans, {})
                THIS.this_dDatexcs = TratarNulo(datexcs, {})
                THIS.this_cDocus = TratarNulo(docus, "")
                THIS.this_cDopes = TratarNulo(dopes, "")
                THIS.this_dDtemis = TratarNulo(dtemis, {})
                THIS.this_cEmps = TratarNulo(emps, "")
                THIS.this_cGrupages = TratarNulo(grupages, "")
                THIS.this_cGrupems = TratarNulo(grupems, "")
                THIS.this_cGrupos = TratarNulo(grupos, "")
                THIS.this_cHists = TratarNulo(hists, "")
                THIS.this_cLocals = TratarNulo(locals, "")
                THIS.this_cMoedas = TratarNulo(moedas, "")
                THIS.this_cNfs = TratarNulo(nfs, "")
                THIS.this_nNlancs = TratarNulo(nlancs, 0)
                THIS.this_nNopers = TratarNulo(nopers, 0)
                THIS.this_nNtrans = TratarNulo(ntrans, 0)
                THIS.this_nNumes = TratarNulo(numes, 0)
                THIS.this_cOpers = TratarNulo(opers, "")
                THIS.this_nSaldocs = TratarNulo(saldocs, 0)
                THIS.this_nSaldons = TratarNulo(saldons, 0)
                THIS.this_nSaldos = TratarNulo(saldos, 0)
                THIS.this_cScontas = TratarNulo(scontas, "")
                THIS.this_nScotacaos = TratarNulo(scotacaos, 0)
                THIS.this_cSgrupos = TratarNulo(sgrupos, "")
                THIS.this_cShists = TratarNulo(shists, "")
                THIS.this_cSmoedas = TratarNulo(smoedas, "")
                THIS.this_cSopers = TratarNulo(sopers, "")
                THIS.this_nSvalors = TratarNulo(svalors, 0)
                THIS.this_cTipos = TratarNulo(tipos, "")
                THIS.this_cTitbans = TratarNulo(titbans, "")
                THIS.this_cTitulos = TratarNulo(titulos, "")
                THIS.this_cUsualts = TratarNulo(usualts, "")
                THIS.this_cUsuexcs = TratarNulo(usuexcs, "")
                THIS.this_nValliqs = TratarNulo(valliqs, 0)
                THIS.this_nValocurs = TratarNulo(valocurs, 0)
                THIS.this_nValors = TratarNulo(valors, 0)
                THIS.this_nValpags = TratarNulo(valpags, 0)
                THIS.this_dVencs = TratarNulo(vencs, {})
                THIS.this_cVlancs = TratarNulo(vlancs, "")
                THIS.this_cVopers = TratarNulo(vopers, "")
                THIS.this_nContapgs = TratarNulo(contapgs, 0)
                THIS.this_cDopcs = TratarNulo(dopcs, "")
                THIS.this_nNumcs = TratarNulo(numcs, 0)
                THIS.this_cCotusus = TratarNulo(cotusus, "")
                THIS.this_cBcontas = TratarNulo(bcontas, "")
                THIS.this_cBgrupos = TratarNulo(bgrupos, "")
                THIS.this_nBorderos = TratarNulo(borderos, 0)
                THIS.this_cHist2s = TratarNulo(hist2s, "")
                THIS.this_nIntconts = TratarNulo(intconts, 0)
                THIS.this_cUsuconcs = TratarNulo(usuconcs, "")
                THIS.this_cAuditors = TratarNulo(auditors, "")
                THIS.this_dDtaudits = TratarNulo(dtaudits, {})
                THIS.this_nValprev = TratarNulo(valprev, 0)
                THIS.this_cEmpdopncs = TratarNulo(empdopncs, "")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_cGruconmoes = TratarNulo(gruconmoes, "")
                THIS.this_cPagos = TratarNulo(pagos, "")
                THIS.this_cDopotps = TratarNulo(dopotps, "")
                THIS.this_cUsupagos = TratarNulo(usupagos, "")
                THIS.this_nTitcancs = TratarNulo(titcancs, 0)
                THIS.this_dDtconfs = TratarNulo(dtconfs, {})
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "")
                THIS.this_nNopercancs = TratarNulo(nopercancs, 0)
                THIS.this_cEspecienfs = TratarNulo(especienfs, "")
                THIS.this_cJobs = TratarNulo(jobs, "")
                THIS.this_nImpostos = TratarNulo(impostos, 0)
                THIS.this_nTpimpostos = TratarNulo(tpimpostos, 0)
                THIS.this_cTitpais = TratarNulo(titpais, "")
                THIS.this_cEmpccs = TratarNulo(empccs, "")
                THIS.this_nRecor = TratarNulo(recor, 0)
                THIS.this_cCompet = TratarNulo(compet, "")
                THIS.this_cEmpos = TratarNulo(empos, "")
                THIS.this_cOridopnums = TratarNulo(oridopnums, "")
                THIS.this_cPastas = TratarNulo(pastas, "")
                THIS.this_cRcontas = TratarNulo(rcontas, "")
                THIS.this_cTpdocnf = TratarNulo(tpdocnf, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SigOpEncBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarSaldos - Popula cursor_4c_Saldos com os saldos das contas do
    * grupo filtrado. Equivalente ao MontaTela() do legado (SIGOPENC).
    *
    * Consulta TRANSCRITA do legado (criterio de selecao e regra de negocio -
    * regra #17 CLAUDE.md):
    *   Select a.emps, a.grupos, a.contas, a.moedas, a.saldos, b.Rclis,
    *          b.Situas, 0 as Flag, 0 as Marcas
    *     From SigMvSlc a, SigCdCli b
    *    Where a.grupos = '<grupo>' [And a.Contas = '<conta>']
    *      And a.Contas = b.Iclis And a.Saldos <> 0
    * Order By a.Contas, a.Moedas
    *
    * O SENTINELA 'ZYWZYWZYWZ' para grupo vazio e DO LEGADO e NAO e
    * descartavel: o filtro e aplicado SEMPRE, inclusive vazio, e com o
    * sentinela a consulta nao casa nada - a grade abre VAZIA de proposito,
    * esperando o usuario escolher o grupo (regra #35a). Trocar por "sem
    * WHERE" traria a tabela INTEIRA.
    *
    * NAO filtra por empresa nem por Situas: o legado SELECIONA a.emps e
    * b.Situas mas nao os usa no WHERE - acrescentar filtro que o legado nao
    * tem e inventar regra de negocio.
    *
    * Colunas conferidas no schema canonico: SigMvSlc(emps char(3),
    * grupos char(10), contas char(10), moedas char(3), saldos numeric(13,2))
    * e SigCdCli(iclis char(10), rclis char(50), situas char(3)). SigMvSlc e
    * tabela de MOVIMENTO e usa emps SEM o prefixo C (regra #48).
    *
    * O SQLEXEC vai para cursor TEMPORARIO e o cursor da grade e recarregado
    * com ZAP + APPEND FROM DBF(): SQLEXEC direto sobre o alias da grade
    * FECHA e RECRIA o alias, zerando o ColumnCount e destruindo o Check1 que
    * a Column5 recebeu por AddObject. O APPEND casa as colunas por NOME,
    * por isso a lista do SELECT e a do CREATE CURSOR do form sao identicas.
    *==========================================================================
    PROCEDURE CarregarSaldos()
        LOCAL loc_cSQL, loc_cGrupo, loc_cConta, loc_cCursor, loc_cTmp
        LOCAL loc_nResult, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorSaldos
        loc_cTmp     = "cursor_4c_SaldosTmp"

        TRY
            *-- Sentinela do legado: grupo vazio nao casa nenhum registro
            loc_cGrupo = ALLTRIM(TratarNulo(THIS.this_cGrupoFiltro, ""))
            IF EMPTY(loc_cGrupo)
                loc_cGrupo = "ZYWZYWZYWZ"
            ENDIF
            loc_cConta = ALLTRIM(TratarNulo(THIS.this_cContaFiltro, ""))

            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "Cursor de saldos (" + loc_cCursor + ;
                    ") nao inicializado."
                MsgErro(THIS.this_cMensagemErro, "SigOpEncBO.CarregarSaldos")
                THIS.this_lErroExibido = .T.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    *-- Sem conexao (modo teste / validacao de UI): grade vazia,
                    *-- mesmo resultado visual do sentinela
                    SELECT (loc_cCursor)
                    ZAP
                    loc_lSucesso = .T.
                ELSE
                    loc_cSQL = "SELECT a.emps, a.grupos, a.contas, a.moedas," + ;
                        " a.saldos, b.rclis, b.situas," + ;
                        " 0 AS flag, 0 AS marcas" + ;
                        " FROM SigMvSlc a, SigCdCli b" + ;
                        " WHERE a.grupos = " + EscaparSQL(loc_cGrupo)

                    IF !EMPTY(loc_cConta)
                        loc_cSQL = loc_cSQL + ;
                            " AND a.contas = " + EscaparSQL(loc_cConta)
                    ENDIF

                    loc_cSQL = loc_cSQL + ;
                        " AND a.contas = b.iclis" + ;
                        " AND a.saldos <> 0" + ;
                        " ORDER BY a.contas, a.moedas"

                    IF USED(loc_cTmp)
                        IF CURSORGETPROP("Buffering", loc_cTmp) > 1
                            TABLEREVERT(.T., loc_cTmp)
                        ENDIF
                        USE IN (loc_cTmp)
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTmp)

                    IF loc_nResult >= 0
                        SELECT (loc_cCursor)
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF(loc_cTmp)
                        SET NULL OFF
                        loc_lSucesso = .T.
                    ELSE
                        *-- Mensagem do legado: MessageBox('Favor Reinicializar o
                        *-- Processo!!!', 16, 'Falha na Conexao (crSigMvSlc)')
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
                        THIS.this_lErroExibido = .T.
                    ENDIF

                    IF USED(loc_cTmp)
                        USE IN (loc_cTmp)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    SELECT (loc_cCursor)
                    GO TOP
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEncBO.CarregarSaldos")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere um lancamento de encerramento em SigMvCcr
    *
    * Equivalente ao bloco "Select CrSigMvCcr / Append Blank / Replace ..." do
    * cmdProcessa.Click do legado, para UMA conta. A PK (cidchaves) e gerada
    * via fUniqueIds() se ainda nao preenchida (regra #22 CLAUDE.md); o legado
    * monta a chave so depois do SCAN inteiro (Dtos(Datas)+fGerUniqueKey+SigKey),
    * mas fUniqueIds() e o gerador de PK canonico do projeto e evita colisao no
    * indice unico sem depender de SigKey/fGerUniqueKey, que nao foram portados.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = THIS.MontarSQLInsertCcr()

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento de encerramento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                THIS.this_nLancamentosGerados = THIS.this_nLancamentosGerados + 1
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SigOpEncBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarSQLInsertCcr - Monta (sem executar) a instrucao INSERT INTO
    * SigMvCcr com os valores correntes das propriedades this_*. Extraido de
    * Inserir() para ser reutilizado por ProcessarEncerramento(), que precisa
    * encadear VARIOS INSERT (um lancamento + a contra-partida, para cada
    * conta marcada) num UNICO lote atomico (SAVE TRANSACTION) - regra
    * CLAUDE.md sobre BEGIN/COMMIT via SQLEXEC nao proteger operacao
    * multi-statement; aqui a atomicidade vem de mandar tudo em UM SQLEXEC.
    *==========================================================================
    PROTECTED FUNCTION MontarSQLInsertCcr()
        LOCAL loc_cSQL

        IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
            THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
        ENDIF

        IF EMPTY(ALLTRIM(NVL(THIS.this_cEmps, "")))
            THIS.this_cEmps = THIS.this_cEmpresa
        ENDIF

        THIS.this_cUsualts = THIS.this_cUsuario
        THIS.this_dDatalts = DATETIME()

        *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
        THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

        *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
        THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
        THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

        *-- Campo computado: Pagos - '0' se valor pago igual ao valor do lancamento
        THIS.this_cPagos = IIF(THIS.this_nValors = THIS.this_nValpags, "0", "1")

        *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCcr ("
            loc_cSQL = loc_cSQL + "cidchaves, autos, concs, contages, contas, contems, cotacaos, datalts,"
            loc_cSQL = loc_cSQL + "datas, dataconcs, datatrans, datexcs, docus, dopes, dtemis, emps,"
            loc_cSQL = loc_cSQL + "grupages, grupems, grupos, hists, locals, moedas, nfs, nlancs,"
            loc_cSQL = loc_cSQL + "nopers, ntrans, numes, opers, saldocs, saldons, saldos, scontas,"
            loc_cSQL = loc_cSQL + "scotacaos, sgrupos, shists, smoedas, sopers, svalors, tipos, titbans,"
            loc_cSQL = loc_cSQL + "titulos, usualts, usuexcs, valliqs, valocurs, valors, valpags, vencs,"
            loc_cSQL = loc_cSQL + "vlancs, vopers, contapgs, dopcs, numcs, cotusus, bcontas, bgrupos,"
            loc_cSQL = loc_cSQL + "borderos, hist2s, intconts, usuconcs, auditors, dtaudits, valprev, empdopncs,"
            loc_cSQL = loc_cSQL + "empdopnums, gruconmoes, pagos, dopotps, usupagos, titcancs, dtconfs, usuconfs,"
            loc_cSQL = loc_cSQL + "nopercancs, especienfs, jobs, impostos, tpimpostos, titpais, empccs, recor,"
            loc_cSQL = loc_cSQL + "compet, empos, oridopnums, pastas, rcontas, tpdocnf"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lAutos, "1", "0") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lConcs, "1", "0") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2)) + ")"

        RETURN loc_cSQL
    ENDFUNC

    *==========================================================================
    * CarregarParametros - Le o parametro SigCdPac (sigkeys e dopzers), igual
    * ao bloco do Init do legado:
    *   ThisForm.poDataMgr.CursorQuery('SigCdPac', 'crSigCdPac')
    *   ThisForm.SigKey = CrSigCdPac.SigKeys
    *   ThisForm.Container1.Get_Dope.Value = CrSigCdPac.DopZers
    *
    * this_cSigKey fica guardado para a fase de Processar (fase 7/8), que monta
    * a PK cidchaves (Dtos(Datas) + fGerUniqueKey + SigKey do legado).
    * this_cOperacao e o valor que o Form copia para txt_4c_Dope.Value.
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_cCursor, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorParametros

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Sem conexao (modo teste / validacao de UI): segue sem parametros
                loc_lSucesso = .T.
            ELSE
                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT sigkeys, dopzers FROM SigCdPac", loc_cCursor)

                IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                    SELECT (loc_cCursor)
                    GO TOP
                    THIS.this_cSigKey   = ALLTRIM(TratarNulo(sigkeys, ""))
                    THIS.this_cOperacao = ALLTRIM(TratarNulo(dopzers, ""))
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + ;
                        "o de Par" + CHR(226) + "metros do Sistema (SigCdPac) n" + CHR(227) + "o encontrada."
                    MsgErro(THIS.this_cMensagemErro, "SigOpEncBO.CarregarParametros")
                    THIS.this_lErroExibido = .T.
                ENDIF

                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEncBO.CarregarParametros")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza um lancamento existente de SigMvCcr (por cidchaves)
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsualts = THIS.this_cUsuario
            THIS.this_dDatalts = DATETIME()

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Campo computado: Pagos - '0' se valor pago igual ao valor do lancamento
            THIS.this_cPagos = IIF(THIS.this_nValors = THIS.this_nValpags, "0", "1")

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCcr SET"
            loc_cSQL = loc_cSQL + " autos = " + IIF(THIS.this_lAutos, "1", "0") + ","
            loc_cSQL = loc_cSQL + " concs = " + IIF(THIS.this_lConcs, "1", "0") + ","
            loc_cSQL = loc_cSQL + " contages = " + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + " contems = " + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + " cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " datalts = " + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dataconcs = " + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + " datexcs = " + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + " docus = " + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grupages = " + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + " grupems = " + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " hists = " + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " nfs = " + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nlancs = " + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + " nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + " saldocs = " + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + " saldons = " + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + " saldos = " + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + " scontas = " + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + " scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " sgrupos = " + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " shists = " + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + " smoedas = " + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " sopers = " + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + " svalors = " + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + " tipos = " + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + " titbans = " + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + " titulos = " + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + " usualts = " + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + " usuexcs = " + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + " valliqs = " + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + " valocurs = " + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + " valpags = " + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + " vencs = " + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + " vlancs = " + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + " vopers = " + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + " contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + " dopcs = " + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + " numcs = " + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + " cotusus = " + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + " bcontas = " + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " bgrupos = " + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " borderos = " + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + " hist2s = " + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + " intconts = " + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + " usuconcs = " + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + " dtaudits = " + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + " valprev = " + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + " empdopncs = " + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " gruconmoes = " + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + " pagos = " + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + " dopotps = " + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + " usupagos = " + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + " titcancs = " + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + " dtconfs = " + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + " usuconfs = " + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nopercancs = " + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + " jobs = " + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + " impostos = " + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + " tpimpostos = " + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + " titpais = " + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + " empccs = " + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + " recor = " + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + " compet = " + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + " empos = " + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + " oridopnums = " + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " pastas = " + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + " rcontas = " + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " tpdocnf = " + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento de encerramento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SigOpEncBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ProcessarEncerramento - cmdProcessa.Click do legado: para CADA conta
    * marcada (Marcas = 1) na grade de saldos, gera DOIS lancamentos em
    * SigMvCcr que se espelham (debito/credito trocados, grupo/conta trocados
    * entre a conta original e a contra-partida) - a dupla entrada que
    * encerra o saldo da conta original contra o grupo/conta informados em
    * par_cGrupoC/par_cContaC. O cabecalho do movimento (SigMvCab) e criado
    * UMA vez por execucao (o legado tambem cria so um, porque ZAPa a propria
    * cursor local a cada clique e faz o Seek contra ela, nao contra o banco).
    *
    * par_cGrupo/par_cGrupoC/par_cContaC/par_cDope chegam do Form, ja
    * validados la (os 4 guards do Click legado: "Obrigatorio Informar o
    * Grupo de Filtro", "Grupo de Contra-Partida nao Informado", "Conta de
    * Contra-Partida nao informada", "Operacao de Mov.Estoque nao cadastrada
    * nos Parametros do Sistema").
    *
    * ATOMICIDADE: BEGIN/COMMIT TRANSACTION mandados via SQLEXEC NAO protegem
    * operacao multi-statement nesta conexao (Transactions=2 MANUAL faz o
    * par so aninhar - regra CLAUDE.md). O cabecalho + os N*2 lancamentos vao
    * num UNICO SQLEXEC, com o SAVE TRANSACTION/TRY/CATCH/THROW do T-SQL
    * (mesmo padrao de SigOpBcbBO.prg:Inserir()) - assim, se qualquer INSERT
    * falhar, nenhum dos outros fica gravado.
    *
    * this_lEmLookup nao se aplica aqui (nao ha picker); a guarda de
    * reentrancia do Processar fica no proprio Form (botao so clicavel uma
    * vez por vez, Click nao e reentrante).
    *==========================================================================
    PROCEDURE ProcessarEncerramento(par_cGrupo, par_cGrupoC, par_cContaC, par_cDope)
        LOCAL loc_cCursor, loc_cBatch, loc_cFrag, loc_nResult, loc_lSucesso, loc_lManual
        LOCAL loc_cEmpresa, loc_xOper, loc_xsOper, loc_nValor, loc_nOper, loc_cVOper, loc_nCota
        LOCAL loc_cHist, loc_cHist2, loc_dAgora, loc_oErro

        loc_lSucesso = .F.
        loc_lManual  = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
        loc_cCursor  = THIS.this_cCursorSaldos
        loc_cEmpresa = THIS.this_cEmpresa
        loc_dAgora   = DATETIME()

        TRY
            IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " saldos carregados para processar."
                MsgErro(THIS.this_cMensagemErro, "SigOpEncBO.ProcessarEncerramento")
                THIS.this_lErroExibido = .T.
            ELSE
                *-- Cabecalho do movimento - gerado UMA vez por execucao
                *-- (Insert Into CrSigMvCab do legado, antes do Seek achar um
                *-- ja existente NA MESMA execucao)
                THIS.this_cCabEmps       = loc_cEmpresa
                THIS.this_cCabDopes      = par_cDope
                THIS.this_nCabNumes      = fGerUniqueKey(ALLTRIM(par_cDope) + loc_cEmpresa)

                IF THIS.this_nCabNumes = 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o n" + ;
                        CHR(250) + "mero do movimento (SigMvCab)."
                    MsgErro(THIS.this_cMensagemErro, "SigOpEncBO.ProcessarEncerramento")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.this_cCabMascnum    = fGerMascara(THIS.this_nCabNumes)
                    THIS.this_cCabEmpdopnums = PADR(loc_cEmpresa, 3) + PADR(par_cDope, 20) + STR(THIS.this_nCabNumes, 6)
                    THIS.this_cCabCidchaves  = LEFT(fUniqueIds(), 20)
                    THIS.this_cCabUsuars     = THIS.this_cUsuario
                    THIS.this_dCabDatars     = loc_dAgora
                    THIS.this_dCabDatas      = loc_dAgora
                    THIS.this_dCabDtalts     = loc_dAgora

                    *-- cursor_4c_PendAud guarda so os cidchaves de SigMvCcr -
                    *-- RegistrarAuditoria() usa THIS.this_cTabela ("SigMvCcr",
                    *-- fixado no Init), entao o cabecalho (SigMvCab) nao entra
                    *-- aqui para nao ser auditado com a tabela errada.
                    IF USED("cursor_4c_PendAud")
                        USE IN cursor_4c_PendAud
                    ENDIF
                    CREATE CURSOR cursor_4c_PendAud (cidchaves C(20))

                    loc_cBatch = "SET NOCOUNT ON; " + ;
                        "DECLARE @nivel4c int = @@TRANCOUNT; " + ;
                        "IF @nivel4c = 0 BEGIN TRANSACTION " + ;
                        "ELSE SAVE TRANSACTION Enc4c; " + ;
                        "BEGIN TRY " + ;
                        THIS.MontarSQLInsertCab() + "; "

                    THIS.this_nContasProcessadas = 0

                    SELECT (loc_cCursor)
                    SCAN FOR marcas = 1
                        SCATTER MEMVAR

                        REPLACE flag WITH 1

                        loc_xOper  = IIF(m.saldos > 0, "C", "D")
                        loc_xsOper = IIF(loc_xOper = "C", "D", "C")
                        loc_nValor = ABS(m.saldos)
                        loc_nOper  = fGerUniqueKey("SigMvCcr")
                        loc_cVOper = loc_cEmpresa + ALLTRIM(STR(loc_nOper, 9))
                        loc_nCota  = fBuscarCotacao(m.moedas, DATE(), gnConnHandle)
                        loc_cHist  = "Encerramento de conta - Grupo:" + ALLTRIM(par_cGrupo)
                        loc_cHist2 = "com Contra-Partida:" + ALLTRIM(par_cGrupoC) + "-" + ALLTRIM(par_cContaC)

                        *-- Entrada DIRETA: encerra a conta do saldo marcado
                        *-- (Select CrSigMvCcr / Append Blank / Replace ... do
                        *-- cmdProcessa.Click)
                        THIS.this_cCidchaves = ""
                        THIS.this_cEmps      = loc_cEmpresa
                        THIS.this_lAutos     = .T.
                        THIS.this_nNopers    = loc_nOper
                        THIS.this_cVopers    = loc_cVOper
                        THIS.this_cOpers     = loc_xOper
                        THIS.this_cSopers    = loc_xsOper
                        THIS.this_cGrupos    = m.grupos
                        THIS.this_cContas    = m.contas
                        THIS.this_cSgrupos   = par_cGrupoC
                        THIS.this_cScontas   = par_cContaC
                        THIS.this_cMoedas    = m.moedas
                        THIS.this_cSmoedas   = m.moedas
                        THIS.this_nCotacaos  = loc_nCota
                        THIS.this_nScotacaos = loc_nCota
                        THIS.this_cDopes     = par_cDope
                        THIS.this_nNumes     = THIS.this_nCabNumes
                        THIS.this_cHists     = loc_cHist
                        THIS.this_cHist2s    = loc_cHist2
                        THIS.this_nValors    = loc_nValor
                        THIS.this_nSvalors   = loc_nValor
                        THIS.this_dDatas     = loc_dAgora
                        THIS.this_dVencs     = loc_dAgora
                        THIS.this_nNlancs    = 0
                        THIS.this_cVlancs    = ""
                        THIS.this_nValpags   = 0

                        loc_cFrag = THIS.MontarSQLInsertCcr()
                        loc_cBatch = loc_cBatch + loc_cFrag + "; "
                        INSERT INTO cursor_4c_PendAud (cidchaves) VALUES (THIS.this_cCidchaves)

                        fRecalculaS(THIS.this_cGrupos, THIS.this_cContas, THIS.this_dDatas, THIS.this_cMoedas, gnConnHandle)

                        *-- Entrada CONTRA-PARTIDA (FazContra do legado): MESMO
                        *-- NOpers/VOpers/Moedas/Cotacaos/Valors/Datas/Dopes/
                        *-- Numes/Hists/Hist2s da entrada direta, so com
                        *-- Grupos/Contas/Opers invertidos com SGrupos/SContas/
                        *-- SOpers - e Autos fica .F. (FazContra nao seta Autos)
                        THIS.this_cCidchaves = ""
                        THIS.this_lAutos     = .F.
                        THIS.this_cGrupos    = par_cGrupoC
                        THIS.this_cContas    = par_cContaC
                        THIS.this_cOpers     = loc_xsOper
                        THIS.this_cSgrupos   = m.grupos
                        THIS.this_cScontas   = m.contas
                        THIS.this_cSopers    = loc_xOper

                        loc_cFrag = THIS.MontarSQLInsertCcr()
                        loc_cBatch = loc_cBatch + loc_cFrag + "; "
                        INSERT INTO cursor_4c_PendAud (cidchaves) VALUES (THIS.this_cCidchaves)

                        fRecalculaS(THIS.this_cGrupos, THIS.this_cContas, THIS.this_dDatas, THIS.this_cMoedas, gnConnHandle)

                        THIS.this_nContasProcessadas = THIS.this_nContasProcessadas + 1
                    ENDSCAN

                    IF THIS.this_nContasProcessadas = 0
                        THIS.this_cMensagemErro = "Nenhuma Conta Selecionada!"
                        MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_cBatch = loc_cBatch + ;
                            "IF @nivel4c = 0 COMMIT TRANSACTION; " + ;
                            "END TRY " + ;
                            "BEGIN CATCH " + ;
                            "IF @nivel4c = 0 " + ;
                            "BEGIN " + ;
                            "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; " + ;
                            "END " + ;
                            "ELSE " + ;
                            "BEGIN " + ;
                            "IF XACT_STATE() = 1 ROLLBACK TRANSACTION Enc4c; " + ;
                            "END; " + ;
                            "THROW; " + ;
                            "END CATCH"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cBatch)

                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                            MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                                "Falha no Processamento do Encerramento")
                            THIS.this_lErroExibido = .T.
                        ELSE
                            IF !fRecalculaS(.T., gnConnHandle)
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                                MsgErro(THIS.this_cMensagemErro, "Falha no Rec" + CHR(225) + "lculo de Saldos (SigOpClS)")
                                THIS.this_lErroExibido = .T.
                            ELSE
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF

                        IF loc_lManual
                            IF loc_lSucesso
                                = SQLCOMMIT(gnConnHandle)
                            ELSE
                                = SQLROLLBACK(gnConnHandle)
                            ENDIF
                        ENDIF

                        IF loc_lSucesso
                            SELECT cursor_4c_PendAud
                            SCAN
                                THIS.this_cCidchaves = cidchaves
                                THIS.RegistrarAuditoria("INSERT")
                            ENDSCAN

                            THIS.this_nLancamentosGerados = THIS.this_nLancamentosGerados + (THIS.this_nContasProcessadas * 2)
                            THIS.this_nCabecalhosGerados  = THIS.this_nCabecalhosGerados + 1
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_PendAud")
                        USE IN cursor_4c_PendAud
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEncBO.ProcessarEncerramento")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarSQLInsertCab - Monta (sem executar) o INSERT INTO SigMvCab do
    * cabecalho do movimento. Colunas primarias (Emps, Dopes, Numes, Usuars,
    * Datars, Datas, MascNum, EmpDopNums, cIdChaves, DtAlts) iguais as que o
    * legado grava explicitamente ("Insert Into CrSigMvCab (Emps, Dopes,
    * Numes, Usuars, Datars, Datas, MascNum, EmpDopNums, CidChaves, DtAlts)").
    *
    * As demais colunas NOT NULL sem DEFAULT no banco (regra CLAUDE.md #22) -
    * SigMvCab tem ~90 delas, a maioria de dominios completamente estranhos a
    * este form (pedido, nota fiscal, boleto) - usam a MESMA lista e os
    * MESMOS defaults ja provados contra o schema em
    * SigOpBcbBO.prg:Inserir() (mesma tabela). "grupoos" e
    * "contaos" sao acrescentados ao FINAL de cada lista porque la eles eram
    * preenchidos com o grupo/conta do codigo de barras - aqui o legado nao
    * tem valor equivalente, entao ficam no default "" como os demais.
    *==========================================================================
    PROTECTED FUNCTION MontarSQLInsertCab()
        LOCAL loc_cColsCab, loc_cValsCab, loc_cSQL

        loc_cColsCab = "npedclis, acres, antecs, chksubn, codpeds, contads, " + ;
            "desc2s, descs, devols, empds, grresps, grupods, " + ;
            "grupos, grvends, iclis, ifors, locals, lotechqs, " + ;
            "lprecos, ncarnecs, nemps, nops, notas, nrcons, " + ;
            "ntrans, numolds, opers, resps, tabds, tpfats, " + ;
            "transps, usuals, usulibs, valacres, valdes2s, valdescs, " + ;
            "valdevs, valencs, valinis, valos, valservs, valvars, " + ;
            "vars, vends, cotusus, espes, qtdes, lcancelas, " + ;
            "cofs, livros, chkbxparcs, ecfs, codobs, dgopes, " + ;
            "trfisicos, utilizados, valndevs, valobxs, noforms, auditors, " + ;
            "empgopnums, contaes, localents, localizas, chkpagos, chkpgs, " + ;
            "codtrans, empdnbxs, empdncrds, obsagends, operadors, vcompensas, " + ;
            "motdscs, ndeclaras, numbalds, numbals, priors, procbals, " + ;
            "procdbal, protats, usupagos, ultgrvs, moeits, rnops, " + ;
            "impress, pstatus, valvarps, cifccfs, cupfis, idconta, " + ;
            "ncupoms, status, valtrans, impcpfs, ccfgnfs, fpubls, " + ;
            "jobs, ptax1s, ptax2s, ptax3s, obscabmovs, codobs2, " + ;
            "grupoos, contaos"

        loc_cValsCab = FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,4) + ", " + EscaparSQL("") + ", " + "0" + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,4) + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
            FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
            FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,4) + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + "0" + ", " + ;
            "0" + ", " + "0" + ", " + "0" + ", " + EscaparSQL("") + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + ;
            FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + ;
            "0" + ", " + "0" + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + ;
            EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + "0" + ", " + "0" + ", " + FormatarNumeroSQL(0,0) + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + EscaparSQL("") + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("")

        loc_cSQL = "INSERT INTO SigMvCab (Emps, Dopes, Numes, Usuars, Datars, Datas, MascNum, EmpDopNums, cIdChaves, DtAlts, " + loc_cColsCab + ") "
        loc_cSQL = loc_cSQL + "VALUES (" + EscaparSQL(THIS.this_cCabEmps) + ", " + EscaparSQL(THIS.this_cCabDopes) + ", " + ;
            FormatarNumeroSQL(THIS.this_nCabNumes, 0) + ", " + EscaparSQL(THIS.this_cCabUsuars) + ", " + ;
            FormatarDataSQL(THIS.this_dCabDatars) + ", " + FormatarDataSQL(THIS.this_dCabDatas) + ", " + ;
            EscaparSQL(THIS.this_cCabMascnum) + ", " + EscaparSQL(THIS.this_cCabEmpdopnums) + ", " + ;
            EscaparSQL(THIS.this_cCabCidchaves) + ", " + FormatarDataSQL(THIS.this_dCabDtalts) + ", " + loc_cValsCab + ")"

        RETURN loc_cSQL
    ENDFUNC

ENDDEFINE

