# FASE B: Funcionalidade - Formsigredoc (APENAS LOGICA)

**FOCO EXCLUSIVO: IMPLEMENTAR LOGICA REAL. NAO alterar nenhuma propriedade visual.**

## OBJETIVO
Os arquivos sigredocBO.prg e Formsigredoc.prg ja existem com layout visual correto (Fase A).
Sua tarefa: preencher TODOS os metodos stub com implementacao REAL e COMPLETA.

## REGRA #1: NAO ALTERAR PROPRIEDADES VISUAIS
**ABSOLUTAMENTE PROIBIDO** modificar:
- Width, Height, Top, Left de qualquer controle
- BackColor, ForeColor, FontName, FontSize
- Caption de labels (apenas Caption de botoes dinamicos OK)
- Picture, PicturePosition, Alignment
- Qualquer propriedade visual definida na Fase A

**SE PRECISAR ADICIONAR UM CONTROLE** que faltou na Fase A, adicione com as propriedades
visuais EXATAS do original. Mas NAO modifique controles ja existentes.

## REGRA #2: IMPLEMENTAR TUDO - ZERO STUBS
- TODOS os Btn*Click DEVEM ter logica real (baseada no legado)
- TODOS os Validar* DEVEM ter validacao real (SELECT no banco)
- TODOS os AbrirLookup* DEVEM criar FormBuscaAuxiliar + mAddColuna + Show
- CarregarLista DEVE usar `cursor_4c_Dados` como nome do cursor principal (SQLEXEC INTO CURSOR cursor_4c_Dados). Este nome e verificado pelo TesteAutomatico.
- CarregarLista DEVE ter SQLEXEC real com cursor protegido
- FormParaBO/BOParaForm DEVEM mapear TODOS os campos
- BO.Inserir/Atualizar/ExecutarExclusao/Buscar/CarregarPorCodigo DEVEM ter SQL real
- FormatarNumeroSQL() para numeros, FormatarDataSQL() para datas, EscaparSQL() para strings (JA INCLUI aspas - NUNCA adicionar aspas extras)

## REGRA #3: PRESERVAR ESTRUTURA
- NAO reorganizar metodos
- NAO renomear variaveis ja declaradas
- NAO remover metodos (mesmo se parecerem inuteis)
- ADICIONAR codigo DENTRO dos metodos existentes

## Arquivos de Referencia
1. **CLAUDE.md** - Regras VFP, SQL, BusinessBase
2. **tasks/task081/sigredoc_form_codigo_fonte.txt** - Codigo fonte original (LOGICA dos metodos)
3. **tasks/task081/mapeamento.json** - Mapeamento de objetos
4. **tasks/task081/comportamento.json** - Analise comportamental (queries SQL, validacoes)
5. **C:\4c\projeto\app\classes\sigredocBO.prg** - BO existente (Fase A) - LER PRIMEIRO
6. **C:\4c\projeto\app\forms\relatorios\Formsigredoc.prg** - Form existente (Fase A) - LER PRIMEIRO

## Arquivos a MODIFICAR (NAO recriar do zero!)
1. **C:\4c\projeto\app\classes\sigredocBO.prg** - Preencher Inserir/Atualizar/ExecutarExclusao/Buscar/CarregarPorCodigo/CarregarDoCursor
2. **C:\4c\projeto\app\forms\relatorios\Formsigredoc.prg** - Preencher Btn*Click, Validar*, Lookup*, CarregarLista, FormParaBO, BOParaForm

## Regras VFP Criticas
- NUNCA RETURN dentro de TRY/CATCH - usar variavel loc_lSucesso
- SQLEXEC em cursor temporario + ZAP + APPEND FROM DBF() (protecao Grid)
- SET NULL ON antes de CREATE CURSOR
- CarregarDoCursor: SELECT (par_cAliasCursor) ANTES de acessar campos
- mAddColuna(campo, "", titulo) - 3 parametros (NAO largura/tabela)
- FormBuscaAuxiliar: this_lSelecionou + cursor destino (NAO ObterCodigoSelecionado)
- **BINDEVENT "Valid" NAO FUNCIONA em TextBox**: Usar "KeyPress" (ENTER=13/TAB=9) para simular Valid. NUNCA usar LostFocus para chamar MontaGrade/CarregarDados/SQLEXEC - LostFocus dispara SEMPRE (inclusive por SetFocus de outro controle) causando RECURSAO INFINITA. Ex: BINDEVENT(txt, "KeyPress", THIS, "TxtCampoKeyPress") e no handler: IF par_nKeyCode = 13 OR par_nKeyCode = 9 ... ENDIF
- **Page.Visible NAO EXISTE**: Page (PageFrame.PageN) NAO tem propriedade Visible. NUNCA .Page1.Visible = .T..
- **PageFrame.Visible OBRIGATORIO**: AddObject cria controles com Visible=.F. SEMPRE adicionar THIS.pgf_4c_Paginas.Visible = .T. ANTES de ActivePage = 1 no InicializarForm.
- **Buttons(N) vs ButtonCount**: Ao fazer BINDEVENT em Buttons(N), N DEVE ser <= ButtonCount.
- Nomes SQL EXATOS do schema.sql (SigCdCor, cgrus, dpros, Iclis, Rclis)
- USE IN cursor ao final de cada lookup
- NovoRegistro() em BtnIncluirClick ANTES de LimparCampos
- this_lNovoRegistro = .F. em CarregarPorCodigo APOS carregar
- NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1)
- CommandGroup e OptionGroup: SEMPRE definir .ButtonCount ANTES de acessar .Buttons(N)
- NUNCA fazer self-assignment: THIS.pgf_4c_Paginas = THIS.pgf_4c_Paginas (causa erro)
- LostFocus != Valid: Valid so dispara quando valor MUDA, LostFocus dispara SEMPRE. Handlers via BINDEVENT LostFocus que abrem lookup DEVEM ter guardia de valor (this_cUltimo*Validado + comparacao antes de processar)
- Busca reversa por descricao: PRIMEIRO SELECT direto no banco. SO abrir FormBuscaAuxiliar se NAO encontrou (legado fAcessoContab faz SEEK primeiro)
- DynamicForeColor/DynamicBackColor: SEMPRE proteger com PEMSTATUS(obj, "DynamicForeColor", 5) antes de atribuir
- Caption do form DEVE ser propagado para lbl_4c_Sombra/lbl_4c_Titulo apos ConfigurarPageFrame
- NUNCA usar COMMIT/ROLLBACK avulsos apos SQLEXEC simples - conexao ODBC usa AUTOCOMMIT. COMMIT/ROLLBACK sem BEGIN TRANSACTION causa erro fatal
- **Variaveis legadas do Framework**: _EMPR, _EMPRESA, pEmp NAO existem no novo sistema. Substituir por go_4c_Sistema.cCodEmpresa (codigo da empresa). Se precisar verificar existencia: IF TYPE("_EMPR") = "C" ... ELSE go_4c_Sistema.cCodEmpresa
- **AtualizarEstadoControles**: Todo metodo que chama MontaGrade() ou CarregarLista() DEVE chamar THIS.AtualizarEstadoControles() em seguida para atualizar estado de botoes (Enabled/Disabled)
- **REGRA ANTI-VISUAL (CRITICO)**: NAO alterar Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize de NENHUM controle. Implementar APENAS logica dentro dos metodos existentes
- **this_cMensagemErro**: Se o Form usa THIS.this_cMensagemErro em CATCH blocks, DEVE declarar 	his_cMensagemErro = "" nas propriedades da classe (NAO herdado de FormBase)
- **REPORT FORM TO FILE**: Pre-computar caminho em variavel LOCAL + macro expansion &var (expressoes inline e name expressions (var) NAO funcionam em VFP9)
- **MESSAGEBOX PROIBIDO**: NUNCA usar MESSAGEBOX() direto. Usar funcoes de messages.prg: MsgInfo() para informativo (icone 64), MsgAviso() para aviso (icone 48), MsgErro() para erro (icone 16), MsgConfirma() para confirmacao Sim/Nao. Essas funcoes suprimem dialogs em modo de teste automatizado.
- **UNION ALL entre tabelas diferentes**: NUNCA usar SELECT * em UNION ALL. Listar colunas EXPLICITAS IDENTICAS em ambas as queries. Tabelas como SigMvCcr/SigMvCpv tem estruturas diferentes.
- **INTO CURSOR READWRITE**: NUNCA usar INTO CURSOR X + USE DBF("X") IN 0 ALIAS Y (causa "file is in use"). Usar INTO CURSOR cursor_4c_Dados READWRITE direto.
- **Cursor placeholder = cursor real**: O CREATE CURSOR placeholder no InicializarForm DEVE ter EXATAMENTE os mesmos campos (nomes e tipos) que o cursor populado por SQLEXEC. Campos diferentes causam erros de ControlSource no grid.
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

**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir SET SAFETY OFF e SET RESOURCE OFF no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.
- **BO: metodo de validacao chama-se ValidarDados() (NAO Validar)**: BusinessBase.Salvar() chama THIS.ValidarDados(). BOs que implementam PROTECTED PROCEDURE Validar() tem validacao silenciosamente pulada -> Inserir roda com valores default e falha no SQL. SEMPRE usar PROTECTED PROCEDURE ValidarDados().
- **IIF() exige LOGICAL no 1o argumento**: IIF(numerico, ...) quebra com "Function argument value, type, or count is invalid" quando valor=0. Em TEXTMERGE SQL e conversoes, SEMPRE comparar: IIF(this_nFlag = 1, '1', '0'). NUNCA passar numerico direto: IIF(this_nFlag, '1', '0').
- **Colunas NUMERIC(1,0) preservam tipo NUMERIC em this_n***: Em CarregarDoCursor, NUNCA usar ramo ELSE generico THIS.this_nXxx = (NVL(col,0) = 1) (converte para LOGICAL). Padrao canonico: IF VARTYPE(col)="N" / THIS.this_nXxx = NVL(col, 0) / ELSE / THIS.this_nXxx = IIF(NVL(col,.F.),1,0) / ENDIF. BIT do SQL->LOGICAL vai em this_l*; NUMERIC(1,0)->NUMERIC vai em this_n*.
- **CheckBox .Value = 0 no AddObject (NAO .F.)**: AddObject CheckBox DEVE inicializar .Value = 0 (NUMERIC). Usar .Value = .F. cria LOGICAL e conflita com LimparCampos (.Value = 0, NUMERIC) e BOParaForm - dispara "Operator/operand type mismatch" no primeiro uso. BOParaForm: usar chk.Value = IIF(this_lProp, 1, 0) ou IIF(this_nProp = 1, 1, 0), nunca atribuir LOGICAL direto.
- **Lookups FormBuscaAuxiliar NUNCA com BINDEVENT "LostFocus"**: Handlers Validar* que criam FormBuscaAuxiliar DEVEM usar BINDEVENT "KeyPress". LostFocus dispara quando o dialog de lookup toma foco -> RECURSAO: segundo dialog empilhado, grade aparece vazia, campo fica em branco apos Selecionar. Handler deve receber (par_nKeyCode, par_nShiftAltCtrl) e executar apenas em ENTER(13)/TAB(9)/F4(115): IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115 / RETURN / ENDIF.
- **ALLTRIM() NAO aceita numerico**: ALLTRIM(txt.Value) quando .Value e numerico (ex: .Value=0, InputMask="999") gera "Function argument value, type, or count is invalid". Em validacao usar comparacao direta (IF .Value = 0); em conversao, envolver com TRANSFORM: ALLTRIM(TRANSFORM(.Value)).
- **cmd_4c_Encerrar.Caption = "Encerrar"**: Botao Encerrar DEVE ter .Caption = "Encerrar" (NAO "X", "Sair" ou ""). A Picture "cadastro_sair_60.jpg" NAO cobre a caption; captions errados aparecem como texto abaixo do icone. Padrao dos forms CRUD (FormCor, FormMoe).
- **PADRAO CANONICO SAIDA/ENCERRAR — PREVALECE SOBRE PILAR 1 (pixel-perfect legado)**: O bloco de saida (container + botao Encerrar) DEVE seguir o padrao canonico do sistema novo (FormCor), IGNORANDO os valores do SCX legado. Canonical (inegociavel): cnt_4c_Saida.Left=917, Width=90, Height=85; cmd_4c_Encerrar.Left=5, Top=5, Width=75, Height=75, Caption="Encerrar". Se o SCX legado tiver Grupo_Saida.Left=935 W=60 ou botao X com W=50/Caption="X"/"Sair"/"Fechar", IGNORE e use o canonico. O mesmo vale para .Width = THIS.Width - 60/-65 em containers de Page (pgf.Page1/Page2): DEVE ser .Width = THIS.Width (container de saida eh flutuante/transparente sobre a Page, subtrair largura deixa faixa clara exposta a direita). Esta regra PREVALECE sobre o PILAR 1 (pixel-perfect ao legado) — o sistema novo tem padrao visual proprio para o bloco de saida que NAO deve ser sobrescrito pelo SCX. CorretorAutomatico #81, #88, #89 corrigem automaticamente, mas o gerador DEVE ja emitir correto.
- **PUBLIC NAO EXISTE em DEFINE CLASS**: Metodos dentro de DEFINE CLASS ... ENDDEFINE sao PUBLIC por default. PUBLIC FUNCTION xxx() e PUBLIC PROCEDURE xxx() sao SYNTAX ERROR ("Statement is not valid in a class definition"). Apenas PROTECTED e HIDDEN sao modifiers validos. Escrever sempre: FUNCTION xxx() / PROCEDURE xxx() (sem PUBLIC) OU PROTECTED PROCEDURE xxx() / HIDDEN FUNCTION xxx().
- **Page.Width / Page.Height READ-ONLY em runtime**: Pages (PageFrame.PageN) NAO aceitam atribuicao a .Width/.Height em runtime — essas propriedades sao controladas pelo PageFrame automaticamente. WITH loc_oPage / .Width = THIS.Width / .Height = THIS.Height / ENDWITH causa "CREATEOBJECT retornou valor nao-objeto" na instanciacao. Remover TODAS as atribuicoes a Page.Width/Height em ConfigurarPageFrame ou similares. Se precisa cobrir area, usar containers filhos da Page com Width/Height fixos.
- **MostrarAviso NAO EXISTE**: Apenas MostrarErro (FormErro.prg), MsgErro, MsgAviso, MsgConfirma, MsgInfo (messages.prg) existem. MostrarAviso(...) gera runtime error "File 'mostraraviso.prg' does not exist". Usar MsgAviso(msg) para validacao de UI (dialog amarelo) OU MostrarErro(msg, titulo) para exceptions tecnicas (dialog vermelho). CorretorAutomatico #90 auto-corrige.
- **Cursor do grid + SQLEXEC Buscar: fechar antes (uncommitted changes)**: Em BO.Buscar ou BO.CarregarPorCodigo, antes de SQLEXEC(..., "cursor_4c_Dados") (ou outro alias que o form usa como grd.RecordSource), fechar o cursor anterior: IF USED("cursor_4c_Dados") / TABLEREVERT(.T., "cursor_4c_Dados") / USE IN cursor_4c_Dados / ENDIF. Sem isso, segundo SQLEXEC falha com "Table buffer contains uncommitted changes" porque o grid pode ter mantido edicoes pendentes no buffer. CorretorAutomatico #91 injeta automaticamente.
- **cnt_4c_Saida padrao canonico (FormCor)**: cnt_4c_Saida Left=917, Width=90, Height=85. cmd_4c_Encerrar dentro com Left=5, Top=5, Width=75, Height=75. Mantem Encerrar com as MESMAS dimensoes dos botoes CRUD (75x75). Valores antigos (Left=935 W=60 botao W=50) tornam o Encerrar visualmente menor - substituir pelo padrao FormCor.
- **FormParaBO/BOParaForm: props EXATAS do BO + descricoes de lookup DECLARADAS**: Toda prop acessada via this_oBusinessObject.xxx DEVE existir como declaracao no BO. Assign em prop nao-declarada cria dinamica, mas LEITURA em instancia fresca (pos CarregarDoCursor, antes de qualquer assign) dispara "Property THIS_XXX is not found". Descricoes de lookup (this_cDsX, this_cDxxx) que nao vao para o SQL mas passam por FormParaBO/BOParaForm TAMBEM precisam ser declaradas no BO (mesmo que nao-persistidas).
- **MsgAviso para validacao de UI, MsgErro APENAS para exceptions tecnicas**: "Selecione um registro", "Campo obrigatorio", "Valor invalido", "Ja cadastrado" DEVEM usar MsgAviso(...) (dialog amarelo). MsgErro/MostrarErro (dialog vermelho + botao "Fechar Aplicacao") APENAS para erros tecnicos reais: exceptions capturadas em CATCH, "Erro ao...", "Falha ao...", SQL errors, conexao. Usar MostrarErro para validacao assusta o usuario.
- **Grid.ColumnCount ANTES de RecordSource em CarregarLista**: TODA vez que definir grd.RecordSource = "cursor_4c_Dados", setar grd.ColumnCount = N IMEDIATAMENTE antes (N = numero de colunas que queremos no grid). Sem isso, grid auto-expande para todas as colunas do cursor (ex: cursor com 10 campos gera grid com 10 colunas e headers duplicados). Regra vale para CarregarLista e tambem ExecutarBusca/Buscar-style refresh. Existe regra #43 (nao resetar ColumnCount) com sentido especifico; esta reforca: ColumnCount DEVE ser setado >= 1 vez antes de CADA RecordSource.
- **FormParaBO DEVE popular TODAS props do BO usadas em Inserir/Atualizar**: Props de SQL (this_d*, this_n*, this_c*) referenciadas em Inserir() DEVEM ser populadas em FormParaBO(), incluindo campos auto-gerados: IF modo==INCLUIR AND EMPTY(this_dDatas) / this_dDatas = DATE() / ENDIF, 	his_cEmps = go_4c_Sistema.cCodEmpresa, etc. Se nao popular, Insert grava NULL/default (data NULL, empresa vazia). Auditoria: toda prop THIS.this_[cdn]\w+ referenciada em Inserir deve aparecer em FormParaBO.
- **INDEX ON ... TAG <nome-da-coluna>, NAO TAG unico "ordem"**: Quando o form precisa mudar ordenacao via SET ORDER TO TAG <col>, criar UM TAG POR COLUNA no cursor (ex: INDEX ON Locals TAG Locals, INDEX ON Nivel2s TAG Nivel2s, etc.). NUNCA criar INDEX ON &loc_cOrdem TAG ordem (nome generico "ordem"): destroi tags anteriores e form nao consegue fazer SET ORDER TO TAG Locals. Auditoria cross-file: listar SET ORDER TO TAG (\w+) no form vs INDEX ON ... TAG (\w+) no BO - tags usados no form mas ausentes no BO sao bugs.
- **PEMSTATUS em cursor: erro "Function argument value, type, or count is invalid"**: PEMSTATUS exige OBJETO no 1o arg, NUNCA alias de cursor. `PEMSTATUS((par_cAlias), "campo", 5)` ou `PEMSTATUS(par_cAlias, "campo", 5)` (com par_cAlias sendo nome de cursor) quebra. Usar `TYPE(par_cAlias + ".campo") != "U"` para checar se campo existe no cursor. Regra #61 ja documentada; reforcar agora porque gerador continua replicando o erro em CarregarDoCursor.
- **Lookup KeyPress: ENTER(13) E TAB(9) E F4(115), NAO so F4**: Handlers Validar*/AbrirLookup* ligados via BINDEVENT KeyPress DEVEM disparar em `par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115`. Somente `= 115` (F4) deixa user preso: digita codigo, TAB, nada acontece. Padrao correto ja em lesson #84; gerador continua emitindo so `= 115` em alguns forms - CorretorAutomatico #85 normaliza.
- **Forms 1-N com grid secundario: criar cursor vazio em BtnIncluirClick**: Forms com grids secundarios (ex: grd_4c_Dados exibindo localidades/itens) onde user adiciona registros manualmente via KeyPress DEVEM criar o cursor vazio com estrutura correta + tags em `BtnIncluirClick`. Sem isso, em modo INCLUIR o cursor nao existe -> user digita e nada acontece. Exemplo: `CREATE CURSOR cursor_4c_Xxx (col1 C(9), col2 N(9,0), ...) / INDEX ON col1 TAG col1 / INDEX ON col2 TAG col2`. Chamar ConfigurarGrdDados() em seguida para bind do grid.

Comecar agora. Ler os arquivos existentes (Fase A) PRIMEIRO, depois o codigo fonte original.
Preencher CADA metodo stub com implementacao COMPLETA baseada no legado.
