# CorretorAutomatico.ps1 - Patterns Reference

This document is the complete reference for all 89 total auto-fix patterns in `CorretorAutomatico.ps1` and the full Common Errors Reference table for VFP9 migration.

The CorretorAutomatico runs automatically during the migration pipeline (Etapa 5.5) and fixes known anti-patterns that cause compilation or runtime errors in VFP9.

---

## Auto-Fix Patterns (89 total)

| # | Description | Before (WRONG) | After (CORRECT) |
|---|-------------|-----------------|------------------|
| 1 | RETURN dentro de TRY/CATCH | `TRY` ... `RETURN .F.` ... `ENDTRY` | `loc_lResultado = .F.` ... `RETURN loc_lResultado` (FORA do TRY) |
| 2 | THIS.InicializarForm() apos DODEFAULT | `DODEFAULT()` + `THIS.InicializarForm()` | `DODEFAULT()` (FormBase.Init ja chama InicializarForm) |
| 3 | loForm.Show(1) | `loForm.Show(1)` | `loForm.Show()` |
| 4 | loForm.Release() apos Show | `loForm.Show()` + `loForm.Release()` | `loForm.Show()` (Release desnecessario) |
| 5 | (par_cAlias).campo | `(par_cAlias).campo` | `SELECT par_cAlias` + `campo` |
| 6 | Salvar(loc_lNovoRegistro) | `THIS.this_oBusinessObject.Salvar(loc_lNovoRegistro)` | `THIS.this_oBusinessObject.Salvar()` (usa this_lNovoRegistro interno) |
| 7 | this_cNomeTabela | `THIS.this_cNomeTabela = "X"` | `THIS.this_cTabela = "X"` |
| 8 | this_cChavePrimaria | `THIS.this_cChavePrimaria = "X"` | `THIS.this_cCampoChave = "X"` |
| 9 | VAL() em campos numericos | `VAL(THIS.txt_4c_Preco.Value)` | `THIS.txt_4c_Preco.Value` (ja eh numerico) |
| 10 | Grid.AllowAddNew/AllowDelete/AllowEdit | `.AllowAddNew = .F.` / `.AllowDelete = .F.` / `.AllowEdit = .F.` | Remover linhas (propriedades NAO existem em VFP9 Grid) |
| 11 | BOM UTF-8 no inicio do arquivo | Bytes EF BB BF no inicio | Remover BOM (VFP9 nao suporta UTF-8 BOM) |
| 12 | CREATEOBJECT nome incorreto do BO | `CREATEOBJECT("TamanhoBO")` | `CREATEOBJECT("TamBO")` (conforme analise.json) |
| 13 | Form herda de FORM generico | `DEFINE CLASS FormX AS FORM` | `DEFINE CLASS FormX AS FormBase` |
| 14 | Nome de variavel inconsistente | `LOCAL loc_lResultado` ... `RETURN loc_lSucesso` | Corrigir para nome declarado (`loc_lResultado` ou `loc_lSucesso`) |
| 15 | PageFrame.BackColor | `THIS.pgf_4c_Paginas.BackColor = RGB(255,255,255)` | Remover linha (PageFrame NAO tem BackColor, usar Page1.BackColor) |
| 16 | SetAll FontName em Column | `Grid.SetAll("FontName", "Tahoma", "Column")` | `Grid.FontName = "Tahoma"` (Column NAO tem FontName) |
| 17 | OptionGroup.Button1 | `OptionGroup.Button1.Caption = "X"` | `OptionGroup.Buttons(1).Caption = "X"` (array syntax) |
| 18 | Caracteres encoding invalido | Bytes fora do range ASCII valido | Substituir por ASCII puro (CHR codes para acentos) |
| 19 | PageFrame.ErasePage | `.ErasePage = .T.` | Remover linha (propriedade NAO existe em VFP9) |
| 20 | CREATE CURSOR C(N) onde N > 254 | `CREATE CURSOR x (campo C(290))` | `CREATE CURSOR x (campo C(254))` (limite VFP9) |
| 21 | PROTECTED em CarregarLista | `PROTECTED PROCEDURE CarregarLista()` | `PROCEDURE CarregarLista()` (BINDEVENT requer PUBLIC) |
| 22 | .Name em Pages/Columns dentro de WITH | `.Page1.Name = "pagLista"` / `.Column1.Name = "col_X"` | Remover linha (rename quebra referencias .Page1/.Column1) |
| 23 | TextBox.ControlSource dentro de Column | `Column1.Text1.ControlSource = "cursor.campo"` | Remover (usar Column.ControlSource apenas) |
| 24 | OptionGroup.FontName/FontSize | `OptionGroup.FontName = "Tahoma"` | Remover (definir em cada Buttons(N).FontName) |
| 25 | *(reservado)* | - | - |
| 26 | ELSEIF | `ELSEIF condicao` | `ELSE` + `IF condicao` + `ENDIF` (VFP9 nao suporta ELSEIF) |
| 27 | Ternario ? : | `resultado = condicao ? valorA : valorB` | `resultado = IIF(condicao, valorA, valorB)` |
| 28 | LOCATE IN alias FOR | `LOCATE IN cursor_4c FOR campo = "X"` | `SELECT cursor_4c` + `LOCATE FOR campo = "X"` |
| 29 | ShowWindow/WindowType ausentes | Form sem ShowWindow/WindowType | Adicionar `ShowWindow = 1` + `WindowType = 1` |
| 30 | BINDEVENT handlers sem LPARAMETERS | `PROCEDURE GridAfterRowColChange()` | `PROCEDURE GridAfterRowColChange(par_nColIndex)` |
| 31 | Aspas duplicadas com EscaparSQL/FormatarDataSQL | `"'" + EscaparSQL(val) + "'"` | `EscaparSQL(val)` (ja retorna com aspas) |
| 32 | Self-assignment THIS.obj = THIS.obj | `THIS.txt_4c_Codigo = THIS.txt_4c_Codigo` | Remover linha (causa "is a method, event, or object") |
| 33 | _EMPR variavel legada | `_EMPR` | `go_4c_Sistema.cCodEmpresa` |
| 34 | ISEMPTY() | `ISEMPTY(campo)` | `EMPTY(campo)` (ISEMPTY nao existe em VFP9) |
| 35 | this_cMensagemErro ausente em Form | Form usa THIS.this_cMensagemErro sem declarar | Adicionar `this_cMensagemErro = ""` nas propriedades do Form (NAO herdado de FormBase) |
| 36 | REPORT FORM TO FILE com expressao inline | `REPORT FORM X TO FILE ADDBS()+Y TYPE XLS` | Pre-computar em variavel LOCAL + macro `&var` |
| 37 | ComboBox.NumberOfElements | `.NumberOfElements = 5` | Remover (propriedade NAO existe em VFP9) |
| 38 | Grid.Panel / Grid.SplitBar | `.Panel = 1`, `.SplitBar = .T.` | Remover (propriedades NAO existem em VFP9) |
| 39 | MESSAGEBOX direto | `MESSAGEBOX("msg", 64, "")` | `MsgInfo("msg")` / `MsgAviso` (48) / `MsgErro` (16). Funcoes de messages.prg suprimem dialogs em modo teste. NAO substitui MESSAGEBOX com retorno atribuido ou confirmacao (4/36). |
| 40 | BINDEVENT "Valid" em TextBox | `BINDEVENT(txt, "Valid", ...)` | `BINDEVENT(txt, "LostFocus", ...)`. Evento Valid via BINDEVENT nao dispara em TextBox/ComboBox. Detecta prefixos txt_/cbo_/cmb_. |
| 41 | Check1.ControlSource em Grid Column | `Column1.Check1.ControlSource = "cursor.campo"` | (removido). Check1.ControlSource conflita com Column1.ControlSource (Error 1767 "Parent object will not allow"). A UNICA definicao deve ser `Column1.ControlSource` APOS `CurrentControl = "Check1"`. |
| 42 | PUBLIC PROCEDURE dentro de DEFINE CLASS | `PUBLIC PROCEDURE NomeMetodo()` | `PROCEDURE NomeMetodo()`. VFP9 NAO aceita modificador PUBLIC em metodos dentro de DEFINE CLASS (todos sao PUBLIC por default). Causa "Syntax error" na linha e cascata de "Statement is not valid in a class definition" em todas as linhas seguintes. |
| 43 | AddObject com objeto (sintaxe invertida) | `parent.AddObject(loc_oBtn, "cmd_4c_X")` | **DETECTA APENAS** (nao corrige auto). AddObject recebe `("nome", "Classe")` strings. Objeto como 1o param causa "Function argument invalid". Correcao manual: `parent.AddObject("cmd_4c_X", "CommandButton")` + `WITH parent.cmd_4c_X`. |
| 44 | Grid CurrentControl="Check1" sem AddObject | `.Column1.CurrentControl = "Check1"` sem AddObject previo | Insere `.Column1.AddObject("Check1", "CheckBox")` + `.Column1.Check1.Caption = ""` ANTES da linha CurrentControl. Grids criados via AddObject nao tem Check1 por default — causa "Unknown member CHECK1" que cascateia silenciosamente. |
| 45 | IF cond THEN cmd (inline IF com THEN) | `IF EMPTY(x) THEN RETURN` | `IF EMPTY(x)` + `    RETURN` + `ENDIF`. VFP9 NAO suporta keyword THEN em IF — gera "Command contains unrecognized phrase/keyword." |
| 46 | COUNT TO var IN alias | `COUNT TO loc_n IN cursor_4c_Dados` | `SELECT cursor_4c_Dados` + `COUNT TO loc_n`. VFP9 COUNT nao tem clausula IN — gera "Command contains unrecognized phrase/keyword." |
| 47 | CheckBox .Value logico (type mismatch) | `chk_4c_X.Value = .T.` / `chk_4c_X.Value = .F.` | `chk_4c_X.Value = 1` / `chk_4c_X.Value = 0`. CheckBox.Value DEVE ser NUMERICO (0/1). Usar logico (.T./.F.) causa "Operator/operand type mismatch" nas comparacoes `= 1`/`= 0` do codigo legado. Aplica apenas a controles `chk_4c_*`. |
| 48 | CREATEOBJECT vs DEFINE CLASS cross-check | `CREATEOBJECT("carBO")` | `CREATEOBJECT("CargoBO")` (le DEFINE CLASS do .prg real na pasta classes). Busca BO files em C:\4c\projeto\app\classes\, compara prefixo do nome usado com o DEFINE CLASS real, corrige se substring match. |
| 49 | Page.Visible (propriedade inexistente) | `.Page1.Visible = .T.` | Linha removida. Page NAO tem propriedade Visible em VFP9 - causa "Property VISIBLE is not found". Pages sao controladas pelo PageFrame via ActivePage. |
| 50 | PageFrame.Visible ausente | `pgf_4c_Paginas.ActivePage = 1` sem Visible antes | Adiciona `pgf_4c_Paginas.Visible = .T.` antes do ActivePage. AddObject cria controles com Visible=.F. - sem isso form abre em branco. |
| 51 | FormatarGridLista ausente | `THIS.FormatarGridLista(oGrid)` chamado mas PROCEDURE nao definido | Adiciona metodo padrao antes de ENDDEFINE: `PROTECTED PROCEDURE FormatarGridLista(par_oGrid)` com FontName="Tahoma", FontSize=8. Causa "Property FORMATARGRIDLISTA is not found" em runtime. |
| 52 | Property + AddObject conflito | `pgf_4c_Paginas = .NULL.` (propriedade) + `THIS.AddObject("pgf_4c_Paginas", ...)` | Remove declaracao de propriedade. VFP9 gera "Object name is invalid" quando AddObject tenta criar objeto com nome ja existente como propriedade da classe. |
| 53 | AddObject nome duplicado | `loc_oCnt.AddObject("lbl_4c_Label1", "Label")` 2x no mesmo container | Renomeia o segundo para `lbl_4c_Label12` (sufixo numerico). VFP9 gera "Object name is invalid" ao adicionar objeto com nome que ja existe no container. |
| 54 | Container sem Visible | `cnt_4c_Botoes` criado via AddObject sem `.Visible = .T.` | Adiciona `.Visible = .T.` no bloco WITH do container. AddObject cria com Visible=.F. por padrao - botoes/controles dentro ficam invisiveis. |
| 55 | LPARAMETERS duplicado | `PROCEDURE Xxx(par_nKey)` seguido de `LPARAMETERS par_nKey` | Remove a linha LPARAMETERS. Params ja declarados na assinatura do PROCEDURE. Causa "Unrecognized command verb" em VFP9. |
| 56 | CommandGroup.FontName (estende #25 OptionGroup) | `.FontName = "Tahoma"` dentro de WITH de CommandGroup | Linha removida. CommandGroup (como OptionGroup) NAO tem FontName/FontSize - definir em cada `.Buttons(N).FontName`. Erro cascateia no TRY/CATCH. |
| 57 | APPEND FROM sem SELECT cursor | `ZAP IN cursor_4c_Dados` + `APPEND FROM DBF("tmp")` | `SELECT cursor_4c_Dados` + `ZAP` + `APPEND FROM DBF("tmp")`. ZAP IN nao muda work area corrente - APPEND vai para cursor errado. |

---

## Common Errors Reference (Complete)

| Erro | Causa | Solucao |
|------|-------|---------|
| "converting varchar to numeric" | TRANSFORM() com SET POINT (virgula no Brasil) | Usar FormatarNumeroSQL() |
| "Function argument type mismatch" | TextBox.Value = .F. (logico ao inves de string) | Inicializar .Value = "" |
| "Function argument value, type, or count is invalid" em FormParaBO | VAL() em campo numerico | Se TextBox.Value ja eh numero, NAO usar VAL() - atribuicao direta |
| Controles invisiveis | PageFrame aninhado | Percorrer Pages() alem de Controls() |
| "Property THIS_XXX is not found" | Nome de propriedade inventado | Verificar nome EXATO no [Entidade]BO.prg |
| "Property THIS_CNOMETABELA is not found" | Usar this_cNomeTabela ao inves de this_cTabela | Usar THIS.this_cTabela e THIS.this_cCampoChave (nomes corretos do BusinessBase) |
| "Unknown member PAGE1" | Acessar .Page1 antes de definir .PageCount | Definir .PageCount = 2 ANTES de acessar .Page1 ou .Page2 |
| "Property VISIBLE is not found" | Tentar definir .Page1.Visible ou .Page2.Visible | Pages NAO tem .Visible - usar apenas .Visible = .T. no PageFrame |
| Grid perde formatacao apos CarregarLista | RecordSource reseta colunas | Salvar/restaurar larguras OU reconfigurar APOS RecordSource |
| Modo VISUALIZAR com muitos botoes visiveis | Falta AjustarBotoesPorModo() | Implementar AjustarBotoesPorModo() que desabilita botoes conforme modo |
| "Property ALLOWDELETE is not found" | Usar .AllowAddNew/.AllowDelete/.AllowEdit em Grid | Estas propriedades NAO EXISTEM em VFP9 Grid - NUNCA usar |
| Changes not taking effect | Cached .FXP files | Deletar *.fxp: `del /s /q C:\4c\projeto\app\*.fxp` |
| BINDEVENT nao funciona (botao sem acao) | Metodo eh PROTECTED | Metodos Btn*Click DEVEM ser PUBLIC (sem PROTECTED) |
| "No PARAMETER statement is found" | Handler de BINDEVENT sem LPARAMETERS | AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShiftAltCtrl) |
| Salvar() retorna .F. silenciosamente | BtnIncluirClick nao chama NovoRegistro() | Chamar THIS.this_oBusinessObject.NovoRegistro() em BtnIncluirClick |
| Violacao de chave primaria no Alterar | CarregarPorCodigo nao reseta this_lNovoRegistro | Adicionar THIS.this_lNovoRegistro = .F. apos carregar registro |
| Campo codigo nao habilita no Incluir | this_cModoAtual setado DEPOIS de HabilitarCampos() | Setar THIS.this_cModoAtual = "INCLUIR" ANTES de chamar HabilitarCampos() |
| "Property OBTERCODIGOSELECIONADO is not found" | FormBuscaAuxiliar nao tem esse metodo | Usar this_lSelecionou + cursor de destino |
| "Property BACKCOLOR is not found" em PageFrame | PageFrame NAO tem propriedade BackColor | Remover .BackColor do PageFrame - usar apenas em .Page1.BackColor, .Page2.BackColor |
| "Property RELEASE is not found" | Chamar .Release() em objeto Custom/BO | Custom NAO tem Release - usar = .NULL. para liberar (dispara Destroy) |
| "XXX is a method, event, or object" | Self-assignment THIS.obj = THIS.obj | NUNCA fazer self-assignment de objetos criados com AddObject. Remover a linha |
| "BUTTONS is not an object" em CommandGroup | ButtonCount nao definido antes de acessar .Buttons(1) | Definir .ButtonCount = N dentro do WITH ANTES de acessar .Buttons(N) |
| "Operator/operand type mismatch" com EVALUATE() | EVALUATE() usado para atribuicao | EVALUATE() retorna valor, NAO executa atribuicao - usar variavel intermediaria |
| "Operator/operand type mismatch" com variavel global | VFP OR NAO faz short-circuit | Usar IF aninhado ao inves de OR quando verificar existencia |
| "Property COLUMN1 is not found" em WITH | PEMSTATUS(.Column1) dentro de WITH loc_oGrid.Column1 | Usar PEMSTATUS(loc_oGrid.Column1) - referencia completa |
| "Alias XXX is not found" em Grid | ControlSource definido antes de criar cursor | Criar cursor ANTES de definir ControlSource do Grid |
| "Property FONTNAME is not found" | SetAll("FontName", ..., "Column") | Column NAO tem FontName - usar Grid.FontName = "Tahoma" diretamente |
| "Unknown member BUTTON1" | OptionGroup.Button1 via AddObject | Usar .Buttons(1) ao inves de .Button1 (sintaxe de array) |
| "Property FONTNAME is not found" em OptionGroup | OptionGroup.FontName/.FontSize via AddObject | OptionGroup NAO tem FontName/FontSize - definir nas .Buttons(N).FontName individuais |
| "Invalid column name XXX" | Nome de coluna inventado no SQL | Consultar schema.sql - usar nomes EXATOS: cgrus, dgrus, cmoes, Iclis, GruConMoes, etc. |
| "Property ERASEPAGE is not found" | .ErasePage = .T. invalido em PageFrame | Remover propriedade - PageFrame NAO tem ErasePage em VFP9 |
| "Unknown member PAGE1" apos WITH | Acessar .Page1 imediatamente apos ENDWITH | Criar variavel local loc_oPageFrame e configurar Pages APOS fechar WITH |
| "Property Lookup[XXX] is not found" | BINDEVENT para metodo de lookup inexistente | Comentar BINDEVENT ate implementar metodo OU gerar metodo de lookup |
| "Unknown member this_oBO" | Nome incorreto de propriedade | Substituir por this_oBusinessObject (nome correto do FormBase) |
| "Property OBTERTODOS is not found" | Metodo inexistente no BusinessBase | Usar Buscar("") ao inves de ObterTodos() (metodo correto) |
| "RETURN/RETRY statement not allowed in TRY/CATCH" | VFP9 nao permite RETURN dentro de TRY | Usar flag variable (loc_lResultado) e RETURN APOS ENDTRY |
| "Must specify additional parameters" em mAddColuna | mAddColuna chamado com 4 params (campo,titulo,largura,tabela) | mAddColuna aceita 3 params: (campo, mascara_ou_vazio, titulo). Tabela via this_cTabela |
| "Invalid column name XXX" em queries JOIN | Coluna referenciada com alias errado (ex: a.Cpfs de SigMvSlc) | Verificar de QUAL tabela vem cada coluna - b.Cpfs de SigCdCli, NAO SigMvSlc |
| "Invalid column name" Concils/Usuar/Tipo/Valos | Nomes de colunas inventados em SigMvCcr | Nomes corretos: Concs, Usualts, Tipos, Valors, Hist2s, Shists (consultar schema.sql!) |
| "A member object with this name already exists" | Init() chama DODEFAULT() + InicializarForm() (duplicado) | FormBase.Init() ja chama InicializarForm(). Init() deve ser apenas RETURN DODEFAULT() |
| "Property DYNAMICFORECOLOR is not found" | Grid base pode nao ter DynamicForeColor | SEMPRE usar IF PEMSTATUS(loc_oGrd, "DynamicForeColor", 5) antes de atribuir |
| "File 'isempty.prg' does not exist" | ISEMPTY() NAO existe em VFP9 - VFP tenta resolver como DO isempty.prg | Substituir ISEMPTY() por EMPTY() (funcao nativa VFP9). NUNCA usar ISEMPTY() |
| "Variable '_EMPR' is not found" | Variavel legada do Framework usada no codigo migrado | Substituir _EMPR por go_4c_Sistema.cCodEmpresa (codigo da empresa) |
| Botao desabilitado apos carregar dados | AtualizarEstadoControles() nao chamado apos MontaGrade() | SEMPRE chamar THIS.AtualizarEstadoControles() apos MontaGrade() ou CarregarLista() |
| Janela de busca abre TODA vez que navega | LostFocus dispara SEMPRE (Valid so quando valor muda) | Adicionar guardia: IF valor == THIS.this_cUltimoValidado THEN skip |
| Titulo do form incorreto ("Cadastro de Testes") | Caption nao propagado para labels de titulo | Apos ConfigurarPageFrame: lbl_4c_Sombra.Caption = THIS.Caption |
| "ROLLBACK TRANSACTION has no corresponding BEGIN TRANSACTION" | COMMIT/ROLLBACK avulsos sem BEGIN TRANSACTION | Conexao ODBC usa AUTOCOMMIT - NUNCA usar COMMIT/ROLLBACK avulsos |
| "Property THIS_CMENSAGEMERRO is not found" | Form usa THIS.this_cMensagemErro mas propriedade so existe em BusinessBase | Adicionar `this_cMensagemErro = ""` nas propriedades do Form (NAO herdado de FormBase) |
| "Command contains unrecognized phrase/keyword" em REPORT FORM | REPORT FORM TO FILE com expressao inline ou name expression (var) | Pre-computar em variavel LOCAL + macro expansion `&var` |
| "Operator/operand type mismatch" em CheckBox | CheckBox.Value = .F. (logico) comparado com 1/0 (numerico) | Se .Value = .F., usar .T./.F. em TODOS os acessos. Converter de banco: (NVL(campo,0) = 1) |
| Grid dados desalinhados dos titulos | RecordSource faz auto-bind pela ordem do cursor, ignorando ControlSource/ColumnOrder | Re-definir .ControlSource de TODAS as colunas APOS cada .RecordSource =. Preferir colunas na ordem visual (sem ColumnOrder) |
| "File 'formatargruposql.prg' does not exist" | Metodo PROTECTED chamado sem THIS. prefix | Adicionar THIS. antes da chamada. CorretorAuto #58 detecta (manual fix) |
| "Operator/operand type mismatch" em MsgConfirma | `IF MsgConfirma(...) = 6` — MsgConfirma retorna .T./.F., nao numerico | Trocar `= 6` por avaliacao direta: `IF MsgConfirma(...)`. CorretorAuto #57 |
| "Property THEMES is not found" em Container | Container VFP9 nao tem .Themes | Remover `.Themes = .F.` de objetos Container. CorretorAuto #56 |
| "Property EXECUTAREXCLUSAO is not found" | Form chama ExecutarExclusao (PROTECTED) em vez de Excluir (PUBLIC) | Trocar para `this_oBusinessObject.Excluir()`. ExecutarExclusao eh interno do BO |
| "Property BACKSTYLE is not found" em CommandGroup/OptionGroup | `.BackStyle = 0` em CommandGroup/OptionGroup | Remover - esses controles NAO possuem BackStyle. CorretorAuto #59 |
| "Property BACKSTYLE is not found" em CommandButton | `.BackStyle = 0` em CommandButton ou .Buttons(N) | Remover - CommandButton NAO possui BackStyle. CorretorAuto #60 |
| "Property TABSTYLE is not found" em PageFrame | `.TabStyle = 0` definido via codigo em PageFrame | Remover - PageFrame.TabStyle eh read-only em VFP9. CorretorAuto #61 |
| 58 | Grid sem RecordMark/DeleteMark em OPERACIONAL | `AddObject("grd_4c_X","Grid")` sem `.RecordMark=.F.`/`.DeleteMark=.F.` | Adicionar `.RecordMark = .F.` e `.DeleteMark = .F.` no WITH do grid. CorretorAuto #58 |
| 59 | CommandGroup/OptionGroup.BackStyle (inexistente) | `.BackStyle = 0` dentro de WITH de CommandGroup/OptionGroup | Linha removida. CommandGroup e OptionGroup NAO possuem BackStyle em VFP9. Apenas Label, CheckBox, Shape, Container, Image possuem. |
| 60 | CommandButton.BackStyle (inexistente) | `.BackStyle = 0` dentro de WITH de CommandButton ou CommandGroup.Buttons(N) | Linha removida. CommandGroup/standalone CommandButton apenas - NAO aplica a OptionGroup.Buttons(N). OptionButton TEM BackStyle. Veja pattern #86. |
| 61 | PageFrame.TabStyle (read-only) | `.TabStyle = 0` dentro de WITH de PageFrame | Linha removida. PageFrame.TabStyle eh read-only em VFP9 - nao pode ser definido via codigo, apenas design-time. |
| 62 | NovoRegistro/EditarRegistro sem DODEFAULT | `PROCEDURE NovoRegistro()` sem `DODEFAULT()` | `DODEFAULT()` adicionado como primeira linha. Sem isso, BusinessBase.this_lEmEdicao fica .F. e Salvar() SEMPRE falha silenciosamente. |
| 63 | Container de botoes CRUD opaco escuro (INVERTIDO em 2026-04-16) | `.BackStyle = 1` + `.BackColor = RGB(53,53,53)` em `cnt_4c_Botoes`/`cnt_4c_Saida`/`cnt_4c_BotoesDados` com CommandButtons | `.BackStyle = 0` (transparente) + remove BackColor escuro. O fundo ja eh dado por Page.Picture (fundo_cad_1003.jpg); container opaco cria caixa cinza ao redor dos botoes que destoa do layout original. EXCECAO UNICA: `cnt_4c_Cabecalho` continua opaco escuro propositalmente. |
| 64 | FormBuscaAuxiliar Release antes de ler cursor | `Release()` antes de ler `cursor_4c_Busca.campo` | **(WARNING apenas)** Ordem correta: ler cursor -> Release -> USE IN. |
| 65 | SQL column names legados (CamelCase) | `DataAlts`, `HoraAlts`, `UsuaAlts`, `DataIncs` | **(WARNING apenas)** Usar nomes reais: `dtalts`, `horaalts`, `usuaalts`, `dtincs`. |
| 66 | NVL(campo,0)=1 em campos BIT (com ou sem parenteses) | `THIS.this_lFlag = (NVL(campo, 0) = 1)` ou `THIS.this_lFlag = NVL(campo, 0) = 1` | Converte para bloco IF/ELSE/ENDIF: `IF VARTYPE(campo)="L" / target=campo / ELSE / target=(NVL(campo,0)=1) / ENDIF`. NUNCA IIF (avalia AMBOS ramos → type mismatch). Regex aceita parenteses opcionais ao redor da expressao NVL. |
| 67 | F4 key code errado (63 em vez de 115) | `par_nKeyCode = 63` em KeyPress | `par_nKeyCode = 115`. VFP9: F4=115, F5=116. Code 63 eh '?' (ASCII). |
| 68 | Container.BorderStyle nao existe | `.BorderStyle = 0` em Container | **REMOVE linha**. Container VFP9 tem `BorderWidth` mas NAO tem `BorderStyle` (propriedade de CommandGroup/OptionGroup). |
| 69 | PageFrame.Height nao compensa Top=-29 | `pgf_4c_Paginas.Top = -29` + `.Height = <Form.Height>` (ex: ambos 600) | `.Height = <Form.Height> + 29` (ex: 629). Sem compensar, sobram 29px descobertos no bottom expondo fundo cinza nativo do form como borda inferior indesejada. Formula: `PageFrame.Height = Form.Height + 29`. |
| 70 | Validar() -> ValidarDados() | `PROTECTED PROCEDURE Validar()` | `PROTECTED PROCEDURE ValidarDados()`. BusinessBase.Salvar chama ValidarDados(); Validar() eh silenciosamente pulado. |
| 71 | IIF() com numerico direto sem comparacao | `IIF(THIS.this_nFlag, '1', '0')` | `IIF(THIS.this_nFlag = 1, '1', '0')`. IIF exige LOGICAL no 1o arg; numerico 0 gera "Function argument value, type, or count is invalid". |
| 72 | this_n* com NVL(col,0)=1 (converte para LOGICAL) | `THIS.this_nFlag = (NVL(col,0) = 1)` | `THIS.this_nFlag = NVL(col, 0)`. Propriedade declarada numerica deve receber numerico; `= 1` converte para LOGICAL e quebra comparacoes posteriores. |
| 73 | CheckBox AddObject init .Value=.F./.T. | `.Value = .F.` em WITH de chk_4c_* | `.Value = 0`. CheckBox.Value deve ser NUMERIC desde init para consistencia com LimparCampos e BOParaForm. |
| 74 | BINDEVENT LostFocus em lookup FormBuscaAuxiliar (AMPLIADO em 2026-04-20) | `BINDEVENT(txt, "LostFocus", THIS, "ValidarX")` | `BINDEVENT(txt, "KeyPress", THIS, "ValidarX")`. Deteccao agora usa 3 heuristicas: (a) handler body contem `CREATEOBJECT("FormBuscaAuxiliar")`, (b) nome do handler contem "Lookup", (c) nome do handler contem "Validar" e arquivo inteiro tem FormBuscaAuxiliar. Tasks 017-020 repetiram LostFocus mesmo com a regra porque o CREATEOBJECT estava em `AbrirLookupXxx`, nao no handler ligado pelo BINDEVENT. Handler precisa aceitar `(par_nKeyCode, par_nShiftAltCtrl)` e filtrar ENTER(13)/TAB(9)/F4(115) - **ajuste manual do handler obrigatorio apos auto-fix**. |
| 75 | ALLTRIM em campo numerico | `ALLTRIM(loc_oPg2.txt_4c_Ordems.Value)` onde .Value=0 | `ALLTRIM(TRANSFORM(loc_oPg2.txt_4c_Ordems.Value))`. ALLTRIM exige string; TRANSFORM converte numerico antes. |
| 76 | cmd_4c_Encerrar.Caption errado | `.Caption = "X"` / `"Sair"` / `""` em WITH de cmd_4c_Encerrar | `.Caption = "Encerrar"`. Picture cadastro_sair_60.jpg nao cobre caption; errados aparecem como texto sob o icone. |
| 77 | cnt_4c_Botoes.Left copiado do legado 770px | `.Left = 343` (ou qualquer != 542) em WITH de cnt_4c_Botoes | `.Left = 542`. Padrao FormCor/FormMoe para form migrado 1000px. Legado 770px tinha Grupo_op.Left=343; NAO copiar direto. |
| 78 | Page.Picture ausente em frmcadastro | `.Page1.Caption = "Lista"` sem `.Page1.Picture` seguinte | Injeta `.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"` (e idem Page2). Sem isso, Page1/Page2 ficam brancas. So aplica em forms da pasta cadastros/. |
| 79 | cnt_4c_Sombra/Cabecalho.Width deixando faixa clara a direita | `.Width = THIS.Width - 60` ou numero < Form.Width em cnt_4c_Sombra/Cabecalho | `.Width = THIS.Width`. Header escuro precisa cobrir toda a largura; cnt_4c_Saida do Encerrar eh transparente e fica por cima. |
| 80 | MostrarErro/MsgErro usado para validacao de UI | `MostrarErro("Selecione...", "")` ou `MostrarErro("Vendedor Inv" + CHR(225) + "lido", "...")` | `MsgAviso(...)`. Heuristica detecta mensagens imperativas ("Selecione", "Informe", "obrigat*", "inv*", "Nenhum", "Campo", "Valor") incluindo acentos codificados via CHR(225)/CHR(227)/CHR(231)/CHR(243). |
| 81 | cnt_4c_Saida/cmd_4c_Encerrar dimensoes nao canonicas | `cnt_4c_Saida.Left=935,.Width=60` + `cmd_4c_Encerrar.Width=50` | Normaliza para canonico FormCor: `cnt_4c_Saida.Left=917,.Width=90` + `cmd_4c_Encerrar.Width=75,.Height=75`. Reforca lesson #86 (task018/019/020 repetiram valores errados mesmo com regra nos prompts). |
| 82 | Grid RecordSource sem ColumnCount explicito antes | `loc_oGrid.RecordSource = "cursor_4c_Dados"` sem `loc_oGrid.ColumnCount = N` na linha anterior | Injeta `loc_oGrid.ColumnCount = N` antes, onde N = numero de `.ColumnX.ControlSource` nas proximas 15 linhas. Evita auto-expansao para todas as colunas do cursor. |
| 83 | ConfigurarPaginaLista/Dados sem loc_oPagina.Picture | `PROCEDURE ConfigurarPaginaDados` + `loc_oPagina = THIS.pgf_4c_Paginas.Page2` sem `loc_oPagina.Picture = ...` apos | Injeta `loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"` apos a atribuicao. Complementa #78 (que so pega padrao inline no WITH do PageFrame). |
| 84 | PEMSTATUS em alias de cursor | `PEMSTATUS((par_cAliasCursor), "campo", 5)` ou `PEMSTATUS(par_cAlias, "campo", 5)` | `TYPE(par_cAliasCursor + ".campo") != "U"`. PEMSTATUS exige OBJETO; cursor precisa de TYPE(). Heuristica detecta (<var>) com parenteses extras OU nomes sugestivos (par_c*, Alias/Cursor). Reforca regra #61. |
| 85 | Handler de lookup KeyPress so dispara em F4 | `IF par_nKeyCode = 115` em handler que cria FormBuscaAuxiliar ou chama AbrirLookup* | `IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115`. User espera TAB/ENTER disparar tambem; so F4 deixa preso. Reforca lesson #84. |
| 86 | OptionGroup.Buttons(N) sem .BackStyle=0 | `WITH obj_4c_Opcao.Buttons(2) / .Caption = "N" + CHR(227) + "o" / ... / ENDWITH` sem `.BackStyle = 0` | Injeta `.BackStyle = 0` apos `.Caption`. OptionButton tem BackStyle (OptionGroup nao); sem BackStyle=0 o fundo opaco clipa caracteres acentuados (ex: "Nao" aparece como "Na"). |
| 87 | OptionGroup.Width menor que MAX(Buttons.Left + Buttons.Width) | `.Width = 100` em OptionGroup cujo ultimo Button vai ate Left+Width=132 | Aumenta `.Width` para `MAX(Buttons[i].Left + Buttons[i].Width) + 10`. OptionGroup com BorderStyle=0 ainda clipa conteudo; container precisa acomodar todos os buttons. |
| 88 | `.Width = THIS.Width - 60/-65/-70` em Page container (faixa clara a direita) | `.Width = THIS.Width - 60` em container filho direto de Page | `.Width = THIS.Width`. Aplica apenas em forms CRUD (tem cnt_4c_Saida ou herda FormBase). A subtracao foi introduzida para "evitar sobrepor cnt_4c_Saida", mas esse container eh flutuante/transparente, entao a subtracao so deixa faixa clara expondo fundo do form. Tasks 018/019/021. |
| 89 | Botao de saida generico (Sair/Fechar/Cancelar/X) -> Encerrar canonico | `AddObject("cmd_4c_Sair","CommandButton")` + `.Caption = "Sair"` / `.Width = 50` | Normaliza Caption para `"Encerrar"`, Width=75, Height=75. Complementa #81 (que so trata `cmd_4c_Encerrar` com esse nome exato). Aplica somente em forms CRUD. Preserva o nome do objeto (evita quebrar referencias). |
