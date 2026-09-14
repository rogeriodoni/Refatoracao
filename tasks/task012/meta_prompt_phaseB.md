# FASE B: Funcionalidade - Formsigmvccr (APENAS LOGICA)

**FOCO EXCLUSIVO: IMPLEMENTAR LOGICA REAL. NAO alterar nenhuma propriedade visual.**

## OBJETIVO
Os arquivos sigmvccrBO.prg e Formsigmvccr.prg ja existem com layout visual correto (Fase A).
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
2. **tasks/task012/sigmvccr_form_codigo_fonte.txt** - Codigo fonte original (LOGICA dos metodos)
3. **tasks/task012/mapeamento.json** - Mapeamento de objetos
4. **tasks/task012/comportamento.json** - Analise comportamental (queries SQL, validacoes)
5. **C:\4c\projeto\app\classes\sigmvccrBO.prg** - BO existente (Fase A) - LER PRIMEIRO
6. **C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg** - Form existente (Fase A) - LER PRIMEIRO

## Arquivos a MODIFICAR (NAO recriar do zero!)
1. **C:\4c\projeto\app\classes\sigmvccrBO.prg** - Preencher Inserir/Atualizar/ExecutarExclusao/Buscar/CarregarPorCodigo/CarregarDoCursor
2. **C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg** - Preencher Btn*Click, Validar*, Lookup*, CarregarLista, FormParaBO, BOParaForm

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
- **Propriedades do BO preservam sufixo "s" da coluna do banco**: Colunas como Moedas, Contas, Grupos mapeiam para this_cMoedas, this_cContas, this_cGrupos. NUNCA "corrigir" removendo o "s" (this_cMoeda NAO EXISTE → "Property not found"). Verificar nome EXATO no DEFINE CLASS do BO.
- **Nomes de icones/imagens: COPIAR EXATO do original**: O atributo .Picture deve ter o nome de arquivo EXATO do original (ex: geral_procura_60.jpg, cadastro_sair_60.jpg). Trocar APENAS o path: ..\framework\imagens\ → gc_4c_CaminhoIcones +. NUNCA inventar nomes de arquivo (ex: consultar.bmp NAO EXISTE).
- **Propriedades do FORM: COPIAR TODAS do original**: TitleBar, ControlBox, MaxButton, MinButton, Closable, ClipControls DEVEM ser copiadas do codigo fonte original. Se original tem TitleBar = 0 (sem barra de titulo), migrado DEVE ter TitleBar = 0. Omitir essas propriedades faz VFP9 usar defaults (barra de titulo visivel) alterando completamente a aparencia do form.
- **CommandButton ForeColor/BackColor/Themes EXATOS**: Botoes avulsos DEVEM copiar ForeColor, BackColor, FontName, FontBold, FontItalic, Themes do original. Se original tem ForeColor=90,90,90 + BackColor=255,255,255 + Themes=.F., copiar EXATO. ForeColor=RGB(255,255,255) em fundo claro torna texto INVISIVEL.
- **Grid RecordMark/DeleteMark em OPERACIONAL**: Grids criados manualmente (AddObject) em forms OPERACIONAIS DEVEM ter .RecordMark = .F. e .DeleteMark = .F.. Sem isso, barras de marcacao aparecem na lateral esquerda do grid.
- **ChkRegister NAO EXISTE em BusinessBase**: O legado usa `ThisForm.poDataMgr.ChkRegister()` para verificar duplicidade. Na migracao, usar SQLEXEC com `SELECT COUNT(*) AS nExiste FROM tabela WHERE campo = valor` + verificar `NVL(cursor.nExiste, 0) > 0`. NUNCA chamar ChkRegister no BO.
- **cnt_4c_Cabecalho FUNDO ESCURO OPACO**: O cntSombra do frmcadastro tem fundo escuro. cnt_4c_Cabecalho DEVE ter BackStyle=1 (opaco) + BackColor=RGB(53,53,53) e lbl_4c_Titulo.ForeColor=RGB(255,255,255) (branco). BackStyle=0 torna o cabecalho INVISIVEL.
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

**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir SET SAFETY OFF e SET RESOURCE OFF no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.

Comecar agora. Ler os arquivos existentes (Fase A) PRIMEIRO, depois o codigo fonte original.
Preencher CADA metodo stub com implementacao COMPLETA baseada no legado.
