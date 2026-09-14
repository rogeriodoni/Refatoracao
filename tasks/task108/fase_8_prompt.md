# MIGRACAO MULTI-FASE: FASE 8/8

## ?? FASE ATUAL: Form - Eventos Auxiliares e Consolidaï¿½ï¿½o

Finalizar com eventos auxiliares e mï¿½todos de suporte

## FASE 8/8: FORM - EVENTOS AUXILIARES E CONSOLIDAï¿½ï¿½O FINAL

### OBJETIVO
FINALIZAR Formsigregli.prg adicionando:
- BtnBuscarClick(), BtnEncerrarClick()
- BtnSalvarClick(), BtnCancelarClick()
- FormParaBO() e BOParaForm() COMPLETOS (TODOS os campos!)
- HabilitarCampos(), LimparCampos()
- CarregarLista(), AjustarBotoesPorModo()

### VALIDAï¿½ï¿½O FINAL
- Todos os mï¿½todos implementados
- FormParaBO/BOParaForm com TODOS os campos
- Arquivo COMPLETO e funcional

### ENTREGA ESPERADA
Arquivo FINAL COMPLETO: C:\4c\projeto\app\forms\operacionais\Formsigregli.prg

**IMPORTANTE**: Verificar que FormParaBO e BOParaForm incluem TODOS os campos!

---

## ?? CONTEXTO DA MIGRAï¿½ï¿½O

# Tarefa: Migrar Formulario OPERACIONAL - Formsigregli

ATENCAO: Este e um FORMULARIO OPERACIONAL (form generico), NAO um cadastro CRUD.
A estrutura do codigo e diferente do padrao CRUD (sem frmcadastro).

## O que e um form OPERACIONAL
- Herda de `form` generico no legado (NAO de frmcadastro)
- Layout CUSTOMIZADO: grids multiplos, containers flutuantes, botoes especializados
- NAO segue padrao Page1=Lista/Page2=Dados do CRUD
- Funcionalidades: consulta, processamento, movimentacao, contas individuais, etc.
- Pode ter containers que ficam Visible=.F. e sao alternados por botoes

## Arquivos de Referencia OBRIGATORIOS (LER ANTES DE COMECAR)
1. **CLAUDE.md** - Regras VFP criticas (CHR(), TRY/CATCH, BINDEVENT, etc.)
2. **tasks/task108/sigregli_form_codigo_fonte.txt** - Codigo fonte original
3. **tasks/task108/mapeamento.json** - Mapeamento de objetos
4. **tasks/task108/comportamento.json** - Analise comportamental (metodos, queries SQL)

## Arquivos a Criar

### 1. C:\4c\projeto\app\classes\sigregliBO.prg  (Business Object)
- Herda de **BusinessBase**
- Propriedades this_* para os campos principais da entidade
- Metodos de carga de dados: BuscarSaldos, BuscarHistorico, etc. (conforme legado)
- Metodos de CRUD se aplicavel (Inserir, Atualizar, ExecutarExclusao)
- SQLEXEC em cursores temporarios, depois ZAP + APPEND FROM DBF() nos cursores do grid

### 2. C:\4c\projeto\app\forms\operacionais\Formsigregli.prg  (Form)
- Herda de **FormBase**
- Layout customizado conforme original (analisar codigo fonte)
- Grids multiplos com cursores separados
- Containers flutuantes (detalhes abaixo)

## REGRAS CRITICAS PARA FORMS OPERACIONAIS

### Containers Flutuantes (Visible=.F. toggled por botoes)

O legado usa paineis que aparecem/desaparecem ao clicar botoes. No novo sistema:

1. Criar container com Visible=.F. (padrao AddObject)
2. Botao faz toggle: container.Visible = !container.Visible
3. **CRITICO**: TornarControlesVisiveis() DEVE filtrar estes containers!

Exemplo de TornarControlesVisiveis com filtro OBRIGATORIO:
`foxpro
PROCEDURE TornarControlesVisiveis(par_oContainer)
    LOCAL loc_i, loc_oControl
    FOR loc_i = 1 TO par_oContainer.ControlCount
        loc_oControl = par_oContainer.Controls(loc_i)
        *-- FILTRO: Nao tornar visiveis containers flutuantes
        IF UPPER(loc_oControl.Name) = "CNT_4C_SALDO" OR ;
           UPPER(loc_oControl.Name) = "CNT_4C_CONSULTA"
            LOOP  && Pular containers flutuantes
        ENDIF
        loc_oControl.Visible = .T.
        *-- Recursao para sub-containers
        IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
            THIS.TornarControlesVisiveis(loc_oControl)
        ENDIF
    ENDFOR
ENDPROC
`

**REGRA**: Identificar TODOS os containers com Visible=.F. no original e EXCLUIR do TornarControlesVisiveis usando INLIST ou verificacao por nome.

### CREATE CURSOR - Ordem IDENTICA em Todos os Locais (CRITICO!)

Se o mesmo cursor (ex: cursor_4c_Saldos) eh criado em mais de um local (Init + CarregarSaldos),
a ORDEM DOS CAMPOS deve ser EXATAMENTE IDENTICA em TODOS os CREATE CURSOR:

`foxpro
*-- ERRADO - Ordens diferentes:
*-- Init: CREATE CURSOR cursor_4c_Dados (Contas C(20), Rclis C(60), Moedas C(10))
*-- Carregar: CREATE CURSOR cursor_4c_Dados (Moedas C(10), Contas C(20), Rclis C(60))

*-- CORRETO - Mesma ordem em TODOS os locais:
CREATE CURSOR cursor_4c_Dados (Contas C(20), Rclis C(60), Moedas C(10))
`

**DICA**: Copiar o CREATE CURSOR do Init e colar IDENTICO em todos os metodos de carga.

### Grid ControlSource DEVE Bater com CREATE CURSOR (CRITICO!)

Os campos usados em ControlSource das colunas do Grid DEVEM existir no CREATE CURSOR:

`foxpro
*-- Se Grid usa:
.Column1.ControlSource = "cursor_4c_Dados.Contas"
.Column2.ControlSource = "cursor_4c_Dados.Rclis"

*-- Entao CREATE CURSOR DEVE ter estes campos:
CREATE CURSOR cursor_4c_Dados (Contas C(20), Rclis C(60))

*-- E o SELECT SQL DEVE ter alias correspondentes:
loc_cSQL = "SELECT a.conta AS Contas, b.razao AS Rclis FROM ..."
`

**REGRA**: Para CADA cursor usado em Grid, verificar:
1. CREATE CURSOR tem TODOS os campos usados em ControlSource
2. SELECT SQL tem alias AS que correspondem aos nomes do CREATE CURSOR
3. Ordem dos campos eh consistente

### SET NULL ON Antes de CREATE CURSOR (OBRIGATORIO)

SQL Server retorna NULLs. Sem SET NULL ON, APPEND FROM falha:

`foxpro
SET NULL ON
CREATE CURSOR cursor_4c_Dados (campo1 C(20) NULL, campo2 N(14,2) NULL)
SET NULL OFF
`

### SQLEXEC em Cursor Temporario (Grid Protection)

NUNCA fazer SQLEXEC direto no cursor do Grid (destroi colunas):

`foxpro
*-- ERRADO:
SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")  && Destroi colunas do Grid!

*-- CORRETO:
SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")  && Cursor temporario
SELECT cursor_4c_Dados
ZAP
APPEND FROM DBF("cursor_4c_DadosTemp")
USE IN cursor_4c_DadosTemp
`

## Analise Comportamental (comportamento.json)

Se disponivel, contem analise profunda dos metodos originais. REGRAS:
1. TODA validacao listada DEVE ser implementada
2. TODAS as queries SQL devem usar APENAS colunas reais do schema.sql
3. TODAS as funcoes externas devem ser integradas ou substituidas
4. O campo `codigoOriginal` mostra logica exata - REPRODUZIR com nova nomenclatura

## Regras VFP Criticas
- NUNCA usar literais acentuados - usar CHR(): a=225, c=231, ao=227, e=233, etc.
- NUNCA usar RETURN dentro de TRY/CATCH - usar variavel loc_lSucesso
- BINDEVENT funciona apenas com metodos PUBLIC (sem PROTECTED)
- **BINDEVENT "Valid" NAO FUNCIONA em TextBox**: Usar "KeyPress" (ENTER=13/TAB=9) para simular Valid. NUNCA usar LostFocus para chamar MontaGrade/CarregarDados/SQLEXEC - LostFocus dispara SEMPRE (inclusive por SetFocus de outro controle) causando RECURSAO INFINITA. Ex: BINDEVENT(txt, "KeyPress", THIS, "TxtCampoKeyPress") e no handler: IF par_nKeyCode = 13 OR par_nKeyCode = 9 ... ENDIF
- **Page.Visible NAO EXISTE**: Page (PageFrame.PageN) NAO tem propriedade Visible. NUNCA .Page1.Visible = .T..
- **PageFrame.Visible OBRIGATORIO**: AddObject cria controles com Visible=.F. SEMPRE adicionar THIS.pgf_4c_Paginas.Visible = .T. ANTES de ActivePage = 1 no InicializarForm. Sem isso form abre em branco.
- **Buttons(N) vs ButtonCount**: Ao fazer BINDEVENT em Buttons(N), N DEVE ser <= ButtonCount. Verificar no AddObject qual era o ButtonCount antes de referenciar.
- TextBox.Value: inicializar como "" (string), 0 (numerico), {} (data)
- FormatarDataSQL() para datas, EscaparSQL() para strings (JA INCLUI aspas - NUNCA adicionar aspas extras), FormatarNumeroSQL() para numeros
- AddObject() cria com Visible=.F. - sempre setar .Visible = .T. (EXCETO containers flutuantes!)
- NUNCA gerar SQL numa unica linha longa - quebrar com +; a cada 3-4 campos
- NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1)
- UI Fidelity PILAR 1: Width/Height/Top/Left/BackColor/ForeColor/FontName EXATOS do original
- PILAR 2: Usar nomes de colunas EXATOS do banco (ver schema.sql)
- **MESSAGEBOX PROIBIDO**: NUNCA usar MESSAGEBOX() direto. Usar funcoes de messages.prg: MsgInfo() para informativo (icone 64), MsgAviso() para aviso (icone 48), MsgErro() para erro (icone 16), MsgConfirma() para confirmacao Sim/Nao. Essas funcoes suprimem dialogs em modo de teste automatizado.
- **UNION ALL entre tabelas diferentes**: NUNCA usar SELECT * em UNION ALL. Listar colunas EXPLICITAS IDENTICAS.
- **INTO CURSOR READWRITE**: NUNCA usar INTO CURSOR X + USE DBF("X") IN 0 ALIAS Y. Usar INTO CURSOR cursor_4c_Dados READWRITE direto.
- **Cursor placeholder = cursor real**: CREATE CURSOR placeholder no InicializarForm DEVE ter EXATAMENTE os mesmos campos que o cursor populado por SQLEXEC.
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
- **BO: metodo de validacao chama-se ValidarDados() (NAO Validar)**: BusinessBase.Salvar() chama THIS.ValidarDados(). BOs que implementam PROTECTED PROCEDURE Validar() tem validacao silenciosamente pulada -> Inserir roda com valores default e falha no SQL. SEMPRE usar PROTECTED PROCEDURE ValidarDados().
- **IIF() exige LOGICAL no 1o argumento**: IIF(numerico, ...) quebra com "Function argument value, type, or count is invalid" quando valor=0. Em TEXTMERGE SQL e conversoes, SEMPRE comparar: IIF(this_nFlag = 1, '1', '0'). NUNCA passar numerico direto: IIF(this_nFlag, '1', '0').
- **Colunas NUMERIC(1,0) preservam tipo NUMERIC em this_n***: Em CarregarDoCursor, NUNCA usar ramo ELSE generico THIS.this_nXxx = (NVL(col,0) = 1) (converte para LOGICAL). Padrao canonico: IF VARTYPE(col)="N" / THIS.this_nXxx = NVL(col, 0) / ELSE / THIS.this_nXxx = IIF(NVL(col,.F.),1,0) / ENDIF. BIT do SQL->LOGICAL vai em this_l*; NUMERIC(1,0)->NUMERIC vai em this_n*.
- **CheckBox .Value = 0 no AddObject (NAO .F.)**: AddObject CheckBox DEVE inicializar .Value = 0 (NUMERIC). Usar .Value = .F. cria LOGICAL e conflita com LimparCampos (.Value = 0, NUMERIC) e BOParaForm - dispara "Operator/operand type mismatch" no primeiro uso. BOParaForm: usar chk.Value = IIF(this_lProp, 1, 0) ou IIF(this_nProp = 1, 1, 0), nunca atribuir LOGICAL direto.
- **Lookups FormBuscaAuxiliar NUNCA com BINDEVENT "LostFocus"**: Handlers Validar* que criam FormBuscaAuxiliar DEVEM usar BINDEVENT "KeyPress". LostFocus dispara quando o dialog de lookup toma foco -> RECURSAO: segundo dialog empilhado, grade aparece vazia, campo fica em branco apos Selecionar. Handler deve receber (par_nKeyCode, par_nShiftAltCtrl) e executar apenas em ENTER(13)/TAB(9)/F4(115): IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115 / RETURN / ENDIF.
- **ALLTRIM() NAO aceita numerico**: ALLTRIM(txt.Value) quando .Value e numerico (ex: .Value=0, InputMask="999") gera "Function argument value, type, or count is invalid". Em validacao usar comparacao direta (IF .Value = 0); em conversao, envolver com TRANSFORM: ALLTRIM(TRANSFORM(.Value)).
- **cmd_4c_Encerrar.Caption = "Encerrar"**: Botao Encerrar DEVE ter .Caption = "Encerrar" (NAO "X", "Sair" ou ""). A Picture "cadastro_sair_60.jpg" NAO cobre a caption; captions errados aparecem como texto abaixo do icone. Padrao dos forms CRUD (FormCor, FormMoe).
- **PADRAO CANONICO SAIDA/ENCERRAR ï¿½ PREVALECE SOBRE PILAR 1 (pixel-perfect legado)**: O bloco de saida (container + botao Encerrar) DEVE seguir o padrao canonico do sistema novo (FormCor), IGNORANDO os valores do SCX legado. Canonical (inegociavel): cnt_4c_Saida.Left=917, Width=90, Height=85; cmd_4c_Encerrar.Left=5, Top=5, Width=75, Height=75, Caption="Encerrar". Se o SCX legado tiver Grupo_Saida.Left=935 W=60 ou botao X com W=50/Caption="X"/"Sair"/"Fechar", IGNORE e use o canonico. O mesmo vale para .Width = THIS.Width - 60/-65 em containers de Page (pgf.Page1/Page2): DEVE ser .Width = THIS.Width (container de saida eh flutuante/transparente sobre a Page, subtrair largura deixa faixa clara exposta a direita). Esta regra PREVALECE sobre o PILAR 1 (pixel-perfect ao legado) ï¿½ o sistema novo tem padrao visual proprio para o bloco de saida que NAO deve ser sobrescrito pelo SCX. CorretorAutomatico #81, #88, #89 corrigem automaticamente, mas o gerador DEVE ja emitir correto.
- **PUBLIC NAO EXISTE em DEFINE CLASS**: Metodos dentro de DEFINE CLASS ... ENDDEFINE sao PUBLIC por default. PUBLIC FUNCTION xxx() e PUBLIC PROCEDURE xxx() sao SYNTAX ERROR ("Statement is not valid in a class definition"). Apenas PROTECTED e HIDDEN sao modifiers validos. Escrever sempre: FUNCTION xxx() / PROCEDURE xxx() (sem PUBLIC) OU PROTECTED PROCEDURE xxx() / HIDDEN FUNCTION xxx().
- **Page.Width / Page.Height READ-ONLY em runtime**: Pages (PageFrame.PageN) NAO aceitam atribuicao a .Width/.Height em runtime ï¿½ essas propriedades sao controladas pelo PageFrame automaticamente. WITH loc_oPage / .Width = THIS.Width / .Height = THIS.Height / ENDWITH causa "CREATEOBJECT retornou valor nao-objeto" na instanciacao. Remover TODAS as atribuicoes a Page.Width/Height em ConfigurarPageFrame ou similares. Se precisa cobrir area, usar containers filhos da Page com Width/Height fixos.
- **MostrarAviso NAO EXISTE**: Apenas MostrarErro (FormErro.prg), MsgErro, MsgAviso, MsgConfirma, MsgInfo (messages.prg) existem. MostrarAviso(...) gera runtime error "File 'mostraraviso.prg' does not exist". Usar MsgAviso(msg) para validacao de UI (dialog amarelo) OU MostrarErro(msg, titulo) para exceptions tecnicas (dialog vermelho). CorretorAutomatico #90 auto-corrige.
- **Cursor do grid + SQLEXEC Buscar: fechar antes (uncommitted changes)**: Em BO.Buscar ou BO.CarregarPorCodigo, antes de SQLEXEC(..., "cursor_4c_Dados") (ou outro alias que o form usa como grd.RecordSource), fechar o cursor anterior: IF USED("cursor_4c_Dados") / TABLEREVERT(.T., "cursor_4c_Dados") / USE IN cursor_4c_Dados / ENDIF. Sem isso, segundo SQLEXEC falha com "Table buffer contains uncommitted changes" porque o grid pode ter mantido edicoes pendentes no buffer. CorretorAutomatico #91 injeta automaticamente.
- **cnt_4c_Saida padrao canonico (FormCor)**: cnt_4c_Saida Left=917, Width=90, Height=85. cmd_4c_Encerrar dentro com Left=5, Top=5, Width=75, Height=75. Mantem Encerrar com as MESMAS dimensoes dos botoes CRUD (75x75). Valores antigos (Left=935 W=60 botao W=50) tornam o Encerrar visualmente menor - substituir pelo padrao FormCor.
- **FormParaBO/BOParaForm: props EXATAS do BO + descricoes de lookup DECLARADAS**: Toda prop acessada via this_oBusinessObject.xxx DEVE existir como declaracao no BO. Assign em prop nao-declarada cria dinamica, mas LEITURA em instancia fresca (pos CarregarDoCursor, antes de qualquer assign) dispara "Property THIS_XXX is not found". Descricoes de lookup (this_cDsX, this_cDxxx) que nao vao para o SQL mas passam por FormParaBO/BOParaForm TAMBEM precisam ser declaradas no BO (mesmo que nao-persistidas).
- **cnt_4c_Botoes.Left = 542 em forms 1000px (NAO copiar Left=343 do legado)**: Container de botoes CRUD DEVE ficar a direita (Left=542, Width=390, ends=932). Gerador tende a copiar Grupo_op.Left=343 do SCX legado (form 770px) resultando em botoes centralizados. Padrao FormCor/FormMoe: Left=542. Formula para 1000px: FormWidth - CntBotoesWidth - GapEncerrar = 1000 - 390 - 68 = 542.
- **Page1.Picture + Page2.Picture = "fundo_cad_1003.jpg" obrigatorio em frmcadastro**: ConfigurarPageFrame de forms frmcadastro (cadastros/) DEVE setar .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg" E .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg". Sem isso, Page1/Page2 ficam totalmente brancas (sem o fundo visual do framework). Ver FormCor.ConfigurarPageFrame como referencia.
- **cnt_4c_Sombra/cnt_4c_Cabecalho.Width = THIS.Width (NAO "THIS.Width - 60")**: Container do header escuro DEVE ocupar a largura TOTAL do form (Width = THIS.Width, ou 1020 como FormCor). O cnt_4c_Saida do Encerrar eh transparente (BackStyle=0) e precisa do fundo escuro POR BAIXO. Width menor deixa faixa clara a direita entre header e borda, expondo fundo do form. NUNCA usar THIS.Width - 60 ou similar achando que precisa deixar espaco para o Encerrar.
- **MsgAviso para validacao de UI, MsgErro APENAS para exceptions tecnicas**: "Selecione um registro", "Campo obrigatorio", "Valor invalido", "Ja cadastrado" DEVEM usar MsgAviso(...) (dialog amarelo). MsgErro/MostrarErro (dialog vermelho + botao "Fechar Aplicacao") APENAS para erros tecnicos reais: exceptions capturadas em CATCH, "Erro ao...", "Falha ao...", SQL errors, conexao. Usar MostrarErro para validacao assusta o usuario.
- **Grid.ColumnCount ANTES de RecordSource em CarregarLista**: TODA vez que definir grd.RecordSource = "cursor_4c_Dados", setar grd.ColumnCount = N IMEDIATAMENTE antes (N = numero de colunas que queremos no grid). Sem isso, grid auto-expande para todas as colunas do cursor (ex: cursor com 10 campos gera grid com 10 colunas e headers duplicados). Regra vale para CarregarLista e tambem ExecutarBusca/Buscar-style refresh. Existe regra #43 (nao resetar ColumnCount) com sentido especifico; esta reforca: ColumnCount DEVE ser setado >= 1 vez antes de CADA RecordSource.
- **ConfigurarPaginaLista/Dados: loc_oPagina.Picture = fundo_cad_1003.jpg obrigatorio**: Metodos que iniciam com loc_oPagina = THIS.pgf_4c_Paginas.PageN DEVEM setar loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg" antes de qualquer AddObject. Sem isso, a pagina fica totalmente branca em vez de mostrar o fundo padrao do framework. Complementar a regra #88 que cobre o padrao .Page1.Picture inline no WITH do PageFrame.
- **FormParaBO DEVE popular TODAS props do BO usadas em Inserir/Atualizar**: Props de SQL (this_d*, this_n*, this_c*) referenciadas em Inserir() DEVEM ser populadas em FormParaBO(), incluindo campos auto-gerados: IF modo==INCLUIR AND EMPTY(this_dDatas) / this_dDatas = DATE() / ENDIF, 	his_cEmps = go_4c_Sistema.cCodEmpresa, etc. Se nao popular, Insert grava NULL/default (data NULL, empresa vazia). Auditoria: toda prop THIS.this_[cdn]\w+ referenciada em Inserir deve aparecer em FormParaBO.
- **INDEX ON ... TAG <nome-da-coluna>, NAO TAG unico "ordem"**: Quando o form precisa mudar ordenacao via SET ORDER TO TAG <col>, criar UM TAG POR COLUNA no cursor (ex: INDEX ON Locals TAG Locals, INDEX ON Nivel2s TAG Nivel2s, etc.). NUNCA criar INDEX ON &loc_cOrdem TAG ordem (nome generico "ordem"): destroi tags anteriores e form nao consegue fazer SET ORDER TO TAG Locals. Auditoria cross-file: listar SET ORDER TO TAG (\w+) no form vs INDEX ON ... TAG (\w+) no BO - tags usados no form mas ausentes no BO sao bugs.
- **Campo auto-preenchido NAO eh ReadOnly/Enabled=.F. no AddObject**: TextBox que o legado preenche via Valid/SEEK em certos fluxos AINDA eh editavel pelo usuario. NUNCA setar `.ReadOnly = .T.` ou `.Enabled = .F.` no AddObject inicial a menos que o SCX legado tenha essas propriedades explicitas. Comentarios como "preenchido ao selecionar no grid" NAO justificam bloquear edicao. Controle de Enabled por modo (INCLUIR/ALTERAR/VISUALIZAR) vai em HabilitarCampos.
- **PEMSTATUS em cursor: erro "Function argument value, type, or count is invalid"**: PEMSTATUS exige OBJETO no 1o arg, NUNCA alias de cursor. `PEMSTATUS((par_cAlias), "campo", 5)` ou `PEMSTATUS(par_cAlias, "campo", 5)` (com par_cAlias sendo nome de cursor) quebra. Usar `TYPE(par_cAlias + ".campo") != "U"` para checar se campo existe no cursor. Regra #61 ja documentada; reforcar agora porque gerador continua replicando o erro em CarregarDoCursor.
- **Lookup KeyPress: ENTER(13) E TAB(9) E F4(115), NAO so F4**: Handlers Validar*/AbrirLookup* ligados via BINDEVENT KeyPress DEVEM disparar em `par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115`. Somente `= 115` (F4) deixa user preso: digita codigo, TAB, nada acontece. Padrao correto ja em lesson #84; gerador continua emitindo so `= 115` em alguns forms - CorretorAutomatico #85 normaliza.
- **Forms 1-N com grid secundario: criar cursor vazio em BtnIncluirClick**: Forms com grids secundarios (ex: grd_4c_Dados exibindo localidades/itens) onde user adiciona registros manualmente via KeyPress DEVEM criar o cursor vazio com estrutura correta + tags em `BtnIncluirClick`. Sem isso, em modo INCLUIR o cursor nao existe -> user digita e nada acontece. Exemplo: `CREATE CURSOR cursor_4c_Xxx (col1 C(9), col2 N(9,0), ...) / INDEX ON col1 TAG col1 / INDEX ON col2 TAG col2`. Chamar ConfigurarGrdDados() em seguida para bind do grid.
- **OptionGroup.Buttons(N) DEVE ter .BackStyle = 0**: OptionButton dentro de OptionGroup tem BackStyle (0=transparente, 1=opaco). Sem .BackStyle = 0 no WITH dos sub-botoes, o fundo opaco pode clipar texto da caption - "N" + CHR(227) + "o" ("Nao") aparece como "Na" na tela. SCX legado tipicamente tem OptionN.BackStyle = 0; migrador as vezes omite. NAO confundir com CommandButton/CommandGroup que NAO tem BackStyle (regras #59/#60).
- **OptionGroup.Width DEVE >= MAX(Buttons[i].Left + Buttons[i].Width) + 10**: Container OptionGroup clipa conteudo mesmo com BorderStyle=0. Se Buttons(N) foram expandidos (ex: Width de 37 para 60 para acomodar captions acentuadas "Nao"), o Container tambem precisa crescer. NAO basta copiar Width do SCX legado ï¿½ validar que container acomoda todos os buttons + 10px margem.

## REGRA CRITICA: NUNCA Criar Stubs com MsgAviso (PROIBIDO!)

**ABSOLUTAMENTE PROIBIDO** criar metodos Btn*Click com MsgAviso("...sera implementado...").
Isso eh um STUB DISFARï¿½ADO e VIOLA a regra de funcionalidade completa.

**ERRADO** (stub disfarï¿½ado):
`foxpro
PROCEDURE BtnMovimentoClick()
    MsgAviso("Movimentacao sera implementada.", "Aviso")
ENDPROC
`

**CORRETO** (logica real baseada no legado):
Analisar o PROCEDURE correspondente no codigo fonte original e implementar:
- Botoes de **relatorio/impressao/Excel**: Implementar geracao de relatorio (REPORT FORM / COPY TO XLS)
- Botoes de **operacao** (Alterar, Excluir, Movimento, Conciliar, Auditar, FollowUp):
  Implementar logica real do legado (SQL INSERT/UPDATE/DELETE, navegacao, abertura de formularios)
- Se o legado chama ProcessaSaldo/ProcessaHist: Criar metodo equivalente no BO

**TODOS os botoes visiveis na tela DEVEM ter funcionalidade REAL implementada.**

## Integracao
- Adicionar SET PROCEDURE para BO e Form em config.prg
- Adicionar item no menu (menu.prg) no popup **popMovimentos** (tipo OPERACIONAL)
  - DEFINE BAR N OF popMovimentos PROMPT "..." MESSAGE "..."
  - ON SELECTION BAR N OF popMovimentos DO AbrirFormsigregli
  - PROCEDURE AbrirFormsigregli() no final do menu.prg
- Deletar *.fxp antes de testar: del /s /q C:\4c\projeto\app\*.fxp

**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir `SET SAFETY OFF` e `SET RESOURCE OFF` no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.

Comecar agora. Ler o codigo fonte original para entender o layout e funcionalidades.


---

## ?? REGRAS CRï¿½TICAS

### 1. Paridade Funcional 100%
**NUNCA criar versï¿½es reduzidas!** Incluir TODOS os campos, TODOS os mï¿½todos, TODAS as funcionalidades.

### 2. Fases Anteriores
Arquivos jï¿½ criados nas fases anteriores:   ? FASE 1: sigregliBO.prg (BO - propriedades e Init)   ? FASE 2: sigregliBO.prg (BO - mï¿½todos CRUD completo)   ? FASE 3: Formsigregli.prg (Form - estrutura base)   ? FASE 4: Formsigregli.prg (Form - Grid e botï¿½es CRUD)   ? FASE 5: Formsigregli.prg (Form - campos principais parte 1)   ? FASE 6: Formsigregli.prg (Form - campos restantes e lookups)   ? FASE 7: Formsigregli.prg (Form - eventos principais)

### 3. Uso de Ferramentas
- **Fase 1**: Use Write para criar novo arquivo BO
- **Fase 2**: Use Read + Edit para COMPLETAR o BO existente (criado na Fase 1)
- **Fase 3**: Use Write para criar novo arquivo Form
- **Fases 4-8**: Use Read + Edit para MODIFICAR arquivo existente

### 4. Validaï¿½ï¿½o
Ao final, verificar se arquivo foi criado/modificado corretamente.

---

## ?? Aï¿½ï¿½O OBRIGATï¿½RIA

**MODIFICAR** arquivo existente usando Read + Edit tools.

Nï¿½O pergunte, Nï¿½O peï¿½a confirmaï¿½ï¿½o.
EXECUTE A FASE 8 AGORA!

---

## REGRA OBRIGATORIA DE COMPLETUDE (APLICADA A ESTA FASE)

**PROIBIDO** incluir no codigo gerado:
- Comentarios `*-- TODO`, `*-- FIXME`, `*-- HACK`, `*-- PLACEHOLDER`
- Procedures/metodos vazios (sem codigo real)
- Comentarios indicando "implementar depois" ou "proxima fase"
- Stubs que retornam valores fixos sem logica real
- Metodos com apenas `DODEFAULT()` quando devem ter logica propria

**CADA metodo gerado DEVE ter implementacao COMPLETA e FUNCIONAL.**

Se nao souber como implementar algo, analise o codigo fonte original e replique a logica.
NUNCA omitir funcionalidade - paridade 100% com o sistema legado.
O resultado sera validado automaticamente e **fases com TODOs/stubs serao REJEITADAS**.

### REGRAS ESPECIFICAS PARA FORM OPERACIONAL

1. **Containers Flutuantes**: Containers com Visible=.F. toggled por botoes - TornarControlesVisiveis DEVE filtrar por nome (INLIST/IF LOOP)
2. **CREATE CURSOR**: Se mesmo cursor aparece em mais de um local, a ORDEM DOS CAMPOS deve ser IDENTICA
3. **Grid ControlSource**: Campos usados em ControlSource DEVEM existir no CREATE CURSOR com nomes identicos
4. **SQLEXEC**: Sempre em cursor temporario + ZAP + APPEND FROM DBF() (nunca direto no cursor do Grid)
5. **SET NULL ON**: Antes de CREATE CURSOR que recebera dados de SQLEXEC
6. **Layout**: NAO segue padrao CRUD Page1=Lista/Page2=Dados - analisar original
