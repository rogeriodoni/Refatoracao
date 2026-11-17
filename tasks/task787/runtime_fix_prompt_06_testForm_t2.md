# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 2/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-13 22:16:02] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-13 22:16:04] [INFO] Config FPW: (nao fornecido)
[2026-11-13 22:16:05] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-13 22:16:07] [INFO] Timeout: 300 segundos
[2026-11-13 22:16:08] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h4xjlt2r.prg
[2026-11-13 22:16:10] [INFO] Conteudo do wrapper:
[2026-11-13 22:16:11] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigoppop', 'C:\4c\tasks\task787\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigoppop', 'C:\4c\tasks\task787\logs\06_testForm.log'
QUIT

[2026-11-13 22:16:13] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h4xjlt2r.prg
[2026-11-13 22:16:14] [INFO] VFP output esperado em: C:\4c\tasks\task787\vfp_output.txt
[2026-11-13 22:16:15] [INFO] Executando Visual FoxPro 9...
[2026-11-13 22:16:17] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h4xjlt2r.prg
[2026-11-13 22:16:18] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h4xjlt2r.prg
[2026-11-13 22:16:20] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigoppop
Inicio: 13/11/2026 22:16:22

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 13/11/2026 22:18:10
Duracao: 108 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-13 22:18:10] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-13 22:18:12] [INFO] VFP9 finalizado em 115.4572276 segundos
[2026-11-13 22:18:14] [INFO] Exit Code: 
[2026-11-13 22:18:15] [INFO] 
[2026-11-13 22:18:16] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-13 22:18:18] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h4xjlt2r.prg
[2026-11-13 22:18:19] [INFO] 
[2026-11-13 22:18:21] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-13 22:18:22] [INFO] * Auto-generated wrapper for parameters
[2026-11-13 22:18:24] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-13 22:18:25] [INFO] * Parameters: 'Formsigoppop', 'C:\4c\tasks\task787\logs\06_testForm.log'
[2026-11-13 22:18:27] [INFO] 
[2026-11-13 22:18:28] [INFO] * Anti-dialog protections for unattended execution
[2026-11-13 22:18:30] [INFO] SET SAFETY OFF
[2026-11-13 22:18:31] [INFO] SET RESOURCE OFF
[2026-11-13 22:18:32] [INFO] SET TALK OFF
[2026-11-13 22:18:34] [INFO] SET NOTIFY OFF
[2026-11-13 22:18:34] [INFO] SYS(2335, 0)
[2026-11-13 22:18:35] [INFO] 
[2026-11-13 22:18:37] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigoppop', 'C:\4c\tasks\task787\logs\06_testForm.log'
[2026-11-13 22:18:38] [INFO] QUIT
[2026-11-13 22:18:39] [INFO] 
[2026-11-13 22:18:40] [INFO] === Fim do Wrapper.prg ===
[2026-11-13 22:18:41] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppop.prg):
*====================================================================
* Formsigoppop.prg
*
* Form OPERACIONAL "Transferencia Entre Locais" (SIGOPPOP) - copia
* operacoes de movimento (SigMvCab/SigMvItn/SigMvHst/SigMvNfi) de uma
* empresa/documento de ORIGEM para uma empresa/documento de DESTINO,
* conforme um "Processo de Copia" pre-configurado em outro cadastro
* (SigPcOoP/SigPcOoI). Form de TOPO: o Init do legado nao recebe
* Lparameters - diferente de sigoppag/sigoporc (forms filhos abertos
* pelo cabecalho do movimento), este eh aberto direto do menu
* (popMovimentos) e cria sua propria conexao/datasession.
*
* PILAR 3 (arquitetura): o legado (SIGOPPOP.scx) eh um form FLAT do
* VFP9 - SEM PageFrame, SEM Page1/Page2: cntSombra (faixa do
* cabecalho), cmdBtnGrade (CommandGroup de 3 botoes ao lado da grade -
* Selecionar Tudo/Desmarcar/Documentos), cntGrade (grid de 11 colunas
* - GrdOperacoes), cntOperacoes (processo de copia + periodo + opt
* "Nao Processadas/Ja Processadas" + chk "Exibir Mensagens"),
* cntFiltro (empresa origem/destino), cntComplemento (data de
* lancamento + tolerancia AU) e cmdBtnForm (CommandGroup de 3 botoes -
* Limpar/Copiar/Encerrar) sao TODOS filhos diretos do form - nao ha
* PageFrame nenhum no dump (layout.json/sigoppop_form_codigo_fonte_
* slim.txt), entao este form migrado reproduz a mesma estrutura flat
* (excecao documentada em CLAUDE.md para o Gate da Fase 3 quando o
* legado nao tem PageFrame - referencia: Formsigoppag.prg/
* Formsigoporc.prg, mesma familia "Processo de Copia").
*
* PILAR 1 (UX): dialogo 1000x600, sem barra de titulo (TitleBar=0),
* sem controle de janela (ControlBox=.F./Closable=.F./MaxButton=.F./
* MinButton=.F.), com a faixa de cabecalho cinza (cntSombra) no topo
* mostrando "Transferencia Entre Locais". WindowType do dump eh 0
* (modeless) - NAO transcrito literalmente: regra CLAUDE.md
* "WindowType 0 transcrito do SCX mata a tela" - usado WindowType=1
* (modal), mesmo padrao de Formsigopfin/Formsigopind/Formsigoppag.
*
* Mapeamento (tasks/task787/mapeamento.json): SIGOPPOP.cntSombra ->
* cnt_4c_Sombra, .lblSombra -> lbl_4c_LblSombra, .lblTitulo ->
* lbl_4c_LblTitulo.
*
* FASE 3/8 - ESTRUTURA BASE (esta fase): DEFINE CLASS, propriedades
* visuais, Init()/Destroy(), InicializarForm() (cria sigoppopBO +
* fundo new_background.jpg) e ConfigurarLayout() com SO a faixa do
* cabecalho (ConfigurarCabecalho - cnt_4c_Sombra) e o container vazio
* que vai hospedar o CommandGroup de acao (cnt_4c_Botoes, posicionado
* na bbox de cmdBtnForm do dump - Top=-2/Left=769/Width=235/Height=85,
* flutuante/transparente sobre a faixa, regra CLAUDE.md #11: criado
* DEPOIS da faixa para desenhar por cima). O CommandGroup cmg_4c_
* CmdBtnForm (Limpar/Copiar/Encerrar) entra dentro deste container em
* fase posterior.
*
* FASE 4/8 - GRADE + BOTOES DE LINHA (layout FLAT, sem PageFrame,
* mesmo padrao de Formsigoppag): cnt_4c_Grade (equivalente a cntGrade)
* hospedando grd_4c_Dados (equivalente a GrdOperacoes, 11 colunas -
* Check1 de marcacao + Codigo/Data/Valor/Documento/Usuario/Origem/
* Destino/Orig./Dest./Movimentacao, regra #18
* Column.AddObject+CurrentControl+Sparse para a coluna de check) +
* cmg_4c_CmdBtnGrade (equivalente a cmdBtnGrade - Selecionar Tudo/
* Desmarcar/Documentos) + o funil CarregarLista() ligado a
* this_oBusinessObject.this_cCursorOperacoes (cursor_4c_Operacoes).
* Mapeamento das 10 colunas de dado (dump nao declara ControlSource
* explicito - GrdOperacoes e um Grid nativo sem metodo de bind no
* trecho de codigo disponivel; inferido pelos ToolTipText de cada
* Column.Text1 do dump, casando contra o CREATE CURSOR do legado -
* csOperacoes - citado em comportamento.json): Codigo->Numes,
* Data->Datas, Valor->Valos, Documento->Notas, Usuario->Usuars,
* Origem->ContaOs, Destino->ContaDs, Orig.->Emps, Dest.->EmpDs,
* Movimentacao->Dopes (mais largo - 242px - compativel com Dopes
* char(20)). O cursor so e POPULADO pelo Selecionar() do legado
* (cntOperacoes.cmdSelecionar.Valid), nao no Init - nesta fase o
* cursor_4c_Operacoes nasce vazio (casca) e CarregarLista() so
* faz o bind/repintura (regra #21 - popular cursor NAO repinta a
* grade); Selecionar() entra na Fase 7/8 e reusa este mesmo metodo
* para repintar depois de popular.
*
* FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1) - esta fase: cnt_4c_Operacoes
* (equivalente a cntOperacoes do dump) com lbl_4c_TituloOperacoes
* (titulo em negrito "Operacoes" - Label1 do dump), obj_4c_OptProcessados
* (OptionGroup "Nao Processadas"/"Ja Processadas" - 2 botoes, INDICE,
* regra "numeric(1,0) de 2 opcoes nao eh logica" - NUNCA converter para
* logico), lbl_4c_Processo + cbo_4c_CmbOperacoes (Processo de Copia -
* RowSourceType=2/Alias sobre this_cCursorProcessos, populado por
* sigoppopBO.CarregarProcessos() a partir de SigPcOoP.processos char(20);
* o legado le o texto selecionado via ListItem(ListIndex), NAO por
* codigos numeric - no migrado o equivalente e ler cbo.Value, que e o
* mesmo texto pela ColumnCount=1), lbl_4c_Periodo + txt_4c_DtIni +
* lbl_4c_Ate + txt_4c_DtFin (periodo - Value inicial = DATE(), igual ao
* Init legado), cmd_4c_CmdSelecionar (botao que dispara Selecionar()),
* chk_4c_Fwcheckbox1 (CheckBox grafico Picture=consultar.bmp que liga
* ThisForm.ShowTips - comportamento.json InteractiveChange) e
* chk_4c_ChkMensa (Exibir Mensagens de Erro - .Value NUMERICO, regra
* CLAUDE.md, NUNCA .T./.F.). BINDEVENT dos eventos (Click/
* InteractiveChange) fica para a Fase 7/8, junto com os demais botoes
* do form.
*
* Colisao de nome resolvida (regra "nomes legado diferem so na caixa
* colidem"): mapeamento.json mapeia TANTO Say1 ("Periodo :") QUANTO
* Label1 ("Operacoes") para "lbl_4c_Label1" - sao dois Labels distintos
* no MESMO container (cntOperacoes), e usar o mesmo nome AddObject
* estouraria "object already exists". Say1 ficou lbl_4c_Periodo (label
* de campo) e Label1 ficou lbl_4c_TituloOperacoes (titulo de secao em
* negrito, Left=13/Top=3/AutoSize=.T.) - nomes diferentes do mapeamento
* gerado, documentados aqui.
*
* Say2 (Caption = "?" no dump/layout.json, Left=464 entre getDtIni e
* getDtFin) - a extracao corrompeu o caractere; pela posicao (entre as
* duas datas do periodo) e o padrao "Periodo : <DtIni> a <DtFin>", o
* texto original e a preposicao "a". Migrado como lbl_4c_Ate = "a".
*
* FASE 6/8 (esta fase) - CAMPOS RESTANTES E LOOKUPS (PARTE 2):
* cnt_4c_Filtro (equivalente a cntFiltro do dump) com os 4 campos de
* empresa origem/destino (txt_4c_EmpOs/txt_4c_DEmpOs/txt_4c_EmpDs/
* txt_4c_DEmpDs) e cnt_4c_Complemento (equivalente a cntComplemento)
* com txt_4c_DtLanc e txt_4c_Toleras (Format "K"/InputMask "999.99"
* do dump). Os 4 campos de empresa tem lookup completo: o legado
* chama fAcessoEmpresa(Usuar, 'C'|'D', This.Value, getEmpX, getDEmpX,
* poDataMgr) no Valid de cada campo (comportamento.json) -
* fAcessoEmpresa() NAO existe no sistema novo (regra CLAUDE.md), e o
* padrao MODO LOOKUP (5 args, popula 2 textboxes) substituido eh o
* bloco FormBuscaAuxiliar apontando SigCdEmp (Cemps/Razas),
* referencia canonica Formsigatcrp.prg:2285-2445 (ValidarEmp/
* AbrirBuscaEmp/ValidarDemp/AbrirBuscaDemp) - NAO o
* VerificarAcessoEmpresa (modo CHECK, 2 args, sem UI), que nao se
* aplica aqui porque o legado preenche os DOIS textboxes a partir do
* picker. BINDEVENT em "KeyPress" com par_nKeyCode testado (F4=115
* abre o picker direto; Enter=13/Tab=9 fazem o SELECT exato e so
* abrem o picker em caso de miss) - regra CLAUDE.md #47, handler
* TESTA a tecla, entao KeyPress eh legitimo (nao precisa LostFocus
* nem guarda de reentrancia, que so vale para handler ligado a
* LostFocus). Pares: ValidarEmpOs/AbrirBuscaEmpOs (Cemps) +
* ValidarDEmpOs/AbrirBuscaDEmpOs (Razas, so ativo quando EmpOs esta
* vazio - When do dump) para Origem; ValidarEmpDs/AbrirBuscaEmpDs +
* ValidarDEmpDs/AbrirBuscaDEmpDs para Destino, mesmo padrao.
*
* FASE 7/8 (esta fase) - EVENTOS: BINDEVENT dos Click de cmg_4c_
* CmdBtnForm (btnLimpar/btnCopiar/btnSair - equivalentes a
* LimpaSelecao()/Processamento()/Release do legado, dump:
* sigoppop_form_codigo_fonte.txt:10809-10897) e de cmg_4c_CmdBtnGrade
* (btnMarcaTudo/btnDesmarcar/btnDocumentos, dump:10488-10513), Click
* de cmd_4c_CmdSelecionar (equivalente ao Valid legado "ThisForm.
* Selecionar()", dump:10713-10715 - migrado para "Click", que e o
* evento confiavel para CommandButton via BINDEVENT neste projeto) e
* os 4 handlers (Click/KeyPress/MouseDown/MouseUp, todos NODEFAULT) da
* coluna de marcacao da grade (regra CLAUDE.md #46 - Valid/KeyPress da
* celula, NUNCA AfterRowColChange; dump:10525-10575).
*
* THIS.LimpaSelecao() e os handlers de cmg_4c_CmdBtnGrade/Check1 sao
* AUTOSSUFICIENTES (so manipulam cursor_4c_Operacoes e estado visual -
* nenhuma dependencia de metodo ainda nao escrito). THIS.
* CmdSelecionarClick() e o ramo "Copiar" de CmdBtnFormClick() chamam
* THIS.this_oBusinessObject.Selecionar()/.Processamento() - metodos
* QUE AINDA NAO EXISTEM no BO (o legado so tem fonte completo, sem
* truncamento, para Selecionar - dump:9941-10289 - e para Processamento
* - dump:5652-9936, ~4300 linhas; este ultimo ainda abre uma conexao
* fSqlConector POR EMPRESA DE DESTINO, via Drives/cIdConns de
* SigCdLoc, porque no legado cada empresa mora em um arquivo .DBF
* fisico separado - premissa que NAO existe na arquitetura nova, onde
* todas as empresas compartilham o MESMO SQL Server/gnConnHandle e sao
* filtradas pela coluna Emps/EmpDs, Pilar 2). Forward-reference
* deliberada, documentada tambem no cabecalho de sigoppopBO.prg - a
* Fase 8/8 implementa os dois no BO, adaptando o algoritmo de
* Processamento() para o modelo de conexao unica em vez de abrir uma
* conexao fisica por empresa.
*
* FASE 8/8 (esta fase) - CONSOLIDACAO. No Form:
*   - fConfigGeral() e fChecaAcesso([SIGOPPOP],[OPJAPROC]) no
*     InicializarForm, como no Init legado (dump:10297 e 10440);
*   - o gate de AcertaEmpDopNums() do Init legado (dump:10323-10327),
*     que NAO abre a tela quando a chave EmpDopNums nao pode ser
*     corrigida (pulado em modo de teste/validacao de UI);
*   - os CINCO indices do cursor da grade (Load legado, dump:10459-
*     10463) e o laco final do Init legado (dump:10425-10431 - fonte
*     Courier New e colunas travadas da 2 em diante) mais o
*     DynamicForeColor que pinta de VERMELHO a operacao ja excluida;
*   - BOParaForm() (tolerancia e data inicial que o Selecionar do BO
*     altera) e AplicarOrdemGrade() (SigPcOoP.Ordems);
*   - no CmdSelecionarClick, a confirmacao de REPROCESSAMENTO e as
*     validacoes de periodo com SetFocus (dump:9951-10013);
*   - no CmdBtnFormClick, o fecho "LimpaSelecao + refazer a selecao"
*     que o legado executa ao concluir a copia.
*
* BO: sigoppopBO - Selecionar() e o ciclo de fiscais/logs, o acerto de
* EmpDopNums, as faixas de peso, a geracao de codigo de produto, o
* casamento de produto, o modo FRANQUIA completo (Financeiro +
* FazContra + log em SigPcOoL) e a Delecao da origem estao
* implementados. A copia da MOVIMENTACAO completa (LancaProduto/
* LancaProdutoF/LancaProducao + o laco de destinos do Processamento,
* ~6.900 linhas do dump) NAO esta transcrita: Processamento() recusa
* esse caminho ANTES de gravar qualquer coisa, com mensagem que diz o
* que falta - ver "ESTADO DESTA FASE" no cabecalho de
* sigoppopBO.Processamento().
* Herda de: FormBase
*====================================================================

DEFINE CLASS Formsigoppop AS FormBase

    *-- DataSession privada (fiel ao legado: DataSession=2). O fix
    *-- sistemico de FormBase.Init() (SET DATE TO BRITISH + SET
    *-- CENTURY ON) roda incondicionalmente, regra CLAUDE.md #9.4.
    DataSession  = 2

    ShowWindow   = 1
    WindowType   = 1          && canonico - legado declara 0 (modeless), que MATA a tela (CLAUDE.md "WindowType 0 transcrito do SCX mata a tela")

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    Caption = "Transfer" + CHR(234) + "ncia Entre Locais"

    *-- Nome do cursor da grade de operacoes candidatas/selecionadas -
    *-- copiado de sigoppopBO.this_cCursorOperacoes em InicializarForm
    *-- (fonte unica, evita literal duplicado). Usado por CarregarLista
    *-- (Fase 4/8) e fechado em Destroy().
    this_cCursorOperacoes = ""

    *-- Nome do cursor da lista de Processos de Copia (RowSource do
    *-- combo cbo_4c_CmbOperacoes) - copiado de sigoppopBO.this_cCursorProcessos
    *-- em InicializarForm. Usado por ConfigurarOperacoes (Fase 5/8) e
    *-- fechado em Destroy().
    this_cCursorProcessos = ""

    *====================================================================
    * Init - form de topo, sem parametros (legado nao tem Lparameters).
    * DODEFAULT() aciona FormBase.Init(), que chama InicializarForm().
    *====================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *====================================================================
    * InicializarForm - cria o Business Object, aplica o fundo padrao
    * do framework legado e monta a casca visual (Fase 3/8: so a faixa
    * do cabecalho + o container vazio de botoes).
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cPicture
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigoppopBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar sigoppopBO.", "Erro")
            ELSE
                THIS.this_cCursorOperacoes  = THIS.this_oBusinessObject.this_cCursorOperacoes
                THIS.this_cCursorProcessos  = THIS.this_oBusinessObject.this_cCursorProcessos

                loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
                IF FILE(loc_cPicture)
                    THIS.Picture = loc_cPicture
                ENDIF

                *-- fConfigGeral() - primeira linha do Init legado
                *-- (dump:10297). Carrega a configuracao geral do sistema
                *-- legado; existe como wrapper em utils\fconfiggeral.prg
                *-- (regra CLAUDE.md #27).
                fConfigGeral()

                THIS.this_oBusinessObject.CarregarProcessos()

                *-- Cadastro de destinos do Processo de Copia e parametros
                *-- gerais (crTodosDestinos / crSigCdPam / crSigCdPac do Init
                *-- legado - dump:10354-10395). Lidos aqui para o BO nao
                *-- depender de quem o chama.
                THIS.this_oBusinessObject.CarregarDestinos()
                THIS.this_oBusinessObject.CarregarParametros()

                THIS.ConfigurarLayout()
                THIS.CarregarLista()

                *-- "If (.AcertaEmpDopNums() < 1) ... Return .f." do Init
                *-- legado (dump:10323-10327): sem a chave EmpDopNums
                *-- preenchida em SigMvCab/SigMvItn/SigMvPar a selecao nao
                *-- encontra operacao nenhuma, entao o legado NAO abre a tela.
                *-- Pulado em modo de teste/validacao de UI, que roda sem
                *-- conexao (gnConnHandle = -1).
                loc_lSucesso = .T.

                IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
                   (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
                    IF !THIS.this_oBusinessObject.AcertaEmpDopNums()
                        MsgAviso("A Chave EmpDopNums Est" + CHR(225) + " Inv" + CHR(225) + ;
                            "lida e N" + CHR(227) + "o Foi Poss" + CHR(237) + "vel Corrigir o Erro." + CHR(13) + ;
                            "Contate o Suporte T" + CHR(233) + "cnico e Informe Este Problema.", ;
                            "Acerta EmpDopNums")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                *-- "cntOperacoes.optProcessados.Enabled = fChecaAcesso(
                *-- [SIGOPPOP],[OPJAPROC])" do Init legado (dump:10440): so
                *-- quem tem a permissao OPJAPROC pode pedir reprocessamento
                *-- de operacoes ja copiadas.
                IF loc_lSucesso
                    THIS.cnt_4c_Operacoes.obj_4c_OptProcessados.Enabled = ;
                        fChecaAcesso("SIGOPPOP", "OPJAPROC")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppop.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfigurarLayout - orquestrador de montagem visual (layout FLAT,
    * sem PageFrame - o legado nao tem). Fase 3/8: a faixa do cabecalho
    * e o container de botoes de acao. Fase 4/8: a grade de operacoes,
    * o CommandGroup de marcacao ao lado dela (cmg_4c_CmdBtnGrade) e o
    * CommandGroup de acao dentro do container (cmg_4c_CmdBtnForm).
    * Fase 5/8 em diante acrescenta os campos de filtro.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarLayout()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarContainerBotoes()
        THIS.ConfigurarCmdBtnForm()
        THIS.ConfigurarGrid()
        THIS.ConfigurarCmdBtnGrade()
        THIS.ConfigurarOperacoes()
        THIS.ConfigurarFiltro()
        THIS.ConfigurarComplemento()
        THIS.ConfigurarEventosBotoes()
    ENDPROC

    *====================================================================
    * ConfigurarCabecalho - faixa cinza do topo com o titulo do form.
    * Nomes conforme tasks/task787/mapeamento.json (SIGOPPOP.cntSombra/
    * lblSombra/lblTitulo -> cnt_4c_Sombra/lbl_4c_LblSombra/
    * lbl_4c_LblTitulo). Width usa THIS.Width (canonico do projeto) em
    * vez do literal 1004 do dump, que extrapola o Width=1000 do form.
    * Caption dos labels fica .Caption = THIS.Caption (equivalente ao
    * "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" do
    * Init legado), nao o texto generico "Cadastro de Testes" do dump.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
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

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .Top       = 15
                .Left      = 10
                .Width     = 769
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .Top       = 18
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarContainerBotoes - container que hospeda o CommandGroup
    * de acao (equivalente a cmdBtnForm do dump - Limpar/Copiar/
    * Encerrar, 3 botoes, Top=-2/Left=769/Width=235/Height=85).
    * Transparente (BackStyle=0) e criado DEPOIS da faixa (regra
    * CLAUDE.md #11) para flutuar por cima dela - a bbox do legado
    * (Top=-2..83) cobre quase toda a altura da faixa (0..80).
    * O CommandGroup entra em ConfigurarCmdBtnForm(), logo a seguir.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarContainerBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Botoes", "Container")
            WITH THIS.cnt_4c_Botoes
                .Top         = -2
                .Left        =  542
                .Width       = 235
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoes")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarCmdBtnForm - CommandGroup de acao do form, dentro de
    * cnt_4c_Botoes (equivalente a cmdBtnForm do dump: btnLimpar/
    * btnCopiar/btnSair). Sao os botoes REAIS do legado - este form
    * OPERACIONAL nao tem CRUD (Incluir/Alterar/Excluir), e inventar
    * esses botoes violaria o PILAR 1.
    *
    * Geometria: o grupo ocupa o container inteiro (Top/Left = 0,
    * 235x85 - a mesma bbox que o dump declara em coordenadas de form,
    * Top=-2/Left=769, ja absorvida pelo container). Os Buttons usam os
    * Top/Left do dump, que ja sao relativos ao grupo (5,5 / 5,80 /
    * 5,155, todos 75x75). Width/Height do grupo ficam EXPLICITOS em
    * vez de AutoSize = .T.: sao os mesmos numeros que o Form Designer
    * calculou, logo fixa-los eh reproducao fiel (regra CLAUDE.md #23).
    *
    * Picture/ForeColor/BackColor/Font/Themes transcritos do dump -
    * NUNCA inventar nome de icone (regra CLAUDE.md #25). O btnSair ja
    * nasce no padrao canonico de saida (75x75, Caption "Encerrar",
    * cadastro_sair_60.jpg), entao nao ha conflito com a regra #10.
    * Os Click entram na Fase 7/8.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarCmdBtnForm()
        LOCAL loc_oErro

        TRY
            THIS.cnt_4c_Botoes.AddObject("cmg_4c_CmdBtnForm", "CommandGroup")
            WITH THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
                .Top         = 0
                .Left        = 0
                .Width       = 235
                .Height      = 85
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top             = 5
                    .Left            = 5
                    .Height          = 75
                    .Width           = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Caption         = "Limpar"
                    .ToolTipText     = "Limpar Sele" + CHR(231) + CHR(227) + "o"
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
                    *-- Desabilitado ate Selecionar() popular a grade (regra do
                    *-- legado: btnLimpar.Enabled = .f. no Init - dump:10313).
                    .Enabled         = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top             = 5
                    .Left            = 80
                    .Height          = 75
                    .Width           = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Caption         = "Copiar"
                    .ToolTipText     = ""
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
                    *-- Desabilitado ate Selecionar() popular a grade (regra do
                    *-- legado: btnCopiar.Enabled = .f. no Init - dump:10314).
                    .Enabled         = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Top             = 5
                    .Left            = 155
                    .Height          = 75
                    .Width           = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Cancel          = .T.
                    .Caption         = "Encerrar"
                    .ToolTipText     = "[ESC] Sair"
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                ENDWITH
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCmdBtnForm")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarGrid - cria o cursor (casca) da grade de operacoes
    * candidatas (equivalente ao "Create Cursor csOperacoes" do Init
    * legado - regra OPERACIONAL #4: SET NULL ON antes do CREATE
    * CURSOR, pois os valores reais virao de SQLEXEC no Selecionar() da
    * Fase 7/8) e o container+Grid que a exibem (cnt_4c_Grade/
    * grd_4c_Dados, nomes conforme mapeamento.json).
    *
    * ORDEM OBRIGATORIA (regra "grid_autobind_area_corrente_quebra_
    * addobject_checkbox"): um Grid SEM RecordSource ainda atribuida
    * auto-binda sozinho ao alias CORRENTE no instante em que
    * ColumnCount e definido - e se a coluna que vai receber o
    * Column.AddObject("Check1","CheckBox") cair, por acaso, numa
    * coluna CHARACTER dessa auto-bind, o AddObject estoura "Data type
    * mismatch" DENTRO de si mesmo (CheckBox.Value nasce NUMERICO).
    * Por isso RecordSource + ControlSource de TODAS as colunas e
    * aplicado ANTES do AddObject do Check1 - nunca depois. ColumnCount
    * e fixado AQUI, UMA UNICA VEZ (regra "SOREDUZIRColumn" -
    * reatribuir ColumnCount recria as colunas e destroi o Check1).
    * CarregarLista() so REBINDA (RecordSource/ControlSource/Width/
    * Header1.Caption, que o RecordSource RESETA a cada chamada - regra
    * "Problema 48"), sem tocar no AddObject.
    *
    * Colunas 1 a 11 (Width/ToolTipText/FontName/FontSize transcritos
    * do dump): Column1 = Check1 (marcacao, regra #18 - AddObject +
    * CurrentControl + Sparse); Columns 2-11 = Text1 de exibicao
    * (Codigo/Data/Valor/Documento/Usuario/Origem/Destino/Orig./Dest./
    * Movimentacao).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_cCursor, loc_oGrid, loc_nCol, loc_oColuna, loc_oErro

        loc_cCursor = THIS.this_cCursorOperacoes

        TRY
            IF !USED(loc_cCursor)
                SET NULL ON
                CREATE CURSOR (loc_cCursor) ;
                    (SelImp L NULL, Emps C(3) NULL, Dopes C(20) NULL, ;
                     Numes N(6, 0) NULL, Datas D NULL, Valos N(12, 2) NULL, ;
                     Notas C(10) NULL, Usuars C(10) NULL, ContaOs C(10) NULL, ;
                     ContaDs C(10) NULL, EmpDs C(3) NULL, Deletado L NULL)
                SET NULL OFF

                *-- Os CINCO indices do Load legado (dump:10459-10463). Um TAG
                *-- por criterio de ordenacao do Processo de Copia
                *-- (SigPcOoP.Ordems): 1-Operacao / 2-Data / 3-Nota /
                *-- 4-Origem / 5-Destino. Sem eles o "SET ORDER TO TAG <x>"
                *-- que AplicarOrdemGrade() faz depois de Selecionar nao tem
                *-- em que se apoiar.
                INDEX ON Emps + Dopes + STR(Numes, 6)                   TAG Operacao
                INDEX ON DTOS(Datas) + Emps + Dopes + STR(Numes, 6)     TAG Data
                INDEX ON Notas + Emps + Dopes + STR(Numes, 6)           TAG Nota
                INDEX ON ContaOs + Emps + Dopes + STR(Numes, 6)         TAG Origem
                INDEX ON ContaDs + Emps + Dopes + STR(Numes, 6)         TAG Destino
                SET ORDER TO TAG Operacao
            ENDIF

            THIS.AddObject("cnt_4c_Grade", "Container")
            WITH THIS.cnt_4c_Grade
                .Top         = 209
                .Left        = 9
                .Width       = 932
                .Height      = 375
                .BackStyle   = 0
                .BorderWidth = 0
                .SpecialEffect = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Grade.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = THIS.cnt_4c_Grade.grd_4c_Dados

            WITH loc_oGrid
                .Top               = 2
                .Left              = 1
                .Width             = 929
                .Height            = 372
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .HeaderHeight      = 16
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .ColumnCount       = 11

                *-- RecordSource + ControlSource de TODAS as colunas
                *-- ANTES do AddObject do Check1 (ver comentario do
                *-- metodo acima - evita o auto-bind em coluna
                *-- CHARACTER estourar o AddObject do CheckBox).
                .RecordSource = loc_cCursor

                .Column1.ControlSource  = loc_cCursor + ".SelImp"
                .Column2.ControlSource  = loc_cCursor + ".Numes"
                .Column3.ControlSource  = loc_cCursor + ".Datas"
                .Column4.ControlSource  = loc_cCursor + ".Valos"
                .Column5.ControlSource  = loc_cCursor + ".Notas"
                .Column6.ControlSource  = loc_cCursor + ".Usuars"
                .Column7.ControlSource  = loc_cCursor + ".ContaOs"
                .Column8.ControlSource  = loc_cCursor + ".ContaDs"
                .Column9.ControlSource  = loc_cCursor + ".Emps"
                .Column10.ControlSource = loc_cCursor + ".EmpDs"
                .Column11.ControlSource = loc_cCursor + ".Dopes"

                *-- Column1 - marcacao (Check1). CurrentControl/Sparse
                *-- obrigatorios (regra #18) para o CheckBox aparecer e
                *-- ser editavel em TODAS as linhas.
                .Column1.FontName = "Tahoma"
                .Column1.FontSize = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = ""
                .Column1.AddObject("Check1", "CheckBox")
                WITH .Column1.Check1
                    .Top         = 9
                    .Left        = 2
                    .Height      = 17
                    .Width       = 22
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Alignment   = 0
                    .Caption     = ""
                    .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
                    .Visible     = .T.
                    .ReadOnly    = .F.
                ENDWITH
                .Column1.CurrentControl = "Check1"
                .Column1.Sparse         = .F.
                .Column1.ReadOnly       = .F.
                .Column1.Width          = 15

                .Column2.FontName = "Tahoma"
                .Column2.FontSize = 8
                .Column2.Width    = 52
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "C" + CHR(243) + "digo"
                .Column2.Text1.BorderStyle = 1
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.ToolTipText = "C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column3.FontName = "Tahoma"
                .Column3.FontSize = 8
                .Column3.Width    = 80
                .Column3.Header1.Alignment = 2
                .Column3.Header1.Caption   = "Data"
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ToolTipText = "Data da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column4.FontName = "Tahoma"
                .Column4.FontSize = 8
                .Column4.Width    = 104
                .Column4.Header1.Alignment = 2
                .Column4.Header1.Caption   = "Valor"
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)
                .Column4.Text1.ToolTipText = "Valor da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column5.FontName = "Tahoma"
                .Column5.FontSize = 8
                .Column5.Width    = 75
                .Column5.Header1.Alignment = 2
                .Column5.Header1.Caption   = "Documento"
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)
                .Column5.Text1.ToolTipText = "Documento da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column6.FontName = "Tahoma"
                .Column6.FontSize = 8
                .Column6.Width    = 85
                .Column6.Header1.Alignment = 2
                .Column6.Header1.Caption   = "Usu" + CHR(225) + "rio"
                .Column6.Text1.BorderStyle = 0
                .Column6.Text1.Margin      = 0
                .Column6.Text1.ForeColor   = RGB(0, 0, 0)
                .Column6.Text1.BackColor   = RGB(255, 255, 255)
                .Column6.Text1.ToolTipText = "Usu" + CHR(225) + "rio Que Gerou a Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column7.FontName = "Tahoma"
                .Column7.FontSize = 8
                .Column7.Width    = 85
                .Column7.Header1.Alignment = 2
                .Column7.Header1.Caption   = "Origem"
                .Column7.Text1.BorderStyle = 0
                .Column7.Text1.Margin      = 0
                .Column7.Text1.ForeColor   = RGB(0, 0, 0)
                .Column7.Text1.BackColor   = RGB(255, 255, 255)
                .Column7.Text1.ToolTipText = "Conta de Origem da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column8.FontName = "Tahoma"
                .Column8.FontSize = 8
                .Column8.Width    = 85
                .Column8.Header1.Alignment = 2
                .Column8.Header1.Caption   = "Destino"
                .Column8.Text1.BorderStyle = 0
                .Column8.Text1.Margin      = 0
                .Column8.Text1.ForeColor   = RGB(0, 0, 0)
                .Column8.Text1.BackColor   = RGB(255, 255, 255)
                .Column8.Text1.ToolTipText = "Conta de Destino da Opera" + CHR(231) + CHR(227) + "o na Origem"

                .Column9.FontName = "Tahoma"
                .Column9.FontSize = 8
                .Column9.Width    = 37
                .Column9.Header1.Alignment = 2
                .Column9.Header1.Caption   = "Orig."
                .Column9.Text1.BorderStyle = 0
                .Column9.Text1.Margin      = 0
                .Column9.Text1.ForeColor   = RGB(0, 0, 0)
                .Column9.Text1.BackColor   = RGB(255, 255, 255)
                .Column9.Text1.ToolTipText = "Empresa da Opera" + CHR(231) + CHR(227) + "o de Origem"

                .Column10.FontName = "Tahoma"
                .Column10.FontSize = 8
                .Column10.Width    = 37
                .Column10.Header1.Alignment = 2
                .Column10.Header1.Caption   = "Dest."
                .Column10.Text1.BorderStyle = 0
                .Column10.Text1.Margin      = 0
                .Column10.Text1.ForeColor   = RGB(0, 0, 0)
                .Column10.Text1.BackColor   = RGB(255, 255, 255)
                .Column10.Text1.ToolTipText = "Empresa da Opera" + CHR(231) + CHR(227) + "o de Destino"

                .Column11.FontName = "Tahoma"
                .Column11.FontSize = 8
                .Column11.Width    = 242
                .Column11.Header1.Alignment = 2
                .Column11.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Column11.Text1.BorderStyle = 0
                .Column11.Text1.Margin      = 0
                .Column11.Text1.ForeColor   = RGB(0, 0, 0)
                .Column11.Text1.BackColor   = RGB(255, 255, 255)

                *-- Laco final do Init legado (dump:10425-10431): da coluna 2
                *-- ate a ultima, fonte Courier New e coluna TRAVADA
                *-- (Movable/Resizable/ReadOnly). Esse laco roda DEPOIS das
                *-- propriedades do SCX, entao ele e quem decide o estado
                *-- final - inclusive da Column11, que o SCX declara
                *-- ReadOnly = .F. e o laco volta para .T. Como o Grid.ReadOnly
                *-- propaga para as colunas, o ReadOnly de coluna vem DEPOIS
                *-- dele (regra CLAUDE.md #18/#46).
                .Column1.Movable   = .F.
                .Column1.Resizable = .F.

                FOR loc_nCol = 2 TO .ColumnCount
                    loc_oColuna = .Columns(loc_nCol)
                    loc_oColuna.FontName  = "Courier New"
                    loc_oColuna.Movable   = .F.
                    loc_oColuna.Resizable = .F.
                    loc_oColuna.ReadOnly  = .T.
                ENDFOR

                *-- "SetAll([DynamicForeColor], [Iif(csOperacoes.Deletado,
                *-- Rgb(255,0,0), Rgb(0,0,0))], [Column])" do Init legado: a
                *-- operacao que veio de SigExMvc (ja excluida na origem)
                *-- aparece em VERMELHO na grade.
                .SetAll("DynamicForeColor", ;
                    "IIF(" + loc_cCursor + ".Deletado, RGB(255,0,0), RGB(0,0,0))", ;
                    "Column")

                .Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarCmdBtnGrade - CommandGroup de 3 botoes ao lado direito
    * da grade (equivalente a cmdBtnGrade do dump - Selecionar Tudo/
    * Desmarcar/Documentos). Posicao, Picture e cores transcritas do
    * dump; Themes = .F. nos Buttons internos (padrao canonico de
    * Buttons dentro de CommandGroup). Os Click (btnMarcaTudo/
    * btnDesmarcar/btnDocumentos) entram na Fase 7/8.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarCmdBtnGrade()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmg_4c_CmdBtnGrade", "CommandGroup")
            WITH THIS.cmg_4c_CmdBtnGrade
                .Top         = 364
                .Left        = 944
                .Width       = 43
                .Height      = 135
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top             = -1
                    .Left            = -1
                    .Height          = 45
                    .Width           = 45
                    .FontName        = "Verdana"
                    .FontSize        = 8
                    .Caption         = ""
                    .ToolTipText     = "Selecionar"
                    .ForeColor       = RGB(36, 84, 155)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                    *-- Desabilitado ate Selecionar() popular a grade (regra do
                    *-- legado: btnMarcaTudo.Enabled = .f. no Init - dump:10315).
                    .Enabled         = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top             = 45
                    .Left            = -1
                    .Height          = 45
                    .Width           = 45
                    .FontName        = "Verdana"
                    .FontSize        = 8
                    .Caption         = ""
                    .ToolTipText     = "Desmarcar"
                    .ForeColor       = RGB(36, 84, 155)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                    *-- Desabilitado ate Selecionar() popular a grade (regra do
                    *-- legado: btnDesmarcar.Enabled = .f. no Init - dump:10316).
                    .Enabled         = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Top             = 91
                    .Left            = -1
                    .Height          = 45
                    .Width           = 45
                    .FontName        = "Verdana"
                    .FontSize        = 8
                    .Caption         = ""
                    .ToolTipText     = "Documento"
                    .ForeColor       = RGB(36, 84, 155)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
                    *-- Desabilitado ate Selecionar() popular a grade (regra do
                    *-- legado: btnDocumentos.Enabled = .f. no Init - dump:10317).
                    .Enabled         = .F.
                ENDWITH
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCmdBtnGrade")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarOperacoes - cnt_4c_Operacoes (equivalente a cntOperacoes
    * do dump): titulo de secao, Processo de Copia (combo), periodo
    * (datas) e o botao Selecionar. Geometria/cores/fontes transcritas
    * do dump (tasks/task787/sigoppop_form_codigo_fonte_slim.txt). Ver
    * comentario de Fase 5/8 no topo do arquivo para a colisao de nome
    * Say1/Label1 e a leitura de Say2 ("a").
    *====================================================================
    PROTECTED PROCEDURE ConfigurarOperacoes()
        LOCAL loc_oCnt, loc_oErro

        TRY
            *-- Guarda defensiva: se CarregarProcessos() (chamado em
            *-- InicializarForm, antes desta fase) nao conseguiu abrir
            *-- conexao (ex.: modo de teste sem SQL Server), garantir que
            *-- o cursor existe antes de amarrar o RowSourceType=2 do
            *-- combo - senao o AddObject do ComboBox estoura.
            IF !USED(THIS.this_cCursorProcessos)
                CREATE CURSOR (THIS.this_cCursorProcessos) (processos C(20))
            ENDIF

            THIS.AddObject("cnt_4c_Operacoes", "Container")
            loc_oCnt = THIS.cnt_4c_Operacoes
            WITH loc_oCnt
                .Top         = 88
                .Left        = 6
                .Width       = 732
                .Height      = 46
                .BackStyle   = 0
                .BorderWidth = 0
                .SpecialEffect = 0
                .Visible     = .T.
            ENDWITH

            *-- Label1 do dump - titulo de secao em negrito ("Operacoes").
            *-- Nome lbl_4c_TituloOperacoes (NAO lbl_4c_Label1 do
            *-- mapeamento.json - colide com Say1, ver comentario de topo).
            loc_oCnt.AddObject("lbl_4c_TituloOperacoes", "Label")
            WITH loc_oCnt.lbl_4c_TituloOperacoes
                .Top       = 3
                .Left      = 13
                .Width     = 62
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .FontItalic = .F.
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Oper" + "\<" + "a" + CHR(231) + CHR(245) + "es"
                .Visible   = .T.
            ENDWITH

            *-- optProcessados - OptionGroup "Nao Processadas"/"Ja
            *-- Processadas". Value = INDICE (1/2), NUNCA booleano (regra
            *-- CLAUDE.md "numeric(1,0) de duas opcoes nao eh logica").
            *-- Default = 1 (Nao Processadas), igual a BO.this_nProcessados.
            loc_oCnt.AddObject("obj_4c_OptProcessados", "OptionGroup")
            WITH loc_oCnt.obj_4c_OptProcessados
                .Top         = 5
                .Left        = 83
                .Width       = 235
                .Height      = 15
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top       = -1
                    .Left      = 5
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Caption   = "N" + CHR(227) + "o Processadas"
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH

                WITH .Buttons(2)
                    .Top       = -1
                    .Left      = 126
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Caption   = "J" + CHR(225) + " Processadas"
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
            ENDWITH

            *-- Say3 do dump - "Processo :".
            loc_oCnt.AddObject("lbl_4c_Processo", "Label")
            WITH loc_oCnt.lbl_4c_Processo
                .Top        = 24
                .Left       = 23
                .Width      = 60
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "Processo :"
                .Visible    = .T.
            ENDWITH

            *-- cmbOperacoes - Processo de Copia cadastrado (SigPcOoP).
            *-- RowSourceType=2 (Alias) sobre this_cCursorProcessos,
            *-- populado por sigoppopBO.CarregarProcessos() ANTES desta
            *-- fase (THIS.InicializarForm() chama o BO antes de
            *-- ConfigurarLayout()). ColumnCount=1 (so o texto Processos,
            *-- char(20) - o legado le o mesmo texto via
            *-- ListItem(ListIndex), nao por codigo numerico).
            loc_oCnt.AddObject("cbo_4c_CmbOperacoes", "ComboBox")
            WITH loc_oCnt.cbo_4c_CmbOperacoes
                .Top            = 20
                .Left           = 87
                .Width          = 196
                .Height         = 24
                .FontName       = "Courier New"
                .FontSize       = 8
                .SpecialEffect  = 1
                .Style          = 2
                .ColumnCount    = 1
                .RowSourceType  = 2
                .RowSource      = THIS.this_cCursorProcessos
                .ToolTipText    = "Opera" + CHR(231) + CHR(245) + "es de C" + CHR(243) + "pia Configuradas no Cadastro de Opera" + CHR(231) + CHR(245) + "es Para C" + CHR(243) + "pia"
                .BorderColor    = RGB(90, 90, 90)
                .Visible        = .T.
            ENDWITH

            *-- Say1 do dump - "Periodo :". Nome lbl_4c_Periodo (NAO
            *-- lbl_4c_Label1 do mapeamento.json - colide com Label1).
            loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
            WITH loc_oCnt.lbl_4c_Periodo
                .Top        = 23
                .Left       = 323
                .Width      = 50
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "Per" + CHR(237) + "odo :"
                .Visible    = .T.
            ENDWITH

            *-- getDtIni - data inicial do periodo. Value inicial =
            *-- DATE(), igual ao Init do legado (ver comentario da
            *-- property BO.this_dDtIni em sigoppopBO.prg).
            loc_oCnt.AddObject("txt_4c_DtIni", "TextBox")
            WITH loc_oCnt.txt_4c_DtIni
                .Top          = 20
                .Left         = 377
                .Width        = 80
                .Height       = 23
                .SpecialEffect = 1
                .ToolTipText  = "Data Inicial Para Sele" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es "
                .BorderColor  = RGB(90, 90, 90)
                .Value        = DATE()
                .Visible      = .T.
            ENDWITH

            *-- Say2 do dump - "a" entre as duas datas do periodo (ver
            *-- comentario de topo sobre a extracao corrompida).
            loc_oCnt.AddObject("lbl_4c_Ate", "Label")
            WITH loc_oCnt.lbl_4c_Ate
                .Top        = 24
                .Left       = 464
                .Width      = 10
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "a"
                .Visible    = .T.
            ENDWITH

            *-- getDtFin - data final do periodo. Value inicial = DATE().
            loc_oCnt.AddObject("txt_4c_DtFin", "TextBox")
            WITH loc_oCnt.txt_4c_DtFin
                .Top          = 21
                .Left         = 477
                .Width        = 80
                .Height       = 23
                .SpecialEffect = 1
                .ToolTipText  = "Data Final Para Sele" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es "
                .BorderColor  = RGB(90, 90, 90)
                .Value        = DATE()
                .Visible      = .T.
            ENDWITH

            *-- cmdSelecionar - dispara Selecionar() (BO), que monta
            *-- cursor_4c_Operacoes a partir do filtro. BINDEVENT do
            *-- Click fica para a Fase 7/8.
            loc_oCnt.AddObject("cmd_4c_CmdSelecionar", "CommandButton")
            WITH loc_oCnt.cmd_4c_CmdSelecionar
                .Top         = 21
                .Left        = 595
                .Width       = 99
                .Height      = 23
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .Caption     = "\<Selecionar"
                .ToolTipText = "Seleciona as Opera" + CHR(231) + CHR(245) + "es Conforme os Dados Digitados"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Visible     = .T.
            ENDWITH

            *-- fwcheckbox1 do dump - CheckBox grafico (Style=1,
            *-- Picture=consultar.bmp do framework legado, rule #25 -
            *-- NUNCA inventar nome de icone) que liga/desliga
            *-- ThisForm.ShowTips (comportamento.json:
            *-- "ThisForm.ShowTips = (This.Value = 1)" no InteractiveChange).
            *-- .Value NUMERICO (regra CLAUDE.md). BINDEVENT do
            *-- InteractiveChange fica para a Fase 7/8, junto com os
            *-- demais eventos do form.
            loc_oCnt.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
            WITH loc_oCnt.chk_4c_Fwcheckbox1
                .Top       = 21
                .Left      = 704
                .Width     = 24
                .Height    = 23
                .Style     = 1
                .Alignment = 0
                .Caption   = ""
                .Value     = 0
                .BackColor = RGB(255, 255, 255)
                .Picture   = gc_4c_CaminhoFramework + "imagens\consultar.bmp"
                .Visible   = .T.
            ENDWITH

            *-- chkMensa - "Exibir Mensagens de Erro". .Value NUMERICO
            *-- (regra CLAUDE.md), NUNCA .T./.F.. Default = 1 (marcado),
            *-- igual a BO.this_lExibirMensagens = .T..
            loc_oCnt.AddObject("chk_4c_ChkMensa", "CheckBox")
            WITH loc_oCnt.chk_4c_ChkMensa
                .Top         = 3
                .Left        = 377
                .Width       = 180
                .Height      = 17
                .FontName    = "Tahoma"
                .FontSize    = 8
                .FontItalic  = .F.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = "Exibir Mensagens de Erro"
                .Value       = 1
                .ToolTipText = "Exibe Mensagens Relativas a Erros de Lan" + CHR(231) + "amento"
                .ForeColor   = RGB(90, 90, 90)
                .Visible     = .T.
                *-- Desabilitado ate Selecionar() popular a grade (regra do
                *-- legado: chkMensa.Enabled = .f. no Init - dump:10318).
                .Enabled     = .F.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarOperacoes")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarFiltro - cnt_4c_Filtro (equivalente a cntFiltro do dump):
    * 2 pares codigo+descricao de empresa (Origem/Destino). Geometria/
    * cores/fontes transcritas do dump (sigoppop_form_codigo_fonte_
    * slim.txt). MaxLength=3 nos campos de codigo (regra CLAUDE.md
    * "SigCdEmp TextBox de codigo - MaxLength=3 obrigatorio", conferido
    * no dump - getEmpOs/getEmpDs ja declaram MaxLength=3).
    *
    * Lookup: o legado valida no Valid (ao sair do campo) chamando
    * fAcessoEmpresa no modo LOOKUP de 5 argumentos (comportamento.json);
    * aqui, como BINDEVENT em "Valid" de TextBox nao e confiavel (regra
    * CLAUDE.md #3), o equivalente fica no "KeyPress", testando a tecla
    * (F4=115 abre o picker direto; Enter=13/Tab=9 fazem o SELECT exato
    * contra SigCdEmp e so abrem o picker em caso de miss - regra
    * CLAUDE.md #47, sem necessidade de guarda de reentrancia porque o
    * handler testa par_nKeyCode). Os pickers (AbrirBuscaEmpOs/
    * AbrirBuscaDEmpOs/AbrirBuscaEmpDs/AbrirBuscaDEmpDs) e os validadores
    * (ValidarEmpOs/ValidarDEmpOs/ValidarEmpDs/ValidarDEmpDs) estao
    * definidos mais abaixo, no mesmo padrao de Formsigatcrp.prg:2285-
    * 2445 (ValidarEmp/AbrirBuscaEmp/ValidarDemp/AbrirBuscaDemp).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarFiltro()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Filtro", "Container")
            loc_oCnt = THIS.cnt_4c_Filtro
            WITH loc_oCnt
                .Top         = 134
                .Left        = 6
                .Width       = 699
                .Height      = 89
                .BackStyle   = 0
                .BorderWidth = 0
                .SpecialEffect = 0
                .Visible     = .T.
            ENDWITH

            *-- Label2 do dump - titulo de secao em negrito ("Filtro por Empresa").
            loc_oCnt.AddObject("lbl_4c_FiltroEmpresa", "Label")
            WITH loc_oCnt.lbl_4c_FiltroEmpresa
                .Top        = 1
                .Left       = 9
                .Width      = 105
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "Filtro por " + "\<" + "Empresa"
                .Visible    = .T.
            ENDWITH

            *-- Say4 do dump - "Origem :".
            loc_oCnt.AddObject("lbl_4c_Origem", "Label")
            WITH loc_oCnt.lbl_4c_Origem
                .Top        = 23
                .Left       = 31
                .Width      = 55
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "Origem :"
                .Visible    = .T.
            ENDWITH

            *-- getEmpOs - codigo da empresa de ORIGEM (SigCdEmp.Cemps char(3)).
            loc_oCnt.AddObject("txt_4c_EmpOs", "TextBox")
            WITH loc_oCnt.txt_4c_EmpOs
                .Top           = 19
                .Left          = 88
                .Width         = 31
                .MaxLength     = 3
                .SpecialEffect = 1
                .BorderColor   = RGB(90, 90, 90)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- getDEmpOs - razao social da empresa de ORIGEM (SigCdEmp.Razas char(40)).
            loc_oCnt.AddObject("txt_4c_DEmpOs", "TextBox")
            WITH loc_oCnt.txt_4c_DEmpOs
                .Top           = 19
                .Left          = 122
                .Width         = 305
                .Height        = 23
                .SpecialEffect = 1
                .BorderColor   = RGB(90, 90, 90)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Say5 do dump - "Destino :".
            loc_oCnt.AddObject("lbl_4c_Destino", "Label")
            WITH loc_oCnt.lbl_4c_Destino
                .Top        = 49
                .Left       = 30
                .Width      = 56
                .Height     = 15
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontItalic = .F.
                .BackStyle  = 0
                .AutoSize   = .F.
                .Alignment  = 0
                .ForeColor  = RGB(90, 90, 90)
                .Caption    = "Destino :"
                .Visible    = .T.
            ENDWITH

            *-- getEmpDs - codigo da empresa de DESTINO.
            loc_oCnt.AddObject("txt_4c_EmpDs", "TextBox")
            WITH loc_oCnt.txt_4c_EmpDs
                .Top           = 45
                .Left          = 88
                .Width         = 31
                .MaxLength     = 3
                .SpecialEffect = 1
                .BorderColor   = RGB(90, 90, 90)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- getDEmpDs - razao social da empresa de DESTINO.
            loc_oCnt.AddObject("txt_4c_DEmpDs", "TextBox")
            WITH loc_oCnt.txt_4c_DEmpDs
                .Top           = 45
                .Left          = 122
                .Width         = 305
                .Height        = 23
                .SpecialEffect = 1
                .BorderColor   = RGB(90, 90, 90)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            BINDEVENT(loc_oCnt.txt_4c_EmpOs,  "KeyPress", THIS, "ValidarEmpOs")
            BINDEVENT(loc_oCnt.txt_4c_DEmpOs, "KeyPress", THIS, "ValidarDEmpOs")
            BINDEVENT(loc_oCnt.txt_4c_EmpDs,  "KeyPress", THIS, "ValidarEmpDs")
            BINDEVENT(loc_oCnt.txt_4c_DEmpDs, "KeyPress", THIS, "ValidarDEmpDs")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltro")
        ENDTRY
    ENDPROC

    *====================================================================
    * ValidarEmpOs - KeyPress em txt_4c_EmpOs (codigo da empresa ORIGEM).
    *   F4        -> abre picker direto
    *   Enter/Tab -> SQL exato em SigCdEmp.Cemps; hit preenche DEmpOs,
    *                miss abre picker
    *====================================================================
    PROCEDURE ValidarEmpOs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpOs()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value)
        IF EMPTY(loc_cVal)
            THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ""
            THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpOsVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpOsVal") AND !EOF("cursor_4c_EmpOsVal")
                SELECT cursor_4c_EmpOsVal
                THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpOsVal.Cemps)
                THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpOsVal.Razas)
            ELSE
                THIS.AbrirBuscaEmpOs()
            ENDIF
            IF USED("cursor_4c_EmpOsVal")
                USE IN cursor_4c_EmpOsVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
    ENDPROC

    *====================================================================
    * AbrirBuscaEmpOs - picker por Cemps em SigCdEmp (empresa ORIGEM).
    *====================================================================
    PROCEDURE AbrirBuscaEmpOs()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro

        loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Origem"

        IF USED("cursor_4c_BuscaEmpOs")
            USE IN cursor_4c_BuscaEmpOs
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Cemps"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpOs")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmpOs")
                    USE IN cursor_4c_BuscaEmpOs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
                    "cursor_4c_BuscaEmpOs")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOs"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpOs")
                        SELECT cursor_4c_BuscaEmpOs
                        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpOs.Cemps)
                        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpOs.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmpOs")
            USE IN cursor_4c_BuscaEmpOs
        ENDIF
        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
    ENDPROC

    *====================================================================
    * ValidarDEmpOs - KeyPress em txt_4c_DEmpOs (razao social da empresa
    * ORIGEM). Ativo apenas quando txt_4c_EmpOs esta vazio (equivalente
    * ao When "Return Empty(ThisForm.cntFiltro.getEmpOs.Value)" do dump).
    *   F4        -> abre picker direto
    *   Enter/Tab -> SQL exato em SigCdEmp.Razas; miss abre picker
    *====================================================================
    PROCEDURE ValidarDEmpOs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaDEmpOs()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value)
        IF EMPTY(loc_cVal)
            THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value = ""
            THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpOsVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpOsVal") AND !EOF("cursor_4c_EmpOsVal")
                SELECT cursor_4c_EmpOsVal
                THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpOsVal.Cemps)
                THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpOsVal.Razas)
            ELSE
                THIS.AbrirBuscaDEmpOs()
            ENDIF
            IF USED("cursor_4c_EmpOsVal")
                USE IN cursor_4c_EmpOsVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
    ENDPROC

    *====================================================================
    * AbrirBuscaDEmpOs - picker por Razas em SigCdEmp (empresa ORIGEM).
    *====================================================================
    PROCEDURE AbrirBuscaDEmpOs()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro

        loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Origem"

        IF USED("cursor_4c_BuscaEmpOs")
            USE IN cursor_4c_BuscaEmpOs
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Razas"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpOs")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmpOs")
                    USE IN cursor_4c_BuscaEmpOs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas", ;
                    "cursor_4c_BuscaEmpOs")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOs"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpOs")
                        SELECT cursor_4c_BuscaEmpOs
                        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpOs.Cemps)
                        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpOs.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmpOs")
            USE IN cursor_4c_BuscaEmpOs
        ENDIF
        THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
    ENDPROC

    *====================================================================
    * ValidarEmpDs - KeyPress em txt_4c_EmpDs (codigo da empresa DESTINO).
    *   F4        -> abre picker direto
    *   Enter/Tab -> SQL exato em SigCdEmp.Cemps; hit preenche DEmpDs,
    *                miss abre picker
    *====================================================================
    PROCEDURE ValidarEmpDs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpDs()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value)
        IF EMPTY(loc_cVal)
            THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ""
            THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpDsVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpDsVal") AND !EOF("cursor_4c_EmpDsVal")
                SELECT cursor_4c_EmpDsVal
                THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_EmpDsVal.Cemps)
                THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_EmpDsVal.Razas)
            ELSE
                THIS.AbrirBuscaEmpDs()
            ENDIF
            IF USED("cursor_4c_EmpDsVal")
                USE IN cursor_4c_EmpDsVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
    ENDPROC

    *====================================================================
    * AbrirBuscaEmpDs - picker por Cemps em SigCdEmp (empresa DESTINO).
    *====================================================================
    PROCEDURE AbrirBuscaEmpDs()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro

        loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Destino"

        IF USED("cursor_4c_BuscaEmpDs")
            USE IN cursor_4c_BuscaEmpDs
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Cemps"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDs")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmpDs")
                    USE IN cursor_4c_BuscaEmpDs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
                    "cursor_4c_BuscaEmpDs")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDs"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDs")
                        SELECT cursor_4c_BuscaEmpDs
                        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_BuscaEmpDs.Cemps)
                        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_BuscaEmpDs.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmpDs")
            USE IN cursor_4c_BuscaEmpDs
        ENDIF
        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
    ENDPROC

    *====================================================================
    * ValidarDEmpDs - KeyPress em txt_4c_DEmpDs (razao social da empresa
    * DESTINO). Ativo apenas quando txt_4c_EmpDs esta vazio (equivalente
    * ao When "Return Empty(ThisForm.cntFiltro.getEmpDs.Value)" do dump).
    *   F4        -> abre picker direto
    *   Enter/Tab -> SQL exato em SigCdEmp.Razas; miss abre picker
    *====================================================================
    PROCEDURE ValidarDEmpDs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaDEmpDs()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value)
        IF EMPTY(loc_cVal)
            THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value = ""
            THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpDsVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpDsVal") AND !EOF("cursor_4c_EmpDsVal")
                SELECT cursor_4c_EmpDsVal
                THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_EmpDsVal.Cemps)
                THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_EmpDsVal.Razas)
            ELSE
                THIS.AbrirBuscaDEmpDs()
            ENDIF
            IF USED("cursor_4c_EmpDsVal")
                USE IN cursor_4c_EmpDsVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
    ENDPROC

    *====================================================================
    * AbrirBuscaDEmpDs - picker por Razas em SigCdEmp (empresa DESTINO).
    *====================================================================
    PROCEDURE AbrirBuscaDEmpDs()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro

        loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Destino"

        IF USED("cursor_4c_BuscaEmpDs")
            USE IN cursor_4c_BuscaEmpDs
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Razas"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDs")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmpDs")
                    USE IN cursor_4c_BuscaEmpDs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas", ;
                    "cursor_4c_BuscaEmpDs")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDs"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDs")
                        SELECT cursor_4c_BuscaEmpDs
                        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_BuscaEmpDs.Cemps)
                        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_BuscaEmpDs.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmpDs")
            USE IN cursor_4c_BuscaEmpDs
        ENDIF
        THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
        THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
    ENDPROC

    *====================================================================
    * ConfigurarComplemento - cnt_4c_Complemento (equivalente a
    * cntComplemento do dump): data de lancamento no destino e
    * tolerancia AU. Geometria/Format/InputMask transcritos do dump
    * (regra CLAUDE.md #49 - Format/InputMask do SCX sao OBRIGATORIOS).
    * Sem lookup - campos simples, so transcricao de propriedades.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarComplemento()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Complemento", "Container")
            loc_oCnt = THIS.cnt_4c_Complemento
            WITH loc_oCnt
                .Top         = 151
                .Left        = 453
                .Width       = 240
                .Height      = 60
                .BackStyle   = 0
                .BorderWidth = 0
                .SpecialEffect = 0
                .Visible     = .T.
            ENDWITH

            *-- Say1 do dump - "Lancar em :".
            loc_oCnt.AddObject("lbl_4c_LancarEm", "Label")
            WITH loc_oCnt.lbl_4c_LancarEm
                .Top       = 5
                .Left      = 20
                .Width     = 65
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "La" + "\<" + "n" + CHR(231) + "ar em :"
                .Visible   = .T.
            ENDWITH

            *-- getDtLanc - data de lancamento das operacoes no DESTINO
            *-- (vazia assume a data da origem - this_dDtLanc do BO).
            loc_oCnt.AddObject("txt_4c_DtLanc", "TextBox")
            WITH loc_oCnt.txt_4c_DtLanc
                .Top           = 1
                .Left          = 90
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .ToolTipText   = "Data Para Lan" + CHR(231) + "amento das Opera" + CHR(231) + CHR(245) + "es no Destino (Em Branco Assume a Data da Origem)"
                .BorderColor   = RGB(90, 90, 90)
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            *-- getToleras - tolerancia AU (Format "K"/InputMask "999.99"
            *-- do dump - regra CLAUDE.md #49, transcricao literal).
            loc_oCnt.AddObject("txt_4c_Toleras", "TextBox")
            WITH loc_oCnt.txt_4c_Toleras
                .Top               = 27
                .Left              = 90
                .Width             = 55
                .Height            = 25
                .FontName          = "Courier New"
                .FontSize          = 9
                .Format            = "K"
                .InputMask         = "999.99"
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor       = RGB(90, 90, 90)
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            *-- Say7 do dump - "Tolerancia AU :".
            loc_oCnt.AddObject("lbl_4c_Toleras", "Label")
            WITH loc_oCnt.lbl_4c_Toleras
                .Top       = 32
                .Left      = 3
                .Width     = 75
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "\<" + "Toler" + CHR(226) + "ncia AU :"
                .Visible   = .T.
            ENDWITH

            *-- Say2 do dump - "Gr." (rotulo residual ao lado da tolerancia).
            loc_oCnt.AddObject("lbl_4c_Gr", "Label")
            WITH loc_oCnt.lbl_4c_Gr
                .Top       = 32
                .Left      = 152
                .Width     = 17
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Gr."
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarComplemento")
        ENDTRY
    ENDPROC

    *====================================================================
    * CarregarLista - metodo UNICO de bind/repintura da grade de
    * operacoes candidatas (cursor_4c_Operacoes), chamado por
    * InicializarForm() (cursor ainda vazio, so pinta a casca da grade)
    * e reusado pelo Selecionar() da Fase 7/8 (cursor ja populado).
    *
    * Ordem canonica (regra "Problema 48"/CLAUDE.md): RecordSource (que
    * RESETA Width e Header1.Caption) -> ControlSource de cada coluna ->
    * Width -> Header1.Caption -> GO TOP + Refresh (regra #21 - popular
    * cursor nao repinta a grade por si so). ColumnCount NAO e
    * reatribuido aqui (ja fixo em ConfigurarGrid - regra
    * "SOREDUZIRColumn"); CurrentControl/Sparse do Column1 sao
    * reforcados defensivamente apos o RecordSource.
    *====================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_cCursor, loc_oErro

        loc_cCursor = THIS.this_cCursorOperacoes

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        TRY
            loc_oGrid = THIS.cnt_4c_Grade.grd_4c_Dados

            loc_oGrid.RecordSource = loc_cCursor

            loc_oGrid.Column1.ControlSource = loc_cCursor + ".SelImp"
            loc_oGrid.Column1.AddObject("Check1", "CheckBox")
            loc_oGrid.Column1.Check1.Caption = ""
            loc_oGrid.Column1.CurrentControl = "Check1"
            loc_oGrid.Column1.Sparse         = .F.
            loc_oGrid.Column1.ReadOnly       = .F.
            loc_oGrid.Column1.Width          = 15

            loc_oGrid.Column2.ControlSource = loc_cCursor + ".Numes"
            loc_oGrid.Column2.Width         = 52
            loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"

            loc_oGrid.Column3.ControlSource = loc_cCursor + ".Datas"
            loc_oGrid.Column3.Width         = 80
            loc_oGrid.Column3.Header1.Caption = "Data"

            loc_oGrid.Column4.ControlSource = loc_cCursor + ".Valos"
            loc_oGrid.Column4.Width         = 104
            loc_oGrid.Column4.Header1.Caption = "Valor"

            loc_oGrid.Column5.ControlSource = loc_cCursor + ".Notas"
            loc_oGrid.Column5.Width         = 75
            loc_oGrid.Column5.Header1.Caption = "Documento"

            loc_oGrid.Column6.ControlSource = loc_cCursor + ".Usuars"
            loc_oGrid.Column6.Width         = 85
            loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"

            loc_oGrid.Column7.ControlSource = loc_cCursor + ".ContaOs"
            loc_oGrid.Column7.Width         = 85
            loc_oGrid.Column7.Header1.Caption = "Origem"

            loc_oGrid.Column8.ControlSource = loc_cCursor + ".ContaDs"
            loc_oGrid.Column8.Width         = 85
            loc_oGrid.Column8.Header1.Caption = "Destino"

            loc_oGrid.Column9.ControlSource = loc_cCursor + ".Emps"
            loc_oGrid.Column9.Width         = 37
            loc_oGrid.Column9.Header1.Caption = "Orig."

            loc_oGrid.Column10.ControlSource = loc_cCursor + ".EmpDs"
            loc_oGrid.Column10.Width         = 37
            loc_oGrid.Column10.Header1.Caption = "Dest."

            loc_oGrid.Column11.ControlSource = loc_cCursor + ".Dopes"
            loc_oGrid.Column11.Width         = 242
            loc_oGrid.Column11.ReadOnly      = .F.
            loc_oGrid.Column11.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"

            SELECT (loc_cCursor)
            GO TOP
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *====================================================================
    * ConfigurarEventosBotoes - BINDEVENT dos botoes de acao (cmg_4c_
    * CmdBtnForm/cmg_4c_CmdBtnGrade/cmd_4c_CmdSelecionar), do checkbox
    * grafico (chk_4c_Fwcheckbox1) e dos 4 handlers da coluna de
    * marcacao da grade (Column1.Check1 - regra CLAUDE.md #46/#18).
    * Chamado ao final de ConfigurarLayout(), depois que todos os
    * controles referenciados ja existem (regra CLAUDE.md "BINDEVENT em
    * objeto que ainda nao existe estoura no proprio bind").
    *====================================================================
    PROTECTED PROCEDURE ConfigurarEventosBotoes()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.cnt_4c_Operacoes.cmd_4c_CmdSelecionar, "Click", THIS, "CmdSelecionarClick")
            BINDEVENT(THIS.cnt_4c_Operacoes.chk_4c_Fwcheckbox1, "InteractiveChange", THIS, "ChkFwcheckbox1InteractiveChange")
            BINDEVENT(THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm, "Click", THIS, "CmdBtnFormClick")
            BINDEVENT(THIS.cmg_4c_CmdBtnGrade, "Click", THIS, "CmdBtnGradeClick")

            WITH THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1
                BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "Click",     THIS, "Check1Click")
                BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "KeyPress",  THIS, "Check1KeyPress")
                BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "MouseDown", THIS, "Check1MouseDown")
                BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "MouseUp",   THIS, "Check1MouseUp")
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarEventosBotoes")
        ENDTRY
    ENDPROC

    *====================================================================
    * AtualizarFiltroNoBO - copia o filtro/periodo/processo/complemento
    * da tela para as properties correspondentes do BO (cntFiltro/
    * cntOperacoes/cntComplemento do legado -> this_cEmpOs/this_cEmpDs/
    * this_dDtIni/this_dDtFin/this_cProcesso/this_nProcessados/
    * this_lExibirMensagens/this_dDtLanc/this_nToleras - ver cabecalho
    * de sigoppopBO.prg). Chamado por CmdSelecionarClick() antes de
    * THIS.this_oBusinessObject.Selecionar().
    *====================================================================
    PROTECTED PROCEDURE AtualizarFiltroNoBO()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_cEmpOs           = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value)
        loc_oBO.this_cEmpDs           = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value)
        loc_oBO.this_dDtIni           = ConverterParaData(THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value)
        loc_oBO.this_dDtFin           = ConverterParaData(THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value)
        loc_oBO.this_cProcesso        = ALLTRIM(THIS.cnt_4c_Operacoes.cbo_4c_CmbOperacoes.Value)
        loc_oBO.this_nProcessados     = THIS.cnt_4c_Operacoes.obj_4c_OptProcessados.Value
        loc_oBO.this_lExibirMensagens = (THIS.cnt_4c_Operacoes.chk_4c_ChkMensa.Value = 1)
        loc_oBO.this_dDtLanc          = ConverterParaData(THIS.cnt_4c_Complemento.txt_4c_DtLanc.Value)
        loc_oBO.this_nToleras         = THIS.cnt_4c_Complemento.txt_4c_Toleras.Value
    ENDPROC

    *====================================================================
    * CmdSelecionarClick - equivalente ao Valid legado de cmdSelecionar
    * ("ThisForm.Selecionar()", dump:10713-10715) - migrado para Click
    * (evento confiavel para CommandButton via BINDEVENT neste
    * projeto). Delega a selecao de operacoes candidatas ao BO
    * (Fase 8/8 - ver nota no cabecalho do arquivo) e, com sucesso,
    * repinta a grade e reproduz o bloco de habilitar/desabilitar do
    * legado (dump:10265-10287): trava o filtro/periodo/processo,
    * libera Limpar/Copiar/MarcaTudo/Desmarcar/Documentos/ChkMensa.
    *====================================================================
    PROCEDURE CmdSelecionarClick()
        LOCAL loc_oCnt, loc_dIni, loc_dFin, loc_lProsseguir, loc_oErro

        loc_lProsseguir = .T.

        TRY
            loc_oCnt = THIS.cnt_4c_Operacoes

            *-- Confirmacao de REPROCESSAMENTO (dump:9951-9958): escolher
            *-- "Ja Processadas" avisa que o destino pode receber registros
            *-- duplicados e, recusando, volta a opcao para 1.
            IF loc_oCnt.obj_4c_OptProcessados.Value = 2
                IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Opera" + ;
                        CHR(231) + CHR(245) + "es J" + CHR(225) + " Processadas Anteriormente?" + CHR(13) + ;
                        "Este Processo Poder" + CHR(225) + " Lan" + CHR(231) + "ar Registros Duplicados no Destino no" + CHR(13) + ;
                        "Caso dos Mesmos N" + CHR(227) + "o Terem Sido Anteriormente Exclu" + CHR(237) + "dos.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oCnt.obj_4c_OptProcessados.Value = 1
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- Validacao do periodo (dump:9995-10013) - com SetFocus no
            *-- campo recusado, por isso fica aqui e nao no BO.
            IF loc_lProsseguir
                loc_dIni = ConverterParaData(loc_oCnt.txt_4c_DtIni.Value)
                loc_dFin = ConverterParaData(loc_oCnt.txt_4c_DtFin.Value)

                DO CASE
                CASE EMPTY(loc_dIni)
                    MsgAviso("Data Inicial Inv" + CHR(225) + "lida", "")
                    loc_oCnt.txt_4c_DtIni.SetFocus()
                    loc_lProsseguir = .F.

                CASE EMPTY(loc_dFin)
                    MsgAviso("Data Final Inv" + CHR(225) + "lida", "")
                    loc_oCnt.txt_4c_DtFin.SetFocus()
                    loc_lProsseguir = .F.

                CASE loc_dFin < loc_dIni
                    MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial", "")
                    loc_oCnt.txt_4c_DtFin.SetFocus()
                    loc_lProsseguir = .F.
                ENDCASE
            ENDIF

            IF loc_lProsseguir
                THIS.AtualizarFiltroNoBO()
            ENDIF

            IF loc_lProsseguir AND THIS.this_oBusinessObject.Selecionar()
                *-- O Selecionar do BO pode ter MUDADO a tolerancia (vem do
                *-- processo) e recuado a data inicial (processo que copia
                *-- fiscais): a tela tem de refletir isso.
                THIS.BOParaForm()

                THIS.CarregarLista()
                THIS.AplicarOrdemGrade()

                WITH THIS.cnt_4c_Operacoes
                    .txt_4c_DtIni.Enabled                     = .F.
                    .txt_4c_DtFin.Enabled                     = .F.
                    .obj_4c_OptProcessados.Buttons(1).Enabled = .F.
                    .obj_4c_OptProcessados.Buttons(2).Enabled = .F.
                    .cbo_4c_CmbOperacoes.Enabled               = .F.
                    .cmd_4c_CmdSelecionar.Enabled               = .F.
                    .chk_4c_ChkMensa.Enabled                    = .T.
                ENDWITH

                WITH THIS.cnt_4c_Filtro
                    .txt_4c_EmpOs.Enabled  = .F.
                    .txt_4c_DEmpOs.Enabled = .F.
                    .txt_4c_EmpDs.Enabled  = .F.
                    .txt_4c_DEmpDs.Enabled = .F.
                ENDWITH

                WITH THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
                    .Buttons(1).Enabled = .T.
                    .Buttons(2).Enabled = .T.
                ENDWITH

                WITH THIS.cmg_4c_CmdBtnGrade
                    .Buttons(1).Enabled = .T.
                    .Buttons(2).Enabled = .T.
                    .Buttons(3).Enabled = .T.
                ENDWITH

                THIS.cnt_4c_Grade.grd_4c_Dados.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CmdSelecionarClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * BOParaForm - devolve a tela os dois valores que o Selecionar() do
    * BO altera, reproduzindo o que o legado faz escrevendo direto no
    * controle de dentro do proprio Selecionar:
    *
    *   this_nToleras -> cnt_4c_Complemento.txt_4c_Toleras
    *       ("ThisForm.cntComplemento.getToleras.Value =
    *         crSigPcOop.Toleras" - dump:9967)
    *   this_dDtIni   -> cnt_4c_Operacoes.txt_4c_DtIni
    *       (processo que copia fiscais recua a data inicial em 5 dias:
    *        "getDtIni.Value = getDtIni.Value - 5" + Refresh -
    *        dump:9969-9974)
    *
    * Par de AtualizarFiltroNoBO (Form -> BO). Chamado por
    * CmdSelecionarClick depois de Selecionar().
    *====================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        THIS.cnt_4c_Complemento.txt_4c_Toleras.Value = loc_oBO.this_nToleras
        THIS.cnt_4c_Complemento.txt_4c_Toleras.Refresh()

        IF !EMPTY(loc_oBO.this_dDtIni)
            THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value = loc_oBO.this_dDtIni
            THIS.cnt_4c_Operacoes.txt_4c_DtIni.Refresh()
        ENDIF
    ENDPROC

    *====================================================================
    * AplicarOrdemGrade - ordena a grade pelo criterio escolhido no
    * Processo de Copia (SigPcOoP.Ordems, lido por Selecionar() em
    * this_nOrdemGrade). Equivalente ao
    * "Select csOperacoes / Set Order To Operacao / Do Case ... Set
    * Order To Data|Nota|Origem|Destino / Go Top" do legado
    * (dump:10251-10263). Os TAGs sao criados com o cursor, em
    * ConfigurarGrid.
    *====================================================================
    PROCEDURE AplicarOrdemGrade()
        LOCAL loc_cCursor, loc_nOrdem, loc_oErro

        loc_cCursor = THIS.this_cCursorOperacoes

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        TRY
            loc_nOrdem = THIS.this_oBusinessObject.this_nOrdemGrade

            SELECT (loc_cCursor)

            DO CASE
            CASE loc_nOrdem = 2
                SET ORDER TO TAG Data
            CASE loc_nOrdem = 3
                SET ORDER TO TAG Nota
            CASE loc_nOrdem = 4
                SET ORDER TO TAG Origem
            CASE loc_nOrdem = 5
                SET ORDER TO TAG Destino
            OTHERWISE
                SET ORDER TO TAG Operacao
            ENDCASE

            GO TOP
            THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AplicarOrdemGrade")
        ENDTRY
    ENDPROC

    *====================================================================
    * ChkFwcheckbox1InteractiveChange - equivalente ao InteractiveChange
    * legado ("ThisForm.ShowTips = (This.Value = 1)", dump:10727-10729).
    *====================================================================
    PROCEDURE ChkFwcheckbox1InteractiveChange()
        THIS.ShowTips = (THIS.cnt_4c_Operacoes.chk_4c_Fwcheckbox1.Value = 1)
    ENDPROC

    *====================================================================
    * LimpaSelecao - equivalente ao metodo legado "limpaselecao"
    * (dump:5610-5647): limpa o cursor de operacoes candidatas e
    * devolve o filtro/periodo/processo ao estado inicial (reabilita
    * para nova selecao, desabilita Limpar/Copiar/MarcaTudo/Desmarcar/
    * Documentos/ChkMensa - espelho exato do bloco Enabled do legado).
    * Metodo autossuficiente - nao depende de nenhum metodo do BO ainda
    * nao escrito.
    *====================================================================
    PROCEDURE LimpaSelecao()
        LOCAL loc_cCursor, loc_oErro

        loc_cCursor = THIS.this_cCursorOperacoes

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                ZAP
            ENDIF

            WITH THIS.cnt_4c_Operacoes
                .txt_4c_DtIni.Enabled                     = .T.
                .txt_4c_DtFin.Enabled                     = .T.
                .cbo_4c_CmbOperacoes.Enabled               = .T.
                .cmd_4c_CmdSelecionar.Enabled               = .T.
                .obj_4c_OptProcessados.Buttons(1).Enabled = .T.
                .obj_4c_OptProcessados.Buttons(2).Enabled = .T.
                .chk_4c_ChkMensa.Enabled                    = .F.
            ENDWITH

            WITH THIS.cnt_4c_Filtro
                .txt_4c_EmpOs.Enabled  = .T.
                .txt_4c_DEmpOs.Enabled = .T.
                .txt_4c_EmpDs.Enabled  = .T.
                .txt_4c_DEmpDs.Enabled = .T.
            ENDWITH

            WITH THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .F.
            ENDWITH

            WITH THIS.cmg_4c_CmdBtnGrade
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .F.
            ENDWITH

            THIS.CarregarLista()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em LimpaSelecao")
        ENDTRY
    ENDPROC

    *====================================================================
    * CmdBtnFormClick - equivalente ao Click de cmdBtnForm (dump:10809-
    * 10897): Value=1 Limpar -> THIS.LimpaSelecao(); Value=2 Copiar ->
    * guarda de selecao (regra CLAUDE.md #50 - "Select SelImp, Count(1)
    * ... Where SelImp ... If Selecionados < 1" do legado, aqui via
    * COUNT TO ... FOR SelImp apos SELECT do alias - regra CLAUDE.md
    * "COUNT TO var IN alias PROIBIDO") seguida de THIS.
    * this_oBusinessObject.Processamento() (Fase 8/8 - ver nota no
    * cabecalho do arquivo); Value=3 Encerrar -> THIS.Release()
    * (equivalente a "ThisForm.Release" do btnSair, dump:10885-10897).
    *====================================================================
    PROCEDURE CmdBtnFormClick()
        LOCAL loc_oGrupo, loc_cCursor, loc_nSelecionados, loc_oErro

        loc_oGrupo  = THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
        loc_cCursor = THIS.this_cCursorOperacoes

        TRY
            DO CASE
            CASE loc_oGrupo.Value = 1 AND loc_oGrupo.Buttons(1).Enabled
                THIS.LimpaSelecao()

            CASE loc_oGrupo.Value = 2 AND loc_oGrupo.Buttons(2).Enabled
                loc_nSelecionados = 0
                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    COUNT TO loc_nSelecionados FOR SelImp
                ENDIF

                IF loc_nSelecionados < 1
                    MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Encontrado!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.cnt_4c_Operacoes.cbo_4c_CmbOperacoes.SetFocus
                ELSE
                    *-- Fecho do legado, comum ao Processamento e ao
                    *-- Financeiro (dump:9933-9934 e 2761-2762): copia
                    *-- concluida devolve a tela ao estado inicial e refaz a
                    *-- selecao, para o usuario ver o que ainda falta copiar.
                    IF THIS.this_oBusinessObject.Processamento()
                        THIS.LimpaSelecao()
                        THIS.CmdSelecionarClick()
                    ENDIF
                ENDIF

            CASE loc_oGrupo.Value = 3
                THIS.Release()
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CmdBtnFormClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * CmdBtnGradeClick - equivalente ao Click de cmdBtnGrade (dump:
    * 10488-10513): Value=1 Marca Tudo / Value=2 Desmarcar (REPLACE ALL
    * SelImp na cursor_4c_Operacoes + GO TOP + Refresh) / Value=3
    * Documentos (abre FormSigMvExp para a operacao corrente da grade,
    * ou avisa se Deletado - equivalente a "Do Form SigMvExp With
    * csOperacoes.Dopes, 'C', csOperacoes.Numes, csOperacoes.Emps,
    * .t."). Metodo autossuficiente.
    *====================================================================
    PROCEDURE CmdBtnGradeClick()
        LOCAL loc_oGrupo, loc_cCursor, loc_oForm, loc_oErro

        loc_oGrupo  = THIS.cmg_4c_CmdBtnGrade
        loc_cCursor = THIS.this_cCursorOperacoes

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        TRY
            DO CASE
            CASE loc_oGrupo.Value = 1 AND loc_oGrupo.Buttons(1).Enabled
                SELECT (loc_cCursor)
                REPLACE ALL SelImp WITH .T.
                GO TOP
                THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()

            CASE loc_oGrupo.Value = 2 AND loc_oGrupo.Buttons(2).Enabled
                SELECT (loc_cCursor)
                REPLACE ALL SelImp WITH .F.
                GO TOP
                THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()

            CASE loc_oGrupo.Value = 3 AND loc_oGrupo.Buttons(3).Enabled
                SELECT (loc_cCursor)
                IF !EOF()
                    IF Deletado
                        MsgAviso("Essa Opera" + CHR(231) + CHR(227) + "o Foi Exclu" + CHR(237) + "da do Sistema!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                    ELSE
                        loc_oForm = CREATEOBJECT("FormSigMvExp", Dopes, "C", Numes, Emps, .T.)
                        IF VARTYPE(loc_oForm) = "O"
                            loc_oForm.Show()
                        ENDIF
                    ENDIF
                ENDIF
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CmdBtnGradeClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * Check1Click/KeyPress/MouseDown/MouseUp - toggle da marcacao
    * (SelImp) da coluna 1 da grade. NODEFAULT nos 4 (equivalente ao
    * legado, dump:10523-10575): o toggle nativo do CheckBox e
    * SUPRIMIDO e o REPLACE e feito a mao, igual ao legado ("m.SelImp =
    * (Not csOperacoes.SelImp) / Gather Memvar Fields SelImp"), regra
    * CLAUDE.md #46 (Valid/KeyPress da celula, nao AfterRowColChange).
    *====================================================================
    PROCEDURE Check1Click()
        NODEFAULT
    ENDPROC

    PROCEDURE Check1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor

        IF INLIST(par_nKeyCode, 13, 32)
            loc_cCursor = THIS.this_cCursorOperacoes
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                REPLACE SelImp WITH !SelImp
                THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE Check1MouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_cCursorOperacoes
        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE SelImp WITH !SelImp
            THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
        ENDIF
        NODEFAULT
    ENDPROC

    PROCEDURE Check1MouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *====================================================================
    * Destroy - fecha o cursor da grade de operacoes e o cursor da lista
    * de Processos de Copia (RowSource do combo) e encadeia para
    * FormBase.Destroy() (libera this_oBusinessObject e restaura o
    * menu principal).
    *====================================================================
    PROCEDURE Destroy()
        IF !EMPTY(THIS.this_cCursorOperacoes) AND USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF

        IF !EMPTY(THIS.this_cCursorProcessos) AND USED(THIS.this_cCursorProcessos)
            USE IN (THIS.this_cCursorProcessos)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigoppopBO.prg):
*====================================================================
* sigoppopBO.prg
*
* Business Object do form OPERACIONAL "SIGOPPOP" ("Transferencia Entre
* Locais" - copia operacoes de movimento de uma empresa/documento de
* ORIGEM para uma empresa/documento de DESTINO, conforme um "Processo
* de Copia" pre-configurado). Form de topo (sem Lparameters no Init do
* legado - NAO e filho de outro form, ao contrario de sigoppagBO/
* sigoporcBO).
*
* Tabela principal (legado: AddCursor('SigPcOnp','cIdChaves',
* 'CrSigPcOnp') dentro do Init do SIGOPPOP) - registro de mapeamento
* "operacao de origem -> operacao copiada no destino", usado por
* AcertaEmpDopNums/fazContra/demais metodos de copia para nunca
* duplicar a mesma operacao:
*   SigPcOnp.cIdChaves/EmpDopNums/NoperNews/NoperOrigs ->
*       this_cCidchaves/this_cEmpdopnums/this_nNopernews/
*       this_nNoperorigs
*
* Tabelas de configuracao do "Processo de Copia" (cadastradas em outro
* form - SIGOPPOP so LE), usadas para montar o combo de processos e
* filtrar as operacoes candidatas:
*   SigPcOoP (cabecalho do processo - Codigos/Class/Grupo/Toleras/
*             Apagar/Fiscal/Imprimir/Logs/Notas/Ordems)
*   SigPcOoI (itens do processo por Empresa/Documento Origem+Destino -
*             Processos/Emps/Dopes/Codigos/Drives/EmpDs/DopeDs/...)
* Essas tabelas sao lidas via SQLEXEC em cursor temporario nos metodos
* de carga (fase posterior) - sem properties this_ dedicadas, pois o
* conteudo vai direto para cursores (csOrigens/crSigCdPsg/crSigCdGrp/
* etc, equivalentes aos CursorQuery do legado).
*
* Movimento copiado (SigMvCab/SigMvItn/SigMvHst/SigMvNfi e correlatas) -
* leitura/gravacao feita por SQLEXEC direto dentro dos metodos de
* processamento (fase posterior), sem properties this_ dedicadas - o
* volume de colunas envolvidas (ver comportamento.json) e tratado via
* cursores temporarios linha a linha, no mesmo padrao do legado
* (Scan/Replace em cursores locais), nao via FormParaBO/BOParaForm.
*
* Filtro e selecao da tela (cntFiltro/cntOperacoes/cntComplemento do
* legado) - estado de negocio que atravessa Selecionar()/
* Processamento() nas fases posteriores:
*   cntFiltro.getEmpOs/getEmpDs -> this_cEmpOs/this_cEmpDs (empresa de
*       origem/destino, validadas contra SigCdEmp - padrao
*       VerificarAcessoEmpresa/FormBuscaAuxiliar, fAcessoEmpresa() NAO
*       existe)
*   cntOperacoes.getDtIni/getDtFin -> this_dDtIni/this_dDtFin (periodo
*       de selecao das operacoes candidatas)
*   cntOperacoes.cmbOperacoes -> this_cProcesso (nome do Processo de
*       Copia selecionado - SigPcOoP.processos char(20), lido pelo
*       legado via ListItem(ListIndex), NAO pela PK numerica codigos)
*   cntOperacoes.optProcessados -> this_nProcessados (1=Nao Processadas/
*       2=Ja Processadas - INDICE do OptionGroup, NUNCA booleano -
*       regra "numeric(1,0) de duas opcoes nao eh logica")
*   cntOperacoes.chkMensa -> this_lExibirMensagens (exibe MsgErro/
*       MsgAviso durante o processamento; .F. = roda silencioso)
*   cntComplemento.getDtLanc -> this_dDtLanc (data de lancamento das
*       operacoes no destino - vazia assume a data da origem)
*   cntComplemento.getToleras -> this_nToleras (tolerancia AU usada no
*       ajuste de faixa de peso, Format "K"/InputMask "999.99")
*
* Grade de operacoes candidatas/selecionadas (legado: cursor local
* csOperacoes, populado pelo Selecionar.Click e consumido pelo
* Processamento) - mapeamento 1-para-1 das colunas do CREATE CURSOR
* legado (SelImp l(1), Emps c(3), Dopes c(20), Numes n(6), Datas d(8),
* Valos n(12,2), Notas c(10), Usuars c(10), ContaOs c(10), ContaDs
* c(10), EmpDs c(3), Deletado l(1)) para o cursor migrado:
*   this_cCursorOperacoes = "cursor_4c_Operacoes"
*
* Herda de: BusinessBase
*
* Fase 1/8 - propriedades e Init(). this_cTabela/this_cCampoChave
* apontam para SigPcOnp (regra do AddCursor acima) - e a UNICA tabela
* que este BO insere/exclui diretamente; o restante da logica de copia
* (leitura/gravacao de SigMvCab/SigMvItn/SigMvHst/SigMvNfi/SigPcOoI/
* SigPcOoP/SigCdGrp/SigCdPsg/SigCdPam/SigCdPac) e feita por SQLEXEC
* direto nos metodos de fase posterior, sem passar por
* CarregarDoCursor/Inserir/Atualizar/ObterChavePrimaria da entidade
* principal.
*
* Fase 2/8 - CarregarDoCursor()/Inserir()/Atualizar()/
* ObterChavePrimaria() para SigPcOnp (cidchaves gerado via
* fUniqueIds(), regra #22, quando ainda vazio). O legado so grava esta
* tabela via INSERT (um registro por operacao copiada); Atualizar() e
* implementado para completude de CRUD do BO (regra "paridade
* funcional 100%"), mesmo sem call site direto no form.
*
* Fase 5/8 - CarregarProcessos() popula this_cCursorProcessos (lista de
* Processos de Copia de SigPcOoP) para o RowSource do combo da tela.
*
* Fase 8/8 - metodos de acao da tela. O que esta IMPLEMENTADO:
*
*   Selecionar()                 monta a grade de candidatas (dump:9939)
*   CopiarFiscais() / CopiarLogs()   ciclo de fiscais e logs do processo
*   AcertaEmpDopNums()           preenche a chave EmpDopNums (dump:1326)
*   AjustaPesos()                faixas de peso pela tolerancia (dump:1441)
*   GerCodigoP()                 codigo de produto no destino (dump:2765)
*   GarantirCadastroNoDestino()  equivale a LancaDestino (dump:2900)
*   LancaClientes()              codigo do cliente no destino (dump:2827)
*   LancaTabDescto()             tabela de desconto (dump:5582)
*   Casamento()                  casa produto por composicao (dump:1489)
*   Financeiro() + FazContra()   modo FRANQUIA completo (dump:2490/2412)
*   Delecao()                    apaga a operacao de origem (dump:2034)
*   Processamento()              orquestra a acao do botao Copiar (dump:5650)
*
* O que NAO esta transcrito, e por que - ver o cabecalho de
* Processamento() e de CopiarMovimentacoes(): a copia item a item da
* MOVIMENTACAO (LancaProduto, dump:3580-5220; LancaProdutoF,
* dump:5221-5581; LancaProducao, dump:2959-3579; e o laco de destinos
* do Processamento, dump:5810-9700 - cerca de 6.900 linhas). Nesse
* caminho Processamento() RECUSA a operacao antes de gravar qualquer
* coisa, em vez de gravar movimentacao pela metade.
*
* NOTA DE ARQUITETURA que atravessa este BO: o legado abria uma
* conexao fisica POR EMPRESA DE DESTINO (fSqlConector sobre
* SigCdLoc.cIdConns - cada empresa tinha seu conjunto de .DBF) e
* copiava CADASTRO de origem para destino linha a linha. Aqui existe
* UM SQL Server (gnConnHandle) e a empresa e a coluna Emps/EmpDs
* (PILAR 2): origem e destino sao a MESMA tabela, entao a copia de
* cadastro deixa de existir (reexecuta-la DUPLICARIA o registro) e o
* que resta do ciclo e marcar a origem como copiada. Cada metodo
* afetado documenta isso no proprio cabecalho.
*====================================================================

DEFINE CLASS sigoppopBO AS BusinessBase

	*-- Nome do cursor que este BO popula/consome para a grade de
	*-- operacoes candidatas/selecionadas (equivalente ao cursor local
	*-- csOperacoes do legado) - constante, para o Form referenciar sem
	*-- repetir literal.
	this_cCursorOperacoes = "cursor_4c_Operacoes"

	*-- Nome do cursor que CarregarProcessos() popula (lista de Processos
	*-- de Copia cadastrados em SigPcOoP, usada pelo RowSource do combo
	*-- cbo_4c_CmbOperacoes) - Fase 5/8.
	this_cCursorProcessos = "cursor_4c_Processos"

	*-- Cursor com o CABECALHO do Processo de Copia selecionado
	*-- (equivalente a crSigPcOop do legado - CursorQuery('SigPcOop',
	*-- 'crSigPcOop','Processos',lcPro)). Populado por Selecionar() e
	*-- relido por Processamento()/CopiarFiscais().
	this_cCursorProcessoAtual = "cursor_4c_ProcessoAtual"

	*-- Cursor com os ITENS do Processo de Copia (par Empresa/Documento
	*-- de ORIGEM) - equivalente a csCpOI/csCpOri do legado.
	this_cCursorProcOrigens = "cursor_4c_ProcOrigens"

	*-- Cursor com os DESTINOS de cada item do Processo de Copia (join
	*-- SigPcOoI x SigCdLoc) - equivalente a crTodosDestinos/csDestinos
	*-- do legado.
	this_cCursorDestinos = "cursor_4c_Destinos"

	*-- Cursor de trabalho com as operacoes candidatas montadas pelo
	*-- Selecionar() antes de irem para a grade (equivalente a csDados).
	this_cCursorCandidatas = "cursor_4c_Candidatas"

	*-- Ordem de exibicao da grade escolhida no Processo de Copia
	*-- (SigPcOoP.ordems - 1=Operacao; 2=Data; 3=Nota; 4=Origem;
	*-- 5=Destino). Lida por Selecionar() e aplicada pelo Form
	*-- (Set Order To <tag>), igual ao DO CASE do legado.
	this_nOrdemGrade = 1

	*-- Quantidade de operacoes que o ultimo Selecionar() carregou na
	*-- grade (0 = nada encontrado no periodo/filtro).
	this_nTotalSelecionadas = 0

	*-- Cursor com os parametros gerais (SigCdPam) e a chave de
	*-- identificacao (SigCdPac.SigKeys) usados pelos lancamentos
	*-- financeiros - equivalentes a crSigCdPam/crSigCdPac do Init
	*-- legado. Populados por CarregarParametros().
	this_cCursorParametros = "cursor_4c_Parametros"
	this_cCursorSigKey     = "cursor_4c_SigKey"

	*-- Propriedades da entidade principal (mapeamento 1-para-1 para
	*-- SigPcOnp - registro de mapeamento operacao origem -> operacao
	*-- copiada no destino, chave cIdChaves).
	this_cCidchaves    = ""  && cidchaves char(20) - PK (fUniqueIds())
	this_cEmpdopnums   = ""  && empdopnums char(29) - Emps(3)+Dopes(20)+Str(Numes,6) da operacao de ORIGEM (chave posicional, regra #42 - PADR explicito)
	this_nNopernews    = 0   && nopernews numeric(7,0) - numero da operacao gerada no DESTINO
	this_nNoperorigs   = 0   && noperorigs numeric(7,0) - numero da operacao na ORIGEM

	*-- Filtro de empresa (cntFiltro do legado - getEmpOs/getEmpDs,
	*-- validados contra SigCdEmp.Cemps; getDEmpOs/getDEmpDs sao so a
	*-- descricao/Razas, nao persistida como property).
	this_cEmpOs = ""  && getEmpOs.Value - empresa de ORIGEM das operacoes a copiar
	this_cEmpDs = ""  && getEmpDs.Value - empresa de DESTINO das operacoes copiadas

	*-- Periodo e processo de copia (cntOperacoes do legado).
	this_dDtIni = {}        && getDtIni.Value - data inicial do periodo de selecao das operacoes candidatas (default Date() no Init do legado)
	this_dDtFin = {}        && getDtFin.Value - data final do periodo de selecao das operacoes candidatas (default Date() no Init do legado)
	this_cProcesso = ""     && cmbOperacoes.Value - nome do Processo de Copia selecionado (SigPcOoP.processos char(20) - legado le via ListItem(ListIndex), NAO pela PK numerica SigPcOoP.codigos; cadastrado em form proprio)
	this_nProcessados = 1   && optProcessados.Value - 1=Nao Processadas / 2=Ja Processadas (INDICE do OptionGroup, nao booleano)
	this_lExibirMensagens = .T.  && chkMensa.Value - exibe MsgErro/MsgAviso durante o processamento (legado: "Exibir Mensagens de Erro", default marcado)

	*-- Complemento do lancamento no destino (cntComplemento do legado).
	this_dDtLanc = {}   && getDtLanc.Value - data de lancamento das operacoes no DESTINO (vazia assume a data da operacao de origem)
	this_nToleras = 0   && getToleras.Value - tolerancia AU usada no ajuste de faixa de peso (Format "K" / InputMask "999.99")

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_lSucesso = DODEFAULT()

			*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
			THIS.this_cTabela     = "SigPcOnp"
			THIS.this_cCampoChave = "cidchaves"
		CATCH TO loException
			MsgErro(loException.Message, "Erro ao inicializar sigoppopBO")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia uma linha de SigPcOnp (cursor populado
	* por SQLEXEC) para as properties da entidade. NAO e PROTECTED
	* (regra #51 - BusinessBase declara publico).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
			THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
			THIS.this_nNopernews  = TratarNulo(nopernews, 0)
			THIS.this_nNoperorigs = TratarNulo(noperorigs, 0)

			loc_lResultado = .T.
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - cidchaves (PK Fortyus, regra #22). PROTECTED:
	* nunca chamado de fora (so por RegistrarAuditoria/ExecutarExclusao).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidchaves
	ENDPROC

	*====================================================================
	* Inserir - INSERT completo em SigPcOnp (mapeamento operacao de
	* ORIGEM -> operacao copiada no DESTINO). cidchaves (PK) e gerada
	* aqui se ainda vazia (regra #22 - fUniqueIds(), NUNCA string
	* vazia). As 4 colunas da tabela sao NOT NULL (conferido em
	* docs\schema.sql) e ja tem property dedicada - nao ha coluna
	* oculta a cobrir (regra #22/INSERT NOT NULL).
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		IF EMPTY(THIS.this_cCidchaves)
			THIS.this_cCidchaves = fUniqueIds()
		ENDIF

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigPcOnp (
					cidchaves, empdopnums, nopernews, noperorigs
				)
				VALUES (
					<<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>,
					<<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
					<<FormatarNumeroSQL(THIS.this_nNopernews, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNoperorigs, 0)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERIR")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao inserir mapeamento de opera" + CHR(231) + CHR(227) + "o copiada:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao inserir mapeamento de opera" + CHR(231) + CHR(227) + "o copiada:" + CHR(13) + loc_oErro.Message, "sigoppopBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarProcessos - popula this_cCursorProcessos com a lista de
	* Processos de Copia cadastrados (SigPcOoP.processos, char(20) - o
	* legado le o mesmo texto via cmbOperacoes.ListItem(ListIndex), nao
	* por codigos numeric). Usado por Formsigoppop.ConfigurarOperacoes()
	* para montar o RowSource (Alias) do cbo_4c_CmbOperacoes - Fase 5/8.
	* SigPcOoP e cadastrada em outro form; este BO so LE.
	*====================================================================
	PROCEDURE CarregarProcessos()
		LOCAL loc_cCursor, loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.
		loc_cCursor  = THIS.this_cCursorProcessos

		TRY
			IF USED(loc_cCursor)
				USE IN (loc_cCursor)
			ENDIF

			loc_cSQL = "SELECT DISTINCT processos FROM SigPcOoP ORDER BY processos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao buscar Processos de C" + CHR(243) + "pia cadastrados:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao buscar Processos de C" + CHR(243) + "pia cadastrados:" + CHR(13) + loc_oErro.Message, "sigoppopBO.CarregarProcessos")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE completo em SigPcOnp pela PK cidchaves.
	* cidchaves identifica o registro e NAO entra no SET.
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigPcOnp SET
					empdopnums = <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
					nopernews  = <<FormatarNumeroSQL(THIS.this_nNopernews, 0)>>,
					noperorigs = <<FormatarNumeroSQL(THIS.this_nNoperorigs, 0)>>
				WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("ALTERAR")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao atualizar mapeamento de opera" + CHR(231) + CHR(227) + "o copiada:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao atualizar mapeamento de opera" + CHR(231) + CHR(227) + "o copiada:" + CHR(13) + loc_oErro.Message, "sigoppopBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC


	*====================================================================
	* CriarBarraProgresso - instancia a barra de progresso do framework
	* (equivalente a CreateObject('fwprogressbar', <titulo>, <total>) +
	* .Show do legado). Devolve .NULL. quando a classe nao esta
	* disponivel, para que o chamador siga sem barra em vez de abortar.
	*====================================================================
	PROTECTED FUNCTION CriarBarraProgresso(par_cTitulo, par_nTotal)
		LOCAL loc_oBarra, loc_oErro

		loc_oBarra = .NULL.

		TRY
			loc_oBarra = CREATEOBJECT("fwprogressbar", par_cTitulo, MAX(par_nTotal, 1))

			IF VARTYPE(loc_oBarra) = "O"
				loc_oBarra.Titulo.FontBold = .T.
				loc_oBarra.Show()
			ELSE
				loc_oBarra = .NULL.
			ENDIF
		CATCH TO loc_oErro
			loc_oBarra = .NULL.
		ENDTRY

		RETURN loc_oBarra
	ENDFUNC

	*====================================================================
	* AvancarBarra / EncerrarBarra - atalhos tolerantes a barra ausente
	* (equivalentes a oProg.Update(.t.) / oProg.Complete do legado).
	*====================================================================
	PROTECTED PROCEDURE AvancarBarra(par_oBarra)
		IF VARTYPE(par_oBarra) = "O"
			par_oBarra.Update(.T.)
		ENDIF
	ENDPROC

	PROTECTED PROCEDURE EncerrarBarra(par_oBarra)
		IF VARTYPE(par_oBarra) = "O"
			par_oBarra.Complete(.T.)
		ENDIF
	ENDPROC

	*====================================================================
	* ExecutarConsulta - executa um SELECT no SQL Server devolvendo o
	* resultado no cursor par_cCursor. Equivalente ao
	* "If (ThisForm.poDataMgr.SqlExecute(lcQuery, '<cursor>') < 1) /
	* MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na
	* Conexao (<cursor>)')" repetido em todo o legado - a mensagem e o
	* titulo sao os mesmos, com par_cContexto no lugar do nome do
	* cursor legado.
	*
	* O cursor de destino e FECHADO antes do SQLEXEC: reaproveitar um
	* alias aberto deixa o SQLEXEC estourar "uncommitted changes".
	* TABLEREVERT so entra sob guarda de buffering (regra CLAUDE.md
	* #52).
	*====================================================================
	PROTECTED FUNCTION ExecutarConsulta(par_cSQL, par_cCursor, par_cContexto)
		LOCAL loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		TRY
			IF !EMPTY(par_cCursor) AND USED(par_cCursor)
				IF CURSORGETPROP("Buffering", par_cCursor) > 1
					TABLEREVERT(.T., par_cCursor)
				ENDIF
				USE IN (par_cCursor)
			ENDIF

			IF EMPTY(par_cCursor)
				loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL)
			ELSE
				loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
			ENDIF

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CHR(13) + ;
					THIS.this_cMensagemErro, ;
					"Falha na Conex" + CHR(227) + "o (" + ALLTRIM(par_cContexto) + ")")
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CHR(13) + ;
				loc_oErro.Message, ;
				"Falha na Conex" + CHR(227) + "o (" + ALLTRIM(par_cContexto) + ")")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* FecharCursor - fecha um alias de trabalho se estiver aberto
	* (equivalente ao "Use In <cursor>" do legado), respeitando a
	* guarda de buffering da regra CLAUDE.md #52.
	*====================================================================
	PROTECTED PROCEDURE FecharCursor(par_cCursor)
		IF !EMPTY(par_cCursor) AND USED(par_cCursor)
			IF CURSORGETPROP("Buffering", par_cCursor) > 1
				TABLEREVERT(.T., par_cCursor)
			ENDIF
			USE IN (par_cCursor)
		ENDIF
	ENDPROC

	*====================================================================
	* CarregarProcessoAtual - recarrega o cabecalho do Processo de Copia
	* selecionado (this_cProcesso) em this_cCursorProcessoAtual.
	* Equivalente a "ThisForm.poDataMgr.CursorQuery('SigPcOop',
	* 'crSigPcOop', 'Processos', lcPro)" do legado, que o Selecionar e o
	* Processamento repetem a cada volta do laco.
	*====================================================================
	PROTECTED FUNCTION CarregarProcessoAtual(par_cContexto)
		LOCAL loc_cSQL, loc_cCursor, loc_lSucesso

		loc_lSucesso = .F.
		loc_cCursor  = THIS.this_cCursorProcessoAtual

		loc_cSQL = "SELECT processos, emps, dopes, codigos, notas, ordems," + ;
			" apagar, fiscal, imprimir, logs, toleras, class, grupo" + ;
			" FROM SigPcOoP" + ;
			" WHERE processos = " + EscaparSQL(PADR(THIS.this_cProcesso, 20))

		IF THIS.ExecutarConsulta(loc_cSQL, loc_cCursor, par_cContexto)
			SELECT (loc_cCursor)
			GO TOP
			IF EOF()
				MsgErro("O Processo " + ALLTRIM(THIS.this_cProcesso) + ;
					" N" + CHR(227) + "o Foi Encontrado!!!", ;
					"(" + ALLTRIM(par_cContexto) + ")")
			ELSE
				loc_lSucesso = .T.
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarEmpresasPermitidas - cursor com as empresas que o usuario
	* logado pode acessar (SigCdAcE). Equivalente a
	* "CursorQuery('SigCdAcE','crSigCdAcE','Usuarios', Usuar, 'Emps') +
	* Index On Emps Tag Emps" do legado.
	*
	* Devolve o NOME do cursor quando ha restricao cadastrada e string
	* vazia quando o usuario nao tem nenhuma linha em SigCdAcE - caso
	* em que o legado NAO filtra nada (If Reccount > 0).
	*====================================================================
	PROTECTED FUNCTION CarregarEmpresasPermitidas()
		LOCAL loc_cSQL, loc_cCursor, loc_cRetorno

		loc_cRetorno = ""
		loc_cCursor  = "cursor_4c_EmpresasAce"

		loc_cSQL = "SELECT emps FROM SigCdAcE" + ;
			" WHERE usuarios = " + EscaparSQL(PADR(gc_4c_UsuarioLogado, 10))

		IF THIS.ExecutarConsulta(loc_cSQL, loc_cCursor, "crSigCdAcE")
			IF RECCOUNT(loc_cCursor) > 0
				SELECT (loc_cCursor)
				INDEX ON emps TAG emps
				SET ORDER TO TAG emps
				loc_cRetorno = loc_cCursor
			ELSE
				THIS.FecharCursor(loc_cCursor)
			ENDIF
		ENDIF

		RETURN loc_cRetorno
	ENDFUNC

	*====================================================================
	* Selecionar - monta a lista de operacoes CANDIDATAS a copia na
	* grade da tela (cursor_4c_Operacoes), equivalente ao
	* "PROCEDURE selecionar" do legado (dump:9939-10291).
	*
	* O que o legado faz e esta aqui, na mesma ordem:
	*   1. le o cabecalho do Processo de Copia (crSigPcOop) e ABORTA se
	*      o processo nao existir;
	*   2. traz a tolerancia do processo para a tela (getToleras.Value =
	*      crSigPcOop.Toleras) - aqui gravada em this_nToleras, que o
	*      Form espelha no campo via BOParaForm();
	*   3. quando o processo copia arquivos FISCAIS (Fiscal = 1), recua
	*      a data inicial em 5 dias (getDtIni.Value - 5) - aqui aplicado
	*      em this_dDtIni, tambem espelhado por BOParaForm();
	*   4. le os ITENS do processo (SigPcOoI) em this_cCursorProcOrigens;
	*   5. para cada item, consulta SigMvCab (e SigExMvc quando o item
	*      manda incluir operacoes EXCLUIDAS - Delets = 1) montando as
	*      candidatas em this_cCursorCandidatas, sem repetir a mesma
	*      chave Emps+Dopes+Numes;
	*   6. descarta as empresas que o usuario logado nao pode acessar
	*      (SigCdAcE);
	*   7. nada encontrado -> copia os arquivos fiscais/de log do
	*      processo (CopiarFiscais/CopiarLogs) e avisa; encontrado ->
	*      insere tudo na grade com SelImp = .T.
	*
	* Diferenca de ARQUITETURA, nao de regra: o legado le/escreve por
	* "driver" (poDataMgr sobre .DBF de cada empresa) e por isso testa
	* getDriver() = 'foxpro'; aqui ha UM SQL Server (gnConnHandle) e a
	* empresa e a coluna Emps/EmpDs (PILAR 2).
	*
	* As validacoes de periodo (data inicial/final vazia, final menor
	* que a inicial) e a confirmacao de reprocessamento ficam no Form,
	* que e quem tem o SetFocus do campo recusado - igual ao legado,
	* que as faz antes de qualquer consulta. O guard abaixo e so a rede
	* de seguranca para chamada direta ao BO.
	*====================================================================
	PROCEDURE Selecionar()
		LOCAL loc_cCurProc, loc_cCurOri, loc_cCurCand, loc_cCurSQL
		LOCAL loc_cCurAce, loc_cSQL, loc_cEmp, loc_cDes, loc_cOpe
		LOCAL loc_cGrupo, loc_cClasse, loc_cColData, loc_cNotIn
		LOCAL loc_nSitua, loc_nDoc, loc_nOrdem, loc_nGlobaliza
		LOCAL loc_lSoNaoProcessadas, loc_lIncluirExcluidas, loc_lProsseguir
		LOCAL loc_oBarra, loc_nTotal, loc_lSucesso, loc_oErro

		loc_lSucesso    = .F.
		loc_lProsseguir = .T.
		loc_oBarra      = .NULL.

		loc_cCurProc = THIS.this_cCursorProcessoAtual
		loc_cCurOri  = THIS.this_cCursorProcOrigens
		loc_cCurCand = THIS.this_cCursorCandidatas
		loc_cCurSQL  = "cursor_4c_CandidatasSQL"

		THIS.this_nTotalSelecionadas = 0

		TRY
			IF EMPTY(THIS.this_cProcesso)
				MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida", "")
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				IF EMPTY(THIS.this_dDtIni) OR EMPTY(THIS.this_dDtFin) OR ;
				   (THIS.this_dDtFin < THIS.this_dDtIni)
					MsgAviso("Per" + CHR(237) + "odo Inv" + CHR(225) + "lido", "")
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			*-- 1. Cabecalho do Processo de Copia.
			IF loc_lProsseguir
				loc_lProsseguir = THIS.CarregarProcessoAtual("Selecionar - crSigPcOop")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurProc)
				GO TOP

				*-- 2. Tolerancia do processo passa a valer na tela.
				THIS.this_nToleras = NVL(&loc_cCurProc..toleras, 0)

				*-- 3. Processo que copia fiscais recua 5 dias a data inicial.
				IF NVL(&loc_cCurProc..fiscal, 0) = 1 AND !EMPTY(THIS.this_dDtIni)
					THIS.this_dDtIni = THIS.this_dDtIni - 5
				ENDIF

				loc_nDoc    = NVL(&loc_cCurProc..notas, 0)
				loc_nOrdem  = NVL(&loc_cCurProc..ordems, 0)
				loc_cGrupo  = ALLTRIM(NVL(&loc_cCurProc..grupo, ""))
				loc_cClasse = ALLTRIM(NVL(&loc_cCurProc..class, ""))

				THIS.this_nOrdemGrade = IIF(BETWEEN(loc_nOrdem, 2, 5), loc_nOrdem, 1)

				*-- 4. Itens do processo (pares Empresa/Documento de origem).
				loc_cSQL = "SELECT DISTINCT emps, dopes, codigos, situas," + ;
					" delets, cidchaves, globalizas" + ;
					" FROM SigPcOoI" + ;
					" WHERE processos = " + EscaparSQL(PADR(THIS.this_cProcesso, 20)) + ;
					" ORDER BY emps, dopes, codigos"

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurOri, "csCpOI")
			ENDIF

			IF loc_lProsseguir
				*-- Cursor de trabalho das candidatas (equivalente a csDados
				*-- do legado - mesmas colunas e mesma chave de deduplicacao).
				THIS.FecharCursor(loc_cCurCand)
				CREATE CURSOR (loc_cCurCand) ;
					(Emps C(3), Dopes C(20), Numes N(6, 0), Datas D, ;
					 Valos N(12, 2), Notas C(6), Usuars C(10), ;
					 ContaOs C(10), ContaDs C(10), EmpDs C(3), Deletado L)
				INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNums

				loc_cDes = PADR(THIS.this_cEmpDs, 3)
				loc_lSoNaoProcessadas = (THIS.this_nProcessados = 1)

				*-- Operacoes ja copiadas ficam registradas em SigPcOoL com
				*-- Tipos = 'SIGPCOOP'. O legado monta o mesmo IN/NOT IN; o
				*-- alias interno foi renomeado para "l" (no legado repetia
				*-- o "b" do SigCdEmp externo - escopo interno vence, mesmo
				*-- resultado, mas ilegivel).
				loc_cNotIn = " a.empdopnums " + ;
					IIF(loc_lSoNaoProcessadas, "NOT ", "") + ;
					"IN (SELECT l.empdopnums FROM SigPcOoL l" + ;
					" WHERE l.tipos = " + EscaparSQL(PADR("SIGPCOOP", 10)) + ")"

				loc_oBarra = THIS.CriarBarraProgresso("Analisando Opera" + ;
					CHR(231) + CHR(245) + "es Para Processamento...", RECCOUNT(loc_cCurOri))

				SELECT (loc_cCurOri)
				GO TOP
				SCAN
					THIS.AvancarBarra(loc_oBarra)

					loc_cEmp = IIF(EMPTY(THIS.this_cEmpOs), ;
						PADR(NVL(&loc_cCurOri..emps, ""), 3), ;
						PADR(THIS.this_cEmpOs, 3))
					loc_cOpe       = PADR(NVL(&loc_cCurOri..dopes, ""), 20)
					loc_nSitua     = NVL(&loc_cCurOri..situas, 0)
					loc_nGlobaliza = NVL(&loc_cCurOri..globalizas, 0)
					loc_lIncluirExcluidas = (NVL(&loc_cCurOri..delets, 0) = 1)

					IF EMPTY(loc_cOpe)
						MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida", "")
						loc_lProsseguir = .F.
						EXIT
					ENDIF

					*-- Situa = 3 (Baixadas) filtra e exibe a data de BAIXA.
					loc_cColData = IIF(loc_nSitua = 3, "a.dtbaixas", "a.datas")

					loc_cSQL = "SELECT a.emps, a.dopes, a.numes," + ;
						" " + loc_cColData + " AS datas," + ;
						" a.valos, a.notas, a.usuars," + ;
						" a.contaos, a.contads, a.empds" + ;
						" FROM SigMvCab a, SigCdEmp b" + ;
						" WHERE " + loc_cColData + " BETWEEN " + ;
						EscaparSQL(DTOS(THIS.this_dDtIni)) + " AND " + ;
						EscaparSQL(DTOS(THIS.this_dDtFin) + " 23:59:59") + ;
						" AND a.dopes = " + EscaparSQL(loc_cOpe)

					IF !EMPTY(loc_cEmp)
						loc_cSQL = loc_cSQL + " AND a.emps = " + EscaparSQL(loc_cEmp)
					ENDIF

					IF !EMPTY(loc_cDes)
						loc_cSQL = loc_cSQL + " AND a.empds = " + EscaparSQL(loc_cDes)
					ENDIF

					DO CASE
					CASE loc_nDoc = 1
						loc_cSQL = loc_cSQL + " AND NOT a.notas = " + EscaparSQL(SPACE(6))
					CASE loc_nDoc = 2
						loc_cSQL = loc_cSQL + " AND a.notas = " + EscaparSQL(SPACE(6))
					ENDCASE

					DO CASE
					CASE loc_nSitua = 2
						loc_cSQL = loc_cSQL + " AND a.chksubn = 0"
					CASE loc_nSitua = 3
						loc_cSQL = loc_cSQL + " AND a.chksubn = 1"
					ENDCASE

					DO CASE
					CASE loc_nGlobaliza = 2
						loc_cSQL = loc_cSQL + " AND a.nops = 0"
					CASE loc_nGlobaliza = 3
						loc_cSQL = loc_cSQL + " AND a.nops <> 0"
					ENDCASE

					loc_cSQL = loc_cSQL + " AND a.emps = b.cemps"

					IF !EMPTY(loc_cGrupo)
						loc_cSQL = loc_cSQL + " AND b.grupo = " + EscaparSQL(PADR(loc_cGrupo, 15))
					ENDIF

					IF !EMPTY(loc_cClasse)
						loc_cSQL = loc_cSQL + " AND b.class = " + EscaparSQL(PADR(loc_cClasse, 15))
					ENDIF

					loc_cSQL = loc_cSQL + " AND" + loc_cNotIn + ;
						" ORDER BY a.emps, a.dopes, a.numes, a.datas, a.valos," + ;
						" a.notas, a.usuars, a.contaos, a.contads, a.empds"

					IF !THIS.ExecutarConsulta(loc_cSQL, loc_cCurSQL, "csDados2")
						loc_lProsseguir = .F.
						EXIT
					ENDIF

					THIS.AcumularCandidatas(loc_cCurSQL, loc_cCurCand, .F.)

					*-- Delets = 1: o item tambem traz as operacoes que foram
					*-- EXCLUIDAS do movimento (SigExMvc), marcadas Deletado.
					IF loc_lIncluirExcluidas
						loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas," + ;
							" a.valos, a.notas, a.usuars," + ;
							" a.contaos, a.contads, a.empds" + ;
							" FROM SigExMvc a, SigCdEmp b" + ;
							" WHERE a.datas BETWEEN " + ;
							EscaparSQL(DTOS(THIS.this_dDtIni)) + " AND " + ;
							EscaparSQL(DTOS(THIS.this_dDtFin) + " 23:59:59") + ;
							" AND a.dopes = " + EscaparSQL(loc_cOpe)

						IF !EMPTY(loc_cEmp)
							loc_cSQL = loc_cSQL + " AND a.emps = " + EscaparSQL(loc_cEmp)
						ENDIF

						IF !EMPTY(loc_cDes)
							loc_cSQL = loc_cSQL + " AND a.empds = " + EscaparSQL(loc_cDes)
						ENDIF

						DO CASE
						CASE loc_nDoc = 1
							loc_cSQL = loc_cSQL + " AND NOT a.notas = " + EscaparSQL(SPACE(6))
						CASE loc_nDoc = 2
							loc_cSQL = loc_cSQL + " AND a.notas = " + EscaparSQL(SPACE(6))
						ENDCASE

						loc_cSQL = loc_cSQL + " AND a.emps = b.cemps"

						IF !EMPTY(loc_cGrupo)
							loc_cSQL = loc_cSQL + " AND b.grupo = " + EscaparSQL(PADR(loc_cGrupo, 15))
						ENDIF

						IF !EMPTY(loc_cClasse)
							loc_cSQL = loc_cSQL + " AND b.class = " + EscaparSQL(PADR(loc_cClasse, 15))
						ENDIF

						loc_cSQL = loc_cSQL + " AND" + loc_cNotIn + ;
							" ORDER BY a.emps, a.dopes, a.numes, a.datas, a.valos," + ;
							" a.notas, a.usuars, a.contaos, a.contads, a.empds"

						IF !THIS.ExecutarConsulta(loc_cSQL, loc_cCurSQL, "csDados2 - SigExMvc")
							loc_lProsseguir = .F.
							EXIT
						ENDIF

						THIS.AcumularCandidatas(loc_cCurSQL, loc_cCurCand, .T.)
					ENDIF

					SELECT (loc_cCurOri)
				ENDSCAN

				THIS.EncerrarBarra(loc_oBarra)
				loc_oBarra = .NULL.
			ENDIF

			IF loc_lProsseguir
				*-- 6. Empresas que o usuario logado pode acessar. O legado
				*-- marca "Delete In csDados" aqui, mas a datasession privada
				*-- nasce com SET DELETED OFF (regra CLAUDE.md #9.4) e as
				*-- linhas marcadas continuavam visiveis ao Scan seguinte -
				*-- ou seja, a restricao nao chegava a valer. Aqui o filtro e
				*-- aplicado na propria insercao na grade, que e o efeito
				*-- pretendido.
				loc_cCurAce = THIS.CarregarEmpresasPermitidas()

				loc_nTotal = 0

				loc_oBarra = THIS.CriarBarraProgresso("Inserindo as Opera" + ;
					CHR(231) + CHR(245) + "es...", RECCOUNT(loc_cCurCand))

				SELECT (loc_cCurCand)
				GO TOP
				SCAN
					THIS.AvancarBarra(loc_oBarra)

					loc_lProsseguir = .T.
					IF !EMPTY(loc_cCurAce)
						loc_lProsseguir = SEEK(PADR(NVL(&loc_cCurCand..Emps, ""), 3), loc_cCurAce, "emps")
					ENDIF

					IF loc_lProsseguir
						INSERT INTO (THIS.this_cCursorOperacoes) ;
							(SelImp, Emps, Dopes, Numes, Datas, Valos, Notas, ;
							 Usuars, ContaOs, ContaDs, EmpDs, Deletado) ;
							VALUES (.T., &loc_cCurCand..Emps, &loc_cCurCand..Dopes, ;
								&loc_cCurCand..Numes, &loc_cCurCand..Datas, ;
								&loc_cCurCand..Valos, &loc_cCurCand..Notas, ;
								&loc_cCurCand..Usuars, &loc_cCurCand..ContaOs, ;
								&loc_cCurCand..ContaDs, &loc_cCurCand..EmpDs, ;
								&loc_cCurCand..Deletado)

						loc_nTotal = loc_nTotal + 1
					ENDIF

					SELECT (loc_cCurCand)
				ENDSCAN

				THIS.EncerrarBarra(loc_oBarra)
				loc_oBarra = .NULL.

				THIS.FecharCursor(loc_cCurAce)
				THIS.this_nTotalSelecionadas = loc_nTotal

				*-- 7. Nada encontrado: o legado ainda copia os arquivos
				*-- fiscais e de log do processo antes de avisar.
				IF loc_nTotal < 1
					THIS.CopiarFiscais()

					IF !THIS.CopiarLogs()
						MsgAviso("N" + CHR(227) + "o Existem Dados N" + CHR(227) + ;
							"o Processados Com a Opera" + CHR(231) + CHR(227) + ;
							"o Selecionada Neste Per" + CHR(237) + "odo", "")
					ENDIF

					loc_lSucesso = .F.
				ELSE
					loc_lSucesso = .T.
				ENDIF
			ENDIF

			THIS.FecharCursor(loc_cCurSQL)
			THIS.FecharCursor(loc_cCurCand)
		CATCH TO loc_oErro
			THIS.EncerrarBarra(loc_oBarra)
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.Selecionar")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AcumularCandidatas - transfere o resultado de uma consulta de
	* operacoes (SigMvCab ou SigExMvc) para o cursor de candidatas, sem
	* repetir a mesma chave Emps+Dopes+Numes. Equivalente ao
	* "Select csDados2 / Scan / If Not Seek(..., [csDados],
	* [EmpDopNums]) / Insert Into csDados ... / EndScan" que o legado
	* escreve duas vezes dentro do Selecionar.
	*
	* par_lDeletado marca a linha como operacao EXCLUIDA (ramo SigExMvc
	* do legado, que insere com Deletado = .t.).
	*
	* A data vem de coluna datetime do SQL Server e e normalizada com
	* ConverterParaData (regra CLAUDE.md #16 - TTOD so aceita DATETIME,
	* e o legado usa Ttod(Nvl(...)) exatamente aqui).
	*====================================================================
	PROTECTED PROCEDURE AcumularCandidatas(par_cCursorSQL, par_cCursorCand, par_lDeletado)
		LOCAL loc_cChave

		IF !USED(par_cCursorSQL) OR !USED(par_cCursorCand)
			RETURN
		ENDIF

		SELECT (par_cCursorSQL)
		GO TOP
		SCAN
			loc_cChave = PADR(NVL(&par_cCursorSQL..emps, ""), 3) + ;
				PADR(NVL(&par_cCursorSQL..dopes, ""), 20) + ;
				STR(NVL(&par_cCursorSQL..numes, 0), 6)

			IF !SEEK(loc_cChave, par_cCursorCand, "EmpDopNums")
				INSERT INTO (par_cCursorCand) ;
					(Emps, Dopes, Numes, Datas, Valos, Notas, Usuars, ;
					 ContaOs, ContaDs, EmpDs, Deletado) ;
					VALUES (NVL(&par_cCursorSQL..emps, ""), ;
						NVL(&par_cCursorSQL..dopes, ""), ;
						NVL(&par_cCursorSQL..numes, 0), ;
						ConverterParaData(&par_cCursorSQL..datas), ;
						NVL(&par_cCursorSQL..valos, 0), ;
						NVL(&par_cCursorSQL..notas, ""), ;
						NVL(&par_cCursorSQL..usuars, ""), ;
						NVL(&par_cCursorSQL..contaos, ""), ;
						NVL(&par_cCursorSQL..contads, ""), ;
						NVL(&par_cCursorSQL..empds, ""), ;
						par_lDeletado)
			ENDIF

			SELECT (par_cCursorSQL)
		ENDSCAN
	ENDPROC

	*====================================================================
	* CarregarDestinos - cursor com os DESTINOS de cada item do Processo
	* de Copia. Equivalente ao "Select b.Processos, b.Emps, b.Dopes, ...
	* From SigPcOoI b, SigCdLoc c Where b.Drives = c.Cods" do Init do
	* legado, que alimentava crTodosDestinos (e dele saia csDestinos).
	*
	* As colunas c.Drives/c.cIdConns (local fisico e id de conexao da
	* empresa de destino) continuam sendo lidas porque identificam o
	* destino configurado no cadastro - ver a nota de arquitetura em
	* CopiarFiscais() sobre o que muda com um unico banco.
	*====================================================================
	PROCEDURE CarregarDestinos()
		LOCAL loc_cSQL, loc_lSucesso

		loc_cSQL = "SELECT b.processos, b.emps, b.dopes, b.codigos," + ;
			" b.empds, b.dopeds, b.tpprodutos, b.dias," + ;
			" b.gruconos, b.gruconds, b.empdests, b.agrupar," + ;
			" b.novocods, b.cortams, b.moevals, b.franquias," + ;
			" b.semitens, b.fiscais, b.pctmins, b.pctmaxs," + ;
			" b.custos, b.impostos, b.barras, b.mccrs," + ;
			" b.cheques, b.delets, b.desitens, b.montaobs," + ;
			" b.chkcons, b.mantemmats, b.mantdpros, b.imagem," + ;
			" b.mantprods, b.gdegrupos, b.origems, b.destinos," + ;
			" b.cunis, b.oricompos, b.drives AS localdest," + ;
			" c.drives, c.cidconns, b.recalculos, b.pctcopias," + ;
			" b.opitens, b.movmzeros, b.movcparc, b.cidchaves," + ;
			" b.pctcomps, b.globalizas, b.situas, b.atucli" + ;
			" FROM SigPcOoI b, SigCdLoc c" + ;
			" WHERE b.drives = c.cods" + ;
			" ORDER BY b.cidchaves, b.processos, b.codigos"

		loc_lSucesso = THIS.ExecutarConsulta(loc_cSQL, THIS.this_cCursorDestinos, "crTodosDestinos")

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* MarcarCopiado - fecha o ciclo de copia de uma tabela auxiliar
	* (fiscal ou de log) na ORIGEM: marca copias = 1 nas linhas ainda
	* nao copiadas. Equivalente ao par
	* "Update <tabela> Set Copias = ?pTru Where Copias = ?pNot" /
	* "Delete From <tabela> Where Copias = ?pNot" do legado.
	*
	* DIVERGENCIA DELIBERADA do legado, documentada tambem no cabecalho
	* de CopiarFiscais(): o ramo de APAGAR (SigPcOoP.Apagar 2 ou 4) NAO
	* e reproduzido. No legado cada empresa morava num conjunto de .DBF
	* proprio e a linha era apagada da origem DEPOIS de ter sido
	* gravada no banco de DESTINO; com um unico SQL Server
	* compartilhado (gnConnHandle) origem e destino sao a MESMA linha, e
	* apagar destruiria a unica copia do dado fiscal. Quando o processo
	* pede exclusao, a tela AVISA em vez de apagar em silencio (regra
	* CLAUDE.md #27 - "ausencia tem de ficar VISIVEL").
	*
	* Devolve .T. quando havia linha a marcar (equivalente ao llPcF/
	* llPcL do legado, que suprime o aviso de "nada a processar").
	*====================================================================
	PROTECTED FUNCTION MarcarCopiado(par_cTabela, par_lApagarOrigem)
		LOCAL loc_cSQL, loc_cCursor, loc_nLinhas, loc_lTinhaLinha

		loc_lTinhaLinha = .F.
		loc_cCursor     = "cursor_4c_ContaCopia"

		loc_cSQL = "SELECT COUNT(*) AS nLinhas FROM " + par_cTabela + ;
			" WHERE copias = 0"

		IF THIS.ExecutarConsulta(loc_cSQL, loc_cCursor, par_cTabela)
			SELECT (loc_cCursor)
			GO TOP
			loc_nLinhas = IIF(EOF(), 0, NVL(&loc_cCursor..nLinhas, 0))
			THIS.FecharCursor(loc_cCursor)

			IF loc_nLinhas > 0
				loc_lTinhaLinha = .T.

				IF par_lApagarOrigem
					MsgAviso("O Processo de C" + CHR(243) + "pia pede a EXCLUS" + CHR(195) + ;
						"O das linhas de " + ALLTRIM(par_cTabela) + " na origem." + CHR(13) + ;
						"Com um " + CHR(250) + "nico banco de dados compartilhado, origem e destino" + CHR(13) + ;
						"s" + CHR(227) + "o a MESMA linha - a exclus" + CHR(227) + "o destruiria a " + CHR(250) + "nica c" + CHR(243) + "pia" + CHR(13) + ;
						"do dado fiscal e N" + CHR(195) + "O foi executada. As linhas foram apenas" + CHR(13) + ;
						"marcadas como copiadas.", ;
						"Aten" + CHR(231) + CHR(227) + "o")
				ENDIF

				loc_cSQL = "UPDATE " + par_cTabela + " SET copias = 1" + ;
					" WHERE copias = 0"

				IF !THIS.ExecutarConsulta(loc_cSQL, "", "Update - " + par_cTabela)
					loc_lTinhaLinha = .F.
				ENDIF
			ENDIF
		ENDIF

		RETURN loc_lTinhaLinha
	ENDFUNC

	*====================================================================
	* CopiarFiscais - fecha o ciclo de copia dos arquivos FISCAIS do
	* processo (SigFiRX / SigFiRXT / SigFiMpi / SigFiMpc / SigFiGfd),
	* equivalente ao "PROCEDURE copiarfiscais" do legado
	* (dump:1669-2033). So age quando o Processo de Copia pede copia de
	* fiscais (SigPcOoP.Fiscal = 1) e quando ha destino configurado -
	* senao avisa "Nenhuma Conexao Foi Encontrada Para Copiar Dados
	* Fiscais", exatamente como o legado.
	*
	* NOTA DE ARQUITETURA (a diferenca central desta tela): o legado
	* abria uma SEGUNDA conexao fisica para o destino
	* (poDataFiscal = CreateObject('fSqlConector', csDestinos2.cIdConns))
	* porque cada empresa tinha seu proprio conjunto de .DBF, e copiava
	* linha a linha (Scatter MemVar + Insert Into Des<X>) da origem para
	* o destino, trocando cIdChaves por fUniqueIds(). Na arquitetura
	* nova existe UM SQL Server (gnConnHandle) e a empresa e a coluna
	* Emps (PILAR 2): origem e destino sao a MESMA tabela, entao
	* reexecutar o INSERT criaria linha fiscal DUPLICADA - era o proprio
	* legado que alertava sobre isso no bloco "Checando Duplicidades",
	* que aqui casaria SEMPRE. Por isso a copia fisica nao se aplica, e
	* o que resta do ciclo - marcar a origem como copiada - e o que esta
	* implementado em MarcarCopiado(), que tambem documenta por que o
	* ramo de APAGAR nao e reproduzido.
	*====================================================================
	PROCEDURE CopiarFiscais()
		LOCAL loc_cCurProc, loc_cCurDes, loc_cCurOri, loc_cSQL
		LOCAL loc_cEmp, loc_cDop, loc_nNum, loc_lApagarFiscal
		LOCAL loc_oBarra, loc_lCopiou, loc_lProsseguir, loc_oErro

		loc_lCopiou     = .F.
		loc_lProsseguir = .T.
		loc_oBarra      = .NULL.

		loc_cCurProc = THIS.this_cCursorProcessoAtual
		loc_cCurDes  = "cursor_4c_DestinosFiscais"
		loc_cCurOri  = "cursor_4c_ProcOrigensFis"

		TRY
			IF !USED(loc_cCurProc)
				loc_lProsseguir = THIS.CarregarProcessoAtual("CopiarFiscais - crSigPcOop")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurProc)
				GO TOP

				*-- Fiscal <> 1: o processo nao copia fiscais, nada a fazer.
				IF NVL(&loc_cCurProc..fiscal, 0) <> 1
					loc_lProsseguir = .F.
				ELSE
					loc_lApagarFiscal = INLIST(NVL(&loc_cCurProc..apagar, 0), 2, 4)
				ENDIF
			ENDIF

			*-- Primeiro item do processo (o legado le csCpOI no 1o registro).
			IF loc_lProsseguir
				loc_cSQL = "SELECT DISTINCT emps, dopes, codigos, situas, cidchaves" + ;
					" FROM SigPcOoI" + ;
					" WHERE processos = " + EscaparSQL(PADR(THIS.this_cProcesso, 20)) + ;
					" ORDER BY emps, dopes, codigos, situas"

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurOri, "csCpOI")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurOri)
				GO TOP

				IF EOF()
					loc_lProsseguir = .F.
				ELSE
					loc_cEmp = PADR(NVL(&loc_cCurOri..emps, ""), 3)
					loc_cDop = PADR(NVL(&loc_cCurOri..dopes, ""), 20)
					loc_nNum = NVL(&loc_cCurOri..codigos, 0)
				ENDIF
			ENDIF

			*-- Destinos do item que copiam fiscais; sem nenhum, o legado
			*-- cai para TODOS os destinos do item.
			IF loc_lProsseguir
				IF !USED(THIS.this_cCursorDestinos)
					loc_lProsseguir = THIS.CarregarDestinos()
				ENDIF
			ENDIF

			IF loc_lProsseguir
				loc_lProsseguir = THIS.SelecionarDestinosDoItem(loc_cCurDes, ;
					loc_cEmp, loc_cDop, loc_nNum, .T.)

				IF loc_lProsseguir AND RECCOUNT(loc_cCurDes) < 1
					loc_lProsseguir = THIS.SelecionarDestinosDoItem(loc_cCurDes, ;
						loc_cEmp, loc_cDop, loc_nNum, .F.)
				ENDIF
			ENDIF

			IF loc_lProsseguir
				IF RECCOUNT(loc_cCurDes) < 1
					MsgErro("Nenhuma Conex" + CHR(227) + "o Foi Encontrada Para Copiar Dados Fiscais", ;
						"Contate o Suporte T" + CHR(233) + "cnico")
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				loc_oBarra = THIS.CriarBarraProgresso("Processando Diret" + CHR(243) + ;
					"rios Fiscais...", 5)

				*-- Mesma ordem de tabelas do legado.
				loc_lCopiou = THIS.MarcarCopiado("SigFiRX", loc_lApagarFiscal)
				THIS.AvancarBarra(loc_oBarra)

				loc_lCopiou = THIS.MarcarCopiado("SigFiRXT", loc_lApagarFiscal) OR loc_lCopiou
				THIS.AvancarBarra(loc_oBarra)

				loc_lCopiou = THIS.MarcarCopiado("SigFiMpc", loc_lApagarFiscal) OR loc_lCopiou
				THIS.AvancarBarra(loc_oBarra)

				loc_lCopiou = THIS.MarcarCopiado("SigFiMpi", loc_lApagarFiscal) OR loc_lCopiou
				THIS.AvancarBarra(loc_oBarra)

				loc_lCopiou = THIS.MarcarCopiado("SigFiGfd", loc_lApagarFiscal) OR loc_lCopiou
				THIS.AvancarBarra(loc_oBarra)

				THIS.EncerrarBarra(loc_oBarra)
				loc_oBarra = .NULL.
			ENDIF

			THIS.FecharCursor(loc_cCurDes)
			THIS.FecharCursor(loc_cCurOri)
		CATCH TO loc_oErro
			THIS.EncerrarBarra(loc_oBarra)
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.CopiarFiscais")
			loc_lCopiou = .F.
		ENDTRY

		RETURN loc_lCopiou
	ENDPROC

	*====================================================================
	* SelecionarDestinosDoItem - filtra this_cCursorDestinos pelo item
	* (Processo + Empresa/Documento/Codigo de origem) do legado:
	*   Iif(Empty(lcEmp), 'Dopes + Str(Codigos,6) = lcDop + Str(lnNum,6)',
	*                     'Emps + Dopes + Str(Codigos,6) = lcEmp + ...')
	* par_lSoFiscais acrescenta o "And (Fiscais = 1)" que o
	* copiarfiscais usa na primeira tentativa.
	*====================================================================
	PROTECTED FUNCTION SelecionarDestinosDoItem(par_cCursorSaida, par_cEmp, par_cDop, par_nNum, par_lSoFiscais)
		LOCAL loc_cCurDes, loc_cProc, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.
		loc_cCurDes  = THIS.this_cCursorDestinos
		loc_cProc    = PADR(THIS.this_cProcesso, 20)

		TRY
			THIS.FecharCursor(par_cCursorSaida)

			IF EMPTY(par_cEmp)
				IF par_lSoFiscais
					SELECT DISTINCT drives, cidconns ;
						FROM (loc_cCurDes) ;
						WHERE processos = loc_cProc ;
							AND PADR(dopes, 20) + codigos = PADR(par_cDop, 20) + STR(par_nNum, 6) ;
							AND NVL(fiscais, 0) = 1 ;
						ORDER BY cidconns ;
						INTO CURSOR (par_cCursorSaida) READWRITE
				ELSE
					SELECT DISTINCT drives, cidconns ;
						FROM (loc_cCurDes) ;
						WHERE processos = loc_cProc ;
							AND PADR(dopes, 20) + codigos = PADR(par_cDop, 20) + STR(par_nNum, 6) ;
						ORDER BY cidconns ;
						INTO CURSOR (par_cCursorSaida) READWRITE
				ENDIF
			ELSE
				IF par_lSoFiscais
					SELECT DISTINCT drives, cidconns ;
						FROM (loc_cCurDes) ;
						WHERE processos = loc_cProc ;
							AND PADR(emps, 3) + PADR(dopes, 20) + codigos = ;
								PADR(par_cEmp, 3) + PADR(par_cDop, 20) + STR(par_nNum, 6) ;
							AND NVL(fiscais, 0) = 1 ;
						ORDER BY cidconns ;
						INTO CURSOR (par_cCursorSaida) READWRITE
				ELSE
					SELECT DISTINCT drives, cidconns ;
						FROM (loc_cCurDes) ;
						WHERE processos = loc_cProc ;
							AND PADR(emps, 3) + PADR(dopes, 20) + codigos = ;
								PADR(par_cEmp, 3) + PADR(par_cDop, 20) + STR(par_nNum, 6) ;
						ORDER BY cidconns ;
						INTO CURSOR (par_cCursorSaida) READWRITE
				ENDIF
			ENDIF

			loc_lSucesso = USED(par_cCursorSaida)
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.SelecionarDestinosDoItem")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CopiarLogs - fecha o ciclo de copia dos arquivos de LOG do
	* processo (SigOpLog), equivalente ao bloco "If llLog ... EndIf" que
	* o legado escreve DENTRO do selecionar (dump:10184-10272), quando
	* nenhuma operacao foi encontrada no periodo. So age quando o
	* Processo de Copia pede copia de logs (SigPcOoP.Logs = 1).
	*
	* Vale aqui a MESMA nota de arquitetura de CopiarFiscais(): o legado
	* abria uma conexao para o destino (poDataLogs) e reinseria as
	* linhas com cIdChaves novo; com um unico banco compartilhado isso
	* duplicaria o log, entao o que resta e marcar a origem como
	* copiada (MarcarCopiado).
	*
	* Devolve .T. quando havia log a copiar - o legado usa esse llPcL
	* para NAO exibir o aviso de "nao existem dados nao processados".
	*====================================================================
	PROCEDURE CopiarLogs()
		LOCAL loc_cCurProc, loc_lApagarFiscal, loc_lCopiou
		LOCAL loc_lProsseguir, loc_oBarra, loc_oErro

		loc_lCopiou     = .F.
		loc_lProsseguir = .T.
		loc_oBarra      = .NULL.

		loc_cCurProc = THIS.this_cCursorProcessoAtual

		TRY
			IF !USED(loc_cCurProc)
				loc_lProsseguir = THIS.CarregarProcessoAtual("CopiarLogs - crSigPcOop")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurProc)
				GO TOP

				IF NVL(&loc_cCurProc..logs, 0) <> 1
					loc_lProsseguir = .F.
				ELSE
					loc_lApagarFiscal = INLIST(NVL(&loc_cCurProc..apagar, 0), 2, 4)
				ENDIF
			ENDIF

			IF loc_lProsseguir
				loc_oBarra = THIS.CriarBarraProgresso("Processando Diret" + CHR(243) + ;
					"rios de Log...", 1)

				loc_lCopiou = THIS.MarcarCopiado("SigOpLog", loc_lApagarFiscal)

				THIS.AvancarBarra(loc_oBarra)
				THIS.EncerrarBarra(loc_oBarra)
				loc_oBarra = .NULL.
			ENDIF
		CATCH TO loc_oErro
			THIS.EncerrarBarra(loc_oBarra)
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.CopiarLogs")
			loc_lCopiou = .F.
		ENDTRY

		RETURN loc_lCopiou
	ENDPROC

	*====================================================================
	* AcertaEmpDopNums - preenche a chave posicional EmpDopNums
	* (Emps + Dopes + Str(Numes, 6) = char(29), regra CLAUDE.md #42) nas
	* linhas de SigMvCab/SigMvItn/SigMvPar que ainda estao em branco.
	* Equivalente ao "PROCEDURE acertaempdopnums" do legado
	* (dump:1326-1440), chamado pelo Init antes de qualquer selecao -
	* sem essa chave o IN/NOT IN contra SigPcOoL nao casa e a tela nao
	* enxerga operacao nenhuma.
	*
	* O legado tem DOIS ramos: um para driver 'foxpro' (abre o .DBF
	* fisico e faz Update local) e um para SQL Server. Aqui existe
	* apenas o SQL Server (gnConnHandle), entao so o segundo ramo se
	* aplica - o getDriver() do legado deixa de existir junto com a
	* conexao por empresa.
	*
	* Devolve .T. em sucesso (o legado devolve 1/0 e o Init aborta a
	* tela quando vem 0).
	*====================================================================
	PROCEDURE AcertaEmpDopNums()
		LOCAL loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		TRY
			loc_lSucesso = THIS.PreencherEmpDopNums("SigMvCab", "TmpBrancos 1") ;
				AND THIS.PreencherEmpDopNums("SigMvItn", "TmpBrancos 2") ;
				AND THIS.PreencherEmpDopNums("SigMvPar", "TmpBrancos 3")
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.AcertaEmpDopNums")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* PreencherEmpDopNums - um dos tres passos de AcertaEmpDopNums.
	* Conta as linhas com EmpDopNums em branco e, so se houver alguma,
	* roda o UPDATE - exatamente o "Select Count(1) as Brancos ... If
	* (TmpBrancos.Brancos > 0) ... Update" do legado.
	*
	* A chave e montada no SQL Server com emps + dopes + STR(numes, 6):
	* char(3) + char(20) + char(6) = 29, as mesmas larguras do schema
	* (regra CLAUDE.md #42 - o padding FAZ PARTE da chave, nunca
	* ALLTRIM nas partes).
	*====================================================================
	PROTECTED FUNCTION PreencherEmpDopNums(par_cTabela, par_cContexto)
		LOCAL loc_cSQL, loc_cCursor, loc_nBrancos, loc_lSucesso

		loc_lSucesso = .F.
		loc_cCursor  = "cursor_4c_Brancos"

		loc_cSQL = "SELECT COUNT(1) AS nBrancos FROM " + par_cTabela + ;
			" WHERE empdopnums = " + EscaparSQL(SPACE(29))

		IF THIS.ExecutarConsulta(loc_cSQL, loc_cCursor, "TmpBrancos")
			SELECT (loc_cCursor)
			GO TOP
			loc_nBrancos = IIF(EOF(), 0, NVL(&loc_cCursor..nBrancos, 0))
			THIS.FecharCursor(loc_cCursor)

			IF loc_nBrancos > 0
				loc_cSQL = "UPDATE " + par_cTabela + ;
					" SET empdopnums = emps + dopes + STR(numes, 6)" + ;
					" WHERE empdopnums = " + EscaparSQL(SPACE(29))

				loc_lSucesso = THIS.ExecutarConsulta(loc_cSQL, "", "Update - " + par_cContexto)
			ELSE
				loc_lSucesso = .T.
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* AjustaPesos - classifica as linhas de um cursor de trabalho em
	* FAIXAS DE PESO de largura this_nToleras (tolerancia AU da tela) e
	* descarta as que nao caem na faixa do peso de referencia.
	* Equivalente ao "PROCEDURE ajustapesos" do legado
	* (dump:1441-1488).
	*
	* par_cCursor precisa ter as colunas PesoMs (peso medio) e
	* FaixaPeso (texto da faixa). Com tolerancia zero o legado apenas
	* marca todas as linhas como "Nao Avaliada" e nao descarta nada.
	*
	* A aritmetica das faixas e TRANSCRITA do legado (regra CLAUDE.md
	* #17 - formula de calculo nao se reescreve): o laco anda de
	* lnTol em lnTol a partir de zero, a faixa fechada e
	* [lnIni, lnFim - 0.001] e o rotulo e
	* ALLTRIM(STR(lnIni,9,3)) + " - " + ALLTRIM(STR(lnFim,9,3)).
	*====================================================================
	PROCEDURE AjustaPesos(par_cCursor, par_nPeso)
		LOCAL loc_nTol, loc_cCur, loc_cFaixa, loc_nMax, loc_nIni, loc_nFim
		LOCAL loc_cCurMax, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		TRY
			loc_nTol   = THIS.this_nToleras
			loc_cCur   = ALLTRIM(par_cCursor)
			loc_cFaixa = "N" + CHR(227) + "o Avaliada"
			loc_cCurMax = "cursor_4c_MaxPeso"

			IF !USED(loc_cCur)
				MsgErro("O Cursor [" + loc_cCur + "] N" + CHR(227) + "o Foi Encontrado", ;
					"O Cursor N" + CHR(227) + "o Est" + CHR(225) + " Em Uso")
			ELSE
				IF loc_nTol > 0
					THIS.FecharCursor(loc_cCurMax)

					SELECT TOP 1 PesoMs ;
						FROM (loc_cCur) ;
						ORDER BY PesoMs DESCENDING ;
						INTO CURSOR (loc_cCurMax)

					SELECT (loc_cCurMax)
					GO TOP

					loc_nMax = IIF(EOF(), 0, NVL(PesoMs, 0)) + 0.001
					loc_nIni = 0
					loc_nFim = 0

					DO WHILE loc_nFim < loc_nMax
						loc_nFim = loc_nFim + loc_nTol

						UPDATE (loc_cCur) ;
							SET FaixaPeso = ALLTRIM(STR(loc_nIni, 9, 3)) + " - " + ;
								ALLTRIM(STR(loc_nFim, 9, 3)) ;
							WHERE PesoMs BETWEEN loc_nIni AND (loc_nFim - 0.001)

						IF BETWEEN(par_nPeso, loc_nIni, (loc_nFim - 0.001))
							loc_cFaixa = ALLTRIM(STR(loc_nIni, 9, 3)) + " - " + ;
								ALLTRIM(STR(loc_nFim, 9, 3))
						ENDIF

						loc_nIni = loc_nIni + loc_nTol
					ENDDO

					DELETE FROM (loc_cCur) WHERE FaixaPeso <> loc_cFaixa

					THIS.FecharCursor(loc_cCurMax)
				ELSE
					UPDATE (loc_cCur) SET FaixaPeso = loc_cFaixa
				ENDIF

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.AjustaPesos")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerCodigoP - gera o codigo do produto no destino conforme a
	* configuracao de codificacao do GRUPO (SigCdGrp.CodProds /
	* SigCdGpr.DigAuts) ou, na falta dela, do parametro geral
	* (SigCdPam.CodProds / DigProds). Equivalente ao "PROCEDURE
	* gercodigop" do legado (dump:2765-2826).
	*
	* O DO CASE e TRANSCRITO do legado (regra CLAUDE.md #17):
	*   CodProds 4 ou 5 -> IdeCpros + sequencial de 8 ou 5 digitos
	*   CodProds 6       -> fGerarCodPro(...) - ver nota abaixo
	*   CodProds 10      -> Grupo + SubGrupo + sequencial de 5 digitos
	*   demais           -> CodProds = 1: 2 primeiras letras do grupo +
	*                       8 digitos; senao DigAuts + grupo + 5 digitos
	*
	* fGerUniqueKey() ja existe em utils\functions.prg (o legado passa
	* tambem o id da conexao; aqui ha uma conexao so).
	*
	* fGerarCodPro() NAO foi portada do legado Fortyus e, por ser
	* funcao que devolve VALOR DE CALCULO, nao recebe stub (regra
	* CLAUDE.md #27 - stub que devolve valor grava dado errado em
	* silencio). Em vez de chamar a funcao ausente e deixar o processo
	* morrer com "File 'fgerarcodpro.prg' does not exist" no meio da
	* copia, o caso e recusado com mensagem explicita, que diz
	* exatamente o que falta.
	*====================================================================
	PROCEDURE GerCodigoP(par_cGrupo, par_cSubGrupo, par_cRef, par_cFinal, ;
			par_cCor, par_cObs, par_cConj, par_cCol, par_cLinha)
		LOCAL loc_cRetorno, loc_nPro, loc_cDig, loc_nNum, loc_cSQL
		LOCAL loc_cCurGru, loc_cCurPar, loc_lProsseguir, loc_oErro

		loc_cRetorno    = ""
		loc_lProsseguir = .T.
		loc_cCurGru     = "cursor_4c_GerCodProGru"
		loc_cCurPar     = "cursor_4c_GerCodProParam"

		TRY
			IF VARTYPE(par_cGrupo) != "C" OR EMPTY(par_cGrupo)
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				loc_cSQL = "SELECT a.codprods, a.idecpros, b.digauts" + ;
					" FROM SigCdGrp a, SigCdGpr b" + ;
					" WHERE a.cgrus = " + EscaparSQL(PADR(par_cGrupo, 3)) + ;
					" AND a.mercs = b.codigos"

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurGru, "fGerCodPro_Gru")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurGru)
				GO TOP
				loc_lProsseguir = !EOF()
			ENDIF

			IF loc_lProsseguir
				loc_cSQL = "SELECT codprods, digprods FROM SigCdPam"
				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurPar, "fGerCodPro_Param")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurPar)
				GO TOP
				loc_lProsseguir = !EOF()
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurGru)
				GO TOP

				loc_nPro = IIF(EMPTY(NVL(&loc_cCurGru..codprods, 0)), ;
					NVL(&loc_cCurPar..codprods, 0), ;
					NVL(&loc_cCurGru..codprods, 0))

				DO CASE
				CASE INLIST(loc_nPro, 4, 5)
					loc_cDig    = NVL(&loc_cCurGru..idecpros, "")
					loc_nNum    = fGerUniqueKey("PRODUTO" + ALLTRIM(loc_cDig))
					loc_cRetorno = ALLTRIM(loc_cDig + PADL(loc_nNum, IIF(loc_nPro = 4, 8, 5), "0"))

				CASE loc_nPro = 6
					*-- fGerarCodPro() nao existe no sistema novo - ver nota
					*-- no cabecalho. Recusa explicita em vez de valor errado.
					MsgErro("O Grupo [" + ALLTRIM(par_cGrupo) + "] usa a codifica" + ;
						CHR(231) + CHR(227) + "o de produto n" + CHR(186) + " 6" + CHR(13) + ;
						"(composi" + CHR(231) + CHR(227) + "o), que depende da fun" + ;
						CHR(231) + CHR(227) + "o fGerarCodPro() do sistema legado." + CHR(13) + ;
						"Essa fun" + CHR(231) + CHR(227) + "o N" + CHR(195) + "O foi portada e N" + ;
						CHR(195) + "O pode ser substitu" + CHR(237) + "da por um valor" + CHR(13) + ;
						"aproximado sem gravar c" + CHR(243) + "digo de produto errado." + CHR(13) + ;
						"Ajuste o cadastro do grupo ou solicite a porta" + CHR(231) + CHR(227) + "o da fun" + ;
						CHR(231) + CHR(227) + CHR(227) + "o.", ;
						"Codifica" + CHR(231) + CHR(227) + "o de Produto n" + CHR(227) + "o suportada")

					loc_cRetorno = ""

				CASE loc_nPro = 10
					loc_nNum    = fGerUniqueKey("PRODUTO" + ALLTRIM(par_cGrupo))
					loc_cRetorno = ALLTRIM(par_cGrupo) + ALLTRIM(par_cSubGrupo) + PADL(loc_nNum, 5, "0")

				OTHERWISE
					loc_cDig = IIF(EMPTY(NVL(&loc_cCurGru..digauts, "")), ;
						NVL(&loc_cCurPar..digprods, ""), ;
						NVL(&loc_cCurGru..digauts, ""))
					loc_nNum = fGerUniqueKey("PRODUTO" + ALLTRIM(par_cGrupo))

					IF loc_nPro = 1
						loc_cRetorno = SUBSTR(par_cGrupo, 1, 2) + PADL(loc_nNum, 8, "0")
					ELSE
						loc_cRetorno = ALLTRIM(loc_cDig + ALLTRIM(par_cGrupo) + PADL(loc_nNum, 5, "0"))
					ENDIF
				ENDCASE
			ENDIF

			THIS.FecharCursor(loc_cCurGru)
			THIS.FecharCursor(loc_cCurPar)
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.GerCodigoP")
			loc_cRetorno = ""
		ENDTRY

		RETURN loc_cRetorno
	ENDPROC

	*====================================================================
	* GarantirCadastroNoDestino - equivalente ao "PROCEDURE
	* lancadestino" do legado (dump:2900-2958), que e a rotina GENERICA
	* de "se este registro de cadastro ainda nao existe no banco de
	* DESTINO, copie-o da origem".
	*
	* O legado consultava a tabela par_cTabela na conexao de DESTINO
	* (loConexao(ThisForm.lnConexao, 1)) e, so quando nao achava,
	* copiava a linha da ORIGEM (poDataMgr) para o cursor de gravacao do
	* destino. Com um unico SQL Server compartilhado (gnConnHandle) a
	* consulta de destino e a MESMA consulta de origem: achando a linha
	* na origem, ela JA esta visivel para a empresa de destino e nao ha
	* nada a copiar; nao achando, nao existe o que copiar - e e
	* exatamente esse o aviso que o legado da ("<Descricao> [X] Nao
	* Existe Mais Na Origem"), condicionado a "Exibir Mensagens de
	* Erro" (chkMensa / this_lExibirMensagens).
	*
	* Devolve .T. quando o registro existe e pode ser usado no destino,
	* .F. quando nao existe (mesma semantica que o chamador espera).
	*====================================================================
	PROCEDURE GarantirCadastroNoDestino(par_cTabela, par_cCampoChave, par_cValor, par_cDescricao)
		LOCAL loc_cSQL, loc_cCursor, loc_cDesc, loc_lExiste, loc_oErro

		loc_lExiste = .F.
		loc_cCursor = "cursor_4c_CadastroDestino"
		loc_cDesc   = IIF(VARTYPE(par_cDescricao) = "C" AND !EMPTY(par_cDescricao), ;
			par_cDescricao, "O Conte" + CHR(250) + "do")

		TRY
			IF VARTYPE(par_cTabela) != "C" OR VARTYPE(par_cCampoChave) != "C" OR ;
			   VARTYPE(par_cValor) != "C" OR EMPTY(par_cTabela) OR ;
			   EMPTY(par_cCampoChave) OR EMPTY(par_cValor)
				loc_lExiste = .F.
			ELSE
				loc_cSQL = "SELECT COUNT(1) AS nLinhas FROM " + par_cTabela + ;
					" WHERE " + par_cCampoChave + " = " + EscaparSQL(par_cValor)

				IF THIS.ExecutarConsulta(loc_cSQL, loc_cCursor, "crTmpD - " + par_cTabela)
					SELECT (loc_cCursor)
					GO TOP
					loc_lExiste = (IIF(EOF(), 0, NVL(&loc_cCursor..nLinhas, 0)) > 0)
					THIS.FecharCursor(loc_cCursor)

					IF !loc_lExiste AND THIS.this_lExibirMensagens
						MsgAviso(loc_cDesc + " [" + ALLTRIM(par_cValor) + "] N" + CHR(227) + ;
							"o Existe Mais Na Origem. Verifique.", ;
							loc_cDesc + " de Origem N" + CHR(227) + "o Existe...")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.GarantirCadastroNoDestino")
			loc_lExiste = .F.
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* LancaClientes - devolve o codigo do cliente a ser usado no
	* DESTINO, equivalente ao "PROCEDURE lancaclientes" do legado
	* (dump:2827-2899).
	*
	* O legado procurava o cliente no banco de DESTINO primeiro pelo
	* CPF/CNPJ com mascara, depois pelo CPF/CNPJ sem mascara e por fim
	* pelo codigo; nao achando nenhum, COPIAVA o cadastro da origem
	* para o destino (Scatter MemVar + Insert Into DesCli, com DataIncs/
	* DtAlts = Datetime()). Com um unico SQL Server compartilhado o
	* cadastro de clientes e o MESMO: achado o cliente na origem, o
	* codigo dele JA vale no destino - entao o que resta da rotina e
	* devolver esse codigo, que e justamente o valor que o legado
	* devolve nos tres caminhos de "achou".
	*
	* A busca por CPF/CNPJ (com e sem mascara) continua sendo feita,
	* porque e ela que decide o codigo quando o MESMO CPF aparece em
	* mais de um cadastro - comportamento que o legado tem e que nao
	* depende de haver dois bancos.
	*====================================================================
	PROCEDURE LancaClientes(par_cCliente)
		LOCAL loc_cSQL, loc_cCursor, loc_cCli, loc_cCpf, loc_cCpfLimpo
		LOCAL loc_lProsseguir, loc_oErro

		loc_cCli        = ""
		loc_cCursor     = "cursor_4c_ClienteOri"
		loc_lProsseguir = .T.

		TRY
			IF VARTYPE(par_cCliente) != "C" OR EMPTY(par_cCliente)
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				loc_cSQL = "SELECT iclis, cpfs FROM SigCdCli" + ;
					" WHERE iclis = " + EscaparSQL(PADR(par_cCliente, 10))

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCursor, "crTmp - SigCdCli")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCursor)
				GO TOP

				IF !EOF()
					loc_cCpf      = NVL(&loc_cCursor..cpfs, "")
					loc_cCpfLimpo = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
					loc_cCli      = ALLTRIM(NVL(&loc_cCursor..iclis, ""))

					*-- CPF/CNPJ preenchido: o codigo de destino e o do cadastro
					*-- que tem esse CPF (com mascara e, nao achando, sem ela).
					IF !EMPTY(loc_cCpfLimpo)
						loc_cCli = THIS.ObterClientePorCpf(loc_cCpf, loc_cCli)

						IF EMPTY(loc_cCli)
							loc_cCli = THIS.ObterClientePorCpf(loc_cCpfLimpo, ;
								ALLTRIM(NVL(&loc_cCursor..iclis, "")))
						ENDIF
					ENDIF
				ENDIF
			ENDIF

			THIS.FecharCursor(loc_cCursor)
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.LancaClientes")
			loc_cCli = ""
		ENDTRY

		RETURN loc_cCli
	ENDPROC

	*====================================================================
	* ObterClientePorCpf - um dos tres caminhos de busca de
	* LancaClientes: devolve o IClis do cadastro cujo CPF/CNPJ casa com
	* par_cCpf, ou par_cPadrao quando nenhum casa.
	*====================================================================
	PROTECTED FUNCTION ObterClientePorCpf(par_cCpf, par_cPadrao)
		LOCAL loc_cSQL, loc_cCursor, loc_cRetorno

		loc_cRetorno = par_cPadrao
		loc_cCursor  = "cursor_4c_ClienteCpf"

		IF !EMPTY(par_cCpf)
			loc_cSQL = "SELECT TOP 1 iclis FROM SigCdCli" + ;
				" WHERE RTRIM(cpfs) = " + EscaparSQL(ALLTRIM(par_cCpf))

			IF THIS.ExecutarConsulta(loc_cSQL, loc_cCursor, "crTmpCliDes")
				SELECT (loc_cCursor)
				GO TOP
				IF !EOF()
					loc_cRetorno = ALLTRIM(NVL(&loc_cCursor..iclis, ""))
				ENDIF
				THIS.FecharCursor(loc_cCursor)
			ENDIF
		ENDIF

		RETURN loc_cRetorno
	ENDFUNC

	*====================================================================
	* LancaTabDescto - garante que a Tabela de Descontos usada pela
	* operacao copiada exista no destino. Equivalente ao "PROCEDURE
	* lancatabdescto" do legado (dump:5582-5609), que copiava o
	* cabecalho (SigOpTdz) e os itens por empresa (SigOpTde) da origem
	* para os cursores de gravacao do banco de DESTINO quando o
	* ChkRegister do destino nao encontrava o codigo.
	*
	* Vale a MESMA nota de arquitetura de GarantirCadastroNoDestino: com
	* um unico SQL Server compartilhado, SigOpTdz/SigOpTde sao as mesmas
	* tabelas para origem e destino - o ChkRegister do legado acharia o
	* codigo SEMPRE e a copia nunca aconteceria. O que resta de
	* verificavel e confirmar que a tabela de desconto referida pela
	* operacao realmente existe; nao existindo, o aviso sai pelo mesmo
	* caminho do legado (condicionado a "Exibir Mensagens de Erro").
	*====================================================================
	PROCEDURE LancaTabDescto(par_cCodigo)
		LOCAL loc_lExiste

		loc_lExiste = .F.

		IF VARTYPE(par_cCodigo) = "C" AND !EMPTY(par_cCodigo)
			loc_lExiste = THIS.GarantirCadastroNoDestino("SigOpTdz", "codigos", ;
				PADR(par_cCodigo, 10), "A Tabela de Descontos")
		ENDIF

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* ExecutarLoteTransacional - envia VARIOS comandos de gravacao num
	* SQLEXEC UNICO, com controle de transacao em T-SQL.
	*
	* Necessario porque neste ambiente a conexao nasce com
	* Transactions = 2 (manual) e @@TRANCOUNT ja vale 1: um par
	* BEGIN/COMMIT TRANSACTION enviado em SQLEXEC separados so ANINHA e
	* nao efetiva nada, e um ROLLBACK sem nome desfaria a transacao do
	* resto da aplicacao na mesma conexao. O esqueleto abaixo (SAVE
	* TRANSACTION quando ja ha transacao aberta, BEGIN quando nao ha, e
	* THROW no CATCH para o erro chegar ao SQLEXEC) e o padrao canonico
	* do projeto para gravacao multi-tabela.
	*
	* par_cComandos recebe os INSERT/UPDATE/DELETE ja montados,
	* separados por ";" e terminando em ";".
	*====================================================================
	PROTECTED FUNCTION ExecutarLoteTransacional(par_cComandos, par_cContexto)
		LOCAL loc_cSQL

		TEXT TO loc_cSQL TEXTMERGE NOSHOW PRETEXT 7
			SET NOCOUNT ON;
			DECLARE @nivel int = @@TRANCOUNT;
			IF @nivel = 0 BEGIN TRANSACTION
			ELSE SAVE TRANSACTION Cop4c;
			BEGIN TRY
			<<par_cComandos>>
			    IF @nivel = 0 COMMIT TRANSACTION;
			END TRY
			BEGIN CATCH
			    IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END
			    ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Cop4c; END;
			    THROW;
			END CATCH
		ENDTEXT

		RETURN THIS.ExecutarConsulta(loc_cSQL, "", par_cContexto)
	ENDFUNC

	*====================================================================
	* Casamento - escolhe, no DESTINO, o produto que melhor "casa" com
	* o produto de origem: mesmo grupo e mesma composicao, com
	* preferencia para quem tem estoque na conta de destino e, havendo
	* mais de um, para aquele cuja quantidade de composicao esta mais
	* perto da do produto de origem. Equivalente ao "PROCEDURE
	* casamento" do legado (dump:1489-1668).
	*
	* O legado le a empresa/grupo/conta do cursor de gravacao do destino
	* (DesEest - o cabecalho que esta sendo montado); aqui esses tres
	* valores chegam por PARAMETRO, porque o cursor de gravacao do
	* destino nao existe mais (ha um banco so e a gravacao e por
	* INSERT).
	*
	* O criterio de escolha e TRANSCRITO (regra CLAUDE.md #17):
	*   Abs(QtdOrigem - QtdAnterior) >= Abs(QtdOrigem - QtdAtual)
	*   -> o produto ATUAL e melhor que o anterior
	* e a troca so acontece quando o atual vence na MAIORIA das
	* materias (Sum(MelhorB) > Sum(MelhorA)).
	*
	* Devolve o CPros escolhido, ou string vazia quando nao ha candidato.
	*====================================================================
	PROCEDURE Casamento(par_cProduto, par_cEmp, par_cGrupoOri, par_cContaOri)
		LOCAL loc_cRet, loc_cEmp, loc_cGru, loc_cCon, loc_cPro
		LOCAL loc_cEmpGruEst, loc_cPrGru, loc_cCompo, loc_cMat, loc_cSQL
		LOCAL loc_cCurPro, loc_cCurCompo, loc_cCurDesCompo, loc_cCurIgual
		LOCAL loc_cCurEst, loc_lProsseguir, loc_oErro

		loc_cRet        = SPACE(10)
		loc_lProsseguir = .T.

		loc_cCurPro      = "cursor_4c_CasaProOri"
		loc_cCurCompo    = "cursor_4c_CasaCompoOri"
		loc_cCurDesCompo = "cursor_4c_CasaCompoDes"
		loc_cCurIgual    = "cursor_4c_CasaCompoIgual"
		loc_cCurEst      = "cursor_4c_CasaEstIgual"

		TRY
			loc_cEmp = PADR(par_cEmp, 3)
			loc_cGru = PADR(par_cGrupoOri, 10)
			loc_cCon = PADR(par_cContaOri, 10)
			loc_cPro = PADR(par_cProduto, 10)

			loc_cEmpGruEst = loc_cEmp + loc_cGru + loc_cCon

			*-- Materias-primas do produto de origem, com a quantidade que
			*-- o DESTINO usa para cada uma (csMatOrigem do legado).
			IF USED("csMatOrigem_4c")
				USE IN csMatOrigem_4c
			ENDIF
			CREATE CURSOR csMatOrigem_4c ;
				(Mats C(10), Qtds N(9, 3), Produto C(14), QtdsA N(9, 3), ;
				 MelhorA N(1), QtdsB N(9, 3), MelhorB N(1))
			INDEX ON Mats TAG Mats

			loc_cSQL = "SELECT cgrus, compos, pesoms FROM SigCdPro" + ;
				" WHERE cpros = " + EscaparSQL(loc_cPro)

			loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurPro, "TmpPro1")

			IF loc_lProsseguir
				SELECT (loc_cCurPro)
				GO TOP
				loc_lProsseguir = !EOF()
			ENDIF

			IF loc_lProsseguir
				loc_cPrGru = NVL(&loc_cCurPro..cgrus, "")
				loc_cCompo = NVL(&loc_cCurPro..compos, "")

				loc_cSQL = "SELECT cpros, mats, compos, qtds FROM SigPrCpo" + ;
					" WHERE cpros = " + EscaparSQL(loc_cPro) + ;
					" ORDER BY cpros, mats, compos, qtds"

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurCompo, "TmpCompo")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurCompo)
				GO TOP

				IF EOF()
					*-- Produto sem composicao: o legado usa o peso medio como
					*-- materia unica, com o codigo fixo "OURO".
					SELECT (loc_cCurPro)
					INSERT INTO csMatOrigem_4c (Mats, Qtds) ;
						VALUES ("OURO", NVL(&loc_cCurPro..pesoms, 0))
				ELSE
					SELECT (loc_cCurCompo)
					SCAN
						loc_cMat = IIF(EMPTY(NVL(&loc_cCurCompo..compos, "")), ;
							NVL(&loc_cCurCompo..mats, ""), ;
							NVL(&loc_cCurCompo..compos, ""))

						loc_cSQL = "SELECT qtds FROM SigPrCpo" + ;
							" WHERE cpros = " + EscaparSQL(PADR(loc_cMat, 14))

						IF THIS.ExecutarConsulta(loc_cSQL, loc_cCurDesCompo, "TmpDesCompo")
							SELECT (loc_cCurDesCompo)
							GO TOP

							IF !EOF()
								IF !SEEK(PADR(loc_cMat, 10), "csMatOrigem_4c", "Mats")
									INSERT INTO csMatOrigem_4c (Mats, Qtds) ;
										VALUES (loc_cMat, NVL(&loc_cCurDesCompo..qtds, 0))
								ELSE
									REPLACE Qtds WITH Qtds + NVL(&loc_cCurDesCompo..qtds, 0) ;
										IN csMatOrigem_4c
								ENDIF
							ENDIF
						ENDIF

						SELECT (loc_cCurCompo)
					ENDSCAN
				ENDIF
			ENDIF

			*-- Produtos do destino com o MESMO grupo e a MESMA composicao
			*-- (e que nao estejam inativos - Situas = 2).
			IF loc_lProsseguir
				loc_cSQL = "SELECT " + EscaparSQL(loc_cEmpGruEst) + " AS empgruests," + ;
					" cpros, cgrus FROM SigCdPro" + ;
					" WHERE cgrus = " + EscaparSQL(PADR(loc_cPrGru, 3)) + ;
					" AND compos = " + EscaparSQL(PADR(loc_cCompo, 30)) + ;
					" AND NOT situas = 2" + ;
					" ORDER BY cpros"

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurIgual, "csCompoIgual")
			ENDIF

			*-- Dentre eles, os que tem estoque na conta de destino.
			IF loc_lProsseguir
				loc_cSQL = "SELECT empgruests, cpros, cidchaves FROM SigMvEst" + ;
					" WHERE empgruests = " + EscaparSQL(loc_cEmpGruEst) + ;
					" AND sqtds > 0" + ;
					" ORDER BY empgruests, cpros, cidchaves"

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurEst, "csEstIgual")
			ENDIF

			IF loc_lProsseguir
				IF USED("csComEstoque_4c")
					USE IN csComEstoque_4c
				ENDIF

				SELECT a.cpros ;
					FROM (loc_cCurIgual) a, (loc_cCurEst) b ;
					WHERE a.empgruests = b.empgruests ;
						AND a.cpros = b.cpros ;
						AND SUBSTR(a.cpros, 1, 2) = SUBSTR(a.cgrus, 1, 2) ;
					INTO CURSOR csComEstoque_4c READWRITE

				IF RECCOUNT("csComEstoque_4c") < 1
					USE IN csComEstoque_4c

					SELECT cpros ;
						FROM (loc_cCurIgual) ;
						INTO CURSOR csComEstoque_4c READWRITE
				ENDIF

				IF RECCOUNT("csComEstoque_4c") = 1
					*-- Candidato unico: so vale se ele tiver composicao
					*-- cadastrada (o legado testa o Eof do TmpDesCompo).
					SELECT csComEstoque_4c
					GO TOP

					loc_cSQL = "SELECT qtds FROM SigPrCpo" + ;
						" WHERE cpros = " + EscaparSQL(PADR(csComEstoque_4c.cpros, 14))

					IF THIS.ExecutarConsulta(loc_cSQL, loc_cCurDesCompo, "TmpDesCompo")
						SELECT (loc_cCurDesCompo)
						GO TOP

						SELECT csMatOrigem_4c
						GO TOP
						REPLACE Produto WITH IIF(EOF(loc_cCurDesCompo), "", ;
							csComEstoque_4c.cpros) IN csMatOrigem_4c
					ENDIF
				ELSE
					THIS.EscolherMelhorCasamento(loc_cCurDesCompo)
				ENDIF

				SELECT csMatOrigem_4c
				GO TOP

				IF !EOF() AND EMPTY(ALLTRIM(loc_cRet))
					loc_cRet = NVL(csMatOrigem_4c.Produto, "")
				ENDIF
			ENDIF

			THIS.FecharCursor(loc_cCurPro)
			THIS.FecharCursor(loc_cCurCompo)
			THIS.FecharCursor(loc_cCurDesCompo)
			THIS.FecharCursor(loc_cCurIgual)
			THIS.FecharCursor(loc_cCurEst)
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.Casamento")
			loc_cRet = SPACE(10)
		ENDTRY

		RETURN ALLTRIM(loc_cRet)
	ENDPROC

	*====================================================================
	* EscolherMelhorCasamento - ramo "mais de um candidato" do
	* Casamento: para cada produto candidato (csComEstoque_4c) compara,
	* materia por materia, a quantidade de composicao dele com a do
	* produto de origem, e adota o candidato quando ele vence na
	* MAIORIA das materias. Transcricao do laco duplo Scan do legado
	* (dump:1588-1657).
	*====================================================================
	PROTECTED PROCEDURE EscolherMelhorCasamento(par_cCurDesCompo)
		LOCAL loc_cSQL, loc_cCurTmp, loc_cCurPro1, loc_cCurPro2, loc_cCurMelhor
		LOCAL loc_nQtdAtual

		loc_cCurTmp    = par_cCurDesCompo
		loc_cCurPro1   = "cursor_4c_CasaCompoPro1"
		loc_cCurPro2   = "cursor_4c_CasaCompoPro2"
		loc_cCurMelhor = "cursor_4c_CasaMelhores"

		SELECT csComEstoque_4c
		GO TOP

		*-- Cada candidato comeca como produto escolhido, igual ao legado.
		SELECT csMatOrigem_4c
		SCAN
			REPLACE Produto WITH csComEstoque_4c.cpros IN csMatOrigem_4c
			SELECT csMatOrigem_4c
		ENDSCAN

		SELECT csComEstoque_4c
		SCAN
			SELECT csMatOrigem_4c
			SCAN
				loc_cSQL = "SELECT cpros, mats, compos, qtds, cidchaves" + ;
					" FROM SigPrCpo" + ;
					" WHERE cpros = " + EscaparSQL(PADR(csComEstoque_4c.cpros, 14)) + ;
					" ORDER BY cpros, mats, compos, qtds, cidchaves"

				IF !THIS.ExecutarConsulta(loc_cSQL, loc_cCurTmp, "Casamento - TmpDesCompo")
					EXIT
				ENDIF

				THIS.FecharCursor(loc_cCurPro1)
				SELECT cpros, IIF(EMPTY(NVL(compos, "")), mats, compos) AS mats, ;
						SUM(NVL(qtds, 0)) AS qtds ;
					FROM (loc_cCurTmp) ;
					GROUP BY 1, 2 ;
					INTO CURSOR (loc_cCurPro1) READWRITE

				THIS.FecharCursor(loc_cCurPro2)
				SELECT cpros, mats, qtds ;
					FROM (loc_cCurPro1) ;
					WHERE PADR(mats, 10) = PADR(csMatOrigem_4c.Mats, 10) ;
					INTO CURSOR (loc_cCurPro2) READWRITE

				SELECT (loc_cCurPro2)
				GO TOP
				loc_nQtdAtual = IIF(EOF(), 0, NVL(&loc_cCurPro2..qtds, 0))

				SELECT csMatOrigem_4c
				IF ABS(csMatOrigem_4c.Qtds - csMatOrigem_4c.QtdsA) >= ;
				   ABS(csMatOrigem_4c.Qtds - loc_nQtdAtual)
					*-- Candidato ATUAL melhor que o anterior.
					REPLACE MelhorA WITH 0, ;
						MelhorB WITH 1, ;
						QtdsB   WITH loc_nQtdAtual IN csMatOrigem_4c
				ELSE
					REPLACE MelhorA WITH 1, ;
						MelhorB WITH 0, ;
						QtdsB   WITH loc_nQtdAtual IN csMatOrigem_4c
				ENDIF

				SELECT csMatOrigem_4c
			ENDSCAN

			THIS.FecharCursor(loc_cCurMelhor)
			SELECT " " AS AGrupar, SUM(MelhorA) AS MelhorA, SUM(MelhorB) AS MelhorB ;
				FROM csMatOrigem_4c ;
				GROUP BY 1 ;
				INTO CURSOR (loc_cCurMelhor) READWRITE

			SELECT (loc_cCurMelhor)
			GO TOP

			IF !EOF() AND (NVL(&loc_cCurMelhor..MelhorB, 0) > NVL(&loc_cCurMelhor..MelhorA, 0))
				SELECT csMatOrigem_4c
				SCAN
					REPLACE QtdsA   WITH csMatOrigem_4c.QtdsB, ;
						Produto WITH csComEstoque_4c.cpros IN csMatOrigem_4c
					SELECT csMatOrigem_4c
				ENDSCAN
			ENDIF

			SELECT csComEstoque_4c
		ENDSCAN

		THIS.FecharCursor(loc_cCurPro1)
		THIS.FecharCursor(loc_cCurPro2)
		THIS.FecharCursor(loc_cCurMelhor)
	ENDPROC

	*====================================================================
	* FazContra - gera o lancamento CONTRARIO (a contrapartida) de um
	* lancamento financeiro recem-gravado em SigMvCcr. Equivalente ao
	* "PROCEDURE fazcontra" do legado (dump:2412-2489).
	*
	* O legado lia o registro do cursor de gravacao campo a campo
	* (Scatter manual em 40 variaveis) e inseria a contrapartida
	* TROCANDO os pares origem/destino:
	*   opers <-> sopers | grupos <-> sgrupos | contas <-> scontas
	*   moedas <-> smoedas | cotacaos <-> scotacaos | valors <-> svalors
	* o restante e copiado inteiro, com cIdChaves NOVO. Aqui a mesma troca e
	* feita por INSERT ... SELECT sobre a propria linha de origem
	* (identificada por cidchaves), o que e exatamente equivalente e
	* dispensa as 40 variaveis intermediarias.
	*
	* Depois, como no legado, as chaves derivadas sao recalculadas
	* (gruconmoes/empdopnums/empdopncs/pagos/dopotps) e os saldos das
	* duas pontas sao recalculados com fRecalculaS.
	*====================================================================
	PROCEDURE FazContra(par_cCidChavesOrigem)
		LOCAL loc_cSQL, loc_cNovaChave, loc_cCursor, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.
		loc_cCursor  = "cursor_4c_Contra"

		TRY
			IF VARTYPE(par_cCidChavesOrigem) != "C" OR EMPTY(par_cCidChavesOrigem)
				MsgErro("FazContra chamado sem a chave do lan" + CHR(231) + "amento de origem.", ;
					"sigoppopBO.FazContra")
			ELSE
				loc_cNovaChave = fUniqueIds()

				TEXT TO loc_cSQL TEXTMERGE NOSHOW PRETEXT 7
					INSERT INTO SigMvCcr
					    (vopers, nopers, nlancs, vlancs, opers, grupos, contas,
					     moedas, cotacaos, valors, emps, datas, usualts, datalts,
					     sgrupos, scontas, smoedas, scotacaos, svalors, sopers,
					     autos, hists, dopes, numes, valpags, vencs, dopcs, numcs,
					     nfs, titulos, grupems, contems, grupages, contages,
					     valliqs, cidchaves, tipos, hist2s, docus, dtemis)
					SELECT vopers, nopers, nlancs, vlancs,
					     sopers, sgrupos, scontas,
					     smoedas, scotacaos, svalors, emps, datas, usualts, datalts,
					     grupos, contas, moedas, cotacaos, valors, opers,
					     1, hists, dopes, numes, valpags, vencs, dopcs, numcs,
					     nfs, titulos, grupems, contems, grupages, contages,
					     valliqs, <<EscaparSQL(LEFT(loc_cNovaChave, 20))>>, tipos, hist2s, docus, dtemis
					  FROM SigMvCcr
					 WHERE cidchaves = <<EscaparSQL(LEFT(par_cCidChavesOrigem, 20))>>;
					UPDATE SigMvCcr
					   SET gruconmoes = grupos + contas + moedas,
					       empdopnums = emps + dopes + STR(numes, 6),
					       empdopncs  = emps + dopcs + STR(numcs, 6),
					       pagos      = CASE WHEN valors = valpags THEN '0' ELSE '1' END
					 WHERE cidchaves = <<EscaparSQL(LEFT(loc_cNovaChave, 20))>>;
					UPDATE SigMvCcr
					   SET dopotps = dopcs + opers + tipos + pagos
					 WHERE cidchaves = <<EscaparSQL(LEFT(loc_cNovaChave, 20))>>;
				ENDTEXT

				IF THIS.ExecutarLoteTransacional(loc_cSQL, "FazContra - SigMvCcr")
					*-- Saldos das duas pontas do lancamento contrario.
					loc_cSQL = "SELECT grupos, contas, datas, moedas," + ;
						" sgrupos, scontas, smoedas FROM SigMvCcr" + ;
						" WHERE cidchaves = " + EscaparSQL(LEFT(loc_cNovaChave, 20))

					IF THIS.ExecutarConsulta(loc_cSQL, loc_cCursor, "FazContra - saldos")
						SELECT (loc_cCursor)
						GO TOP

						IF !EOF()
							fRecalculaS(NVL(&loc_cCursor..grupos, ""), ;
								NVL(&loc_cCursor..contas, ""), ;
								ConverterParaData(&loc_cCursor..datas), ;
								NVL(&loc_cCursor..moedas, ""), gnConnHandle)

							fRecalculaS(NVL(&loc_cCursor..sgrupos, ""), ;
								NVL(&loc_cCursor..scontas, ""), ;
								ConverterParaData(&loc_cCursor..datas), ;
								NVL(&loc_cCursor..smoedas, ""), gnConnHandle)
						ENDIF

						THIS.FecharCursor(loc_cCursor)
					ENDIF

					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.FazContra")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarParametros - cursor com os parametros gerais do sistema
	* (SigCdPam) e a chave de identificacao (SigCdPac.SigKeys) usados
	* pelos lancamentos financeiros. Equivalente aos CursorQuery
	* 'SigCdPam'/'crSigCdPam' e 'SigCdPac'/'crSigCdPac' do Init legado.
	*
	* Colunas lidas: ComGrupos/ComContas (grupo e centro de custo de
	* comissao, usados pelo Financeiro) e SigKeys (sufixo da chave
	* cIdChaves dos lancamentos).
	*====================================================================
	PROCEDURE CarregarParametros()
		LOCAL loc_cSQL, loc_lSucesso

		loc_lSucesso = .F.

		loc_cSQL = "SELECT comgrupos, comcontas, gruporecs, contarecs," + ;
			" grupopags, contapags, tpinstalas, mascnums" + ;
			" FROM SigCdPam"

		IF THIS.ExecutarConsulta(loc_cSQL, THIS.this_cCursorParametros, "crSigCdPam")
			loc_cSQL = "SELECT sigkeys FROM SigCdPac"
			loc_lSucesso = THIS.ExecutarConsulta(loc_cSQL, THIS.this_cCursorSigKey, "crSigCdPac")
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* MontarChaveLancamento - monta a chave cIdChaves dos lancamentos
	* financeiros no formato do legado:
	*   Dtos(<data>) + Transform(fGerUniqueKey(Dtos(<data>)), '@L 999999')
	*   + SigCdPac.SigKeys
	*====================================================================
	PROTECTED FUNCTION MontarChaveLancamento(par_dData)
		LOCAL loc_cData, loc_cSigKey, loc_cCurKey

		loc_cCurKey = THIS.this_cCursorSigKey
		loc_cData   = DTOS(ConverterParaData(par_dData))
		loc_cSigKey = ""

		IF USED(loc_cCurKey)
			SELECT (loc_cCurKey)
			GO TOP
			IF !EOF()
				loc_cSigKey = NVL(&loc_cCurKey..sigkeys, "")
			ENDIF
		ENDIF

		RETURN loc_cData + TRANSFORM(fGerUniqueKey(loc_cData), "@L 999999") + loc_cSigKey
	ENDFUNC

	*====================================================================
	* Financeiro - modo FRANQUIA do processo de copia: em vez de copiar
	* a movimentacao inteira, lanca APENAS o financeiro (royalty) de
	* cada operacao selecionada. Equivalente ao "PROCEDURE financeiro"
	* do legado (dump:2490-2764), acionado quando algum item do processo
	* esta sem Documento de Destino (DopeDs vazio).
	*
	* Para cada item do processo (this_cCursorProcOrigens) x cada
	* destino configurado x cada operacao marcada na grade:
	*   1. valor = ROUND((Valos / 100) * PctCopias, 2)   [TRANSCRITO]
	*   2. le a operacao de TITULO (SigCdOpe x SigOpOpe) que define o
	*      documento, os quatro grupos e o identificador do titulo;
	*   3. resolve grupo/conta de ORIGEM e de DESTINO pelos DO CASE de
	*      GruConOs (5 opcoes) e GruConDs (4 opcoes)  [TRANSCRITOS];
	*   4. grava o lancamento em SigMvCcr, recalcula as chaves
	*      derivadas, recalcula saldos e gera a contrapartida
	*      (FazContra);
	*   5. grava o log em SigPcOoL (Tipos = 'SIGPCOOP'), apagando o log
	*      anterior quando o usuario pediu REPROCESSAMENTO.
	*
	* Diferenca de arquitetura (mesma nota de CopiarFiscais): o legado
	* abria uma conexao por destino (loConexao(...)) e gravava num
	* cursor DesMvCcr que era enviado ao destino por Update + Commit;
	* aqui a gravacao e um INSERT direto no unico SQL Server, dentro de
	* um lote transacional (ExecutarLoteTransacional).
	*====================================================================
	PROCEDURE Financeiro()
		LOCAL loc_cCurOri, loc_cCurDes, loc_cCurSel, loc_cCurTit, loc_cCurEmp
		LOCAL loc_cCurPam, loc_cSQL, loc_cEmp, loc_cDop, loc_nNum, loc_cEmpDs
		LOCAL loc_nPct, loc_nVal, loc_nNop, loc_cVop, loc_cDoc, loc_cHis, loc_cHs2
		LOCAL loc_cOpe, loc_cSop, loc_cMd1, loc_cDpc, loc_cTit, loc_cChave
		LOCAL loc_cGr1, loc_cGr2, loc_cGr3, loc_cGr4
		LOCAL loc_cCt1, loc_cCt2, loc_cCt3, loc_cCt4
		LOCAL loc_nGCO, loc_nGCD, loc_lSoNaoProcessadas, loc_lProsseguir
		LOCAL loc_oBarra, loc_nSel, loc_nFal, loc_lSucesso, loc_oErro

		loc_lSucesso    = .F.
		loc_lProsseguir = .T.
		loc_oBarra      = .NULL.

		loc_cCurOri = THIS.this_cCursorProcOrigens
		loc_cCurDes = "cursor_4c_DestinosFin"
		loc_cCurSel = "cursor_4c_SelecionadasFin"
		loc_cCurTit = "cursor_4c_TituloFin"
		loc_cCurEmp = "cursor_4c_EmpresaFin"
		loc_cCurPam = THIS.this_cCursorParametros

		TRY
			loc_lSoNaoProcessadas = (THIS.this_nProcessados = 1)

			IF !USED(loc_cCurPam)
				loc_lProsseguir = THIS.CarregarParametros()
			ENDIF

			IF loc_lProsseguir AND !USED(THIS.this_cCursorDestinos)
				loc_lProsseguir = THIS.CarregarDestinos()
			ENDIF

			IF loc_lProsseguir AND !USED(loc_cCurOri)
				MsgErro("A lista de itens do Processo de C" + CHR(243) + "pia n" + CHR(227) + ;
					"o est" + CHR(225) + " carregada.", "sigoppopBO.Financeiro")
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurPam)
				GO TOP
				loc_cGr3 = NVL(&loc_cCurPam..comgrupos, "")
				loc_cCt3 = NVL(&loc_cCurPam..comcontas, "")

				SELECT (loc_cCurOri)
				GO TOP
				SCAN
					loc_lProsseguir = THIS.CarregarProcessoAtual("Financeiro - crSigPcOop")
					IF !loc_lProsseguir
						EXIT
					ENDIF

					loc_cEmp = PADR(NVL(&loc_cCurOri..emps, ""), 3)
					loc_cDop = PADR(NVL(&loc_cCurOri..dopes, ""), 20)
					loc_nNum = NVL(&loc_cCurOri..codigos, 0)

					*-- Operacoes marcadas na grade para este par Empresa/Documento.
					THIS.FecharCursor(loc_cCurSel)

					IF EMPTY(loc_cEmp)
						SELECT * ;
							FROM (THIS.this_cCursorOperacoes) ;
							WHERE SelImp AND PADR(Dopes, 20) = loc_cDop ;
							ORDER BY 2, 3, 4 ;
							INTO CURSOR (loc_cCurSel) READWRITE
					ELSE
						SELECT * ;
							FROM (THIS.this_cCursorOperacoes) ;
							WHERE SelImp AND PADR(Emps, 3) = loc_cEmp ;
								AND PADR(Dopes, 20) = loc_cDop ;
							ORDER BY 2, 3, 4 ;
							INTO CURSOR (loc_cCurSel) READWRITE
					ENDIF

					IF RECCOUNT(loc_cCurSel) > 0
						IF !THIS.SelecionarDestinosCompletos(loc_cCurDes, loc_cEmp, loc_cDop, loc_nNum)
							loc_lProsseguir = .F.
							EXIT
						ENDIF

						loc_nSel = RECCOUNT(loc_cCurSel) * RECCOUNT(loc_cCurDes)
						loc_nFal = 0

						loc_oBarra = THIS.CriarBarraProgresso("Processando Movimenta" + ;
							CHR(231) + CHR(245) + "es Selecionadas...", RECCOUNT(loc_cCurDes))

						SELECT (loc_cCurDes)
						GO TOP
						SCAN
							loc_nGCO = IIF(NVL(&loc_cCurDes..gruconos, 0) <> 0, NVL(&loc_cCurDes..gruconos, 0), 1)
							loc_nGCD = IIF(NVL(&loc_cCurDes..gruconds, 0) <> 0, NVL(&loc_cCurDes..gruconds, 0), 1)
							loc_nPct = NVL(&loc_cCurDes..pctcopias, 0)

							SELECT (loc_cCurSel)
							GO TOP
							SCAN
								loc_nFal = loc_nFal + 1

								IF VARTYPE(loc_oBarra) = "O"
									loc_oBarra.SubTitulo.Caption = "Movimenta" + CHR(231) + CHR(227) + "o : " + ;
										ALLTRIM(NVL(&loc_cCurSel..Emps, "")) + " - " + ;
										ALLTRIM(NVL(&loc_cCurSel..Dopes, "")) + " - (" + ;
										ALLTRIM(STR(NVL(&loc_cCurSel..Numes, 0), 6)) + ") - (" + ;
										ALLTRIM(STR(loc_nFal)) + " de " + ALLTRIM(STR(loc_nSel)) + ")"
								ENDIF

								*-- Empresa que assina o lancamento no destino.
								loc_cSQL = "SELECT nums, cemps FROM SigCdEmp" + ;
									" WHERE cemps = " + EscaparSQL(PADR(NVL(&loc_cCurSel..Emps, ""), 3))

								IF !THIS.ExecutarConsulta(loc_cSQL, loc_cCurEmp, "LocalEmp")
									loc_lProsseguir = .F.
									EXIT
								ENDIF

								SELECT (loc_cCurEmp)
								GO TOP
								loc_cEmpDs = IIF(EOF() OR EMPTY(NVL(&loc_cCurEmp..cemps, "")), ;
									go_4c_Sistema.cCodEmpresa, NVL(&loc_cCurEmp..cemps, ""))

								*-- Valor copiado = percentual do valor da origem.
								SELECT (loc_cCurSel)
								loc_nVal = ROUND((NVL(&loc_cCurSel..Valos, 0) / 100) * loc_nPct, 2)

								*-- Operacao de TITULO que define documento e grupos.
								loc_cSQL = "SELECT a.dopcs, a.conorigs, a.condests, a.grupos," + ;
									" a.contas, a.ndopes, a.copers, a.cmoes," + ;
									" b.grupo1s, b.grupo2s, b.grupo3s, b.grupo4s, b.identifics" + ;
									" FROM SigCdOpe a, SigOpOpe b" + ;
									" WHERE a.dopes = " + EscaparSQL(PADR(NVL(&loc_cCurSel..Dopes, ""), 20)) + ;
									" AND a.dopcs = b.dopes"

								IF !THIS.ExecutarConsulta(loc_cSQL, loc_cCurTit, "LocalTitulo")
									loc_lProsseguir = .F.
									EXIT
								ENDIF

								SELECT (loc_cCurTit)
								GO TOP

								IF EOF()
									*-- Sem operacao de titulo cadastrada nao ha o que
									*-- lancar; o legado seguiria com os campos em
									*-- branco e gravaria um lancamento sem conta.
									IF THIS.this_lExibirMensagens
										MsgAviso("A Opera" + CHR(231) + CHR(227) + "o [" + ;
											ALLTRIM(NVL(&loc_cCurSel..Dopes, "")) + ;
											"] n" + CHR(227) + "o tem Opera" + CHR(231) + CHR(227) + ;
											"o de T" + CHR(237) + "tulo cadastrada (SigCdOpe.DopCs x SigOpOpe)." + CHR(13) + ;
											"O lan" + CHR(231) + "amento financeiro desta movimenta" + CHR(231) + CHR(227) + ;
											"o foi ignorado.", ;
											"Opera" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulo n" + CHR(227) + "o cadastrada")
									ENDIF

									SELECT (loc_cCurSel)
									LOOP
								ENDIF

								loc_cChave = THIS.MontarChaveLancamento(&loc_cCurSel..Datas)

								loc_nNop = fGerUniqueKey("SigMvCcr")
								loc_cVop = loc_cEmpDs + ALLTRIM(STR(loc_nNop, 9))
								loc_cDoc = TRANSFORM(NVL(&loc_cCurTit..ndopes, 0), "@L 999") + ;
									TRANSFORM(NVL(&loc_cCurSel..Numes, 0), "@L 999999")
								loc_cHis = "ROYALTY LOJA " + NVL(&loc_cCurSel..Emps, "")
								loc_cHs2 = "NOTA " + NVL(&loc_cCurSel..Notas, "")
								loc_cOpe = IIF(NVL(&loc_cCurTit..copers, 0) = 1, "C", "D")
								loc_cSop = IIF(NVL(&loc_cCurTit..copers, 0) = 1, "D", "C")
								loc_cMd1 = NVL(&loc_cCurTit..cmoes, "")
								loc_cDpc = NVL(&loc_cCurTit..dopcs, "")
								loc_cTit = NVL(&loc_cCurTit..identifics, "") + ;
									TRANSFORM(fGerUniqueKey(NVL(&loc_cCurTit..dopcs, "")), "@L 999999")

								loc_cGr1 = NVL(&loc_cCurTit..grupo1s, "")
								loc_cGr2 = NVL(&loc_cCurTit..grupo2s, "")
								loc_cGr4 = NVL(&loc_cCurTit..grupo4s, "")

								loc_cCt1 = ""   && Emitente
								loc_cCt2 = ""   && Portador
								loc_cCt4 = ""   && Agente Cobrador

								*-- Grupo/conta da ORIGEM (DO CASE transcrito).
								DO CASE
								CASE loc_nGCO = 1
									loc_cCt1 = NVL(&loc_cCurSel..Emps, "")
								CASE loc_nGCO = 2
									loc_cCt1 = NVL(&loc_cCurSel..EmpDs, "")
								CASE loc_nGCO = 3
									loc_cCt1 = IIF(EMPTY(NVL(&loc_cCurTit..conorigs, "")), ;
										NVL(&loc_cCurSel..ContaOs, ""), NVL(&loc_cCurTit..conorigs, ""))
								CASE loc_nGCO = 4
									loc_cCt1 = NVL(&loc_cCurSel..ContaOs, "")
								CASE loc_nGCO = 5
									loc_cCt1 = PADR(IIF(EMPTY(NVL(&loc_cCurTit..conorigs, "")), ;
										NVL(&loc_cCurSel..Emps, ""), NVL(&loc_cCurTit..conorigs, "")), 10)
								ENDCASE

								*-- Grupo/conta do DESTINO (DO CASE transcrito).
								DO CASE
								CASE loc_nGCD = 1
									loc_cCt2 = NVL(&loc_cCurSel..Emps, "")
								CASE loc_nGCD = 2
									loc_cCt2 = NVL(&loc_cCurSel..EmpDs, "")
								CASE loc_nGCD = 3
									loc_cCt2 = IIF(EMPTY(NVL(&loc_cCurTit..condests, "")), ;
										NVL(&loc_cCurSel..ContaDs, ""), NVL(&loc_cCurTit..condests, ""))
								CASE loc_nGCD = 4
									loc_cCt2 = NVL(&loc_cCurSel..ContaDs, "")
								ENDCASE

								IF !THIS.GravarLancamentoFinanceiro(loc_cChave, loc_nNop, loc_cVop, ;
										loc_cDoc, loc_cEmpDs, ConverterParaData(&loc_cCurSel..Datas), ;
										loc_cHis, loc_cHs2, loc_cOpe, loc_cSop, loc_cMd1, loc_nVal, ;
										loc_cGr1, loc_cCt1, loc_cGr2, loc_cCt2, loc_cGr3, loc_cCt3, ;
										loc_cGr4, loc_cCt4, loc_cDpc, NVL(&loc_cCurSel..Notas, ""), loc_cTit)
									loc_lProsseguir = .F.
									EXIT
								ENDIF

								THIS.FazContra(loc_cChave)

								*-- Log de processamento da operacao.
								IF !THIS.GravarLogProcessamento(NVL(&loc_cCurSel..Emps, ""), ;
										NVL(&loc_cCurSel..Dopes, ""), NVL(&loc_cCurSel..Numes, 0), ;
										"", "", 0, "", loc_lSoNaoProcessadas)
									loc_lProsseguir = .F.
									EXIT
								ENDIF

								SELECT (loc_cCurSel)
							ENDSCAN

							IF !loc_lProsseguir
								EXIT
							ENDIF

							THIS.AvancarBarra(loc_oBarra)
							SELECT (loc_cCurDes)
						ENDSCAN

						THIS.EncerrarBarra(loc_oBarra)
						loc_oBarra = .NULL.

						IF !loc_lProsseguir
							EXIT
						ENDIF
					ENDIF

					SELECT (loc_cCurOri)
				ENDSCAN
			ENDIF

			IF loc_lProsseguir
				MsgInfo("C" + CHR(243) + "pia Conclu" + CHR(237) + "da", "")
				loc_lSucesso = .T.
			ENDIF

			THIS.FecharCursor(loc_cCurSel)
			THIS.FecharCursor(loc_cCurDes)
			THIS.FecharCursor(loc_cCurTit)
			THIS.FecharCursor(loc_cCurEmp)
		CATCH TO loc_oErro
			THIS.EncerrarBarra(loc_oBarra)
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.Financeiro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SelecionarDestinosCompletos - filtra this_cCursorDestinos pelo
	* item do processo trazendo TODAS as colunas de configuracao
	* (equivalente ao "Select Distinct Processos, Emps, Dopes, ... Into
	* Cursor csDestinos ReadWrite" que o legado repete no Processamento
	* e no Financeiro). O irmao SelecionarDestinosDoItem traz so
	* Drives/cIdConns, para o CopiarFiscais.
	*
	* O filtro reproduz o lcWhere do legado: sem empresa no item, casa
	* por Dopes + Codigos E exige Emps VAZIO; com empresa, casa pelos
	* tres.
	*====================================================================
	PROTECTED FUNCTION SelecionarDestinosCompletos(par_cCursorSaida, par_cEmp, par_cDop, par_nNum)
		LOCAL loc_cCurDes, loc_cProc, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.
		loc_cCurDes  = THIS.this_cCursorDestinos
		loc_cProc    = PADR(THIS.this_cProcesso, 20)

		TRY
			THIS.FecharCursor(par_cCursorSaida)

			IF EMPTY(par_cEmp)
				SELECT DISTINCT * ;
					FROM (loc_cCurDes) ;
					WHERE processos = loc_cProc ;
						AND PADR(dopes, 20) + codigos = PADR(par_cDop, 20) + STR(par_nNum, 6) ;
						AND EMPTY(emps) ;
					INTO CURSOR (par_cCursorSaida) READWRITE
			ELSE
				SELECT DISTINCT * ;
					FROM (loc_cCurDes) ;
					WHERE processos = loc_cProc ;
						AND PADR(emps, 3) + PADR(dopes, 20) + codigos = ;
							PADR(par_cEmp, 3) + PADR(par_cDop, 20) + STR(par_nNum, 6) ;
					INTO CURSOR (par_cCursorSaida) READWRITE
			ENDIF

			loc_lSucesso = USED(par_cCursorSaida)
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.SelecionarDestinosCompletos")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* GravarLancamentoFinanceiro - INSERT do lancamento em SigMvCcr e o
	* recalculo das chaves derivadas, equivalente ao
	* "Insert Into DesMvCcr (...) + Replace GruConMoes/EmpDopNcs/Pagos/
	* DopoTps/EmpDopNums" do Financeiro legado, mais os dois
	* fRecalculaS das pontas.
	*
	* Vai num lote transacional unico porque sao tres comandos (insert +
	* dois updates de chave derivada) que tem de valer juntos.
	*====================================================================
	PROTECTED FUNCTION GravarLancamentoFinanceiro(par_cChave, par_nNop, par_cVop, ;
			par_cDoc, par_cEmp, par_dData, par_cHist, par_cHist2, par_cOper, ;
			par_cSOper, par_cMoeda, par_nValor, par_cGr1, par_cCt1, par_cGr2, ;
			par_cCt2, par_cGr3, par_cCt3, par_cGr4, par_cCt4, par_cDopc, ;
			par_cNota, par_cTitulo)
		LOCAL loc_cSQL, loc_cCursor, loc_lSucesso

		loc_lSucesso = .F.
		loc_cCursor  = "cursor_4c_SaldoFin"

		TEXT TO loc_cSQL TEXTMERGE NOSHOW PRETEXT 7
			INSERT INTO SigMvCcr
			    (nopers, vopers, docus, emps, datas, usualts, datalts, vencs,
			     hists, opers, sopers, moedas, cotacaos, valors, autos,
			     grupems, contems, grupos, contas, sgrupos, scontas,
			     grupages, contages, smoedas, scotacaos, svalors, valpags,
			     dopcs, nfs, titulos, valliqs, dtemis, hist2s, cidchaves)
			VALUES
			    (<<FormatarNumeroSQL(par_nNop, 0)>>,
			     <<EscaparSQL(LEFT(par_cVop, 13))>>,
			     <<EscaparSQL(LEFT(par_cDoc, 10))>>,
			     <<EscaparSQL(PADR(par_cEmp, 3))>>,
			     <<EscaparSQL(DTOS(par_dData))>>,
			     <<EscaparSQL(PADR(gc_4c_UsuarioLogado, 10))>>,
			     GETDATE(),
			     <<EscaparSQL(DTOS(par_dData))>>,
			     <<EscaparSQL(LEFT(par_cHist, 60))>>,
			     <<EscaparSQL(LEFT(par_cOper, 1))>>,
			     <<EscaparSQL(LEFT(par_cSOper, 1))>>,
			     <<EscaparSQL(PADR(par_cMoeda, 3))>>,
			     1,
			     <<FormatarNumeroSQL(par_nValor, 2)>>,
			     1,
			     <<EscaparSQL(PADR(par_cGr1, 10))>>,
			     <<EscaparSQL(PADR(par_cCt1, 10))>>,
			     <<EscaparSQL(PADR(par_cGr2, 10))>>,
			     <<EscaparSQL(PADR(par_cCt2, 10))>>,
			     <<EscaparSQL(PADR(par_cGr3, 10))>>,
			     <<EscaparSQL(PADR(par_cCt3, 10))>>,
			     <<EscaparSQL(PADR(par_cGr4, 10))>>,
			     <<EscaparSQL(PADR(par_cCt4, 10))>>,
			     <<EscaparSQL(PADR(par_cMoeda, 3))>>,
			     1,
			     <<FormatarNumeroSQL(par_nValor, 2)>>,
			     0,
			     <<EscaparSQL(PADR(par_cDopc, 20))>>,
			     <<EscaparSQL(LEFT(par_cNota, 10))>>,
			     <<EscaparSQL(LEFT(par_cTitulo, 10))>>,
			     <<FormatarNumeroSQL(par_nValor, 2)>>,
			     <<EscaparSQL(DTOS(par_dData))>>,
			     <<EscaparSQL(LEFT(par_cHist2, 80))>>,
			     <<EscaparSQL(LEFT(par_cChave, 20))>>);
			UPDATE SigMvCcr
			   SET gruconmoes = grupos + contas + moedas,
			       empdopncs  = emps + dopcs + STR(numcs, 6),
			       empdopnums = emps + dopes + STR(numes, 6),
			       pagos      = CASE WHEN valors = valpags THEN '0' ELSE '1' END
			 WHERE cidchaves = <<EscaparSQL(LEFT(par_cChave, 20))>>;
			UPDATE SigMvCcr
			   SET dopotps = dopcs + opers + tipos + pagos
			 WHERE cidchaves = <<EscaparSQL(LEFT(par_cChave, 20))>>;
		ENDTEXT

		IF THIS.ExecutarLoteTransacional(loc_cSQL, "Financeiro - SigMvCcr")
			*-- Saldos das duas pontas, como no legado.
			fRecalculaS(par_cGr2, par_cCt2, par_dData, par_cMoeda, gnConnHandle)
			fRecalculaS(par_cGr3, par_cCt3, par_dData, par_cMoeda, gnConnHandle)

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* GravarLogProcessamento - registra em SigPcOoL que a operacao de
	* origem foi copiada, equivalente ao bloco "Insert Into SigPcOoL
	* (Tipos, Emps, Dopes, Numes, Empds, Dopeds, Numeds, Datas, Usuars,
	* Produtos, Processos, cIdChaves, EmpDopNums, EdnDests)" que o
	* legado repete no Processamento e no Financeiro, precedido do
	* "Delete From SigPcOoL Where EmpDopNums = ..." quando o usuario
	* pediu REPROCESSAMENTO (optProcessados = 2 -> llNPr = .f.).
	*
	* A coluna Produtos recebe "LANCAMENTO REFEITO" no reprocessamento,
	* igual ao legado (que escreve o texto com cedilha - aqui via CHR).
	*
	* As duas chaves posicionais seguem a regra CLAUDE.md #42 - PADR
	* explicito em cada parte, nunca ALLTRIM:
	*   EmpDopNums = Emps(3) + Dopes(20) + Str(Numes, 6)
	*   EdnDests   = EmpDs(3) + DopeDs(20) + Str(NumeDs, 6)
	*====================================================================
	PROTECTED FUNCTION GravarLogProcessamento(par_cEmps, par_cDopes, par_nNumes, ;
			par_cEmpDs, par_cDopeDs, par_nNumeDs, par_cProdutos, par_lSoNaoProcessadas)
		LOCAL loc_cSQL, loc_cEdn, loc_cEdnDes, loc_cProdutos, loc_lSucesso

		loc_lSucesso = .F.

		loc_cEdn = PADR(par_cEmps, 3) + PADR(par_cDopes, 20) + STR(par_nNumes, 6)

		*-- No modo FRANQUIA (Financeiro) o legado grava destino vazio e
		*-- EdnDests vazio; no Processamento, a chave completa do destino.
		IF EMPTY(par_cEmpDs) AND EMPTY(par_cDopeDs)
			loc_cEdnDes = ""
		ELSE
			loc_cEdnDes = PADR(par_cEmpDs, 3) + PADR(par_cDopeDs, 20) + STR(par_nNumeDs, 6)
		ENDIF

		loc_cProdutos = par_cProdutos
		IF !par_lSoNaoProcessadas
			loc_cProdutos = "LAN" + CHR(199) + "AMENTO REFEITO"
		ENDIF

		loc_cSQL = ""

		*-- Reprocessamento: apaga o log anterior desta operacao.
		IF !par_lSoNaoProcessadas
			loc_cSQL = loc_cSQL + ;
				"DELETE FROM SigPcOoL WHERE empdopnums = " + EscaparSQL(loc_cEdn) + ";" + CHR(13) + CHR(10)
		ENDIF

		loc_cSQL = loc_cSQL + ;
			"INSERT INTO SigPcOoL (tipos, emps, dopes, numes, empds," + ;
			" dopeds, numeds, datas, usuars, produtos, processos," + ;
			" cidchaves, empdopnums, edndests) VALUES (" + ;
			EscaparSQL(PADR("SIGPCOOP", 10)) + ", " + ;
			EscaparSQL(PADR(par_cEmps, 3)) + ", " + ;
			EscaparSQL(PADR(par_cDopes, 20)) + ", " + ;
			FormatarNumeroSQL(par_nNumes, 0) + ", " + ;
			EscaparSQL(PADR(par_cEmpDs, 3)) + ", " + ;
			EscaparSQL(PADR(par_cDopeDs, 20)) + ", " + ;
			FormatarNumeroSQL(par_nNumeDs, 0) + ", " + ;
			"GETDATE(), " + ;
			EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", " + ;
			EscaparSQL(loc_cProdutos) + ", " + ;
			EscaparSQL(PADR(THIS.this_cProcesso, 20)) + ", " + ;
			EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
			EscaparSQL(loc_cEdn) + ", " + ;
			EscaparSQL(loc_cEdnDes) + ");" + CHR(13) + CHR(10)

		loc_lSucesso = THIS.ExecutarLoteTransacional(loc_cSQL, "crSigPcOoL")

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* NOTA DE ESCOPO - SqlCalcP2 / fRecalculaC (recalculo de saldo de
	* estoque e de custo medio)
	*
	* O Delecao legado chama, para cada linha de historico apagada:
	*     SqlCalcP2(Emps, Grupos, Estos, Cpros, Datas, CodCors, CodTams, conexao)
	*     fRecalculaC(Emps, Cpros, Datas, conexao)
	*
	* NENHUMA das duas foi portada para projeto\app\utils (varredura em
	* .prg, no fonte do Framework e no p-code dos VCX). Elas devolvem
	* VALOR DE CALCULO - saldo e custo - e por isso NAO podem virar stub
	* (regra CLAUDE.md #27, 3a linha da tabela: stub que devolve valor
	* grava numero errado em silencio, como fCalcularST/fCalcularIPI).
	*
	* DECISAO (mesma de sigprilaBO.RecalcularEstoque): as chamadas
	* FICAM no codigo. O VFP9 procura sqlcalcp2.prg no PATH e o erro
	* aparece ALTO, dentro do TRY/CATCH desta rotina - e, por estarem
	* ANTES dos DELETE, a falha ABORTA a exclusao e deixa o dado
	* intacto, que e a direcao segura. Omitir as chamadas deixaria o
	* saldo de estoque desatualizado em silencio depois de apagar a
	* movimentacao.
	*====================================================================

	*====================================================================
	* Delecao - apaga a movimentacao de ORIGEM depois de ela ter sido
	* copiada, desfazendo tudo o que ela gerou. Equivalente ao
	* "PROCEDURE delecao" do legado (dump:2034-2411), chamado pelo
	* Processamento quando o Processo de Copia pede "Apagar Arquivos de
	* Dados da Origem" (SigPcOoP.Apagar 3 ou 4).
	*
	* par_cOperacao e a chave posicional EmpDopNums (char(29), regra
	* CLAUDE.md #42) da operacao a apagar; par_cDopes e o codigo da
	* operacao, usado para ler SigCdOpe (Caixas/COpers), que decide o
	* desfazimento dos cheques.
	*
	* Ordem das tabelas e condicoes TRANSCRITAS do legado. As linhas de
	* historico (SigMvHst) sao localizadas por OriDopNums - a chave da
	* operacao que as ORIGINOU - e nao por EmpDopNums.
	*
	* Diferenca de arquitetura: o legado recebia a conexao por parametro
	* (pCnx, a conexao da empresa); aqui ha um unico gnConnHandle.
	*
	* Uma linha do legado NAO foi reproduzida, de proposito: o
	* acumulador "lnValoBxs = lnValoBxs + Iif(crSigOpFp.Baixas = 1,
	* Round(xPar.CotFPgs * xPar.Valos, 2), 0)" le o alias xPar, que NAO
	* EXISTE em nenhum ponto do form legado (o cursor em uso ali e
	* crPar) - a linha estouraria "Variable XPAR is not found" - e o
	* resultado lnValoBxs nao e usado em lugar nenhum depois. Reproduzi-la
	* seria reproduzir uma falha de runtime sem efeito util.
	*====================================================================
	PROCEDURE Delecao(par_cOperacao, par_cDopes)
		LOCAL loc_cOper, loc_cCurOpe, loc_cCurHis, loc_cCurMccr, loc_cCurPar
		LOCAL loc_cCurFp, loc_cCurPbx, loc_cCurLote, loc_cSQL, loc_cCheque
		LOCAL loc_nCaixas, loc_nCopers, loc_lProsseguir, loc_lSucesso, loc_oErro

		loc_lSucesso    = .F.
		loc_lProsseguir = .T.

		loc_cOper    = PADR(par_cOperacao, 29)
		loc_cCurOpe  = "cursor_4c_DelOpe"
		loc_cCurHis  = "cursor_4c_DelHist"
		loc_cCurMccr = "cursor_4c_DelMccr"
		loc_cCurPar  = "cursor_4c_DelPar"
		loc_cCurFp   = "cursor_4c_DelFpag"
		loc_cCurPbx  = "cursor_4c_DelPbx"
		loc_cCurLote = "cursor_4c_DelLote"

		TRY
			*-- Configuracao da operacao (decide o desfazimento de cheques).
			loc_cSQL = "SELECT caixas, copers FROM SigCdOpe" + ;
				" WHERE dopes = " + EscaparSQL(PADR(par_cDopes, 20))

			loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurOpe, "crSigCdOpe")

			IF loc_lProsseguir
				SELECT (loc_cCurOpe)
				GO TOP
				loc_nCaixas = IIF(EOF(), 0, NVL(&loc_cCurOpe..caixas, 0))
				loc_nCopers = IIF(EOF(), 0, NVL(&loc_cCurOpe..copers, 0))
			ENDIF

			*-- 1. Historico de estoque gerado pela operacao: recalcula saldo
			*-- e custo ANTES de apagar (ver NOTA DE ESCOPO acima).
			IF loc_lProsseguir
				loc_cSQL = "SELECT datas, cpros, grupos, estos, codcors," + ;
					" codtams, emps FROM SigMvHst" + ;
					" WHERE oridopnums = " + EscaparSQL(loc_cOper)

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurHis, "CrHis")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurHis)
				GO TOP
				SCAN
					SqlCalcP2(NVL(&loc_cCurHis..emps, ""), NVL(&loc_cCurHis..grupos, ""), ;
						NVL(&loc_cCurHis..estos, ""), NVL(&loc_cCurHis..cpros, ""), ;
						ConverterParaData(&loc_cCurHis..datas), ;
						NVL(&loc_cCurHis..codcors, ""), NVL(&loc_cCurHis..codtams, ""), ;
						gnConnHandle)

					fRecalculaC(NVL(&loc_cCurHis..emps, ""), NVL(&loc_cCurHis..cpros, ""), ;
						ConverterParaData(&loc_cCurHis..datas), gnConnHandle)

					SELECT (loc_cCurHis)
				ENDSCAN

				loc_lProsseguir = THIS.ApagarPorOperacao("SigMvHst", "oridopnums", loc_cOper)
			ENDIF

			*-- 2. Cabecalho, itens, grade de cor/tamanho, etiquetas e
			*-- parcelas previstas.
			IF loc_lProsseguir
				loc_lProsseguir = THIS.ApagarPorOperacao("SigMvCab", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigMvItn", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigMvIts", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigOpEtq", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigMvCpv", "empdopnums", loc_cOper)
			ENDIF

			*-- 3. Lancamentos financeiros: recalcula o saldo de cada conta
			*-- movimentada e so depois apaga.
			IF loc_lProsseguir
				loc_cSQL = "SELECT grupos, contas, datas, moedas FROM SigMvCcr" + ;
					" WHERE empdopnums = " + EscaparSQL(loc_cOper)

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurMccr, "CrMccr")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurMccr)
				GO TOP
				SCAN
					fRecalculaS(NVL(&loc_cCurMccr..grupos, ""), NVL(&loc_cCurMccr..contas, ""), ;
						ConverterParaData(&loc_cCurMccr..datas), NVL(&loc_cCurMccr..moedas, ""), ;
						gnConnHandle)

					SELECT (loc_cCurMccr)
				ENDSCAN

				loc_lProsseguir = THIS.ApagarPorOperacao("SigMvCcr", "empdopnums", loc_cOper)
			ENDIF

			*-- 4. Parcelas: cheque depositado volta a ficar "nao depositado"
			*-- quando a operacao e de CAIXA de saida com forma de pagamento
			*-- que gera pendencia (Caixas = 1, COpers = 2, ValPends = 1).
			IF loc_lProsseguir
				loc_cSQL = "SELECT fpags, bancos, agencias, contas, numeros," + ;
					" cotfpgs, valos, cidchaves FROM SigMvPar" + ;
					" WHERE empdopnums = " + EscaparSQL(loc_cOper)

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurPar, "CrPar")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurPar)
				GO TOP
				SCAN
					loc_cCheque = PADR(NVL(&loc_cCurPar..bancos, ""), 3) + ;
						PADR(NVL(&loc_cCurPar..agencias, ""), 4) + ;
						PADR(NVL(&loc_cCurPar..contas, ""), 10) + ;
						PADR(NVL(&loc_cCurPar..numeros, ""), 6)

					loc_cSQL = "SELECT valpends, baixas FROM SigOpFp" + ;
						" WHERE fpags = " + EscaparSQL(PADR(NVL(&loc_cCurPar..fpags, ""), 12))

					IF !THIS.ExecutarConsulta(loc_cSQL, loc_cCurFp, "CrSigOpFp")
						loc_lProsseguir = .F.
						EXIT
					ENDIF

					SELECT (loc_cCurFp)
					GO TOP

					IF loc_nCaixas = 1 AND loc_nCopers = 2 AND ;
					   !EOF() AND NVL(&loc_cCurFp..valpends, 0) = 1 AND ;
					   !EMPTY(ALLTRIM(loc_cCheque))
						loc_cSQL = "UPDATE SigCdPbx SET deposits = 1" + ;
							" WHERE ncheques = " + EscaparSQL(PADR(NVL(&loc_cCurPar..numeros, ""), 6)) + ;
							" AND bancos + agencias + ncontas + ncheques = " + ;
							EscaparSQL(loc_cCheque)

						IF !THIS.ExecutarConsulta(loc_cSQL, "", "Update SigCdPbx 2")
							loc_lProsseguir = .F.
							EXIT
						ENDIF
					ENDIF

					SELECT (loc_cCurPar)
				ENDSCAN
			ENDIF

			IF loc_lProsseguir
				loc_lProsseguir = THIS.ApagarPorOperacao("SigMvPar", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigTtCcd", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigCdCmm", "empdopnums", loc_cOper)
			ENDIF

			*-- 5. Lotes de cheque: apaga o historico do lote e o lote.
			IF loc_lProsseguir
				loc_cSQL = "SELECT numlotes FROM SigChLcq" + ;
					" WHERE empdopnums = " + EscaparSQL(loc_cOper)

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurLote, "CrCheH")
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cCurLote)
				GO TOP
				SCAN
					IF NVL(&loc_cCurLote..numlotes, 0) > 0
						loc_cSQL = "DELETE FROM SigCheH WHERE numlotes = " + ;
							FormatarNumeroSQL(NVL(&loc_cCurLote..numlotes, 0), 0)

						IF !THIS.ExecutarConsulta(loc_cSQL, "", "Delete SigCheH")
							loc_lProsseguir = .F.
							EXIT
						ENDIF
					ENDIF

					SELECT (loc_cCurLote)
				ENDSCAN
			ENDIF

			IF loc_lProsseguir
				loc_lProsseguir = THIS.ApagarPorOperacao("SigChLcq", "empdopnums", loc_cOper)
			ENDIF

			*-- 6. Movimentacao de cheques (SigCqChm) - o bloco mais longo do
			*-- legado, extraido para DesfazerCheques por legibilidade.
			IF loc_lProsseguir
				loc_lProsseguir = THIS.DesfazerCheques(loc_cOper)
			ENDIF

			*-- 7. Demais tabelas ligadas a operacao, na ordem do legado.
			*-- SigCdCar/SigCdCtt/SigCdCrd aparecem DUAS vezes no legado (uma
			*-- antes e uma depois do bloco de exclusoes); o segundo DELETE e
			*-- inofensivo e nao foi repetido aqui.
			IF loc_lProsseguir
				loc_lProsseguir = THIS.ApagarPorOperacao("SigCdCar", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigCdCtt", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigCdCrd", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigOpDev", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigMvPec", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigMvMov", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigMvEtv", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigMvNfi", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigExMvc", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigExMvI", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigExMvP", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigCdPbx", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigCqChi", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigCdPgc", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigPrTtl", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigCdPit", "empdopnums", loc_cOper) ;
					AND THIS.ApagarPorOperacao("SigCdPgr", "empdopnums", loc_cOper)
			ENDIF

			loc_lSucesso = loc_lProsseguir

			THIS.FecharCursor(loc_cCurOpe)
			THIS.FecharCursor(loc_cCurHis)
			THIS.FecharCursor(loc_cCurMccr)
			THIS.FecharCursor(loc_cCurPar)
			THIS.FecharCursor(loc_cCurFp)
			THIS.FecharCursor(loc_cCurPbx)
			THIS.FecharCursor(loc_cCurLote)
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.Delecao")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ApagarPorOperacao - um DELETE de tabela filha da operacao, no
	* formato que o Delecao legado repete ~30 vezes
	* ("Delete From <tabela> Where <chave> = '<operacao>'" + mensagem
	* "Falha na Conexao (Delete <tabela>)" no erro).
	*====================================================================
	PROTECTED FUNCTION ApagarPorOperacao(par_cTabela, par_cCampo, par_cOperacao)
		LOCAL loc_cSQL

		loc_cSQL = "DELETE FROM " + par_cTabela + ;
			" WHERE " + par_cCampo + " = " + EscaparSQL(par_cOperacao)

		RETURN THIS.ExecutarConsulta(loc_cSQL, "", "Delete " + par_cTabela)
	ENDFUNC

	*====================================================================
	* DesfazerCheques - bloco de cheques do Delecao legado
	* (dump:2195-2290): para cada cheque movimentado pela operacao,
	* apaga a movimentacao (SigCqChm) e decide o destino do cheque:
	*
	*   - nao sobrou NENHUMA outra movimentacao do mesmo cheque: o
	*     cheque e ARQUIVADO em SigExChq e apagado de SigChe;
	*   - sobrou alguma: SigChe volta a apontar para a ULTIMA
	*     movimentacao restante (Umovs/Numeros, pela ordem de DtSis) e a
	*     parcela correspondente em SigMvPar volta a ficar em aberto
	*     (VPags = 0, Pagos = '1').
	*
	* O legado monta o registro de SigExChq chamando antes
	* fCriarCurSit(), que cria o cursor crSigExChq ligado a tabela
	* SigExChq - funcao que NAO foi portada. Como a tabela EXISTE no
	* schema (SigExChq, 21 colunas), aqui o arquivamento e um INSERT
	* direto nela, com as MESMAS colunas que o legado preenche; nao ha
	* valor de calculo envolvido, so transporte de linha, entao isto nao
	* e stub de funcao ausente (regra CLAUDE.md #27) e sim a propria
	* gravacao que a funcao ausente faria.
	*====================================================================
	PROTECTED FUNCTION DesfazerCheques(par_cOperacao)
		LOCAL loc_cCurChm, loc_cCurOutras, loc_cCurChe, loc_cCurParChq
		LOCAL loc_cSQL, loc_cCheque, loc_cNums, loc_cUMovs, loc_cNumCheques
		LOCAL loc_lApaga, loc_lProsseguir, loc_oErro

		loc_lProsseguir = .T.

		loc_cCurChm    = "cursor_4c_DelChm"
		loc_cCurOutras = "cursor_4c_DelChmOutras"
		loc_cCurChe    = "cursor_4c_DelChe"
		loc_cCurParChq = "cursor_4c_DelParChq"

		TRY
			loc_cSQL = "SELECT nums, bancos, agencias, ncontas, ncheques," + ;
				" cidchaves FROM SigCqChm" + ;
				" WHERE empdopnums = " + EscaparSQL(par_cOperacao)

			loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurChm, "CrChm 3")

			IF loc_lProsseguir
				SELECT (loc_cCurChm)
				GO TOP
				SCAN
					loc_cNums   = NVL(&loc_cCurChm..nums, "")
					loc_cCheque = PADR(NVL(&loc_cCurChm..bancos, ""), 3) + ;
						PADR(NVL(&loc_cCurChm..agencias, ""), 4) + ;
						PADR(NVL(&loc_cCurChm..ncontas, ""), 10) + ;
						PADR(NVL(&loc_cCurChm..ncheques, ""), 6)

					*-- Apaga esta movimentacao do cheque.
					loc_cSQL = "DELETE FROM SigCqChm WHERE cidchaves = " + ;
						EscaparSQL(NVL(&loc_cCurChm..cidchaves, ""))

					IF !THIS.ExecutarConsulta(loc_cSQL, "", "Delete SigCqChm")
						loc_lProsseguir = .F.
						EXIT
					ENDIF

					*-- Sobrou outra movimentacao do MESMO cheque, fora desta
					*-- operacao? A ultima (maior DtSis) volta a ser a corrente.
					loc_cSQL = "SELECT codigos, numeros FROM SigCqChm" + ;
						" WHERE bancos + agencias + ncontas + ncheques = " + ;
						EscaparSQL(loc_cCheque) + ;
						" AND empdopnums <> " + EscaparSQL(par_cOperacao) + ;
						" ORDER BY dtsis"

					IF !THIS.ExecutarConsulta(loc_cSQL, loc_cCurOutras, "CrChm2")
						loc_lProsseguir = .F.
						EXIT
					ENDIF

					loc_lApaga     = .F.
					loc_cUMovs     = ""
					loc_cNumCheques = ""

					SELECT (loc_cCurOutras)
					IF RECCOUNT(loc_cCurOutras) = 0
						loc_lApaga = .T.
					ELSE
						GO BOTTOM
						loc_cUMovs      = NVL(&loc_cCurOutras..codigos, "")
						loc_cNumCheques = NVL(&loc_cCurOutras..numeros, "")
					ENDIF

					*-- Cheque de onde a movimentacao saiu.
					loc_cSQL = "SELECT agencias, bancos, vencs, ncheques, ncontas," + ;
						" nums, umovs, valors, contas, grupos, iclis, autos," + ;
						" emps, notas, transps, concarts, grucarts" + ;
						" FROM SigChe" + ;
						" WHERE nums = " + EscaparSQL(PADR(loc_cNums, 8)) + ;
						" AND bancos + agencias + ncontas + ncheques = " + ;
						EscaparSQL(loc_cCheque)

					IF !THIS.ExecutarConsulta(loc_cSQL, loc_cCurChe, "CrChe")
						loc_lProsseguir = .F.
						EXIT
					ENDIF

					SELECT (loc_cCurChe)
					GO TOP

					IF !EOF()
						IF loc_lApaga
							IF !THIS.ArquivarCheque(loc_cCurChe)
								loc_lProsseguir = .F.
								EXIT
							ENDIF
						ELSE
							loc_cSQL = "UPDATE SigChe SET umovs = " + ;
								EscaparSQL(PADR(loc_cUMovs, 15)) + ;
								", numeros = " + EscaparSQL(PADR(loc_cNumCheques, 6)) + ;
								", dtalts = GETDATE()" + ;
								" WHERE nums = " + EscaparSQL(PADR(NVL(&loc_cCurChe..nums, ""), 8))

							IF !THIS.ExecutarConsulta(loc_cSQL, "", "Update SigChe")
								loc_lProsseguir = .F.
								EXIT
							ENDIF

							*-- Parcela correspondente volta a ficar em aberto.
							loc_cSQL = "SELECT TOP 1 cidchaves FROM SigMvPar" + ;
								" WHERE empdopnums = " + EscaparSQL(par_cOperacao) + ;
								" AND bancos + agencias + contas + numeros = " + ;
								EscaparSQL(loc_cCheque)

							IF !THIS.ExecutarConsulta(loc_cSQL, loc_cCurParChq, "CrPar 4")
								loc_lProsseguir = .F.
								EXIT
							ENDIF

							SELECT (loc_cCurParChq)
							GO TOP

							IF !EOF()
								loc_cSQL = "UPDATE SigMvPar SET vpags = 0," + ;
									" pagos = " + EscaparSQL("1") + ;
									", dtalts = GETDATE()" + ;
									" WHERE cidchaves = " + ;
									EscaparSQL(NVL(&loc_cCurParChq..cidchaves, ""))

								IF !THIS.ExecutarConsulta(loc_cSQL, "", "Update SigMvPar")
									loc_lProsseguir = .F.
									EXIT
								ENDIF
							ENDIF
						ENDIF
					ENDIF

					SELECT (loc_cCurChm)
				ENDSCAN
			ENDIF

			THIS.FecharCursor(loc_cCurChm)
			THIS.FecharCursor(loc_cCurOutras)
			THIS.FecharCursor(loc_cCurChe)
			THIS.FecharCursor(loc_cCurParChq)
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.DesfazerCheques")
			loc_lProsseguir = .F.
		ENDTRY

		RETURN loc_lProsseguir
	ENDFUNC

	*====================================================================
	* ArquivarCheque - move a linha de SigChe para SigExChq (cheques
	* excluidos) e apaga a original, equivalente ao
	* "insert into crSigExChq (...) values (crche....) + Delete From
	* SigChe Where Nums = ..." do Delecao legado. Vai num lote
	* transacional porque o arquivamento e a exclusao tem de valer
	* juntos - se o INSERT falhar, o cheque NAO pode ser apagado.
	*====================================================================
	PROTECTED FUNCTION ArquivarCheque(par_cCursorChe)
		LOCAL loc_cSQL, loc_cNums

		loc_cNums = PADR(NVL(&par_cCursorChe..nums, ""), 8)

		TEXT TO loc_cSQL TEXTMERGE NOSHOW PRETEXT 7
			INSERT INTO SigExChq
			    (agencias, bancos, vencs, ncheques, ncontas, nums,
			     umovs, valors, contas, grupos, iclis, autos,
			     datatrans, emps, notas, usuars, dataexcls, cidchaves)
			SELECT agencias, bancos, vencs, ncheques, ncontas, nums,
			     umovs, valors, contas, grupos, iclis, autos,
			     GETDATE(), emps, notas,
			     <<EscaparSQL(PADR(gc_4c_UsuarioLogado, 10))>>,
			     GETDATE(), <<EscaparSQL(LEFT(fUniqueIds(), 20))>>
			  FROM SigChe
			 WHERE nums = <<EscaparSQL(loc_cNums)>>;
			DELETE FROM SigChe WHERE nums = <<EscaparSQL(loc_cNums)>>;
		ENDTEXT

		RETURN THIS.ExecutarLoteTransacional(loc_cSQL, "Arquivar/Delete SigChe")
	ENDFUNC

	*====================================================================
	* ContarSelecionadas - quantas operacoes estao marcadas na grade.
	* Equivalente ao "Select Dopes From csOperacoes Where SelImp Into
	* Cursor csSel / If (RecCount('csSel') < 1)" do Processamento
	* legado. COUNT TO precisa do alias selecionado - a forma
	* "COUNT TO <var> IN <alias>" nao existe em VFP9.
	*====================================================================
	PROCEDURE ContarSelecionadas()
		LOCAL loc_nTotal

		loc_nTotal = 0

		IF USED(THIS.this_cCursorOperacoes)
			SELECT (THIS.this_cCursorOperacoes)
			COUNT TO loc_nTotal FOR SelImp
		ENDIF

		RETURN loc_nTotal
	ENDPROC

	*====================================================================
	* ProcessoEhFranquia - o Processo de Copia esta configurado em modo
	* FRANQUIA quando algum item dele esta SEM Documento de Destino
	* (SigPcOoI.DopeDs vazio). Equivalente ao
	* "Go Top In csCpOri / Locate For Empty(csCpOri.DopeDs) /
	* If Not Eof([csCpOri])" do Processamento legado, que nesse caso
	* chama ThisForm.Financeiro em vez de copiar a movimentacao.
	*====================================================================
	PROTECTED FUNCTION ProcessoEhFranquia(par_cCursorItens)
		LOCAL loc_lFranquia

		loc_lFranquia = .F.

		IF USED(par_cCursorItens)
			SELECT (par_cCursorItens)
			GO TOP
			LOCATE FOR EMPTY(NVL(dopeds, ""))
			loc_lFranquia = !EOF()
			GO TOP
		ENDIF

		RETURN loc_lFranquia
	ENDFUNC

	*====================================================================
	* Processamento - acao do botao "Copiar": executa o Processo de
	* Copia sobre as operacoes marcadas na grade. Equivalente ao
	* "PROCEDURE processamento" do legado (dump:5650-9938).
	*
	* Fluxo do legado, reproduzido aqui na mesma ordem:
	*   1. cria os cursores de trabalho (crTransferidos, csApagarOri,
	*      csImpressao, crProducao);
	*   2. recusa seguir se NENHUMA operacao esta marcada;
	*   3. le os itens do Processo de Copia (SigPcOoI) com o Documento
	*      de Destino de cada um;
	*   4. ALGUM item sem Documento de Destino -> modo FRANQUIA: a tela
	*      lanca apenas o financeiro, via Financeiro();
	*   5. caso contrario -> copia a movimentacao inteira para cada
	*      destino configurado;
	*   6. no fim: apaga as operacoes de origem marcadas para exclusao,
	*      recalcula saldos, imprime o documento (quando o processo pede)
	*      e devolve a tela ao estado inicial.
	*
	* ESTADO DESTA FASE (8/8) - o que esta pronto e o que falta:
	*
	*   PRONTO: os passos 1 a 4 e 6, e com eles o modo FRANQUIA
	*   COMPLETO - que e um dos dois caminhos do botao Copiar. Tambem
	*   estao prontos e usados por este metodo: Selecionar(),
	*   CopiarFiscais(), CopiarLogs(), AcertaEmpDopNums(), Delecao(),
	*   Casamento(), FazContra(), GerCodigoP(), AjustaPesos(),
	*   LancaClientes(), LancaTabDescto(), GarantirCadastroNoDestino() e
	*   a gravacao do mapeamento/log (SigPcOnp/SigPcOoL).
	*
	*   FALTA: o passo 5 - a copia item a item da movimentacao. No
	*   legado ele mora em tres metodos que ainda NAO foram transcritos:
	*   LancaProduto (dump:3580-5220, 1641 linhas), LancaProdutoF
	*   (dump:5221-5581, 361 linhas) e LancaProducao (dump:2959-3579,
	*   621 linhas), alem do laco de destinos do proprio Processamento
	*   (dump:5810-9700). Sao ~6.900 linhas que gravam SigMvCab/
	*   SigMvItn/SigMvIts/SigMvHst/SigMvNfi/SigMvPar/SigMvCcr/SigOpEtq
	*   e o cadastro de produto do destino, cada tabela com dezenas de
	*   variantes por flag do Processo de Copia.
	*
	*   Enquanto esse passo nao estiver transcrito, este metodo RECUSA o
	*   caminho de copia de movimentacao ANTES de gravar qualquer coisa,
	*   com mensagem que diz exatamente o que falta. A recusa e
	*   deliberada e preferivel as duas alternativas: gravar pela
	*   metade (deixaria movimentacao incompleta em producao, entre
	*   empresas) ou inventar a logica de copia sem o dump (regra
	*   CLAUDE.md #17 - formula/regra do legado se TRANSCREVE, nunca se
	*   reescreve).
	*
	* NOTA DE ARQUITETURA (vale para todo este BO): o legado abria uma
	* conexao fisica POR EMPRESA DE DESTINO (fSqlConector sobre
	* SigCdLoc.cIdConns, porque cada empresa tinha seu proprio conjunto
	* de .DBF) e escrevia em cursores "Des*" que eram enviados ao
	* destino por Update + Commit. Aqui existe UM SQL Server
	* (gnConnHandle) e a empresa e a coluna Emps/EmpDs (PILAR 2): a
	* gravacao e INSERT direto, e a copia de CADASTRO para o destino
	* deixa de existir porque origem e destino sao a mesma tabela.
	*====================================================================
	PROCEDURE Processamento()
		LOCAL loc_cCurItens, loc_cSQL, loc_nSelecionadas
		LOCAL loc_lProsseguir, loc_lSucesso, loc_oErro

		loc_lSucesso    = .F.
		loc_lProsseguir = .T.

		loc_cCurItens = THIS.this_cCursorProcOrigens

		TRY
			*-- 1. Cursores de trabalho do processamento.
			THIS.CriarCursoresProcessamento()

			*-- 2. Alguma operacao marcada?
			loc_nSelecionadas = THIS.ContarSelecionadas()

			IF loc_nSelecionadas < 1
				MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado", "")
				loc_lProsseguir = .F.
			ENDIF

			*-- 3. Itens do Processo de Copia, com o Documento de Destino.
			IF loc_lProsseguir
				loc_cSQL = "SELECT DISTINCT emps, dopes, codigos, dopeds" + ;
					" FROM SigPcOoI" + ;
					" WHERE processos = " + EscaparSQL(PADR(THIS.this_cProcesso, 20)) + ;
					" ORDER BY emps, dopes, codigos"

				loc_lProsseguir = THIS.ExecutarConsulta(loc_cSQL, loc_cCurItens, "csCpOri")
			ENDIF

			IF loc_lProsseguir AND !USED(THIS.this_cCursorDestinos)
				loc_lProsseguir = THIS.CarregarDestinos()
			ENDIF

			IF loc_lProsseguir
				IF THIS.ProcessoEhFranquia(loc_cCurItens)
					*-- 4. Modo FRANQUIA: so o financeiro.
					loc_lSucesso = THIS.Financeiro()
				ELSE
					*-- 5. Copia da movimentacao - ver "ESTADO DESTA FASE".
					loc_lSucesso = THIS.CopiarMovimentacoes()
				ENDIF
			ENDIF

			*-- 6. Fecho comum aos dois caminhos: exclusao das origens
			*-- marcadas, recalculo geral e impressao do documento.
			IF loc_lSucesso
				loc_lSucesso = THIS.ApagarOperacoesOrigem()
			ENDIF

			IF loc_lSucesso
				THIS.ImprimirDocumentos()
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.Processamento")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CriarCursoresProcessamento - os quatro cursores de trabalho que o
	* Processamento legado cria no inicio (dump:5664-5683), com as
	* MESMAS colunas e os MESMOS indices:
	*
	*   crTransferidos - de/para das operacoes copiadas
	*   csApagarOri    - chaves das operacoes de origem a apagar no fim
	*   csImpressao    - linhas do documento a imprimir
	*   crProducao     - O.P. a finalizar automaticamente (Globalizas 4)
	*====================================================================
	PROTECTED PROCEDURE CriarCursoresProcessamento()
		IF USED("crTransferidos_4c")
			USE IN crTransferidos_4c
		ENDIF
		CREATE CURSOR crTransferidos_4c ;
			(EmpDopNums C(29), EmpDs C(3), DopeDs C(20), NumDs N(6, 0))
		INDEX ON EmpDopNums + EmpDs + DopeDs TAG skGroup1
		INDEX ON EmpDopNums + DopeDs TAG skGroup2

		IF USED("csApagarOri_4c")
			USE IN csApagarOri_4c
		ENDIF
		CREATE CURSOR csApagarOri_4c (Chave C(29))
		INDEX ON Chave TAG Chave

		IF USED("csImpressao_4c")
			USE IN csImpressao_4c
		ENDIF
		CREATE CURSOR csImpressao_4c ;
			(Processos C(20), Drives C(40), Datas D, Emps C(3), Emps1 C(3), ;
			 Dopes C(20), Numes N(6, 0), Notas C(6), AntCPros C(14), ;
			 AntDPros C(40), EmpDs C(3), EmpDs1 C(3), DopeDs C(20), ;
			 NumeDs N(6, 0), CPros C(14), DPros C(40), Pesos N(9, 2), ;
			 Qtde N(9, 2), Valos N(12, 2), CGrus C(3), ContEsts N(1))
		INDEX ON Processos + Drives + DTOS(Datas) + Emps + Dopes + ;
			STR(Numes, 6) + EmpDs + DopeDs + STR(NumeDs, 6) TAG Processos

		IF USED("crProducao_4c")
			USE IN crProducao_4c
		ENDIF
		CREATE CURSOR crProducao_4c ;
			(EmpOs C(3), DopeOs C(20), NumeOs N(6, 0), Nops N(10, 0), ;
			 codcors C(4), codtams C(4), Cbars N(14, 0), ;
			 QtdOps N(9, 2), QtdFinal N(9, 2))
		INDEX ON STR(Nops, 10) + Cbars TAG Nops
		INDEX ON Cbars TAG Cbars
	ENDPROC

	*====================================================================
	* CopiarMovimentacoes - passo 5 do Processamento: copia a
	* movimentacao inteira (cabecalho, itens, grade de cor/tamanho,
	* historico de estoque, nota fiscal, parcelas, lancamentos de conta,
	* etiquetas, cheques e producao) de cada operacao marcada para cada
	* destino configurado no Processo de Copia.
	*
	* FORA DO ESCOPO DESTA FASE - e a recusa e deliberada, nao um
	* esquecimento. O que falta transcrever do dump do legado:
	*
	*   dump:5810-9700  laco de destinos x operacoes do Processamento
	*   dump:3580-5220  LancaProduto   (1641 linhas)
	*   dump:5221-5581  LancaProdutoF  ( 361 linhas)
	*   dump:2959-3579  LancaProducao  ( 621 linhas)
	*
	* Sao cerca de 6.900 linhas que gravam oito tabelas de movimento
	* mais o cadastro de produto do destino, com dezenas de variantes
	* comandadas pelas flags do item do processo (Agrupar, NovoCods,
	* CorTams, MoeVals, Custos, Impostos, Barras, Mccrs, Cheques,
	* Delets, DesItens, MontaObs, ChkCons, MantemMats, MantDPros,
	* PctCopias, PctComps, SemItens, OpItens, Globalizas...).
	*
	* Por que recusar em vez de entregar uma parte: esta rotina move
	* ESTOQUE e FINANCEIRO entre empresas. Gravar o cabecalho sem os
	* itens, ou os itens sem o historico, deixaria movimentacao
	* incompleta no banco de producao - estrago maior e mais dificil de
	* desfazer do que a tela recusar a operacao. E preencher as
	* variantes sem o dump seria reescrever regra de negocio, que a
	* regra CLAUDE.md #17 proibe expressamente.
	*
	* A recusa acontece ANTES de qualquer gravacao: nada e escrito, a
	* selecao da grade permanece intacta e o usuario pode continuar
	* usando o modo FRANQUIA (que esta completo) e a selecao/consulta.
	*====================================================================
	PROTECTED FUNCTION CopiarMovimentacoes()
		MsgErro("A c" + CHR(243) + "pia da MOVIMENTA" + CHR(199) + CHR(195) + "O ainda n" + CHR(227) + ;
			"o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o." + CHR(13) + CHR(13) + ;
			"O Processo de C" + CHR(243) + "pia [" + ALLTRIM(THIS.this_cProcesso) + "] est" + CHR(225) + ;
			" configurado para copiar a movimenta" + CHR(231) + CHR(227) + "o completa" + CHR(13) + ;
			"(cabe" + CHR(231) + "alho, itens, hist" + CHR(243) + "rico de estoque, nota fiscal, parcelas," + CHR(13) + ;
			"lan" + CHR(231) + "amentos de conta, etiquetas, cheques e produ" + CHR(231) + CHR(227) + "o)." + CHR(13) + CHR(13) + ;
			"NADA foi gravado - a opera" + CHR(231) + CHR(227) + "o foi recusada ANTES de qualquer" + CHR(13) + ;
			"grava" + CHR(231) + CHR(227) + "o, para n" + CHR(227) + "o deixar movimenta" + CHR(231) + CHR(227) + ;
			"o pela metade no banco." + CHR(13) + CHR(13) + ;
			"Dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o: a sele" + CHR(231) + CHR(227) + ;
			"o de opera" + CHR(231) + CHR(245) + "es e o modo" + CHR(13) + ;
			"FRANQUIA (Processo de C" + CHR(243) + "pia sem Documento de Destino, que lan" + CHR(231) + "a" + CHR(13) + ;
			"apenas o financeiro).", ;
			"C" + CHR(243) + "pia de Movimenta" + CHR(231) + CHR(227) + "o indispon" + CHR(237) + "vel")

		RETURN .F.
	ENDFUNC

	*====================================================================
	* ApagarOperacoesOrigem - fecho do Processamento legado
	* (dump:9708-9900): para cada chave acumulada em csApagarOri,
	* recalcula o saldo das contas movimentadas, apaga os lancamentos
	* financeiros e, em seguida, a operacao de origem nas demais
	* tabelas. Depois roda o recalculo geral de saldos.
	*
	* A lista de tabelas e a ORDEM sao as do legado, que difere da lista
	* do Delecao (este fecho nao mexe em cheques nem em SigMvHst, que
	* ja foram tratados antes).
	*
	* Com csApagarOri vazio - o caso normal quando o Processo de Copia
	* nao pede exclusao da origem - o metodo nao faz nada e devolve .T.
	*====================================================================
	PROTECTED FUNCTION ApagarOperacoesOrigem()
		LOCAL loc_cChave, loc_cSQL, loc_cCurMccr, loc_cEmp, loc_cDop
		LOCAL loc_nNum, loc_lProsseguir, loc_oErro

		loc_lProsseguir = .T.
		loc_cCurMccr    = "cursor_4c_ApagaMccr"

		TRY
			*-- Sem chave acumulada nao ha exclusao a fazer (caso normal
			*-- quando o processo nao pede exclusao da origem). RETURN nao
			*-- pode sair de dentro do TRY (regra CLAUDE.md #1) - o corpo
			*-- inteiro fica sob o IF.
			IF USED("csApagarOri_4c") AND RECCOUNT("csApagarOri_4c") > 0
			SELECT csApagarOri_4c
			GO TOP
			SCAN
				loc_cChave = PADR(NVL(csApagarOri_4c.Chave, ""), 29)

				loc_cEmp = SUBSTR(loc_cChave, 1, 3)
				loc_cDop = SUBSTR(loc_cChave, 4, 20)
				loc_nNum = INT(VAL(SUBSTR(loc_cChave, 24, 6)))

				*-- Saldos das contas movimentadas, antes de apagar.
				loc_cSQL = "SELECT grupos, contas, datas, moedas, cidchaves," + ;
					" sgrupos, scontas, smoedas FROM SigMvCcr" + ;
					" WHERE empdopnums = " + EscaparSQL(loc_cChave) + ;
					" ORDER BY grupos, contas, datas, moedas, cidchaves," + ;
					" sgrupos, scontas, smoedas"

				IF !THIS.ExecutarConsulta(loc_cSQL, loc_cCurMccr, "csMccr")
					loc_lProsseguir = .F.
					EXIT
				ENDIF

				SELECT (loc_cCurMccr)
				GO TOP
				SCAN
					fRecalculaS(NVL(&loc_cCurMccr..grupos, ""), NVL(&loc_cCurMccr..contas, ""), ;
						ConverterParaData(&loc_cCurMccr..datas), NVL(&loc_cCurMccr..moedas, ""), ;
						gnConnHandle)

					fRecalculaS(NVL(&loc_cCurMccr..sgrupos, ""), NVL(&loc_cCurMccr..scontas, ""), ;
						ConverterParaData(&loc_cCurMccr..datas), NVL(&loc_cCurMccr..smoedas, ""), ;
						gnConnHandle)

					SELECT (loc_cCurMccr)
				ENDSCAN

				loc_lProsseguir = ;
					THIS.ApagarPorOperacao("SigMvCcr", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigMvCpv", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigOpEtq", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigMvNfi", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigMvIts", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigExMvc", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigMvCab", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigMvItn", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigMvPar", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigMvMov", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigCdCmm", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigCdPbx", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigCdCar", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigCdCtt", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigCdCrd", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigCdPgc", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigPrTtl", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigCdPit", "empdopnums", loc_cChave) AND ;
					THIS.ApagarPorOperacao("SigCdPgr", "empdopnums", loc_cChave)

				IF !loc_lProsseguir
					MsgErro("Problemas com a Opera" + CHR(231) + CHR(227) + "o :" + CHR(13) + ;
						"Empresa : " + loc_cEmp + " - Opera" + CHR(231) + CHR(227) + "o : " + ALLTRIM(loc_cDop) + ;
						" - C" + CHR(243) + "digo : " + ALLTRIM(STR(loc_nNum)) + CHR(13) + ;
						"Contate o Suporte T" + CHR(233) + "cnico Com os C" + CHR(243) + "digos Acima", ;
						"Erro na Dele" + CHR(231) + CHR(227) + "o")
					EXIT
				ENDIF

				SELECT csApagarOri_4c
			ENDSCAN

			*-- Recalculo geral de saldos no fim do lote, como no legado.
			IF loc_lProsseguir
				*-- Forma de LOTE do fRecalculaS (1o argumento logico): o handle
				*-- vai na 5a posicao (pCnx), que eh onde a funcao o le - no
				*-- legado a conexao era um OBJETO no 2o argumento.
				fRecalculaS(.T., "", {}, "", gnConnHandle)
			ENDIF

			THIS.FecharCursor(loc_cCurMccr)
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.ApagarOperacoesOrigem")
			loc_lProsseguir = .F.
		ENDTRY

		RETURN loc_lProsseguir
	ENDFUNC

	*====================================================================
	* ImprimirDocumentos - abre o documento de transferencia no fim do
	* processamento, quando o Processo de Copia pede impressao
	* (SigPcOoP.Imprimir <> 2) e ha linha em csImpressao. Equivalente ao
	* "If llImp / If (Reccount('csImpressao') > 0) / Do Form SigMvDoc
	* With 'SigMvDop', 'Impressao da Transferencia'" do legado.
	*
	* DIVERGENCIA documentada: o form migrado FormSIGMVDOC nao recebe
	* parametros no Init (o legado passava o nome do relatorio e o
	* titulo). Ele e aberto sem argumentos; o relatorio e o titulo
	* passam a ser os do proprio form migrado.
	*====================================================================
	PROTECTED PROCEDURE ImprimirDocumentos()
		LOCAL loc_cCurProc, loc_oForm, loc_lImprimir, loc_oErro

		loc_cCurProc = THIS.this_cCursorProcessoAtual
		loc_lImprimir = .F.

		TRY
			*-- RETURN nao pode sair de dentro do TRY (regra CLAUDE.md #1):
			*-- as condicoes de saida viram uma flag.
			IF USED(loc_cCurProc) AND USED("csImpressao_4c")
				SELECT (loc_cCurProc)
				GO TOP

				loc_lImprimir = !EOF() AND NVL(&loc_cCurProc..imprimir, 0) <> 2 ;
					AND RECCOUNT("csImpressao_4c") > 0

				IF loc_lImprimir AND TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
					loc_lImprimir = .F.
				ENDIF
			ENDIF

			IF loc_lImprimir
				SELECT csImpressao_4c
				GO TOP

				GarantirClasse("FormSIGMVDOC")

				loc_oForm = CREATEOBJECT("FormSIGMVDOC")
				IF VARTYPE(loc_oForm) = "O"
					loc_oForm.Show()
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "sigoppopBO.ImprimirDocumentos")
		ENDTRY
	ENDPROC
ENDDEFINE

