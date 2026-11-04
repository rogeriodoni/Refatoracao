# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarDadosReais': No PARAMETER statement is found. | Detalhes: Linha: 1196, Proc: montagrade; Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-10-31 08:51:23] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-31 08:51:23] [INFO] Config FPW: (nao fornecido)
[2026-10-31 08:51:23] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-31 08:51:23] [INFO] Timeout: 300 segundos
[2026-10-31 08:51:23] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_44vid0zs.prg
[2026-10-31 08:51:23] [INFO] Conteudo do wrapper:
[2026-10-31 08:51:23] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpDes', 'C:\4c\tasks\task719', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpDes', 'C:\4c\tasks\task719', 'OPERACIONAL'
QUIT

[2026-10-31 08:51:23] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_44vid0zs.prg
[2026-10-31 08:51:23] [INFO] VFP output esperado em: C:\4c\tasks\task719\vfp_output.txt
[2026-10-31 08:51:23] [INFO] Executando Visual FoxPro 9...
[2026-10-31 08:51:23] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_44vid0zs.prg
[2026-10-31 08:51:23] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_44vid0zs.prg
[2026-10-31 08:51:23] [INFO] Timeout configurado: 300 segundos
[2026-10-31 08:51:23] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-31 08:51:23] [INFO] VFP9 finalizado em 0.5125216 segundos
[2026-10-31 08:51:23] [INFO] Exit Code: 
[2026-10-31 08:51:23] [INFO] 
[2026-10-31 08:51:23] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-31 08:51:23] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_44vid0zs.prg
[2026-10-31 08:51:23] [INFO] 
[2026-10-31 08:51:23] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-31 08:51:23] [INFO] * Auto-generated wrapper for parameters
[2026-10-31 08:51:23] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-31 08:51:23] [INFO] * Parameters: 'FormSigOpDes', 'C:\4c\tasks\task719', 'OPERACIONAL'
[2026-10-31 08:51:23] [INFO] 
[2026-10-31 08:51:23] [INFO] * Anti-dialog protections for unattended execution
[2026-10-31 08:51:23] [INFO] SET SAFETY OFF
[2026-10-31 08:51:23] [INFO] SET RESOURCE OFF
[2026-10-31 08:51:23] [INFO] SET TALK OFF
[2026-10-31 08:51:23] [INFO] SET NOTIFY OFF
[2026-10-31 08:51:23] [INFO] SYS(2335, 0)
[2026-10-31 08:51:23] [INFO] 
[2026-10-31 08:51:23] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpDes', 'C:\4c\tasks\task719', 'OPERACIONAL'
[2026-10-31 08:51:23] [INFO] QUIT
[2026-10-31 08:51:23] [INFO] 
[2026-10-31 08:51:23] [INFO] === Fim do Wrapper.prg ===
[2026-10-31 08:51:23] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpDes",
  "timestamp": "20261031085123",
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
      "passou": false,
      "erro": "No PARAMETER statement is found.",
      "detalhes": "Linha: 1196, Proc: montagrade"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 2 (CHKSELECAOKEYPRESS, KEYPRESS)"
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDes.prg):
*==============================================================================
* FormSigOpDes.prg - Form OPERACIONAL: Selecao de Descontos
* Migrado de: tasks/task719/SigOpDes.SCX (SIGOPDES)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - dialogo MODAL FILHO, aberto a partir da
*         grade de itens de um movimento de venda (checkbox da coluna de
*         desconto do item).
*
* O QUE ESTA TELA EH
* ------------------
* SigOpDes.SCX e' o dialogo "Selecao de Descontos": exibe os tipos de
* desconto elegiveis para o item atual (grade principal, localDes no
* legado), marca/edita percentual e valor de cada linha, mostra a cota de
* desconto acumulada da empresa (grade GrdCota, so para acesso GERENTE) e
* os totais (Valor Original / Total Desconto / Saldo). Confirmar grava as
* linhas marcadas em SigMvItd; Cancelar fecha sem gravar.
*
* O legado le o contexto do item/movimento (Emps/Dopes/Numes/Cpros/
* Citens/...) e o cadastro do produto atual (Cgrus/Sgrus/...) diretamente
* dos cursores globais TprMvCab/crTpmMvItn/crProd, que ja estao abertos
* pelo form chamador quando ele faz "Do Form SigOpDes With pCnx, pForm".
* Esta arquitetura nao depende mais desses cursores globais - o form
* chamador passa o contexto inteiro por parametro no Init (ver abaixo), e
* o SigOpDesBO (Fases 1-2) guarda esse contexto em propriedades this_*.
*
* ESCOPO DAS FASES 3 E 4/8 - ESTRUTURA, GRADES E CARGA
* -----------------------------------------------------
* A Fase 3 entregou a casca da tela:
*
*   DEFINE CLASS + propriedades visuais   transcritas do dump
*   Init(<20 parametros de contexto>)     equivalente ao pCnx/pForm legado,
*                                          mas com o contexto INTEIRO (o
*                                          legado lia dos cursores globais)
*   InicializarForm                       BO + Picture + superficie visual
*   ConfigurarPageFrame                   orquestrador da montagem
*   ConfigurarCabecalho                   cntSombra + lblSombra/lblTitulo
*   TornarControlesVisiveis               AddObject nasce com Visible = .F.
*
* A Fase 4 acrescentou, dentro dessa casca:
*
*   ConfigurarBotoes      cmg_4c_Botoes (cntBotoes) - Confirmar/Cancelar
*   ConfigurarGradeCota   grd_4c_Cota (GrdCota) - cota da empresa, 3
*                         colunas somente-leitura, exibida so com acesso
*                         GERENTE (AcessoGradeCota)
*   ConfigurarGrade       grd_4c_Dados (Grade) - a grade principal de
*                         descontos, 4 colunas: checkbox de selecao /
*                         descricao / % desconto / valor desconto
*   CarregarLista         carga das DUAS grades, delegando ao BO
*                         (SigOpDesBO.CarregarCota e .CarregarDescontos,
*                         que reproduzem o pipeline de cursores do Init
*                         legado: crDesc, crTipo, localDes e crSigCdDes)
*   MontaGrade            funil UNICO de repintura (Go Top + Refresh),
*                         com VincularGrade/VincularGradeCota para o
*                         rebind quando o RecordSource se perde
*
* A Fase 5 entregou a primeira metade dos totais (Say2/lnValor e
* Say4/lnTDesc).
*
* ESCOPO DA FASE 6/8 - CAMPOS RESTANTES E CELULAS DIGITAVEIS
* ----------------------------------------------------------
*   ConfigurarTotais        completado com Say1/lnSaldo, o terceiro par
*                           de total (o unico que faltava do dump)
*   InstalarCelulasGrade    as tres celulas da grade principal passam a
*                           ser subclasses de TextBox com o When/Valid
*                           do legado EMBUTIDO (regra CLAUDE.md #46), em
*                           Column2/3/4 via CurrentControl
*   ValidarPercentualDesconto / ValidarValorDesconto
*                           os dois PROCEDURE Valid do legado
*                           (Grade.Column3.Text1 e Grade.Column4.Text1),
*                           transcritos regra a regra
*   CalcularTotais          o PROCEDURE calctots do legado - motor de
*                           totais que os dois Valid acionam e de quem
*                           eles leem o Saldo para o teste final
*   GradeAfterRowColChange  a navegacao da coluna de descricao para a
*                           coluna editavel do tipo de desconto
*
* NAO HA LOOKUP NESTA TELA, e isso foi medido, nao presumido: o dump
* SigOpDes_form_codigo_fonte.txt nao casa nenhum dos padroes de busca do
* legado - zero "fwbusca" (que cobre fwBuscaExt/fwBuscaSel/fwBuscaInt),
* zero "mAddColuna", zero "sigacess(" e zero "Acesso<X>(". A tela recebe
* a lista de descontos elegiveis JA resolvida pelo pipeline de
* elegibilidade do BO; o usuario nao digita codigo de tabela nenhuma -
* ele marca linhas e edita percentual/valor. Criar aqui um
* AbrirLookup*/AbrirBusca* significaria consultar uma tabela que o
* legado nunca consulta (viola o PILAR 1 e a regra "NUNCA inventar
* tabelas de lookup").
*
* O que ESTA fase cobre no lugar do lookup e' o par When/Valid dos
* campos DIGITAVEIS, que e' a outra metade do contrato da fase: a grade
* tem duas celulas que aceitam digitacao (% Desconto e Valor Desconto) e
* uma que o legado bloqueia por When (Descricao).
*
* ESCOPO DA FASE 7/8 - EVENTOS PRINCIPAIS
* ----------------------------------------
*   BtnCancelarClick / BtnConfirmarClick
*                           cmg_4c_Botoes.Buttons(1)/Buttons(2) (btnSair/
*                           btnConfirmar do legado). Sair so libera o
*                           dialogo; Confirmar remove os descontos
*                           anteriores do item e regrava em SigMvItd uma
*                           linha por tipo marcado (ConfirmarSelecaoExec +
*                           SigOpDesBO.ExcluirDescontosDoItem/Inserir)
*   ChkSelecaoClick/MouseDown/MouseUp/KeyPress + ChkSelecaoToggle(Exec)
*                           os 4 handlers do checkbox de selecao de cada
*                           linha (fwcheckbox1 do legado), com a
*                           autorizacao de gerente/supervisor/diretoria via
*                           DO FORM SigOpSen (FAIL-CLOSED - ver
*                           feedback_sigopsen_ausente_gate_autorizacao)
*   Header1Click            Grade.Column1.Header1.Click - selecionar/
*                           desmarcar TODAS as linhas de uma vez
*
* Os tres acionam CalcularTotais (Fase 6/8).
*
* ESCOPO DA FASE 8/8 - CONSOLIDACAO FINAL
* ----------------------------------------
*   FormParaBO              FONTE UNICA tela -> BO: o contexto do
*                           movimento/item/produto (que o Init recebeu por
*                           parametro) e os TRES totais lidos dos TextBox.
*                           Chamado por InicializarForm, CalcularTotais e
*                           ConfirmarSelecaoExec - antes, essas atribuicoes
*                           estavam espalhadas pelos tres (e o contexto era
*                           reatribuido DENTRO do SCAN de gravacao, uma vez
*                           por linha).
*   BOParaForm              FONTE UNICA BO -> tela: os mesmos tres totais.
*                           Chamado por CarregarLista entre MontaGrade e
*                           CalcularTotais - ordem obrigatoria, porque
*                           CalcularTotais LE txt_4c_LnValor.Value como
*                           base do rateio.
*   Destroy                 o "PROCEDURE Release" do legado: solta as duas
*                           grades dos cursores e SO ENTAO fecha
*                           cursor_4c_Dados/cursor_4c_Cota, fechando com
*                           DODEFAULT() (sem ele o menu principal do
*                           sistema aparece encolhido depois que este
*                           dialogo fecha).
*
* O Cancelar da Fase 7 foi renomeado de BtnSairClick para BtnCancelarClick:
* o handler leva o nome da ACAO que o usuario ve, e o dump da' a Command1
* "Caption = \<Cancelar" / "Cancel = .T." ("btnSair" e' so o .Name interno
* do objeto no SCX).
*
* METODOS CANONICOS DE CRUD QUE NAO SE APLICAM A ESTA TELA
* ---------------------------------------------------------
* SIGOPDES e' dialogo MODAL FILHO de selecao, nao cadastro: nao tem pagina
* de Lista nem de Dados, nao tem modo INCLUIR/ALTERAR/VISUALIZAR e nao tem
* botao nenhum alem dos DOIS do dump (cntBotoes.ButtonCount = 2). Medido no
* dump SigOpDes_form_codigo_fonte.txt, nao presumido:
*
*   BtnSalvarClick       zero ocorrencias de "btnSalvar", "btnGravar" e
*                        "mGravaDados" no dump. O botao de gravar desta tela
*                        e' o Confirmar (Command2, "Caption = \<Confirmar"),
*                        e o handler dele e' BtnConfirmarClick. Inventar um
*                        segundo botao "Salvar" violaria o PILAR 1.
*   BtnBuscarClick       nao ha lookup nem busca nesta tela (zero "fwbusca",
*                        zero "mAddColuna", zero "sigacess(" no dump - ver a
*                        nota da Fase 6 acima). A lista de descontos
*                        elegiveis chega JA resolvida pelo pipeline do BO.
*   BtnEncerrarClick     "Encerrar" e' o nome canonico do botao de saida de
*                        form CRUD (cnt_4c_Saida/cmd_4c_Encerrar, regra
*                        CLAUDE.md #10). Aqui o botao de saida e' o Cancelar
*                        do proprio dump, ja entregue como BtnCancelarClick -
*                        um BtnEncerrarClick seria um segundo nome para o
*                        MESMO e unico caminho de fechar a tela.
*   HabilitarCampos      nao ha modo de edicao a habilitar/desabilitar. O
*                        que o legado controla por campo ele controla no
*                        When de cada celula (Column2.Text1.When -> .f.,
*                        Column3/4.Text1.When -> "localdes.selecao=1",
*                        lnValor/lnTDesc/lnSaldo.When -> .F., GrdCota
*                        inteiro ReadOnly), e esses When estao EMBUTIDOS nas
*                        subclasses de celula (Fase 6) e nas propriedades
*                        dos controles - que e' onde o legado os poe.
*   LimparCampos         nao existe "registro novo" aqui: a tela abre com a
*                        lista do item carregada e fecha. O unico caminho de
*                        limpeza que o legado tem e' o
*                        "replace descos with 0 / valdes with 0" de linha
*                        desmarcada, que vive em CalcularTotais e em
*                        ReverterCelulaDesconto.
*   AjustarBotoesPorModo nao ha modo, e os dois botoes do dump estao SEMPRE
*                        habilitados (nenhum .Enabled no dump de cntBotoes,
*                        nenhum When/Enabled nos Command1/Command2).
*
* Em todos os seis casos a alternativa seria criar metodo VAZIO (proibido
* pela regra de completude) ou inventar superficie que o legado nao tem
* (proibido pelo PILAR 1).
*
* NOTA DE WINDOWTYPE (regra CLAUDE.md #29): a classe nasce com
* WindowType = 0 e so recebe WindowType = 1 (modal, necessario para o
* Show() bloqueante do form chamador manter a referencia viva) fora dos
* modos de teste/validacao de UI - mesmo padrao de FormSigOpClp. Em
* gb_4c_ValidandoUI/gb_4c_ModoTeste o form e' instanciado sem Show(), e um
* WindowType = 1 ali arriscaria falha de instanciacao headless sem
* nenhum defeito real existir em producao.
*==============================================================================

DEFINE CLASS FormSigOpDes AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - TRANSCRITAS do dump de SIGOPDES
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Height            = 361
    Width             = 800
    Caption           = "Sele" + CHR(231) + CHR(227) + "o de Descontos"
    BorderStyle       = 2
    AutoCenter        = .T.
    TitleBar          = 0
    ShowWindow = 1
    ControlBox        = .F.
    Closable          = .F.
    MaxButton         = .F.
    MinButton         = .F.
    Movable           = .F.
    ClipControls      = .F.
    KeyPreview        = .T.
    ShowTips          = .T.
    AlwaysOnTop       = .T.
    Themes            = .F.
    ShowWindow        = 0
    WindowType        = 0
    DataSession       = 1
    FontName          = "Verdana"
    FontSize          = 8

    *--------------------------------------------------------------------------
    * Contexto do movimento/item recebido do form chamador (equivalente ao
    * que o Init legado lia de TprMvCab/crTpmMvItn) - espelha 1:1 as
    * propriedades de contexto do SigOpDesBO (Fases 1-2).
    *--------------------------------------------------------------------------
    this_cEmps       = ""
    this_cDopes      = ""
    this_nNumes      = 0
    this_cContads    = ""
    this_dDatas      = {}
    this_cEmpDopNums = ""
    this_cCpros      = ""
    this_nCitens     = 0
    this_nUnitOrigs  = 0
    this_nQtds       = 0
    this_nTotas      = 0

    *--------------------------------------------------------------------------
    * Contexto do cadastro do produto atual (equivalente a crProd do
    * legado, usado nas regras de elegibilidade de desconto)
    *--------------------------------------------------------------------------
    this_cCgrus      = ""
    this_cSgrus      = ""
    this_cCodcors    = ""
    this_cColecoes   = ""
    this_cCodfinp    = ""
    this_nPvens      = 0
    this_dDtLacto    = {}
    this_lForaLinha  = .F.
    this_nPrecode    = 0

    *--------------------------------------------------------------------------
    * Quantidade de recebimentos PARCELADOS do movimento - equivalente a
    * RECCOUNT('crPar') do legado, que vem de
    * "SELECT * from xPar where parcs > 1 into cursor crPar" no Init. xPar
    * e' um cursor GLOBAL do form chamador (a tela de venda), igual a
    * TprMvCab/crTpmMvItn: nao existe nesta arquitetura, entao chega por
    * parametro no Init como todo o resto do contexto.
    *
    * Usado SO pelos dois Valid de celula desta fase (a regra "desconto
    * financeiro nao e' permitido para pagamento parcelado", tipo 2) - nao
    * vai para o BO porque nao alimenta SQL nem gravacao, e espelhar
    * contexto que o BO nao consome so criaria um segundo lugar para
    * divergir.
    *
    * Zero (o default quando o chamador omite o parametro) reproduz
    * exatamente o legado com crPar VAZIO: a regra nao bloqueia nada.
    *--------------------------------------------------------------------------
    this_nQtdParcelas = 0

    *==========================================================================
    * Init - recebe o contexto do item/movimento e do produto atual do
    * form chamador.
    *
    * Legado (SIGOPDES.Init):
    *
    *   Lparameters pCnx, pForm
    *   This.poDataMgr = pCnx
    *   This.parentform = pForm
    *   lcCpros = crTpmMvItn.cpros
    *   pcItem  = crTpmMvItn.citens
    *   lcEmp   = TprMvCab.emps
    *   ... (demais leituras de TprMvCab/crTpmMvItn/crProd)
    *
    * pCnx nao tem equivalente aqui: a conexao e' gnConnHandle (global). O
    * contexto que o legado lia dos cursores globais chega por parametro -
    * ver o cabecalho do arquivo.
    *
    * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1): o resultado passa
    * pela flag loc_lSucesso.
    *==========================================================================
    PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_cContads, ;
                    par_dDatas, par_cEmpDopNums, par_cCpros, par_nCitens, ;
                    par_nUnitOrigs, par_nQtds, par_nTotas, ;
                    par_cCgrus, par_cSgrus, par_cCodcors, par_cColecoes, ;
                    par_cCodfinp, par_nPvens, par_dDtLacto, par_lForaLinha, ;
                    par_nPrecode, par_nQtdParcelas)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        *-- WindowType = 1 em PRODUCAO (regra CLAUDE.md #29): o chamador
        *-- instancia este form com CREATEOBJECT numa variavel LOCAL e so a
        *-- chamada bloqueante de Show() modal mantem essa referencia viva
        *-- enquanto o dialogo esta aberto. Em teste/validacao de UI o
        *-- Show() nunca e' chamado, e o 0 da classe evita risco de falha de
        *-- instanciacao headless.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        TRY
            THIS.this_cEmps       = TratarNulo(par_cEmps, "")
            THIS.this_cDopes      = TratarNulo(par_cDopes, "")
            THIS.this_nNumes      = TratarNulo(par_nNumes, 0)
            THIS.this_cContads    = TratarNulo(par_cContads, "")
            THIS.this_dDatas      = ConverterParaData(par_dDatas)
            THIS.this_cEmpDopNums = TratarNulo(par_cEmpDopNums, "")
            THIS.this_cCpros      = TratarNulo(par_cCpros, "")
            THIS.this_nCitens     = TratarNulo(par_nCitens, 0)
            THIS.this_nUnitOrigs  = TratarNulo(par_nUnitOrigs, 0)
            THIS.this_nQtds       = TratarNulo(par_nQtds, 0)
            THIS.this_nTotas      = TratarNulo(par_nTotas, 0)

            THIS.this_cCgrus      = TratarNulo(par_cCgrus, "")
            THIS.this_cSgrus      = TratarNulo(par_cSgrus, "")
            THIS.this_cCodcors    = TratarNulo(par_cCodcors, "")
            THIS.this_cColecoes   = TratarNulo(par_cColecoes, "")
            THIS.this_cCodfinp    = TratarNulo(par_cCodfinp, "")
            THIS.this_nPvens      = TratarNulo(par_nPvens, 0)
            THIS.this_dDtLacto    = ConverterParaData(par_dDtLacto)
            THIS.this_lForaLinha  = TratarNulo(par_lForaLinha, .F.)
            THIS.this_nPrecode    = TratarNulo(par_nPrecode, 0)

            *-- Parametro OPCIONAL: TratarNulo devolve o default tambem
            *-- quando o argumento foi OMITIDO (o VFP entrega .F. nesse
            *-- caso, e TratarNulo trata logico vazio como ausente).
            THIS.this_nQtdParcelas = TratarNulo(par_nQtdParcelas, 0)

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpDesBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpDesBO." + ;
                        CHR(13) + "VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "Erro em Init")
            ELSE
                *-- FormBase.Init chama InicializarForm
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpDes.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - propaga o contexto para o BO e monta a superficie
    * visual da tela.
    *
    * Picture: o dump traz "..\framework\imagens\new_background.jpg" - o
    * arquivo vive em vbmp\ no sistema novo, alcancado por
    * gc_4c_CaminhoIcones (nunca remontado a partir de gc_4c_CaminhoBase -
    * regra CLAUDE.md Pattern #170/#156). Atribuido direto, sem guard
    * IF FILE(): guard mascara arquivo ausente em silencio (regra CLAUDE.md
    * #25) - o arquivo foi conferido em vbmp\new_background.jpg.
    *
    * this_nValor (propriedade de totais do BO) recebe this_nUnitOrigs aqui
    * porque e' exatamente o que o Init legado faz:
    * "this.lnValor.value = crTpmMvItn.unitorigs".
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Contexto do movimento/item/produto -> BO, e this_nValor
            *-- (legado: "this.lnValor.value = crTpmMvItn.unitorigs").
            *-- A transferencia mora em FormParaBO, que e' a fonte unica
            *-- tela -> BO: a gravacao do Confirmar chama o MESMO metodo, e
            *-- duplicar estas atribuicoes aqui criaria um segundo lugar
            *-- para divergir em silencio.
            *--
            *-- ANTES de ConfigurarPageFrame de proposito: ConfigurarTotais
            *-- nasce os tres TextBox de total lendo
            *-- this_oBusinessObject.this_nValor/this_nTDesc/this_nSaldo, que
            *-- precisam ja estar resolvidos. FormParaBO sabe que nessa
            *-- primeira passagem os TextBox ainda nao existem.
            *--
            *-- O retorno e' descartado de proposito: FormParaBO JA exibiu a
            *-- falha (unico caminho de falha e' BO ausente/excecao, e repetir
            *-- a mensagem aqui daria dois dialogos para o mesmo erro - regra
            *-- CLAUDE.md #20). Sem contexto a grade abre vazia, o que e'
            *-- melhor que a tela nao abrir.
            THIS.FormParaBO()

            THIS.ConfigurarPageFrame()

            *-- Legado: lblSombra.Caption / lblTitulo.Caption = ThisForm.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- AddObject cria tudo com Visible = .F.
            THIS.TornarControlesVisiveis(THIS)

            *-- Carga das duas grades. Pulada em validacao de UI e em modo
            *-- de teste porque nesses modos nao ha conexao: gnConnHandle
            *-- invalido faz o SQLEXEC disparar excecao, e a tela deixaria
            *-- de instanciar por falta de banco, nao por defeito de layout.
            *-- O retorno e' descartado de proposito - a falha de carga ja
            *-- foi reportada pelo BO e a tela abre com a grade vazia, em
            *-- vez de nao abrir.
            IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
               (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
                THIS.CarregarLista()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - orquestra a montagem visual
    *
    * Nao ha PageFrame real: o legado SIGOPDES e' flat (ver o cabecalho do
    * arquivo). O nome e' mantido por conformidade com o contrato do
    * pipeline. ORDEM OBRIGATORIA - o cabecalho primeiro (a faixa cinza
    * ocupa Top 0..80 e qualquer controle criado depois desenha por cima -
    * regra CLAUDE.md #11); cmg_4c_Botoes em seguida, porque o legado
    * (cntBotoes Top=-2 Height=85) flutua POR CIMA da faixa de proposito -
    * e' a barra de acao do topo, nao um controle de dados (excecao da
    * mesma regra #11); as duas grades depois, ja abaixo da faixa
    * (GrdCota.Top=85, Grade.Top=131 - nenhuma precisa de compensacao,
    * este form nao tem PageFrame.Top=-29).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarGradeCota()
        THIS.ConfigurarGrade()
        THIS.ConfigurarTotais()
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - cmg_4c_Botoes (cntBotoes do legado): CommandGroup
    * com 2 botoes, Confirmar (Buttons(2) = Command2 do dump) e Cancelar
    * (Buttons(1) = Command1 do dump, com .Cancel = .T. - ESC aciona).
    *
    * Geometria/aparencia TRANSCRITA do dump (SIGOPDES.cntBotoes): grupo em
    * Top=-2/Left=643/Width=160/Height=85 - flutua por cima da faixa do
    * cabecalho de proposito (ver ConfigurarPageFrame). CommandGroup NAO
    * tem FontName/ForeColor/BackColor (regra CLAUDE.md "CommandGroup.
    * FontName NAO EXISTE") - essas propriedades vao nos Buttons(N), que
    * sao CommandButton de verdade.
    *
    * Icones TRANSCRITOS do dump (regra CLAUDE.md #25): cadastro_sair_60.jpg
    * (Cancelar) e cadastro_salvar_60.jpg (Confirmar) - ambos confirmados
    * em vbmp\. Themes = .F. em ambos (Buttons(N) dentro de CommandGroup
    * MANTEM Themes = .F. - regra CommandButton ForeColor/BackColor/Themes
    * EXATOS).
    *
    * BINDEVENT dos Click (btnConfirmar/btnSair - Fase 7/8) fica no fim do
    * metodo, junto com o motor CalcTots que os dois acionam.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")

        WITH THIS.cmg_4c_Botoes
            .Top          = -2
            .Left         = 643
            .Width        = 160
            .Height       = 85
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .SpecialEffect = 1
            .BorderColor  = RGB(136, 189, 188)
            .Value        = 0
            .TabIndex     = 2
            .Visible      = .T.

            *-- Buttons(1) = Command1/btnSair do dump (Cancelar, [Esc] encerra)
            WITH .Buttons(1)
                .Top          = 5
                .Left         = 80
                .Width        = 75
                .Height       = 75
                .FontName     = "Comic Sans MS"
                .FontSize     = 8
                .FontBold     = .T.
                .FontItalic   = .T.
                .WordWrap     = .T.
                .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel       = .T.
                .Caption      = "\<Cancelar"
                .MousePointer = 15
                .ToolTipText  = "[Esc] Encerrar"
                .SpecialEffect = 0
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
                .TabIndex     = 2
            ENDWITH

            *-- Buttons(2) = Command2/btnConfirmar do dump
            WITH .Buttons(2)
                .Top          = 5
                .Left         = 5
                .Width        = 75
                .Height       = 75
                .FontName     = "Comic Sans MS"
                .FontSize     = 8
                .FontBold     = .T.
                .FontItalic   = .T.
                .WordWrap     = .T.
                .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption      = "\<Confirmar"
                .MousePointer = 15
                .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
                .SpecialEffect = 0
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
                .TabIndex     = 1
            ENDWITH
        ENDWITH

        *-- BINDEVENT dos dois botoes (Fase 7/8). Buttons(1) = btnSair/Cancelar
        *-- (legado: "ThisForm.Release" puro); Buttons(2) = btnConfirmar
        *-- (legado: grava SigMvItd e libera o dialogo).
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnCancelarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnConfirmarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarGradeCota - grd_4c_Cota (GrdCota do legado): cota de desconto
    * acumulada da empresa, visivel SOMENTE para acesso GERENTE (legado:
    * "THIS.grdCota.Visible=fChecaAcesso('SIGCDDES','GERENTE')" no Init).
    *
    * 3 colunas somente-leitura (ReadOnly = .T. no grid inteiro, igual ao
    * dump): Empresa / Cota / Utilizada. O dump fisicamente tem 3 objetos
    * Column (ColumnCount = 3), com os 2 ultimos renomeados (.Name =
    * "Column3"/"Column4") por terem sobrado de um ColumnCount = 4 original
    * (a 2a coluna, ValMeta, esta comentada no Init - "*!*This.GrdCota.
    * Column2.ControlSource = [crSigCdDes.valmeta]") - aqui os 3 Column
    * ficam na ordem natural 1/2/3 (PILAR 3 nao exige preservar o
    * artefato de rename).
    *
    * O cursor cursor_4c_Cota e' criado vazio AQUI porque Column.ControlSource
    * exige que o cursor JA exista: atribuir ControlSource de cursor
    * inexistente estoura "Alias is not found" dentro do TRY do
    * InicializarForm, o CREATEOBJECT devolve .F. e o usuario aciona a tela
    * e nada acontece, sem erro visivel. Quem popula de verdade e'
    * SigOpDesBO.CarregarCota, chamada por CarregarLista.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeCota()
        LOCAL loc_oGrdCota

        *-- Estrutura inicial com a MESMA lista de colunas que
        *-- SigOpDesBO.CarregarCota recria: APPEND FROM casa as colunas por
        *-- NOME, e coluna faltando aqui sumiria da grade em silencio.
        IF !USED("cursor_4c_Cota")
            SET NULL ON
            CREATE CURSOR cursor_4c_Cota ;
                (Emps C(3), Valcota N(11,2), Valdes N(11,2), ;
                 Codigo C(10), Valmeta N(11,2))
            SET NULL OFF
        ENDIF

        THIS.AddObject("grd_4c_Cota", "Grid")
        loc_oGrdCota = THIS.grd_4c_Cota

        WITH loc_oGrdCota
            .ColumnCount  = 3
            .RecordSource = "cursor_4c_Cota"
            .Top          = 85
            .Left         = 25
            .Width        = 413
            .Height       = 39
            .FontName     = "Verdana"
            .FontSize     = 8
            .HeaderHeight = 22
            .RowHeight    = 16
            .ScrollBars   = 2
            .ReadOnly     = .T.
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .TabIndex     = 1
            .Visible      = THIS.AcessoGradeCota()
        ENDWITH

        *-- Column1: Empresa (crSigCdDes.emps)
        WITH loc_oGrdCota.Column1
            .ControlSource = "cursor_4c_Cota.Emps"
            .Width         = 75
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        WITH loc_oGrdCota.Column1.Text1
            .BorderStyle = 0
            .InputMask   = ""
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH
        WITH loc_oGrdCota.Column1.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Empresa"
        ENDWITH

        *-- Column2: Cota (crSigCdDes.valcota)
        WITH loc_oGrdCota.Column2
            .ControlSource = "cursor_4c_Cota.ValCota"
            .Width         = 145
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        WITH loc_oGrdCota.Column2.Text1
            .BorderStyle = 0
            .Format      = "999,999,999.99"
            .InputMask   = ""
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
        WITH loc_oGrdCota.Column2.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Cota"
        ENDWITH

        *-- Column3: Utilizada (crSigCdDes.Valdes)
        WITH loc_oGrdCota.Column3
            .ControlSource = "cursor_4c_Cota.Valdes"
            .Width         = 169
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        WITH loc_oGrdCota.Column3.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
        WITH loc_oGrdCota.Column3.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Utilizada"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - grd_4c_Dados (Grade do legado): grade principal de
    * tipos de desconto elegiveis (localDes no legado) - 4 colunas:
    * checkbox de selecao / descricao / % desconto / valor desconto.
    *
    * Column1 e' checkbox puro (regra CLAUDE.md #18 - Column.AddObject NAO
    * basta, precisa de CurrentControl + Sparse = .F.; regra "CheckBox
    * .Value SEMPRE NUMERICO" - Selecao e' NUMERIC(1,0) no legado, nao
    * logico). Geometria/InputMask/Format de cada coluna TRANSCRITOS do
    * dump (SIGOPDES.Grade.ColumnN) - regra CLAUDE.md #49 (Format/InputMask
    * nunca descartados).
    *
    * O cursor cursor_4c_Dados nasce vazio AQUI com os MESMOS campos que
    * SigOpDesBO.CarregarDescontos recria - placeholder e cursor real tem
    * de ter estrutura IDENTICA, porque o APPEND FROM da recarga casa as
    * colunas por NOME e coluna ausente de um dos lados nao viaja, sem
    * erro nenhum. Descos N(7,4) e Valdes N(9,2) acompanham as colunas de
    * destino SigMvItd.pdes numeric(7,4) e SigMvItd.vdes numeric(9,2),
    * gravadas por SigOpDesBO.Inserir().
    *
    * As celulas de Column2/3/4 sao instaladas por InstalarCelulasGrade
    * (Fase 6/8), que poe em cada coluna uma SUBCLASSE de TextBox com o
    * When/Valid do legado embutido - as propriedades visuais que o dump
    * declara em ColumnN.Text1 passam a ser aplicadas nessa subclasse, que
    * e' quem desenha e edita a celula a partir do CurrentControl.
    *
    * O BINDEVENT do fwcheckbox1.Click (autorizacao de gerente/supervisor/
    * diretoria via SigOpSen) e o do Header1.Click de selecionar-tudo
    * (Fase 7/8) ficam no fim do metodo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrade

        *-- Estrutura inicial com a MESMA lista de colunas que
        *-- SigOpDesBO.CarregarDescontos recria (APPEND FROM casa por NOME).
        *-- Alem das 4 colunas exibidas, o cursor carrega as 4 que o legado
        *-- tambem mantem em localDes e que os fluxos de validacao e de
        *-- gravacao consomem: Codigos (SigOpTdz.codigos, que vai para
        *-- SigMvItd.cdesc), Tpdesc (regra de autorizacao por tipo),
        *-- Descosmax (teto que o Valid da coluna "% Desconto" cobra) e
        *-- Usuars (quem autorizou, gravado em SigMvItd.usuars).
        IF !USED("cursor_4c_Dados")
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ;
                (Selecao N(1,0), Descrs C(30), Descos N(7,4), ;
                 Valdes N(9,2), Codigos C(10), Tpdesc N(2,0), ;
                 Descosmax N(7,4), Usuars C(10))
            SET NULL OFF
        ENDIF

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrade = THIS.grd_4c_Dados

        WITH loc_oGrade
            .ColumnCount  = 4
            .RecordSource = "cursor_4c_Dados"
            .Top          = 131
            .Left         = 24
            .Width        = 748
            .Height       = 169
            .FontName     = "Verdana"
            .FontSize     = 8
            .HeaderHeight = 22
            .RowHeight    = 16
            .ScrollBars   = 2
            .ReadOnly     = .F.
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .TabIndex     = 1
            .Visible      = .T.
        ENDWITH

        *-- Column1: checkbox de selecao (fwcheckbox1 do legado)
        WITH loc_oGrade.Column1
            .ControlSource = "cursor_4c_Dados.Selecao"
            .Width         = 23
            .Alignment     = 2
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .F.
            .Sparse        = .F.
            .Format        = "K!"
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oGrade.Column1.AddObject("chk_4c_Selecao", "CheckBox")
        WITH loc_oGrade.Column1.chk_4c_Selecao
            .Top       = 31
            .Left      = 12
            .FontName  = "Verdana"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .Centered  = .T.
            .BackStyle = 0
            .Caption   = ""
            .ReadOnly  = .F.
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        loc_oGrade.Column1.CurrentControl = "chk_4c_Selecao"

        WITH loc_oGrade.Column1.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = ""
            .Picture   = gc_4c_CaminhoIcones + "CHECKBX.BMP"
        ENDWITH

        *-- BINDEVENT do checkbox de selecao (Fase 7/8) - regra CLAUDE.md
        *-- "CheckBox em coluna de Grid": o toggle nativo NAO e' confiavel
        *-- dentro de Column, entao Click/MouseDown so suprimem (NODEFAULT) e
        *-- MouseUp/KeyPress(Enter/Espaco) e' quem de fato alterna, via
        *-- ChkSelecaoToggle - que tambem carrega a logica de autorizacao do
        *-- legado (SigOpSen). BINDEVENT do Header1.Click (selecionar/
        *-- desmarcar tudo) fica aqui tambem, por serem da mesma coluna.
        BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "Click",     THIS, "ChkSelecaoClick")
        BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "MouseDown", THIS, "ChkSelecaoMouseDown")
        BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "MouseUp",   THIS, "ChkSelecaoMouseUp")
        BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "KeyPress",  THIS, "ChkSelecaoKeyPress")
        BINDEVENT(loc_oGrade.Column1.Header1,        "Click",     THIS, "Header1Click")

        *-- Column2: descricao do tipo de desconto (localDes.Descrs)
        WITH loc_oGrade.Column2
            .ControlSource = "cursor_4c_Dados.Descrs"
            .Width         = 500
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH
        WITH loc_oGrade.Column2.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Desconto"
        ENDWITH

        *-- Column3: percentual de desconto (localDes.Descos)
        WITH loc_oGrade.Column3
            .ControlSource = "cursor_4c_Dados.Descos"
            .Width         = 88
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH
        WITH loc_oGrade.Column3.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "% Desconto"
        ENDWITH

        *-- Column4: valor do desconto (localDes.Valdes)
        WITH loc_oGrade.Column4
            .ControlSource = "cursor_4c_Dados.Valdes"
            .Width         = 110
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH
        WITH loc_oGrade.Column4.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Valor Desconto"
        ENDWITH

        *-- Celulas digitaveis / bloqueadas das colunas 2, 3 e 4. Fica por
        *-- ULTIMO porque Column.ReadOnly tem de ser definido DEPOIS de
        *-- Grid.ReadOnly (o do grid propaga para as colunas e sobrescreve
        *-- o delas - regra CLAUDE.md #46).
        THIS.InstalarCelulasGrade(loc_oGrade)
    ENDPROC

    *==========================================================================
    * ConfigurarTotais - os TRES pares de total, filhos diretos do form:
    * Say2/lnValor ("Valor Original :"), Say4/lnTDesc ("Total Desconto :")
    * e Say1/lnSaldo ("Saldo :") do legado. Os dois primeiros vieram na
    * Fase 5; o terceiro entra aqui, completando os campos do dump - com
    * ele a tela cobre TODOS os objetos do layout.json.
    *
    * lnSaldo e' o campo que os dois Valid de celula LEEM para o teste
    * final do legado ("IF thisform.lnSaldo.Value < 0 ..."), entao ele e'
    * pre-requisito de ValidarPercentualDesconto/ValidarValorDesconto -
    * nao da' para adiar um sem adiar os outros.
    *
    * TabIndex do dump (33 nos tres Say, 38 nos tres campos) NAO e'
    * transcrito, de proposito: os tres campos tem TabStop = .F. (o When
    * Return(.F.) do legado) e Label nao entra na tabulacao, logo o
    * TabIndex deles e' inerte - e atribuir TabIndex em runtime RENUMERA
    * os demais controles do form, o que mexeria na ordem de tabulacao
    * real (cmg_4c_Botoes = 2, grd_4c_Dados = 1) sem nenhum ganho.
    *
    * Os tres campos (lnValor/lnTDesc/lnSaldo) tem PROCEDURE When
    * Return(.F.) no legado - nunca recebem foco, sao so EXIBICAO. Aqui
    * isso vira ReadOnly = .T. + TabStop = .F. (equivalente: a celula nunca
    * entra em edicao e o Tab pula o controle), sem precisar de evento.
    *
    * Geometria/InputMask TRANSCRITOS do dump (SIGOPDES.Say2/lnValor/Say4/
    * lnTDesc) - regra CLAUDE.md #49 (Format/InputMask nunca descartados).
    * ForeColor dos labels e' RGB(90,90,90), EXPLICITO no dump (nao e' o
    * caso de "classe say sem ForeColor" da regra CLAUDE.md #12).
    *
    * lnValor.Value nasce de THIS.this_oBusinessObject.this_nValor - esse
    * valor ja foi igualado a this_nUnitOrigs em InicializarForm, que e'
    * exatamente o que o Init legado faz ("this.lnValor.value =
    * crTpmMvItn.unitorigs"). lnTDesc.Value nasce 0: o legado so o
    * preenche dentro do motor CalcTots (Fase 7/8), disparado por acoes do
    * usuario (marcar/editar uma linha da grade) que ainda nao existem.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTotais()
        *-- lbl_4c_Label2 / txt_4c_LnValor: "Valor Original :" (Say2/lnValor)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 307
            .Left      = 368
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Valor Original :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_LnValor", "TextBox")
        WITH THIS.txt_4c_LnValor
            .Top           = 303
            .Left          = 452
            .Width         = 98
            .Height        = 23
            .FontName      = "Verdana"
            .FontSize      = 8
            .FontBold      = .F.
            .Alignment     = 1
            .InputMask     = "999,999,999.99"
            .MaxLength     = 10
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Value         = THIS.this_oBusinessObject.this_nValor
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label4 / txt_4c_LnTDesc: "Total Desconto :" (Say4/lnTDesc)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 308
            .Left      = 564
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Total Desconto :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_LnTDesc", "TextBox")
        WITH THIS.txt_4c_LnTDesc
            .Top           = 304
            .Left          = 654
            .Width         = 98
            .Height        = 23
            .FontName      = "Verdana"
            .FontSize      = 8
            .FontBold      = .F.
            .Alignment     = 1
            .InputMask     = "999,999,999.99"
            .MaxLength     = 10
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Value         = THIS.this_oBusinessObject.this_nTDesc
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label1 / txt_4c_LnSaldo: "Saldo :" (Say1/lnSaldo)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 330
            .Left      = 610
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Saldo :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_LnSaldo", "TextBox")
        WITH THIS.txt_4c_LnSaldo
            .Top           = 329
            .Left          = 654
            .Width         = 98
            .Height        = 23
            .FontName      = "Verdana"
            .FontSize      = 8
            .FontBold      = .F.
            .Alignment     = 1
            .InputMask     = "999,999,999.99"
            .MaxLength     = 10
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Value         = THIS.this_oBusinessObject.this_nSaldo
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do titulo (cntSombra do legado)
    *
    * Geometria TRANSCRITA do dump (SIGOPDES.cntSombra / lblSombra /
    * lblTitulo): Top 0 / Left 0 / Width 800 / Height 80 /
    * BackColor 100,100,100 / BorderWidth 0; lblSombra em Top 18
    * (sombra preta) e lblTitulo em Top 17 (texto branco por cima), ambos
    * Left 10 / Width 769, Tahoma 18 bold.
    *
    * AutoSize = .F. EXPLICITO nos dois labels: com WordWrap = .T. (que o
    * dump declara) um AutoSize = .T. DESCARTA a Height e colapsa o texto
    * para uma linha so (regra CLAUDE.md #23). As Width/Height aqui ja sao
    * as que o Form Designer calculou, entao fixa-las e' reproducao fiel.
    *
    * ForeColor BRANCO em lbl_4c_Titulo e' uma das excecoes legitimas da
    * regra CLAUDE.md #12: o container e' OPACO e escuro
    * (BackStyle = 1 + BackColor RGB(100,100,100)), nao a textura clara das
    * paginas de cadastro.
    *
    * Caption dos dois labels fica em branco aqui (so o Caption real, que
    * depende de THIS.Caption, e' aplicado em InicializarForm - igual ao
    * Init legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- lblSombra: sombra preta, desenhada 1px abaixo do titulo
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = ""
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: texto branco por cima da sombra
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = ""
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AcessoGradeCota - responde se a grade de cota (grd_4c_Cota) deve
    * aparecer. Legado: "THIS.grdCota.Visible = fChecaAcesso('SIGCDDES',
    * 'GERENTE')" - so o acesso GERENTE ve a cota da empresa.
    *
    * A chamada de 2 argumentos e' a do legado e esta FIEL: os 3
    * parametros restantes de fChecaAcesso tem fallback proprio dentro da
    * funcao (pUsu cai na PUBLIC Usuar, pMsg ausente nao exibe aviso).
    *
    * O guard de modo existe porque fChecaAcesso abre conexao propria
    * (CreateObject('fSqlConector') + SELECT em SigCdAcu): em validacao de
    * UI e em modo de teste nao ha banco, e a chamada ficaria pendurada
    * DENTRO do CREATEOBJECT do form, o que se le como "a tela nao
    * instancia" sem haver defeito nenhum de tela. Sem banco a grade de
    * cota nao teria o que mostrar de qualquer forma.
    *==========================================================================
    PROTECTED FUNCTION AcessoGradeCota()
        LOCAL loc_lAcesso

        loc_lAcesso = .F.

        IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
           (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
            loc_lAcesso = fChecaAcesso("SIGCDDES", "GERENTE")
        ENDIF

        RETURN loc_lAcesso
    ENDFUNC

    *==========================================================================
    * CarregarLista - carga das duas grades da tela, no mesmo ponto do
    * fluxo em que o Init legado as popula.
    *
    * Legado: o Init monta crDesc/crTipo/localDes e crSigCdDes e termina
    * ligando cada grade ao seu cursor
    * ("This.Grade.RecordSource = [localDes]" e
    *  "This.GrdCota.RecordSource = [crSigCdDes]") seguido de
    * "This.Refresh". Aqui as consultas vivem no BO (SigOpDesBO.
    * CarregarDescontos / CarregarCota), que recarrega cursor_4c_Dados e
    * cursor_4c_Cota com ZAP + APPEND FROM DBF() - a estrutura, o
    * RecordSource e os ControlSource sobrevivem - e o form apenas repinta.
    *
    * PUBLIC de proposito: o harness de teste automatizado chama
    * THIS.oForm.CarregarLista() de FORA da classe (PEMSTATUS devolve .T.
    * para metodo PROTECTED e a chamada real falharia em runtime).
    *
    * RETURN fica FORA do TRY/CATCH - o resultado passa pela flag.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_lCota, loc_lDescontos, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
                        "vel para carregar os descontos.", "Erro em CarregarLista")
            ELSE
                *-- A cota vem PRIMEIRO: CarregarCota resolve this_cCodigo
                *-- (o codigo da cota vigente), que a gravacao dos
                *-- descontos selecionados consome.
                loc_lCota      = THIS.this_oBusinessObject.CarregarCota()
                loc_lDescontos = THIS.this_oBusinessObject.CarregarDescontos()

                *-- Repintar SEMPRE, inclusive quando a carga falha: a
                *-- grade pode estar exibindo o conteudo de uma carga
                *-- anterior, e popular cursor nao repinta grade sozinho.
                THIS.MontaGrade()

                *-- BO -> tela: o Valor Original (legado: "this.lnValor.value
                *-- = crTpmMvItn.unitorigs") e os dois totais que a carga do
                *-- BO deixou nas properties. Tem de rodar ANTES do
                *-- CalcularTotais, porque CalcularTotais LE
                *-- txt_4c_LnValor.Value como base do rateio - inverter a
                *-- ordem calcularia percentual sobre o valor da carga
                *-- anterior, sem erro nenhum na tela.
                THIS.BOParaForm()

                *-- O Init legado termina com "=thisform.CalcTots()": a
                *-- tela abre com Total Desconto / Saldo ja refletindo os
                *-- descontos que MarcarDescontosGravados pre-selecionou, e
                *-- a cota utilizada ja somada. Sem esta chamada os tres
                *-- campos de total abririam zerados sobre uma grade com
                *-- linhas marcadas - divergencia muda, porque nada falha.
                THIS.CalcularTotais()

                loc_lSucesso = loc_lCota AND loc_lDescontos
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontaGrade - funil UNICO de repintura das duas grades.
    *
    * Popular um cursor NAO faz a grade ligada a ele exibir as linhas: o
    * legado sempre fecha a carga com "Go Top In <cursor>" +
    * "<grade>.Refresh", e sem isso a grade fica visualmente vazia com o
    * cursor cheio - sintoma que manda o diagnostico para SQL/permissao.
    * Por isso a repintura mora aqui e e' chamada por TODO caminho que
    * popula os cursores.
    *
    * ColumnCount NAO e' reatribuido: qualquer atribuicao a ColumnCount
    * recria os objetos Column e DESTRUIRIA o CheckBox posto por
    * AddObject em Column1 (com ele, a coluna de selecao da grade).
    *
    * O rebind completo (RecordSource -> ControlSource -> Width ->
    * Header1.Caption -> CurrentControl/Sparse) so roda quando o
    * RecordSource se perdeu, porque atribuir RecordSource RESETA Width,
    * Header1.Caption, Sparse e CurrentControl - refaze-lo a cada carga
    * seria apagar o que ConfigurarGrade acabou de montar. Na carga
    * normal (ZAP + APPEND FROM, que preserva o alias) basta o GO TOP +
    * Refresh.
    *==========================================================================
    PROCEDURE MontaGrade()
        LOCAL loc_oGrade, loc_oGrdCota, loc_oErro

        TRY
            *-- Grade principal de descontos
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
                loc_oGrade = THIS.grd_4c_Dados

                IF UPPER(ALLTRIM(loc_oGrade.RecordSource)) != "CURSOR_4C_DADOS"
                    THIS.VincularGrade()
                ENDIF

                SELECT cursor_4c_Dados
                GO TOP
                loc_oGrade.Refresh()
            ENDIF

            *-- Grade da cota da empresa
            IF PEMSTATUS(THIS, "grd_4c_Cota", 5) AND USED("cursor_4c_Cota")
                loc_oGrdCota = THIS.grd_4c_Cota

                IF UPPER(ALLTRIM(loc_oGrdCota.RecordSource)) != "CURSOR_4C_COTA"
                    THIS.VincularGradeCota()
                ENDIF

                SELECT cursor_4c_Cota
                GO TOP
                loc_oGrdCota.Refresh()
            ENDIF

            *-- Volta o alias corrente para a grade principal, que e' a
            *-- que recebe o foco e de onde os eventos de celula leem.
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em MontaGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VincularGrade - religa grd_4c_Dados a cursor_4c_Dados e repoe TUDO
    * que a atribuicao de RecordSource reseta.
    *
    * Atribuir RecordSource devolve Column.Width ao default 90, limpa
    * Header1.Caption, zera Sparse e derruba CurrentControl - entao a
    * ordem obrigatoria e' RecordSource -> ControlSource -> Width ->
    * Header1.Caption, e so DEPOIS o par CurrentControl/Sparse da coluna
    * do CheckBox. Os valores repostos aqui sao os MESMOS transcritos do
    * dump em ConfigurarGrade.
    *
    * ColumnCount fica de fora: reatribui-lo recriaria os Column e
    * destruiria o CheckBox de Column1.
    *==========================================================================
    PROTECTED PROCEDURE VincularGrade()
        LOCAL loc_oGrade

        loc_oGrade = THIS.grd_4c_Dados

        *-- Atribuir ColumnCount recria os objetos Column e DESTRUIRIA o
        *-- chk_4c_Selecao posto por AddObject em Column1: a coluna de
        *-- selecao voltaria a desenhar o Text1 dela e o usuario perderia o
        *-- unico jeito de marcar a linha. Por isso, aqui:
        *-- NAO reatribuir ColumnCount.
        loc_oGrade.RecordSource = "cursor_4c_Dados"

        loc_oGrade.Column1.ControlSource = "cursor_4c_Dados.Selecao"
        loc_oGrade.Column2.ControlSource = "cursor_4c_Dados.Descrs"
        loc_oGrade.Column3.ControlSource = "cursor_4c_Dados.Descos"
        loc_oGrade.Column4.ControlSource = "cursor_4c_Dados.Valdes"

        loc_oGrade.Column1.Width = 23
        loc_oGrade.Column2.Width = 500
        loc_oGrade.Column3.Width = 88
        loc_oGrade.Column4.Width = 110

        loc_oGrade.Column1.Header1.Caption = ""
        loc_oGrade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + ;
                                             "o do Desconto"
        loc_oGrade.Column3.Header1.Caption = "% Desconto"
        loc_oGrade.Column4.Header1.Caption = "Valor Desconto"

        *-- Sem CurrentControl a coluna volta a desenhar o Text1 dela e o
        *-- CheckBox de selecao, apesar de existir, nao aparece; sem
        *-- Sparse = .F. ele apareceria so na linha ativa.
        IF PEMSTATUS(loc_oGrade.Column1, "chk_4c_Selecao", 5)
            loc_oGrade.Column1.CurrentControl = "chk_4c_Selecao"
        ENDIF
        loc_oGrade.Column1.Sparse = .F.

        *-- As celulas de Column2/3/4 tambem se perdem no rebind
        *-- (RecordSource derruba CurrentControl), e sem elas a coluna de
        *-- descricao voltaria a aceitar digitacao e as duas colunas
        *-- editaveis perderiam o When/Valid do legado. InstalarCelulasGrade
        *-- e' idempotente: so chama AddObject quando o objeto nao existe.
        THIS.InstalarCelulasGrade(loc_oGrade)
    ENDPROC

    *==========================================================================
    * VincularGradeCota - religa grd_4c_Cota a cursor_4c_Cota e repoe o
    * que a atribuicao de RecordSource reseta (mesma regra de ordem de
    * VincularGrade). Legado: GrdCota.Column1/3/4.ControlSource apontam
    * emps / valcota / Valdes de crSigCdDes - aqui nas 3 Column em ordem
    * natural, com as larguras e captions do dump.
    *
    * Column.ReadOnly vai DEPOIS de Grid.ReadOnly: o do grid propaga para
    * as colunas e sobrescreveria o das colunas.
    *==========================================================================
    PROTECTED PROCEDURE VincularGradeCota()
        LOCAL loc_oGrdCota

        loc_oGrdCota = THIS.grd_4c_Cota

        *-- NAO reatribuir ColumnCount aqui: as 3 Column desta grade e as
        *-- larguras do dump sao montadas por ConfigurarGradeCota, e
        *-- reatribuir ColumnCount as recriaria do zero.
        loc_oGrdCota.RecordSource = "cursor_4c_Cota"

        loc_oGrdCota.Column1.ControlSource = "cursor_4c_Cota.Emps"
        loc_oGrdCota.Column2.ControlSource = "cursor_4c_Cota.Valcota"
        loc_oGrdCota.Column3.ControlSource = "cursor_4c_Cota.Valdes"

        loc_oGrdCota.Column1.Width = 75
        loc_oGrdCota.Column2.Width = 145
        loc_oGrdCota.Column3.Width = 169

        loc_oGrdCota.Column1.Header1.Caption = "Empresa"
        loc_oGrdCota.Column2.Header1.Caption = "Cota"
        loc_oGrdCota.Column3.Header1.Caption = "Utilizada"

        loc_oGrdCota.ReadOnly         = .T.
        loc_oGrdCota.Column1.ReadOnly = .T.
        loc_oGrdCota.Column2.ReadOnly = .T.
        loc_oGrdCota.Column3.ReadOnly = .T.
    ENDPROC

    *==========================================================================
    * InstalarCelulasGrade - poe em Column2/3/4 da grade principal a
    * SUBCLASSE de TextBox que carrega o When/Valid daquela celula no
    * legado, e liga cada uma por CurrentControl.
    *
    * POR QUE SUBCLASSE E NAO BINDEVENT (regra CLAUDE.md #46): a validacao
    * de celula de grade mora no Valid do TextBox da coluna, e BINDEVENT
    * em "Valid" de TextBox de Column nao e' confiavel - alem disso o
    * BINDEVENT DESCARTA o retorno do delegate, e aqui o retorno e' o
    * mecanismo: o Valid devolvendo .F. e' o que mantem o cursor na celula
    * depois de recusar o valor digitado, e o When devolvendo .F. e' o que
    * impede a entrada na celula. Nenhum dos dois efeitos sobrevive a um
    * BINDEVENT. AfterRowColChange tambem nao serve: ele dispara DEPOIS de
    * entrar na celula nova e o indice que ele recebe e' o da coluna de
    * DESTINO, nao o da coluna que o usuario acabou de deixar.
    *
    * Column.AddObject NAO basta para o controle aparecer (regra CLAUDE.md
    * #18): sem CurrentControl a coluna continua desenhando o Text1 dela, o
    * objeto existe, responde a PEMSTATUS e o When/Valid nunca roda. Por
    * isso as propriedades visuais que o dump declara em ColumnN.Text1 sao
    * aplicadas AQUI, na subclasse - ela e' que passa a desenhar a celula.
    *
    * Sparse fica no default (.T.) nas tres colunas, como no dump (que so
    * declara Sparse em Column1, a do CheckBox): as subclasses sao TextBox
    * e desenham igual ao Text1 que substituem, e o When/Valid de uma
    * Column roda na celula ATIVA, que e' justamente o que Sparse = .T. ja
    * instancia. Forcar Sparse = .F. aqui instanciaria um controle por
    * linha visivel sem mudar nada do que se ve.
    *
    * IDEMPOTENTE de proposito: AddObject duas vezes com o mesmo nome no
    * mesmo alvo estoura "Object is already defined" e derrubaria o Init.
    * VincularGrade chama este metodo depois de cada rebind, porque
    * atribuir RecordSource derruba CurrentControl.
    *==========================================================================
    PROTECTED PROCEDURE InstalarCelulasGrade(par_oGrade)
        IF VARTYPE(par_oGrade) != "O"
            RETURN
        ENDIF

        *-- Column2: descricao do tipo de desconto. O legado NAO usa
        *-- ReadOnly aqui (o dump declara Column2.ReadOnly = .F.) - quem
        *-- bloqueia a digitacao e' o "When / Return .f." do Text1, e e'
        *-- esse o mecanismo reproduzido. Transcrever so o ReadOnly = .F.
        *-- do dump e parar ai deixaria a descricao do desconto EDITAVEL.
        IF !PEMSTATUS(par_oGrade.Column2, "txt_4c_CelDescricao", 5)
            par_oGrade.Column2.AddObject("txt_4c_CelDescricao", ;
                                          "TextBoxCelDescricaoSigOpDes_4c")
        ENDIF
        WITH par_oGrade.Column2.txt_4c_CelDescricao
            .BorderStyle = 0
            .InputMask   = ""
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH
        par_oGrade.Column2.CurrentControl = "txt_4c_CelDescricao"

        *-- Column3: percentual de desconto (localDes.Descos)
        IF !PEMSTATUS(par_oGrade.Column3, "txt_4c_CelPercentual", 5)
            par_oGrade.Column3.AddObject("txt_4c_CelPercentual", ;
                                          "TextBoxCelPercentualSigOpDes_4c")
        ENDIF
        WITH par_oGrade.Column3.txt_4c_CelPercentual
            .BorderStyle = 0
            .InputMask   = "999.99"
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH
        par_oGrade.Column3.CurrentControl = "txt_4c_CelPercentual"

        *-- Column4: valor do desconto (localDes.Valdes)
        IF !PEMSTATUS(par_oGrade.Column4, "txt_4c_CelValor", 5)
            par_oGrade.Column4.AddObject("txt_4c_CelValor", ;
                                          "TextBoxCelValorSigOpDes_4c")
        ENDIF
        WITH par_oGrade.Column4.txt_4c_CelValor
            .BorderStyle = 0
            .Format      = "999,999,999.99"
            .InputMask   = ""
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH
        par_oGrade.Column4.CurrentControl = "txt_4c_CelValor"

        *-- Column.ReadOnly por ULTIMO: Grid.ReadOnly propaga para as
        *-- colunas e sobrescreve o delas (regra CLAUDE.md #46). Os tres
        *-- valores sao os do dump (ColumnN.ReadOnly = .F.).
        par_oGrade.Column2.ReadOnly = .F.
        par_oGrade.Column3.ReadOnly = .F.
        par_oGrade.Column4.ReadOnly = .F.
    ENDPROC

    *==========================================================================
    * ValorNumerico - devolve SEMPRE um numero a partir do .Value de um
    * campo de total.
    *
    * Os tres campos de total nascem numericos, mas um TextBox com
    * InputMask pode devolver Caractere depois de passar por digitacao, e
    * uma conta sobre Caractere estoura em runtime no meio do Valid - erro
    * que aparece como "a celula nao aceita o valor" sem dizer por que.
    *==========================================================================
    PROTECTED FUNCTION ValorNumerico(par_uValor)
        LOCAL loc_nValor, loc_cTipo

        loc_nValor = 0
        loc_cTipo  = VARTYPE(par_uValor)

        DO CASE
            CASE loc_cTipo = "N"
                loc_nValor = par_uValor
            CASE loc_cTipo = "C"
                loc_nValor = VAL(CHRTRAN(ALLTRIM(par_uValor), ",", ""))
        ENDCASE

        RETURN loc_nValor
    ENDFUNC

    *==========================================================================
    * DescontoEntraNaCota - responde se o tipo de desconto consome a cota
    * de desconto da empresa.
    *
    * Legado: "!INLIST(crDesc.tpdesc, 1, 2, 9, 11)" no teste de cota dos
    * dois Valid. Os quatro tipos de FORA sao aniversario (1), financeiro
    * (2), diretoria (9) e extra/loja (11).
    *
    * Esta lista NAO e' a mesma do somatorio da cota em CalcularTotais
    * ("!INLIST(tpdesc, 1, 2, 6, 7, 10, 11, 12, 13)"): o legado tem DUAS
    * listas diferentes, uma para SOMAR a cota e outra para COBRAR o
    * estouro, e unifica-las mudaria a regra de negocio. Cada uma fica no
    * seu lugar, transcrita.
    *==========================================================================
    PROTECTED FUNCTION DescontoEntraNaCota(par_nTpDesc)
        RETURN !INLIST(THIS.ValorNumerico(par_nTpDesc), 1, 2, 9, 11)
    ENDFUNC

    *==========================================================================
    * CotaEstourada - responde se a cota de desconto da empresa foi
    * excedida. Legado: "crSigCdDes.valdes > crSigCdDes.valcota".
    *
    * Le cursor_4c_Cota (crSigCdDes do legado) na linha corrente, que
    * CarregarCota deixa posicionada na empresa do movimento e
    * CalcularTotais mantem atualizada. Cota ausente (cursor vazio) NAO
    * bloqueia: o legado, com crSigCdDes vazio, compara dois campos
    * inexistentes e o teste da .F. - recusar a gravacao por falta de
    * cadastro de cota seria inventar bloqueio.
    *==========================================================================
    PROTECTED FUNCTION CotaEstourada()
        LOCAL loc_lEstourou

        loc_lEstourou = .F.

        IF USED("cursor_4c_Cota") AND !EOF("cursor_4c_Cota")
            loc_lEstourou = (NVL(cursor_4c_Cota.Valdes, 0) > ;
                             NVL(cursor_4c_Cota.Valcota, 0))
        ENDIF

        RETURN loc_lEstourou
    ENDFUNC

    *==========================================================================
    * CalcularTotais - o PROCEDURE calctots do legado.
    *
    * Motor de totais da tela: normaliza a linha corrente, soma os
    * descontos, atualiza a cota utilizada da empresa e escreve os tres
    * campos de total. TRANSCRITO linha a linha (regra CLAUDE.md #17 - a
    * formula, o ROUND, o /100 e o SINAL sao regra de negocio):
    *
    *   replace descos with IIF(selecao = 0, 00.0000, descos)
    *   replace valdes with IIF(selecao = 0, 000000000.00,
    *                           ROUND(lnvalor.value * descos / 100, 2))
    *   lnReg = IIF(EOF('localdes'), 0, RECNO())
    *   GO top / SUM valdes to lnTDesc
    *   GO top / SUM valdes to lnTDescI for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
    *   SELECT crSigmvitd / GO top
    *   SUM vdes to lnTDescM for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
    *                           AND citens <> pcItem
    *   replace valdes with crValdes.vdes + lnTDescI + lnTDescM in crSigCdDes
    *   lnSaldo = lnvalor.value - lnTDesc
    *   lnSaldo.Value = lnSaldo / lnTdesc.Value = lnTDesc
    *   IF lnReg <> 0 / GO lnReg / endif
    *   thisform.Refresh
    *
    * Os dois primeiros REPLACE sao SEM escopo no legado, isto e' valem
    * para a linha CORRENTE e nao para o cursor inteiro - quem muda e' a
    * linha que o usuario acabou de marcar ou editar.
    *
    * lnTDescM (descontos JA GRAVADOS dos OUTROS itens do movimento) vem
    * de crSigmvitd, cursor global do form chamador que esta arquitetura
    * nao tem: a soma e' resolvida uma vez na carga por
    * SigOpDesBO.CarregarDescontoOutrosItens e lida aqui da propriedade
    * this_nVDescOutrosItens. Uma vez e' suficiente e nao e' atalho - esta
    * tela edita UM item, os outros nao mudam enquanto o dialogo esta
    * aberto, e o legado tambem nao os reconsulta (ele so re-soma um
    * cursor que ninguem alterou).
    *
    * A base da cota (crValdes.vdes do legado) e' lida de this_nValDes e
    * NAO de cursor_4c_Cota.Valdes, porque esta mesma rotina SOBRESCREVE
    * essa coluna do cursor: ler dali faria a cota utilizada crescer de
    * forma acumulada a cada tecla digitada.
    *
    * RECNO e' salvo e reposto porque SUM varre o cursor inteiro e deixa o
    * ponteiro em EOF - sem repor, a linha que o usuario esta editando
    * deixaria de ser a linha corrente no meio do proprio Valid.
    *
    * PUBLIC: os eventos da Fase 7/8 (Click do checkbox de cada linha,
    * Header1.Click de selecionar-tudo) acionam este metodo de fora.
    *==========================================================================
    PROCEDURE CalcularTotais()
        LOCAL loc_nReg, loc_nSaldo, loc_nTDesc, loc_nTDescI, loc_nTDescM
        LOCAL loc_nValor, loc_nBaseCota, loc_oErro

        TRY
            IF !USED("cursor_4c_Dados")
                MsgErro("Cursor de descontos indispon" + CHR(237) + "vel " + ;
                        "para calcular os totais.", "Erro em CalcularTotais")
            ELSE
                loc_nValor = THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)

                SELECT cursor_4c_Dados

                *-- Linha corrente: desmarcada zera os dois campos, marcada
                *-- recalcula o valor a partir do percentual.
                IF !EOF("cursor_4c_Dados")
                    IF NVL(cursor_4c_Dados.Selecao, 0) = 0
                        REPLACE Descos WITH 0, ;
                                Valdes WITH 0 ;
                            IN cursor_4c_Dados
                    ELSE
                        REPLACE Valdes WITH ROUND(loc_nValor * ;
                                NVL(cursor_4c_Dados.Descos, 0) / 100, 2) ;
                            IN cursor_4c_Dados
                    ENDIF
                ENDIF

                loc_nReg = IIF(EOF("cursor_4c_Dados"), 0, RECNO("cursor_4c_Dados"))

                *-- Total de desconto do item: TODAS as linhas
                GO TOP IN cursor_4c_Dados
                SUM cursor_4c_Dados.Valdes TO loc_nTDesc

                *-- Parcela que CONSOME a cota da empresa: ficam de fora
                *-- aniversario(1), financeiro(2), troca zerada(6),
                *-- up diamond(7), upgrade alianca(10), extra/loja(11),
                *-- brinde(12) e troca de preco(13).
                GO TOP IN cursor_4c_Dados
                SUM cursor_4c_Dados.Valdes TO loc_nTDescI ;
                    FOR !INLIST(NVL(cursor_4c_Dados.Tpdesc, 0), ;
                                1, 2, 6, 7, 10, 11, 12, 13)

                loc_nTDescM   = 0
                loc_nBaseCota = 0

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    loc_nTDescM   = THIS.ValorNumerico( ;
                        THIS.this_oBusinessObject.this_nVDescOutrosItens)
                    loc_nBaseCota = THIS.ValorNumerico( ;
                        THIS.this_oBusinessObject.this_nValDes)
                ENDIF

                *-- Cota utilizada da empresa = acumulado gravado em
                *-- SigCdDes + o que esta tela esta aplicando neste item +
                *-- o que os outros itens do movimento ja gravaram.
                IF USED("cursor_4c_Cota") AND !EOF("cursor_4c_Cota")
                    REPLACE Valdes WITH loc_nBaseCota + loc_nTDescI + loc_nTDescM ;
                        IN cursor_4c_Cota
                ENDIF

                *-- SINAL preservado: o legado NAO zera saldo negativo - e'
                *-- justamente o saldo negativo que os Valid das celulas
                *-- testam para recusar desconto maior que o produto.
                loc_nSaldo = loc_nValor - loc_nTDesc

                THIS.txt_4c_LnTDesc.Value = loc_nTDesc
                THIS.txt_4c_LnSaldo.Value = loc_nSaldo

                *-- Espelho no BO: a gravacao le os totais de la, e deixar
                *-- a tela como unica fonte faria o registro gravar os
                *-- valores da carga em vez dos que estao na tela.
                *--
                *-- Pelo FormParaBO, nao por atribuicao direta: os TextBox
                *-- acabaram de receber os valores novos, e FormParaBO e' o
                *-- unico lugar que sabe le-los (inclusive tolerando o
                *-- Caractere que o InputMask pode devolver). Atribuir aqui
                *-- tambem deixaria DOIS lugares espelhando as mesmas
                *-- properties, que foi exatamente o que esta fase desfez.
                THIS.FormParaBO()

                SELECT cursor_4c_Dados
                IF loc_nReg <> 0 AND loc_nReg <= RECCOUNT("cursor_4c_Dados")
                    GO loc_nReg IN cursor_4c_Dados
                ENDIF

                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CalcularTotais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - cmg_4c_Botoes.Buttons(1) (Command1 do dump).
    *
    * Legado: "PROCEDURE btnSair.Click / ThisForm.Release" - nenhuma outra
    * logica, nenhuma confirmacao. Cancelar fecha o dialogo sem gravar nada.
    *
    * POR QUE "Cancelar" E NAO "Sair": o handler e' nomeado pela ACAO que o
    * usuario ve, nao pelo nome do objeto legado. O dump de SIGOPDES.cntBotoes
    * da' a Command1 "Caption = \<Cancelar", "ToolTipText = [Esc] Encerrar" e
    * "Cancel = .T." - o botao na tela diz CANCELAR; "btnSair" e' so o .Name
    * interno do objeto no SCX. Herdar o nome do objeto faria o metodo divergir
    * do que a tela mostra e do nome canonico do pipeline para o caminho de
    * "fechar sem gravar".
    *
    * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - cmg_4c_Botoes.Buttons(2) (btnConfirmar do legado).
    *
    * Legado (PROCEDURE btnConfirmar.Click):
    *
    *   ThisForm.Grade.Refresh
    *   Select localDes / Go Top In localDes / ThisForm.Grade.Refresh
    *   SELECT crsigmvitd
    *   DELETE all for cpros = crTpmMvItn.cpros and citens = crTpmMvItn.citens
    *   Select localDes / DELETE ALL for descos = 0 / GO top
    *   SCAN
    *       If (localDes.Selecao = 1)
    *           lcIdChave = fUniqueIds()
    *           INSERT into crSigmvItd (...) values (...)
    *       ENDIF
    *   ENDSCAN
    *   ThisForm.Release
    *
    * "DELETE ALL for descos = 0" marca deletadas (SET DELETED liga) as
    * linhas com desconto zero, e o SCAN so insere as que sobrevivem E tem
    * Selecao = 1 - equivalente a "Selecao = 1 AND Descos <> 0", que e' o
    * filtro usado no SCAN de ConfirmarSelecaoExec.
    *
    * O par wrapper + Exec existe pela mesma razao de ValidarPercentualDesconto
    * (regra CLAUDE.md #1): o corpo tem SCAN/loop e chamadas de BO que podem
    * estourar, e o Release() final tem de rodar FORA do TRY. Release()
    * acontece SEMPRE, inclusive apos erro - igual ao legado, que nao tem
    * TRY/CATCH nenhum e sempre libera o dialogo no fim.
    *
    * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro

        TRY
            THIS.ConfirmarSelecaoExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnConfirmarClick")
        ENDTRY

        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfirmarSelecaoExec - corpo do btnConfirmar.Click: remove os
    * descontos anteriores do item e regrava, em SigMvItd, uma linha para
    * cada tipo de desconto marcado na grade com valor diferente de zero.
    *
    * SigOpDesBO.ExcluirDescontosDoItem() substitui o
    * "DELETE all for cpros = ... and citens = ..." em crsigmvitd (cursor
    * global do form chamador): aqui a tabela e' acessada direto, restrita
    * ao mesmo par cpros/citens.
    *
    * Cada iteracao do SCAN preenche no BO exatamente as colunas que o
    * INSERT do legado usa alem do contexto fixo do item (ja presente nas
    * properties this_cCpros/this_nCitens/this_cEmps/this_cDopes/
    * this_nNumes, herdadas do Init do form): Cdesc/Ddesc/Pdes/Vdes/TpDesc/
    * Usuars vem da linha corrente de cursor_4c_Dados, ValBase vem de
    * this_nUnitOrigs (legado: "crTpmMvItn.unitorigs") e Codigo (a cota
    * vigente, "crSigcdDes.codigo") ja foi resolvido por
    * SigOpDesBO.CarregarCota na abertura da tela e permanece em
    * this_oBusinessObject.this_cCodigo.
    *
    * this_cCidChaves e' zerado ANTES de cada Inserir(): e' o gatilho que faz
    * Inserir() gerar um fUniqueIds() NOVO por linha (regra CLAUDE.md #22) -
    * equivalente a "lcIdChave = fUniqueIds()" dentro do SCAN do legado.
    *==========================================================================
    PROCEDURE ConfirmarSelecaoExec()
        LOCAL loc_lExcluiu

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
                    "vel para confirmar a sele" + CHR(231) + CHR(227) + "o.", ;
                    "Erro em BtnConfirmarClick")
            RETURN
        ENDIF

        *-- Contexto do item/movimento + os totais que estao na TELA, numa
        *-- chamada so e FORA do SCAN: o contexto e' o MESMO para todas as
        *-- linhas gravadas (e' sempre o mesmo item), entao reatribui-lo a
        *-- cada iteracao so criava um segundo lugar para divergir do
        *-- InicializarForm. Dentro do SCAN ficam APENAS os campos que
        *-- mudam de linha para linha.
        THIS.FormParaBO()

        loc_lExcluiu = THIS.this_oBusinessObject.ExcluirDescontosDoItem()

        IF !loc_lExcluiu
            RETURN
        ENDIF

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        GO TOP

        SCAN FOR NVL(Selecao, 0) = 1 AND NVL(Descos, 0) <> 0
            WITH THIS.this_oBusinessObject
                *-- this_cCidChaves zerado a cada volta e' o gatilho que faz
                *-- Inserir() gerar um fUniqueIds() NOVO por linha (regra
                *-- CLAUDE.md #22) - equivalente ao "lcIdChave =
                *-- fUniqueIds()" dentro do SCAN do legado. Sem isto a
                *-- segunda linha colidiria no indice unico.
                .this_cCidChaves = ""

                *-- Campos da LINHA corrente da grade (legado: localdes.*)
                .this_cCdesc     = cursor_4c_Dados.Codigos
                .this_cDdesc     = cursor_4c_Dados.Descrs
                .this_nPdes      = cursor_4c_Dados.Descos
                .this_nVdes      = cursor_4c_Dados.Valdes
                .this_nTpDesc    = cursor_4c_Dados.Tpdesc
                .this_cUsuars    = cursor_4c_Dados.Usuars

                *-- Base do desconto (legado: crTpmMvItn.unitorigs)
                .this_nValBase   = THIS.this_nUnitOrigs
            ENDWITH

            THIS.this_oBusinessObject.Inserir()

            SELECT cursor_4c_Dados
        ENDSCAN
    ENDPROC

    *==========================================================================
    * Header1Click - SIGOPDES.Grade.Column1.Header1.Click (selecionar/
    * desmarcar TODAS as linhas da grade principal).
    *
    * Legado:
    *
    *   If (This.parent.Header1.Tag = [X])
    *       This.parent.Header1.Tag = [ ]
    *       Update localDes Set Selecao = 0
    *   Else
    *       This.parent.Header1.Tag = [X]
    *       Update localDes Set Selecao = 1
    *   EndIf
    *   ThisForm.Grade.Refresh
    *
    * This.parent.Header1 e' o proprio Header1 (This.parent = Column1) - o
    * Tag dele guarda o estado do toggle entre um clique e outro, igual ao
    * que fica aqui em loc_oHeader.Tag (propriedade nativa, generica, de
    * qualquer objeto VFP).
    *
    * NAO chama CalcularTotais - e' FIEL ao legado, que tambem so faz o
    * Update + Refresh aqui. "Selecionar tudo" marca Selecao em TODAS as
    * linhas sem passar pela autorizacao (SigOpSen) que o Click do checkbox
    * individual cobra - e' o mesmo comportamento do legado, nao uma lacuna
    * desta migracao.
    *
    * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE Header1Click()
        LOCAL loc_oHeader, loc_oErro

        TRY
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
                loc_oHeader = THIS.grd_4c_Dados.Column1.Header1

                IF ALLTRIM(NVL(loc_oHeader.Tag, "")) == "X"
                    loc_oHeader.Tag = ""
                    UPDATE cursor_4c_Dados SET Selecao = 0
                ELSE
                    loc_oHeader.Tag = "X"
                    UPDATE cursor_4c_Dados SET Selecao = 1
                ENDIF

                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Header1Click")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkSelecaoClick / ChkSelecaoMouseDown / ChkSelecaoMouseUp /
    * ChkSelecaoKeyPress - os quatro handlers do checkbox de selecao de
    * Column1 (fwcheckbox1 do legado).
    *
    * Regra CLAUDE.md "CheckBox em coluna de Grid": o toggle nativo NAO e'
    * confiavel dentro de Column (Column.AddObject + CurrentControl +
    * Sparse = .F.), entao Click/MouseDown so suprimem (NODEFAULT) e
    * MouseUp/KeyPress(Enter=13/Espaco=32) sao quem de fato aciona o
    * ChkSelecaoToggle - equivalente ao "clicar no checkbox" do legado, cujo
    * Click comeca com "=DoDefault()" (toggle nativo) e so DEPOIS reage ao
    * this.Value resultante.
    *
    * Todos PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE ChkSelecaoClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkSelecaoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkSelecaoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkSelecaoToggle()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkSelecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.ChkSelecaoToggle()
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkSelecaoToggle - wrapper com TRY/CATCH de ChkSelecaoToggleExec
    * (regra CLAUDE.md #1 - RETURN fica fora do TRY; o Exec tem RETURN
    * antecipado e roda sem TRY proprio).
    *
    * PUBLIC: chamado pelos quatro handlers acima.
    *==========================================================================
    PROCEDURE ChkSelecaoToggle()
        LOCAL loc_oErro

        TRY
            THIS.ChkSelecaoToggleExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ChkSelecaoToggle")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkSelecaoToggleExec - corpo do fwcheckbox1.Click do legado.
    *
    * Legado:
    *
    *   =DoDefault()
    *   IF this.Value = 0
    *       thisform.calctots() / return
    *   ENDIF
    *   if INLIST(localdes.tpdesc,3,4,5,11,12,13)   && desconto de gerente
    *       Do Form SigOpSen With 'CANCITEM','Libera Desconto','' To _Retorno
    *       llOk = ( Left( _Retorno, 1 ) = "*" )
    *       If !llOk
    *           MessageBox('Autorizacao nao Confirmada!!',0+48,'')
    *           thisform.grade.column1.Fwcheckbox1.Value=0
    *           thisform.grade.Refresh
    *       ELSE
    *           replace usuars with SUBSTR(_Retorno,2) in localdes
    *       EndIf
    *       thisform.calctots() / RETURN .t.
    *   ENDIF
    *   if INLIST(localdes.tpdesc,8)   && desconto supervisor
    *       Do Form SigOpSen With 'LIBFPAG', ... (mesma logica)
    *   ENDIF
    *   if INLIST(localdes.tpdesc,9)   && desconto diretoria
    *       Do Form SigOpSen With 'SDINSUF', ... (mesma logica)
    *   ENDIF
    *   thisform.calctots() / RETURN .t.
    *
    * As TRES chamadas de SigOpSen do legado sao o MESMO dialogo com
    * programa (1o parametro) diferente - aqui e' um DO CASE que resolve o
    * programa pelo Tpdesc e um UNICO bloco de autorizacao, sem repetir a
    * logica tres vezes.
    *
    * SigOpSen NAO EXISTE na nova arquitetura (ver
    * feedback_sigopsen_ausente_gate_autorizacao): o sigopsen.SCX so existe
    * na pasta do legado, fora do SET PATH, e "DO FORM SigOpSen" dispara
    * erro 1 "File ... does not exist." em runtime. Por ser gate de
    * AUTORIZACAO, a falha e' tratada FAIL-CLOSED - dialogo indisponivel =>
    * NAO autorizado, mesmo desfecho do "Autorizacao nao Confirmada" do
    * legado - e a ausencia fica VISIVEL em MsgErro (regra CLAUDE.md #27),
    * nunca mascarada/substituida por um MsgConfirma. O TRY cobre SO a
    * chamada do dialogo (regra CLAUDE.md #29); avaliacao do retorno e
    * gravacao ficam FORA do bloco.
    *
    * O toggle (REPLACE Selecao) acontece ANTES do teste de autorizacao,
    * igual ao legado: a' DoDefault() ja alternou this.Value quando o Click
    * comeca a rodar.
    *==========================================================================
    PROTECTED PROCEDURE ChkSelecaoToggleExec()
        LOCAL loc_nNovoValor, loc_nTpDesc, loc_cPrograma
        LOCAL loc_cRetorno, loc_lAutorizado, loc_lDialogoAbriu, loc_cFalhaDialogo
        LOCAL loc_oErroSen

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_nNovoValor = IIF(NVL(cursor_4c_Dados.Selecao, 0) = 0, 1, 0)
        REPLACE Selecao WITH loc_nNovoValor IN cursor_4c_Dados

        IF loc_nNovoValor = 0
            THIS.CalcularTotais()
            RETURN
        ENDIF

        loc_nTpDesc   = NVL(cursor_4c_Dados.Tpdesc, 0)
        loc_cPrograma = ""

        DO CASE
            CASE INLIST(loc_nTpDesc, 3, 4, 5, 11, 12, 13)
                loc_cPrograma = "CANCITEM"
            CASE loc_nTpDesc = 8
                loc_cPrograma = "LIBFPAG"
            CASE loc_nTpDesc = 9
                loc_cPrograma = "SDINSUF"
        ENDCASE

        IF !EMPTY(loc_cPrograma)
            loc_cRetorno      = ""
            loc_cFalhaDialogo = ""
            loc_lDialogoAbriu = .F.

            TRY
                DO FORM SigOpSen WITH loc_cPrograma, "Libera Desconto", "" TO loc_cRetorno
                loc_lDialogoAbriu = .T.
            CATCH TO loc_oErroSen
                loc_cFalhaDialogo = loc_oErroSen.Message
            ENDTRY

            CLEAR TYPEAHEAD

            loc_lAutorizado = (loc_lDialogoAbriu AND ;
                               LEFT(ALLTRIM(NVL(loc_cRetorno, "")), 1) = "*")

            IF !loc_lAutorizado
                IF loc_lDialogoAbriu
                    MsgAviso("Autoriza" + CHR(231) + CHR(227) + "o n" + ;
                             CHR(227) + "o Confirmada!!", "")
                ELSE
                    *-- FAIL-CLOSED: sem o dialogo de senha nao se libera
                    *-- nenhum desconto que exija autorizacao.
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel abrir a tela de autoriza" + CHR(231) + ;
                            CHR(227) + "o (SigOpSen)." + CHR(13) + ;
                            "O desconto N" + CHR(195) + "O foi liberado." + ;
                            CHR(13) + CHR(13) + "Detalhe: " + loc_cFalhaDialogo, ;
                            "Libera Desconto")
                ENDIF

                REPLACE Selecao WITH 0 IN cursor_4c_Dados
                THIS.grd_4c_Dados.Refresh()
            ELSE
                REPLACE Usuars WITH SUBSTR(loc_cRetorno, 2) IN cursor_4c_Dados
            ENDIF
        ENDIF

        THIS.CalcularTotais()
    ENDPROC

    *==========================================================================
    * ValidarPercentualDesconto - o PROCEDURE Valid de
    * SIGOPDES.Grade.Column3.Text1 (celula "% Desconto").
    *
    * Chamado pelo Valid da subclasse txt_4c_CelPercentual, que e' o
    * CurrentControl da coluna. O retorno E' o mecanismo: .F. mantem o
    * cursor na celula e recusa a saida; .T. libera.
    *
    * PUBLIC porque quem chama e' a subclasse da celula, de FORA da classe
    * do form (regra CLAUDE.md #51 - metodo chamado de fora nunca pode ser
    * PROTECTED em nivel nenhum da heranca).
    *
    * O par wrapper + Exec existe por causa da regra CLAUDE.md #1: o corpo
    * tem tres RETURN antecipados (um por regra recusada), e RETURN dentro
    * de TRY/CATCH e' proibido. O wrapper fica com o TRY e com o RETURN
    * unico; o Exec, sem TRY, pode usar os RETURN do legado.
    *==========================================================================
    PROCEDURE ValidarPercentualDesconto(par_oTxt)
        LOCAL loc_lValido, loc_oErro

        loc_lValido = .T.

        TRY
            loc_lValido = THIS.ValidarPercentualDescontoExec(par_oTxt)
        CATCH TO loc_oErro
            *-- Falha de infraestrutura NAO prende o usuario na celula: o
            *-- erro e' exibido e a saida e' liberada. Recusar a saida aqui
            *-- deixaria a tela travada na celula, sem o usuario ter como
            *-- sair a nao ser pelo Cancelar.
            loc_lValido = .T.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarPercentualDesconto")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ValidarPercentualDescontoExec - corpo do Valid da coluna "% Desconto".
    *
    * Transcricao do legado, regra por regra:
    *
    *   SELECT crDesc / LOCATE for codigos = localdes.codigos
    *   IF this.Value > crDesc.descosmax -> "Desconto maior que o permitido"
    *   IF crDesc.tpdesc = 2 and RECCOUNT('crPar') <> 0 and this.Value > 0
    *      -> "Desconto nao permitido para pagamento parcelado."
    *   thisform.calctots()
    *   IF (lnSaldo.Value < 0) or (crSigCdDes.valdes > crSigCdDes.valcota
    *      and !INLIST(crDesc.tpdesc,1,2,9,11))
    *      -> "Desconto maior que o permitido"
    *
    * O LOCATE do legado procura em crDesc a linha de MESMO codigos da
    * linha corrente de localDes. Nesta arquitetura crDesc e localDes
    * foram FUNDIDOS num cursor so (cursor_4c_Dados, montado por
    * SigOpDesBO.CarregarDescontos: Descos/Valdes sao as colunas editaveis
    * de localDes e Descosmax/Tpdesc/Codigos vem de crDesc), entao "a
    * linha de crDesc com o mesmo codigos" E' a linha corrente - o LOCATE
    * deixa de ser necessario em vez de ser descartado.
    *
    * REVERSAO SEMPRE PARA ZERO, e isso NAO e' simplificacao: o legado
    * reverte com "this.Value = crDesc.descos", e crDesc.descos vale 0 em
    * TODA linha - o Init legado faz "replace all descos with 0.00 in
    * crDesc" e nada mais escreve nessa coluna de crDesc (os REPLACE de
    * edicao e de calctots vao todos para localDes). Reverter para
    * cursor_4c_Dados.Descos seria reverter para o valor que o usuario
    * acabou de digitar, ou seja nao reverter nada.
    *
    * DIVERGENCIA CONHECIDA, de um unico tipo de desconto: o teto cobrado
    * aqui e' cursor_4c_Dados.Descosmax, que para o tipo 13 (troca de
    * preco) ja vem SOBRESCRITO pelo percentual da troca
    * (FiltrarElegibilidade, passo 3, espelhando "replace descosmax with
    * crPre.descos in localDes for tpdesc = 13"). No legado o Valid le
    * crDesc.descosmax, que e' o teto do CADASTRO - la a sobrescrita foi
    * para localDes e o Valid nao a ve. A fusao dos dois cursores foi
    * decidida nas Fases 1-2 e nao se desfaz aqui; o efeito e' que o tipo
    * 13 passa a ser cobrado pelo teto da troca de preco em vez do teto do
    * cadastro. Esta e' a unica coluna do dump em que os dois divergem.
    *
    * O cursor recebe o valor digitado ANTES de CalcularTotais: dentro do
    * Valid o valor esta em par_oTxt.Value e o cursor so recebe DEPOIS
    * (regra CLAUDE.md #46), mas o teste final do legado le o Saldo que
    * calctots produz A PARTIR DO CURSOR - sem gravar antes, o teste
    * julgaria o valor ANTERIOR e deixaria passar o desconto recusado.
    *==========================================================================
    PROTECTED FUNCTION ValidarPercentualDescontoExec(par_oTxt)
        LOCAL loc_nDigitado, loc_nTeto, loc_nTpDesc

        IF VARTYPE(par_oTxt) != "O" OR !USED("cursor_4c_Dados") OR ;
           EOF("cursor_4c_Dados")
            RETURN .T.
        ENDIF

        loc_nDigitado = THIS.ValorNumerico(par_oTxt.Value)
        loc_nTeto     = NVL(cursor_4c_Dados.Descosmax, 0)
        loc_nTpDesc   = NVL(cursor_4c_Dados.Tpdesc, 0)

        *-- Regra 1: percentual acima do teto do tipo de desconto
        IF loc_nDigitado > loc_nTeto
            MsgAviso("Desconto maior que o permitido", "Aviso")
            THIS.ReverterCelulaDesconto(par_oTxt)
            RETURN .F.
        ENDIF

        *-- Regra 2: desconto financeiro (tipo 2) nao existe em venda
        *-- parcelada (legado: RECCOUNT('crPar') <> 0)
        IF loc_nTpDesc = 2 AND THIS.this_nQtdParcelas <> 0 AND loc_nDigitado > 0
            MsgAviso("Desconto n" + CHR(227) + "o permitido para pagamento " + ;
                     "parcelado.", "Aviso")
            THIS.ReverterCelulaDesconto(par_oTxt)
            RETURN .F.
        ENDIF

        *-- Valor aceito ate aqui: grava no cursor e recalcula os totais
        REPLACE Descos WITH loc_nDigitado IN cursor_4c_Dados
        THIS.CalcularTotais()

        *-- Regra 3: desconto maior que o produto (saldo negativo) ou cota
        *-- da empresa estourada por um tipo que consome cota
        IF THIS.ValorNumerico(THIS.txt_4c_LnSaldo.Value) < 0 OR ;
           (THIS.CotaEstourada() AND THIS.DescontoEntraNaCota(loc_nTpDesc))
            MsgAviso("Desconto maior que o permitido", "Aviso")
            THIS.ReverterCelulaDesconto(par_oTxt)
            THIS.CalcularTotais()

            *-- Legado: "RETURN IIF(this.Value = 0, .t., .f.)" - depois da
            *-- reversao o campo vale 0, logo a saida da celula e'
            *-- LIBERADA (o legado nao prende o usuario numa celula que ele
            *-- acabou de ver ser zerada). A expressao e' transcrita em vez
            *-- de pre-resolvida para continuar valendo se a reversao
            *-- deixar de ser zero.
            RETURN IIF(THIS.ValorNumerico(par_oTxt.Value) = 0, .T., .F.)
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ValidarValorDesconto - o PROCEDURE Valid de
    * SIGOPDES.Grade.Column4.Text1 (celula "Valor Desconto").
    *
    * Mesmo contrato de ValidarPercentualDesconto: chamado pelo Valid da
    * subclasse txt_4c_CelValor, PUBLIC, e o retorno governa a saida da
    * celula. Par wrapper + Exec pelo mesmo motivo (regra CLAUDE.md #1).
    *==========================================================================
    PROCEDURE ValidarValorDesconto(par_oTxt)
        LOCAL loc_lValido, loc_oErro

        loc_lValido = .T.

        TRY
            loc_lValido = THIS.ValidarValorDescontoExec(par_oTxt)
        CATCH TO loc_oErro
            loc_lValido = .T.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarValorDesconto")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ValidarValorDescontoExec - corpo do Valid da coluna "Valor Desconto".
    *
    * Aqui o usuario digita o VALOR e o legado o converte em percentual
    * antes de validar - a formula e' TRANSCRITA (regra CLAUDE.md #17),
    * inclusive o guard de divisao por zero e as 4 casas do ROUND:
    *
    *   lnPdes = Iif(This.Value = 0 Or (Thisform.lnvalor.Value * 100) = 0,
    *                0,
    *                Round(This.Value / Thisform.lnvalor.Value * 100, 4))
    *   If lnPdes > crDesc.descosmax -> "Desconto maior que o permitido"
    *   IF crDesc.tpdesc = 2 and RECCOUNT('crPar') <> 0 and this.Value > 0
    *      -> "Desconto nao permitido para pagamento parcelado."
    *   Replace descos With lnPdes In localdes
    *   Thisform.calctots()
    *   IF (lnSaldo.Value < 0) or (cota estourada e tipo consome cota)
    *      -> "Desconto maior que o permitido"
    *
    * O teto e' cobrado sobre o PERCENTUAL derivado, nao sobre o valor: e'
    * o mesmo Descosmax da coluna "% Desconto".
    *
    * A reversao e' feita por ReverterCelulaDesconto, que zera o percentual
    * E o valor no cursor junto com o controle. O legado so atribui
    * "This.Value = crDesc.valdes" e deixa a volta ao cursor para o VFP -
    * mas no terceiro guard o percentual JA foi gravado com o valor
    * recusado, e calctots recalcula o valor a partir dele; sem zerar o
    * percentual explicitamente, o valor recusado voltaria ao cursor.
    * Zerar os dois e' o estado em que o legado converge depois do
    * write-back, escrito de forma deterministica em vez de depender da
    * ordem em que o VFP devolve o valor do controle ao ControlSource.
    *==========================================================================
    PROTECTED FUNCTION ValidarValorDescontoExec(par_oTxt)
        LOCAL loc_nDigitado, loc_nValor, loc_nPdes, loc_nTeto, loc_nTpDesc

        IF VARTYPE(par_oTxt) != "O" OR !USED("cursor_4c_Dados") OR ;
           EOF("cursor_4c_Dados")
            RETURN .T.
        ENDIF

        loc_nDigitado = THIS.ValorNumerico(par_oTxt.Value)
        loc_nValor    = THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)
        loc_nTeto     = NVL(cursor_4c_Dados.Descosmax, 0)
        loc_nTpDesc   = NVL(cursor_4c_Dados.Tpdesc, 0)

        *-- Valor digitado convertido em percentual sobre o valor original
        loc_nPdes = IIF(loc_nDigitado = 0 OR (loc_nValor * 100) = 0, ;
                        0, ;
                        ROUND(loc_nDigitado / loc_nValor * 100, 4))

        *-- Regra 1: percentual equivalente acima do teto do tipo
        IF loc_nPdes > loc_nTeto
            MsgAviso("Desconto maior que o permitido", "Aviso")
            THIS.ReverterCelulaDesconto(par_oTxt)
            RETURN .F.
        ENDIF

        *-- Regra 2: desconto financeiro (tipo 2) em venda parcelada
        IF loc_nTpDesc = 2 AND THIS.this_nQtdParcelas <> 0 AND loc_nDigitado > 0
            MsgAviso("Desconto n" + CHR(227) + "o permitido para pagamento " + ;
                     "parcelado.", "Aviso")
            THIS.ReverterCelulaDesconto(par_oTxt)
            RETURN .F.
        ENDIF

        *-- Legado: "Replace descos With lnPdes In localdes" - o valor
        *-- digitado passa a existir como PERCENTUAL, e e' calctots que
        *-- reescreve o valor a partir dele (ROUND(valor * descos / 100, 2)).
        *-- Por isso o valor gravado pode diferir em centavos do digitado:
        *-- e' o comportamento do legado, nao arredondamento acrescentado.
        REPLACE Descos WITH loc_nPdes IN cursor_4c_Dados
        THIS.CalcularTotais()

        *-- Regra 3: saldo negativo ou cota da empresa estourada
        IF THIS.ValorNumerico(THIS.txt_4c_LnSaldo.Value) < 0 OR ;
           (THIS.CotaEstourada() AND THIS.DescontoEntraNaCota(loc_nTpDesc))
            MsgAviso("Desconto maior que o permitido", "Aviso")
            THIS.ReverterCelulaDesconto(par_oTxt)
            THIS.CalcularTotais()

            RETURN IIF(THIS.ValorNumerico(par_oTxt.Value) = 0, .T., .F.)
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ReverterCelulaDesconto - desfaz a digitacao recusada por um dos Valid.
    *
    * Legado: "this.Value = crDesc.descos" (coluna %) e
    * "This.Value = crDesc.valdes" (coluna Valor), seguidos de
    * "this.Refresh". As duas colunas de crDesc valem 0 em toda linha (ver
    * o comentario de ValidarPercentualDescontoExec), entao a reversao e'
    * para ZERO nos dois casos - o legado usa nomes diferentes para o
    * mesmo zero.
    *
    * Zera TAMBEM o cursor, nas duas colunas: o controle sozinho nao basta
    * porque CalcularTotais recalcula o valor a partir do percentual do
    * CURSOR, e um percentual recusado que ficasse gravado reapareceria
    * como valor na proxima passagem do calculo.
    *
    * NAO toca em Selecao: recusar o percentual nao desmarca a linha, e
    * desmarcar faria o When da celula passar a devolver .F., tirando do
    * usuario a chance de corrigir o valor que ele acabou de digitar.
    *==========================================================================
    PROTECTED PROCEDURE ReverterCelulaDesconto(par_oTxt)
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            REPLACE Descos WITH 0, ;
                    Valdes WITH 0 ;
                IN cursor_4c_Dados
        ENDIF

        IF VARTYPE(par_oTxt) = "O"
            par_oTxt.Value = 0
            par_oTxt.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - FONTE UNICA da transferencia TELA -> BO.
    *
    * Reune, num lugar so, as duas coisas que esta tela precisa empurrar para
    * o SigOpDesBO:
    *
    *   1. O CONTEXTO do movimento/item/produto que o Init recebeu por
    *      parametro. No legado isso nao existia como transferencia: o BO
    *      "era" o form, e as regras de elegibilidade liam TprMvCab,
    *      crTpmMvItn e crProd diretamente (cursores globais do form
    *      chamador). Nesta arquitetura o contexto entra pelo Init do form e
    *      tem de chegar ao BO antes de qualquer consulta.
    *
    *   2. Os TRES TOTAIS da tela (Valor Original / Total Desconto / Saldo),
    *      lidos dos TextBox. O legado tambem trata a tela como fonte: o
    *      calctots le "thisform.lnvalor.value" e escreve
    *      "thisform.lnSaldo.Value" / "thisform.lnTdesc.Value", e o
    *      btnConfirmar grava "localdes.valdes" - sempre o que esta na TELA,
    *      nunca o que veio da carga.
    *
    * POR QUE EXISTE: o contexto era atribuido inline em InicializarForm e as
    * colunas de contexto eram reatribuidas DE NOVO dentro do SCAN de
    * ConfirmarSelecaoExec. Dois lugares escrevendo as mesmas properties sao
    * dois lugares para divergir em silencio (um recebe campo novo e o outro
    * nao, e a gravacao passa a usar contexto velho sem erro nenhum).
    *
    * LEITURA DOS TEXTBOX SOB GUARDA DE EXISTENCIA: InicializarForm chama
    * este metodo ANTES de ConfigurarPageFrame, porque ConfigurarTotais le
    * this_oBusinessObject.this_nValor para inicializar os TextBox - ou seja,
    * na primeira chamada os TextBox ainda NAO existem. Sem a guarda,
    * THIS.txt_4c_LnValor estouraria "Property TXT_4C_LNVALOR is not found"
    * dentro do TRY do InicializarForm, o CREATEOBJECT devolveria .F. e o
    * usuario acionaria a tela sem nada acontecer e sem erro visivel. Nessa
    * primeira passagem this_nValor recebe this_nUnitOrigs, que e' exatamente
    * o "this.lnValor.value = crTpmMvItn.unitorigs" do Init legado.
    *
    * ValorNumerico em toda leitura de TextBox: InputMask pode devolver
    * Caractere depois de passar por digitacao, e atribuir Caractere a uma
    * property numerica do BO faria a conta seguinte estourar longe daqui.
    *
    * PROTECTED EXPLICITO, e nao por estilo: FormBase.prg declara
    * "PROTECTED PROCEDURE FormParaBO()" (e' um dos hooks que
    * FormBase.Salvar/Novo/Cancelar chamam por THIS.), e em VFP9 a subclasse
    * NAO pode ALARGAR o escopo herdado - escrever "PROCEDURE FormParaBO"
    * sem o modificador nao torna o metodo publico, so esconde que ele
    * continua protegido. Medido no probe desta fase: com a declaracao sem
    * modificador, PEMSTATUS(oForm, "FormParaBO", 2) devolvia .T. (protegido)
    * e a chamada de fora estourava "Property FORMPARABO is not found."
    *
    * Consequencia pratica: este metodo so e' alcancavel de DENTRO da classe
    * (sempre por THIS., regra CLAUDE.md #8). Para exercita-lo num harness, o
    * caminho e' uma "DEFINE CLASS Probe... AS FormSigOpDes" com um metodo
    * publico que chame THIS.FormParaBO() - subclasse alcanca membro
    * protegido, script solto nao.
    *
    * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
                        "vel para transferir os dados da tela.", ;
                        "Erro em FormParaBO")
            ELSE
                WITH THIS.this_oBusinessObject
                    *-- Contexto do movimento/item (legado: TprMvCab e
                    *-- crTpmMvItn)
                    .this_cEmps       = THIS.this_cEmps
                    .this_cDopes      = THIS.this_cDopes
                    .this_nNumes      = THIS.this_nNumes
                    .this_cContads    = THIS.this_cContads
                    .this_dDatas      = THIS.this_dDatas
                    .this_cEmpDopNums = THIS.this_cEmpDopNums
                    .this_cCpros      = THIS.this_cCpros
                    .this_nCitens     = THIS.this_nCitens
                    .this_nUnitOrigs  = THIS.this_nUnitOrigs
                    .this_nQtds       = THIS.this_nQtds
                    .this_nTotas      = THIS.this_nTotas

                    *-- Contexto do cadastro do produto atual (legado:
                    *-- crProd), consumido pelas regras de elegibilidade
                    .this_cCgrus      = THIS.this_cCgrus
                    .this_cSgrus      = THIS.this_cSgrus
                    .this_cCodcors    = THIS.this_cCodcors
                    .this_cColecoes   = THIS.this_cColecoes
                    .this_cCodfinp    = THIS.this_cCodfinp
                    .this_nPvens      = THIS.this_nPvens
                    .this_dDtLacto    = THIS.this_dDtLacto
                    .this_lForaLinha  = THIS.this_lForaLinha
                    .this_nPrecode    = THIS.this_nPrecode
                ENDWITH

                *-- Totais. Na PRIMEIRA chamada (de dentro do
                *-- InicializarForm, antes de ConfigurarTotais) os TextBox
                *-- ainda nao existem: this_nValor recebe this_nUnitOrigs, o
                *-- mesmo valor com que ConfigurarTotais nasce o campo.
                IF PEMSTATUS(THIS, "txt_4c_LnValor", 5)
                    THIS.this_oBusinessObject.this_nValor = ;
                        THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)
                ELSE
                    THIS.this_oBusinessObject.this_nValor = THIS.this_nUnitOrigs
                ENDIF

                IF PEMSTATUS(THIS, "txt_4c_LnTDesc", 5)
                    THIS.this_oBusinessObject.this_nTDesc = ;
                        THIS.ValorNumerico(THIS.txt_4c_LnTDesc.Value)
                ENDIF

                IF PEMSTATUS(THIS, "txt_4c_LnSaldo", 5)
                    THIS.this_oBusinessObject.this_nSaldo = ;
                        THIS.ValorNumerico(THIS.txt_4c_LnSaldo.Value)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - FONTE UNICA da transferencia BO -> TELA.
    *
    * O inverso do FormParaBO, e com o mesmo alcance: os TRES campos de total
    * da tela (Valor Original / Total Desconto / Saldo). Nao ha mais nada para
    * espelhar - os campos editaveis desta tela nao sao controles do form, sao
    * as CELULAS da grade, e elas leem de cursor_4c_Dados por ControlSource
    * (quem repinta e' MontaGrade, nao este metodo).
    *
    * Legado equivalente, no fim do Init: "this.lnValor.value =
    * crTpmMvItn.unitorigs" seguido de "=thisform.CalcTots()" - a tela abre
    * com o Valor Original vindo do item e os outros dois ja calculados.
    * Aqui o Valor Original vem de this_nValor (que FormParaBO acabou de
    * resolver a partir de this_nUnitOrigs) e os outros dois das properties
    * que a carga do BO deixou; CalcularTotais, chamado logo depois pelo
    * CarregarLista, recalcula Total Desconto e Saldo sobre a grade ja cheia.
    *
    * GUARDA DE EXISTENCIA nos tres TextBox pela mesma razao do FormParaBO:
    * o metodo pode rodar antes da superficie visual estar montada, e um
    * "Property is not found" aqui derrubaria o Init inteiro.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO: FormBase.prg
    * declara "PROTECTED PROCEDURE BOParaForm()" e o VFP9 nao deixa a
    * subclasse alargar o escopo herdado - sem o modificador o metodo ficaria
    * protegido de qualquer jeito, e a declaracao mentiria para quem le.
    *
    * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
                        "vel para atualizar os totais da tela.", ;
                        "Erro em BOParaForm")
            ELSE
                WITH THIS.this_oBusinessObject
                    IF PEMSTATUS(THIS, "txt_4c_LnValor", 5)
                        THIS.txt_4c_LnValor.Value = ;
                            THIS.ValorNumerico(.this_nValor)
                    ENDIF

                    IF PEMSTATUS(THIS, "txt_4c_LnTDesc", 5)
                        THIS.txt_4c_LnTDesc.Value = ;
                            THIS.ValorNumerico(.this_nTDesc)
                    ENDIF

                    IF PEMSTATUS(THIS, "txt_4c_LnSaldo", 5)
                        THIS.txt_4c_LnSaldo.Value = ;
                            THIS.ValorNumerico(.this_nSaldo)
                    ENDIF
                ENDWITH

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Destroy - o "PROCEDURE Release" do legado.
    *
    * Legado:
    *
    *   RELEASE pcChv, pcEDN, pcItem
    *   This.Grade.RecordSource          = []
    *   This.Grade.Column1.ControlSource = []
    *   This.Grade.Column2.ControlSource = []
    *   This.Grade.Column3.ControlSource = []
    *   This.Grade.Column4.ControlSource = []
    *   Use In localDes
    *
    * As tres variaveis PUBLIC (pcChv/pcEDN/pcItem) nao tem equivalente: o
    * contexto que elas carregavam entre o Init e os eventos vive em
    * properties this_* do form e do BO, que morrem com os objetos - nao ha
    * o que soltar do espaco global.
    *
    * O resto e' transcrito: SOLTAR a grade do cursor ANTES de fechar o
    * cursor. A ordem importa - fechar o alias com a grade ainda ligada a ele
    * deixa o Grid apontando para alias morto, e qualquer repintura posterior
    * (o VFP repinta durante a propria destruicao da tela) acha alias
    * inexistente. cursor_4c_Cota recebe o mesmo tratamento: o legado nao
    * fechava crSigCdDes porque era cursor GLOBAL do chamador; aqui as duas
    * grades sao nossas e os dois cursores tambem.
    *
    * NAO HA TABLEREVERT antes do USE IN (regra CLAUDE.md #52): os dois
    * cursores nascem de CREATE CURSOR, ou seja Buffering = 1, e TABLEREVERT
    * sem buffering nao e' no-op - estoura erro 1586 "Function requires row
    * or table buffering mode". USE IN fecha o alias sozinho, inclusive com
    * buffer sujo.
    *
    * DODEFAULT() na ULTIMA linha e' obrigatorio: FormBase.Destroy refaz os
    * popups do menu principal (RELEASE POPUP + CriarMenuPrincipal), e sem a
    * cadeia de heranca o menu do sistema aparece encolhido depois que este
    * dialogo fecha.
    *
    * SEM RETURN: Destroy nao devolve valor, e o CATCH so reporta - abortar a
    * destruicao por falha de limpeza deixaria o form pendurado.
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            *-- Solta a grade principal do cursor (legado: Grade.RecordSource
            *-- e os quatro Column.ControlSource)
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                WITH THIS.grd_4c_Dados
                    .RecordSource          = ""
                    .Column1.ControlSource = ""
                    .Column2.ControlSource = ""
                    .Column3.ControlSource = ""
                    .Column4.ControlSource = ""
                ENDWITH
            ENDIF

            *-- Solta a grade da cota (GrdCota, 3 colunas)
            IF PEMSTATUS(THIS, "grd_4c_Cota", 5)
                WITH THIS.grd_4c_Cota
                    .RecordSource          = ""
                    .Column1.ControlSource = ""
                    .Column2.ControlSource = ""
                    .Column3.ControlSource = ""
                ENDWITH
            ENDIF

            *-- E so ENTAO fecha os cursores (legado: "Use In localDes")
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF USED("cursor_4c_Cota")
                USE IN cursor_4c_Cota
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna visiveis, recursivamente, todos os
    * controles de par_oContainer (AddObject sempre cria com Visible = .F.).
    * Percorre tambem Pages de PageFrame, mesmo este form nao tendo nenhum
    * hoje - mantido pelo mesmo motivo do padrao canonico FormCor/FormCargo:
    * um PageFrame acrescentado depois ja seria coberto.
    *
    * grd_4c_Cota e' EXCECAO: a visibilidade dele e' decidida pelo acesso
    * GERENTE (ver AcessoGradeCota) e forcar Visible = .T. aqui exporia a
    * cota de desconto da empresa para QUALQUER usuario, apagando em
    * silencio a regra que o legado aplica. A recursao entra no objeto de
    * qualquer forma, para os filhos dele nascerem visiveis quando o
    * container voltar a ser exibido.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND ;
                   UPPER(loc_oObjeto.Name) != "GRD_4C_COTA"
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE

*==============================================================================
* Subclasses de celula da grade principal de FormSigOpDes
*
* Uma por coluna editavel/bloqueada de SIGOPDES.Grade, instaladas por
* FormSigOpDes.InstalarCelulasGrade com Column.AddObject + CurrentControl.
*
* POR QUE SUBCLASSE: a validacao de celula de grade mora no Valid do TextBox
* da coluna, e BINDEVENT em "Valid" de TextBox de Column nao e' confiavel
* (regra CLAUDE.md #46); alem disso BINDEVENT DESCARTA o retorno do delegate,
* e aqui o retorno E' o mecanismo - o Valid devolvendo .F. recusa a saida da
* celula e o When devolvendo .F. recusa a entrada. Nenhum dos dois efeitos
* sobrevive a um BINDEVENT.
*
* Cada subclasse so decide ENTRAR/SAIR e delega a regra ao metodo PUBLIC
* correspondente do form (fonte unica): o legado tambem chama
* "thisform.calctots()" de dentro dos Valid, isto e' a regra nunca morou no
* controle.
*
* O guard PEMSTATUS existe porque estas classes vivem no mesmo arquivo do
* form mas sao instanciadas pelo Grid: se um dia a celula for reusada em
* outro form sem esses metodos, a ausencia vira "a celula nao valida" em vez
* de "Property is not found" derrubando a tela.
*==============================================================================

*------------------------------------------------------------------------------
* TextBoxCelDescricaoSigOpDes_4c - celula da coluna "Descricao do Desconto"
* (SIGOPDES.Grade.Column2.Text1).
*
* O legado declara Column2.ReadOnly = .F. e bloqueia a digitacao com
* "PROCEDURE When / Return .f." no Text1 - a descricao do tipo de desconto e'
* so leitura, o usuario nunca a edita.
*
* O "PROCEDURE GotFocus" que o dump traz neste mesmo objeto (um salto para a
* coluna 3 ou 4 conforme o tpdesc da linha) e' CODIGO MORTO no legado e por
* isso nao e' reproduzido: com o When devolvendo .F. a celula nunca e'
* ativada, logo o GotFocus dela nunca dispara. Reproduzi-lo por outra via
* (AfterRowColChange, por exemplo) ACRESCENTARIA um salto de foco que a tela
* legada nao faz. O mesmo vale para o GotFocus identico de
* SIGOPDES.GrdCota.Column1.Text1, que tambem tem When devolvendo .F.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCelDescricaoSigOpDes_4c AS TextBox

    PROCEDURE When()
        RETURN .F.
    ENDPROC

ENDDEFINE

*------------------------------------------------------------------------------
* TextBoxCelPercentualSigOpDes_4c - celula da coluna "% Desconto"
* (SIGOPDES.Grade.Column3.Text1).
*
* When  legado: "RETURN localdes.selecao = 1" - so a linha MARCADA aceita
*               percentual. A linha comentada logo acima dele no dump
*               ("INLIST(tpdesc,1,2,3,4,5,8,9) and selecao = 1") e' a versao
*               antiga da regra e fica comentada, como no legado.
* Valid legado: as tres regras de teto / parcelado / saldo-e-cota, que vivem
*               em FormSigOpDes.ValidarPercentualDesconto.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCelPercentualSigOpDes_4c AS TextBox

    PROCEDURE When()
        LOCAL loc_lPermite

        loc_lPermite = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            IF VARTYPE(cursor_4c_Dados.Selecao) = "L"
                loc_lPermite = cursor_4c_Dados.Selecao
            ELSE
                loc_lPermite = (NVL(cursor_4c_Dados.Selecao, 0) = 1)
            ENDIF
        ENDIF

        RETURN loc_lPermite
    ENDPROC

    PROCEDURE Valid()
        LOCAL loc_lValido

        loc_lValido = .T.

        IF PEMSTATUS(THISFORM, "ValidarPercentualDesconto", 5)
            loc_lValido = THISFORM.ValidarPercentualDesconto(THIS)
        ENDIF

        RETURN loc_lValido
    ENDPROC

ENDDEFINE

*------------------------------------------------------------------------------
* TextBoxCelValorSigOpDes_4c - celula da coluna "Valor Desconto"
* (SIGOPDES.Grade.Column4.Text1).
*
* When  legado: "RETURN localdes.selecao = 1" (o "&&RETURN .f." comentado
*               abaixo dele no dump e' a versao antiga da regra).
* Valid legado: converte o valor digitado em percentual e aplica as mesmas
*               tres regras - vive em FormSigOpDes.ValidarValorDesconto.
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxCelValorSigOpDes_4c AS TextBox

    PROCEDURE When()
        LOCAL loc_lPermite

        loc_lPermite = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            IF VARTYPE(cursor_4c_Dados.Selecao) = "L"
                loc_lPermite = cursor_4c_Dados.Selecao
            ELSE
                loc_lPermite = (NVL(cursor_4c_Dados.Selecao, 0) = 1)
            ENDIF
        ENDIF

        RETURN loc_lPermite
    ENDPROC

    PROCEDURE Valid()
        LOCAL loc_lValido

        loc_lValido = .T.

        IF PEMSTATUS(THISFORM, "ValidarValorDesconto", 5)
            loc_lValido = THISFORM.ValidarValorDesconto(THIS)
        ENDIF

        RETURN loc_lValido
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpDesBO.prg):
*====================================================================
* SigOpDesBO.prg
*
* Business Object para Selecao de Descontos (dialogo modal aberto a
* partir da grade de itens de um movimento de venda).
*
* Tabela gravada ao confirmar a selecao: SigMvItd (uma linha por tipo
* de desconto marcado na grade). Tabela consultada/atualizada para o
* controle de cota acumulada por empresa: SigCdDes.
*
* O item/movimento de origem (Emps/Dopes/Numes/Cpros/Citens/...) e o
* cadastro do produto atual (Cgrus/Sgrus/...) sao fornecidos pelo form
* chamador - esta nova arquitetura nao depende mais dos cursores
* globais do legado (TprMvCab/crTpmMvItn), que sao passados pelo
* FormBase chamador via parametro.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpDesBO AS BusinessBase

	*-- Contexto do movimento/item (equivalente a TprMvCab/crTpmMvItn do legado)
	this_cEmps       = ""   && Emps       char(3)  - empresa do movimento
	this_cDopes      = ""   && Dopes      char(20) - documento/operacao do movimento
	this_nNumes      = 0    && Numes      numeric(6,0) - numero do movimento
	this_cContads    = ""   && Contads    char(10) - codigo da conta/cliente do movimento
	this_dDatas      = {}   && Datas      datetime - data do movimento
	this_cEmpDopNums = ""   && EmpDopNums char(29) - chave posicional Emps+Dopes+Numes (regra #42, NAO usar ALLTRIM nas partes)
	this_cCpros      = ""   && Cpros      char(14) - codigo do produto do item atual
	this_nCitens     = 0    && Citens     numeric  - numero/indice do item na lista de itens
	this_nUnitOrigs  = 0    && UnitOrigs  numeric(14,6) - valor unitario original do item (base do desconto)
	this_nQtds       = 0    && Qtds       numeric(9,3)  - quantidade do item
	this_nTotas      = 0    && Totas      numeric(11,2) - valor total do item

	*-- Cadastro do produto atual (SigCdPro), usado nas regras de elegibilidade de desconto
	this_cCgrus      = ""   && Cgrus      - grupo do produto
	this_cSgrus      = ""   && Sgrus      - subgrupo do produto
	this_cCodcors    = ""   && Codcors    - codigo da cor do produto
	this_cColecoes   = ""   && Colecoes   - codigo da colecao do produto
	this_cCodfinp    = ""   && Codfinp    - codigo do acabamento/finp do produto
	this_nPvens      = 0    && Pvens      - preco de venda atual do produto
	this_dDtLacto    = {}   && DtLacto    - data de lancamento do produto
	this_lForaLinha  = .F.  && ForaLinha  - indica produto fora de linha
	this_nPrecode    = 0    && Precode    - indica produto de/por (preco promocional)

	*-- Totais da selecao de desconto (equivalente a ThisForm.lnValor/lnSaldo/lnTDesc do legado)
	this_nValor      = 0    && Valor original do item, base do calculo de desconto
	this_nSaldo      = 0    && Saldo apos aplicar os descontos selecionados na grade
	this_nTDesc      = 0    && Soma dos valores de desconto selecionados na grade

	*-- Cota de desconto da empresa (SigCdDes), controla o limite acumulado
	this_cCodigo     = ""   && Codigo    char(10)      - PK de SigCdDes
	this_nValCota    = 0    && ValCota   numeric(11,2) - valor da cota de desconto da empresa
	this_nValDes     = 0    && ValDes    numeric(11,2) - valor de desconto ja utilizado (acumulado)
	this_nValMeta    = 0    && ValMeta   numeric(11,2) - valor da meta de venda da empresa
	this_nValCotaC   = 0    && ValCotaC  numeric(11,2) - valor da cota complementar

	*-- Soma dos descontos JA GRAVADOS em SigMvItd pelos OUTROS itens do
	*-- mesmo movimento, restrita aos tipos que CONSOMEM a cota da
	*-- empresa. Equivale ao lnTDescM do calctots legado, que vem de
	*-- "SELECT crSigmvitd / SUM vdes to lnTDescM for
	*--  !INLIST(tpdesc,1,2,6,7,10,11,12,13) AND citens <> pcItem".
	*-- crSigmvitd e' cursor global do form chamador, que esta
	*-- arquitetura nao tem: a soma e' resolvida por
	*-- CarregarDescontoOutrosItens e lida pelo CalcularTotais do form.
	this_nVDescOutrosItens = 0

	*-- Linha de desconto a gravar em SigMvItd quando o usuario confirma a selecao
	this_cCidChaves  = ""   && CidChaves char(20)      - PK da linha de desconto (gerada por fUniqueIds())
	this_dDtAlts     = {}   && DtAlts    datetime      - data/hora da inclusao do desconto
	this_cCdesc      = ""   && Cdesc     char(10)      - codigo do tipo de desconto selecionado (SigOpTdz.codigos)
	this_cDdesc      = ""   && Ddesc     char(30)      - descricao do tipo de desconto selecionado
	this_nPdes       = 0    && Pdes      numeric(7,4)  - percentual de desconto aplicado
	this_nVdes       = 0    && Vdes      numeric(9,2)  - valor de desconto aplicado
	this_nValBase    = 0    && ValBase   numeric(10,2) - valor base sobre o qual o desconto foi calculado
	this_nTpDesc     = 0    && TpDesc    numeric(2,0)  - tipo de desconto (1=aniversario,2=financeiro,3=relogio,6=troca,7=updiamond,8=supervisor,9=diretoria,10=upalianca,11=extra,12=brinde,13=alteracao de preco)
	this_cUsuars     = ""   && Usuars    char(10)      - usuario que autorizou/incluiu o desconto

	*-- Colunas NOT NULL de SigMvItd que o INSERT legado NUNCA cita (regra #22 -
	*-- invisiveis no dump porque nao tem controle na tela nem property no SCX).
	*-- Sem valor proprio no legado: usar o default documentado (numeric -> 0,
	*-- char -> vazio) para nao quebrar o INSERT com "valor NULL" no SQL Server.
	this_nCitensTpDesc = 0  && CitensTpDesc numeric(4,0) - sem referencia no legado, default 0
	this_cChaveexterna = "" && ChaveExterna char(33)     - sem referencia no legado, default vazio

	*-- Contexto de ELEGIBILIDADE do item, consultado por
	*-- ConsultarContextoElegibilidade e lido por FiltrarElegibilidade.
	*-- Cada uma substitui o RECCOUNT() de um cursor auxiliar do Init
	*-- legado (ver o comentario de FiltrarElegibilidade).
	this_nQtdPromoImp  = 0  && crProPro - SigImpPr vigente para o produto
	this_nQtdAniv      = 0  && crClid   - SigCdCli.nascs no mes corrente
	this_nQtdPrecoAlt  = 0  && crPre    - SigPrPre com troca de preco em 2 dias
	this_nDescPrecoAlt = 0  && crPre.descos - percentual da troca de preco (teto do tipo 13)
	this_nQtdItdJolie  = 0  && crItdJ   - SigMvItd ja gravado com o tipo 2 do grupo configurado

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigMvItd"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave primaria (cidchaves) para uso
	* em RegistrarAuditoria(). PROTECTED (regra #51 - nunca chamado de fora).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas de SigMvItd do cursor
	* para as propriedades do BO. SEMPRE SELECT (par_cAliasCursor) antes
	* de acessar os campos (regra #9 CLAUDE.md).
	*
	* O 2o argumento de TratarNulo e' o VALOR PADRAO devolvido quando a
	* coluna vem NULL, NAO um codigo de tipo: TratarNulo(citens, "N")
	* gravaria a STRING "N" numa property numerica e a primeira conta
	* feita com ela estouraria por tipo. Por isso cada chamada abaixo
	* passa o default do TIPO da property - "" para char, 0 para numeric
	* e {} para datetime.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCdesc         = TratarNulo(cdesc, "")
				THIS.this_cCidChaves     = TratarNulo(cidchaves, "")
				THIS.this_nCitens        = TratarNulo(citens, 0)
				THIS.this_cCpros         = TratarNulo(cpros, "")
				THIS.this_cDdesc         = TratarNulo(ddesc, "")
				THIS.this_cDopes         = TratarNulo(dopes, "")
				THIS.this_dDtAlts        = TratarNulo(dtalts, {})
				THIS.this_cEmpDopNums    = TratarNulo(empdopnums, "")
				THIS.this_cEmps          = TratarNulo(emps, "")
				THIS.this_nNumes         = TratarNulo(numes, 0)
				THIS.this_nPdes          = TratarNulo(pdes, 0)
				THIS.this_cUsuars        = TratarNulo(usuars, "")
				THIS.this_nValBase       = TratarNulo(valbase, 0)
				THIS.this_nVdes          = TratarNulo(vdes, 0)
				THIS.this_nCitensTpDesc  = TratarNulo(citenstpdesc, 0)
				THIS.this_cCodigo        = TratarNulo(codigo, "")
				THIS.this_nTpDesc        = TratarNulo(tpdesc, 0)
				THIS.this_cChaveexterna  = TratarNulo(chaveexterna, "")

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere nova linha de desconto em SigMvItd
	* PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida -
	* equivalente a "lcIdChave = fUniqueIds()" do btnConfirmar.Click legado.
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			*-- Campo posicional Emps+Dopes+Numes (regra #42 - NUNCA ALLTRIM nas partes)
			THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- DtAlts = data/hora da inclusao (equivalente a DATETIME() do legado)
			THIS.this_dDtAlts = DATETIME()

			loc_cSQL = "INSERT INTO SigMvItd ("
			loc_cSQL = loc_cSQL + "cdesc, cidchaves, citens, cpros, ddesc, dopes, dtalts, empdopnums,"
			loc_cSQL = loc_cSQL + "emps, numes, pdes, usuars, valbase, vdes, citenstpdesc, codigo,"
			loc_cSQL = loc_cSQL + "tpdesc, chaveexterna"
			loc_cSQL = loc_cSQL + ") VALUES ("
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCdesc, 10)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidChaves, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDdesc, 30)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtAlts) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPdes, 4) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValBase, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdes, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitensTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodigo, 10)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ")"

			IF USED("cursor_4c_Insert")
				USE IN cursor_4c_Insert
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

			IF loc_nResult < 0
				MsgErro("Erro ao inserir desconto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("INSERT")
				IF USED("cursor_4c_Insert")
					USE IN cursor_4c_Insert
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza linha de desconto existente em SigMvItd (por cidchaves)
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Campo posicional Emps+Dopes+Numes (regra #42 - NUNCA ALLTRIM nas partes)
			THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			loc_cSQL = "UPDATE SigMvItd SET"
			loc_cSQL = loc_cSQL + " cdesc = " + EscaparSQL(LEFT(THIS.this_cCdesc, 10)) + ","
			loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + " cpros = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + " ddesc = " + EscaparSQL(LEFT(THIS.this_cDdesc, 30)) + ","
			loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + " dtalts = " + FormatarDataSQL(THIS.this_dDtAlts) + ","
			loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
			loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + " pdes = " + FormatarNumeroSQL(THIS.this_nPdes, 4) + ","
			loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
			loc_cSQL = loc_cSQL + " valbase = " + FormatarNumeroSQL(THIS.this_nValBase, 2) + ","
			loc_cSQL = loc_cSQL + " vdes = " + FormatarNumeroSQL(THIS.this_nVdes, 2) + ","
			loc_cSQL = loc_cSQL + " citenstpdesc = " + FormatarNumeroSQL(THIS.this_nCitensTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + " codigo = " + EscaparSQL(LEFT(THIS.this_cCodigo, 10)) + ","
			loc_cSQL = loc_cSQL + " tpdesc = " + FormatarNumeroSQL(THIS.this_nTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + " chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))
			loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidChaves, 20))

			IF USED("cursor_4c_Update")
				USE IN cursor_4c_Update
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

			IF loc_nResult < 0
				MsgErro("Erro ao atualizar desconto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("UPDATE")
				IF USED("cursor_4c_Update")
					USE IN cursor_4c_Update
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExcluirDescontosDoItem - remove TODAS as linhas de desconto do item
	* corrente em SigMvItd, antes de btnConfirmar.Click regravar a
	* selecao atual da grade.
	*
	* Legado (btnConfirmar.Click):
	*   SELECT crsigmvitd
	*   DELETE all for cpros = crTpmMvItn.cpros and citens = crTpmMvItn.citens
	*
	* crsigmvitd e' cursor GLOBAL do form chamador (todas as linhas de
	* desconto do movimento, de TODOS os itens) - nesta arquitetura o
	* DELETE vai direto na tabela, restrito ao mesmo par cpros/citens, que
	* e' exatamente o que o FOR do legado filtra.
	*
	* PUBLIC: chamado pelo form em BtnConfirmarClick (regra #51 - metodo
	* chamado de fora nunca pode ser PROTECTED).
	*====================================================================
	PROCEDURE ExcluirDescontosDoItem()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso

		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cCpros, "")))
			loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)

			IF USED("cursor_4c_DelItd")
				USE IN cursor_4c_DelItd
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelItd")

			IF loc_nResult < 0
				MsgErro("Erro ao remover os descontos anteriores do item:" + ;
						CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_DelItd")
				USE IN cursor_4c_DelItd
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.ExcluirDescontosDoItem")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ContarSQL - devolve o escalar da coluna N de um SELECT COUNT(*)
	* executado no SQL Server. Centraliza o padrao
	* "SQLEXEC -> le N -> fecha cursor" usado pelas checagens de
	* elegibilidade abaixo, que no legado eram RECCOUNT() de cursores
	* auxiliares (crProPro/crClid/crItdJ).
	*
	* O cursor de apoio e' SEMPRE fechado antes e depois, para nao deixar
	* alias aberto entre chamadas (o 2o SQLEXEC no mesmo alias erraria).
	* PROTECTED - chamado so por THIS. dentro do proprio BO (regra #51).
	*====================================================================
	PROTECTED FUNCTION ContarSQL(par_cSQL)
		LOCAL loc_nTotal, loc_nResult, loc_nAliasAnt

		loc_nTotal    = 0
		loc_nAliasAnt = SELECT()

		IF USED("cursor_4c_DesCnt")
			USE IN cursor_4c_DesCnt
		ENDIF

		loc_nResult = SQLEXEC(gnConnHandle, par_cSQL, "cursor_4c_DesCnt")

		IF loc_nResult >= 0 AND USED("cursor_4c_DesCnt")
			SELECT cursor_4c_DesCnt
			IF !EOF()
				loc_nTotal = NVL(cursor_4c_DesCnt.N, 0)
			ENDIF
		ENDIF

		IF USED("cursor_4c_DesCnt")
			USE IN cursor_4c_DesCnt
		ENDIF

		IF loc_nAliasAnt > 0
			SELECT (loc_nAliasAnt)
		ENDIF

		RETURN loc_nTotal
	ENDFUNC

	*====================================================================
	* ContarTipoConfig - conta linhas de cursor_4c_TipoTmp (o crTipo do
	* legado: SigOpTdt cruzado com SigOpTdz) para um par Tipos/TpDesc,
	* opcionalmente restrito ao grupo informado em Codtips.
	*
	* Substitui os RECCOUNT() dos cursores auxiliares do Init legado:
	*   crTipoRe   = crTipo where tipos = 1 and tpdesc = 3   (relogio)
	*   crTipoExAl = crTipo where tipos = 1 and tpdesc = 11  (extra alianca)
	*   crTipoJ    = crTipo where tipos = 1 and tpdesc = 2   (jolie)
	*   crGrRe/crGrAl/crGrJ = o MESMO conjunto, restrito a
	*                         "cgrus do produto in (codtips)"
	*
	* par_nUsarCod e' NUMERICO (0 = conta o par Tipos/TpDesc inteiro,
	* 1 = conta so as linhas cujo Codtips casa com par_cCodTips) de
	* proposito: parametro LOGICO omitido obriga teste de PCOUNT para ser
	* lido com seguranca.
	*
	* O RECNO corrente de cursor_4c_TipoTmp e' reposto no fim - o SCAN
	* move o ponteiro e outras checagens leem o mesmo alias depois.
	*====================================================================
	PROTECTED FUNCTION ContarTipoConfig(par_nTipos, par_nTpDesc, par_nUsarCod, par_cCodTips)
		LOCAL loc_nTotal, loc_nRecAnt, loc_cCod, loc_nAliasAnt

		loc_nTotal = 0

		IF USED("cursor_4c_TipoTmp")
			loc_nAliasAnt = SELECT()
			loc_cCod      = IIF(VARTYPE(par_cCodTips) = "C", ALLTRIM(par_cCodTips), "")

			SELECT cursor_4c_TipoTmp
			loc_nRecAnt = IIF(EOF("cursor_4c_TipoTmp"), 0, RECNO("cursor_4c_TipoTmp"))

			SCAN
				IF cursor_4c_TipoTmp.Tipos = par_nTipos AND ;
				   cursor_4c_TipoTmp.Tpdesc = par_nTpDesc
					IF par_nUsarCod = 0 OR ;
					   ALLTRIM(cursor_4c_TipoTmp.Codtips) == loc_cCod
						loc_nTotal = loc_nTotal + 1
					ENDIF
				ENDIF
			ENDSCAN

			IF loc_nRecAnt > 0 AND loc_nRecAnt <= RECCOUNT("cursor_4c_TipoTmp")
				GO loc_nRecAnt IN cursor_4c_TipoTmp
			ENDIF

			IF loc_nAliasAnt > 0
				SELECT (loc_nAliasAnt)
			ENDIF
		ENDIF

		RETURN loc_nTotal
	ENDFUNC

	*====================================================================
	* ObterCodigoTipoConfig - devolve o Codigos da PRIMEIRA linha de
	* cursor_4c_TipoTmp para o par Tipos/TpDesc informado.
	*
	* Reproduz a leitura do legado "crTipoExAl.codigos" / "crTipoJ.codigos"
	* nos DELETE condicionais: apos "SELECT * from crTipo where ... into
	* cursor crTipoXX" o ponteiro fica no TOPO, entao o que o legado le e'
	* o primeiro registro da ordenacao por cidchaves - que e' a ordenacao
	* com que cursor_4c_TipoTmp e' criado.
	*====================================================================
	PROTECTED FUNCTION ObterCodigoTipoConfig(par_nTipos, par_nTpDesc)
		LOCAL loc_cCodigo, loc_nRecAnt, loc_nAliasAnt

		loc_cCodigo = ""

		IF USED("cursor_4c_TipoTmp")
			loc_nAliasAnt = SELECT()
			SELECT cursor_4c_TipoTmp
			loc_nRecAnt = IIF(EOF("cursor_4c_TipoTmp"), 0, RECNO("cursor_4c_TipoTmp"))

			SCAN
				IF cursor_4c_TipoTmp.Tipos = par_nTipos AND ;
				   cursor_4c_TipoTmp.Tpdesc = par_nTpDesc
					loc_cCodigo = ALLTRIM(NVL(cursor_4c_TipoTmp.Codigos, ""))
					EXIT
				ENDIF
			ENDSCAN

			IF loc_nRecAnt > 0 AND loc_nRecAnt <= RECCOUNT("cursor_4c_TipoTmp")
				GO loc_nRecAnt IN cursor_4c_TipoTmp
			ENDIF

			IF loc_nAliasAnt > 0
				SELECT (loc_nAliasAnt)
			ENDIF
		ENDIF

		RETURN loc_cCodigo
	ENDFUNC

	*====================================================================
	* CarregarCota - popula cursor_4c_Cota (crSigCdDes do legado) com a
	* cota de desconto da empresa do movimento: codigo, empresa, cota
	* contratada, cota ja utilizada e meta.
	*
	* No legado crSigCdDes NAO e' consultado neste form - ele chega aberto
	* do form chamador, que o monta a partir de SigCdDes. Aqui a consulta
	* e' feita no proprio BO, filtrada pela empresa do movimento
	* (this_cEmps), que e' a mesma linha que o legado exibia.
	*
	* A coluna Valdes trazida aqui e' o acumulado GRAVADO em SigCdDes;
	* CalcTots soma a ela os descontos da tela antes de exibir.
	*
	* SQLEXEC NUNCA sobre o alias ligado ao Grid (isso zeraria o
	* ColumnCount): a consulta vai para cursor_4c_CotaTmp e cursor_4c_Cota
	* e' recarregado com ZAP + APPEND FROM DBF(), que preserva estrutura,
	* RecordSource e ControlSource.
	*====================================================================
	PROCEDURE CarregarCota()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmps

		loc_lSucesso = .F.

		TRY
			loc_cEmps = ALLTRIM(NVL(THIS.this_cEmps, ""))

			loc_cSQL = "SELECT ISNULL(codigo, '') AS Codigo,"
			loc_cSQL = loc_cSQL + " ISNULL(emps, '') AS Emps,"
			loc_cSQL = loc_cSQL + " ISNULL(valcota, 0) AS Valcota,"
			loc_cSQL = loc_cSQL + " ISNULL(valdes, 0) AS Valdes,"
			loc_cSQL = loc_cSQL + " ISNULL(valmeta, 0) AS Valmeta"
			loc_cSQL = loc_cSQL + " FROM SigCdDes"
			loc_cSQL = loc_cSQL + " WHERE emps = " + EscaparSQL(loc_cEmps)
			loc_cSQL = loc_cSQL + " ORDER BY codigo"

			IF USED("cursor_4c_CotaTmp")
				USE IN cursor_4c_CotaTmp
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotaTmp")

			IF loc_nResult < 0
				MsgErro("Erro ao carregar a cota de descontos da empresa:" + ;
						CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF !USED("cursor_4c_Cota")
					SET NULL ON
					CREATE CURSOR cursor_4c_Cota ;
						(Emps C(3), Valcota N(11,2), Valdes N(11,2), ;
						 Codigo C(10), Valmeta N(11,2))
					SET NULL OFF
				ENDIF

				SELECT cursor_4c_Cota
				ZAP

				IF USED("cursor_4c_CotaTmp") AND RECCOUNT("cursor_4c_CotaTmp") > 0
					SELECT cursor_4c_Cota
					APPEND FROM DBF("cursor_4c_CotaTmp")
				ENDIF

				IF USED("cursor_4c_CotaTmp")
					USE IN cursor_4c_CotaTmp
				ENDIF

				SELECT cursor_4c_Cota
				GO TOP

				*-- Codigo da cota vigente: e' o "crSigcdDes.codigo" que o
				*-- btnConfirmar.Click legado grava em SigMvItd.codigo.
				IF !EOF("cursor_4c_Cota")
					THIS.this_cCodigo  = ALLTRIM(NVL(cursor_4c_Cota.Codigo, ""))
					THIS.this_nValCota = NVL(cursor_4c_Cota.Valcota, 0)
					THIS.this_nValDes  = NVL(cursor_4c_Cota.Valdes, 0)
					THIS.this_nValMeta = NVL(cursor_4c_Cota.Valmeta, 0)
				ENDIF

				*-- lnTDescM do calctots legado: os descontos ja gravados
				*-- pelos OUTROS itens do movimento entram na cota
				*-- utilizada que a grade exibe. Resolvido aqui, junto com
				*-- a cota, porque e' a mesma conta e nao muda enquanto o
				*-- dialogo esta aberto. O retorno nao condiciona o
				*-- sucesso da carga da cota: sem a soma dos outros itens
				*-- a tela ainda abre e opera, so a cota utilizada fica
				*-- sem essa parcela - e a falha de SQL ja foi exibida.
				THIS.CarregarDescontoOutrosItens()

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarCota")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDescontoOutrosItens - resolve o lnTDescM do calctots legado:
	* a soma dos descontos JA GRAVADOS em SigMvItd pelos OUTROS itens do
	* mesmo movimento, contando so os tipos que CONSOMEM a cota da
	* empresa.
	*
	* Legado (PROCEDURE calctots):
	*
	*   SELECT crSigmvitd
	*   GO top
	*   SUM vdes to lnTDescM for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
	*                            AND citens <> pcItem
	*
	* crSigmvitd e' um cursor GLOBAL do form chamador (todos os itens de
	* desconto do movimento), igual a TprMvCab/crTpmMvItn - nao existe
	* nesta arquitetura, entao a mesma conta e' feita no SQL Server com o
	* filtro IDENTICO: mesmo movimento (empdopnums), outro item
	* (citens <> this_nCitens) e a MESMA lista de tipos excluidos.
	*
	* Os oito tipos de fora sao aniversario(1), financeiro(2), troca
	* zerada(6), up diamond(7), upgrade alianca(10), extra/loja(11),
	* brinde(12) e troca de preco(13) - a lista do comentario do legado
	* ("nao entra na cota A,V,TZ,UP,UpAlianca,extra/loja,brinde,troca
	* preco"). NAO confundir com a lista do teste de ESTOURO da cota nos
	* Valid das celulas, que exclui apenas 1, 2, 9 e 11: o legado tem duas
	* listas diferentes de proposito.
	*
	* Resolvido UMA vez, na carga: esta tela edita UM item, os descontos
	* dos outros itens nao mudam enquanto o dialogo esta aberto, e o
	* legado tambem nao os reconsulta (ele so re-soma um cursor que
	* ninguem alterou entre uma chamada de calctots e a seguinte).
	*
	* A chave do movimento e' POSICIONAL (regra #42): Emps char(3) +
	* Dopes char(20) + Str(Numes, 6) = char(29). PADR explicito em cada
	* parte, NUNCA ALLTRIM - encurtar qualquer parte desloca a chave, o
	* SELECT nao casa nada e devolve ZERO linhas sem erro nenhum, o que
	* faria a cota utilizada ser calculada sem os outros itens.
	*
	* Zero linhas NAO e' falha: movimento com um unico item, ou com
	* descontos so dos tipos excluidos, soma zero - exatamente o que o
	* legado obtem com crSigmvitd vazio.
	*====================================================================
	PROCEDURE CarregarDescontoOutrosItens()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpDopNums

		loc_lSucesso = .F.

		TRY
			THIS.this_nVDescOutrosItens = 0

			loc_cEmpDopNums = PADR(NVL(THIS.this_cEmps, ""), 3) + ;
							  PADR(NVL(THIS.this_cDopes, ""), 20) + ;
							  STR(NVL(THIS.this_nNumes, 0), 6)

			IF USED("cursor_4c_ItdOutros")
				USE IN cursor_4c_ItdOutros
			ENDIF

			loc_cSQL = "SELECT ISNULL(SUM(vdes), 0) AS Vdes"
			loc_cSQL = loc_cSQL + " FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
			loc_cSQL = loc_cSQL + " AND citens <> " + ;
								  FormatarNumeroSQL(THIS.this_nCitens, 0)
			loc_cSQL = loc_cSQL + " AND tpdesc NOT IN (1, 2, 6, 7, 10, 11, 12, 13)"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItdOutros")

			IF loc_nResult < 0
				MsgErro("Erro ao somar os descontos dos demais itens do " + ;
						"movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED("cursor_4c_ItdOutros") AND ;
				   RECCOUNT("cursor_4c_ItdOutros") > 0
					SELECT cursor_4c_ItdOutros
					GO TOP
					THIS.this_nVDescOutrosItens = NVL(cursor_4c_ItdOutros.Vdes, 0)
				ENDIF

				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ItdOutros")
				USE IN cursor_4c_ItdOutros
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarDescontoOutrosItens")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConsultarContextoElegibilidade - executa as consultas de contexto
	* que o Init legado fazia em cursores auxiliares e guarda o resultado
	* nas propriedades this_nQtd*/this_nDescPrecoAlt.
	*
	* Equivalencia com o legado, consulta por consulta:
	*
	*   crProPro -> this_nQtdPromoImp  (SigImpPr vigente na data do
	*               movimento; havendo promocao, so sobram os tipos 8 e 9)
	*   crClid   -> this_nQtdAniv      (SigCdCli.nascs no mes corrente;
	*               sem aniversario, o tipo 1 sai)
	*   crPre    -> this_nQtdPrecoAlt / this_nDescPrecoAlt (SigPrPre com
	*               troca de preco nos ultimos 2 dias; sem troca o tipo 13
	*               sai, com troca o percentual vira o teto do tipo 13)
	*   crItdJ   -> this_nQtdItdJolie  (SigMvItd ja gravado com o desconto
	*               tipo 2 do grupo configurado para este item)
	*
	* A divisao de crPre e' feita no VFP e nao no SQL Server porque
	* "ROUND((pvens - pvensant) / pvens * 100, 2)" com pvens = 0 ABORTA a
	* query inteira no SQL Server (divide by zero); aqui o zero devolve 0
	* e o tipo 13 fica com o teto do proprio cadastro, em vez de a tela
	* inteira falhar.
	*
	* ORDEM: depende de cursor_4c_TipoTmp ja estar carregado, porque o
	* codigo do tipo 2 jolie sai de ObterCodigoTipoConfig.
	*====================================================================
	PROTECTED PROCEDURE ConsultarContextoElegibilidade()
		LOCAL loc_cSQL, loc_cCpros, loc_cContads, loc_dBase, loc_dLimite
		LOCAL loc_nResult, loc_cCodTipoJ, loc_nPvens, loc_nPvensAnt

		loc_cCpros   = ALLTRIM(NVL(THIS.this_cCpros, ""))
		loc_cContads = ALLTRIM(NVL(THIS.this_cContads, ""))

		*-- Data base do movimento (TprMvCab.datas no legado). Sem data no
		*-- contexto cai em DATE(), para as comparacoes de vigencia nunca
		*-- virarem comparacao com NULL (que nao casa nada em silencio).
		loc_dBase = ConverterParaData(THIS.this_dDatas)
		IF EMPTY(loc_dBase)
			loc_dBase = DATE()
		ENDIF

		*-- Legado: ldData = DTOT(TTOD(TprMvCab.datas) - 2)
		loc_dLimite = loc_dBase - 2

		THIS.this_nQtdPromoImp  = 0
		THIS.this_nQtdAniv      = 0
		THIS.this_nQtdPrecoAlt  = 0
		THIS.this_nDescPrecoAlt = 0
		THIS.this_nQtdItdJolie  = 0

		*-- crProPro: produto com promocao de importacao vigente
		loc_cSQL = "SELECT COUNT(*) AS N FROM SigImpPr"
		loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND dtinicial <= " + FormatarDataSQL(loc_dBase)
		loc_cSQL = loc_cSQL + " AND dtfinal >= " + FormatarDataSQL(loc_dBase)
		THIS.this_nQtdPromoImp = THIS.ContarSQL(loc_cSQL)

		*-- crClid: aniversario do cliente no mes corrente
		loc_cSQL = "SELECT COUNT(*) AS N FROM SigCdCli"
		loc_cSQL = loc_cSQL + " WHERE iclis = " + EscaparSQL(loc_cContads)
		loc_cSQL = loc_cSQL + " AND nascs IS NOT NULL"
		loc_cSQL = loc_cSQL + " AND MONTH(nascs) = " + FormatarNumeroSQL(MONTH(DATE()), 0)
		THIS.this_nQtdAniv = THIS.ContarSQL(loc_cSQL)

		*-- crPre: troca de preco do produto nos ultimos 2 dias
		IF USED("cursor_4c_PreTmp")
			USE IN cursor_4c_PreTmp
		ENDIF

		loc_cSQL = "SELECT TOP 1 ISNULL(pvens, 0) AS Pvens,"
		loc_cSQL = loc_cSQL + " ISNULL(pvensant, 0) AS Pvensant"
		loc_cSQL = loc_cSQL + " FROM SigPrPre"
		loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND datas >= " + FormatarDataSQL(loc_dLimite)
		loc_cSQL = loc_cSQL + " ORDER BY datas DESC"

		loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PreTmp")

		IF loc_nResult >= 0 AND USED("cursor_4c_PreTmp")
			SELECT cursor_4c_PreTmp
			IF !EOF()
				THIS.this_nQtdPrecoAlt = RECCOUNT("cursor_4c_PreTmp")
				loc_nPvens    = NVL(cursor_4c_PreTmp.Pvens, 0)
				loc_nPvensAnt = NVL(cursor_4c_PreTmp.Pvensant, 0)
				IF loc_nPvens <> 0
					THIS.this_nDescPrecoAlt = ROUND((loc_nPvens - loc_nPvensAnt) / ;
													loc_nPvens * 100, 2)
				ENDIF
			ENDIF
		ENDIF

		IF USED("cursor_4c_PreTmp")
			USE IN cursor_4c_PreTmp
		ENDIF

		*-- crItdJ: desconto tipo 2 do grupo configurado ja gravado para
		*-- este item (havendo, o tipo 2 permanece na grade).
		loc_cCodTipoJ = THIS.ObterCodigoTipoConfig(1, 2)

		IF !EMPTY(loc_cCodTipoJ)
			loc_cSQL = "SELECT COUNT(*) AS N FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
			loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)
			loc_cSQL = loc_cSQL + " AND tpdesc = 2"
			loc_cSQL = loc_cSQL + " AND cdesc = " + EscaparSQL(loc_cCodTipoJ)
			THIS.this_nQtdItdJolie = THIS.ContarSQL(loc_cSQL)
		ENDIF
	ENDPROC

	*====================================================================
	* FiltrarElegibilidade - aplica sobre par_cAlias (copia de trabalho
	* dos tipos de desconto) os DELETE de elegibilidade do Init legado,
	* na MESMA ordem em que o legado os executa.
	*
	* Mapa linha a linha com o legado:
	*
	*  1) if RECCOUNT('crItnS') = 0 -> DELETE for INLIST(tpdesc,6,7,10)
	*     crItnS e' o item de SUBNIVEL, que no legado vem do cursor
	*     crEesti aberto pelo form chamador. O contrato de Init deste form
	*     recebe o item ATUAL, nao a troca de subnivel, logo RECCOUNT = 0
	*     e os tipos de troca (6 = troca zerada, 7 = up diamond,
	*     10 = upgrade alianca) saem - exatamente o que o legado faz
	*     quando nao ha subnivel.
	*  2) if RECCOUNT('crTipoExAl') <> 0 and RECCOUNT('crGrAl') = 0
	*        -> DELETE for tpdesc = 11 and codigos = crTipoExAl.codigos
	*  3) if RECCOUNT('crPre') = 0 -> DELETE for INLIST(tpdesc,13)
	*     senao -> replace descosmax with crPre.descos for tpdesc = 13
	*  4) if RECCOUNT('crGrRe') = 0 -> DELETE for INLIST(tpdesc,3)
	*  5) if nascs vazio ou de outro mes -> DELETE for INLIST(tpdesc,1)
	*  6) if RECCOUNT('crProPro') > 0 -> DELETE for !INLIST(tpdesc,8,9)
	*  7) if RECCOUNT('crDepor') > 0 -> DELETE for !INLIST(tpdesc,2,8,9)
	*     crDepor e' "SigCdPro where cpros = X and precode <> 0", que o
	*     contexto ja traz em this_nPrecode.
	*  8) jolie -> DELETE for tpdesc = 2 and codigos = crTipoJ.codigos
	*
	* Dois DELETE do legado ficam de FORA, por motivos opostos:
	*
	*  - FORA DE LINHA: o bloco "DELETE for !INLIST(tpdesc,2,5,8,9)" esta
	*    COMENTADO no legado (*!*), com a nota "Permite descontos mesmo se
	*    produto fora de linha" - manter o comportamento comentado e' a
	*    leitura fiel, e por isso this_lForaLinha nao filtra nada aqui.
	*  - BRINDE (tipo 12): o legado so o mantem quando SigCdPmc tem
	*    promocao vigente com "valmin <= valor dos OUTROS itens do
	*    movimento"; esse somatorio vem do cursor de itens do form
	*    chamador, que nao faz parte do contrato de Init. Filtrar por um
	*    total arbitrario RETIRARIA da tela um desconto que o legado
	*    concede, entao o tipo 12 permanece e a autorizacao continua
	*    sendo cobrada no fluxo de confirmacao.
	*
	* A condicao jolie do legado tem DOIS ramos ligados por OR; aqui
	* entra apenas o primeiro ("grupo configurado no tipo 2 e o produto
	* fora desse grupo"), porque o segundo depende do mesmo somatorio de
	* itens do chamador. O ramo aplicado e' um SUBCONJUNTO do que o legado
	* apaga, logo nenhum tipo que o legado mantem e' retirado.
	*====================================================================
	PROTECTED PROCEDURE FiltrarElegibilidade(par_cAlias)
		LOCAL loc_nTipoExAl, loc_nGrupoExAl, loc_cCodExAl
		LOCAL loc_nTipoRe, loc_nGrupoRe, loc_nTipoJ, loc_nGrupoJ, loc_cCodTipoJ
		LOCAL loc_cCgrus

		loc_cCgrus = ALLTRIM(NVL(THIS.this_cCgrus, ""))

		*-- (1) sem item de subnivel: tipos de troca saem
		SELECT (par_cAlias)
		DELETE FOR INLIST(Tpdesc, 6, 7, 10)

		*-- (2) tipo 11 com grupo configurado que nao e' o do produto
		loc_nTipoExAl  = THIS.ContarTipoConfig(1, 11, 0, "")
		loc_nGrupoExAl = THIS.ContarTipoConfig(1, 11, 1, loc_cCgrus)

		IF loc_nTipoExAl <> 0 AND loc_nGrupoExAl = 0
			loc_cCodExAl = THIS.ObterCodigoTipoConfig(1, 11)
			SELECT (par_cAlias)
			DELETE FOR Tpdesc = 11 AND ALLTRIM(Codigos) == loc_cCodExAl
		ENDIF

		*-- (3) tipo 13 depende de troca de preco recente
		SELECT (par_cAlias)
		IF THIS.this_nQtdPrecoAlt = 0
			DELETE FOR INLIST(Tpdesc, 13)
		ELSE
			REPLACE ALL Descosmax WITH THIS.this_nDescPrecoAlt ;
				FOR Tpdesc = 13
		ENDIF

		*-- (4) tipo 3 (relogio) depende do grupo configurado
		loc_nTipoRe  = THIS.ContarTipoConfig(1, 3, 0, "")
		loc_nGrupoRe = THIS.ContarTipoConfig(1, 3, 1, loc_cCgrus)

		SELECT (par_cAlias)
		IF loc_nTipoRe <> 0 AND loc_nGrupoRe = 0
			DELETE FOR INLIST(Tpdesc, 3)
		ENDIF

		*-- (5) tipo 1 (aniversario) depende do mes de nascimento
		SELECT (par_cAlias)
		IF THIS.this_nQtdAniv = 0
			DELETE FOR INLIST(Tpdesc, 1)
		ENDIF

		*-- (6) produto em promocao: so supervisor (8) e diretoria (9)
		SELECT (par_cAlias)
		IF THIS.this_nQtdPromoImp > 0
			DELETE FOR !INLIST(Tpdesc, 8, 9)
		ENDIF

		*-- (7) produto de/por: so financeiro (2), supervisor (8), diretoria (9)
		SELECT (par_cAlias)
		IF NVL(THIS.this_nPrecode, 0) <> 0
			DELETE FOR !INLIST(Tpdesc, 2, 8, 9)
		ENDIF

		*-- (8) tipo 2 (jolie) com grupo configurado que nao e' o do produto
		loc_nTipoJ  = THIS.ContarTipoConfig(1, 2, 0, "")
		loc_nGrupoJ = THIS.ContarTipoConfig(1, 2, 1, loc_cCgrus)

		IF loc_nTipoJ <> 0 AND loc_nGrupoJ = 0 AND THIS.this_nQtdItdJolie = 0
			loc_cCodTipoJ = THIS.ObterCodigoTipoConfig(1, 2)
			SELECT (par_cAlias)
			DELETE FOR Tpdesc = 2 AND ALLTRIM(Codigos) == loc_cCodTipoJ
		ENDIF

		SELECT (par_cAlias)
	ENDPROC

	*====================================================================
	* MarcarDescontosGravados - pre-seleciona em par_cAlias os tipos de
	* desconto JA gravados em SigMvItd para o item corrente, trazendo o
	* percentual, o valor e o usuario que autorizou.
	*
	* Legado (fim do Init):
	*   SELECT * from crSigmvitd where cpros = lcCpros and citens = pcItem
	*                                                   into cursor crOpItd
	*   SELECT localDes / GO top / SCAN
	*       SELECT crOpItd / LOCATE for cdesc = localDes.codigos
	*       IF FOUND()
	*           replace selecao with 1              in localDes
	*           replace descos  with crOpItd.pdes   in localDes
	*           replace valdes  with crOpItd.vdes   in localDes
	*           replace usuars  with crOpItd.usuars in localDes
	*       ENDIF
	*   ENDSCAN
	*
	* O filtro ganha empdopnums (a chave posicional Emps+Dopes+Numes) em
	* cima de cpros/citens: no legado crSigmvitd JA chega do chamador
	* restrito ao movimento aberto, enquanto aqui a leitura e' direta na
	* tabela e cpros+citens sozinhos casariam o mesmo item de OUTROS
	* movimentos. A chave e' montada com PADR nas partes, NUNCA ALLTRIM -
	* ela e' POSICIONAL (3 + 20 + 6 = 29, a largura de
	* SigMvItd.empdopnums); ALLTRIM nas partes encurta a chave e o SELECT
	* devolve ZERO linhas sem nenhum erro.
	*====================================================================
	PROTECTED PROCEDURE MarcarDescontosGravados(par_cAlias)
		LOCAL loc_cSQL, loc_nResult, loc_cEmpDopNums, loc_cCpros, loc_cCodigo

		loc_cCpros      = ALLTRIM(NVL(THIS.this_cCpros, ""))
		loc_cEmpDopNums = PADR(NVL(THIS.this_cEmps, ""), 3) + ;
						  PADR(NVL(THIS.this_cDopes, ""), 20) + ;
						  STR(NVL(THIS.this_nNumes, 0), 6)

		IF USED("cursor_4c_ItdTmp")
			USE IN cursor_4c_ItdTmp
		ENDIF

		loc_cSQL = "SELECT ISNULL(cdesc, '') AS Cdesc,"
		loc_cSQL = loc_cSQL + " ISNULL(pdes, 0) AS Pdes,"
		loc_cSQL = loc_cSQL + " ISNULL(vdes, 0) AS Vdes,"
		loc_cSQL = loc_cSQL + " ISNULL(usuars, '') AS Usuars"
		loc_cSQL = loc_cSQL + " FROM SigMvItd"
		loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
		loc_cSQL = loc_cSQL + " AND cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)

		loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItdTmp")

		IF loc_nResult < 0
			MsgErro("Erro ao ler os descontos j" + CHR(225) + " gravados do item:" + ;
					CHR(13) + CapturarErroSQL(), "Erro SQL")
		ELSE
			IF USED("cursor_4c_ItdTmp") AND RECCOUNT("cursor_4c_ItdTmp") > 0
				SELECT (par_cAlias)
				GO TOP
				SCAN
					loc_cCodigo = ALLTRIM(NVL(EVALUATE(par_cAlias + ".Codigos"), ""))

					SELECT cursor_4c_ItdTmp
					GO TOP
					LOCATE FOR ALLTRIM(cursor_4c_ItdTmp.Cdesc) == loc_cCodigo

					IF FOUND()
						SELECT (par_cAlias)
						REPLACE Selecao WITH 1, ;
								Descos  WITH NVL(cursor_4c_ItdTmp.Pdes, 0), ;
								Valdes  WITH NVL(cursor_4c_ItdTmp.Vdes, 0), ;
								Usuars  WITH ALLTRIM(NVL(cursor_4c_ItdTmp.Usuars, ""))
					ENDIF

					SELECT (par_cAlias)
				ENDSCAN
			ENDIF
		ENDIF

		IF USED("cursor_4c_ItdTmp")
			USE IN cursor_4c_ItdTmp
		ENDIF

		SELECT (par_cAlias)
		GO TOP
	ENDPROC

	*====================================================================
	* CarregarDescontos - popula cursor_4c_Dados (localDes do legado) com
	* os tipos de desconto que o item corrente pode receber.
	*
	* Pipeline, espelhando o Init legado:
	*
	*  1) cursor_4c_DesTmp  <- SigOpTdz cruzado com SigCdTbd pela operacao
	*                          do movimento (crDesc do legado), com a
	*                          copia de trabalho das colunas de localDes:
	*                          Selecao = 0, Valdes = 0, Descos = 0 e
	*                          Descosmax = SigOpTdz.descos (o teto que o
	*                          Valid da coluna "% Desconto" cobra). O
	*                          legado monta esse mesmo par com
	*                          "Select 0 as selecao, 000000000.00 as
	*                          valdes, descos as descosmax, * from crDesc"
	*                          seguido de "replace all descos with 0.00".
	*  2) cursor_4c_TipoTmp <- SigOpTdt cruzado com SigOpTdz (crTipo),
	*                          ordenado por cidchaves: a configuracao de
	*                          grupo de cada tipo de desconto.
	*  3) ConsultarContextoElegibilidade -> promocao / aniversario /
	*                          troca de preco / jolie ja gravado
	*  4) FiltrarElegibilidade           -> os DELETE do legado
	*  5) MarcarDescontosGravados        -> pre-selecao a partir de SigMvItd
	*  6) cursor_4c_Dados   <- ZAP + APPEND FROM DBF(copia compactada)
	*
	* Dois cuidados de SQL nas consultas 1 e 2:
	*
	*  - COLLATE DATABASE_DEFAULT em "a.codigos = c.codigos":
	*    SigOpTdz.codigos e' SQL_Latin1_General_CP1_CI_AS e
	*    SigCdTbd.codigos e' Latin1_General_CI_AS. Sem o COLLATE o SQL
	*    Server RECUSA a query inteira com conflito de ordenacao, em
	*    runtime, com o .prg compilando limpo. O join de SigOpTdt com
	*    SigOpTdz nao precisa: as duas colunas estao na mesma collation.
	*  - "a.listaemp IS NULL" no filtro do tipo 11: o legado faz
	*    "DELETE FROM crDesc where tpDesc = 11 and !listaemp like '%emp%'"
	*    e, com listaemp nulo, "!NULL" e' NULL no VFP - a linha NAO e'
	*    apagada. Omitir o IS NULL apagaria linha que o legado mantem.
	*
	* O ZAP/APPEND existe porque SQLEXEC (ou SELECT INTO CURSOR) sobre o
	* alias ligado ao Grid o fecha e recria, zerando o ColumnCount - a
	* grade viraria um retangulo branco sem cabecalho, sem erro nenhum.
	* A lista de colunas do CREATE CURSOR aqui e' a MESMA do placeholder
	* criado em FormSigOpDes.ConfigurarGrade, porque APPEND FROM casa as
	* colunas por NOME.
	*====================================================================
	PROCEDURE CarregarDescontos()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmps, loc_cDopes
		LOCAL loc_cListaEmp, loc_cDeletedAnt

		loc_lSucesso = .F.

		TRY
			loc_cEmps     = ALLTRIM(NVL(THIS.this_cEmps, ""))
			loc_cDopes    = ALLTRIM(NVL(THIS.this_cDopes, ""))
			loc_cListaEmp = EscaparSQL("%" + loc_cEmps + "%")

			*-- (1) crDesc: tipos habilitados na operacao do movimento
			IF USED("cursor_4c_DesSql")
				USE IN cursor_4c_DesSql
			ENDIF

			loc_cSQL = "SELECT 0 AS Selecao,"
			loc_cSQL = loc_cSQL + " CAST(0 AS numeric(9,2)) AS Valdes,"
			loc_cSQL = loc_cSQL + " CAST(0 AS numeric(7,4)) AS Descos,"
			loc_cSQL = loc_cSQL + " ISNULL(a.descos, 0) AS Descosmax,"
			loc_cSQL = loc_cSQL + " ISNULL(a.codigos, '') AS Codigos,"
			loc_cSQL = loc_cSQL + " ISNULL(a.descrs, '') AS Descrs,"
			loc_cSQL = loc_cSQL + " ISNULL(a.tpdesc, 0) AS Tpdesc,"
			loc_cSQL = loc_cSQL + " CAST('' AS char(10)) AS Usuars"
			loc_cSQL = loc_cSQL + " FROM SigOpTdz a"
			loc_cSQL = loc_cSQL + " INNER JOIN SigCdTbd c"
			loc_cSQL = loc_cSQL + " ON a.codigos COLLATE DATABASE_DEFAULT = c.codigos"
			loc_cSQL = loc_cSQL + " WHERE c.dopes = " + EscaparSQL(loc_cDopes)
			loc_cSQL = loc_cSQL + " AND a.tpdesc <> 0"
			loc_cSQL = loc_cSQL + " AND (a.tpdesc <> 11 OR a.listaemp IS NULL"
			loc_cSQL = loc_cSQL + " OR CAST(a.listaemp AS varchar(8000)) LIKE " + ;
								  loc_cListaEmp + ")"
			loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesSql")

			IF loc_nResult < 0
				MsgErro("Erro ao carregar os tipos de desconto da opera" + ;
						CHR(231) + CHR(227) + "o:" + CHR(13) + ;
						CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- Copia de trabalho READWRITE: os DELETE/REPLACE de
				*-- elegibilidade nao rodam em cursor de SQL pass-through.
				IF USED("cursor_4c_DesTmp")
					USE IN cursor_4c_DesTmp
				ENDIF
				SELECT * FROM cursor_4c_DesSql INTO CURSOR cursor_4c_DesTmp READWRITE

				IF USED("cursor_4c_DesSql")
					USE IN cursor_4c_DesSql
				ENDIF

				*-- (2) crTipo: configuracao de grupo por tipo de desconto
				IF USED("cursor_4c_TipoTmp")
					USE IN cursor_4c_TipoTmp
				ENDIF

				loc_cSQL = "SELECT ISNULL(b.codigos, '') AS Codigos,"
				loc_cSQL = loc_cSQL + " ISNULL(b.codtips, '') AS Codtips,"
				loc_cSQL = loc_cSQL + " ISNULL(b.tipos, 0) AS Tipos,"
				loc_cSQL = loc_cSQL + " ISNULL(b.cidchaves, '') AS Cidchaves,"
				loc_cSQL = loc_cSQL + " ISNULL(a.tpdesc, 0) AS Tpdesc"
				loc_cSQL = loc_cSQL + " FROM SigOpTdt b"
				loc_cSQL = loc_cSQL + " INNER JOIN SigOpTdz a ON a.codigos = b.codigos"
				loc_cSQL = loc_cSQL + " WHERE a.tpdesc <> 0"
				loc_cSQL = loc_cSQL + " AND (a.tpdesc <> 11 OR a.listaemp IS NULL"
				loc_cSQL = loc_cSQL + " OR CAST(a.listaemp AS varchar(8000)) LIKE " + ;
									  loc_cListaEmp + ")"
				loc_cSQL = loc_cSQL + " ORDER BY b.cidchaves"

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TipoTmp")

				IF loc_nResult < 0
					MsgErro("Erro ao carregar a configura" + CHR(231) + CHR(227) + ;
							"o dos tipos de desconto:" + CHR(13) + ;
							CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- (3) contexto e (4) elegibilidade
					THIS.ConsultarContextoElegibilidade()
					THIS.FiltrarElegibilidade("cursor_4c_DesTmp")

					*-- Compacta: APPEND FROM respeita SET DELETED, e o
					*-- estado do ambiente nao e' garantido aqui. O SET e'
					*-- restaurado logo depois, sem macro.
					loc_cDeletedAnt = SET("DELETED")
					SET DELETED ON

					IF USED("cursor_4c_DesApp")
						USE IN cursor_4c_DesApp
					ENDIF
					SELECT * FROM cursor_4c_DesTmp INTO CURSOR cursor_4c_DesApp READWRITE

					IF loc_cDeletedAnt = "OFF"
						SET DELETED OFF
					ELSE
						SET DELETED ON
					ENDIF

					IF USED("cursor_4c_DesTmp")
						USE IN cursor_4c_DesTmp
					ENDIF

					*-- (5) pre-selecao do que ja esta gravado
					THIS.MarcarDescontosGravados("cursor_4c_DesApp")

					*-- (6) recarga do alias do Grid preservando a estrutura
					IF !USED("cursor_4c_Dados")
						SET NULL ON
						CREATE CURSOR cursor_4c_Dados ;
							(Selecao N(1,0), Descrs C(30), Descos N(7,4), ;
							 Valdes N(9,2), Codigos C(10), Tpdesc N(2,0), ;
							 Descosmax N(7,4), Usuars C(10))
						SET NULL OFF
					ENDIF

					SELECT cursor_4c_Dados
					ZAP

					IF USED("cursor_4c_DesApp") AND RECCOUNT("cursor_4c_DesApp") > 0
						SELECT cursor_4c_Dados
						APPEND FROM DBF("cursor_4c_DesApp")
					ENDIF

					IF USED("cursor_4c_DesApp")
						USE IN cursor_4c_DesApp
					ENDIF
					IF USED("cursor_4c_TipoTmp")
						USE IN cursor_4c_TipoTmp
					ENDIF

					SELECT cursor_4c_Dados
					GO TOP

					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarDescontos")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

