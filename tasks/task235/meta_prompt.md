# Tarefa: Migrar Formulario de RELATORIO - FormSIGPRCCR

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
3. **tasks/task235/SIGPRCCR_form_codigo_fonte.txt** - Codigo fonte original (filtros, layout)
4. **tasks/task235/mapeamento.json** - Mapeamento de objetos
5. **tasks/task235/comportamento.json** - Analise comportamental (metodos, queries SQL, validacoes)

## Arquivos a Criar

### 1. C:\4c\projeto\app\classes\SIGPRCCRBO.prg  (BO do Relatorio)
- Herda de **RelatorioBase** (NAO de BusinessBase!)
- Propriedades this_* para cada filtro do formulario (datas, codigos, opcoes)
- Override de **PrepararDados()**: monta SQL com WHERE baseado nos filtros -> SQLEXEC
- Init(): chamar DODEFAULT com caminho do FRX e titulo do relatorio
- NAO implementar: Inserir(), Atualizar(), ExecutarExclusao(), Buscar(), CarregarPorCodigo()

### 2. C:\4c\projeto\app\forms\relatorios\FormSIGPRCCR.prg  (Form de Filtros)
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
            THIS.this_oRelatorio = CREATEOBJECT("SIGPRCCRBO")
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
- **fAcessoEmpresa() NAO EXISTE (nao portada)**: A funcao global AcessoEmpresa() do Framework legado (sigacess.PRG) NAO foi portada para a nova arquitetura. Chamadas diretas quebram em runtime com "File 'facessoempresa.prg' does not exist" (VFP9 procura .prg externo quando o nome nao eh THIS.metodo nem funcao definida). Substituicao canonica: MODO CHECK (3 args, retorna boolean) AcessoEmpresa(usu,"C",cod) -> VerificarAcessoEmpresa(usu, cod) (helper em utils/functions.prg). MODO LOOKUP (5 args, popula 2 textboxes) AcessoEmpresa(usu, "C"|"D", val, oCod, oDsc) -> bloco FormBuscaAuxiliar apontando SigCdEmp com chave Cemps (modo C) ou Razas (modo D), retornando ambas colunas. Titulo: "Sele" + CHR(231) + CHR(227) + "o de Empresa". Auto-fix: CorretorAutomatico #110. Padrao canonico: Formsigatcrp.prg:2278-2378 (KeyPress) e Formsigrepes.prg:6501-6540 (LostFocus). Bug observado em Formsigatcrp.prg + Formsigrepes.prg (2026-07-02, Erro14).
- **fAcessoContas() NAO USAR para lookup UX (auto-load do primeiro registro)**: A funcao AcessoContas() (utils/functions.prg:719) EH portada, mas seu fluxo interno (LIKE '%valor%' + LOCATE + FormBuscaSimples) auto-popula o textbox com o PRIMEIRO registro que contem o valor digitado â€” mesmo sem selecao explicita do usuario no picker. Resultado tipico: user digita "11" no campo Gerente/Vendedor e o form carrega "GAVETA - LOJA 001..." (primeiro match parcial). PROIBIDO usar AcessoContas(usu, grp, "C"|"D", val, txtCod, txtNom) como handler de Valid/KeyPress em textbox de lookup. Substituicao canonica: mesmo padrao de fAcessoEmpresa lookup (Formsigatcrp.prg:2612-2790 apos Erro16 fix). Enter/Tab -> SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = valor exato (hit -> auto-preenche, miss -> THIS.AbrirBusca<X>()). AbrirBusca<X> -> SQL proprio com LIKE 'valor%' OR RTRIM(RClis) LIKE 'valor%' (starts-with, NAO contem) + fallback lista completa + CREATEOBJECT("FormBuscaAuxiliar") sem SQL automatica + mAddColuna("IClis"/"RClis") + .Show() respeitando 	his_lSelecionou. AcessoContas() continua valida para contexto backend (SCAN loop de acesso, validacao sem UI). Bug observado em Formsigatcrp.prg ValidarCodGer/ValidarNomGer/ValidarCodVen/ValidarNomVen (2026-07-02, Erro16).
- **.RecordMark/.DeleteMark SO em Grid â€” NUNCA em CommandButton/Label/Container/TextBox/ComboBox/etc**: As propriedades .RecordMark e .DeleteMark sao EXCLUSIVAS de Grid (barras laterais de marcacao/exclusao de registro). Gerador frequentemente copia esse par de WITH grd_4c_Xxx e cola em WITH de CommandButton adjacente (ex: cmd_4c_SelXxx/cmd_4c_DslXxx ao lado de grids de selecao multipla em REPORT). VFP9 trava com "Property RECORDMARK is not found" ao instanciar o form. PIOR: o erro eh silenciosamente engolido pelo TRY/CATCH de InicializarForm (apenas seta loc_lSucesso=.F. sem MsgErro), resultando em CREATEOBJECT("FormXxx") retornar .F. sem exception aparente e "VARTYPE retornou: L" no dialog. PROIBIDO gerar .RecordMark = .F. ou .DeleteMark = .F. em WITH cujo AddObject NAO seja "Grid". Recomendacao complementar: no CATCH de InicializarForm, chamar MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure) ANTES de setar loc_lSucesso=.F. â€” expoe o erro para debug em vez de engolir silenciosamente. Auto-fix: CorretorAutomatico #111. Bug observado em Formsigrepes.prg (2026-07-02, Erro17): 9 CommandButtons corrompidos (cmd_4c_SelOrigMerc, cmd_4c_SelTipoInvs, cmd_4c_SelLinha, etc).
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
- **Nomes de icones/imagens: COPIAR EXATO do original + VALIDAR EXISTENCIA**: O atributo .Picture deve ter o nome de arquivo EXATO do original (ex: geral_procura_60.jpg, cadastro_sair_60.jpg). Trocar APENAS o path: ..\framework\imagens\ ? gc_4c_CaminhoIcones +. NUNCA inventar nomes de arquivo (ex: consultar.bmp, geral_visualizar_60.jpg, geral_imprimir_60.jpg, geral_fechar_60.jpg â€” NAO EXISTEM em vbmp/). USAR APENAS gc_4c_CaminhoIcones (NUNCA gc_4c_Icones â€” variavel legada, gera falhas em runtime). Para REPORT, ver "REPORT Buttons(N).Picture: ICONES CANONICOS OBRIGATORIOS" abaixo.
- **Propriedades do FORM: COPIAR TODAS do original**: TitleBar, ControlBox, MaxButton, MinButton, Closable, ClipControls DEVEM ser copiadas do codigo fonte original. Se original tem TitleBar = 0 (sem barra de titulo), migrado DEVE ter TitleBar = 0. Omitir essas propriedades faz VFP9 usar defaults (barra de titulo visivel) alterando completamente a aparencia do form.
- **CommandButton ForeColor/BackColor/Themes EXATOS**: Botoes avulsos DEVEM copiar ForeColor, BackColor, FontName, FontBold, FontItalic, Themes do original. Se original tem ForeColor=90,90,90 + BackColor=255,255,255 + Themes=.F., copiar EXATO. ForeColor=RGB(255,255,255) em fundo claro torna texto INVISIVEL. **EXCECAO**: standalone CommandButton (fora de CommandGroup) com .Picture DEFINIDO precisa de .Themes = .T. + .DisabledPicture = (mesma imagem) â€” sem isso, com Themes=.F. + Enabled=.F. o icone NAO renderiza (so caption aparece). Auto-fix: CorretorAutomatico #99. Buttons(N) DENTRO de CommandGroup MANTEM Themes=.F. (canonico REPORT).
- **CommandButton auxiliar ao lado de Grid: NUNCA OMITIR .Picture**: Botoes standalone tipo cmd_4c_SelTudo (Selecionar Todos), cmd_4c_Apaga (Desmarcar/apaga), ou similares ao lado de grids de selecao TEM .Picture no SCX original (geral_marcar_26.jpg para Selecionar, cadastro_excluir_26.jpg para Desmarcar). Migracao frequentemente OMITE a linha .Picture inteira - botao renderiza como caixa vazia sem icone. SEMPRE copiar .Picture = gc_4c_CaminhoIcones + "nome.jpg" do original + aplicar padrao standalone (.Themes=.T. + .DisabledPicture). Heuristica: se WITH cmd_4c_* tem .ToolTipText = "Selecionar"/"Desmarcar"/"Marcar Todos"/"Limpar" e NAO tem .Picture, faltou copiar. Auto-fix: CorretorAutomatico #104. Bug em Formsigrecmc.prg (task052, 2026-07-01).
- **SigCdOpe eh single-column: NUNCA usar descrs/Descrs**: SigCdOpe tem Dopes (char(20)) que eh PK **E** descricao ao mesmo tempo â€” NAO existe coluna descrs/Descrs nessa tabela. Lookup FormBuscaAuxiliar para SigCdOpe deve chamar UMA UNICA mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o"). NUNCA adicionar segunda coluna mAddColuna("descrs", ...) â€” gera runtime "Variable 'DESCRS' is not found" em FormBuscaAuxiliar.ConfigurarGrid quando seta Columns(N).ControlSource. Mesma regra para SELECT: SELECT Dopes FROM SigCdOpe (NUNCA SELECT Dopes, Descrs FROM SigCdOpe). Referencia: FormSIGREADS.prg:1554, Formsigrevto.prg:900. Auto-fix: CorretorAutomatico #105. Bug em Formsigrecmc.prg:1848 e FormSigReCmp.prg:1767/1813 (task052/task045, 2026-07-01).
- **CommandButton icone-only (Caption="") NUNCA setar .Enabled=.F. em runtime**: Standalone CommandButton com Caption="" + .Picture NAO renderiza icone quando .Enabled=.F., INDEPENDENTE de .Themes=.T. ou .F. â€” botao vira retangulo vazio. Isso refina o Pattern #99 (que funciona apenas para botoes COM caption como cmd_4c_Graficos). Nunca setar .Enabled=.F./.Enabled=.T. em cmd_4c_* icone-only (SelTudo/Apaga tipicos) fora do bloco AddObject inicial â€” em vez disso: (a) NAO desabilitar (botao fica clickavel mas handler ja pode ser inocuo â€” SelTudo/Apaga so mexem em cursor cujo report vai ignorar), (b) desabilitar via check condicional dentro do handler PROCEDURE CmdXClick, OU (c) usar .Visible=.F. em vez de .Enabled=.F.. Auto-fix: CorretorAutomatico #106 (remove runtime .Enabled=.F./.T. em cmd_4c_* icone-only). Bug em Formsigrecmc.prg cmd_4c_SelTudo/cmd_4c_Apaga (task052, erro8.PNG, 2026-07-01) â€” desabilitar em TxtNmOperacaoKeyPress apagava icones apos usuario preencher Movimentacao.
- **Container de botoes sobre Grid: OBRIGATORIO BackStyle=1 OU posicionar fora da bbox do Grid**: Container filho de Form com CommandButtons dentro NAO pode ter BackStyle=0 (transparente) se seu retangulo (Top..Top+Height) sobrepoe o Grid irmao (grid.Top..grid.Top+grid.Height). Grid re-renderiza rows em scroll (redraw parcial da area) â€” sem fundo opaco por tras dos botoes, os botoes ficam "carimbados" repetidamente em cada frame novo ("ghost trails"). Fix: (a) Top >= grid.Top + grid.Height + margem (posicao FORA da bbox â€” preferido), OU (b) BackStyle = 1 + BackColor = RGB(255, 255, 255) se overlay for necessario. Auto-fix: CorretorAutomatico #107. Bug em FormBuscaAuxiliar.prg cnt_4c_Botoes (task052, Erro9.PNG, 2026-07-01) â€” Top=252 dentro do grid (grid bottom=306) + BackStyle=0 mostrava botoes Selecionar/Cancela stackados 3+ vezes ao scrollar a lista de contas.
- **OptionGroup.Buttons(N).Value NUNCA setar valor != 0**: Em VFP9, OptionGroup.Value eh INTEGER (1..N) indicando qual dos N botoes esta selecionado. OptionButton.Value (individual) eh BOOLEAN (0/1) â€” quem gerencia eh o OptionGroup. Se o codigo migrado setar Buttons(2).Value = 2, Buttons(3).Value = 3... VFP9 trata QUALQUER nao-zero como truthy â†’ TODOS os radio buttons aparecem marcados de uma vez, comportamento visual quebrado. NUNCA setar .Value = N (com N != 0) dentro de bloco WITH ...Buttons(N). Se quiser default selection, setar apenas OptionGroup.Value = indice (ex: OptionGroup.Value = 2 para 2o botao marcado). Auto-fix: CorretorAutomatico #108. Bug em Formsigregli.prg (task108, 2026-07-01) em 5 OptionGroups (Get_Tipo/TpOrdem/Get_Boleto/Get_Pedido/Opt_Ordem).
- **TornarControlesVisiveis: skip com LOOP DEVE recursar em containers hidden-por-default**: Metodo recursivo TornarControlesVisiveis seta Visible=.T. em sub-controles apos AddObject (que os cria Visible=.F. default). Quando ha lista de skip para containers que devem comecar ocultos (ex: IF INLIST(control.Name, "CNT_4C_ETIQUETAS", "CNT_4C_RELACAO") LOOP ENDIF), o LOOP pula TANTO setar Visible do container QUANTO recursar dentro dele. Resultado: container fica hidden corretamente MAS seus filhos tambem ficam Visible=.F. permanente. Quando logica posterior seta container.Visible=.T., container aparece VAZIO. Fix: dentro do IF de skip, ANTES do LOOP, recursar THIS.TornarControlesVisiveis(container) para tornar filhos visiveis sem tocar Visible do proprio container. Auto-fix: CorretorAutomatico #109. Bug em Formsigregli.prg (task108, 2026-07-01) â€” containers cnt_4c_Etiquetas/Relacao apareciam vazios ao selecionar Tipo de Impressao.
- **cnt_4c_Cabecalho Labels NUNCA usar AutoSize=.T.**: lbl_4c_Sombra/lbl_4c_Titulo em cnt_4c_Cabecalho DEVEM ter AutoSize = .F. (default) + Width = THIS.Width (Container Width, igual THISFORM.Width). Com AutoSize = .T., captions longos expandem a Label alem da area dos botoes (cmg_4c_Botoes Left=529, Graficos Left=460), deixando texto truncado visualmente atras dos botoes. AutoSize=.F. clipa naturalmente no boundary. Auto-fix: CorretorAutomatico #98. Bug em Formsigrecmc.prg (2026-06-25). Template canonico: FormSigReAac.prg:104-146.
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
- **REPORT Buttons(N).Picture/Caption: CANONICOS OBRIGATORIOS (incluindo Buttons(3)=EMAIL, NAO Excel)**: Os 4 botoes do cmg_4c_Botoes em forms REPORT DEVEM ter EXATAMENTE Picture+Caption: Buttons(1)=elatorio_video_26.jpg+"\<Visualizar"; Buttons(2)=elatorio_impressora_26.jpg+"\<Imprimir"; **Buttons(3)=geral_envelope_32.jpg+"\<Arquivos Email" (NAO Excel/relatorio_excel_26.jpg â€” o Name="DocExcel" do framework eh apenas legado, o botao visual eh envelope de email; ver docs/FRAMEWORK_class_codigo_fonte.txt linhas ~6644-6664)**; Buttons(4)=elatorio_sair_60.jpg+"\<Encerrar". ToolTipText do Buttons(3) DEVE ser "Arquivos Email" (nao "Exportar para Excel"). Path: SEMPRE gc_4c_CaminhoIcones + (NUNCA gc_4c_Icones). PROIBIDO inventar geral_visualizar_60.jpg, geral_imprimir_60.jpg, geral_fechar_60.jpg (NAO EXISTEM em vbmp/). Auto-fix: CorretorAutomatico #96 (icones inexistentes) + #100 (Buttons(3) Excel->Email). Bugs: Formsigatcrp.prg (2026-06-25) + FormSigReAac.prg (2026-06-26, task025). Template canonico: FormSigReAac.prg:179-249.
- **REPORT Buttons(N).FontName="Comic Sans MS" (NAO Tahoma)**: Os 4 Buttons(N) do cmg_4c_Botoes em REPORT DEVEM ter FontName="Comic Sans MS" + FontSize=8 (framework rmrelatorio.btnReport.CommandN). O SCX original NAO sobrescreve FontName, entao herdam Comic Sans MS do framework. Gerador frequentemente coloca "Tahoma" por default - quebra fidelidade visual. Buttons(1) costuma vir SEM FontName/FontSize declarados; explicitar nos 4 botoes eh mais robusto. Auto-fix: CorretorAutomatico #101 (Corrigir-ButtonsReportFontNameComicSans). Bug em FormSigReAac.prg (2026-06-26, task025).
- **REPORT Buttons(3) e Buttons(4) DEVEM ter WordWrap=.T.**: O framework rmrelatorio.btnReport.Command3.WordWrap = .T. (linha 6653) e Command4.WordWrap = .T. (linha 6673). Sem WordWrap=.T., captions longos como "Arquivos Email" (14 chars, Buttons(3)) sao TRUNCADOS porque nao cabem em 1 linha dentro de 65-75px com Comic Sans MS bold-italic 8. WordWrap permite quebrar em "Arquivos"/"Email" (2 linhas). Buttons(1)/(2) MANTEM WordWrap=.F. (default, framework explicitamente set para Command1; Command2 nao declara mas default eh .F.). Auto-fix: CorretorAutomatico #102 (Corrigir-ButtonsReportWordWrap). Bug em FormSigReAac.prg (2026-06-26, task025, imagem erro4.PNG).
- **REPORT btnReport geometria: SCX overrides PRECEDEM defaults do framework**: Os defaults do framework btnReport sao Width=273, Left=529, Height=80; Buttons Width=65, Height=70, Lefts=5/71/137/203 (inc 66). PORÃ‰M o SCX original PODE sobrescrever essa geometria â€” quando sobrescreve, USAR os valores do SCX, NAO os defaults. Antes de aplicar defaults, LER a secao "PROPRIEDADES DE: <FORM>" em 	asks/<task>/<form>_form_codigo_fonte.txt e procurar overrides de tnReport.Width/Left/Height/Top e tnReport.Visualiza/Imprime/DocExcel/sair.Top/Left/Width/Height. Ex: SigReAac.scx tem tnReport.Width=310, Left=494, Height=85 + CommandN.Width=75, Height=75 com Lefts=5/80/155/230 (inc 75). Migrar com defaults ignorando o SCX quebra Pilar 1 (UX pixel-perfect). Defaults so aplicam quando SCX NAO sobrescreve. NAO automatizavel (precisa ler arquivo da task). Bug em FormSigReAac.prg (2026-06-26, task025).
- **REPORT OBRIGATORIO ter ConfigurarCabecalho() chamado ANTES de CriarBotoesRelatorio()**: TODO form REPORT (que herda FormBase + tem cmg_4c_Botoes) DEVE ter PROCEDURE ConfigurarCabecalho que cria cnt_4c_Cabecalho (Container Top=0, Left=0, Width=THIS.Width, Height=80, BackStyle=1, BackColor=RGB(100,100,100), BorderWidth=0) com 2 Labels sobrepostos: lbl_4c_Sombra (Top=22, Left=22, ForeColor preto, FontSize=14) + lbl_4c_Titulo (Top=20, Left=20, ForeColor branco, FontSize=14). Caption = THISFORM.Caption. A chamada THIS.ConfigurarCabecalho() DEVE vir ANTES de THIS.CriarBotoesRelatorio() em InicializarForm() (Z-order: cabecalho atras, botoes na frente). Sem isso o form abre sem a faixa cinza superior caracteristica e os 4 botoes ficam "flutuando" no canto direito. Auto-fix: CorretorAutomatico #97. Bug observado em Formsigatcrp.prg (2026-06-25). Template canonico: FormSigReAac.prg:104-146.
- **cnt_4c_Cabecalho Labels NUNCA usar AutoSize=.T.**: lbl_4c_Sombra e lbl_4c_Titulo em cnt_4c_Cabecalho DEVEM ter AutoSize = .F. (default) + Width = THIS.Width (ou explicito limitado ao espaco livre dos botoes). Com AutoSize = .T., captions longos (ex: "Relatorio de Clientes que Mais/Menos/Nao Compram em Valores e Quantidades") expandem a Label alem da area dos botoes (cmg_4c_Botoes Left=529), deixando texto visualmente truncado atras dos botoes. AutoSize=.F. clipa naturalmente. Auto-fix: CorretorAutomatico #98. Bug observado em Formsigrecmc.prg (2026-06-25). Captions muito longas tambem precisam encurtar manualmente.
- **Standalone CommandButton com Picture: usar Themes=.T. + DisabledPicture**: CommandButton declarado via THIS.AddObject("cmd_4c_X","CommandButton") (FORA de CommandGroup) com .Picture definido DEVE usar .Themes = .T. (NAO .F.) E definir .DisabledPicture (mesma imagem do .Picture). Sem isso, com .Themes = .F. + .Enabled = .F., o icone NAO renderiza (botao aparece so com caption). Buttons(N) DENTRO de CommandGroup MANTEM .Themes = .F. (config canonica REPORT). Aplica APENAS a standalone CommandButtons. Auto-fix: CorretorAutomatico #99. Bug observado em Formsigrecmc.prg cmd_4c_Graficos (2026-06-25).
- **REPORT Buttons(N).Picture nomes corrompidos/legados**: O gerador AS VEZES extrai mal o filename de imagens\<nome>.jpg do framework dump, gerando nomes ERRADOS: "ideo.jpg" (perdeu "v" de "video"), "otao_encerrar.jpg" (perdeu "b" de "botao"), "impressora.jpg"/"excel.jpg"/"video.jpg"/"botao_encerrar.jpg" (nomes "bare" sem sufixo _26/_60 que NAO EXISTEM em vbmp/). Mapear SEMPRE para canonicos: ideo.jpg/ideo.jpg->elatorio_video_26.jpg; impressora.jpg->elatorio_impressora_26.jpg; excel.jpg->geral_envelope_32.jpg (botao 3 = EMAIL); otao_encerrar.jpg/otao_encerrar.jpg->elatorio_sair_60.jpg. Auto-fix: CorretorAutomatico #96 estendido. Bug em FormSIGREADS.prg (2026-06-26, task026).
- **REPORT grids (grd_4c_*): HeaderHeight=0 + RowHeight=18 + FontName="Tahoma" canonicos**: Grids em forms REPORT (frmrelatorio) seguem padrao HeaderHeight=0 (header escondido â€” Label externa serve de pseudo-header tipo "Tipo de Operacao :"), RowHeight=18 (nao 16) e FontName="Tahoma" (nao "Verdana"). Sem HeaderHeight=0, "Descrs" e similares aparecem como header de grid, destoando do layout do framework. Auto-fix: CorretorAutomatico #103 (Corrigir-GridReportCanonico). Bug em FormSIGREADS.prg (2026-06-26, task026).
- **ANTES DE MIGRAR: checar SCX mais novo em correcoes/**: O SCX em 	asks/task<NNN>/ pode estar DESATUALIZADO. ANTES de iniciar o pipeline, verificar se existe versao mais recente em C:\4c\origem\correcoes\<basename>.SCX (forma de teste/producao mais recente) ou em C:\4install\FortyusMC*/Fortyus/<basename>.SCX. Comparar timestamp e tamanho com o SCX da task. Se houver mais novo, COPIAR .SCX + .SCT para task e re-extrair via DO C:\4c\projeto\app\utils\ExtractSCXCode.prg WITH 'tasks\task<NNN>\<basename>.SCX'. Caso contrario, form migrado pode ficar incompleto (faltando controles/funcionalidade adicionados em versoes posteriores). Bug em task026/SIGREADS: SCX da task (2020, 4957 bytes, 35 objetos) vs SCX em correcoes/ (2024, 5829 bytes, 41 objetos com Label2/Grdgrupo/Fwbtnp1/Fwbtnp2/optTipoRel 5 botoes).
- **fwprogressbar NAO PORTADA â€” usar stub em classes/fwprogressbar.prg**: REPORT forms que usam CREATEOBJECT("fwprogressbar", cTitulo, nTotal) para barra de progresso (padrao Framework legado, usado em MCursor/Processamento/filtros pesados) precisam do stub em C:\4c\projeto\app\classes\fwprogressbar.prg (Form base com Init/Show/Update/Complete + labels Titulo/SubTitulo/lblPercentage + shpThermBar) registrado em config.prg via CarregarSeExistir(gcCaminhoClasses + "fwprogressbar.prg"). Sem isso, CREATEOBJECT lanca "Class 'fwprogressbar' is not found", CATCH silencioso em InicializarForm engole erro, Init() retorna .F., CREATEOBJECT("FormXxx") retorna .F. (Logical) -> "VARTYPE retornou: L" no menu. Bug em Formsigrepes.prg (2026-07-02, Erro17): 15 chamadas a fwprogressbar sem classe definida.
- **KeyPress handler: LPARAMETERS + guard Enter(13)/Tab(9)/F4(115) obrigatorios**: Handler bindado a KeyPress via BINDEVENT DEVE ter LPARAMETERS na primeira linha do corpo: LPARAMETERS par_nKeyCode, par_nShiftAltCtrl. Sem LPARAMETERS: runtime "No PARAMETER statement is found" no primeiro keystroke (bug engolido se CATCH nao verboso). Handlers de LOOKUP (que abrem FormBuscaAuxiliar) DEVEM ter guard IMEDIATAMENTE apos LPARAMETERS: IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115 / RETURN / ENDIF. Sem guard, handler roda a CADA tecla digitada, abrindo picker modal no primeiro char digitado â€” user nao consegue terminar de digitar codigo. Handlers de checkbox mutual-exclusion (chk_4c_*) NAO precisam do guard (rodam em qualquer keypress mas sao inocuous). Padrao canonico: Formsigatcrp.prg:2614-2624 e Formsigrepes.prg:6488-6497. Auto-fix: CorretorAutomatico #30 estendido para PROCEDURE sem parens + #112 (guard 13/9/115 injetado em Validar* com FormBuscaAuxiliar). Bug em Formsigrepes.prg (2026-07-02, Erro18): 32 handlers Validar* sem LPARAMETERS + 24 handlers de lookup sem guard.
- **FormBuscaAuxiliar manual-API (CREATEOBJECT vazio + setters) NAO POPULA cursor**: Setar 	his_cTabela/	his_cCampoBusca/	his_cValorBusca/	his_cCursorDestino em objeto criado com CREATEOBJECT("FormBuscaAuxiliar") (SEM params) + mAddColuna(...) + .Show() NAO dispara SQLEXEC internamente. ConfigurarGrid() executa IF !USED(THIS.this_cCursorDestino) RETURN e picker abre com grid VAZIO (user ve caixa cinza sem dados). Alem disso, propriedades como 	his_cFiltro/	his_cCursorOrigem/	his_nMaxRegistros que gerador as vezes seta NAO EXISTEM em FormBuscaAuxiliar â€” sao adhoc-dinamicas sem efeito. Duas alternativas CORRETAS: (a) Init com params completos: CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "Tabela", "cursor_4c_Busca", "Campo", cVal, "Titulo", .T., .T., cFiltro) â€” Init dispara SELECT exato + fallback LIKE; (b) Pre-popular cursor via SQLEXEC(gnConnHandle, "SELECT ...", "cursor_4c_Busca") ANTES de .Show(). Helper reutilizavel AbrirLookup(txtCod, txtDesc, tabela, campoCod, campoDesc, campoBusca, valor, cursor, titulo, filtro, forcarPicker) â€” implementacao canonica em Formsigrepes.prg:3318-3385. Auto-fix: nao automavel (refatoracao estrutural). Bug em Formsigrepes.prg (2026-07-02, Erro18): 13 handlers Validar* com manual-API abriam picker vazio.
- **REPORT Buttons(N).Left + Width DEVE caber em CommandGroup.Width**: Antes de aplicar Lefts do SCX ao cmg_4c_Botoes, VALIDAR: Buttons(4).Left + Buttons(4).Width <= cmg_4c_Botoes.Width. Se transbordar, Encerrar renderiza cortado (parcialmente visivel). SCX legado frequentemente tem geometria de SigReAac copiada (Buttons Width=75, Lefts=5/80/155/230, inc 75) mas Formsigrepes-like tem CommandGroup Width=273 + Buttons Width=65 â€” os Lefts=5/80/155/230 ends 295 > 273 -> overflow 22px. Fallback canonico para Width=273 + Buttons Width=65: **Lefts=5/72/139/206 (gap 2, ends 271)**. Framework defaults (rule 3205) sao Lefts=5/71/137/203 (inc 66, gap 1, ends 268). SCX overrides com incrementos > 66 quando Buttons Width=65 devem ser validados/recalculados. Auto-fix: CorretorAutomatico #113 valida overflow em cmg_4c_Botoes e recalcula Lefts. Bug em Formsigrepes.prg (2026-07-02, Erro19) â€” Encerrar aparecia cortado.
- **MsgAviso("...encontrada") antes de THIS.AbrirBusca<X>() eh REDUNDANTE e QUEBRA UX**: Em handlers Validar<Campo> que fazem SELECT TOP 1 exato e caem no ELSE quando nao acham, PROIBIDO gerar MsgAviso("Empresa nao encontrada") + .Value = "" + THIS.AbrirBusca<X>() em sequencia. User ve dialog blocking "nao encontrada" -> clica OK -> picker abre -> mas o clear-field ja apagou o valor digitado, entao o picker abre SEM prefix para LIKE. Padrao CORRETO: apenas THIS.AbrirBusca<X>() no ELSE â€” o picker abrindo direto E JA o feedback visual de "nao achou match exato", e o valor digitado eh preservado para o SELECT LIKE prefix dentro do picker. Exemplo ERRADO: MsgAviso("Vendedor nao encontrado", "Vendedor") / .Value="" / THIS.AbrirBuscaVended(). Exemplo CORRETO: apenas THIS.AbrirBuscaVended(). Auto-fix: CorretorAutomatico #114. Bug em FormSIGREADS.prg (2026-07-02, Erro20) â€” 4 handlers (Empresa/Vendedor/Operacao/Moeda) + sweep global de 49 forms com mesmo anti-padrao.
- **SigCdGcr tem coluna descrs (com 'r'), NAO descs â€” consultar schema.sql sempre**: Tabelas com nomes parecidos podem ter colunas de descricao diferentes. SigCdGcr (Grupo Estoque/Contabil) tem descrs (indice linha 21685). Suas irmas SigCdGpr (Grande Grupo), SigCdLin (Linha), SigCdCol (Colecao) tem descs. NUNCA assumir nome de coluna por analogia entre tabelas â€” SEMPRE consultar docs/schema.sql para nomes reais. SigCdGcr aparece nos lookups de "Grupo de Estoque" e "Grupo Contabil" â€” SELECT descs FROM SigCdGcr gera "Nome de coluna 'descs' invalido" em runtime. Padrao CORRETO: SELECT codigos, descrs FROM SigCdGcr. mAddColuna do FormBuscaAuxiliar sobre SigCdGcr tambem: mAddColuna("descrs", ...). Auto-fix: CorretorAutomatico #115. Bug em FormSIGREAEG/FormSIGREEGG/FormSigReCsp/Formsigreegp (2026-07-02, Erro21) â€” 4 forms, ~14 refs. Regra generica: em toda familia Sig*Cd* (SigCdEmp/Cli/Pro/Grp/Gpr/Gcr/Lin/Col/Ope/Fip/etc.), NUNCA colar column-name de outra tabela â€” verificar schema.sql explicitamente.
- **BtnVisualizarClick/BtnImprimirClick DEVEM ter TRY/CATCH + FULLPATH() ao redor de REPORT FORM**: TODO handler que executa REPORT FORM ... PREVIEW/TO PRINTER deve envolver o corpo em TRY ... CATCH TO loc_oErro / MostrarErro("Erro ao visualizar/imprimir relat" + CHR(243) + "rio:" + CHR(13) + "Erro: " + loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro") / ENDTRY e normalizar o path do FRX via loc_cArquivoFRX = FULLPATH(gc_4c_CaminhoReports + "arquivo.frx") (elimina ..\ que pode causar issues em modos especificos). Sem TRY/CATCH, qualquer erro dentro do REPORT FORM propaga ate o handler generico de menu.prg AbrirRelXxx com mensagem generica "Erro ao abrir Relatorio de X" â€” dificultando debug. Contexto: FRX legados frequentemente referenciam variaveis globais tipo gcLogoRel/gcCabRel â€” se o path da imagem apontar para arquivo inexistente (ex: logo.bmp ausente em vbmp/) e o Print When 
ot empty(gcLogoRel) retornar .T., REPORT FORM estoura "Invalid path or file name" em runtime. TRY/CATCH garante mensagem descritiva; FULLPATH() garante path canonico. Padrao canonico: Formsigrecgr.prg:564-611 (BO GerarRelatorio com TRY/CATCH) e FormSigReCmp.prg:1486-1512 (BtnVisualizarClick com TRY/CATCH). Config-level: config.prg DEVE ter IF NOT FILE(gc_4c_LogoRelatorio) / gc_4c_LogoRelatorio = "" / ENDIF apos setar o path (guard aplicado 2026-07-03, Erro22 â€” sem guard, gcLogoRel propagava path invalido e QUALQUER FRX com Picture=gcLogoRel estourava em runtime). NAO automavel (refatoracao estrutural do handler). Bug em FormRelPlanoContas.prg BtnVisualizarClick (2026-07-03, Erro22) â€” logo.bmp ausente + falta de TRY/CATCH mascarou o erro real.
- **INDEX ON composto (A+B) com SEEK parcial (so A) FALHA 100% com SET EXACT ON**: config.prg:193 seta SET EXACT ON globalmente â€” SEEK exige match da CHAVE INTEIRA do indice, nao mais prefix. Se cursor tem INDEX ON A + B TAG X (chave concatenada, ex: 20 chars) e o codigo faz SEEK(loc_valorA, cursor, "X") passando so A (ex: 10 chars), SEEK retorna .F. SEMPRE â€” IF SEEK() cai silenciosamente e a expansao/scan pula toda a subarvore sem exception. REGRA: se TODOS os SEEK(..., cursor, "X") do mesmo TAG usam apenas o primeiro campo do compound, trocar o INDEX para single-column (INDEX ON A TAG X). Se precisa manter compound (uniqueness, multi-key seek), OU pad-completar a chave do SEEK ate o tamanho da chave do indice OU SET EXACT OFF local (salvar/restaurar). Auditoria cross-file: listar INDEX ON (\w+)\s*\+\s*(\w+) TAG (\w+) vs SEEK\(.*,\s*<cursor>,\s*"\3"\) â€” se todos os SEEK usam so \1, eh bug. Bug em PlanoContasBO.prg + SigRePlcBO.prg (2026-07-03, Erro23) â€” relatorio Plano de Contas perdia nivel 5 (contas analiticas / clientes SigCdCli) porque INDEX ON Grupos + IClis TAG Grupos + SEEK(loc_cLsGrupo, "crSigCdCli", "Grupos") nunca casava; fix trocou por INDEX ON Grupos TAG Grupos. NAO automavel (detector precisa correlacionar INDEX + SEEK do mesmo TAG dentro do mesmo cursor no mesmo arquivo).

## Integracao
- Adicionar SET PROCEDURE para BO e Form em config.prg
- Adicionar item no menu (menu.prg) no popup **popRelatorios** (tipo REPORT)
  - DEFINE BAR N OF popRelatorios PROMPT "..." MESSAGE "..."
  - ON SELECTION BAR N OF popRelatorios DO AbrirFormSIGPRCCR
  - PROCEDURE AbrirFormSIGPRCCR() no final do menu.prg
- Deletar *.fxp antes de testar: del /s /q C:\4c\projeto\app\*.fxp

**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir `SET SAFETY OFF` e `SET RESOURCE OFF` no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.

Comecar agora. Ler relatoriobase.prg primeiro, depois o codigo fonte original.
