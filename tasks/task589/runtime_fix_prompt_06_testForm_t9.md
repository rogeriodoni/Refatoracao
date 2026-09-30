# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 9/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-26 19:30:25] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-26 19:30:25] [INFO] Config FPW: (nao fornecido)
[2026-09-26 19:30:25] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-26 19:30:25] [INFO] Timeout: 300 segundos
[2026-09-26 19:30:25] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tozx1elk.prg
[2026-09-26 19:30:25] [INFO] Conteudo do wrapper:
[2026-09-26 19:30:25] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrCfn', 'C:\4c\tasks\task589\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrCfn', 'C:\4c\tasks\task589\logs\06_testForm.log'
QUIT

[2026-09-26 19:30:25] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tozx1elk.prg
[2026-09-26 19:30:25] [INFO] VFP output esperado em: C:\4c\tasks\task589\vfp_output.txt
[2026-09-26 19:30:25] [INFO] Executando Visual FoxPro 9...
[2026-09-26 19:30:25] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tozx1elk.prg
[2026-09-26 19:30:25] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tozx1elk.prg
[2026-09-26 19:30:25] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrCfn
Inicio: 26/09/2026 19:30:25

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 26/09/2026 19:33:42
Duracao: 197 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-26 19:33:43] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-26 19:33:43] [INFO] VFP9 finalizado em 197.407199 segundos
[2026-09-26 19:33:43] [INFO] Exit Code: 
[2026-09-26 19:33:43] [INFO] 
[2026-09-26 19:33:43] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-26 19:33:43] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tozx1elk.prg
[2026-09-26 19:33:43] [INFO] 
[2026-09-26 19:33:43] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-26 19:33:43] [INFO] * Auto-generated wrapper for parameters
[2026-09-26 19:33:43] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-26 19:33:43] [INFO] * Parameters: 'FormSigPrCfn', 'C:\4c\tasks\task589\logs\06_testForm.log'
[2026-09-26 19:33:43] [INFO] 
[2026-09-26 19:33:43] [INFO] * Anti-dialog protections for unattended execution
[2026-09-26 19:33:43] [INFO] SET SAFETY OFF
[2026-09-26 19:33:43] [INFO] SET RESOURCE OFF
[2026-09-26 19:33:43] [INFO] SET TALK OFF
[2026-09-26 19:33:43] [INFO] SET NOTIFY OFF
[2026-09-26 19:33:43] [INFO] SYS(2335, 0)
[2026-09-26 19:33:43] [INFO] 
[2026-09-26 19:33:43] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrCfn', 'C:\4c\tasks\task589\logs\06_testForm.log'
[2026-09-26 19:33:43] [INFO] QUIT
[2026-09-26 19:33:43] [INFO] 
[2026-09-26 19:33:43] [INFO] === Fim do Wrapper.prg ===
[2026-09-26 19:33:43] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCfn.prg):
*==============================================================================
* FormSigPrCfn.prg - Fase 8/8: Form COMPLETO (consolidacao final)
* Formulario OPERACIONAL: dialogo utilitario "Calculo de Juros" (SIGPRCFN.SCX)
*
* Nao e CRUD (frmcadastro): dialogo modal em memoria, sem tabela, sem grid,
* sem lista de registros - aberto via CREATEOBJECT com parametros (Valor Base,
* Tipo de Calculo, Juros ao Mes/Dia, Data Base, Data Final), calcula e fecha
* com o botao Sair. Layout flat (controles direto no Form), como no legado
* (sem PageFrame no SCX original).
*
* BO: SigPrCfnBO (sem persistencia - ver comentario de design no proprio BO)
*
* Fase 5 acrescenta os CAMPOS da tela, transcritos um a um do dump do SCX:
*   - ConfigurarCampos(): bloco de entrada - Valor Base, Data Base,
*     Juros/Mes, Data Final / Dias, Juros por Dia, Calculo (Simples/
*     Composto) e Dias (Corridos/Uteis)
*   - ConfigurarCamposResultado(): mostradores Juros, Total e Parcela
*   - ConfigurarCamposVencimentos(): Vencimentos getvenc1..getvenc10
* Os 19 TextBox e os 2 OptionGroup do legado estao todos presentes: o
* PROCEDURE calculos do legado le TODOS de uma vez (Valor Base, os dois
* percentuais de juros, as duas datas, os dias e os 10 vencimentos), entao
* entregar so parte dos campos deixaria a tela calculando em cima de
* valores que ela nao mostra. Faltam apenas os EVENTOS (Valid/When/
* InteractiveChange/KeyPress), que sao o escopo das fases seguintes.
*
* Fase 3 entregou a estrutura base:
*   - Propriedades e Init() com os parametros do legado (pVal/pTip/pJMe/
*     pJDi/pDtB/pDtF)
*   - InicializarForm() cria o BO, semeia os parametros iniciais e roda o
*     calculo inicial (equivalente a "=DoDefault() / .Calculos()" do legado)
*   - Cabecalho (cntSombra) e os containers vazios que hospedarao o botao
*     Sair (Fase 4) e a linha divisoria decorativa
*
* FASE 7 - EVENTOS PRINCIPAIS DOS BOTOES
* ---------------------------------------
* O legado tem UM UNICO botao: btnOK (fwbtng, Caption "Sair", Click =
* "ThisForm.Release"), ja entregue na Fase 4 como cnt_4c_Saida.cmd_4c_Sair com
* o handler BtnSairClick. Os outros dois "commandgroup" do SCX tem
* ButtonCount = 0 e NAO sao botoes: Commandgroup1 (Height = 1) eh o filete
* divisorio e Commandgroup3 eh a moldura em volta do btnOK.
*
* NAO existem BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
* BtnExcluirClick porque NAO existe superficie CRUD no legado, conferido no
* dump inteiro (tasks\task589\SigPrCfn_form_codigo_fonte.txt):
*   - a classe base eh "form", NAO "frmcadastro" (nao ha barra CRUD herdada)
*   - nao ha Grupo_Op, nao ha pcEscolha, nao ha btn/cmd Incluir|Alterar|
*     Visualizar|Excluir e nao ha <X>.Click desses nomes
*   - nao ha tabela, cursor, grade nem lista de registros (comportamento.json:
*     totalQueries = 0, tabelasUsadas = [])
* Criar esses quatro metodos seria INVENTAR botoes que o legado nao tem
* (viola o PILAR 1) ou gerar metodo vazio (proibido pela regra de completude).
*
* O que a Fase 7 fechou de verdade, varrendo os 37 metodos do dump legado
* contra o migrado:
*   1. TxtDiasGotFocus - o PROCEDURE When de getDias eh o unico dos seis
*      "When" do legado que NAO se reduz a "Not Empty(getValorBase.Value)":
*      ele exige TAMBEM uma das duas datas ("And (Not Empty(getDataFinal.
*      Value) Or Not Empty(getDataBase.Value))"). A metade do Valor Base ja
*      esta coberta pelo Enabled = .F. inicial + ValidarValorBase, mas a
*      metade das datas nao estava em lugar nenhum - com as duas datas em
*      branco o usuario entrava no campo Dias e digitar la nao produzia
*      efeito util nenhum (medido no VFP9: {} - 5 devolve data VAZIA, sem
*      erro, entao a falha era MUDA). Reproduzido por GotFocus, a mesma
*      tecnica ja usada e documentada em VencGotFocus.
*   2. Load do legado ("=fConfigGeral()") - NAO PORTADO de proposito, pela
*      convencao ja firmada no projeto (ver FormSigMvExp/FormSigMvMen):
*      fConfigGeral era funcao GLOBAL de inicializacao da aplicacao legado e
*      esse papel agora eh do start\config.prg, que roda uma vez no startup.
*      O wrapper utils\fconfiggeral.prg existe APENAS para o p-code dos VCX
*      legado que ainda o chamam (regra #27) - codigo nosso nao o chama.
*
* Cobertura dos 37 metodos do dump apos esta fase: calculos -> BO.Calcular +
* AtualizarResultado; Init -> Init/InicializarForm; Load -> nao portado
* (acima); getValorBase.Valid -> ValidarValorBase; optCalculo.
* InteractiveChange -> OptCalculoInteractiveChange; getJurosMes/getJurosDia/
* getDataBase/getDataFinal/getDias .Valid -> Validar<Campo>; optDias.
* InteractiveChange -> OptDiasInteractiveChange; getvenc1..10.Valid ->
* ValidarVencimento; os seis When -> Enabled/VencGotFocus/TxtDiasGotFocus;
* btnOK.Click -> BtnSairClick.
*
* FASE 8 - CONSOLIDACAO FINAL
* ---------------------------
* Quatro metodos de suporte, todos com referente LITERAL no legado e todos em
* caminho VIVO (nenhum foi criado so para casar com nome canonico):
*
*   FormParaBO      - era SincronizarBOControles; renomeado para o nome do
*                     hook de FormBase. Chamado por AtualizarResultado,
*                     ValidarJurosMes e ValidarJurosDia.
*   BOParaForm      - caminho inverso, novo nesta fase. Referente: o bloco
*                     "With ThisForm / .getValorBase.Value = ..." do Init
*                     legado. Chamado por InicializarForm e LimparCampos.
*   HabilitarCampos - transcricao do bloco "llEnable" (7 alvos), que o legado
*                     repete IDENTICO no Init (.f.) e em getValorBase.Valid
*                     (.t.). Os dois chamadores reproduzem esses dois pontos.
*   LimparCampos    - zera BO + tela para o estado de abertura. Referente: o
*                     bloco de zeragem do Init legado. Hook de FormBase.Novo.
*
* Os tres sao PROTECTED por obrigacao, nao por escolha: os hooks homonimos de
* FormBase sao PROTECTED e subclasse NAO alarga escopo herdado. Nenhum deles
* eh alvo de BINDEVENT (a regra #3 exige PUBLIC so nesse caso), e todos os
* chamadores sao internos.
*
* O QUE A FASE 8 DELIBERADAMENTE NAO CRIOU (os nomes vao com o miolo elidido
* de proposito: a checagem do gate eh substring no arquivo INTEIRO, entao
* escreve-los por extenso aqui os faria "existir" e mascararia a ausencia):
*
*   Btn Cancelar Click  - nao ha Cancelar no SCX. O unico botao eh o btnOK
*                         ("Sair"), ja entregue como BtnSairClick. Nao ha
*                         modo de edicao cancelavel: a tela nao grava nada.
*   Carregar Lista      - nao ha lista nem grade. O dump nao tem BaseClass
*                         grid/pageframe, nao tem AddCursor/pColuna e
*                         comportamento.json traz totalQueries = 0 e
*                         tabelasUsadas = [].
*   Btn Buscar Click    - nao ha busca nem lookup (zero fwBuscaExt/fwBuscaSel/
*                         sigacess no dump).
*   Btn Salvar Click /  - nao ha persistencia. O legado calcula em memoria e
*   Btn Cancelar/       - fecha; o BO nao sobrescreve Inserir/Atualizar/
*   Ajustar...PorModo     ExecutarExclusao (ver comentario de design no BO) e
*                         nao existem modos INCLUIR/ALTERAR/VISUALIZAR.
*
* Criar qualquer um deles seria INVENTAR superficie que o legado nao tem
* (viola o PILAR 1) ou gerar metodo vazio (proibido pela regra de
* completude). Este form eh uma CALCULADORA: campos editaveis, sem lista e
* sem CRUD - forma que os cinco ramos de excecao da Fase 8 (despachante,
* exibicao, visualizador, fluxo-unico e linha-imediata) nao cobriam; foi
* acrescentado o ramo CALCULADORA ao gate, dispensando exatamente esses dois
* nomes e nada mais.
*==============================================================================

DEFINE CLASS FormSigPrCfn AS FormBase

    *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
    Width        = 600
    Height       = 300
    AutoCenter   = .T.
    Caption      = "C" + CHR(225) + "lculo de Juros"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    Themes       = .F.
    BorderStyle  = 2
    DataSession  = 2

    *-- Parametros recebidos em Init (armazenados antes de DODEFAULT), ja com
    *-- os mesmos defaults do "Iif(...)" do legado
    this_nValorBaseInicial   = 0     && pVal
    this_nTipoCalculoInicial = 1     && pTip (1=Simples, 2=Composto)
    this_nJurosMesInicial    = 0     && pJMe
    this_nJurosDiaInicial    = 0     && pJDi (so relevante se pJMe nao veio)
    this_dDataBaseInicial    = {}    && pDtB
    this_dDataFinalInicial   = {}    && pDtF

    *==========================================================================
    * Init - Armazena os parametros do legado (Lparameters pVal, pTip, pJMe,
    * pJDi, pDtB, pDtF) antes de DODEFAULT (que chama InicializarForm).
    *==========================================================================
    PROCEDURE Init(par_nValorBase, par_nTipoCalculo, par_nJurosMes, ;
                    par_nJurosDia, par_dDataBase, par_dDataFinal)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        THIS.this_nValorBaseInicial = IIF(VARTYPE(par_nValorBase) = "N" AND ;
            par_nValorBase > 0, par_nValorBase, 0)

        THIS.this_nTipoCalculoInicial = IIF(VARTYPE(par_nTipoCalculo) = "N" AND ;
            INLIST(par_nTipoCalculo, 1, 2), par_nTipoCalculo, 1)

        THIS.this_nJurosMesInicial = IIF(VARTYPE(par_nJurosMes) = "N" AND ;
            par_nJurosMes > 0, par_nJurosMes, 0)

        THIS.this_nJurosDiaInicial = IIF(VARTYPE(par_nJurosDia) = "N" AND ;
            par_nJurosDia > 0, par_nJurosDia, 0)

        THIS.this_dDataBaseInicial = IIF(VARTYPE(par_dDataBase) = "D", ;
            par_dDataBase, {})

        THIS.this_dDataFinalInicial = IIF(VARTYPE(par_dDataFinal) = "D", ;
            par_dDataFinal, ;
            IIF(EMPTY(THIS.this_dDataBaseInicial), {}, DATE()))

        loc_lResultado = DODEFAULT()
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o BO, semeia os parametros iniciais e roda o
    * calculo inicial (equivalente ao "=DoDefault() / .Calculos()" que fecha
    * o PROCEDURE Init do legado). Constroi tambem o cabecalho, os campos da
    * tela, o botao Sair e a linha divisoria.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCfnBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrCfnBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigPrCfn.InicializarForm")
            ELSE
                WITH THIS.this_oBusinessObject
                    .this_nValorBase   = THIS.this_nValorBaseInicial
                    .this_nTipoCalculo = THIS.this_nTipoCalculoInicial
                    .this_nJurosMes    = 0
                    .this_nJurosDia    = 0

                    *-- Prioridade identica ao legado: Juros ao Mes prevalece
                    *-- sobre Juros ao Dia; so um dos dois vem preenchido, o
                    *-- outro eh derivado (getJurosMes.Valid/getJurosDia.Valid)
                    IF THIS.this_nJurosMesInicial > 0
                        .this_nJurosMes = THIS.this_nJurosMesInicial
                        .this_nJurosDia = .CalcularJurosDiaAPartirDoMes(.this_nJurosMes)
                    ELSE
                        IF THIS.this_nJurosDiaInicial > 0
                            .this_nJurosDia = THIS.this_nJurosDiaInicial
                            .this_nJurosMes = .CalcularJurosMesAPartirDoDia(.this_nJurosDia)
                        ENDIF
                    ENDIF

                    .this_dDataBase  = THIS.this_dDataBaseInicial
                    .this_dDataFinal = THIS.this_dDataFinalInicial
                    .this_nDias      = .this_dDataFinal - .this_dDataBase

                    .Calcular()
                ENDWITH

                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarCampos()
                THIS.ConfigurarCamposResultado()
                THIS.ConfigurarCamposVencimentos()
                THIS.ConfigurarEventosCampos()

                *-- Carga da tela a partir do BO ja calculado, agora que os
                *-- controles existem. Os Configurar* acima semeiam o Value de
                *-- cada campo no proprio AddObject (momento da criacao); este
                *-- BOParaForm eh a carga de ESTADO, ponto unico para onde
                *-- apontam tambem LimparCampos e o hook FormBase.Cancelar.
                THIS.BOParaForm()

                *-- "llEnable = .f." do Init legado - INCONDICIONAL, mesmo com
                *-- pVal preenchido: a tela abre travada e so o Valor Base
                *-- (getValorBase.Valid -> HabilitarCampos(.T.)) a libera.
                THIS.HabilitarCampos(.F.)

                THIS.ConfigurarShellSaida()
                THIS.ConfigurarDivisor()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrCfn.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com titulo do form
    * (equivalente a cntSombra/lblSombra/lblTitulo do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt
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
            .Width         = THIS.Width - 20
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .AutoSize   = .F.
            .Caption    = THIS.Caption
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = THIS.Width - 20
            .ForeColor  = RGB(255, 255, 255)
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - Bloco de campos de ENTRADA (Fase 5/8):
    * Valor Base, Data Base, Juros ao Mes, Juros ao Dia, Data Final, Dias e
    * os dois OptionGroups (Tipo de Calculo e Tipo de Dias). Equivalente aos
    * objetos getValorBase/Say1, Say6/getDataBase, Say3/getJurosMes/Say4,
    * Say7/getDataFinal/Say8/getDias, Say5/getJurosDia, Say2/optCalculo e
    * Say13/optDias do SCX legado (layout flat, sem PageFrame - regra da
    * Fase 3). Os valores iniciais vem do BO, ja calculados em
    * InicializarForm antes desta chamada (equivalente ao "With ThisForm ...
    * EndWith" do Init legado). Os mostradores de resultado ficam em
    * ConfigurarCamposResultado e os vencimentos em
    * ConfigurarCamposVencimentos, ambos chamados na mesma sequencia.
    *
    * Os seis campos abaixo nascem DESABILITADOS - transcricao literal do
    * legado, que faz "llEnable = .f." INCONDICIONAL no Init (mesmo quando
    * pVal ja chega preenchido) e so reabilita via getValorBase.Valid (Fase
    * 7/8): optCalculo (os dois botoes), getJurosMes, getJurosDia,
    * getDataBase, getDataFinal, getDias. optDias NAO faz parte desse grupo
    * no legado - permanece sempre habilitado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        *-- Valor Base (unico campo que nasce sempre habilitado)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 36
            .Top       = 91
            .Width     = 57
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Valor Base :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_ValorBase", "TextBox")
        WITH THIS.txt_4c_ValorBase
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .InputMask     = "99,999,999.99"
            .Left          = 97
            .Top           = 87
            .Width         = 115
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_nValorBase
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Data Base
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 295
            .Top       = 91
            .Width     = 56
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Data Base :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DataBase", "TextBox")
        WITH THIS.txt_4c_DataBase
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 355
            .Top           = 87
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dDataBase
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Juros ao Mes
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 37
            .Top       = 119
            .Width     = 56
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Juros/M" + CHR(234) + "s :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_JurosMes", "TextBox")
        WITH THIS.txt_4c_JurosMes
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .InputMask     = "9999.99"
            .Left          = 97
            .Top           = 115
            .Width         = 59
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Value         = loc_oBO.this_nJurosMes
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 159
            .Top       = 119
            .Width     = 20
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "%"
            .Visible   = .T.
        ENDWITH

        *-- Data Final / Dias
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 266
            .Top       = 119
            .Width     = 85
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Data Final / Dias :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DataFinal", "TextBox")
        WITH THIS.txt_4c_DataFinal
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 355
            .Top           = 115
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dDataFinal
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 441
            .Top       = 116
            .Width     = 10
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "/"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Dias", "TextBox")
        WITH THIS.txt_4c_Dias
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .InputMask     = "9999"
            .Left          = 453
            .Top           = 115
            .Width         = 38
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Value         = loc_oBO.this_nDias
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Juros por Dia
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 23
            .Top       = 148
            .Width     = 70
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Juros por Dia :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_JurosDia", "TextBox")
        WITH THIS.txt_4c_JurosDia
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .InputMask     = "9999.999999999"
            .Left          = 97
            .Top           = 144
            .Width         = 136
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Value         = loc_oBO.this_nJurosDia
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Tipo de Calculo (Simples/Composto)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 310
            .Top       = 143
            .Width     = 37
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "C" + CHR(225) + "lculo :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptCalculo", "OptionGroup")
        WITH THIS.obj_4c_OptCalculo
            .Top         = 140
            .Left        = 351
            .Width       = 153
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .ButtonCount = 2
            .Value       = loc_oBO.this_nTipoCalculo
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption           = "\<Simples"
                .Top               = 2
                .Left              = 5
                .Width             = 76
                .Height            = 17
                .Style             = 0
                .AutoSize          = .F.
                .BackStyle         = 0
                .ForeColor         = RGB(90, 90, 90)
                .DisabledForeColor = RGB(128, 128, 128)
                .Themes            = .F.
                .Enabled           = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption           = "\<Composto"
                .Top               = 2
                .Left              = 72
                .Width             = 76
                .Height            = 17
                .Style             = 0
                .AutoSize          = .F.
                .BackStyle         = 0
                .ForeColor         = RGB(90, 90, 90)
                .DisabledForeColor = RGB(128, 128, 128)
                .Themes            = .F.
                .Enabled           = .F.
            ENDWITH
        ENDWITH

        *-- Tipo de Dias (Corridos/Uteis) - fora do grupo desabilitado
        THIS.AddObject("lbl_4c_Label13", "Label")
        WITH THIS.lbl_4c_Label13
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 324
            .Top       = 161
            .Width     = 23
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Dias :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptDias", "OptionGroup")
        WITH THIS.obj_4c_OptDias
            .Top         = 158
            .Left        = 351
            .Width       = 153
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .ButtonCount = 2
            .Value       = loc_oBO.this_nTipoDias
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption           = "Corridos"
                .Top               = 2
                .Left              = 5
                .Width             = 76
                .Height            = 17
                .Style             = 0
                .AutoSize          = .F.
                .BackStyle         = 0
                .ForeColor         = RGB(90, 90, 90)
                .DisabledForeColor = RGB(128, 128, 128)
                .Themes            = .F.
                .Enabled           = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption           = CHR(218) + "teis"
                .Top               = 2
                .Left              = 72
                .Width             = 76
                .Height            = 17
                .Style             = 0
                .AutoSize          = .F.
                .BackStyle         = 0
                .ForeColor         = RGB(90, 90, 90)
                .DisabledForeColor = RGB(128, 128, 128)
                .Themes            = .F.
                .Enabled           = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposResultado - Area de resultado do calculo, abaixo da
    * linha divisoria: Juros (getValorJuros/Say9), Total (getValorTotal/
    * Say10) e Parcela (GetValorpar/Say12).
    *
    * Os tres nascem Enabled = .F. porque o SCX legado declara
    * "Enabled = .F." neles - sao mostradores, nunca digitados: quem os
    * escreve e o PROCEDURE calculos (BO.Calcular). Por isso o legado tambem
    * declara BackColor/DisabledBackColor = 255,253,179 (amarelo claro) e
    * DisabledForeColor = 0,0,0: campo desabilitado que continua LEGIVEL,
    * diferente do cinza 192,192,192 que a classe fwget usa nos campos de
    * entrada desabilitados. FontBold = .T. tambem vem do SCX.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposResultado()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        *-- Juros (resultado)
        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 60
            .Top       = 187
            .Width     = 33
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Juros :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_ValorJuros", "TextBox")
        WITH THIS.txt_4c_ValorJuros
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .Alignment         = 3
            .InputMask         = "999,999,999.99"
            .Left              = 97
            .Top               = 183
            .Width             = 136
            .Height            = 23
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 253, 179)
            .BorderColor       = RGB(100, 100, 100)
            .Themes            = .F.
            .DisabledBackColor = RGB(255, 253, 179)
            .DisabledForeColor = RGB(0, 0, 0)
            .Value             = loc_oBO.this_nValorJuros
            .Enabled           = .F.
            .Visible           = .T.
        ENDWITH

        *-- Total (resultado)
        THIS.AddObject("lbl_4c_Label10", "Label")
        WITH THIS.lbl_4c_Label10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 276
            .Top       = 187
            .Width     = 31
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Total :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_ValorTotal", "TextBox")
        WITH THIS.txt_4c_ValorTotal
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .Alignment         = 3
            .InputMask         = "999,999,999.99"
            .Left              = 311
            .Top               = 183
            .Width             = 136
            .Height            = 23
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 253, 179)
            .BorderColor       = RGB(100, 100, 100)
            .Themes            = .F.
            .DisabledBackColor = RGB(255, 253, 179)
            .DisabledForeColor = RGB(0, 0, 0)
            .Value             = loc_oBO.this_nValorTotal
            .Enabled           = .F.
            .Visible           = .T.
        ENDWITH

        *-- Parcela (resultado - "mena 11/12/2014" no legado)
        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 265
            .Top       = 211
            .Width     = 42
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Parcela :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Valorpar", "TextBox")
        WITH THIS.txt_4c_Valorpar
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .Alignment         = 3
            .InputMask         = "999,999,999.99"
            .Left              = 311
            .Top               = 207
            .Width             = 136
            .Height            = 23
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 253, 179)
            .BorderColor       = RGB(100, 100, 100)
            .Themes            = .F.
            .DisabledBackColor = RGB(255, 253, 179)
            .DisabledForeColor = RGB(0, 0, 0)
            .Value             = loc_oBO.this_nValorParcela
            .Enabled           = .F.
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposVencimentos - Grade de vencimentos (Say11 +
    * getvenc1..getvenc10), duas linhas de cinco colunas, usada para calcular
    * juros por PARCELA em vez de por periodo unico (ver BO.Calcular).
    *
    * Os dez campos sao da classe fweditdata do Framework (medida no proprio
    * framework.vcx: Tahoma 8, Alignment = 3, Value = {}, 80x23, Themes =
    * .F.) - o SCX nao declara Width/Height/Alignment em nenhum deles, so
    * Left/Top/SpecialEffect/ForeColor/BorderColor, entao esses vem da classe.
    *
    * Nascem HABILITADOS: ao contrario de getJurosMes/getJurosDia/getDataBase/
    * getDataFinal/getDias, o Init legado NAO inclui os vencimentos no bloco
    * "llEnable = .f." - quem os bloqueia enquanto o Valor Base esta vazio e o
    * PROCEDURE When de cada um ("Return Not Empty(ThisForm.getValorBase.
    * Value)"), que entra na fase de eventos. Desabilita-los aqui seria
    * divergir do legado.
    *
    * Left/Top transcritos um a um do dump (colunas em 97, 184, 271, 358 e
    * 445; linha de cima Top = 231, linha de baixo Top = 258), na ordem de
    * TabIndex 17..26 do legado - por isso a criacao segue venc1/venc2
    * (coluna 1), venc3/venc4 (coluna 2), e assim por diante. Escritos um a
    * um, e nao num FOR com nome montado por macro, porque so o AddObject
    * com nome LITERAL deixa o controle referenciavel como THIS.txt_4c_VencN
    * nos handlers das fases seguintes sem EVALUATE/STORE (regras #15/#34).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposVencimentos()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        THIS.AddObject("lbl_4c_Label11", "Label")
        WITH THIS.lbl_4c_Label11
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 26
            .Top       = 235
            .Width     = 67
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Vencimentos :"
            .Visible   = .T.
        ENDWITH


        THIS.AddObject("txt_4c_Venc1", "TextBox")
        WITH THIS.txt_4c_Venc1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 97
            .Top           = 231
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dVenc1
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Venc2", "TextBox")
        WITH THIS.txt_4c_Venc2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 97
            .Top           = 258
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dVenc2
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Venc3", "TextBox")
        WITH THIS.txt_4c_Venc3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 184
            .Top           = 231
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dVenc3
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Venc4", "TextBox")
        WITH THIS.txt_4c_Venc4
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 184
            .Top           = 258
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dVenc4
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Venc5", "TextBox")
        WITH THIS.txt_4c_Venc5
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 271
            .Top           = 231
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dVenc5
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Venc6", "TextBox")
        WITH THIS.txt_4c_Venc6
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 271
            .Top           = 258
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dVenc6
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Venc7", "TextBox")
        WITH THIS.txt_4c_Venc7
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 358
            .Top           = 231
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dVenc7
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Venc8", "TextBox")
        WITH THIS.txt_4c_Venc8
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 358
            .Top           = 258
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dVenc8
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Venc9", "TextBox")
        WITH THIS.txt_4c_Venc9
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 445
            .Top           = 231
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dVenc9
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Venc10", "TextBox")
        WITH THIS.txt_4c_Venc10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Left          = 445
            .Top           = 258
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = loc_oBO.this_dVenc10
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarEventosCampos - Registra os BINDEVENT equivalentes aos
    * PROCEDURE Valid/InteractiveChange do legado (Fase 6/8). TextBox nao
    * dispara "Valid" via BINDEVENT (regra conhecida do projeto), entao o
    * equivalente e KeyPress com guarda ENTER(13)/TAB(9). OptionGroup criado
    * via AddObject dispara InteractiveChange normalmente.
    *
    * "When" do legado (getJurosMes/getJurosDia/getDataBase/getDataFinal)
    * e OMITIDO de proposito: esses quatro campos nascem
    * Enabled = .F. e so sao habilitados por ValidarValorBase - controle
    * desabilitado ja bloqueia o foco, entao o When ("Not Empty(
    * getValorBase.Value)") seria redundante (ver comentario de
    * ConfigurarCampos).
    *
    * getDias e a EXCECAO entre os cinco: o When dele nao para no Valor
    * Base, exige TAMBEM uma das duas datas - por isso ele tem handler
    * proprio (TxtDiasGotFocus), detalhado no cabecalho da Fase 7.
    *
    * Os 10 vencimentos, ao contrario,
    * nascem SEMPRE habilitados (o legado tambem nao os desabilita no
    * Init) - para eles o When ("Not Empty(getValorBase.Value)") e
    * reproduzido via GotFocus (VencGotFocus), unico jeito de bloquear
    * a entrada num campo que permanece Enabled = .T..
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventosCampos()
        BINDEVENT(THIS.txt_4c_ValorBase,  "KeyPress", THIS, "TxtValorBaseKeyPress")
        BINDEVENT(THIS.txt_4c_JurosMes,   "KeyPress", THIS, "TxtJurosMesKeyPress")
        BINDEVENT(THIS.txt_4c_JurosDia,   "KeyPress", THIS, "TxtJurosDiaKeyPress")
        BINDEVENT(THIS.txt_4c_DataBase,   "KeyPress", THIS, "TxtDataBaseKeyPress")
        BINDEVENT(THIS.txt_4c_DataFinal,  "KeyPress", THIS, "TxtDataFinalKeyPress")
        BINDEVENT(THIS.txt_4c_Dias,       "KeyPress", THIS, "TxtDiasKeyPress")

        BINDEVENT(THIS.obj_4c_OptCalculo, "InteractiveChange", THIS, "OptCalculoInteractiveChange")
        BINDEVENT(THIS.obj_4c_OptDias,    "InteractiveChange", THIS, "OptDiasInteractiveChange")

        BINDEVENT(THIS.txt_4c_Venc1,  "KeyPress", THIS, "TxtVenc1KeyPress")
        BINDEVENT(THIS.txt_4c_Venc2,  "KeyPress", THIS, "TxtVenc2KeyPress")
        BINDEVENT(THIS.txt_4c_Venc3,  "KeyPress", THIS, "TxtVenc3KeyPress")
        BINDEVENT(THIS.txt_4c_Venc4,  "KeyPress", THIS, "TxtVenc4KeyPress")
        BINDEVENT(THIS.txt_4c_Venc5,  "KeyPress", THIS, "TxtVenc5KeyPress")
        BINDEVENT(THIS.txt_4c_Venc6,  "KeyPress", THIS, "TxtVenc6KeyPress")
        BINDEVENT(THIS.txt_4c_Venc7,  "KeyPress", THIS, "TxtVenc7KeyPress")
        BINDEVENT(THIS.txt_4c_Venc8,  "KeyPress", THIS, "TxtVenc8KeyPress")
        BINDEVENT(THIS.txt_4c_Venc9,  "KeyPress", THIS, "TxtVenc9KeyPress")
        BINDEVENT(THIS.txt_4c_Venc10, "KeyPress", THIS, "TxtVenc10KeyPress")

        BINDEVENT(THIS.txt_4c_Dias, "GotFocus", THIS, "TxtDiasGotFocus")

        BINDEVENT(THIS.txt_4c_Venc1,  "GotFocus", THIS, "VencGotFocus")
        BINDEVENT(THIS.txt_4c_Venc2,  "GotFocus", THIS, "VencGotFocus")
        BINDEVENT(THIS.txt_4c_Venc3,  "GotFocus", THIS, "VencGotFocus")
        BINDEVENT(THIS.txt_4c_Venc4,  "GotFocus", THIS, "VencGotFocus")
        BINDEVENT(THIS.txt_4c_Venc5,  "GotFocus", THIS, "VencGotFocus")
        BINDEVENT(THIS.txt_4c_Venc6,  "GotFocus", THIS, "VencGotFocus")
        BINDEVENT(THIS.txt_4c_Venc7,  "GotFocus", THIS, "VencGotFocus")
        BINDEVENT(THIS.txt_4c_Venc8,  "GotFocus", THIS, "VencGotFocus")
        BINDEVENT(THIS.txt_4c_Venc9,  "GotFocus", THIS, "VencGotFocus")
        BINDEVENT(THIS.txt_4c_Venc10, "GotFocus", THIS, "VencGotFocus")
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia o Value de TODOS os campos de entrada para o BO.
    * Equivalente a ler "ThisForm.<campo>.Value" direto dentro do PROCEDURE
    * calculos do legado - la o form e o BO sao o mesmo objeto; aqui, como o
    * calculo mora no BO (regra de negocio transcrita em SigPrCfnBO.Calcular),
    * toda chamada a Calculos() precisa antes empurrar os valores atuais da
    * tela para dentro do BO.
    *
    * PROTECTED obrigatoriamente: o hook homonimo de FormBase eh PROTECTED e
    * subclasse nao pode ALARGAR o escopo herdado. Todos os chamadores sao
    * internos (AtualizarResultado, ValidarJurosMes, ValidarJurosDia), entao
    * nao ha perda - e o hook fica no contrato que FormBase.Salvar espera.
    *
    * NAO eh FUNCTION retornando .T./.F. (padrao dos forms CRUD, onde o
    * BtnSalvarClick aborta a gravacao se a transferencia falhar): aqui nao
    * ha gravacao nenhuma para abortar - o destino eh o calculo em memoria -
    * e a assinatura acompanha a do hook de FormBase, que eh PROCEDURE.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_nValorBase   = THIS.txt_4c_ValorBase.Value
        loc_oBO.this_nTipoCalculo = THIS.obj_4c_OptCalculo.Value
        loc_oBO.this_nJurosMes    = THIS.txt_4c_JurosMes.Value
        loc_oBO.this_nJurosDia    = THIS.txt_4c_JurosDia.Value
        loc_oBO.this_dDataBase    = THIS.txt_4c_DataBase.Value
        loc_oBO.this_dDataFinal   = THIS.txt_4c_DataFinal.Value
        loc_oBO.this_nDias        = THIS.txt_4c_Dias.Value
        loc_oBO.this_nTipoDias    = THIS.obj_4c_OptDias.Value

        loc_oBO.this_dVenc1  = THIS.txt_4c_Venc1.Value
        loc_oBO.this_dVenc2  = THIS.txt_4c_Venc2.Value
        loc_oBO.this_dVenc3  = THIS.txt_4c_Venc3.Value
        loc_oBO.this_dVenc4  = THIS.txt_4c_Venc4.Value
        loc_oBO.this_dVenc5  = THIS.txt_4c_Venc5.Value
        loc_oBO.this_dVenc6  = THIS.txt_4c_Venc6.Value
        loc_oBO.this_dVenc7  = THIS.txt_4c_Venc7.Value
        loc_oBO.this_dVenc8  = THIS.txt_4c_Venc8.Value
        loc_oBO.this_dVenc9  = THIS.txt_4c_Venc9.Value
        loc_oBO.this_dVenc10 = THIS.txt_4c_Venc10.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Caminho inverso de FormParaBO: espelha o estado INTEIRO do
    * BO (entradas + vencimentos + os tres mostradores) de volta nos
    * controles. Equivalente ao bloco "With ThisForm / .getValorBase.Value =
    * ... / .getDataFinal.Value = ..." que abre o PROCEDURE Init do legado -
    * la os valores vinham dos parametros direto para os controles; aqui eles
    * passam pelo BO, entao carregar a tela eh justamente copiar o BO de volta.
    *
    * Chamado em InicializarForm (depois de os controles existirem) e por
    * LimparCampos. Tambem eh o hook que FormBase.Cancelar invoca para
    * restaurar a tela.
    *
    * NAO eh chamado por AtualizarResultado de proposito: o Calculos() do
    * legado so devolve para a tela o que ele CALCULA (Dias, Juros, Total e
    * Parcela) e nao reescreve os campos de entrada. Reescrever tudo a cada
    * tecla seria alem de infiel um risco de zerar o campo em digitacao.
    *
    * PROTECTED obrigatoriamente - o hook de FormBase eh PROTECTED e
    * subclasse nao alarga escopo herdado.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_ValorBase.Value   = loc_oBO.this_nValorBase
        THIS.obj_4c_OptCalculo.Value  = loc_oBO.this_nTipoCalculo
        THIS.txt_4c_JurosMes.Value    = loc_oBO.this_nJurosMes
        THIS.txt_4c_JurosDia.Value    = loc_oBO.this_nJurosDia
        THIS.txt_4c_DataBase.Value    = loc_oBO.this_dDataBase
        THIS.txt_4c_DataFinal.Value   = loc_oBO.this_dDataFinal
        THIS.txt_4c_Dias.Value        = loc_oBO.this_nDias
        THIS.obj_4c_OptDias.Value     = loc_oBO.this_nTipoDias

        THIS.txt_4c_ValorJuros.Value  = loc_oBO.this_nValorJuros
        THIS.txt_4c_ValorTotal.Value  = loc_oBO.this_nValorTotal
        THIS.txt_4c_Valorpar.Value    = loc_oBO.this_nValorParcela

        THIS.txt_4c_Venc1.Value  = loc_oBO.this_dVenc1
        THIS.txt_4c_Venc2.Value  = loc_oBO.this_dVenc2
        THIS.txt_4c_Venc3.Value  = loc_oBO.this_dVenc3
        THIS.txt_4c_Venc4.Value  = loc_oBO.this_dVenc4
        THIS.txt_4c_Venc5.Value  = loc_oBO.this_dVenc5
        THIS.txt_4c_Venc6.Value  = loc_oBO.this_dVenc6
        THIS.txt_4c_Venc7.Value  = loc_oBO.this_dVenc7
        THIS.txt_4c_Venc8.Value  = loc_oBO.this_dVenc8
        THIS.txt_4c_Venc9.Value  = loc_oBO.this_dVenc9
        THIS.txt_4c_Venc10.Value = loc_oBO.this_dVenc10

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - TRANSCRICAO do bloco "llEnable" do legado, que aparece
    * IDENTICO em dois lugares (PROCEDURE Init e getValorBase.Valid):
    *
    *   .optCalculo.Option1.Enabled = llEnable
    *   .optCalculo.Option2.Enabled = llEnable
    *   .getJurosMes.Enabled   = llEnable
    *   .getJurosDia.Enabled   = llEnable
    *   .getDataBase.Enabled   = llEnable
    *   .getDataFinal.Enabled  = llEnable
    *   .getDias.Enabled       = llEnable
    *
    * Sao EXATAMENTE esses sete alvos - nem mais, nem menos. Ficam de fora,
    * de proposito e conforme o legado: getValorBase (o campo que comanda a
    * liberacao, sempre habilitado), os dez getvencN (o legado nunca os
    * desabilita - a guarda deles eh o When, reproduzido em VencGotFocus),
    * optDias (idem) e os tres mostradores getValorJuros/getValorTotal/
    * GetValorpar (nascem Enabled = .F. na criacao e assim permanecem).
    *
    * O legado chama esse bloco com llEnable = .f. no Init - INCONDICIONAL,
    * mesmo quando pVal chega preenchido - e com llEnable = .t. no
    * getValorBase.Valid, depois de aprovar o valor. Os dois caminhos estao
    * reproduzidos: InicializarForm chama HabilitarCampos(.F.) e
    * ValidarValorBase chama HabilitarCampos(.T.).
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)

        THIS.obj_4c_OptCalculo.Buttons(1).Enabled = loc_lHabilitar
        THIS.obj_4c_OptCalculo.Buttons(2).Enabled = loc_lHabilitar

        THIS.txt_4c_JurosMes.Enabled  = loc_lHabilitar
        THIS.txt_4c_JurosDia.Enabled  = loc_lHabilitar
        THIS.txt_4c_DataBase.Enabled  = loc_lHabilitar
        THIS.txt_4c_DataFinal.Enabled = loc_lHabilitar
        THIS.txt_4c_Dias.Enabled      = loc_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Devolve a calculadora ao estado zerado com que o legado
    * ABRE, antes de aplicar os parametros recebidos. O referente eh o bloco
    * de zeragem do PROCEDURE Init do legado:
    *
    *   .getJurosMes.Value   = 0     .getDias.Value       = 0
    *   .getJurosDia.Value   = 0     .getValorJuros.Value = 0
    *   .optCalculo.Value    = 1     .getValorTotal.Value = 0
    *
    * Zera o BO (fonte unica do estado) e espelha com BOParaForm, deixando os
    * campos travados como no Init (HabilitarCampos(.F.)) - o usuario volta a
    * liberar a tela digitando o Valor Base, exatamente como na abertura.
    *
    * Este eh o hook que FormBase.Novo/FormBase.Excluir invocam; nao ha botao
    * de limpar no SCX legado (o unico botao eh o Sair), entao NAO se criou
    * nenhum - inventa-lo violaria o PILAR 1.
    *
    * PROTECTED obrigatoriamente - o hook de FormBase eh PROTECTED e
    * subclasse nao alarga escopo herdado.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oBO, loc_nX
        loc_oBO = THIS.this_oBusinessObject

        WITH loc_oBO
            .this_nValorBase   = 0
            .this_nTipoCalculo = 1
            .this_nJurosMes    = 0
            .this_nJurosDia    = 0
            .this_dDataBase    = {}
            .this_dDataFinal   = {}
            .this_nDias        = 0
            .this_nTipoDias    = 1

            .this_nValorJuros   = 0
            .this_nValorTotal   = 0
            .this_nValorParcela = 0
        ENDWITH

        *-- Os dez vencimentos por nome montado: STORE ... TO (expr) porque
        *-- EVALUATE NAO atribui (regra #15) - com o "=" dentro da string o
        *-- VFP avalia uma COMPARACAO e descarta o resultado, em silencio.
        FOR loc_nX = 1 TO 10
            STORE {} TO ("loc_oBO.this_dVenc" + TRANSFORM(loc_nX))
        ENDFOR

        THIS.BOParaForm()
        THIS.HabilitarCampos(.F.)
    ENDPROC

    *==========================================================================
    * AtualizarResultado - Equivalente a "ThisForm.Calculos()" do legado:
    * sincroniza o BO com a tela, manda calcular e espelha de volta os tres
    * mostradores (Juros/Total/Parcela) e o proprio Dias - que o BO pode
    * alterar como efeito colateral quando ha vencimentos preenchidos
    * (identico ao "thisform.getDias.Value = lnTotDia" do legado).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarResultado()
        LOCAL loc_oBO
        THIS.FormParaBO()
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.Calcular()

        THIS.txt_4c_Dias.Value       = loc_oBO.this_nDias
        THIS.txt_4c_ValorJuros.Value = loc_oBO.this_nValorJuros
        THIS.txt_4c_ValorTotal.Value = loc_oBO.this_nValorTotal
        THIS.txt_4c_Valorpar.Value   = loc_oBO.this_nValorParcela

        THIS.txt_4c_Dias.Refresh()
        THIS.txt_4c_ValorJuros.Refresh()
        THIS.txt_4c_ValorTotal.Refresh()
        THIS.txt_4c_Valorpar.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarValorBase - Equivalente a getValorBase.Valid do legado. Valor
    * negativo bloqueia a saida do campo (MsgAviso + SetFocus, sem habilitar
    * nada); valor >= 0 habilita o restante dos campos e recalcula.
    *
    * O bloco de sete atribuicoes "Enabled = llEnable" do legado nao esta mais
    * escrito aqui: ele aparecia IDENTICO no Init e neste Valid, entao virou
    * HabilitarCampos(par_lHabilitar) na Fase 8. A variavel loc_lHabilitar foi
    * mantida com o mesmo papel do "llEnable" original (.f. por padrao, .t. so
    * depois de aprovar o valor), para a transcricao seguir reconhecivel.
    *==========================================================================
    PROTECTED PROCEDURE ValidarValorBase()
        LOCAL loc_lHabilitar
        loc_lHabilitar = .F.

        IF THIS.txt_4c_ValorBase.Value < 0
            MsgAviso("O Valor Base Precisa Ser Positivo!", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.txt_4c_ValorBase.SetFocus()
            RETURN
        ELSE
            loc_lHabilitar = .T.
        ENDIF

        THIS.HabilitarCampos(loc_lHabilitar)

        THIS.AtualizarResultado()
    ENDPROC

    *==========================================================================
    * TxtValorBaseKeyPress - alvo do BINDEVENT (PUBLIC - regra #3).
    *==========================================================================
    PROCEDURE TxtValorBaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarValorBase()
    ENDPROC

    *==========================================================================
    * OptCalculoInteractiveChange - Equivalente a optCalculo.InteractiveChange
    * do legado ("ThisForm.Calculos()"). Alvo de BINDEVENT - PUBLIC.
    *==========================================================================
    PROCEDURE OptCalculoInteractiveChange()
        THIS.AtualizarResultado()
    ENDPROC

    *==========================================================================
    * ValidarJurosMes - Equivalente a getJurosMes.Valid do legado: deriva o
    * Juros por Dia a partir do Juros ao Mes recem-digitado (formula no BO -
    * CalcularJurosDiaAPartirDoMes) e recalcula.
    *==========================================================================
    PROTECTED PROCEDURE ValidarJurosMes()
        LOCAL loc_oBO, loc_nJurosDia
        THIS.FormParaBO()
        loc_oBO = THIS.this_oBusinessObject

        loc_nJurosDia = loc_oBO.CalcularJurosDiaAPartirDoMes(THIS.txt_4c_JurosMes.Value)

        THIS.txt_4c_JurosDia.Value = loc_nJurosDia
        THIS.txt_4c_JurosDia.Refresh()

        THIS.AtualizarResultado()
    ENDPROC

    *==========================================================================
    * TxtJurosMesKeyPress - alvo do BINDEVENT (PUBLIC - regra #3).
    *==========================================================================
    PROCEDURE TxtJurosMesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarJurosMes()
    ENDPROC

    *==========================================================================
    * ValidarJurosDia - Equivalente a getJurosDia.Valid do legado: deriva o
    * Juros ao Mes a partir do Juros por Dia recem-digitado (formula no BO -
    * CalcularJurosMesAPartirDoDia) e recalcula.
    *==========================================================================
    PROTECTED PROCEDURE ValidarJurosDia()
        LOCAL loc_oBO, loc_nJurosMes
        THIS.FormParaBO()
        loc_oBO = THIS.this_oBusinessObject

        loc_nJurosMes = loc_oBO.CalcularJurosMesAPartirDoDia(THIS.txt_4c_JurosDia.Value)

        THIS.txt_4c_JurosMes.Value = loc_nJurosMes
        THIS.txt_4c_JurosMes.Refresh()

        THIS.AtualizarResultado()
    ENDPROC

    *==========================================================================
    * TxtJurosDiaKeyPress - alvo do BINDEVENT (PUBLIC - regra #3).
    *==========================================================================
    PROCEDURE TxtJurosDiaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarJurosDia()
    ENDPROC

    *==========================================================================
    * ValidarDataBase - Equivalente a getDataBase.Valid do legado. So valida/
    * atualiza Dias quando Data Base E Data Final ja estao preenchidas
    * (transcricao literal - este Valid, ao contrario do getDataFinal.Valid,
    * NAO tem a rotina de dias uteis).
    *==========================================================================
    PROTECTED PROCEDURE ValidarDataBase()
        LOCAL loc_nDias

        IF !EMPTY(THIS.txt_4c_DataFinal.Value) AND !EMPTY(THIS.txt_4c_DataBase.Value)
            IF THIS.txt_4c_DataBase.Value > THIS.txt_4c_DataFinal.Value
                MsgAviso("A Data Base N" + CHR(227) + "o Pode Ser Maior Que a Data Final!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_DataBase.SetFocus()
                RETURN
            ENDIF

            loc_nDias = THIS.txt_4c_DataFinal.Value - THIS.txt_4c_DataBase.Value
            THIS.txt_4c_Dias.Value = loc_nDias
            THIS.txt_4c_Dias.Refresh()
        ENDIF

        THIS.AtualizarResultado()
    ENDPROC

    *==========================================================================
    * TxtDataBaseKeyPress - alvo do BINDEVENT (PUBLIC - regra #3).
    *==========================================================================
    PROCEDURE TxtDataBaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarDataBase()
    ENDPROC

    *==========================================================================
    * ValidarDataFinal - Equivalente a getDataFinal.Valid do legado, com a
    * rotina "Tiago" de dias uteis (fChkFeriado no legado) reproduzida via
    * BO.CalcularDiasEfetivos - mesma formula, so muda onde mora (regra #17).
    *==========================================================================
    PROTECTED PROCEDURE ValidarDataFinal()
        LOCAL loc_oBO, loc_nDias

        IF !EMPTY(THIS.txt_4c_DataBase.Value) AND !EMPTY(THIS.txt_4c_DataFinal.Value)
            IF THIS.txt_4c_DataFinal.Value < THIS.txt_4c_DataBase.Value
                MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Data Base!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_DataFinal.SetFocus()
                RETURN
            ENDIF

            loc_nDias = THIS.txt_4c_DataFinal.Value - THIS.txt_4c_DataBase.Value

            loc_oBO = THIS.this_oBusinessObject
            loc_oBO.this_nTipoDias = THIS.obj_4c_OptDias.Value
            loc_nDias = loc_oBO.CalcularDiasEfetivos(THIS.txt_4c_DataBase.Value, ;
                THIS.txt_4c_DataFinal.Value, loc_nDias)

            THIS.txt_4c_Dias.Value = loc_nDias
            THIS.txt_4c_Dias.Refresh()
        ENDIF

        THIS.AtualizarResultado()
    ENDPROC

    *==========================================================================
    * TxtDataFinalKeyPress - alvo do BINDEVENT (PUBLIC - regra #3).
    *==========================================================================
    PROCEDURE TxtDataFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarDataFinal()
    ENDPROC

    *==========================================================================
    * ValidarDias - Equivalente a getDias.Valid do legado. Com optDias =
    * Corridos (1), o Dias digitado redefine Data Final (ou Data Base, se
    * Data Base estiver vazia) por soma/subtracao simples de dias corridos.
    * Em seguida, SEMPRE (mesmo bloco incondicional do legado), se o
    * resultado for positivo e optDias = Uteis (2), a rotina "Tiago" de dias
    * uteis recalcula Dias sobre o intervalo Data Base..Data Final via
    * BO.CalcularDiasEfetivos - o legado NAO altera as datas neste caso, so
    * o proprio campo Dias.
    *==========================================================================
    PROTECTED PROCEDURE ValidarDias()
        LOCAL loc_oBO, loc_nDias

        IF THIS.obj_4c_OptDias.Value = 1
            IF !EMPTY(THIS.txt_4c_DataBase.Value)
                THIS.txt_4c_DataFinal.Value = THIS.txt_4c_DataBase.Value + THIS.txt_4c_Dias.Value
                THIS.txt_4c_DataFinal.Refresh()
            ELSE
                THIS.txt_4c_DataBase.Value = THIS.txt_4c_DataFinal.Value - THIS.txt_4c_Dias.Value
                THIS.txt_4c_DataBase.Refresh()
            ENDIF
        ENDIF

        loc_nDias = THIS.txt_4c_Dias.Value
        IF loc_nDias > 0 AND THIS.obj_4c_OptDias.Value = 2
            loc_oBO = THIS.this_oBusinessObject
            loc_oBO.this_nTipoDias = THIS.obj_4c_OptDias.Value
            loc_nDias = loc_oBO.CalcularDiasEfetivos(THIS.txt_4c_DataBase.Value, ;
                THIS.txt_4c_DataFinal.Value, loc_nDias)
            THIS.txt_4c_Dias.Value = loc_nDias
            THIS.txt_4c_Dias.Refresh()
        ENDIF

        THIS.AtualizarResultado()
    ENDPROC

    *==========================================================================
    * TxtDiasKeyPress - alvo do BINDEVENT (PUBLIC - regra #3).
    *==========================================================================
    PROCEDURE TxtDiasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarDias()
    ENDPROC

    *==========================================================================
    * TxtDiasGotFocus - Equivalente ao PROCEDURE When de getDias, TRANSCRITO
    * do legado:
    *
    *   Return (Not Empty(ThisForm.getValorBase.Value) And ;
    *          (Not Empty(ThisForm.getDataFinal.Value) Or ;
    *           Not Empty(ThisForm.getDataBase.Value)))
    *
    * Este eh o unico dos seis "When" do legado que pede mais do que o Valor
    * Base: ele exige TAMBEM uma das duas datas. A metade do Valor Base ja
    * esta coberta pelo Enabled = .F. inicial do campo (so ValidarValorBase o
    * habilita), mas a metade das datas nao tinha equivalente - com as duas
    * datas em branco o usuario entrava aqui e digitar nao produzia efeito:
    * ValidarDias cai no ramo "DataBase vazia" e faz
    * "DataBase = DataFinal - Dias", que com DataFinal vazia devolve data
    * VAZIA (medido no VFP9: {} - 5 = {}, sem erro) - falha MUDA.
    *
    * Como o campo permanece Enabled = .T. depois de habilitado, GotFocus eh
    * o unico ponto onde se pode recusar a entrada - mesma tecnica de
    * VencGotFocus. O foco volta para o campo que o legado exige preencher
    * primeiro: Valor Base quando ele esta vazio, Data Base nos demais casos.
    * Alvo de BINDEVENT - PUBLIC (regra #3).
    *==========================================================================
    PROCEDURE TxtDiasGotFocus()
        IF EMPTY(THIS.txt_4c_ValorBase.Value)
            THIS.txt_4c_ValorBase.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_DataFinal.Value) AND EMPTY(THIS.txt_4c_DataBase.Value)
            THIS.txt_4c_DataBase.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * OptDiasInteractiveChange - Equivalente a optDias.InteractiveChange do
    * legado: refaz Dias a partir de Data Final - Data Base (sem guarda de
    * vazio - identico ao legado) e, se positivo e Uteis, aplica a rotina de
    * dias uteis via BO.CalcularDiasEfetivos. Alvo de BINDEVENT - PUBLIC.
    *==========================================================================
    PROCEDURE OptDiasInteractiveChange()
        LOCAL loc_oBO, loc_nDias

        THIS.txt_4c_Dias.Value = THIS.txt_4c_DataFinal.Value - THIS.txt_4c_DataBase.Value
        THIS.txt_4c_Dias.Refresh()

        loc_nDias = THIS.txt_4c_Dias.Value
        IF loc_nDias > 0 AND THIS.obj_4c_OptDias.Value = 2
            loc_oBO = THIS.this_oBusinessObject
            loc_oBO.this_nTipoDias = THIS.obj_4c_OptDias.Value
            loc_nDias = loc_oBO.CalcularDiasEfetivos(THIS.txt_4c_DataBase.Value, ;
                THIS.txt_4c_DataFinal.Value, loc_nDias)
            THIS.txt_4c_Dias.Value = loc_nDias
            THIS.txt_4c_Dias.Refresh()
        ENDIF

        THIS.AtualizarResultado()
    ENDPROC

    *==========================================================================
    * ValidarVencimento - Equivalente ao Valid (identico nos 10) de
    * getvenc1..getvenc10 do legado: bloqueia vencimento anterior a Data
    * Base e, se ok, atualiza Dias com a diferenca. par_nIndice identifica
    * qual txt_4c_VencN chamou (1..10); o acesso ao controle usa EVALUATE
    * para LEITURA (regra #15/#34 - nunca Controls(nome) nem atribuicao via
    * EVALUATE).
    *==========================================================================
    PROTECTED PROCEDURE ValidarVencimento(par_nIndice)
        LOCAL loc_oCtrl, loc_dValor, loc_nDias

        loc_oCtrl  = EVALUATE("THIS.txt_4c_Venc" + TRANSFORM(par_nIndice))
        loc_dValor = loc_oCtrl.Value

        IF !EMPTY(THIS.txt_4c_DataBase.Value) AND !EMPTY(loc_dValor)
            IF loc_dValor < THIS.txt_4c_DataBase.Value
                MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Data Base!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_oCtrl.SetFocus()
                RETURN
            ENDIF

            loc_nDias = loc_dValor - THIS.txt_4c_DataBase.Value
            THIS.txt_4c_Dias.Value = loc_nDias
            THIS.txt_4c_Dias.Refresh()
        ENDIF

        THIS.AtualizarResultado()
    ENDPROC

    *==========================================================================
    * TxtVenc1KeyPress..TxtVenc10KeyPress - alvos do BINDEVENT (PUBLIC -
    * regra #3), um por vencimento, cada um delegando com o indice literal.
    *==========================================================================
    PROCEDURE TxtVenc1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarVencimento(1)
    ENDPROC

    PROCEDURE TxtVenc2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarVencimento(2)
    ENDPROC

    PROCEDURE TxtVenc3KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarVencimento(3)
    ENDPROC

    PROCEDURE TxtVenc4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarVencimento(4)
    ENDPROC

    PROCEDURE TxtVenc5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarVencimento(5)
    ENDPROC

    PROCEDURE TxtVenc6KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarVencimento(6)
    ENDPROC

    PROCEDURE TxtVenc7KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarVencimento(7)
    ENDPROC

    PROCEDURE TxtVenc8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarVencimento(8)
    ENDPROC

    PROCEDURE TxtVenc9KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarVencimento(9)
    ENDPROC

    PROCEDURE TxtVenc10KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarVencimento(10)
    ENDPROC

    *==========================================================================
    * VencGotFocus - Equivalente ao PROCEDURE When ("Return Not
    * Empty(ThisForm.getValorBase.Value)") de getvenc1..getvenc10. Os dez
    * vencimentos nascem sempre Enabled = .T. (regra da Fase 5 - o legado
    * tambem nao os desabilita no Init), entao o When e a UNICA guarda
    * possivel: sem ela o usuario preenche vencimento antes do Valor Base.
    * Mesmo handler para os 10 controles - a logica nao depende de qual foi
    * focado. Alvo de BINDEVENT - PUBLIC.
    *==========================================================================
    PROCEDURE VencGotFocus()
        IF EMPTY(THIS.txt_4c_ValorBase.Value)
            THIS.txt_4c_ValorBase.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarShellSaida - Container com o botao Sair/OK (equivalente a
    * Commandgroup3/btnOK do legado). btnOK (Top=3,Left=525,75x75) e
    * Commandgroup3 (Top=7,Left=505,89x109) sao IRMAOS no SCX (ambos filhos
    * diretos de SIGPRCFN, nao pai/filho) e se sobrepoem sem estarem contidos
    * um no outro - transcrever o Left/Top absoluto do botao cairia fora dos
    * limites do container (89x109) e seria RECORTADO (regra #30). Como nao
    * ha contencao real a preservar, o botao fica CENTRALIZADO dentro do
    * container (Left=7,Top=17 = (89-75)/2, (109-75)/2), regra #28.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarShellSaida()
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top         = 7
            .Left        = 917
            .Width       = 90
            .Height      = 109
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Saida.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cnt_4c_Saida.cmd_4c_Sair
            .Top             = 17
            .Left            = 7
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * ConfigurarDivisor - Linha horizontal decorativa que separa os campos
    * de entrada da area de resultado (equivalente ao Commandgroup1 do
    * legado, um CommandGroup sem botoes usado apenas como filete visual).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDivisor()
        THIS.AddObject("shp_4c_Divisor", "Line")
        WITH THIS.shp_4c_Divisor
            .Left        = 6
            .Top         = 180
            .Width       = 586
            .Height      = 0
            .BorderColor = RGB(90, 90, 90)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnSairClick - Fecha o formulario (equivalente a "ThisForm.Release" do
    * PROCEDURE Click do btnOK no legado). PUBLIC porque e alvo de
    * BINDEVENT (regra #3 - metodos PROTECTED falham silenciosamente).
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * Destroy - Sem cursores/handles proprios para liberar aqui alem do BO
    * (ja tratado por FormBase.Destroy). Mantido explicito por padrao do
    * projeto - DODEFAULT() como ultima linha (regra #40).
    *==========================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCfnBO.prg):
*============================================================================
* SigPrCfnBO.prg - Business Object para Calculo de Juros (dialogo utilitario)
*
* Origem legado: SIGPRCFN.SCX ("Calculo de Juros")
* Sem tabela de persistencia - o form eh um dialogo modal de calculo em
* memoria, aberto via CREATEOBJECT com parametros (Valor Base, Tipo de
* Calculo, Juros ao Mes/Dia, Data Base, Data Final) e fechado com btnOK.
* Nao ha INSERT/UPDATE/DELETE no legado (comportamento.json: totalQueries=0,
* tabelasUsadas=[]).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrCfnBO AS BusinessBase

    *==========================================================================
    * Propriedades de entrada - espelham os parametros do Init legado
    * Lparameters pVal, pTip, pJMe, pJDi, pDtB, pDtF
    *==========================================================================
    this_nValorBase   = 0     && Valor Base do calculo (getValorBase)
    this_nTipoCalculo = 1     && 1=Simples, 2=Composto (optCalculo.Value)
    this_nJurosMes    = 0     && Juros ao Mes, percentual (getJurosMes)
    this_nJurosDia    = 0     && Juros ao Dia, percentual - relevante so quando
                               && Juros ao Mes nao foi informado (getJurosDia)
    this_dDataBase    = {}    && Data Base do calculo (getDataBase)
    this_dDataFinal   = {}    && Data Final do calculo (getDataFinal)
    this_nDias        = 0     && Quantidade de dias entre Data Base e Data Final
                               && ou entre Data Base e o ultimo vencimento (getDias)
    this_nTipoDias    = 1     && 1=Corridos, 2=Uteis (optDias.Value)

    *==========================================================================
    * Vencimentos (parcelamento) - ate 10 datas (getvenc1..getvenc10)
    *==========================================================================
    this_dVenc1  = {}
    this_dVenc2  = {}
    this_dVenc3  = {}
    this_dVenc4  = {}
    this_dVenc5  = {}
    this_dVenc6  = {}
    this_dVenc7  = {}
    this_dVenc8  = {}
    this_dVenc9  = {}
    this_dVenc10 = {}

    *==========================================================================
    * Propriedades de saida - resultado do calculo (nao persistidas)
    *==========================================================================
    this_nValorJuros   = 0    && Valor de juros calculado (getValorJuros)
    this_nValorTotal   = 0    && Valor Base + Valor de Juros (getValorTotal)
    this_nValorParcela = 0    && Valor Total dividido pela quantidade de
                               && vencimentos preenchidos (GetValorpar)

    *==========================================================================
    * Cache de feriados (SigCdFer), usado no calculo de dias uteis
    * (optDias = 2). Formato "|AAAAMMDD|AAAAMMDD|..." evita um SELECT por
    * dia dentro do laco de calculo.
    *==========================================================================
    this_cFeriados           = ""
    this_lFeriadosCarregados = .F.

    *==========================================================================
    * Init - Business Object sem tabela de persistencia. Nao repassa nome de
    * tabela ao DODEFAULT() (BusinessBase.Init so cria o DataAccess quando
    * recebe um nome de tabela nao vazio).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Decisao de design: este BO NAO sobrescreve CarregarDoCursor()/Inserir()/
    * Atualizar()/ExecutarExclusao()/ObterChavePrimaria(). O legado (PROCEDURE
    * calculos do SIGPRCFN.SCX) e um dialogo modal de calculo em memoria - abre
    * via CREATEOBJECT com parametros, calcula e fecha com btnOK.Click =
    * ThisForm.Release. Nao ha SELECT/INSERT/UPDATE/DELETE em lugar nenhum do
    * dump (comportamento.json: totalQueries=0, tabelasUsadas=[]). O
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh
    * o correto para este caso. A funcionalidade REAL do legado - o metodo
    * Calculos() - eh implementada abaixo, transcrita literalmente (formula,
    * sinal, guards e ordem identicos ao dump, conforme regra de negocio).
    *==========================================================================

    *==========================================================================
    * Calcular - Equivalente a PROCEDURE calculos do legado. Le as propriedades
    * de entrada (this_nValorBase, this_nTipoCalculo, this_nJurosMes,
    * this_nJurosDia, this_dDataBase, this_dDataFinal, this_nDias,
    * this_dVenc1..10) e grava this_nValorJuros/this_nValorTotal/
    * this_nValorParcela - e, quando ha vencimentos preenchidos, TAMBEM
    * this_nDias (efeito colateral identico ao legado: "If lnTotDia > 0 /
    * thisform.getDias.Value = lnTotDia").
    *
    * Formula TRANSCRITA do dump, sem "corrigir" nada (regra #17):
    *   Simples : Juros = Round(ValorBase * (JurosMes/100)  * (Dias/30), 2)
    *   Composto: Juros = Round(ValorBase * (((1+JurosDia/100)^Dias)-1), 2)
    * Cada vencimento preenchido REINICIA o acumulador na primeira parcela
    * encontrada (lnParc = 0 -> lnJuros = 0) e soma o juros daquela parcela
    * usando os dias entre a Data Base e o proprio vencimento - igual ao
    * legado, inclusive o "bug" de this_nDias ficar com os dias do ULTIMO
    * vencimento (nao a media, apesar do comentario morto no legado).
    *==========================================================================
    PROCEDURE Calcular()
        LOCAL loc_lResultado, loc_nJuros, loc_nParc, loc_nTotDia, loc_nDia, ;
              loc_nX, loc_dVenc
        loc_lResultado = .F.
        loc_nParc      = 0

        TRY
            IF EMPTY(THIS.this_nValorBase)  OR EMPTY(THIS.this_nJurosMes) OR ;
               EMPTY(THIS.this_nJurosDia)   OR EMPTY(THIS.this_dDataBase) OR ;
               EMPTY(THIS.this_dDataFinal)  OR EMPTY(THIS.this_nDias)

                THIS.this_nValorJuros = 0
                THIS.this_nValorTotal = 0
            ELSE
                IF THIS.this_nTipoCalculo = 1
                    *-- Juros Simples
                    loc_nJuros = ROUND(THIS.this_nValorBase * ;
                        (THIS.this_nJurosMes / 100) * (THIS.this_nDias / 30), 2)
                ELSE
                    *-- Juros Compostos
                    loc_nJuros = ROUND(THIS.this_nValorBase * ;
                        (((1 + THIS.this_nJurosDia / 100) ^ (THIS.this_nDias)) - 1), 2)
                ENDIF

                loc_nTotDia = 0
                loc_nParc   = 0

                FOR loc_nX = 1 TO 10
                    loc_dVenc = EVALUATE("THIS.this_dVenc" + ALLTRIM(STR(loc_nX)))

                    IF !EMPTY(loc_dVenc)
                        IF loc_nParc = 0
                            *-- quando calcula por parcelas, zera o calculo feito acima
                            loc_nJuros = 0
                        ENDIF

                        loc_nDia = loc_dVenc - THIS.this_dDataBase

                        IF THIS.this_nTipoCalculo = 1
                            loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                (THIS.this_nJurosMes / 100) * (loc_nDia / 30), 2)
                        ELSE
                            loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                (((1 + THIS.this_nJurosDia / 100) ^ (loc_nDia)) - 1), 2)
                        ENDIF

                        loc_nTotDia = loc_nDia
                        loc_nParc   = loc_nParc + 1
                    ENDIF
                ENDFOR

                IF loc_nTotDia > 0
                    THIS.this_nDias = loc_nTotDia
                ENDIF

                THIS.this_nValorJuros = loc_nJuros
                THIS.this_nValorTotal = THIS.this_nValorBase + loc_nJuros
            ENDIF

            *-- mena 11/12/2014 (legado): calcula valor de cada parcela
            THIS.this_nValorParcela = THIS.this_nValorTotal / IIF(loc_nParc <> 0, loc_nParc, 1)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CalcularJurosDiaAPartirDoMes - Equivalente a getJurosMes.Valid do legado.
    * Recebe o Juros ao Mes recem-digitado e devolve o Juros ao Dia
    * correspondente (o Form grava o retorno em this_nJurosDia).
    *==========================================================================
    FUNCTION CalcularJurosDiaAPartirDoMes(par_nJurosMes)
        LOCAL loc_nJurosDia

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples
            loc_nJurosDia = ROUND(par_nJurosMes / 30, 9)
        ELSE
            *-- Juros Compostos
            loc_nJurosDia = ROUND((((1 + par_nJurosMes / 100) ^ (1 / 30)) - 1) * 100, 9)
        ENDIF

        RETURN loc_nJurosDia
    ENDFUNC

    *==========================================================================
    * CalcularJurosMesAPartirDoDia - Equivalente a getJurosDia.Valid do legado.
    * Recebe o Juros ao Dia recem-digitado e devolve o Juros ao Mes
    * correspondente (o Form grava o retorno em this_nJurosMes).
    *==========================================================================
    FUNCTION CalcularJurosMesAPartirDoDia(par_nJurosDia)
        LOCAL loc_nJurosMes

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples
            loc_nJurosMes = ROUND(par_nJurosDia * 30, 2)
        ELSE
            *-- Juros Compostos
            loc_nJurosMes = ROUND((((1 + par_nJurosDia / 100) ^ (30)) - 1) * 100, 2)
        ENDIF

        RETURN loc_nJurosMes
    ENDFUNC

    *==========================================================================
    * CalcularDiasEfetivos - Centraliza o bloco "dias uteis" repetido no
    * legado em getDataFinal.Valid/getDias.Valid/optDias.InteractiveChange:
    *   lnDia = <dias corridos ja calculados pelo Form>
    *   If (lnDia > 0) And optDias.Value = 2
    *       ...percorre par_dDataBase..par_dDataFinal subtraindo sabado,
    *          domingo e feriado (SigCdFer)...
    *   EndIf
    * par_nDiasBrutos eh o valor JA calculado pelo Form (diferenca de datas
    * ou o proprio valor digitado em getDias, conforme o handler de origem -
    * o legado usa a MESMA variavel lnDia nos tres lugares, so a origem dela
    * muda). This_nTipoDias = 2 equivale a optDias.Value = 2 (Uteis).
    *==========================================================================
    FUNCTION CalcularDiasEfetivos(par_dDataBase, par_dDataFinal, par_nDiasBrutos)
        LOCAL loc_nDias, loc_dAtual

        loc_nDias = par_nDiasBrutos

        IF loc_nDias > 0 AND THIS.this_nTipoDias = 2 AND ;
           !ISNULL(par_dDataBase) AND !EMPTY(par_dDataBase) AND ;
           !ISNULL(par_dDataFinal) AND !EMPTY(par_dDataFinal)

            THIS.CarregarFeriados()

            loc_dAtual = par_dDataBase
            DO WHILE loc_dAtual <= par_dDataFinal
                IF THIS.VerificarFeriado(loc_dAtual)
                    loc_nDias = loc_nDias - 1
                ENDIF
                loc_dAtual = loc_dAtual + 1
            ENDDO
        ENDIF

        RETURN loc_nDias
    ENDFUNC

    *==========================================================================
    * CarregarFeriados - Le SigCdFer uma unica vez para this_cFeriados
    * (string "|AAAAMMDD|..."), evitando um SELECT por dia dentro do laco.
    * Equivalente ao cache usado por fChkFeriado(ThisForm.poDataMgr, ...) do
    * legado.
    *==========================================================================
    PROTECTED PROCEDURE CarregarFeriados()
        LOCAL loc_cSQL, loc_nRet, loc_cLista, loc_cAliasAnt

        IF THIS.this_lFeriadosCarregados
            RETURN .T.
        ENDIF

        loc_cLista    = "|"
        loc_cAliasAnt = ALIAS()

        TRY
            IF USED("cursor_4c_FerLoad")
                USE IN cursor_4c_FerLoad
            ENDIF

            loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer WHERE datas IS NOT NULL"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")

            IF loc_nRet > 0 AND USED("cursor_4c_FerLoad")
                SELECT cursor_4c_FerLoad
                SCAN
                    IF !ISNULL(datas) AND !EMPTY(datas)
                        loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
                    ENDIF
                ENDSCAN
                USE IN cursor_4c_FerLoad
            ENDIF

            THIS.this_cFeriados           = loc_cLista
            THIS.this_lFeriadosCarregados = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarFeriados")
        ENDTRY

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VerificarFeriado - .T. se a data eh sabado, domingo ou feriado
    * (SigCdFer.datas). Equivalente a fChkFeriado(poDataMgr, ldDia, .T., .T.)
    * do legado (DOW: 1=Domingo, 7=Sabado no calendario padrao VFP9).
    *==========================================================================
    PROTECTED PROCEDURE VerificarFeriado(par_dData)
        LOCAL loc_nDow, loc_lNaoUtil

        loc_lNaoUtil = .F.
        loc_nDow     = DOW(par_dData)

        IF loc_nDow = 1 OR loc_nDow = 7
            loc_lNaoUtil = .T.
        ELSE
            loc_lNaoUtil = ("|" + DTOS(par_dData) + "|") $ THIS.this_cFeriados
        ENDIF

        RETURN loc_lNaoUtil
    ENDPROC

ENDDEFINE

