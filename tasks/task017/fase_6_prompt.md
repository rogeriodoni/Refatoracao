# MIGRACAO MULTI-FASE: FASE 6/8

## 🎯 FASE ATUAL: Form - Campos Restantes e Lookups (Page2 - Parte 2)

Adicionar últimos 50% dos campos e implementar lookups

## FASE 6/8: FORM - CAMPOS RESTANTES E LOOKUPS

### OBJETIVO
COMPLETAR ConfigurarPaginaDados() adicionando:
- Ultimos 50% dos TextBoxes e Labels
- TODOS os lookups com BINDEVENT (F4/F5) COMPLETAMENTE IMPLEMENTADOS
- Container cnt_4c_BotoesAcao (Salvar, Cancelar)

### REGRA CRITICA: LOOKUP COMPLETO - PROIBIDO DEIXAR TODO
**PROIBIDO** criar metodos de lookup com comentarios TODO ou stubs vazios.
Cada campo com lookup DEVE ter o metodo AbrirLookupXxx() COMPLETAMENTE implementado.

### PADRAO OBRIGATORIO DE LOOKUP (copiar e adaptar para cada campo)

#### 1. BINDEVENT no ConfigurarPaginaDados() - registrar F4 e DblClick:
`oxpro
*-- BINDEVENT para campo com lookup
BINDEVENT(loc_oPagina.txt_4c_CodGrupo, "KeyPress", THIS, "CodGrupoLookupKeyPress")
BINDEVENT(loc_oPagina.txt_4c_CodGrupo, "DblClick", THIS, "CodGrupoLookupDblClick")
`

#### 2. Metodos de evento (PUBLIC - nunca PROTECTED):
`oxpro
PROCEDURE CodGrupoLookupKeyPress(nKeyCode, nShiftAltCtrl)
    IF nKeyCode = 28  && F4 (codigo 28 no VFP9)
        THIS.AbrirLookupGrupo()
    ENDIF
ENDPROC

PROCEDURE CodGrupoLookupDblClick()
    THIS.AbrirLookupGrupo()
ENDPROC
`

#### 3. Metodo AbrirLookupXxx() COMPLETO E FUNCIONAL:
`oxpro
PROCEDURE AbrirLookupGrupo()
    *-- Verificar se campo esta habilitado
    IF !THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_CodGrupo.Enabled
        RETURN
    ENDIF

    LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
        "SigCdGrp", ;
        "cursor_4c_BuscaGrupo", ;
        "cgrus", ;
        ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_CodGrupo.Value), ;
        "Buscar Grupo")

    *-- Configurar colunas (usar nomes EXATOS das colunas da tabela no banco)
    loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")

    *-- Exibir e aguardar selecao
    loc_oBusca.Show()

    *-- Processar selecao
    IF loc_oBusca.this_lSelecionou
        IF USED("cursor_4c_BuscaGrupo")
            loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
            loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrupo.dgrus)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_CodGrupo.Value  = loc_cCodigo
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_DescGrupo.Value = loc_cDescricao
        ENDIF
    ENDIF

    *-- Limpar cursor e objeto
    IF USED("cursor_4c_BuscaGrupo")
        USE IN cursor_4c_BuscaGrupo
    ENDIF
    loc_oBusca.Release()
ENDPROC
`

### MAPEAMENTO TABELAS AUXILIARES (nomes EXATOS do banco)
Consultar docs/schema.sql para nomes de tabelas e colunas. Exemplos comuns:
- Grupo Produto:  SigCdGrp  -> cgrus (cod), dgrus (desc)
- Grupo CC:       SigCdGcr  -> Codigos (cod), Descrs (desc) **NAO confundir com SigCdGrp!**
- SubGrupo:       SigCdSgp  -> csgps (cod), dsgps (desc)
- Cor:            SigCdCor  -> cods  (cod), descs (desc)
- Tamanho:        SigCdTam  -> ctams (cod), dtams (desc)
- Moeda:          SigCdMoe  -> cmoes (cod), dmoes (desc)
- Fornecedor:     SigCdCli  -> Iclis (cod), Rclis (desc)
- Grupo Acesso:   SigCdAcg  -> cgacs (cod), dgacs (desc)

**REGRA CRITICA**: NUNCA adivinhar tabela/coluna! SEMPRE verificar no codigo fonte ORIGINAL qual tabela eh usada.
Se o original usa `Seek(valor, [crSigCdGcr], [Codigos])`, a tabela eh SigCdGcr, NAO SigCdGrp!

### COMO FAZER
1. LER o arquivo existente: C:\4c\projeto\app\forms\operacionais\Formsigtosen.prg
2. LER o codigo fonte original para identificar TODOS os campos com lookup (F4/F5/sigacess)
3. Para CADA campo com lookup: adicionar BINDEVENT + metodo evento + AbrirLookupXxx() COMPLETO
4. USAR Edit tool para modificar arquivo existente

### VALIDACAO OBRIGATORIA ANTES DE ENTREGAR
- Nenhum metodo de lookup pode conter "TODO" ou estar vazio
- Cada AbrirLookupXxx() deve ter: CREATEOBJECT FormBuscaAuxiliar, mAddColuna, Show(), verificar this_lSelecionou, preencher campo, USE IN cursor, Release()

### ENTREGA ESPERADA
Arquivo ATUALIZADO: C:\4c\projeto\app\forms\operacionais\Formsigtosen.prg

---

## 📋 CONTEXTO DA MIGRAÇÃO

# Tarefa: Migrar Formulario OPERACIONAL - Formsigtosen

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
2. **tasks/task017/sigtosen_form_codigo_fonte.txt** - Codigo fonte original
3. **tasks/task017/mapeamento.json** - Mapeamento de objetos
4. **tasks/task017/comportamento.json** - Analise comportamental (metodos, queries SQL)

## Arquivos a Criar

### 1. C:\4c\projeto\app\classes\sigtosenBO.prg  (Business Object)
- Herda de **BusinessBase**
- Propriedades this_* para os campos principais da entidade
- Metodos de carga de dados: BuscarSaldos, BuscarHistorico, etc. (conforme legado)
- Metodos de CRUD se aplicavel (Inserir, Atualizar, ExecutarExclusao)
- SQLEXEC em cursores temporarios, depois ZAP + APPEND FROM DBF() nos cursores do grid

### 2. C:\4c\projeto\app\forms\operacionais\Formsigtosen.prg  (Form)
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
- **Propriedades this_ DECLARAR com nome EXATO do uso**: TODA propriedade referenciada como THIS.this_cXxx no codigo DEVE ter declaracao IDENTICA this_cXxx = "" no cabecalho DEFINE CLASS. Nomes amigaveis diferentes (ex: declarar this_cUltGrupo mas usar THIS.this_cUltCgrus) causam Error 174 Property not found no primeiro LostFocus.
- **Container.BorderStyle NAO EXISTE**: Container VFP9 tem BorderWidth mas NAO tem BorderStyle (propriedade de CommandGroup/OptionGroup). Usar apenas .BorderWidth = 0. CorretorAuto #68 remove automaticamente.

## REGRA CRITICA: NUNCA Criar Stubs com MsgAviso (PROIBIDO!)

**ABSOLUTAMENTE PROIBIDO** criar metodos Btn*Click com MsgAviso("...sera implementado...").
Isso eh um STUB DISFARÇADO e VIOLA a regra de funcionalidade completa.

**ERRADO** (stub disfarçado):
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
  - ON SELECTION BAR N OF popMovimentos DO AbrirFormsigtosen
  - PROCEDURE AbrirFormsigtosen() no final do menu.prg
- Deletar *.fxp antes de testar: del /s /q C:\4c\projeto\app\*.fxp

**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir `SET SAFETY OFF` e `SET RESOURCE OFF` no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.

Comecar agora. Ler o codigo fonte original para entender o layout e funcionalidades.


---

## ⚠️ REGRAS CRÍTICAS

### 1. Paridade Funcional 100%
**NUNCA criar versões reduzidas!** Incluir TODOS os campos, TODOS os métodos, TODAS as funcionalidades.

### 2. Fases Anteriores
Arquivos já criados nas fases anteriores:   ✅ FASE 1: sigtosenBO.prg (BO - propriedades e Init)   ✅ FASE 2: sigtosenBO.prg (BO - métodos CRUD completo)   ✅ FASE 3: Formsigtosen.prg (Form - estrutura base)   ✅ FASE 4: Formsigtosen.prg (Form - Grid e botões CRUD)   ✅ FASE 5: Formsigtosen.prg (Form - campos principais parte 1)

### 3. Uso de Ferramentas
- **Fase 1**: Use Write para criar novo arquivo BO
- **Fase 2**: Use Read + Edit para COMPLETAR o BO existente (criado na Fase 1)
- **Fase 3**: Use Write para criar novo arquivo Form
- **Fases 4-8**: Use Read + Edit para MODIFICAR arquivo existente

### 4. Validação
Ao final, verificar se arquivo foi criado/modificado corretamente.

---

## 🚀 AÇÃO OBRIGATÓRIA

**MODIFICAR** arquivo existente usando Read + Edit tools.

NÃO pergunte, NÃO peça confirmação.
EXECUTE A FASE 6 AGORA!

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
