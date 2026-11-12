# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-11 21:04:10] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-11 21:04:10] [INFO] Config FPW: (nao fornecido)
[2026-11-11 21:04:10] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-11 21:04:10] [INFO] Timeout: 300 segundos
[2026-11-11 21:04:10] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gvgpfiol.prg
[2026-11-11 21:04:10] [INFO] Conteudo do wrapper:
[2026-11-11 21:04:10] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpPcu', 'C:\4c\tasks\task777\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpPcu', 'C:\4c\tasks\task777\logs\06_testForm.log'
QUIT

[2026-11-11 21:04:10] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gvgpfiol.prg
[2026-11-11 21:04:10] [INFO] VFP output esperado em: C:\4c\tasks\task777\vfp_output.txt
[2026-11-11 21:04:10] [INFO] Executando Visual FoxPro 9...
[2026-11-11 21:04:10] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gvgpfiol.prg
[2026-11-11 21:04:10] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gvgpfiol.prg
[2026-11-11 21:04:10] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpPcu
Inicio: 11/11/2026 21:04:10

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
OK - Objeto criado com sucesso
     Tipo: O
     Classe: Formsigoppcu

[ETAPA 3] Mostrando formulario (nao-modal)...
ERRO - Excecao ao mostrar formulario:
     Mensagem: Property WINDOWTYPE is read-only.

=== RESULTADO DO TESTE ===
Fim: 11/11/2026 21:04:29
Duracao: 19 segundos
Return Code: 2
Status: ERRO AO MOSTRAR FORM

===========================
[2026-11-11 21:04:29] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-11 21:04:29] [INFO] VFP9 finalizado em 19.443686 segundos
[2026-11-11 21:04:29] [INFO] Exit Code: 
[2026-11-11 21:04:29] [INFO] 
[2026-11-11 21:04:29] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-11 21:04:29] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gvgpfiol.prg
[2026-11-11 21:04:29] [INFO] 
[2026-11-11 21:04:29] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-11 21:04:29] [INFO] * Auto-generated wrapper for parameters
[2026-11-11 21:04:29] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-11 21:04:29] [INFO] * Parameters: 'FormSigOpPcu', 'C:\4c\tasks\task777\logs\06_testForm.log'
[2026-11-11 21:04:29] [INFO] 
[2026-11-11 21:04:29] [INFO] * Anti-dialog protections for unattended execution
[2026-11-11 21:04:29] [INFO] SET SAFETY OFF
[2026-11-11 21:04:29] [INFO] SET RESOURCE OFF
[2026-11-11 21:04:29] [INFO] SET TALK OFF
[2026-11-11 21:04:29] [INFO] SET NOTIFY OFF
[2026-11-11 21:04:29] [INFO] SYS(2335, 0)
[2026-11-11 21:04:29] [INFO] 
[2026-11-11 21:04:29] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpPcu', 'C:\4c\tasks\task777\logs\06_testForm.log'
[2026-11-11 21:04:29] [INFO] QUIT
[2026-11-11 21:04:29] [INFO] 
[2026-11-11 21:04:29] [INFO] === Fim do Wrapper.prg ===
[2026-11-11 21:04:29] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPcu.prg):
*==============================================================================
* FormSigOpPcu.prg - Planilha de Custo
* Origem: SIGOPPCU.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL (dialogo modal filho, aberto pelo SIGCDPRO/FormProduto)
*       Aberto pelo form pai com: CREATEOBJECT("FormSigOpPcu", oFormPai, nDataSes, cTipo)
*       DataSession=1: acessa o cursor local do pai (csGrade) na DataSession
*       dele via "SET DATASESSION TO" (mesma tecnica de FormDCC).
* Layout: Flat (sem PageFrame) - legado nao tem PageFrame, so um container
*       unico (Cnt_Planilha) com a faixa de cabecalho, a grade e o botao
*       Encerrar.
*
* CONTRATO EXTERNO (importante para ler ConfigurarGrade/VincularGrade):
*   A grade NAO se liga a um cursor desta tela: ela se liga a "csGrade", que
*   eh um cursor LOCAL do form CHAMADOR (SIGCDPRO/FormProduto) e vive na
*   DataSession dele - este dialogo apenas entra naquela DataSession
*   ("SET DATASESSION TO" no Init) e edita o mesmo cursor em memoria.
*   Consequencias de projeto:
*     - o bind (RecordSource + ControlSource) NAO pode acontecer em tempo de
*       construcao: o alias pode nem existir quando a tela se monta, e
*       Column.ControlSource de alias inexistente estoura "Alias is not found"
*       DENTRO do TRY de InicializarForm, matando a tela inteira (regra #41).
*       Por isso ConfigurarGrade() carrega SO o que nao depende de dado e o
*       bind mora em VincularGrade(), condicionado a USED(alias);
*     - Destroy NAO fecha csGrade: o cursor eh do chamador, que continua
*       precisando dele depois deste dialogo fechar. MEDIDO no dump do pai
*       (tasks/task003/sigcdpro_form_codigo_fonte.txt:20840): quem alimenta
*       o "Insert Into CrSigPrFtp" eh o SCAN do PROPRIO csGrade por
*       AltCoef = 1 - nao o crPrFtp que esta tela monta.
*
* Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: ja entregues, e a ausencia dos
* quatro nomes CRUD foi MEDIDA no dump, nao presumida.
*
*   (a) O QUE O LEGADO TEM DE BOTAO - exatamente UM. Contado no dump
*       (tasks\task777\SigOpPcu_form_codigo_fonte.txt): 1 objeto com
*       "BaseClass: commandbutton" (cmdSair, classe fwbtng) e ZERO objeto com
*       "BaseClass: commandgroup". O dump declara 12 metodos com codigo
*       (rodape confirma), e um unico "PROCEDURE Click" - o do proprio
*       cmdSair.
*
*   (b) O QUE O LEGADO NAO TEM - zero evidencia de CRUD, nas tres vias
*       independentes, medidas sobre o mesmo dump:
*
*         ESTRUTURAL : "frmcadastro" 0, "frmrelatorio" 0, "Grupo_Op" 0 e
*                      "pcEscolha" 0 - o form e "Class: form" PURO, com
*                      "WindowType = 1" e SEM PageFrame (layout FLAT, um
*                      unico container Cnt_Planilha).
*         NOME       : "Incluir" 0, "Alterar" 0, "Visualizar" 0, "Excluir" 0
*                      e "Inserir" 0 - nem a barra CRUD do frmcadastro nem a
*                      toolbar de LINHA de grade existem.
*         CHAMADA    : nenhum "<X>.Click" com X em Incluir/Alterar/
*                      Visualizar/Excluir - o unico .Click do dump e o do
*                      proprio cmdSair.
*
*       Por isso NAO existem aqui BtnIncluirClick/BtnAlterarClick/
*       BtnVisualizarClick/BtnExcluirClick: criar os quatro violaria o
*       PILAR 1 (inventa botao que o usuario do legado nunca teve) e, com
*       corpo vazio, violaria a regra de completude. Mesma decisao e mesmo
*       motivo do precedente SIGOPCLP -> FormSigOpClp (task704: grade de 7
*       colunas + UM botao Encerrar) e SIGOPDVM -> FormSIGOPDVM (task726) -
*       esta tela e o mesmo padrao, so com mais colunas editaveis.
*
*   (c) O UNICO EVENTO DE BOTAO QUE EXISTE JA ESTA PORTADO - cmdSair.Click ->
*       BtnEncerrarClick, com BINDEVENT no fim de ConfigurarBotaoEncerrar,
*       escrito em fase anterior. Os cinco pontos conferem:
*         1. BtnEncerrarClick e PUBLIC (sem PROTECTED) - BINDEVENT em metodo
*            PROTECTED falha EM SILENCIO (regra #3);
*         2. o delegate EXISTE com o nome exato passado ao BINDEVENT;
*         3. o BINDEVENT vem DEPOIS do AddObject do botao, no fim do metodo;
*         4. THIS.Hide() (nao Release()) e a traducao certa AQUI porque esta
*            tela DEVOLVE resultado ao chamador (crPrFtp, via
*            MontarCursorAlterados) e e aberta com CREATEOBJECT + Show() -
*            Release() destruiria o objeto antes do chamador poder ler o
*            cursor (regra do FormSigOpCtd/task715, mesma familia do
*            FormBuscaAuxiliar);
*         5. o ESC nao precisa de segundo handler - cmd_4c_Encerrar tem
*            Cancel = .T. transcrito do dump, e a tecla de cancelamento
*            dispara o mesmo Click interceptado pelo BINDEVENT.
*
*   (d) NAO ha outro evento de botao a portar. O dump nao tem CommandGroup
*       nem segundo CommandButton. O "Load" ("=fConfigGeral()") segue NAO
*       PORTADO: fConfigGeral era inicializacao GLOBAL da aplicacao Fortyus,
*       e utils\fconfiggeral.prg e um wrapper NO-OP que existe apenas para o
*       p-code dos VCX legado - precedente registrado em FormSigMvExp,
*       FormSigMvMen, FormSigPrTar, Formsigprtam, FormSIGPRVTX, FormSIGPRMEI
*       e FormSIGOPDVM.
*
* Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO: a fase cobra, por convencao de
* form CRUD, os nomes Btn<Cancelar>Click, FormPara<BO>, <BO>ParaForm, Carregar<Lista>,
* HabilitarCampos, LimparCampos, AjustarBotoesPorModo e BtnBuscarClick. Nenhum
* deles tem REFERENTE neste legado, e cada ausencia foi MEDIDA no dump, nao
* presumida:
*
*   Btn<Cancelar>Click      - eh o "Cancelar" que ABANDONA uma edicao na Page2
*                           de Dados do frmcadastro. Nao ha PageFrame, nem
*                           Page2, nem modo de edicao: o dump tem UM unico
*                           CommandButton (cmdSair, Caption "Encerrar") e ele
*                           nao abandona nada - monta o cursor de resultado
*                           para o pai e fecha. Renomear BtnEncerrarClick para
*                           "Cancelar" faria o nome MENTIR sobre o que o
*                           metodo faz.
*   Btn<Salvar>Click e os   - nao ha o que GRAVAR aqui. Esta tela nao escreve em
*   irmaos Confirmar/       tabela nenhuma: as unicas escritas do dump sao
*   Gravar/Processa         REPLACE no cursor csGrade, que eh do CHAMADOR, e o
*                           "Select ... Into Cursor crPrFtp" do cmdSair. Quem
*                           persiste em sigprftp eh o form PAI, DEPOIS de ler
*                           crPrFtp. Criar um botao de gravar aqui inventaria
*                           superficie que o usuario do legado nunca teve.
*   FormPara<BO>            - sentido CAMPO -> BO. A unica celula digitavel
*                           (Column4, o coeficiente) escreve DIRETO no cursor
*                           csGrade pelo ControlSource, e o valor novo chega ao
*                           BO como ARGUMENTO de RecalcularCoeficiente(), nao
*                           por mapeamento generico de campos. O unico controle
*                           de dados fora da grade (txt_4c_Adicional) eh
*                           ReadOnly no proprio dump - nunca ha o que ler dele.
*   <BO>ParaForm            - sentido BO -> CAMPO. A grade le o cursor DIRETO
*                           (RecordSource + sete ControlSource, ver
*                           VincularGrade) e o unico campo que o codigo
*                           escreve eh o total do rodape, espelhado por
*                           AtualizarTotalAdicional() a partir de
*                           this_nTotalAdicional - fonte unica, no BO.
*   Carregar<Lista>         - a carga da grade EXISTE e eh obrigatoria; o que
*                           nao existe eh o NOME canonico de uma lista CRUD
*                           independente. Aqui ela eh o funil CarregarDados(),
*                           que reproduz o bloco final do Init legado
*                           (Set Key To / Sum Valos / Goto Top / bind /
*                           Refresh) e eh chamado em TODO caminho que mexe no
*                           cursor ou na chave. Manter o nome CarregarDados eh
*                           deliberado: TesteAutomatico.prg classifica como
*                           OPERACIONAL justamente o form que NAO tem
*                           Carregar<Lista> nem AlternarPagina, e batizar o funil
*                           com o nome CRUD jogaria esta tela no caminho de
*                           teste de cadastro, que procura cursor_4c_Dados -
*                           cursor que esta tela nao tem nem deve ter (a grade
*                           se liga a csGrade, do chamador).
*   HabilitarCampos e     - sao o par INCLUIR/ALTERAR x VISUALIZAR do
*   AjustarBotoesPorModo    frmcadastro. Esta tela nao tem modo: o que decide
*                           se a celula do coeficiente aceita digitacao eh o
*                           "When" da coluna, que nao depende de modo algum e
*                           sim do tipo da planilha mais o acesso do usuario -
*                           ja portado em AplicarTravasDeColuna(), chamado no
*                           fim de VincularGrade().
*   LimparCampos          - zera a ficha de Dados entre um registro e outro. O
*                           dialogo vive UM produto, recebido do chamador, e
*                           fecha; nao ha ficha nem troca de registro.
*   BtnBuscarClick        - nao ha busca: o conteudo da grade ja vem pronto do
*                           chamador, e o unico "filtro" eh o Set Key To pelo
*                           tipo da planilha, aplicado na carga.
*==============================================================================
DEFINE CLASS FormSigOpPcu AS FormBase

    this_cMensagemErro = ""
    Width       = 1000
    Height      = 600
    Caption     = "Planilha de Custo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    DataSession = 1

    *-- Janela SEM barra de titulo e SEM caixa de controle, transcritas do
    *-- bloco "PROPRIEDADES DE: SIGOPPCU" do dump (BorderStyle = 2,
    *-- ControlBox = .F., TitleBar = 0, ClipControls = .F.). Nao sao detalhe
    *-- cosmetico: sem elas o migrado ganha uma barra de titulo com o "X",
    *-- isto eh uma SAIDA que o legado nao tem e que NAO passa pelo funil
    *-- FecharDialogo() - fechando por ali, MontarCursorAlterados() nunca
    *-- roda, crPrFtp nao eh montado e o form pai (SIGCDPRO/FormProduto)
    *-- recebe a planilha como se nada tivesse sido alterado, sem erro e sem
    *-- log. Com o "X" fora, a UNICA saida volta a ser cmd_4c_Encerrar - que
    *-- tem Cancel = .T. e portanto atende tambem o ESC -, exatamente como no
    *-- legado; o usuario nao fica sem saida (o risco inverso, de tirar a
    *-- unica saida da tela).
    *-- Mesmo par ja transcrito nos dialogos filhos irmaos: FormSigOpLrC,
    *-- FormDCC, FormSigOpClp e FormSIGOPDVM.
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    ClipControls = .F.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Referencia ao form pai (SIGCDPRO/FormProduto) - habilitado no Destroy
    this_oParentForm = .NULL.

    *-- DataSession do form pai (legado: pnDataSes) - csGrade vive la
    this_nDataSessionPai = 0

    *-- Tipo da planilha (legado: pTipo) - "C" = Fator/Custo, "V" = Venda
    this_cTipo = "C"

    *==========================================================================
    * Init - Recebe parametros do form pai e troca para a DataSession dele
    * par_oParentForm : referencia ao form pai (SIGCDPRO/FormProduto)
    * par_nDataSes    : DataSession do pai, onde vive o cursor csGrade
    * par_cTipo       : "C" (Fator/Custo) ou "V" (Venda)
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_nDataSes, par_cTipo

        LOCAL loc_oErro
        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
            ENDIF

            THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSes) = "N", par_nDataSes, 0)
            THIS.this_cTipo           = IIF(VARTYPE(par_cTipo) = "C" AND !EMPTY(par_cTipo), par_cTipo, "C")

            IF THIS.this_nDataSessionPai > 0
                SET DATASESSION TO (THIS.this_nDataSessionPai)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object e a estrutura visual base
    * (container principal + faixa de cabecalho). Chamado automaticamente
    * por FormBase.Init() via DODEFAULT().
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpPcuBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object SigOpPcuBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro")
            ELSE
                THIS.this_oBusinessObject.this_cTipo           = THIS.this_cTipo
                THIS.this_oBusinessObject.this_nDataSessionPai = THIS.this_nDataSessionPai

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c__Planilha.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c__Planilha.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- SO AGORA os titulos que dependem de dado (ver
                *-- AtualizarTitulos): no legado a faixa do cabecalho recebe o
                *-- Caption ORIGINAL e so DEPOIS o Caption do form passa a ser
                *-- o produto em edicao - invertido, a faixa cinza exibiria o
                *-- codigo do produto, que o legado nao exibe.
                THIS.AtualizarTitulos()

                THIS.TornarControlesVisiveis(THIS)

                *-- Carga da grade pelo FUNIL unico (ver CarregarDados): liga
                *-- a grade ao cursor do chamador, aplica o filtro do tipo e
                *-- repinta. Devolver .F. aqui eh esperado quando a tela eh
                *-- instanciada SEM chamador (harness de teste), e por isso o
                *-- resultado NAO entra em loc_lSucesso: a tela abre igual.
                THIS.CarregarDados()

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de layout base
    * SIGOPPCU original eh flat OPERACIONAL (sem PageFrame nativo - um unico
    * container Cnt_Planilha). Este metodo agrupa a montagem do layout base.
    *
    * A ORDEM de criacao eh a do SCX legado dentro de Cnt_Planilha
    * (cntSombra -> grdGrade -> Label1 -> Get_Adicional -> cmdSair) e importa
    * por DOIS motivos:
    *   - cmd_4c_Encerrar fica em Top = 3, isto eh DENTRO da area da faixa do
    *     cabecalho (Top 0..80), e so desenha por cima dela se for criado
    *     DEPOIS (regra #11);
    *   - a ordem de criacao EH a ordem de tabulacao efetiva do legado (ver
    *     AplicarOrdemTabulacao, que mede o descarte do TabIndex = 18 do
    *     dump), entao trocar a posicao de um Configurar* aqui muda a
    *     sequencia do Tab em silencio.
    * A grade (Top = 130) nao toca a faixa, mas segue a mesma ordem do dump
    * por fidelidade.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrade()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarBotaoEncerrar()

        *-- Depois de TODOS os AddObject da tela: TabIndex atribuido antes do
        *-- controle existir estoura, e AddObject renumera o que vier depois.
        THIS.AplicarOrdemTabulacao()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria o container principal (legado: Cnt_Planilha)
    * e, dentro dele, a faixa de cabecalho (legado: cntSombra + lblSombra +
    * lblTitulo). Posicoes/tamanhos transcritos do dump do legado.
    *
    * O Picture do container eh o FUNDO da tela inteira (o legado declara
    * "Cnt_Planilha.Picture = ..\framework\imagens\new_background.jpg", e o
    * container cobre 999x600 sobre um form 1000x600). Sem ele a tela abre
    * cinza-liso: .Picture inexistente ou ausente nao gera erro nenhum em
    * VFP9, o controle so nao desenha a imagem (regra #25), por isso o nome do
    * arquivo eh TRANSCRITO do dump e nao escolhido por semelhanca. O caminho
    * usa gc_4c_CaminhoFramework, NUNCA gc_4c_CaminhoBase + "Framework\..."
    * (que resolveria para start\Framework\, inexistente).
    *
    * BackStyle = 1 eh o default da base class Container, que eh o valor FIEL
    * (o dump nao declara BackStyle) e eh o que faz o Picture valer como fundo
    * opaco da area. SpecialEffect = 0 tambem vem do dump.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        *-- Container principal (legado: Cnt_Planilha, Top=0 Left=0 W=999 H=600)
        THIS.AddObject("cnt_4c__Planilha", "Container")
        WITH THIS.cnt_4c__Planilha
            .Top           = 0
            .Left          = 0
            .Width         = 999
            .Height        = 600
            .BackStyle     = 1
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Picture       = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
            .Visible       = .T.
        ENDWITH

        *-- Faixa do cabecalho (legado: cntSombra, dentro de Cnt_Planilha)
        THIS.cnt_4c__Planilha.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c__Planilha.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.cnt_4c__Planilha.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c__Planilha.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c__Planilha.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top       = 25
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .T.
            .Alignment = 0
            .Caption   = "Planilha de Custo"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Planilha.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c__Planilha.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 24
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .Caption     = "Planilha de Custo"
            .FontName    = "Tahoma"
            .FontSize    = 16
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            *-- ToolTipText do dump (lblTitulo) - unico dos dois labels que tem
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - grd_4c_Dados (mapeamento.json: SIGOPPCU.Cnt_Planilha.
    * grdGrade), a grade da planilha de custo. Filha de cnt_4c__Planilha,
    * como no legado.
    *
    * Geometria e colunas transcritas do dump (tasks\task777\
    * SigOpPcu_form_codigo_fonte.txt, secao "SIGOPPCU.Cnt_Planilha.grdGrade"):
    *
    *     grdGrade: Top=130 Left=5 Width=989 Height=442, ColumnCount=7,
    *               FontName="Tahoma" FontSize=8, HeaderHeight=16,
    *               RowHeight=16, ScrollBars=2, ReadOnly=.F.,
    *               DeleteMark=.F., AllowHeaderSizing=.T.,
    *               AllowRowSizing=.T., GridLineColor=(238,238,238)
    *     Column1 "Codigo"     Width=120  (csGrade.Cpros)
    *     Column2 "Descricao"  Width=280  (csGrade.Dpros)
    *     Column3 "Total (a)"  Width=90   InputMask="999,999.999"
    *     Column4 "Coef./(%)"  Width=73   InputMask="999.9999"   <- EDITAVEL
    *     Column5 "Valor (b)"  Width=90   InputMask="999,999.999"
    *     Column6 "Total (a+b)" Width=90  InputMask="999,999.999"
    *     Column7 "Acumulado"  Width=100  InputMask="99,999,999.999"
    *
    * Tres propriedades do dump NAO sao transcritas, de proposito:
    *   - ZOrderSet = 20: nao existe em runtime em classe nenhuma, eh
    *     bookkeeping do Form Designer gravado no SCX (regra #33);
    *   - TabIndex = 18: TabIndex fora da faixa 1..N eh descartado em
    *     silencio, entao a ordem de tabulacao so pode ser numerada depois do
    *     ULTIMO AddObject da tela, num metodo proprio;
    *   - Column3.ColumnOrder = 3: ja eh a posicao natural da coluna, logo
    *     atribui-la eh inerte e so arrisca reordenar a grade.
    *
    * RecordMark = .F. acompanha o DeleteMark = .F. do dump: eh regra do
    * projeto para Grid criado por AddObject em form OPERACIONAL (sem isso
    * aparece a barra de marcacao lateral que o legado nao tem).
    *
    * AQUI ficam SO as propriedades que NAO dependem de dado (regra #41):
    * geometria, ColumnCount, Movable/Resizable, fontes, cores e InputMask. O
    * bind - RecordSource, os sete ControlSource, as larguras, os
    * Header1.Caption e o DynamicForeColor - mora em VincularGrade(), porque
    * o alias eh do form CHAMADOR (ver "CONTRATO EXTERNO" no cabecalho) e
    * porque atribuir RecordSource RESETA Column.Width e Header1.Caption -
    * esses dois tem de ser reaplicados DEPOIS do bind, nunca antes.
    *
    * O ReadOnly = .F. de cada coluna eh o valor literal do dump; a trava de
    * verdade das colunas que o usuario nao digita vem do "When" delas (todas
    * fazem "RETURN .F.", menos a Column4) e eh aplicada por
    * AplicarTravasDeColuna(), chamado no fim de VincularGrade.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oCnt

        loc_oCnt = THIS.cnt_4c__Planilha
        loc_oCnt.AddObject("grd_4c_Dados", "Grid")

        WITH loc_oCnt.grd_4c_Dados
            .Top               = 130
            .Left              = 5
            .Width             = 989
            .Height            = 442
            .ColumnCount       = 7
            .HeaderHeight      = 16
            .RowHeight         = 16
            .ScrollBars        = 2
            .ReadOnly          = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .AllowHeaderSizing = .T.
            .AllowRowSizing    = .T.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.
        ENDWITH

        *-- Column1 - "Codigo" (csGrade.Cpros). Sem InputMask no dump.
        WITH loc_oCnt.grd_4c_Dados.Column1
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Movable            = .F.
            .Resizable          = .F.
            .ReadOnly           = .F.
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Header1.Alignment  = 2
            .Header1.ForeColor  = RGB(0, 0, 0)
            .Text1.FontName     = "Tahoma"
            .Text1.FontSize     = 8
            .Text1.BorderStyle  = 0
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .F.
            .Text1.ForeColor    = RGB(0, 0, 0)
            .Text1.BackColor    = RGB(255, 255, 255)
        ENDWITH

        *-- Column2 - "Descricao" (csGrade.Dpros). Sem InputMask no dump.
        WITH loc_oCnt.grd_4c_Dados.Column2
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Movable            = .F.
            .Resizable          = .F.
            .ReadOnly           = .F.
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Header1.Alignment  = 2
            .Header1.ForeColor  = RGB(0, 0, 0)
            .Text1.FontName     = "Tahoma"
            .Text1.FontSize     = 8
            .Text1.BorderStyle  = 0
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .F.
            .Text1.ForeColor    = RGB(0, 0, 0)
            .Text1.BackColor    = RGB(255, 255, 255)
        ENDWITH

        *-- Column3 - "Total (a)" (csGrade.Totas). O dump declara o InputMask
        *-- nos DOIS niveis (Column e Text1) - transcrever os dois.
        WITH loc_oCnt.grd_4c_Dados.Column3
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Movable            = .F.
            .Resizable          = .F.
            .ReadOnly           = .F.
            .InputMask          = "999,999.999"
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Header1.Alignment  = 2
            .Header1.ForeColor  = RGB(0, 0, 0)
            .Text1.FontName     = "Tahoma"
            .Text1.FontSize     = 8
            .Text1.BorderStyle  = 0
            .Text1.InputMask    = "999,999.999"
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .F.
            .Text1.ForeColor    = RGB(0, 0, 0)
            .Text1.BackColor    = RGB(255, 255, 255)
        ENDWITH

        *-- Column4 - "Coef. / (%)" (csGrade.Coefs). E a UNICA coluna que o
        *-- usuario digita, e por isso a unica cujo When do legado nao eh
        *-- "RETURN .F." - ver AplicarTravasDeColuna(). O par GotFocus/Valid
        *-- do legado (guarda o valor ao entrar, recalcula ao sair) eh
        *-- reproduzido com BINDEVENT direto no Text1 NATIVO da coluna, nas
        *-- duas pontas que sao confiaveis via BINDEVENT em TextBox
        *-- (GotFocus e LostFocus - "Valid" literal nao eh, por isso
        *-- LostFocus faz o papel do Column4.Valid legado aqui; padrao ja
        *-- usado em FormPzo/Formsigmvcot). O BINDEVENT fica no FIM do bloco,
        *-- com o objeto ja criado.
        WITH loc_oCnt.grd_4c_Dados.Column4
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Movable            = .F.
            .Resizable          = .F.
            .ReadOnly           = .F.
            .InputMask          = "999.9999"
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Header1.Alignment  = 2
            .Header1.ForeColor  = RGB(0, 0, 0)
            .Text1.FontName     = "Tahoma"
            .Text1.FontSize     = 8
            .Text1.BorderStyle  = 0
            .Text1.InputMask    = "999.9999"
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .F.
            .Text1.ForeColor    = RGB(0, 0, 0)
            .Text1.BackColor    = RGB(255, 255, 255)
        ENDWITH

        BINDEVENT(loc_oCnt.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "GridCoefGotFocus")
        BINDEVENT(loc_oCnt.grd_4c_Dados.Column4.Text1, "LostFocus", THIS, "GridCoefLostFocus")

        *-- Column5 - "Valor (b)" (csGrade.Valos)
        WITH loc_oCnt.grd_4c_Dados.Column5
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Movable            = .F.
            .Resizable          = .F.
            .ReadOnly           = .F.
            .InputMask          = "999,999.999"
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Header1.Alignment  = 2
            .Header1.ForeColor  = RGB(0, 0, 0)
            .Text1.FontName     = "Tahoma"
            .Text1.FontSize     = 8
            .Text1.BorderStyle  = 0
            .Text1.InputMask    = "999,999.999"
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .F.
            .Text1.ForeColor    = RGB(0, 0, 0)
            .Text1.BackColor    = RGB(255, 255, 255)
        ENDWITH

        *-- Column6 - "Total (a+b)" (csGrade.totalG)
        WITH loc_oCnt.grd_4c_Dados.Column6
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Movable            = .F.
            .Resizable          = .F.
            .ReadOnly           = .F.
            .InputMask          = "999,999.999"
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Header1.Alignment  = 2
            .Header1.ForeColor  = RGB(0, 0, 0)
            .Text1.FontName     = "Tahoma"
            .Text1.FontSize     = 8
            .Text1.BorderStyle  = 0
            .Text1.InputMask    = "999,999.999"
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .F.
            .Text1.ForeColor    = RGB(0, 0, 0)
            .Text1.BackColor    = RGB(255, 255, 255)
        ENDWITH

        *-- Column7 - "Acumulado" (csGrade.Acumulas)
        WITH loc_oCnt.grd_4c_Dados.Column7
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Movable            = .F.
            .Resizable          = .F.
            .ReadOnly           = .F.
            .InputMask          = "99,999,999.999"
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Header1.Alignment  = 2
            .Header1.ForeColor  = RGB(0, 0, 0)
            .Text1.FontName     = "Tahoma"
            .Text1.FontSize     = 8
            .Text1.BorderStyle  = 0
            .Text1.InputMask    = "99,999,999.999"
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .F.
            .Text1.ForeColor    = RGB(0, 0, 0)
            .Text1.BackColor    = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * VincularGrade - liga grd_4c_Dados ao cursor csGrade do form CHAMADOR
    *
    * Equivale ao bloco que o Init legado executa em tempo de abertura:
    *
    *     With Thisform.Cnt_Planilha.GrdGrade
    *         .RecordSource          = 'CsGrade'
    *         .Column1.ControlSource = 'CsGrade.Cpros'
    *         .Column2.ControlSource = 'CsGrade.Dpros'
    *         .Column3.ControlSource = 'CsGrade.Totas'
    *         .Column4.ControlSource = 'CsGrade.Coefs'
    *         .Column5.ControlSource = 'CsGrade.Valos'
    *         .Column6.ControlSource = 'CsGrade.totalG'
    *         .Column7.ControlSource = 'CsGrade.Acumulas'
    *     EndWith
    *     SetAll('DynamicForeColor',
    *            'Iif(csGrade.AltCoef=1, RGB(255,0,0), RGB(0,0,0))', 'Column')
    *
    * O DynamicForeColor eh o que pinta de VERMELHO a linha cujo coeficiente
    * foi alterado (AltCoef = 1) - eh o unico sinal visual que o usuario tem
    * de quais linhas vao ser gravadas pelo form pai, entao nao eh enfeite.
    *
    * O bind inteiro eh CONDICIONADO a USED(alias): o cursor eh do chamador
    * (ver "CONTRATO EXTERNO" no cabecalho) e pode nao estar aberto - no
    * harness de teste nunca esta. Column.ControlSource de alias inexistente
    * estoura "Alias is not found" e derrubaria o Init (regra #41).
    *
    * ORDEM OBRIGATORIA (regra #41 / Problema 48): ColumnCount -> RecordSource
    * -> ControlSource -> Width -> Header1.Caption. Atribuir RecordSource
    * RESETA Column.Width (para o default) e Header1.Caption (para "Column1"
    * ...), logo esses dois vem DEPOIS do bind - e vem SEMPRE, inclusive com o
    * alias fechado, para a grade nunca aparecer com cabecalho generico e
    * largura errada.
    *
    * ColumnCount = 7 antes do RecordSource eh obrigatorio: sem ele o VFP
    * expande a grade para TODAS as colunas do cursor (csGrade tem 13) e
    * duplica cabecalhos. Reatribuir o MESMO valor eh inofensivo - medido no
    * VFP9: so REDUZIR ColumnCount destroi o que foi posto nas Columns.
    *==========================================================================
    PROTECTED PROCEDURE VincularGrade()
        LOCAL loc_cAlias, loc_oGrade

        loc_cAlias = ""
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorGrade
        ENDIF

        loc_oGrade = THIS.cnt_4c__Planilha.grd_4c_Dados

        *-- 1. ColumnCount ANTES do RecordSource
        loc_oGrade.ColumnCount = 7

        *-- 2. RecordSource + ControlSource - SO com o cursor do chamador aberto
        IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            loc_oGrade.RecordSource = loc_cAlias

            loc_oGrade.Column1.ControlSource = loc_cAlias + ".Cpros"
            loc_oGrade.Column2.ControlSource = loc_cAlias + ".Dpros"
            loc_oGrade.Column3.ControlSource = loc_cAlias + ".Totas"
            loc_oGrade.Column4.ControlSource = loc_cAlias + ".Coefs"
            loc_oGrade.Column5.ControlSource = loc_cAlias + ".Valos"
            loc_oGrade.Column6.ControlSource = loc_cAlias + ".totalG"
            loc_oGrade.Column7.ControlSource = loc_cAlias + ".Acumulas"

            *-- Linha vermelha para coeficiente alterado (AltCoef = 1). A
            *-- expressao eh avaliada a cada repintura, entao so pode ser
            *-- instalada com o alias aberto.
            loc_oGrade.SetAll("DynamicForeColor", ;
                "IIF(" + loc_cAlias + ".AltCoef = 1, RGB(255,0,0), RGB(0,0,0))", ;
                "Column")
        ENDIF

        *-- 3. Width DEPOIS do bind (o bind acima zera as larguras)
        loc_oGrade.Column1.Width = 120
        loc_oGrade.Column2.Width = 280
        loc_oGrade.Column3.Width = 90
        loc_oGrade.Column4.Width = 73
        loc_oGrade.Column5.Width = 90
        loc_oGrade.Column6.Width = 90
        loc_oGrade.Column7.Width = 100

        *-- 4. Header1.Caption por ULTIMO (o bind acima devolve "ColumnN")
        loc_oGrade.Column1.Header1.Caption = "C" + CHR(243) + "digo"
        loc_oGrade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrade.Column3.Header1.Caption = "Total (a)"
        loc_oGrade.Column4.Header1.Caption = "Coef. / (%)"
        loc_oGrade.Column5.Header1.Caption = "Valor (b)"
        loc_oGrade.Column6.Header1.Caption = "Total (a+b)"
        loc_oGrade.Column7.Header1.Caption = "Acumulado"

        *-- 5. Travas de coluna por ULTIMO: Column.ReadOnly tem de vir DEPOIS
        *--    de Grid.ReadOnly (que propaga para as colunas) - regra #18.
        THIS.AplicarTravasDeColuna()
    ENDPROC

    *==========================================================================
    * AplicarTravasDeColuna - reproduz o "When" de cada coluna da grade
    *
    * No SCX legado cada celula tem o seu When, e eh ele - nao o ReadOnly -
    * que decide onde o usuario pode digitar:
    *
    *     Column1/2/3/5/6/7.Text1.When -> RETURN .F.              (travadas)
    *     Column4.Text1.When -> Return fChecaAcesso([SIGCDFTI]) And (pcTipo = [V])
    *
    * Ou seja: das sete colunas, SEIS sao apenas exibicao (vem calculadas da
    * composicao montada pelo form pai) e so o coeficiente eh digitavel - e
    * mesmo ele so na planilha de VENDA e para quem tem acesso ao cadastro de
    * Feitios (SIGCDFTI). A checagem de acesso ja esta portada no BO, em
    * VerificarAcessoCoeficiente(), que repete literalmente a conjuncao do
    * legado.
    *
    * Os dois operandos do When nao mudam enquanto o dialogo esta aberto (o
    * tipo chega por parametro no Init e a permissao do usuario eh a mesma em
    * todas as linhas), entao avaliar a condicao na carga eh equivalente a
    * avalia-la a cada entrada na celula - e evita consultar o banco a cada
    * tecla.
    *
    * Em modo de teste/validacao de UI a parte de PERMISSAO eh omitida de
    * proposito: fChecaAcesso abre conexao SQL propria (a definicao que vence
    * eh a de Framework\sigacess.PRG, nao o stub de utils\functions.prg) e
    * travaria a execucao sem banco. Resta a parte que nao depende de
    * recurso externo - o tipo da planilha.
    *==========================================================================
    PROTECTED PROCEDURE AplicarTravasDeColuna()
        LOCAL loc_oGrade, loc_lCoefEditavel, loc_lModoTeste

        loc_oGrade = THIS.cnt_4c__Planilha.grd_4c_Dados

        *-- "When -> RETURN .F." das seis colunas de exibicao
        loc_oGrade.Column1.ReadOnly = .T.
        loc_oGrade.Column2.ReadOnly = .T.
        loc_oGrade.Column3.ReadOnly = .T.
        loc_oGrade.Column5.ReadOnly = .T.
        loc_oGrade.Column6.ReadOnly = .T.
        loc_oGrade.Column7.ReadOnly = .T.

        *-- "When -> fChecaAcesso([SIGCDFTI]) And (pcTipo = [V])" da Column4.
        *-- IFs encaixados, e nao um AND unico: VFP9 nao garante avaliacao
        *-- em curto-circuito, e ler uma global inexistente estoura.
        loc_lModoTeste = .F.
        IF TYPE("gb_4c_ModoTeste") = "L"
            loc_lModoTeste = gb_4c_ModoTeste
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L"
            loc_lModoTeste = loc_lModoTeste OR gb_4c_ValidandoUI
        ENDIF

        loc_lCoefEditavel = (THIS.this_cTipo == "V")
        IF loc_lCoefEditavel AND !loc_lModoTeste
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lCoefEditavel = THIS.this_oBusinessObject.VerificarAcessoCoeficiente()
            ENDIF
        ENDIF

        loc_oGrade.Column4.ReadOnly = !loc_lCoefEditavel
    ENDPROC

    *==========================================================================
    * GridCoefGotFocus - GotFocus de grd_4c_Dados.Column4.Text1 (ligado por
    * BINDEVENT em ConfigurarGrade). Reproduz o Column4.GotFocus legado
    * ("PUBLIC lnCoef / lnCoef = This.Value"): guarda, no BO, o valor do
    * coeficiente ANTES da edicao - SigOpPcuBO.ArmazenarCoefAnterior eh quem
    * compara esse valor com o novo dentro de RecalcularCoeficiente, para
    * decidir se a linha deve ser marcada como alterada (AltCoef/CidChaves).
    *
    * PUBLIC pela regra #3 (BINDEVENT exige metodo PUBLIC).
    *==========================================================================
    PROCEDURE GridCoefGotFocus()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.ArmazenarCoefAnterior( ;
                    THIS.cnt_4c__Planilha.grd_4c_Dados.Column4.Text1.Value)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em GridCoefGotFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GridCoefLostFocus - LostFocus de grd_4c_Dados.Column4.Text1 (ligado por
    * BINDEVENT em ConfigurarGrade). Reproduz o Column4.Valid legado ao sair
    * da celula: delega a SigOpPcuBO.RecalcularCoeficiente (formula
    * transcrita literalmente - regra #17) o REPLACE de Coefs/Valos/TotalG/
    * Acumulas na linha corrente de csGrade e a nova soma do total adicional,
    * e espelha o resultado na tela com AtualizarTotalAdicional() + Refresh
    * da grade - as duas atribuicoes que o legado faz ao final do Valid
    * ("Get_Adicional.Value = lnVr" + repintura implicita da grade).
    *
    * O valor digitado esta em Text1.Value (o cursor so recebe DEPOIS -
    * regra #46); RecalcularCoeficiente eh quem grava esse valor no cursor
    * via REPLACE, entao nao ha necessidade de reescrever Text1.Value de
    * volta (nao eh lookup, o valor digitado eh o que fica).
    *
    * PUBLIC pela regra #3 (BINDEVENT exige metodo PUBLIC).
    *==========================================================================
    PROCEDURE GridCoefLostFocus()
        LOCAL loc_nNovoCoef, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_nNovoCoef = THIS.cnt_4c__Planilha.grd_4c_Dados.Column4.Text1.Value
                IF VARTYPE(loc_nNovoCoef) != "N"
                    loc_nNovoCoef = 0
                ENDIF

                IF THIS.this_oBusinessObject.RecalcularCoeficiente(loc_nNovoCoef)
                    THIS.AtualizarTotalAdicional()
                    THIS.cnt_4c__Planilha.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em GridCoefLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDados - FUNIL UNICO de carga da grade (regra #21)
    *
    * Reproduz, na MESMA ordem, o que o Init legado faz com os dados:
    *
    *     Select CsGrade
    *     Set Key To pTipo        && filtra a planilha pelo tipo recebido
    *     Sum Valos to _TTA       && total adicional exibido no rodape
    *     Goto Top
    *     ... bind da grade ...
    *     .Refresh
    *
    * O "Set Key To" FILTRA a visao do cursor - eh assim que a tela mostra so
    * as linhas da planilha de Fator OU de Venda, e nao a composicao inteira -
    * e trocar ordem/chave de um alias NAO repinta a grade ligada a ele. Sem o
    * Refresh do fim a grade continua desenhando o conteudo de antes do
    * filtro, sem erro e sem log, so com dado errado na tela (regra #21).
    *
    * Por que FUNIL: a carga tem de rodar INTEIRA em todo caminho que mexa no
    * cursor ou na chave - a abertura, aqui, e o recalculo do coeficiente
    * (Column4.Valid do legado, que faz "Replace ... In csGrade" e volta a
    * somar Valos). Com as tres etapas separadas, um desses caminhos esquece o
    * Refresh e o sintoma reaparece.
    *
    * PUBLIC de proposito (sem PROTECTED): alem dos handlers desta classe, o
    * harness TesteAutomatico.prg chama este metodo de FORA da classe, por
    * nome e sem argumento. PEMSTATUS(...,5) devolve .T. tambem para metodo
    * PROTECTED - so testa existencia, nao escopo - entao com PROTECTED o
    * harness entraria no branch e a chamada estouraria "Property
    * CARREGARDADOS is not found" (regra #3).
    *
    * Devolve .F., sem erro na tela, quando o cursor do chamador nao esta
    * aberto - o caso NORMAL do harness, que instancia a tela sem chamador.
    * Por isso o corpo inteiro vive dentro de TRY: carga que estoura aqui
    * derrubaria o Init. Sem RETURN dentro do TRY (regra #1) - o resultado sai
    * por flag e o unico RETURN fica depois do ENDTRY.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- 1. Bind da grade (no-op de bind com o cursor fechado, mas
            *--    reaplica largura, cabecalho e travas sempre).
            THIS.VincularGrade()

            *-- 2. "Select CsGrade / Set Key To pTipo / Sum Valos / Goto Top"
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = THIS.this_oBusinessObject.FiltrarGrade(THIS.this_cTipo)
            ENDIF

            *-- 3. O "Get_Adicional.Value = _tta" do Init legado: espelha no
            *--    rodape o total que o passo 2 somou. Fica DENTRO do funil -
            *--    o passo 2 recalcula o total em toda carga, e sem isto o
            *--    campo exibiria 0 (ou o total anterior) para sempre.
            THIS.AtualizarTotalAdicional()

            *-- 4. O ".Refresh" do Init legado. Sem ele a grade nao mostra o
            *--    efeito do SET KEY aplicado no passo 2 (regra #21).
            THIS.Refresh()
            THIS.cnt_4c__Planilha.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            loc_lSucesso            = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar a " + ;
                    "planilha de custo." + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "FormSigOpPcu.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - os DOIS controles de dados que o legado tem fora
    * da grade: o subtitulo da planilha (legado: Label1) e o campo do total
    * adicional (legado: Get_Adicional).
    *
    * Esta tela eh FLAT (OPERACIONAL sem PageFrame - ver "CONTRATO EXTERNO" no
    * cabecalho): nao existe "Page2 de Dados" no legado, e inventar uma
    * violaria o PILAR 1. Os dois controles nascem filhos DIRETOS de
    * cnt_4c__Planilha, exatamente como no SCX, e este metodo eh CHAMADO por
    * ConfigurarPageFrame entre a grade e o botao - que eh a posicao do dump
    * (ver AplicarOrdemTabulacao).
    *
    * Propriedades transcritas do dump (tasks\task777\
    * SigOpPcu_form_codigo_fonte.txt, secoes "SIGOPPCU.Cnt_Planilha.Label1" e
    * "SIGOPPCU.Cnt_Planilha.Get_Adicional"):
    *
    *     Label1        Top=96  Left=67  864x21  Tahoma 12 bold
    *                   Alignment=2  BackStyle=0  ForeColor=(90,90,90)
    *                   Caption="Planilha de Custo"
    *     Get_Adicional Top=576 Left=588  92x23  Tahoma 8 bold
    *                   Alignment=3  Value=0  InputMask="9999,999.999"
    *                   ReadOnly=.T.  SpecialEffect=1  ForeColor=(0,0,0)
    *                   BackColor=(251,254,226)
    *                   DisabledBackColor=(251,254,226)
    *                   DisabledForeColor=(90,90,90)
    *
    * Label1 declara Width E Alignment no dump, logo o centramento eh do
    * LEGADO e NAO pode ser "corrigido" para Alignment = 0 (regra #23): os
    * 864px centram o subtitulo sobre a largura da grade. AutoSize fica
    * explicitamente .F. - em Label criado por AddObject o AutoSize = .T. eh
    * no-op e ainda DESCARTA a Height.
    *
    * O ForeColor (90,90,90) eh o do dump e eh obrigatorio: por tras ha a
    * textura CLARA new_background.jpg e o label eh transparente
    * (BackStyle = 0) - branco ficaria INVISIVEL (regra #12).
    *
    * Get_Adicional eh ReadOnly = .T. no proprio dump: o valor vem SEMPRE de
    * codigo (AtualizarTotalAdicional), nunca da digitacao. NAO se acrescenta
    * TabStop = .F. - o legado nao tem "When -> RETURN .F." neste campo (so
    * nas colunas da grade), entao ele continua no ciclo do Tab, como no
    * original. E nao ha ControlSource porque o legado tambem nao tem: o Init
    * dele faz "Sum Valos to _TTA" e atribui "Get_Adicional.Value = _tta".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCnt

        loc_oCnt = THIS.cnt_4c__Planilha

        *-- Subtitulo da planilha (legado: Label1). O Caption definitivo, com
        *-- o tipo entre parenteses, eh posto por AtualizarTitulos.
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top       = 96
            .Left      = 67
            .Width     = 864
            .Height    = 21
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .F.
            .Alignment = 2
            .Caption   = "Planilha de Custo"
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Total adicional (legado: Get_Adicional) - soma de Valos das linhas
        *-- visiveis, exibida no rodape. Somente leitura.
        loc_oCnt.AddObject("txt_4c_Adicional", "TextBox")
        WITH loc_oCnt.txt_4c_Adicional
            .Top               = 576
            .Left              = 588
            .Width             = 92
            .Height            = 23
            .Value             = 0
            .InputMask         = "9999,999.999"
            .Alignment         = 3
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(251, 254, 226)
            .DisabledForeColor = RGB(90, 90, 90)
            .DisabledBackColor = RGB(251, 254, 226)
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AplicarOrdemTabulacao - TabIndex, DEPOIS de todos os AddObject da tela
    *
    * O dump declara TabIndex em UM objeto so: "grdGrade.TabIndex = 18". Esse
    * literal NAO eh a ordem efetiva do legado - o VFP aplica o TabIndex no
    * instante em que CRIA cada objeto e o limita ao numero de IRMAOS que
    * existem NAQUELE container naquele momento. Simulando o load no escopo de
    * Cnt_Planilha, na ordem dos registros do SCX:
    *
    *     1o cntSombra     (sem literal)            -> 1
    *     2o grdGrade      (literal 18, nao cabe)   -> 2
    *     3o Label1        (sem literal)            -> 3
    *     4o Get_Adicional (sem literal)            -> 4
    *     5o cmdSair       (sem literal)            -> 5
    *
    * Isto eh: o 18 eh DESCARTADO em silencio e a ordem efetiva do legado eh a
    * ordem de criacao. Como a ordem de criacao deste form eh a MESMA do SCX,
    * as atribuicoes abaixo sao um no-op - e ficam escritas de proposito, como
    * documentacao da sequencia correta e como guarda contra alguem reordenar
    * os Configurar* depois (o AddObject renumeraria em silencio). Escreve-se
    * o ordinal EFETIVO (1..5), nunca o literal 18, para o codigo nao afirmar
    * um valor que o objeto jamais guarda e nao criar falso defeito numa
    * auditoria dump-x-migrado.
    *
    * Ordem ASCENDENTE com contador PROPRIO (loc_nSeq): valor duplicado ou
    * fora da faixa eh descartado em silencio, e a faixa eh o numero de
    * controles que TEM a propriedade - pular um nome sem pular o numero
    * abriria lacuna. O guard eh PEMSTATUS no CONTROLE: PEMSTATUS(THIS,
    * "<nome>", 5) so diria que o membro existe no form (regras #3 e #34).
    *==========================================================================
    PROTECTED PROCEDURE AplicarOrdemTabulacao()
        LOCAL loc_nSeq, loc_oCnt

        loc_oCnt = THIS.cnt_4c__Planilha

        *-- Nivel da Form: cnt_4c__Planilha eh o unico filho direto
        IF PEMSTATUS(loc_oCnt, "TabIndex", 5)
            loc_oCnt.TabIndex = 1
        ENDIF

        *-- Nivel de cnt_4c__Planilha, na ordem efetiva medida acima
        loc_nSeq = 0

        IF PEMSTATUS(loc_oCnt.cnt_4c_Sombra, "TabIndex", 5)
            loc_nSeq = loc_nSeq + 1
            loc_oCnt.cnt_4c_Sombra.TabIndex = loc_nSeq
        ENDIF

        IF PEMSTATUS(loc_oCnt.grd_4c_Dados, "TabIndex", 5)
            loc_nSeq = loc_nSeq + 1
            loc_oCnt.grd_4c_Dados.TabIndex = loc_nSeq
        ENDIF

        IF PEMSTATUS(loc_oCnt.lbl_4c_Label1, "TabIndex", 5)
            loc_nSeq = loc_nSeq + 1
            loc_oCnt.lbl_4c_Label1.TabIndex = loc_nSeq
        ENDIF

        IF PEMSTATUS(loc_oCnt.txt_4c_Adicional, "TabIndex", 5)
            loc_nSeq = loc_nSeq + 1
            loc_oCnt.txt_4c_Adicional.TabIndex = loc_nSeq
        ENDIF

        IF PEMSTATUS(loc_oCnt.cmd_4c_Encerrar, "TabIndex", 5)
            loc_nSeq = loc_nSeq + 1
            loc_oCnt.cmd_4c_Encerrar.TabIndex = loc_nSeq
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarTitulos - as duas atribuicoes de titulo que o Init legado faz
    * DEPOIS de mandar o Caption para a faixa do cabecalho:
    *
    *     ThisForm.Caption = CrSigCdPro.Cpros + ' - ' + CrSigCdPro.Dpros
    *     ThisForm.Cnt_Planilha.label1.Caption = ;
    *         'Planilha de Custo ('+Iif(ptipo=[C],'Fator','Venda')+')'
    *
    * Por que NAO fica dentro de ConfigurarPaginaDados: a ORDEM eh que faz a
    * faixa cinza exibir "Planilha de Custo" e nao o produto. No legado
    * lblSombra/lblTitulo recebem o Caption ORIGINAL e so DEPOIS o Caption do
    * form passa a ser o produto em edicao; chamado daqui (apos as duas linhas
    * do InicializarForm) isso eh reproduzido. Com TitleBar = 0 - declarado no
    * dump e agora transcrito na classe - o Caption do form nao aparece na
    * tela, nem no legado nem aqui; a atribuicao eh mantida mesmo assim
    * porque eh o que o Init legado faz, e porque o Caption continua sendo o
    * que o BO guarda em this_cCodigoProduto/this_cDescricaoProduto.
    *
    * O produto vem de CrSigCdPro, cursor do form CHAMADOR (mesmo contrato da
    * grade), logo o acesso eh CONDICIONADO a USED(): sem chamador (harness de
    * teste) nao ha produto, o Caption fica o original e nada estoura. O
    * EVALUATE eh LEITURA de membro com nome montado - o uso CORRETO dele
    * (regra #15) - porque o alias vem de uma property do BO, nao eh literal.
    *
    * PUBLIC de proposito: eh chamado de fora da classe por probe/harness, e
    * PEMSTATUS nao distingue PROTECTED (regra #3).
    *==========================================================================
    PROCEDURE AtualizarTitulos()
        LOCAL loc_cAliasProduto, loc_cCodigo, loc_cDescricao, loc_oErro

        TRY
            *-- "Planilha de Custo (Fator)" / "(Venda)" conforme o pTipo
            THIS.cnt_4c__Planilha.lbl_4c_Label1.Caption = ;
                "Planilha de Custo (" + ;
                IIF(THIS.this_cTipo == "C", "Fator", "Venda") + ")"

            loc_cAliasProduto = ""
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAliasProduto = THIS.this_oBusinessObject.this_cCursorProduto
            ENDIF

            IF !EMPTY(loc_cAliasProduto) AND USED(loc_cAliasProduto)
                IF !EOF(loc_cAliasProduto)
                    loc_cCodigo    = ALLTRIM(EVALUATE(loc_cAliasProduto + ".Cpros"))
                    loc_cDescricao = ALLTRIM(EVALUATE(loc_cAliasProduto + ".Dpros"))

                    THIS.this_oBusinessObject.this_cCodigoProduto    = loc_cCodigo
                    THIS.this_oBusinessObject.this_cDescricaoProduto = loc_cDescricao

                    THIS.Caption = loc_cCodigo + " - " + loc_cDescricao
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel montar o " + ;
                    "t" + CHR(237) + "tulo da planilha." + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "FormSigOpPcu.AtualizarTitulos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarTotalAdicional - espelha em txt_4c_Adicional o total que o BO
    * somou, reproduzindo as DUAS atribuicoes do legado:
    *
    *     Init:          ThisForm.Cnt_Planilha.Get_Adicional.Value = _tta
    *     Column4.Valid: thisform.cnt_Planilha.get_Adicional.Value = lnVr
    *
    * FONTE UNICA: quem soma eh o BO (FiltrarGrade na carga e
    * RecalcularCoeficiente na edicao do coeficiente, os dois gravando
    * this_nTotalAdicional) e a tela so ESPELHA - o form NUNCA recalcula por
    * conta propria, senao os dois caminhos divergem sem erro na tela.
    *
    * Chamado pelo funil CarregarDados, antes do Refresh. Quem recalcular o
    * coeficiente (Valid da coluna) tem de chamar este metodo tambem - sem
    * isso o rodape continua exibindo o total anterior, sem erro e sem log.
    *
    * PUBLIC pelo mesmo motivo de CarregarDados: eh chamado de FORA da classe
    * (probe/harness) e PEMSTATUS nao distingue PROTECTED (regra #3).
    *
    * O VARTYPE antes de atribuir nao eh enfeite: TextBox com .Value numerico
    * que recebe Caractere troca o TIPO do controle e o InputMask passa a
    * exibir lixo.
    *==========================================================================
    PROCEDURE AtualizarTotalAdicional()
        LOCAL loc_nTotal

        loc_nTotal = 0
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_nTotal = THIS.this_oBusinessObject.this_nTotalAdicional
        ENDIF

        IF VARTYPE(loc_nTotal) != "N"
            loc_nTotal = 0
        ENDIF

        IF PEMSTATUS(THIS.cnt_4c__Planilha, "txt_4c_Adicional", 5)
            THIS.cnt_4c__Planilha.txt_4c_Adicional.Value = loc_nTotal
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoEncerrar - cmd_4c_Encerrar (legado: cmdSair, classe
    * fwbtng do framework.vcx). Filho de cnt_4c__Planilha, como no legado.
    *
    * O SCX declara so Top=3, Left=924, Caption="Encerrar", Cancel=.T. e
    * Picture=cadastro_sair_60.jpg - o resto vem da classe fwbtng
    * (docs\FRAMEWORK_class_codigo_fonte.txt): FontName="Comic Sans MS",
    * FontBold/FontItalic=.T., FontSize=8, WordWrap=.T., MousePointer=15,
    * ForeColor=(90,90,90), BackColor=(255,255,255).
    *
    * GEOMETRIA: a fwbtng eh 80x100 e, no Left=924 do SCX, terminaria em 1004
    * - 5px alem da borda do container (Width=999), que RECORTA o excedente
    * (regra #30). Os 75x75 usados aqui sao o canonico do projeto para
    * cmd_4c_Encerrar (medido no acervo: unanime nos forms OPERACIONAL) e
    * fecham exatamente em 999, mantendo o Left do legado.
    *
    * Cancel = .T. faz o ESC disparar este MESMO Click, entao as duas saidas
    * da tela (mouse e teclado) caem no funil unico FecharDialogo().
    *
    * Themes = .T. + DisabledPicture divergem do Themes = .F. da classe
    * fwbtng por regra do projeto: standalone CommandButton com Picture nao
    * renderiza o icone quando desabilitado se Themes = .F.
    *
    * O Click eh ligado por BINDEVENT no FIM deste metodo, e nao antes do
    * AddObject: BINDEVENT exige o objeto JA criado. O delegate
    * (BtnEncerrarClick) eh PUBLIC pela regra #3.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
        LOCAL loc_oCnt

        loc_oCnt = THIS.cnt_4c__Planilha
        loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")

        WITH loc_oCnt.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 924
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Click de cmd_4c_Encerrar (e do ESC, por Cancel=.T.)
    * Ligado por BINDEVENT, logo PUBLIC (regra #3).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.FecharDialogo()
    ENDPROC

    *==========================================================================
    * FecharDialogo - funil unico de saida, transcrito do cmdSair.Click legado:
    *
    *     SELECT * from csGrade where altcoef = 1 into cursor crPrFtp READWRITE
    *     Select CsGrade
    *     Set Key To
    *     If (Type([ThisForm.ParentForm])=[O])
    *         Thisform.ParentForm.Enabled = .T.
    *     EndIf
    *     Release lnCoef, pcTipo
    *     ThisForm.Release
    *
    * As duas primeiras partes (montar crPrFtp com as linhas alteradas e
    * DESFAZER o "Set Key To" aplicado na carga) sao dados e moram no BO, em
    * MontarCursorAlterados(). Esse cursor eh o entregavel da tela, e o papel
    * dele no pai foi MEDIDO no dump, nao presumido: a PERSISTENCIA em
    * sigprftp sai do SCAN do proprio csGrade por AltCoef = 1
    * (sigcdpro_form_codigo_fonte.txt:20840); crPrFtp eh lido quando o pai
    * REMONTA a composicao, para reaplicar Coefs/cidchaves sobre as linhas
    * correspondentes (linhas 14706-14715). Por isso ele tem de ser montado
    * ANTES de fechar, e o
    * "Set Key To" tem de ser desfeito - o cursor volta para o pai como ele o
    * entregou, sem filtro.
    *
    * O "Release lnCoef, pcTipo" do legado nao tem equivalente: eram variaveis
    * PUBLIC, e no migrado esse estado sao propriedades do BO, que morrem com
    * o objeto.
    *
    * FECHA COM Hide(), NAO Release(): medido no VFP9, THIS.Release() destroi
    * o objeto mesmo com o chamador segurando a referencia (a variavel do
    * chamador passa a VARTYPE "X"), e este dialogo eh aberto por
    * CREATEOBJECT + Show(). Com Hide() o Show() modal retorna igual - para o
    * usuario a tela fecha do mesmo jeito (PILAR 1) - e o chamador ainda
    * consegue ler o resultado antes de chamar Release() ele mesmo, que eh o
    * desenho que o projeto ja adota em FormBuscaAuxiliar.
    *==========================================================================
    PROCEDURE FecharDialogo()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.MontarCursorAlterados()
            ENDIF

            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel concluir o " + ;
                    "encerramento da planilha." + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "FormSigOpPcu.FecharDialogo")
        ENDTRY

        THIS.Hide()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis recursivamente os controles
    * de um container (AddObject cria com Visible=.F. por padrao). Itera
    * Pages de PageFrames e Controls de containers.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
    * Destroy - Reabilita o form pai antes de fechar
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpPcuBO.prg):
*====================================================================
* SigOpPcuBO.prg
*
* Business Object para SigOpPcu - Planilha de Custo
* Herda de: BusinessBase
*
* ORIGEM LEGADO: SigOpPcu.SCX (dialogo modal filho)
*   Chamado por SIGCDPRO (Cadastro de Produto), aba Composicao:
*     chkPlanCus.Valid -> Do Form SigOpPcu With ThisForm, DataSessionId, [C]
*     chkPlanVen.Valid -> Do Form SigOpPcu With ThisForm, DataSessionId, [V]
*   Parametros do Init legado: poForm (form pai), pnDataSes (DataSession
*   do pai), pTipo ("C" = planilha de Fator/Custo, "V" = planilha de Venda).
*
* NATUREZA DA TELA (importante para entender este BO):
*   A planilha opera sobre o CURSOR LOCAL "csGrade", que pertence ao form
*   PAI (SIGCDPRO) e vive na DataSession DELE - o dialogo faz
*   "Set DataSession to pnDataSes" e edita o mesmo cursor em memoria.
*   Estrutura do cursor, transcrita do Load do SIGCDPRO:
*     Create Cursor CsGrade (Tipos c(1), Ordem n(3), Cpros c(14),
*            Dpros c(30), Totas n(12,3), Coefs n(8,4), Valos n(12,3),
*            TotalG n(12,3), Acumulas n(12,3), cGrus c(3), cods c(2),
*            CidChaves c(20), AltCoef n(1,0))
*     Index On Tipos + Str(Ordem,3) + Cpros Tag Ordem
*   O dialogo filtra as linhas do tipo recebido com "Set Key To pTipo"
*   sobre essa TAG e permite editar apenas a coluna Coefs (Coef./(%)),
*   recalculando Valos / TotalG / Acumulas e o total adicional.
*
* PERSISTENCIA: este dialogo NAO grava em tabela nenhuma. Quem persiste
*   eh o form PAI, no Salvar dele, lendo as linhas marcadas pelo dialogo:
*     SELECT csGrade / SCAN / IF altcoef = 1
*         Insert Into CrSigPrFtp (cGrus, cods, coefs, cpros, PkChaves)
*             Values (csGrade.cgrus, csGrade.cods, csGrade.coefs,
*                     crSigcdPro.cpros,
*                     IIF(EMPTY(csGrade.CidChaves), fUniqueIds(),
*                         csGrade.CidChaves))
*   Por isso o contrato de saida do dialogo sao as DUAS marcas que ele
*   grava na linha editada (AltCoef = 1 e CidChaves = fUniqueIds()) mais
*   o cursor crPrFtp que o botao Encerrar monta com as linhas alteradas:
*     SELECT * from csGrade where altcoef = 1 into cursor crPrFtp READWRITE
*   O comportamento padrao herdado de BusinessBase para Inserir() /
*   Atualizar() / ExecutarExclusao() (recusar a operacao e reportar pelo
*   ExibirFalha do Salvar) ja eh o correto para esta tela.
*
* TABELA DE REFERENCIA (PILAR 2 - nomes EXATOS do schema):
*   sigprftp  - destino final do coeficiente alterado (gravado pelo pai)
*               cgrus char(3), cods char(2), coefs numeric(6,4),
*               cpros char(14), pkchaves char(20), valors numeric(10,2)
*   SigPrFto  - origem das linhas da planilha montadas pelo pai
*               cidchaves char(20), coefs numeric(7,4), cpros char(14)
*====================================================================

DEFINE CLASS SigOpPcuBO AS BusinessBase

    *----------------------------------------------------------------
    * PARAMETROS DE ABERTURA (legado: LParameters poForm, pnDataSes, pTipo)
    *----------------------------------------------------------------
    this_cTipo              = "C"    && pTipo: "C" = Fator (custo), "V" = Venda
    this_nDataSessionPai    = 0      && pnDataSes - DataSession do form pai

    *----------------------------------------------------------------
    * CURSORES COMPARTILHADOS COM O FORM PAI
    * Os nomes sao os do legado de proposito: estes cursores NAO sao
    * criados aqui, eles pertencem a DataSession do form pai e os nomes
    * sao o CONTRATO entre as duas telas (mesma pratica de FormFti,
    * que tambem preserva "csGrade").
    *----------------------------------------------------------------
    this_cCursorGrade       = "csGrade"      && linhas da planilha (cursor do pai)
    this_cCursorProduto     = "CrSigCdPro"   && produto em edicao no pai (Cpros/Dpros)
    this_cCursorAlterados   = "crPrFtp"      && saida: linhas com AltCoef = 1
    this_cTagOrdem          = "Ordem"        && TAG Tipos + Str(Ordem,3) + Cpros

    *----------------------------------------------------------------
    * LINHA DA PLANILHA (colunas do cursor csGrade)
    * Tipo e tamanho transcritos do Create Cursor do SIGCDPRO.
    *----------------------------------------------------------------
    this_cTipos             = ""     && Tipos     c(1)      - "C" ou "V"
    this_nOrdem             = 0      && Ordem     n(3,0)    - sequencia da linha
    this_cCpros             = ""     && Cpros     c(14)     - codigo (coluna "Codigo")
    this_cDpros             = ""     && Dpros     c(30)     - descricao (coluna "Descricao")
    this_nTotas             = 0      && Totas     n(12,3)   - coluna "Total (a)"
    this_nCoefs             = 0      && Coefs     n(8,4)    - coluna "Coef. / (%)" (EDITAVEL)
    this_nValos             = 0      && Valos     n(12,3)   - coluna "Valor (b)"
    this_nTotalG            = 0      && TotalG    n(12,3)   - coluna "Total (a+b)"
    this_nAcumulas          = 0      && Acumulas  n(12,3)   - coluna "Acumulado"
    this_cCgrus             = ""     && cGrus     c(3)      - grupo (-> sigprftp.cgrus)
    this_cCods              = ""     && cods      c(2)      - feitio (-> sigprftp.cods)
    this_cCidChaves         = ""     && CidChaves c(20)     - PK (-> sigprftp.pkchaves)
    this_nAltCoef           = 0      && AltCoef   n(1,0)    - 1 = coeficiente alterado

    *----------------------------------------------------------------
    * CABECALHO DA TELA
    * Legado: ThisForm.Caption = CrSigCdPro.Cpros + " - " + CrSigCdPro.Dpros
    *         Label1 = "Planilha de Custo (" + Iif(pTipo="C","Fator","Venda") + ")"
    *----------------------------------------------------------------
    this_cCodigoProduto     = ""     && CrSigCdPro.Cpros c(14)
    this_cDescricaoProduto  = ""     && CrSigCdPro.Dpros c(30)

    *----------------------------------------------------------------
    * ESTADO DE CALCULO
    * this_nTotalAdicional eh o _TTA do legado (Sum Valos), exibido no
    * TextBox Get_Adicional, e eh recalculado a cada edicao de Coefs.
    * this_nCoefAnterior eh o lnCoef que o legado guardava no GotFocus
    * da celula para descobrir se o coeficiente mudou de fato - so nesse
    * caso a linha recebe AltCoef = 1 e CidChaves nova.
    *----------------------------------------------------------------
    this_nTotalAdicional    = 0      && _TTA - soma de Valos do tipo corrente
    this_nCoefAnterior      = 0      && lnCoef - valor de Coefs ao entrar na celula

    *----------------------------------------------------------------
    * CONTROLE DE ACESSO
    * Legado (When da Column4): Return fChecaAcesso([SIGCDFTI]) And (pcTipo = [V])
    * Ou seja: a coluna do coeficiente so eh editavel com acesso ao
    * cadastro de Feitios E na planilha de VENDA. O default .T. acompanha
    * o fChecaAcesso portado (utils\functions.prg), que libera o acesso;
    * o valor eh reavaliado por fChecaAcesso na carga da planilha.
    *----------------------------------------------------------------
    this_lAcessoFeitio      = .T.    && fChecaAcesso("SIGCDFTI")

    *====================================================================
    * Init - Inicializa o Business Object
    *
    * Nao recebe parametro obrigatorio: o harness de teste instancia com
    * CREATEOBJECT("SigOpPcuBO") sem argumento, e Init que devolve .F.
    * mata o form. O tipo da planilha ("C"/"V") e a DataSession do pai
    * sao atribuidos pelo form depois da instanciacao.
    *
    * this_cTabela / this_cCampoChave apontam para sigprftp / pkchaves,
    * que eh onde o coeficiente editado aqui termina gravado pelo form
    * pai (nomes EXATOS do schema - PILAR 2).
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "sigprftp"
            THIS.this_cCampoChave = "pkchaves"

            *-- Estado inicial da planilha (equivalente ao Init legado
            *-- antes de "Set Key To pTipo" / "Sum Valos to _TTA")
            THIS.this_cTipo             = "C"
            THIS.this_nDataSessionPai   = 0
            THIS.this_nTotalAdicional   = 0
            THIS.this_nCoefAnterior     = 0
            THIS.this_lAcessoFeitio     = .T.

            THIS.this_cCodigoProduto    = ""
            THIS.this_cDescricaoProduto = ""

            THIS.this_cTipos      = ""
            THIS.this_nOrdem      = 0
            THIS.this_cCpros      = ""
            THIS.this_cDpros      = ""
            THIS.this_nTotas      = 0
            THIS.this_nCoefs      = 0
            THIS.this_nValos      = 0
            THIS.this_nTotalG     = 0
            THIS.this_nAcumulas   = 0
            THIS.this_cCgrus      = ""
            THIS.this_cCods       = ""
            THIS.this_cCidChaves  = ""
            THIS.this_nAltCoef    = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar SigOpPcuBO:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades desta linha a partir do
    * registro CORRENTE do cursor recebido (este dialogo nao usa SQLEXEC:
    * a "fonte de dados" eh o cursor local csGrade, compartilhado com o
    * form pai - ver cabecalho do arquivo).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cTipos     = TratarNulo(Tipos, "C")
            THIS.this_nOrdem     = TratarNulo(Ordem, "N")
            THIS.this_cCpros     = TratarNulo(Cpros, "C")
            THIS.this_cDpros     = TratarNulo(Dpros, "C")
            THIS.this_nTotas     = TratarNulo(Totas, "N")
            THIS.this_nCoefs     = TratarNulo(Coefs, "N")
            THIS.this_nValos     = TratarNulo(Valos, "N")
            THIS.this_nTotalG    = TratarNulo(TotalG, "N")
            THIS.this_nAcumulas  = TratarNulo(Acumulas, "N")
            THIS.this_cCgrus     = TratarNulo(cGrus, "C")
            THIS.this_cCods      = TratarNulo(cods, "C")
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_nAltCoef   = TratarNulo(AltCoef, "N")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave desta linha no destino final (sigprftp.
    * pkchaves = csGrade.CidChaves). Mantido por consistencia com
    * BusinessBase; este dialogo NAO chama Salvar()/Excluir() (ver nota
    * de PERSISTENCIA no cabecalho do arquivo e Init() acima) - quem
    * grava em sigprftp eh o form PAI (SIGCDPRO), varrendo o proprio
    * csGrade pelas linhas com AltCoef = 1 que esta tela marcou.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN EscaparSQL(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * FiltrarGrade - Replica "Select CsGrade / Set Key To pTipo" do Init
    * legado: restringe o cursor compartilhado csGrade as linhas do tipo
    * recebido ("C" = Fator/Custo, "V" = Venda, Column4.When) e recalcula
    * o total adicional (_TTA do legado / TextBox Get_Adicional) somando
    * Valos das linhas visiveis.
    *
    * O "Set Key To pTipo" do legado NAO pode ser transcrito ao pe da letra
    * aqui - e o motivo nao se ve lendo o codigo, so MEDINDO. O TAG "Ordem"
    * do csGrade eh COMPOSTO ("Index On Tipos + Str(Ordem,3) + Cpros", dump
    * do SIGCDPRO), isto eh uma chave de 18 caracteres, e "V" eh um valor
    * PARCIAL dela. Medido no VFP9 em 2026-11-11 (automation\
    * MedirSetKeyRange777.prg, mesmo cursor e mesmo TAG):
    *
    *     SET EXACT OFF + SET KEY TO "V"                  -> 3 linhas
    *     SET EXACT ON  + SET KEY TO "V"                  -> 0 LINHAS
    *     SET EXACT ON  + SET KEY TO RANGE "V", "V"+CHR(255)...  -> 3 linhas
    *
    * E o projeto roda com EXACT ON: start\config.prg:242 faz "SET EXACT ON"
    * no nivel de cima, ao contrario do ambiente Fortyus. Transcrito
    * literalmente, portanto, o filtro casa ZERO linha e a planilha abre
    * VAZIA - sem erro, sem log e sem excecao, que eh o sintoma que manda o
    * diagnostico para o cursor ou para o form pai (a mesma familia da regra
    * #21 e da licao "INDEX composto + SEEK parcial com EXACT ON").
    *
    * SET KEY TO RANGE eh a forma que nao depende do SET EXACT: o limite
    * inferior eh o proprio tipo e o superior eh o tipo seguido de CHR(255),
    * que ordena acima de qualquer sufixo possivel da chave. Medido no mesmo
    * script: "V" -> 3, "C" -> 2, tipo inexistente -> 0, e o SUM Valos passa
    * a somar so as visiveis (250.000 contra 380.000 sem filtro). O sufixo
    * eh FOLGADO de proposito (250 chars, contra os 17 que faltariam para
    * completar a chave): limite superior maior que a chave foi medido e
    * funciona, e assim o codigo nao fica amarrado a largura exata do TAG,
    * que pertence ao form PAI e pode mudar la.
    *
    * NAO se usa "salvar e restaurar SET EXACT" no lugar disto: o SET eh
    * global, valeria para tudo que rodasse entre as duas linhas, e deixaria
    * o comportamento da tela dependendo de um estado de ambiente.
    *
    * Tipo vazio = sem filtro (o legado tambem limpa o filtro com
    * "Set Key To" sem argumento, em MontarCursorAlterados).
    *====================================================================
    PROCEDURE FiltrarGrade(par_cTipo)
        LOCAL loc_lSucesso, loc_nTotalAdicional, loc_cTipo
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade)
            THIS.this_cTipo = par_cTipo
            loc_cTipo = IIF(VARTYPE(par_cTipo) = "C", ALLTRIM(par_cTipo), "")

            SELECT (THIS.this_cCursorGrade)
            SET ORDER TO TAG (THIS.this_cTagOrdem)
            IF EMPTY(loc_cTipo)
                SET KEY TO
            ELSE
                SET KEY TO RANGE loc_cTipo, loc_cTipo + REPLICATE(CHR(255), 250)
            ENDIF
            GO TOP IN (THIS.this_cCursorGrade)

            loc_nTotalAdicional = 0
            SUM Valos TO loc_nTotalAdicional
            THIS.this_nTotalAdicional = loc_nTotalAdicional

            GO TOP IN (THIS.this_cCursorGrade)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * VerificarAcessoCoeficiente - Replica Column4.When do legado:
    *   Return fChecaAcesso([SIGCDFTI]) And (pcTipo = [V])
    * A celula do coeficiente so eh editavel com acesso ao cadastro de
    * Feitios (SIGCDFTI) E na planilha de VENDA. Chamado pelo Form no
    * When/InteractiveChange da coluna de Coefs.
    *====================================================================
    PROCEDURE VerificarAcessoCoeficiente()
        THIS.this_lAcessoFeitio = (fChecaAcesso("SIGCDFTI") AND (THIS.this_cTipo == "V"))
        RETURN THIS.this_lAcessoFeitio
    ENDPROC

    *====================================================================
    * ArmazenarCoefAnterior - Replica Column4.GotFocus do legado
    * ("PUBLIC lnCoef / lnCoef = this.Value"): guarda o valor do
    * coeficiente ANTES da edicao, para THIS.RecalcularCoeficiente()
    * decidir se a linha deve ser marcada como alterada.
    *====================================================================
    PROCEDURE ArmazenarCoefAnterior(par_nCoefAtual)
        THIS.this_nCoefAnterior = TratarNulo(par_nCoefAtual, 0)
    ENDPROC

    *====================================================================
    * RecalcularCoeficiente - Replica Column4.Valid do legado (formula
    * transcrita LITERALMENTE, sem reescrever - regra de negocio):
    *   IF this.Value <> lnCoef
    *       replace altcoef with 1 in csGrade
    *       replace cidChaves with fUniqueIds() in csGrade
    *   ENDIF
    *   replace valos with Round((( totas * coefs ) - totas ),3) in csGrade
    *   replace totalg with totas + valos in csGrade
    *   GO top / SCAN / replace acumulas with lnVr + valos + totas / lnVr = acumulas
    *   Sum Valos to lnVr -> Get_Adicional.Value
    *
    * par_nNovoCoef - valor novo da celula (TextBox.Value no legado),
    * aplicado ao registro CORRENTE do cursor csGrade.
    *====================================================================
    PROCEDURE RecalcularCoeficiente(par_nNovoCoef)
        LOCAL loc_lSucesso, loc_nRegistroAtual, loc_nAcumulado, loc_nTotalAdicional
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade) AND !EOF(THIS.this_cCursorGrade)
            SELECT (THIS.this_cCursorGrade)

            IF par_nNovoCoef <> THIS.this_nCoefAnterior
                REPLACE AltCoef WITH 1 IN (THIS.this_cCursorGrade)
                REPLACE CidChaves WITH fUniqueIds() IN (THIS.this_cCursorGrade)
            ENDIF

            loc_nRegistroAtual = RECNO(THIS.this_cCursorGrade)

            REPLACE Coefs WITH par_nNovoCoef IN (THIS.this_cCursorGrade)
            REPLACE Valos WITH ROUND(((Totas * Coefs) - Totas), 3) IN (THIS.this_cCursorGrade)
            REPLACE TotalG WITH Totas + Valos IN (THIS.this_cCursorGrade)

            GO TOP IN (THIS.this_cCursorGrade)
            loc_nAcumulado = 0
            SCAN
                REPLACE Acumulas WITH loc_nAcumulado + Valos + Totas IN (THIS.this_cCursorGrade)
                loc_nAcumulado = Acumulas
            ENDSCAN

            loc_nTotalAdicional = 0
            SUM Valos TO loc_nTotalAdicional
            THIS.this_nTotalAdicional = loc_nTotalAdicional

            GO RECORD loc_nRegistroAtual IN (THIS.this_cCursorGrade)
            THIS.CarregarDoCursor(THIS.this_cCursorGrade)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MontarCursorAlterados - Replica a parte de dados do cmdSair.Click
    * do legado:
    *   SELECT * from csGrade where altcoef = 1 into cursor crPrFtp READWRITE
    *   Select CsGrade / Set Key To
    * (o restante do Click - ThisForm.ParentForm.Enabled = .T. e
    * ThisForm.Release - eh responsabilidade do Form, nao do BO). Chamado
    * pelo botao Encerrar antes de fechar o dialogo. MEDIDO no dump do pai:
    * o form PAI (SIGCDPRO) grava sigprftp a partir do SCAN do PROPRIO
    * csGrade por AltCoef = 1 (sigcdpro_form_codigo_fonte.txt:20840), e le
    * this_cCursorAlterados (crPrFtp) quando REMONTA a composicao, para
    * reaplicar Coefs/cidchaves (linhas 14706-14715).
    *====================================================================
    PROCEDURE MontarCursorAlterados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade)
            IF USED(THIS.this_cCursorAlterados)
                USE IN (THIS.this_cCursorAlterados)
            ENDIF

            SELECT * FROM (THIS.this_cCursorGrade) WHERE AltCoef = 1 ;
                INTO CURSOR (THIS.this_cCursorAlterados) READWRITE

            SELECT (THIS.this_cCursorGrade)
            SET KEY TO

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

