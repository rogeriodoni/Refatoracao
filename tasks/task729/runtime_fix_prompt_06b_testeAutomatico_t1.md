# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[01/11/2026 01:36:04 AM] Empenho: Produto não informado


### LOG DA ETAPA (06b_testeAutomatico):
[2026-11-01 01:36:02] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-01 01:36:02] [INFO] Config FPW: (nao fornecido)
[2026-11-01 01:36:03] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-01 01:36:03] [INFO] Timeout: 300 segundos
[2026-11-01 01:36:03] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qoxmvd1b.prg
[2026-11-01 01:36:03] [INFO] Conteudo do wrapper:
[2026-11-01 01:36:03] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpEmp', 'C:\4c\tasks\task729', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpEmp', 'C:\4c\tasks\task729', 'OPERACIONAL'
QUIT

[2026-11-01 01:36:03] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qoxmvd1b.prg
[2026-11-01 01:36:03] [INFO] VFP output esperado em: C:\4c\tasks\task729\vfp_output.txt
[2026-11-01 01:36:03] [INFO] Executando Visual FoxPro 9...
[2026-11-01 01:36:03] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qoxmvd1b.prg
[2026-11-01 01:36:03] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qoxmvd1b.prg
[2026-11-01 01:36:03] [INFO] Timeout configurado: 300 segundos
[2026-11-01 01:36:04] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-01 01:36:04] [INFO] VFP9 finalizado em 1.095072 segundos
[2026-11-01 01:36:05] [INFO] Exit Code: 
[2026-11-01 01:36:05] [INFO] 
[2026-11-01 01:36:05] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-01 01:36:05] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qoxmvd1b.prg
[2026-11-01 01:36:05] [INFO] 
[2026-11-01 01:36:05] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-01 01:36:05] [INFO] * Auto-generated wrapper for parameters
[2026-11-01 01:36:05] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-01 01:36:05] [INFO] * Parameters: 'FormSigOpEmp', 'C:\4c\tasks\task729', 'OPERACIONAL'
[2026-11-01 01:36:05] [INFO] 
[2026-11-01 01:36:05] [INFO] * Anti-dialog protections for unattended execution
[2026-11-01 01:36:06] [INFO] SET SAFETY OFF
[2026-11-01 01:36:06] [INFO] SET RESOURCE OFF
[2026-11-01 01:36:06] [INFO] SET TALK OFF
[2026-11-01 01:36:06] [INFO] SET NOTIFY OFF
[2026-11-01 01:36:06] [INFO] SYS(2335, 0)
[2026-11-01 01:36:07] [INFO] 
[2026-11-01 01:36:07] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpEmp', 'C:\4c\tasks\task729', 'OPERACIONAL'
[2026-11-01 01:36:07] [INFO] QUIT
[2026-11-01 01:36:07] [INFO] 
[2026-11-01 01:36:07] [INFO] === Fim do Wrapper.prg ===
[2026-11-01 01:36:07] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpEmp",
  "timestamp": "20261101013604",
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEmp.prg):
*==============================================================================
* FormSigOpEmp.prg - Form Operacional: Empenho
* Migrado de: tasks/task729/SIGOPEMP.SCX
* BO: SigOpEmpBO.prg (classes/SigOpEmpBO.prg)
*
* Dialogo filho do movimento (SigMvEtr/Etiqueta), aberto passando a
* referencia do form pai e o numero da data session dele (equivalente a
* Lparameters poForm, pnDatSes do legado). Layout CUSTOMIZADO - NAO segue o
* padrao CRUD Page1=Lista/Page2=Dados: cabecalho + grid de itens empenhados +
* shape decorativo + dois campos de descricao (grupo/conta) + botao
* Encerrar, todos direto no Form.
*
* O legado le crSigMvEtr.Cpros trocando PERMANENTEMENTE a data session do
* dialogo para a do form pai (Set DataSession to pnDatSes, sem restaurar) e
* liga o grid direto ao cursor 'CrEmpenhado' que o pai ja deixa aberto -
* dependencia cruzada entre data sessions, fragil para a arquitetura nova.
* Aqui a troca eh TEMPORARIA (THIS.ObterProdutoDoFormPai): o UNICO uso do
* cursor do pai eh obter o codigo do produto, guardado em THIS.this_cProduto
* e repassado ao BO, que busca os empenhos com SQL proprio
* (SigOpEmpBO.BuscarEmpenhosDoProduto) em vez de depender de CrEmpenhado
* continuar aberto na sessao do pai pelo resto da vida deste dialogo.
*
* FASE 6/8 - SEM TRABALHO NESTA FASE (confirmado contra o dump e o
* comportamento.json, nao assumido por omissao). O SIGOPEMP.SCX legado tem
* so 7 metodos (montagrades, Load, Init, ok.Click, get_NGrupo.When,
* Get_NConta.When, grdItens.AfterRowColChange) e NENHUM casa padrao de
* lookup do Framework (zero fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/
* CreateObject de busca) - comportamento.json.resumo.funcoesExternas lista
* so fConfigGeral e MontaGrade. Os dois UNICOS TextBox do form
* (get_NGrupo/Get_NConta) tem `PROCEDURE When / Return .f.` no legado, ou
* seja NUNCA entram em edicao - sao visores, ja entregues na Fase 5 como
* txt_4c__NGrupo/txt_4c_NConta (ReadOnly=.T./TabStop=.F.) e ja alimentados
* por THIS.BOParaForm(). Nao ha "ultimos 50% de campos" a adicionar (zero
* campos em analise.json.campos) nem container cnt_4c_BotoesAcao
* Salvar/Cancelar - o legado so tem o botao "ok" (Encerrar), ja migrado na
* Fase 5 como cmd_4c_Ok/CmdOkClick. Inventar lookup ou botoes de
* Salvar/Cancelar aqui violaria o PILAR 1 e a regra "NUNCA inventar
* tabelas de lookup que nao existem no original". O unico metodo do dump
* ainda sem equivalente - grdItens.AfterRowColChange - foi portado na
* Fase 7 (handler PUBLIC da grade, conforme ja registrado no cabecalho de
* BOParaForm abaixo).
*
* FASE 7/8 - EVENTOS PRINCIPAIS. Os quatro handlers da barra CRUD do
* framework (um por verbo: incluir, alterar, visualizar e excluir registro)
* NAO existem aqui porque o legado NAO TEM essa barra - conferido no dump,
* nao assumido por omissao:
*   - SIGOPEMP herda de form PURO, e nao da classe de cadastro do framework
*     (zero ocorrencia do nome dessa classe-mae no dump), logo nao herda a
*     barra de botoes dela;
*   - zero ocorrencia do CommandGroup que hospeda essa barra, da variavel de
*     MODO do cadastro e dos quatro verbos CRUD em qualquer forma - nome de
*     objeto, caption, metodo ou chamada de Click;
*   - a SUPERFICIE DE BOTAO do legado eh UM botao so: o dump tem exatamente
*     1 objeto de base commandbutton (SIGOPEMP.ok, Caption "Encerrar") e
*     nenhum de base commandgroup.
* Esse unico botao TEM o seu evento portado (ok.Click = ThisForm.Release ->
* cmd_4c_Ok/CmdOkClick, Fase 5), e a Fase 7 acrescenta o unico outro evento
* do dump, o da grade. Criar os quatro handlers da barra CRUD aqui exigiria
* INVENTAR botoes que o legado nao tem (viola o PILAR 1 e a regra "NUNCA
* inventar") ou escrever quatro metodos vazios (viola a regra de
* completude). O form eh um dialogo filho SOMENTE-LEITURA de consulta:
* coerente com isso, o BO recusa Inserir/Atualizar com a mensagem
* "Empenho e uma tela de consulta".
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO. Fecha a migracao com a
* TABELA DE DISPOSICAO dos 7 (e so 7) metodos do SIGOPEMP.SCX, para que a
* ausencia de qualquer outro seja verificavel e nao presumida:
*
*   metodo do SCX legado        | onde foi parar no migrado
*   ----------------------------|-------------------------------------------
*   montagrades                 | ConfigurarGrid            (Fase 4)
*   Init                        | Init + InicializarForm    (Fase 3)
*   ok.Click                    | CmdOkClick                (Fase 5)
*   get_NGrupo.When  (Return .f)| ReadOnly=.T. + TabStop=.F. (Fase 5)
*   Get_NConta.When  (Return .f)| ReadOnly=.T. + TabStop=.F. (Fase 5)
*   grdItens.AfterRowColChange  | GradeAfterRowColChange    (Fase 7)
*   Load  (=fConfigGeral())     | NAO PORTADO - ver (a)
*
* (a) Load: "=fConfigGeral()". No Fortyus fConfigGeral era inicializacao
*     GLOBAL da aplicacao (parametros do sistema, cursores de referencia),
*     chamada pelo Load de dezenas de telas. Na arquitetura nova esse papel
*     eh de config.prg/ConfigurarAmbiente(), que roda ANTES de qualquer form
*     existir; chama-la daqui seria re-executar inicializacao global no meio
*     da vida da aplicacao. Mesma disposicao, pelo mesmo motivo, de
*     FormSigMvExp/FormSigMvMen/FormSigMvPdt/FormSigMvSbn/FormSigOpClp. O
*     wrapper utils\fconfiggeral.prg existe para o p-code dos VCX legado que
*     ainda chamam o nome (regra #27), nao para codigo nosso.
*
* A Fase 8 corrigiu dois defeitos reais e NAO inventou superficie nova:
*
*   1. ConfigurarOrdemTabulacao() - novo. A ordem de tabulacao saia da ordem
*      de criacao dos AddObject e divergia do legado: o Encerrar vinha ANTES
*      da grade, e a grade (o conteudo da tela) caia em ULTIMO. Medido no
*      VFP9 e documentado no cabecalho do proprio metodo.
*   2. InicializarForm - o bypass de gb_4c_ValidandoUI estava com RETURN no
*      TOPO do metodo, pulando THIS.Picture e TODA a montagem visual; agora
*      cerca apenas CarregarLista(), o unico trecho que depende de SQL.
*
* Os nomes canonicos de form CRUD que a Fase 8 normalmente fecha NAO se
* aplicam aqui, e a razao eh estrutural (conferida no dump, nao presumida
* por omissao) - este eh um dialogo filho de CONSULTA, sem Page2(Dados) e
* sem modo de edicao:
*
*   BtnSalvarClick / BtnCancelarClick - o dump tem exatamente 1 objeto de
*     base commandbutton (SIGOPEMP.ok) e nenhum commandgroup, e o Click dele
*     so faz ThisForm.Release(). Nao existe par Confirmar/Cancelar a migrar;
*     cria-lo seria inventar botao (viola o PILAR 1) e o handler nasceria
*     vazio (viola a regra de completude). O unico botao TEM handler:
*     CmdOkClick.
*   BtnBuscarClick - nao ha campo de filtro nem botao de busca: a tela abre
*     ja filtrada pelo produto que o form pai informa (this_cProduto), que eh
*     o que CarregarLista() consome.
*   FormParaBO - transfere CAMPO EDITAVEL para o BO. Os dois unicos TextBox
*     tem "When / Return .f." no legado: nunca entram em edicao, nunca
*     recebem digitacao do usuario e nada deles tem de voltar ao BO. O
*     sentido que existe de verdade - BO -> campo - esta em BOParaForm().
*   HabilitarCampos - alterna campo entre editavel e somente-leitura por
*     MODO (INCLUIR/ALTERAR/VISUALIZAR). Aqui nao ha modo nem campo
*     editavel: o estado somente-leitura eh invariante, declarado uma vez em
*     ConfigurarPaginaDados (ReadOnly/TabStop) e no Grid (ReadOnly = .T.),
*     exatamente como o legado o declara.
*   AjustarBotoesPorModo - idem: um unico botao, sempre habilitado, sem modo
*     que o afete. O legado tampouco desabilita o "ok" em qualquer caminho.
*
* Ja entregues e consolidados nas fases anteriores, revisados aqui:
* BOParaForm, LimparCampos e CarregarLista (este ultimo PUBLIC, como o
* harness de teste automatizado exige - regra #3).
*==============================================================================

DEFINE CLASS FormSigOpEmp AS FormBase

    DataSession = 2
    ShowWindow = 1
    BorderStyle = 2
    Height      = 600
    Width       = 800
    AutoCenter  = .T.
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .F.
    TitleBar    = 0
    WindowState = 0
    ShowWindow  = 0
    WindowType  = 0

    *-- Referencia ao form pai (equivalente a ThisForm.ParentForm/poForm do legado)
    this_oParentForm = .NULL.

    *-- Codigo do produto cujos empenhos sao exibidos (equivalente a
    *-- Alltrim(crSigMvEtr.Cpros), lido da data session do form pai no Init)
    this_cProduto = ""

    *--------------------------------------------------------------------------
    * Init - recebe o form pai e o numero da data session do pai (equivalente
    * a LParameters poForm, pnDatSes do legado); monta o Caption com CHR() e
    * resolve o produto filtrado antes de delegar ao FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_nDataSes

        THIS.Caption = "Empenho"

        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_oParentForm = par_oParentForm
        ENDIF

        THIS.this_cProduto = THIS.ObterProdutoDoFormPai(par_nDataSes)

        IF !EMPTY(THIS.this_cProduto)
            THIS.Caption = "Empenho - " + ALLTRIM(THIS.this_cProduto)
        ENDIF

        THIS.Icon = gc_4c_CaminhoIcones + "4Control1.ico"

        *-- ShowWindow/WindowType=1 na classe causaria TIMEOUT em VFP9 -T (top-
        *-- level window bloqueante) durante testes headless. Classe definida
        *-- com ShowWindow=0/WindowType=0; producao restaura modal top-level
        *-- aqui (mesmo padrao de FormSigOpChc/FormICD).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType  = 1
            THIS.ShowWindow  = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterProdutoDoFormPai - le crSigMvEtr.Cpros na data session do form pai
    * (equivalente a Alltrim(crSigMvEtr.Cpros) do legado), trocando para ela
    * TEMPORARIAMENTE (mesmo padrao de FormGrupo.prg) e restaurando a sessao
    * corrente em seguida - ao contrario do legado, que troca e nunca
    * restaura.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterProdutoDoFormPai(par_nDataSes)
        LOCAL loc_nSessaoAtual, loc_cProduto, loc_oErro

        loc_cProduto     = ""
        loc_nSessaoAtual = SET("DATASESSION")

        IF VARTYPE(par_nDataSes) = "N" AND par_nDataSes > 0
            TRY
                SET DATASESSION TO (par_nDataSes)
                IF USED("crSigMvEtr") AND !EOF("crSigMvEtr")
                    loc_cProduto = ALLTRIM(TratarNulo(crSigMvEtr.Cpros, ""))
                ENDIF
            CATCH TO loc_oErro
                loc_cProduto = ""
            ENDTRY
            SET DATASESSION TO (loc_nSessaoAtual)
        ENDIF

        RETURN loc_cProduto
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a estrutura base do form operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpEmpBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpEmpBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ELSE
                THIS.this_oBusinessObject.this_cProduto = THIS.this_cProduto

                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                THIS.ConfigurarOrdemTabulacao()

                *-- O bypass de validacao de UI cerca SO o trecho que depende
                *-- de SQL/conexao. Um RETURN no TOPO deste metodo (como
                *-- estava) pularia tambem THIS.Picture e TODA a montagem
                *-- visual: a etapa de UI Fidelity instanciaria um form vazio
                *-- e nenhuma diferenca seria corrigivel, porque o metodo que
                *-- escreve a propriedade nunca teria rodado.
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

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
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (dialogo flat, sem Lista/Dados do CRUD).
    *
    * A ORDEM reproduz a ordem dos objetos no SCX legado (cntSombra, Shape1,
    * ok, get_NGrupo, Get_NConta, grdItens), porque em VFP9 o AddObject
    * define o z-order: o ultimo criado desenha POR CIMA. Importa aqui
    * porque Shape1 (Left 768..788, Top 7..24) fica DENTRO da area do botao
    * Encerrar (Left 725..800, Top 3..78) - criar o Shape DEPOIS do botao o
    * poria sobre ele. ConfigurarPaginaDados vem entao ANTES de
    * ConfigurarBotoes, igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarGrid()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - cria os controles de DADOS do dialogo, todos
    * filhos DIRETOS do Form (nao ha PageFrame nem container de campos):
    *
    *   shp_4c_Shape1  (SIGOPEMP.Shape1)      Top=7   Left=768 20x17
    *   txt_4c__NGrupo (SIGOPEMP.get_NGrupo)  Top=465 Left=68  360x21
    *   txt_4c_NConta  (SIGOPEMP.Get_NConta)  Top=488 Left=68  360x21
    *
    * Propriedades TRANSCRITAS do dump legado, incluindo o par
    * Format/InputMask (CLAUDE.md regra #49 - o migrador costuma descartar
    * os dois). Nao ha `Say`/Label nenhum para esses dois campos no SCX: a
    * SECAO 1 do dump lista apenas cntSombra+2 labels, Shape1, ok,
    * get_NGrupo, Get_NConta e grdItens - os dois campos ficam sem legenda
    * no legado, e inventar rotulo aqui violaria o PILAR 1.
    *
    * ZOrderSet = 3 do dump NAO eh transcrito: eh bookkeeping do Form
    * Designer, nao existe em runtime e estouraria "Property ZORDERSET is
    * not found" no Init (CLAUDE.md regra #33).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Shape1: decorativo, BackStyle=0 (sem preenchimento) e
        *-- BorderStyle=0 (sem borda) exatamente como o dump. Shape NAO tem
        *-- ForeColor/BackColor - a cor mora em BorderColor/FillColor
        *-- (CLAUDE.md regra #33), por isso 136,189,188 vai em .BorderColor.
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 768
            .Width       = 20
            .Height      = 17
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        *-- get_NGrupo: descricao do Grupo Destino da linha corrente da grade
        *-- (SigCdGcr.Descrs). O legado tem `PROCEDURE When / Return .f.`,
        *-- isto eh, o campo NUNCA entra em edicao - eh so visor. O
        *-- equivalente no sistema novo eh ReadOnly = .T. + TabStop = .F.
        *-- (When por BINDEVENT nao eh confiavel em TextBox, CLAUDE.md regra
        *-- #3, e BINDEVENT descarta o retorno do delegate, entao um When
        *-- ligado por BINDEVENT nao bloquearia nada).
        THIS.AddObject("txt_4c__NGrupo", "TextBox")
        WITH THIS.txt_4c__NGrupo
            .Top           = 465
            .Left          = 68
            .Width         = 360
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Format        = "K!"
            .MaxLength     = 50
            .Value         = ""
            .ReadOnly      = .T.
            .TabStop       = .F.
        ENDWITH

        *-- Get_NConta: descricao da Conta Destino da linha corrente da grade
        *-- (SigCdCli.Rclis). Mesmo `When / Return .f.` do get_NGrupo.
        THIS.AddObject("txt_4c_NConta", "TextBox")
        WITH THIS.txt_4c_NConta
            .Top           = 488
            .Left          = 68
            .Width         = 360
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Format        = "K!"
            .MaxLength     = 50
            .Value         = ""
            .ReadOnly      = .T.
            .TabStop       = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - espelha nos dois visores as descricoes que o BO resolveu
    * para a linha corrente da grade (this_cDescricaoGrupo <- SigCdGcr.Descrs,
    * this_cDescricaoConta <- SigCdCli.Rclis), equivalente as duas atribuicoes
    * do AfterRowColChange legado.
    *
    * PROTECTED de proposito, e NAO ha como alargar: eh override de um HOOK
    * que a FormBase ja declara PROTECTED (formbase.prg:280), e em VFP9 o
    * PROTECTED da classe base PREVALECE sobre o override sem modificador
    * (CLAUDE.md regra #51) - medido aqui: chamar de fora estoura "Property
    * BOPARAFORM is not found". So eh chamado por THIS.BOParaForm(), de
    * DENTRO da classe (CarregarLista e, na Fase 7, o handler da grade - que
    * ai sim eh PUBLIC, como BINDEVENT exige).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        TRY
            THIS.txt_4c__NGrupo.Value = TratarNulo( ;
                THIS.this_oBusinessObject.this_cDescricaoGrupo, "")

            THIS.txt_4c_NConta.Value = TratarNulo( ;
                THIS.this_oBusinessObject.this_cDescricaoConta, "")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BOParaForm")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - zera os dois visores de descricao. Chamado quando a
    * grade esta vazia ou fica sem registro corrente: o AfterRowColChange
    * legado tambem grava '' nos dois campos quando o CursorQuery nao acha a
    * descricao (Iif(..., evaluate(...), '')), entao campo vazio eh estado
    * previsto e nao erro.
    *
    * PROTECTED pelo mesmo motivo do BOParaForm: a FormBase declara este hook
    * PROTECTED (formbase.prg:276) e o override nao alarga o escopo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c__NGrupo.Value = ""
        THIS.txt_4c_NConta.Value  = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - cria grd_4c_Dados (equivalente a grdItens do legado) e
    * liga as 7 colunas ao cursor_4c_Empenhado - mesmas colunas, legendas e
    * larguras do PROCEDURE montagrades legado (Emp/Operacao/Codigo/Data/
    * Grupo/Conta/Qtde). O cursor placeholder eh criado ANTES de ligar o
    * ControlSource: Column.ControlSource de alias ainda inexistente derruba
    * o Init (CLAUDE.md regra #41) - CriarCursorEmpenhado() eh o ponto UNICO
    * de CREATE CURSOR desta tela, com a MESMA estrutura usada depois por
    * BuscarEmpenhosDoProduto().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid, loc_cCursor

        THIS.this_oBusinessObject.CriarCursorEmpenhado()
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top               = 122
            .Left              = 37
            .Width             = 725
            .Height            = 343
            .FontName          = "Tahoma"
            .HeaderHeight      = 17
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ColumnCount       = 7
            .RecordSource      = loc_cCursor
        ENDWITH

        loc_oGrid.Column1.ControlSource = loc_cCursor + ".Emps"
        loc_oGrid.Column2.ControlSource = loc_cCursor + ".Dopes"
        loc_oGrid.Column3.ControlSource = loc_cCursor + ".Numes"
        loc_oGrid.Column3.InputMask     = "999999"
        loc_oGrid.Column4.ControlSource = loc_cCursor + ".Datas"
        loc_oGrid.Column5.ControlSource = loc_cCursor + ".GrupoDs"
        loc_oGrid.Column6.ControlSource = loc_cCursor + ".ContaDs"
        loc_oGrid.Column7.ControlSource = loc_cCursor + ".Qtds"
        loc_oGrid.Column7.InputMask     = "9999999.99"

        loc_oGrid.Column1.Width = 31
        loc_oGrid.Column2.Width = 206
        loc_oGrid.Column3.Width = 60
        loc_oGrid.Column4.Width = 80
        loc_oGrid.Column5.Width = 80
        loc_oGrid.Column6.Width = 80
        loc_oGrid.Column7.Width = 80

        loc_oGrid.Column1.Header1.Caption = "Emp"
        loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
        loc_oGrid.Column3.Header1.Caption = "C" + CHR(243) + "digo"
        loc_oGrid.Column4.Header1.Caption = "Data"
        loc_oGrid.Column5.Header1.Caption = "Grupo"
        loc_oGrid.Column6.Header1.Caption = "Conta"
        loc_oGrid.Column7.Header1.Caption = "Qtde"

        loc_oGrid.Column1.Header1.Alignment = 2
        loc_oGrid.Column2.Header1.Alignment = 2
        loc_oGrid.Column3.Header1.Alignment = 2
        loc_oGrid.Column4.Header1.Alignment = 2
        loc_oGrid.Column5.Header1.Alignment = 2
        loc_oGrid.Column6.Header1.Alignment = 2
        loc_oGrid.Column7.Header1.Alignment = 2

        loc_oGrid.Column1.Header1.FontSize = 8
        loc_oGrid.Column2.Header1.FontSize = 8
        loc_oGrid.Column3.Header1.FontSize = 8
        loc_oGrid.Column4.Header1.FontSize = 8
        loc_oGrid.Column5.Header1.FontSize = 8
        loc_oGrid.Column6.Header1.FontSize = 8
        loc_oGrid.Column7.Header1.FontSize = 8

        loc_oGrid.Column1.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column2.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column3.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column4.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column5.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column6.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column7.Header1.ForeColor = RGB(0, 0, 0)

        *-- O PROCEDURE montagrades legado reatribui, no FOR final, Movable/
        *-- Resizable/ReadOnly e FontName de TODA coluna (inclusive do Text1)
        *-- para "Courier New" - isso PREVALECE sobre o FontName Tahoma
        *-- declarado nas propriedades iniciais do grid.
        loc_oGrid.Column1.Movable   = .F.
        loc_oGrid.Column2.Movable   = .F.
        loc_oGrid.Column3.Movable   = .F.
        loc_oGrid.Column4.Movable   = .F.
        loc_oGrid.Column5.Movable   = .F.
        loc_oGrid.Column6.Movable   = .F.
        loc_oGrid.Column7.Movable   = .F.

        loc_oGrid.Column1.Resizable = .F.
        loc_oGrid.Column2.Resizable = .F.
        loc_oGrid.Column3.Resizable = .F.
        loc_oGrid.Column4.Resizable = .F.
        loc_oGrid.Column5.Resizable = .F.
        loc_oGrid.Column6.Resizable = .F.
        loc_oGrid.Column7.Resizable = .F.

        loc_oGrid.Column1.ReadOnly = .T.
        loc_oGrid.Column2.ReadOnly = .T.
        loc_oGrid.Column3.ReadOnly = .T.
        loc_oGrid.Column4.ReadOnly = .T.
        loc_oGrid.Column5.ReadOnly = .T.
        loc_oGrid.Column6.ReadOnly = .T.
        loc_oGrid.Column7.ReadOnly = .T.

        loc_oGrid.Column1.FontName = "Courier New"
        loc_oGrid.Column2.FontName = "Courier New"
        loc_oGrid.Column3.FontName = "Courier New"
        loc_oGrid.Column4.FontName = "Courier New"
        loc_oGrid.Column5.FontName = "Courier New"
        loc_oGrid.Column6.FontName = "Courier New"
        loc_oGrid.Column7.FontName = "Courier New"

        loc_oGrid.Column1.Text1.FontName  = "Courier New"
        loc_oGrid.Column2.Text1.FontName  = "Courier New"
        loc_oGrid.Column3.Text1.FontName  = "Courier New"
        loc_oGrid.Column4.Text1.FontName  = "Courier New"
        loc_oGrid.Column5.Text1.FontName  = "Courier New"
        loc_oGrid.Column6.Text1.FontName  = "Courier New"
        loc_oGrid.Column7.Text1.FontName  = "Courier New"

        loc_oGrid.Column1.Text1.ReadOnly  = .T.
        loc_oGrid.Column2.Text1.ReadOnly  = .T.
        loc_oGrid.Column6.Text1.ReadOnly  = .T.
        loc_oGrid.Column7.Text1.ReadOnly  = .T.

        loc_oGrid.Column1.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column2.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column3.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column4.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column5.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column6.Text1.ForeColor = RGB(0, 0, 0)

        loc_oGrid.Column1.Text1.BackColor = RGB(255, 255, 255)
        loc_oGrid.Column2.Text1.BackColor = RGB(255, 255, 255)
        loc_oGrid.Column3.Text1.BackColor = RGB(255, 255, 255)
        loc_oGrid.Column4.Text1.BackColor = RGB(255, 255, 255)
        loc_oGrid.Column5.Text1.BackColor = RGB(255, 255, 255)
        loc_oGrid.Column6.Text1.BackColor = RGB(255, 255, 255)

        *-- Coluna 5 (Grupo): Text1.Alignment = 3 (direita) no dump legado
        loc_oGrid.Column5.Text1.Alignment = 3

        *-- Coluna 7 (Qtde): destaque em negrito + fundo amarelo claro, igual
        *-- ao dump legado (Column7.FontBold / Column7.BackColor)
        loc_oGrid.Column7.FontBold        = .T.
        loc_oGrid.Column7.Text1.FontBold  = .T.
        loc_oGrid.Column7.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column7.Text1.BackColor = RGB(255, 255, 170)

        *-- Unico evento de dados do form: ao trocar a linha corrente, o
        *-- legado resolve as descricoes de Grupo/Conta e as mostra nos dois
        *-- visores (grdItens.AfterRowColChange). Ligado por BINDEVENT porque
        *-- o Grid eh criado por AddObject e nao ha subclasse onde declarar o
        *-- evento; o delegate eh PUBLIC (CLAUDE.md regra #3).
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cria cmd_4c_Ok (equivalente ao botao "ok" do legado,
    * Caption "Encerrar", que apenas fecha o dialogo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOkClick - equivalente a ThisForm.Release() do botao "ok" legado
    *--------------------------------------------------------------------------
    PROCEDURE CmdOkClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - handler de grd_4c_Dados.AfterRowColChange,
    * equivalente ao grdItens.AfterRowColChange do legado:
    *
    *   thisform.get_NGrupo.Value = Iif(...CursorQuery('SigCdGcr','crSigCdGcr',
    *                                    'codigos',crEmpenhado.GrupoDs,[Descrs])
    *                                    ,evaluate('crSigCdGcr.Descrs'),'')
    *   thisform.get_NConta.Value = Iif(...CursorQuery('SigCdCli','crSigCdCli',
    *                                    'iclis',crEmpenhado.ContaDs,[Rclis])
    *                                    ,evaluate('crSigCdCli.Rclis'),'')
    *
    * As duas consultas ficam no BO (ObterDescricaoGrupo/ObterDescricaoConta,
    * chamadas por CarregarDoCursor); aqui o handler so le a linha corrente e
    * espelha o resultado nos visores via BOParaForm(). Descricao nao
    * encontrada vira string vazia nos dois lados - o Iif(...,'') do legado faz
    * o mesmo, entao campo vazio eh estado previsto e NAO erro.
    *
    * SEM filtro por par_nColIndex, igual ao legado: este handler carrega o
    * DETALHE da linha corrente, que eh o uso CORRETO de AfterRowColChange
    * (CLAUDE.md regra #46 - o que a regra proibe eh validar CELULA aqui,
    * filtrando a coluna, porque nColIndex eh a coluna de DESTINO). O
    * parametro eh declarado porque o evento o passa (regra #3), mesmo sem uso.
    *
    * PUBLIC obrigatoriamente: BINDEVENT em metodo PROTECTED falha em silencio
    * (regra #3). Por isso o corpo chama os hooks PROTECTED BOParaForm/
    * LimparCampos de DENTRO da classe, com THIS. (regra #8).
    *
    * NAO chama Refresh no grid - o legado tambem nao chama, e Refresh aqui
    * redispararia o proprio AfterRowColChange. Atribuir .Value aos dois
    * TextBox nao mexe no ponteiro do cursor da grade, entao nao ha
    * reentrancia a cercar.
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_cCursor, loc_oErro

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista

        TRY
            IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0 ;
                    AND !EOF(loc_cCursor) AND !BOF(loc_cCursor)
                THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
                THIS.BOParaForm()
            ELSE
                *-- Grade vazia ou sem registro corrente: sem linha nao ha
                *-- Grupo/Conta a descrever.
                THIS.LimparCampos()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em GradeAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - popula cursor_4c_Empenhado com os empenhos do produto
    * filtrado (THIS.this_cProduto, resolvido no Init a partir da data
    * session do form pai) e repinta o grid - popular o cursor NAO repinta a
    * grade por si so (CLAUDE.md regra #21): GO TOP + Refresh sao
    * obrigatorios apos a carga.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cCursor

        loc_lSucesso = THIS.this_oBusinessObject.BuscarEmpenhosDoProduto( ;
            go_4c_Sistema.cCodEmpresa, THIS.this_cProduto)

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista

        IF USED(loc_cCursor)
            GO TOP IN (loc_cCursor)
            THIS.grd_4c_Dados.Refresh()

            *-- Linha 1 ja fica corrente, mas o AfterRowColChange NAO dispara
            *-- na carga - entao os dois visores de descricao sao populados
            *-- aqui, senao abririam vazios com a grade cheia.
            IF RECCOUNT(loc_cCursor) > 0 AND !EOF(loc_cCursor)
                THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
                THIS.BOParaForm()
            ELSE
                THIS.LimparCampos()
            ENDIF
        ELSE
            THIS.LimparCampos()
        ENDIF

        IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Empenho")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria cnt_4c_Sombra (equivalente a cntSombra do
    * legado) com os labels de sombra e titulo.
    * Propriedades TRANSCRITAS do dump (SIGOPEMP.cntSombra/lblSombra/
    * lblTitulo): Top=0/Left=0/Width=800/Height=80/BackColor=100,100,100 no
    * container; labels com Left=10/Width=769, lblSombra Top=25/Height=40,
    * lblTitulo Top=24/Height=46/ForeColor branco.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Width         = 769
            .Height        = 40
            .Top           = 25
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize  = .F.
            .Width     = 769
            .Height    = 46
            .Top       = 24
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOrdemTabulacao - reproduz a ORDEM DE TABULACAO do legado.
    *
    * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
    * tem relacao com a do SCX. Nao ha erro, nao ha log e nao aparece em
    * screenshot - so o Tab andando na ordem errada. Aqui o efeito era
    * concreto: o Encerrar vinha ANTES da grade.
    *
    * Os valores do dump (ok=11, get_NGrupo=81, Get_NConta=84, grdItens=2)
    * NAO podem ser transcritos ao pe da letra: o VFP aplica o TabIndex no
    * instante em que CRIA cada objeto e DESCARTA, em silencio, valor acima
    * do numero de controles tab-aveis existentes naquele momento. Medido no
    * VFP9 (automation\medir_tabindex_729.prg), simulando o load na ordem dos
    * registros do SCX: so o 2 da grade sobrevive; 11/81/84 sao descartados.
    *
    *   objeto      | dump | EFETIVO no legado
    *   cntSombra   |  --  | 1
    *   grdItens    |   2  | 2   <- unico valor do dump que sobrevive
    *   ok          |  11  | 3
    *   get_NGrupo  |  81  | 4
    *   Get_NConta  |  84  | 5
    *
    * Por isso aqui vao os ordinais EFETIVOS, com o valor do dump no
    * comentario - escrever "11"/"81"/"84" afirmaria um TabIndex que o
    * objeto nunca guarda e custaria tempo a quem auditar dump x migrado.
    *
    * Medido na MESMA rodada, com a ordem de criacao deste form:
    *   sem este metodo -> cnt=1, NGrupo=2, NConta=3, Ok=4, Grade=5 (ERRADO:
    *                      Encerrar antes da grade, grade em ULTIMO)
    *   com este metodo -> cnt=1, Grade=2, Ok=3, NGrupo=4, NConta=5 (= legado)
    *
    * Tres cuidados que a medicao confirmou:
    *   - ASCENDENTE: cada atribuicao poe o controle na posicao pedida e
    *     empurra os demais para tras; descendente TROCA pares de lugar.
    *   - DEPOIS de todos os AddObject (chamado no fim de InicializarForm).
    *   - Shape NAO TEM TabIndex (medido: PEMSTATUS devolve .F.), por isso
    *     shp_4c_Shape1 fica fora da sequencia e cada atribuicao eh guardada
    *     por PEMSTATUS no PROPRIO controle - PEMSTATUS(THIS, "<nome>", 5) so
    *     diria que o membro existe no form e o metodo quebraria no Shape com
    *     "Property TABINDEX is not found".
    *
    * Os dois TextBox entram na sequencia por fidelidade, mas estao FORA do
    * ciclo do Tab nos dois lados: no legado por "When / Return .f." e aqui
    * por TabStop = .F. (ver ConfigurarPaginaDados). Na pratica o ciclo
    * visivel eh grade -> Encerrar, como no legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
        LOCAL loc_nSeq, loc_nI, loc_cNome, loc_aOrdem[5]

        *-- Ordem EFETIVA do legado (ver tabela no cabecalho deste metodo)
        loc_aOrdem[1] = "cnt_4c_Sombra"     && SCX cntSombra  - sem TabIndex
        loc_aOrdem[2] = "grd_4c_Dados"      && SCX grdItens   - TabIndex 2
        loc_aOrdem[3] = "cmd_4c_Ok"         && SCX ok         - TabIndex 11 (descartado no load)
        loc_aOrdem[4] = "txt_4c__NGrupo"    && SCX get_NGrupo - TabIndex 81 (descartado no load)
        loc_aOrdem[5] = "txt_4c_NConta"     && SCX Get_NConta - TabIndex 84 (descartado no load)

        *-- Contador PROPRIO e sequencial: usar o indice do laco abriria
        *-- lacuna ao pular um controle, e valor FORA da faixa 1..N (N = so
        *-- os controles que TEM TabIndex) eh descartado em silencio.
        loc_nSeq = 0

        FOR loc_nI = 1 TO ALEN(loc_aOrdem)
            loc_cNome = loc_aOrdem[loc_nI]

            IF PEMSTATUS(THIS, loc_cNome, 5)
                *-- Guard no CONTROLE, nao no form: Shape nao tem TabIndex
                IF PEMSTATUS(EVALUATE("THIS." + loc_cNome), "TabIndex", 5)
                    loc_nSeq = loc_nSeq + 1
                    STORE loc_nSeq TO ("THIS." + loc_cNome + ".TabIndex")
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
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
    * Destroy - libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpEmpBO.prg):
*====================================================================
* SigOpEmpBO.prg
*
* Business Object para SigOpEmp (Empenho)
* Form OPERACIONAL (dialogo filho, somente leitura): exibe os itens
* empenhados (reservados) de um produto especifico, recebidos do
* form pai (SigMvEtr/Etiqueta) atraves de um cursor ja montado
* ('CrEmpenhado' no legado - Emps+Dopes+Numes+Datas de SigMvCab
* juntado com Qtds de SigMvItn, filtrado pelo produto corrente).
*
* Tabelas envolvidas: SigMvCab, SigMvItn, SigCdGcr, SigCdCli, SigMvEtr
*====================================================================

DEFINE CLASS SigOpEmpBO AS BusinessBase

	*-- Propriedades da entidade (linha corrente do grid de empenhos)
	this_cEmps = ""              && Empresa (CrEmpenhado.Emps / SigMvCab.Emps)
	this_cDopes = ""             && Codigo da operacao (CrEmpenhado.Dopes / SigMvCab.Dopes)
	this_nNumes = 0              && Numero do movimento (CrEmpenhado.Numes / SigMvCab.Numes)
	this_dDatas = {}             && Data do movimento (CrEmpenhado.Datas / SigMvCab.Datas)
	this_cGrupoDs = ""           && Codigo do Grupo Destino do movimento (CrEmpenhado.GrupoDs / SigMvCab.Grupods)
	this_cContaDs = ""           && Codigo da Conta Destino do movimento (CrEmpenhado.ContaDs / SigMvCab.Contads)
	this_nQtds = 0               && Quantidade empenhada do item (CrEmpenhado.Qtds / SigMvItn.Qtds)

	*-- Propriedade recebida do form pai (filtro do empenho exibido)
	this_cProduto = ""           && Codigo do produto cujos empenhos sao exibidos (SigMvItn.Cpros / crSigMvEtr.Cpros do form pai)

	*-- Propriedades derivadas/exibidas no form (descricoes resolvidas por lookup
	*-- quando o usuario navega entre as linhas da grade - AfterRowColChange)
	this_cDescricaoGrupo = ""    && Descricao do Grupo Destino da linha corrente (SigCdGcr.Descrs), exibida em get_NGrupo
	this_cDescricaoConta = ""    && Descricao da Conta Destino da linha corrente (SigCdCli.Rclis), exibida em Get_NConta

	*-- Nome do cursor de listagem que este BO popula (equivalente a
	*-- CrEmpenhado do legado); mantido como propriedade para o Form
	*-- referenciar sem repetir o literal
	this_cCursorLista = "cursor_4c_Empenhado"

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvCab"
		THIS.this_cCampoChave = "EmpDopNums"

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas do registro corrente do
	* cursor de listagem (cursor_4c_Empenhado, equivalente ao CrEmpenhado
	* do legado) para as propriedades this_* da linha selecionada na
	* grade - usado pelo Form em AfterRowColChange para resolver as
	* descricoes de Grupo/Conta da linha corrente.
	*   par_cAliasCursor - alias a ler; se omitido usa this_cCursorLista
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_cAlias, loc_lSucesso
		loc_lSucesso = .F.

		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
			par_cAliasCursor, THIS.this_cCursorLista)

		IF !USED(loc_cAlias)
			THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
		ELSE
			SELECT (loc_cAlias)

			IF EOF() OR BOF()
				THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente em " + loc_cAlias
			ELSE
				THIS.this_cEmps     = TratarNulo(Emps, "")
				THIS.this_cDopes    = TratarNulo(Dopes, "")
				THIS.this_nNumes    = TratarNulo(Numes, 0)
				THIS.this_dDatas    = TratarNulo(Datas, {})
				THIS.this_cGrupoDs  = TratarNulo(GrupoDs, "")
				THIS.this_cContaDs  = TratarNulo(ContaDs, "")
				THIS.this_nQtds     = TratarNulo(Qtds, 0)

				*-- Resolve as descricoes da linha corrente, igual ao
				*-- Grade.AfterRowColChange do legado
				THIS.this_cDescricaoGrupo = THIS.ObterDescricaoGrupo(THIS.this_cGrupoDs)
				THIS.this_cDescricaoConta = THIS.ObterDescricaoConta(THIS.this_cContaDs)

				loc_lSucesso = .T.
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Chave logica da linha de empenho corrente,
	* equivalente ao EmpDopNums usado no legado (Emps + Dopes + Numes
	* com 6 digitos). PROTECTED: de fora do BO nunca eh chamado
	* (CLAUDE.md regra #51).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
	ENDPROC

	*====================================================================
	* MontarChaveEmpDopNums - Monta a chave Emps+Dopes+Str(Numes,6) usada
	* pelo legado para localizar os itens (SigMvItn) de um movimento
	* (SigMvCab). Publico porque o Form tambem precisa montar essa
	* chave a partir da linha corrente do grid.
	*====================================================================
	FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
		*-- A chave eh POSICIONAL e tem 29 caracteres FIXOS: Emps char(3) +
		*-- Dopes char(20) + Str(Numes,6) = 29, exatamente a largura de
		*-- SigMvCab.EmpDopNums/SigMvItn.EmpDopNums (char(29) no
		*-- docs\schema.sql). ALLTRIM nas partes QUEBRA a busca em
		*-- SILENCIO (CLAUDE.md regra #42) - por isso PADR explicito, sem
		*-- confiar no padding que o cursor por acaso traz.
		RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
		       PADR(TratarNulo(par_cDopes, ""), 20) + ;
		       STR(TratarNulo(par_nNumes, 0), 6)
	ENDFUNC

	*====================================================================
	* Inserir / Atualizar - SigOpEmp eh EXCLUSIVAMENTE uma tela de
	* CONSULTA (dialogo filho que mostra os itens empenhados/reservados
	* de um produto). O codigo fonte legado inteiro
	* (SigOpEmp_form_codigo_fonte.txt) foi conferido e NAO contem
	* nenhum comando de gravacao (Insert/Update/Delete/TableUpdate) - o
	* unico botao ("ok"/Encerrar) apenas chama ThisForm.Release(). Nao
	* existe chave nem tabela propria para gravar aqui, e inventar um
	* INSERT/UPDATE violaria o PILAR 2. Os dois metodos ficam
	* sobrescritos apenas para deixar a mensagem explicita -
	* RegistrarAuditoria() nunca eh chamado porque nenhuma gravacao
	* ocorre.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		THIS.this_cMensagemErro = "Empenho " + CHR(233) + " uma tela de consulta - n" + ;
			CHR(227) + "o grava registros."
		RETURN .F.
	ENDPROC

	PROTECTED PROCEDURE Atualizar()
		THIS.this_cMensagemErro = "Empenho " + CHR(233) + " uma tela de consulta - n" + ;
			CHR(227) + "o grava registros."
		RETURN .F.
	ENDPROC

	*====================================================================
	* CriarCursorEmpenhado - cria (ou recria) o cursor placeholder da
	* grade (cursor_4c_Empenhado), com a MESMA estrutura/ordem de colunas
	* usada por BuscarEmpenhosDoProduto() - o ponto UNICO de CREATE
	* CURSOR desta tela, para o Grid.ControlSource de ConfigurarPaginaLista
	* nunca referenciar alias ainda inexistente (CLAUDE.md regra #41).
	*   par_lForcarRecriar - .T. derruba e recria o alias mesmo existindo
	*====================================================================
	PROCEDURE CriarCursorEmpenhado(par_lForcarRecriar)
		LOCAL loc_cAlias, loc_lRecriar

		loc_cAlias = ALLTRIM(THIS.this_cCursorLista)
		loc_lRecriar = !USED(loc_cAlias)

		IF VARTYPE(par_lForcarRecriar) = "L" AND par_lForcarRecriar
			loc_lRecriar = .T.
		ENDIF

		IF loc_lRecriar
			IF USED(loc_cAlias)
				USE IN (loc_cAlias)
			ENDIF

			*-- Larguras conforme docs\schema.sql (SigMvCab/SigMvItn):
			*-- qtds numeric(9,3) -> N(10,3) (o ponto decimal entra na largura)
			CREATE CURSOR (loc_cAlias) ( ;
				Emps     C(3),    ;
				Dopes    C(20),   ;
				Numes    N(6, 0), ;
				Datas    T,       ;
				GrupoDs  C(10),   ;
				ContaDs  C(10),   ;
				Qtds     N(10, 3) )
		ENDIF

		RETURN USED(loc_cAlias)
	ENDPROC

	*====================================================================
	* BuscarEmpenhosDoProduto - Popula this_cCursorLista (cursor_4c_
	* Empenhado) com os movimentos que tem quantidade empenhada/
	* reservada (SigMvItn.Qtds) do produto informado, juntando o
	* cabecalho do movimento (SigMvCab) com o item (SigMvItn) pela
	* chave EmpDopNums - equivalente ao cursor 'CrEmpenhado' que o form
	* pai (SigMvEtr/Etiqueta) monta e deixa aberto antes de abrir este
	* dialogo (RecordSource = 'CrEmpenhado' no Init legado).
	*   par_cEmps    - empresa (filtra o cabecalho do movimento)
	*   par_cProduto - codigo do produto (SigMvItn.Cpros) cujos
	*                  empenhos devem ser exibidos
	*====================================================================
	FUNCTION BuscarEmpenhosDoProduto(par_cEmps, par_cProduto)
		LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_lSucesso, loc_oErro

		THIS.this_cMensagemErro = ""
		loc_lSucesso  = .F.
		loc_cAliasTmp = "cursor_4c_EmpenhadoTmp"

		IF EMPTY(ALLTRIM(TratarNulo(par_cProduto, "")))
			THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o informado"
			RETURN .F.
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Datas, " + ;
					   "a.Grupods AS GrupoDs, a.Contads AS ContaDs, b.Qtds " + ;
					   "FROM SigMvCab a " + ;
					   "JOIN SigMvItn b ON a.EmpDopNums = b.EmpDopNums " + ;
					   "WHERE b.Cpros = " + EscaparSQL(ALLTRIM(par_cProduto))

			IF VARTYPE(par_cEmps) = "C" AND !EMPTY(ALLTRIM(par_cEmps))
				loc_cSQL = loc_cSQL + " AND a.Emps = " + EscaparSQL(ALLTRIM(par_cEmps))
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.Datas"

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

			IF loc_nResultado < 0
				THIS.this_cMensagemErro = "Erro ao buscar os empenhos do produto:" + ;
					CHR(13) + CapturarErroSQL()
			ELSE
				*-- NAO forcar recriacao do cursor aqui: o Grid da tela ja
				*-- esta com RecordSource/ControlSource ligados a este alias
				*-- (ConfigurarGrid roda ANTES da 1a chamada a este metodo).
				*-- Fechar/recriar o alias (USE IN + CREATE CURSOR) com o
				*-- Grid ja bindado zera o ColumnCount (mesmo efeito do
				*-- SQLEXEC direto sobre alias de grid - CLAUDE.md regra
				*-- correlata). CriarCursorEmpenhado() SEM forcar so cria se
				*-- ainda nao existir; existindo, ZAP + APPEND preserva a
				*-- estrutura e o binding do Grid.
				IF !THIS.CriarCursorEmpenhado(.F.)
					THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
						"vel preparar a lista de empenhos."
				ELSE
					SELECT (THIS.this_cCursorLista)
					ZAP
					IF loc_nResultado > 0
						APPEND FROM DBF(loc_cAliasTmp)
					ENDIF

					GO TOP IN (THIS.this_cCursorLista)
					loc_lSucesso = .T.
				ENDIF
			ENDIF

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterDescricaoGrupo - Descricao do Grupo Destino do movimento
	* (SigCdGcr.Descrs), equivalente ao
	* CursorQuery('SigCdGcr','crSigCdGcr','codigos',GrupoDs,[Descrs])
	* do legado (Grade.AfterRowColChange).
	*====================================================================
	FUNCTION ObterDescricaoGrupo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_cDescricao, loc_oErro

		loc_cDescricao = ""
		loc_cAliasTmp  = "cursor_4c_GrupoDsTmp"

		IF EMPTY(ALLTRIM(TratarNulo(par_cCodigo, ""))) ;
				OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN ""
		ENDIF

		TRY
			loc_cSQL = "SELECT descrs FROM SigCdGcr WHERE codigos = " + ;
				EscaparSQL(ALLTRIM(par_cCodigo))

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

			IF loc_nResultado > 0
				SELECT (loc_cAliasTmp)
				IF !EOF()
					loc_cDescricao = TratarNulo(descrs, "")
				ENDIF
			ENDIF

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF
		CATCH TO loc_oErro
			loc_cDescricao = ""
		ENDTRY

		RETURN loc_cDescricao
	ENDFUNC

	*====================================================================
	* ObterDescricaoConta - Descricao da Conta Destino do movimento
	* (SigCdCli.Rclis), equivalente ao
	* CursorQuery('SigCdCli','crSigCdCli','iclis',ContaDs,[Rclis])
	* do legado (Grade.AfterRowColChange).
	*====================================================================
	FUNCTION ObterDescricaoConta(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_cDescricao, loc_oErro

		loc_cDescricao = ""
		loc_cAliasTmp  = "cursor_4c_ContaDsTmp"

		IF EMPTY(ALLTRIM(TratarNulo(par_cCodigo, ""))) ;
				OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN ""
		ENDIF

		TRY
			loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + ;
				EscaparSQL(ALLTRIM(par_cCodigo))

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

			IF loc_nResultado > 0
				SELECT (loc_cAliasTmp)
				IF !EOF()
					loc_cDescricao = TratarNulo(rclis, "")
				ENDIF
			ENDIF

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF
		CATCH TO loc_oErro
			loc_cDescricao = ""
		ENDTRY

		RETURN loc_cDescricao
	ENDFUNC

ENDDEFINE

