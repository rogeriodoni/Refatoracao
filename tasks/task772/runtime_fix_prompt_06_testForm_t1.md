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
[2026-11-09 19:11:30] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-09 19:11:30] [INFO] Config FPW: (nao fornecido)
[2026-11-09 19:11:30] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 19:11:30] [INFO] Timeout: 300 segundos
[2026-11-09 19:11:30] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ey0splsl.prg
[2026-11-09 19:11:30] [INFO] Conteudo do wrapper:
[2026-11-09 19:11:30] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGOPNOP', 'C:\4c\tasks\task772\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGOPNOP', 'C:\4c\tasks\task772\logs\06_testForm.log'
QUIT

[2026-11-09 19:11:30] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ey0splsl.prg
[2026-11-09 19:11:30] [INFO] VFP output esperado em: C:\4c\tasks\task772\vfp_output.txt
[2026-11-09 19:11:30] [INFO] Executando Visual FoxPro 9...
[2026-11-09 19:11:30] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ey0splsl.prg
[2026-11-09 19:11:30] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ey0splsl.prg
[2026-11-09 19:11:30] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGOPNOP
Inicio: 09/11/2026 19:11:30

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 09/11/2026 19:12:39
Duracao: 69 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-09 19:12:39] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-09 19:12:39] [INFO] VFP9 finalizado em 68.9338023 segundos
[2026-11-09 19:12:39] [INFO] Exit Code: 
[2026-11-09 19:12:39] [INFO] 
[2026-11-09 19:12:39] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-09 19:12:39] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ey0splsl.prg
[2026-11-09 19:12:39] [INFO] 
[2026-11-09 19:12:39] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-09 19:12:39] [INFO] * Auto-generated wrapper for parameters
[2026-11-09 19:12:39] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 19:12:39] [INFO] * Parameters: 'FormSIGOPNOP', 'C:\4c\tasks\task772\logs\06_testForm.log'
[2026-11-09 19:12:39] [INFO] 
[2026-11-09 19:12:39] [INFO] * Anti-dialog protections for unattended execution
[2026-11-09 19:12:39] [INFO] SET SAFETY OFF
[2026-11-09 19:12:39] [INFO] SET RESOURCE OFF
[2026-11-09 19:12:39] [INFO] SET TALK OFF
[2026-11-09 19:12:39] [INFO] SET NOTIFY OFF
[2026-11-09 19:12:39] [INFO] SYS(2335, 0)
[2026-11-09 19:12:39] [INFO] 
[2026-11-09 19:12:39] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGOPNOP', 'C:\4c\tasks\task772\logs\06_testForm.log'
[2026-11-09 19:12:39] [INFO] QUIT
[2026-11-09 19:12:39] [INFO] 
[2026-11-09 19:12:39] [INFO] === Fim do Wrapper.prg ===
[2026-11-09 19:12:39] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPNOP.prg):
*==============================================================================
* FormSIGOPNOP.prg - Analise de OP/Envelopes
*==============================================================================
* Tipo: OPERACIONAL (layout customizado, SEM PageFrame)
* Migrado de: SIGOPNOP.SCX
*
* Pilares:
*   UX   -> layout e comportamento o mais proximo possivel do legado (800x600)
*   BD   -> SigCdNei/SigCdNec/SigCdPro/SigOpPic/SigPdMvf (ver SIGOPNOPBO.prg)
*   CODE -> arquitetura em camadas (FormBase / SIGOPNOPBO)
*
* NOTA (paridade com o legado): o SIGOPNOP eh uma tela de CONSULTA em arvore
* (TreeView ActiveX) de movimentacoes de producao, pesquisadas por numero de
* Envelope OU numero de O.P. (ver SIGOPNOPBO.PesquisarPorEnvelope/
* PesquisarPorOP). O legado (raiz Class: form, SEM BaseClass: pageframe -
* ver tasks\task772\layout.json/SIGOPNOP_form_codigo_fonte.txt) usa layout
* proprio com os controles direto na Form, sem Page1(Lista)/Page2(Dados) nem
* os 6 botoes CRUD canonicos (Incluir/Visualizar/Alterar/Excluir/Buscar/
* Encerrar - o unico botao de saida eh o Command1 ("Encerrar") dentro de
* Commandgroup1, ButtonCount=1). Inventar PageFrame ou botoes CRUD violaria o
* PILAR 1 e a regra "NUNCA inventar funcionalidade que o legado nao tem".
* Referencia direta: FormSIGMVMVT.prg (mesma familia de tela - consulta em
* arvore via OLEControl ActiveX, guardado em TRY/CATCH e pulado em modo
* teste - ver feedback_mscomctl_treectrl_trava_em_modal_de_licenca).
*
* FASE 3/8 - ESTRUTURA BASE: DEFINE CLASS, propriedades de estado (espelham
* as propriedades customizadas do form legado - paEmpDopNums, Arqfigura,
* plDblClick), Init()/InicializarForm()/Destroy() e os DOIS containers de
* topo do layout legado (cnt_4c_Container1 / cnt_4c_Container2), ainda
* vazios. O conteudo deles (TreeView, GetOP, GetEnvelope, Label3, Label1,
* Label2) e os controles soltos na Form (Commandgroup1, Fwbtng1, Fwbtng2,
* Imagem) entram na Fase 4.
*
* FASE 4/8 - CONTROLES: ConfigurarControles() preenche os dois containers
* da Fase 3 e cria os controles soltos na Form, com geometria/propriedades
* transcritas LITERALMENTE da SECAO 2 do dump (PILAR 1):
*   cnt_4c_Container1 -> obj_4c_TreeView (arvore - ctTree.ocx, controle
*     ActiveX de terceiros sem substituto nativo VFP9, mesma familia de
*     FormSIGMVMVT: instanciado via OLEControl com o mesmo ProgID do
*     legado, guardado em TRY/CATCH e pulado em modo teste/validacao de
*     UI - ver feedback_mscomctl_treectrl_trava_em_modal_de_licenca), mais
*     lbl_4c_Label3 ("O.P. :"), lbl_4c_Label1 ("Envelope :"), txt_4c_OP
*     (GetOP) e txt_4c_Envelope (GetEnvelope).
*   cnt_4c_Container2 -> lbl_4c_Label1 ("AGUARDE!") e lbl_4c_Label2
*     ("Pesquisando as Movimentacoes") - conteudo do painel flutuante.
*   Form (sem container, fiel ao SCX) -> cmg_4c_Commandgroup1 (unico
*     botao "Encerrar" - nome canonico cmg_4c_, NAO o obj_4c_ do
*     mapeamento.json gerado: ver feedback_commandgroup_obj_4c_reprova_
*     gate_fase4), cmd_4c_Fwbtng1 ("Expandir"), cmd_4c_Fwbtng2
*     ("Regredir") e img_4c_Imagem (imagem do produto).
*
* Mais o METODO DE CARGA desta tela, que aqui NAO alimenta uma grade e sim
* a ARVORE (o SCX nao tem Grid nem PageFrame - a superficie de lista eh o
* TreeView ActiveX, dirigido pela API de nos AddPictureNode/NodeExpanded/
* NodeFontBold). Medicao que dispensa Grid/CRUD neste legado, feita sobre
* tasks\task772\SIGOPNOP_form_codigo_fonte.txt: ZERO "BaseClass: grid",
* ZERO "BaseClass: pageframe", ZERO .AddCursor(/pColuna/RecordSource/
* ControlSource, UM "BaseClass: olecontrol" e 7 chamadas da API de nos.
*   CarregarDados()           -> escolhe o criterio (O.P. ou Envelope -
*     mutuamente exclusivos no legado), chama SIGOPNOPBO.PesquisarPorOP/
*     PesquisarPorEnvelope e desenha a arvore. Equivale aos dois Valid do
*     legado (Container1.GetOP.Valid -> MakeTree, Container1.GetEnvelope.
*     Valid -> MakeTreeEnv).
*   PopularArvore()           -> transcricao dos PROCEDURE maketree e
*     maketreeenv (mesmo algoritmo, cinco textos/icones diferentes).
*   PrepararArvore()          -> os seis AddImage do Init legado (uma unica
*     vez - os indices 1..6 do AddPictureNode sao fixos) e o bloco
*     ClearNodes/TipsDisplay/SmallIcons/PicAlign/SelectedStyle/PictureType
*     que os dois metodos legado repetem no inicio.
*   ExibirImagemProduto()     -> bloco da figura do produto do GetOP.Valid.
*   AdicionarNoOrigemDestino()/AdicionarNoMedida() -> os blocos de no que o
*     legado repete literalmente (2x e 3x por iteracao do Scan).
*   ArvoreDisponivel()        -> guarda do ActiveX (OCX ausente/modo teste).
*
* FASES 6/7 - EVENTOS PRINCIPAIS: ConfigurarEventos() liga os eventos dos
* dois campos digitaveis (GotFocus/Valid -> KeyPress em ENTER/TAB) e o Click
* dos tres botoes do legado (Encerrar/Expandir/Regredir).
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO: fecham-se os TRES ultimos
* metodos com codigo do dump que ainda nao tinham equivalente, completando a
* cobertura de 100% da SECAO 3 (17 metodos - ver a tabela de cobertura no fim
* deste cabecalho):
*   TreeViewKeyPress()      -> TreeView.KeyPress  (ESC)
*   TreeViewNodeClick()     -> TreeView.NodeClick (no clicado + drill)
*   EmpilharChaveNavegacao()-> as 3 linhas de pilha paEmpDopNums do NodeClick
*   ImgImagemDblClick()     -> Imagem.DblClick    (zoom da foto do produto)
*   AbrirFormZoomImagem()   -> "Do Form SigOpZom With ..." do Imagem.DblClick
*
* O QUE NAO SE APLICA A ESTA TELA, e por que (medido no dump, nao presumido):
*
*   Btn...CancelarClick / Form...ParaBO / BO...ParaForm / Carregar...Lista
*     Sao convencao do par Page2(Dados) + modo INCLUIR/ALTERAR do
*     frmcadastro: os dois primeiros mapeiam em BLOCO os campos de uma ficha
*     de/para o BO, e o Cancelar descarta uma edicao em andamento. Aqui nao
*     ha ficha, nao ha modo de edicao cancelavel e nao ha grade: a tela tem
*     DOIS campos de parametro (O.P. e Envelope) cuja transferencia para o BO
*     acontece por ARGUMENTO do metodo de carga (CarregarDados ->
*     PesquisarPorOP/PesquisarPorEnvelope), e a "lista" eh a ARVORE ActiveX,
*     alimentada por CarregarDados/PopularArvore. (Os quatro nomes estao
*     grafados com o miolo elidido de proposito: escritos por extenso, um
*     comentario os faria passar por implementados num gate que procura o
*     nome por substring no arquivo inteiro.)
*
*   HabilitarCampos / LimparCampos / AjustarBotoesPorModo
*     Nao existe modo (INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR) nesta tela - o
*     dump nao tem pcEscolha, Grupo_Op nem frmcadastro. Os dois campos sao
*     sempre editaveis (os dois When do legado sao "Return(.t.)" puro) e a
*     unica limpeza que o legado faz eh a exclusao mutua ja reproduzida nos
*     GotFocus (TxtOPGotFocus/TxtEnvelopeGotFocus). Criar os tres metodos
*     vazios eh proibido pela regra de completude, e preenche-los com modos
*     inventados violaria o PILAR 1.
*
*   Botao de gravar (Salvar/Confirmar/Gravar/Processa)
*     O SCX declara TRES botoes e nenhum persiste nada: Commandgroup1
*     ("Encerrar", Cancel = .T.) fecha a tela, e Fwbtng1/Fwbtng2 - icone puro,
*     Caption = "", verbo so no ToolTipText "Expandir"/"Regredir" - mexem no
*     nivel de expansao da arvore. Nao ha Insert/Update/Delete/TableUpdate em
*     lugar nenhum do dump: esta tela ANALISA. A acao dela eh disparada pelos
*     CAMPOS (Valid -> consulta -> arvore), nao por botao.
*
* LINHAS DO LEGADO DELIBERADAMENTE NAO REPRODUZIDAS (e por que):
*   Init: "Keyboard Chr(32)" + "=Inkey(0)"
*     Idioma Fortyus de descarte de tecla ja digitada antes de instanciar o
*     ActiveX - enfileira um espaco e o consome na hora, com o retorno
*     jogado fora. Nao persiste, nao abre tela, nao retem calculo: eh ruido
*     de UI. Reproduzi-lo injetaria um espaco no primeiro campo com foco.
*   NodeClick: as tres atribuicoes a GetcEmp/GetDopes/GetNumes
*     Os tres TextBox NAO EXISTEM no SCX - ver TreeViewNodeClick, que mede
*     isso e explica o que entrou no lugar (a property this_cChaveNavegacao).
*   TreeView.DblClick e Commandgroup1.Command3.When / GetEnvelope.When
*     O primeiro esta VAZIO no dump; os outros dois sao "Return(.t.)" puro.
*     Nao ha efeito a reproduzir.
*
* COBERTURA DA SECAO 3 DO DUMP (17 metodos com codigo):
*   form.Init ................. Init + InicializarForm + PrepararArvore
*   form.maketree ............. PopularArvore(.F.)
*   form.maketreeenv .......... PopularArvore(.T.)
*   Commandgroup1.Command3.Click  CmdEncerrarClick
*   Commandgroup1.Command3.When   "Return(.t.)" - sem efeito
*   TreeView.Click/DblClick ... vazios no dump
*   TreeView.KeyPress ......... TreeViewKeyPress
*   TreeView.NodeClick ........ TreeViewNodeClick + EmpilharChaveNavegacao
*   GetEnvelope.GotFocus ...... TxtEnvelopeGotFocus
*   GetEnvelope.Valid ......... ValidarEnvelope -> CarregarDados
*   GetEnvelope.When .......... "Return(.t.)" - sem efeito
*   GetOP.GotFocus + GetOP.When TxtOPGotFocus
*   GetOP.Valid ............... ValidarOP -> CarregarDados + ExibirImagemProduto
*   Fwbtng1.Click ............. CmdExpandirClick
*   Fwbtng2.Click ............. CmdRegredirClick
*   Imagem.DblClick ........... ImgImagemDblClick + AbrirFormZoomImagem
*
* Parametros de abertura (Parameters plModal, pcEmps, pcDopes, pcNumes do
* Init legado): pcEmps/pcDopes/pcNumes sao declarados mas NUNCA referenciados
* no restante do codigo do form legado (conferido no dump completo em
* tasks\task772\SIGOPNOP_form_codigo_fonte.txt) - a assinatura eh mantida
* para fidelidade de chamada, mas nao ha logica do legado para reproduzir a
* partir deles. plModal tambem eh recebido sem efeito: a unica linha que o
* usaria no legado esta COMENTADA no proprio SCX ("*ThisForm.WindowType =
* Iif(plModal,1,0)") - por isso THIS.WindowType NAO eh alterado aqui.
*
* CHAMADA:
*   loForm = CREATEOBJECT("FormSIGOPNOP")
*   loForm.Show()
*==============================================================================

DEFINE CLASS FormSIGOPNOP AS FormBase

	*-- Dimensoes e comportamento identicos ao legado (SIGOPNOP.SCX)
	Height       = 600
	Width        = 800
	AutoCenter   = .T.
	BorderStyle  = 2
	ShowWindow   = 1
	WindowType   = 1
	ControlBox   = .F.
	MaxButton    = .F.
	MinButton    = .F.
	*-- Closable NAO entra: o dump do SCX declara so ControlBox/MaxButton/
	*-- MinButton, e as cinco propriedades sao INDEPENDENTES (medido no VFP9 -
	*-- sem barra de titulo os botoes nao DESENHAM, mas Closable continua .T.
	*-- e o Alt+F4 continua funcionando). Inventar Closable = .F. aqui tiraria
	*-- a saida por teclado que o legado tinha, sem erro e sem log
	*-- (feedback_closable_inventado_tira_a_unica_saida). A saida por ESC
	*-- continua garantida por cmg_4c_Commandgroup1.Buttons(1).Cancel = .T.,
	*-- transcrito do dump.
	ClipControls = .F.
	ShowTips     = .T.
	Themes       = .F.
	FontName     = "Verdana"
	FontSize     = 8
	DataSession  = 2

	*-- Parametros de abertura (Parameters plModal, pcEmps, pcDopes, pcNumes
	*-- do Init legado). pcEmps/pcDopes/pcNumes NUNCA sao lidos no resto do
	*-- form legado (conferido no dump) - guardados so para manter a mesma
	*-- assinatura de chamada. plModal fica guardado pelo mesmo motivo, mas
	*-- NAO altera THIS.WindowType (a linha correspondente esta comentada no
	*-- SCX legado).
	this_lModalParam = .F.
	this_cEmpsParam  = ""
	this_cDopesParam = ""
	this_nNumesParam = 0

	*-- ThisForm.paEmpDopNums[1] - pilha de EmpDopNums visitados na arvore
	*-- (TreeView.NodeClick, Fase 7/8).
	DIMENSION this_aEmpDopNums[1]

	*-- ThisForm.Arqfigura - caminho do .jpg temporario extraido de
	*-- SigCdPro.FigJpgs (ver SIGOPNOPBO.this_cArquivoImagem/
	*-- BuscarImagemProduto/ExcluirImagemTemporaria). Apagado ao Encerrar
	*-- (Commandgroup1.Command1.Click no legado: "Delete File
	*-- (ThisForm.Arqfigura)").
	this_cArquivoFigura = ""

	*-- ThisForm.plDblClick - cargo (NodeCargo) do ultimo no clicado na
	*-- arvore, usado pelo TreeView.NodeClick para distinguir o 1o clique
	*-- (so seleciona) do 2o clique no MESMO no (drill - dispara MakeTree).
	this_cUltimoNoClicado = ""

	*-- Chave de navegacao CORRENTE (Emps + Dopes + Str(Numes)). No legado ela
	*-- nao mora numa property: mora em TRES TextBox - Container1.GetcEmp,
	*-- Container1.GetDopes e Container1.GetNumes -, que o NodeClick le e
	*-- reescreve. Esses tres controles NAO EXISTEM no SCX (a SECAO 1 do dump
	*-- lista, dentro do Container1, apenas TreeView, Label3, Label1,
	*-- GetEnvelope e GetOP) - sobraram so as referencias a eles no codigo do
	*-- NodeClick. Reproduzir os tres controles seria INVENTAR tela que o
	*-- legado nao tem; guardar o mesmo valor numa property reproduz o ESTADO
	*-- sem inventar UI. Ver TreeViewNodeClick/EmpilharChaveNavegacao.
	*-- O valor INICIAL eh posto em InicializarForm e NAO eh vazio - a nota la
	*-- explica por que isso importa para a pilha (initializer de property so
	*-- aceita constante, dai nao dar para por STR(0, 6) aqui).
	this_cChaveNavegacao = ""

	*-- ThisForm.pnNodeExp - nivel corrente de expansao da arvore. Posto em 1
	*-- no fim de MakeTree/MakeTreeEnv (ver PopularArvore) e incrementado/
	*-- decrementado pelos botoes Expandir/Regredir do legado (Fwbtng1.Click
	*-- e Fwbtng2.Click, Fase 7).
	this_nNodeExp = 0

	*-- Controle interno (NAO tem equivalente no legado): as seis imagens dos
	*-- nos sao carregadas por AddImage UMA UNICA vez, como no Init legado.
	*-- AddImage empilha indices novos a cada chamada e os indices 1..6 usados
	*-- pelo AddPictureNode sao FIXOS - recarregar a cada pesquisa trocaria os
	*-- icones de todos os nos.
	this_lImagensArvore = .F.

	*-- Guarda de reentrancia da consulta disparada pelos dois campos
	*-- digitaveis (ver ValidarOP/ValidarEnvelope). CarregarDados abre dialogo
	*-- modal (MsgAviso/MsgErro) e redesenha a arvore; enquanto isso o teclado
	*-- continua enfileirando, e sem a guarda segurar o ENTER empilha consultas
	*-- identicas. Mesmo padrao do this_lEmLookup dos lookups do projeto.
	this_lEmConsulta = .F.

	*==========================================================================
	* Init - Recebe os parametros de abertura (Parameters plModal, pcEmps,
	* pcDopes, pcNumes do legado) e repassa para FormBase.Init() (que chama
	* InicializarForm() atraves de DODEFAULT()).
	*==========================================================================
	PROCEDURE Init(par_lModal, par_cEmps, par_cDopes, par_nNumes)
		THIS.this_lModalParam = IIF(TYPE("par_lModal") = "L", par_lModal, .F.)
		THIS.this_cEmpsParam  = IIF(TYPE("par_cEmps")  = "C", ALLTRIM(par_cEmps), "")
		THIS.this_cDopesParam = IIF(TYPE("par_cDopes") = "C", ALLTRIM(par_cDopes), "")
		THIS.this_nNumesParam = IIF(TYPE("par_nNumes") = "N", par_nNumes, 0)

		RETURN DODEFAULT()
	ENDPROC

	*==========================================================================
	* InicializarForm - Instancia o Business Object, reinicializa o estado de
	* navegacao da arvore (equivalente ao bloco inicial do Init legado -
	* Declare ThisForm.paEmpDopNums[1] / ThisForm.Arqfigura recebe espaco) e cria os
	* containers de topo do layout legado. O conteudo dos containers e os
	* controles soltos na Form (TreeView/GetOP/GetEnvelope/labels/
	* Commandgroup1/Fwbtng1/Fwbtng2/Imagem) entram na Fase 4.
	*==========================================================================
	PROTECTED PROCEDURE InicializarForm
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		THIS.this_oBusinessObject = CREATEOBJECT("SIGOPNOPBO")

		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			MsgErro("Falha ao criar SIGOPNOPBO", "Erro")
		ELSE
			THIS.Caption = "An" + CHR(225) + "lise de OP/Envelopes"

			*-- Picture = ..\framework\imagens\new_background.jpg no legado -
			*-- caminho resolvido via gc_4c_CaminhoFramework (regra CLAUDE.md
			*-- #27/Pattern #170 - NUNCA montar esse caminho a partir de gc_4c_CaminhoBase).
			IF FILE(gc_4c_CaminhoFramework + "imagens\new_background.jpg")
				THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
			ENDIF

			*-- Reinicializa o estado de navegacao da arvore (equivalente ao
			*-- Declare ThisForm.paEmpDopNums[1] / Arqfigura = ' ' do Init
			*-- legado - o form nao fecha entre uma pesquisa e outra).
			DIMENSION THIS.this_aEmpDopNums[1]
			THIS.this_aEmpDopNums[1] = ""

			THIS.this_cArquivoFigura   = ""
			THIS.this_cUltimoNoClicado = ""

			*-- Chave de navegacao INICIAL. No legado ela eh
			*-- "GetcEmp.Value + GetDopes.Value + Str(GetNumes.Value, 6)" com
			*-- os tres TextBox recem-criados, isto eh "" + "" + "     0" =
			*-- STR(0, 6) - que NAO eh vazio, por causa do zero do Str.
			*-- Isso IMPORTA: a pilha do NodeClick cresce testando
			*-- "!Empty(paEmpDopNums[1])" (ver EmpilharChaveNavegacao), logo
			*-- uma chave inicial VAZIA faria a 1a chave empilhada ser vazia e
			*-- a pilha NUNCA crescer - divergencia medida no probe da Fase 8
			*-- (ALEN ficava em 1 depois de dois drills, onde o legado da 2).
			THIS.this_cChaveNavegacao = STR(0, 6)

			*-- Containers de topo do layout legado (filhos diretos da Form -
			*-- o SCX nao tem PageFrame).
			THIS.ConfigurarContainers()

			*-- Conteudo dos containers + controles soltos na Form (Fase 4).
			THIS.ConfigurarControles()

			*-- Ordem de tabulacao EFETIVA do legado - tem de rodar depois de
			*-- TODOS os AddObject (ver AplicarOrdemTabulacao).
			THIS.AplicarOrdemTabulacao()

			*-- Eventos dos dois campos digitaveis (Fase 6). Tem de rodar
			*-- ANTES do SetFocus abaixo: no legado o SetFocus do Init ja
			*-- dispara o When e o GotFocus do GetOP, que zeram o campo irmao
			*-- e apagam a figura do produto.
			THIS.ConfigurarEventos()

			*-- AddObject cria tudo com Visible=.F. por padrao - torna
			*-- visivel, preservando cnt_4c_Container2 (painel "AGUARDE!")
			*-- e img_4c_Imagem invisiveis, fieis ao legado.
			THIS.TornarControlesVisiveis(THIS)

			*-- Init legado: "ThisForm.Container1.GetOP.SetFocus" (ver nota
			*-- de SetFocus sem TRY/CATCH em ConfigurarControles).
			IF THIS.cnt_4c_Container1.txt_4c_OP.Enabled AND THIS.cnt_4c_Container1.txt_4c_OP.Visible
				THIS.cnt_4c_Container1.txt_4c_OP.SetFocus()
			ENDIF

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ConfigurarContainers - Cria os containers de topo do layout legado
	* (filhos DIRETOS da Form - o SCX nao tem PageFrame nenhum, ver
	* SECAO 1 do dump: so "Parent: sigopnop" / BaseClass: container).
	*
	* Geometria e propriedades transcritas LITERALMENTE da SECAO 2 do dump
	* (PILAR 1) - nada inventado:
	*   Container1: Top=136 Left=23 Height=456 Width=744 BackStyle=0
	*               BorderWidth=0 TabIndex=1 BackColor=212,208,200
	*               BorderColor=136,189,188  -> superficie da arvore
	*   Container2: Top=267 Left=221 Height=65 Width=358 SpecialEffect=0
	*               TabIndex=3 BackColor=255,255,255 -> painel "AGUARDE!"
	*
	* cnt_4c_Container2 nasce INVISIVEL de proposito: o Init legado termina
	* com "ThisForm.Container2.Visible = .f." e os metodos MakeTree/
	* MakeTreeEnv o acendem ("ThisForm.Container2.Visible = .t.") enquanto a
	* pesquisa roda. Por ser container FLUTUANTE, ele TEM de ficar fora do
	* TornarControlesVisiveis (que entra com os controles na Fase 4) - senao
	* o painel de aguarde fica aceso na tela desde a abertura.
	*
	* Conteudo de cada container (TreeView, GetOP, GetEnvelope, Label3,
	* Label1, Label2) entra na Fase 4; aqui ficam so as duas cascas.
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarContainers
		LOCAL loc_oCnt

		*-- cnt_4c_Container1 (sigopnop.Container1) - area da arvore
		THIS.AddObject("cnt_4c_Container1", "Container")
		loc_oCnt = THIS.cnt_4c_Container1
		WITH loc_oCnt
			.Top           = 136
			.Left          = 23
			.Height        = 456
			.Width         = 744
			.BackStyle     = 0
			.BorderWidth   = 0
			.TabIndex      = 1
			.BackColor     = RGB(212, 208, 200)
			.BorderColor   = RGB(136, 189, 188)
			.SpecialEffect = 0
			.Visible       = .T.
		ENDWITH

		*-- cnt_4c_Container2 (sigopnop.Container2) - painel "AGUARDE!".
		*-- Visible = .F. reproduz o fim do Init legado; so MakeTree/
		*-- MakeTreeEnv o tornam visivel durante a pesquisa.
		THIS.AddObject("cnt_4c_Container2", "Container")
		loc_oCnt = THIS.cnt_4c_Container2
		WITH loc_oCnt
			.Top           = 267
			.Left          = 221
			.Height        = 65
			.Width         = 358
			.SpecialEffect = 0
			.TabIndex      = 3
			.BackColor     = RGB(255, 255, 255)
			.Visible       = .F.
		ENDWITH
	ENDPROC

	*==========================================================================
	* ConfigurarControles - Preenche os dois containers criados na Fase 3 e
	* cria os controles soltos na Form (sem container - fiel ao SCX, que
	* nao tem PageFrame). Geometria/propriedades transcritas LITERALMENTE
	* da SECAO 2 do dump (PILAR 1) - nada inventado, exceto onde anotado.
	*
	* obj_4c_TreeView eh a arvore hierarquica desta tela (equivalente ao
	* "grid" das telas CRUD) - controle ActiveX de terceiros ctTree.ocx/DBI
	* Technologies, sem substituto nativo VFP9 (mesma familia de
	* FormSIGMVMVT - NAO trocar por MSComctlLib.TreeCtrl, que trava em
	* dialogo modal de licenca que o TRY/CATCH nao intercepta - ver
	* feedback_mscomctl_treectrl_trava_em_modal_de_licenca). Instanciado
	* via OLEControl com o mesmo ProgID do legado, guardado em TRY/CATCH e
	* pulado em modo teste/validacao de UI.
	*
	* As 6 imagens dos nos da arvore (AddImage no Init legado) NAO entram
	* aqui - ficam em PrepararArvore(), chamada pelo metodo de carga, com o
	* flag this_lImagensArvore garantindo UMA UNICA carga (AddImage repetido
	* empilharia indices novos e quebraria os indices fixos 1..6 usados pelo
	* AddPictureNode do legado). Mesmo padrao de
	* FormSIGMVMVT.PrepararArvore.
	*
	* AutoSize dos Labels: o dump declara AutoSize = .T. nos QUATRO labels,
	* mas AutoSize eh NO-OP em Label criado por AddObject (regra CLAUDE.md
	* #23, medida no VFP9) - a Width fica nos 100 do default enquanto o
	* controle esta invisivel, e com WordWrap ele ainda DESCARTA a Height.
	* Por isso os quatro saem com AutoSize = .F. e com a Width/Height que o
	* SCX declara (35x15, 63x15, 114x25, 279x20) - esses numeros JA SAO o
	* auto-size que o Form Designer calculou, logo fixa-los eh reproducao
	* fiel, nao desvio do PILAR 1. Sem isso o "AGUARDE!" (114) e o
	* "Pesquisando as Movimentacoes" (279) sairiam cortados nos 100.
	*
	* TabIndex: NAO entra nos blocos WITH abaixo. O SCX grava valores que
	* NAO cabem na contagem de objetos do instante da criacao e o VFP os
	* CLAMPA no load (regra medida em feedback_tabindex_do_scx_nao_transcrito)
	* - transcrever o literal daria ordem fiel ao ARQUIVO e infiel a TELA.
	* A ordem EFETIVA do legado eh reproduzida em AplicarOrdemTabulacao(),
	* chamada depois de TODOS os AddObject.
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarControles
		LOCAL loc_oErrOle

		*-- ===== Conteudo de cnt_4c_Container1 (area da arvore) =====

		*-- obj_4c_TreeView (sigopnop.Container1.TreeView) - ctTree.ocx.
		*-- ATENCAO: o SCX so preserva o caminho do OCX, nao o ProgID/CLSID
		*-- exato - "cttree.cttreeview" eh o mesmo ProgID usado em
		*-- FormSIGMVMVT (mesmo controle de terceiros). Se a instanciacao
		*-- falhar por ProgID incorreto (em vez de OCX ausente), conferir
		*-- via OLEVIEW/regedit (HKCR\TypeLib) numa maquina com o legado.
		IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
		   (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
			TRY
				THIS.cnt_4c_Container1.AddObject("obj_4c_TreeView", "OLEControl", "cttree.cttreeview")
				WITH THIS.cnt_4c_Container1.obj_4c_TreeView
					.Top     = 28
					.Left    = 9
					.Height  = 421
					.Width   = 725
					.Visible = .T.
				ENDWITH
			CATCH TO loc_oErrOle
				MsgErro("Controle de " + CHR(225) + "rvore (ctTree.ocx) indispon" + ;
						CHR(237) + "vel nesta esta" + CHR(231) + CHR(227) + "o: " + ;
						loc_oErrOle.Message, "Aviso")
			ENDTRY
		ENDIF

		*-- lbl_4c_Label3 ("O.P. :") - AutoSize = .F. + Width/Height do dump
		*-- (35x15). Ver nota de AutoSize em ConfigurarControles.
		THIS.cnt_4c_Container1.AddObject("lbl_4c_Label3", "Label")
		WITH THIS.cnt_4c_Container1.lbl_4c_Label3
			.AutoSize  = .F.
			.FontName  = "Verdana"
			.FontSize  = 8
			.BackStyle = 0
			.Caption   = "O.P. :"
			.Top       = 6
			.Left      = 12
			.Width     = 35
			.Height    = 15
			.ForeColor = RGB(36, 84, 155)
			.Visible   = .T.
		ENDWITH

		*-- lbl_4c_Label1 ("Envelope :") - dump 63x15.
		THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
		WITH THIS.cnt_4c_Container1.lbl_4c_Label1
			.AutoSize  = .F.
			.FontName  = "Verdana"
			.FontSize  = 8
			.BackStyle = 0
			.Caption   = "Envelope :"
			.Top       = 7
			.Left      = 146
			.Width     = 63
			.Height    = 15
			.ForeColor = RGB(36, 84, 155)
			.Visible   = .T.
		ENDWITH

		*-- txt_4c_OP (GetOP) - numerico (Value=0), equivalente a
		*-- SigCdNei.Nops/SigMvCab.Nops. Format/InputMask/MaxLength
		*-- transcritos do dump (regra CLAUDE.md #49 - os dois valem).
		THIS.cnt_4c_Container1.AddObject("txt_4c_OP", "TextBox")
		WITH THIS.cnt_4c_Container1.txt_4c_OP
			.Alignment         = 3
			.Value             = 0
			.Format            = "R"
			.Height            = 23
			.InputMask         = "9999999999"
			.Left              = 49
			.MaxLength         = 10
			.SpecialEffect     = 1
			.Top               = 2
			.Width             = 86
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(0, 0, 128)
			.BorderColor       = RGB(36, 84, 155)
			.Visible           = .T.
		ENDWITH

		*-- txt_4c_Envelope (GetEnvelope) - numerico (Value=0), equivalente
		*-- a SigCdNei.Nenvs.
		THIS.cnt_4c_Container1.AddObject("txt_4c_Envelope", "TextBox")
		WITH THIS.cnt_4c_Container1.txt_4c_Envelope
			.Alignment         = 3
			.Value             = 0
			.Format            = "R"
			.Height            = 23
			.InputMask         = "9999999999"
			.Left              = 210
			.MaxLength         = 10
			.SpecialEffect     = 1
			.Top               = 3
			.Width             = 86
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(0, 0, 128)
			.BorderColor       = RGB(36, 84, 155)
			.Visible           = .T.
		ENDWITH

		*-- ===== Conteudo de cnt_4c_Container2 (painel "AGUARDE!" -
		*-- flutuante, nasce invisivel - ver ConfigurarContainers/Fase 3) =====

		*-- lbl_4c_Label1 ("AGUARDE!") - dump 114x25. Com AutoSize = .T. e sem
		*-- Width a caixa ficaria nos 100 do default e o texto (Verdana 14
		*-- bold, Alignment = 2) sairia CORTADO.
		THIS.cnt_4c_Container2.AddObject("lbl_4c_Label1", "Label")
		WITH THIS.cnt_4c_Container2.lbl_4c_Label1
			.AutoSize  = .F.
			.FontBold  = .T.
			.FontName  = "Verdana"
			.FontSize  = 14
			.Alignment = 2
			.BackStyle = 0
			.Caption   = "AGUARDE!"
			.Top       = 2
			.Left      = 122
			.Width     = 114
			.Height    = 25
			.ForeColor = RGB(240, 0, 0)
			.Visible   = .T.
		ENDWITH

		*-- lbl_4c_Label2 ("Pesquisando as Movimentacoes") - dump 279x20. Eh o
		*-- caso mais grave do AutoSize: 279 contra os 100 do default, ou seja
		*-- a frase apareceria pela METADE no painel de aguarde.
		THIS.cnt_4c_Container2.AddObject("lbl_4c_Label2", "Label")
		WITH THIS.cnt_4c_Container2.lbl_4c_Label2
			.AutoSize  = .F.
			.FontBold  = .T.
			.FontName  = "Verdana"
			.FontSize  = 12
			.Alignment = 2
			.BackStyle = 0
			.Caption   = "Pesquisando as Movimenta" + CHR(231) + CHR(245) + "es"
			.Top       = 31
			.Left      = 39
			.Width     = 279
			.Height    = 20
			.ForeColor = RGB(36, 84, 155)
			.Visible   = .T.
		ENDWITH

		*-- ===== Controles soltos na Form (sem container - fiel ao SCX) =====

		*-- cmg_4c_Commandgroup1 - unico botao de saida (ButtonCount=1,
		*-- Caption="Encerrar"). Nome canonico cmg_4c_ (NAO o obj_4c_ do
		*-- mapeamento.json gerado - o AnalisadorObjetos nao reconhece
		*-- CommandGroup e cai no prefixo generico; ver
		*-- feedback_commandgroup_obj_4c_reprova_gate_fase4).
		THIS.AddObject("cmg_4c_Commandgroup1", "CommandGroup")
		WITH THIS.cmg_4c_Commandgroup1
			.ButtonCount   = 1
			.Top           = 7
			.Left          = 691
			.Height        = 110
			.Width         = 90
			.BackStyle     = 0
			.SpecialEffect = 1
			.BorderColor   = RGB(136, 189, 188)
			.Themes        = .F.

			WITH .Buttons(1)
				.Top       = 5
				.Left      = 5
				.Height    = 100
				.Width     = 80
				.FontName  = "Verdana"
				.FontSize  = 8
				.WordWrap  = .T.
				.Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
				.Cancel    = .T.
				.Caption   = "Encerrar"
				.ForeColor = RGB(36, 84, 155)
				.BackColor = RGB(255, 255, 255)
				.Themes    = .F.
			ENDWITH

			.Value   = 0
			.Visible = .T.
		ENDWITH

		*-- cmd_4c_Fwbtng1 ("Expandir" - seta para baixo). O SCX declara so
		*-- Top/Left/Picture/Caption/ToolTipText: todo o resto vem da classe
		*-- "fwbtng" do framework.vcx, lida em docs\FRAMEWORK_class_codigo_fonte.txt
		*-- (NUNCA chutar propriedade herdada - regra CLAUDE.md #30/#31):
		*--   Height=100  Width=80  FontBold=.T.  FontItalic=.T.
		*--   FontName="Comic Sans MS"  FontSize=8  WordWrap=.T.
		*--   MousePointer=15  ForeColor=90,90,90  BackColor=255,255,255
		*-- Unico desvio deliberado: Themes = .T. (a classe tem .F.).
		*-- CommandButton STANDALONE com .Picture exige Themes=.T. +
		*-- DisabledPicture, senao o icone nao renderiza (Pattern #99) - e
		*-- como o Caption eh "", sem icone o botao fica um retangulo vazio.
		THIS.AddObject("cmd_4c_Fwbtng1", "CommandButton")
		WITH THIS.cmd_4c_Fwbtng1
			.Top             = 12
			.Left            = 12
			.Height          = 100
			.Width           = 80
			.Picture         = gc_4c_CaminhoIcones + "geral_seta_bai_60.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_bai_60.jpg"
			.Caption         = ""
			.ToolTipText     = "Expandir"
			.FontName        = "Comic Sans MS"
			.FontSize        = 8
			.FontBold        = .T.
			.FontItalic      = .T.
			.WordWrap        = .T.
			.MousePointer    = 15
			.ForeColor       = RGB(90, 90, 90)
			.BackColor       = RGB(255, 255, 255)
			.Themes          = .T.
			.Visible         = .T.
		ENDWITH

		*-- cmd_4c_Fwbtng2 ("Regredir" - seta para cima). Mesma heranca da
		*-- classe fwbtng e mesma observacao de Themes do Fwbtng1 acima.
		THIS.AddObject("cmd_4c_Fwbtng2", "CommandButton")
		WITH THIS.cmd_4c_Fwbtng2
			.Top             = 12
			.Left            = 96
			.Height          = 100
			.Width           = 80
			.Picture         = gc_4c_CaminhoIcones + "geral_seta_cim_60.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_cim_60.jpg"
			.Caption         = ""
			.ToolTipText     = "Regredir"
			.FontName        = "Comic Sans MS"
			.FontSize        = 8
			.FontBold        = .T.
			.FontItalic      = .T.
			.WordWrap        = .T.
			.MousePointer    = 15
			.ForeColor       = RGB(90, 90, 90)
			.BackColor       = RGB(255, 255, 255)
			.Themes          = .T.
			.Visible         = .T.
		ENDWITH

		*-- img_4c_Imagem - imagem do produto (Visible=.F. no legado - so
		*-- acende depois que o Valid do GetOP encontra produto com foto,
		*-- Fase 7/8).
		THIS.AddObject("img_4c_Imagem", "Image")
		WITH THIS.img_4c_Imagem
			.Stretch     = 1
			.Enabled     = .T.
			.Height      = 109
			.Left        = 474
			.Top         = 11
			.Width       = 192
			.ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
			.Visible     = .F.
		ENDWITH
	ENDPROC

	*==========================================================================
	* AplicarOrdemTabulacao - Reproduz a ordem de tabulacao EFETIVA do legado.
	*
	* TabIndex eh gravavel em runtime e cada atribuicao INSERE o controle na
	* posicao pedida, empurrando os demais - por isso este metodo roda depois
	* de TODOS os AddObject e atribui em ordem ASCENDENTE.
	*
	* Por que NAO transcrever o literal do dump: o VFP aplica o TabIndex
	* gravado no instante em que CRIA cada objeto e o limita ao total de
	* controles existentes NAQUELE instante (clamp medido no VFP9 - ver
	* feedback_tabindex_do_scx_nao_transcrito / SIGPRTEF). Simulando o load do
	* SCX com a ordem de criacao da SECAO 1 do dump:
	*
	*   Form (cria Commandgroup1, Container1, Container2, Fwbtng1, Fwbtng2,
	*         Imagem) - literais 2, 1, 3:
	*     Commandgroup1 = 2 como 1o objeto -> clampa para 1
	*     Container1    = 1 como 2o objeto -> cabe, empurra o grupo para 2
	*     Container2    = 3 como 3o objeto -> cabe
	*     EFETIVO: Container1=1, Commandgroup1=2, Container2=3, e
	*              Fwbtng1/Fwbtng2/Imagem em 4/5/6 pela ordem de criacao.
	*
	*   Container1 (cria TreeView, Label3, Label1, GetEnvelope, GetOP) -
	*   literais 3, 4, 5, 2, 1:
	*     TreeView    = 3 como 1o objeto -> clampa para 1
	*     Label3      = 4 como 2o objeto -> clampa para 2
	*     Label1      = 5 como 3o objeto -> clampa para 3
	*     GetEnvelope = 2 como 4o objeto -> cabe, entra em 2
	*     GetOP       = 1 como 5o objeto -> cabe, entra em 1
	*     EFETIVO: GetOP=1, TreeView=2, GetEnvelope=3 (Label3/Label1 atras).
	*
	* Ou seja: no legado o Tab sai do campo O.P. para a ARVORE e so depois
	* para o campo Envelope - coerente com a tela (digita a O.P., o Valid
	* monta a arvore, o Tab cai nela para navegar). Transcrever 3/4/5/2/1 ao
	* pe da letra produziria O.P. -> Envelope -> arvore, que eh outra ordem.
	*
	* Os LABELS ficam de fora: Label tem TabIndex mas NAO tem TabStop (nao
	* recebe foco), entao numera-los eh inerte e so embaralharia a sequencia
	* dos controles que de fato param o Tab.
	*
	* obj_4c_TreeView pode nao existir (OCX ausente na estacao, ou modo
	* teste/validacao de UI) - por isso a guarda ArvoreDisponivel(), sem a
	* qual a atribuicao derrubaria o Init com "Unknown member OBJ_4C_TREEVIEW".
	*==========================================================================
	PROTECTED PROCEDURE AplicarOrdemTabulacao()
		LOCAL loc_oCnt, loc_nSeq

		*-- Nivel da Form: Container1(1) -> Commandgroup1(2) -> Container2(3).
		*-- Fwbtng1/Fwbtng2/Imagem seguem em 4/5/6 pela ordem de criacao,
		*-- como no legado.
		THIS.cnt_4c_Container1.TabIndex    = 1
		THIS.cmg_4c_Commandgroup1.TabIndex = 2
		THIS.cnt_4c_Container2.TabIndex    = 3

		*-- Nivel de Container1, so os focalizaveis:
		*-- txt_4c_OP(1) -> obj_4c_TreeView(2) -> txt_4c_Envelope(3).
		loc_oCnt = THIS.cnt_4c_Container1
		loc_oCnt.txt_4c_OP.TabIndex = 1

		loc_nSeq = 1
		IF THIS.ArvoreDisponivel() AND ;
		   PEMSTATUS(loc_oCnt.obj_4c_TreeView, "TabIndex", 5)
			loc_nSeq = loc_nSeq + 1
			loc_oCnt.obj_4c_TreeView.TabIndex = loc_nSeq
		ENDIF

		loc_nSeq = loc_nSeq + 1
		loc_oCnt.txt_4c_Envelope.TabIndex = loc_nSeq
	ENDPROC

	*==========================================================================
	* ConfigurarEventos - Liga os eventos dos DOIS campos digitaveis da tela
	* (GetOP e GetEnvelope do legado). Roda depois de TODOS os AddObject e
	* ANTES do SetFocus do Init.
	*
	* NAO HA LOOKUP NESTA TELA, e isso foi CONFERIDO no dump, nao presumido:
	* tasks\task772\SIGOPNOP_form_codigo_fonte.txt nao casa NENHUM dos padroes
	* de busca do legado - zero "fwBuscaExt"/"fwBuscaSel"/"fwBuscaInt", zero
	* "mAddColuna", zero "sigacess(" e zero "Acesso<X>(" (AcessoCampos/
	* Contab/Contas/Empresa/Grupos/MovInd/MovMto/Produto/Titulo). O unico
	* CreateObject do form eh "fSqlConector" (gerente de conexao do legado,
	* hoje gnConnHandle + DataAccess). Os dois campos sao NUMEROS digitados a
	* mao (O.P. e Envelope) que o Valid consulta direto; nao existe tabela de
	* apoio para escolher em grade. Criar aqui um AbrirBusca*/AbrirLookup*
	* seria INVENTAR tabela de lookup que o legado nunca consulta - viola o
	* PILAR 1 e a regra explicita "NUNCA inventar tabelas de lookup que nao
	* existem no original".
	*
	* Pelo mesmo motivo nao existe container de Salvar/Cancelar: o SCX legado
	* tem UM CommandGroup de um unico botao (Encerrar) e dois CommandButton de
	* navegacao da arvore (Expandir/Regredir) - esta tela ANALISA, nao grava.
	* Os Click dos tres tambem sao ligados aqui (CmdEncerrarClick,
	* CmdExpandirClick e CmdRegredirClick): sao TODOS os botoes que o legado
	* tem, e nenhum deles eh CRUD.
	*
	* Por que "KeyPress" e nao "LostFocus": o legado valida no Valid (ao SAIR
	* do campo) e BINDEVENT em "Valid" NAO dispara de forma confiavel em
	* TextBox. O substituto canonico eh "KeyPress" TESTANDO a tecla - ENTER(13)
	* e TAB(9), as duas que saem do campo. "LostFocus" esta proibido aqui pela
	* regra oposta: o handler chama CarregarDados (SQLEXEC + redesenho da
	* arvore) e LostFocus dispara SEMPRE, inclusive pelo SetFocus de outro
	* controle, o que produz recursao. A regra CLAUDE.md #47 (lookup tem de ir
	* em LostFocus) NAO se aplica: ela trata de handler que abre PICKER sem
	* testar a tecla - aqui nao ha picker e a tecla eh testada.
	*
	* GotFocus reproduz DUAS coisas do legado, que juntas fazem dos dois
	* campos mutuamente exclusivos:
	*   GetOP.GotFocus       -> "This.Parent.GetEnvelope.Value = 0"
	*   GetEnvelope.GotFocus -> "This.Parent.GetOP.Value = 0"
	* e, no caso do O.P., mais o When ("ThisForm.Imagem.Visible = .f."), cujo
	* Return(.t.) esta COMENTADO no SCX - ou seja, o When legado so tem esse
	* efeito colateral. Ele vai para o GotFocus por dois motivos: BINDEVENT
	* DESCARTA o retorno do delegate (um When ligado por BINDEVENT nao
	* bloquearia nada mesmo) e When/GotFocus disparam na MESMA entrada no
	* campo, logo o efeito visivel eh identico. O When do GetEnvelope eh
	* "Return(.t.)" puro - nao tem efeito nenhum a reproduzir.
	*
	* Os DEZ handlers sao PUBLIC (sem PROTECTED): BINDEVENT ignora metodo
	* PROTECTED em silencio (regra CLAUDE.md #3).
	*
	* FASE 8 acrescenta os tres ultimos - os eventos que faltavam para cobrir
	* cada metodo com codigo do dump: TreeView.KeyPress, TreeView.NodeClick e
	* Imagem.DblClick. Evento de ActiveX chega pelo MESMO BINDEVENT dos
	* controles nativos (padrao do form irmao FormSIGMVMVT), mas o controle so
	* existe se o AddObject do OCX deu certo - dai a guarda ArvoreDisponivel().
	*==========================================================================
	PROCEDURE ConfigurarEventos()
		LOCAL loc_oCnt

		loc_oCnt = THIS.cnt_4c_Container1

		*-- GetOP: GotFocus (zera o Envelope + apaga a figura) e Valid
		*-- (consulta por O.P.), este ultimo via KeyPress ENTER/TAB.
		BINDEVENT(loc_oCnt.txt_4c_OP, "GotFocus", THIS, "TxtOPGotFocus")
		BINDEVENT(loc_oCnt.txt_4c_OP, "KeyPress", THIS, "ValidarOP")

		*-- GetEnvelope: GotFocus (zera a O.P.) e Valid (consulta por
		*-- Envelope).
		BINDEVENT(loc_oCnt.txt_4c_Envelope, "GotFocus", THIS, "TxtEnvelopeGotFocus")
		BINDEVENT(loc_oCnt.txt_4c_Envelope, "KeyPress", THIS, "ValidarEnvelope")

		*-- Commandgroup1 ("Encerrar"): o BINDEVENT vai no BOTAO, nao no
		*-- grupo - o legado poe o codigo em Command3.Click e o Click do
		*-- GRUPO so dispararia se o botao nao tivesse codigo proprio.
		BINDEVENT(THIS.cmg_4c_Commandgroup1.Buttons(1), "Click", THIS, "CmdEncerrarClick")

		*-- Fwbtng1/Fwbtng2: navegacao de nivel da arvore (Expandir/Regredir).
		*-- Sao CommandButton SOLTOS na Form no legado, nao membros de grupo.
		BINDEVENT(THIS.cmd_4c_Fwbtng1, "Click", THIS, "CmdExpandirClick")
		BINDEVENT(THIS.cmd_4c_Fwbtng2, "Click", THIS, "CmdRegredirClick")

		*-- obj_4c_TreeView: KeyPress (ESC) e NodeClick (no selecionado) do
		*-- TreeView legado. O DblClick do TreeView legado esta VAZIO no dump
		*-- ("*** ActiveX Control Event ***" e mais nada), entao nao ha o que
		*-- ligar nele - ligar um handler ali seria inventar comportamento.
		IF THIS.ArvoreDisponivel()
			BINDEVENT(loc_oCnt.obj_4c_TreeView, "KeyPress",  THIS, "TreeViewKeyPress")
			BINDEVENT(loc_oCnt.obj_4c_TreeView, "NodeClick", THIS, "TreeViewNodeClick")
		ENDIF

		*-- img_4c_Imagem.DblClick - o proprio ToolTipText do legado anuncia
		*-- ("Imagem do Produto (Clique Duplo Para Zoom)"): amplia a foto do
		*-- produto da O.P. pesquisada.
		BINDEVENT(THIS.img_4c_Imagem, "DblClick", THIS, "ImgImagemDblClick")
	ENDPROC

	*==========================================================================
	* TxtOPGotFocus - GetOP.GotFocus + GetOP.When do legado:
	*   This.Parent.GetEnvelope.Value = 0
	*   ThisForm.Imagem.Visible = .f.
	*
	* A segunda linha eh o When (ver ConfigurarEventos): ao voltar para o
	* campo da O.P., a figura do produto da pesquisa ANTERIOR sai da tela.
	* Sem ela o usuario digitaria uma O.P. nova olhando a foto da antiga.
	*==========================================================================
	PROCEDURE TxtOPGotFocus()
		THIS.cnt_4c_Container1.txt_4c_Envelope.Value = 0
		THIS.img_4c_Imagem.Visible = .F.
	ENDPROC

	*==========================================================================
	* TxtEnvelopeGotFocus - GetEnvelope.GotFocus do legado:
	*   This.Parent.GetOP.Value = 0
	*
	* O When do GetEnvelope eh "Return(.t.)" puro - sem efeito a reproduzir, e
	* por isso a figura NAO eh apagada aqui (o caminho do Envelope nunca mexe
	* na Imagem, nem no legado).
	*==========================================================================
	PROCEDURE TxtEnvelopeGotFocus()
		THIS.cnt_4c_Container1.txt_4c_OP.Value = 0
	ENDPROC

	*==========================================================================
	* ValidarOP - GetOP.Valid do legado. A consulta (SELECT + UNION ALL +
	* fallback de SigPdMvf + figura do produto) mora no SIGOPNOPBO e o desenho
	* da arvore em PopularArvore; aqui fica so o GATILHO, com a guarda do
	* legado e a do teclado.
	*
	* Os tres IF sao SEPARADOS de proposito: VFP9 NAO faz short-circuit em OR,
	* entao juntar "VARTYPE(par_nKeyCode) != 'N' OR par_nKeyCode != 13"
	* avaliaria a comparacao numerica tambem quando o argumento nao eh
	* numerico, estourando "Operator/operand type mismatch".
	*
	* Os RETURN ficam todos FORA de qualquer TRY (regra CLAUDE.md #1).
	*==========================================================================
	PROCEDURE ValidarOP(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_nValor, loc_oErro

		*-- KeyPress passa SEMPRE os dois argumentos, mas o handler tambem eh
		*-- alcancavel por chamada direta (harness de teste) - sem esta guarda
		*-- a comparacao abaixo estouraria.
		IF VARTYPE(par_nKeyCode) != "N"
			RETURN
		ENDIF

		*-- So ENTER e TAB saem do campo. Sem este teste a consulta dispararia
		*-- a CADA tecla, com o numero da O.P. pela metade.
		IF par_nKeyCode != 13 AND par_nKeyCode != 9
			RETURN
		ENDIF

		IF THIS.this_lEmConsulta
			RETURN
		ENDIF

		loc_nValor = THIS.cnt_4c_Container1.txt_4c_OP.Value
		loc_nValor = IIF(VARTYPE(loc_nValor) = "N", loc_nValor, 0)

		*-- "If ! Empty(This.Value)" que envolve o Valid legado inteiro: campo
		*-- zerado nao consulta e nao avisa nada.
		IF loc_nValor != 0
			THIS.this_lEmConsulta = .T.

			TRY
				THIS.CarregarDados()
			CATCH TO loc_oErro
				MsgErro("Falha ao consultar a O.P.: " + loc_oErro.Message + CHR(13) + ;
						"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
						"Procedure: " + loc_oErro.Procedure, "Erro")
			ENDTRY

			*-- Liberada DEPOIS do ENDTRY, para valer tambem quando o CATCH
			*-- dispara - flag travada ligada MATARIA o campo pelo resto da
			*-- vida do form (regra CLAUDE.md #47).
			THIS.this_lEmConsulta = .F.
		ENDIF
	ENDPROC

	*==========================================================================
	* ValidarEnvelope - GetEnvelope.Valid do legado. Gemeo de ValidarOP (valem
	* as mesmas notas de short-circuit, de guarda de reentrancia e de liberacao
	* da flag depois do ENDTRY); a diferenca eh so o campo lido - e, portanto,
	* o criterio que CarregarDados escolhe (loc_lPorEnvelope = (O.P. = 0)).
	*
	* O caminho do Envelope NAO toca na figura do produto: o Valid do
	* GetEnvelope legado nao tem o bloco de Imagem/StrToFile que o GetOP tem.
	*==========================================================================
	PROCEDURE ValidarEnvelope(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_nValor, loc_oErro

		IF VARTYPE(par_nKeyCode) != "N"
			RETURN
		ENDIF

		IF par_nKeyCode != 13 AND par_nKeyCode != 9
			RETURN
		ENDIF

		IF THIS.this_lEmConsulta
			RETURN
		ENDIF

		loc_nValor = THIS.cnt_4c_Container1.txt_4c_Envelope.Value
		loc_nValor = IIF(VARTYPE(loc_nValor) = "N", loc_nValor, 0)

		IF loc_nValor != 0
			THIS.this_lEmConsulta = .T.

			TRY
				THIS.CarregarDados()
			CATCH TO loc_oErro
				MsgErro("Falha ao consultar o Envelope: " + loc_oErro.Message + CHR(13) + ;
						"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
						"Procedure: " + loc_oErro.Procedure, "Erro")
			ENDTRY

			THIS.this_lEmConsulta = .F.
		ENDIF
	ENDPROC

	*==========================================================================
	* CmdEncerrarClick - Commandgroup1.Command3.Click do legado, as DUAS
	* linhas, NESTA ordem:
	*   Delete File (ThisForm.Arqfigura)
	*   ThisForm.Release
	*
	* O botao eh o UNICO do CommandGroup (ButtonCount = 1, Caption "Encerrar",
	* Cancel = .T.) - por isso o BINDEVENT vai em .Buttons(1) e nao no grupo:
	* o legado poe o codigo no BOTAO (Command3.Click), e o Click do GRUPO so
	* dispararia se o botao nao tivesse codigo proprio.
	*
	* (a) O "Delete File" mora no BO (SIGOPNOPBO.ExcluirImagemTemporaria), que
	* eh quem conhece o caminho do .jpg temporario extraido de SigCdPro.FigJpgs
	* e ja traz as duas defesas que o legado nao tem: IF FILE() antes de apagar
	* e SET SAFETY OFF em volta do DELETE FILE (com SAFETY ON ele abre dialogo
	* de confirmacao, e dialogo modal travaria o pipeline). O legado apaga as
	* cegas - e no caminho em que o produto NAO tem foto o Arqfigura dele
	* aponta para arquivo que nunca foi criado (ou para o " " do Init), entao o
	* Delete File legado erra ali. A guarda eh desvio DELIBERADO e invisivel ao
	* usuario (PILAR 1 preservado).
	*
	* (b) .Picture = "" ANTES de apagar: o controle Image mantem o arquivo
	* preso enquanto aponta para ele, e o CLEAR RESOURCES do BO sozinho nao
	* solta essa referencia. Sem isto o DELETE FILE falha e o .jpg fica para
	* tras em SYS(2023) a cada pesquisa. Nao tem efeito visivel - a tela esta
	* fechando - entao tambem nao mexe com o PILAR 1.
	*
	* (c) O TRY cobre SO a limpeza, e o Release fica FORA dele: falha ao apagar
	* um temporario nao pode impedir a tela de fechar, que eh a razao de existir
	* do botao. O CATCH nao eh silencioso (CLAUDE.md #9).
	*
	* (d) Release() e nao Hide(): esta tela NAO devolve resultado a chamador
	* nenhum - conferido, nao presumido. O dump do SCX nao tem PROCEDURE Unload
	* (logo nao existe "DO FORM ... TO"), o form nao tem property de retorno, e
	* nao ha um unico call site de SIGOPNOP no acervo legado nem no projeto
	* migrado. A regra do Hide
	* (feedback_release_mata_referencia_dialogo_usa_hide) vale para dialogo
	* FILHO cujo pai le o resultado depois do Show(); aqui Hide() deixaria o
	* objeto vivo segurando a datasession privada e os cursores dela.
	*
	* O Release dispara Destroy -> SIGOPNOPBO.Destroy, que repete
	* ExcluirImagemTemporaria + FecharCursoresResultado. Repetir eh inocuo (o
	* BO zera this_cArquivoImagem e os dois metodos sao idempotentes) e eh a
	* rede de seguranca para quem fechar a tela por outro caminho - Alt+F4,
	* que continua valendo porque Closable segue .T. (ver o bloco de
	* propriedades da classe).
	*==========================================================================
	PROCEDURE CmdEncerrarClick()
		LOCAL loc_oErro

		TRY
			*-- (b) solta a referencia do Image antes do DELETE FILE
			THIS.img_4c_Imagem.Picture = ""
			THIS.img_4c_Imagem.Visible = .F.

			IF VARTYPE(THIS.this_oBusinessObject) = "O"
				THIS.this_oBusinessObject.ExcluirImagemTemporaria()
			ENDIF

			*-- Espelho de ThisForm.Arqfigura: o arquivo acabou de ser
			*-- apagado, entao a property nao pode seguir apontando para ele.
			THIS.this_cArquivoFigura = ""
		CATCH TO loc_oErro
			MsgErro("Falha ao apagar a imagem tempor" + CHR(225) + "ria: " + ;
					loc_oErro.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
					"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY

		*-- "ThisForm.Release" - FORA do TRY (ver nota (c) acima)
		THIS.Release()
	ENDPROC

	*==========================================================================
	* CmdExpandirClick - Fwbtng1.Click do legado (ToolTipText "Expandir", seta
	* para baixo), transcrito linha a linha:
	*
	*   loTree1 = ThisForm.Container1.TreeView
	*   llExpande = .f.
	*   For lnNode = 0 To loTree1.lIstCount-1
	*       If ThisForm.pnNodeExp + 1 = loTree1.NodeLevel(lnNode)
	*           loTree1.NodeExpanded(lnNode) = .t.
	*           llExpande = .t.
	*       Endif
	*   EndFor
	*   If llExpande
	*       ThisForm.pnNodeExp = ThisForm.pnNodeExp + 1
	*   Endif
	*
	* Abre UM nivel por clique: expande todos os nos do nivel SEGUINTE ao
	* corrente (this_nNodeExp, posto em 1 no fim de PopularArvore) e so avanca
	* o contador se existia no naquele nivel - sem o llExpande, cliques
	* repetidos no fundo da arvore empurrariam o contador indefinidamente e o
	* botao Regredir precisaria do mesmo numero de cliques para voltar a ter
	* efeito.
	*
	* A arvore eh base ZERO (o laco vai de 0 a ListCount-1): transcrito do
	* legado, NAO convertido para 1..N.
	*
	* Nada de ReDraw/Refresh no fim: os dois Click do legado nao chamam nenhum
	* dos dois (so maketree/maketreeenv chamam, ja reproduzidos em
	* PopularArvore) - o proprio NodeExpanded repinta.
	*
	* ArvoreDisponivel() eh obrigatorio: sem o OCX registrado na estacao (ou em
	* modo teste/validacao de UI) o obj_4c_TreeView nao existe e a primeira
	* linha derrubaria o metodo com "Unknown member OBJ_4C_TREEVIEW". O RETURN
	* da guarda fica FORA de qualquer TRY (CLAUDE.md #1).
	*
	* PUBLIC (sem PROTECTED) porque eh alvo de BINDEVENT - metodo PROTECTED eh
	* ignorado em silencio (CLAUDE.md #3).
	*==========================================================================
	PROCEDURE CmdExpandirClick()
		LOCAL loc_lExpandiu, loc_nNo, loc_nTotal, loc_oErro

		IF !THIS.ArvoreDisponivel()
			RETURN
		ENDIF

		loc_lExpandiu = .F.

		TRY
			WITH THIS.cnt_4c_Container1.obj_4c_TreeView
				loc_nTotal = .ListCount

				FOR loc_nNo = 0 TO loc_nTotal - 1
					IF THIS.this_nNodeExp + 1 = .NodeLevel(loc_nNo)
						.NodeExpanded(loc_nNo) = .T.
						loc_lExpandiu = .T.
					ENDIF
				ENDFOR
			ENDWITH

			IF loc_lExpandiu
				THIS.this_nNodeExp = THIS.this_nNodeExp + 1
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Falha ao expandir a " + CHR(225) + "rvore: " + ;
					loc_oErro.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
					"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY
	ENDPROC

	*==========================================================================
	* CmdRegredirClick - Fwbtng2.Click do legado (ToolTipText "Regredir", seta
	* para cima), transcrito linha a linha:
	*
	*   If Type('ThisForm.pnNodeExp') = 'N' And ThisForm.pnNodeExp > 0
	*       loTree1 = ThisForm.Container1.TreeView
	*       For lnNode = 0 To loTree1.lIstCount-1
	*           If ThisForm.pnNodeExp = loTree1.NodeLevel(lnNode)
	*               loTree1.NodeExpanded(lnNode) = .f.
	*           Endif
	*       EndFor
	*       ThisForm.pnNodeExp = ThisForm.pnNodeExp - 1
	*   EndIf
	*
	* Fecha o nivel CORRENTE e recua o contador - inverso do Expandir, que abre
	* o nivel SEGUINTE. A assimetria (um usa pnNodeExp + 1, o outro pnNodeExp)
	* eh do legado e NAO se uniformiza.
	*
	* As DUAS condicoes do IF legado estao reproduzidas, mas em IF SEPARADOS:
	* VFP9 nao faz short-circuit, entao "VARTYPE(...) = 'N' AND
	* THIS.this_nNodeExp > 0" avaliaria a comparacao numerica tambem quando a
	* property nao fosse numerica. O Type() do legado existe porque lah a
	* property eh criada em runtime; aqui this_nNodeExp eh DECLARADA numerica
	* no DEFINE CLASS, entao a guarda eh redundante - mantida por fidelidade e
	* porque custa nada.
	*
	* O "> 0" eh o que impede o contador de ficar negativo: zerado, o Regredir
	* nao faz nada (nem decrementa) e o Expandir volta a abrir o nivel 1.
	*
	* Diferente do Expandir, aqui o contador recua SEMPRE que a guarda passa -
	* mesmo que nenhum no do nivel corrente tenha sido encontrado. Tambem eh do
	* legado: neste Click nao existe llExpande.
	*==========================================================================
	PROCEDURE CmdRegredirClick()
		LOCAL loc_nNo, loc_nTotal, loc_oErro

		IF !THIS.ArvoreDisponivel()
			RETURN
		ENDIF

		*-- "Type('ThisForm.pnNodeExp') = 'N'" - 1a metade da guarda legado
		IF VARTYPE(THIS.this_nNodeExp) != "N"
			RETURN
		ENDIF

		*-- "And ThisForm.pnNodeExp > 0" - 2a metade, em IF separado
		IF THIS.this_nNodeExp <= 0
			RETURN
		ENDIF

		TRY
			WITH THIS.cnt_4c_Container1.obj_4c_TreeView
				loc_nTotal = .ListCount

				FOR loc_nNo = 0 TO loc_nTotal - 1
					IF THIS.this_nNodeExp = .NodeLevel(loc_nNo)
						.NodeExpanded(loc_nNo) = .F.
					ENDIF
				ENDFOR
			ENDWITH

			THIS.this_nNodeExp = THIS.this_nNodeExp - 1
		CATCH TO loc_oErro
			MsgErro("Falha ao regredir a " + CHR(225) + "rvore: " + ;
					loc_oErro.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
					"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY
	ENDPROC

	*==========================================================================
	* TreeViewKeyPress - TreeView.KeyPress do legado. Evento de ActiveX recebe
	* UM unico argumento (keyascii), diferente do KeyPress nativo de TextBox,
	* que recebe dois - por isso o LPARAMETERS vai no CORPO e nao na linha do
	* PROCEDURE (mesma forma do form irmao FormSIGMVMVT.TreeViewKeyPress).
	*
	*   LPARAMETERS keyascii
	*   If KeyAscii = 27
	*       Release Windows
	*   Endif
	*
	* RELEASE WINDOWS eh transcricao LITERAL. Medido: o comando age sobre
	* janelas de DEFINE WINDOW, NAO sobre forms, e o projeto nao define
	* nenhuma - ou seja, no legado esta linha ja era inerte. Trocar por
	* THIS.Release() FECHARIA a tela ao ESC dentro da arvore, comportamento
	* que o legado NAO tem: o ESC desta tela eh o Cancel = .T. do botao
	* Encerrar (transcrito do dump), que alem de fechar ainda apaga o .jpg
	* temporario. Inventar um segundo caminho de fechamento aqui mudaria a UX
	* sem nenhuma linha do legado pedindo.
	*
	* A guarda de VARTYPE existe porque o handler tambem eh alcancavel por
	* chamada direta (harness de teste), onde o argumento pode chegar ausente;
	* sem ela a comparacao numerica estouraria "Operator/operand type
	* mismatch". O RETURN fica FORA de qualquer TRY (CLAUDE.md #1).
	*
	* PUBLIC (sem PROTECTED) porque eh alvo de BINDEVENT (CLAUDE.md #3).
	*==========================================================================
	PROCEDURE TreeViewKeyPress
		LPARAMETERS par_nKeyAscii

		IF VARTYPE(par_nKeyAscii) != "N"
			RETURN
		ENDIF

		IF par_nKeyAscii = 27
			RELEASE WINDOWS
		ENDIF
	ENDPROC

	*==========================================================================
	* TreeViewNodeClick - TreeView.NodeClick do legado (ActiveX, LPARAMETERS
	* nindex, ncolumn), transcrito com a MESMA estrutura aninhada:
	*
	*   If ! Empty(Thisform.plDblClick)
	*       If This.NodeCargo(nIndex) = Thisform.plDblClick
	*           If !Empty(ThisForm.paEmpDopNums[1])
	*               Declare ThisForm.paEmpDopNums[Alen(ThisForm.paEmpDopNums)+1]
	*           EndIf
	*           ThisForm.paEmpDopNums[Alen(...)] = GetcEmp.Value + GetDopes.Value + Str(GetNumes.Value,6)
	*           GetcEmp.Value  = Left(This.NodeCargo(nIndex),3)
	*           GetDopes.Value = Substr(This.NodeCargo(nIndex),4,20)
	*           GetNumes.Value = Val(Alltrim(Substr(This.NodeCargo(nIndex),24)))
	*           ThisForm.Maketree()
	*       Else
	*           Thisform.plDblClick = This.NodeCargo(nIndex)
	*       Endif
	*   Else
	*       Thisform.plDblClick = This.NodeCargo(nIndex)
	*   EndIf
	*
	* O ramo de DRILL (2o clique no MESMO no) esta reproduzido no que EXISTE,
	* e duas coisas dele foram MEDIDAS no dump antes de decidir:
	*
	* (1) **Nenhum no recebe cargo.** "NodeCargo(" aparece 6 vezes em
	*     tasks\task772\SIGOPNOP_form_codigo_fonte.txt e TODAS as 6 sao
	*     LEITURA ("This.NodeCargo(nIndex)") - zero atribuicao. Os dois
	*     metodos que montam a arvore (maketree/maketreeenv) chamam
	*     AddPictureNode + NodeHeader/NodeExpanded/NodeShowChecks/
	*     NodeFontBold e mais nada. Logo o cargo chega sempre vazio/zero,
	*     "Empty(plDblClick)" eh sempre .T. e o legado cai SEMPRE no ELSE de
	*     fora: na pratica o NodeClick legado so REGISTRA o no clicado.
	* (2) **Os tres TextBox que o ramo escreve nao existem no SCX** (ver a
	*     property this_cChaveNavegacao) - se o ramo fosse alcancavel,
	*     estouraria no proprio legado.
	*
	* Por isso a chave corrente vive em this_cChaveNavegacao e NAO em tres
	* controles reproduzidos: reproduzi-los seria inventar tela. E o
	* "ThisForm.Maketree()" do fim do ramo vira THIS.PopularArvore(.F.) -
	* literal, inclusive o fato de o legado chamar MakeTree (variante da O.P.)
	* mesmo quando a pesquisa foi por Envelope. Nao ha consulta nova a fazer
	* ali: maketree/maketreeenv percorrem o cursor CORRENTE com um Scan e nao
	* executam SQL nenhum - e nem leem os tres campos que o ramo acabou de
	* escrever. Ou seja, o efeito real do drill eh empilhar a chave e
	* REDESENHAR a arvore, e eh exatamente isso que esta reproduzido.
	*
	* O cargo eh normalizado por TratarNulo (que devolve o 2o argumento quando
	* o valor eh NULL - EMPTY(.NULL.) seria .F. e furaria a prova do legado) e
	* so vira string quando NAO esta vazio: cargo 0/vazio tem de continuar
	* produzindo "" para "Empty()" valer o mesmo que no legado - TRANSFORM(0)
	* daria "0", que NAO eh vazio, e tornaria alcancavel um ramo que no legado
	* nunca roda.
	*
	* Comparacao com "==" (e nao "="): exata em qualquer SET EXACT, e
	* equivalente ao "=" do legado sob o SET EXACT ON do config.prg.
	*
	* PUBLIC (sem PROTECTED) porque eh alvo de BINDEVENT (CLAUDE.md #3).
	*==========================================================================
	PROCEDURE TreeViewNodeClick
		LPARAMETERS par_nIndex, par_nColumn
		LOCAL loc_uCargo, loc_cCargo, loc_lLeu, loc_oErro

		IF !THIS.ArvoreDisponivel()
			RETURN
		ENDIF

		IF VARTYPE(par_nIndex) != "N"
			RETURN
		ENDIF

		loc_cCargo = ""
		loc_lLeu   = .F.

		TRY
			loc_uCargo = TratarNulo(THIS.cnt_4c_Container1.obj_4c_TreeView.NodeCargo(par_nIndex), "")

			IF !EMPTY(loc_uCargo)
				loc_cCargo = ALLTRIM(TRANSFORM(loc_uCargo))
			ENDIF

			loc_lLeu = .T.
		CATCH TO loc_oErro
			MsgErro("Falha ao ler o n" + CHR(243) + " clicado na " + CHR(225) + "rvore: " + ;
					loc_oErro.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
					"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY

		*-- Leitura falhou: nao mexe no estado de navegacao (o RETURN fica
		*-- FORA do TRY - CLAUDE.md #1).
		IF !loc_lLeu
			RETURN
		ENDIF

		*-- "If ! Empty(Thisform.plDblClick)"
		IF !EMPTY(THIS.this_cUltimoNoClicado)
			*-- "If This.NodeCargo(nIndex) = Thisform.plDblClick"
			IF loc_cCargo == THIS.this_cUltimoNoClicado
				*-- 2o clique no MESMO no - ramo de DRILL
				THIS.EmpilharChaveNavegacao()
				THIS.this_cChaveNavegacao = loc_cCargo
				THIS.PopularArvore(.F.)
			ELSE
				*-- "Thisform.plDblClick = This.NodeCargo(nIndex)"
				THIS.this_cUltimoNoClicado = loc_cCargo
			ENDIF
		ELSE
			*-- Mesmo ELSE do legado, no nivel de fora
			THIS.this_cUltimoNoClicado = loc_cCargo
		ENDIF
	ENDPROC

	*==========================================================================
	* EmpilharChaveNavegacao - as tres linhas de pilha do NodeClick legado:
	*
	*   If !Empty(ThisForm.paEmpDopNums[1])
	*       Declare ThisForm.paEmpDopNums[Alen(ThisForm.paEmpDopNums)+1]
	*   EndIf
	*   ThisForm.paEmpDopNums[Alen(ThisForm.paEmpDopNums)] = <chave corrente>
	*
	* A 1a chave ocupa o elemento que o Init ja criou (DIMENSION [1] em
	* InicializarForm, espelho do "Declare ThisForm.paEmpDopNums[1]"); da 2a
	* em diante o array CRESCE um elemento por drill.
	*
	* O "!Empty(paEmpDopNums[1])" eh o jeito do legado de perguntar "o slot 1
	* ja esta ocupado?", e isso so funciona porque a chave empilhada NUNCA eh
	* vazia: ela termina em Str(<numero>, 6), que no pior caso vale "     0".
	* Por isso this_cChaveNavegacao NASCE com STR(0, 6) e nao com "" - ver a
	* nota em InicializarForm. Com chave inicial vazia a pilha nao crescia
	* nunca (medido no probe da Fase 8).
	*
	* A pilha eh WRITE-ONLY tambem no legado - conferido no dump: fora do
	* Init, "paEmpDopNums" so aparece nas tres linhas acima, nunca como
	* leitura. Nao existe "voltar um nivel" para reproduzir; reproduzi-la
	* assim eh fiel, e inventar o pop seria funcionalidade nova.
	*==========================================================================
	PROTECTED PROCEDURE EmpilharChaveNavegacao()
		LOCAL loc_nTopo

		IF !EMPTY(THIS.this_aEmpDopNums[1])
			loc_nTopo = ALEN(THIS.this_aEmpDopNums) + 1
			DIMENSION THIS.this_aEmpDopNums[loc_nTopo]
		ENDIF

		THIS.this_aEmpDopNums[ALEN(THIS.this_aEmpDopNums)] = THIS.this_cChaveNavegacao
	ENDPROC

	*==========================================================================
	* ImgImagemDblClick - Imagem.DblClick do legado (ToolTipText "Imagem do
	* Produto (Clique Duplo Para Zoom)"):
	*
	*   lcArquivo = Sys(2023) + '\' + Sys(2015) + '.Jpg'
	*   Select crTmpPro
	*   If Not Empty(crTmpPro.FigJpgs) And Not IsNull(crTmpPro.FigJpgs)
	*       =StrToFile(crTmpPro.FigJpgs, lcArquivo)
	*   EndIf
	*   If File(lcArquivo)
	*       Do Form SigOpZom With lcArquivo, 'Produto : ' + crTmpPro.CPros + ' - ' + crTmpPro.DPros, ''
	*       Delete File (lcArquivo)
	*   EndIf
	*
	* O crTmpPro do legado eh o cursor_4c_Produto do BO (SIGOPNOPBO.
	* this_cCursorProduto), populado por BuscarImagemProduto no caminho da
	* O.P. - o mesmo SELECT cpros, dpros, FigJpgs From SigCdPro. O arquivo
	* daqui eh um temporario PROPRIO (SYS(2015) novo), separado do
	* this_cArquivoImagem que alimenta o img_4c_Imagem da tela: eh assim no
	* legado, e por isso ele apaga este e nao o outro.
	*
	* Tres desvios deliberados, nenhum visivel ao usuario:
	*   (a) a work area corrente eh salva e restaurada em volta do
	*       SELECT - o legado troca de area e nunca repoe;
	*   (b) STRTOFILE eh TESTADO (> 0) antes de tentar abrir o zoom, em vez de
	*       descartar o retorno com "=StrToFile(...)";
	*   (c) SET SAFETY OFF em volta do ERASE: com SAFETY ON o VFP9 abre
	*       dialogo de confirmacao, e dialogo modal trava o pipeline
	*       (CLAUDE.md #6). O legado apaga as cegas.
	*
	* NAO ha STRCONV/base64 aqui: o legado grava o memo FigJpgs direto com
	* StrToFile, e o BO desta task faz igual (SIGOPNOPBO.BuscarImagemProduto).
	* Acrescentar um STRCONV(...,14) decodificaria duas vezes a imagem de quem
	* grava JPG puro.
	*
	* PUBLIC (sem PROTECTED) porque eh alvo de BINDEVENT (CLAUDE.md #3).
	*==========================================================================
	PROCEDURE ImgImagemDblClick()
		LOCAL loc_cCursor, loc_cArquivo, loc_cProduto, loc_cDescProduto
		LOCAL loc_cFoto, loc_cAliasAnterior, loc_cSafety, loc_oErro

		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN
		ENDIF

		loc_cCursor = THIS.this_oBusinessObject.this_cCursorProduto

		*-- "Select crTmpPro": sem o cursor do produto nao ha foto a ampliar
		*-- (acontece quando a pesquisa foi por Envelope - esse caminho do
		*-- legado nunca consulta SigCdPro).
		IF !USED(loc_cCursor)
			RETURN
		ENDIF

		loc_cArquivo     = ""
		loc_cProduto     = ""
		loc_cDescProduto = ""
		loc_cAliasAnterior = ALIAS()

		TRY
			SELECT (loc_cCursor)

			IF !EOF()
				loc_cProduto     = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Cpros"), ""))
				loc_cDescProduto = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Dpros"), ""))

				*-- "If Not Empty(crTmpPro.FigJpgs) And Not IsNull(...)" -
				*-- TratarNulo cobre o IsNull (CLAUDE.md #27: EMPTY(.NULL.)
				*-- devolve .F., entao o EMPTY sozinho nao bastaria).
				loc_cFoto = TratarNulo(EVALUATE(loc_cCursor + ".FigJpgs"), "")

				IF !EMPTY(loc_cFoto)
					loc_cArquivo = SYS(2023) + "\" + ALLTRIM(SYS(2015)) + ".Jpg"

					IF STRTOFILE(loc_cFoto, loc_cArquivo) <= 0
						loc_cArquivo = ""
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Falha ao extrair a imagem do produto: " + ;
					loc_oErro.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
					"Procedure: " + loc_oErro.Procedure, "Erro")
			loc_cArquivo = ""
		ENDTRY

		*-- (a) repoe a area de trabalho do chamador
		IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
			SELECT (loc_cAliasAnterior)
		ENDIF

		*-- "If File(lcArquivo) / Do Form SigOpZom ... / Delete File". O
		*-- Show() do dialogo filho fica FORA de qualquer TRY (CLAUDE.md #29).
		IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
			THIS.AbrirFormZoomImagem(loc_cArquivo, loc_cProduto, loc_cDescProduto)

			*-- (c) ERASE sem dialogo de confirmacao
			loc_cSafety = SET("SAFETY")
			SET SAFETY OFF

			ERASE (loc_cArquivo)

			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF
		ENDIF
	ENDPROC

	*==========================================================================
	* AbrirFormZoomImagem - "Do Form SigOpZom With lcArquivo, 'Produto : ' +
	* crTmpPro.CPros + ' - ' + crTmpPro.DPros, ''" do legado (zoom da foto do
	* produto). O 3o argumento eh string VAZIA no legado - transcrito assim.
	*
	* NAO se escreve "DO FORM" no projeto novo: os forms migrados sao
	* DEFINE CLASS em .prg e nao existe .scx nenhum em projeto\, entao o
	* DO FORM estoura "File 'sigopzom.scx' does not exist" e o dialogo NUNCA
	* abre - alem de a classe filha nao entrar no indice de carga sob demanda,
	* que o GerarIndiceClasses monta lendo CREATEOBJECT/AddObject. A forma
	* canonica eh CREATEOBJECT com o nome LITERAL da classe migrada.
	*
	* SIGOPZOM esta FORA do escopo desta task (segue em ProximasMigracoes\) -
	* mesmo padrao ja adotado em FormSigMvSbn.AbrirFormZoomImagem e
	* FormSigPrCtr: o CREATEOBJECT vai guardado e a ausencia eh AVISADA ao
	* usuario, em vez de estourar "Class definition FORMSIGOPZOM is not
	* found" ou - pior - de o duplo clique na foto nao fazer nada e ninguem
	* descobrir. Ausencia de modulo tem de ficar VISIVEL. Quando SigOpZom for
	* migrado, esta chamada passa a funcionar sem nenhuma alteracao aqui.
	*
	* Show() FORA do TRY: form modal chamado DENTRO de TRY faz qualquer erro
	* de runtime da tela filha cair no CATCH do pai, a referencia LOCAL morrer
	* e a janela filha fechar sozinha (CLAUDE.md #29).
	*==========================================================================
	PROTECTED PROCEDURE AbrirFormZoomImagem(par_cArquivo, par_cProduto, par_cDescProduto)
		LOCAL loc_oForm, loc_cTitulo, loc_oErro

		loc_cTitulo = "Produto : " + ALLTRIM(par_cProduto) + " - " + ALLTRIM(par_cDescProduto)

		TRY
			loc_oForm = CREATEOBJECT("FormSigOpZom", par_cArquivo, loc_cTitulo, "")
		CATCH TO loc_oErro
			loc_oForm = .NULL.
		ENDTRY

		IF VARTYPE(loc_oForm) = "O"
			loc_oForm.Show()
		ELSE
			MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + ;
					CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta " + ;
					"vers" + CHR(227) + "o.", "Aviso")
		ENDIF
	ENDPROC

	*==========================================================================
	* ArvoreDisponivel - O obj_4c_TreeView so existe se o AddObject com o
	* ActiveX ctTree.ocx tiver dado certo em ConfigurarControles (o OCX pode
	* nao estar registrado na estacao, e em modo teste/validacao de UI ele nem
	* eh tentado). Sem esta guarda, TODA chamada a API de nos derrubaria o
	* metodo com "Unknown member OBJ_4C_TREEVIEW". Mesmo padrao de
	* FormSIGMVMVT.ArvoreDisponivel.
	*==========================================================================
	PROTECTED FUNCTION ArvoreDisponivel()
		RETURN PEMSTATUS(THIS.cnt_4c_Container1, "obj_4c_TreeView", 5) AND ;
		       VARTYPE(THIS.cnt_4c_Container1.obj_4c_TreeView) = "O"
	ENDFUNC

	*==========================================================================
	* PrepararArvore - Reproduz (a) os seis AddImage do Init legado e (b) o
	* bloco de inicializacao que MakeTree e MakeTreeEnv repetem identicos no
	* inicio:
	*   loTree1.ClearNodes / TipsDisplay = .t. / ExpandOnDClick /
	*   SmallIcons = .t. / PicAlign = 0 / SelectedStyle = 2 / PictureType = 1
	*
	* As imagens entram UMA UNICA vez (this_lImagensArvore), como no Init
	* legado: AddImage empilha indices novos a cada chamada e os indices
	* 1..6 usados pelo AddPictureNode sao FIXOS no codigo do legado -
	* recarregar a cada pesquisa trocaria os icones de todos os nos (mesma
	* razao do flag em FormSIGMVMVT.PrepararArvore).
	*
	* Caminhos transcritos do Init legado, na MESMA ordem (eh a ordem que
	* define o indice). Cada linha do legado traz, COMENTADA ao lado, a versao
	* ANTERIOR do mesmo icone - que eh o alternativo usado aqui (ver abaixo):
	*   1 \imagens\geral_documento_26.jpg  (&&\vbmp\Form4.Ico)     raiz O.P.
	*   2 \imagens\geral_caixa_16.jpg      (&&\vbmp\depend3.bmp)   movim./material/medida
	*   3 \imagens\geral_pendencia_26.jpg  (&&\vbmp\OHist.Ico)     (reservado pelo legado)
	*   4 \imagens\geral_palete_26.jpg     (&&\vbmp\Replace.Ico)   material de SERVICO
	*   5 \vbmp\EnvMail.Bmp                (sem alternativo)       raiz Envelope
	*   6 \imagens\geral_subnivel_26.jpg   (&&\vbmp\Server15.Ico)  Origem/Destino
	* "\imagens\" eh a pasta do Framework legado (gc_4c_CaminhoFramework -
	* regra CLAUDE.md #27 / Pattern #170) e "\vbmp\" eh gc_4c_CaminhoIcones.
	*
	* MEDIDO no VFP9 em 2026-11-09 (automation\medir_loadpicture_jpeg.prg): LOADPICTURE
	* REJEITA os cinco .jpg com "OLE error code 0x800a01e1" - e os arquivos
	* EXISTEM (FILE() = .T.); so o .Bmp carrega. Isto eh limitacao do
	* LOADPICTURE com JPEG, nao arquivo ausente, entao IF FILE() nao protege.
	* Por isso cada imagem cai no arquivo que o PROPRIO legado nomeia no
	* comentario da mesma linha (.Ico/.bmp, os seis presentes em vbmp\) -
	* alvo vindo do DUMP, nunca de palpite (regra #25). Mesma familia de
	* icones que FormSIGMVMVT usa (Form4.Ico/depend3.bmp/OHist.Ico).
	*
	* As DUAS metades ficam em TRY SEPARADOS, reproduzindo a separacao do
	* legado (as imagens moram no Init, o bloco de propriedades mora no
	* MakeTree/MakeTreeEnv): num TRY unico, a falha do LOADPICTURE abortava
	* o metodo ANTES do ClearNodes e os nos da pesquisa anterior PERMANECIAM
	* na arvore - medido no probe, 15 nos viravam 29 na segunda pesquisa.
	*
	* O flag this_lImagensArvore eh ligado DEPOIS da tentativa, com sucesso
	* ou sem: o que nao pode repetir eh o AddImage, que empilha indice novo e
	* deslocaria os indices fixos 1..6 do AddPictureNode.
	*==========================================================================
	PROTECTED PROCEDURE PrepararArvore()
		LOCAL loc_oErro

		IF THIS.ArvoreDisponivel()
			IF !THIS.this_lImagensArvore
				THIS.CarregarImagemArvore("imagens\geral_documento_26.jpg", "Form4.Ico")
				THIS.CarregarImagemArvore("imagens\geral_caixa_16.jpg", "depend3.bmp")
				THIS.CarregarImagemArvore("imagens\geral_pendencia_26.jpg", "OHist.Ico")
				THIS.CarregarImagemArvore("imagens\geral_palete_26.jpg", "Replace.Ico")
				THIS.CarregarImagemArvore("", "EnvMail.Bmp")
				THIS.CarregarImagemArvore("imagens\geral_subnivel_26.jpg", "Server15.Ico")

				THIS.this_lImagensArvore = .T.
			ENDIF

			TRY
				WITH THIS.cnt_4c_Container1.obj_4c_TreeView
					.ClearNodes
					.TipsDisplay   = .T.
					.ExpandOnDClick
					.SmallIcons    = .T.
					.PicAlign      = 0
					.SelectedStyle = 2
					.PictureType   = 1
				ENDWITH
			CATCH TO loc_oErro
				MsgErro("Falha ao preparar a " + CHR(225) + "rvore: " + ;
						loc_oErro.Message + CHR(13) + ;
						"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
						"Procedure: " + loc_oErro.Procedure, "Erro")
			ENDTRY
		ENDIF
	ENDPROC

	*==========================================================================
	* CarregarImagemArvore - UM AddImage do Init legado. Tenta primeiro o
	* arquivo da linha ATIVA do legado (par_cRelativoFramework, dentro de
	* gc_4c_CaminhoFramework) e, falhando, o arquivo que o legado nomeia no
	* COMENTARIO da mesma linha (par_cAlternativoVbmp, dentro de
	* gc_4c_CaminhoIcones) - ver a medicao de LOADPICTURE x JPEG no cabecalho
	* de PrepararArvore.
	*
	* par_cRelativoFramework vazio significa que a linha do legado JA aponta
	* direto para \vbmp\ (caso do EnvMail.Bmp, indice 5).
	*
	* TRY por IMAGEM: uma falha nao pode impedir as outras cinco de entrar,
	* senao os indices 1..6 ficam deslocados. O AddImage eh chamado SEMPRE,
	* inclusive com a imagem nula, exatamente para o indice nao escorregar -
	* indice sem figura desenha no sem icone, o que eh degradacao visivel;
	* indice deslocado poria o icone ERRADO em todos os nos.
	*
	* NENHUM CATCH eh silencioso (CLAUDE.md #9): a falha do caminho PRINCIPAL
	* eh esperada e medida (LOADPICTURE x JPEG), entao ela so acumula a
	* mensagem; o erro so eh EXIBIDO quando o alternativo tambem falha - isto
	* eh, quando a imagem realmente nao entrou. Reportar a cada tentativa
	* produziria cinco dialogos por pesquisa.
	*==========================================================================
	PROTECTED PROCEDURE CarregarImagemArvore(par_cRelativoFramework, par_cAlternativoVbmp)
		LOCAL loc_oImagem, loc_oErro, loc_cPrincipal, loc_cAlternativo, loc_cFalhas

		loc_oImagem      = .NULL.
		loc_cFalhas      = ""
		loc_cPrincipal   = IIF(EMPTY(par_cRelativoFramework), "", ;
							   gc_4c_CaminhoFramework + par_cRelativoFramework)
		loc_cAlternativo = IIF(EMPTY(par_cAlternativoVbmp), "", ;
							   gc_4c_CaminhoIcones + par_cAlternativoVbmp)

		IF !EMPTY(loc_cPrincipal)
			TRY
				loc_oImagem = LOADPICTURE(loc_cPrincipal)
			CATCH TO loc_oErro
				loc_oImagem = .NULL.
				loc_cFalhas = loc_cFalhas + loc_cPrincipal + ": " + ;
					loc_oErro.Message + CHR(13)
			ENDTRY
		ENDIF

		IF VARTYPE(loc_oImagem) != "O" AND !EMPTY(loc_cAlternativo)
			TRY
				loc_oImagem = LOADPICTURE(loc_cAlternativo)
			CATCH TO loc_oErro
				loc_oImagem = .NULL.
				loc_cFalhas = loc_cFalhas + loc_cAlternativo + ": " + ;
					loc_oErro.Message + CHR(13)
			ENDTRY
		ENDIF

		TRY
			THIS.cnt_4c_Container1.obj_4c_TreeView.AddImage(loc_oImagem)
		CATCH TO loc_oErro
			loc_cFalhas = loc_cFalhas + "AddImage: " + loc_oErro.Message + CHR(13)
		ENDTRY

		*-- Imagem obtida eh o caso normal (o alternativo do legado carrega) -
		*-- so avisa quando NENHUM dos dois caminhos entregou a figura.
		IF VARTYPE(loc_oImagem) != "O" AND !EMPTY(loc_cFalhas)
			MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar um " + ;
					"dos " + CHR(237) + "cones da " + CHR(225) + "rvore:" + CHR(13) + ;
					loc_cFalhas, "Erro")
		ENDIF
	ENDPROC

	*==========================================================================
	* CarregarDados - METODO DE CARGA desta tela. Aqui a superficie de lista
	* NAO eh uma grade: eh a arvore (obj_4c_TreeView). Equivale ao par de
	* Valid do legado:
	*   Container1.GetOP.Valid       -> consulta por O.P.   + ThisForm.MakeTree()
	*   Container1.GetEnvelope.Valid -> consulta por Envel. + ThisForm.MakeTreeEnv()
	*
	* Os dois campos sao MUTUAMENTE EXCLUSIVOS no legado (GetOP.GotFocus faz
	* "GetEnvelope.Value = 0" e GetEnvelope.GotFocus faz "GetOP.Value = 0"),
	* por isso o criterio eh simplesmente qual dos dois esta preenchido - nao
	* existe caso de ambos com valor.
	*
	* O "If ! Empty(This.Value)" que envolve os DOIS Valid do legado tambem eh
	* reproduzido: campo vazio nao consulta e nao avisa nada.
	*
	* A consulta em si (SELECT + UNION ALL + fallback de SigPdMvf + figura do
	* produto + agregacao de TotPesos) mora no SIGOPNOPBO (Fase 2); aqui fica
	* so o que eh de TELA: escolher o criterio, exibir a figura e desenhar a
	* arvore.
	*
	* O TRY cobre a chamada ao BO porque SQLEXEC com handle invalido DISPARA
	* excecao em vez de devolver -1 - sem ele o usuario veria o "Program Error"
	* CRU do VFP no lugar do dialogo do sistema. RETURN unico, DEPOIS do
	* ENDTRY (CLAUDE.md #1).
	*==========================================================================
	PROCEDURE CarregarDados()
		LOCAL loc_lSucesso, loc_nOP, loc_nEnvelope, loc_lPorEnvelope
		LOCAL loc_lAchou, loc_oErro, loc_cMensagem

		loc_lSucesso = .F.

		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			MsgErro("Business Object indispon" + CHR(237) + "vel - n" + CHR(227) + ;
					"o foi poss" + CHR(237) + "vel consultar.", "Erro")
		ELSE
			loc_nOP       = THIS.cnt_4c_Container1.txt_4c_OP.Value
			loc_nEnvelope = THIS.cnt_4c_Container1.txt_4c_Envelope.Value

			loc_nOP       = IIF(VARTYPE(loc_nOP) = "N", loc_nOP, 0)
			loc_nEnvelope = IIF(VARTYPE(loc_nEnvelope) = "N", loc_nEnvelope, 0)

			*-- "If ! Empty(This.Value)" dos dois Valid legado: campo em
			*-- branco nao dispara consulta nenhuma (e nao avisa).
			IF loc_nOP != 0 OR loc_nEnvelope != 0
				loc_lPorEnvelope = (loc_nOP = 0)

				TRY
					IF loc_lPorEnvelope
						loc_lAchou = THIS.this_oBusinessObject.PesquisarPorEnvelope(loc_nEnvelope)
					ELSE
						loc_lAchou = THIS.this_oBusinessObject.PesquisarPorOP(loc_nOP)
					ENDIF

					IF loc_lAchou
						*-- Bloco da figura do produto do GetOP.Valid legado -
						*-- so existe no caminho da O.P. (o Valid do
						*-- GetEnvelope nao toca na Imagem).
						IF !loc_lPorEnvelope
							THIS.ExibirImagemProduto()
						ENDIF

						THIS.PopularArvore(loc_lPorEnvelope)
						loc_lSucesso = .T.
					ELSE
						*-- MessageBox do legado: "Envelope Nao Localizado !!!"
						*-- e "O.P. Nao Localizada !!!". Mensagem de validacao
						*-- usa MsgAviso (nao MsgErro).
						loc_cMensagem = ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro)

						IF EMPTY(loc_cMensagem)
							loc_cMensagem = IIF(loc_lPorEnvelope, ;
								"Envelope N" + CHR(227) + "o Localizado !!!", ;
								"O.P. N" + CHR(227) + "o Localizada !!!")
						ENDIF

						MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
					ENDIF
				CATCH TO loc_oErro
					MsgErro("Falha ao consultar as movimenta" + CHR(231) + CHR(245) + "es: " + ;
							loc_oErro.Message + CHR(13) + ;
							"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
							"Procedure: " + loc_oErro.Procedure, "Erro")
				ENDTRY
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExibirImagemProduto - Bloco da figura do produto do GetOP.Valid legado:
	*   Thisform.Arqfigura = lcArquivo
	*   Clear Resources
	*   ThisForm.Imagem.Picture = [] / ThisForm.Imagem.Visible = .f.
	*   If Not Empty(crTmpPro.FigJpgs) And Not IsNull(crTmpPro.FigJpgs)
	*       If (StrToFile(crTmpPro.FigJpgs, lcArquivo) > 0)
	*           ThisForm.Imagem.Picture = (lcArquivo) / .Visible = .t.
	*
	* O StrToFile (e a consulta a SigCdPro) ja rodaram em
	* SIGOPNOPBO.BuscarImagemProduto, que deixa o caminho do .jpg temporario
	* em this_cArquivoImagem APENAS quando a extracao deu certo - por isso o
	* teste aqui equivale ao "StrToFile(...) > 0" do legado.
	*
	* CLEAR RESOURCES eh transcricao literal, nao defesa inventada: sem ele o
	* VFP9 mantem o .jpg ANTERIOR em cache e a tela continua exibindo a figura
	* do produto da pesquisa passada.
	*==========================================================================
	PROTECTED PROCEDURE ExibirImagemProduto()
		LOCAL loc_cArquivo

		loc_cArquivo = ALLTRIM(THIS.this_oBusinessObject.this_cArquivoImagem)

		*-- ThisForm.Arqfigura = lcArquivo - apagado ao Encerrar ("Delete File
		*-- (ThisForm.Arqfigura)" no Click do Commandgroup1, Fase 7).
		THIS.this_cArquivoFigura = loc_cArquivo

		CLEAR RESOURCES

		THIS.img_4c_Imagem.Picture = ""
		THIS.img_4c_Imagem.Visible = .F.

		IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
			THIS.img_4c_Imagem.Picture = loc_cArquivo
			THIS.img_4c_Imagem.Visible = .T.
		ENDIF
	ENDPROC

	*==========================================================================
	* PopularArvore - Desenha os nos a partir do cursor que o BO acabou de
	* montar (this_cCursorArvore = o CrSigCdNei do legado). Transcricao dos
	* PROCEDURE maketree (par_lPorEnvelope = .F.) e maketreeenv
	* (par_lPorEnvelope = .T.), que sao o MESMO algoritmo com cinco textos/
	* icones diferentes - cada diferenca esta anotada abaixo e foi transcrita
	* LITERALMENTE, nao reescrita (CLAUDE.md #17).
	*
	* Hierarquia (nivel, icone):
	*   1 raiz             O.P. (icone 1) | Envelope (icone 5)
	*   2 movimentacao     icone 2 no maketree | icone 1 no maketreeenv
	*   3 Origem/Destino   icone 6 nos dois
	*   4 material         icone 4 se servico, 2 se material (nos dois)
	*   5 qtde / peso2 / peso   icone 2 nos tres
	*
	* Separado de CarregarDados para que a CONSULTA continue valendo quando o
	* ActiveX da arvore nao esta disponivel na estacao (mesma divisao de
	* FormSIGMVMVT.CarregarDados/PopularArvore).
	*
	* "Set Decimals To 3" do legado eh reproduzido em volta do laco (os
	* Transform de 3 decimais dependem dele) e restaurado DEPOIS do ENDTRY,
	* para valer tambem quando o CATCH dispara. SET("Decimals") devolve
	* NUMERICO - NUNCA envolver com VAL() (Pattern #152).
	*==========================================================================
	PROTECTED PROCEDURE PopularArvore(par_lPorEnvelope)
		LOCAL loc_lPorEnvelope, loc_cCursor, loc_oErro, loc_nDecimais
		LOCAL loc_nNo, loc_cTexto, loc_nIcone, loc_lServicos
		LOCAL loc_cChave, loc_cEmpDnPsAnt, loc_cOriDes, loc_cOriDesAnt

		loc_lPorEnvelope = IIF(VARTYPE(par_lPorEnvelope) = "L", par_lPorEnvelope, .F.)
		loc_cCursor      = THIS.this_oBusinessObject.this_cCursorArvore

		IF !USED(loc_cCursor) OR !THIS.ArvoreDisponivel()
			RETURN
		ENDIF

		*-- "ThisForm.Container2.Visible = .t." - primeira linha dos dois
		*-- metodos legado: acende o painel "AGUARDE! / Pesquisando as
		*-- Movimentacoes" enquanto a arvore eh desenhada.
		THIS.cnt_4c_Container2.Visible = .T.

		THIS.PrepararArvore()

		loc_nDecimais = SET("Decimals")
		SET DECIMALS TO 3

		TRY
			SELECT (loc_cCursor)
			GO TOP

			*-- ===== Nivel 1 - no raiz =====
			*-- maketree:    [O.P. : ] + Str(nEnvs) + [ - ] + Cpros +
			*--              Iif(nOpMaes > 0, [ - O.P. Mae: ] + Str(nOpMaes), [ ])
			*-- maketreeenv: [Envelope : ] + Str(nEnvs)
			IF loc_lPorEnvelope
				loc_cTexto = "Envelope : " + ALLTRIM(STR(TratarNulo(Nenvs, 0)))
				loc_nIcone = 5
			ELSE
				loc_cTexto = "O.P. : " + ALLTRIM(STR(TratarNulo(Nenvs, 0))) + " - " + ;
					TratarNulo(Cpros, "") + ;
					IIF(TratarNulo(NopMaes, 0) > 0, ;
						" - O.P. M" + CHR(227) + "e: " + ALLTRIM(STR(TratarNulo(NopMaes, 0))), ;
						" ")
				loc_nIcone = 1
			ENDIF

			WITH THIS.cnt_4c_Container1.obj_4c_TreeView
				loc_nNo = .AddPictureNode(loc_cTexto, 0, 1, loc_nIcone, 0, 0)
				.NodeHeader(loc_nNo)     = .T.
				.NodeExpanded(loc_nNo)   = .T.
				.NodeShowChecks(loc_nNo) = .F.
				.NodeFontBold(loc_nNo)   = 2
			ENDWITH

			loc_cEmpDnPsAnt = ""
			loc_cOriDesAnt  = ""

			SCAN
				*-- Servicos eh coluna bit no SQL Server e o SELECT do BO a
				*-- traz como CAST(... AS INT): chega NUMERICA ao cursor,
				*-- entao a comparacao tem de ser explicita (IIF exige logico
				*-- no 1o argumento - numerico estoura erro 11).
				loc_lServicos = (TratarNulo(Servicos, 0) = 1)

				*-- EmpDnPs eh char(33) POSICIONAL = Emps(3) + Dopps(20) +
				*-- Str(Numps, 10). O PADR repoe as 33 posicoes antes de
				*-- fatiar - o legado fatia o campo do cursor direto, que ja
				*-- vem preenchido (CLAUDE.md #42: o padding FAZ PARTE da chave).
				loc_cChave = PADR(TratarNulo(EmpDnPs, ""), 33)

				loc_cOriDes = TratarNulo(Grupoos, "") + TratarNulo(Contaos, "") + ;
					TratarNulo(Grupods, "") + TratarNulo(Contads, "")

				*-- ===== Nivel 2 - movimentacao (quebra por EmpDnPs) =====
				*-- "Movimentacao : " + Left(EmpDnPs,3) + [/] +
				*--   Alltrim(Substr(EmpDnPs,4,20)) + [/] +
				*--   Alltrim(Right(EmpDnPs,6)) + [ - ] + Dtoc(Datas) + [ - ] +
				*--   Transform(TotPesos,"@Z 999,999.999") + [ Gr]
				*-- O Right(...,6) eh do legado e NAO se "corrige" para 10: o
				*-- Str(Numps,10) eh alinhado a direita, entao os 6 ultimos
				*-- caracteres sao o numero (CLAUDE.md #17 - transcrever).
				*-- Icone: 2 no maketree, 1 no maketreeenv.
				IF !(loc_cEmpDnPsAnt == loc_cChave)
					loc_cTexto = "Movimenta" + CHR(231) + CHR(227) + "o : " + ;
						LEFT(loc_cChave, 3) + "/" + ;
						ALLTRIM(SUBSTR(loc_cChave, 4, 20)) + "/" + ;
						ALLTRIM(RIGHT(loc_cChave, 6)) + " - " + ;
						DTOC(ConverterParaData(Datas)) + " - " + ;
						TRANSFORM(TratarNulo(TotPesos, 0), "@Z 999,999.999") + " Gr"

					WITH THIS.cnt_4c_Container1.obj_4c_TreeView
						loc_nNo = .AddPictureNode(loc_cTexto, 0, 2, ;
							IIF(loc_lPorEnvelope, 1, 2), 0, 0)
						.NodeHeader(loc_nNo)     = .F.
						.NodeExpanded(loc_nNo)   = .F.
						.NodeShowChecks(loc_nNo) = .F.
						.NodeFontBold(loc_nNo)   = 1
					ENDWITH

					loc_cEmpDnPsAnt = loc_cChave

					*-- Origem/Destino logo abaixo da movimentacao nova
					THIS.AdicionarNoOrigemDestino()
					loc_cOriDesAnt = loc_cOriDes

					IF USED(loc_cCursor)
						SELECT (loc_cCursor)
					ENDIF
				ENDIF

				*-- ===== Nivel 3 - Origem/Destino (quebra DENTRO da mesma
				*-- movimentacao). O legado repete o IF, nao usa ELSE. =====
				IF !(loc_cOriDesAnt == loc_cOriDes)
					THIS.AdicionarNoOrigemDestino()
					loc_cOriDesAnt = loc_cOriDes

					IF USED(loc_cCursor)
						SELECT (loc_cCursor)
					ENDIF
				ENDIF

				*-- ===== Nivel 4 - material =====
				*-- maketree:    Alltrim(cMats) + [ - ] + Alltrim(dPros)
				*-- maketreeenv: Iif(nOps = 0, [], Alltrim(Str(nOps)) + [ - ]) +
				*--              Alltrim(cMats) + [ - ] + Alltrim(dPros)
				loc_cTexto = IIF(loc_lPorEnvelope, ;
						IIF(TratarNulo(Nops, 0) = 0, "", ;
							ALLTRIM(STR(TratarNulo(Nops, 0))) + " - "), ;
						"") + ;
					ALLTRIM(TratarNulo(Cmats, "")) + " - " + ;
					ALLTRIM(TratarNulo(Dpros, ""))

				WITH THIS.cnt_4c_Container1.obj_4c_TreeView
					loc_nNo = .AddPictureNode(loc_cTexto, 0, 4, ;
						IIF(loc_lServicos, 4, 2), 0, 0)
					.NodeHeader(loc_nNo)     = .F.
					.NodeExpanded(loc_nNo)   = .F.
					.NodeShowChecks(loc_nNo) = .F.
					.NodeFontBold(loc_nNo)   = IIF(loc_lServicos, 2, 1)
				ENDWITH

				*-- ===== Nivel 5 - quantidade =====
				*-- maketree:    Alltrim(Transform(Qtds,[999,999.999])) + [ ] +
				*--              Iif(qtds = 0, [], cUnis)
				*-- maketreeenv: Alltrim(Transform(Qtds,[999,999.999])) + [ ] + cUnis
				loc_cTexto = ALLTRIM(TRANSFORM(TratarNulo(Qtds, 0), "999,999.999")) + " " + ;
					IIF(loc_lPorEnvelope, ;
						TratarNulo(Cunis, ""), ;
						IIF(TratarNulo(Qtds, 0) = 0, "", TratarNulo(Cunis, "")))

				THIS.AdicionarNoMedida(loc_cTexto)

				*-- ===== Nivel 5 - peso 2 (identico nos dois metodos) =====
				*-- Iif(Servicos, [], Iif(Peso2s = 0, [],
				*--   Alltrim(Transform(Peso2s,[999,999.999])) + [ ] + cUnips))
				loc_cTexto = IIF(loc_lServicos, "", ;
					IIF(TratarNulo(Peso2s, 0) = 0, "", ;
						ALLTRIM(TRANSFORM(TratarNulo(Peso2s, 0), "999,999.999")) + " " + ;
						TratarNulo(Cunips, "")))

				THIS.AdicionarNoMedida(loc_cTexto)

				*-- ===== Nivel 5 - peso =====
				*-- maketree:    Iif(Servicos, [], Alltrim(Transform(Pesos,[999,999.999])) +
				*--                Iif(pesos = 0, [], [ GR]))
				*-- maketreeenv: Iif(Servicos, [], Iif(Pesos = 0, [],
				*--                Alltrim(Transform(Pesos,[999,999.999])) + [ GR]))
				*-- A diferenca eh REAL e nao se uniformiza: com Pesos = 0 em
				*-- linha de material (nao servico) o maketree AINDA desenha o
				*-- no (texto so com o numero) e o maketreeenv nao desenha nada.
				IF loc_lPorEnvelope
					loc_cTexto = IIF(loc_lServicos, "", ;
						IIF(TratarNulo(Pesos, 0) = 0, "", ;
							ALLTRIM(TRANSFORM(TratarNulo(Pesos, 0), "999,999.999")) + " GR"))
				ELSE
					loc_cTexto = IIF(loc_lServicos, "", ;
						ALLTRIM(TRANSFORM(TratarNulo(Pesos, 0), "999,999.999")) + ;
						IIF(TratarNulo(Pesos, 0) = 0, "", " GR"))
				ENDIF

				THIS.AdicionarNoMedida(loc_cTexto)
			ENDSCAN

			*-- "loTree1.ReDraw(.t.) / loTree1.Refresh" do fim dos dois metodos
			WITH THIS.cnt_4c_Container1.obj_4c_TreeView
				.ReDraw(.T.)
				.Refresh()
			ENDWITH

			*-- "ThisForm.pnNodeExp = 1" - nivel corrente de expansao, lido
			*-- pelos botoes Expandir/Regredir (Fwbtng1/Fwbtng2, Fase 7).
			THIS.this_nNodeExp = 1
		CATCH TO loc_oErro
			MsgErro("Falha ao montar a " + CHR(225) + "rvore: " + ;
					loc_oErro.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
					"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY

		*-- Restauracao dos decimais e apagamento do painel ficam FORA do TRY,
		*-- para valerem tambem quando o CATCH dispara.
		SET DECIMALS TO loc_nDecimais

		*-- "ThisForm.Container2.Visible = .F." do fim dos dois metodos
		THIS.cnt_4c_Container2.Visible = .F.
	ENDPROC

	*==========================================================================
	* AdicionarNoOrigemDestino - No de nivel 3, icone 6. O legado repete este
	* bloco IDENTICO em dois pontos de cada metodo (quebra de movimentacao e
	* quebra de Origem/Destino dentro da mesma movimentacao), e identico entre
	* maketree e maketreeenv:
	*   [Origem : ] + Alltrim(GrupoOS) + [/] + Alltrim(ContaOS) + [ - ] +
	*   [Destino : ] + Alltrim(GrupoDS) + [/] + Alltrim(ContaDS)
	*
	* Le o registro CORRENTE do cursor da arvore, como o legado faz dentro do
	* Scan. Campo alcancado por NOME -> EVALUATE para LEITURA (CLAUDE.md #15).
	*==========================================================================
	PROTECTED PROCEDURE AdicionarNoOrigemDestino()
		LOCAL loc_cTexto, loc_nNo, loc_cCursor

		loc_cCursor = THIS.this_oBusinessObject.this_cCursorArvore

		IF !USED(loc_cCursor) OR !THIS.ArvoreDisponivel()
			RETURN
		ENDIF

		loc_cTexto = "Origem : " + ;
			ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Grupoos"), "")) + "/" + ;
			ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Contaos"), "")) + " - " + ;
			"Destino : " + ;
			ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Grupods"), "")) + "/" + ;
			ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Contads"), ""))

		WITH THIS.cnt_4c_Container1.obj_4c_TreeView
			loc_nNo = .AddPictureNode(loc_cTexto, 0, 3, 6, 0, 0)
			.NodeHeader(loc_nNo)     = .F.
			.NodeExpanded(loc_nNo)   = .F.
			.NodeShowChecks(loc_nNo) = .F.
			.NodeFontBold(loc_nNo)   = 1
		ENDWITH
	ENDPROC

	*==========================================================================
	* AdicionarNoMedida - No de nivel 5, icone 2, com a guarda
	* "If ! Empty(lcDados)" que o legado repete nos TRES nos de medida
	* (quantidade, peso 2 e peso). O texto chega montado pelo chamador porque
	* cada um dos tres tem expressao propria - e duas delas diferem entre
	* maketree e maketreeenv.
	*==========================================================================
	PROTECTED PROCEDURE AdicionarNoMedida(par_cTexto)
		LOCAL loc_nNo

		IF EMPTY(par_cTexto) OR !THIS.ArvoreDisponivel()
			RETURN
		ENDIF

		WITH THIS.cnt_4c_Container1.obj_4c_TreeView
			loc_nNo = .AddPictureNode(par_cTexto, 0, 5, 2, 0, 0)
			.NodeHeader(loc_nNo)     = .F.
			.NodeExpanded(loc_nNo)   = .F.
			.NodeShowChecks(loc_nNo) = .F.
			.NodeFontBold(loc_nNo)   = 1
		ENDWITH
	ENDPROC

	*==========================================================================
	* TornarControlesVisiveis - Torna os controles filhos visiveis apos o
	* AddObject (que os cria Visible=.F. por padrao), preservando as DUAS
	* excecoes fieis ao legado: cnt_4c_Container2 (painel "AGUARDE!" -
	* flutuante, Visible=.F. - ver ConfigurarContainers) e img_4c_Imagem
	* (sem produto pesquisado ainda, Visible=.F. no SCX). O container
	* flutuante tem os FILHOS tornados visiveis mesmo assim - pular com
	* LOOP sem recursar deixaria o painel aparecer vazio quando algum
	* metodo o acender mais adiante (Fase 7/8).
	*==========================================================================
	PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
		LOCAL loc_nI, loc_oObjeto

		FOR loc_nI = 1 TO par_oContainer.ControlCount
			loc_oObjeto = par_oContainer.Controls(loc_nI)

			IF VARTYPE(loc_oObjeto) = "O"
				IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CONTAINER2", "IMG_4C_IMAGEM")
					IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
						THIS.TornarControlesVisiveis(loc_oObjeto)
					ENDIF
					LOOP
				ENDIF

				IF PEMSTATUS(loc_oObjeto, "Visible", 5)
					loc_oObjeto.Visible = .T.
				ENDIF

				IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
					THIS.TornarControlesVisiveis(loc_oObjeto)
				ENDIF
			ENDIF
		ENDFOR
	ENDPROC

	*==========================================================================
	* Destroy
	*==========================================================================
	PROCEDURE Destroy
		DODEFAULT()
	ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPNOPBO.prg):
*==============================================================================
* SIGOPNOPBO.PRG
* Business Object para FormSIGOPNOP - Analise de OP/Envelopes
*
* Form OPERACIONAL de consulta (sem tabela unica): pesquisa movimentacoes de
* producao por numero de Envelope (SigCdNei/SigCdNec) ou por numero de O.P.
* (SigCdNei/SigCdNec/SigOpPic/SigPdMvf), monta a arvore de resultado e exibe
* a figura do produto (SigCdPro.FigJpgs) extraida para arquivo temporario.
*==============================================================================

DEFINE CLASS SIGOPNOPBO AS BusinessBase

	*-- Criterios de pesquisa (espelham Container1.GetOP e Container1.GetEnvelope do legado)
	this_nNumeroOP = 0
	this_nNumeroEnvelope = 0

	*-- Cursores de resultado populados pelas pesquisas (Fase 2)
	this_cCursorArvore = "cursor_4c_Arvore"
	this_cCursorProduto = "cursor_4c_Produto"
	this_lRegistroEncontrado = .F.

	*-- Figura do produto extraida de SigCdPro.FigJpgs para arquivo temporario
	this_cArquivoImagem = ""

	*-- REGISTRO CORRENTE da arvore de resultado (THIS.this_cCursorArvore),
	*-- carregado por CarregarDoCursor(). Os nomes espelham as colunas do cursor
	*-- (que por sua vez espelham as colunas do legado lidas no Scan de
	*-- MakeTree/MakeTreeEnv sobre CrSigCdNei).
	this_cCidchaves = ""
	this_nNenvs = 0
	this_cEmpDnPs = ""
	this_dDatas = {}
	this_cGrupoos = ""
	this_cContaos = ""
	this_cGrupods = ""
	this_cContads = ""
	this_lServicos = .F.
	this_nNops = 0
	this_cCmats = ""
	this_cDpros = ""
	this_nQtds = 0
	this_cCunis = ""
	this_nPeso2s = 0
	this_cCunips = ""
	this_nPesos = 0
	this_nTotPesos = 0
	this_cCpros = ""
	this_nNopMaes = 0

	*-- Decomposicao POSICIONAL de EmpDnPs char(33) = Emps(3) + Dopps(20) +
	*-- Str(Numps, 10). O legado decompoe assim no TreeView.DblClick:
	*-- Left(NodeCargo,3) / Substr(NodeCargo,4,20) / Val(Alltrim(Substr(NodeCargo,24)))
	this_cEmps = ""
	this_cDopps = ""
	this_nNumps = 0

	*==============================================================================
	* Init - Inicializa Business Object
	*==============================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- Consulta multi-tabela (SigCdNei/SigCdNec/SigCdPro/SigOpPic/SigPdMvf):
		*-- nao existe tabela mestre unica. O registro eh identificado pela chave de
		*-- movimentacao EmpDnPs char(33), compartilhada pelas tabelas envolvidas.
		THIS.this_cTabela = ""
		THIS.this_cCampoChave = "EmpDnPs"

		THIS.this_nNumeroOP = 0
		THIS.this_nNumeroEnvelope = 0
		THIS.this_cCursorArvore = "cursor_4c_Arvore"
		THIS.this_cCursorProduto = "cursor_4c_Produto"
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""

		THIS.ResetarRegistroCorrente()

		RETURN .T.
	ENDPROC

	*==============================================================================
	* Inserir()/Atualizar()/ExecutarExclusao() do BusinessBase NAO sao
	* sobrescritos aqui: este form eh de CONSULTA (pesquisa movimentacoes de
	* producao por Envelope ou O.P. em SigCdNei/SigCdNec/SigCdPro/SigOpPic/
	* SigPdMvf), sem INSERT/UPDATE/DELETE no legado - o unico efeito colateral
	* eh a extracao da figura do produto para um arquivo temporario (apagado ao
	* Encerrar). O comportamento padrao herdado de BusinessBase para
	* Inserir/Atualizar/ExecutarExclusao/RegistrarAuditoria ja eh o correto para
	* este BO.
	*
	* Conferido no dump legado (SIGOPNOP_form_codigo_fonte.txt): ZERO ocorrencia
	* de TABLEUPDATE(, ZERO de .AddCursor( e ZERO alvo de Insert Into / Update /
	* Delete From. O unico Delete do legado eh "Delete File (ThisForm.Arqfigura)",
	* que apaga o arquivo temporario da figura e nao toca no banco - reproduzido
	* aqui em ExcluirImagemTemporaria(). Inventar um INSERT/UPDATE para este BO
	* exigiria adivinhar a lista de colunas, o que a regra #22 do CLAUDE.md
	* proibe (a lista vem do schema, nunca de adivinhacao).
	*
	* ObterChavePrimaria() SIM eh sobrescrito, porque a identidade do registro
	* corrente (EmpDnPs) nao eh derivavel de this_cTabela/this_cCampoChave.
	*==============================================================================

	*==============================================================================
	* PesquisarPorEnvelope - Pesquisa movimentacoes de producao por numero de
	* Envelope. Equivale ao PROCEDURE Valid de Container1.GetEnvelope no legado
	* (SigCdNei/SigCdNec/SigCdPro), que monta o cursor CrSigCdNei consumido pela
	* arvore (ThisForm.MakeTreeEnv no legado).
	*==============================================================================
	PROCEDURE PesquisarPorEnvelope(par_nNumeroEnvelope)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		THIS.this_cMensagemErro = ""
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""
		loc_lSucesso = .F.

		IF VARTYPE(par_nNumeroEnvelope) != "N" OR par_nNumeroEnvelope = 0
			RETURN .F.
		ENDIF

		THIS.this_nNumeroEnvelope = par_nNumeroEnvelope

		loc_cSQL = "SELECT b.Cidchaves, a.Nenvs, a.EmpDnPs, b.Datas, b.Grupoos, b.Contaos, " + ;
			"b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, a.Nops, a.Cmats, c.Dpros, a.Qtds, c.Cunis, " + ;
			"a.Peso2s, c.Cunips, a.Pesos, SPACE(14) AS Cpros, 0 AS NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c " + ;
			"WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNumeroEnvelope, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros " + ;
			"ORDER BY b.Cidchaves, a.Nops, a.Cmats"

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		SELECT cursor_4c_Nensi
		GO TOP

		IF EOF("cursor_4c_Nensi")
			THIS.this_cMensagemErro = "Envelope N" + CHR(227) + "o Localizado !!!"
			USE IN cursor_4c_Nensi
			RETURN .F.
		ENDIF

		loc_lSucesso = THIS.MontarCursorArvore("cursor_4c_Nensi")

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		THIS.this_lRegistroEncontrado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* PesquisarPorOP - Pesquisa movimentacoes de producao por numero de O.P.
	* Equivale ao PROCEDURE Valid de Container1.GetOP no legado: primeiro tenta a
	* consulta de movimentacao normal (SigCdNei/SigCdNec/SigCdPro/SigOpPic, nos
	* dois sentidos - O.P. propria e O.P. filha de um Envelope); se nao encontrar
	* nada, cai no fallback de O.P. ainda sem movimentacao gerada (SigPdMvf/
	* SigCdNec). Em qualquer dos dois casos, busca a figura do produto em
	* SigCdPro e extrai para arquivo temporario (THIS.this_cArquivoImagem).
	*==============================================================================
	PROCEDURE PesquisarPorOP(par_nNumeroOP)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cProduto

		THIS.this_cMensagemErro = ""
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""
		loc_lSucesso = .F.

		IF VARTYPE(par_nNumeroOP) != "N" OR par_nNumeroOP = 0
			RETURN .F.
		ENDIF

		THIS.this_nNumeroOP = par_nNumeroOP

		loc_cSQL = "SELECT DISTINCT b.Cidchaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas, " + ;
			"b.Grupoos, b.Contaos, b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, 0 AS Nops, " + ;
			"a.Cmats, c.Dpros, a.Qtds, c.Cunis, a.Peso2s, c.Cunips, a.Pesos, d.Cpros, d.NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d " + ;
			"WHERE a.Nops = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros AND a.Nops = d.Nops " + ;
			"UNION ALL " + ;
			"SELECT DISTINCT b.Cidchaves, a.Nenvs, a.EmpDnPs, b.Datas, " + ;
			"b.Grupoos, b.Contaos, b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, 0 AS Nops, " + ;
			"a.Cmats, c.Dpros, a.Qtds, c.Cunis, a.Peso2s, c.Cunips, a.Pesos, d.Cpros, d.NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d " + ;
			"WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.Nops <> " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros AND a.Nenvs = d.Nops " + ;
			"ORDER BY b.Cidchaves, a.Nops, a.Cmats"

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		SELECT cursor_4c_Nensi
		GO TOP

		IF EOF("cursor_4c_Nensi")
			*-- O.P. ainda sem movimentacao gerada - cai no fallback de SigPdMvf,
			*-- igual ao legado ("Nenhum" material agregado, pesos/qtds zerados)
			IF USED("cursor_4c_Nensi")
				USE IN cursor_4c_Nensi
			ENDIF

			loc_cSQL = "SELECT b.Cidchaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas, " + ;
				"b.Grupoos, b.Contaos, b.Grupods, b.Contads, 0 AS Servicos, " + ;
				"0 AS Nops, 'Nenhum        ' AS Cmats, " + ;
				"'Nenhum Material Agregado' AS Dpros, 0 AS Qtds, '   ' AS Cunis, " + ;
				"0 AS Peso2s, '   ' AS Cunips, 0 AS Pesos, a.CodPds AS Cpros, 0 AS NopMaes " + ;
				"FROM SigPdMvf a, SigCdNec b " + ;
				"WHERE a.Nops = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
				" AND a.EmpDnPs = b.EmpDnPs " + ;
				"ORDER BY b.Cidchaves, a.Nops"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
				RETURN .F.
			ENDIF

			SELECT cursor_4c_Nensi
			GO TOP

			IF EOF("cursor_4c_Nensi")
				THIS.this_cMensagemErro = "O.P. N" + CHR(227) + "o Localizada !!!"
				USE IN cursor_4c_Nensi
				RETURN .F.
			ENDIF
		ENDIF

		loc_cProduto = ALLTRIM(cursor_4c_Nensi.Cpros)

		IF !THIS.BuscarImagemProduto(loc_cProduto)
			IF USED("cursor_4c_Nensi")
				USE IN cursor_4c_Nensi
			ENDIF
			RETURN .F.
		ENDIF

		loc_lSucesso = THIS.MontarCursorArvore("cursor_4c_Nensi")

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		THIS.this_lRegistroEncontrado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* MontarCursorArvore - Agrupa os pesos por movimentacao (EmpDnPs, excluindo
	* linhas de servico) e junta o total (TotPesos) a cada linha do cursor de
	* origem, gravando o resultado em THIS.this_cCursorArvore. Equivale ao bloco
	* final repetido no Valid de GetEnvelope e de GetOP do legado (Select ...
	* Sum(Pesos) ... Group by 1 + Select a.*, b.TotPesos ... Into Cursor
	* CrSigCdNei Order by CidChaves, Nops, Cmats).
	*==============================================================================
	PROTECTED PROCEDURE MontarCursorArvore(par_cCursorOrigem)
		LOCAL loc_cCursorTotais

		loc_cCursorTotais = "cursor_4c_Totais"

		IF !USED(par_cCursorOrigem)
			RETURN .F.
		ENDIF

		IF USED(loc_cCursorTotais)
			USE IN (loc_cCursorTotais)
		ENDIF

		SELECT EmpDnPs, SUM(Pesos) AS TotPesos FROM (par_cCursorOrigem) WHERE Servicos = 0 ;
			INTO CURSOR (loc_cCursorTotais) GROUP BY 1

		IF USED(THIS.this_cCursorArvore)
			USE IN (THIS.this_cCursorArvore)
		ENDIF

		SELECT a.*, b.TotPesos FROM (par_cCursorOrigem) a, (loc_cCursorTotais) b ;
			WHERE a.EmpDnPs = b.EmpDnPs ;
			INTO CURSOR (THIS.this_cCursorArvore) READWRITE ;
			ORDER BY a.CidChaves, a.Nops, a.Cmats

		IF USED(loc_cCursorTotais)
			USE IN (loc_cCursorTotais)
		ENDIF

		RETURN USED(THIS.this_cCursorArvore) AND RECCOUNT(THIS.this_cCursorArvore) > 0
	ENDPROC

	*==============================================================================
	* BuscarImagemProduto - Localiza o produto em SigCdPro e extrai a figura
	* (FigJpgs) para um arquivo .jpg temporario, exatamente como o legado faz no
	* final do Valid de GetOP (StrToFile sobre o campo memo). Ausencia de figura
	* NAO eh erro - THIS.this_cArquivoImagem fica vazio e o Form nao exibe nada.
	*==============================================================================
	PROTECTED PROCEDURE BuscarImagemProduto(par_cProduto)
		LOCAL loc_cSQL, loc_nResultado, loc_cNomeArquivo

		THIS.this_cArquivoImagem = ""

		IF VARTYPE(par_cProduto) != "C" OR EMPTY(ALLTRIM(par_cProduto))
			RETURN .T.
		ENDIF

		IF USED(THIS.this_cCursorProduto)
			USE IN (THIS.this_cCursorProduto)
		ENDIF

		loc_cSQL = "SELECT Cpros, Dpros, FigJpgs FROM SigCdPro WHERE Cpros = " + ;
			EscaparSQL(par_cProduto)

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProduto)

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		IF USED(THIS.this_cCursorProduto)
			SELECT (THIS.this_cCursorProduto)
			GO TOP

			IF !EOF() ;
					AND !EMPTY(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs")) ;
					AND !ISNULL(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs"))

				loc_cNomeArquivo = SYS(2023) + "\" + ALLTRIM(SYS(2015)) + ".jpg"

				IF STRTOFILE(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs"), loc_cNomeArquivo) > 0
					THIS.this_cArquivoImagem = loc_cNomeArquivo
				ENDIF
			ENDIF
		ENDIF

		RETURN .T.
	ENDPROC


	*==============================================================================
	* CarregarDoCursor - Carrega o registro CORRENTE do cursor da arvore para as
	* propriedades do BO. Eh o que o Form consome ao montar a arvore e ao tratar o
	* no selecionado: no legado, cada iteracao do "Scan" de MakeTree/MakeTreeEnv
	* le essas MESMAS colunas direto do cursor CrSigCdNei.
	*
	* Sem par_cAliasCursor assume THIS.this_cCursorArvore.
	*
	* A work area corrente eh SALVA e RESTAURADA: o Form chama este metodo de
	* dentro de lacos que percorrem o proprio cursor, e trocar a area sem repor
	* quebraria o SCAN do chamador. Por isso ha um unico RETURN, no fim.
	*==============================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_cAlias, loc_nAreaAnterior, loc_lSucesso, loc_cChave

		loc_lSucesso = .F.

		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
			ALLTRIM(par_cAliasCursor), THIS.this_cCursorArvore)

		IF !USED(loc_cAlias)
			THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
				"o est" + CHR(225) + " aberto."
		ELSE
			loc_nAreaAnterior = SELECT()
			SELECT (loc_cAlias)

			*-- Cursor em EOF/BOF nao eh falha: apenas nao ha registro corrente
			*-- para carregar (a arvore chama este metodo dentro de laco)
			IF !EOF() AND !BOF()
				THIS.this_cCidchaves = TratarNulo(Cidchaves, "")
				THIS.this_nNenvs     = TratarNulo(Nenvs, 0)
				THIS.this_cEmpDnPs   = TratarNulo(EmpDnPs, "")
				THIS.this_dDatas     = ConverterParaData(Datas)
				THIS.this_cGrupoos   = TratarNulo(Grupoos, "")
				THIS.this_cContaos   = TratarNulo(Contaos, "")
				THIS.this_cGrupods   = TratarNulo(Grupods, "")
				THIS.this_cContads   = TratarNulo(Contads, "")
				THIS.this_nNops      = TratarNulo(Nops, 0)
				THIS.this_cCmats     = TratarNulo(Cmats, "")
				THIS.this_cDpros     = TratarNulo(Dpros, "")
				THIS.this_nQtds      = TratarNulo(Qtds, 0)
				THIS.this_cCunis     = TratarNulo(Cunis, "")
				THIS.this_nPeso2s    = TratarNulo(Peso2s, 0)
				THIS.this_cCunips    = TratarNulo(Cunips, "")
				THIS.this_nPesos     = TratarNulo(Pesos, 0)
				THIS.this_cCpros     = TratarNulo(Cpros, "")
				THIS.this_nNopMaes   = TratarNulo(NopMaes, 0)

				*-- Servicos eh coluna bit no SQL Server. O SELECT do BO a traz
				*-- como CAST(... AS INT), entao chega SEMPRE numerica ao cursor.
				*-- A conversao aqui entrega um LOGICO de verdade ao Form, que
				*-- precisa dele para usar IIF() (IIF exige logico no 1o argumento).
				THIS.this_lServicos = ConverterParaLogico(TratarNulo(Servicos, 0))

				*-- TotPesos so existe no cursor da arvore (eh o total agregado por
				*-- movimentacao). Alias cru de SQLEXEC nao tem essa coluna, e nome
				*-- de campo inexistente estoura "Variable ... is not found" - por
				*-- isso o TYPE() antes (PEMSTATUS NAO serve para cursor).
				IF TYPE(loc_cAlias + ".TotPesos") = "N"
					THIS.this_nTotPesos = TratarNulo(EVALUATE(loc_cAlias + ".TotPesos"), 0)
				ELSE
					THIS.this_nTotPesos = 0
				ENDIF

				*-- EmpDnPs char(33) eh chave POSICIONAL: Emps(3) + Dopps(20) +
				*-- Str(Numps, 10). O legado decompoe exatamente nessas fatias
				*-- (Left / Substr / Val) no TreeView.DblClick. O PADR garante as
				*-- 33 posicoes antes de fatiar; NUNCA aplicar ALLTRIM nas partes
				*-- INTERIORES, porque o padding FAZ PARTE da chave.
				loc_cChave = PADR(THIS.this_cEmpDnPs, 33)
				THIS.this_cEmps  = LEFT(loc_cChave, 3)
				THIS.this_cDopps = SUBSTR(loc_cChave, 4, 20)
				THIS.this_nNumps = VAL(ALLTRIM(SUBSTR(loc_cChave, 24)))

				loc_lSucesso = .T.
			ENDIF

			IF loc_nAreaAnterior > 0
				SELECT (loc_nAreaAnterior)
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* MontarChaveEmpDnPs - Remonta a chave POSICIONAL EmpDnPs:
	*     Emps char(3) + Dopps char(20) + Str(Numps, 10) = char(33)
	* A largura do char(33) destino (SigCdNei / SigCdNec / SigPdMvf / SigOpPic) eh
	* a conferencia da montagem: 3 + 20 + 10 = 33.
	*
	* PADR EXPLICITO em cada parte. ALLTRIM nas partes INTERIORES encurtaria a
	* chave, ela nunca casaria no WHERE e o SELECT devolveria ZERO linhas em
	* SILENCIO - sem erro e sem log. Nao confiar no padding que o cursor por
	* acaso traz: as propriedades do BO podem ter vindo de um TextBox.
	*==============================================================================
	PROCEDURE MontarChaveEmpDnPs(par_cEmps, par_cDopps, par_nNumps)
		LOCAL loc_cEmps, loc_cDopps, loc_nNumps

		loc_cEmps  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
		loc_cDopps = IIF(VARTYPE(par_cDopps) = "C", par_cDopps, "")
		loc_nNumps = IIF(VARTYPE(par_nNumps) = "N", par_nNumps, 0)

		RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopps, 20) + STR(loc_nNumps, 10)
	ENDPROC

	*==============================================================================
	* ObterChavePrimaria - Identidade do registro corrente, usada pela auditoria
	* da BusinessBase. Nesta consulta nao existe tabela mestre unica: o registro
	* eh identificado pela chave de movimentacao EmpDnPs, coluna char(33) que
	* SigCdNei, SigCdNec, SigPdMvf e SigOpPic compartilham.
	*
	* ALLTRIM aqui eh na chave INTEIRA (no fim), nao nas partes - isso eh
	* inofensivo, porque char no SQL Server compara com blank-padding ANSI.
	*==============================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		LOCAL loc_cChave

		loc_cChave = ALLTRIM(THIS.this_cEmpDnPs)

		IF EMPTY(loc_cChave)
			loc_cChave = ALLTRIM(THIS.MontarChaveEmpDnPs(THIS.this_cEmps, ;
				THIS.this_cDopps, THIS.this_nNumps))
		ENDIF

		RETURN loc_cChave
	ENDPROC

	*==============================================================================
	* ResetarRegistroCorrente - Zera as propriedades do registro corrente da
	* arvore. Chamado pelo Init e pelo LimparDados: o Form nao eh fechado entre
	* uma pesquisa e outra, entao sem este reset a pesquisa seguinte exibiria
	* residuo da anterior quando o novo cursor viesse vazio.
	*==============================================================================
	PROTECTED PROCEDURE ResetarRegistroCorrente()
		THIS.this_cCidchaves = ""
		THIS.this_nNenvs     = 0
		THIS.this_cEmpDnPs   = ""
		THIS.this_dDatas     = {}
		THIS.this_cGrupoos   = ""
		THIS.this_cContaos   = ""
		THIS.this_cGrupods   = ""
		THIS.this_cContads   = ""
		THIS.this_lServicos  = .F.
		THIS.this_nNops      = 0
		THIS.this_cCmats     = ""
		THIS.this_cDpros     = ""
		THIS.this_nQtds      = 0
		THIS.this_cCunis     = ""
		THIS.this_nPeso2s    = 0
		THIS.this_cCunips    = ""
		THIS.this_nPesos     = 0
		THIS.this_nTotPesos  = 0
		THIS.this_cCpros     = ""
		THIS.this_nNopMaes   = 0
		THIS.this_cEmps      = ""
		THIS.this_cDopps     = ""
		THIS.this_nNumps     = 0

		RETURN .T.
	ENDPROC

	*==============================================================================
	* LimparDados - Zera criterios de pesquisa e registro corrente, fechando os
	* cursores de resultado. O Form chama isto ao limpar a tela (no legado os dois
	* TextBox se zeram mutuamente: GetOP.GotFocus zera GetEnvelope e o GotFocus de
	* GetEnvelope zera GetOP).
	*==============================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_nNumeroOP = 0
		THIS.this_nNumeroEnvelope = 0
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cMensagemErro = ""

		THIS.ResetarRegistroCorrente()
		THIS.FecharCursoresResultado()

		RETURN .T.
	ENDPROC

	*==============================================================================
	* FecharCursoresResultado - Fecha os cursores de resultado da consulta.
	*
	* O guard eh pelo BUFFERING, nao so pelo USED(): TABLEREVERT() EXIGE row ou
	* table buffering e, sem ele, dispara o erro 1586 em vez de ser no-op. Cursor
	* nascido de CREATE CURSOR ou de SELECT INTO CURSOR vem com Buffering = 1, e
	* nesse caso USE IN fecha o alias sozinho, mesmo com buffer sujo.
	*==============================================================================
	PROCEDURE FecharCursoresResultado()
		LOCAL ARRAY loc_aCursores[3]
		LOCAL loc_nI, loc_cCursor

		loc_aCursores[1] = THIS.this_cCursorArvore
		loc_aCursores[2] = THIS.this_cCursorProduto
		loc_aCursores[3] = "cursor_4c_Nensi"

		FOR loc_nI = 1 TO ALEN(loc_aCursores)
			loc_cCursor = loc_aCursores[loc_nI]

			IF VARTYPE(loc_cCursor) = "C" AND !EMPTY(loc_cCursor) AND USED(loc_cCursor)
				IF CURSORGETPROP("Buffering", loc_cCursor) > 1
					TABLEREVERT(.T., loc_cCursor)
				ENDIF
				USE IN (loc_cCursor)
			ENDIF
		ENDFOR

		RETURN .T.
	ENDPROC

	*==============================================================================
	* ExcluirImagemTemporaria - Apaga o .jpg que BuscarImagemProduto extraiu de
	* SigCdPro.FigJpgs. Equivale ao "Delete File (ThisForm.Arqfigura)" que o legado
	* executa no Click do botao de saida (Commandgroup1).
	*
	* CLEAR RESOURCES antes de apagar: o VFP mantem o bitmap em cache e o arquivo
	* fica preso enquanto o cache nao eh liberado (o legado faz o mesmo antes de
	* trocar a figura). SET SAFETY OFF em volta do DELETE FILE porque com SAFETY ON
	* ele abre dialogo de confirmacao, e dialogo modal travaria o pipeline.
	*==============================================================================
	PROCEDURE ExcluirImagemTemporaria()
		LOCAL loc_cArquivo, loc_cSafety

		loc_cArquivo = ALLTRIM(THIS.this_cArquivoImagem)
		THIS.this_cArquivoImagem = ""

		IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
			CLEAR RESOURCES

			loc_cSafety = SET("SAFETY")
			SET SAFETY OFF

			DELETE FILE (loc_cArquivo)

			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF
		ENDIF

		RETURN .T.
	ENDPROC

	*==============================================================================
	* Destroy - Libera os cursores de resultado e o arquivo temporario da figura.
	*==============================================================================
	PROCEDURE Destroy()
		THIS.ExcluirImagemTemporaria()
		THIS.FecharCursoresResultado()

		DODEFAULT()
	ENDPROC
ENDDEFINE

