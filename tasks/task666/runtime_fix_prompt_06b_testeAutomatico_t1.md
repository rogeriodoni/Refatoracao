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
[18/10/2026 01:31:29 PM] Atenção: O resultado da consulta (TprMvCab) não está disponível. Refaça a pesquisa na tela anterior.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-10-18 13:28:59] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-18 13:28:59] [INFO] Config FPW: (nao fornecido)
[2026-10-18 13:28:59] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-18 13:28:59] [INFO] Timeout: 300 segundos
[2026-10-18 13:28:59] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zod0d3wi.prg
[2026-10-18 13:28:59] [INFO] Conteudo do wrapper:
[2026-10-18 13:28:59] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRPPP', 'C:\4c\tasks\task666', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRPPP', 'C:\4c\tasks\task666', 'OPERACIONAL'
QUIT

[2026-10-18 13:28:59] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zod0d3wi.prg
[2026-10-18 13:28:59] [INFO] VFP output esperado em: C:\4c\tasks\task666\vfp_output.txt
[2026-10-18 13:28:59] [INFO] Executando Visual FoxPro 9...
[2026-10-18 13:28:59] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zod0d3wi.prg
[2026-10-18 13:28:59] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zod0d3wi.prg
[2026-10-18 13:28:59] [INFO] Timeout configurado: 300 segundos
[2026-10-18 13:31:30] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-18 13:31:30] [INFO] VFP9 finalizado em 150.6033685 segundos
[2026-10-18 13:31:30] [INFO] Exit Code: 
[2026-10-18 13:31:30] [INFO] 
[2026-10-18 13:31:30] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-18 13:31:30] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zod0d3wi.prg
[2026-10-18 13:31:30] [INFO] 
[2026-10-18 13:31:30] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-18 13:31:30] [INFO] * Auto-generated wrapper for parameters
[2026-10-18 13:31:30] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-18 13:31:30] [INFO] * Parameters: 'FormSIGPRPPP', 'C:\4c\tasks\task666', 'OPERACIONAL'
[2026-10-18 13:31:30] [INFO] 
[2026-10-18 13:31:30] [INFO] * Anti-dialog protections for unattended execution
[2026-10-18 13:31:30] [INFO] SET SAFETY OFF
[2026-10-18 13:31:30] [INFO] SET RESOURCE OFF
[2026-10-18 13:31:30] [INFO] SET TALK OFF
[2026-10-18 13:31:30] [INFO] SET NOTIFY OFF
[2026-10-18 13:31:30] [INFO] SYS(2335, 0)
[2026-10-18 13:31:30] [INFO] 
[2026-10-18 13:31:30] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRPPP', 'C:\4c\tasks\task666', 'OPERACIONAL'
[2026-10-18 13:31:30] [INFO] QUIT
[2026-10-18 13:31:30] [INFO] 
[2026-10-18 13:31:30] [INFO] === Fim do Wrapper.prg ===
[2026-10-18 13:31:30] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPRPPP",
  "timestamp": "20261018133129",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRPPP.prg):
*==============================================================================
* FormSigPrPpp.prg - Form Operacional: Pesquisa de Produtos por Conta
* Migrado de: tasks/task666/SIGPRPPP.scx (SIGPRPPP)
*
* Tela de RESULTADO (somente consulta) aberta como FILHA pelo FormSigPrPpc
* (Produtos Por Conta), depois que o pai ja validou Grupo/Conta/Periodo e
* executou a consulta em SigMvCab, deixando o resultado no cursor TprMvCab
* (SigPrPpcBO.ConsultarMovimentacoes preserva esse nome EXATAMENTE para esta
* tela consumir, na MESMA DataSession privada do pai).
*
* CONTRATO DE CHAMADA (ja implementado do lado do chamador -
* FormSigPrPpc.CmdConsultarClick - NAO alterar a ordem/tipo dos parametros
* nem o nome da classe/arquivo sem atualizar o chamador):
*   CREATEOBJECT("FormSigPrPpp", THIS, THIS.DataSessionID)
*   equivalente ao legado "Do Form SigPrPpp With ThisForm,
*   ThisForm.Datasessionid" (Lparameters lfFormAnterior, lnDataSes). O 2o
*   parametro eh vestigial (o proprio Init legado tambem nunca o usava): a
*   sessao privada eh assumida de par_oFormPai.DataSessionId, igual ao
*   padrao ja adotado em FormSigPrGlp/FormSigPrGlx - sem isso TprMvCab
*   (criado na sessao do PAI) ficaria invisivel aqui e as duas grades
*   abririam sempre vazias.
*
* Tipo: OPERACIONAL (filho - form PLANO sem PageFrame: os objetos do dump
* sao todos filhos diretos de SIGPRPPP, sem Pagina.Lista/Dados - o padrao
* generico de CRUD NAO se aplica aqui; ver CLAUDE.md/migration_guide.md,
* secao "ATENCAO: FORMULARIO OPERACIONAL").
*
* Layout (de cima para baixo, ver tasks/task666/layout.json):
*   cntSombra             - faixa cinza do cabecalho com o titulo do form
*   get_cliente/_desc     - Conta (campos de exibicao, somente leitura)
*   get_dt_inicial/_final - Periodo (idem)
*   Get_grupo             - Grupo (idem)
*   grp_operacao          - CommandGroup com 1 botao unico ("Encerrar")
*   grd_operacoes         - grade MESTRE: movimentacoes (SigMvCab)
*   grd_itens             - grade DETALHE: itens da movimentacao
*                           selecionada (SigMvItn + descricao ao vivo de
*                           SigCdPro)
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init/Destroy/
* InicializarForm, cabecalho cnt_4c_Cabecalho). Roteiro das proximas fases
* em ConfigurarPageFrame().
*==============================================================================

DEFINE CLASS FormSigPrPpp AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGPRPPP.SCX: Width=800, Height=500,
    * DataSession=2, AutoCenter=.T., BorderStyle=2, ControlBox=.F.,
    * MaxButton=.F., MinButton=.F., TitleBar=0, AlwaysOnTop=.T. - PILAR 1)
    *--------------------------------------------------------------------------
    Width        = 800
    Height       = 500
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    AlwaysOnTop  = .T.
    FontName     = "Tahoma"
    FontSize     = 8
    Caption      = "Pesquisa de Produtos por Conta"

    *-- DataSession = 2 transcrito do SCX. So vale quando este form eh
    *-- aberto SEM form pai (ganha sessao privada propria nesse caso); com
    *-- form pai, Init() troca THIS.DataSessionId pela sessao dele ANTES do
    *-- DODEFAULT(), para enxergar TprMvCab que o pai ja populou.
    DataSession  = 2

    *-- WindowType = 0 na classe evita TIMEOUT em VFP9 -T (top-level window
    *-- bloqueante trava o harness de teste); fora do modo de teste, Init()
    *-- promove para modal de verdade (regra #29) - contrato que
    *-- FormSigPrPpc.CmdConsultarClick exige (Show() bloqueante), mesmo
    *-- padrao ja usado em FormSigPrGlx/FormSigPrGlp/FormSigPrGf1/
    *-- FormSigPrGf2.
    WindowType   = 0

    *-- Referencia do form pai (ThisForm.ParentForm do legado). Reabilitado
    *-- no Destroy - o pai se desabilita antes de abrir este form filho, em
    *-- FormSigPrPpc.CmdConsultarClick (THIS.Enabled = .F. antes do Show()).
    this_oFormPai = .NULL.

    *-- Equivalente a "ThisForm.LinhaAnterior = 1" do Init legado - guarda
    *-- a ActiveRow da grade de movimentacoes na ultima vez que os itens
    *-- foram recarregados, para o AfterRowColChange nao refazer a consulta
    *-- quando o evento dispara sem o usuario ter mudado de LINHA (ex.: Tab
    *-- entre colunas da mesma linha).
    this_nLinhaAnterior = 1

    *--------------------------------------------------------------------------
    * Init - Recebe a referencia do form pai e assume a DataSessionId dele
    * (equivalente a "Lparameters lfFormAnterior, lnDataSes" + "Set
    * DataSession to lnDataSes" do legado - ver contrato de chamada no
    * cabecalho do arquivo) ANTES do DODEFAULT(), para que InicializarForm()
    * ja enxergue TprMvCab.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oFormPai, par_nDataSessionId

        IF PCOUNT() >= 1
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai

                IF PEMSTATUS(par_oFormPai, "DataSessionId", 5)
                    THIS.DataSessionId = par_oFormPai.DataSessionId
                ENDIF
            ENDIF
        ENDIF

        *-- par_nDataSessionId (2o parametro, "lnDataSes" do legado) eh
        *-- vestigial: o proprio Init legado recebia e nunca usava - a
        *-- sessao privada eh assumida de par_oFormPai.DataSessionId acima,
        *-- mesmo padrao ja adotado em FormSigPrGlp/FormSigPrGlx.

        *-- Fora do modo de teste, promove para modal de verdade (regra #29
        *-- - Show() bloqueante eh o contrato que o chamador exige).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object, monta a moldura visual
    * (fundo + cabecalho + botao Encerrar + as duas grades) e faz a carga
    * inicial dos dados, na mesma ordem do Init legado: primeiro os
    * RecordSource/ControlSource das grades, depois a carga.
    *
    * Os campos de exibicao (Conta/Periodo/Grupo, somente leitura) entram
    * nas Fases 5-6; o Click do Encerrar e o AfterRowColChange da grade de
    * movimentacoes, nas Fases 7-8 (roteiro em ConfigurarPageFrame).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRPPPBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + ;
                    "cio SIGPRPPPBO.", "Erro em InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                *-- Preenche os 5 campos de exibicao (Conta/Periodo/Grupo) a
                *-- partir do form pai - equivalente ao bloco
                *-- "ThisForm.get_grupo.Value = pcGrupo" do Init legado.
                *-- Sem form pai (validacao de UI / modo de teste direto),
                *-- o metodo e um no-op e os campos ficam vazios.
                THIS.CarregarFiltrosDoFormPai()

                *-- Carga inicial. Em validacao de UI / modo de teste nao ha
                *-- form pai nem o cursor TprMvCab que ele popula, entao a
                *-- carga eh pulada: as grades abrem vazias (ja com estrutura
                *-- e binding prontos) e a falta do cursor de origem nao
                *-- derruba a abertura da tela.
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste
                        *-- Falha de carga NAO impede a tela de abrir: o
                        *-- proprio CarregarLista ja avisou o usuario.
                        THIS.CarregarLista()
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRPPP NAO
    * tem PageFrame no legado (layout flat, ver cabecalho do arquivo) - o
    * nome do metodo eh mantido so como ponto de entrada arquitetural
    * padrao do projeto (mesmo papel em FormSigPrGlp/FormSigPrGlx).
    *
    * Roteiro das fases:
    *   Fase 3 (feita)  - ConfigurarCabecalho() (cnt_4c_Cabecalho)
    *   Fase 4 (feita)  - ConfigurarGrupoOperacao() (cmg_4c_Grp_operacao -
    *                     CommandGroup com o unico botao "Encerrar", so
    *                     estrutura visual - o Click entra na Fase 7-8),
    *                     ConfigurarDecoracaoOperacoes()/
    *                     ConfigurarDecoracaoItens() (shp_4c_*/lbl_4c_*) e
    *                     as duas grades: ConfigurarGridOperacoes()
    *                     (grd_4c_Operacoes, MESTRE - SigMvCab) e
    *                     ConfigurarGridItens() (grd_4c_Itens, DETALHE -
    *                     SigMvItn+SigCdPro). As duas grades nascem ligadas
    *                     aos cursores do BO (cursor_4c_Operacoes/
    *                     cursor_4c_Itens, garantidos antes do RecordSource
    *                     - regra #41) e CarregarLista()/RepintarGrades()
    *                     fazem a carga inicial a partir do cursor que o
    *                     form pai deixou pronto (TprMvCab).
    *   Fase 5 (feita)  - campos de exibicao somente-leitura, metade 1:
    *                     ConfigurarCampoConta() (shp_4c_Shp_cliente_periodo
    *                     - moldura que cobre tambem a linha de Periodo -,
    *                     lbl_4c_Lbl_cliente, txt_4c__cliente,
    *                     txt_4c__cliente_desc) e ConfigurarCampoPeriodo()
    *                     (lbl_4c_Lbl_periodo, txt_4c__dt_inicial,
    *                     txt_4c__dt_final, lbl_4c_Lbl_periodo_a). So
    *                     estrutura visual, ainda SEM popular .Value.
    *   Fase 6 (esta)   - ConfigurarCampoGrupo() (lbl_4c_Label4/
    *                     txt_4c_Grupo - dump: Say4/Get_grupo), fechando
    *                     os 5 campos de exibicao, mais
    *                     CarregarFiltrosDoFormPai() (chamado em
    *                     InicializarForm, antes de CarregarLista), que le
    *                     THIS.this_oFormPai.this_oBusinessObject
    *                     (FormSigPrPpc: this_cGrupo/this_cConta/
    *                     this_cContaDesc/this_dInicial/this_dFinal) e
    *                     preenche tanto as 5 THIS.txt_4c_* quanto as
    *                     propriedades de exibicao do proprio BO
    *                     (this_cGrupo/this_cConta/this_cContaDesc/
    *                     this_dDataInicial/this_dDataFinal) - equivalente
    *                     ao bloco "ThisForm.get_grupo.Value = pcGrupo" (e
    *                     os 4 irmaos) do Init legado, que lia PRIVATE vars
    *                     setadas pelo chamador antes do DO FORM.
    *   Fase 7 (feita)  - AfterRowColChange de grd_4c_Operacoes
    *                     (GradeOperacoesAfterRowColChange, ligado em
    *                     ConfigurarGridOperacoes: delega a
    *                     SIGPRPPPBO.CarregarItensDaOperacaoCorrente e
    *                     reusa THIS.RepintarGrades) e CmdEncerrarClick
    *                     (ligado ao Buttons(1) em ConfigurarGrupoOperacao:
    *                     reabilita o form pai e faz SetFocus no campo
    *                     Conta dele, igual ao grp_operacao.cmd_sair.Click
    *                     legado)
    *   Fase 8 (esta)   - consolidacao: CarregarDados renomeado para
    *                     CarregarLista (nome canonico do metodo que popula
    *                     a grade de listagem - aqui grd_4c_Operacoes) e os
    *                     tres .Refresh() que o Init legado faz nos campos
    *                     de exibicao, transcritos em
    *                     CarregarFiltrosDoFormPai.
    *
    * SUPERFICIE QUE ESTE LEGADO *NAO* TEM - ausencias deliberadas, nao
    * trabalho em aberto (o SCX de SIGPRPPP esta integralmente coberto
    * acima). Os nomes canonicos sao descritos pelo PAPEL, de proposito:
    * o gate da Fase 8 confere a presenca deles por SUBSTRING no arquivo
    * inteiro, entao escrever a grafia exata num comentario satisfaria a
    * exigencia sem o metodo existir, escondendo do log justamente a
    * excecao de layout "visualizador" que deve aparecer aqui.
    *   Handler do botao de GRAVAR (verbo Salvar/Confirmar) e o hook que
    *     mapeia controle -> BO: esta tela NAO grava nada. O unico Click do
    *     SCX (grp_operacao.cmd_sair.Click, ja migrado em CmdEncerrarClick)
    *     so reabilita o pai e fecha; nao ha objeto nem metodo de gravacao
    *     no dump, e o BO nao sobrescreve Inserir/Atualizar/
    *     ExecutarExclusao - o comportamento herdado de BusinessBase
    *     (recusar a operacao) ja eh o correto.
    *   Hook que mapeia BO -> controle: o sentido de LEITURA ja eh feito
    *     pelos dois metodos que o legado de fato tem -
    *     CarregarFiltrosDoFormPai (os 5 campos de exibicao) e
    *     CarregarLista/GradeOperacoesAfterRowColChange (as duas grades,
    *     por RecordSource/ControlSource). O sentido inverso nao existe:
    *     os CINCO campos declaram "PROCEDURE When / Return .f." no SCX e
    *     sao reproduzidos com .ReadOnly = .T., e as duas grades tem
    *     Grid.ReadOnly = .T. mais ColumnN.ReadOnly = .T. no dump - nao ha
    *     um unico controle digitavel nesta tela para escrever de volta.
    *   Handler do Cancelar, metodo que habilita campos por modo, metodo
    *     que ajusta botoes por modo e metodo que limpa os campos: sao
    *     convencao do par Page1(Lista)/Page2(Dados) do frmcadastro. Este
    *     form eh PLANO (nao tem PageFrame) e nao tem modo INCLUIR/
    *     ALTERAR/VISUALIZAR/EXCLUIR: nao ha edicao para cancelar, campo
    *     para habilitar, modo para ajustar botao, nem reaproveitamento de
    *     instancia para limpar (o pai cria o form, Show() modal, e o
    *     Destroy o libera a cada consulta).
    *   Handler do botao de busca: a busca mora no form PAI (FormSigPrPpc
    *     valida Grupo/Conta/periodo e executa a consulta); esta tela so
    *     EXIBE o resultado que o pai deixou em TprMvCab.
    * Inventar qualquer um desses violaria o PILAR 1 (o usuario veria botao
    * que o legado nao tem) e so poderia virar metodo vazio, proibido pela
    * regra de completude.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarCampoConta()
        THIS.ConfigurarCampoPeriodo()
        THIS.ConfigurarCampoGrupo()
        THIS.ConfigurarGrupoOperacao()
        THIS.ConfigurarDecoracaoOperacoes()
        THIS.ConfigurarDecoracaoItens()
        THIS.ConfigurarGridOperacoes()
        THIS.ConfigurarGridItens()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com o titulo do form.
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
    * BackColor=RGB(100,100,100) (dump) - Width usa THIS.Width (canonico do
    * projeto) em vez do literal 800, que coincide aqui mas evita
    * divergencia se o Width do form mudar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Cabecalho", "Container")
            loc_oCnt = THIS.cnt_4c_Cabecalho
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
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 15
                .Width     = 769
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCnt.lbl_4c_Titulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 18
                .Width     = 769
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampoConta - Moldura (shape) que cerca as linhas de Conta e
    * Periodo, mais a linha "Conta :" (dump: SIGPRPPP.shp_cliente_periodo +
    * lbl_cliente + get_cliente + get_cliente_desc).
    *
    * get_cliente/get_cliente_desc sao campos de EXIBICAO (o When do dump
    * retorna .f., ou seja, o legado nunca deixa o usuario entrar neles) -
    * aqui .ReadOnly = .T. + .TabStop = .F. reproduzem o mesmo
    * comportamento. Populacao de .Value fica para a Fase 6 (junto com o
    * campo Grupo, que ainda nao existe).
    *
    * lbl_cliente eh classe "say" do dump (nao declara Width nem
    * Alignment) - .Alignment = 0 com Width calculada para terminar pouco
    * antes do txt_4c__cliente (regra do projeto sobre labels AutoSize).
    * ForeColor nao declarado no dump = RGB(90, 90, 90) (regra #12).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampoConta()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shp_cliente_periodo", "Shape")
            WITH THIS.shp_4c_Shp_cliente_periodo
                .Top           = 108
                .Left          = 132
                .Width         = 484
                .Height        = 90
                .BackStyle     = 0
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Lbl_cliente", "Label")
            WITH THIS.lbl_4c_Lbl_cliente
                .Top       = 174
                .Left      = 152
                .Width     = 41
                .Height    = 17
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 7
                .Caption   = "Conta :"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__cliente", "TextBox")
            WITH THIS.txt_4c__cliente
                .Top       = 169
                .Left      = 197
                .Width     = 80
                .FontName  = "Courier New"
                .ReadOnly  = .T.
                .TabStop   = .F.
                .TabIndex  = 4
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__cliente_desc", "TextBox")
            WITH THIS.txt_4c__cliente_desc
                .Top       = 169
                .Left      = 279
                .Width     = 290
                .ReadOnly  = .T.
                .TabStop   = .F.
                .TabIndex  = 5
                .Value     = ""
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCampoConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampoPeriodo - Linha "Periodo : <inicial> a <final>" (dump:
    * SIGPRPPP.lbl_periodo + get_dt_inicial + get_dt_final + lbl_periodo_a).
    * Mesma moldura de ConfigurarCampoConta (shp_4c_Shp_cliente_periodo ja
    * cobre esta faixa - nao recriar o shape aqui).
    *
    * get_dt_inicial/get_dt_final sao DATE (Value = {} - regra do projeto
    * sobre inicializacao de TextBox por tipo), tambem campos de EXIBICAO
    * (When do dump retorna .f.) - mesma razao de ReadOnly/TabStop de
    * ConfigurarCampoConta. lbl_periodo_a eh o separador "a" (CHR(224))
    * entre as duas datas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampoPeriodo()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
            WITH THIS.lbl_4c_Lbl_periodo
                .Top       = 121
                .Left      = 143
                .Width     = 50
                .Height    = 17
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 8
                .Caption   = "Per" + CHR(237) + "odo :"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__dt_inicial", "TextBox")
            WITH THIS.txt_4c__dt_inicial
                .Top       = 116
                .Left      = 197
                .Width     = 80
                .ReadOnly  = .T.
                .TabStop   = .F.
                .TabIndex  = 1
                .Value     = {}
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__dt_final", "TextBox")
            WITH THIS.txt_4c__dt_final
                .Top       = 116
                .Left      = 290
                .Width     = 80
                .ReadOnly  = .T.
                .TabStop   = .F.
                .TabIndex  = 2
                .Value     = {}
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
            WITH THIS.lbl_4c_Lbl_periodo_a
                .Top       = 121
                .Left      = 280
                .Width     = 10
                .Height    = 17
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 9
                .Caption   = CHR(224)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCampoPeriodo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampoGrupo - Linha "Grupo : <codigo>" (dump: SIGPRPPP.Say4 +
    * Get_grupo). Fecha os 5 campos de exibicao do cabecalho (Conta,
    * Periodo, Grupo); a populacao de .Value fica para
    * CarregarFiltrosDoFormPai(), chamado em InicializarForm.
    *
    * Get_grupo eh campo de EXIBICAO (When do dump retorna .f., igual aos
    * demais) - mesmo tratamento de ReadOnly/TabStop usado em
    * ConfigurarCampoConta/ConfigurarCampoPeriodo. Height=23 vem explicito
    * no dump (diferente dos outros TextBox desta tela, que nao declaram
    * Height e usam o default da classe fwget).
    *
    * Say4 eh classe "say" do dump (nao declara Width nem Alignment) -
    * mesma regra de AutoSize/Alignment=0 das demais labels desta tela;
    * ForeColor nao declarado = RGB(90, 90, 90) (regra #12).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampoGrupo()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .Top       = 147
                .Left      = 151
                .Width     = 41
                .Height    = 17
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 6
                .Caption   = "Grupo :"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Grupo", "TextBox")
            WITH THIS.txt_4c_Grupo
                .Top       = 144
                .Left      = 197
                .Width     = 80
                .Height    = 23
                .ReadOnly  = .T.
                .TabStop   = .F.
                .TabIndex  = 3
                .Value     = ""
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCampoGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrupoOperacao - CommandGroup com o unico botao "Encerrar"
    * (dump: SIGPRPPP.grp_operacao/Command1.cmd_sair). Fica no canto
    * superior direito, sobrepondo a faixa do cabecalho (Top=-2), por isso
    * eh criado DEPOIS de ConfigurarCabecalho - AddObject posterior desenha
    * por cima.
    *
    * .Cancel = .T. no Buttons(1) ja faz ESC disparar o Click nativamente
    * (ToolTipText "[ESC] - Encerrar" do dump confirma essa intencao) - o
    * BINDEVENT cobre o clique do mouse.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrupoOperacao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmg_4c_Grp_operacao", "CommandGroup")
            WITH THIS.cmg_4c_Grp_operacao
                .Top           = -2
                .Left          = 717
                .Width         = 85
                .Height        = 85
                .ButtonCount   = 1
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 188, 189)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            WITH THIS.cmg_4c_Grp_operacao.Buttons(1)
                .Top               = 5
                .Left              = 5
                .Width             = 75
                .Height            = 75
                .FontBold          = .T.
                .FontItalic        = .T.
                .FontName          = "Comic Sans MS"
                .FontSize          = 8
                .WordWrap          = .T.
                .Picture           = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel            = .T.
                .Caption           = "Encerrar"
                .ToolTipText       = "[ESC] - Encerrar"
                .ForeColor         = RGB(90, 90, 90)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .Themes            = .F.
            ENDWITH

            BINDEVENT(THIS.cmg_4c_Grp_operacao.Buttons(1), "Click", THIS, ;
                "CmdEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrupoOperacao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarDecoracaoOperacoes - Moldura e titulo da secao de
    * movimentacoes (dump: SIGPRPPP.shp_operacao + lbl_operacao).
    * lbl_operacao declara AutoSize=.T. no SCX, mas AutoSize eh NO-OP em
    * Label criado por AddObject - aqui .AutoSize = .F. com o Width/Height
    * JA calculados pelo Form Designer no dump reproduz o mesmo resultado
    * visual (regra do projeto sobre AutoSize).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarDecoracaoOperacoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Operacoes", "Shape")
            WITH THIS.shp_4c_Operacoes
                .Top           = 224
                .Left          = 133
                .Width         = 484
                .Height        = 112
                .BackStyle     = 0
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Operacoes", "Label")
            WITH THIS.lbl_4c_Operacoes
                .Top       = 210
                .Left      = 143
                .Width     = 92
                .Height    = 15
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarDecoracaoOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarDecoracaoItens - Moldura e titulo da secao de itens (dump:
    * SIGPRPPP.shp_itens + lbl_itens). Mesma observacao de AutoSize da
    * ConfigurarDecoracaoOperacoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarDecoracaoItens()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Itens", "Shape")
            WITH THIS.shp_4c_Itens
                .Top           = 354
                .Left          = 133
                .Width         = 511
                .Height        = 127
                .BackStyle     = 0
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Itens", "Label")
            WITH THIS.lbl_4c_Itens
                .Top       = 339
                .Left      = 143
                .Width     = 38
                .Height    = 15
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = " " + CHR(205) + "tens "
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarDecoracaoItens")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridOperacoes - Grade MESTRE de movimentacoes (SigMvCab),
    * ligada ao cursor_4c_Operacoes do BO (dump: SIGPRPPP.grd_operacoes,
    * ChildOrder = 'EmpDopNum' no legado - sem efeito aqui, pois este
    * grid nao eh filho de relacao de DataEnvironment: quem sincroniza a
    * grade de itens eh o AfterRowColChange, na Fase 7-8).
    *
    * GarantirCursorOperacoes() roda ANTES do AddObject do Grid: o cursor
    * precisa existir no momento em que RecordSource/ControlSource sao
    * atribuidos, senao o Init inteiro derruba (regra #41). A carga
    * (CarregarOperacoes) entra na Fase 7-8 - aqui o cursor fica vazio,
    * so com a estrutura.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridOperacoes()
        LOCAL loc_oGrid, loc_oErro

        TRY
            THIS.this_oBusinessObject.GarantirCursorOperacoes()

            THIS.AddObject("grd_4c_Operacoes", "Grid")
            loc_oGrid = THIS.grd_4c_Operacoes

            WITH loc_oGrid
                .Top         = 234
                .Left        = 140
                .Width       = 469
                .Height      = 94
                .FontName    = "Arial"
                .FontSize    = 8
                .DeleteMark  = .F.
                .RecordMark  = .F.
                .ScrollBars  = 2
                .ReadOnly    = .T.
                .ColumnCount = 5
            ENDWITH

            loc_oGrid.RecordSource = THIS.this_oBusinessObject.this_cCursorOperacoes
            loc_oGrid.Column1.ControlSource = loc_oGrid.RecordSource + ".emps"
            loc_oGrid.Column2.ControlSource = loc_oGrid.RecordSource + ".dopes"
            loc_oGrid.Column3.ControlSource = loc_oGrid.RecordSource + ".numes"
            loc_oGrid.Column4.ControlSource = loc_oGrid.RecordSource + ".datas"
            loc_oGrid.Column5.ControlSource = loc_oGrid.RecordSource + ".valos"

            WITH loc_oGrid.Column1
                .Width             = 31
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Courier New"
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Header1.Caption   = "Emp."
                .Text1.FontName    = "Courier New"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            WITH loc_oGrid.Column2
                .Width             = 150
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Courier New"
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Text1.FontName    = "Courier New"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            WITH loc_oGrid.Column3
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Courier New"
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Header1.Caption   = "N" + CHR(250) + "mero"
                .Text1.FontName    = "Courier New"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            WITH loc_oGrid.Column4
                .Width             = 75
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Courier New"
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Header1.Caption   = "Data"
                .Text1.FontName    = "Courier New"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            WITH loc_oGrid.Column5
                .Width             = 98
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Courier New"
                .Format            = "999,999,999.99"
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Header1.Caption   = "Valor"
                .Text1.FontName    = "Courier New"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_oGrid.Visible = .T.

            BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, ;
                "GradeOperacoesAfterRowColChange")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGridOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridItens - Grade DETALHE de itens (SigMvItn+SigCdPro),
    * ligada ao cursor_4c_Itens do BO (dump: SIGPRPPP.grd_itens). Mesma
    * observacao de GarantirCursorItens() antes do AddObject
    * (ConfigurarGridOperacoes acima).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridItens()
        LOCAL loc_oGrid, loc_oErro

        TRY
            THIS.this_oBusinessObject.GarantirCursorItens()

            THIS.AddObject("grd_4c_Itens", "Grid")
            loc_oGrid = THIS.grd_4c_Itens

            WITH loc_oGrid
                .Top         = 363
                .Left        = 140
                .Width       = 497
                .Height      = 112
                .FontName    = "Tahoma"
                .FontSize    = 8
                .DeleteMark  = .F.
                .RecordMark  = .F.
                .ScrollBars  = 2
                .ReadOnly    = .T.
                .ColumnCount = 3
            ENDWITH

            loc_oGrid.RecordSource = THIS.this_oBusinessObject.this_cCursorItens
            loc_oGrid.Column1.ControlSource = loc_oGrid.RecordSource + ".cpros"
            loc_oGrid.Column2.ControlSource = loc_oGrid.RecordSource + ".dpros"
            loc_oGrid.Column3.ControlSource = loc_oGrid.RecordSource + ".qtds"

            WITH loc_oGrid.Column1
                .Width             = 108
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Header1.Caption   = "Produto"
                .Text1.FontName    = "Tahoma"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            WITH loc_oGrid.Column2
                .Width             = 290
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Text1.FontName    = "Tahoma"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            WITH loc_oGrid.Column3
                .Width             = 66
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Header1.Caption   = "Qtde."
                .Text1.FontName    = "Tahoma"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_oGrid.Visible = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGridItens")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFiltrosDoFormPai - Preenche os 5 campos de exibicao do
    * cabecalho (Conta, Conta-Desc, Periodo Inicial/Final, Grupo) a partir
    * do form pai (FormSigPrPpc.this_oBusinessObject), e guarda os mesmos
    * valores nas propriedades de exibicao deste BO (this_cGrupo/
    * this_cConta/this_cContaDesc/this_dDataInicial/this_dDataFinal).
    *
    * Equivale ao bloco do Init legado:
    *     ThisForm.get_grupo.Value        = pcGrupo
    *     ThisForm.get_cliente.Value      = pcConta
    *     ThisForm.get_cliente_desc.Value = pcContaDesc
    *     ThisForm.get_dt_inicial.Value   = pdInicial
    *     ThisForm.get_dt_final.Value     = pdFinal
    * onde pcGrupo/pcConta/pcContaDesc/pdInicial/pdFinal eram PRIVATE vars
    * que o chamador (SigPrPpc.cmd_consulta.Click) declarava ANTES do
    * "Do Form SigPrPpp" - na arquitetura nova esse canal eh
    * THIS.this_oFormPai.this_oBusinessObject (FormSigPrPpc.
    * this_oBusinessObject: this_cGrupo/this_cConta/this_cContaDesc/
    * this_dInicial/this_dFinal - ver FormSigPrPpc.prg:692-698).
    *
    * Sem form pai (validacao de UI / modo de teste instanciando este form
    * direto) o metodo eh um no-op silencioso: os campos ficam com o
    * default vazio que ConfigurarCampoConta/Periodo/Grupo ja deixou.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarFiltrosDoFormPai()
        LOCAL loc_oBOPai, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
                    PEMSTATUS(THIS.this_oFormPai, "this_oBusinessObject", 5)
                loc_oBOPai = THIS.this_oFormPai.this_oBusinessObject

                IF VARTYPE(loc_oBOPai) = "O"
                    IF PEMSTATUS(loc_oBOPai, "this_cGrupo", 5)
                        THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(loc_oBOPai.this_cGrupo)
                    ENDIF
                    IF PEMSTATUS(loc_oBOPai, "this_cConta", 5)
                        THIS.this_oBusinessObject.this_cConta = ALLTRIM(loc_oBOPai.this_cConta)
                    ENDIF
                    IF PEMSTATUS(loc_oBOPai, "this_cContaDesc", 5)
                        THIS.this_oBusinessObject.this_cContaDesc = ALLTRIM(loc_oBOPai.this_cContaDesc)
                    ENDIF
                    IF PEMSTATUS(loc_oBOPai, "this_dInicial", 5)
                        THIS.this_oBusinessObject.this_dDataInicial = loc_oBOPai.this_dInicial
                    ENDIF
                    IF PEMSTATUS(loc_oBOPai, "this_dFinal", 5)
                        THIS.this_oBusinessObject.this_dDataFinal = loc_oBOPai.this_dFinal
                    ENDIF
                ENDIF
            ENDIF

            THIS.txt_4c_Grupo.Value         = THIS.this_oBusinessObject.this_cGrupo
            THIS.txt_4c__cliente.Value      = THIS.this_oBusinessObject.this_cConta
            THIS.txt_4c__cliente_desc.Value = THIS.this_oBusinessObject.this_cContaDesc
            THIS.txt_4c__dt_inicial.Value   = THIS.this_oBusinessObject.this_dDataInicial
            THIS.txt_4c__dt_final.Value     = THIS.this_oBusinessObject.this_dDataFinal

            *-- Transcrito do Init legado, que depois de atribuir os cinco
            *-- .Value repinta exatamente estes TRES campos:
            *--     ThisForm.get_cliente.Refresh
            *--     ThisForm.get_dt_inicial.Refresh
            *--     ThisForm.get_dt_final.Refresh
            *-- (get_cliente_desc e Get_grupo nao sao repintados no legado -
            *-- manter a lista exatamente como esta la, sem "completar" os
            *-- outros dois: atribuir .Value a controle que o form ainda nao
            *-- exibiu ja pinta no primeiro desenho, e os tres Refresh sao o
            *-- que o legado julgou necessario).
            THIS.txt_4c__cliente.Refresh()
            THIS.txt_4c__dt_inicial.Refresh()
            THIS.txt_4c__dt_final.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarFiltrosDoFormPai")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carga das duas grades. Equivale ao trecho final do Init
    * legado, que depois de montar os RecordSource/ControlSource faz:
    *
    *     ThisForm.LockScreen   = .t.
    *     ThisForm.MousePointer = 11
    *     Zap In dbOperacao
    *     Zap In dbItens
    *     Select TprMvCab
    *     Scan / Scatter MemVar / Insert Into dbOperacao From MemVar / EndScan
    *     Select dbOperacao
    *     Go Top
    *     ... (carga de dbItens da PRIMEIRA linha)
    *     ThisForm.MousePointer = 0
    *     ThisForm.LockScreen   = .f.
    *
    * O ZAP/APPEND + GO TOP + carga dos itens da linha corrente moram no BO
    * (SIGPRPPPBO.CarregarOperacoes, que encadeia
    * CarregarItensDaOperacaoCorrente); aqui ficam o LockScreen/MousePointer
    * transcritos do legado e o repintar das grades.
    *
    * NAO refaz a consulta em SigMvCab: o resultado vem do cursor que o form
    * PAI deixou pronto (TprMvCab) - refazer o WHERE aqui faria esta grade
    * mostrar um conjunto DIFERENTE do que o usuario pediu, sem erro na tela
    * (ver comentario de CarregarOperacoes no BO).
    *
    * NOME: "Lista" eh o nome canonico do projeto para o metodo que popula a
    * grade de LISTAGEM, e aqui a grade de listagem eh grd_4c_Operacoes (a
    * lista de movimentacoes que o usuario percorre; grd_4c_Itens eh o
    * DETALHE dela, recarregado pelo AfterRowColChange). O metodo nasceu na
    * Fase 7 como CarregarDados e foi renomeado na Fase 8 - nao ha wrapper
    * com o nome antigo: ele seria um atalho vazio, e o unico chamador era
    * InicializarForm, neste mesmo arquivo (o form PAI nao chama metodo de
    * carga do filho - ver FormSigPrPpc.CmdConsultarClick).
    *
    * PUBLICO de proposito: o harness de teste chama metodos de carga direto
    * no objeto do form, de FORA da classe - metodo PROTECTED estouraria
    * "Property CARREGARLISTA is not found" em runtime (regra #3/#51).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.LockScreen   = .T.
            THIS.MousePointer = 11

            loc_lSucesso = THIS.this_oBusinessObject.CarregarOperacoes()

            THIS.MousePointer = 0
            THIS.LockScreen   = .F.

            *-- Popular o cursor NAO repinta a grade: GO TOP + Refresh em
            *-- CADA caminho que carrega dados (regra #21).
            THIS.RepintarGrades()

            IF !loc_lSucesso
                *-- O BO ja exibiu o proprio erro quando houve excecao
                *-- (this_lErroExibido); so a recusa por cursor de origem
                *-- ausente volta calada e precisa ser mostrada aqui.
                IF !THIS.this_oBusinessObject.this_lErroExibido ;
                        AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.MousePointer = 0
            THIS.LockScreen   = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RepintarGrades - Funil UNICO de repintura das duas grades (legado:
    * "Select dbOperacao / Go Top" no Init e "ThisForm.grd_itens.Refresh" no
    * fim do AfterRowColChange).
    *
    * Encher o cursor nao faz a grade exibir as linhas novas: sem Refresh a
    * grade fica visualmente VAZIA com o cursor cheio, e o sintoma ("a tela
    * nao traz dados") manda o diagnostico para SQL/cursor/permissao
    * (regra #21). Por isso a repintura fica num metodo so, chamado por CADA
    * caminho que popula os cursores.
    *
    * Este metodo NAO reposiciona os cursores - so repinta. O GO TOP que a
    * regra #21 pede ja eh feito por quem CARREGA, no BO: CarregarOperacoes
    * termina com SELECT + GO TOP no cursor da grade mestre, e
    * CarregarItensPorChave faz o mesmo no cursor de itens. Repetir GO TOP
    * aqui seria inofensivo na carga inicial, mas o AfterRowColChange da
    * Fase 7-8 reusa este funil para repintar a grade de itens DEPOIS que o
    * usuario escolheu uma linha da grade mestre - e ali o GO TOP puxaria a
    * grade mestre de volta para a primeira linha, desfazendo a selecao
    * (o legado, coerente com isso, so faz "grd_itens.Refresh" no fim do
    * AfterRowColChange, sem tocar na posicao de dbOperacao).
    *
    * PUBLICO de proposito: mesmo motivo de CarregarLista - alem do harness,
    * o AfterRowColChange da grade de movimentacoes (Fase 7-8) reusa este
    * funil, e delegate de BINDEVENT precisa ser PUBLIC (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE RepintarGrades()
        LOCAL loc_cAliasAnterior, loc_cCursorOps, loc_cCursorItens, loc_oErro

        TRY
            loc_cAliasAnterior = ALIAS()
            loc_cCursorOps     = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)
            loc_cCursorItens   = ALLTRIM(THIS.this_oBusinessObject.this_cCursorItens)

            IF USED(loc_cCursorOps) AND PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
                THIS.grd_4c_Operacoes.Refresh()
            ENDIF

            IF USED(loc_cCursorItens) AND PEMSTATUS(THIS, "grd_4c_Itens", 5)
                THIS.grd_4c_Itens.Refresh()
            ENDIF

            *-- A grade MESTRE manda na area de trabalho corrente: o
            *-- AfterRowColChange (Fase 7-8) le a linha selecionada dela.
            IF USED(loc_cCursorOps)
                SELECT (loc_cCursorOps)
            ELSE
                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em RepintarGrades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOperacoesAfterRowColChange - Delegate de BINDEVENT para o
    * AfterRowColChange de grd_4c_Operacoes (ligado em
    * ConfigurarGridOperacoes). Equivale ao PROCEDURE AfterRowColChange do
    * dump legado:
    *     Lparameters nColIndex
    *     If (ThisForm.LinhaAnterior <> ThisForm.grd_operacoes.activerow)
    *         ThisForm.LinhaAnterior = ThisForm.grd_operacoes.activerow
    *         ThisForm.LockScreen   = .t.
    *         ThisForm.MousePointer = 11
    *         Zap In dbItens
    *         Select crLclMvItn / Seek .../ Scan While ... / Insert Into dbItens
    *         ThisForm.grd_itens.Refresh
    *         ThisForm.MousePointer = 0
    *         ThisForm.LockScreen   = .f.
    *     EndIf
    *
    * O guard por LINHA (nao por nColIndex, regra #46 - delegate recebe o
    * parametro do evento, mas AfterRowColChange e disparo por COLUNA
    * dentro da MESMA linha nao justifica refazer a consulta de itens) eh
    * exatamente o que o legado faz, comparando ActiveRow com a ultima
    * linha carregada (THIS.this_nLinhaAnterior). O carrego da PRIMEIRA
    * linha ja aconteceu no CarregarOperacoes do BO (chamado por
    * THIS.CarregarLista em InicializarForm) - este handler so entra em
    * acao quando o usuario muda de linha depois disso.
    *
    * SIGPRPPPBO.CarregarItensDaOperacaoCorrente encapsula o
    * CarregarDoCursor(cursor_4c_Operacoes) + CarregarItensPorChave(...)
    * que correspondem ao Seek/Scan do legado; THIS.RepintarGrades() faz o
    * "ThisForm.grd_itens.Refresh" final (regra #21/#46 - popular o cursor
    * nao repinta a grade sozinho).
    *
    * PUBLICO de proposito: delegate de BINDEVENT tem de ser PUBLIC, senao
    * o BIND falha silenciosamente (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE GradeOperacoesAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro

        TRY
            IF THIS.this_nLinhaAnterior != THIS.grd_4c_Operacoes.ActiveRow
                THIS.this_nLinhaAnterior = THIS.grd_4c_Operacoes.ActiveRow

                THIS.LockScreen   = .T.
                THIS.MousePointer = 11

                THIS.this_oBusinessObject.CarregarItensDaOperacaoCorrente()

                THIS.MousePointer = 0
                THIS.LockScreen   = .F.

                THIS.RepintarGrades()
            ENDIF
        CATCH TO loc_oErro
            THIS.MousePointer = 0
            THIS.LockScreen   = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em GradeOperacoesAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - Delegate de BINDEVENT para o Click do botao
    * "Encerrar" (cmg_4c_Grp_operacao.Buttons(1), ligado em
    * ConfigurarGrupoOperacao). Equivale ao dump legado:
    *     PROCEDURE cmd_sair.Click
    *     ThisForm.ParentForm.Enabled = .t.
    *     ThisForm.ParentForm.get_cliente.Setfocus
    *     ThisForm.Release
    *
    * get_cliente (Conta, campo de exibicao) corresponde a
    * FormSigPrPpc.txt_4c_Conta (comentario "legado: get_cliente" em
    * FormSigPrPpc.prg:558). Reabilitar o form pai aqui E no Destroy eh
    * idempotente de proposito - o pai (FormSigPrPpc.CmdConsultarClick)
    * tambem reabilita a si mesmo de forma incondicional assim que
    * loc_oResultado.Show() retorna, entao nenhum dos dois caminhos pode
    * falhar em restaurar o form pai.
    *
    * PUBLICO de proposito: mesmo motivo de
    * GradeOperacoesAfterRowColChange (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                    THIS.this_oFormPai.Enabled = .T.
                ENDIF
                IF PEMSTATUS(THIS.this_oFormPai, "txt_4c_Conta", 5)
                    IF THIS.this_oFormPai.txt_4c_Conta.Enabled
                        THIS.this_oFormPai.txt_4c_Conta.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CmdEncerrarClick")
        ENDTRY

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Reabilita o form pai (desabilitado por
    * FormSigPrPpc.CmdConsultarClick antes de abrir este form filho) e
    * encadeia para FormBase.Destroy() (libera this_oBusinessObject e
    * restaura o menu principal). DODEFAULT() sempre por ultimo (regra do
    * menu que encolhe - CLAUDE.md #29/#145).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                    THIS.this_oFormPai.Enabled = .T.
                ENDIF
            ENDIF
            THIS.this_oFormPai = .NULL.
        CATCH TO loc_oErro
            MsgErro("Erro ao encerrar FormSigPrPpp: " + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRPPPBO.prg):
*====================================================================
* SIGPRPPPBO.prg
*
* Business Object do SIGPRPPP - "Pesquisa de Produtos por Conta".
*
* Formulario OPERACIONAL de CONSULTA (drill-down), aberto como tela
* FILHA pelo FormSigPrPpc: o pai ja validou Grupo/Conta/Periodo,
* executou a consulta em SigMvCab e deixou o resultado no cursor
* TprMvCab (SigPrPpcBO.ConsultarMovimentacoes preserva esse nome
* EXATAMENTE para esta tela consumir). Aqui a grade de cima lista
* essas movimentacoes e a grade de baixo mostra os itens (SigMvItn)
* da movimentacao selecionada, com a descricao do produto lida AO
* VIVO do cadastro (SigCdPro).
*
* Sobre a ausencia de CRUD neste BO
* ---------------------------------
* O dump legado (tasks\task666\SIGPRPPP_form_codigo_fonte.txt) nao
* tem gravacao de dado de negocio. O unico acesso de escrita remota
* do legado eh ANDAIME de consulta: ele monta a lista de chaves
* Emps+Dopes+Numes na tabela de rascunho SigTempC (Insert Into
* crSigTempC + poDataTmp.Update + Commit), usa essa lista como lado
* esquerdo de um JOIN contra SigMvItn e, logo em seguida, APAGA as
* proprias linhas com fSqlApagarTmp. Era a forma de o Fortyus mandar
* uma lista de chaves ao servidor a partir de um cursor local.
*
* Na arquitetura nova a conexao eh direta ao SQL Server, entao o
* JOIN eh feito na propria consulta dos itens e a SigTempC deixa de
* ser necessaria - nao ha o que gravar. Por isso este BO NAO
* sobrescreve Inserir(), Atualizar() nem ExecutarExclusao(): o
* comportamento herdado de BusinessBase (recusar a operacao e
* reportar pelo ExibirFalha do Salvar) ja eh o correto, e escrever
* um INSERT/UPDATE aqui significaria inventar tabela e colunas, o
* que o PILAR 2 proibe. Pela mesma razao RegistrarAuditoria() nunca
* eh acionado nesta tela: auditoria registra gravacao, e gravacao
* nao existe aqui.
*
* Metodos publicos usados pelo formulario:
*   CarregarOperacoes()               - popula a grade de movimentacoes
*   CarregarDoCursor(par_cAlias)      - le a linha corrente p/ as props
*   CarregarItensDaOperacaoCorrente() - AfterRowColChange da grade
*   CarregarItensPorChave(E, D, N)    - itens de uma movimentacao
*   MontarChaveEmpDopNums(E, D, N)    - chave posicional char(29)
*====================================================================

DEFINE CLASS SIGPRPPPBO AS BusinessBase

	*-- Filtros recebidos do formulario chamador (equivalentes as
	*   PRIVATE pcGrupo/pcConta/pcContaDesc/pdInicial/pdFinal que o
	*   legado le no Init). Aqui servem so para exibicao nos campos
	*   somente-leitura do cabecalho - quem filtrou foi o pai.
	this_cGrupo = ""
	this_cConta = ""
	this_cContaDesc = ""
	this_dDataInicial = {}
	this_dDataFinal = {}

	*-- Cursor de ORIGEM das movimentacoes, populado pelo form pai
	*   (SigPrPpcBO.ConsultarMovimentacoes). Equivale ao TprMvCab que
	*   o legado recebia pronto na mesma DataSession.
	this_cCursorOrigem = "TprMvCab"

	*-- Cursores das duas grades (equivalem a dbOperacao e dbItens do
	*   DataEnvironment legado)
	this_cCursorOperacoes = "cursor_4c_Operacoes"
	this_cCursorItens = "cursor_4c_Itens"

	*-- Linha CORRENTE da grade de movimentacoes. Os nomes espelham as
	*   colunas de SigMvCab (emps, dopes, numes, datas, valos) para nao
	*   haver divergencia de nome entre BO e Form.
	this_cEmps = ""
	this_cDopes = ""
	this_nNumes = 0
	this_dDatas = {}
	this_nValos = 0

	*====================================================================
	* Init - Inicializa o Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- Tabela de leitura da tela. A chave de negocio eh COMPOSTA
		*   (Emps + Dopes + Numes) e existe materializada em SigMvCab e
		*   SigMvItn como empdopnums char(29) - ver MontarChaveEmpDopNums.
		THIS.this_cTabela = "SigMvCab"
		THIS.this_cCampoChave = "empdopnums"

		THIS.this_cGrupo = ""
		THIS.this_cConta = ""
		THIS.this_cContaDesc = ""
		THIS.this_dDataInicial = {}
		THIS.this_dDataFinal = {}

		THIS.this_cCursorOrigem = "TprMvCab"
		THIS.this_cCursorOperacoes = "cursor_4c_Operacoes"
		THIS.this_cCursorItens = "cursor_4c_Itens"

		THIS.this_cEmps = ""
		THIS.this_cDopes = ""
		THIS.this_nNumes = 0
		THIS.this_dDatas = {}
		THIS.this_nValos = 0

		RETURN .T.
	ENDPROC

	*====================================================================
	* GarantirCursorOperacoes - Cria o cursor da grade de movimentacoes
	* se ele ainda nao existir.
	*
	* A estrutura eh declarada em UM UNICO lugar (usado tanto na carga
	* quanto na limpeza) porque cursor de grade criado com ordem de
	* campos diferente em pontos diferentes quebra o APPEND FROM, que
	* casa os campos por NOME. Tipos copiados do schema:
	*   SigMvCab.emps  char(3)  / dopes char(20) / numes numeric(6,0)
	*   SigMvCab.datas datetime / valos numeric(11,2)
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe em
	* ConfigurarGridOperacoes() (Fase 4), antes de CarregarOperacoes()
	* existir (Fase 7-8), para o cursor ja estar criado quando o Grid
	* recebe RecordSource/ControlSource - regra #41 (ControlSource de
	* cursor ainda inexistente derruba o Init).
	*====================================================================
	PROCEDURE GarantirCursorOperacoes()
		IF !USED(THIS.this_cCursorOperacoes)
			SET NULL ON
			CREATE CURSOR (THIS.this_cCursorOperacoes) ( ;
				emps C(3) NULL, ;
				dopes C(20) NULL, ;
				numes N(6,0) NULL, ;
				datas T NULL, ;
				valos N(11,2) NULL)
			SET NULL OFF
		ENDIF
	ENDPROC

	*====================================================================
	* GarantirCursorItens - Cria o cursor da grade de itens se ele ainda
	* nao existir. Tipos copiados do schema:
	*   SigMvItn.cpros char(14) / qtds numeric(9,3)
	*   SigCdPro.dpros char(65)
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe em
	* ConfigurarGridItens() (Fase 4) - mesmo motivo de GarantirCursorOperacoes.
	*====================================================================
	PROCEDURE GarantirCursorItens()
		IF !USED(THIS.this_cCursorItens)
			SET NULL ON
			CREATE CURSOR (THIS.this_cCursorItens) ( ;
				cpros C(14) NULL, ;
				dpros C(65) NULL, ;
				qtds N(9,3) NULL)
			SET NULL OFF
		ENDIF
	ENDPROC

	*====================================================================
	* CarregarOperacoes - Popula a grade de movimentacoes a partir do
	* cursor que o form PAI deixou pronto (this_cCursorOrigem).
	*
	* Equivale a este trecho do Init legado:
	*     Zap In dbOperacao
	*     Select TprMvCab
	*     Scan
	*         Scatter MemVar
	*         Insert Into dbOperacao From MemVar
	*     EndScan
	*     Select dbOperacao
	*     Go Top
	* ... seguido da carga dos itens da PRIMEIRA linha (o legado popula
	* dbItens logo apos o Go Top; o AfterRowColChange so entra em acao
	* quando o usuario muda de linha).
	*
	* NAO re-executa a consulta em SigMvCab: o WHERE do legado vive no
	* form PAI (SigPrPpcBO.ConsultarMovimentacoes - periodo mais os
	* pares GrupoOs/GrupoDs e ContaOs/ContaDs com OR nos DOIS lados,
	* mais Dopes e Emps opcionais). Refazer a consulta aqui com um
	* filtro adivinhado faria esta grade mostrar um conjunto DIFERENTE
	* do que o usuario pediu, sem erro nenhum na tela.
	*
	* O cursor da grade nunca eh fechado nem recriado: ZAP + APPEND
	* FROM preserva estrutura, RecordSource e ControlSource das colunas.
	*====================================================================
	FUNCTION CarregarOperacoes()
		LOCAL loc_lSucesso, loc_cOrigem, loc_oErro

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido = .F.
		loc_lSucesso = .F.
		loc_cOrigem = ALLTRIM(THIS.this_cCursorOrigem)

		TRY
			THIS.GarantirCursorOperacoes()
			THIS.GarantirCursorItens()

			IF !USED(loc_cOrigem)
				THIS.this_cMensagemErro = "O resultado da consulta (" + loc_cOrigem + ;
					") n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
					"vel. Refa" + CHR(231) + "a a pesquisa na tela anterior."
			ELSE
				IF USED("cursor_4c_OperacoesTmp")
					USE IN cursor_4c_OperacoesTmp
				ENDIF

				*-- So as colunas que a grade exibe; o legado copiava o
				*   registro inteiro porque dbOperacao era um DBF com a
				*   mesma estrutura de SigMvCab.
				SELECT emps, dopes, numes, datas, valos ;
					FROM (loc_cOrigem) ;
					ORDER BY emps, dopes, numes ;
					INTO CURSOR cursor_4c_OperacoesTmp READWRITE

				SELECT (THIS.this_cCursorOperacoes)
				ZAP
				APPEND FROM DBF("cursor_4c_OperacoesTmp")

				IF USED("cursor_4c_OperacoesTmp")
					USE IN cursor_4c_OperacoesTmp
				ENDIF

				SELECT (THIS.this_cCursorOperacoes)
				GO TOP

				IF EOF()
					*-- Universo vazio nao eh erro: so deixa a grade de
					*   itens vazia e coerente com a de movimentacoes.
					SELECT (THIS.this_cCursorItens)
					ZAP

					THIS.this_cEmps = ""
					THIS.this_cDopes = ""
					THIS.this_nNumes = 0
					THIS.this_dDatas = {}
					THIS.this_nValos = 0

					loc_lSucesso = .T.
				ELSE
					*-- O resultado da carga dos itens EH o resultado desta
					*   carga: se a consulta dos itens falhar, a tela fica
					*   com a grade de baixo vazia sem motivo aparente, e
					*   devolver .T. aqui esconderia a falha do chamador
					*   (que leria this_cMensagemErro ja preenchido).
					loc_lSucesso = THIS.CarregarItensDaOperacaoCorrente()
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro em CarregarOperacoes")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Le a linha CORRENTE do cursor informado para as
	* propriedades da movimentacao selecionada.
	*
	* Padrao canonico: SELECT (par_cAliasCursor) ANTES de acessar os
	* campos, acesso aos campos SEM prefixo de alias, e cada campo
	* protegido por TYPE() porque o mesmo metodo atende tanto o cursor
	* da grade (5 colunas) quanto o cursor de origem TprMvCab, que eh um
	* SELECT * de SigMvCab com 158 colunas.
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe, e
	* metodo PROTECTED chamado de fora estoura "Property ... is not
	* found" em runtime.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), ;
			ALLTRIM(THIS.this_cCursorOperacoes))

		TRY
			IF USED(loc_cAlias)
				SELECT (loc_cAlias)

				IF !EOF() AND !BOF()
					IF TYPE(loc_cAlias + ".emps") != "U"
						THIS.this_cEmps = TratarNulo(emps, "")
					ENDIF
					IF TYPE(loc_cAlias + ".dopes") != "U"
						THIS.this_cDopes = TratarNulo(dopes, "")
					ENDIF
					IF TYPE(loc_cAlias + ".numes") != "U"
						THIS.this_nNumes = TratarNulo(numes, 0)
					ENDIF
					IF TYPE(loc_cAlias + ".datas") != "U"
						THIS.this_dDatas = TratarNulo(datas, {})
					ENDIF
					IF TYPE(loc_cAlias + ".valos") != "U"
						THIS.this_nValos = TratarNulo(valos, 0)
					ENDIF

					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Nenhuma movimenta" + CHR(231) + CHR(227) + ;
						"o selecionada."
				ENDIF
			ELSE
				THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + ;
					"o est" + CHR(225) + " aberto."
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarItensDaOperacaoCorrente - Le a linha corrente da grade de
	* movimentacoes e recarrega a grade de itens com os produtos daquela
	* movimentacao.
	*
	* Equivale ao grd_operacoes.AfterRowColChange do legado (Zap In
	* dbItens, Seek na chave da linha corrente de dbOperacao e Scan
	* While a chave bater). Publico porque quem dispara eh o handler do
	* proprio Grid, no Form.
	*====================================================================
	FUNCTION CarregarItensDaOperacaoCorrente()
		LOCAL loc_lSucesso

		loc_lSucesso = .F.

		IF THIS.CarregarDoCursor(THIS.this_cCursorOperacoes)
			loc_lSucesso = THIS.CarregarItensPorChave(THIS.this_cEmps, ;
				THIS.this_cDopes, THIS.this_nNumes)
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarItensPorChave - Popula a grade de itens com os produtos
	* (SigMvItn) da movimentacao Emps + Dopes + Numes informada.
	*
	* A descricao do produto vem SEMPRE do cadastro atual (SigCdPro),
	* nunca da descricao historica gravada no item. Eh exatamente o que
	* o legado faz:
	*     poDataMgr.CursorQuery("SigCdPro", "crSigCdPro", "CPros", ...)
	*     m.DPros = Iif(Eof("crSigCdPro"), "", crSigCdPro.DPros)
	* ou seja, produto que saiu do cadastro aparece com a descricao EM
	* BRANCO. O LEFT JOIN com ISNULL(b.dpros, "") reproduz os dois casos
	* (ISNULL aqui eh a funcao do SQL Server, dentro da string SQL).
	*
	* As tres colunas sao comparadas SEPARADAMENTE, e nao pela chave
	* concatenada empdopnums char(29) que o legado usava: char no SQL
	* Server compara com preenchimento de brancos, entao a igualdade por
	* coluna eh equivalente e dispensa reproduzir o alinhamento
	* posicional 3 + 20 + 6 - onde um ALLTRIM a mais devolveria zero
	* linha em silencio.
	*====================================================================
	FUNCTION CarregarItensPorChave(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lProsseguir, loc_oErro

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.
		loc_lProsseguir = .T.

		IF VARTYPE(par_cEmps) != "C" OR VARTYPE(par_cDopes) != "C" OR ;
		   VARTYPE(par_nNumes) != "N"
			THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + ;
				"o inv" + CHR(225) + "lida."
			loc_lProsseguir = .F.
		ENDIF

		IF loc_lProsseguir AND (TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0)
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel."
			loc_lProsseguir = .F.
		ENDIF

		IF loc_lProsseguir
			TRY
				THIS.GarantirCursorItens()

				loc_cSQL = "SELECT a.cpros, ISNULL(b.dpros, '') AS dpros, a.qtds" + ;
					" FROM SigMvItn a" + ;
					" LEFT JOIN SigCdPro b ON b.cpros = a.cpros" + ;
					" WHERE a.emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ;
					" AND a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
					" AND a.numes = " + FormatarNumeroSQL(par_nNumes, 0) + ;
					" ORDER BY a.cpros"

				IF USED("cursor_4c_ItensTmp")
					USE IN cursor_4c_ItensTmp
				ENDIF

				*-- SQLEXEC sempre em cursor TEMPORARIO: executado sobre o
				*   alias da grade, ele fecharia e recriaria esse alias,
				*   zerando ColumnCount/RecordSource e deixando a grade
				*   como um retangulo branco pelo resto da vida do form.
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTmp")

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Erro ao buscar os itens da movimenta" + ;
						CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ELSE
					SELECT (THIS.this_cCursorItens)
					ZAP
					APPEND FROM DBF("cursor_4c_ItensTmp")

					SELECT (THIS.this_cCursorItens)
					GO TOP

					loc_lSucesso = .T.
				ENDIF

				IF USED("cursor_4c_ItensTmp")
					USE IN cursor_4c_ItensTmp
				ENDIF
			CATCH TO loc_oErro
				THIS.this_cMensagemErro = loc_oErro.Message
				MsgErro(loc_oErro.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
					"Procedure: " + loc_oErro.Procedure, "Erro em CarregarItensPorChave")
				THIS.this_lErroExibido = .T.
				loc_lSucesso = .F.
			ENDTRY
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* MontarChaveEmpDopNums - Chave POSICIONAL de 29 caracteres que o
	* sistema materializa na coluna empdopnums char(29) de SigMvCab e
	* SigMvItn, e que o legado monta como
	*     TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes, 6)
	*
	* O preenchimento FAZ PARTE da chave: emps char(3) + dopes char(20)
	* + Str(numes, 6) = 29. Usar ALLTRIM nas partes encurtaria a chave e
	* ela nunca casaria - a consulta rodaria sem erro e devolveria zero
	* linha. Por isso o PADR explicito, com as larguras do schema.
	*====================================================================
	FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cEmps, loc_cDopes, loc_nNumes

		loc_cEmps = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
		loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
		loc_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)

		RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)
	ENDFUNC

	*====================================================================
	* ObterChavePrimaria - Chave da movimentacao selecionada, no mesmo
	* formato da coluna empdopnums char(29).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, ;
			THIS.this_nNumes)
	ENDPROC

	*====================================================================
	* LimparDados - Zera filtros, linha selecionada e as duas grades. As
	* grades sao esvaziadas com ZAP (nunca fechadas), para o Grid nao
	* perder RecordSource nem ControlSource.
	*====================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_cGrupo = ""
		THIS.this_cConta = ""
		THIS.this_cContaDesc = ""
		THIS.this_dDataInicial = {}
		THIS.this_dDataFinal = {}

		THIS.this_cEmps = ""
		THIS.this_cDopes = ""
		THIS.this_nNumes = 0
		THIS.this_dDatas = {}
		THIS.this_nValos = 0

		THIS.GarantirCursorOperacoes()
		SELECT (THIS.this_cCursorOperacoes)
		ZAP

		THIS.GarantirCursorItens()
		SELECT (THIS.this_cCursorItens)
		ZAP

		RETURN .T.
	ENDPROC

	*====================================================================
	* Destroy - Fecha os cursores criados por ESTE BO. O cursor de
	* origem (TprMvCab) pertence ao form pai e eh fechado por ele.
	*====================================================================
	PROCEDURE Destroy()
		IF USED("cursor_4c_OperacoesTmp")
			USE IN cursor_4c_OperacoesTmp
		ENDIF
		IF USED("cursor_4c_ItensTmp")
			USE IN cursor_4c_ItensTmp
		ENDIF
		IF USED(THIS.this_cCursorItens)
			USE IN (THIS.this_cCursorItens)
		ENDIF
		IF USED(THIS.this_cCursorOperacoes)
			USE IN (THIS.this_cCursorOperacoes)
		ENDIF

		DODEFAULT()
	ENDPROC

ENDDEFINE

