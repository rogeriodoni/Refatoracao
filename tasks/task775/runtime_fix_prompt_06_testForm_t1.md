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
[2026-11-10 00:58:19] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-10 00:58:19] [INFO] Config FPW: (nao fornecido)
[2026-11-10 00:58:19] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-10 00:58:19] [INFO] Timeout: 300 segundos
[2026-11-10 00:58:19] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2vtkusdc.prg
[2026-11-10 00:58:19] [INFO] Conteudo do wrapper:
[2026-11-10 00:58:19] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpOco', 'C:\4c\tasks\task775\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpOco', 'C:\4c\tasks\task775\logs\06_testForm.log'
QUIT

[2026-11-10 00:58:19] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2vtkusdc.prg
[2026-11-10 00:58:19] [INFO] VFP output esperado em: C:\4c\tasks\task775\vfp_output.txt
[2026-11-10 00:58:19] [INFO] Executando Visual FoxPro 9...
[2026-11-10 00:58:19] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2vtkusdc.prg
[2026-11-10 00:58:19] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2vtkusdc.prg
[2026-11-10 00:58:19] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpOco
Inicio: 10/11/2026 00:58:20

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 10/11/2026 00:59:26
Duracao: 66 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-10 00:59:26] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-10 00:59:26] [INFO] VFP9 finalizado em 66.8867718 segundos
[2026-11-10 00:59:26] [INFO] Exit Code: 
[2026-11-10 00:59:26] [INFO] 
[2026-11-10 00:59:26] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-10 00:59:26] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2vtkusdc.prg
[2026-11-10 00:59:26] [INFO] 
[2026-11-10 00:59:26] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-10 00:59:26] [INFO] * Auto-generated wrapper for parameters
[2026-11-10 00:59:26] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-10 00:59:26] [INFO] * Parameters: 'FormSigOpOco', 'C:\4c\tasks\task775\logs\06_testForm.log'
[2026-11-10 00:59:26] [INFO] 
[2026-11-10 00:59:26] [INFO] * Anti-dialog protections for unattended execution
[2026-11-10 00:59:26] [INFO] SET SAFETY OFF
[2026-11-10 00:59:26] [INFO] SET RESOURCE OFF
[2026-11-10 00:59:26] [INFO] SET TALK OFF
[2026-11-10 00:59:26] [INFO] SET NOTIFY OFF
[2026-11-10 00:59:26] [INFO] SYS(2335, 0)
[2026-11-10 00:59:26] [INFO] 
[2026-11-10 00:59:26] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpOco', 'C:\4c\tasks\task775\logs\06_testForm.log'
[2026-11-10 00:59:26] [INFO] QUIT
[2026-11-10 00:59:26] [INFO] 
[2026-11-10 00:59:26] [INFO] === Fim do Wrapper.prg ===
[2026-11-10 00:59:26] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpOco.prg):
*==============================================================================
* FormSigOpOco.prg
* Form Operacional: Ocorrencia (lancamento de ocorrencia na leitura de balanco)
* Herda de: FormBase
* Tipo: OPERACIONAL - layout FLAT (o SCX legado NAO tem PageFrame nem Page)
* SCX Origem: SigOpOco.SCX  (tasks\task775\SigOpOco_form_codigo_fonte.txt)
* BO:         SigOpOcoBO    (projeto\app\classes\SigOpOcoBO.prg)
*
* Dialogo MODAL (WindowType = 1, TitleBar = 0, ControlBox/Closable = .F.)
* aberto pela tela de contagem de inventario para o usuario informar a
* OCORRENCIA, a OBSERVACAO e o PESO REAL da etiqueta recem-lida.
*
*------------------------------------------------------------------------------
* CONTRATO EXTERNO - o alias "Historico" eh do form CHAMADOR
*
* O "PROCEDURE Init" do SCX legado recebe seis parametros e, sem abrir cursor
* nenhum, apenas se POSICIONA num alias que ja esta aberto:
*
*     LParameters lcCodBarra, oOldForm, llRepete, lcObs, lnTop, lnLeft
*     ...
*     Select Historico
*     Set Order To CBars
*     Set Key To lcCodBarra
*     Go Top
*
* Esse alias eh montado pelo form PAI (SIGCDBAL, migrado como FormBAL) com
* AddCursor sobre SigIvTrH. No sistema novo ele se chama "cursor_4c_Historico"
* e nasce em FormBAL.CarregarGradeLeitura() (forms\cadastros\FormBAL.prg:3396).
* Dai tres consequencias que valem para o form INTEIRO:
*
*   (a) DataSession = 1 (sessao CORRENTE), igual ao SCX. Trocar para 2 daria
*       sessao privada e o cursor do chamador ficaria INVISIVEL aqui.
*   (b) Destroy() NAO fecha cursor_4c_Historico - quem abriu eh o chamador, e
*       fechar o alias de outro form deixaria a grade dele morta.
*   (c) o nome do alias chega por propriedade (this_cCursorHistorico), nunca
*       literal espalhado pelo codigo - mesmo contrato que SigOpOcoBO (Fases
*       1-2) ja documenta no proprio cabecalho.
*
* E o form tem de TOLERAR o alias ausente: o harness de teste
* (automation\vfp_helpers\TestFormWrapper.prg) faz CREATEOBJECT(classe) SEM
* chamador nenhum, logo sem cursor. Nenhuma guarda deste arquivo devolve .F.
* por falta do cursor - InicializarForm que devolve .F. MATA a tela.
*
*------------------------------------------------------------------------------
* PARAMETROS DO Init - capturados SEM validacao que reprove
*
* O harness chama CREATEOBJECT("FormSigOpOco") sem argumento algum. Em VFP9
* parametro nao passado chega como .F. LOGICO, entao cada um eh lido com
* guarda de VARTYPE (e PCOUNT no logico, cujo tipo do ausente coincide com o
* tipo esperado). NAO existe aqui o bloco "MsgErro + .F." de parametro
* obrigatorio: ele reprovaria SEMPRE a etapa 06_testForm, com a propria
* mensagem de validacao aparecendo como se fosse bug de logica.
*
*------------------------------------------------------------------------------
* POSICIONAMENTO DA JANELA - transcrito LITERALMENTE, inclusive a anomalia
*
* O legado faz
*
*     ThisForm.Top  = lnTop + 22
*     ThisForm.Left = lnTop + 390        && <-- lnTop, NAO lnLeft
*
* A segunda linha usa lnTop nas DUAS coordenadas. Parece erro de digitacao do
* legado, mas eh o posicionamento que o usuario ve hoje, e "formula do legado
* se TRANSCREVE, nunca se reescreve": corrigir para lnLeft mudaria o lugar em
* que a janela aparece (PILAR 1). Fica transcrito como esta, com o desvio
* registrado aqui para quem for revisar.
*
* Por isso AutoCenter = .F. na classe (FormBase declara .T.): AutoCenter age
* no Show e SOBRESCREVERIA o Top/Left calculado. Sem chamador - harness, ou
* abertura sem as coordenadas - o form cai no AutoCenter, para nao nascer
* encavalado no canto 0,0.
*
*------------------------------------------------------------------------------
* LAYOUT FLAT - por que NAO ha PageFrame aqui
*
* A arvore de objetos do dump tem o objeto raiz como "Class: form / BaseClass:
* form" (form GENERICO, nao frmcadastro nem frmrelatorio) e NENHUMA linha
* "BaseClass: pageframe". Os 19 objetos penduram direto na Form ou no
* container do cabecalho. Criar PageFrame com Page1 (Lista) e Page2 (Dados)
* aqui seria inventar estrutura que o legado nao tem - viola o PILAR 1 e a
* regra "NUNCA inventar". Sem PageFrame tambem NAO existe a compensacao de
* +29 no Top: todas as coordenadas vao CRUAS do SCX.
*
*------------------------------------------------------------------------------
* FASE 3/8 - ESTRUTURA BASE (o que este arquivo entrega)
*   - DEFINE CLASS FormSigOpOco AS FormBase + propriedades visuais transcritas
*     do SCX (665x323, BorderStyle 2, TitleBar = 0, ControlBox/Closable/
*     MaxButton/MinButton = .F., ClipControls = .F., WindowType = 1,
*     DataSession = 1, AutoCenter = .F.)
*   - Init() - captura os seis parametros do chamador e aplica o Top/Left
*   - InicializarForm() - fundo do form (Picture new_background.jpg), criacao
*     do Business Object, repasse dos parametros ao BO, montagem da faixa do
*     cabecalho e posicionamento do cursor do chamador
*   - ConfigurarCabecalho() - cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo
*     (mapeamento.json: cntSombra -> cnt_4c_Sombra, lblSombra ->
*     lbl_4c_LblSombra, lblTitulo -> lbl_4c_LblTitulo)
*   - PosicionarHistorico() - o "Select Historico / Set Order To CBars /
*     Set Key To lcCodBarra / Go Top" do Init legado
*   - TornarControlesVisiveis() recursivo (AddObject cria tudo Visible = .F.)
*   - Destroy() - libera o BO e devolve o controle ao FormBase via DODEFAULT()
*
*   A faixa do cabecalho eh o PRIMEIRO AddObject do form (regra #11): o botao
*   de saida do legado fica em Top = 3, DENTRO da area da faixa (Top 0..80), e
*   precisa ser criado DEPOIS dela para desenhar por cima.
*
*------------------------------------------------------------------------------
* FASE 4/8 - GRID E BOTAO DE SAIDA (o que esta fase acrescenta)
*
*   Este form eh FLAT (ver "LAYOUT FLAT" acima) - nao ha Page1/Page2 nem
*   PageFrame, entao o roteiro generico "ConfigurarPaginaLista + 6 botoes CRUD"
*   NAO se aplica aqui: o legado SIGOPOCO eh um dialogo modal de lancamento de
*   UMA ocorrencia (nao uma lista de registros com Incluir/Alterar/Excluir), e
*   inventar PageFrame Lista/Dados violaria o PILAR 1 e a regra "NUNCA
*   inventar". MEDIDO no dump deste legado, que eh o que dispensa o ramo
*   paginado: ZERO linha "BaseClass: pageframe" na arvore de objetos, raiz
*   "Class: form / BaseClass: form" (form GENERICO), e a UNICA superficie de
*   lista eh a propria "BaseClass: grid" (SIGOPOCO.Grade) - ha grade, mas nao
*   ha Page nem botao CRUD algum (os 19 objetos do dump sao form +
*   dataenvironment + container do cabecalho + 2 label de titulo + grid com 4
*   coluna/header/textbox + 1 commandbutton de saida + 2 say + 1 editbox).
*   O entregavel real desta fase, ja delimitado no comentario da Fase 3, eh:
*
*   - ConfigurarGrade() - grd_4c_Dados (mapeamento.json: SIGOPOCO.Grade ->
*     grd_4c_Dados), 4 colunas transcritas do dump (Column1 "Barras" e
*     Column2 "Local" ReadOnly; Column3 "Ocorrencia" e Column4 "Peso Real"
*     editaveis - sao os dois campos que esta tela existe para preencher).
*     SO propriedade que NAO depende de dado (regra #41): geometria,
*     ColumnCount, ReadOnly/Movable/Resizable, fontes, cores, InputMask.
*   - VincularGrade() - o bind: RecordSource + os 4 ControlSource (SO quando
*     USED(this_cCursorHistorico) - o alias eh do form CHAMADOR, ver "CONTRATO
*     EXTERNO", e no harness sem chamador ele nao existe; ControlSource de
*     alias ausente estoura "Alias is not found" DENTRO do TRY de
*     InicializarForm e mata a tela inteira, regra #41), e DEPOIS dele as
*     larguras e os Header1.Caption, nesta ordem obrigatoria ColumnCount ->
*     RecordSource -> ControlSource -> Width -> Header1.Caption (regra #41/
*     Problema 48 - o bind RESETA largura e cabecalho, entao os dois tem de
*     ser reaplicados depois, nunca antes).
*   - CarregarDados() - FUNIL UNICO de carga (regra #21), PUBLIC: vincula,
*     posiciona o alias do chamador e REPINTA com "ThisForm.Refresh +
*     ThisForm.Grade.Refresh". Esse par de Refresh eh a transcricao das duas
*     ultimas linhas do Init legado e vinha FALTANDO - defeito real, nao
*     detalhe: o "Set Key To" filtra a visao do alias e trocar ordem/chave NAO
*     repinta a grade ligada a ele, entao sem o Refresh a grade seguia
*     desenhando o conteudo de antes do filtro, sem erro e sem log.
*     InicializarForm passou a chamar este funil no lugar da chamada nua a
*     PosicionarHistorico.
*   - ConfigurarBotaoSaida() - cmd_4c_Saida (mapeamento.json chamava o
*     controle "Sa?da": o Name do legado tem acento, mas identificador VFP
*     referenciado por THIS.<nome> tem de ser ASCII - o Caption, nao o nome
*     do objeto, eh quem leva o CHR(237); regra #4). So geometria/visual
*     aqui: Click fica para a Fase 7-8, junto com o resto dos handlers deste
*     form (nenhum metodo vazio - regra de completude).
*
*------------------------------------------------------------------------------
* FASE 5/8 - LABELS ESTATICOS DA OBSERVACAO (o que esta fase acrescenta)
*
*   Sem Page2/PageFrame neste form (ver "LAYOUT FLAT" acima), o roteiro
*   generico "ConfigurarPaginaDados() com metade dos campos" nao se aplica -
*   os dois controles restantes do dump que NAO dependem de dado nenhum sao
*   os dois labels (mapeamento.json: SIGOPOCO.Say7 -> lbl_4c_Label7,
*   SIGOPOCO.Say1 -> lbl_4c_Label1), entao ficam aqui; o EditBox de observacao
*   (Get_Obs), que tem ControlSource condicionado ao alias do chamador no
*   mesmo padrao de VincularGrade (regra #41), fica para a Fase 6.
*
*   - ConfigurarCamposObservacao() - lbl_4c_Label7 ("Obs : ", Top=195
*     Left=196 Width=31 Height=15) e lbl_4c_Label1 ("Tecle [TAB]  p/ sair da
*     Observacao", Top=283 Left=224 Width=169 Height=15). AutoSize = .F.
*     explicito com os Width/Height do dump (regra #23: AutoSize = .T. eh
*     no-op em Label criado por AddObject). ForeColor = RGB(90, 90, 90)
*     porque o dump NAO declara ForeColor para a classe "say" (regra #12) -
*     o Picture do form (new_background.jpg) nao eh escuro o bastante para
*     justificar branco, e sem essa cor o label fica ilegivel sobre o fundo.
*     Nenhum dos dois se sobrepoe a faixa (Top 0..80), a grade (Top 104..191)
*     nem o botao de saida (Top 3..78), entao a ordem de criacao em relacao a
*     eles eh indiferente.
*
*------------------------------------------------------------------------------
* FASE 6/8 - EDITBOX DE OBSERVACAO (o que esta fase acrescenta)
*
*   Ultimo controle do dump que faltava: o EditBox de observacao
*   (mapeamento.json: SIGOPOCO.Get_Obs -> obj_4c_Get_Obs), classe "fwmemo" do
*   Framework legado (BaseClass editbox). Mesmo padrao de VincularGrade da
*   Fase 4 (regra #41): o ControlSource ("Historico.Obs" no dump) depende do
*   alias do form CHAMADOR, que pode nao existir no instante em que esta
*   tela se constroi (harness sem chamador) - Column.ControlSource/
*   EditBox.ControlSource de alias ausente estoura "Alias is not found"
*   DENTRO do TRY de InicializarForm e mata a tela inteira. Por isso o
*   controle fica dividido em dois metodos, no mesmo padrao da grade:
*
*   - ConfigurarCampoObservacao() - AddObject + geometria/fonte do dump
*     (FontName="Arial", FontSize=8, Top=195 Left=222 Width=195 Height=87).
*     SO propriedade que NAO depende de dado (regra #41). Top=195 nao disputa
*     z-order com a faixa (0..80), a grade (104..191) nem o botao de saida
*     (3..78).
*   - VincularObservacao() - o bind condicionado a USED(alias), chamado pelo
*     mesmo funil de carga que religa a grade (CarregarDados - regra #21),
*     para repetir sempre que o alias aparecer. Fiel ao legado mesmo a
*     coluna "obs" ainda nao chegando no SELECT do FormBAL hoje - ver
*     "LACUNA REAL DO CONTRATO" acima. Nao se inventa coluna aqui.
*
*   E o LOOKUP, que eh a outra metade desta fase. O unico do form esta no
*   Valid de SIGOPOCO.Grade.Column3.Text1 (coluna Ocorrencia) e consulta
*   SigBaOco - identificado no dump pelo "CreateObject(fwBuscaInt, CsOcorr,
*   ...)". Ele NAO pode ser ligado por BINDEVENT nem validado em
*   AfterRowColChange: BINDEVENT em Valid de TextBox dentro de Column nao
*   dispara de forma confiavel E descartaria o valor de retorno (o legado
*   devolve .F. para prender o foco na celula quando a consulta falha), e o
*   nColIndex de AfterRowColChange eh a coluna de DESTINO, entao sair da
*   Column3 entregaria 4 e o lookup nunca rodaria (regras #3 e #46). Por isso
*   ele vira CONTROLE DE CELULA, no padrao canonico do FormLpr:
*
*   - TextBoxOcorrenciaOco_4c (DEFINE CLASS no fim deste arquivo) - Valid e
*     LostFocus embutidos, delegando a metodos PUBLIC do form.
*   - InstalarCelulaOcorrencia() - AddObject + CurrentControl + Sparse = .F.
*     + Visible (regra #18: AddObject sozinho NAO faz o controle aparecer).
*     Chamado no FIM de VincularGrade e idempotente, porque o ColumnCount de
*     la recria os objetos Column e destroi o que foi posto neles.
*   - ValidarOcorrenciaGrade() / ...Exec() - wrapper com guarda de
*     reentrancia (o picker eh modal e redispara o Valid) + corpo. O valor
*     digitado eh lido do CONTROLE, nunca do cursor (regra #46). A consulta,
*     os indices e o Seek ficam no BO (PopularOcorrencias/ValidarOcorrencia).
*   - AbrirBuscaOcorrencia() - o browse. O "fwBuscaInt" do legado busca em
*     cursor LOCAL ja populado, entao o equivalente eh a API
*     DefinirCursor/Mostrar do FormBuscaAuxiliar - e NAO o Init com
*     parametros, que faria um SQLEXEC proprio contra a TABELA e duplicaria a
*     consulta que o BO ja fez (regra #36/#37). Nao achar o codigo NAO eh
*     erro: abre o browse sem MsgAviso e sem apagar o digitado (regra #50) -
*     a unica limpeza eh no ESC, que eh o que o legado faz.
*
*   Com o campo de observacao na tela, os handlers DELE tambem entram aqui -
*   eles sao o que faz o campo funcionar, nao decoracao de fase seguinte:
*
*   - PodeEditarObservacao() - When do Get_Obs, embutido na classe
*     EditBoxObsOco_4c porque GOVERNA a edicao (so libera o campo com a
*     Ocorrencia preenchida) e BINDEVENT descartaria o retorno (regra #3).
*     Transcreve as DUAS metades: o auto-preenchimento com a observacao
*     anterior quando "repete obs" esta ligado, e o retorno.
*   - ObservacaoLostFocus() - Valid E LostFocus do Get_Obs num handler so,
*     ligado por BINDEVENT "LostFocus" (os dois rodam ao sair do campo e
*     nenhum depende de retorno). Preserva o GUARD que os separa:
*     ObsAnterior do chamador so muda com a observacao PREENCHIDA, enquanto
*     this_cObservas eh gravada sempre.
*   - FocarObservacao() / FocarPesoReal() - os dois SetFocus de navegacao que
*     o legado tem no LostFocus da celula Ocorrencia e no do Get_Obs.
*
* O QUE NAO ENTRA NESTA FASE (por desenho do pipeline)
*   - Click da saida ("ThisForm.Release") ....................... Fase 7
*   - Valid da coluna Peso Real ("KeyBoard {DNARROW}") e o AfterRowColChange
*     da grade ("ThisForm.Get_Obs.Refresh") ..................... Fase 8
*
*   Nenhum desses metodos aparece aqui nem como stub: metodo vazio eh proibido
*   pela regra de completude, e declarar chamada a metodo inexistente estoura
*   em RUNTIME com "Property X is not found" (regra #13).
*
*------------------------------------------------------------------------------
* FASE 7/8 - EVENTO DO BOTAO (o que esta fase acrescenta)
*
*   Esta fase porta os "eventos principais dos botoes". O roteiro generico
*   pede os quatro handlers CRUD da barra do frmcadastro, e eles NAO existem
*   neste form - nem como stub. MEDIDO no dump deste legado (629 linhas): UM
*   unico objeto com "BaseClass: commandbutton" (SIGOPOCO."Sa" + CHR(237) +
*   "da"), ZERO linha "BaseClass: commandgroup", e NENHUMA citacao de
*   "frmcadastro", "Grupo_Op" ou "pcEscolha" - este dialogo nao herda nem
*   declara barra CRUD. Portar os quatro obrigaria a INVENTAR botoes que o
*   legado nao tem (viola o PILAR 1 e a regra "NUNCA inventar") ou a declarar
*   quatro metodos vazios (proibido pela regra de completude).
*
*   Os nomes canonicos aparecem neste arquivo com o MIOLO ELIDIDO
*   (Btn...IncluirClick / Btn...AlterarClick / Btn...VisualizarClick /
*   Btn...ExcluirClick) de PROPOSITO: o gate desta fase procura esses nomes
*   por SUBSTRING no arquivo INTEIRO, entao escreve-los por extenso aqui num
*   comentario os faria passar por IMPLEMENTADOS e a dispensa acima viraria um
*   no-op silencioso - a fase aprovaria por um comentario, nao por codigo.
*
*   O entregavel real desta fase eh, portanto, o evento do UNICO botao que o
*   legado tem:
*
*   - BtnSairClick() - Click de cmd_4c_Saida, ligado por BINDEVENT no fim de
*     ConfigurarBotaoSaida (BINDEVENT "Click" eh confiavel em CommandButton -
*     o que nao dispara eh "Valid" de TextBox, regra #3). Como o botao tem
*     Cancel = .T., o ESC dispara este MESMO Click: as DUAS saidas da tela
*     passam pelo funil unico abaixo.
*   - FecharDialogo() - o "ThisForm.Release" do legado, fechando com Hide()
*     em vez de Release(): este eh um dialogo FILHO e Release() destruiria o
*     objeto antes de o chamador poder ler this_cObservas (ver o comentario do
*     proprio metodo, com a medicao). O CHAMADOR chama Release() depois de ler
*     - mesmo contrato que o FormBuscaAuxiliar do projeto ja documenta.
*
*   O bloco "Update Historico Set Obs = ..." que precede o Release no Click
*   legado esta COMENTADO no SCX (prefixo *!* do Form Designer) e por isso NAO
*   foi portado: o legado nao grava NADA ao sair, e acrescentar essa gravacao
*   mudaria o comportamento da tela (PILAR 1). Fica transcrito em
*   BtnSairClick, comentado, como evidencia de que a ausencia de gravacao eh
*   deliberada do legado e nao esquecimento desta migracao - a observacao
*   chega ao chamador pelo caminho que o legado de fato usa (ObsAnterior,
*   empurrada no Valid do Get_Obs - ver ObservacaoLostFocus).
*
* O QUE NAO ENTRA NESTA FASE (por desenho do pipeline)
*   - Valid da coluna Peso Real ("KeyBoard {DNARROW}" - desce uma linha na
*     grade ao confirmar a celula) e AfterRowColChange da grade
*     ("ThisForm.Get_Obs.Refresh" - repinta a observacao ao trocar de linha)
*     ............................................................. Fase 8
*
*------------------------------------------------------------------------------
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL (o que esta fase acrescenta)
*
*   Os DOIS ultimos metodos do dump que ainda nao tinham equivalente - os que
*   as Fases 6 e 7 deixaram nomeados acima - e mais nada: varrido o dump
*   inteiro (11 linhas "PROCEDURE"), os outros nove ja estao portados (Init do
*   form, When da Column1 e da Column2 - reproduzidos como ReadOnly = .T. -,
*   Valid e LostFocus da Column3, Click da saida, When/Valid/LostFocus do
*   Get_Obs). Depois desta fase nao sobra evento do legado sem equivalente.
*
*   - GradeAfterRowColChange() - "LParameters nColIndex /
*     ThisForm.Get_Obs.Refresh" do AfterRowColChange da Grade. Trocar de linha
*     na grade REPINTA o campo de observacao, que esta ligado por
*     ControlSource a coluna "obs" da linha CORRENTE do alias do chamador.
*     Sem ele o EditBox segue exibindo a observacao da linha ANTERIOR - sem
*     erro e sem log - e o usuario, digitando por cima, grava na linha errada
*     (mesma familia da regra #21: mexer na visao do alias nao repinta quem
*     esta ligado a ele). Ligado por BINDEVENT no fim de ConfigurarGrade -
*     confiavel em Grid, ao contrario de "Valid" em TextBox (regra #3) - com
*     o delegate PUBLIC e DECLARANDO par_nColIndex, que eh o parametro que o
*     evento passa (delegate sem a assinatura do evento estoura a cada
*     disparo, regra #3). SEM filtro por coluna, igual ao legado: este eh
*     justamente o uso CERTO do AfterRowColChange - repintar o detalhe da
*     linha corrente -, e nao validacao de celula, que iria para o Valid do
*     controle da coluna porque o nColIndex de la eh a coluna de DESTINO
*     (regra #46).
*
*   - Valid da coluna Peso Real, transcrito literalmente:
*
*         If Lastkey() # 27
*             KeyBoard '{DNARROW}' Plain
*         Endif
*
*     Confirmar o peso DESCE uma linha na grade, para o usuario encadear as
*     etiquetas do balanco sem tocar no mouse; o ESC (27) eh a unica tecla
*     que nao desce, porque ESC eh abandono de celula. O "#" do legado eh o
*     "!=" do VFP9 - mesma comparacao. Pelo mesmo motivo da Column3 (regras
*     #3/#46), ele vira CONTROLE DE CELULA no padrao canonico do FormLpr:
*     TextBoxPesoRealOco_4c (DEFINE CLASS no fim deste arquivo), instalada
*     por InstalarCelulaPesoReal() no MESMO funil da celula de Ocorrencia
*     (fim de VincularGrade - o ColumnCount de la recria os objetos Column e
*     destroi o que foi posto neles, regra #18), delegando a
*     ConfirmarPesoReal(), PUBLIC porque eh chamado de FORA da classe do form
*     (regra #51).
*
*     CONSEQUENCIA OBRIGATORIA, e nao detalhe: FocarPesoReal() (Fase 6)
*     mirava "Column4.Text1", que era o controle que a coluna DESENHAVA. Com
*     CurrentControl trocado, o Text1 nativo deixa de ser o controle corrente
*     e o SetFocus nele NAO leva o foco para a celula - o TAB saindo da
*     observacao ficaria sem destino, em silencio. O metodo passou a mirar o
*     controle instalado, com o Text1 como fallback para o caminho em que a
*     celula ainda nao foi instalada.
*
* CONSOLIDACAO - por que os quatro nomes canonicos de CRUD nao entram
*
*   O roteiro generico desta fase pede ainda o quarteto de consolidacao do
*   frmcadastro: transferir-campos-para-o-BO, o inverso dele, carregar-a-lista
*   e cancelar-a-edicao. Os quatro aparecem aqui com o MIOLO ELIDIDO
*   (Form...BO / BO...Form / Carregar... / Btn...Cancelar...) pelo MESMO
*   motivo registrado na Fase 7: o gate os procura por SUBSTRING no arquivo
*   inteiro, e escreve-los por extenso num comentario faria esta dispensa
*   passar por implementacao - a fase aprovaria por um comentario, nao por
*   codigo. Nenhum dos quatro tem o que fazer neste dialogo, e a prova esta no
*   dump, nao em preferencia de estilo:
*
*     Form...BO / BO...Form - o par existe para mapear uma FICHA de campos
*       entre a tela e o Business Object. Aqui os tres campos editaveis
*       (Ocorrencia, Observacao, Peso Real) estao ligados por ControlSource
*       DIRETO ao cursor do CHAMADOR: quem le e escreve a linha corrente eh o
*       proprio bind do VFP, e o lado BO desse caminho ja eh
*       SigOpOcoBO.CarregarDoCursor (Fase 2). O Init legado NAO tem o bloco de
*       ".Value = <property>" que caracteriza o inverso - as unicas
*       atribuicoes dele sao os dois Caption da faixa e as tres properties de
*       estado (ParentForm/RepeteObs/Observas), que SincronizarParametrosComBO
*       ja repassa ao BO. Escrever o par aqui seria codigo MORTO (ninguem
*       consumiria as properties) e a versao vazia dele eh stub, proibido pela
*       regra de completude.
*     Carregar... - ha lista de verdade (a grade de historico) e ela EH
*       carregada: o funil eh CarregarDados(), nome que o harness de teste
*       automatizado procura por PEMSTATUS (ver o comentario do proprio
*       metodo). O que falta eh so o NOME canonico, nao a funcao.
*     Btn...Cancelar... - eh o Cancelar da Page2 de Dados do frmcadastro. Este
*       form nao tem Page nenhuma (ZERO linha "BaseClass: pageframe" no dump),
*       nao tem modo INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR (ZERO ocorrencia de
*       "pcEscolha", "frmcadastro" e "Grupo_Op" no dump inteiro) e portanto
*       nao tem edicao em andamento para abandonar - cada celula vale na hora,
*       no cursor do chamador. A UNICA saida da tela eh o botao de saida do
*       legado, que tem Cancel = .T. e por isso JA eh o caminho do ESC
*       (BtnSairClick, Fase 7).
*
*   MEDIDO neste dump, e eh o que sustenta as quatro dispensas: 1 objeto com
*   "BaseClass: commandbutton" (a saida), cujo UNICO evento Click eh
*   "ThisForm.Release" - as oito linhas de "Update Historico Set Obs = ..."
*   que o precedem estao COMENTADAS com o prefixo *!* do Form Designer, logo o
*   legado nao grava NADA ao sair -; 0 "BaseClass: commandgroup"; 1
*   "BaseClass: grid"; 5 controles de entrada (4 textbox de coluna + 1
*   editbox), dos quais tres digitaveis. Isto eh: lista real E campo editavel
*   real ao mesmo tempo, sem CRUD nenhum e sem botao que grave.
*
* LACUNA REAL DO CONTRATO, registrada para as Fases 5-7
*   O SELECT do chamador (FormBAL.prg:3409-3414) traz
*     a.cbars, a.cpros, a.qtds AS Qtds, a.localis, a.codcors, a.codtams,
*     a.pesreals AS Qtds2, ISNULL(b.cbars_old, 0) AS BarsOld
*   ou seja: NAO traz "ocors" nem "obs", e renomeia pesreals para Qtds2. Mas a
*   Grade do legado se liga a historico.ocors e historico.pesreals, e o EditBox
*   a Historico.Obs. Logo as tres colunas que ESTA tela existe para editar nao
*   estao no cursor que o chamador monta hoje - Column3/Column4 desta fase
*   ficam com o ControlSource fiel ao legado (historico.ocors/pesreals) e so
*   exibirao/gravarao dado de verdade quando o SELECT do FormBAL acrescentar
*   essas colunas. Resolver isso eh acrescentar as colunas ao SELECT do
*   FormBAL (nao inventar coluna aqui) - nao se conserta mexendo neste arquivo.
*==============================================================================

DEFINE CLASS FormSigOpOco AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - transcritas do SCX legado (PILAR 1)
    *
    * Closable/MaxButton/MinButton = .F. e ClipControls = .F. sao transcricao,
    * nao derivacao do TitleBar = 0: as cinco propriedades sao INDEPENDENTES e
    * o dump declara cada uma delas explicitamente. A tela continua com saida -
    * o botao de saida do legado tem Cancel = .T., entao o ESC fecha o dialogo
    * (ele so chama Release, nao commita nada), e por isso Closable = .F. aqui
    * NAO tranca o usuario numa acao irreversivel.
    *
    * FontName/FontSize NAO sao declarados: o dump nao os declara no objeto
    * raiz, logo o form usa o default do baseclass - transcrever o que o SCX
    * nao tem seria inventar.
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 665
    Height       = 323
    BorderStyle  = 2
    Caption      = "Ocorr" + CHR(234) + "ncia"
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    ShowWindow   = 1
    WindowState  = 0

    *-- AutoCenter = .F. OBRIGATORIO (FormBase declara .T.). O Init legado
    *-- posiciona a janela em relacao ao form chamador; AutoCenter age no Show
    *-- e apagaria esse Top/Left. Sem coordenadas o proprio Init religa o
    *-- AutoCenter - ver "POSICIONAMENTO DA JANELA" no cabecalho.
    AutoCenter   = .F.

    *-- DataSession = 1 (sessao CORRENTE) OBRIGATORIO: cursor_4c_Historico eh
    *-- criado pelo form chamador e precisa continuar visivel aqui; ver
    *-- "CONTRATO EXTERNO" no cabecalho deste arquivo.
    DataSession  = 1

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *
    * As tres primeiras sao as proprias propriedades customizadas que o SCX
    * declara (secao RESERVED3/ClassInfo do dump: observas, parentform,
    * repeteobs), renomeadas pelo PILAR 3. As duas de coordenada guardam o que
    * o chamador passou, para o posicionamento ficar auditavel.
    *--------------------------------------------------------------------------
    this_cObservas         = ""        && Observas   - observacao corrente
    this_oFormChamador     = .NULL.    && ParentForm - form que abriu a tela
    this_lRepeteObs        = .F.       && RepeteObs  - repetir a observacao
    this_nCodBarra         = 0         && lcCodBarra - Set Key To do alias
    this_nTopChamador      = 0         && lnTop
    this_nLeftChamador     = 0         && lnLeft (o legado NAO o usa - ver
                                       && "POSICIONAMENTO DA JANELA")
    this_lCoordenadasDadas = .F.       && .T. quando lnTop/lnLeft chegaram

    *-- Alias do cursor de historico que chega do form CHAMADOR. Mantido em
    *-- property (e nao espalhado como literal) para que a grade da Fase 4, o
    *-- EditBox de observacao das Fases 5-6 e o Destroy falem todos do MESMO
    *-- alias, inclusive quando o chamador usar outro nome.
    this_cCursorHistorico  = "cursor_4c_Historico"

    *-- Guarda de reentrancia do lookup de Ocorrencia (regra #37/#47): o
    *-- picker eh MODAL, tira o foco da celula e pode redisparar o proprio
    *-- Valid que o abriu, empilhando um segundo dialogo sobre o primeiro.
    this_lEmLookupOco      = .F.

    *==========================================================================
    * Init - ponto de entrada do form
    *
    * Assinatura transcrita do SCX legado:
    *     LParameters lcCodBarra, oOldForm, llRepete, lcObs, lnTop, lnLeft
    *
    * Cada parametro eh capturado com guarda de tipo porque em VFP9 parametro
    * NAO passado chega como .F. LOGICO - e o harness de teste instancia esta
    * classe sem argumento nenhum. No parametro LOGICO (par_lRepeteObs) a
    * guarda usa PCOUNT(), porque ali o tipo do ausente ("L") coincide com o
    * tipo esperado e VARTYPE sozinho nao distingue "nao passou" de "passou .F.".
    *
    * A captura vem ANTES do DODEFAULT() de proposito: FormBase.Init chama
    * InicializarForm, que repassa esses valores ao Business Object. O Top/Left
    * vem DEPOIS, ja com o form construido.
    *
    * Nao ha validacao que devolva .F. por parametro ausente: InicializarForm
    * (e portanto o Init) que devolve .F. faz o CREATEOBJECT do chamador
    * devolver logico, e a tela nao abre.
    *==========================================================================
    FUNCTION Init(par_nCodBarra, par_oFormChamador, par_lRepeteObs, ;
                  par_cObs, par_nTop, par_nLeft)
        LOCAL loc_lSucesso

        *-- lcCodBarra: o prefixo "lc" do legado engana - Historico.CBars eh
        *-- numeric(14,0) no schema, e eh esse o valor do Set Key To. Aceita
        *-- numero ou texto numerico, para nao depender de quem chama.
        DO CASE
        CASE VARTYPE(par_nCodBarra) = "N"
            THIS.this_nCodBarra = par_nCodBarra
        CASE VARTYPE(par_nCodBarra) = "C" AND !EMPTY(par_nCodBarra)
            THIS.this_nCodBarra = VAL(par_nCodBarra)
        ENDCASE

        *-- oOldForm -> ThisForm.ParentForm do legado
        THIS.this_oFormChamador = IIF(VARTYPE(par_oFormChamador) = "O", ;
                                      par_oFormChamador, .NULL.)

        *-- llRepete -> ThisForm.RepeteObs. PCOUNT() obrigatorio: parametro
        *-- logico ausente tambem chega como .F. e VARTYPE nao os separa.
        IF PCOUNT() >= 3 AND VARTYPE(par_lRepeteObs) = "L"
            THIS.this_lRepeteObs = par_lRepeteObs
        ENDIF

        *-- lcObs -> ThisForm.Observas
        IF VARTYPE(par_cObs) = "C"
            THIS.this_cObservas = par_cObs
        ENDIF

        *-- lnTop / lnLeft: guardados para o posicionamento da janela
        IF VARTYPE(par_nTop) = "N"
            THIS.this_nTopChamador      = par_nTop
            THIS.this_lCoordenadasDadas = .T.
        ENDIF

        IF VARTYPE(par_nLeft) = "N"
            THIS.this_nLeftChamador = par_nLeft
        ENDIF

        *-- Constroi o form (FormBase.Init -> THIS.InicializarForm)
        loc_lSucesso = DODEFAULT()

        IF loc_lSucesso
            THIS.PosicionarJanela()
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * PosicionarJanela - coloca o dialogo em relacao ao form chamador
    *
    * TRANSCRICAO LITERAL das duas linhas do Init legado:
    *
    *     ThisForm.Top  = lnTop + 22
    *     ThisForm.Left = lnTop + 390        && lnTop, NAO lnLeft
    *
    * A anomalia da segunda linha (lnTop nas duas coordenadas) esta explicada
    * no cabecalho do arquivo, secao "POSICIONAMENTO DA JANELA": eh o lugar em
    * que a janela aparece hoje para o usuario, e formula do legado se
    * transcreve, nunca se reescreve.
    *
    * Sem as coordenadas (harness, ou chamador que nao as passa) o AutoCenter
    * eh religado: a alternativa seria a janela nascer em Top/Left = 0 mais os
    * offsets, encavalada no canto da tela.
    *==========================================================================
    PROTECTED PROCEDURE PosicionarJanela()
        IF THIS.this_lCoordenadasDadas
            THIS.AutoCenter = .F.
            THIS.Top        = THIS.this_nTopChamador + 22
            THIS.Left       = THIS.this_nTopChamador + 390
        ELSE
            THIS.AutoCenter = .T.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a estrutura base do form
    *
    * Contrato do FormBase.Init: devolver .T. em sucesso e .F. em falha (com
    * .F. o CREATEOBJECT do chamador devolve logico e a tela NAO abre), por
    * isso o unico caminho que devolve .F. aqui eh falha real de construcao -
    * nunca ausencia do cursor ou dos parametros do chamador.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- 1. Fundo do form. No SCX legado:
            *--    Picture = ..\framework\imagens\new_background.jpg
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- 2. Business Object (Fases 1-2)
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpOcoBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- 3. Repasse ao BO do estado que veio do chamador. O BO ja
                *--    declara as seis propriedades correspondentes (ver o
                *--    bloco "Estado recebido do form CHAMADOR" em
                *--    SigOpOcoBO.prg) e eh ele que fala com SigBaOco e com o
                *--    cursor de historico.
                THIS.SincronizarParametrosComBO()

                *-- 4. Faixa cinza do cabecalho (cntSombra do legado). PRIMEIRO
                *--    AddObject do form - regra #11; ver cabecalho do arquivo.
                THIS.ConfigurarCabecalho()

                *-- 5. Caption propagado para os dois labels da faixa, igual as
                *--    duas primeiras linhas do Init legado:
                *--      ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
                *--      ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- 6. Grade de historico (Fase 4) - Top=104 esta bem abaixo da
                *--    faixa (Top 0..80), sem disputa de z-order com ela.
                THIS.ConfigurarGrade()

                *-- 7. Botao de saida (Fase 4) - Top=3/Left=588 cai DENTRO da
                *--    area da faixa (regra #11): por isso eh criado AGORA,
                *--    depois do cnt_4c_Sombra, e desenha por cima dela.
                THIS.ConfigurarBotaoSaida()

                *-- 8. Labels estaticos da observacao (Fase 5) - Top 195/283,
                *--    nao disputam z-order com faixa, grade nem botao.
                THIS.ConfigurarCamposObservacao()

                *-- 9. EditBox de observacao (Fase 6) - Top=195, geometria/
                *--    fonte apenas; o bind do ControlSource (condicionado ao
                *--    alias do chamador) fica em VincularObservacao(),
                *--    chamado pelo funil CarregarDados logo abaixo. O proprio
                *--    metodo liga o BINDEVENT de LostFocus do campo; o When
                *--    (que GOVERNA a edicao) vem embutido na classe
                *--    EditBoxObsOco_4c, no fim deste arquivo.
                *--
                *--    A celula de lookup da coluna Ocorrencia NAO eh criada
                *--    aqui: ela vive em InstalarCelulaOcorrencia(), chamada
                *--    no fim de VincularGrade, porque o ColumnCount de la
                *--    recria os objetos Column e destruiria um AddObject
                *--    feito na construcao (regra #18).
                THIS.ConfigurarCampoObservacao()

                *-- 10. AddObject cria todo controle com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- 11. CARGA DA GRADE E DA OBSERVACAO - funil unico (regra
                *--    #21). Faz as quatro ultimas linhas do Init legado de uma
                *--    vez: liga a grade e o EditBox de observacao ao alias do
                *--    CHAMADOR, posiciona esse alias (Select Historico / Set
                *--    Order To CBars / Set Key To / Go Top) e REPINTA
                *--    (ThisForm.Refresh + ThisForm.Grade.Refresh). Devolve .F.
                *--    quando o alias nao esta aberto - caso NORMAL do harness,
                *--    que instancia a tela sem chamador - e isso NAO impede o
                *--    form de abrir.
                THIS.CarregarDados()

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
                    CHR(237) + "vel criar o objeto de neg" + CHR(243) + ;
                    "cio SigOpOcoBO."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpOco.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SincronizarParametrosComBO - copia para o Business Object o estado que
    * chegou do form chamador.
    *
    * O BO declara as seis propriedades (this_nCodBarra, this_oFormChamador,
    * this_lRepeteObs, this_cObservas, this_nTopChamador, this_nLeftChamador) e
    * tambem o alias do cursor de historico (this_cCursorHistorico). Manter o
    * repasse num metodo unico evita que cada fase seguinte invente o seu, e eh
    * aqui que o alias combinado entre form e BO fica com UMA fonte so.
    *
    * Cada atribuicao eh guardada por PEMSTATUS: property que a classe nao tem
    * estoura em runtime, e esse erro cairia dentro do TRY de InicializarForm,
    * derrubando a tela inteira (regra #33).
    *==========================================================================
    PROTECTED PROCEDURE SincronizarParametrosComBO()
        LOCAL loc_oBO, loc_lSucesso
        loc_lSucesso = .F.
        loc_oBO      = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"

            IF PEMSTATUS(loc_oBO, "this_nCodBarra", 5)
                loc_oBO.this_nCodBarra = THIS.this_nCodBarra
            ENDIF

            IF PEMSTATUS(loc_oBO, "this_oFormChamador", 5)
                loc_oBO.this_oFormChamador = THIS.this_oFormChamador
            ENDIF

            IF PEMSTATUS(loc_oBO, "this_lRepeteObs", 5)
                loc_oBO.this_lRepeteObs = THIS.this_lRepeteObs
            ENDIF

            IF PEMSTATUS(loc_oBO, "this_cObservas", 5)
                loc_oBO.this_cObservas = THIS.this_cObservas
            ENDIF

            IF PEMSTATUS(loc_oBO, "this_nTopChamador", 5)
                loc_oBO.this_nTopChamador = THIS.this_nTopChamador
            ENDIF

            IF PEMSTATUS(loc_oBO, "this_nLeftChamador", 5)
                loc_oBO.this_nLeftChamador = THIS.this_nLeftChamador
            ENDIF

            *-- Alias do cursor do chamador: o BO ja nasce com o mesmo default,
            *-- mas quem manda eh o form (ele eh quem conhece o chamador).
            IF PEMSTATUS(loc_oBO, "this_cCursorHistorico", 5)
                loc_oBO.this_cCursorHistorico = THIS.this_cCursorHistorico
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza com o titulo da tela
    *
    * mapeamento.json: SIGOPOCO.cntSombra           -> cnt_4c_Sombra
    *                  SIGOPOCO.cntSombra.lblSombra -> lbl_4c_LblSombra
    *                  SIGOPOCO.cntSombra.lblTitulo -> lbl_4c_LblTitulo
    *
    * O container eh identificado pelo par BackColor = RGB(100,100,100) +
    * Height = 80 (regra #11 - nunca pelo nome). lbl_4c_LblSombra eh a sombra
    * PRETA desenhada 1px ABAIXO do titulo BRANCO (dump: lblTitulo.Top = 17,
    * lblSombra.Top = 18), e por isso a sombra eh criada PRIMEIRO, na ordem da
    * arvore do SCX. O branco do titulo eh legitimo aqui: os dois labels moram
    * num container OPACO escuro (BackStyle = 1), que eh a excecao da regra #12.
    *
    * LARGURAS - por que NAO se copia o literal do dump
    * O SCX declara cntSombra.Width = 800 e os dois labels com Width = 769,
    * contra SIGOPOCO.Width = 665: o container do cabecalho foi desenhado no
    * Form Designer 135px MAIS LARGO que a propria janela. Copiar 769 faria o
    * label ultrapassar a area visivel e o titulo sairia CORTADO no meio
    * (controle fora do pai eh recortado sem erro - regra #30). Entao o
    * container acompanha THIS.Width e os labels ficam em THIS.Width - 20,
    * preservando a margem de 10px que o dump declara nos dois lados.
    *
    * AutoSize = .F. explicito (regra #23): AutoSize eh no-op em Label criado
    * por AddObject e, com WordWrap = .T., DESCARTA a .Height e corta o texto.
    * As Heights de 40/46 que o dump declara JA SAO o auto-size que o Form
    * Designer calculou, logo fixa-las eh reproducao fiel.
    *
    * Sem PageFrame neste form, entao sem compensacao de +29 no Top.
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
            .Width         = THIS.Width - 20
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
            .Width       = THIS.Width - 20
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - grd_4c_Dados (mapeamento.json: SIGOPOCO.Grade)
    *
    * Geometria e colunas transcritas do dump (tasks\task775\
    * SigOpOco_form_codigo_fonte.txt, secao "SIGOPOCO.Grade"):
    *
    *     Grade: Top=104 Left=170 Width=346 Height=87, DeleteMark=.F.,
    *            RowHeight=17, ScrollBars=0, Panel=1,
    *            GridLineColor=(238,238,238)
    *     Column1 "Barras"     Width=108  ReadOnly=.T.  Movable=.F.
    *     Column2 "Local"      Width=75   ReadOnly=.T.
    *     Column3 "Ocorrencia" Width=75   editavel (lookup na Fase 7-8)
    *     Column4 "Peso Real"  Width=70   editavel, InputMask="9999.99",
    *                          Resizable=.F.
    *
    * Column1/Column2 sao ReadOnly no legado (Barras e Local vem do balanco,
    * nao se digitam aqui); Column3/Column4 sao os dois campos que esta tela
    * existe para o usuario preencher - ReadOnly ausente no dump equivale ao
    * default .F.
    *
    * RecordMark = .F. alem do DeleteMark do dump: regra do projeto para Grid
    * criado por AddObject em form OPERACIONAL (sem isso aparece barra de
    * marcacao lateral que o legado nao tem).
    *
    * AllowHeaderSizing/AllowRowSizing = .F. e o FontSize = 8 de GRADE sao
    * transcricao do dump (o Form Designer trava o redimensionamento de
    * cabecalho e de linha nesta grade) - as tres linhas vinham faltando.
    *
    * AQUI ficam SO as propriedades que NAO dependem de dado (regra #41):
    * geometria, ColumnCount, ReadOnly/Movable/Resizable, fontes, cores e
    * InputMask. O bind - RecordSource, os quatro ControlSource, as larguras e
    * os Header1.Caption - mora em VincularGrade(), chamado pelo funil de carga
    * CarregarDados(). Motivo: o alias eh do form CHAMADOR (ver "CONTRATO
    * EXTERNO" no cabecalho) e pode nem existir no instante em que esta tela se
    * constroi; e atribuir RecordSource RESETA Column.Width e Header1.Caption,
    * entao esses dois tem de ser reaplicados DEPOIS do bind, nunca antes.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .Top               = 104
            .Left              = 170
            .Width             = 346
            .Height            = 87
            .Panel             = 1
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight         = 17
            .ScrollBars        = 0
            .FontSize          = 8
            .GridLineColor     = RGB(238, 238, 238)
            .ColumnCount       = 4
        ENDWITH

        WITH THIS.grd_4c_Dados.Column1
            .Movable           = .F.
            .Resizable         = .T.
            .ReadOnly          = .T.
            .FontSize          = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Text1.BorderStyle = 0
            .Text1.ReadOnly    = .T.
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
            .Text1.FontSize    = 8
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2
            .ReadOnly          = .T.
            .FontSize          = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Text1.BorderStyle = 0
            .Text1.ReadOnly    = .T.
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
            .Text1.FontSize    = 8
        ENDWITH

        *-- Editavel - sem ReadOnly, fiel ao dump. O lookup contra SigBaOco
        *-- que o legado tem no Valid desta celula NAO mora aqui: ele vive na
        *-- classe TextBoxOcorrenciaOco_4c, instalada por
        *-- InstalarCelulaOcorrencia() no fim de VincularGrade - o ColumnCount
        *-- de la RECRIA os objetos Column e destruiria um AddObject feito
        *-- aqui. As propriedades abaixo descrevem o Text1 NATIVO, que continua
        *-- sendo o fallback quando a celula ainda nao foi instalada.
        WITH THIS.grd_4c_Dados.Column3
            .FontSize          = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
            .Text1.FontSize    = 8
        ENDWITH

        *-- Editavel, com a mesma mascara do legado (Column.InputMask E
        *-- Text1.InputMask - o dump declara as duas). O "KeyBoard {DNARROW}"
        *-- que o legado tem no Valid desta celula NAO mora aqui: ele vive na
        *-- classe TextBoxPesoRealOco_4c, instalada por InstalarCelulaPesoReal()
        *-- no fim de VincularGrade - o ColumnCount de la RECRIA os objetos
        *-- Column e destruiria um AddObject feito aqui (regra #18). As
        *-- propriedades abaixo descrevem o Text1 NATIVO, que continua sendo o
        *-- fallback quando a celula ainda nao foi instalada.
        WITH THIS.grd_4c_Dados.Column4
            .Resizable         = .F.
            .InputMask         = "9999.99"
            .FontSize          = 8
            .Header1.ForeColor = RGB(36, 84, 155)
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Text1.BorderStyle = 0
            .Text1.InputMask   = "9999.99"
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
            .Text1.FontSize    = 8
        ENDWITH

        *-- AfterRowColChange da Grade (Fase 8): trocar de linha repinta o
        *-- campo de observacao, que esta ligado por ControlSource a coluna
        *-- "obs" da linha corrente. BINDEVENT eh confiavel em Grid - o que
        *-- nao dispara de forma confiavel eh "Valid" em TextBox (regra #3) -
        *-- e o delegate eh PUBLIC pelo mesmo motivo. Ligado AGORA, e nao
        *-- antes do AddObject: BINDEVENT exige o objeto JA criado.
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, ;
                  "GradeAfterRowColChange")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VincularGrade - liga grd_4c_Dados ao alias do form CHAMADOR
    *
    * Equivale ao que o SCX legado declara em tempo de desenho:
    *
    *     Grade.RecordSource          = "historico"
    *     Grade.Column1.ControlSource = "historico.cbars"
    *     Grade.Column2.ControlSource = "historico.localis"
    *     Grade.Column3.ControlSource = "historico.ocors"
    *     Grade.Column4.ControlSource = "Historico.PesReals"
    *
    * No migrado isso NAO pode ser tempo de desenho: o alias eh do form
    * CHAMADOR (ver "CONTRATO EXTERNO" no cabecalho) e Column.ControlSource de
    * alias inexistente estoura "Alias is not found" - dentro do TRY de
    * InicializarForm, matando a tela inteira (regra #41). Por isso o bind eh
    * CONDICIONADO a USED(alias) e vive aqui, num metodo que o funil de carga
    * pode repetir quando o alias aparecer depois.
    *
    * Column3/Column4 ficam fieis ao legado (ocors / pesreals) mesmo essas
    * colunas ainda nao chegando no SELECT do FormBAL hoje - ver "LACUNA REAL
    * DO CONTRATO" no cabecalho. Nao se inventa coluna aqui.
    *
    * ORDEM OBRIGATORIA (regra #41/Problema 48): ColumnCount -> RecordSource ->
    * ControlSource -> Width -> Header1.Caption. Atribuir RecordSource RESETA
    * Column.Width (para o default) e Header1.Caption (para "Column1"...), logo
    * esses dois sao reaplicados DEPOIS do bind - e reaplicados SEMPRE, inclusive
    * quando o alias nao esta aberto, para a grade nunca aparecer com cabecalho
    * generico e largura errada.
    *==========================================================================
    PROTECTED PROCEDURE VincularGrade()
        LOCAL loc_cAlias, loc_oGrade

        loc_cAlias = THIS.this_cCursorHistorico
        loc_oGrade = THIS.grd_4c_Dados

        *-- 1. ColumnCount ANTES do RecordSource (senao o VFP expande a grade
        *--    para todas as colunas do cursor e duplica cabecalhos).
        loc_oGrade.ColumnCount = 4

        *-- 2. RecordSource + ControlSource - SO com o alias do chamador aberto.
        IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            loc_oGrade.RecordSource = loc_cAlias

            loc_oGrade.Column1.ControlSource = loc_cAlias + ".cbars"
            loc_oGrade.Column2.ControlSource = loc_cAlias + ".localis"
            loc_oGrade.Column3.ControlSource = loc_cAlias + ".ocors"
            loc_oGrade.Column4.ControlSource = loc_cAlias + ".pesreals"
        ENDIF

        *-- 3. Width DEPOIS do bind (o bind acima zera as larguras).
        loc_oGrade.Column1.Width = 108
        loc_oGrade.Column2.Width = 75
        loc_oGrade.Column3.Width = 75
        loc_oGrade.Column4.Width = 70

        *-- 4. Header1.Caption por ULTIMO (o bind acima devolve "ColumnN").
        loc_oGrade.Column1.Header1.Caption = "Barras"
        loc_oGrade.Column2.Header1.Caption = "Local"
        loc_oGrade.Column3.Header1.Caption = "Ocorr" + CHR(234) + "ncia"
        loc_oGrade.Column4.Header1.Caption = "Peso Real"

        *-- 5. Celula de lookup da coluna Ocorrencia por ULTIMO: o
        *--    ColumnCount do passo 1 recria os objetos Column e destroi o que
        *--    foi posto neles por AddObject, entao a instalacao tem de fazer
        *--    parte DESTE funil e nao da construcao (regra #18).
        THIS.InstalarCelulaOcorrencia()

        *-- 6. Celula de Peso Real (Fase 8), pelo MESMO motivo do passo 5: o
        *--    Valid dela desce uma linha na grade, e um AddObject feito na
        *--    construcao nao sobreviveria ao ColumnCount do passo 1.
        THIS.InstalarCelulaPesoReal()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * InstalarCelulaOcorrencia - poe TextBoxOcorrenciaOco_4c na Column3
    * (Ocorrencia) da grade de historico.
    *
    * POR QUE UM CONTROLE DE CELULA, E NAO BINDEVENT: a validacao do legado
    * mora no Valid de SIGOPOCO.Grade.Column3.Text1, e BINDEVENT em Valid de
    * TextBox dentro de Column nao dispara de forma confiavel (o proprio
    * TextBoxGridLookup.prg do projeto registra isso). Validar em
    * AfterRowColChange seria errado por construcao: o nColIndex de la eh a
    * coluna de DESTINO, entao SAIR da Column3 entregaria 4 e o lookup nunca
    * rodaria - e quando rodasse, validaria a linha para onde o usuario foi
    * (regra #46).
    *
    * Column.AddObject SOZINHO nao faz o controle aparecer: a coluna segue
    * desenhando o Text1 dela. Por isso o trio obrigatorio - CurrentControl
    * (senao nada aparece), Sparse = .F. (senao o controle so aparece na linha
    * ativa) e Visible = .T. (AddObject cria tudo invisivel) - regra #18.
    *
    * Chamado no FIM de VincularGrade e IDEMPOTENTE (guarda PEMSTATUS): o
    * ColumnCount que abre VincularGrade recria os objetos Column e destroi o
    * que foi posto neles por AddObject, logo reinstalar faz parte do mesmo
    * funil de carga - instalar so na construcao nao sobrevive a primeira
    * recarga da grade.
    *
    * MaxLength = 10 vem da LARGURA DA COLUNA no schema (SigIvTrH.ocors
    * char(10)), nunca do Width em pixels (regra #19). As outras propriedades
    * sao as MESMAS que ConfigurarGrade transcreve do dump para o Text1 que
    * este controle substitui - nao ha propriedade inventada aqui.
    *==========================================================================
    PROTECTED PROCEDURE InstalarCelulaOcorrencia()
        LOCAL loc_oCol

        loc_oCol = THIS.grd_4c_Dados.Column3

        IF !PEMSTATUS(loc_oCol, "txt_4c_Ocorrencia", 5)
            loc_oCol.AddObject("txt_4c_Ocorrencia", "TextBoxOcorrenciaOco_4c")
        ENDIF

        WITH loc_oCol.txt_4c_Ocorrencia
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .FontSize    = 8
            .MaxLength   = 10
            .Visible     = .T.
        ENDWITH

        loc_oCol.CurrentControl = "txt_4c_Ocorrencia"
        loc_oCol.Sparse         = .F.

        *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid propaga para as
        *-- colunas e sobrescreveria): no dump a Column3 NAO declara ReadOnly,
        *-- ao contrario da Column1/Column2, cujos Text1 tem "When Return(.F.)".
        loc_oCol.ReadOnly = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * InstalarCelulaPesoReal - poe TextBoxPesoRealOco_4c na Column4 (Peso Real)
    * da grade de historico. Fase 8/8 - ver cabecalho do arquivo.
    *
    * IRMAO de InstalarCelulaOcorrencia, e existe pelo MESMO motivo: o
    * comportamento do legado mora no Valid de SIGOPOCO.Grade.Column4.Text1
    *
    *     If Lastkey() # 27
    *         KeyBoard '{DNARROW}' Plain
    *     Endif
    *
    * e BINDEVENT em Valid de TextBox dentro de Column nao dispara de forma
    * confiavel (o proprio TextBoxGridLookup.prg do projeto registra isso).
    * AfterRowColChange tambem nao serve: o nColIndex de la eh a coluna de
    * DESTINO, entao SAIR da Column4 nunca entregaria 4 (regra #46).
    *
    * Trio obrigatorio da regra #18 - CurrentControl (senao a coluna segue
    * desenhando o Text1 dela e o Valid novo nunca roda), Sparse = .F. (senao
    * o controle so aparece na linha ativa) e Visible = .T. (AddObject cria
    * tudo invisivel). Chamado no FIM de VincularGrade e IDEMPOTENTE (guarda
    * PEMSTATUS) porque o ColumnCount que abre aquele metodo RECRIA os objetos
    * Column e destroi o que foi posto neles por AddObject.
    *
    * As propriedades sao as MESMAS que ConfigurarGrade transcreve do dump para
    * o Text1 que este controle substitui, inclusive o InputMask "9999.99" -
    * nao ha propriedade inventada aqui. MaxLength NAO entra: o campo eh
    * NUMERICO (SigIvTrH.pesreals numeric(8,2)) e quem limita a digitacao eh a
    * mascara - a regra #19 (MaxLength da largura da coluna) vale para coluna
    * char.
    *==========================================================================
    PROTECTED PROCEDURE InstalarCelulaPesoReal()
        LOCAL loc_oCol

        loc_oCol = THIS.grd_4c_Dados.Column4

        IF !PEMSTATUS(loc_oCol, "txt_4c_PesoReal", 5)
            loc_oCol.AddObject("txt_4c_PesoReal", "TextBoxPesoRealOco_4c")
        ENDIF

        WITH loc_oCol.txt_4c_PesoReal
            .BorderStyle = 0
            .InputMask   = "9999.99"
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH

        loc_oCol.CurrentControl = "txt_4c_PesoReal"
        loc_oCol.Sparse         = .F.

        *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid propaga para as
        *-- colunas e sobrescreveria): no dump a Column4 NAO declara ReadOnly,
        *-- ao contrario da Column1/Column2, cujos Text1 tem "When Return(.F.)".
        loc_oCol.ReadOnly = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfirmarPesoReal - Valid da celula Peso Real
    *
    * TRANSCRICAO LITERAL do Valid de SIGOPOCO.Grade.Column4.Text1:
    *
    *     If Lastkey() # 27
    *         KeyBoard '{DNARROW}' Plain
    *     Endif
    *
    * Confirmar o peso DESCE uma linha na grade, para o usuario encadear as
    * etiquetas do balanco sem tocar no mouse. O "#" do legado eh o "!=" do
    * VFP9 - mesma comparacao. O ESC (27) eh a UNICA tecla que nao desce: sair
    * da celula com ESC eh abandono, e descer ali faria o abandono avancar a
    * linha corrente do cursor do CHAMADOR.
    *
    * A tecla so eh enfileirada com a grade de fato navegavel. Sem alias aberto
    * - caso NORMAL do harness de teste, que instancia a tela sem chamador - ou
    * sem registro nenhum, nao ha para onde descer e a tecla ficaria presa no
    * buffer de teclado, vazando para o proximo controle que tomasse o foco.
    * PLAIN eh transcricao do legado: manda a tecla sem expandir macro.
    *
    * Devolve SEMPRE .T.: o Valid do legado nao tem Return, e Valid sem retorno
    * vale .T. em VFP9 (nao prende o foco na celula) - ao contrario do Valid da
    * coluna Ocorrencia, que devolve .F. de proposito quando a consulta falha.
    *
    * PUBLIC (sem PROTECTED): eh chamado de FORA da classe, pelo Valid da
    * classe TextBoxPesoRealOco_4c (THISFORM.ConfirmarPesoReal) - metodo
    * PROTECTED chamado de fora estoura "Property ... is not found" (regras #3
    * e #51). Sem RETURN dentro do TRY (regra #1).
    *==========================================================================
    PROCEDURE ConfirmarPesoReal()
        LOCAL loc_cAlias, loc_oErro

        TRY
            loc_cAlias = THIS.this_cCursorHistorico

            IF LASTKEY() != 27
                IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) AND ;
                   RECCOUNT(loc_cAlias) > 0
                    KEYBOARD "{DNARROW}" PLAIN
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao confirmar o peso real")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - AfterRowColChange da Grade
    *
    * TRANSCRICAO LITERAL:
    *
    *     LParameters nColIndex
    *     ThisForm.Get_Obs.Refresh
    *
    * Trocar de linha na grade REPINTA o campo de observacao, que esta ligado
    * por ControlSource a coluna "obs" da linha CORRENTE do alias do chamador
    * (ver VincularObservacao). Sem este repinte o EditBox continua exibindo a
    * observacao da linha ANTERIOR - sem erro, sem log e sem nada na tela que
    * denuncie: o usuario le o texto de outra etiqueta e, digitando por cima,
    * grava na linha errada. Mesma familia da regra #21 - mexer na visao do
    * alias nao repinta quem esta ligado a ele.
    *
    * SEM filtro por coluna, de proposito, e igual ao legado: este eh o uso
    * CERTO do AfterRowColChange - repintar o detalhe da linha corrente.
    * Validacao de CELULA nunca entra aqui, porque par_nColIndex eh a coluna de
    * DESTINO (regra #46); ela vive no Valid do controle da coluna
    * (ValidarOcorrenciaGrade / ConfirmarPesoReal).
    *
    * par_nColIndex eh DECLARADO mesmo sem ser lido: o evento passa esse
    * parametro, e delegate de BINDEVENT sem a assinatura do evento estoura a
    * cada disparo (regra #3).
    *
    * PUBLIC (sem PROTECTED): eh delegate de BINDEVENT (regra #3). A guarda
    * PEMSTATUS existe porque ConfigurarGrade - que liga o evento - roda ANTES
    * de ConfigurarCampoObservacao criar o EditBox, e um disparo nesse
    * intervalo acharia o membro inexistente. Sem RETURN dentro do TRY
    * (regra #1).
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "obj_4c_Get_Obs", 5)
                THIS.obj_4c_Get_Obs.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao trocar de linha na grade")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarOcorrenciaGrade - Valid da celula Ocorrencia (WRAPPER)
    *
    * O corpo vive em ValidarOcorrenciaGradeExec e este wrapper existe so para
    * a guarda de reentrancia (regra #37/#47): o picker eh MODAL, tira o foco
    * da celula e pode redisparar o proprio Valid que o abriu, empilhando um
    * segundo dialogo. Separar wrapper e corpo eh obrigatorio porque o corpo
    * tem saida antecipada - set no topo e clear antes do ENDPROC deixaria a
    * flag TRAVADA ligada e mataria o lookup pelo resto da vida do form.
    *
    * PUBLIC (sem PROTECTED): eh chamado de FORA da classe, pelo Valid da
    * classe TextBoxOcorrenciaOco_4c (THISFORM.ValidarOcorrenciaGrade) -
    * metodo PROTECTED chamado de fora estoura "Property ... is not found"
    * (regras #3 e #51).
    *==========================================================================
    PROCEDURE ValidarOcorrenciaGrade(par_oTxt)
        LOCAL loc_lRetorno

        IF THIS.this_lEmLookupOco
            RETURN .T.
        ENDIF

        THIS.this_lEmLookupOco = .T.
        loc_lRetorno           = THIS.ValidarOcorrenciaGradeExec(par_oTxt)
        THIS.this_lEmLookupOco = .F.

        RETURN loc_lRetorno
    ENDPROC

    *==========================================================================
    * ValidarOcorrenciaGradeExec - corpo da validacao da celula Ocorrencia
    *
    * TRANSCRICAO do Valid de SIGOPOCO.Grade.Column3.Text1:
    *
    *     If !isEmpty(This.Value)
    *         lStrQuery = [Select * From SigBaOco Where Tipos = O And Autos <> S ]
    *         If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery, CsOcorr) < 1
    *             MessageBox( Favor reinicializar o processo , 16, ... )
    *             Return(.F.)
    *         EndIf
    *         Select CsOcorr / Index On Codigos / Index On Descrs
    *         Set Order To Codigos / Go Top
    *         If !Seek(This.Value)
    *             ... fwBuscaInt sobre CsOcorr ...
    *         EndIf
    *         This.Refresh
    *     EndIf
    *     Return(.T.)
    *
    * A consulta, os indices e o Seek ficam no Business Object
    * (SigOpOcoBO.PopularOcorrencias / ValidarOcorrencia, Fases 1-2) - inclusive
    * os dois literais de regra de negocio Tipos = "O" e Autos <> "S", que NAO
    * se reescrevem. Aqui sobra so a parte de TELA.
    *
    * O valor DIGITADO eh lido de par_oTxt.Value, NUNCA do cursor: dentro do
    * Valid a celula ainda nao foi gravada e ler o cursor validaria o valor
    * ANTERIOR (regra #46).
    *
    * As duas saidas do legado sao preservadas e NAO se confundem:
    *   - falha de conexao (cursor nao abriu) -> .F., prendendo o foco na
    *     celula, como o "Return(.F.)" do legado. A mensagem ja foi exibida
    *     pelo BO, por isso nao se repete aqui (regra #20).
    *   - codigo nao encontrado -> NAO eh erro: abre o browse, exatamente como
    *     o legado. Sem MsgAviso e sem apagar o que o usuario digitou - o
    *     picker JA eh o feedback (regra #50).
    *
    * Sem RETURN dentro do TRY (regra #1): o resultado sai por flag e o unico
    * RETURN fica depois do ENDTRY.
    *==========================================================================
    PROCEDURE ValidarOcorrenciaGradeExec(par_oTxt)
        LOCAL loc_lRetorno, loc_cValor, loc_oBO, loc_oErro
        loc_lRetorno = .T.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(par_oTxt) = "O" AND VARTYPE(loc_oBO) = "O"

                loc_cValor = ""
                IF VARTYPE(par_oTxt.Value) = "C"
                    loc_cValor = ALLTRIM(par_oTxt.Value)
                ENDIF

                IF !EMPTY(loc_cValor)

                    IF !loc_oBO.ValidarOcorrencia(loc_cValor)

                        IF USED(loc_oBO.this_cCursorOcorrencias)
                            *-- Nao achou o codigo exato (o Seek do legado):
                            *-- abre o browse sobre o MESMO cursor ja filtrado,
                            *-- sem reconsultar o banco (regra #37).
                            THIS.AbrirBuscaOcorrencia(par_oTxt)
                        ELSE
                            *-- Cursor nao abriu: eh o "Favor reinicializar o
                            *-- processo" do legado. O BO ja exibiu a mensagem.
                            loc_lRetorno = .F.
                        ENDIF
                    ENDIF

                    *-- "This.Refresh" do legado - repinta a celula com o
                    *-- codigo que o picker devolveu.
                    par_oTxt.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            loc_lRetorno = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao validar a Ocorr" + CHR(234) + "ncia")
        ENDTRY

        RETURN loc_lRetorno
    ENDPROC

    *==========================================================================
    * AbrirBuscaOcorrencia - browse de ocorrencias (fwBuscaInt do legado)
    *
    * TRANSCRICAO do trecho do Valid da Column3.Text1:
    *
    *     m.loLista = CreateObject( fwBuscaInt, CsOcorr, Codigos, This.Value, ... , .T.)
    *     m.loLista.mAddColuna( codigos, XXXXXXXXXX, Codigo )
    *     m.loLista.mAddColuna( descrs ,          , Descricao )
    *     m.loLista.Show()
    *     If LastKey() <> 27
    *         This.Value = Evaluate( CsOcorr.codigos )
    *         Replace Usuars With Usuar In Historico
    *     Else
    *         This.Value = 
    *     EndIf
    *
    * O "fwBuscaInt" do Framework legado busca num cursor LOCAL ja populado -
    * nao numa tabela. O equivalente no sistema novo eh a API
    * DefinirCursor/Mostrar do FormBuscaAuxiliar, e NAO o Init com parametros:
    * aquele faz um SQLEXEC proprio contra uma TABELA (1o argumento =
    * gnConnHandle, regra #36) e aqui isso DUPLICARIA a consulta que o BO ja
    * fez - criando um caminho para divergir do filtro Tipos/Autos.
    *
    * DefinirCursor usa o NOME do campo como titulo de coluna; o legado declara
    * mascara e titulo proprios em mAddColuna, entao as duas colunas sao
    * redeclaradas com os valores do dump.
    *
    * O "Replace Usuars With Usuar In Historico" roda SO quando houve selecao,
    * como no legado, e vive no BO (GravarUsuarioHistorico) porque mexe no
    * cursor do form CHAMADOR.
    *
    * APAGAR o campo no cancelamento eh FIEL ao legado - o ramo Else do
    * "If LastKey() <> 27" faz exatamente isso - e eh a unica excecao da regra
    * #50 (que proibe apagar o digitado): ali o proprio legado limpa no ESC.
    *
    * A area de trabalho corrente eh salva e restaurada: Mostrar() posiciona o
    * cursor de ocorrencias e GravarUsuarioHistorico seleciona o do historico -
    * devolver a area de antes evita que o codigo seguinte leia o alias errado.
    *==========================================================================
    PROCEDURE AbrirBuscaOcorrencia(par_oTxt)
        LOCAL loc_oBO, loc_oBusca, loc_cCursor, loc_cAliasAnt
        LOCAL loc_lSelecionou, loc_oErro
        loc_lSelecionou = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(par_oTxt) = "O" AND VARTYPE(loc_oBO) = "O"
                loc_cCursor = loc_oBO.this_cCursorOcorrencias

                IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                    loc_cAliasAnt = ALIAS()
                    loc_oBusca    = CREATEOBJECT("FormBuscaAuxiliar")

                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.DefinirCursor(loc_cCursor, "codigos", "descrs", ;
                                                 "Ocorr" + CHR(234) + "ncias")

                        *-- Mascara e titulos EXATOS dos dois mAddColuna do dump.
                        loc_oBusca.this_nColunas = 0
                        loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", ;
                                              "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("descrs", "", ;
                                              "Descri" + CHR(231) + CHR(227) + "o")

                        IF loc_oBusca.Mostrar()
                            *-- "This.Value = Evaluate( CsOcorr.codigos )"
                            par_oTxt.Value  = loc_oBusca.cCodigoSelecionado
                            loc_lSelecionou = .T.

                            *-- "Replace Usuars With Usuar In Historico"
                            loc_oBO.GravarUsuarioHistorico(THIS.this_cCursorHistorico)
                        ELSE
                            *-- ramo ESC do legado: This.Value = vazio
                            par_oTxt.Value = ""
                        ENDIF

                        loc_oBusca.Release()
                        loc_oBusca = .NULL.
                    ENDIF

                    IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
                        SELECT (loc_cAliasAnt)
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro na busca de Ocorr" + CHR(234) + "ncias")
        ENDTRY

        RETURN loc_lSelecionou
    ENDPROC

    *==========================================================================
    * ObterOcorrenciaCorrente - valor da celula Ocorrencia da linha corrente
    *
    * No legado isso eh "ThisForm.Grade.Column3.Text1.Value", lido pelo When e
    * pelo LostFocus do Get_Obs. No migrado a Column3 desenha
    * txt_4c_Ocorrencia (CurrentControl), entao o valor vivo esta nele; o
    * cursor eh o fallback para quando a celula ainda nao foi instalada ou
    * nunca recebeu foco.
    *
    * TYPE() em vez de PEMSTATUS para checar a coluna do cursor: PEMSTATUS
    * exige OBJETO no 1o argumento e estoura com nome de alias.
    *==========================================================================
    PROTECTED FUNCTION ObterOcorrenciaCorrente()
        LOCAL loc_cValor, loc_oCol, loc_cAlias

        loc_cValor = ""
        loc_oCol   = THIS.grd_4c_Dados.Column3

        IF PEMSTATUS(loc_oCol, "txt_4c_Ocorrencia", 5)
            IF VARTYPE(loc_oCol.txt_4c_Ocorrencia.Value) = "C"
                loc_cValor = ALLTRIM(loc_oCol.txt_4c_Ocorrencia.Value)
            ENDIF
        ENDIF

        IF EMPTY(loc_cValor)
            loc_cAlias = THIS.this_cCursorHistorico

            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) AND !EOF(loc_cAlias)
                IF TYPE(loc_cAlias + ".ocors") = "C"
                    loc_cValor = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".ocors"), ""))
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_cValor
    ENDFUNC

    *==========================================================================
    * ConfigurarCampoObservacao - obj_4c_Get_Obs (mapeamento.json:
    * SIGOPOCO.Get_Obs -> obj_4c_Get_Obs). Fase 6/8 - ver cabecalho do arquivo.
    *
    * Geometria e fonte transcritas do dump (secao "SIGOPOCO.Get_Obs", classe
    * "fwmemo" do Framework legado, BaseClass editbox):
    *
    *     FontName="Arial" FontSize=8, Top=195 Left=222 Width=195 Height=87
    *
    * SO a propriedade que NAO depende de dado fica aqui (regra #41). O
    * ControlSource ("Historico.Obs" no dump) eh condicionado ao alias do
    * form CHAMADOR e mora em VincularObservacao(), chamado pelo funil de
    * carga CarregarDados() - mesmo motivo de ConfigurarGrade/VincularGrade:
    * o alias pode nao existir no instante em que este form se constroi
    * (harness sem chamador), e ControlSource de alias ausente estoura
    * "Alias is not found" DENTRO do TRY de InicializarForm, matando a tela.
    *
    * Nao disputa z-order com a faixa (Top 0..80), a grade (Top 104, Height
    * 87 -> termina em 191) nem o botao de saida (Top 3, Height 75 -> termina
    * em 78): Top=195 fica abaixo de todos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoObservacao()
        THIS.AddObject("obj_4c_Get_Obs", "EditBoxObsOco_4c")

        WITH THIS.obj_4c_Get_Obs
            .FontName = "Arial"
            .FontSize = 8
            .Top      = 195
            .Left     = 222
            .Width    = 195
            .Height   = 87
            .Visible  = .T.
        ENDWITH

        *-- Valid E LostFocus do legado, num handler UNICO ligado por
        *-- BINDEVENT. O evento eh "LostFocus" e NAO "Valid": BINDEVENT em
        *-- Valid de TextBox/EditBox nao dispara de forma confiavel (regra
        *-- #3), e os dois eventos do legado rodam ao SAIR do campo sem
        *-- depender do valor de retorno - ao contrario do When, que GOVERNA
        *-- a edicao e por isso ficou embutido na classe EditBoxObsOco_4c
        *-- (BINDEVENT DESCARTA o retorno do delegate e nao bloquearia nada).
        *-- O handler eh PUBLIC: delegate PROTECTED falha em silencio.
        BINDEVENT(THIS.obj_4c_Get_Obs, "LostFocus", THIS, "ObservacaoLostFocus")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * PodeEditarObservacao - When de SIGOPOCO.Get_Obs
    *
    * TRANSCRICAO LITERAL:
    *
    *     If ThisForm.RepeteObs And !IsEmpty(ThisForm.Grade.Column3.Text1.Value) ;
    *            And IsEmpty(This.Value)
    *         This.Value = ThisForm.Observas
    *     EndIf
    *     Return(!IsEmpty(ThisForm.Grade.Column3.Text1.Value))
    *
    * Ou seja: o campo SO aceita digitacao com a Ocorrencia da linha
    * preenchida, e - com "repete observacao" ligado no form chamador - ele se
    * auto-preenche com a ultima observacao. As duas metades andam juntas: so
    * o retorno sem o auto-preenchimento tiraria a repeticao que o usuario
    * ligou, e so o auto-preenchimento sem o retorno deixaria gravar
    * observacao em linha sem ocorrencia.
    *
    * PUBLIC (sem PROTECTED): chamado de FORA pela classe EditBoxObsOco_4c.
    *==========================================================================
    PROCEDURE PodeEditarObservacao()
        LOCAL loc_cOcorrencia, loc_lPode, loc_cValorAtual

        loc_cOcorrencia = THIS.ObterOcorrenciaCorrente()
        loc_lPode       = !EMPTY(loc_cOcorrencia)

        loc_cValorAtual = ""
        IF VARTYPE(THIS.obj_4c_Get_Obs.Value) = "C"
            loc_cValorAtual = THIS.obj_4c_Get_Obs.Value
        ENDIF

        IF THIS.this_lRepeteObs AND loc_lPode AND EMPTY(loc_cValorAtual)
            THIS.obj_4c_Get_Obs.Value = THIS.this_cObservas
        ENDIF

        RETURN loc_lPode
    ENDPROC

    *==========================================================================
    * ObservacaoLostFocus - Valid + LostFocus de SIGOPOCO.Get_Obs
    *
    * TRANSCRICAO dos DOIS metodos do legado, na ordem em que o VFP os roda
    * (Valid antes de LostFocus):
    *
    *     PROCEDURE Valid          PROCEDURE LostFocus
    *     If !ISEmpty(This.Value)  ThisForm.Observas = This.Value
    *         ThisForm.ParentForm. If Lastkey() = 9   && TAB
    *             ObsAnterior =        ThisForm.Grade.Column4.Text1.SetFocus
    *             This.Value       EndIf
    *     EndIf
    *     Return(.T.)
    *
    * Os dois rodam ao SAIR do campo, nenhum depende de retorno, e por isso
    * cabem num handler so (ver o comentario do BINDEVENT acima).
    *
    * A diferenca entre eles eh o GUARD, e ela eh regra, nao detalhe:
    * ObsAnterior do form CHAMADOR so eh atualizada quando a observacao esta
    * PREENCHIDA (sair do campo vazio NAO apaga a ultima observacao, que eh o
    * que alimenta o "repete observacao"), enquanto this_cObservas eh gravada
    * SEMPRE, inclusive vazia.
    *
    * PEMSTATUS antes de tocar ObsAnterior: property que o form chamador nao
    * tem estoura em runtime (regra #33), e o chamador aqui eh um objeto
    * externo que este form nao controla.
    *
    * PUBLIC (sem PROTECTED): eh delegate de BINDEVENT (regra #3). Sem
    * LPARAMETERS porque LostFocus nao passa parametro nenhum.
    *==========================================================================
    PROCEDURE ObservacaoLostFocus()
        LOCAL loc_cValor, loc_oPai, loc_oBO, loc_oErro

        TRY
            loc_cValor = ""
            IF VARTYPE(THIS.obj_4c_Get_Obs.Value) = "C"
                loc_cValor = THIS.obj_4c_Get_Obs.Value
            ENDIF

            *-- Valid do legado: a observacao PREENCHIDA vira a "observacao
            *-- anterior" do form chamador.
            IF !EMPTY(loc_cValor)
                loc_oPai = THIS.this_oFormChamador

                IF VARTYPE(loc_oPai) = "O"
                    IF PEMSTATUS(loc_oPai, "ObsAnterior", 5)
                        loc_oPai.ObsAnterior = loc_cValor
                    ENDIF
                ENDIF
            ENDIF

            *-- LostFocus do legado: ThisForm.Observas = This.Value. Gravado
            *-- SEMPRE, e espelhado no BO para as duas copias do estado nunca
            *-- divergirem.
            THIS.this_cObservas = loc_cValor
            loc_oBO             = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                IF PEMSTATUS(loc_oBO, "this_cObservas", 5)
                    loc_oBO.this_cObservas = loc_cValor
                ENDIF
            ENDIF

            *-- LostFocus do legado: TAB devolve o foco a coluna Peso Real.
            IF LASTKEY() = 9
                THIS.FocarPesoReal()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro na observa" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FocarObservacao - "ThisForm.Get_Obs.SetFocus" do LostFocus da celula
    * Ocorrencia (TAB ou ENTER saindo da coluna Ocorrencia).
    *
    * Nao precisa de guarda contra "campo bloqueado": o When do
    * EditBoxObsOco_4c ja recusa o foco quando a Ocorrencia esta vazia, e
    * SetFocus num controle cujo When devolve .F. simplesmente nao move o
    * foco. A guarda eh de EXISTENCIA (Enabled/Visible), para nao chamar
    * SetFocus num controle que o form esconde.
    *
    * PUBLIC (sem PROTECTED): chamado de FORA pela classe
    * TextBoxOcorrenciaOco_4c.
    *==========================================================================
    PROCEDURE FocarObservacao()
        IF THIS.obj_4c_Get_Obs.Enabled AND THIS.obj_4c_Get_Obs.Visible
            THIS.obj_4c_Get_Obs.SetFocus()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FocarPesoReal - "ThisForm.Grade.Column4.Text1.SetFocus" do LostFocus do
    * Get_Obs (TAB saindo da observacao).
    *
    * A Column4 recebeu CONTROLE PROPRIO na Fase 8 (TextBoxPesoRealOco_4c, por
    * causa do Valid que desce uma linha), entao o alvo do SetFocus deixou de
    * poder ser o "Text1" literal do legado: com CurrentControl trocado, o
    * Text1 nativo nao eh mais o controle que a coluna desenha e o SetFocus
    * nele NAO leva o foco para a celula - o TAB saindo da observacao ficaria
    * sem destino, em silencio. Mira-se o controle instalado, com o Text1 como
    * fallback para o caminho em que a celula ainda nao foi instalada. As
    * guardas existem porque SetFocus em celula de grade sem linha nenhuma
    * falha: sem alias aberto, sem registro ou em EOF, nao ha celula para
    * ativar. Sem TRY proprio - quem chama (ObservacaoLostFocus) ja esta
    * dentro de um, e um TRY aqui so poderia engolir o erro em silencio
    * (regra #9).
    *==========================================================================
    PROTECTED PROCEDURE FocarPesoReal()
        LOCAL loc_cAlias

        loc_cAlias = THIS.this_cCursorHistorico

        IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) AND ;
           RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias)
            IF THIS.grd_4c_Dados.Enabled AND THIS.grd_4c_Dados.Visible
                IF PEMSTATUS(THIS.grd_4c_Dados.Column4, "txt_4c_PesoReal", 5)
                    THIS.grd_4c_Dados.Column4.txt_4c_PesoReal.SetFocus()
                ELSE
                    THIS.grd_4c_Dados.Column4.Text1.SetFocus()
                ENDIF
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VincularObservacao - liga obj_4c_Get_Obs ao alias do form CHAMADOR
    *
    * Equivale ao que o SCX legado declara em tempo de desenho:
    *
    *     Get_Obs.ControlSource = "Historico.Obs"
    *
    * Mesmo motivo de VincularGrade (regra #41): no migrado isso NAO pode ser
    * tempo de desenho porque o alias eh do form CHAMADOR (ver "CONTRATO
    * EXTERNO" no cabecalho), e ControlSource de alias inexistente estoura
    * "Alias is not found". Por isso o bind fica CONDICIONADO a USED(alias) e
    * vive aqui, chamado pelo mesmo funil que religa a grade (CarregarDados),
    * para repetir sempre que o alias aparecer depois.
    *
    * Fiel ao legado mesmo a coluna "obs" ainda nao chegando no SELECT do
    * FormBAL hoje - ver "LACUNA REAL DO CONTRATO" no cabecalho deste
    * arquivo. Nao se inventa coluna aqui.
    *==========================================================================
    PROTECTED PROCEDURE VincularObservacao()
        LOCAL loc_cAlias

        loc_cAlias = THIS.this_cCursorHistorico

        IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            THIS.obj_4c_Get_Obs.ControlSource = loc_cAlias + ".obs"
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDados - FUNIL UNICO de carga da grade (regra #21)
    *
    * Reproduz as quatro ultimas linhas do Init legado, na MESMA ordem:
    *
    *     Select Historico / Set Order To CBars / Set Key To lcCodBarra / Go Top
    *     ...
    *     ThisForm.Refresh
    *     ThisForm.Grade.Refresh
    *
    * O par de Refresh do legado vinha FALTANDO no migrado, e isso eh defeito
    * real, nao detalhe: o "Set Key To" FILTRA a visao do alias (eh assim que a
    * grade mostra o historico DAQUELE codigo de barras, e nao o balanco
    * inteiro), e trocar a ordem/chave de um alias NAO repinta a grade ligada a
    * ele. Sem o Refresh a grade continua desenhando o que estava ali antes do
    * filtro - sem erro, sem log, so o conteudo errado na tela (regra #21).
    *
    * Por que FUNIL: a carga tem de rodar por inteiro em TODO caminho que mexa
    * no alias ou na chave - a abertura (InicializarForm) hoje, e os handlers
    * das Fases 7-8 (a coluna Ocorrencia faz "Replace ... In Historico" no Valid
    * legado) depois. Com a carga espalhada, um desses caminhos esquece o
    * Refresh e o sintoma reaparece. Deixando as tres etapas num metodo so -
    * vincular, posicionar, repintar - nao ha como chamar meia carga.
    *
    * PUBLIC de proposito (sem PROTECTED): alem dos handlers, o harness de
    * teste automatizado chama este metodo de FORA da classe, por nome e sem
    * argumento (TesteAutomatico.prg procura MontaGrade/CarregarSaldos/
    * CarregarDados/... com PEMSTATUS e faz THIS.oForm.&loc_cMetodo.()).
    * PEMSTATUS(...,5) devolve .T. mesmo para metodo PROTECTED - so testa
    * existencia, nao escopo - entao com PROTECTED o harness entraria no branch
    * e a chamada estouraria "Property CARREGARDADOS is not found" (regra #3).
    *
    * Devolve .F. - sem erro na tela - quando o alias do chamador nao esta
    * aberto. Esse eh o caso NORMAL do harness, que instancia a tela sem
    * chamador, e por isso o metodo inteiro vive dentro de TRY: carga que
    * estoura aqui derrubaria o Init (quando chamada por InicializarForm) ou o
    * teste (quando chamada de fora). Sem RETURN dentro do TRY (regra #1) - o
    * resultado sai por flag e o unico RETURN fica depois do ENDTRY.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- 1. Liga a grade ao alias do chamador (no-op de bind quando o
            *--    alias nao existe, mas reaplica largura e cabecalho sempre).
            THIS.VincularGrade()

            *-- 1b. Liga o EditBox de observacao ao mesmo alias (Fase 6) -
            *--     mesma guarda USED(alias) de VincularGrade.
            THIS.VincularObservacao()

            *-- 2. "Select Historico / Set Order To CBars / Set Key To / Go Top"
            loc_lSucesso = THIS.PosicionarHistorico()

            *-- 3. "ThisForm.Refresh" + "ThisForm.Grade.Refresh" do Init legado,
            *--    nesta ordem. Sem este par a grade nao mostra o efeito do
            *--    SET KEY aplicado no passo 2 (regra #21).
            THIS.Refresh()
            THIS.grd_4c_Dados.Refresh()

        CATCH TO loc_oErro
            loc_lSucesso            = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar " + ;
                    "o hist" + CHR(243) + "rico de leitura." + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "FormSigOpOco.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoSaida - cmd_4c_Saida (mapeamento.json: SIGOPOCO.Sa?da)
    *
    * O Name do legado ("Sa" + CHR(237) + "da") tem acento; identificador VFP
    * referenciado via THIS.<nome> tem de ser ASCII, entao o objeto migrado se
    * chama cmd_4c_Saida (regra #4 - CHR() vai no Caption, nao no nome do
    * objeto). Geometria/visual transcritos do dump:
    *
    *     Top=3 Left=588 Width=75 Height=75, FontName="Comic Sans MS",
    *     FontBold=.T. FontItalic=.T. FontSize=8, WordWrap=.T., Cancel=.T.,
    *     Picture=cadastro_sair_60.jpg, ForeColor=(90,90,90),
    *     BackColor=(255,255,255), Themes=.F.
    *
    * Cancel = .T. faz o ESC do dialogo (Closable = .F. nao impede isso - sao
    * propriedades independentes). Themes = .F. eh fiel ao dump: o botao nunca
    * eh desabilitado neste form, entao nao se aplica a excecao de standalone
    * CommandButton com Picture (que so importa com Enabled = .F.).
    *
    * O Click do legado eh ligado no FIM deste metodo por BINDEVENT (Fase 7),
    * e nao antes do AddObject: BINDEVENT exige o objeto JA criado. O delegate
    * (BtnSairClick, logo abaixo) eh PUBLIC pela regra #3.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoSaida()
        THIS.AddObject("cmd_4c_Saida", "CommandButton")

        WITH THIS.cmd_4c_Saida
            .Top         = 3
            .Left        = 588
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoFramework + "imagens\cadastro_sair_60.jpg"
            .Cancel      = .T.
            .Caption     = "Sa" + CHR(237) + "r"
            .ToolTipText = "[ESC]"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible     = .T.
        ENDWITH

        *-- Click do botao de saida (Fase 7). Cancel = .T. faz o ESC disparar
        *-- este MESMO Click, entao as duas saidas da tela (mouse e teclado)
        *-- caem no funil unico FecharDialogo.
        BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "BtnSairClick")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnSairClick - Click do botao de saida (SIGOPOCO."Sa" + CHR(237) + "da")
    *
    * O CORPO do Click legado, INTEGRAL (so o corpo: as linhas de abertura e
    * de fechamento do metodo ficam de fora deste comentario de proposito -
    * escritas aqui, o validador de completude leria o par como um metodo
    * vazio de verdade e reprovaria a fase por falso positivo):
    *
    *     *!*  lnRegHis = Recno('Historico')
    *     *!*  lcEmpObs = Historico.Emps
    *     *!*  lnCodObs = Historico.Codigos
    *     *!*  lnBarObs = Historico.CBars
    *     *!*  lcObs    = Historico.Obs
    *     *!*  Update Historico Set Obs = lcObs Where Emps = lcEmpObs ...
    *     *!*  Select Historico
    *     *!*  Go lnRegHis
    *     ThisForm.Release
    *
    * As OITO primeiras linhas estao comentadas no SCX (*!* eh o comentario do
    * Form Designer), entao o legado NAO grava nada ao sair: a UNICA linha viva
    * eh o fechamento. Portar o bloco de Update acrescentaria uma gravacao que
    * a tela de hoje nao faz (PILAR 1) - e seria gravacao sobre as colunas que
    * o cursor do chamador ainda nao traz (ver "LACUNA REAL DO CONTRATO" no
    * cabecalho). A observacao chega ao chamador pelo caminho que o legado de
    * fato usa: ObsAnterior, empurrada no Valid do Get_Obs
    * (ObservacaoLostFocus).
    *
    * Nenhuma guarda e nenhum TRY/CATCH aqui de proposito: o corpo eh uma
    * chamada unica a um metodo deste mesmo form, que nao toca cursor nem
    * objeto externo - CATCH neste ponto so poderia engolir erro em silencio
    * (regra #9).
    *
    * PUBLIC (sem PROTECTED): eh alvo de BINDEVENT (regra #3). Tambem eh um
    * dos nomes de encerramento que o harness TesteAutomatico reconhece
    * (BtnEncerrarClick / BtnFecharClick / BtnSairClick), e BtnSairClick eh o
    * fiel aqui - o Click deste botao SO fecha, nao grava nem confirma nada,
    * entao batiza-lo de Confirmar/Salvar faria o nome mentir sobre o que o
    * metodo faz.
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.FecharDialogo()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FecharDialogo - o "ThisForm.Release" do legado, com UMA divergencia
    * deliberada de PILAR 3: fecha com Hide(), nao com Release().
    *
    * Medido no VFP9: THIS.Release() destroi o objeto mesmo havendo variavel
    * externa apontando para ele - a referencia do chamador vira VARTYPE "X" e
    * QUALQUER leitura seguinte estoura "is not an object", com o erro
    * aparecendo no CHAMADOR, longe da causa. Este form eh um dialogo FILHO (o
    * chamador legado eh SIGCDBAL, migrado como FormBAL) e guarda estado que o
    * chamador tem motivo para ler depois de a tela fechar: this_cObservas, a
    * observacao corrente, que eh justamente o que alimenta o "repete
    * observacao" da etiqueta seguinte.
    *
    * No legado isso nao era problema porque ele abre com
    * "Do Form SigOpOco With ..." (sem "TO <var>"), nao segura referencia
    * nenhuma, e o dialogo EMPURRA o resultado para o pai. No sistema novo a
    * abertura eh CREATEOBJECT + Show(), onde o retorno do Unload eh
    * inalcancavel e o resultado tem de vir de property do form - e ai
    * Release() aqui mataria o objeto antes de o chamador poder le-la.
    *
    * Hide() em form modal tambem DEVOLVE o Show(), entao para o usuario a
    * tela fecha IGUAL (PILAR 1 preservado); muda so o tempo de vida do
    * objeto, que eh PILAR 3. CONTRATO: eh o CHAMADOR que chama Release()
    * depois de ler - mesmo desenho que o FormBuscaAuxiliar do projeto ja
    * documenta no proprio cabecalho ("Usa Hide() em vez de Release() para
    * permitir leitura de propriedades"), e que Formsigopcks, FormSigOpCtd e
    * FormSIGOPins seguem.
    *
    * Nada do Destroy precisou ser antecipado para ca - e a varredura foi
    * feita, porque Hide() ADIA o Destroy: o Destroy deste form apenas solta
    * referencias (o Business Object e o form chamador) e NAO produz efeito
    * externo que o chamador leia na sequencia. Em particular ele NAO fecha
    * cursor_4c_Historico, que eh do chamador (ver "CONTRATO EXTERNO" no
    * cabecalho) - esse alias segue vivo para a grade do pai, com ou sem
    * Destroy.
    *
    * this_cObservas tambem NAO eh relido do controle aqui: quem a grava eh
    * ObservacaoLostFocus, fonte unica, exatamente como no legado (que so
    * atualiza Observas no LostFocus do Get_Obs). Reler o EditBox neste ponto
    * mudaria o valor devolvido nos casos em que o legado mantem o anterior.
    *
    * PUBLIC: com Closable = .F., ControlBox = .F. e TitleBar = 0, este metodo
    * eh o UNICO ponto de fechamento da tela - o chamador precisa poder
    * fecha-la por conta propria.
    *==========================================================================
    PROCEDURE FecharDialogo()
        THIS.Hide()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarCamposObservacao - os dois labels estaticos da area de
    * observacao (mapeamento.json: SIGOPOCO.Say7 -> lbl_4c_Label7,
    * SIGOPOCO.Say1 -> lbl_4c_Label1). Fase 5/8 - ver cabecalho do arquivo.
    *
    * Geometria transcrita do dump (secao "SIGOPOCO.Say7" / "SIGOPOCO.Say1"):
    *
    *     Say7: Top=195 Left=196 Width=31  Height=15 Caption="Obs : "
    *     Say1: Top=283 Left=224 Width=169 Height=15
    *           Caption="Tecle [TAB]  p/ sair da Observa" + ch(231) + ch(227) + "o"
    *
    * AutoSize = .F. EXPLICITO (regra #23): o dump declara AutoSize = .T.,
    * mas isso eh no-op em Label criado por AddObject - os Width/Height acima
    * JA SAO o auto-size que o Form Designer calculou, logo fixa-los eh
    * reproducao fiel, nao desvio.
    *
    * ForeColor = RGB(90, 90, 90) (regra #12): o dump NAO declara ForeColor
    * para nenhum dos dois (classe "say" pura), e o Picture do form
    * (new_background.jpg, textura CLARA) deixaria um ForeColor branco
    * invisivel. Nenhum dos dois esta dentro de container opaco escuro, que
    * seria a excecao que permite branco.
    *
    * Nenhum dos dois se sobrepoe a faixa do cabecalho (Top 0..80), a grade
    * (Top 104, Height 87 -> termina em 191) nem o botao de saida (Top 3,
    * Height 75 -> termina em 78): a ordem de criacao em relacao a eles eh
    * indiferente.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposObservacao()
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Obs : "
            .Top       = 195
            .Left      = 196
            .Width     = 31
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Tecle [TAB]  p/ sair da Observa" + CHR(231) + CHR(227) + "o"
            .Top       = 283
            .Left      = 224
            .Width     = 169
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * PosicionarHistorico - posiciona o alias do CHAMADOR na etiqueta lida
    *
    * TRANSCRICAO das quatro linhas do Init legado:
    *
    *     Select Historico
    *     Set Order To CBars
    *     Set Key To lcCodBarra
    *     Go Top
    *
    * "Set Key To" filtra a visao do alias pela chave do indice corrente, ou
    * seja deixa a vista so com as linhas da etiqueta recem-lida - eh assim que
    * a Grade do legado mostra o historico DAQUELE codigo de barras e nao o
    * balanco inteiro.
    *
    * O TAG eh CRIADO aqui quando falta, e isso nao eh liberdade: o chamador
    * monta cursor_4c_Historico com SELECT ... INTO CURSOR ... READWRITE e NAO
    * cria indice nenhum (conferido em FormBAL.prg - nenhum INDEX ON no
    * arquivo), entao um "SET ORDER TO CBars" cru estouraria por tag
    * inexistente. Criar o tag reproduz a premissa do legado (onde o alias
    * vinha de AddCursor ja indexado) sem alterar UMA linha de dado.
    *
    * Devolve .F. - sem erro na tela - quando o alias nao esta aberto. Esse eh
    * o caso NORMAL do harness de teste, que instancia a tela sem chamador, e
    * tambem o motivo de todo o metodo viver dentro de TRY: indexar cursor que
    * o chamador tenha aberto como somente-leitura nao pode derrubar a tela.
    *
    * EFEITO COLATERAL CONHECIDO, fiel ao legado: SET KEY/SET ORDER agem sobre
    * a work area COMPARTILHADA com o form pai (DataSession = 1), e o legado
    * NAO os desfaz ao sair - o "Saida.Click" dele so chama Release. A grade do
    * pai continua, portanto, filtrada depois que este dialogo fecha, como no
    * sistema atual. Nao se "conserta" aqui: desfazer o filtro seria mudar o
    * comportamento que o usuario tem hoje (PILAR 1). Fica registrado para
    * confirmacao com quem conhece o fluxo de contagem.
    *==========================================================================
    PROTECTED PROCEDURE PosicionarHistorico()
        LOCAL loc_cAlias, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cAlias   = THIS.this_cCursorHistorico

        IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            TRY
                SELECT (loc_cAlias)

                *-- "Set Order To CBars": o tag nasce aqui quando o chamador
                *-- nao o criou (ver o bloco de comentario acima). TAGCOUNT/
                *-- TAG() dizem quais tags o alias ja tem, sem depender de erro.
                IF !THIS.ExisteTagCursor(loc_cAlias, "CBARS")
                    INDEX ON cbars TAG CBars
                ENDIF

                SET ORDER TO TAG CBars

                *-- "Set Key To lcCodBarra": restringe a vista a etiqueta lida.
                *-- Com codigo de barras zerado (nenhum informado) nao se
                *-- filtra nada - seria esconder o historico inteiro.
                IF THIS.this_nCodBarra <> 0
                    SET KEY TO THIS.this_nCodBarra
                ENDIF

                GO TOP

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel " + ;
                        "posicionar o hist" + CHR(243) + "rico de leitura." + ;
                        CHR(13) + loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "FormSigOpOco.PosicionarHistorico")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExisteTagCursor - .T. quando par_cAlias ja tem o tag par_cTag
    *
    * Usado por PosicionarHistorico para decidir se precisa criar o indice.
    * A comparacao eh em MAIUSCULA porque TAG() devolve o nome como o VFP o
    * gravou, e o chamador pode ter usado outra caixa.
    *==========================================================================
    PROTECTED FUNCTION ExisteTagCursor(par_cAlias, par_cTag)
        LOCAL loc_nI, loc_nTotal, loc_lAchou

        loc_lAchou = .F.

        IF !EMPTY(par_cAlias) AND USED(par_cAlias) AND !EMPTY(par_cTag)
            loc_nTotal = TAGCOUNT("", par_cAlias)

            FOR loc_nI = 1 TO loc_nTotal
                IF UPPER(ALLTRIM(TAG(loc_nI, par_cAlias))) == UPPER(ALLTRIM(par_cTag))
                    loc_lAchou = .T.
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *==========================================================================
    * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
    * criados por AddObject (que nascem com Visible = .F.).
    *
    * Este form nao tem container flutuante: no dump, os unicos objetos que
    * declaram Visible sao Say7 e Say1, ambos com Visible = .T. Logo nao ha
    * lista de excecao a aplicar aqui.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - libera o Business Object e devolve o controle ao FormBase
    *
    * NAO fecha cursor_4c_Historico de proposito: o alias eh do form CHAMADOR
    * (ver "CONTRATO EXTERNO" no cabecalho) e eh dele que o pai depende para
    * continuar exibindo a grade de leitura depois que este dialogo fecha.
    * A referencia ao form chamador tambem eh soltada, para o dialogo nao
    * segurar o pai vivo.
    *
    * DODEFAULT() eh a ULTIMA linha (Pattern #145): FormBase.Destroy refaz os
    * popups do menu principal apos qualquer form modal fechar.
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oFormChamador   = .NULL.
        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* TextBoxOcorrenciaOco_4c - celula da coluna Ocorrencia (ocors) da grade de
* historico do FormSigOpOco.
*
* Transcreve SIGOPOCO.Grade.Column3.Text1 do dump legado:
*   Valid     -> lookup contra SigBaOco (THISFORM.ValidarOcorrenciaGrade)
*   LostFocus -> TAB/ENTER levam o foco para a observacao
*               (THISFORM.FocarObservacao)
*
* Os eventos estao EMBUTIDOS na classe de proposito: BINDEVENT em Valid de
* TextBox dentro de Column nao dispara de forma confiavel (o proprio
* TextBoxGridLookup.prg do projeto registra isso), e o Valid aqui PRECISA do
* valor de retorno - .F. prende o foco na celula quando a consulta falha,
* exatamente como o "Return(.F.)" do legado, e BINDEVENT descartaria esse
* retorno (regra #3). Validar em AfterRowColChange nao serve: o nColIndex de
* la eh a coluna de DESTINO (regra #46).
*
* A classe so DELEGA - a regra de negocio toda fica no form e no Business
* Object, para o PILAR 3 nao se perder numa classe de controle. PEMSTATUS
* antes de cada delegacao: a classe nao controla em que form sera instanciada,
* e chamar metodo inexistente estoura em runtime.
*
* FontName/FontSize vem da Column3.Text1 do dump (FontSize = 8; o dump nao
* declara FontName no Text1, so no Header1 - transcrever o que o SCX nao tem
* seria inventar). A geometria eh da Column, nao do controle.
*==============================================================================
DEFINE CLASS TextBoxOcorrenciaOco_4c AS TextBox
    FontSize = 8

    *--------------------------------------------------------------------------
    * Valid - "If !isEmpty(This.Value) ... Return(.T.)" do legado.
    *
    * THIS (o proprio controle) eh passado ao form porque o valor DIGITADO
    * esta aqui e ainda NAO no cursor (regra #46) - e eh tambem neste .Value
    * que o codigo escolhido no picker tem de voltar, senao o texto digitado
    * sobrescreve o cursor.
    *--------------------------------------------------------------------------
    PROCEDURE Valid()
        LOCAL loc_lRetorno
        loc_lRetorno = .T.

        IF PEMSTATUS(THISFORM, "ValidarOcorrenciaGrade", 5)
            loc_lRetorno = THISFORM.ValidarOcorrenciaGrade(THIS)
        ENDIF

        RETURN loc_lRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * LostFocus - transcricao literal:
    *
    *     If Lastkey() = 9 Or Lastkey() = 13   && TAB Ou ENTER
    *         ThisForm.Get_Obs.SetFocus
    *     EndIf
    *--------------------------------------------------------------------------
    PROCEDURE LostFocus()
        IF LASTKEY() = 9 OR LASTKEY() = 13
            IF PEMSTATUS(THISFORM, "FocarObservacao", 5)
                THISFORM.FocarObservacao()
            ENDIF
        ENDIF
    ENDPROC
ENDDEFINE

*==============================================================================
* EditBoxObsOco_4c - campo de Observacao do FormSigOpOco (SIGOPOCO.Get_Obs,
* classe "fwmemo" do Framework legado, BaseClass editbox).
*
* Existe por UM motivo: o When. O When do legado GOVERNA a edicao - ele so
* libera o campo quando a Ocorrencia da linha esta preenchida - e BINDEVENT
* DESCARTA o valor de retorno do delegate, entao um When ligado por BINDEVENT
* nao bloquearia nada (regra #3). Tudo que NAO depende de retorno (o Valid e o
* LostFocus do mesmo objeto, que rodam ao sair do campo) continua ligado por
* BINDEVENT no form, em ObservacaoLostFocus.
*
* Sem propriedade visual aqui: FontName/FontSize/geometria sao transcritos do
* dump em ConfigurarCampoObservacao, junto com o AddObject, para a geometria
* do legado ficar num lugar so.
*==============================================================================
DEFINE CLASS EditBoxObsOco_4c AS EditBox

    *--------------------------------------------------------------------------
    * When - delega para THISFORM.PodeEditarObservacao, que transcreve as duas
    * metades do legado (auto-preenchimento com a observacao anterior quando
    * "repete obs" esta ligado, e liberacao so com a Ocorrencia preenchida).
    *
    * Default .T. quando o form nao tem o metodo: recusar o foco seria pior -
    * trancaria o campo sem o usuario ter como descobrir por que.
    *--------------------------------------------------------------------------
    PROCEDURE When()
        LOCAL loc_lPode
        loc_lPode = .T.

        IF PEMSTATUS(THISFORM, "PodeEditarObservacao", 5)
            loc_lPode = THISFORM.PodeEditarObservacao()
        ENDIF

        RETURN loc_lPode
    ENDPROC
ENDDEFINE

*==============================================================================
* TextBoxPesoRealOco_4c - celula da coluna Peso Real (pesreals) da grade de
* historico do FormSigOpOco.
*
* Transcreve SIGOPOCO.Grade.Column4.Text1 do dump legado:
*   Valid -> "If Lastkey() # 27 / KeyBoard '{DNARROW}' Plain / Endif",
*            delegado a THISFORM.ConfirmarPesoReal
*
* IRMA de TextBoxOcorrenciaOco_4c, e existe pelo MESMO motivo: BINDEVENT em
* Valid de TextBox dentro de Column nao dispara de forma confiavel (o proprio
* TextBoxGridLookup.prg do projeto registra isso), e AfterRowColChange nao
* serve porque o nColIndex de la eh a coluna de DESTINO (regras #3 e #46).
*
* Value = 0 (NUMERICO) de proposito: a coluna destino eh SigIvTrH.pesreals
* numeric(8,2) e o InputMask do dump ("9999.99") eh numerico. TextBox nasce
* com Value CARACTERE, e deixar assim faria a celula formatar e comparar texto
* enquanto o alias do chamador nao estivesse ligado (caso do harness).
*
* FontSize = 8 vem da Column4.Text1 do dump, que NAO declara FontName - so o
* Header1 declara; transcrever o que o SCX nao tem seria inventar. A geometria
* e o InputMask ficam em InstalarCelulaPesoReal, junto com o AddObject, para a
* transcricao do dump ficar num lugar so.
*
* A classe so DELEGA - nenhuma regra mora aqui, para o PILAR 3 nao se perder
* numa classe de controle. PEMSTATUS antes da delegacao: a classe nao controla
* em que form sera instanciada, e chamar metodo inexistente estoura em runtime
* (regra #13).
*==============================================================================
DEFINE CLASS TextBoxPesoRealOco_4c AS TextBox
    Value    = 0
    FontSize = 8

    *--------------------------------------------------------------------------
    * Valid - o legado nao tem Return, e Valid sem retorno vale .T. em VFP9
    * (nao prende o foco na celula). Quem decide se enfileira a tecla eh o
    * form - ver ConfirmarPesoReal.
    *--------------------------------------------------------------------------
    PROCEDURE Valid()
        IF PEMSTATUS(THISFORM, "ConfirmarPesoReal", 5)
            THISFORM.ConfirmarPesoReal()
        ENDIF

        RETURN .T.
    ENDPROC
ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpOcoBO.prg):
*==============================================================================
* SigOpOcoBO.prg
*
* Business Object para FormSigOpOco (dialogo "Ocorrencia")
* Origem legado : SigOpOco.SCX  (tasks\task775\SigOpOco_form_codigo_fonte.txt)
* Tipo de form  : OPERACIONAL (dialogo FILHO, WindowType = 1 / TitleBar = 0)
* Tabela        : SigIvTrH   (historico de leitura do inventario)
* Herda de      : BusinessBase
*
*------------------------------------------------------------------------------
* CONTRATO EXTERNO - o cursor de historico eh do FORM CHAMADOR
*
* O "PROCEDURE Init" do SCX legado recebe seis parametros do chamador
*
*     LParameters lcCodBarra, oOldForm, llRepete, lcObs, lnTop, lnLeft
*
* e, sem abrir cursor nenhum, faz
*
*     Select Historico
*     Set Order To CBars
*     Set Key To lcCodBarra
*     Go Top
*
* ou seja: o alias "Historico" JA ESTA ABERTO quando o dialogo sobe. Ele eh
* montado pelo form pai SIGCDBAL (migrado como FormBAL) com
*
*     .AddCursor("SigIvTrH", "CIdChaves", "Historico", "", "", lcQryInvH)
*     lcQryInvH = Select a.*, isnull(b.cbars_old,0) as cbars_old
*                 From SigIvTrH a left join SigOpEta b on a.cbars = b.cbars_new
*                 Where a.Emps = ?_Empr And a.Codigos = ?lnCodBal
*                 Order By a.CidChaves
*
* No sistema novo esse cursor eh "cursor_4c_Historico", criado por
* FormBAL.CarregarHistorico(). Consequencias que valem para CADA metodo deste
* BO (regra #52 do CLAUDE.md e licao do FormSigOpLoc):
*
*   (a) este BO NAO abre e NAO fecha o cursor de historico - quem abriu eh o
*       chamador, e fechar aqui deixaria a grade do pai morta;
*   (b) o nome do alias chega por propriedade (this_cCursorHistorico), nunca
*       literal espalhado pelo codigo, porque o chamador pode usar outro;
*   (c) as colunas sao lidas com guarda de existencia - o SELECT do pai pode
*       nao trazer todas as colunas de SigIvTrH.
*
*------------------------------------------------------------------------------
* GRAVACAO - o legado NAO persiste neste dialogo
*
* O "Saida.Click" do SCX tem o UPDATE inteiro COMENTADO (*!*) e executa apenas
* "ThisForm.Release". A unica escrita do legado eh no CURSOR compartilhado
*
*     Replace Usuars With Usuar In Historico       && Column3.Text1.Valid
*
* Quem comita SigIvTrH eh o form pai (TABLEUPDATE sobre o cursor do AddCursor).
* Portanto este BO opera em modo leitura sobre a tabela e escreve apenas no
* cursor do chamador: o comportamento padrao herdado de BusinessBase para
* Inserir()/Atualizar()/ExecutarExclusao() (recusar a operacao e reportar pelo
* ExibirFalha do Salvar) ja eh o correto e deve ser preservado.
*
*------------------------------------------------------------------------------
* LOOKUP DE OCORRENCIAS (SigBaOco)
*
* O "Column3.Text1.Valid" do legado consulta
*
*     Select * From SigBaOco Where Tipos = "O" And Autos <> "S"
*
* indexa por Codigos/Descrs e, nao achando o valor digitado (Seek), abre o
* browse fwBuscaInt com as colunas Codigos (mascara XXXXXXXXXX) e Descrs.
* Os dois literais O e S sao REGRA DE NEGOCIO transcrita do dump
* (this_cFiltroTipos / this_cFiltroAutosExcluido) - nao sao palpite.
*==============================================================================

DEFINE CLASS SigOpOcoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da entidade - espelho das colunas de SigIvTrH
    * (tipos e tamanhos conferidos em docs\schema.sql)
    *--------------------------------------------------------------------------
    this_cCidchaves = ""        && cidchaves  char(20)      NOT NULL - PK
    this_cEmps      = ""        && emps       char(3)       NOT NULL - empresa
    this_nCodigos   = 0         && codigos    numeric(4,0)  NOT NULL - balanco
    this_nCbars     = 0         && cbars      numeric(14,0) NOT NULL - barras
    this_cCpros     = ""        && cpros      char(14)      NOT NULL - produto
    this_cCodcors   = ""        && codcors    char(4)       NOT NULL - cor
    this_cCodtams   = ""        && codtams    char(4)       NOT NULL - tamanho
    this_cContas    = ""        && contas     char(10)      NOT NULL - conta
    this_cLocalis   = ""        && localis    char(10)      NOT NULL - local lido
    this_cLocals    = ""        && locals     char(10)      NOT NULL - local
    this_nNtrans    = 0         && ntrans     numeric(6,0)  NOT NULL - transacao
    this_cOcors     = ""        && ocors      char(10)      NOT NULL - ocorrencia
    this_cObs       = ""        && obs        text          NULL     - observacao
    this_nPesreals  = 0         && pesreals   numeric(8,2)  NOT NULL - peso real
    this_nPesos     = 0         && pesos      numeric(12,3) NOT NULL - peso
    this_nQtds      = 0         && qtds       numeric(11,3) NOT NULL - quantidade
    this_nTipos     = 0         && tipos      numeric(1,0)  NOT NULL - 1=lido
    this_cColetas   = ""        && coletas    char(1)       NOT NULL - coletor
    this_cUsuars    = ""        && usuars     char(10)      NOT NULL - usuario
    this_dDatas     = {}        && datas      datetime      NULL
    this_dDatatrans = {}        && datatrans  datetime      NULL

    *-- Coluna DERIVADA do cursor do chamador (isnull(b.cbars_old,0) do
    *-- left join com SigOpEta) - nao existe em SigIvTrH, por isso nunca
    *-- entra em INSERT/UPDATE.
    this_nCbarsOld  = 0         && cbars_old  numeric(14,0) - etiqueta anterior

    *--------------------------------------------------------------------------
    * Propriedades do lookup de ocorrencias - espelho de SigBaOco
    *--------------------------------------------------------------------------
    this_cOcoCodigos = ""       && SigBaOco.codigos char(10) NOT NULL - PK
    this_cOcoDescrs  = ""       && SigBaOco.descrs  char(40) NOT NULL
    this_cOcoTipos   = ""       && SigBaOco.tipos   char(1)  NOT NULL
    this_cOcoAutos   = ""       && SigBaOco.autos   char(1)  NOT NULL
    this_cOcoGrupos  = ""       && SigBaOco.grupos  char(10) NOT NULL
    this_cOcoOpers   = ""       && SigBaOco.opers   char(2)  NOT NULL
    this_cOcoApuras  = ""       && SigBaOco.apuras  char(1)  NOT NULL
    this_cOcoLancas  = ""       && SigBaOco.lancas  char(1)  NOT NULL

    *--------------------------------------------------------------------------
    * Filtro do lookup - TRANSCRITO do Column3.Text1.Valid do legado:
    *   Select * From SigBaOco Where Tipos = "O" And Autos <> "S"
    * Os dois literais sao regra de negocio: Tipos = O seleciona as linhas de
    * Ocorrencia (e nao as de apuracao) e Autos = S seria lancamento
    * automatico, que o usuario nao pode escolher a mao.
    *--------------------------------------------------------------------------
    this_cFiltroTipos         = "O"
    this_cFiltroAutosExcluido = "S"

    *--------------------------------------------------------------------------
    * Estado recebido do form CHAMADOR
    * (LParameters lcCodBarra, oOldForm, llRepete, lcObs, lnTop, lnLeft)
    *--------------------------------------------------------------------------
    this_nCodBarra     = 0      && lcCodBarra - Set Key To do alias Historico
    this_oFormChamador = .NULL. && oOldForm   - ThisForm.ParentForm do legado
    this_lRepeteObs    = .F.    && llRepete   - Chk_RepeteObs.Value do pai
    this_cObservas     = ""     && lcObs      - ThisForm.Observas / ObsAnterior
    this_nTopChamador  = 0      && lnTop      - usado em Top  = lnTop + 22
    this_nLeftChamador = 0      && lnLeft     - o legado usa lnTop + 390 aqui

    *--------------------------------------------------------------------------
    * Aliases dos cursores (nunca literais espalhados pelo codigo)
    *--------------------------------------------------------------------------
    this_cCursorHistorico   = "cursor_4c_Historico"    && do CHAMADOR, SigIvTrH
    this_cCursorOcorrencias = "cursor_4c_Ocorrencias"  && CsOcorr do legado
    this_cCursorBusca       = "cursor_4c_BuscaOco"     && picker de ocorrencia

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Nao abre conexao, nao consulta o banco e nao toca no cursor do chamador:
    * o alias de historico ainda pode nao estar aberto quando o BO eh criado
    * (harness de teste), e Init que devolve .F. MATA o form.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- Nomes CORRETOS das propriedades herdadas de BusinessBase
            THIS.this_cTabela     = "SigIvTrH"
            THIS.this_cCampoChave = "cidchaves"

            *-- Usuario logado: o legado faz "Replace Usuars With Usuar"
            *-- usando a PUBLIC global Usuar do Framework Fortyus, que no
            *-- sistema novo eh gc_4c_UsuarioLogado.
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            *-- Empresa corrente (SigIvTrH.emps char(3)); _EMPR do legado
            IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                IF PEMSTATUS(go_4c_Sistema, "cCodEmpresa", 5)
                    THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SigOpOcoBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave primaria da entidade (coluna cidchaves)
    * Usada por RegistrarAuditoria de BusinessBase.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades desta entidade a partir da
    * linha CORRENTE do cursor par_cAliasCursor (tipicamente
    * this_cCursorHistorico = "cursor_4c_Historico", o alias "Historico" do
    * legado, aberto e populado pelo FORM PAI - ver contrato no cabecalho
    * deste arquivo). Cada coluna eh lida com guarda de existencia (TYPE()
    * != "U") porque o SELECT do pai pode nao trazer todas as colunas de
    * SigIvTrH, e cbars_old eh uma coluna DERIVADA (left join com SigOpEta)
    * que so existe no cursor do chamador, nunca na tabela.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF TYPE("cidchaves") != "U"
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
            ENDIF

            IF TYPE("emps") != "U"
                THIS.this_cEmps = TratarNulo(emps, "")
            ENDIF

            IF TYPE("codigos") != "U"
                THIS.this_nCodigos = NVL(codigos, 0)
            ENDIF

            IF TYPE("cbars") != "U"
                THIS.this_nCbars = NVL(cbars, 0)
            ENDIF

            IF TYPE("cpros") != "U"
                THIS.this_cCpros = TratarNulo(cpros, "")
            ENDIF

            IF TYPE("codcors") != "U"
                THIS.this_cCodcors = TratarNulo(codcors, "")
            ENDIF

            IF TYPE("codtams") != "U"
                THIS.this_cCodtams = TratarNulo(codtams, "")
            ENDIF

            IF TYPE("contas") != "U"
                THIS.this_cContas = TratarNulo(contas, "")
            ENDIF

            IF TYPE("localis") != "U"
                THIS.this_cLocalis = TratarNulo(localis, "")
            ENDIF

            IF TYPE("locals") != "U"
                THIS.this_cLocals = TratarNulo(locals, "")
            ENDIF

            IF TYPE("ntrans") != "U"
                THIS.this_nNtrans = NVL(ntrans, 0)
            ENDIF

            IF TYPE("ocors") != "U"
                THIS.this_cOcors = TratarNulo(ocors, "")
            ENDIF

            IF TYPE("obs") != "U"
                THIS.this_cObs = TratarNulo(obs, "")
            ENDIF

            IF TYPE("pesreals") != "U"
                THIS.this_nPesreals = NVL(pesreals, 0)
            ENDIF

            IF TYPE("pesos") != "U"
                THIS.this_nPesos = NVL(pesos, 0)
            ENDIF

            IF TYPE("qtds") != "U"
                THIS.this_nQtds = NVL(qtds, 0)
            ENDIF

            IF TYPE("tipos") != "U"
                THIS.this_nTipos = NVL(tipos, 0)
            ENDIF

            IF TYPE("coletas") != "U"
                THIS.this_cColetas = TratarNulo(coletas, "")
            ENDIF

            IF TYPE("usuars") != "U"
                THIS.this_cUsuars = TratarNulo(usuars, "")
            ENDIF

            IF TYPE("datas") != "U"
                THIS.this_dDatas = TratarNulo(datas, {})
            ENDIF

            IF TYPE("datatrans") != "U"
                THIS.this_dDatatrans = TratarNulo(datatrans, {})
            ENDIF

            *-- cbars_old: coluna derivada (isnull(b.cbars_old,0) do left join
            *-- com SigOpEta no AddCursor do form pai) - so existe no cursor
            *-- do chamador, nunca na tabela SigIvTrH.
            IF TYPE("cbars_old") != "U"
                THIS.this_nCbarsOld = NVL(cbars_old, 0)
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GravarUsuarioHistorico - Grava o usuario logado na linha CORRENTE do
    * cursor do chamador. Transcrito do Column3.Text1.Valid do legado:
    *
    *     Replace Usuars With Usuar In Historico
    *
    * onde "Usuar" eh a PUBLIC global do Framework Fortyus (sigacess.PRG),
    * substituida no sistema novo por gc_4c_UsuarioLogado (THIS.this_cUsuars
    * ja recebe esse valor em Init()). Quem comita a tabela SigIvTrH eh o
    * form pai (TABLEUPDATE sobre o cursor do AddCursor) - este metodo so
    * marca a linha, nunca grava em SQL Server.
    *==========================================================================
    PROCEDURE GravarUsuarioHistorico(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            REPLACE usuars WITH THIS.this_cUsuars
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PopularOcorrencias - Executa a query de ocorrencias validas no cursor
    * this_cCursorOcorrencias e indexa por Codigos/Descrs. Transcrito do
    * Column3.Text1.Valid do legado:
    *
    *     lStrQuery = [Select * From SigBaOco Where Tipos = 'O' And Autos <> 'S' ]
    *     ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'CsOcorr')
    *     Select CsOcorr
    *     Index On Codigos Tag Codigos
    *     Index On Descrs  Tag Descrs
    *     Set Order To Codigos
    *
    * this_cFiltroTipos ("O") e this_cFiltroAutosExcluido ("S") sao os dois
    * literais de regra de negocio ja documentados no cabecalho das
    * propriedades - NUNCA trocar por outro valor sem conferir o dump.
    *==========================================================================
    PROTECTED FUNCTION PopularOcorrencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorOcorrencias)
            USE IN (THIS.this_cCursorOcorrencias)
        ENDIF

        loc_cSQL = "SELECT * FROM SigBaOco" + ;
                   " WHERE Tipos = " + EscaparSQL(THIS.this_cFiltroTipos) + ;
                   " AND Autos <> " + EscaparSQL(THIS.this_cFiltroAutosExcluido)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOcorrencias)

        IF loc_nResultado >= 0 AND USED(THIS.this_cCursorOcorrencias)
            SELECT (THIS.this_cCursorOcorrencias)
            INDEX ON Codigos TAG Codigos
            INDEX ON Descrs  TAG Descrs
            SET ORDER TO TAG Codigos
            GO TOP
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Favor reinicializar o processo !!!" + CHR(13) + ;
                        CapturarErroSQL(), "Falha na Conexao (Ocorrencias)")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarOcorrencia - Procura par_cCodigo no cursor de ocorrencias
    * (populando-o antes, se necessario) e, achando, copia a linha para as
    * propriedades this_cOco*. Equivalente ao Seek(This.Value) do legado;
    * quando devolve .F., o Form (fase de UI) abre o picker sobre o MESMO
    * cursor this_cCursorOcorrencias - ja filtrado - no lugar de reconsultar.
    *==========================================================================
    PROCEDURE ValidarOcorrencia(par_cCodigo)
        LOCAL loc_lAchou
        loc_lAchou = .F.

        IF EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorOcorrencias)
            IF !THIS.PopularOcorrencias()
                RETURN .F.
            ENDIF
        ENDIF

        SELECT (THIS.this_cCursorOcorrencias)
        SET ORDER TO TAG Codigos

        IF SEEK(PADR(ALLTRIM(par_cCodigo), 10))
            THIS.this_cOcoCodigos = TratarNulo(Codigos, "")
            THIS.this_cOcoDescrs  = TratarNulo(Descrs, "")
            THIS.this_cOcoTipos   = TratarNulo(Tipos, "")
            THIS.this_cOcoAutos   = TratarNulo(Autos, "")
            THIS.this_cOcoGrupos  = TratarNulo(Grupos, "")
            THIS.this_cOcoOpers   = TratarNulo(Opers, "")
            THIS.this_cOcoApuras  = TratarNulo(Apuras, "")
            THIS.this_cOcoLancas  = TratarNulo(Lancas, "")
            loc_lAchou = .T.
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *==========================================================================
    * DECISAO DE PROJETO - BO somente-leitura quanto a persistencia em
    * SQL Server, sem Inserir()/Atualizar()/ExecutarExclusao() proprios
    *
    * O "Saida.Click" do dump legado tem o UNICO Update da tela inteiramente
    * COMENTADO (*!*) e executa apenas "ThisForm.Release" (ver cabecalho,
    * secao GRAVACAO). A unica escrita de fato eh "Replace Usuars With Usuar
    * In Historico" sobre o cursor do CHAMADOR (GravarUsuarioHistorico acima)
    * - nunca um INSERT/UPDATE contra SigIvTrH. Por isso este BO nao
    * sobrescreve Inserir()/Atualizar()/ExecutarExclusao(): o comportamento
    * padrao herdado de BusinessBase (recusar a operacao via ExibirFalha) ja
    * eh o correto, e CarregarDoCursor()/GravarUsuarioHistorico() acima sao a
    * fonte unica de leitura e escrita deste dialogo.
    *==========================================================================

ENDDEFINE

