# FASE A: Layout Visual - FormSigPdMp3 (APENAS UI)

**FOCO EXCLUSIVO: LAYOUT PIXEL-PERFECT. Funcionalidade sera adicionada na Fase B.**

## OBJETIVO
Criar o layout visual IDENTICO ao sistema legado. Copiar TODAS as propriedades visuais
(Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize, Caption, InputMask)
EXATAMENTE como estao no codigo fonte original.

## REGRA #1: UI FIDELITY ACIMA DE TUDO
- Cada controle DEVE ter as propriedades visuais EXATAS do original
- Posicoes (Top/Left) DEVEM ser copiadas sem arredondamento
- Cores (BackColor/ForeColor) DEVEM ser RGB identico
- Fontes (FontName/FontSize/FontBold) DEVEM ser identicas
- Tamanhos (Width/Height) DEVEM ser identicos
- **Compensar PageFrame.Top=-29**: controles dentro de Pages recebem +29 no Top
- **Picture do Form**: Se o form original tem .Picture (background image), COPIAR para o form migrado usando gc_4c_CaminhoIcones + nome_arquivo. Ex: `THIS.Picture = gc_4c_CaminhoIcones + "fundo_cadastro.jpg"`
- **Caption com hotkeys (\<)**: PRESERVAR marcadores \< em Captions de labels. Ex: `"\<Atendente :"` (o \< define tecla de atalho). NUNCA remover \<.
- **Width/Height de Labels**: Copiar valores EXATOS. NAO usar AutoSize = .T. em labels que tem Width explicito no original.
- **Cursor do Grid CRUD**: O cursor principal do grid DEVE se chamar `cursor_4c_Dados` (nome padrao verificado pelo TesteAutomatico).

## REGRA #2: STUBS SAO PERMITIDOS NESTA FASE
Metodos de evento (Btn*Click, Validar*, Lookup*, Tecla*) podem ser stubs vazios:
`foxpro
PROCEDURE BtnIncluirClick()
    *-- Fase B: implementar logica
ENDPROC
`

Metodos de DADOS podem ser stubs:
`foxpro
PROTECTED PROCEDURE CarregarLista()
    *-- Fase B: implementar SQL
ENDPROC

PROTECTED PROCEDURE FormParaBO()
    *-- Fase B: implementar binding
ENDPROC
`

## REGRA #3: O QUE DEVE ESTAR COMPLETO
- **BO**: Apenas declaracao de propriedades this_* e Init() com this_cTabela/this_cCampoChave
- **Form Init/InicializarForm**: COMPLETO (cria estrutura visual)
- **ConfigurarPageFrame**: COMPLETO (Pages, BackColor, Caption, Picture)
- **ConfigurarPaginaLista**: COMPLETO (Grid com colunas, Container de botoes CRUD com icones)
- **ConfigurarPaginaDados**: COMPLETO (TODOS os campos, labels, containers, botoes)
- **TornarControlesVisiveis**: COMPLETO (com filtro de containers flutuantes se OPERACIONAL)
- **AlternarPagina**: COMPLETO
- **HabilitarCampos/LimparCampos**: COMPLETO (iterar sobre controles)

## Arquivos de Referencia
1. **CLAUDE.md** - Secao UI FIDELITY (propriedades obrigatorias, compensacao Top+29)
2. **tasks/task144/SigPdMp3_form_codigo_fonte.txt** - Codigo fonte original (PROPRIEDADES VISUAIS)
3. **tasks/task144/mapeamento.json** - Mapeamento de objetos (nomes legado -> novo)

## Arquivos a Criar
1. **C:\4c\projeto\app\classes\SigPdMp3BO.prg** - BO com propriedades this_* e Init() apenas
2. **C:\4c\projeto\app\forms\operacionais\FormSigPdMp3.prg** - Form com layout COMPLETO

## Regras VFP Criticas
- CHR() para acentos (a=225, c=231, ao=227, e=233, i=237, o=243)
- NUNCA RETURN dentro de TRY/CATCH
- BINDEVENT metodos PUBLIC (sem PROTECTED)
- **BINDEVENT "Valid" NAO FUNCIONA em TextBox**: Usar "KeyPress" (ENTER=13/TAB=9) para simular Valid. NUNCA usar LostFocus para chamar MontaGrade/CarregarDados/SQLEXEC - LostFocus dispara SEMPRE (inclusive por SetFocus de outro controle) causando RECURSAO INFINITA. Ex: BINDEVENT(txt, "KeyPress", THIS, "TxtCampoKeyPress") e no handler: IF par_nKeyCode = 13 OR par_nKeyCode = 9 ... ENDIF
- **Page.Visible NAO EXISTE**: Page (PageFrame.PageN) NAO tem propriedade Visible. NUNCA .Page1.Visible = .T..
- **PageFrame.Visible OBRIGATORIO**: AddObject cria controles com Visible=.F. SEMPRE adicionar THIS.pgf_4c_Paginas.Visible = .T. ANTES de ActivePage = 1 no InicializarForm. Sem isso form abre em branco.
- **Buttons(N) vs ButtonCount**: Ao fazer BINDEVENT em Buttons(N), N DEVE ser <= ButtonCount. Verificar no AddObject qual era o ButtonCount antes de referenciar.
- TextBox.Value inicializar: "" (string), 0 (numerico), {} (data)
- AddObject cria Visible=.F. - setar .Visible = .T.
- PageCount ANTES de acessar .Page1/.Page2
- NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1)
- PageFrame NAO tem BackColor (usar Page1.BackColor)
- Grid NAO tem AllowAddNew/AllowDelete/AllowEdit
- CommandGroup e OptionGroup: SEMPRE definir .ButtonCount ANTES de acessar .Buttons(N)
- NUNCA fazer self-assignment: THIS.pgf_4c_Paginas = THIS.pgf_4c_Paginas (causa erro "is a method, event, or object")
- Botoes CRUD: Width=75, Height=75, Left sequencial (5,80,155,230,305,380)
- ControlBox=.F., TitleBar=0 (sem barra de titulo)
- Themes=.F. em TODOS os botoes
- Variaveis legadas (_EMPR, _EMPRESA, pEmp): substituir por go_4c_Sistema.cCodEmpresa
- **this_cMensagemErro**: SEMPRE declarar 	his_cMensagemErro = "" nas propriedades do Form (NAO herdado de FormBase, necessario para CATCH blocks)
- **REPORT FORM TO FILE**: Pre-computar caminho em variavel LOCAL + macro expansion &var (expressoes inline NAO funcionam)
- **MESSAGEBOX PROIBIDO**: NUNCA usar MESSAGEBOX() direto. Usar funcoes de messages.prg: MsgInfo() para informativo (icone 64), MsgAviso() para aviso (icone 48), MsgErro() para erro (icone 16), MsgConfirma() para confirmacao Sim/Nao. Essas funcoes suprimem dialogs em modo de teste automatizado.
- **CheckBox em Grid Column (Error 1767)**: Para grids com CheckBox, a UNICA definicao de ControlSource deve ser Column1.ControlSource = "cursor.campo" DEPOIS de CurrentControl = "Check1". NUNCA definir Check1.ControlSource (conflita com Column) E NUNCA definir Column1.ControlSource ANTES de AddObject("Check1").
- **AddObject sintaxe CORRETA**: parent.AddObject("nome", "Classe") - ambos strings. NUNCA parent.AddObject(loc_oObj, "nome") (objeto como parametro causa "Function argument invalid"). Padrao: parent.AddObject("cmd_4c_X", "CommandButton") + WITH parent.cmd_4c_X para configurar.
- **Grid Column CurrentControl="Check1" EXIGE AddObject**: ANTES de .Column1.CurrentControl = "Check1", OBRIGATORIO: .Column1.AddObject("Check1", "CheckBox") + .Column1.Check1.Caption = "". Sem isso, erro "Unknown member CHECK1" cascateia e destroi toda inicializacao.
- **CheckBox .Value SEMPRE NUMERICO**: Inicializar CheckBox com .Value = 1 (marcado) ou .Value = 0 (desmarcado). NUNCA usar .T./.F. (logico). Comparar com = 1/= 0, IIF com IIF(chk.Value = 1, ...). Misturar tipos causa "Operator/operand type mismatch".
- **IF THEN inline PROIBIDO**: VFP9 NAO suporta IF cond THEN cmd numa unica linha. Gera "Command contains unrecognized phrase/keyword." SEMPRE expandir para multi-linha: IF cond /   cmd / ENDIF.
- **COUNT TO var IN alias PROIBIDO**: VFP9 COUNT nao tem clausula IN. Gera "Command contains unrecognized phrase/keyword." Usar: SELECT alias + COUNT TO var.
- **APPEND FROM requer SELECT cursor antes**: ZAP IN cursor_name NAO muda a work area corrente. APPEND FROM DBF("tmp") vai para a work area CORRENTE. SEMPRE fazer SELECT cursor_destino antes de APPEND FROM. Sem isso, dados vao para o cursor errado e o grid fica vazio.
- **CommandGroup.FontName NAO EXISTE**: CommandGroup (como OptionGroup) NAO tem FontName/FontSize. Definir em cada .Buttons(N).FontName. Tentar no grupo causa "Property FONTNAME is not found" que cascateia e impede toda configuracao dos botoes.
- **AlternarPagina DEVE chamar AjustarBotoesPorModo**: Em forms CRUD, ao voltar para Page1 (LISTA), OBRIGATORIO chamar THIS.AjustarBotoesPorModo() ANTES de THIS.CarregarLista(). Sem isso os botoes ficam desabilitados apos Incluir/Alterar/Visualizar.
- **CommandGroup BackStyle/BorderStyle EXATOS do original**: Se o original tem BackStyle=0 + BorderStyle=0, o CommandGroup eh TRANSPARENTE (container logico invisivel). NUNCA adicionar BackColor quando original nao tem. Copiar BackStyle, BorderStyle, SpecialEffect EXATOS.
- **ForeColor de Labels: COPIAR do original, NUNCA assumir**: Labels sobre fundo escuro usam ForeColor branco, labels sobre fundo claro usam ForeColor cinza (90,90,90). Copiar ForeColor EXATO do codigo fonte original. Assumir cor "baseado no tema" causa labels INVISIVEIS.
- **Buttons(N) dentro de CommandGroup: propriedades EXATAS**: Left, Top, FontName, FontBold, FontItalic, BackColor, ForeColor dos Buttons DEVEM vir do codigo fonte original. NUNCA inventar Left=0 ou FontName="Tahoma" quando original tem Left=178 ou FontName="Comic Sans MS".
- **Propriedades do BO preservam sufixo "s" da coluna do banco**: Colunas como Moedas, Contas, Grupos mapeiam para this_cMoedas, this_cContas, this_cGrupos. NUNCA "corrigir" removendo o "s" (this_cMoeda NAO EXISTE ? "Property not found"). Verificar nome EXATO no DEFINE CLASS do BO.
- **Nomes de icones/imagens: COPIAR EXATO do original**: O atributo .Picture deve ter o nome de arquivo EXATO do original (ex: geral_procura_60.jpg, cadastro_sair_60.jpg). Trocar APENAS o path: ..\framework\imagens\ ? gc_4c_CaminhoIcones +. NUNCA inventar nomes de arquivo (ex: consultar.bmp NAO EXISTE).
- **Propriedades do FORM: COPIAR TODAS do original**: TitleBar, ControlBox, MaxButton, MinButton, Closable, ClipControls DEVEM ser copiadas do codigo fonte original. Se original tem TitleBar = 0 (sem barra de titulo), migrado DEVE ter TitleBar = 0. Omitir essas propriedades faz VFP9 usar defaults (barra de titulo visivel) alterando completamente a aparencia do form.
- **CommandButton ForeColor/BackColor/Themes EXATOS**: Botoes avulsos DEVEM copiar ForeColor, BackColor, FontName, FontBold, FontItalic, Themes do original. Se original tem ForeColor=90,90,90 + BackColor=255,255,255 + Themes=.F., copiar EXATO. ForeColor=RGB(255,255,255) em fundo claro torna texto INVISIVEL.
- **Grid RecordMark/DeleteMark em OPERACIONAL**: Grids criados manualmente (AddObject) em forms OPERACIONAIS DEVEM ter .RecordMark = .F. e .DeleteMark = .F.. Sem isso, barras de marcacao aparecem na lateral esquerda do grid.
- **ChkRegister NAO EXISTE em BusinessBase**: O legado usa `ThisForm.poDataMgr.ChkRegister()` para verificar duplicidade. Na migracao, usar SQLEXEC com `SELECT COUNT(*) AS nExiste FROM tabela WHERE campo = valor` + verificar `NVL(cursor.nExiste, 0) > 0`. NUNCA chamar ChkRegister no BO.
- **cnt_4c_Cabecalho FUNDO CINZA MEDIO OPACO**: O cntSombra do framework.vcx tem BackColor=RGB(100,100,100) (cinza medio, NAO escuro). cnt_4c_Cabecalho DEVE ter BackStyle=1 (opaco) + BackColor=RGB(100,100,100) + lbl_4c_Titulo.ForeColor=RGB(255,255,255) (branco sobre cinza). Valor RGB(100,100,100) (quase preto) eh ERRADO - usar 100 (cinza medio do framework). BackStyle=0 torna o cabecalho INVISIVEL. Bug corrigido em 2026-05-15 (system-wide).
- **NovoRegistro()/EditarRegistro() DEVEM chamar DODEFAULT()**: BOs que sobrescrevem NovoRegistro() ou EditarRegistro() DEVEM chamar DODEFAULT() como primeira linha. Sem isso, BusinessBase NAO seta this_lEmEdicao=.T. e Salvar() SEMPRE retorna .F. silenciosamente.
- **Botoes CRUD LADO DIREITO, posicoes EXATAS (ver framework_frmcadastro_layout.md)**: cnt_4c_Botoes Left=542 Width=390 (LADO DIREITO, NUNCA esquerdo!). Botoes internos Width=75, Left=5,80,155,230,305. FontName="Comic Sans MS" (NAO Tahoma). Encerrar em cnt_4c_Saida SEPARADO (Left=935, W=60). Grid FontName="Verdana". TODAS as posicoes padrao estao em `docs/framework_frmcadastro_layout.md`.
- **Lookup textbox DEVE disparar em ENTER/TAB alem de F4**: Campos com lookup (fwBuscaExt no legado) DEVEM disparar busca em F4(115) E ENTER(13)/TAB(9) no KeyPress handler. O Valid original disparava ao sair do campo. Se o usuario digitar valor e pressionar TAB sem handler, nada acontece.
- **F4=115, F5=116 em KeyPress**: NUNCA usar 63 (que eh '?'). Codigos corretos: ENTER=13, TAB=9, F4=115, F5=116, ESC=27
- **Campos BIT do SQL Server**: Chegam como LOGICAL (.T./.F.) no VFP9. NUNCA usar NVL(campo,0)=1. Usar IF campo / IF !campo direto. NUMERIC(1,0) sim usa NVL.
- **Lookup ao sair do campo**: KeyPress com ENTER/TAB deve VALIDAR valor digitado contra tabela de referencia. Se encontrar, preencher descricao. Se nao encontrar, abrir FormBuscaAuxiliar. F4/F5 sempre abre lookup direto.
- **Z-ORDER AddObject em Page2**: Quando Page2 tem PageFrame interno + OptionGroup/botoes de navegacao, adicionar `ZOrder(0)` nos controles de navegacao APOS adicionar o PageFrame. VFP9 AddObject coloca ultimo objeto no topo do z-order, cobrindo controles anteriores.
- **PageFrame interno .Tabs = .F.**: PageFrame interno que usa OptionGroup para navegacao entre sub-paginas DEVE ter `.Tabs = .F.`. Se .Tabs = .T., tabs nativos do VFP9 ficam visiveis e consomem espaco, sobrepondo controles.
- **Container Left+Width <= Form.Width**: Validar que Left + Width de TODOS os containers nao exceda Form.Width (normalmente 1000). Container parcialmente fora da area visivel fica cortado ou inacessivel.
- **NUNCA inventar tabelas de lookup**: Se o original NAO faz Seek/lookup de descricao para um campo, NAO criar query de lookup. Tabelas como SigCdCcr, SigCdJob NAO existem. Copiar nomes de tabela EXATAMENTE do codigo original. Se nao ha lookup no original, o campo eh apenas exibido.
- **WHERE Emps SOMENTE em tabelas que tem a coluna**: Tabelas de cadastro generico (SigCdGcr, SigCdMoe, SigCdCor, SigCdUni) tipicamente NAO tem coluna Emps. Antes de adicionar `WHERE Emps = go_4c_Sistema.cCodEmpresa`, verificar no schema.sql se a tabela realmente tem essa coluna. Na duvida, omitir o filtro.
- **Propriedades this_ DECLARAR com nome EXATO do uso**: TODA propriedade referenciada como THIS.this_cXxx no codigo DEVE ter declaracao IDENTICA this_cXxx = "" no cabecalho DEFINE CLASS. Nomes amigaveis diferentes (ex: declarar this_cUltGrupo mas usar THIS.this_cUltCgrus) causam Error 174 Property not found no primeiro LostFocus.
- **Container.BorderStyle NAO EXISTE**: Container VFP9 tem BorderWidth mas NAO tem BorderStyle (propriedade de CommandGroup/OptionGroup). Usar apenas .BorderWidth = 0. CorretorAuto #68 remove automaticamente.
- **Containers de botoes CRUD TRANSPARENTES**: Containers que hospedam botoes CRUD em forms frmcadastro (cnt_4c_Botoes, cnt_4c_Saida, cnt_4c_BotoesDados) DEVEM usar BackStyle=0 (transparente), NUNCA BackStyle=1 com BackColor=RGB(100,100,100) ou similar escuro. O fundo do form ja e fornecido por Page.Picture (fundo_cad_1003.jpg); container opaco escuro cria caixa cinza ao redor dos botoes que destoa do layout original. EXCECAO UNICA: cnt_4c_Cabecalho usa opaco escuro propositalmente (cntSombra).
- **PageFrame.Height = Form.Height + 29**: Em forms frmcadastro com PageFrame oculto (Tabs=.F., Top=-29), o pgf_4c_Paginas.Height DEVE ser Form.Height + 29 (NAO igual a Form.Height). Com Top=-29 e Height=Form.Height, sobram 29px descobertos no bottom expondo o fundo cinza nativo do form como borda indesejada. Formula: Form.Height=600 -> PageFrame.Height=629. Form.Height=650 -> PageFrame.Height=679.

- **IIF() exige LOGICAL no 1o argumento**: IIF(numerico, ...) quebra com "Function argument value, type, or count is invalid" quando valor=0. Em TEXTMERGE SQL e conversoes, SEMPRE comparar: IIF(this_nFlag = 1, '1', '0'). NUNCA passar numerico direto: IIF(this_nFlag, '1', '0').
- **CheckBox .Value = 0 no AddObject (NAO .F.)**: AddObject CheckBox DEVE inicializar .Value = 0 (NUMERIC). Usar .Value = .F. cria LOGICAL e conflita com LimparCampos (.Value = 0, NUMERIC) e BOParaForm - dispara "Operator/operand type mismatch" no primeiro uso. BOParaForm: usar chk.Value = IIF(this_lProp, 1, 0) ou IIF(this_nProp = 1, 1, 0), nunca atribuir LOGICAL direto.
- **cmd_4c_Encerrar.Caption = "Encerrar"**: Botao Encerrar DEVE ter .Caption = "Encerrar" (NAO "X", "Sair" ou ""). A Picture "cadastro_sair_60.jpg" NAO cobre a caption; captions errados aparecem como texto abaixo do icone. Padrao dos forms CRUD (FormCor, FormMoe).
- **PADRAO CANONICO SAIDA/ENCERRAR ï¿½ PREVALECE SOBRE PILAR 1 (pixel-perfect legado)**: O bloco de saida (container + botao Encerrar) DEVE seguir o padrao canonico do sistema novo (FormCor), IGNORANDO os valores do SCX legado. Canonical (inegociavel): cnt_4c_Saida.Left=917, Width=90, Height=85; cmd_4c_Encerrar.Left=5, Top=5, Width=75, Height=75, Caption="Encerrar". Se o SCX legado tiver Grupo_Saida.Left=935 W=60 ou botao X com W=50/Caption="X"/"Sair"/"Fechar", IGNORE e use o canonico. O mesmo vale para .Width = THIS.Width - 60/-65 em containers de Page (pgf.Page1/Page2): DEVE ser .Width = THIS.Width (container de saida eh flutuante/transparente sobre a Page, subtrair largura deixa faixa clara exposta a direita). Esta regra PREVALECE sobre o PILAR 1 (pixel-perfect ao legado) ï¿½ o sistema novo tem padrao visual proprio para o bloco de saida que NAO deve ser sobrescrito pelo SCX. CorretorAutomatico #81, #88, #89 corrigem automaticamente, mas o gerador DEVE ja emitir correto.
- **PUBLIC NAO EXISTE em DEFINE CLASS**: Metodos dentro de DEFINE CLASS ... ENDDEFINE sao PUBLIC por default. PUBLIC FUNCTION xxx() e PUBLIC PROCEDURE xxx() sao SYNTAX ERROR ("Statement is not valid in a class definition"). Apenas PROTECTED e HIDDEN sao modifiers validos. Escrever sempre: FUNCTION xxx() / PROCEDURE xxx() (sem PUBLIC) OU PROTECTED PROCEDURE xxx() / HIDDEN FUNCTION xxx().
- **Page.Width / Page.Height READ-ONLY em runtime**: Pages (PageFrame.PageN) NAO aceitam atribuicao a .Width/.Height em runtime ï¿½ essas propriedades sao controladas pelo PageFrame automaticamente. WITH loc_oPage / .Width = THIS.Width / .Height = THIS.Height / ENDWITH causa "CREATEOBJECT retornou valor nao-objeto" na instanciacao. Remover TODAS as atribuicoes a Page.Width/Height em ConfigurarPageFrame ou similares. Se precisa cobrir area, usar containers filhos da Page com Width/Height fixos.
- **MostrarAviso NAO EXISTE**: Apenas MostrarErro (FormErro.prg), MsgErro, MsgAviso, MsgConfirma, MsgInfo (messages.prg) existem. MostrarAviso(...) gera runtime error "File 'mostraraviso.prg' does not exist". Usar MsgAviso(msg) para validacao de UI (dialog amarelo) OU MostrarErro(msg, titulo) para exceptions tecnicas (dialog vermelho). CorretorAutomatico #90 auto-corrige.
- **Cursor do grid + SQLEXEC Buscar: fechar antes (uncommitted changes)**: Em BO.Buscar ou BO.CarregarPorCodigo, antes de SQLEXEC(..., "cursor_4c_Dados") (ou outro alias que o form usa como grd.RecordSource), fechar o cursor anterior: IF USED("cursor_4c_Dados") / TABLEREVERT(.T., "cursor_4c_Dados") / USE IN cursor_4c_Dados / ENDIF. Sem isso, segundo SQLEXEC falha com "Table buffer contains uncommitted changes" porque o grid pode ter mantido edicoes pendentes no buffer. CorretorAutomatico #91 injeta automaticamente.
- **cnt_4c_Saida padrao canonico (FormCor)**: cnt_4c_Saida Left=917, Width=90, Height=85. cmd_4c_Encerrar dentro com Left=5, Top=5, Width=75, Height=75. Mantem Encerrar com as MESMAS dimensoes dos botoes CRUD (75x75). Valores antigos (Left=935 W=60 botao W=50) tornam o Encerrar visualmente menor - substituir pelo padrao FormCor.
- **cnt_4c_Botoes.Left = 542 em forms 1000px (NAO copiar Left=343 do legado)**: Container de botoes CRUD DEVE ficar a direita (Left=542, Width=390, ends=932). Gerador tende a copiar Grupo_op.Left=343 do SCX legado (form 770px) resultando em botoes centralizados. Padrao FormCor/FormMoe: Left=542. Formula para 1000px: FormWidth - CntBotoesWidth - GapEncerrar = 1000 - 390 - 68 = 542.
- **Page1.Picture + Page2.Picture = "fundo_cad_1003.jpg" obrigatorio em frmcadastro**: ConfigurarPageFrame de forms frmcadastro (cadastros/) DEVE setar .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg" E .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg". Sem isso, Page1/Page2 ficam totalmente brancas (sem o fundo visual do framework). Ver FormCor.ConfigurarPageFrame como referencia.
- **MsgAviso para validacao de UI, MsgErro APENAS para exceptions tecnicas**: "Selecione um registro", "Campo obrigatorio", "Valor invalido", "Ja cadastrado" DEVEM usar MsgAviso(...) (dialog amarelo). MsgErro/MostrarErro (dialog vermelho + botao "Fechar Aplicacao") APENAS para erros tecnicos reais: exceptions capturadas em CATCH, "Erro ao...", "Falha ao...", SQL errors, conexao. Usar MostrarErro para validacao assusta o usuario.
- **ConfigurarPaginaLista/Dados: loc_oPagina.Picture = fundo_cad_1003.jpg obrigatorio**: Metodos que iniciam com loc_oPagina = THIS.pgf_4c_Paginas.PageN DEVEM setar loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg" antes de qualquer AddObject. Sem isso, a pagina fica totalmente branca em vez de mostrar o fundo padrao do framework. Complementar a regra #88 que cobre o padrao .Page1.Picture inline no WITH do PageFrame.
- **Campo auto-preenchido NAO eh ReadOnly/Enabled=.F. no AddObject**: TextBox que o legado preenche via Valid/SEEK em certos fluxos AINDA eh editavel pelo usuario. NUNCA setar `.ReadOnly = .T.` ou `.Enabled = .F.` no AddObject inicial a menos que o SCX legado tenha essas propriedades explicitas. Comentarios como "preenchido ao selecionar no grid" NAO justificam bloquear edicao. Controle de Enabled por modo (INCLUIR/ALTERAR/VISUALIZAR) vai em HabilitarCampos.
- **OptionGroup.Buttons(N) DEVE ter .BackStyle = 0**: OptionButton dentro de OptionGroup tem BackStyle (0=transparente, 1=opaco). Sem .BackStyle = 0 no WITH dos sub-botoes, o fundo opaco pode clipar texto da caption - "N" + CHR(227) + "o" ("Nao") aparece como "Na" na tela. SCX legado tipicamente tem OptionN.BackStyle = 0; migrador as vezes omite. NAO confundir com CommandButton/CommandGroup que NAO tem BackStyle (regras #59/#60).
- **OptionGroup.Width DEVE >= MAX(Buttons[i].Left + Buttons[i].Width) + 10**: Container OptionGroup clipa conteudo mesmo com BorderStyle=0. Se Buttons(N) foram expandidos (ex: Width de 37 para 60 para acomodar captions acentuadas "Nao"), o Container tambem precisa crescer. NAO basta copiar Width do SCX legado ï¿½ validar que container acomoda todos os buttons + 10px margem.
**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir SET SAFETY OFF e SET RESOURCE OFF no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.

Comecar agora. Foco TOTAL em copiar propriedades visuais EXATAS do codigo fonte original.
