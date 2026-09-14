# RETRY OBRIGATORIO - FASE 4 FALHOU NA TENTATIVA ANTERIOR

**ERRO ANTERIOR**: Fase 4 NÃO passou na validação. Verifique os logs em C:\4c\tasks\task050\logs\05_migracao_fase4.log

**INSTRUCAO**: Voce DEVE completar esta fase AGORA. NAO pergunte, NAO peca confirmacao.
Gere o codigo COMPLETO e FUNCIONAL.

---

# MIGRACAO MULTI-FASE: FASE 4/8

## ?? FASE ATUAL: Form - Grid e Botões CRUD (Page1)

Adicionar Grid e botões CRUD na Page1

## FASE 4/8: FORM - GRID E BOTÕES CRUD

### OBJETIVO
COMPLETAR Page1 de Formsigreche.prg adicionando:
- ConfigurarPaginaLista() com Grid completo
- Container cnt_4c_Botoes com 6 botões CRUD (Incluir, Visualizar, Alterar, Excluir, Buscar, Encerrar)
- AlternarPagina()

### COMO FAZER
1. LER o arquivo existente: C:\4c\projeto\app\forms\relatorios\Formsigreche.prg
2. ADICIONAR ConfigurarPaginaLista() e AlternarPagina()
3. USAR Edit tool para modificar arquivo existente

### ENTREGA ESPERADA
Arquivo ATUALIZADO: C:\4c\projeto\app\forms\relatorios\Formsigreche.prg

---

## ?? CONTEXTO DA MIGRAÇÃO

# Tarefa: Migrar Formulario de RELATORIO - Formsigreche

ATENCAO: Este e um FORMULARIO DE RELATORIO (frmrelatorio), NAO um cadastro CRUD.
A estrutura do codigo e completamente diferente do padrao CRUD.

## O que e um frmrelatorio
- Exibe campos de FILTRO/PARAMETRO (datas, codigos, opcoes de selecao)
- NAO tem Grid de lista, NAO tem operacoes CRUD
- Botoes: Imprimir, Visualizar (preview na tela), Cancelar/Fechar
- Ao imprimir: monta clausula WHERE com os filtros -> SQLEXEC -> REPORT FORM xxx PREVIEW

## Arquivos de Referencia OBRIGATORIOS (LER ANTES DE COMECAR)
1. **CLAUDE.md** - Regras VFP criticas (CHR(), TRY/CATCH, BINDEVENT, etc.)
2. **projeto/app/classes/relatoriobase.prg** - LEIA COMPLETAMENTE - e a base do BO de relatorio
3. **tasks/task050/sigreche_form_codigo_fonte.txt** - Codigo fonte original (filtros, layout)
4. **tasks/task050/mapeamento.json** - Mapeamento de objetos
5. **tasks/task050/comportamento.json** - Analise comportamental (metodos, queries SQL, validacoes)

## Arquivos a Criar

### 1. C:\4c\projeto\app\classes\sigrecheBO.prg  (BO do Relatorio)
- Herda de **RelatorioBase** (NAO de BusinessBase!)
- Propriedades this_* para cada filtro do formulario (datas, codigos, opcoes)
- Override de **PrepararDados()**: monta SQL com WHERE baseado nos filtros -> SQLEXEC
- Init(): chamar DODEFAULT com caminho do FRX e titulo do relatorio
- NAO implementar: Inserir(), Atualizar(), ExecutarExclusao(), Buscar(), CarregarPorCodigo()

### 2. C:\4c\projeto\app\forms\relatorios\Formsigreche.prg  (Form de Filtros)
- Herda de **FormBase**
- Layout FLAT: SEM PageFrame de duas paginas (sem Page1 de lista + Page2 de dados)
- Controles adicionados direto ao form em InicializarForm() (ou em container unico)
- Campos de filtro identicos ao original: TextBoxes, OptionGroups, ComboBoxes, datas
- Lookups F4/DblClick para campos de codigo (igual ao original)
- Botoes: Imprimir, Visualizar, Cancelar
- Metodos: InicializarForm, FormParaRelatorio, BtnImprimirClick, BtnVisualizarClick, BtnCancelarClick

## Padroes de Implementacao

### BO - PrepararDados():
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_cSQL, loc_cWhere, loc_nResult
        loc_cWhere = "1=1"
        IF !EMPTY(THIS.this_cCampo)
            loc_cWhere = loc_cWhere + " AND campo = " + EscaparSQL(THIS.this_cCampo)
        ENDIF
        IF !EMPTY(THIS.this_dDtInicial)
            loc_cWhere = loc_cWhere + " AND data >= " + FormatarDataSQL(THIS.this_dDtInicial)
        ENDIF
        loc_cSQL = "SELECT ... FROM tabela WHERE " + loc_cWhere
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
        IF loc_nResult < 0
            THIS.this_cMensagemErro = "Erro ao buscar dados"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

### Form - BtnImprimirClick():
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro())
        ENDIF
    ENDPROC

### Form - FormParaRelatorio():
    PROTECTED PROCEDURE FormParaRelatorio()
        WITH THIS.this_oRelatorio
            .this_dDtInicial = THIS.txt_4c_DtInicial.Value
            .this_cCliente   = ALLTRIM(THIS.txt_4c_Cliente.Value)
            && ... (todos os filtros do form)
        ENDWITH
    ENDPROC

### Form - InicializarForm() (sem PageFrame CRUD):
    PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oRelatorio = CREATEOBJECT("sigrecheBO")
            THIS.Width   = XXX  && EXATO do original
            THIS.Height  = XXX  && EXATO do original
            THIS.ConfigurarCamposFiltro()
            THIS.ConfigurarBotoesRelatorio()
            THIS.LimparCampos()
            THIS.Visible = .T.
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

### Form - Destroy() (CRITICO - NAO usar Release no BO!):
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.  && NAO usar .Release() - Custom nao tem Release!
        ENDIF
        DODEFAULT()
    ENDPROC

## CRITICO: Validacao LostFocus em campos de descricao (Validar*)

No sistema legado, campos de DESCRICAO (nome, razao social) tinham Valid events que fazem
lookup reverso automatico: usuario digita nome, ao sair do campo (Tab), o sistema busca
no banco e preenche o campo de CODIGO correspondente.

### REGRA: Para CADA par codigo/descricao, implementar ValidarXxx completo

Identificar no codigo fonte original: todo campo que tem evento Valid com fAcessoContas,
fAcessoEmpresa, fwBuscaExt ou fwBuscaInt DEVE ter o Validar* correspondente implementado.

### Padrao ValidarXxx (campo de descricao - busca reversa):
    PROCEDURE ValidarNomXxx()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_NomXxx.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_CodXxx.Value = ""
            THIS.txt_4c_NomXxx.Value = ""
            RETURN
        ENDIF
        *-- Abrir lookup automatico por nome/descricao
        THIS.AbrirBuscaNomXxx()
    ENDPROC

### Padrao ValidarXxx (campo de codigo - busca direta):
    PROCEDURE ValidarCodXxx()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c_CodXxx.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_DesXxx.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT campo_cod, campo_desc FROM tabela WHERE campo_cod = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_XxxVal")
        IF loc_nResult > 0
            SELECT cursor_4c_XxxVal
            IF !EOF()
                THIS.txt_4c_DesXxx.Value = ALLTRIM(campo_desc)
            ENDIF
            USE IN cursor_4c_XxxVal
        ENDIF
    ENDPROC

### Padrao ValidarAtendente (campo unico sem par):
    PROCEDURE ValidarAtendente()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Atendente.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        *-- Abrir lookup automatico
        THIS.AbrirBuscaAtendente()
    ENDPROC

**PROIBIDO**: Deixar Validar* vazios com apenas comentario. Cada um DEVE ter logica real
baseada no Valid event correspondente do legado.

## CRITICO: Tecla* para campos sem lookup (data/PV)

Campos de data ou PV que nao precisam de F4/F5 devem ter handlers vazios - isso e correto:
    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShift)
    ENDPROC

## Analise Comportamental (comportamento.json)

Se o arquivo **comportamento.json** estiver disponivel no contexto, ele contem a analise profunda dos
metodos e eventos do codigo original. REGRAS OBRIGATORIAS:

1. **TODA validacao** listada com `temValidacao=true` DEVE ser implementada
2. **TODAS as queries SQL** devem usar APENAS colunas reais - NAO inventar colunas
3. Se `validacaoSchema.colunasInvalidas` tiver itens, essas colunas NAO EXISTEM - NAO usar
4. **TODAS as funcoes externas** devem ser integradas ou substituidas
5. O campo `codigoOriginal` mostra a logica exata - REPRODUZIR com nova nomenclatura

## Regras VFP Criticas
- NUNCA usar literais acentuados - usar CHR(): a=225, c=231, ao=227, e=233, etc.
- NUNCA usar RETURN dentro de TRY/CATCH - usar variavel loc_lSucesso
- NUNCA usar .Release() em objetos Custom/BO - apenas em objetos Form
- BINDEVENT funciona apenas com metodos PUBLIC (sem PROTECTED)
- **BINDEVENT "Valid" NAO FUNCIONA em TextBox**: Usar "KeyPress" (ENTER=13/TAB=9) para simular Valid. NUNCA usar LostFocus para chamar MontaGrade/CarregarDados/SQLEXEC - LostFocus dispara SEMPRE (inclusive por SetFocus de outro controle) causando RECURSAO INFINITA. Ex: BINDEVENT(txt, "KeyPress", THIS, "TxtCampoKeyPress") e no handler: IF par_nKeyCode = 13 OR par_nKeyCode = 9 ... ENDIF
- **Page.Visible NAO EXISTE**: Page (PageFrame.PageN) NAO tem propriedade Visible. NUNCA .Page1.Visible = .T..
- **PageFrame.Visible OBRIGATORIO**: AddObject cria controles com Visible=.F. SEMPRE adicionar THIS.pgf_4c_Paginas.Visible = .T. ANTES de ActivePage = 1 no InicializarForm. Sem isso form abre em branco.
- **Buttons(N) vs ButtonCount**: Ao fazer BINDEVENT em Buttons(N), N DEVE ser <= ButtonCount. Verificar no AddObject qual era o ButtonCount antes de referenciar.
- TextBox.Value: inicializar como "" (string), 0 (numerico), {} (data)
- FormatarDataSQL() para datas em SQL, EscaparSQL() para strings (JA INCLUI aspas - NUNCA adicionar aspas extras: campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'")
- AddObject() cria controles com Visible=.F. - sempre setar .Visible = .T.
- NUNCA gerar strings SQL numa unica linha longa - SEMPRE quebrar com `+;` (continuation) a cada 3-4 campos. VFP9 tem limite de ~8000 chars por linha logica
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
- **IIF() exige LOGICAL no 1o argumento**: IIF(numerico, ...) quebra com "Function argument value, type, or count is invalid" quando valor=0. Em TEXTMERGE SQL e conversoes, SEMPRE comparar: IIF(this_nFlag = 1, '1', '0'). NUNCA passar numerico direto: IIF(this_nFlag, '1', '0').
- **cnt_4c_Sombra/cnt_4c_Cabecalho.Width = THIS.Width (NAO "THIS.Width - 60")**: Container do header escuro DEVE ocupar a largura TOTAL do form (Width = THIS.Width, ou 1020 como FormCor). O cnt_4c_Saida do Encerrar eh transparente (BackStyle=0) e precisa do fundo escuro POR BAIXO. Width menor deixa faixa clara a direita entre header e borda, expondo fundo do form. NUNCA usar THIS.Width - 60 ou similar achando que precisa deixar espaco para o Encerrar.
- **PUBLIC FUNCTION/PROCEDURE em DEFINE CLASS = SYNTAX ERROR**: Dentro de DEFINE CLASS ... ENDDEFINE, metodos sao PUBLIC por DEFAULT. Apenas PROTECTED e HIDDEN sao modifiers validos. NUNCA PUBLIC FUNCTION Buscar() nem PUBLIC PROCEDURE Init() - gera cascade "Statement is not valid in a class definition" no .ERR e em runtime CREATEOBJECT do BO retorna .F. -> mensagem "VARTYPE retornou: L" ao abrir form. Usar FUNCTION Buscar() / PROCEDURE Init(). Auto-fix: CorretorAutomatico Corrigir-PublicProcedureEmDefineClass (bug observado em task018/UfsBO.prg).
- **btnReport e CommandGroup, NAO Container (frmrelatorio framework.vcx)**: Os 4 botoes superiores de forms REPORT (Visualizar/Imprimir/DocExcel/Sair) sao parte de UMA UNICA CommandGroup chamada cmg_4c_Botoes, NUNCA Container com 4 CommandButtons separados. Geometria EXATA do framework: cmg_4c_Botoes.Top=0, Left=529, Width=273, Height=80, ButtonCount=4, BackStyle=0, BorderStyle=0, BorderColor=RGB(136,189,188), SpecialEffect=1, Themes=.F.. Cada Buttons(N): Top=5, Width=65, Height=70, FontName="Comic Sans MS", FontBold=.T., FontItalic=.T., FontSize=8, BackColor=RGB(255,255,255), ForeColor=RGB(90,90,90), PicturePosition=13 (icone ACIMA), SpecialEffect=0, MousePointer=15, Themes=.F.. Lefts dos botoes: Buttons(1)=5, Buttons(2)=71, Buttons(3)=137, Buttons(4)=203 (incrementos de 66). Buttons(4) .Cancel=.T. (ESC fecha). BINDEVENT em THIS.cmg_4c_Botoes.Buttons(N), NAO em CommandButtons nomeados. Bug observado em task023/SIGREVIS + task024/sigrevto (2026-05-15) - geravam Container+CommandButtons, captions truncadas porque PicturePosition=1 (icon-LEFT) com Width=67 nao cabia. Referencia: imagens em C:\4c\origem\configuracaoBotoesRelatorio.jpg + ideo.jpg/impressora.jpg/excel.jpg/otao_encerrar.jpg.

## Integracao
- Adicionar SET PROCEDURE para BO e Form em config.prg
- Adicionar item no menu (menu.prg) no popup **popRelatorios** (tipo REPORT)
  - DEFINE BAR N OF popRelatorios PROMPT "..." MESSAGE "..."
  - ON SELECTION BAR N OF popRelatorios DO AbrirFormsigreche
  - PROCEDURE AbrirFormsigreche() no final do menu.prg
- Deletar *.fxp antes de testar: del /s /q C:\4c\projeto\app\*.fxp

**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir `SET SAFETY OFF` e `SET RESOURCE OFF` no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.

Comecar agora. Ler relatoriobase.prg primeiro, depois o codigo fonte original.


---

## ?? REGRAS CRÍTICAS

### 1. Paridade Funcional 100%
**NUNCA criar versões reduzidas!** Incluir TODOS os campos, TODOS os métodos, TODAS as funcionalidades.

### 2. Fases Anteriores
Arquivos já criados nas fases anteriores:   ? FASE 1: sigrecheBO.prg (BO - propriedades e Init)   ? FASE 2: sigrecheBO.prg (BO - métodos CRUD completo)   ? FASE 3: Formsigreche.prg (Form - estrutura base)

### 3. Uso de Ferramentas
- **Fase 1**: Use Write para criar novo arquivo BO
- **Fase 2**: Use Read + Edit para COMPLETAR o BO existente (criado na Fase 1)
- **Fase 3**: Use Write para criar novo arquivo Form
- **Fases 4-8**: Use Read + Edit para MODIFICAR arquivo existente

### 4. Validação
Ao final, verificar se arquivo foi criado/modificado corretamente.

---

## ?? AÇÃO OBRIGATÓRIA

**MODIFICAR** arquivo existente usando Read + Edit tools.

NÃO pergunte, NÃO peça confirmação.
EXECUTE A FASE 4 AGORA!

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



