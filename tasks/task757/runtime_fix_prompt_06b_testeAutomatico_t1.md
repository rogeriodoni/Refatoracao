# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-11-08 07:39:16] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-08 07:39:17] [INFO] Config FPW: (nao fornecido)
[2026-11-08 07:39:17] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 07:39:17] [INFO] Timeout: 300 segundos
[2026-11-08 07:39:17] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3hs2igq2.prg
[2026-11-08 07:39:17] [INFO] Conteudo do wrapper:
[2026-11-08 07:39:18] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpLcl', 'C:\4c\tasks\task757', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpLcl', 'C:\4c\tasks\task757', 'OPERACIONAL'
QUIT

[2026-11-08 07:39:18] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3hs2igq2.prg
[2026-11-08 07:39:18] [INFO] VFP output esperado em: C:\4c\tasks\task757\vfp_output.txt
[2026-11-08 07:39:18] [INFO] Executando Visual FoxPro 9...
[2026-11-08 07:39:18] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3hs2igq2.prg
[2026-11-08 07:39:19] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3hs2igq2.prg
[2026-11-08 07:39:19] [INFO] Timeout configurado: 300 segundos
[2026-11-08 07:39:20] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-08 07:39:20] [INFO] VFP9 finalizado em 1.7044633 segundos
[2026-11-08 07:39:20] [INFO] Exit Code: 
[2026-11-08 07:39:20] [INFO] 
[2026-11-08 07:39:21] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-08 07:39:21] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3hs2igq2.prg
[2026-11-08 07:39:21] [INFO] 
[2026-11-08 07:39:22] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-08 07:39:22] [INFO] * Auto-generated wrapper for parameters
[2026-11-08 07:39:22] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 07:39:22] [INFO] * Parameters: 'FormSigOpLcl', 'C:\4c\tasks\task757', 'OPERACIONAL'
[2026-11-08 07:39:22] [INFO] 
[2026-11-08 07:39:22] [INFO] * Anti-dialog protections for unattended execution
[2026-11-08 07:39:22] [INFO] SET SAFETY OFF
[2026-11-08 07:39:23] [INFO] SET RESOURCE OFF
[2026-11-08 07:39:23] [INFO] SET TALK OFF
[2026-11-08 07:39:23] [INFO] SET NOTIFY OFF
[2026-11-08 07:39:23] [INFO] SYS(2335, 0)
[2026-11-08 07:39:23] [INFO] 
[2026-11-08 07:39:23] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpLcl', 'C:\4c\tasks\task757', 'OPERACIONAL'
[2026-11-08 07:39:24] [INFO] QUIT
[2026-11-08 07:39:24] [INFO] 
[2026-11-08 07:39:24] [INFO] === Fim do Wrapper.prg ===
[2026-11-08 07:39:24] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpLcl",
  "timestamp": "20261108073920",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": true,
      "erro": "",
      "detalhes": "CarregarLista() executado | (sem registros - tabela pode estar vazia)"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnIncluirClick nao encontrado (OK para REPORT/OPERACIONAL)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": false,
      "erro": "Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)",
      "detalhes": ""
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 2 (CHKMARCASKEYPRESS, KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 8,
    "falhou": 1,
    "percentual": 89
  }
}



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLcl.prg):
*==============================================================================
* FormSigOpLcl.prg
* Form Operacional: Selecao de Localizacao de Estoque
* Herda de: FormBase
* Tipo: OPERACIONAL - layout FLAT (o SCX legado NAO tem PageFrame nem Page)
* SCX Origem: SigOpLcl.SCX  (tasks\task757\SigOpLcl_form_codigo_fonte.txt)
*
* Dialogo MODAL aberto por um form de movimentacao para atribuir a
* localizacao fisica (Base / 2o / 3o / 4o nivel) aos itens marcados na grade.
*
* Parametros Init (legado: lParameters pCnx, pEscolha, pOrigem):
*   par_oCnx     - objeto de conexao legado (poDataMgr). Guardado por
*                  fidelidade ao contrato; o acesso ao banco usa gnConnHandle.
*   par_cEscolha - modo da tela chamadora: INSERIR / ALTERAR / outro
*                  (so INSERIR/ALTERAR permitem editar - When do legado)
*   par_cOrigem  - "ORIGEM" faz a localizacao ir para crTpmMvItn.Localos;
*                  qualquer outro valor usa crTpmMvItn.Locals
*
* CONTRATO EXTERNO: o cursor crTpmMvItn eh do form CHAMADOR e chega por esta
* data session. Por isso DataSession = 1 (sessao corrente, igual ao SCX) -
* trocar para 2 isolaria a sessao e o cursor do chamador ficaria invisivel.
*
* FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1)
*   Entregue ate aqui: DEFINE CLASS + propriedades visuais e de estado, Init,
*   InicializarForm, ConfigurarCabecalho (cntSombra), ConfigurarGrid +
*   CarregarLista (grdItens), ConfigurarBotoes (cntBotoes/SelTudo/apaga),
*   ConfigurarCamposNiveis (Shape1 + Base e Segundo Nivel, com o gate de modo
*   em AtualizarDependenciaNiveis), TornarControlesVisiveis e Destroy.
*
* FASE 6/8 - CAMPOS RESTANTES E LOOKUPS (PARTE 2)
*   Acrescentado nesta fase: ConfigurarCamposNiveisParte2 (Terceiro/Quarto
*   Nivel + ShpFigura/ImgJpg da foto do produto), ConfigurarAcoesLocalizacao
*   (cmdAcoes - Localizar/Limpar Selecao), ConfigurarOrdenacao (Label5 +
*   OptOrdem), ConfigurarLookupsNiveis (os quatro lookups de nivel, em
*   LostFocus - regra #47 - com guarda de reentrancia this_lEmLookup),
*   AbrirBuscaBase / AbrirBuscaNivel (os DOIS funis de picker - regra #37 -
*   o primeiro sobre a tabela REMOTA SigLcNv1, o segundo sobre o cursor LOCAL
*   da hierarquia) com os resolvedores ObterControleNivel / ObterCursorNivel /
*   ObterTituloNivel, e
*   ConfigurarHandlersGrade (toggle do Check1 da coluna Marcas + foto/estado
*   do botao Localizar no AfterRowColChange). AtualizarDependenciaNiveis foi
*   estendido para gatear tambem Terceiro e Quarto Nivel.
*
* FASE 8/8 - CONSOLIDACAO FINAL
*   Acrescentado nesta fase os tres funis canonicos que ate aqui estavam
*   espalhados pelos handlers, cada um com referente EXPLICITO no SCX legado:
*     CarregarLista() - era VincularGrade; eh a transcricao do "PROCEDURE
*       montagrade" legado (bind + Index on cItens + Refresh). PUBLIC, porque
*       eh o funil de recarga e o harness o aciona de fora (regra #3).
*     FormParaBO()    - o bloco lcLoc1..lcLoc4 do inicio do btnLocalizar.Click,
*       agora cobrindo tambem as quatro descricoes (que o BO declarava e
*       ninguem alimentava). Ponto UNICO de travessia tela -> BO.
*     BOParaForm()    - sentido inverso; recarrega os oito campos a partir do
*       estado do BO, usado pelos dois caminhos que limpam a selecao
*       (fim do btnLocalizar.Click e btnLimpar.Click).
*   Os dois hooks sao PROTECTED EXPLICITO - FormBase os declara PROTECTED e o
*   VFP9 nao deixa a subclasse alargar escopo herdado.
*
*   O QUE ESTE FORM NAO TEM, e por que:
*     - barra CRUD (os cinco botoes de cadastro) e os dois botoes da Page2 de
*       Dados: o SCX eh "Class: form" puro, sem frmcadastro e sem Grupo_Op; o
*       modo (pcEscolha) CHEGA do chamador por parametro, nao eh escolhido
*       aqui. Os botoes reais sao os seis do dump, todos com handler.
*     - Ajustar<...>PorModo / Habilitar<...>: o gate de modo do legado eh o
*       "When" de cada campo e de cada botao, e esta reproduzido em
*       AtualizarDependenciaNiveis + this_lPodeEditar.
*     - Limpar<...>: a limpeza dos oito campos eh BOParaForm sobre
*       SigOpLclBO.LimparNiveis(), fonte unica dos dois caminhos acima.
*==============================================================================

DEFINE CLASS FormSigOpLcl AS FormBase

    *-- Propriedades visuais transcritas do SCX legado (PILAR 1)
    this_cMensagemErro = ""
    Width        = 968
    Height       = 500
    AutoCenter   = .T.
    ShowTips     = .T.
    BorderStyle  = 2
    Caption      = "Sele" + CHR(231) + CHR(227) + "o de Localiza" + CHR(231) + CHR(227) + "o"
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    KeyPreview   = .T.
    TitleBar     = 0
    WindowType   = 1
    AlwaysOnTop  = .T.
    Themes       = .F.
    FontName     = "Verdana"
    FontSize     = 8

    *-- DataSession = 1 (sessao corrente) - obrigatorio: crTpmMvItn eh criado
    *-- pelo form chamador e precisa continuar visivel aqui
    DataSession  = 1

    *-- Parametros recebidos no Init (equivalentes a pcEscolha/pcOrigem/
    *-- poDataMgr do SCX legado), guardados ANTES do DODEFAULT
    this_cEscolha      = ""       && pcEscolha - INSERIR / ALTERAR / outro
    this_cOrigem       = ""       && pcOrigem  - "ORIGEM" ou outro
    this_oConexao      = .NULL.   && poDataMgr - conexao legado (nao usada em SQL)

    *-- Estado operacional
    *-- .T. quando o modo recebido permite editar (INSERIR/ALTERAR). Eh o
    *-- equivalente ao "Return(InList(Thisform.pcEscolha,'INSERIR','ALTERAR'))"
    *-- que o legado repete no When de cada campo e de cada botao de acao.
    this_lPodeEditar   = .F.

    *-- Ordenacao corrente da grade (OptOrdem do legado: 1 = Produto,
    *-- 2 = Colecao/Categoria)
    this_nOrdemAtual   = 1

    *-- Guarda de reentrancia dos lookups de nivel: o picker eh MODAL, tira o
    *-- foco e redispara o proprio LostFocus do campo que o abriu
    this_lEmLookup     = .F.

    *==========================================================================
    * Init - guarda os parametros do chamador e dispara a inicializacao
    *
    * Legado: lParameters pCnx, pEscolha, pOrigem (atribuidos a ThisForm.*
    * antes de montar a tela).
    *
    * Os parametros vem do form PAI e NAO existem no harness de teste
    * (TestFormWrapper faz CREATEOBJECT sem argumento nenhum), por isso a
    * leitura eh toda guardada por VARTYPE/PCOUNT e NENHUMA ausencia derruba
    * o Init - devolver .F. aqui faria CREATEOBJECT devolver .F. logico.
    *==========================================================================
    PROCEDURE Init(par_oCnx, par_cEscolha, par_cOrigem)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- poDataMgr: guardado por fidelidade ao contrato do legado
        THIS.this_oConexao = IIF(VARTYPE(par_oCnx) = "O", par_oCnx, .NULL.)

        *-- pcEscolha: modo da tela chamadora
        IF PCOUNT() >= 2 AND VARTYPE(par_cEscolha) = "C"
            THIS.this_cEscolha = ALLTRIM(UPPER(par_cEscolha))
        ENDIF

        *-- pcOrigem: define qual coluna de crTpmMvItn recebe a localizacao
        IF PCOUNT() >= 3 AND VARTYPE(par_cOrigem) = "C"
            THIS.this_cOrigem = ALLTRIM(UPPER(par_cOrigem))
        ENDIF

        *-- Equivalente ao When do legado: so INSERIR/ALTERAR editam
        THIS.this_lPodeEditar = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

        *-- OptOrdem nasce com Value = 1 (Produto) no SCX
        THIS.this_nOrdemAtual = 1

        loc_lResultado = DODEFAULT()

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - instancia o BO, monta a casca da tela e carrega os
    *                   cursores de trabalho
    *
    * Ordem de montagem (fiel ao Init legado):
    *   1. BO (SigOpLclBO) - dono dos cursores e das regras
    *   2. cursor de localizacoes escolhidas (csLocals do legado)
    *   3. itens do movimento a partir de crTpmMvItn (crItensLoc do legado)
    *   4. hierarquia de niveis + expansao do XML (crSigLcNv2..4 do legado)
    *   5. cabecalho (cntSombra do legado)
    *   6. grade de itens (grdItens do legado - estrutura, depois bind)
    *   7. botoes de acao (cntBotoes/SelTudo/apaga do legado)
    *   8. campos da localizacao (Shape1 + Base/Segundo Nivel do legado)
    *
    * Os passos 3 e 4 dependem de recursos EXTERNOS (o cursor do form
    * chamador e a conexao com o SQL Server). A ausencia deles NAO derruba a
    * tela: o Init legado tambem segue adiante, e no harness de teste nem o
    * cursor nem a conexao existem. Quem depende do dado valida na hora de
    * gravar (ValidarDados/Inserir do BO).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- 1. Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpLclBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- Propaga o contexto recebido do chamador para o BO
                THIS.this_oBusinessObject.this_cEscolha = THIS.this_cEscolha
                THIS.this_oBusinessObject.this_cOrigem  = THIS.this_cOrigem

                *-- 2. Cursor das localizacoes escolhidas (csLocals do legado)
                THIS.this_oBusinessObject.CriarCursorLocalizacoes()

                *-- 3. Itens do movimento (crItensLoc do legado). Devolve .F.
                *--    quando crTpmMvItn nao esta aberto - situacao normal no
                *--    harness e tratada pelo BO, nao impede abrir a tela.
                THIS.this_oBusinessObject.CarregarItens(THIS.this_cOrigem)

                *-- 4. Hierarquia de niveis + expansao do XML de cada nivel
                THIS.this_oBusinessObject.CarregarNiveis()

                *-- 5. Cabecalho (cntSombra legado, com os dois labels)
                THIS.ConfigurarCabecalho()

                *-- Caption propagado para os labels do cabecalho, igual as
                *-- duas primeiras linhas do Init legado
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- 6. Grade de itens: estrutura primeiro, bind depois (o
                *--    bind depende de cursor_4c_Itens, que so existe apos
                *--    o passo 3 ter rodado)
                THIS.ConfigurarGrid()
                THIS.CarregarLista()

                *-- 7. Botoes de acao (Confirmar/Cancelar + Selecionar/
                *--    Desmarcar tudo)
                THIS.ConfigurarBotoes()

                *-- 8. Campos da localizacao (Shape1 + Base e Segundo Nivel)
                THIS.ConfigurarCamposNiveis()

                *-- 8b. Campos da localizacao, parte 2 (Terceiro/Quarto Nivel
                *--     + ShpFigura/ImgJpg da foto do produto)
                THIS.ConfigurarCamposNiveisParte2()

                *-- 9. Acoes de localizacao (btnLocalizar/btnLimpar - cmdAcoes)
                THIS.ConfigurarAcoesLocalizacao()

                *-- 10. Ordenacao da grade (Label5 + OptOrdem)
                THIS.ConfigurarOrdenacao()

                *-- 11. Lookups dos quatro niveis de localizacao
                THIS.ConfigurarLookupsNiveis()

                *-- 12. Handlers da grade (toggle do Check1 + AfterRowColChange)
                THIS.ConfigurarHandlersGrade()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o objeto de neg" + CHR(243) + "cio SigOpLclBO."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar a tela de Sele" + CHR(231) + CHR(227) + ;
                    "o de Localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do titulo (cntSombra do SCX legado)
    *
    * Geometria e cores transcritas do dump:
    *   cntSombra  Top=0 Left=0 Width=968 Height=80 BackColor=100,100,100
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *
    * Os dois labels sao a sombra e o texto do mesmo titulo (o preto desenha
    * 1px abaixo do branco). AutoSize = .F. explicito: em Label criado por
    * AddObject o AutoSize eh no-op e com WordWrap = .T. ele ainda descarta a
    * Height - a geometria do SCX ja eh o auto-size calculado pelo Designer.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra

        WITH loc_oCnt
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .AutoSize    = .F.
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - grade de itens do movimento (grdItens do SCX legado)
    *
    * Geometria e colunas transcritas do dump. ColumnOrder define a ordem
    * VISUAL das colunas (1=Marcas, 2=#, 3=Produto, 4=Descricao, 5=
    * Localizacao) - diferente da ordem de CRIACAO (Column1..5), que segue
    * a ordem do SCX.
    *
    * NAO vincula RecordSource/ControlSource aqui: cursor_4c_Itens so existe
    * depois de SigOpLclBO.CarregarItens() rodar, e Column.ControlSource de
    * cursor ainda ausente derruba o Init. O bind fica em CarregarLista(),
    * chamado depois na mesma ordem de InicializarForm.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        *-- DESFAZER o auto-bind ANTES de mexer em ColumnCount. Grid nasce com
        *-- RecordSourceType = 1 (Alias) e o VFP9 o liga sozinho ao alias da
        *-- WORK AREA CORRENTE - aqui a dos cursores que o BO acabou de montar
        *-- (medido: RecordSource=[Cursor_4c_LcNv4], ColumnCount=2). Com a
        *-- coluna ja vinculada a um campo CHAR, o AddObject do CheckBox em
        *-- Column3 estoura "Error with CHK_4C_MARCAS - Value : Data type
        *-- mismatch", InicializarForm devolve .F. e a TELA NAO ABRE.
        loc_oGrid.RecordSourceType = 1
        loc_oGrid.RecordSource     = ""

        WITH loc_oGrid
            .Top           = 87
            .Left          = 12
            .Width         = 575
            .Height        = 387
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .TabIndex      = 1
            .GridLineColor = RGB(238, 238, 238)
            .ColumnCount   = 5
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Column1 - Produto (Cpros). ColumnOrder=3 (3a posicao visual)
        WITH loc_oGrid.Column1
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ColumnOrder       = 3
            .Width             = 122
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Produto"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.Alignment   = 3
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .F.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column2 - Descricao (Dpros). ColumnOrder=4
        WITH loc_oGrid.Column2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ColumnOrder       = 4
            .Width             = 290
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column3 - marca de selecao (Marcas). ColumnOrder=1 (1a posicao
        *-- visual). CheckBox via AddObject + CurrentControl (regra #18) -
        *-- o toggle de clique (KeyPress/MouseDown/MouseUp) entra na fase
        *-- dos handlers de grade.
        WITH loc_oGrid.Column3
            .FontName         = "Tahoma"
            .FontSize         = 8
            .ColumnOrder      = 1
            .Width            = 17
            .Header1.FontName = "Tahoma"
            .Header1.FontSize = 8
            .Header1.Caption  = ""
        ENDWITH

        loc_oGrid.Column3.AddObject("chk_4c_Marcas", "CheckBox")
        WITH loc_oGrid.Column3.chk_4c_Marcas
            .Top       = 22
            .Left      = 22
            .Height    = 17
            .Width     = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .Caption   = ""
            *-- .Value NUMERICO e OBRIGATORIO: CheckBox nasce com .Value
            *-- LOGICO (.F.) e a coluna ligada eh cursor_4c_Itens.Marcas
            *-- N(1,0). Sem esta linha o bind de Column3.ControlSource
            *-- estoura "Error with CHK_4C_MARCAS - Value : Data type
            *-- mismatch", InicializarForm devolve .F. e CREATEOBJECT
            *-- devolve .F. logico - a tela nao abre.
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        loc_oGrid.Column3.CurrentControl = "chk_4c_Marcas"
        loc_oGrid.Column3.Sparse         = .F.
        loc_oGrid.Column3.ReadOnly       = .F.

        *-- Column4 - numero do item (cItens). ColumnOrder=2
        WITH loc_oGrid.Column4
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ColumnOrder       = 2
            .Width             = 25
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "#"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 - localizacao atribuida (Locals). ColumnOrder default (5)
        WITH loc_oGrid.Column5
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = 95
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Localiza" + CHR(231) + CHR(227) + "o"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarLista - FUNIL UNICO de carga/repintura da grade de itens
    *
    * Eh a transcricao do "PROCEDURE montagrade" do SCX legado, que faz
    * exatamente isto e nada mais:
    *     Select crItensLoc / Index on cItens Tag cItens / Go top
    *     With ThisForm.grdItens
    *         .RecordSource = [crItensLoc]
    *         .column1..column5.ControlSource = [crItensLoc.<coluna>]
    *         .Refresh()
    *     EndWith
    *     ThisForm.grdItens.Column1.SetFocus / .Refresh
    *
    * O nome canonico do projeto para esse funil eh CarregarLista (o legado
    * chama de montagrade), e ele eh PUBLIC de proposito (regra #3): o
    * harness de teste o aciona de FORA da classe, e tambem o btnLimpar do
    * legado o chama como ponto de recarga.
    *
    * Chamada DEPOIS de SigOpLclBO.CarregarItens() rodar. Se o cursor nao
    * existe (crTpmMvItn fechado - sem form chamador, caso do harness de
    * teste), cria um placeholder com a MESMA estrutura da SELECT do BO
    * (regra "cursor placeholder = cursor real"), para a grade sempre ter
    * um alias valido para ligar.
    *
    * RecordSource reseta Width/Header1.Caption/CurrentControl/Sparse das
    * colunas (Problema 48 do projeto / regra #18) - por isso sao
    * reaplicados abaixo, na ordem canonica: ColumnCount -> RecordSource ->
    * ControlSource -> Width -> Header.Caption.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid

        IF !USED("cursor_4c_Itens")
            CREATE CURSOR cursor_4c_Itens (Marcas N(1, 0), Cpros C(14), ;
                Dpros C(65), cItens N(10, 0), Locals C(10), Categoria C(6))
        ENDIF

        loc_oGrid = THIS.grd_4c_Dados

        *-- Column3 volta para o Text1 ANTES do bind: atribuir RecordSource
        *-- auto-vincula cada coluna ao campo de MESMA POSICAO do cursor, e a
        *-- 3a eh Dpros (char). Com o CheckBox ainda sendo o CurrentControl,
        *-- esse vinculo intermediario estoura Data type mismatch. O
        *-- CurrentControl eh reposto no fim, depois do ControlSource certo.
        loc_oGrid.Column3.CurrentControl = "Text1"

        loc_oGrid.RecordSource = ""
        loc_oGrid.RecordSource = "cursor_4c_Itens"
        loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.Cpros"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.Dpros"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.Marcas"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.cItens"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.Locals"

        loc_oGrid.Column1.Width           = 122
        loc_oGrid.Column1.Header1.Caption = "Produto"

        loc_oGrid.Column2.Width           = 290
        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

        loc_oGrid.Column3.Width           = 17
        loc_oGrid.Column3.Header1.Caption = ""
        loc_oGrid.Column3.CurrentControl  = "chk_4c_Marcas"
        loc_oGrid.Column3.Sparse          = .F.

        loc_oGrid.Column4.Width           = 25
        loc_oGrid.Column4.Header1.Caption = "#"

        loc_oGrid.Column5.Width           = 95
        loc_oGrid.Column5.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"

        *-- "Index on cItens Tag cItens" do montagrade legado: a ordem volta
        *-- para o numero do item a cada recarga (o OptOrdem reindexa depois,
        *-- em OrdenarItens). O tag so existe quando o cursor veio de
        *-- CarregarItens - no placeholder do harness nao ha tag nenhum, e
        *-- SET ORDER TO TAG num cursor sem tag estoura.
        SELECT cursor_4c_Itens
        IF TAGNO("cItens", "", "cursor_4c_Itens") > 0
            SET ORDER TO TAG cItens
        ENDIF
        GO TOP
        loc_oGrid.Refresh()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Confirmar/Cancelar (cntBotoes) + Selecionar/
    * Desmarcar tudo (SelTudo/apaga) do SCX legado
    *
    * Este dialogo NAO tem botoes CRUD (Incluir/Alterar/Excluir/Buscar) - o
    * legado so tem estes quatro botoes de acao, porque a tela eh um popup
    * de selecao e nao um cadastro. Localizar/Limpar Selecao (cmdAcoes) e a
    * ordenacao (OptOrdem) dependem dos campos de nivel (getBase/getNvl2..4),
    * que entram em fase posterior - ficam de fora deste metodo de proposito.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()

        *-- cntBotoes legado: Confirmar (Buttons(2)/Command2) e Cancelar
        *-- (Buttons(1)/Command1), lado direito da tela
        THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
        WITH THIS.obj_4c_CntBotoes
            .Top           = -3
            .Left          = 812
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 0
            .TabIndex      = 3
            .Themes        = .F.

            WITH .Buttons(1)
                .Top           = 5
                .Left          = 80
                .Width         = 75
                .Height        = 75
                .Caption       = "\<Cancelar"
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .FontBold      = .T.
                .FontItalic    = .T.
                .WordWrap      = .T.
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel        = .T.
                .MousePointer  = 15
                .TabIndex      = 2
                .ToolTipText   = "[Esc] Encerrar"
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top          = 5
                .Left         = 5
                .Width        = 75
                .Height       = 75
                .Caption      = "\<Confirmar"
                .FontName     = "Comic Sans MS"
                .FontSize     = 8
                .FontBold     = .T.
                .FontItalic   = .T.
                .WordWrap     = .T.
                .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .MousePointer = 15
                .TabIndex     = 1
                .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(1), "Click", THIS, "BtnCancelarClick")
        BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(2), "Click", THIS, "BtnConfirmarClick")

        *-- SelTudo/apaga: standalone, ao lado da grade. Picture e ToolTip
        *-- transcritos do dump (regra #25 - NUNCA inventar nome de icone)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top             = 220
            .Left            = 590
            .Width           = 45
            .Height          = 40
            .Caption         = ""
            .FontName        = "Verdana"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Themes          = .T.
            .TabStop         = .F.
            .ToolTipText     = "Selecionar"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")

        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top             = 261
            .Left            = 590
            .Width           = 45
            .Height          = 40
            .Caption         = ""
            .FontName        = "Verdana"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Themes          = .T.
            .TabStop         = .F.
            .ToolTipText     = "Desmarcar"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarCamposNiveis - bloco da localizacao, PARTE 1 (Base e 2o nivel)
    *
    * Transcricao do dump do SCX legado, objeto a objeto:
    *   Shape1    Top= 87 Left=646 W=292 H=196 BackStyle=0  (moldura do bloco)
    *   Label3    Top= 89 Left=682 W= 25 H= 15 "Base"           ForeColor 90,90,90
    *   getBase   Top=107 Left=682 W= 54 H= 24 SpecialEffect=1  TabIndex=5
    *   getDBase  Top=107 Left=737 W=174 H= 24 SpecialEffect=1  TabIndex=6
    *   Label1    Top=134 Left=682 W= 70 H= 15 "Segundo Nivel"  ForeColor 90,90,90
    *   getNvl2   Top=152 Left=682 W= 54 H= 24 SpecialEffect=1  TabIndex=8
    *   getDNvl2  Top=152 Left=737 W=174 H= 24 SpecialEffect=1  TabIndex=9
    *
    * A moldura (Shape1) eh o PRIMEIRO AddObject do metodo: ela cobre toda a
    * area do bloco e precisa desenhar ATRAS dos labels e das caixas de texto.
    * Shape nao tem ForeColor (a cor dele mora em BorderColor/FillColor) e o
    * dump nao declara nenhuma das duas - nada a transcrever.
    *
    * Labels: o dump declara AutoSize = .T., mas em Label criado por AddObject
    * o AutoSize eh no-op e com WordWrap ele ainda descarta a Height, por isso
    * vai .AutoSize = .F. com a Width E a Height do SCX, que JA SAO o auto-size
    * calculado pelo Form Designer. O Alignment fica em 0 (a classe say do
    * legado eh alinhada a esquerda) e o ForeColor eh o RGB(90, 90, 90) do
    * dump: branco sobre o fundo claro do form ficaria invisivel.
    *
    * MaxLength vem da LARGURA DA COLUNA no schema, nunca do Width em pixels:
    *   SigLcNv1.cods  char(2)  -> txt_4c_Base  = 2
    *   SigLcNv1.descs char(20) -> txt_4c_DBase = 20
    *   SigLcNv2.cods  char(2)  -> txt_4c_Nvl2  = 2
    *   SigLcNv2.descs char(20) -> txt_4c_DNvl2 = 20
    * O cursor de nivel expoe o codigo na coluna calculada Codigo, mas o valor
    * que o usuario digita eh o cods da tabela - sao as mesmas larguras que
    * SigOpLclBO.MontarLocalizacao soma (2+2+2+4) para caber nos 10 chars de
    * SigMvItn.locals.
    *
    * O dump NAO declara Format nem InputMask em nenhuma destas caixas: nada a
    * transcrever, e inventar mascara mudaria o que o usuario pode digitar.
    *
    * Os dois campos de DESCRICAO sao somente-leitura por decisao do legado -
    * getDBase.When e getDNvl2.When fazem "Return .F.", ou seja o usuario nunca
    * alcanca esses campos; eles recebem valor apenas pelo lookup do codigo ao
    * lado. Migrado como ReadOnly = .T. + TabStop = .F.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposNiveis()

        *-- Shape1: moldura do bloco de localizacao (transparente, so borda)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top       = 87
            .Left      = 646
            .Width     = 292
            .Height    = 196
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label3 + getBase + getDBase: nivel 1 (Base), de SigLcNv1
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Base"
            .Top       = 89
            .Left      = 682
            .Width     = 25
            .Height    = 15
            .TabIndex  = 4
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Base", "TextBox")
        WITH THIS.txt_4c_Base
            .FontName      = "Verdana"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 2
            .Margin        = 3
            .SpecialEffect = 1
            .Top           = 107
            .Left          = 682
            .Width         = 54
            .Height        = 24
            .TabIndex      = 5
            .ToolTipText   = "Base da Localiza" + CHR(231) + CHR(227) + "o"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DBase", "TextBox")
        WITH THIS.txt_4c_DBase
            .FontName      = "Verdana"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 20
            .Margin        = 3
            .SpecialEffect = 1
            .Top           = 107
            .Left          = 737
            .Width         = 174
            .Height        = 24
            .TabIndex      = 6
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label1 + getNvl2 + getDNvl2: nivel 2, de SigLcNv2
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Segundo N" + CHR(237) + "vel"
            .Top       = 134
            .Left      = 682
            .Width     = 70
            .Height    = 15
            .TabIndex  = 7
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Nvl2", "TextBox")
        WITH THIS.txt_4c_Nvl2
            .FontName      = "Verdana"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 2
            .Margin        = 3
            .SpecialEffect = 1
            .Top           = 152
            .Left          = 682
            .Width         = 54
            .Height        = 24
            .TabIndex      = 8
            .ToolTipText   = "Segundo N" + CHR(237) + "vel da Localiza" + ;
                             CHR(231) + CHR(227) + "o"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DNvl2", "TextBox")
        WITH THIS.txt_4c_DNvl2
            .FontName      = "Verdana"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 20
            .Margin        = 3
            .SpecialEffect = 1
            .Top           = 152
            .Left          = 737
            .Width         = 174
            .Height        = 24
            .TabIndex      = 9
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Estado inicial do gate de modo/dependencia (When do legado)
        THIS.AtualizarDependenciaNiveis()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarCamposNiveisParte2 - bloco da localizacao, PARTE 2 (Terceiro
    * e Quarto nivel) + a moldura/imagem da foto do produto (ShpFigura/ImgJpg)
    *
    * Transcricao do dump do SCX legado, objeto a objeto:
    *   Label2    Top=183 Left=682 W=67 H=15 "Terceiro Nivel" ForeColor 90,90,90
    *   getNvl3   Top=201 Left=682 W=54 H=24 SpecialEffect=1  TabIndex=11
    *   getDNvl3  Top=201 Left=737 W=174 H=24 SpecialEffect=1 TabIndex=12
    *   Label4    Top=228 Left=682 W=62 H=15 "Quarto Nivel"   ForeColor 90,90,90
    *   getNvl4   Top=246 Left=682 W=54 H=24 SpecialEffect=1  TabIndex=14
    *   getDNvl4  Top=246 Left=737 W=174 H=24 SpecialEffect=1 TabIndex=15
    *   ShpFigura Top=303 Left=619 W=319 H=172 BackStyle=0 (moldura da foto)
    *   ImgJpg    Top=306 Left=622 W=313 H=165 Stretch=2 Visible=.F.
    *
    * MaxLength das caixas de codigo/descricao, pela LARGURA DA COLUNA no
    * schema (regra #19), nunca pelo Width em pixels:
    *   SigLcNv3.cods  char(2)  -> txt_4c_Nvl3  = 2
    *   SigLcNv3.descs char(20) -> txt_4c_DNvl3 = 20
    *   SigLcNv4.cods  char(4)  -> txt_4c_Nvl4  = 4  (o unico nivel com 4)
    *   SigLcNv4.descs char(20) -> txt_4c_DNvl4 = 20
    * Essas quatro larguras (2+2+2+4) sao exatamente as que
    * SigOpLclBO.MontarLocalizacao soma para caber nos 10 chars de
    * SigMvItn.locals.
    *
    * ImgJpg nasce Visible = .F. (dump legado) e fica assim ate o
    * AfterRowColChange da grade decidir se ha foto para a linha corrente -
    * por isso o nome do controle (img_4c_ImgJpg) ja esta na lista de EXCECAO
    * de TornarControlesVisiveis (regra da tela nao forcar visivel o que o
    * legado mantem oculto).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposNiveisParte2()

        *-- Label2 + getNvl3 + getDNvl3: nivel 3, de SigLcNv3
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Terceiro N" + CHR(237) + "vel"
            .Top       = 183
            .Left      = 682
            .Width     = 67
            .Height    = 15
            .TabIndex  = 10
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Nvl3", "TextBox")
        WITH THIS.txt_4c_Nvl3
            .FontName      = "Verdana"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 2
            .Margin        = 3
            .SpecialEffect = 1
            .Top           = 201
            .Left          = 682
            .Width         = 54
            .Height        = 24
            .TabIndex      = 11
            .ToolTipText   = "Terceiro N" + CHR(237) + "vel da Localiza" + ;
                             CHR(231) + CHR(227) + "o"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DNvl3", "TextBox")
        WITH THIS.txt_4c_DNvl3
            .FontName      = "Verdana"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 20
            .Margin        = 3
            .SpecialEffect = 1
            .Top           = 201
            .Left          = 737
            .Width         = 174
            .Height        = 24
            .TabIndex      = 12
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label4 + getNvl4 + getDNvl4: nivel 4, de SigLcNv4
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Quarto N" + CHR(237) + "vel"
            .Top       = 228
            .Left      = 682
            .Width     = 62
            .Height    = 15
            .TabIndex  = 13
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Nvl4", "TextBox")
        WITH THIS.txt_4c_Nvl4
            .FontName      = "Verdana"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 4
            .Margin        = 3
            .SpecialEffect = 1
            .Top           = 246
            .Left          = 682
            .Width         = 54
            .Height        = 24
            .TabIndex      = 14
            .ToolTipText   = "Quarto N" + CHR(237) + "vel da Localiza" + ;
                             CHR(231) + CHR(227) + "o"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DNvl4", "TextBox")
        WITH THIS.txt_4c_DNvl4
            .FontName      = "Verdana"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 20
            .Margin        = 3
            .SpecialEffect = 1
            .Top           = 246
            .Left          = 737
            .Width         = 174
            .Height        = 24
            .TabIndex      = 15
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Visible       = .T.
        ENDWITH

        *-- ShpFigura: moldura da foto do produto (transparente, so borda)
        THIS.AddObject("shp_4c_ShpFigura", "Shape")
        WITH THIS.shp_4c_ShpFigura
            .Top       = 303
            .Left      = 619
            .Width     = 319
            .Height    = 172
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- ImgJpg: foto do produto, preenchida pelo AfterRowColChange da
        *-- grade. Nasce OCULTA (dump legado) - fica assim ate ter foto.
        THIS.AddObject("img_4c_ImgJpg", "Image")
        WITH THIS.img_4c_ImgJpg
            .Top     = 306
            .Left    = 622
            .Width   = 313
            .Height  = 165
            .Stretch = 2
            .Picture = ""
            .Visible = .F.
        ENDWITH

        *-- Reaplica o gate de modo/dependencia com os campos novos
        THIS.AtualizarDependenciaNiveis()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarAcoesLocalizacao - botoes Localizar/Limpar Selecao (cmdAcoes)
    *
    * Geometria e cores transcritas do dump (mesmo padrao de cntBotoes):
    *   cmdAcoes      Top=-3 Left=662 W=160 H=85 ButtonCount=2
    *   Buttons(1)    btnLocalizar - Top=5 Left=80 W=75 H=75
    *   Buttons(2)    btnLimpar    - Top=5 Left=5  W=75 H=75
    *
    * btnLocalizar.Enabled comeca igual a this_lPodeEditar e eh refinado pelo
    * AfterRowColChange da grade (so fica .T. quando a linha corrente tem
    * Marcas <> 0 - regra #37 do legado). btnLimpar.Enabled fica so em
    * this_lPodeEditar, sem depender da linha corrente - o legado tem o mesmo
    * When para os dois (InList(pcEscolha,'INSERIR','ALTERAR')), mas so
    * btnLocalizar.When tem a segunda condicao de item marcado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAcoesLocalizacao()

        THIS.AddObject("obj_4c_CmdAcoes", "CommandGroup")
        WITH THIS.obj_4c_CmdAcoes
            .Top           = -3
            .Left          = 662
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 0
            .TabIndex      = 2
            .Themes        = .F.

            WITH .Buttons(1)
                .Top           = 5
                .Left          = 80
                .Width         = 75
                .Height        = 75
                .Caption       = "\<Localizar"
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .FontBold      = .T.
                .FontItalic    = .T.
                .WordWrap      = .T.
                .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .Cancel        = .T.
                .MousePointer  = 15
                .TabIndex      = 2
                .ToolTipText   = "[Esc] Encerrar"
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .Enabled       = THIS.this_lPodeEditar
            ENDWITH

            WITH .Buttons(2)
                .Top          = 5
                .Left         = 5
                .Width        = 75
                .Height       = 75
                .Caption      = "\<Limpar Sele" + CHR(231) + CHR(227) + "o"
                .FontName     = "Comic Sans MS"
                .FontSize     = 8
                .FontBold     = .T.
                .FontItalic   = .T.
                .WordWrap     = .T.
                .Picture      = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
                .MousePointer = 15
                .TabIndex     = 1
                .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
                .Enabled      = THIS.this_lPodeEditar
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.obj_4c_CmdAcoes.Buttons(1), "Click", THIS, "BtnLocalizarClick")
        BINDEVENT(THIS.obj_4c_CmdAcoes.Buttons(2), "Click", THIS, "BtnLimparClick")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarOrdenacao - Label5 + OptOrdem (ordenacao da grade de itens)
    *
    * Geometria transcrita do dump:
    *   Label5   Top=479 Left=13 W=65 H=15 "Ordenacao : " ForeColor 90,90,90
    *   OptOrdem Top=473 Left=74 W=130 H=25 ButtonCount=2 Value=1
    *     Option1 "Produto" Left=5  Top=5 W=56 H=15 (Value=1 - default)
    *     Option2 "Colecao" Left=69 Top=5 W=56 H=15
    *
    * OptOrdem.Value = 1 -> ordena por Cpros; 2 -> ordena por Categoria
    * (SigOpLclBO.OrdenarItens, transcricao do OptOrdem.Valid legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOrdenacao()

        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Ordena" + CHR(231) + CHR(227) + "o : "
            .Top       = 479
            .Left      = 13
            .Width     = 65
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
        WITH THIS.obj_4c_OptOrdem
            .Top         = 473
            .Left        = 74
            .Width       = 130
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Produto"
                .Top       = 5
                .Left      = 5
                .Width     = 56
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Cole" + CHR(231) + CHR(227) + "o"
                .Top       = 5
                .Left      = 69
                .Width     = 56
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.obj_4c_OptOrdem, "InteractiveChange", THIS, "OptOrdemInteractiveChange")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * OptOrdemInteractiveChange - OptOrdem.Valid do legado
    *   Value = 1 -> Index on Cpros ; senao -> Index on Categoria / Go Top /
    *   grdItens.Refresh
    *==========================================================================
    PROCEDURE OptOrdemInteractiveChange()
        LOCAL loc_nValor
        loc_nValor = THIS.obj_4c_OptOrdem.Value
        THIS.this_nOrdemAtual = loc_nValor

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.OrdenarItens(loc_nValor)
        ENDIF

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            GO TOP
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * AtualizarDependenciaNiveis - gate dos campos de nivel (When do legado)
    *
    * O legado escreve a regra no When de cada caixa:
    *   getBase.When : Return (InList(pcEscolha,[INSERIR],[ALTERAR]))
    *   getNvl2.When : o mesmo teste de modo E, antes de liberar,
    *                  If Empty(getBase.Value) -> Return .F.
    *   getNvl3.When : o mesmo, mas contra getNvl2.Value
    *   getNvl4.When : o mesmo, mas contra getNvl3.Value
    *
    * BINDEVENT nao atende "When" de TextBox de forma confiavel, entao o gate
    * mora num metodo UNICO e PUBLIC, chamado por todo ponto que muda o estado
    * dos niveis. Campo fora do gate fica com Enabled = .F.: a caixa cinza
    * ocupa o lugar do "Wait Window [Nivel Anterior nao Informado.] Nowait"
    * que o legado piscava ao tentar entrar no campo, e impede a digitacao do
    * mesmo jeito.
    *
    * As caixas de descricao nao entram aqui: elas sao ReadOnly de nascimento
    * (o When delas devolve .F. no legado, sem condicao nenhuma).
    *
    * Os PEMSTATUS de Nvl3/Nvl4 existem porque este metodo ja eh chamado no
    * fim de ConfigurarCamposNiveis (so Base/Nvl2 criados ainda) - sem a
    * guarda, a 1a chamada estouraria "Property TXT_4C_NVL3 is not found".
    *==========================================================================
    PROCEDURE AtualizarDependenciaNiveis()
        LOCAL loc_lBasePreenchida, loc_lNvl2Preenchida, loc_lNvl3Preenchida

        IF !PEMSTATUS(THIS, "txt_4c_Base", 5) OR !PEMSTATUS(THIS, "txt_4c_Nvl2", 5)
            RETURN .F.
        ENDIF

        loc_lBasePreenchida = !EMPTY(ALLTRIM(THIS.txt_4c_Base.Value))

        THIS.txt_4c_Base.Enabled = THIS.this_lPodeEditar
        THIS.txt_4c_Nvl2.Enabled = THIS.this_lPodeEditar AND loc_lBasePreenchida

        IF PEMSTATUS(THIS, "txt_4c_Nvl3", 5)
            loc_lNvl2Preenchida      = !EMPTY(ALLTRIM(THIS.txt_4c_Nvl2.Value))
            THIS.txt_4c_Nvl3.Enabled = THIS.this_lPodeEditar AND loc_lNvl2Preenchida
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Nvl4", 5)
            loc_lNvl3Preenchida      = !EMPTY(ALLTRIM(THIS.txt_4c_Nvl3.Value))
            THIS.txt_4c_Nvl4.Enabled = THIS.this_lPodeEditar AND loc_lNvl3Preenchida
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - btnConfirmar.Click do legado
    *
    * Propaga cursor_4c_Locais para crTpmMvItn (SigOpLclBO.Atualizar) e
    * encerra o dialogo. O legado NAO tem guarda de QUANTIDADE - sempre libera
    * a tela depois do Scan/Update, mesmo que nenhuma linha tenha sido afetada
    * (csLocals vazio = fechar sem mudanca), e isso eh reproduzido aqui:
    * Atualizar() devolve .T. com this_nItensConfirmados = 0.
    *
    * Mas o Atualizar() migrado tem guardas que o legado nao tem (crTpmMvItn
    * ou cursor_4c_Locais fechados) e nesses caminhos ele devolve .F. deixando
    * this_cMensagemErro preenchida SEM exibir - ExibirFalha da BusinessBase eh
    * PROTECTED e so roda por dentro do Salvar()/Excluir() (regra #51), que
    * este fluxo nao usa. Ignorar o retorno fechava a tela em SILENCIO sem
    * aplicar localizacao nenhuma (regra #20: falha de gravacao nunca eh muda).
    * Entao: exibe a mensagem e NAO libera o form, para o usuario nao perder as
    * localizacoes que ja montou.
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lConfirmou

        loc_lConfirmou = .T.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lConfirmou = THIS.this_oBusinessObject.Atualizar()

            IF !loc_lConfirmou
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel confirmar a " + ;
                                 "localiza" + CHR(231) + CHR(227) + "o dos itens.", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF loc_lConfirmou
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - btnSair.Click do legado (ThisForm.Release)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSelTudoClick - SelTudo.Click do legado
    *   Replace All Marcas With 1 / Go Top / Refresh.
    *   When do legado: so age em INSERIR/ALTERAR (this_lPodeEditar).
    *==========================================================================
    PROCEDURE BtnSelTudoClick()
        IF !THIS.this_lPodeEditar
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MarcarTodosItens(1)
        ENDIF

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            GO TOP
        ENDIF
        THIS.GradeAfterRowColChange()
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * BtnApagaClick - apaga.Click do legado
    *   Replace All Marcas With 0 / Go Top / Refresh.
    *   When do legado: so age em INSERIR/ALTERAR (this_lPodeEditar).
    *==========================================================================
    PROCEDURE BtnApagaClick()
        IF !THIS.this_lPodeEditar
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MarcarTodosItens(0)
        ENDIF

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            GO TOP
        ENDIF
        THIS.GradeAfterRowColChange()
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * ConfigurarLookupsNiveis - liga os quatro lookups de nivel (LostFocus,
    * regra #47) e as cascatas de limpeza (InteractiveChange)
    *
    * O legado valida no Valid de cada caixa (ao SAIR dela). BINDEVENT em
    * "Valid" de TextBox nao eh confiavel (regra #47), entao o equivalente
    * mora em "LostFocus" - sem parametros, e com guarda de reentrancia
    * this_lEmLookup (o picker eh MODAL e tira o foco, redisparando o
    * proprio LostFocus).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLookupsNiveis()

        BINDEVENT(THIS.txt_4c_Base, "LostFocus", THIS, "BaseLostFocus")
        BINDEVENT(THIS.txt_4c_Base, "InteractiveChange", THIS, "BaseInteractiveChange")

        BINDEVENT(THIS.txt_4c_Nvl2, "LostFocus", THIS, "Nvl2LostFocus")
        BINDEVENT(THIS.txt_4c_Nvl2, "InteractiveChange", THIS, "Nvl2InteractiveChange")

        BINDEVENT(THIS.txt_4c_Nvl3, "LostFocus", THIS, "Nvl3LostFocus")
        BINDEVENT(THIS.txt_4c_Nvl3, "InteractiveChange", THIS, "Nvl3InteractiveChange")

        BINDEVENT(THIS.txt_4c_Nvl4, "LostFocus", THIS, "Nvl4LostFocus")
        BINDEVENT(THIS.txt_4c_Nvl4, "InteractiveChange", THIS, "Nvl4InteractiveChange")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BaseInteractiveChange / Nvl2InteractiveChange / Nvl3InteractiveChange /
    * Nvl4InteractiveChange - cascata de limpeza do legado
    *
    * Legado: cada nivel, ao mudar, limpa a propria descricao E todos os
    * niveis/descricoes ABAIXO dele (getBase.InteractiveChange limpa os 7
    * campos seguintes; getNvl2 limpa os 5 seguintes; getNvl3 limpa os 3
    * seguintes; getNvl4 so limpa a propria descricao).
    *==========================================================================
    PROCEDURE BaseInteractiveChange()
        THIS.txt_4c_DBase.Value = ""
        THIS.txt_4c_Nvl2.Value  = ""
        THIS.txt_4c_DNvl2.Value = ""
        THIS.txt_4c_Nvl3.Value  = ""
        THIS.txt_4c_DNvl3.Value = ""
        THIS.txt_4c_Nvl4.Value  = ""
        THIS.txt_4c_DNvl4.Value = ""
        THIS.AtualizarDependenciaNiveis()
    ENDPROC

    PROCEDURE Nvl2InteractiveChange()
        THIS.txt_4c_DNvl2.Value = ""
        THIS.txt_4c_Nvl3.Value  = ""
        THIS.txt_4c_DNvl3.Value = ""
        THIS.txt_4c_Nvl4.Value  = ""
        THIS.txt_4c_DNvl4.Value = ""
        THIS.AtualizarDependenciaNiveis()
    ENDPROC

    PROCEDURE Nvl3InteractiveChange()
        THIS.txt_4c_DNvl3.Value = ""
        THIS.txt_4c_Nvl4.Value  = ""
        THIS.txt_4c_DNvl4.Value = ""
        THIS.AtualizarDependenciaNiveis()
    ENDPROC

    PROCEDURE Nvl4InteractiveChange()
        THIS.txt_4c_DNvl4.Value = ""
    ENDPROC

    *==========================================================================
    * BaseLostFocus - getBase.Valid do legado (busca na tabela REMOTA SigLcNv1)
    *
    * Legado (fwbuscaext): tenta match EXATO por Cods sozinho; so achando NAO
    * acha eh que mostra o browse. Aqui: SQLEXEC exato primeiro (silencioso);
    * sem match, THIS.AbrirLookupCanonico (regra #36/37 - Pattern B do
    * FormBuscaAuxiliar com CREATEOBJECT de 2+ argumentos eh PROIBIDO).
    *
    * Guarda de reentrancia (regra #37/#47): o picker eh MODAL e tira o foco
    * do campo, o que redispara este proprio LostFocus. O corpo vive em
    * BaseLostFocusExec para a flag ser SEMPRE liberada, inclusive com
    * RETURN antecipado dentro do Exec.
    *==========================================================================
    PROCEDURE BaseLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.BaseLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE BaseLostFocusExec()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_lAchou

        loc_cValor = ALLTRIM(THIS.txt_4c_Base.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_lAchou = .F.

        IF TYPE("gnConnHandle") = "N"
            IF gnConnHandle > 0
                IF USED("cursor_4c_BaseExata")
                    USE IN cursor_4c_BaseExata
                ENDIF

                loc_cSQL = "SELECT Cods, Descs FROM SigLcNv1 WHERE Cods = " + EscaparSQL(loc_cValor)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BaseExata")

                IF loc_nResultado > 0 AND USED("cursor_4c_BaseExata")
                    IF RECCOUNT("cursor_4c_BaseExata") = 1
                        THIS.txt_4c_Base.Value  = ALLTRIM(cursor_4c_BaseExata.Cods)
                        THIS.txt_4c_DBase.Value = ALLTRIM(NVL(cursor_4c_BaseExata.Descs, ""))
                        loc_lAchou = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BaseExata")
                    USE IN cursor_4c_BaseExata
                ENDIF
            ENDIF
        ENDIF

        IF !loc_lAchou
            *-- Funil unico do picker (regra #37): tudo que abre
            *-- FormBuscaAuxiliar para a Base passa por AbrirBuscaBase
            THIS.AbrirBuscaBase()
        ENDIF

        THIS.txt_4c_Base.Refresh()
        THIS.txt_4c_DBase.Refresh()

        THIS.AtualizarDependenciaNiveis()
    ENDPROC

    *==========================================================================
    * Nvl2LostFocus / Nvl3LostFocus / Nvl4LostFocus - getNvl2/3/4.Valid do
    * legado (busca no cursor LOCAL da hierarquia, ja filtrado pelo pai)
    *
    * Os tres delegam a ValidarNivelExec, que reproduz o padrao comum:
    *   Select * From crSigLcNvN Where Cods = <pai> Into Cursor LocalNivel
    *   Seek <valor digitado> - achando, NAO reatribui nada (fidelidade ao
    *   legado: o Valid so toca Value/Desc no ramo "nao achou"); nao achando,
    *   abre o picker sobre o cursor LOCAL (Pattern A - DefinirCursor/Mostrar)
    *   e preenche codigo + descricao com o selecionado.
    *==========================================================================
    PROCEDURE Nvl2LostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarNivelExec(2)
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE Nvl3LostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarNivelExec(3)
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE Nvl4LostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarNivelExec(4)
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarNivelExec(par_nNivel)
        LOCAL loc_oTxt, loc_oTxtDesc, loc_oTxtPai, loc_cCursorNivel
        LOCAL loc_cValor, loc_cValorPai

        loc_oTxt     = THIS.ObterControleNivel(par_nNivel, "COD")
        loc_oTxtDesc = THIS.ObterControleNivel(par_nNivel, "DESC")
        loc_oTxtPai  = THIS.ObterControleNivel(par_nNivel, "PAI")

        IF VARTYPE(loc_oTxt) != "O" OR VARTYPE(loc_oTxtDesc) != "O" OR VARTYPE(loc_oTxtPai) != "O"
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(loc_oTxt.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cCursorNivel = THIS.ObterCursorNivel(par_nNivel)
        loc_cValorPai    = ALLTRIM(loc_oTxtPai.Value)

        THIS.this_oBusinessObject.CarregarNivelFiltrado(loc_cCursorNivel, loc_cValorPai)

        IF USED("cursor_4c_LocalNivel")
            IF !SEEK(loc_cValor, "cursor_4c_LocalNivel", "Codigo")
                *-- Nao achou -> browse de selecao, SEMPRE pelo funil unico
                *-- (regra #37). Achando, o legado NAO reatribui nada: o
                *-- getNvlN.Valid so toca Value/Desc no ramo "nao achou".
                THIS.AbrirBuscaNivel(par_nNivel)
            ENDIF
        ENDIF

        loc_oTxt.Refresh()
        loc_oTxtDesc.Refresh()

        THIS.AtualizarDependenciaNiveis()
    ENDPROC

    *==========================================================================
    * AbrirBuscaBase - FUNIL UNICO do picker da Base (SigLcNv1, tabela REMOTA)
    *
    * Padrao canonico do projeto (regra #37): todo caminho que precise exibir o
    * browse de selecao da Base passa por aqui, nunca por um CREATEOBJECT
    * espalhado pelos handlers. Transcreve o getBase.Valid legado:
    *   CreateObject('fwbuscaext', ..., 'SigLcNv1', 'crListaRemota', 'Cods',
    *                This.Value, 'Selecao', .t.)
    *   loLista.mAddColuna('Cods',  '', 'Localizacao')
    *   loLista.mAddColuna('Descs', '', 'Descricao')
    * O match exato (plAchouRegistro do legado) eh tentado ANTES, em
    * BaseLostFocusExec - aqui se chega apenas no ramo "nao achou".
    *
    * Metodo PUBLIC de proposito (regra #3): eh o funil, e tem de poder ser
    * acionado de fora do proprio LostFocus.
    *
    * Guarda de reentrancia em SAVE/RESTORE, nao set/clear (regra #47): este
    * metodo eh chamado de DENTRO de BaseLostFocusExec, onde a flag ja esta
    * ligada - um clear simples a liberaria cedo demais e o LostFocus que o
    * fechamento do picker MODAL redispara abriria um SEGUNDO dialogo.
    *==========================================================================
    PROCEDURE AbrirBuscaBase()
        LOCAL loc_cValor, loc_lEmLookupAnt, loc_oErro

        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Base.Value)

            THIS.AbrirLookupCanonico("SigLcNv1", "Cods", "Descs", ;
                "Sele" + CHR(231) + CHR(227) + "o", loc_cValor, ;
                THIS.txt_4c_Base, THIS.txt_4c_DBase)

        CATCH TO loc_oErro
            MsgErro("Erro ao abrir a sele" + CHR(231) + CHR(227) + "o da Base:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        *-- Restaurado FORA do TRY, para valer tambem quando o CATCH dispara
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *==========================================================================
    * AbrirBuscaNivel - FUNIL UNICO do picker de 2o/3o/4o nivel (cursor LOCAL)
    *
    * Transcreve o ramo "nao achou" do getNvl2/3/4.Valid legado:
    *   loBrow = Createobject('fwbuscasel', 'LocalNivel', 'Codigo',
    *                         This.Value, 'Selecao')
    *   loBrow.AddColuna('Codigo', '', 'Codigo',    .T., 'Codigo')
    *   loBrow.AddColuna('Descs',  '', 'Descricao', .F.)
    *   loBrow.Show
    *   This.Value = LocalNivel.Codigo
    *   ThisForm.getDNvlN.Value = LocalNivel.Descs
    *
    * O picker usa o Pattern A (CREATEOBJECT sem argumento + DefinirCursor +
    * Mostrar) porque a lista eh um cursor LOCAL ja filtrado pelo pai - o
    * Pattern B (CREATEOBJECT com parametros) dispararia um SELECT remoto
    * proprio e abriria o dialogo vazio.
    *
    * Refaz o filtro do pai antes de abrir (CarregarNivelFiltrado) para o
    * metodo ser auto-contido e correto tambem quando acionado de fora de
    * ValidarNivelExec; o custo eh um SELECT em cursor local.
    *==========================================================================
    PROCEDURE AbrirBuscaNivel(par_nNivel)
        LOCAL loc_oTxt, loc_oTxtDesc, loc_oTxtPai, loc_cCursorNivel, loc_cTitulo
        LOCAL loc_oBusca, loc_lEmLookupAnt, loc_lProsseguir, loc_oErro

        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        loc_lProsseguir     = .T.

        TRY
            loc_oTxt     = THIS.ObterControleNivel(par_nNivel, "COD")
            loc_oTxtDesc = THIS.ObterControleNivel(par_nNivel, "DESC")
            loc_oTxtPai  = THIS.ObterControleNivel(par_nNivel, "PAI")

            IF VARTYPE(loc_oTxt) != "O" OR VARTYPE(loc_oTxtDesc) != "O" OR VARTYPE(loc_oTxtPai) != "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cCursorNivel = THIS.ObterCursorNivel(par_nNivel)
                loc_cTitulo      = THIS.ObterTituloNivel(par_nNivel)

                THIS.this_oBusinessObject.CarregarNivelFiltrado(loc_cCursorNivel, ;
                    ALLTRIM(loc_oTxtPai.Value))

                IF USED("cursor_4c_LocalNivel")
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.DefinirCursor("cursor_4c_LocalNivel", "Codigo", "Descs", ;
                            "Sele" + CHR(231) + CHR(227) + "o - " + loc_cTitulo)
                        IF loc_oBusca.Mostrar()
                            loc_oTxt.Value     = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                            loc_oTxtDesc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao abrir a sele" + CHR(231) + CHR(227) + "o do n" + CHR(237) + "vel:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        *-- Restaurado FORA do TRY, para valer tambem quando o CATCH dispara
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *==========================================================================
    * ObterControleNivel / ObterCursorNivel / ObterTituloNivel - resolvedores
    * da hierarquia de niveis, usados por ValidarNivelExec e AbrirBuscaNivel
    *
    * Fonte UNICA do mapeamento nivel -> (campo de codigo, campo de descricao,
    * campo do nivel PAI, cursor da hierarquia, titulo do browse): duplicar o
    * DO CASE nos dois metodos deixaria os dois livres para divergir.
    *
    * par_cQual: "COD" (campo do nivel), "DESC" (descricao) ou "PAI" (campo do
    * nivel anterior, que filtra o cursor). Nivel fora de 2..4 devolve .NULL. e
    * o chamador aborta - a Base nao entra aqui: ela mora numa tabela REMOTA e
    * tem funil proprio (AbrirBuscaBase).
    *==========================================================================
    PROTECTED FUNCTION ObterControleNivel(par_nNivel, par_cQual)
        LOCAL loc_oRet, loc_cQual

        loc_oRet  = .NULL.
        loc_cQual = IIF(VARTYPE(par_cQual) = "C", UPPER(ALLTRIM(par_cQual)), "")

        DO CASE
            CASE par_nNivel = 2 AND loc_cQual = "COD"
                loc_oRet = THIS.txt_4c_Nvl2
            CASE par_nNivel = 2 AND loc_cQual = "DESC"
                loc_oRet = THIS.txt_4c_DNvl2
            CASE par_nNivel = 2 AND loc_cQual = "PAI"
                loc_oRet = THIS.txt_4c_Base
            CASE par_nNivel = 3 AND loc_cQual = "COD"
                loc_oRet = THIS.txt_4c_Nvl3
            CASE par_nNivel = 3 AND loc_cQual = "DESC"
                loc_oRet = THIS.txt_4c_DNvl3
            CASE par_nNivel = 3 AND loc_cQual = "PAI"
                loc_oRet = THIS.txt_4c_Nvl2
            CASE par_nNivel = 4 AND loc_cQual = "COD"
                loc_oRet = THIS.txt_4c_Nvl4
            CASE par_nNivel = 4 AND loc_cQual = "DESC"
                loc_oRet = THIS.txt_4c_DNvl4
            CASE par_nNivel = 4 AND loc_cQual = "PAI"
                loc_oRet = THIS.txt_4c_Nvl3
        ENDCASE

        RETURN loc_oRet
    ENDFUNC

    PROTECTED FUNCTION ObterCursorNivel(par_nNivel)
        LOCAL loc_cRet

        loc_cRet = ""

        DO CASE
            CASE par_nNivel = 2
                loc_cRet = "cursor_4c_LcNv2"
            CASE par_nNivel = 3
                loc_cRet = "cursor_4c_LcNv3"
            CASE par_nNivel = 4
                loc_cRet = "cursor_4c_LcNv4"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    PROTECTED FUNCTION ObterTituloNivel(par_nNivel)
        LOCAL loc_cRet

        loc_cRet = ""

        DO CASE
            CASE par_nNivel = 2
                loc_cRet = "Segundo N" + CHR(237) + "vel"
            CASE par_nNivel = 3
                loc_cRet = "Terceiro N" + CHR(237) + "vel"
            CASE par_nNivel = 4
                loc_cRet = "Quarto N" + CHR(237) + "vel"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    *==========================================================================
    * ConfigurarHandlersGrade - toggle do Check1/chk_4c_Marcas (regra #146/
    * Pattern #185) e AfterRowColChange (foto do produto + estado do botao
    * Localizar)
    *
    * O legado SUPRIME o toggle nativo do CheckBox (Click/MouseDown com
    * NoDefault) e alterna o valor por codigo no KeyPress/MouseUp - sem isso
    * o CheckBox renderiza mas nao responde a clique nem a Espaco/Enter.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarHandlersGrade()
        LOCAL loc_oChk
        loc_oChk = THIS.grd_4c_Dados.Column3.chk_4c_Marcas

        BINDEVENT(loc_oChk, "Click",     THIS, "ChkMarcasClick")
        BINDEVENT(loc_oChk, "MouseDown", THIS, "ChkMarcasMouseDown")
        BINDEVENT(loc_oChk, "MouseUp",   THIS, "ChkMarcasMouseUp")
        BINDEVENT(loc_oChk, "KeyPress",  THIS, "ChkMarcasKeyPress")

        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        RETURN .T.
    ENDPROC

    PROCEDURE ChkMarcasClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkMarcasKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ChkMarcasKeyPress - Check1.KeyPress do legado
    *   Enter(13)/Espaco(32): alterna Marcas da linha corrente, repinta a
    *   grade e reavalia foto/estado do botao Localizar.
    *   When do legado: so age em INSERIR/ALTERAR (this_lPodeEditar).
    *==========================================================================
    PROCEDURE ChkMarcasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !THIS.this_lPodeEditar
            RETURN
        ENDIF

        IF !INLIST(par_nKeyCode, 13, 32)
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.AlternarMarcaItem()
        ENDIF

        THIS.GradeAfterRowColChange()
        THIS.grd_4c_Dados.Refresh()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - grdItens.AfterRowColChange do legado
    *
    * (a) foto do produto da linha corrente (SigOpLclBO.BuscarFotoProduto -
    *     decodifica o base64 de SigCdPro.FigJpgs uma unica vez - regra do
    *     STRCONV duplo);
    * (b) habilita btnLocalizar so quando a linha corrente tem Marcas <> 0 E
    *     o modo permite editar - o legado testa os dois juntos.
    *
    * par_nColIndex nao eh usado (o legado tambem nao usa - a chamada do
    * Check1.KeyPress eh This.parent.parent.AfterRowColChange, sem argumento).
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_cArquivo, loc_lHabilitaLocalizar

        loc_lHabilitaLocalizar = .F.

        IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND !EOF("cursor_4c_Itens")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cArquivo = THIS.this_oBusinessObject.BuscarFotoProduto(ALLTRIM(cursor_4c_Itens.Cpros))
            ELSE
                loc_cArquivo = ""
            ENDIF

            IF !EMPTY(loc_cArquivo)
                THIS.img_4c_ImgJpg.Visible = .F.
                THIS.img_4c_ImgJpg.Picture = ""
                THIS.img_4c_ImgJpg.Picture = loc_cArquivo
                THIS.img_4c_ImgJpg.Visible = .T.
            ELSE
                THIS.img_4c_ImgJpg.Visible = .F.
                THIS.img_4c_ImgJpg.Picture = ""
            ENDIF

            loc_lHabilitaLocalizar = (cursor_4c_Itens.Marcas <> 0) AND THIS.this_lPodeEditar
        ELSE
            THIS.img_4c_ImgJpg.Visible = .F.
            THIS.img_4c_ImgJpg.Picture = ""
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_CmdAcoes", 5)
            THIS.obj_4c_CmdAcoes.Buttons(1).Enabled = loc_lHabilitaLocalizar
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnLocalizarClick - btnLocalizar.Click do legado
    *
    * Grava (SigOpLclBO.Inserir) a localizacao montada a partir dos quatro
    * campos de nivel para todo item marcado, remove essas linhas da grade e
    * limpa os campos de nivel - exatamente o fluxo do Click legado.
    *
    * O guard de modo eh o When do botao legado (InList(pcEscolha,'INSERIR',
    * 'ALTERAR')); o botao ja nasce/fica Enabled de acordo (ConfigurarAcoes
    * Localizacao + GradeAfterRowColChange), o IF aqui eh so defensivo -
    * mesmo padrao de BtnSelTudoClick/BtnApagaClick.
    *==========================================================================
    PROCEDURE BtnLocalizarClick()
        IF !THIS.this_lPodeEditar
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- lcLoc1..lcLoc4 do Click legado: le os campos da tela para o BO
        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarNiveis(.T.)
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Inserir()
            *-- Legado: ThisForm.getBase/getNvl2/getNvl3/getNvl4/getDBase/
            *-- getDNvl2/getDNvl3/getDNvl4.Value = [] no fim do Click.
            *-- Zera no BO e ESPELHA na tela, para os oito campos terem uma
            *-- fonte unica (LimparNiveis) em vez de oito atribuicoes soltas.
            THIS.this_oBusinessObject.LimparNiveis()
            THIS.BOParaForm()

            THIS.AtualizarDependenciaNiveis()

            IF USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                GO TOP
            ENDIF
            THIS.grd_4c_Dados.Column1.SetFocus()
            THIS.grd_4c_Dados.Refresh()
            THIS.GradeAfterRowColChange()
        ELSE
            *-- Inserir() recusa em silencio (modo, cursores fechados, nenhum
            *-- item marcado): deixa this_cMensagemErro preenchida e NAO exibe,
            *-- porque ExibirFalha da BusinessBase eh PROTECTED e so roda por
            *-- dentro do Salvar() (regra #51). Sem este ELSE o usuario clicava
            *-- Localizar e NADA acontecia (regra #20).
            IF !THIS.this_oBusinessObject.this_lErroExibido
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel atribuir a " + ;
                             "localiza" + CHR(231) + CHR(227) + "o aos itens selecionados.", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnLimparClick - btnLimpar.Click do legado
    *
    * O legado tem o REPLACE de Marcas/Locals COMENTADO (**Replace all...) -
    * so refaz o bind da grade (MontaGrade) e limpa os oito campos de nivel.
    * Transcrito literalmente (regra #17): "Limpar Selecao" NAO desmarca os
    * itens - para isso existe o botao "apaga" ao lado da grade.
    *==========================================================================
    PROCEDURE BtnLimparClick()
        IF !THIS.this_lPodeEditar
            RETURN
        ENDIF

        THIS.CarregarLista()

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            GO TOP
        ENDIF

        *-- Os oito campos do legado, pela mesma fonte unica do Localizar
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LimparNiveis()
        ENDIF
        THIS.BOParaForm()

        THIS.AtualizarDependenciaNiveis()
    ENDPROC

    *==========================================================================
    * FormParaBO - os oito campos da localizacao -> propriedades do BO
    *
    * Nao eh convencao importada de form CRUD: o bloco EXISTE no legado, no
    * inicio do btnLocalizar.Click, so sem esse nome -
    *     lcLoc1 = ThisForm.getBase.Value
    *     lcLoc2 = ThisForm.getNvl2.Value
    *     lcLoc3 = ThisForm.getNvl3.Value
    *     lcLoc4 = ThisForm.getNvl4.Value
    * que o Click concatena em lcLocaliza. No migrado quem concatena eh
    * SigOpLclBO.MontarLocalizacao(), a partir destas properties, e quem
    * valida eh ValidarNiveis() - os dois leem o BO, nunca a tela, entao o
    * ponto UNICO de travessia tela -> BO eh este metodo.
    *
    * As quatro DESCRICOES vao junto: o BO declara this_cDescBase/
    * this_cDescNvl2..4 e sem este metodo ninguem as alimentava (so
    * LimparNiveis as zerava), o que deixava BOParaForm sem o que espelhar.
    *
    * PROTECTED EXPLICITO: FormBase declara FormParaBO como PROTECTED e o
    * VFP9 nao permite ALARGAR o escopo herdado - omitir o modificador NAO
    * tornaria o metodo publico, so esconderia o fato. Chamada sempre por
    * THIS. de dentro da classe (regra #8).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            WITH THIS.this_oBusinessObject
                .this_cBase     = ALLTRIM(THIS.txt_4c_Base.Value)
                .this_cDescBase = ALLTRIM(THIS.txt_4c_DBase.Value)

                .this_cNvl2     = ALLTRIM(THIS.txt_4c_Nvl2.Value)
                .this_cDescNvl2 = ALLTRIM(THIS.txt_4c_DNvl2.Value)

                .this_cNvl3     = ALLTRIM(THIS.txt_4c_Nvl3.Value)
                .this_cDescNvl3 = ALLTRIM(THIS.txt_4c_DNvl3.Value)

                .this_cNvl4     = ALLTRIM(THIS.txt_4c_Nvl4.Value)
                .this_cDescNvl4 = ALLTRIM(THIS.txt_4c_DNvl4.Value)
            ENDWITH

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - propriedades do BO -> os oito campos da localizacao
    *
    * Sentido inverso de FormParaBO, e tambem com referente no legado: o
    * ramo "achou" de cada Valid escreve o par codigo/descricao de volta na
    * tela (This.Value = crListaRemota.Cods / ThisForm.getDBase.Value =
    * crListaRemota.Descs, e o equivalente com LocalNivel nos niveis 2..4),
    * e o btnLimpar.Click / o fim do btnLocalizar.Click zeram os oito.
    *
    * Os lookups continuam escrevendo direto nos TextBox (transcricao fiel
    * do Valid legado, que mexe no controle e nao numa property); este
    * metodo eh o ponto de RECARGA da tela a partir do estado do BO, usado
    * pelos dois caminhos que limpam a selecao.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO (escopo herdado
    * de FormBase, que o VFP9 nao deixa alargar).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            WITH THIS.this_oBusinessObject
                THIS.txt_4c_Base.Value  = ALLTRIM(.this_cBase)
                THIS.txt_4c_DBase.Value = ALLTRIM(.this_cDescBase)

                THIS.txt_4c_Nvl2.Value  = ALLTRIM(.this_cNvl2)
                THIS.txt_4c_DNvl2.Value = ALLTRIM(.this_cDescNvl2)

                THIS.txt_4c_Nvl3.Value  = ALLTRIM(.this_cNvl3)
                THIS.txt_4c_DNvl3.Value = ALLTRIM(.this_cDescNvl3)

                THIS.txt_4c_Nvl4.Value  = ALLTRIM(.this_cNvl4)
                THIS.txt_4c_DNvl4.Value = ALLTRIM(.this_cDescNvl4)
            ENDWITH

            THIS.txt_4c_Base.Refresh()
            THIS.txt_4c_DBase.Refresh()
            THIS.txt_4c_Nvl2.Refresh()
            THIS.txt_4c_DNvl2.Refresh()
            THIS.txt_4c_Nvl3.Refresh()
            THIS.txt_4c_DNvl3.Refresh()
            THIS.txt_4c_Nvl4.Refresh()
            THIS.txt_4c_DNvl4.Refresh()

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controle com Visible = .F.
    *
    * Percorre Controls recursivamente e tambem as Pages de PageFrame (este
    * form nao tem PageFrame, mas o metodo segue o padrao do projeto).
    *
    * A lista de EXCECAO abaixo sao os controles que o SCX legado declara
    * Visible = .F. de proposito - forcar .T. neles expoe area que o legado
    * mantem oculta:
    *   ImgJpg (img_4c_ImgJpg) - foto do produto, so aparece quando a linha
    *   corrente da grade tem imagem gravada em SigCdPro.FigJpgs
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oObjeto, loc_cNome

        IF VARTYPE(par_oContainer) != "O"
            RETURN .F.
        ENDIF

        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN .F.
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(ALLTRIM(loc_oObjeto.Name))

                *-- Controles que nascem ocultos no legado continuam ocultos
                IF INLIST(loc_cNome, "IMG_4C_IMGJPG")
                    *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- PageFrame: percorrer as Pages (que nao entram em Controls)
                IF UPPER(loc_oObjeto.BaseClass) == "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Containers em geral: recursao pelos filhos
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - libera o BO (que fecha os proprios cursores de trabalho)
    *
    * Legado (Release): Use In crItensLoc / Use In csLocals - no migrado esses
    * cursores pertencem ao BO e sao fechados pelo Destroy dele.
    * crTpmMvItn NAO eh fechado aqui: pertence ao form CHAMADOR.
    *
    * DODEFAULT() eh obrigatorio e fica por ULTIMO: FormBase.Destroy refaz os
    * popups do menu principal, que o fechamento de form modal corrompe.
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.this_oConexao = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpLclBO.prg):
*====================================================================
* SigOpLclBO.prg
*
* Business Object para Selecao de Localizacao de Estoque
* (atribuicao da localizacao fisica - Base/Nivel2/Nivel3/Nivel4 - aos
* itens marcados numa grade de movimentacao fornecida pelo form
* chamador, via cursor crTpmMvItn na data session compartilhada)
*
* Tabelas: SigLcNv1 (Base), SigLcNv2, SigLcNv3, SigLcNv4 (hierarquia
* de localizacao - cada nivel 2/3/4 guarda em Nivel um XML com os
* codigos validos do nivel anterior, expandido em cursor pelo
* equivalente a ReverterXML do legado)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpLclBO AS BusinessBase

    *-- Contexto recebido do form chamador (equivalente a pcEscolha/pcOrigem
    *-- do Init legado) - define o modo da tela (INSERIR/ALTERAR/outro) e
    *-- qual coluna de crTpmMvItn recebe a localizacao (Localos quando
    *-- this_cOrigem = 'ORIGEM', Locals nos demais casos)
    this_cEscolha    = ""   && pcEscolha legado - modo da tela chamadora
    this_cOrigem     = ""   && pcOrigem legado - 'ORIGEM' ou outro

    *-- Nivel 1 (Base) - SigLcNv1.cods char(2) / descs char(20)
    this_cBase       = ""
    this_cDescBase   = ""

    *-- Nivel 2 - SigLcNv2.cods char(2) / descs char(20)
    this_cNvl2       = ""
    this_cDescNvl2   = ""

    *-- Nivel 3 - SigLcNv3.cods char(2) / descs char(20)
    this_cNvl3       = ""
    this_cDescNvl3   = ""

    *-- Nivel 4 - SigLcNv4.cods char(4) / descs char(20)
    this_cNvl4       = ""
    this_cDescNvl4   = ""

    *-- Localizacao composta (Base+Nvl2+Nvl3+Nvl4), igual ao lcLocaliza
    *-- do btnLocalizar.Click legado - gravada em csLocals.Locals e
    *-- depois propagada para crTpmMvItn.Locals/Localos
    this_cLocalizacaoMontada = ""

    *-- .T. quando ha pelo menos uma linha de crItensLoc com Marcas <> 0
    *-- (equivalente ao guard do btnLocalizar.When/do When do Check1)
    this_lTemItensSelecionados = .F.

    *-- ITEM corrente da grade (linha de cursor_4c_Itens, que espelha
    *-- crTpmMvItn). Alimentadas por CarregarDoCursor e usadas por
    *-- ObterChavePrimaria/RegistrarAuditoria.
    *-- cItens eh NUMERIC: SigMvItn.cItens eh numeric(10,0)
    this_nCItens     = 0
    this_cCpros      = ""    && SigMvItn.cpros   char(14)
    this_cDpros      = ""    && SigMvItn.dpros   char(65)
    this_cLocalItem  = ""    && SigMvItn.locals / localos char(10)
    this_cCategoria  = ""    && SigCdPro.categoria char(6)
    this_nMarcas     = 0     && marca de selecao da grade (0/1)

    *-- Quantidade de itens efetivamente gravados pelo ultimo Inserir()
    *-- (linhas acrescentadas a cursor_4c_Locais) e pelo ultimo Atualizar()
    *-- (linhas propagadas para crTpmMvItn). Usadas pelo form para decidir
    *-- se houve o que gravar - NUNCA reportar sucesso sem gravacao.
    this_nItensGravados    = 0
    this_nItensConfirmados = 0

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigLcNv1"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * FecharCursor - fecha alias com guarda de BUFFERING (regra #52)
    *
    * TABLEREVERT sem buffering NAO eh no-op: estoura erro 1586 "Function
    * requires row or table buffering mode". Cursor nascido de CREATE
    * CURSOR / SELECT ... INTO CURSOR vem com Buffering = 1, e USE IN
    * fecha o alias mesmo com buffer sujo - por isso o TABLEREVERT so
    * acontece quando ha buffering de verdade.
    *====================================================================
    PROTECTED PROCEDURE FecharCursor(par_cAlias)
        IF VARTYPE(par_cAlias) = "C" AND !EMPTY(ALLTRIM(par_cAlias))
            IF USED(par_cAlias)
                IF CURSORGETPROP("Buffering", par_cAlias) > 1
                    TABLEREVERT(.T., par_cAlias)
                ENDIF
                USE IN (par_cAlias)
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * MarcaComoNumero / ComoTexto - leitura TIPO-SEGURA de coluna de XML
    *
    * O cursor que sai do fXmlToCursor tem os tipos ditados pelo XML, e o
    * XMLTOCURSOR nativo INFERE tipo quando o XML nao traz schema XSD.
    * MEDIDO no VFP9 em 2026-11-08 (automation\medir_xml_schema.prg), com o
    * mesmo cursor de origem (Cods C(2)="01", Marcas N(1)=1):
    *
    *   XML COM schema -> Marcas=N, Cods=C "01", Codigo=C "0001"   (fiel)
    *   XML SEM schema -> Marcas=L, Cods=N 1,    Codigo=N 1        (estragado)
    *
    * O legado funciona com "Scan For CrAux.Marcas <> 0" e grava CrAux.Cods
    * em coluna char, logo o XML gravado em producao TRAZ schema. Mas um
    * registro sem schema faria "Marcas <> 0" estourar
    * "Operator/operand type mismatch" e abortar a expansao INTEIRA - os
    * cursores de nivel ficariam vazios e os lookups da tela nao mostrariam
    * nada, sem erro visivel. Estes dois helpers absorvem essa variacao de
    * tipo; a semantica para o XML normal (com schema) eh identica.
    *====================================================================
    PROTECTED PROCEDURE MarcaComoNumero(par_uValor)
        LOCAL loc_nMarca, loc_cTipo

        loc_nMarca = 0
        loc_cTipo  = VARTYPE(par_uValor)

        DO CASE
            CASE ISNULL(par_uValor)
                loc_nMarca = 0
            CASE loc_cTipo = "N"
                loc_nMarca = IIF(par_uValor <> 0, 1, 0)
            CASE loc_cTipo = "L"
                loc_nMarca = IIF(par_uValor, 1, 0)
            CASE loc_cTipo = "C"
                *-- "1"/"S"/"T"/".T." contam como marcado
                loc_nMarca = IIF(INLIST(UPPER(LEFT(ALLTRIM(par_uValor) + " ", 1)), "1", "S", "T"), 1, 0)
            OTHERWISE
                loc_nMarca = 0
        ENDCASE

        RETURN loc_nMarca
    ENDPROC

    PROTECTED PROCEDURE ComoTexto(par_uValor)
        LOCAL loc_cTexto, loc_cTipo

        loc_cTexto = ""
        loc_cTipo  = VARTYPE(par_uValor)

        DO CASE
            CASE ISNULL(par_uValor)
                loc_cTexto = ""
            CASE loc_cTipo = "C"
                loc_cTexto = par_uValor
            CASE loc_cTipo = "N"
                loc_cTexto = ALLTRIM(TRANSFORM(par_uValor))
            CASE loc_cTipo = "L"
                loc_cTexto = IIF(par_uValor, "1", "0")
            OTHERWISE
                loc_cTexto = ""
        ENDCASE

        RETURN loc_cTexto
    ENDPROC

    *====================================================================
    * ObterPrefixoTemp - prefixo dos arquivos temporarios de imagem
    *
    * Legado: Sys(2023) + [\] + goSistema.Sys2015Tmp + Sys(2015) + [.jpg]
    * A property Sys2015Tmp foi acrescentada ao go_4c_Sistema no config.prg;
    * o PEMSTATUS aqui eh so para nao estourar "Property SYS2015TMP is not
    * found" num ambiente com config antigo em memoria (medido no VFP9:
    * leitura de property ausente em objeto Empty eh erro, nao .NULL.).
    *====================================================================
    PROTECTED PROCEDURE ObterPrefixoTemp()
        LOCAL loc_cPrefixo
        loc_cPrefixo = "4c_tmp_"
        IF TYPE("go_4c_Sistema") = "O"
            IF PEMSTATUS(go_4c_Sistema, "Sys2015Tmp", 5)
                loc_cPrefixo = ALLTRIM(NVL(go_4c_Sistema.Sys2015Tmp, "4c_tmp_"))
            ENDIF
        ENDIF
        RETURN loc_cPrefixo
    ENDPROC

    *====================================================================
    * CriarCursorLocalizacoes - cria o cursor das atribuicoes ja feitas na
    *                           tela e ainda nao confirmadas
    *
    * Equivale ao csLocals do Init legado:
    *     Create Cursor csLocals(cItens n(4), Cpros c(14), Locals c(10))
    *
    * DESVIO DELIBERADO: cItens vai como N(10,0) e nao N(4). A coluna de
    * origem eh SigMvItn.cItens numeric(10,0); com N(4) todo item acima de
    * 9999 estouraria no APPEND. Nao eh formula de negocio (regra #17), eh
    * largura de buffer - e casar com o schema eh a regra da casa.
    * Cpros c(14) e Locals c(10) batem com SigMvItn.cpros / .locals.
    *====================================================================
    PROCEDURE CriarCursorLocalizacoes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.FecharCursor("cursor_4c_Locais")
            CREATE CURSOR cursor_4c_Locais (cItens N(10, 0), Cpros C(14), Locals C(10))
            loc_lSucesso = USED("cursor_4c_Locais")
        CATCH TO loc_oErro
            MsgErro("Erro ao criar o cursor de localiza" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarItens - monta o cursor da grade a partir de crTpmMvItn
    *
    * Legado (Init):
    *   Select 0 as Marcas, Cpros, Dpros, cItens,
    *          Iif(ThisForm.pcOrigem='ORIGEM', LocalOs, Locals) as Locals,
    *          Space(10) as Categoria
    *     from crTpmMvItn Where Not Empty(Cpros) Into Cursor crItensLoc ReadWrite
    *   + por item: Select Categoria From SigCdPro where Cpros = '<item>'
    *
    * crTpmMvItn eh o cursor do form CHAMADOR (contrato externo) - conserva
    * o nome do legado de proposito; os demais seguem o PILAR 3.
    *
    * Os TRES tags (cItens / Cpros / Categoria) sao criados aqui, um por
    * coluna, para que OrdenarItens possa fazer SET ORDER TO TAG <coluna>.
    *====================================================================
    PROCEDURE CarregarItens(par_cOrigem)
        LOCAL loc_lSucesso, loc_cColLocal, loc_cSQL, loc_nResultado, loc_lProsseguir

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        IF PCOUNT() >= 1 AND VARTYPE(par_cOrigem) = "C"
            THIS.this_cOrigem = par_cOrigem
        ENDIF

        TRY
            IF !USED("crTpmMvItn")
                THIS.this_cMensagemErro = "O cursor de itens do movimento (crTpmMvItn) n" + ;
                                          CHR(227) + "o est" + CHR(225) + " aberto."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- Legado: a coluna de origem muda conforme pcOrigem
                loc_cColLocal = IIF(ALLTRIM(UPPER(NVL(THIS.this_cOrigem, ""))) == "ORIGEM", ;
                                    "LocalOs", "Locals")

                THIS.FecharCursor("cursor_4c_Itens")

                SELECT 0 AS Marcas, Cpros, Dpros, cItens, ;
                       &loc_cColLocal. AS Locals, SPACE(10) AS Categoria ;
                    FROM crTpmMvItn ;
                    WHERE !EMPTY(Cpros) ;
                    INTO CURSOR cursor_4c_Itens READWRITE

                *-- Categoria de cada produto (SigCdPro.categoria char(6)).
                *-- Uma consulta por item, como o legado - a grade eh pequena
                *-- e assim o resultado nao divergir do original.
                IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 ;
                        AND TYPE("gnConnHandle") = "N"
                    IF gnConnHandle > 0
                        SELECT cursor_4c_Itens
                        GO TOP
                        SCAN
                            loc_cSQL = "SELECT Categoria FROM SigCdPro WHERE Cpros = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Itens.Cpros))

                            THIS.FecharCursor("cursor_4c_Prod")
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prod")

                            IF loc_nResultado > 0 AND USED("cursor_4c_Prod")
                                IF RECCOUNT("cursor_4c_Prod") > 0
                                    REPLACE Categoria ;
                                        WITH TratarNulo(cursor_4c_Prod.Categoria, "") ;
                                        IN cursor_4c_Itens
                                ENDIF
                            ENDIF

                            *-- volta para o alias do SCAN (o SQLEXEC trocou a
                            *-- area de trabalho corrente)
                            SELECT cursor_4c_Itens
                        ENDSCAN
                        THIS.FecharCursor("cursor_4c_Prod")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_Itens")
                    SELECT cursor_4c_Itens
                    INDEX ON cItens    TAG cItens
                    INDEX ON Cpros     TAG Cpros
                    INDEX ON Categoria TAG Categoria
                    SET ORDER TO TAG cItens
                    GO TOP
                    loc_lSucesso = .T.
                ENDIF

                THIS.ContarItensSelecionados()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar os itens do movimento:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarNiveis - le a hierarquia de localizacao e expande o XML
    *
    * Legado (Init): quatro Select * From SigLcNv1..4 para csNivel1..4,
    * quatro cursores "vazios com estrutura" crSigLcNv1..4 (com a coluna
    * extra Codigo) e tres chamadas ReverterXML.
    *
    * crSigLcNv1 nasce vazio e NUNCA eh populado - o nivel 1 nao tem pai, e
    * a busca da Base vai direto na tabela remota SigLcNv1. Fica criado por
    * fidelidade ao legado.
    *====================================================================
    PROCEDURE CarregarNiveis()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_nI, loc_nResultado
        LOCAL loc_cTabela, loc_cDestino

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            IF TYPE("gnConnHandle") != "N"
                loc_lProsseguir = .F.
            ELSE
                IF gnConnHandle <= 0
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF !loc_lProsseguir
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                                          CHR(227) + "o dispon" + CHR(237) + "vel."
            ENDIF

            IF loc_lProsseguir
                *-- SQLEXEC recebe o nome do cursor como STRING: nao precisa macro
                FOR loc_nI = 1 TO 4
                    loc_cTabela  = "SigLcNv" + TRANSFORM(loc_nI)
                    loc_cDestino = "cursor_4c_Nivel" + TRANSFORM(loc_nI)

                    THIS.FecharCursor(loc_cDestino)
                    loc_nResultado = SQLEXEC(gnConnHandle, "SELECT * FROM " + loc_cTabela, loc_cDestino)

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao ler " + loc_cTabela + ":" + CHR(13) + ;
                                                  CapturarErroSQL()
                        loc_lProsseguir = .F.
                        EXIT
                    ENDIF
                ENDFOR
            ENDIF

            IF loc_lProsseguir
                *-- Cursores expandidos: estrutura do nivel + a coluna Codigo.
                *-- SPACE(4) cobre o maior codigo da hierarquia (SigLcNv4.cods
                *-- eh char(4); os niveis 1 a 3 sao char(2)).
                THIS.FecharCursor("cursor_4c_LcNv1")
                THIS.FecharCursor("cursor_4c_LcNv2")
                THIS.FecharCursor("cursor_4c_LcNv3")
                THIS.FecharCursor("cursor_4c_LcNv4")

                SELECT *, SPACE(4) AS Codigo FROM cursor_4c_Nivel1 WHERE 1 = 0 ;
                    INTO CURSOR cursor_4c_LcNv1 READWRITE
                SELECT *, SPACE(4) AS Codigo FROM cursor_4c_Nivel2 WHERE 1 = 0 ;
                    INTO CURSOR cursor_4c_LcNv2 READWRITE
                SELECT *, SPACE(4) AS Codigo FROM cursor_4c_Nivel3 WHERE 1 = 0 ;
                    INTO CURSOR cursor_4c_LcNv3 READWRITE
                SELECT *, SPACE(4) AS Codigo FROM cursor_4c_Nivel4 WHERE 1 = 0 ;
                    INTO CURSOR cursor_4c_LcNv4 READWRITE

                *-- Cada nivel N guarda em <nivel> um XML com os codigos do
                *-- nivel N-1 que o habilitam
                THIS.ReverterXML("cursor_4c_Nivel2", "cursor_4c_Nivel1", "cursor_4c_LcNv2")
                THIS.ReverterXML("cursor_4c_Nivel3", "cursor_4c_Nivel2", "cursor_4c_LcNv3")
                THIS.ReverterXML("cursor_4c_Nivel4", "cursor_4c_Nivel3", "cursor_4c_LcNv4")

                loc_lSucesso = USED("cursor_4c_LcNv2") AND USED("cursor_4c_LcNv3") ;
                               AND USED("cursor_4c_LcNv4")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar os n" + CHR(237) + "veis de localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ReverterXML - expande o XML da coluna <nivel> em linhas
    *
    * Transcrito do PROCEDURE reverterxml legado. Para cada linha do nivel,
    * o XML de <nivel> eh carregado em cursor_4c_Aux e as entradas marcadas
    * (Marcas <> 0) viram linhas no cursor de destino, onde:
    *     Cods   = codigo do nivel ANTERIOR (o pai que habilita)
    *     Codigo = codigo do PROPRIO nivel
    *     Descs  = descricao do PROPRIO nivel
    *
    * par_cNivAnt existe so para reposicionar aquele cursor no fim, como no
    * legado.
    *====================================================================
    PROCEDURE ReverterXML(par_cCursor, par_cNivAnt, par_cCurDest)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_nOldSel, loc_cXML
        LOCAL loc_cCodAux, loc_cChaveAux

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_nOldSel     = SELECT()
        loc_cCodAux     = ""
        loc_cChaveAux   = ""

        TRY
            IF VARTYPE(par_cCursor) != "C" OR VARTYPE(par_cCurDest) != "C"
                loc_lProsseguir = .F.
            ELSE
                IF !USED(par_cCursor) OR !USED(par_cCurDest)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF !loc_lProsseguir
                THIS.this_cMensagemErro = "Cursores de n" + CHR(237) + "vel n" + CHR(227) + ;
                                          "o dispon" + CHR(237) + "veis para expandir o XML."
            ENDIF

            IF loc_lProsseguir
                THIS.FecharCursor("cursor_4c_Aux")

                SELECT cidchaves, Cods, Descs, 0 AS Marcas, SPACE(4) AS Codigo ;
                    FROM &par_cCursor. ;
                    WHERE 1 = 0 ;
                    INTO CURSOR cursor_4c_Aux READWRITE

                SELECT &par_cCursor.
                GO TOP

                SCAN
                    loc_cXML = NVL(&par_cCursor..Nivel, "")
                    ZAP IN cursor_4c_Aux

                    IF !EMPTY(loc_cXML)
                        *-- fXmlToCursor: wrapper em utils\fxmltocursor.prg
                        *-- (funcao global do legado Fortyus, regra #27)
                        = fXmlToCursor(loc_cXML, "cursor_4c_Aux", .F.)

                        IF USED("cursor_4c_Aux")
                            SELECT cursor_4c_Aux
                            *-- Legado: Scan For CrAux.Marcas <> 0
                            *-- O teste vai pelo MarcaComoNumero para nao
                            *-- estourar quando o XML nao trouxe schema e o
                            *-- Marcas chegou como Logico.
                            SCAN
                                IF THIS.MarcaComoNumero(cursor_4c_Aux.Marcas) <> 0
                                    loc_cCodAux   = THIS.ComoTexto(cursor_4c_Aux.Cods)
                                    loc_cChaveAux = THIS.ComoTexto(cursor_4c_Aux.CidChaves)

                                    SELECT &par_cCurDest.
                                    APPEND BLANK
                                    REPLACE Cods      WITH loc_cCodAux, ;
                                            Descs     WITH &par_cCursor..Descs, ;
                                            CidChaves WITH loc_cChaveAux, ;
                                            Codigo    WITH &par_cCursor..Cods

                                    SELECT cursor_4c_Aux
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDIF

                    *-- volta para o alias do SCAN externo
                    SELECT &par_cCursor.
                ENDSCAN

                IF VARTYPE(par_cNivAnt) = "C"
                    IF USED(par_cNivAnt)
                        SELECT &par_cNivAnt.
                        GO TOP
                    ENDIF
                ENDIF

                THIS.FecharCursor("cursor_4c_Aux")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao expandir a hierarquia de localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarNivelFiltrado - filhos de um nivel, para o lookup do form
    *
    * Legado (getNvl2/3/4.Valid):
    *   Select * From CrSigLcNvN Where Cods = lcNivel Into Cursor LocalNivel Readwrite
    *   Select LocalNivel / Index On Codigo Tag Codigo
    *
    * Deixa cursor_4c_LocalNivel aberto e indexado por Codigo - o form faz o
    * SEEK e, nao achando, abre o browse de selecao.
    *
    * MEDIDO no VFP9 (2026-11-08): com SET EXACT ON (que o config.prg liga),
    * "Cods = '01'" CASA coluna char(4) contendo "01  " - os brancos a
    * direita sao ignorados. Por isso o WHERE do legado pode ser transcrito
    * como esta, sem ALLTRIM na coluna (que estragaria o Rushmore).
    *====================================================================
    PROCEDURE CarregarNivelFiltrado(par_cCursorNivel, par_cCodigoPai)
        LOCAL loc_nQtd, loc_cFiltro, loc_lProsseguir

        loc_nQtd        = 0
        loc_lProsseguir = .T.

        TRY
            IF VARTYPE(par_cCursorNivel) != "C"
                loc_lProsseguir = .F.
            ELSE
                IF !USED(par_cCursorNivel)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cFiltro = IIF(VARTYPE(par_cCodigoPai) = "C", ALLTRIM(par_cCodigoPai), "")

                THIS.FecharCursor("cursor_4c_LocalNivel")

                SELECT * FROM &par_cCursorNivel. ;
                    WHERE Cods = m.loc_cFiltro ;
                    INTO CURSOR cursor_4c_LocalNivel READWRITE

                IF USED("cursor_4c_LocalNivel")
                    SELECT cursor_4c_LocalNivel
                    INDEX ON Codigo TAG Codigo
                    GO TOP
                    loc_nQtd = RECCOUNT("cursor_4c_LocalNivel")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao filtrar o n" + CHR(237) + "vel de localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_nQtd = 0
        ENDTRY

        RETURN loc_nQtd
    ENDPROC

    *====================================================================
    * ValidarNiveis - transcricao do PROCEDURE validacao legado
    *
    * O legado exige o nivel seguinte SOMENTE quando aquele nivel tem
    * filhos para o pai escolhido - e a condicao que CERCA cada checagem
    * faz parte da regra (regra #21b), por isso vai transcrita inteira:
    *   nivel 2: Reccount(crSigLcNv2) > 0 e Nvl2 vazio
    *   nivel 3: Reccount(crSigLcNv3) > 0 e Nvl3 vazio e Nvl2 PREENCHIDO
    *   nivel 4: Reccount(crSigLcNv4) > 0 e Nvl4 vazio e Nvl3 PREENCHIDO
    *
    * par_lExibirMensagem = .T. (default) reproduz o MessageBox do legado;
    * .F. so preenche this_cMensagemErro, para o caminho do Salvar da
    * BusinessBase exibir uma unica vez (regra #20).
    *====================================================================
    PROCEDURE ValidarNiveis(par_lExibirMensagem)
        LOCAL loc_lValido, loc_lExibir, loc_nOldSel, loc_cMsg

        loc_lValido = .T.
        loc_cMsg    = ""
        loc_nOldSel = SELECT()
        loc_lExibir = IIF(PCOUNT() >= 1 AND VARTYPE(par_lExibirMensagem) = "L", ;
                          par_lExibirMensagem, .T.)

        *-- Base eh sempre obrigatoria
        IF EMPTY(ALLTRIM(NVL(THIS.this_cBase, "")))
            loc_cMsg    = "Informar a Base da Localiza" + CHR(231) + CHR(227) + "o."
            loc_lValido = .F.
        ENDIF

        *-- Segundo nivel
        IF loc_lValido AND USED("cursor_4c_LcNv2") ;
                AND EMPTY(ALLTRIM(NVL(THIS.this_cNvl2, "")))
            IF RECCOUNT("cursor_4c_LcNv2") > 0
                IF THIS.CarregarNivelFiltrado("cursor_4c_LcNv2", ALLTRIM(NVL(THIS.this_cBase, ""))) > 0
                    loc_cMsg    = "Informar o Segundo N" + CHR(237) + "vel da Localiza" + ;
                                  CHR(231) + CHR(227) + "o."
                    loc_lValido = .F.
                ENDIF
            ENDIF
        ENDIF

        *-- Terceiro nivel (so cobrado quando o segundo foi informado)
        IF loc_lValido AND USED("cursor_4c_LcNv3") ;
                AND EMPTY(ALLTRIM(NVL(THIS.this_cNvl3, ""))) ;
                AND !EMPTY(ALLTRIM(NVL(THIS.this_cNvl2, "")))
            IF RECCOUNT("cursor_4c_LcNv3") > 0
                IF THIS.CarregarNivelFiltrado("cursor_4c_LcNv3", ALLTRIM(NVL(THIS.this_cNvl2, ""))) > 0
                    loc_cMsg    = "Informar o Terceiro N" + CHR(237) + "vel da Localiza" + ;
                                  CHR(231) + CHR(227) + "o."
                    loc_lValido = .F.
                ENDIF
            ENDIF
        ENDIF

        *-- Quarto nivel (so cobrado quando o terceiro foi informado)
        IF loc_lValido AND USED("cursor_4c_LcNv4") ;
                AND EMPTY(ALLTRIM(NVL(THIS.this_cNvl4, ""))) ;
                AND !EMPTY(ALLTRIM(NVL(THIS.this_cNvl3, "")))
            IF RECCOUNT("cursor_4c_LcNv4") > 0
                IF THIS.CarregarNivelFiltrado("cursor_4c_LcNv4", ALLTRIM(NVL(THIS.this_cNvl3, ""))) > 0
                    loc_cMsg    = "Informar o Quarto N" + CHR(237) + "vel da Localiza" + ;
                                  CHR(231) + CHR(227) + "o."
                    loc_lValido = .F.
                ENDIF
            ENDIF
        ENDIF

        THIS.this_cMensagemErro = loc_cMsg

        IF !loc_lValido AND loc_lExibir
            MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * MontarLocalizacao - concatena os quatro niveis
    *
    * Legado (btnLocalizar.Click):
    *   lcLocaliza = Alltrim(lcLoc1)+Alltrim(lcLoc2)+Alltrim(lcLoc3)+Alltrim(lcLoc4)
    *
    * TRANSCRITO LITERALMENTE (regra #17): o ALLTRIM em cada parte eh do
    * legado. As larguras somam exatamente os 10 chars do destino
    * (2+2+2+4 = SigMvItn.locals char(10)) quando todos os codigos vem do
    * lookup, que eh como a tela os preenche.
    *====================================================================
    PROCEDURE MontarLocalizacao()
        THIS.this_cLocalizacaoMontada = ALLTRIM(NVL(THIS.this_cBase, "")) + ;
                                        ALLTRIM(NVL(THIS.this_cNvl2, "")) + ;
                                        ALLTRIM(NVL(THIS.this_cNvl3, "")) + ;
                                        ALLTRIM(NVL(THIS.this_cNvl4, ""))
        RETURN THIS.this_cLocalizacaoMontada
    ENDPROC

    *====================================================================
    * ContarItensSelecionados - quantos itens estao marcados
    *
    * COUNT move o ponteiro, por isso o RECNO eh reposto no fim: a grade
    * chama isto no AfterRowColChange e perder a linha corrente faria o
    * cursor "pular" sozinho.
    *====================================================================
    PROCEDURE ContarItensSelecionados()
        LOCAL loc_nQtd, loc_nRec, loc_nOldSel

        loc_nQtd    = 0
        loc_nOldSel = SELECT()

        IF USED("cursor_4c_Itens")
            loc_nRec = RECNO("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            COUNT FOR Marcas <> 0 TO loc_nQtd
            IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Itens")
                GO loc_nRec IN cursor_4c_Itens
            ENDIF
        ENDIF

        THIS.this_lTemItensSelecionados = (loc_nQtd > 0)

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_nQtd
    ENDPROC

    *====================================================================
    * MarcarTodosItens - SelTudo.Click (1) e apaga.Click (0) do legado
    *   Replace All crItensLoc.Marcas with <0|1> / Go Top
    *====================================================================
    PROCEDURE MarcarTodosItens(par_nValor)
        LOCAL loc_nMarca, loc_lSucesso, loc_nOldSel

        loc_lSucesso = .F.
        loc_nOldSel  = SELECT()
        loc_nMarca   = 0

        IF PCOUNT() >= 1 AND VARTYPE(par_nValor) = "N"
            loc_nMarca = IIF(par_nValor <> 0, 1, 0)
        ENDIF

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            REPLACE ALL Marcas WITH loc_nMarca
            GO TOP
            loc_lSucesso = .T.
        ENDIF

        THIS.ContarItensSelecionados()

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AlternarMarcaItem - toggle do Check1 da coluna 3
    *   Replace crItensLoc.Marcas With IIf(crItensLoc.Marcas == 0,1,0)
    *====================================================================
    PROCEDURE AlternarMarcaItem()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Itens")
            IF !EOF("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
                REPLACE Marcas WITH IIF(cursor_4c_Itens.Marcas = 0, 1, 0) IN cursor_4c_Itens
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        THIS.ContarItensSelecionados()

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * OrdenarItens - OptOrdem.Valid do legado
    *   Value = 1 -> Index on Cpros ; senao -> Index on Categoria
    *
    * Os tags ja existem (criados em CarregarItens), entao aqui basta
    * trocar a ordem corrente - mais barato que reindexar e com o mesmo
    * efeito visual.
    *====================================================================
    PROCEDURE OrdenarItens(par_nOpcao)
        LOCAL loc_lSucesso, loc_nOldSel
        loc_lSucesso = .F.
        loc_nOldSel  = SELECT()

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            IF VARTYPE(par_nOpcao) = "N" AND par_nOpcao = 1
                SET ORDER TO TAG Cpros
            ELSE
                SET ORDER TO TAG Categoria
            ENDIF
            GO TOP
            loc_lSucesso = .T.
        ENDIF

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarFotoProduto - grava a foto do produto num arquivo temporario
    *
    * Legado (grdItens.AfterRowColChange): le SigCdPro.FigJpgs, remove os
    * prefixos data-URI, decodifica base64 UMA vez (STRCONV ..., 14) e
    * grava em Sys(2023). Decodificar duas vezes corrompe a imagem.
    *
    * Devolve o caminho do arquivo, ou "" quando nao ha foto - o form usa o
    * retorno vazio para esconder a Image.
    *
    * DESVIO DELIBERADO no CATCH: aqui NAO entra MsgErro. Este metodo roda
    * a cada troca de linha da grade; um modal por linha com foto corrompida
    * deixaria a tela inutilizavel. O erro fica registrado em
    * this_cMensagemErro (com LineNo/Procedure), portanto diagnosticavel -
    * eh o que a regra #9 quer evitar, CATCH que engole sem deixar rastro.
    *====================================================================
    PROCEDURE BuscarFotoProduto(par_cCpros)
        LOCAL loc_cArquivo, loc_cSQL, loc_nResultado, loc_cBase64, loc_cBinario
        LOCAL loc_lProsseguir

        loc_cArquivo    = ""
        loc_lProsseguir = .T.

        TRY
            IF VARTYPE(par_cCpros) != "C"
                loc_lProsseguir = .F.
            ELSE
                IF EMPTY(ALLTRIM(par_cCpros))
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND TYPE("gnConnHandle") = "N"
                IF gnConnHandle <= 0
                    loc_lProsseguir = .F.
                ENDIF
            ELSE
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                THIS.FecharCursor("cursor_4c_Foto")

                loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + ;
                           EscaparSQL(ALLTRIM(par_cCpros))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Foto")

                IF loc_nResultado > 0 AND USED("cursor_4c_Foto")
                    IF RECCOUNT("cursor_4c_Foto") > 0
                        SELECT cursor_4c_Foto
                        GO TOP
                        loc_cBase64 = TratarNulo(cursor_4c_Foto.FigJpgs, "")

                        IF !EMPTY(loc_cBase64)
                            loc_cBase64 = STRTRAN(loc_cBase64, "data:image/png;base64,",  "")
                            loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpeg;base64,", "")
                            loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpg;base64,",  "")

                            *-- UMA conversao base64 -> binario
                            loc_cBinario = STRCONV(loc_cBase64, 14)
                            loc_cArquivo = ADDBS(SYS(2023)) + THIS.ObterPrefixoTemp() + ;
                                           SYS(2015) + ".jpg"

                            CLEAR RESOURCES
                            STRTOFILE(loc_cBinario, loc_cArquivo)

                            IF !FILE(loc_cArquivo)
                                loc_cArquivo = ""
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                THIS.FecharCursor("cursor_4c_Foto")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar a foto do produto: " + ;
                                      loc_oErro.Message + ;
                                      " (Linha " + TRANSFORM(loc_oErro.LineNo) + ;
                                      ", Procedure " + loc_oErro.Procedure + ")"
            loc_cArquivo = ""
        ENDTRY

        RETURN loc_cArquivo
    ENDPROC

    *====================================================================
    * LimparNiveis - zera os quatro niveis e suas descricoes
    *
    * Legado: btnLimpar.Click e o final do btnLocalizar.Click limpam os
    * oito campos da esquerda para a direita.
    *====================================================================
    PROCEDURE LimparNiveis()
        THIS.this_cBase     = ""
        THIS.this_cDescBase = ""
        THIS.this_cNvl2     = ""
        THIS.this_cDescNvl2 = ""
        THIS.this_cNvl3     = ""
        THIS.this_cDescNvl3 = ""
        THIS.this_cNvl4     = ""
        THIS.this_cDescNvl4 = ""
        THIS.this_cLocalizacaoMontada = ""
        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - carrega a linha corrente do cursor de itens
    *
    * Mapeia TODAS as colunas da grade (Marcas, Cpros, Dpros, cItens,
    * Locals, Categoria). Cada coluna eh testada com TYPE() antes de ser
    * lida, para que o metodo tambem sirva para crTpmMvItn, que nao tem
    * Marcas nem Categoria (PEMSTATUS nao funciona sobre alias de cursor -
    * exige objeto).
    *
    * Sem parametro, usa cursor_4c_Itens.
    *====================================================================
    PROCEDURE CarregarDoCursor(pcCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_nOldSel, loc_cColLocal

        loc_lSucesso = .F.
        loc_nOldSel  = SELECT()
        loc_cAlias   = "cursor_4c_Itens"

        IF PCOUNT() >= 1 AND VARTYPE(pcCursor) = "C"
            IF !EMPTY(ALLTRIM(pcCursor))
                loc_cAlias = ALLTRIM(pcCursor)
            ENDIF
        ENDIF

        IF USED(loc_cAlias)
            IF RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias)
                SELECT (loc_cAlias)

                IF TYPE(loc_cAlias + ".Marcas") != "U"
                    THIS.this_nMarcas = TratarNulo(EVALUATE(loc_cAlias + ".Marcas"), 0)
                ENDIF

                IF TYPE(loc_cAlias + ".Cpros") != "U"
                    THIS.this_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Cpros"), ""))
                ENDIF

                IF TYPE(loc_cAlias + ".Dpros") != "U"
                    THIS.this_cDpros = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Dpros"), ""))
                ENDIF

                IF TYPE(loc_cAlias + ".cItens") != "U"
                    THIS.this_nCItens = TratarNulo(EVALUATE(loc_cAlias + ".cItens"), 0)
                ENDIF

                IF TYPE(loc_cAlias + ".Categoria") != "U"
                    THIS.this_cCategoria = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Categoria"), ""))
                ENDIF

                *-- Em crTpmMvItn a localizacao do item mora em Localos quando
                *-- a tela foi aberta com pcOrigem = 'ORIGEM' (igual ao IIF do
                *-- Init legado); cursor_4c_Itens ja traz a coluna resolvida
                *-- como Locals.
                loc_cColLocal = "Locals"
                IF ALLTRIM(UPPER(NVL(THIS.this_cOrigem, ""))) == "ORIGEM"
                    IF TYPE(loc_cAlias + ".Localos") != "U"
                        loc_cColLocal = "Localos"
                    ENDIF
                ENDIF

                IF TYPE(loc_cAlias + "." + loc_cColLocal) != "U"
                    THIS.this_cLocalItem = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + "." + loc_cColLocal), ""))
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - chamado por BusinessBase.Salvar
    *
    * Preenche this_cMensagemErro e NAO exibe nada: quem exibe eh o
    * ExibirFalha do Salvar (regra #20), senao a mensagem sai duas vezes.
    *====================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        THIS.this_cMensagemErro = ""

        *-- .F. = nao exibir aqui
        loc_lValido = THIS.ValidarNiveis(.F.)

        IF loc_lValido
            IF THIS.ContarItensSelecionados() = 0
                THIS.this_cMensagemErro = "Selecione ao menos um item da grade antes de " + ;
                                          "atribuir a localiza" + CHR(231) + CHR(227) + "o."
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - grava a localizacao dos itens marcados
    *
    * Transcricao do btnLocalizar.Click legado, que eh onde esta tela
    * "grava": para cada item marcado em crItensLoc acrescenta uma linha em
    * csLocals (item, produto, localizacao montada) e remove o item da
    * grade. A escrita eh em CURSOR - esta tela NAO tem INSERT/UPDATE em
    * tabela do SQL Server em lugar nenhum do legado, e inventar um
    * violaria a regra #22 (a lista de colunas vem do schema, nunca de
    * adivinhacao).
    *
    * O guard de modo eh o When dos botoes do legado:
    *   Return (InList(ThisForm.pcEscolha,[INSERIR],[ALTERAR]))
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_nOldSel, loc_nQtd

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_nOldSel     = SELECT()
        THIS.this_nItensGravados = 0

        *-- Mesmo reset que BusinessBase.Salvar() faz na entrada: sem ele um
        *-- this_lErroExibido = .T. de uma falha ANTERIOR faria o form calar a
        *-- mensagem desta chamada (o guard do chamador eh justamente essa flag)
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF !INLIST(ALLTRIM(UPPER(NVL(THIS.this_cEscolha, ""))), "INSERIR", "ALTERAR")
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                          "o permitida no modo atual."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !USED("cursor_4c_Itens") OR !USED("cursor_4c_Locais")
                    THIS.this_cMensagemErro = "Cursores de trabalho n" + CHR(227) + "o est" + ;
                                              CHR(227) + "o abertos."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nQtd = THIS.ContarItensSelecionados()
                IF loc_nQtd = 0
                    THIS.this_cMensagemErro = "Selecione ao menos um item da grade antes de " + ;
                                              "atribuir a localiza" + CHR(231) + CHR(227) + "o."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.MontarLocalizacao()

                *-- Legado: Scan For Marcas <> 0 / Select csLocals / Append Blank
                SELECT cursor_4c_Itens
                GO TOP
                SCAN FOR Marcas <> 0
                    SELECT cursor_4c_Locais
                    APPEND BLANK
                    REPLACE cItens WITH cursor_4c_Itens.cItens, ;
                            Cpros  WITH cursor_4c_Itens.Cpros, ;
                            Locals WITH THIS.this_cLocalizacaoMontada

                    THIS.this_nItensGravados = THIS.this_nItensGravados + 1

                    *-- volta para o alias do SCAN
                    SELECT cursor_4c_Itens
                ENDSCAN

                *-- Legado: Delete From crItensLoc Where Marcas <> 0
                *-- (SET DELETED ON esconde as linhas da grade)
                DELETE FROM cursor_4c_Itens WHERE Marcas <> 0

                SELECT cursor_4c_Itens
                GO TOP

                loc_lSucesso = (THIS.this_nItensGravados > 0)

                IF loc_lSucesso
                    *-- auditoria ANTES de limpar os niveis: ObterChavePrimaria
                    *-- usa a localizacao montada
                    THIS.RegistrarAuditoria("INSERT")

                    *-- Legado limpa os oito campos no fim do btnLocalizar.Click
                    THIS.LimparNiveis()
                    THIS.ContarItensSelecionados()
                ELSE
                    THIS.this_cMensagemErro = "Nenhum item foi localizado."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            *-- A subclasse exibe o proprio erro e deixa this_cMensagemErro
            *-- VAZIA, senao o Salvar da base exibiria de novo (regra #20)
            MsgErro("Erro ao gravar a localiza" + CHR(231) + CHR(227) + "o dos itens:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            THIS.this_cMensagemErro = ""
            THIS.this_lErroExibido  = .T.
            loc_lSucesso = .F.
        ENDTRY

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - propaga as localizacoes para o cursor do form chamador
    *
    * Transcricao do btnConfirmar.Click legado:
    *   Select csLocals / Scan
    *       If pcOrigem = 'ORIGEM'
    *           Update crTpmMvItn set Localos = csLocals.Locals where cItens = csLocals.cItens
    *       Else
    *           Update crTpmMvItn set Locals  = csLocals.Locals where cItens = csLocals.cItens
    *   EndScan / Select crTpmMvItn / Go top
    *
    * this_nItensConfirmados conta as linhas REALMENTE afetadas (_TALLY), e
    * nao as iteracoes: o form tem de consultar esse contador antes de dizer
    * "gravado com sucesso" - csLocals vazio significa fechar sem mudanca,
    * que o legado permite.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_nOldSel, loc_cColDestino
        LOCAL loc_nItem, loc_cLocal

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_nOldSel     = SELECT()
        THIS.this_nItensConfirmados = 0

        *-- Mesmo reset que BusinessBase.Salvar() faz na entrada (ver Inserir)
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF !USED("crTpmMvItn")
                THIS.this_cMensagemErro = "O cursor de itens do movimento (crTpmMvItn) n" + ;
                                          CHR(227) + "o est" + CHR(225) + " aberto."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !USED("cursor_4c_Locais")
                    THIS.this_cMensagemErro = "O cursor de localiza" + CHR(231) + CHR(245) + ;
                                              "es n" + CHR(227) + "o est" + CHR(225) + " aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Coluna de destino conforme pcOrigem, igual ao legado
                loc_cColDestino = IIF(ALLTRIM(UPPER(NVL(THIS.this_cOrigem, ""))) == "ORIGEM", ;
                                      "Localos", "Locals")

                SELECT cursor_4c_Locais
                GO TOP
                SCAN
                    loc_nItem  = cursor_4c_Locais.cItens
                    loc_cLocal = cursor_4c_Locais.Locals

                    UPDATE crTpmMvItn ;
                        SET &loc_cColDestino. = m.loc_cLocal ;
                        WHERE cItens = m.loc_nItem

                    IF _TALLY > 0
                        THIS.this_nItensConfirmados = THIS.this_nItensConfirmados + _TALLY
                    ENDIF

                    *-- volta para o alias do SCAN
                    SELECT cursor_4c_Locais
                ENDSCAN

                SELECT crTpmMvItn
                GO TOP

                loc_lSucesso = .T.

                IF THIS.this_nItensConfirmados > 0
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao confirmar a localiza" + CHR(231) + CHR(227) + "o dos itens:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            THIS.this_cMensagemErro = ""
            THIS.this_lErroExibido  = .T.
            loc_lSucesso = .F.
        ENDTRY

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - identificacao do registro para a auditoria
    *
    * Esta tela nao grava em tabela: a "chave" util no LogAuditoria eh o
    * que identifica a atribuicao feita - item, localizacao montada e
    * origem. LogAuditoria.ChaveRegistro eh varchar(100), por isso o LEFT.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = ALLTRIM(NVL(THIS.this_cLocalizacaoMontada, ""))

        IF THIS.this_nCItens > 0
            loc_cChave = ALLTRIM(TRANSFORM(THIS.this_nCItens)) + "/" + loc_cChave
        ENDIF

        IF !EMPTY(ALLTRIM(NVL(THIS.this_cOrigem, "")))
            loc_cChave = loc_cChave + "/" + ALLTRIM(THIS.this_cOrigem)
        ENDIF

        RETURN LEFT(loc_cChave, 100)
    ENDPROC

    *====================================================================
    * LimparDados - zera o estado da tela
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.LimparNiveis()

        THIS.this_nCItens    = 0
        THIS.this_cCpros     = ""
        THIS.this_cDpros     = ""
        THIS.this_cLocalItem = ""
        THIS.this_cCategoria = ""
        THIS.this_nMarcas    = 0

        THIS.this_lTemItensSelecionados = .F.
        THIS.this_nItensGravados        = 0
        THIS.this_nItensConfirmados     = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * Destroy - fecha os cursores de trabalho
    *
    * Legado (Release): Use In crItensLoc / Use In csLocals. crTpmMvItn NAO
    * eh fechado aqui - pertence ao form chamador.
    *====================================================================
    PROCEDURE Destroy()
        THIS.FecharCursor("cursor_4c_Itens")
        THIS.FecharCursor("cursor_4c_Locais")
        THIS.FecharCursor("cursor_4c_Aux")
        THIS.FecharCursor("cursor_4c_LocalNivel")
        THIS.FecharCursor("cursor_4c_Prod")
        THIS.FecharCursor("cursor_4c_Foto")
        THIS.FecharCursor("cursor_4c_Nivel1")
        THIS.FecharCursor("cursor_4c_Nivel2")
        THIS.FecharCursor("cursor_4c_Nivel3")
        THIS.FecharCursor("cursor_4c_Nivel4")
        THIS.FecharCursor("cursor_4c_LcNv1")
        THIS.FecharCursor("cursor_4c_LcNv2")
        THIS.FecharCursor("cursor_4c_LcNv3")
        THIS.FecharCursor("cursor_4c_LcNv4")

        DODEFAULT()
    ENDPROC

ENDDEFINE

