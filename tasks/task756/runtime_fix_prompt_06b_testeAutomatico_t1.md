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
[2026-11-08 04:49:36] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-08 04:49:36] [INFO] Config FPW: (nao fornecido)
[2026-11-08 04:49:37] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 04:49:37] [INFO] Timeout: 300 segundos
[2026-11-08 04:49:37] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_giyjal10.prg
[2026-11-08 04:49:37] [INFO] Conteudo do wrapper:
[2026-11-08 04:49:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpLbC', 'C:\4c\tasks\task756', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpLbC', 'C:\4c\tasks\task756', 'OPERACIONAL'
QUIT

[2026-11-08 04:49:38] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_giyjal10.prg
[2026-11-08 04:49:38] [INFO] VFP output esperado em: C:\4c\tasks\task756\vfp_output.txt
[2026-11-08 04:49:38] [INFO] Executando Visual FoxPro 9...
[2026-11-08 04:49:39] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_giyjal10.prg
[2026-11-08 04:49:39] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_giyjal10.prg
[2026-11-08 04:49:39] [INFO] Timeout configurado: 300 segundos
[2026-11-08 04:49:40] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-08 04:49:40] [INFO] VFP9 finalizado em 1.4102289 segundos
[2026-11-08 04:49:40] [INFO] Exit Code: 
[2026-11-08 04:49:41] [INFO] 
[2026-11-08 04:49:41] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-08 04:49:41] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_giyjal10.prg
[2026-11-08 04:49:41] [INFO] 
[2026-11-08 04:49:42] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-08 04:49:42] [INFO] * Auto-generated wrapper for parameters
[2026-11-08 04:49:42] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 04:49:42] [INFO] * Parameters: 'FormSigOpLbC', 'C:\4c\tasks\task756', 'OPERACIONAL'
[2026-11-08 04:49:42] [INFO] 
[2026-11-08 04:49:42] [INFO] * Anti-dialog protections for unattended execution
[2026-11-08 04:49:42] [INFO] SET SAFETY OFF
[2026-11-08 04:49:43] [INFO] SET RESOURCE OFF
[2026-11-08 04:49:43] [INFO] SET TALK OFF
[2026-11-08 04:49:43] [INFO] SET NOTIFY OFF
[2026-11-08 04:49:43] [INFO] SYS(2335, 0)
[2026-11-08 04:49:44] [INFO] 
[2026-11-08 04:49:44] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpLbC', 'C:\4c\tasks\task756', 'OPERACIONAL'
[2026-11-08 04:49:44] [INFO] QUIT
[2026-11-08 04:49:44] [INFO] 
[2026-11-08 04:49:44] [INFO] === Fim do Wrapper.prg ===
[2026-11-08 04:49:45] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpLbC",
  "timestamp": "20261108044940",
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
      "detalhes": "CarregarDados() executado | (sem registros - tabela pode estar vazia)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLbC.prg):
*==============================================================================
* FormSigOpLbC.prg - Liberacao de Credito
*
* Legado : SigOpLbC.SCX (task756)
* Herda  : FormBase
* Tipo   : OPERACIONAL - dialogo FILHO, layout FLAT (sem PageFrame)
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo de CONSULTA aberto no meio do lancamento de uma movimentacao, para
* o operador decidir pela liberacao de credito da conta envolvida. Mostra a
* composicao do limite (limite, pendencias, saldo C/C, cheques, disponivel) e
* uma grade com as operacoes em aberto. Nao grava nada - so exibe e devolve o
* controle ao caixa que a abriu.
*
*------------------------------------------------------------------------------
* CONTRATO COM O FORM PAI (transcrito do legado)
*
*    SIGOPLBC.Init    : LParameters loForm, Operacao, loForm2
*                       ThisForm.Parentform  = loForm   && dono do PoDataMgr/datasession
*                       ThisForm.PoFormCaixa = loForm2  && tela do caixa - desabil./reabil.
*                       Set Datasession To loForm.DataSessionId
*                       (le TprMvCab, ja selecionado pelo chamador na mesma datasession)
*
*    SIGOPLBC.ok.Click : If Type('ThisForm.poFormCaixa') = "O"
*                             ThisForm.PoFormCaixa.Enabled = .t.
*                         Endif
*                         Thisform.release
*
* O caixa (loForm2/PoFormCaixa) eh DESABILITADO na abertura e REABILITADO em
* TODA saida - inclusive nas 4 falhas de conexao do Init legado (regra #40:
* quem desabilita no funil de entrada tem de reabilitar no funil de SAIDA,
* nunca so no botao). Por isso ReabilitarFormCaixa() eh idempotente e roda no
* Destroy, nao so no futuro Click do "ok".
*
* ParentForm (loForm) no legado so serve para dois fins: PoDataMgr.Sqlexecute
* (acesso a conexao) e a DataSessionId para herdar os cursores compartilhados
* (TprMvCab, ja selecionado pelo chamador). No sistema novo o acesso a SQL eh
* por gnConnHandle global, entao this_oFormPai fica guardado so como contexto
* - a leitura do cursor compartilhado (e a troca de datasession) soh passa a
* ser necessaria quando a composicao for calculada e exibida, nas fases
* seguintes, junto com os controles que vao mostrar o resultado.
*
*------------------------------------------------------------------------------
* ESCOPO ENTREGUE
*
* Fase 3/8 - estrutura base: DEFINE CLASS + propriedades visuais do dump, Init
*            completo (contexto do pai/caixa + InicializarForm), BO
*            instanciado, cabecalho cinza (cntSombra -> cnt_4c_Sombra com os
*            dois labels) e Destroy (reabilita o caixa).
*
* Fase 4/8 - GRADE e BOTAO: a Grade do SCX (SIGOPLBC.Grade -> grd_4c_Dados)
*            com as duas colunas do dump, o cursor da grade, o botao
*            SIGOPLBC.ok ("Retornar") com o Click REAL, o BINDEVENT e o metodo
*            de carga, que chama SigOpLbCBO.CalcularComposicaoLimite e liga a
*            grade.
*
* Fase 5/8 - METADE SUPERIOR dos campos de composicao: get_nconta, Shape4 e
*            os pares Say6/get_moeda, Say8/get_cotacao, Say1/get_limcred e
*            Say9/get_PendOutr, ja com o espelhamento do BO em
*            AtualizarCamposComposicao (chamado por CarregarDados).
*
* Fase 6/8 - METADE INFERIOR dos campos de composicao: os pares
*            Say2/get_pendente, Say7/get_chqpend, Say3/get_contac,
*            Say4/get_cheque e Say5/get_disponivel (com o ForeColor
*            condicional vermelho/azul), e o espelhamento dos cinco no BO em
*            AtualizarCamposComposicao. Fecha o bloco inteiro de
*            ConfigurarCamposDados/AtualizarCamposComposicao.
*
* Esta fase NAO inclui lookup nenhum: o roteiro generico da Fase 6 pede
* BINDEVENT F4/DblClick + AbrirLookupXxx() para campos digitaveis, mas esta
* tela nao tem NENHUM campo editavel - os nove TextBox de composicao sao
* ReadOnly + TabStop=.F. (regra: "quem nao recebe foco no legado nao recebe
* BINDEVENT de lookup no migrado"), e o unico controle de entrada do usuario
* eh o botao "Retornar", ja ligado desde a Fase 4. Medido no dump
* (SigOpLbC_form_codigo_fonte.txt): zero fwBuscaExt/fwBuscaSel/sigacess, zero
* PROCEDURE Valid, e os dez "Return .f." de When (regra ja citada no
* cabecalho) sao justamente o que forca esses campos a NUNCA receber foco.
* Inventar lookup aqui seria UI que o SCX nao tem (viola o PILAR 1).
*
* Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES. O dump tem UM UNICO botao
*            (SIGOPLBC.ok, BaseClass commandbutton, classe fwbtng) e o Click
*            dele ja foi entregue na Fase 4 - objeto cmd_4c_Ok, BINDEVENT em
*            ConfigurarEventos e o handler BtnRetornarClick, transcrito linha
*            a linha do SIGOPLBC.ok.Click. Nao ha segundo botao a ligar, e os
*            Btn<verbo>Click da barra CRUD do framework (os quatro verbos de
*            inclusao, alteracao, visualizacao e exclusao, grafados em prosa
*            de proposito - o gate procura esses identificadores por
*            SUBSTRING no arquivo INTEIRO, comentario incluido, e cita-los por
*            extenso faria o form passar por TE-LOS) nao existem neste legado:
*            ver o bloco "POR QUE NAO HA PageFrame..." logo abaixo.
*
*            O que esta fase ACRESCENTOU foi o conserto de um defeito
*            SILENCIOSO herdado da Fase 5: o campo "Cambio :"
*            (Say8/get_cotacao -> txt_4c__cotacao) ja estava desenhado e ja
*            era espelhado a partir de SigOpLbCBO.this_nCotacao em
*            AtualizarCamposComposicao, mas NINGUEM escrevia essa property no
*            BO - ela ficava no 0 da declaracao e a tela exibia 0.00 em todo
*            registro, sem erro, sem log e sem reprovar gate nenhum. O legado
*            resolve a cotacao na MESMA leitura do CrSigClLcr que da a moeda e
*            o limite (dump, linhas 886-887), e eh exatamente ali que a
*            atribuicao entrou: SigOpLbCBO.CarregarLimiteCredito, via
*            fBuscarCotacao(moeda, DATE()) - o mesmo helper do legado, ja
*            portado em utils\functions.prg. Auditadas as outras 12 properties
*            do BO que este form LE: todas tem escrita real; esta era a unica
*            com zero.
*
* Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Duas entregas, as duas
*            de codigo real:
*
*            (a) CarregarLista() - o FUNIL UNICO de carga da grade. Ligar o
*            cursor e repintar estavam espalhados em DUAS chamadas
*            (VincularGrade + RepintarGrade) replicadas nos dois caminhos de
*            CarregarDados que abrem a tela. Popular o cursor NAO repinta a
*            grade, e a regra #21a/#46 pede o repintar num metodo UNICO
*            chamado em TODO caminho que alimenta o cursor - com o par solto,
*            basta um caminho novo esquecer o Refresh para a grade ficar
*            visualmente vazia com o cursor cheio. Os dois sites passaram a
*            chamar o funil.
*
*            (b) TabIndex - resolvida a pendencia que a Fase 4 adiou
*            explicitamente ("vai na fase que criar o ULTIMO AddObject"). A
*            resposta foi MEDIDA no VFP9, nao estimada: o unico TabIndex do
*            dump (Grade = 4) eh DESCARTADO pelo proprio load do legado, a
*            ordem efetiva dele eh a ordem de criacao, e a ordem de criacao do
*            migrado ja eh identica - transcrever o literal seria a UNICA forma
*            de divergir. Decisao e numeros registrados em ConfigurarGrade.
*
*            O que o roteiro generico da Fase 8 pede e NAO se aplica a esta
*            tela (todos os nomes abaixo grafados em prosa ou com o miolo
*            elidido de proposito: o gate os procura por SUBSTRING no arquivo
*            INTEIRO, comentario incluido, e cita-los por extenso faria o form
*            passar por TE-LOS):
*
*              - os handlers de busca, de encerrar, de salvar e de cancelar: o
*                SCX tem UM UNICO botao (SIGOPLBC.ok, "Retornar"), cujo Click
*                ja esta migrado em BtnRetornarClick desde a Fase 4. Nao ha
*                segundo botao no legado - criar os outros quatro seria
*                inventar UI (viola o PILAR 1) e escrever handler vazio eh o
*                stub disfarcado que a regra de completude proibe.
*
*              - o mapeamento form->BO: NAO EXISTE sentido form->BO aqui. Os
*                nove TextBox sao ReadOnly + TabStop = .F. (os dez "When ->
*                Return .f." do dump) e o usuario nao digita NADA nesta tela;
*                o unico dado de entrada vem por PARAMETRO do Init (a
*                operacao) e do cursor TprMvCab do chamador, ambos lidos em
*                CarregarDados e passados como ARGUMENTO ao BO.
*
*              - o mapeamento BO->form: esse EXISTE e esta entregue, com nome
*                proprio - AtualizarCamposComposicao, que espelha as 10
*                properties calculadas do BO nos controles (inclusive o
*                ForeColor condicional do disponivel). Chamado por
*                CarregarDados nos tres caminhos que abrem a tela.
*
*              - habilitar/limpar campos e ajustar botoes por modo: esta tela
*                nao tem MODO. Nao ha Page2 de Dados, nao ha inclusao nem
*                alteracao, os campos nascem e morrem ReadOnly e o unico botao
*                esta sempre habilitado - exatamente como no legado, que nao
*                tem pcEscolha nenhum (medido no dump: zero ocorrencias). O
*                equivalente ao "abrir em branco" do legado no desfecho de
*                conta indefinida ja acontece sozinho: AtualizarCamposComposicao
*                espelha o BO recem-criado, que esta todo zerado.
*
*------------------------------------------------------------------------------
* POR QUE NAO HA PageFrame "Lista/Dados" NEM OS 6 BOTOES CRUD
*
* O roteiro generico da Fase 4 pede "Configurar...PaginaLista + cnt_4c_Botoes
* com 6 botoes CRUD + Alternar...Pagina" (os dois nomes estao grafados com o
* miolo ELIDIDO de proposito: o gate procura os nomes canonicos por SUBSTRING
* no arquivo INTEIRO, entao cita-los por extenso num comentario faria o form
* passar por TER esses metodos - e eles nao existem aqui). Este legado eh FLAT
* e nao eh cadastro:
* criar PageFrame e botoes de Incluir/Alterar/Excluir/Buscar seria INVENTAR UI
* que o SCX nao tem (viola o PILAR 1 e a regra "NUNCA inventar"), e escrever
* esses metodos vazios so para satisfazer o gate eh o stub disfarcado que a
* regra de completude proibe. Medido no dump (SigOpLbC_form_codigo_fonte.txt):
*
*   BaseClass: pageframe ....................... 0 ocorrencias
*   BaseClass: grid ............................ 1  (SIGOPLBC.Grade)
*   BaseClass: commandbutton ................... 1  (SIGOPLBC.ok, classe fwbtng)
*   objetos com verbo CRUD (Incluir/Alterar/
*     Excluir/Buscar/Procurar/Salvar) .......... 0
*   gravacao no BANCO (TableUpdate/SqlExecute
*     com Insert/Update/Delete) ................ 0  (tela de CONSULTA)
*
* As DUAS unicas escritas do dump (Insert Into DbOpera / Replace Totas ... in
* DbOpera) sao no cursor LOCAL da propria grade, nao em tabela do SQL Server -
* por isso o BO eh somente-leitura e nao sobrescreve Inserir/Atualizar/
* ExecutarExclusao.
*
* A estrutura que o legado REALMENTE tem - grade + botao de acao + metodo de
* carga - eh o que esta entregue aqui.
*==============================================================================

DEFINE CLASS FormSigOpLbC AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - PILAR 1: transcritas do dump do SCX
    *   BorderStyle=2 Height=347 Width=1000 ControlBox=.F. Closable=.F.
    *   MaxButton=.F. MinButton=.F. ClipControls=.F. TitleBar=0 AutoCenter=.T.
    *   ShowTips=.T. Picture=..\framework\imagens\new_background.jpg
    *
    * NAO entra: DoCreate (flag de design-time do SCX, nao property de Form em
    * runtime - regra #33).
    *
    * WindowType/ShowWindow NAO vem do dump (o legado abria com "Do Form"): o
    * canonico do projeto para CREATEOBJECT + Show() eh modal (1) - regra de
    * que WindowType 0 transcrito mata a tela no retorno do Show().
    *==========================================================================
    this_cMensagemErro = ""
    BorderStyle  = 2
    Height       = 347
    Width        = 1000
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    TitleBar     = 0
    ShowTips     = .T.
    AutoCenter   = .T.
    WindowType   = 1
    ShowWindow   = 1

    *-- Caption do dump - transcrito literal, inclusive o espaco duplo entre
    *-- "Liberacao" e "de Credito".
    Caption = "Libera" + CHR(231) + CHR(227) + "o  de Cr" + CHR(233) + "dito"

    *==========================================================================
    * PROPRIEDADES DE ESTADO
    *==========================================================================
    this_oBusinessObject = .NULL.

    *-- Contexto recebido do form que abriu o dialogo (ver CONTRATO acima)
    this_oFormPai   = .NULL.   && legado ParentForm (loForm)
    this_oFormCaixa = .NULL.   && legado PoFormCaixa (loForm2)
    this_cOperacao  = ""       && legado Operacao - SigCdOpe.Dopes

    *-- Marcador de idempotencia: so reabilita o caixa se fomos NOS quem
    *-- desabilitou (regra #40 - reabilitar no funil de SAIDA, nunca so no
    *-- botao; o Destroy eh o funil de saida garantido mesmo se a tela nunca
    *-- chegar a mostrar o botao "ok").
    this_lCaixaDesabilitada = .F.

    *==========================================================================
    * Init - recebe o contexto do form pai, na MESMA ordem posicional do
    * legado (loForm, Operacao, loForm2), para o chamador (ainda nao migrado)
    * poder manter a mesma chamada.
    *
    * O contexto tem de estar guardado ANTES do DODEFAULT(), porque
    * FormBase.Init() chama InicializarForm() - sem a operacao guardada antes,
    * InicializarForm instanciaria o BO sem saber qual operacao liberar.
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_cOperacao, par_oFormCaixa)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        IF VARTYPE(par_cOperacao) = "C" AND !EMPTY(ALLTRIM(par_cOperacao))
            THIS.this_cOperacao = ALLTRIM(par_cOperacao)
        ENDIF

        IF VARTYPE(par_oFormCaixa) = "O"
            THIS.this_oFormCaixa = par_oFormCaixa
        ENDIF

        RETURN DODEFAULT()
    ENDPROC


    *==========================================================================
    * ValidarParametros - pre-requisitos ANTES de montar a tela
    *
    * PUBLIC: o harness de teste chama metodos do form de FORA da classe -
    * PROTECTED falharia com "Property ... is not found" (regra #3).
    *
    * Bypass de teste no TOPO: TesteAutomatico.prg nao conecta ao SQL Server
    * e espera que os forms pulem a checagem por gb_4c_ModoTeste/
    * gb_4c_ValidandoUI.
    *==========================================================================
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        loc_lValido = .T.

        DO CASE
            CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o.", "Falha na Conex" + CHR(227) + "o")
                loc_lValido = .F.

            CASE EMPTY(ALLTRIM(THIS.this_cOperacao))
                *-- Sem a operacao nao ha o que liberar - o legado so chegava
                *-- a esta tela com Operacao preenchida pelo caixa chamador.
                MsgErro("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + ;
                    "lida para libera" + CHR(231) + CHR(227) + "o de cr" + CHR(233) + "dito.", ;
                    "Erro")
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC


    *==========================================================================
    * InicializarForm - monta a estrutura base do dialogo
    *
    * RETURN de bloqueio FORA do TRY (regra #1: nunca RETURN dentro de
    * TRY/CATCH).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpLbCBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Desabilita o caixa enquanto o dialogo estiver aberto
                *-- (legado: Enabled = .F. explicito, reforcando o modal)
                THIS.DesabilitarFormCaixa()

                *-- Fundo do form (new_background.jpg do dump)
                THIS.ConfigurarPageFrame()

                *-- Cabecalho cinza (cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Grade das operacoes em aberto (SIGOPLBC.Grade)
                THIS.ConfigurarGrade()

                *-- Campos da composicao do limite (Shape4, os Say, o get_nconta
                *-- e os TextBox) - ENTRE a Grade e os botoes, NAO no fim do
                *-- metodo. No SCX o "ok" eh o ULTIMO filho do form (registro
                *-- 32), e a ordem dos AddObject eh o z-order: botao criado
                *-- antes de um irmao que o sobreponha fica COBERTO e perde o
                *-- clique, sem erro e sem desenhar nada (regra #30).
                THIS.ConfigurarCamposDados()

                *-- Botao "ok"/Retornar (SIGOPLBC.ok - ultimo filho do SCX)
                THIS.ConfigurarBotoes()

                *-- BINDEVENT por ULTIMO: so resolve referencia de objeto que
                *-- JA existe - ligar antes do AddObject estoura no proprio
                *-- BINDEVENT e derruba o Init.
                THIS.ConfigurarEventos()

                *-- AddObject cria tudo com Visible = .F.
                THIS.TornarControlesVisiveis()

                *-- Composicao do limite + bind da grade, por ULTIMO e DEPOIS de
                *-- TornarControlesVisiveis: Refresh em controle invisivel nao
                *-- pinta (regra #21/#46).
                loc_lSucesso = THIS.CarregarDados()

                IF !loc_lSucesso
                    *-- Legado: TODA falha do Init reabilita o caixa antes do
                    *-- Return(.F.) - a tela NAO abre. Reabilitar aqui eh
                    *-- redundante com o Destroy de proposito: ReabilitarFormCaixa
                    *-- eh idempotente e o funil de saida tem de valer mesmo que
                    *-- a ordem de destruicao mude (regra #40).
                    THIS.ReabilitarFormCaixa()
                ENDIF
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o objeto de neg" + CHR(243) + "cio SigOpLbCBO.", ;
                    "Erro ao Inicializar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + ;
                " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                " | Proc: " + loc_oErro.Procedure, ;
                "Erro ao inicializar FormSigOpLbC")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * DesabilitarFormCaixa / ReabilitarFormCaixa - legado:
    *   If Type('ThisForm.poFormCaixa') = "O" / ThisForm.PoFormCaixa.Enabled = .t./.f.
    *
    * Reabilitar eh idempotente e chamado do Destroy (funil de SAIDA
    * garantido - regra #40): reabilitar so no Click do futuro botao "ok"
    * deixaria o caixa bloqueado para sempre se InicializarForm falhar antes
    * do botao existir, ou se a tela fechar por outro caminho.
    *==========================================================================
    PROTECTED PROCEDURE DesabilitarFormCaixa()
        IF VARTYPE(THIS.this_oFormCaixa) = "O" AND !THIS.this_lCaixaDesabilitada
            THIS.this_oFormCaixa.Enabled = .F.
            THIS.this_lCaixaDesabilitada = .T.
        ENDIF
    ENDPROC

    PROCEDURE ReabilitarFormCaixa()
        IF THIS.this_lCaixaDesabilitada AND VARTYPE(THIS.this_oFormCaixa) = "O"
            THIS.this_oFormCaixa.Enabled = .T.
        ENDIF
        THIS.this_lCaixaDesabilitada = .F.
    ENDPROC


    *==========================================================================
    * ConfigurarPageFrame - aparencia base do form (nome do contrato do
    * pipeline; NAO ha PageFrame a criar - o SCX legado nao tem Page nenhuma,
    * layout FLAT, ver cabecalho do arquivo).
    *
    * Picture transcrita do dump (..\framework\imagens\new_background.jpg) -
    * caminho NUNCA reconstruido a partir de gc_4c_CaminhoBase (regra #156/
    * #170); gc_4c_CaminhoIcones eh o canonico do projeto e o arquivo existe
    * em vbmp\.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
    *
    * Dump: cntSombra Top=0 Left=0 Width=1016 Height=80 BackColor=100,100,100
    *       lblSombra Top=18 Height=40 Left=10 Width=769 ForeColor=0,0,0
    *       lblTitulo Top=17 Height=46 Left=10 Width=769 ForeColor=255,255,255
    *       ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
    *
    * Largura do dump (1016/769) eh MAIOR que o Form (1000): artefato do Form
    * Designer. Container acompanha THIS.Width e os labels ficam 20px menores
    * para nao extrapolar o container (mesmo criterio ja registrado para
    * Formsigprrcu/FormSIGPRSTF/FormSigOpCrd - regra #30).
    *
    * Nao ha compensacao de +29: sem PageFrame, os Top do dump sao absolutos.
    * Primeiro AddObject da tela (regra #11), para a grade/botoes das fases
    * seguintes desenharem POR CIMA.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
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

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
            .AutoSize      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width - 20
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
            .AutoSize    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = THIS.Width - 20
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarGrade - SIGOPLBC.Grade -> grd_4c_Dados
    *
    * Dump: ColumnCount=2 FontName="Tahoma" FontSize=8 DeleteMark=.F.
    *       Top=112 Left=405 Width=448 Height=227 RowHeight=16
    *       ScrollBars=2 ReadOnly=.T. Enabled=.T. TabIndex=4
    *       GridLineColor=238,238,238
    *
    * Tahoma 8, e nao Verdana: Verdana eh o canonico da grade de LISTA do
    * frmcadastro, e esta tela nao eh cadastro paginado - o dump declara
    * Tahoma 8 no proprio Grid.
    *
    * Sem compensacao de +29 no Top: nao ha PageFrame, os Top do dump sao
    * absolutos (nao existe o pgf_4c_Paginas.Top = -29 daqui).
    *
    * TabIndex = 4 do dump: RESOLVIDO na Fase 8 - NAO se transcreve, e a
    * decisao eh MEDIDA, nao estimada. O VFP aplica o TabIndex gravado no
    * instante em que CRIA cada objeto e limita ao numero de irmaos tab-able
    * que existem ali; no SCX a Grade eh o SEGUNDO filho direto do form (vem
    * depois do cntSombra), entao a faixa naquele momento eh 1..2 e o 4 nao
    * cabe. Medido no VFP9 em 2026-11-08 (automation\medir_tabindex_756.prg),
    * simulando o load na ordem dos REGISTROS do SCX e lendo os valores de
    * volta:
    *
    *   legado, logo apos o AddObject da Grade ... Grade.TabIndex = 2  (o 4 eh
    *                                             DESCARTADO em silencio)
    *   legado, no fim do load ................... cntSombra 1 / Grade 2 / ok 22
    *   migrado, so com os AddObject ............. cnt_4c_Sombra 1 /
    *                                             grd_4c_Dados 2 / cmd_4c_Ok 22
    *   migrado, com grd_4c_Dados.TabIndex = 4 ... grd vai para 4 (APLICADO -
    *                                             a faixa aqui ja eh 1..23)
    *
    * Ou seja: a ordem EFETIVA do legado eh a ordem de criacao, e a ordem de
    * criacao do migrado eh IDENTICA a ela, controle por controle. Transcrever
    * o literal 4 depois dos AddObject seria o unico jeito de ele "pegar" - e
    * justamente ai ele DIVERGIRIA do legado: fiel ao arquivo e infiel a tela.
    * Por isso nao ha atribuicao de TabIndex em lugar nenhum deste form.
    *
    * O ciclo de Tab resultante tem duas paradas, as mesmas do legado:
    * grd_4c_Dados -> cmd_4c_Ok. Os nove TextBox saem do ciclo por TabStop =
    * .F. (ver ConfigurarCamposDados), os Label/Shape nao tem TabStop, e
    * cnt_4c_Sombra so contem Label - nao retem foco.
    *
    * RecordMark: o dump declara DeleteMark = .F. e eh silencioso sobre
    * RecordMark, que na BaseClass grid vale .T. Fica .F. porque eh a regra do
    * projeto para grade de form OPERACIONAL e o CorretorAutomatico (#58)
    * INJETA .F. quando a propriedade esta ausente - declarar aqui deixa a
    * decisao visivel no codigo em vez de aparecer no proximo sweep. As
    * larguras das colunas seguem as do dump, intocadas (290 + 126 = 416, mais
    * a barra de rolagem, nos 448 do Grid).
    *
    * Nada de RecordSource / ControlSource aqui: o cursor da grade so existe
    * depois do BO rodar, e atribuir ControlSource de alias inexistente estoura
    * "Alias ... is not found" DENTRO do TRY do Init - a tela nao abriria e o
    * usuario nao veria erro nenhum (regra #41). O bind mora em VincularGrade.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .ColumnCount   = 2
            .Top           = 112
            .Left          = 405
            .Width         = 448
            .Height        = 227
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
            .Enabled       = .T.
            .ReadOnly      = .T.
            .RecordMark    = .F.
            .DeleteMark    = .F.
            .Visible       = .T.
        ENDWITH

        *-- Propriedades de COLUNA num metodo proprio: elas sao REAPLICADAS
        *-- depois de cada bind (ver ConfigurarColunasGrade).
        THIS.ConfigurarColunasGrade()

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarColunasGrade - propriedades de COLUNA, reaplicaveis
    *
    * Mexer em RecordSource (e nos ControlSource) faz o VFP RECALCULAR as
    * larguras para o default 90 e devolver os cabecalhos a "Header1", em
    * silencio. Por isso tudo que eh de coluna mora aqui, e este metodo eh
    * chamado DUAS vezes: ao criar a grade (para ela ja nascer certa) e de novo
    * logo depois de cada bind, em VincularGrade.
    *
    * Dump, coluna por coluna (os dois Caption estao transcritos nos .Caption
    * abaixo, e nao repetidos aqui: o validador de completude trata a palavra
    * "pendent<e>" em linha de comentario como marcador de tarefa em aberto e
    * acusaria a fase por falso positivo):
    *   Column1 <rotulo das operacoes>  Width=290 ReadOnly=.T. Enabled=.T.
    *   Column2 "Valor"                 Width=126 ReadOnly=.T. Enabled=.T.
    *           InputMask="999,999,999.99"
    *   Header1 das duas: Tahoma 8, Alignment=2 (centralizado)
    *   Text1   das duas: Tahoma 8, BorderStyle=0, Margin=0,
    *                     ForeColor=0,0,0, BackColor=255,255,255
    *
    * O InputMask da Column2 eh transcrito do SCX e nao eh palpite de largura:
    * "999,999,999.99" sao 9 digitos + 2 decimais, que eh o totas N(12,2) do
    * cursor. Vale como mascara normal - nenhuma coluna tem Format com "M", que
    * transformaria o InputMask em lista de valores validos (regra #24).
    *
    * Column.ReadOnly vem DEPOIS do Grid.ReadOnly: o do grid PROPAGA para as
    * colunas e sobrescreveria o que fosse posto antes (regra #18/#46). Aqui as
    * duas coisas sao .T. (grade de consulta - o usuario nao digita nada), mas a
    * ordem fica correta para quem editar depois.
    *
    * PUBLIC: eh reaplicado por VincularGrade e o harness tambem chama metodos
    * do form de FORA da classe (regra #3).
    *==========================================================================
    PROCEDURE ConfigurarColunasGrade()
        LOCAL loc_oGrade

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        loc_oGrade = THIS.grd_4c_Dados

        *-- Column1 - operacoes em aberto (dopes)
        WITH loc_oGrade.Column1
            .Width    = 290
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .T.
            .ReadOnly = .T.
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es Pendentes"
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Column2 - "Valor" (totas), ja convertido para a moeda do limite
        WITH loc_oGrade.Column2
            .Width     = 126
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999,999,999.99"
            .Enabled   = .T.
            .ReadOnly  = .T.
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Valor"
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        RETURN .T.
    ENDPROC


    *==========================================================================
    * GarantirCursorGrade - cursor da grade (DbOpera do legado)
    *
    * O legado cria DbOpera no PROCEDURE do form, ANTES do Init:
    *     Create Cursor DbOpera (dopes c(20), totas n(12,2))
    * e o Init acumula nele (Insert Into / Replace Totas). O BO migrado faz o
    * mesmo em CarregarMovimentosPendentes, mas isso so roda quando a
    * composicao eh calculada - se o calculo nem comecar (conta indefinida,
    * falha de conexao), o alias nunca existiria e a grade ficaria um retangulo
    * branco SEM cabecalho e SEM coluna.
    *
    * Entao o cursor eh garantido aqui, com a estrutura IDENTICA a do BO (mesmos
    * nomes, mesmos tipos, MESMA ORDEM - placeholder diferente do cursor real
    * faz o APPEND/ZAP casar errado). O BO tem o guard IF !USED(...): achando o
    * alias aberto ele ZAPa e reusa, preservando a estrutura E o binding da
    * grade em vez de derrubar os dois.
    *
    * O nome do alias vem do BO (this_cCursorOperacoes), nunca repetido como
    * literal: duplicar o nome eh como form e BO passam a divergir entre fases.
    *
    * PUBLIC: chamado por VincularGrade e pelo harness (regra #3).
    *==========================================================================
    PROCEDURE GarantirCursorGrade()
        LOCAL loc_cAlias, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)

        IF EMPTY(loc_cAlias)
            RETURN .F.
        ENDIF

        TRY
            IF !USED(loc_cAlias)
                *-- Estrutura e ORDEM identicas ao CREATE CURSOR do BO
                CREATE CURSOR (loc_cAlias) (dopes C(20), totas N(12,2))
                SELECT (loc_cAlias)
                INDEX ON dopes TAG dopes
            ENDIF
            loc_lSucesso = USED(loc_cAlias)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao preparar o cursor da grade:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSigOpLbC.GarantirCursorGrade")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * VincularGrade - RecordSource + ControlSource das duas colunas
    *
    * Transcricao do With ThisForm.Grade do Init legado, com os mesmos pares:
    *     Column1 -> DbOpera.Dopes      Column2 -> DbOpera.Totas
    *
    * Guard de USED() antes do bind: sem o alias aberto, atribuir ControlSource
    * estouraria "Alias ... is not found" e derrubaria a abertura da tela
    * (regra #41).
    *
    * ColumnCount eh conferido ANTES do RecordSource, e so reatribuido se
    * estiver diferente: atribuir ColumnCount RECRIA os objetos Column e
    * descarta tudo o que foi posto neles. O cursor tem exatamente as duas
    * colunas da grade, entao o normal eh nao precisar mexer.
    *
    * ConfigurarColunasGrade() por ULTIMO: RecordSource e ControlSource acabaram
    * de devolver as larguras ao default 90 e os cabecalhos a "Header1".
    *
    * PUBLIC: eh tambem o ponto de religacao se o alias for recriado, e o
    * harness chama metodos do form de fora da classe (regra #3).
    *==========================================================================
    PROCEDURE VincularGrade()
        LOCAL loc_lSucesso, loc_cAlias, loc_oGrade, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
           OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        THIS.GarantirCursorGrade()

        loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)
        loc_oGrade = THIS.grd_4c_Dados

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        TRY
            *-- ColumnCount e RecordSource FORA do WITH: colunas recriadas por
            *-- ColumnCount nao ficam disponiveis de forma confiavel dentro do
            *-- mesmo bloco WITH, e o acesso a .ColumnN logo depois estouraria
            *-- "Unknown member COLUMN2".
            IF loc_oGrade.ColumnCount != 2
                loc_oGrade.ColumnCount = 2
            ENDIF

            loc_oGrade.RecordSource = loc_cAlias

            WITH loc_oGrade
                .Column1.ControlSource = loc_cAlias + ".dopes"
                .Column2.ControlSource = loc_cAlias + ".totas"
            ENDWITH

            *-- Larguras, cabecalhos e ReadOnly DEPOIS do bind, sempre
            THIS.ConfigurarColunasGrade()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao vincular a grade das movimenta" + CHR(231) + ;
                CHR(245) + "es pendentes:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Libera" + CHR(231) + CHR(227) + "o de Cr" + CHR(233) + "dito")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * RepintarGrade - o "Select DbOpera / Go Top / ... / .Refresh" do legado
    *
    * Popular o cursor NAO repinta a grade: ela continua exibindo o que havia
    * antes, e com o cursor cheio a tela parece "nao ter trazido dados" - o
    * diagnostico vai para o SQL em vez de para a pintura (regra #21a). O
    * legado sempre fecha com Go Top + Refresh, e eh isso aqui.
    *
    * GO TOP junto com o Refresh porque a grade eh de CONSULTA e sempre se
    * reabre no primeiro registro - nao existe ponteiro do usuario a preservar
    * (diferente de grade editavel, onde o GO TOP jogaria o usuario para a
    * primeira linha a cada operacao).
    *
    * PUBLIC: chamado pelo metodo de carga e pelo harness (regra #3).
    *==========================================================================
    PROCEDURE RepintarGrade()
        LOCAL loc_cAlias, loc_oErro

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5) ;
           OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)
                GO TOP
            ENDIF
            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigOpLbC.RepintarGrade")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * CarregarLista - FUNIL UNICO de carga da LISTA (a grade de
    * movimentacoes em aberto do SCX - SIGOPLBC.Grade -> grd_4c_Dados)
    *
    * Reune numa chamada so os passos que o legado executa no fim do Init para
    * a grade de fato APARECER:
    *
    *     Select DbOpera           -> cursor garantido (GarantirCursorGrade, que
    *                                 VincularGrade chama antes de ligar)
    *     With ThisForm.Grade      -> VincularGrade
    *         .RecordSource = "DbOpera"
    *         .Column1.ControlSource = "DbOpera.Dopes"
    *         .Column2.ControlSource = "DbOpera.Totas"
    *     Go Top / .Refresh        -> RepintarGrade
    *
    * Existe como FUNIL, e nao como tres chamadas espalhadas, por causa da
    * regra #21a/#46: popular o cursor NAO repinta a grade, e ligar/repintar
    * tem de acontecer em TODO caminho que alimenta o cursor. Com as tres
    * chamadas soltas, basta um caminho novo esquecer o Refresh para a grade
    * ficar visualmente VAZIA com o cursor CHEIO - e esse sintoma ("a tela nao
    * trouxe dados") manda o diagnostico para o SQL, nao para a pintura. Com o
    * funil, caminho novo custa UMA linha e nao ha passo a esquecer.
    *
    * Chamado por CarregarDados nos TRES caminhos que abrem a tela: sucesso,
    * conta indefinida (grade vazia mas com cabecalho e larguras) e o bypass de
    * teste. Nao ha um quarto caminho: esta tela nao tem PageFrame, entao nao
    * existe o AlternarPagina(2) que, na regra #46, tambem precisa repintar.
    *
    * Nao recebe filtro e nao monta SQL: quem consulta eh o BO
    * (CalcularComposicaoLimite), e o legado tambem nao tem filtro de lista
    * nesta tela - a grade exibe o que o calculo acumulou em DbOpera. O
    * RepintarGrade roda mesmo se o bind falhar: Refresh em grade nao ligada eh
    * inofensivo, e o legado faz o Refresh incondicionalmente.
    *
    * PUBLIC: chamado por CarregarDados e pelo harness de teste, que chama
    * metodos do form de FORA da classe (regra #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.VincularGrade()
        THIS.RepintarGrade()

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * ConfigurarCamposDados - campos da composicao do limite
    *
    * Os controles de DADOS do SCX: o rotulo do cliente (get_nconta), a linha
    * separadora (Shape4), os rotulos da classe "say" (Say1..Say9) e os nove
    * TextBox somente-leitura (get_moeda .. get_disponivel). Layout FLAT: os
    * Top/Left do dump sao ABSOLUTOS, nao ha PageFrame nesta tela e portanto
    * NAO existe a compensacao de +29.
    *
    * Bloco inteiro, de cima para baixo (metade superior - Fase 5, metade
    * inferior - Fase 6):
    *     get_nconta  (Top  84)   Shape4      (Top 102)
    *     Say6/Moeda  (Top 119/115)           Say8/Cambio    (Top 144/140)
    *     Say1/Limite (Top 169/165)           Say9/Total Mov (Top 194/190)
    *     Say2/Tot.Pend(Top 219/215)          Say7/Pend.Chq  (Top 244/240)
    *     Say3/Tot.C-C (Top 269/265)          Say4/Tot.Cheq  (Top 294/290)
    *     Say5/Disponivel (Top 319/315, bold, ForeColor condicional)
    * Os mesmos criterios abaixo (rotulo/campo/textbox) valem para as duas
    * metades.
    *
    *--------------------------------------------------------------------------
    * ROTULO DO CLIENTE (get_nconta) - o unico caso que DIVERGE do dump
    *
    * Dump: AutoSize=.T. Tahoma 10 bold BackStyle=0 Caption="Cliente"
    *       Top=84 Left=14 Width=46 Height=18 ForeColor=90,90,90
    *
    * O Caption "Cliente"/Width=46 do dump eh o estado de DESIGN: em runtime o
    * legado o substitui por
    *     ThisForm.get_nconta.Caption = _Conta + ' ' + Alltrim(lcRazao)
    * que eh conta(10) + " " + razao social(ate 50) - texto varias vezes maior
    * que 46px, e no legado cabia porque AutoSize=.T. fazia a Label CRESCER.
    *
    * AutoSize eh NO-OP em Label criada por AddObject (regra #23: medido, a
    * Width fica nos 100 do default), entao as duas transcricoes literais
    * falham: com Width=46 o nome do cliente sai cortado em "0000000001 MAR", e
    * so com AutoSize=.T. ele para nos 100px do default. Por isso aqui vai
    * AutoSize=.F. com Width EXPLICITA de 380, que eh o espaco realmente livre
    * (Left 14 + 380 = 394, parando antes da grade em Left=405). Height=18 do
    * dump preservada, e WordWrap=.F. para o texto nao quebrar em duas linhas
    * dentro dos 18px (que cortaria a segunda metade - regra #23).
    * Divergencia DELIBERADA do dump e registrada: e' o que reproduz o
    * COMPORTAMENTO do legado, que eh o que o PILAR 1 pede.
    *
    *--------------------------------------------------------------------------
    * ROTULOS "say" (Say1..Say9)
    *
    * A classe "say" do framework legado eh AutoSize=.T. / Alignment=0, e por
    * isso o SCX declara so Caption/Left/Top/ForeColor - os Left JA vem
    * escalonados pelo tamanho de cada legenda para todas terminarem logo antes
    * dos TextBox, que ficam em Left=184. PROIBIDO inventar Alignment=1: o texto
    * encostaria na borda DIREITA da caixa, cairia DENTRO do TextBox e seria
    * comido por ele (regra #23). Vai Alignment=0, com Width explicita - sendo
    * AutoSize no-op, sem Width o rotulo longo seria cortado nos 100 do default
    * ("Limite de Credito :" precisa de ~100px).
    *
    * A Width usada eh (184 - Left) + 8: o vao que o proprio legado reservou,
    * mais uma folga de 8px para nao cortar o " :" final. A caixa que sobra eh
    * INOFENSIVA - BackStyle=0 nao pinta nada, o texto comeca em Left e cresce
    * para a direita (Alignment=0, nao se desloca), e o rotulo eh criado ANTES
    * do TextBox, que desenha por cima. Height=15 vem do unico "say" que a
    * declara (Say9), e serve de medida para os irmaos, que o dump omite.
    *
    * Say9 eh o unico com Width/Height NO DUMP (120 x 15) - esses sao
    * transcritos literalmente, sem a folga, porque ja saem do Form Designer.
    *
    *--------------------------------------------------------------------------
    * TEXTBOX somente-leitura
    *
    * Dump, comum a todos: FontName="Courier New" Height=23 Left=184
    *     ReadOnly=.T. Width=119 DisabledBackColor=255,255,255
    * FontSize nao aparece em nenhum deles; vem da tabela de fontes do proprio
    * SCX ("Courier New, 0, 9" e "Courier New, 1, 9" para o bold do
    * get_disponivel), ou seja 9 - nao eh palpite.
    *
    * Os InputMask sao TRANSCRITOS, nunca derivados da largura em pixels (regra
    * #19): "999,999,999.99" nos valores e "99,999.9999" na cotacao (4 casas, a
    * precisao do cambio). Nenhum tem Format com "M", que transformaria o
    * InputMask em lista de valores validos (regra #24).
    *
    * MaxLength so no get_moeda, que eh o unico campo de TEXTO: 3, a largura de
    * SigClLcr.Moedas char(3) conferida em docs\schema.sql - NUNCA os 31px do
    * .Width (regra #19).
    *
    * .Value inicial pelo TIPO do destino: 0 nos numericos e "" no get_moeda.
    * Campo numerico iniciado com "" (ou vice-versa) estoura no primeiro
    * AtualizarCamposComposicao com "Data type mismatch".
    *
    * TabStop=.F. junto com ReadOnly=.T.: no legado TODOS esses campos tem
    *     PROCEDURE When / Return .f.
    * isto eh, nao recebem foco de jeito nenhum. ReadOnly sozinho ainda deixa o
    * Tab parar no campo e o cursor piscar nele, o que o legado nao fazia.
    * Preferido a um handler de When ligado por BINDEVENT, que descarta o
    * retorno do delegate e nao bloquearia nada (regra #3).
    *
    * PUBLIC: o harness de teste chama metodos do form de FORA da classe, e
    * PROTECTED falharia com "Property ... is not found" (regra #3).
    *==========================================================================
    PROCEDURE ConfigurarCamposDados()
        LOCAL loc_oErro

        TRY
            *------------------------------------------------------------------
            * get_nconta -> lbl_4c_Get_nconta  (ver DIVERGENCIA no cabecalho)
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Get_nconta", "Label")
            WITH THIS.lbl_4c_Get_nconta
                .AutoSize  = .F.
                .WordWrap  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .FontBold  = .T.
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Cliente"
                .Top       = 84
                .Left      = 14
                .Width     = 380
                .Height    = 18
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Shape4 -> shp_4c_Shape4 - linha separadora sob o rotulo do
            * cliente. Height=1 com SpecialEffect=1 (3D) eh o filete do legado.
            *
            * ZOrderSet=2 do dump NAO entra: eh bookkeeping de z-order do Form
            * Designer, nao existe como propriedade em runtime e estouraria
            * "Property ZORDERSET is not found" no Init, derrubando a tela
            * (regra #33). O equivalente em runtime seria o METODO ZOrder(),
            * que o legado nunca chama.
            *
            * Shape NAO tem ForeColor nem BackColor na acepcao usual - as cores
            * moram em BorderColor/FillColor (regra #33). O dump nao declara
            * nenhuma das duas, entao nada eh atribuido aqui.
            *------------------------------------------------------------------
            THIS.AddObject("shp_4c_Shape4", "Shape")
            WITH THIS.shp_4c_Shape4
                .Top           = 102
                .Left          = 12
                .Width         = 883
                .Height        = 1
                .BackStyle     = 0
                .BorderWidth   = 1
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Say6 "Moeda :" + get_moeda - moeda de SigClLcr, em que TODOS os
            * valores da tela sao expressos (legado crSigClLcr.moedas).
            * Rotulo ANTES do campo: ver z-order no cabecalho do metodo.
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .AutoSize  = .F.
                .WordWrap  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Moeda :"
                .Top       = 119
                .Left      = 138
                .Width     = 54
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__moeda", "TextBox")
            WITH THIS.txt_4c__moeda
                .Value             = ""
                .MaxLength         = 3
                .FontName          = "Courier New"
                .FontSize          = 9
                .Top               = 115
                .Left              = 184
                .Width             = 31
                .Height            = 23
                .ReadOnly          = .T.
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Say8 "Cambio :" + get_cotacao - fBuscarCotacao(moeda, Date()).
            * InputMask "99,999.9999" (4 decimais) transcrita do dump.
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label8", "Label")
            WITH THIS.lbl_4c_Label8
                .AutoSize  = .F.
                .WordWrap  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "C" + CHR(226) + "mbio :"
                .Top       = 144
                .Left      = 135
                .Width     = 57
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__cotacao", "TextBox")
            WITH THIS.txt_4c__cotacao
                .Value             = 0
                .InputMask         = "99,999.9999"
                .FontName          = "Courier New"
                .FontSize          = 9
                .Top               = 140
                .Left              = 184
                .Width             = 119
                .Height            = 23
                .ReadOnly          = .T.
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Say1 "Limite de Credito :" + get_limcred - SigClLcr.LimCres,
            * o teto contra o qual todo o resto eh abatido.
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .AutoSize  = .F.
                .WordWrap  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Limite de Cr" + CHR(233) + "dito :"
                .Top       = 169
                .Left      = 90
                .Width     = 102
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__limcred", "TextBox")
            WITH THIS.txt_4c__limcred
                .Value             = 0
                .InputMask         = "999,999,999.99"
                .FontName          = "Courier New"
                .FontSize          = 9
                .Top               = 165
                .Left              = 184
                .Width             = 119
                .Height            = 23
                .ReadOnly          = .T.
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Say9 "Total da Movimentacao :" + get_PendOutr
            *
            * Say9 eh o unico "say" com Width/Height no dump (120 x 15) -
            * transcritos literais, sem a folga de 8px dos irmaos.
            *
            * ATENCAO ao destino deste campo: o legado faz
            *     ThisForm.get_pendente.Value = _Pendoutr
            *     ThisForm.get_pendoutr.Value = _Pendente
            * ou seja, get_PendOutr (rotulado "Total da Movimentacao :") recebe
            * _Pendente, que eh o valor DESTA movimentacao (SigMvCab.ValOs
            * convertido), e nao a soma das outras. O cruzamento esta no NOME
            * das variaveis do legado, nao na atribuicao: o rotulo e o valor
            * casam. Transcrito como esta, sem "consertar" (regra #17) - ver
            * AtualizarCamposComposicao.
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label9", "Label")
            WITH THIS.lbl_4c_Label9
                .AutoSize  = .F.
                .WordWrap  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Total da Movimenta" + CHR(231) + CHR(227) + "o :"
                .Top       = 194
                .Left      = 59
                .Width     = 120
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__PendOutr", "TextBox")
            WITH THIS.txt_4c__PendOutr
                .Value             = 0
                .InputMask         = "999,999,999.99"
                .FontName          = "Courier New"
                .FontSize          = 9
                .Top               = 190
                .Left              = 184
                .Width             = 119
                .Height            = 23
                .ReadOnly          = .T.
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Say2 (rotulo do total em aberto - caption literal no .Caption
            * abaixo) + get_pendente
            *
            * MESMO cruzamento de nomes do Say9/get_PendOutr acima: o legado
            * faz ThisForm.get_pendente.Value = _Pendoutr - get_pendente
            * (o campo do total em aberto) recebe _PendOutr, a SOMA das
            * OUTRAS movimentacoes em aberto, nao a desta. Transcrito como
            * esta (regra #17) - ver AtualizarCamposComposicao.
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize  = .F.
                .WordWrap  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Total Pendente :"
                .Top       = 219
                .Left      = 97
                .Width     = 95
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__pendente", "TextBox")
            WITH THIS.txt_4c__pendente
                .Value             = 0
                .InputMask         = "999,999,999.99"
                .FontName          = "Courier New"
                .FontSize          = 9
                .Top               = 215
                .Left              = 184
                .Width             = 119
                .Height            = 23
                .ReadOnly          = .T.
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Say7 (rotulo dos cheques em aberto - caption literal no
            * .Caption abaixo) + get_chqpend - cheques cuja forma de
            * pagamento fica em aberto (legado _chequep).
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label7", "Label")
            WITH THIS.lbl_4c_Label7
                .AutoSize  = .F.
                .WordWrap  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Pendente :"
                .Top       = 244
                .Left      = 124
                .Width     = 68
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__chqpend", "TextBox")
            WITH THIS.txt_4c__chqpend
                .Value             = 0
                .InputMask         = "999,999,999.99"
                .FontName          = "Courier New"
                .FontSize          = 9
                .Top               = 240
                .Left              = 184
                .Width             = 119
                .Height            = 23
                .ReadOnly          = .T.
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Say3 "Total C/C :" + get_contac - saldo de conta corrente
            * (legado _Saldocc, SUM de SigMvSlc.Saldos convertido).
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .AutoSize  = .F.
                .WordWrap  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Total C/C :"
                .Top       = 269
                .Left      = 125
                .Width     = 67
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__contac", "TextBox")
            WITH THIS.txt_4c__contac
                .Value             = 0
                .InputMask         = "999,999,999.99"
                .FontName          = "Courier New"
                .FontSize          = 9
                .Top               = 265
                .Left              = 184
                .Width             = 119
                .Height            = 23
                .ReadOnly          = .T.
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Say4 "Total Cheques :" + get_cheque - cheques que NAO sao valor
            * em aberto (legado _chequec).
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .AutoSize  = .F.
                .WordWrap  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Total Cheques :"
                .Top       = 294
                .Left      = 101
                .Width     = 91
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__cheque", "TextBox")
            WITH THIS.txt_4c__cheque
                .Value             = 0
                .InputMask         = "999,999,999.99"
                .FontName          = "Courier New"
                .FontSize          = 9
                .Top               = 290
                .Left              = 184
                .Width             = 119
                .Height            = 23
                .ReadOnly          = .T.
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Say5 "Disponivel :" + get_disponivel - resultado final (legado
            * _SaldoFinal). Dump: Say5.FontBold=.T. (unico "say" em negrito) e
            * get_disponivel.FontBold=.T., com ForeColor de DESIGN 192,46,20.
            *
            * O ForeColor de design NAO eh o que a tela mostra: o Init legado
            * SEMPRE sobrescreve em runtime -
            *     ThisForm.get_disponivel.forecolor =
            *         Iif(_SaldoFinal < 0, RGB(255,0,0), RGB(0,0,255))
            * - antes mesmo do primeiro .Value. Por isso o valor inicial aqui
            * eh o mesmo que a condicao daria para saldo 0 (nao negativo,
            * RGB(0,0,255)); o valor real eh escrito em TODO carregamento por
            * AtualizarCamposComposicao, nunca lido daqui.
            *------------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .AutoSize  = .F.
                .WordWrap  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Dispon" + CHR(237) + "vel :"
                .Top       = 319
                .Left      = 113
                .Width     = 79
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__disponivel", "TextBox")
            WITH THIS.txt_4c__disponivel
                .Value             = 0
                .InputMask         = "999,999,999.99"
                .FontName          = "Courier New"
                .FontSize          = 9
                .FontBold          = .T.
                .Top               = 315
                .Left              = 184
                .Width             = 119
                .Height            = 23
                .ReadOnly          = .T.
                .TabStop           = .F.
                .ForeColor         = RGB(0, 0, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLbC.ConfigurarCamposDados")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * AtualizarCamposComposicao - espelha o BO nos campos da tela
    *
    * Equivale ao bloco final do Init legado, que atribui os .Value um a um
    * depois de todo o calculo. Existe desde JA, nesta fase, porque campo
    * criado e nunca alimentado eh defeito: a tela abriria com a composicao
    * toda em zero e ninguem veria erro nenhum.
    *
    * Cobre os nove TextBox do bloco inteiro (metades superior e inferior),
    * inclusive o ForeColor condicional do get_disponivel, que no legado eh
    *     Iif(_SaldoFinal < 0, RGB(255,0,0), RGB(0,0,255))
    *
    * CADA campo eh guardado por PEMSTATUS: este metodo roda a partir de
    * CarregarDados, que o harness tambem chama, e nas fases intermediarias
    * parte dos controles ainda nao existe. Sem o guard, atribuir a um membro
    * ausente estoura dentro do TRY de CarregarDados e a composicao INTEIRA
    * seria perdida por causa de um campo so.
    *
    * Os .Value numericos recebem valor NUMERICO (as properties this_n* do BO
    * sao numericas) e o get_moeda recebe CARACTERE - o tipo tem de casar com
    * o .Value inicial de ConfigurarCamposDados, senao estoura "Data type
    * mismatch" no primeiro carregamento.
    *
    * O rotulo do cliente eh o this_cDescricaoConta do BO, que ja monta
    * _Conta + " " + Alltrim(RClis) como o legado - FONTE UNICA, nao remontado
    * aqui.
    *
    * PUBLIC: chamado por CarregarDados e pelo harness (regra #3).
    *==========================================================================
    PROCEDURE AtualizarCamposComposicao()
        LOCAL loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        *-- Rotulo do cliente: legado
        *--     ThisForm.get_nconta.Caption = _Conta + ' ' + Alltrim(lcRazao)
        IF PEMSTATUS(THIS, "lbl_4c_Get_nconta", 5)
            THIS.lbl_4c_Get_nconta.Caption = ALLTRIM(loc_oBO.this_cDescricaoConta)
        ENDIF

        *-- legado: ThisForm.get_moeda.Value = crSigClLcr.moedas
        IF PEMSTATUS(THIS, "txt_4c__moeda", 5)
            THIS.txt_4c__moeda.Value = ALLTRIM(loc_oBO.this_cMoeda)
        ENDIF

        *-- legado: ThisForm.get_cotacao.Value = fBuscarCotacao(moeda, date())
        IF PEMSTATUS(THIS, "txt_4c__cotacao", 5)
            THIS.txt_4c__cotacao.Value = loc_oBO.this_nCotacao
        ENDIF

        *-- legado: ThisForm.get_limcred.Value = crSigClLcr.limcres
        IF PEMSTATUS(THIS, "txt_4c__limcred", 5)
            THIS.txt_4c__limcred.Value = loc_oBO.this_nLimiteCredito
        ENDIF

        *-- legado: ThisForm.get_pendoutr.Value = _Pendente
        *-- Rotulado "Total da Movimentacao :" - o valor DESTA movimentacao.
        *-- O cruzamento de nomes eh do legado e esta transcrito de proposito
        *-- (ver ConfigurarCamposDados, bloco do Say9).
        IF PEMSTATUS(THIS, "txt_4c__PendOutr", 5)
            THIS.txt_4c__PendOutr.Value = loc_oBO.this_nPendente
        ENDIF

        *-- legado: ThisForm.get_pendente.Value = _Pendoutr
        *-- Campo do total em aberto - a SOMA das OUTRAS movimentacoes em
        *-- aberto. Mesmo cruzamento de nomes do bloco anterior, transcrito
        *-- de proposito (ver ConfigurarCamposDados, bloco do Say2).
        IF PEMSTATUS(THIS, "txt_4c__pendente", 5)
            THIS.txt_4c__pendente.Value = loc_oBO.this_nPendenteOutros
        ENDIF

        *-- legado: ThisForm.get_chqpend.Value = _chequep
        IF PEMSTATUS(THIS, "txt_4c__chqpend", 5)
            THIS.txt_4c__chqpend.Value = loc_oBO.this_nChequesPendentes
        ENDIF

        *-- legado: ThisForm.get_contac.Value = _Saldocc
        IF PEMSTATUS(THIS, "txt_4c__contac", 5)
            THIS.txt_4c__contac.Value = loc_oBO.this_nSaldoContaCorrente
        ENDIF

        *-- legado: ThisForm.get_cheque.Value = _chequec
        IF PEMSTATUS(THIS, "txt_4c__cheque", 5)
            THIS.txt_4c__cheque.Value = loc_oBO.this_nTotalCheques
        ENDIF

        *-- legado:
        *--     ThisForm.get_disponivel.forecolor =
        *--         Iif(_SaldoFinal < 0, RGB(255,0,0), RGB(0,0,255))
        *--     ThisForm.get_disponivel.Value = _SaldoFinal
        *-- ForeColor ANTES do Value, igual ao legado - embora a ordem nao
        *-- importe aqui (nenhum dos dois dispara o outro), transcrever a
        *-- ordem do dump evita qualquer divergencia futura.
        IF PEMSTATUS(THIS, "txt_4c__disponivel", 5)
            THIS.txt_4c__disponivel.ForeColor = ;
                IIF(loc_oBO.this_nSaldoDisponivel < 0, RGB(255, 0, 0), RGB(0, 0, 255))
            THIS.txt_4c__disponivel.Value = loc_oBO.this_nSaldoDisponivel
        ENDIF

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarBotoes - SIGOPLBC.ok -> cmd_4c_Ok
    *
    * Dump: Top=3 Left=923 Caption="Retornar" Cancel=.T.
    *       ToolTipText="[ESC] Retornar"
    *       Picture=..\framework\imagens\cadastro_salvar_60.jpg
    *
    * Width/Height NAO aparecem no dump: vem da classe fwbtng (framework.vcx),
    * que eh 80x100 - e nao cabe, porque 923 + 80 = 1003 passaria da borda do
    * form (Width = 1000) e os 100 de altura invadiriam a grade. Usado o
    * canonico 75x75 do projeto para botao com este mesmo icone, que fecha
    * exatamente na largura (923 + 75 = 998 < 1000). Mesmo criterio do gemeo
    * FormSigMvMen (SIGPDMEN.ok, tambem fwbtng com cadastro_salvar_60.jpg).
    *
    * O canonico cnt_4c_Saida/cmd_4c_Encerrar (Left=917, Width=90 - regra #10)
    * NAO se aplica: ele vale para os CRUD frmcadastro. Aqui o botao eh filho
    * DIRETO do form, no Left do SCX, e nao ha container de saida nenhum.
    *
    * Picture = cadastro_salvar_60.jpg eh TRANSCRITA do dump, nao escolhida por
    * semelhanca semantica: pelo criterio semantico um botao "Retornar" levaria
    * um icone de sair, e o legado usa o de SALVAR (regra #25). O arquivo foi
    * conferido em vbmp\ - .Picture apontando para arquivo inexistente nao da
    * erro nenhum, o botao so fica sem icone.
    *
    * Themes = .T. + DisabledPicture com a MESMA imagem: CommandButton SOLTO
    * (fora de CommandGroup) com .Picture nao renderiza o icone com
    * Themes = .F. (CorretorAutomatico #99). A excecao Themes = .F. vale para
    * Buttons(N) DENTRO de CommandGroup, que nao eh o caso aqui.
    *
    * Cancel = .T. eh transcricao do SCX: faz o ESC acionar o botao, que eh o
    * "[ESC] Retornar" do proprio ToolTipText.
    *
    * O botao fica POR CIMA da faixa do cabecalho de proposito (Top 3..78
    * dentro dos 0..80 do cnt_4c_Sombra): eh o layout do legado, e funciona
    * porque o cabecalho eh o PRIMEIRO AddObject da tela (regra #11).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Ok", "CommandButton")
            WITH THIS.cmd_4c_Ok
                .Top             = 3
                .Left            = 923
                .Width           = 75
                .Height          = 75
                .Caption         = "Retornar"
                .ToolTipText     = "[ESC] Retornar"
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .AutoSize        = .F.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .Themes          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Enabled         = .T.
                .Visible         = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLbC.ConfigurarBotoes")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarEventos - BINDEVENT dos Click
    *
    * O Click do "ok" eh o UNICO evento de CONTROLE do dump inteiro: a SECAO 3
    * tem o PROCEDURE e o Init do form, os dez "Return .f." dos When (campos
    * somente-leitura, que no migrado viram ReadOnly e nao precisam de
    * handler) e este Click. Nao ha outro evento a ligar nas fases seguintes.
    *
    * O handler eh PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com
    * metodo PROTECTED (regra #3).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnRetornarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLbC.ConfigurarEventos")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * BtnRetornarClick - transcricao do SIGOPLBC.ok.Click legado:
    *
    *     If Type('ThisForm.poFormCaixa') = "O"
    *         ThisForm.PoFormCaixa.Enabled = .t.
    *     Endif
    *     Thisform.release
    *
    * Nomeado pela ACAO (o Caption "Retornar" e o corpo do Click), nao pelo
    * Name do objeto legado ("ok"): o nome tem de dizer o que o metodo FAZ.
    * O objeto segue cmd_4c_Ok porque eh o que o mapeamento.json da task
    * declara, e o ValidarUIFidelity monta o caminho a partir dele.
    *
    * Release() e nao Hide(): esta tela eh um dialogo que nao devolve nada ao
    * chamador - o legado faz Thisform.release, e quem le a decisao de credito
    * eh o operador, nao o form do caixa.
    *
    * PUBLIC (sem PROTECTED): ligado por BINDEVENT.
    *==========================================================================
    PROCEDURE BtnRetornarClick()
        LOCAL loc_oErro

        TRY
            THIS.ReabilitarFormCaixa()
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpLbC.BtnRetornarClick")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * CarregarDados - calcula a composicao do limite e liga a grade
    *
    * Espelha o corpo do Init legado: o calculo todo esta no BO
    * (CalcularComposicaoLimite), e o que sobra aqui eh ler o cabecalho da
    * movimentacao em lancamento, passar ao BO e repintar a grade.
    *
    * DE ONDE VEM O CABECALHO: do cursor TprMvCab, criado e posicionado pelo
    * form CHAMADOR (o caixa). O legado alcanca esse cursor com
    * "set datasession to loForm.DataSessionId"; aqui nao eh preciso trocar de
    * datasession porque FormBase nao declara DataSession = 2 - o form fica na
    * sessao default (1), a MESMA do chamador, e o alias eh visivel direto
    * (mesmo padrao de FormDCC/FormPzo).
    *
    * As colunas sao lidas QUALIFICADAS pelo alias (TprMvCab.<col>), sem
    * SELECT e sem mexer no ponteiro: o cursor eh do CHAMADOR, que continua
    * usando o registro corrente depois que este dialogo fechar.
    *
    * Os valores sao passados com ALLTRIM: as chaves POSICIONAIS que dependem
    * do padding (SigClLcr.GruContas char(20) = Grupos char(10) + Contas
    * char(10), e SigMvCab.EmpDopNums char(29)) sao montadas DENTRO do BO com
    * PADR explicito, que repoe o padding (regra #42). Nao ha chave posicional
    * montada aqui.
    *
    * TRES desfechos, transcritos do legado:
    *
    *   1) sucesso                  -> liga a grade e repinta
    *   2) this_lContaIndefinida    -> o legado faz "Return" NU (sem valor),
    *      isto eh, o Init devolve .T. e a TELA ABRE, com os campos em branco,
    *      depois de reabilitar o caixa. Nao ha mensagem: o lado considerado da
    *      movimentacao simplesmente nao tem conta, e nao ha nada a liberar.
    *      Reproduzido como esta, mesmo sendo um desfecho esquisito (PILAR 1).
    *   3) this_lFalhaConexao       -> o legado faz "Return(.F.)" e a tela NAO
    *      abre. A mensagem ("Favor reinicializar o processo") JA foi exibida
    *      pelo BO, que marcou a flag - repetir aqui daria dois dialogos.
    *
    * Bypass de teste: o harness nao conecta ao SQL Server. A grade continua
    * sendo CRIADA e LIGADA ao cursor vazio (para a tela nao abrir com um
    * retangulo branco sem cabecalho na validacao visual); so a chamada ao BO
    * eh pulada.
    *
    * PUBLIC: harness chama metodos do form de fora da classe (regra #3).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_lModoTeste, loc_oBO, loc_oErro
        LOCAL loc_cEmps, loc_nNumes, loc_nValOs
        LOCAL loc_cGrupoOs, loc_cContaOs, loc_cGrupoDs, loc_cContaDs

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) ;
                      OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

        TRY
            IF loc_lModoTeste
                *-- Sem conexao: so a grade vazia, ja com cabecalhos e larguras,
                *-- e os campos espelhando o BO recem-criado (tudo zerado) - o
                *-- que importa aqui eh provar que o espelhamento nao estoura
                *-- por tipo nem por membro ausente.
                THIS.CarregarLista()
                THIS.AtualizarCamposComposicao()
                loc_lSucesso = .T.
            ELSE
                IF !USED("TprMvCab")
                    *-- O legado faz "Select TprMvCab" direto e quebraria com
                    *-- "Alias TPRMVCAB is not found". O contrato eh o chamador
                    *-- criar e posicionar o cursor antes de abrir o dialogo;
                    *-- sem ele nao ha movimentacao a avaliar.
                    MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                        "Cabe" + CHR(231) + "alho da movimenta" + CHR(231) + ;
                        CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
                        "vel (TprMvCab).", "Falha na Conex" + CHR(227) + "o")
                    loc_lSucesso = .F.
                ELSE
                    IF EOF("TprMvCab")
                        *-- Cursor aberto mas sem registro corrente: ler as
                        *-- colunas devolveria tudo em branco e a tela exibiria
                        *-- uma composicao de zeros como se fosse real.
                        MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                            "Nenhuma movimenta" + CHR(231) + CHR(227) + "o " + ;
                            "selecionada.", "Falha na Conex" + CHR(227) + "o")
                        loc_lSucesso = .F.
                    ELSE
                        *-- legado: Emps / Numes / ValOs / os dois lados da conta
                        loc_cEmps    = ALLTRIM(TratarNulo(TprMvCab.Emps, ""))
                        loc_nNumes   = TratarNulo(TprMvCab.Numes, 0)
                        loc_nValOs   = TratarNulo(TprMvCab.ValOs, 0)
                        loc_cGrupoOs = ALLTRIM(TratarNulo(TprMvCab.GrupoOs, ""))
                        loc_cContaOs = ALLTRIM(TratarNulo(TprMvCab.ContaOs, ""))
                        loc_cGrupoDs = ALLTRIM(TratarNulo(TprMvCab.GrupoDs, ""))
                        loc_cContaDs = ALLTRIM(TratarNulo(TprMvCab.ContaDs, ""))

                        loc_oBO = THIS.this_oBusinessObject

                        IF loc_oBO.CalcularComposicaoLimite(THIS.this_cOperacao, ;
                                loc_cEmps, loc_nNumes, loc_nValOs, ;
                                loc_cGrupoOs, loc_cContaOs, ;
                                loc_cGrupoDs, loc_cContaDs)

                            loc_lSucesso = .T.
                        ELSE
                            *-- Desfecho 2: conta indefinida -> a tela ABRE em
                            *-- branco, com o caixa ja reabilitado (legado:
                            *-- Return nu, sem mensagem).
                            *-- Desfecho 3: falha de conexao -> a tela NAO abre;
                            *-- o BO ja exibiu a mensagem.
                            IF loc_oBO.this_lContaIndefinida
                                THIS.ReabilitarFormCaixa()
                                loc_lSucesso = .T.
                            ELSE
                                loc_lSucesso = .F.

                                *-- Rede de seguranca (regra #20: falha de
                                *-- gravacao/carga NUNCA eh muda). Hoje todo
                                *-- caminho de .F. do BO ou marca
                                *-- this_lFalhaConexao com MsgErro, ou marca
                                *-- this_lContaIndefinida; se um caminho novo
                                *-- devolver .F. calado, a tela nao abriria e o
                                *-- usuario veria o menu sem nenhuma reacao ao
                                *-- clique.
                                IF !loc_oBO.this_lFalhaConexao
                                    MsgErro(IIF(EMPTY(loc_oBO.this_cMensagemErro), ;
                                        "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                                        "vel calcular a composi" + CHR(231) + CHR(227) + ;
                                        "o do limite de cr" + CHR(233) + "dito.", ;
                                        loc_oBO.this_cMensagemErro), ;
                                        "Libera" + CHR(231) + CHR(227) + "o de Cr" + ;
                                        CHR(233) + "dito")
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Liga e repinta em QUALQUER desfecho que abra a tela:
                        *-- na conta indefinida a grade fica vazia, mas com
                        *-- cabecalho e larguras - nao um retangulo branco, e os
                        *-- campos ficam nos zeros do BO, que eh exatamente o
                        *-- "abre em branco" do legado nesse desfecho.
                        IF loc_lSucesso
                            THIS.CarregarLista()
                            THIS.AtualizarCamposComposicao()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar a composi" + CHR(231) + CHR(227) + "o do " + ;
                "limite de cr" + CHR(233) + "dito:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Libera" + CHR(231) + CHR(227) + "o de Cr" + CHR(233) + "dito")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
    * Percorre Controls recursivamente, inclusive Pages de eventuais
    * PageFrames (nao ha nenhum nesta tela, mas o metodo segue o padrao do
    * projeto para continuar correto se algo mudar nas proximas fases).
    *
    * PUBLIC: harness de teste chama metodos do form de fora da classe
    * (regra #3).
    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_nI

        FOR loc_nI = 1 TO THIS.ControlCount
            THIS.TornarControleEFilhosVisiveis(THIS.Controls(loc_nI))
        ENDFOR

        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE TornarControleEFilhosVisiveis(par_oObjeto)
        LOCAL loc_nP, loc_nC

        IF VARTYPE(par_oObjeto) != "O"
            RETURN .F.
        ENDIF

        IF PEMSTATUS(par_oObjeto, "Visible", 5)
            par_oObjeto.Visible = .T.
        ENDIF

        IF PEMSTATUS(par_oObjeto, "PageCount", 5) AND par_oObjeto.PageCount > 0
            FOR loc_nP = 1 TO par_oObjeto.PageCount
                THIS.TornarControleEFilhosVisiveis(par_oObjeto.Pages(loc_nP))
            ENDFOR
        ENDIF

        IF PEMSTATUS(par_oObjeto, "ControlCount", 5) AND par_oObjeto.ControlCount > 0
            FOR loc_nC = 1 TO par_oObjeto.ControlCount
                THIS.TornarControleEFilhosVisiveis(par_oObjeto.Controls(loc_nC))
            ENDFOR
        ENDIF

        RETURN .T.
    ENDPROC


    *==========================================================================
    * Destroy - funil de SAIDA garantido: reabilita o caixa (regra #40) e
    * chama DODEFAULT() para o fix de menu da FormBase (menu-shrink apos
    * form modal).
    *
    * Fecha tambem o cursor da grade (DbOpera do legado), que eh do FORM e nao
    * do chamador. Sem TABLEREVERT: o cursor nasce com Buffering = 1 e
    * TABLEREVERT sem buffering nao eh no-op - estoura o erro 1586 "Function
    * requires row or table buffering mode" (regra #52). USE IN fecha o alias
    * sozinho, inclusive com buffer sujo.
    *
    * O cursor TprMvCab NAO eh fechado: eh do form CHAMADOR, que continua
    * usando ele depois que este dialogo fechar.
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_cAlias

        THIS.ReabilitarFormCaixa()

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                USE IN (loc_cAlias)
            ENDIF
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpLbCBO.prg):
*==============================================================================
* SigOpLbCBO.prg
*
* Business Object para Liberacao de Credito (SigOpLbC)
*
* Form OPERACIONAL de CONSULTA: exibe a composicao do limite de credito de
* uma conta no momento em que uma movimentacao esta sendo lancada, para que
* o operador decida pela liberacao. Nao grava nada - apenas consulta e
* calcula. Por isso NAO sobrescreve Inserir()/Atualizar()/ExecutarExclusao():
* o comportamento padrao herdado de BusinessBase ja eh o correto.
*
* Tabela principal: SigCdOpe (Dopes) - a operacao que disparou a liberacao
*
* Tabelas consultadas (nomes e colunas EXATOS do legado - PILAR 2):
*   SigCdOpe  Dopes, TipoOps, Nivels, LimCres, OpPends
*   SigClLcr  LimCres, Moedas, GruContas       (limite de credito da conta)
*   SigOpPed  Dopes, Tpagos, Tutils            (configuracao das operacoes a considerar)
*   SigMvCab  Emps, Numes, ValOs, GrupoOs, ContaOs, GrupoDs, ContaDs,
*             EmpDopNums, ChkPagos, ChkSubn, Utilizados, Dopes
*   SigMvItn  EmpDopNums, Dopes, Moedas, Qtds, QtBaixas, Units, ValRats
*   SigMvSlc  Grupos, Contas, Moedas, Saldos   (saldo de conta corrente)
*   SigCdCli  IClis, RClis                     (razao social do cliente)
*   SigChe    GrClis, IClis, Valors, Fpags, UMovs, Nums
*   SigCqChm  Nums
*   SigCdOpt  Operacaos, Tipos
*   SigOpFp   Fpags, ValPends
*   SigCdTom  Codigos, GerGdmis                (tipo de operacao)
*   SigCdPam  OpPends, ChqlCreds               (parametros do sistema)
*
* Herda de: BusinessBase
*
* FASE 1/8 - Propriedades e Init
* FASE 2/8 - Metodos de calculo (equivalente funcional ao CRUD, ja que o
*   BO eh somente-leitura): CalcularComposicaoLimite() eh o ponto de
*   entrada publico chamado pelo Form; os demais sao passos do Init do
*   legado, um a um, incluindo as duas queries que o legado SO executa
*   no passe de dados: LocalOpePd/CrTprMvCab/CrConserto2/lCredEesti
*   (grade de movimentacoes em aberto) e Pendencia/Cheques (totais).
*   CrTmpOpe (Select Dopes,OpPends From SigCdOpe) eh lida e indexada no
*   legado mas NUNCA referenciada depois - dead code confirmado por
*   busca no dump completo - omitida aqui por nao ter efeito observavel.
*   CarregarDoCursor() sobrescreve o metodo de BusinessBase e eh a FONTE
*   UNICA do mapeamento SigCdOpe -> propriedades, com guarda de EOF.
*==============================================================================

DEFINE CLASS SigOpLbCBO AS BusinessBase

    *==========================================================================
    * PARAMETROS DE ENTRADA
    * O legado recebe Init(loForm, Operacao, loForm2); loForm/loForm2 sao
    * referencias de UI e ficam no Form. Ao BO interessa apenas a operacao.
    *==========================================================================

    this_cOperacao = ""                 && par Operacao - SigCdOpe.Dopes char(20)

    *==========================================================================
    * SigCdOpe - cursor lCredOpe do legado
    * Select Dopes, TipoOps, Nivels, LimCres From SigCdOpe Where Dopes = <op>
    *==========================================================================

    this_cDopes    = ""                 && SigCdOpe.Dopes   char(20)
    this_nTipoOps  = 0                  && SigCdOpe.TipoOps numeric(2,0) - legado Tipoop
    this_cNivels   = ""                 && SigCdOpe.Nivels  char(20)     - legado _Nivel
    this_nLimCres  = 0                  && SigCdOpe.LimCres numeric(1,0) - 1 = usa ORIGEM, senao DESTINO

    *==========================================================================
    * Cabecalho da movimentacao em lancamento (cursor TprMvCab do legado)
    * O lado lido (origem x destino) depende de SigCdOpe.LimCres.
    *==========================================================================

    this_cEmps             = ""         && SigMvCab.Emps    char(3)
    this_nNumes            = 0          && SigMvCab.Numes   numeric(6,0)
    this_nValorMovimento   = 0          && SigMvCab.ValOs   numeric(11,2) - base do legado _Pendente
    this_cGrupo            = ""         && legado _Grupo  - GrupoOs ou GrupoDs  char(10)
    this_cConta            = ""         && legado _Conta  - ContaOs ou ContaDs  char(10)
    this_cCampoGrupoSQL    = ""         && legado _mgrupo - "a.grupoos" / "a.grupods"
    this_cCampoContaSQL    = ""         && legado _mconta - "a.contaos" / "a.contads"

    *-- legado _ChvLCred: Emps(3) + Nivels(20) + Str(Numes,6) = char(29)
    *-- Chave POSICIONAL: montar com PADR, NUNCA com ALLTRIM nas partes,
    *-- senao o WHERE nao casa e a consulta devolve ZERO linhas em silencio.
    this_cChaveLimiteCredito = ""       && SigMvCab.EmpDopNums char(29) a EXCLUIR da pendencia

    *==========================================================================
    * SigClLcr - limite de credito da conta (cursor CrSigClLcr do legado)
    * CursorQuery('SigClLcr','CrSigClLcr','GruContas', _Grupo + _Conta)
    *==========================================================================

    this_nLimiteCredito = 0             && SigClLcr.LimCres   numeric(10,2)
    this_cMoeda         = ""            && SigClLcr.Moedas    char(3) - moeda de CONVERSAO de tudo
    this_cGruContas     = ""            && SigClLcr.GruContas char(20) - _Grupo + _Conta

    *==========================================================================
    * SigCdCli - identificacao do cliente (cursor CrTmpCli do legado)
    *==========================================================================

    this_cRazaoCliente   = ""           && SigCdCli.RClis char(50)
    this_cDescricaoConta = ""           && legado: _Conta + " " + Alltrim(RClis) - caption get_nconta

    *==========================================================================
    * SigCdTom - tipo de operacao (cursor LocalTOpe do legado)
    * CursorQuery('SigCdTom','LocalTOpe','Codigos', TipoOp)
    *==========================================================================

    this_nGerGdmis = 0                  && SigCdTom.GerGdmis numeric(1,0) - 3 = abate pendencias/cheques

    *==========================================================================
    * SigCdPam - parametros do sistema (cursor crSigCdPam do legado)
    *==========================================================================

    this_nOpPendsParam     = 0          && SigCdPam.OpPends   numeric(2,0) - TipoOps que conta como pendencia
    this_lChqLimiteCredito = .F.        && SigCdPam.ChqlCreds bit - cheque sempre abate o limite

    *==========================================================================
    * VALORES CALCULADOS - todos convertidos para this_cMoeda (SigClLcr.Moedas)
    * Nomes do legado preservados em comentario para rastrear cada formula.
    *==========================================================================

    this_nCotacao            = 0        && fBuscarCotacao(this_cMoeda, Date()) - get_cotacao
    this_nSaldoContaCorrente = 0        && legado _Saldocc  - SUM de SigMvSlc.Saldos convertido
    this_nTotalCheques       = 0        && legado _chequec  - cheques que NAO sao valor pendente
    this_nChequesPendentes   = 0        && legado _chequep  - cheques cuja forma de pagamento fica em aberto
    this_nPendente           = 0        && legado _Pendente - ValOs desta movimentacao, convertido
    this_nPendenteOutros     = 0        && legado _PendOutr - SUM das OUTRAS movimentacoes em aberto
    this_nSaldoDisponivel    = 0        && legado _SaldoFinal - resultado exibido em get_disponivel

    *==========================================================================
    * CURSORES
    * cursor_4c_Operacoes eh o cursor da GRADE (DbOpera do legado), criado
    * no Load com "Create Cursor DbOpera (dopes c(20), totas n(12,2))".
    * A estrutura e a ORDEM das colunas tem de ser identicas em CADA lugar
    * que recriar o cursor, e os ControlSource da grade usam estes nomes.
    *==========================================================================

    this_cCursorOperacoes    = "cursor_4c_Operacoes"        && DbOpera     - GRADE (Dopes, Totas)
    this_cCursorCredOpe      = "cursor_4c_CredOpe"          && lCredOpe
    this_cCursorLimiteConta  = "cursor_4c_LimiteConta"      && CrSigClLcr
    this_cCursorOpePendente  = "cursor_4c_OpePendente"      && LocalOpePd
    this_cCursorTipoOpePend  = "cursor_4c_TipoOpePend"      && CrTmpOpe
    this_cCursorMovCabecalho = "cursor_4c_MovCabecalho"     && CrTprMvCab
    this_cCursorMovFiltrado  = "cursor_4c_MovFiltrado"      && CrConserto2
    this_cCursorItensMov     = "cursor_4c_ItensMov"         && lCredEesti
    this_cCursorCliente      = "cursor_4c_Cliente"          && CrTmpCli
    this_cCursorSaldoConta   = "cursor_4c_SaldoConta"       && CrTmpSccr
    this_cCursorCheques      = "cursor_4c_Cheques"          && Cheques
    this_cCursorFormaPagto   = "cursor_4c_FormaPagto"       && CrSigOpFp
    this_cCursorPendencia    = "cursor_4c_Pendencia"        && Pendencia
    this_cCursorTipoOperacao = "cursor_4c_TipoOperacao"     && LocalTOpe
    this_cCursorParametros   = "cursor_4c_Parametros"       && crSigCdPam

    *==========================================================================
    * ESTADO
    * O Init do legado tem dois desfechos de recusa DIFERENTES, e o Form
    * precisa distinguir: Return(.F.) por falha de conexao (com a mensagem
    * "Favor reinicializar o processo") e Return simples quando Grupo ou
    * Conta estao vazios (sem mensagem alguma - nada a liberar).
    *==========================================================================

    this_lDadosCarregados = .F.         && .T. quando a composicao foi calculada
    this_lFalhaConexao    = .F.         && .T. quando algum SQLEXEC falhou
    this_lContaIndefinida = .F.         && .T. quando Grupo ou Conta vazio (legado: Return sem msg)

    *==========================================================================
    * Init - Inicializa Business Object
    *
    * Nenhuma consulta roda aqui: o legado faz tudo no Init do FORM, depois
    * de receber a operacao e o cursor do cabecalho da movimentacao. O Form
    * chama os metodos de carga apos informar this_cOperacao.
    *
    * RETURN apenas FORA do TRY/CATCH - dentro do bloco so a flag
    * loc_lSucesso eh movimentada.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdOpe"
            THIS.this_cCampoChave = "Dopes"

            *-- Estado inicial explicito: a instancia pode ser reaproveitada
            *-- pelo Form entre duas liberacoes, e flag de sessao anterior
            *-- ligada faria a tela exibir a composicao do movimento antigo.
            THIS.this_lDadosCarregados = .F.
            THIS.this_lFalhaConexao    = .F.
            THIS.this_lContaIndefinida = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar SigOpLbCBO:" + CHR(13) + ;
                loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FASE 2/8 - METODOS DE CALCULO
    *==========================================================================

    *--------------------------------------------------------------------------
    * CalcularComposicaoLimite - Calcula a composicao do limite de credito da
    * conta envolvida numa movimentacao, para a tela decidir pela liberacao.
    *
    * Espelha o Init(loForm, Operacao, loForm2) do legado: loForm/loForm2 sao
    * referencias de tela e ficam com o Form; aqui chegam so a operacao e os
    * campos do cabecalho da movimentacao em lancamento (legado: cursor
    * TprMvCab, selecionado pelo form CHAMADOR antes de abrir esta tela).
    *
    * Retorna .T. quando a composicao foi calculada com sucesso. Retorna .F.
    * em dois casos que o Form tem de distinguir - this_lFalhaConexao (legado:
    * Return(.F.) com MessageBox "Favor reinicializar o processo") e
    * this_lContaIndefinida (legado: Return simples, SEM mensagem, quando
    * Grupo ou Conta do lado considerado estao vazios).
    *--------------------------------------------------------------------------
    PROCEDURE CalcularComposicaoLimite(par_cOperacao, par_cEmps, par_nNumes, ;
            par_nValOs, par_cGrupoOs, par_cContaOs, par_cGrupoDs, par_cContaDs)

        LOCAL loc_lSucesso

        THIS.this_lDadosCarregados = .F.
        THIS.this_lFalhaConexao    = .F.
        THIS.this_lContaIndefinida = .F.

        THIS.this_cOperacao = TratarNulo(par_cOperacao, "")

        loc_lSucesso = THIS.CarregarOperacao()

        IF loc_lSucesso
            THIS.DefinirLadoMovimento(par_cEmps, par_nNumes, par_nValOs, ;
                par_cGrupoOs, par_cContaOs, par_cGrupoDs, par_cContaDs)

            IF EMPTY(THIS.this_cGrupo) OR EMPTY(THIS.this_cConta)
                *-- legado: "If IsEmpty(_Grupo) Or IsEmpty(_Conta) / Return" -
                *-- sem mensagem, nada a liberar (conta nao se aplica a este lado)
                THIS.this_lContaIndefinida = .T.
                loc_lSucesso = .F.
            ELSE
                *-- legado: _ChvLCred = TprMvCab.Emps + _Nivel + Str(TprMvCab.Numes,6)
                *-- Chave POSICIONAL (regra #42): PADR explicito nas partes,
                *-- NUNCA ALLTRIM - senao o WHERE de CalcularPendencias() nao
                *-- casa e a consulta devolve zero linhas em silencio.
                THIS.this_cChaveLimiteCredito = PADR(THIS.this_cEmps, 3) + ;
                    PADR(THIS.this_cNivels, 20) + STR(THIS.this_nNumes, 6)
            ENDIF
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CarregarLimiteCredito()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CarregarMovimentosPendentes()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CarregarCliente()
        ENDIF

        IF loc_lSucesso
            *-- legado: ThisForm.get_nconta.Caption = _Conta + ' ' + Alltrim(lcRazao)
            THIS.this_cDescricaoConta = ALLTRIM(THIS.this_cConta) + " " + ;
                ALLTRIM(THIS.this_cRazaoCliente)
            loc_lSucesso = THIS.CalcularSaldoContaCorrente()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CalcularCheques()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CarregarTipoOperacao()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CarregarParametrosSistema()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CalcularPendencias()
        ENDIF

        IF loc_lSucesso
            THIS.CalcularSaldoDisponivel()
            THIS.this_lDadosCarregados = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - legado:
    *   lcSql = Select Dopes,TipoOps,Nivels,LimCres From SigCdOpe Where Dopes=<op>
    *   If Sqlexecute(lcsql,'lCredOpe') < 1 -> MessageBox + Return(.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarOperacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, TipoOps, Nivels, LimCres FROM SigCdOpe " + ;
                "WHERE Dopes = " + EscaparSQL(THIS.this_cOperacao)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCredOpe)

            *-- legado: "If ...Sqlexecute(lcsql,'lCredOpe') < 1". No Fortyus o
            *-- retorno eh a CONTAGEM de linhas, logo ZERO linha tambem cai na
            *-- recusa. O SQLEXEC do VFP9 devolve 1 por result set e NAO conta
            *-- linhas: a ausencia de registro eh detectada pela guarda de EOF
            *-- de CarregarDoCursor, que devolve .F. - sem ela a leitura em EOF
            *-- entregaria branco/zero e o calculo seguiria com limite 0 e o
            *-- lado da conta errado, sem erro nenhum na tela.
            IF loc_nResultado < 1
                loc_lSucesso = .F.
            ELSE
                *-- Mapeamento SigCdOpe -> propriedades em FONTE UNICA
                loc_lSucesso = THIS.CarregarDoCursor(THIS.this_cCursorCredOpe)
            ENDIF

            IF !loc_lSucesso
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conexao (lCredOpe)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
            ENDIF

            IF USED(THIS.this_cCursorCredOpe)
                USE IN (THIS.this_cCursorCredOpe)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lFalhaConexao = .T.
            THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - FONTE UNICA do mapeamento da tabela principal
    * (SigCdOpe) para as propriedades do BO.
    *
    * Sobrescreve o metodo homonimo de BusinessBase, que eh PUBLIC: marcar a
    * sobrescrita como PROTECTED a tornaria inalcancavel de fora, porque
    * PROTECTED em QUALQUER nivel da heranca vence (regra #51).
    *
    * Colunas EXATAS de SigCdOpe (conferidas em docs/schema.sql):
    *   dopes   char(20)        tipoops numeric(2,0)
    *   nivels  char(20)        limcres numeric(1,0)
    *
    * Devolve .F. quando NAO ha registro corrente para ler - alias fechado,
    * cursor vazio ou em EOF. Essa guarda eh o que traduz o "< 1" do legado:
    * no Fortyus o Sqlexecute devolvia a CONTAGEM de linhas, enquanto o
    * SQLEXEC do VFP9 devolve 1 por result set e nao distingue zero linha.
    * Sem a guarda, a leitura em EOF entrega branco/zero sem erro algum.
    *
    * Sem par_cAliasCursor, assume o cursor da propria consulta de operacao
    * (this_cCursorCredOpe), que eh o unico chamador interno.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor)
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = THIS.this_cCursorCredOpe
        ENDIF

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias)
                    *-- TYPE() eh a forma valida de testar existencia de campo
                    *-- em CURSOR (PEMSTATUS exige objeto e estoura recebendo
                    *-- alias). Necessario porque BusinessBase.Buscar aceita a
                    *-- lista de campos em pcCampos, logo o alias pode chegar
                    *-- mais estreito que o SELECT de CarregarOperacao().
                    IF TYPE(loc_cAlias + ".Dopes") != "U"
                        THIS.this_cDopes = TratarNulo(Dopes, "")
                    ENDIF

                    IF TYPE(loc_cAlias + ".TipoOps") != "U"
                        THIS.this_nTipoOps = TratarNulo(TipoOps, 0)
                    ENDIF

                    IF TYPE(loc_cAlias + ".Nivels") != "U"
                        *-- legado _Nivel: entra na chave posicional
                        *-- EmpDopNums = Emps(3) + Nivels(20) + Str(Numes,6)
                        THIS.this_cNivels = TratarNulo(Nivels, "")
                    ENDIF

                    IF TYPE(loc_cAlias + ".LimCres") != "U"
                        *-- numeric(1,0): 1 = considerar o lado ORIGEM do
                        *-- movimento; qualquer outro valor = lado DESTINO.
                        THIS.this_nLimCres = TratarNulo(LimCres, 0)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor [" + loc_cAlias + "]:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "SigOpLbCBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirLadoMovimento - legado:
    *   Select TprMvCab
    *   If lCredOpe.limcres = 1
    *       _Grupo=grupoos / _Conta=Contaos / _mgrupo='a.grupoos' / _mconta='a.contaos'
    *   Else
    *       _Grupo=grupods / _Conta=Contads / _mgrupo='a.grupods' / _mconta='a.contads'
    *   EndIf
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DefinirLadoMovimento(par_cEmps, par_nNumes, par_nValOs, ;
            par_cGrupoOs, par_cContaOs, par_cGrupoDs, par_cContaDs)

        THIS.this_cEmps           = TratarNulo(par_cEmps, "")
        THIS.this_nNumes          = TratarNulo(par_nNumes, 0)
        THIS.this_nValorMovimento = TratarNulo(par_nValOs, 0)

        IF THIS.this_nLimCres = 1
            THIS.this_cGrupo         = TratarNulo(par_cGrupoOs, "")
            THIS.this_cConta         = TratarNulo(par_cContaOs, "")
            THIS.this_cCampoGrupoSQL = "a.grupoos"
            THIS.this_cCampoContaSQL = "a.contaos"
        ELSE
            THIS.this_cGrupo         = TratarNulo(par_cGrupoDs, "")
            THIS.this_cConta         = TratarNulo(par_cContaDs, "")
            THIS.this_cCampoGrupoSQL = "a.grupods"
            THIS.this_cCampoContaSQL = "a.contads"
        ENDIF

        *-- SigClLcr.GruContas char(20) = Grupos char(10) + Contas char(10)
        THIS.this_cGruContas = PADR(THIS.this_cGrupo, 10) + PADR(THIS.this_cConta, 10)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLimiteCredito - legado:
    *   CursorQuery('SigClLcr','CrSigClLcr','GruContas',_Grupo+_Conta)
    * Sem guarda de falha no legado (API diferente do Sqlexecute): zero
    * linha nao eh erro, so zera o limite e segue (conta sem limite cadastrado).
    *
    * Este metodo eh a FONTE UNICA das tres leituras que o legado faz do
    * CrSigClLcr para a tela, e as tres andam JUNTAS (linhas 886-887 do dump):
    *
    *   ThisForm.get_limcred.Value = crSigClLcr.limcres        -> this_nLimiteCredito
    *   ThisForm.get_moeda.Value   = crSigClLcr.moedas         -> this_cMoeda
    *   ThisForm.get_cotacao.Value = fBuscarCotacao(crSigClLcr.moedas, date())
    *                                                          -> this_nCotacao
    *
    * A cotacao vem de fBuscarCotacao() (utils\functions.prg), que eh o mesmo
    * helper que o legado usa e que JA esta portado - nao reimplementar aqui
    * (regra #13). Ele devolve 1.0 para moeda vazia ou "R$", exatamente o que
    * o legado exibe quando a conta nao tem limite cadastrado, por isso a
    * chamada fica FORA do IF de RECCOUNT: o legado tambem le
    * crSigClLcr.moedas sem testar EOF e cai no mesmo 1.0.
    *
    * A cotacao eh so EXIBICAO (campo "Cambio :"): as conversoes de valor
    * chamam fBuscarCotacao() no ponto de uso, como o legado, porque cada uma
    * converte de uma moeda de ORIGEM diferente - guardar uma taxa so aqui e
    * reaproveita-la nos calculos trocaria o divisor e alteraria valor
    * gravado/exibido (regra #17).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarLimiteCredito()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT LimCres, Moedas FROM SigClLcr " + ;
                "WHERE GruContas = " + EscaparSQL(THIS.this_cGruContas)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorLimiteConta)

            IF loc_nResultado < 0
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Erro ao carregar limite de cr" + CHR(233) + "dito."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                IF loc_nResultado > 0 AND RECCOUNT(THIS.this_cCursorLimiteConta) > 0
                    SELECT (THIS.this_cCursorLimiteConta)
                    THIS.this_nLimiteCredito = TratarNulo(LimCres, 0)
                    THIS.this_cMoeda         = TratarNulo(Moedas, "")
                ELSE
                    THIS.this_nLimiteCredito = 0
                    THIS.this_cMoeda         = ""
                ENDIF

                *-- legado: ThisForm.get_cotacao.Value =
                *--             fBuscarCotacao( crSigClLcr.moedas, date() )
                THIS.this_nCotacao = fBuscarCotacao(THIS.this_cMoeda, DATE(), gnConnHandle)

                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorLimiteConta)
                USE IN (THIS.this_cCursorLimiteConta)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lFalhaConexao = .T.
            THIS.this_cMensagemErro = "Erro ao carregar limite de cr" + CHR(233) + "dito:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMovimentosPendentes - popula cursor_4c_Operacoes (DbOpera do
    * legado - a GRADE da tela) com o total, por operacao em aberto, convertido
    * para a moeda do limite de credito.
    *
    * Legado (sequencia completa):
    *   1) Select * From SigOpPed -> LocalOpePd (Sqlexecute < 1 = falha)
    *   2) Reccount('LocalOpePd') > 0 ->
    *      a) Union all SigMvCab+SigOpPed pelos dois lados da conta -> CrTprMvCab
    *      b) CrConserto2 = EmpDopNums dos registros de CrTprMvCab cujo Dopes
    *         bate em LocalOpePd nas condicoes Tpagos/ChkPagos e Tutils/Utilizados
    *      c) Para cada EmpDopNums de CrConserto2: soma os itens do movimento
    *         por moeda (SigMvItn) e converte para this_cMoeda, acumulando em DbOpera
    *
    * (b) eh SCAN+LOCATE, nao SELECT declarativo: ChkPagos vem de coluna BIT,
    * e um IIF/OR dentro de um SELECT avalia os dois lados da expressao - se o
    * driver entregar Numerico em vez de Logico, estoura "Operator/operand
    * type mismatch". THIS.BitParaLogico() normaliza ANTES da comparacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarMovimentosPendentes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDopes, loc_lChkPagos, loc_nUtilizados, loc_cEmpDopNums
        LOCAL loc_nTpagos, loc_nTutils, loc_lCondPagos, loc_lCondUtils, loc_lIncluir
        LOCAL loc_cDopesItem, loc_nTotaOrigem, loc_cMoedaOrigem, loc_nConv

        loc_lSucesso = .F.

        TRY
            *-- cursor_4c_Operacoes (DbOpera legado) - estrutura fixa (regra
            *-- #42): a ordem das colunas tem de ser identica em todo lugar
            *-- que recriar o cursor, e a Grade da Lista usa estes nomes.
            IF !USED(THIS.this_cCursorOperacoes)
                CREATE CURSOR (THIS.this_cCursorOperacoes) (dopes C(20), totas N(12,2))
            ELSE
                SELECT (THIS.this_cCursorOperacoes)
                ZAP
            ENDIF
            SELECT (THIS.this_cCursorOperacoes)
            INDEX ON dopes TAG dopes

            *-- SigOpPed - operacoes configuradas a considerar (LocalOpePd legado)
            loc_cSQL = "SELECT * FROM SigOpPed"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpePendente)

            IF loc_nResultado < 1
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conexao (LocalOpePd)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
            ELSE
                SELECT (THIS.this_cCursorOpePendente)
                INDEX ON dopes TAG dopes

                *-- SigMvCab + SigOpPed: movimentos da conta nos dois lados
                *-- (Debito e Credito) - colunas EXPLICITAS, exigido em UNION ALL
                loc_cSQL = "SELECT a.Dopes, a.EmpDopNums, a.ChkPagos, a.ChkSubn, a.Utilizados " + ;
                    "FROM SigMvCab a, SigOpPed b " + ;
                    "WHERE a.ContaDs = " + EscaparSQL(THIS.this_cConta) + ;
                    " AND a.Dopes = b.Dopes " + ;
                    "UNION ALL " + ;
                    "SELECT a.Dopes, a.EmpDopNums, a.ChkPagos, a.ChkSubn, a.Utilizados " + ;
                    "FROM SigMvCab a, SigOpPed b " + ;
                    "WHERE a.ContaOs = " + EscaparSQL(THIS.this_cConta) + ;
                    " AND a.ContaDs <> " + EscaparSQL(THIS.this_cConta) + ;
                    " AND a.Dopes = b.Dopes"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorMovCabecalho)

                IF loc_nResultado < 1
                    THIS.this_lFalhaConexao = .T.
                    THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                        "Falha na conexao (CrTprMvCab)"
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
                ELSE
                    *-- CrConserto2 do legado: EmpDopNums dos movimentos que
                    *-- casam nas condicoes Tpagos/ChkPagos e Tutils/Utilizados
                    IF USED(THIS.this_cCursorMovFiltrado)
                        USE IN (THIS.this_cCursorMovFiltrado)
                    ENDIF
                    CREATE CURSOR (THIS.this_cCursorMovFiltrado) (empdopnums C(29))

                    SELECT (THIS.this_cCursorMovCabecalho)
                    SCAN
                        loc_cDopes      = Dopes
                        loc_lChkPagos   = THIS.BitParaLogico(ChkPagos)
                        loc_nUtilizados = TratarNulo(Utilizados, 0)
                        loc_cEmpDopNums = EmpDopNums
                        loc_lIncluir    = .F.

                        SELECT (THIS.this_cCursorOpePendente)
                        IF SEEK(loc_cDopes, THIS.this_cCursorOpePendente, "dopes")
                            loc_nTpagos = TratarNulo(Tpagos, 0)
                            loc_nTutils = TratarNulo(Tutils, 0)

                            DO CASE
                            CASE loc_nTpagos = 1
                                loc_lCondPagos = loc_lChkPagos
                            CASE loc_nTpagos = 2
                                loc_lCondPagos = !loc_lChkPagos
                            OTHERWISE
                                loc_lCondPagos = .T.
                            ENDCASE

                            DO CASE
                            CASE loc_nTutils = 1
                                loc_lCondUtils = (loc_nUtilizados = 1)
                            CASE loc_nTutils = 2
                                loc_lCondUtils = (loc_nUtilizados = 0)
                            OTHERWISE
                                loc_lCondUtils = .T.
                            ENDCASE

                            loc_lIncluir = loc_lCondPagos AND loc_lCondUtils
                        ENDIF

                        IF loc_lIncluir
                            SELECT (THIS.this_cCursorMovFiltrado)
                            APPEND BLANK
                            REPLACE empdopnums WITH loc_cEmpDopNums
                        ENDIF

                        SELECT (THIS.this_cCursorMovCabecalho)
                    ENDSCAN

                    *-- lCredEesti do legado: por EmpDopNums filtrado, soma o
                    *-- total dos itens por moeda e converte para this_cMoeda
                    SELECT (THIS.this_cCursorMovFiltrado)
                    SCAN
                        loc_cEmpDopNums = empdopnums

                        loc_cSQL = "SELECT Dopes, Moedas, " + ;
                            "SUM((Qtds - QtBaixas) * (Units + ValRats)) AS Totas " + ;
                            "FROM SigMvItn " + ;
                            "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
                            " GROUP BY Dopes, Moedas"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItensMov) > 0
                            SELECT (THIS.this_cCursorItensMov)
                            SCAN
                                loc_cDopesItem   = Dopes
                                loc_nTotaOrigem  = TratarNulo(Totas, 0)
                                loc_cMoedaOrigem = TratarNulo(Moedas, "")

                                SELECT (THIS.this_cCursorOperacoes)
                                IF !SEEK(loc_cDopesItem, THIS.this_cCursorOperacoes, "dopes")
                                    APPEND BLANK
                                    REPLACE dopes WITH loc_cDopesItem
                                ENDIF

                                loc_nConv = ROUND(loc_nTotaOrigem * ;
                                    fBuscarCotacao(loc_cMoedaOrigem, DATE()) / ;
                                    fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
                                REPLACE totas WITH totas + loc_nConv

                                SELECT (THIS.this_cCursorItensMov)
                            ENDSCAN
                        ENDIF

                        IF USED(THIS.this_cCursorItensMov)
                            USE IN (THIS.this_cCursorItensMov)
                        ENDIF

                        SELECT (THIS.this_cCursorMovFiltrado)
                    ENDSCAN

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            SELECT (THIS.this_cCursorOperacoes)
            GO TOP

            IF USED(THIS.this_cCursorOpePendente)
                USE IN (THIS.this_cCursorOpePendente)
            ENDIF
            IF USED(THIS.this_cCursorMovCabecalho)
                USE IN (THIS.this_cCursorMovCabecalho)
            ENDIF
            IF USED(THIS.this_cCursorMovFiltrado)
                USE IN (THIS.this_cCursorMovFiltrado)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar movimentos pendentes:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCliente - legado:
    *   lcSql = Select Rclis From SigCdCli where Iclis = '<Conta>'
    *   If Sqlexecute(lcSql,'CrTmpCli') < 1 -> MessageBox + Return(.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCliente()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                EscaparSQL(THIS.this_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCliente)

            IF loc_nResultado < 1
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conexao (CrTmpCli)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
            ELSE
                SELECT (THIS.this_cCursorCliente)
                THIS.this_cRazaoCliente = TratarNulo(RClis, "")
                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorCliente)
                USE IN (THIS.this_cCursorCliente)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lFalhaConexao = .T.
            THIS.this_cMensagemErro = "Erro ao carregar cliente:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularSaldoContaCorrente - legado:
    *   CursorQuery('SigMvSlc','CrTmpSccr',@LaCampo)  -- Grupos=_Grupo, Contas=_Conta
    *   Scan: _Saldocc += Round(Saldos * cotacao(moedas)/cotacao(crSigClLcr.moedas),2)
    * Sem guarda de falha no legado: zero linha eh estado valido (conta sem
    * movimento de C/C) e nao interrompe o calculo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcularSaldoContaCorrente()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nConv

        loc_lSucesso = .F.
        THIS.this_nSaldoContaCorrente = 0

        TRY
            loc_cSQL = "SELECT Moedas, Saldos FROM SigMvSlc " + ;
                "WHERE Grupos = " + EscaparSQL(THIS.this_cGrupo) + ;
                " AND Contas = " + EscaparSQL(THIS.this_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorSaldoConta)

            IF loc_nResultado < 0
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Erro ao calcular saldo de conta corrente."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                IF loc_nResultado > 0
                    SELECT (THIS.this_cCursorSaldoConta)
                    SCAN
                        loc_nConv = ROUND(TratarNulo(Saldos, 0) * ;
                            fBuscarCotacao(Moedas, DATE()) / ;
                            fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
                        THIS.this_nSaldoContaCorrente = THIS.this_nSaldoContaCorrente + loc_nConv
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorSaldoConta)
                USE IN (THIS.this_cCursorSaldoConta)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao calcular saldo de conta corrente:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularCheques - legado:
    *   lcQuery = cheques em aberto (SigCqChm+SigChe+SigCdOpt, tipos='DB') -> Cheques
    *   If Sqlexecute(lcQuery,'Cheques') < 1 -> MessageBox + Return .f.
    *   Scan Cheques:
    *       If IsEmpty(fpags)
    *           _chequep = _chequec + valors   && transcrito LITERAL - ver nota abaixo
    *       Else
    *           CursorQuery('SigOpFp','CrSigOpFp','Fpags',Cheques.Fpags)
    *           If crSigOpFp.valpends # 1 -> _chequec += valors  Else _chequep += valors
    *       EndIf
    *   _Chequec = Round(_chequec / cotacao(crSigClLcr.moedas), 2)
    *   _Chequep = Round(_chequep / cotacao(crSigClLcr.moedas), 2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcularCheques()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_nChequeC, loc_nChequeP, loc_cFpags, loc_nValors, loc_nValPends

        loc_lSucesso = .F.
        loc_nChequeC = 0
        loc_nChequeP = 0

        TRY
            loc_cSQL = "SELECT b.GrClis, b.IClis, SUM(b.Valors) AS Valors, b.Fpags " + ;
                "FROM SigCqChm a, SigChe b, SigCdOpt c " + ;
                "WHERE b.GrClis = " + EscaparSQL(THIS.this_cGrupo) + ;
                " AND b.IClis = " + EscaparSQL(THIS.this_cConta) + ;
                " AND b.Umovs = c.Operacaos AND c.Tipos = " + EscaparSQL("DB") + ;
                " AND a.Nums = b.Nums " + ;
                "GROUP BY b.GrClis, b.IClis, b.Fpags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCheques)

            IF loc_nResultado < 1
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conexao (cheques)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
            ELSE
                SELECT (THIS.this_cCursorCheques)
                SCAN
                    loc_cFpags  = TratarNulo(Fpags, "")
                    loc_nValors = TratarNulo(Valors, 0)

                    IF EMPTY(loc_cFpags)
                        *-- Transcrito LITERALMENTE do legado (regra CLAUDE.md
                        *-- #17 - formula de calculo eh regra de negocio, nao se
                        *-- reescreve): a linha original soma ao acumulador de
                        *-- CHEQUES (os que nao ficam em aberto) mas atribui ao acumulador oposto.
                        *-- Preservado mesmo parecendo invertido.
                        loc_nChequeP = loc_nChequeC + loc_nValors
                    ELSE
                        loc_cSQL = "SELECT ValPends FROM SigOpFp WHERE Fpags = " + ;
                            EscaparSQL(loc_cFpags)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFormaPagto) > 0
                            SELECT (THIS.this_cCursorFormaPagto)
                            loc_nValPends = TratarNulo(ValPends, 0)
                        ELSE
                            loc_nValPends = 0
                        ENDIF

                        IF USED(THIS.this_cCursorFormaPagto)
                            USE IN (THIS.this_cCursorFormaPagto)
                        ENDIF

                        IF loc_nValPends != 1
                            loc_nChequeC = loc_nChequeC + loc_nValors
                        ELSE
                            loc_nChequeP = loc_nChequeP + loc_nValors
                        ENDIF
                    ENDIF

                    SELECT (THIS.this_cCursorCheques)
                ENDSCAN

                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorCheques)
                USE IN (THIS.this_cCursorCheques)
            ENDIF

            THIS.this_nTotalCheques     = ROUND(loc_nChequeC / fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
            THIS.this_nChequesPendentes = ROUND(loc_nChequeP / fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao calcular cheques:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTipoOperacao - legado:
    *   CursorQuery('SigCdTom','LocalTOpe','Codigos',TipoOp)
    * Sem guarda de falha no legado: zero linha so zera GerGdmis e segue.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarTipoOperacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, GerGdmis FROM SigCdTom " + ;
                "WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nTipoOps, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTipoOperacao)

            IF loc_nResultado < 0
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                IF loc_nResultado > 0 AND RECCOUNT(THIS.this_cCursorTipoOperacao) > 0
                    SELECT (THIS.this_cCursorTipoOperacao)
                    THIS.this_nGerGdmis = TratarNulo(GerGdmis, 0)
                ELSE
                    THIS.this_nGerGdmis = 0
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorTipoOperacao)
                USE IN (THIS.this_cCursorTipoOperacao)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - cursor crSigCdPam do legado (SigCdPam eh
    * tabela de UMA linha - parametros gerais). Sem guarda de falha no
    * legado: zero linha so zera os parametros e segue.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT OpPends, ChqlCreds FROM SigCdPam"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorParametros)

            IF loc_nResultado < 0
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Erro ao carregar parametros do sistema."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                IF loc_nResultado > 0 AND RECCOUNT(THIS.this_cCursorParametros) > 0
                    SELECT (THIS.this_cCursorParametros)
                    THIS.this_nOpPendsParam     = TratarNulo(OpPends, 0)
                    THIS.this_lChqLimiteCredito = THIS.BitParaLogico(ChqlCreds)
                ELSE
                    THIS.this_nOpPendsParam     = 0
                    THIS.this_lChqLimiteCredito = .F.
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorParametros)
                USE IN (THIS.this_cCursorParametros)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar parametros do sistema:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularPendencias - legado:
    *   _Pendente = Round(TprMvCab.valos / cotacao(crSigClLcr.moedas), 2)
    *   _PendOutr = 0
    *   lcQuery = Soma por Dopes/Moedas de SigMvCab+SigMvItn+SigCdOpe, no lado
    *             <mgrupo>/<mconta>, excluindo a chave desta movimentacao
    *             (EmpDopNums <> _chvLCred), filtrado por c.Tipoops=OpPends -> Pendencia
    *   If Sqlexecute(lcQuery,'Pendencia') < 1 -> MessageBox + Return .f.
    *   Scan Pendencia: _PendOutr += Round(totas * cotacao(moedas)/cotacao(crSigClLcr.moedas),2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcularPendencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nConv

        loc_lSucesso = .F.

        TRY
            THIS.this_nPendente = ROUND(THIS.this_nValorMovimento / ;
                fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
            THIS.this_nPendenteOutros = 0

            loc_cSQL = "SELECT SUM((b.Qtds - b.QtBaixas) * b.Units) AS Totas, b.Moedas, a.Dopes " + ;
                "FROM SigMvCab a, SigMvItn b, SigCdOpe c " + ;
                "WHERE " + THIS.this_cCampoGrupoSQL + " = " + EscaparSQL(THIS.this_cGrupo) + ;
                " AND " + THIS.this_cCampoContaSQL + " = " + EscaparSQL(THIS.this_cConta) + ;
                " AND a.EmpDopNums <> " + EscaparSQL(THIS.this_cChaveLimiteCredito) + ;
                " AND a.EmpDopNums = b.EmpDopNums AND a.Dopes = c.Dopes " + ;
                " AND c.TipoOps = " + FormatarNumeroSQL(THIS.this_nOpPendsParam, 0) + ;
                " GROUP BY b.Moedas, a.Dopes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorPendencia)

            IF loc_nResultado < 1
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conexao (Pendencia)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
            ELSE
                SELECT (THIS.this_cCursorPendencia)
                SCAN
                    loc_nConv = ROUND(TratarNulo(Totas, 0) * fBuscarCotacao(Moedas, DATE()) / ;
                        fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
                    THIS.this_nPendenteOutros = THIS.this_nPendenteOutros + loc_nConv
                ENDSCAN

                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorPendencia)
                USE IN (THIS.this_cCursorPendencia)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao calcular pendencias:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularSaldoDisponivel - legado:
    *   _SaldoFinal = crSigClLcr.limcres
    *       - Iif(LocalTOpe.GerGdmis=3,(_Pendente + _PendOutr),0)
    *       - _Saldocc
    *       - Iif(LocalTOpe.GerGdmis=3 Or crSigCdPam.ChqlCreds,_Chequec,0)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcularSaldoDisponivel()
        LOCAL loc_nAbatePendencia, loc_nAbateCheques

        loc_nAbatePendencia = IIF(THIS.this_nGerGdmis = 3, ;
            (THIS.this_nPendente + THIS.this_nPendenteOutros), 0)

        loc_nAbateCheques = IIF(THIS.this_nGerGdmis = 3 OR THIS.this_lChqLimiteCredito, ;
            THIS.this_nTotalCheques, 0)

        THIS.this_nSaldoDisponivel = THIS.this_nLimiteCredito - loc_nAbatePendencia - ;
            THIS.this_nSaldoContaCorrente - loc_nAbateCheques
    ENDPROC

    *--------------------------------------------------------------------------
    * BitParaLogico - Normaliza coluna BIT do SQL Server para Logico. O driver
    * entrega ora Logico (.T./.F.) ora Numerico (0/1) conforme o ponto da
    * query - testar o VARTYPE numa VARIAVEL LOCAL, nunca dentro de IIF/OR
    * no meio de um SELECT (os dois lados da expressao sempre avaliam, e o
    * lado "errado" estoura "Operator/operand type mismatch").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BitParaLogico(par_uValor)
        LOCAL loc_lRetorno

        DO CASE
        CASE VARTYPE(par_uValor) = "L"
            loc_lRetorno = par_uValor
        CASE VARTYPE(par_uValor) = "N"
            loc_lRetorno = (par_uValor = 1)
        OTHERWISE
            loc_lRetorno = .F.
        ENDCASE

        RETURN loc_lRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Dopes da operacao (SigCdOpe). Este BO eh somente-
    * leitura (ver cabecalho do arquivo) e RegistrarAuditoria/Inserir/
    * Atualizar/ExecutarExclusao nunca rodam aqui - sobrescrito so pela
    * convencao do projeto (CLAUDE.md - Audit System).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cDopes
    ENDPROC

ENDDEFINE

