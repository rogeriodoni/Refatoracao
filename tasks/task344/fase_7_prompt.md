# MIGRACAO MULTI-FASE: FASE 7/8

## ?? FASE ATUAL: Form - Eventos Principais

Implementar eventos principais dos botï¿½es

## FASE 7/8: FORM - EVENTOS PRINCIPAIS

### OBJETIVO
Adicionar eventos principais:
- BtnIncluirClick()
- BtnAlterarClick()
- BtnVisualizarClick()
- BtnExcluirClick()

### COMO FAZER
1. LER o arquivo existente: C:\4c\projeto\app\forms\cadastros\Formacu.prg
2. ADICIONAR os 4 eventos principais
3. USAR Edit tool para modificar arquivo existente

### ENTREGA ESPERADA
Arquivo ATUALIZADO: C:\4c\projeto\app\forms\cadastros\Formacu.prg

---

## ?? CONTEXTO DA MIGRAï¿½ï¿½O

# Tarefa: Migrar Formacu

Migre o formulario sigcdacu para o novo sistema seguindo todas as regras do CLAUDE.md.

## Arquivos de Referencia OBRIGATORIOS
1. **CLAUDE.md** - Ler secao dos 3 PILARES antes de comecar
2. **docs/FORMCOR_LICOES_APRENDIDAS.md** - Ler COMPLETAMENTE para nao repetir os 5 problemas
3. **docs/migration_guide.md** - Checklist geral
4. **tasks/task344/sigcdacu_form_codigo_fonte.txt** - Codigo fonte original
5. **tasks/task344/mapeamento.json** - Mapeamento de objetos (se disponivel)
6. **tasks/task344/comportamento.json** - Analise comportamental de metodos/eventos (se disponivel)

## Arquivos a Criar
1. **C:\4c\projeto\app\classes\acuBO.prg**
   - Herda de BusinessBase
   - Propriedades this_* para todos os campos da tabela
   - **Metodos OBRIGATORIOS** (nomes EXATOS do BusinessBase):
     - Inserir() - INSERT (PROTECTED)
     - Atualizar() - UPDATE (PROTECTED)
     - ExecutarExclusao() - DELETE (PROTECTED) **<- NAO usar "Excluir()"!**
     - Buscar() - SELECT (PUBLIC)
     - CarregarPorCodigo() - SELECT por PK (PUBLIC)
   - ObterChavePrimaria() para auditoria
   - **CRITICO - Init()**: Usar nomes CORRETOS das propriedades herdadas:
     `oxpro
     PROCEDURE Init()
         DODEFAULT()
         THIS.this_cTabela = "NomeTabela"      && CORRETO (NAO this_cNomeTabela)
         THIS.this_cCampoChave = "campo_pk"    && CORRETO (NAO this_cChavePrimaria)
         RETURN .T.
     ENDPROC
     `
   - **CarregarDoCursor**: SEMPRE usar SELECT (par_cAliasCursor) ANTES de acessar campos
     `oxpro
     PROCEDURE CarregarDoCursor(par_cAliasCursor)
         IF USED(par_cAliasCursor)
             SELECT (par_cAliasCursor)           && OBRIGATORIO
             THIS.this_campo = TratarNulo(campo, "C")  && Sem alias
             RETURN .T.
         ENDIF
         RETURN .F.
     ENDPROC
     `
   - **NUNCA usar**: (par_cAliasCursor).campo -> ERRO de sintaxe!

2. **C:\4c\projeto\app\forms\cadastros\Formacu.prg**
   - Herda de FormBase
   - PageFrame com Top=-29 e Tabs=.F.
   - Page1: Lista (Grid)
   - Page2: Dados (Campos)
   - Lookups: TODOS os campos que tinham no original (F4/DblClick)
   - Validacoes: copiar do original

   **Metodos OBRIGATORIOS do Form** (NUNCA omitir):
     -- **Base/Setup**:
       - Init() - Apenas RETURN DODEFAULT(), sem logica complexa
       - InicializarForm() - Configura estrutura completa (chamado pelo FormBase)
       - ConfigurarPageFrame() - Cria PageFrame com 2 Pages
       - ConfigurarPaginaLista() - Page1 (Grid + Botoes CRUD)
       - ConfigurarPaginaDados() - Page2 (Campos + Botoes Salvar/Cancelar)

     -- **Navegacao (CRITICOS)**:
       - **CarregarLista()** - OBRIGATORIO - Carrega dados no Grid da Page1
       - **AlternarPagina(par_nPagina)** - OBRIGATORIO - Alterna entre Page1 (1) e Page2 (2)

     -- **Data Binding**:
       - FormParaBO() - Transfere Form -> BO (chamado antes de Salvar)
       - BOParaForm() - Transfere BO -> Form (chamado apos Carregar)

     -- **Eventos CRUD (Page1)**:
       - BtnIncluirClick() - Incluir novo registro
       - BtnAlterarClick() - Alterar registro selecionado
       - BtnVisualizarClick() - Visualizar registro (somente leitura)
       - BtnExcluirClick() - Excluir registro selecionado
       - BtnBuscarClick() - Buscar/filtrar registros
       - BtnEncerrarClick() - Fechar formulario

     -- **Eventos Page2**:
       - BtnSalvarClick() - Salvar alteracoes (Confirmar)
       - BtnCancelarClick() - Cancelar e voltar para lista

     -- **Auxiliares (Recomendados)**:
       - HabilitarCampos(par_lHabilitar) - Habilita/desabilita campos
       - LimparCampos() - Limpa valores dos campos
       - AjustarBotoesPorModo() - Ajusta botoes por modo (INCLUIR/ALTERAR/VISUALIZAR)

   **IMPORTANTE - IMPLEMENTACAO COMPLETA OBRIGATORIA**:
   - TODOS os metodos acima devem ser implementados COM LOGICA FUNCIONAL
   - NAO criar stubs/placeholders (ex: RETURN .T. vazio)
   - NAO usar MsgAviso("...sera implementado...") como placeholder - isso eh um STUB DISFARï¿½ADO
   - NAO deixar comentarios "TODO" ou "Implementar depois"
   - CADA metodo deve executar sua funcao completa NA PRIMEIRA VEZ
   - Botoes de relatorio/impressao/Excel DEVEM chamar ProcessaSaldo/ProcessaHist com parametro tipo ('I','V','E')
   - Botoes de operacao (Alterar, Excluir, Conciliar, Auditar) DEVEM ter logica real baseada no legado

   **Exemplos de implementacao COMPLETA obrigatoria**:

   `oxpro
   *-- CORRETO - CarregarLista() COMPLETO:
   PROTECTED PROCEDURE CarregarLista()
       LOCAL loc_lResultado, loc_oGrid
       loc_lResultado = .F.

       TRY
           IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
               RETURN .T.
           ENDIF

           loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

           IF !THIS.this_oBusinessObject.Buscar("")
               loc_lResultado = .F.
           ELSE
               loc_oGrid.RecordSource = "cursor_4c_Dados"
               loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.campo1"
               loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.campo2"
               loc_oGrid.Column1.Width = 100
               loc_oGrid.Column2.Width = 300
               loc_lResultado = .T.
           ENDIF
       CATCH TO loException
           MostrarErro(loException, "CarregarLista")
           loc_lResultado = .F.
       ENDTRY

       RETURN loc_lResultado
   ENDPROC

   *-- CORRETO - AlternarPagina() COMPLETO:
   PROTECTED PROCEDURE AlternarPagina(par_nPagina)
       IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
           RETURN .F.
       ENDIF

       THIS.pgf_4c_Paginas.ActivePage = par_nPagina

       IF par_nPagina = 1
           THIS.CarregarLista()
       ENDIF

       RETURN .T.
   ENDPROC

   *-- ERRADO - Stub/Placeholder (NAO ACEITAR):
   PROTECTED PROCEDURE CarregarLista()
       RETURN .T.  && Vazio - NAO funciona!
   ENDPROC

   *-- ERRADO - Comentario TODO (NAO ACEITAR):
   PROTECTED PROCEDURE AlternarPagina(par_nPagina)
       * TODO: Implementar depois  && NAO aceitavel!
       RETURN .T.
   ENDPROC
   `

   **NUNCA omitir ou deixar incompleto CarregarLista() ou AlternarPagina()** - sao CRITICOS!

## Analise Comportamental (comportamento.json)

Se o arquivo **comportamento.json** estiver disponivel no contexto, ele contem a analise profunda dos
metodos e eventos do codigo original (SECAO 3). REGRAS OBRIGATORIAS:

1. **TODA validacao** listada em `metodos[].analise.temValidacao=true` DEVE ser implementada no novo sistema
2. **TODAS as queries SQL** devem usar APENAS colunas listadas em `sqlQueries[].colunas` - NAO inventar colunas
3. Se `validacaoSchema.colunasInvalidas` tiver itens, essas colunas NAO EXISTEM na tabela - NAO usar
4. **TODAS as funcoes externas** listadas em `resumo.funcoesExternas` devem ser integradas ou substituidas
5. **TODOS os controles** referenciados em `metodos[].analise.controlesReferenciados` devem existir no form
6. Metodos com `analise.temLookup=true` DEVEM ter lookup implementado (F4/DblClick)
7. Metodos com `analise.temNavegacao=true` controlam visibilidade/habilitacao - implementar equivalente
8. O campo `codigoOriginal` mostra a logica exata do legado - REPRODUZIR a logica (com nova nomenclatura)

## 3 PILARES INEGOCIAVEIS
1. **UX**: Manter o mais proximo possivel (Width, Height, BackColor, FontName, FontSize EXATOS)
2. **Banco**: Identico (nao alterar nomes de tabelas/colunas)
3. **Codigo**: OBRIGATORIAMENTE diferente (nova arquitetura, novos nomes)

## REGRA CRITICA: NUNCA usar RETURN dentro de TRY/CATCH

**ERRO FATAL**: "RETURN/RETRY statement not allowed in TRY/CATCH"

`oxpro
*-- ERRADO - NUNCA FAZER:
PROTECTED PROCEDURE CarregarLista()
    TRY
        IF !THIS.this_oBusinessObject.Buscar("")
            RETURN .F.  && ERRO CRITICO!
        ENDIF
        RETURN .T.  && ERRO CRITICO!
    CATCH
        RETURN .F.  && ERRO CRITICO!
    ENDTRY
ENDPROC

*-- CORRETO - SEMPRE FAZER:
PROTECTED PROCEDURE CarregarLista()
    LOCAL loc_lResultado
    loc_lResultado = .F.

    TRY
        IF !THIS.this_oBusinessObject.Buscar("")
            loc_lResultado = .F.  && Atribuir variavel
        ELSE
            loc_lResultado = .T.  && Atribuir variavel
        ENDIF
    CATCH TO loException
        MostrarErro("Erro: " + loException.Message, "Erro")
        loc_lResultado = .F.  && Atribuir variavel
    ENDTRY

    RETURN loc_lResultado  && RETURN apenas FORA do TRY/CATCH
ENDPROC
`

**CHECKLIST**: Declarar LOCAL loc_lResultado, inicializar .F., substituir TODOS os RETURNs por atribuicoes, RETURN apenas FORA.

## REGRA CRITICA: Strings SQL longas DEVEM ser quebradas com continuation

VFP9 tem limite de ~8000 chars por linha logica. Strings SQL com muitos campos DEVEM ser quebradas com `+;`:

`oxpro
*-- ERRADO - linha unica muito longa:
loc_cSQL = "SELECT a.Campo1, a.Campo2, a.Campo3, a.Campo4, a.Campo5, a.Campo6, a.Campo7, a.Campo8, a.Campo9, a.Campo10 FROM Tabela a WHERE a.Chave = " + EscaparSQL(loc_cChave)

*-- CORRETO - quebrar a cada 3-4 campos:
loc_cSQL = "SELECT a.Campo1, a.Campo2, a.Campo3, a.Campo4," + ;
    " a.Campo5, a.Campo6, a.Campo7, a.Campo8," + ;
    " a.Campo9, a.Campo10 FROM Tabela a" + ;
    " WHERE a.Chave = " + EscaparSQL(loc_cChave)
`

## 23 PROBLEMAS CRITICOS A NAO REPETIR (task006/task014/task016/task017/task018)

### Problema 1: Botoes Sem Icones e Captions
**TODOS os botoes DEVEM ter estas 3 propriedades:**
`oxpro
*-- Botao Incluir (EXEMPLO COMPLETO - COPIAR)
loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
    .Caption = "Incluir"                               && Caption SEM tecla atalho
    .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"  && Icone (OBRIGATORIO)
    .PicturePosition = 13                              && Icone ACIMA do texto
    .Top = 5
    .Left = 5
    .Width = 75
    .Height = 75
    .BackColor = RGB(255, 255, 255)
    .ForeColor = RGB(90, 90, 90)
    .Themes = .F.
    .SpecialEffect = 0
ENDWITH
`
**Aplicar em TODOS os 8 botoes**: Incluir, Alterar, Excluir, Consultar, Pesquisar, Sair, Salvar, Cancelar

### Problema 2: Grid Perde Dados Apos Consultar
**BtnCancelarClick() DEVE chamar CarregarLista():**
`oxpro
PROTECTED PROCEDURE BtnCancelarClick()
    THIS.AlternarPagina(1)
    THIS.this_cModoAtual = "LISTA"
    THIS.CarregarLista()  && OBRIGATORIO: recarrega dados + formatacao
ENDPROC
`

### Problema 3: Erro ao Fechar Form - "loForm is not an object"
**PADRAO CORRETO para AbrirForm() no menu.prg (COPIAR EXATAMENTE):**
`oxpro
PROCEDURE AbrirFormacu()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("Formacu")

        IF VARTYPE(loForm) = "O"                  && VARTYPE, NAO ISNULL
            loForm.Show()                         && SEM parametro
            *-- NAO chamar loForm.Release() - FormBase cuida disso
        ELSE
            MostrarErro("Erro ao criar formulario Formacu", "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario Formacu:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC
`
**NUNCA usar**:
- loForm.Show(1) (parametro modal)
- loForm.Release() apos Show()
- ISNULL(loForm) ao inves de VARTYPE(loForm) = "O"

### Problema 4: Erro ao Salvar - "no parameter statement is found"
**Salvar() NUNCA recebe parametro:**
`oxpro
*-- ERRADO: Salvar(loc_lNovoRegistro)
IF THIS.this_oBusinessObject.Salvar(loc_lNovoRegistro)

*-- CORRETO: Salvar() SEM parametro
IF THIS.this_oBusinessObject.Salvar()
    MsgSucesso("Registro salvo com sucesso!")
    THIS.AlternarPagina(1)
    THIS.CarregarLista()
ENDIF
`
**Por que?** BusinessBase.Salvar() ja sabe se e INSERT ou UPDATE atraves da propriedade interna 	his_lNovoRegistro.

### Problema 5: Labels com Cores Incorretas
**SEMPRE copiar TODAS as propriedades visuais do original:**
`oxpro
WITH loc_oPagina.lbl_4c_Codigo
    .Caption = "C" + CHR(243) + "digo :"
    .Top = 140
    .Left = 369
    .Width = 45
    .Height = 17
    .BackColor = RGB(90, 90, 90)      && COPIAR do original
    .ForeColor = RGB(255, 255, 255)   && COPIAR do original
    .FontName = "Tahoma"               && COPIAR do original
    .FontSize = 8                      && COPIAR do original
    .FontBold = .F.
    .Alignment = 1  && Right
ENDWITH
`

### Problemas 6-11: Ja Documentados
6. Grid perde cabecalhos -> Reconfigurar Header1.Caption APOS RecordSource em CarregarGrade/CarregarLista (OBRIGATORIO! Sem isso, colunas ficam sem titulo)
7. Botoes cortados -> Se PageFrame.Top=-29, compensar +29px em TODOS os controles de topo
8. "Connection invalid" -> Verificar gb_4c_ValidandoUI antes de CarregarLista()
9. Mapeamento incorreto -> Criar hierarquia correta no JSON
10. Duplicacao de raiz -> Ja corrigido no ComparadorUI.prg
11. Metodos auxiliares -> SEMPRE implementar TornarControlesVisiveis() + FormatarGridLista() no form

## IMPORTANTE: Init() - NAO Chamar InicializarForm() Duas Vezes!

**PADRAO CORRETO para FormXxx.Init()**:
`oxpro
PROCEDURE Init()
    *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
    *-- NAO chamar THIS.InicializarForm() novamente aqui!
    RETURN DODEFAULT()
ENDPROC
`

**NUNCA fazer**:
`oxpro
PROCEDURE Init()
    DODEFAULT()
    THIS.InicializarForm()  && ERRO: Chamada duplicada!
    RETURN .T.
ENDPROC
`

**Por que?** FormBase.Init() ja chama THIS.InicializarForm(). Se chamar novamente, AddObject() tenta criar objetos que ja existem -> erro "A member object with this name already exists".

### Problema 12: ConfigurarPaginaDados() sem ENDPROC
**CRITICO**: Todo PROCEDURE deve terminar com ENDPROC e chamar TornarControlesVisiveis():
`oxpro
*-- ERRADO - Page2 fica VAZIA:
PROTECTED PROCEDURE ConfigurarPaginaDados()
    LOCAL loc_oPagina
    loc_oPagina = THIS.pgf_4c_Paginas.Page2

    loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
    * ... mais campos ...

    * NOTA: campos criados
*-- FALTA ENDPROC! -> Codigo nao executa corretamente

*-- CORRETO - SEMPRE terminar com TornarControlesVisiveis + ENDPROC:
PROTECTED PROCEDURE ConfigurarPaginaDados()
    LOCAL loc_oPagina
    loc_oPagina = THIS.pgf_4c_Paginas.Page2

    loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
    * ... mais campos ...

    * OBRIGATORIO: Tornar controles visiveis
    THIS.TornarControlesVisiveis(loc_oPagina)
ENDPROC  && <- NUNCA ESQUECER!
`

### Problema 13: CarregarPorId vs CarregarPorCodigo
**CRITICO**: O metodo correto no BO e CarregarPorCodigo, NAO CarregarPorId:
`oxpro
*-- ERRADO - Metodo nao existe:
IF THIS.this_oBusinessObject.CarregarPorId(loc_cCodigo)  && ERRO!

*-- CORRETO - Usar nome do metodo do BO:
IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
`
**Verificar**: Antes de usar, confirmar o nome exato do metodo no arquivo [Entidade]BO.prg

### Problema 14: Propriedades Visuais na Definicao da Classe (Form fecha imediatamente)
**CRITICO**: Se o form abre e fecha SEM mensagem de erro, provavelmente faltam propriedades visuais na DEFINE CLASS:
`oxpro
*-- ERRADO - Form abre e fecha imediatamente:
DEFINE CLASS FormTam AS FormBase
    this_oBusinessObject = .NULL.

    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC
ENDDEFINE

*-- CORRETO - Propriedades visuais OBRIGATORIAS na DEFINE CLASS:
DEFINE CLASS FormTam AS FormBase
    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height = 600
    Width = 1000
    Caption = "Cadastro de Tamanhos"
    AutoCenter = .T.
    ShowWindow = 1
    WindowType = 1
    ControlBox = .F.
    TitleBar = 0
    Themes = .F.
    BorderStyle = 2

    this_oBusinessObject = .NULL.

    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC
ENDDEFINE
`
**Por que?** FormBase.Init() depende dessas propriedades para configurar corretamente o formulario. Sem elas, o form pode falhar silenciosamente.

### Problema 15: ExecutarExclusao vs Excluir (metodo nao encontrado)
**CRITICO**: O nome correto do metodo de exclusao no BusinessBase e ExecutarExclusao(), NAO Excluir():
`oxpro
*-- ERRADO no [Entidade]BO.prg:
PROTECTED PROCEDURE Excluir()  && ERRO: BusinessBase nao chama este metodo!
    ...
ENDPROC

*-- CORRETO no [Entidade]BO.prg:
PROTECTED PROCEDURE ExecutarExclusao()  && Nome correto do BusinessBase
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
        TEXT TO loc_cSQL TEXTMERGE NOSHOW
            DELETE FROM NomeTabela WHERE campo_pk = <<EscaparSQL(THIS.this_cCodigo)>>
        ENDTEXT
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
        IF loc_nResultado >= 0
            THIS.RegistrarAuditoria("DELETE")
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loException
        MostrarErro("Erro:" + CHR(13) + loException.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
ENDPROC
`
**Verificar**: BusinessBase.Excluir() chama THIS.ExecutarExclusao() internamente!

### Problema 16: Icone do Botao Salvar e RETURN em Validacao
**DOIS ERROS COMUNS**:

1. **Icone incorreto**: Usar cadastro_salvar_60.jpg (NAO cadastro_confirmar_60.jpg que nao existe)
`oxpro
*-- ERRADO - Arquivo nao existe:
.Picture = gc_4c_CaminhoIcones + "cadastro_confirmar_60.jpg"

*-- CORRETO:
.Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
`

2. **RETURN dentro de TRY para validacao**: Mover validacao para FORA do TRY
`oxpro
*-- ERRADO - RETURN silenciosamente falha:
TRY
    IF EMPTY(campo)
        MsgAviso("Campo obrigatorio!")
        RETURN  && Nao funciona dentro de TRY!
    ENDIF
    ...
ENDTRY

*-- CORRETO - Validacao ANTES do TRY:
IF EMPTY(campo)
    MsgAviso("Campo obrigatorio!")
    RETURN .F.  && Funciona fora do TRY
ENDIF

TRY
    ...
ENDTRY
`

**Tabela de icones corretos**:
| Botao | Icone |
|-------|-------|
| Incluir | cadastro_inserir_26.jpg |
| Visualizar | cadastro_vizualizar_60.jpg |
| Alterar | cadastro_alterar_60.jpg |
| Excluir | cadastro_excluir_60.jpg |
| Buscar | cadastro_procurar_60.jpg |
| Encerrar | cadastro_sair_60.jpg |
| **Salvar** | **cadastro_salvar_60.jpg** |
| Cancelar | cadastro_cancelar_60.jpg |

### Problema 17: BINDEVENT nao funciona com metodos PROTECTED
**CRITICO**: Metodos chamados via BINDEVENT devem ser PUBLIC (sem PROTECTED):
`oxpro
*-- ERRADO - BINDEVENT falha silenciosamente:
BINDEVENT(loBtn, "Click", THIS, "BtnSalvarClick")
...
PROTECTED PROCEDURE BtnSalvarClick()  && PROTECTED impede BINDEVENT!
    ...
ENDPROC

*-- CORRETO - Metodo sem PROTECTED:
BINDEVENT(loBtn, "Click", THIS, "BtnSalvarClick")
...
PROCEDURE BtnSalvarClick()  && PUBLIC (sem PROTECTED)
    ...
ENDPROC
`
**Regra**: TODOS os metodos Btn*Click devem ser PUBLIC (sem PROTECTED) para funcionar com BINDEVENT.

### Problema 18: BtnIncluirClick/BtnAlterarClick sem NovoRegistro()/EditarRegistro()
**CRITICO**: Os metodos de botao DEVEM chamar os metodos do BO para preparar o estado:
`oxpro
*-- ERRADO - Salvar() nao sabe se e INSERT ou UPDATE:
PROCEDURE BtnIncluirClick()
    THIS.LimparCampos()
    THIS.HabilitarCampos(.T.)
    THIS.AlternarPagina(2)
    THIS.this_cModoAtual = "INCLUIR"
ENDPROC

*-- CORRETO - Chamar NovoRegistro() para preparar INSERT:
PROCEDURE BtnIncluirClick()
    THIS.this_oBusinessObject.NovoRegistro()  && OBRIGATORIO: Prepara BO para INSERT
    THIS.LimparCampos()
    THIS.HabilitarCampos(.T.)
    THIS.AlternarPagina(2)
    THIS.this_cModoAtual = "INCLUIR"
ENDPROC

*-- CORRETO - Chamar EditarRegistro() para preparar UPDATE:
PROCEDURE BtnAlterarClick()
    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
        THIS.this_oBusinessObject.EditarRegistro()  && OBRIGATORIO: Prepara BO para UPDATE
        THIS.BOParaForm()
        ...
    ENDIF
ENDPROC
`
**Por que?** O BusinessBase.Salvar() usa 	his_lNovoRegistro para decidir entre INSERT e UPDATE. Sem chamar NovoRegistro()/EditarRegistro(), esse flag nao e setado corretamente.

### Problema 19: HabilitarCampos() chamado ANTES de setar this_cModoAtual
**CRITICO**: O metodo HabilitarCampos verifica 	his_cModoAtual para decidir se habilita o campo codigo:
`oxpro
*-- ERRADO - this_cModoAtual ainda e "LISTA" quando HabilitarCampos e chamado:
PROCEDURE BtnIncluirClick()
    THIS.LimparCampos()
    THIS.HabilitarCampos(.T.)           && this_cModoAtual = "LISTA" aqui!
    THIS.this_cModoAtual = "INCLUIR"    && Setado tarde demais
ENDPROC

*-- CORRETO - Setar this_cModoAtual ANTES de HabilitarCampos:
PROCEDURE BtnIncluirClick()
    THIS.this_oBusinessObject.NovoRegistro()
    THIS.LimparCampos()
    THIS.this_cModoAtual = "INCLUIR"    && ANTES de HabilitarCampos!
    THIS.HabilitarCampos(.T.)
    THIS.AlternarPagina(2)
ENDPROC
`

### Problema 20: Parametros errados no FormBuscaAuxiliar
**CRITICO**: FormBuscaAuxiliar espera gnConnHandle como primeiro parametro:
`oxpro
*-- ERRADO - Parametros na ordem errada:
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", "SigCdTam", "cods", "descs")

*-- CORRETO - gnConnHandle primeiro:
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_Busca", "cods", "", "Buscar Tamanho")
`
**Assinatura**: FormBuscaAuxiliar(gnConnHandle, cTabela, cCursor, cCampo, cValor, cTitulo, lBuscaExata, lMostraGrid, cFiltro)

### Problema 21: Imagem de fundo com caminho relativo incorreto
**CRITICO**: Usar gc_4c_CaminhoIcones ao inves de caminho relativo:
`oxpro
*-- ERRADO - Caminho relativo pode nao funcionar:
.Page1.Picture = "..\framework\imagens\fundo_cad_1003.jpg"

*-- CORRETO - Usar variavel global de caminho:
.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
`

### Problema 22: CarregarPorCodigo nao reseta this_lNovoRegistro
**CRITICO**: Ao carregar registro existente, DEVE resetar 	his_lNovoRegistro = .F.:
`oxpro
*-- No [Entidade]BO.prg, metodo CarregarPorCodigo:
IF RECCOUNT("cursor_4c_Carrega") > 0
    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
    THIS.this_lNovoRegistro = .F.  && OBRIGATORIO: Evita violacao de PK no Alterar
ENDIF
`
**Por que?** Se o usuario clicar Incluir (seta 	his_lNovoRegistro = .T.) e depois Alterar, sem resetar o flag, o Salvar() chama Inserir() ao inves de Atualizar() -> Violacao de chave primaria.

### Problema 23: FormBuscaAuxiliar - Uso correto (NAO tem ObterCodigoSelecionado)
**CRITICO**: FormBuscaAuxiliar NAO tem metodo ObterCodigoSelecionado(). Usar propriedade 	his_lSelecionou e cursor:
`oxpro
*-- ERRADO - Metodo nao existe:
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ...)
loc_oBusca.Show()
loc_cCodigo = loc_oBusca.ObterCodigoSelecionado()  && ERRO!

*-- CORRETO - Usar this_lSelecionou e cursor:
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_Busca", "cods", "", "Buscar")

*-- Adicionar colunas ao grid
loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")

*-- Mostrar modal
loc_oBusca.Show(1)

*-- Verificar selecao via propriedade
IF loc_oBusca.this_lSelecionou
    *-- Ler valor do cursor (NAO do objeto)
    IF USED("cursor_4c_Busca")
        loc_cCodigo = ALLTRIM(cursor_4c_Busca.cods)
    ENDIF
ENDIF

*-- Limpar
IF USED("cursor_4c_Busca")
    USE IN cursor_4c_Busca
ENDIF
loc_oBusca.Release()
`

### Problema 24: PageFrame NAO tem propriedade BackColor
**CRITICO**: PageFrame e um container, NAO tem BackColor - apenas as Pages internas tem:
`oxpro
*-- ERRADO - PageFrame NAO tem BackColor:
THIS.AddObject("pgf_4c_Paginas", "PageFrame")
WITH THIS.pgf_4c_Paginas
    .PageCount = 2
    .BackColor = RGB(255,255,255)  && ERRO! PageFrame nao tem BackColor!
ENDWITH

*-- CORRETO - BackColor apenas nas PAGES:
THIS.AddObject("pgf_4c_Paginas", "PageFrame")
WITH THIS.pgf_4c_Paginas
    .PageCount = 2
    .Page1.BackColor = RGB(255,255,255)  && Pages TEM BackColor
    .Page2.BackColor = RGB(255,255,255)
ENDWITH
`
**CorretorAutomatico.ps1 pattern #15 remove automaticamente .BackColor de PageFrame.**

### Problema 25: Queries SQL com tabela/coluna ERRADA + Grid sem coluna no SELECT (CRITICO!)
**CRITICO**: Ao migrar, NUNCA inventar nomes de tabelas ou colunas. SEMPRE extrair do codigo ORIGINAL:
`oxpro
*-- ERRADO - Claude "adivinhou" a tabela errada:
*-- Original usa SigCdGcr (Grupos Conta Corrente) com coluna Codigos
*-- Migrado incorretamente como SigCdGrp (Grupos Produto) com coluna cgrus
loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cGrupo)

*-- CORRETO - Copiar tabela e colunas EXATAS do codigo original:
loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
`

**REGRA OBRIGATORIA**: Para CADA query SQL no codigo migrado:
1. Localizar a query equivalente no **codigo fonte original** (buscar por SELECT, INSERT, UPDATE, DELETE)
2. Copiar o nome da TABELA exato do original
3. Copiar os nomes das COLUNAS exatos do original
4. Se a tabela nao aparece diretamente em SQL mas via SEEK/cursor local (ex: `=Seek(valor, [crSigCdGcr], [Codigos])`), verificar qual query CRIOU esse cursor (buscar `SqlExecute` + nome do cursor)
5. Validar contra **docs/schema.sql** se a tabela e colunas existem

**Tabelas que SAO DIFERENTES (nao confundir!):**
| Tabela | Descricao | PK | Colunas Desc |
|--------|-----------|-----|-------------|
| SigCdGrp | Grupos de **Produto** | cgrus | dgrus |
| SigCdGcr | Grupos de **Conta Corrente** | Codigos | Descrs |
| SigCdCli | Clientes | Iclis | Rclis |
| SigCdEmp | Empresas | CEmps | Razas |

**REGRA GRID-SQL OBRIGATORIA (Consistencia ControlSource ? SELECT)**:
Para CADA coluna de Grid com `ControlSource = "cursor_xxx.CAMPO"`:
1. O campo CAMPO **DEVE** existir no `CREATE CURSOR cursor_xxx (... CAMPO ...)`
2. O campo CAMPO **DEVE** existir no `SELECT ... CAMPO ... INTO CURSOR cursor_xxx` ou `SQLEXEC(..., "cursor_xxx")`
3. Se o Grid tem N colunas com ControlSource, o SELECT DEVE retornar pelo menos esses N campos
4. Exemplo: Se Grid.Column9.ControlSource = "cursor_4c_Historico.NFs", entao o SELECT do BO DEVE incluir `a.NFs` e o CREATE CURSOR DEVE ter `NFs C(10)`

`oxpro
*-- ERRADO - Grid referencia NFs mas SELECT nao inclui:
loc_cSQL = "SELECT a.Datas, a.Hists, a.Valors FROM SigMvCcr a"  && Falta NFs!
*-- Grid: .Column9.ControlSource = "cursor_4c_Historico.NFs"     && ERRO: Variable NFS not found!

*-- CORRETO - SELECT inclui TODAS as colunas usadas no Grid:
loc_cSQL = "SELECT a.Datas, a.Hists, a.Valors, a.NFs FROM SigMvCcr a"  && NFs incluido!
`

### Problema 26: Containers flutuantes ficam visiveis ao abrir o form
**CRITICO**: Se o form original tem paineis/containers que iniciam OCULTOS (Visible=.F.) e so aparecem ao clicar botoes, o metodo `TornarControlesVisiveis()` NAO deve torna-los visiveis.

**MECANISMO DO BUG**: `AddObject()` cria controles com Visible=.F. ? voce seta Visible=.F. nos containers flutuantes ? `TornarControlesVisiveis()` percorre recursivamente e seta Visible=.T. em TUDO ? containers flutuantes ficam visiveis indevidamente.

`oxpro
*-- ERRADO - TornarControlesVisiveis() torna TUDO visivel incluindo paineis flutuantes:
PROCEDURE TornarControlesVisiveis(par_oContainer)
    FOR loc_i = 1 TO par_oContainer.ControlCount
        loc_oControl = par_oContainer.Controls(loc_i)
        loc_oControl.Visible = .T.  && Torna visivel ate paineis que deviam estar ocultos!
    ENDFOR
ENDPROC

*-- CORRETO - Filtrar containers flutuantes por NOME:
PROCEDURE TornarControlesVisiveis(par_oContainer)
    LOCAL loc_i, loc_oControl, loc_cNome
    FOR loc_i = 1 TO par_oContainer.ControlCount
        loc_oControl = par_oContainer.Controls(loc_i)
        *-- Pular containers que devem iniciar ocultos (paineis flutuantes)
        loc_cNome = UPPER(loc_oControl.Name)
        IF INLIST(loc_cNome, "lista de nomes dos containers flutuantes aqui")
            *-- Nao tornar visivel, mas RECURSAO nos filhos (controles internos SIM)
            THIS.TornarControlesVisiveis(loc_oControl)
            LOOP
        ENDIF
        loc_oControl.Visible = .T.
        IF PEMSTATUS(loc_oControl, "ControlCount", 5)
            THIS.TornarControlesVisiveis(loc_oControl)
        ENDIF
    ENDFOR
ENDPROC
`

**REGRA OBRIGATORIA**: Ao migrar, listar TODOS os containers que devem iniciar ocultos:
1. Buscar no original por: `Visible = .F.` em containers/objetos
2. Buscar por containers que so aparecem via Click de botao (ex: `cnt_Relatorio.Visible = .T.` dentro de um cmd_Click)
3. Gerar o INLIST com os nomes _4c_ correspondentes
4. O filtro deve estar em TornarControlesVisiveis(), NAO basta setar .Visible=.F. na criacao (pois TornarControlesVisiveis SOBRESCREVE)
5. **IMPORTANTE**: Mesmo pulando o container, RECUAR nos filhos para tornar os controles INTERNOS visiveis (serao usados quando o container for mostrado)

### Problema 27: Botoes desalinhados (Top inconsistente por CommandGroup)
**CRITICO**: Quando botoes estao agrupados horizontalmente, TODOS devem ter o MESMO Top.

**CAUSA RAIZ**: No original, botoes podem estar DENTRO de um CommandGroup (ex: `grp_operacao`). No novo sistema, os botoes sao criados DIRETAMENTE na Page. O Top final deve ser calculado como a SOMA das coordenadas:

`
Top_final = CommandGroup.Top + Button.Top (dentro do group) + Compensacao_PageFrame
`

`oxpro
*-- EXEMPLO - Original:
*-- Page1: cmd_procurar.Top=4 (direto na page), grp_operacao.Top=-1 (group na page)
*--         grp_operacao.cmd_consulta.Top=5, grp_operacao.cmd_sair.Top=5
*-- PageFrame.Top = -28 (compensacao = +28)
*--
*-- Calculo CORRETO:
*-- cmd_procurar: 4 + 28 = 32
*-- cmd_consulta: (-1 + 5) + 28 = 32  (group.Top + button.Top + compensacao)
*-- cmd_sair:     (-1 + 5) + 28 = 32

*-- ERRADO - Consultar calcula errado, Encerrar usa so group.Top:
cmd_4c_Procurar.Top   = 32   && OK
cmd_4c_Consultar.Top  = 33   && ERRADO (nao somou corretamente)
cmd_4c_Encerrar.Top   = 27   && ERRADO (usou so group.Top + 28, esqueceu button.Top)

*-- CORRETO - Todos com mesmo Top:
cmd_4c_Procurar.Top   = 32
cmd_4c_Consultar.Top  = 32
cmd_4c_Encerrar.Top   = 32
`

**REGRA OBRIGATORIA**: Para botoes que no original estao dentro de CommandGroup:
1. Identificar o CommandGroup (ex: `grp_operacao`) e anotar seu .Top
2. Identificar cada Command dentro (Command1, Command2) e anotar seus .Top internos
3. Top_absoluto_original = CommandGroup.Top + Command.Top
4. Top_final_migrado = Top_absoluto_original + Compensacao_PageFrame
5. **VERIFICAR**: Todos os botoes na mesma "barra" (mesma faixa horizontal) DEVEM ter o MESMO Top final
6. Se houver divergencia de 1-5px, usar o valor MAIS FREQUENTE como padrao

### Problema 28: mAddColuna com parametros na ordem errada (CRITICO!)
**CRITICO**: O metodo `mAddColuna` do FormBuscaAuxiliar tem assinatura: `mAddColuna(par_cCampo, par_cMascara, par_cTitulo)`
- par_cCampo: nome do campo no cursor (ex: "Codigos")
- par_cMascara: InputMask (string vazia se nao tiver mascara)
- par_cTitulo: titulo da coluna no grid (ex: "Codigo")

`oxpro
*-- ERRADO - Terceiro parametro eh numero (largura), causa "Function argument value, type, or count is invalid":
loc_oBusca.mAddColuna("Codigos", "Codigo", 80)    && ERRO! 80 nao eh string!
loc_oBusca.mAddColuna("Descrs", "Descricao", 300) && ERRO! 300 nao eh string!

*-- CORRETO - Todos os 3 parametros sao strings (Campo, Mascara, Titulo):
loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
`

**REGRA**: mAddColuna NUNCA recebe largura como parametro. A largura eh calculada automaticamente pelo FormBuscaAuxiliar.

### Problema 29: FormBuscaAuxiliar - Dois modos de uso (CRITICO!)
**CRITICO**: FormBuscaAuxiliar tem DOIS modos de uso. Usar o modo ERRADO causa "Function argument value, type, or count is invalid".

**MODO 1 - Com parametros no Init (lookup em TABELA SQL):**
Usado quando a busca eh diretamente numa tabela do banco. O Init faz o SELECT automaticamente.

```foxpro
*-- Lookup numa tabela SQL (ex: SigCdGcr):
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
    "SigCdGcr", "cursor_4c_Busca", "Codigos", loc_cValor, ;
    "Grupo de Conta Corrente")

IF VARTYPE(loc_oBusca) = "O"
    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
        *-- Registro exato encontrado
        loc_cGrupo = ALLTRIM(cursor_4c_Busca.Codigos)
    ELSEIF !loc_oBusca.this_lAchouRegistro
        *-- Nao encontrou exato, mostrar grid para selecao
        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
            loc_cGrupo = ALLTRIM(cursor_4c_Busca.Codigos)
        ENDIF
    ENDIF
    loc_oBusca.Release()
ENDIF
IF USED("cursor_4c_Busca")
    USE IN cursor_4c_Busca
ENDIF
```

**MODO 2 - Sem parametros no Init (lookup em CURSOR LOCAL pre-existente):**
Usado quando o cursor jah foi criado por um metodo do BO. O Init NAO faz SELECT.

```foxpro
*-- Lookup num cursor local jah carregado pelo BO:
THIS.this_oBusinessObject.BuscarContaPorGrupo(loc_cGrupo, "")

loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
IF VARTYPE(loc_oBusca) = "O"
    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"  && Cursor jah existente
    loc_oBusca.this_cTitulo = "Contas do Grupo"
    loc_oBusca.mAddColuna("Contas", "", "Conta")
    loc_oBusca.mAddColuna("RClis", "", "Nome")
    loc_oBusca.Show()

    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
        loc_cConta = ALLTRIM(cursor_4c_BuscaConta.Contas)
    ENDIF
    loc_oBusca.Release()
ENDIF
IF USED("cursor_4c_BuscaConta")
    USE IN cursor_4c_BuscaConta
ENDIF
```

**QUANDO usar cada modo:**
| Situacao | Modo | Exemplo |
|----------|------|---------|
| Busca em tabela SQL padrao | MODO 1 (com params) | SigCdGrp, SigCdCli, SigCdMoe |
| Busca em cursor do BO | MODO 2 (sem params) | cursor_4c_BuscaConta (criado por BuscarContaPorGrupo) |
| Busca com filtro adicional | MODO 1 (com params + par_cFiltro) | Busca com WHERE extra |

**ERROS COMUNS:**
- CREATEOBJECT("FormBuscaAuxiliar") sem params ? Init tenta UPPER(ALLTRIM(.F.)) ? ERRO!
  Isso foi corrigido no FormBuscaAuxiliar.prg (retorna .T. imediatamente se par_cTabela nao eh string).
- Usar MODO 1 quando o cursor jah existe localmente ? SELECT desnecessario
- Usar MODO 2 sem definir this_cCursorDestino ? grid vazio

### Problema 30: OptionGroup - Buttons sem Left/Top/AutoSize (CRITICO!)
**CRITICO**: Ao criar OptionGroup via AddObject, os Buttons ficam SOBREPOSTOS (todos no Left=0) se nao definir Left individual.
O usuario so ve o primeiro botao - os demais ficam escondidos atras dele.

```foxpro
*-- ERRADO - Buttons ficam sobrepostos (todos no Left=0):
par_oPagina.AddObject("opt_4c_Filtro", "OptionGroup")
WITH par_oPagina.opt_4c_Filtro
    .ButtonCount = 3
    .Width       = 206
    .Height      = 26
ENDWITH
WITH par_oPagina.opt_4c_Filtro.Buttons(1)
    .Caption  = "Global"
    .Width    = 60
ENDWITH
WITH par_oPagina.opt_4c_Filtro.Buttons(2)
    .Caption  = "Positivos"
    .Width    = 70
    && SEM .Left ? fica no Left=0, atras do Button1!
ENDWITH

*-- CORRETO - Definir Left, Top, AutoSize, ForeColor e Themes em CADA Button:
par_oPagina.AddObject("opt_4c_Filtro", "OptionGroup")
WITH par_oPagina.opt_4c_Filtro
    .ButtonCount = 3
    .Width       = 206
    .Height      = 26
    .BackStyle   = 0
    .BorderStyle = 0
    .Visible     = .T.
ENDWITH
WITH par_oPagina.opt_4c_Filtro.Buttons(1)
    .Caption   = "Global"
    .Left      = 5
    .Top       = 5
    .Width     = 60
    .AutoSize  = .T.
    .FontName  = "Tahoma"
    .FontSize  = 8
    .ForeColor = RGB(90, 90, 90)
    .Themes    = .F.
ENDWITH
WITH par_oPagina.opt_4c_Filtro.Buttons(2)
    .Caption   = "Positivos"
    .Left      = 63          && Left do anterior + Width do anterior (~3px gap)
    .Top       = 5
    .Width     = 70
    .AutoSize  = .T.
    .FontName  = "Tahoma"
    .FontSize  = 8
    .ForeColor = RGB(90, 90, 90)
    .Themes    = .F.
ENDWITH
```

**REGRA**: SEMPRE copiar do legado: Left, Top, AutoSize, ForeColor, Themes de CADA Button do OptionGroup.
Se o legado nao especifica Left (usa AutoSize), calcular: `Left = Left_anterior + Width_anterior + 3`.

### Problema 31: Eventos que disparam carga de dados (LostFocus/InteractiveChange) - CRITICO!
**CRITICO**: No legado, campos de filtro (grupo, moeda, periodo) disparam carga de dados ao SAIR do campo (Valid/LostFocus).
OptionGroups (filtro, ordem) disparam recarga ao MUDAR de opcao (InteractiveChange).
Se nao implementar esses eventos, a grade NUNCA carrega dados.

**Padrao obrigatorio - Analisar no legado:**

1. **Procurar por `MontaGrade`, `Processa`, `Buscar`** nos eventos Valid/LostFocus dos campos de filtro
2. **Procurar por `InteractiveChange`** nos OptionGroups - se chama MontaGrade/Processa, adicionar BINDEVENT

```foxpro
*-- ERRADO - LostFocus do campo so valida, NAO carrega dados:
PROCEDURE ValidarGrupo()
    LOCAL loc_cGrupo
    loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
    IF EMPTY(loc_cGrupo)
        RETURN
    ENDIF
    *-- Valida grupo no banco...
    *-- MAS NAO CARREGA A GRADE! Usuario precisa clicar em outro lugar.
ENDPROC

*-- CORRETO - LostFocus valida E carrega a grade:
PROCEDURE ValidarGrupo()
    LOCAL loc_cGrupo
    loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
    IF EMPTY(loc_cGrupo)
        RETURN
    ENDIF
    *-- Valida grupo no banco...
    IF loc_lGrupoValido
        THIS.CarregarGradeSaldo()   && OBRIGATORIO: Carregar dados apos validar
    ENDIF
ENDPROC
```

```foxpro
*-- OBRIGATORIO: BINDEVENT para InteractiveChange de OptionGroups que afetam dados:
BINDEVENT(par_oPagina.opt_4c_Filtro, "InteractiveChange", THIS, "FiltroSaldoChanged")

PROCEDURE FiltroSaldoChanged()
    IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value))
        THIS.CarregarGradeSaldo()
    ENDIF
ENDPROC
```

**Checklist de eventos de carga (OBRIGATORIO para TODA migracao):**
- [ ] Campo de grupo/filtro principal: LostFocus chama metodo de carga (CarregarGrade, BuscarDados)
- [ ] Lookup (BtnProcurarClick): Apos selecionar, chama metodo de carga
- [ ] OptionGroup de filtro: InteractiveChange chama metodo de carga
- [ ] OptionGroup de ordem: InteractiveChange chama metodo de carga/reordenacao
- [ ] Campo de periodo (data): LostFocus chama metodo de carga (se aplicavel)

### Problema 32: Grid - Headers perdidos apos RecordSource (CRITICO!)
**CRITICO**: Quando `CarregarGrade*()` redefine RecordSource e ControlSource, os Header1.Caption sao RESETADOS para o nome do campo (ex: "Contas" ao inves de "Conta").
O metodo CarregarGrade DEVE redefinir os Headers APOS RecordSource + ControlSource + Width.

```foxpro
*-- ERRADO - Headers ficam com nome do campo (Contas, RClis, Moedas...):
PROCEDURE CarregarGradeSaldo()
    loc_oGrid.RecordSource = "cursor_4c_Saldos"
    loc_oGrid.Column1.ControlSource = "cursor_4c_Saldos.Contas"
    loc_oGrid.Column1.Width = 100
    && Headers NAO redefinidos ? ficam "Contas" ao inves de "Conta"
    loc_oGrid.Refresh()
ENDPROC

*-- CORRETO - Redefinir Headers APOS RecordSource:
PROCEDURE CarregarGradeSaldo()
    loc_oGrid.RecordSource = "cursor_4c_Saldos"
    loc_oGrid.Column1.ControlSource = "cursor_4c_Saldos.Contas"
    loc_oGrid.Column1.Width = 100
    loc_oGrid.Column1.Header1.Caption = "Conta"    && OBRIGATORIO: Redefinir
    loc_oGrid.Refresh()
ENDPROC
```

**REGRA**: Toda vez que RecordSource for setado, Header1.Caption, InputMask e Alignment DEVEM ser redefinidos logo apos.

### Problema 33: Botao Consultar deve navegar para aba de detalhe (forms operacionais)
Em forms operacionais com 2 abas (lista + detalhe), o botao Consultar/Visualizar no legado:
1. Captura dados do registro selecionado na grade
2. Preenche campos na aba de detalhe
3. Navega para a aba de detalhe (ActivePage = 2)
4. Carrega dados detalhados

```foxpro
*-- ERRADO - Consultar apenas abre um container:
PROCEDURE BtnConsultarClick()
    THIS.cnt_4c_Consulta.Visible = .T.   && NAO navega para detalhe!
ENDPROC

*-- CORRETO - Consultar navega para aba de detalhe com dados:
PROCEDURE BtnConsultarClick()
    IF !USED("cursor_4c_Saldos") OR EOF("cursor_4c_Saldos")
        MostrarErro("Nenhum registro selecionado!", "")
        RETURN
    ENDIF
    SELECT cursor_4c_Saldos
    loc_oPg2.txt_4c_Campo1.Value = ALLTRIM(cursor_4c_Saldos.Campo1)
    loc_oPg2.txt_4c_Campo2.Value = ALLTRIM(cursor_4c_Saldos.Campo2)
    THIS.pgf_4c_Paginas.ActivePage = 2
    THIS.CarregarGradeDetalhe()
ENDPROC
```

**REGRA**: Analisar no legado o que cada botao do CommandGroup/grp_operacao faz. Muitos navegam entre abas, nao apenas abrem containers.

### Problema 34: SQLEXEC substitui cursor e destroi colunas do Grid (CRITICO!)
Quando SQLEXEC cria um cursor com o mesmo nome de um cursor ja vinculado a um Grid, o cursor antigo eh destruido e recriado. O Grid perde TODAS as colunas (Column1..N ficam "Unknown member").

```foxpro
*-- ERRADO - SQLEXEC substitui cursor e destroi colunas do Grid:
SQLEXEC(gnConnHandle, "SELECT ...", "cursor_4c_Dados")  && Destroi cursor original!
loc_oGrid.Column1.Header1.Caption = "Codigo"           && ERRO: Unknown member COLUMN1

*-- CORRETO - SQLEXEC em cursor TEMPORARIO + ZAP + APPEND:
SQLEXEC(gnConnHandle, "SELECT ...", "cursor_4c_DadosTemp")  && Cursor temporario
SELECT cursor_4c_Dados
ZAP IN cursor_4c_Dados                                      && Limpa cursor do grid
APPEND FROM DBF("cursor_4c_DadosTemp")                      && Copia dados
USE IN cursor_4c_DadosTemp                                   && Fecha temporario
GO TOP IN cursor_4c_Dados
loc_oGrid.Refresh()                                          && Grid preserva colunas
```

**REGRA**: Em QUALQUER metodo que recarrega dados de um Grid (MontaGrade, CarregarHistorico, FiltrarDados), SEMPRE usar cursor temporario + ZAP + APPEND para preservar as colunas do Grid.

### Problema 35: CREATE CURSOR placeholder deve aceitar NULLs (CRITICO!)
Cursores placeholder criados para Grid precisam aceitar NULLs, pois SQLEXEC do SQL Server retorna NULLs em campos como DtAudits, Cpfs, etc. APPEND FROM falha com "Field XXX does not accept null values".

```foxpro
*-- ERRADO - cursor nao aceita NULLs:
CREATE CURSOR cursor_4c_Dados (Campo1 C(10), Campo2 T)
*-- APPEND FROM cursor com NULLs -> ERRO!

*-- CORRETO - SET NULL ON antes do CREATE CURSOR:
SET NULL ON
CREATE CURSOR cursor_4c_Dados (Campo1 C(10), Campo2 T)
SET NULL OFF
*-- APPEND FROM cursor com NULLs -> OK
```

**REGRA**: TODOS os CREATE CURSOR de cursores placeholder para Grid devem ter SET NULL ON/OFF ao redor.

### Problema 36: Grid RecordSource + ColumnCount dentro de WITH nao cria colunas (CRITICO!)
Ao definir .RecordSource e .ColumnCount dentro de um bloco WITH do Grid, as colunas podem nao ser criadas imediatamente, causando "Unknown member COLUMN1" na linha seguinte.

```foxpro
*-- ERRADO - Column1 nao existe imediatamente:
WITH loc_oGrid
    .RecordSource = "cursor_4c_Dados"
    .ColumnCount = 10
    .Column1.ControlSource = "cursor_4c_Dados.Campo"  && ERRO: Unknown member COLUMN1
ENDWITH

*-- CORRETO - RecordSource e ColumnCount FORA do WITH:
loc_oGrid.RecordSource = "cursor_4c_Dados"
loc_oGrid.ColumnCount = 10
WITH loc_oGrid
    .Column1.ControlSource = "cursor_4c_Dados.Campo"  && OK: colunas ja existem
ENDWITH
```

**REGRA**: SEMPRE definir RecordSource e ColumnCount com referencia EXPLICITA (loc_oGrid.xxx), NUNCA dentro de WITH.

### Problema 38: BINDEVENT handler sem parametros para eventos que passam parametros (CRITICO!)
Eventos VFP como AfterRowColChange e KeyPress passam parametros obrigatorios ao handler.
Se o handler nao declara LPARAMETERS, VFP gera "No PARAMETER statement is found".

```foxpro
*-- ERRADO - handler sem parametros:
BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridHistAfterRowColChange")
PROCEDURE GridHistAfterRowColChange()  && ERRO: No PARAMETER statement is found
    THIS.CarregarDetalheHist()
ENDPROC

*-- CORRETO - handler com parametros:
BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridHistAfterRowColChange")
PROCEDURE GridHistAfterRowColChange(par_nColIndex)
    THIS.CarregarDetalheHist()
ENDPROC

*-- KeyPress tambem precisa de parametros:
PROCEDURE TeclaGridHist(par_nKeyCode, par_nShiftAltCtrl)
    * handler de KeyPress
ENDPROC
```

**REGRA**: SEMPRE declarar parametros em handlers de BINDEVENT para AfterRowColChange(par_nColIndex) e KeyPress(par_nKeyCode, par_nShiftAltCtrl).

### Problema 39: Navegacao Page1?Page2 em forms OPERACIONAL deve ler do grid (CRITICO!)
Em forms OPERACIONAL com PageFrame, o botao "Consultar" deve ler os dados da LINHA SELECIONADA no grid de Page1 e navegar para Page2 com dados carregados. NAO deve abrir um floating container para input manual.

```foxpro
*-- ERRADO - Toggle de floating container para input manual:
PROCEDURE BtnConsultarSaldoClick()
    loc_oCnt.Visible = !loc_oCnt.Visible  && ERRADO: pede input manual
ENDPROC

*-- CORRETO - Le do grid e navega diretamente:
PROCEDURE BtnConsultarSaldoClick()
    SELECT cursor_4c_Saldos
    loc_cGrupo = ALLTRIM(cursor_4c_Saldos.Grupos)
    loc_cConta = ALLTRIM(cursor_4c_Saldos.Contas)
    *-- Preenche campos da Page2
    THIS.pgf_4c_Principal.Page2.txt_4c_ContaHist.Value = loc_cConta
    *-- Carrega dados e navega
    THIS.CarregarHistorico()
    THIS.pgf_4c_Principal.ActivePage = 2
ENDPROC
```

**REGRA**: Em forms OPERACIONAL, botoes de navegacao entre paginas DEVEM ler dados do cursor do grid selecionado, NAO pedir input manual via floating container.

### Problema 40: Header Captions de Grid devem ser IDENTICOS ao legado (CRITICO!)
Os captions dos headers do Grid DEVEM ser copiados EXATAMENTE do fonte legado. NAO abreviar, NAO inventar nomes.

```foxpro
*-- ERRADO - Headers inventados/abreviados:
.Column4.Header1.Caption = "Op"      && Legado usa "Mov"
.Column7.Header1.Caption = "Doc"     && Legado usa "Documento"
.Column8.Header1.Caption = "NF"      && Legado usa "Nota"

*-- CORRETO - Copiar EXATAMENTE do fonte legado:
.Column4.Header1.Caption = "Mov"         && EXATO do legado
.Column7.Header1.Caption = "Documento"   && EXATO do legado
.Column8.Header1.Caption = "Nota"        && EXATO do legado
```

**REGRA**: SEMPRE procurar "Caption =" nos blocos de Header1 do fonte legado e copiar EXATAMENTE. O Code Review (CHECK 17) valida automaticamente.

### Problema 41: mAddColuna do FormBuscaAuxiliar tem 3 parametros (CRITICO!)
O metodo mAddColuna aceita EXATAMENTE 3 parametros: campo, mascara, titulo.

```foxpro
*-- ERRADO - 4 parametros (largura e tabela NAO existem):
loc_oBusca.mAddColuna("Codigos", "C" + CHR(243) + "digo", 80, "SigCdGcr")

*-- CORRETO - 3 parametros (campo, mascara, titulo):
loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
```

**A tabela e o cursor devem ser configurados ANTES via propriedades:**
```foxpro
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
loc_oBusca.this_cTabela = "SigCdGcr"          && Tabela de busca
loc_oBusca.this_cCampoChave = "Codigos"        && Campo chave
loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaAuxiliar"
loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
loc_oBusca.Show()
```

**REGRA**: mAddColuna SEMPRE com 3 params: (campo, mascara_ou_vazio, titulo). NUNCA passar largura ou tabela como parametro.

### Problema 42: Colunas SQL inventadas em queries com JOIN (CRITICO!)
**CRITICO**: Em queries com JOIN, verificar de QUAL tabela (alias) cada coluna vem. NUNCA assumir que colunas de uma tabela existem em outra.

```foxpro
*-- ERRADO - Cpfs, Matris, Situas NAO existem em SigMvSlc (alias a):
loc_cQuery = "SELECT a.Contas, a.Saldos, a.Cpfs, a.Matris" + ;
             " FROM SigMvSlc a LEFT JOIN SigCdCli b ON b.Iclis = a.Contas"

*-- CORRETO - Cpfs, ContaMats, Situas vem de SigCdCli (alias b):
loc_cQuery = "SELECT a.Contas, a.Saldos, b.Cpfs, b.ContaMats, b.Situas" + ;
             " FROM SigMvSlc a LEFT JOIN SigCdCli b ON b.Iclis = a.Contas"
```

**Colunas frequentemente confundidas em JOINs:**
| Coluna | Tabela CORRETA | NAO existe em |
|--------|---------------|---------------|
| Cpfs | SigCdCli | SigMvSlc, SigCdPbx |
| ContaMats | SigCdCli | SigMvSlc |
| Situas | SigCdCli | SigMvSlc |
| Rclis | SigCdCli | SigMvSlc |

**Colunas com nomes nao-intuitivos em SigMvCcr:**
| ERRADO (inventado) | CORRETO (schema.sql) |
|--------------------|---------------------|
| Concils | Concs |
| Usuar | Usualts |
| Tipo | Tipos |
| Valos | Valors |
| Hists2 | Hist2s |
| hiss3 | Shists |

**REGRA**: Copiar nomes do codigo ORIGINAL + validar em schema.sql. NUNCA "normalizar" nomes.

### Problema 43: Init() duplicando InicializarForm (CRITICO!)
**CRITICO**: O FormBase.Init() ja chama THIS.InicializarForm(). Se o Init() do form tambem chama InicializarForm(), ocorre:
- AddObject duplicado ("A member object with this name already exists")
- PageFrame criado 2x, Grid criado 2x
- Erro cascata em todos os metodos subsequentes

```foxpro
*-- ERRADO - InicializarForm chamado 2x (DODEFAULT()->FormBase.Init()->InicializarForm() + chamada direta):
PROCEDURE Init()
    DODEFAULT()                        && Ja chama InicializarForm() internamente
    loc_lSucesso = THIS.InicializarForm()  && DUPLICADO! Causa "member already exists"
    RETURN loc_lSucesso
ENDPROC

*-- CORRETO - Apenas DODEFAULT() (FormBase.Init() ja cuida de tudo):
PROCEDURE Init()
    LOCAL loc_lSucesso
    loc_lSucesso = .F.
    TRY
        loc_lSucesso = DODEFAULT()
    CATCH TO loException
        MostrarErro(loException, "FormXxx.Init")
    ENDTRY
    RETURN loc_lSucesso
ENDPROC
```

### Problema 44: Caption/Titulo nao propagado para labels de exibicao
O legado copia ThisForm.Caption para labels de titulo (lblSombra/lblTitulo) no Init().
Se o form migrado NAO faz isso, o titulo na tela fica incorreto (ex: "Cadastro de Testes" que eh o default do FormBase).

```foxpro
*-- CORRETO - Propagar Caption para labels APOS ConfigurarPageFrame:
*-- No InicializarForm(), apos ConfigurarPageFrame():
IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra") = "O"
    THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
ENDIF
IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo") = "O"
    THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
ENDIF
```

### Problema 45: LostFocus abrindo lookup sem guardia de valor alterado
No legado, Valid event so dispara quando o valor do campo MUDA. Mas BINDEVENT com LostFocus dispara em CADA perda de foco. Se o handler abre FormBuscaAuxiliar sem verificar se o valor mudou, a janela de busca abre toda vez que o usuario clica em outro campo.

```foxpro
*-- ERRADO - Lookup abre em CADA perda de foco:
PROCEDURE ValidarGrupoSaldo()
    LOCAL loc_cGrupo
    loc_cGrupo = ALLTRIM(THIS.txt_4c_GrupoSaldo.Value)
    IF EMPTY(loc_cGrupo)
        RETURN
    ENDIF
    THIS.AbrirBuscaGrupoSaldo()  && Abre TODA vez que perde foco!
ENDPROC

*-- CORRETO - Verificar se valor mudou:
this_cUltimoGrupoValidado = ""   && Propriedade para rastrear

PROCEDURE ValidarGrupoSaldo()
    LOCAL loc_cGrupo
    loc_cGrupo = ALLTRIM(THIS.txt_4c_GrupoSaldo.Value)
    IF loc_cGrupo == THIS.this_cUltimoGrupoValidado
        RETURN   && Valor nao mudou, nao revalidar
    ENDIF
    THIS.this_cUltimoGrupoValidado = loc_cGrupo
    IF EMPTY(loc_cGrupo)
        RETURN
    ENDIF
    THIS.AbrirBuscaGrupoSaldo()
ENDPROC
```

### Problema 46: COMMIT/ROLLBACK avulsos sem BEGIN TRANSACTION (CRITICO!)
A conexao ODBC do VFP opera em **AUTOCOMMIT** - cada SQLEXEC eh uma transacao implicita. NUNCA usar COMMIT/ROLLBACK avulsos apos UPDATE/INSERT/DELETE simples.

```foxpro
*-- ERRADO - ROLLBACK sem BEGIN TRANSACTION ? erro fatal:
TRY
    SQLEXEC(gnConnHandle, "UPDATE tabela SET ...", "cursor_4c_U")
    SQLEXEC(gnConnHandle, "COMMIT", "cursor_4c_Cmt")       && DESNECESSARIO em autocommit
CATCH
    SQLEXEC(gnConnHandle, "ROLLBACK", "cursor_4c_Rb")      && ERRO: no corresponding BEGIN TRANSACTION
ENDTRY

*-- CORRETO - Sem transacao explicita (autocommit):
TRY
    loc_nResult = SQLEXEC(gnConnHandle, "UPDATE tabela SET ...", "cursor_4c_U")
    IF loc_nResult < 0
        MsgErro("Erro: " + CapturarErroSQL(), "Erro SQL")
    ENDIF
CATCH TO loException
    MostrarErro(loException, "NomeMetodo")
ENDTRY

*-- CORRETO - Com transacao explicita (multi-statement):
*-- Usar SOMENTE quando precisa atualizar MULTIPLAS tabelas atomicamente
TRY
    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")     && OBRIGATORIO antes de COMMIT/ROLLBACK
    SQLEXEC(gnConnHandle, "UPDATE tabela1 SET ...")
    SQLEXEC(gnConnHandle, "UPDATE tabela2 SET ...")
    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
CATCH
    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
ENDTRY
```

### Problema 47: CheckBox.Value tipo inconsistente (CRITICO!)
CheckBox inicializado com .Value = .F. (logico) MAS comparado com = 1 ou resetado com = 0 (numerico) causa "Operator/operand type mismatch".

```foxpro
*-- ERRADO - Tipo mismatch:
.Value = .F.                              && Inicializado como LOGICO
loc_lNovo = (chk_4c_Campo.Value = 1)     && Comparando com NUMERICO ? ERRO!
chk_4c_Campo.Value = 0                    && Atribuindo NUMERICO ? ERRO!

*-- CORRETO - Tipo consistente:
.Value = .F.                              && Inicializado como LOGICO
loc_lNovo = (chk_4c_Campo.Value = .T.)   && LOGICO com LOGICO
chk_4c_Campo.Value = .F.                  && LOGICO
*-- Carregar de banco (campo numerico 0/1):
chk_4c_Campo.Value = (NVL(cursor.Concs, 0) = 1)  && Converte para LOGICO
```

### Problema 48: RecordSource reseta ControlSource via auto-bind (CRITICO!)
Quando .RecordSource eh (re)atribuido, VFP faz auto-bind dos campos do cursor para as colunas pela ORDEM dos campos no cursor (campo 1 ? Column1, campo 2 ? Column2), IGNORANDO qualquer ControlSource definido anteriormente. Isso causa dados desalinhados dos headers.

**REGRA 1**: NUNCA usar ColumnOrder. Definir colunas na ordem visual direta (Column1 = primeira coluna visual).
**REGRA 2**: Re-definir .ControlSource de TODAS as colunas APOS cada .RecordSource =.

```foxpro
*-- ERRADO - ControlSource definido ANTES de RecordSource (sera sobrescrito):
loc_oGrd.Column1.ControlSource = "cursor.Emps"    && Sera ignorado!
loc_oGrd.RecordSource = "cursor"                    && Auto-bind: Column1 recebe campo 1 do cursor

*-- CORRETO - ControlSource APOS RecordSource:
loc_oGrd.RecordSource = "cursor"
loc_oGrd.Column1.ControlSource = "cursor.Emps"     && Agora SIM funciona
loc_oGrd.Column2.ControlSource = "cursor.Datas"
loc_oGrd.Column1.Width = 30
loc_oGrd.Column2.Width = 71
```

### Problema 49: PageFrame AddObject + Tabs=.F. -> Page.Height runtime = PageFrame.Height + 4 (OPERACIONAL)

Em forms OPERACIONAL com PageFrame criado via AddObject e Tabs=.F., o VFP9 adiciona **+4** ao Page.Height em runtime. O ValidarUIFidelity compara valores em runtime e detecta a diferenca.

**REGRA**: Ao declarar .Height de PageFrame com Tabs=.F. em form OPERACIONAL, usar o valor do original **menos 4**:

```foxpro
*-- Original SCX tem Page.Height = 635 em runtime
*-- ERRADO - copia o valor bruto do original, runtime mostra +4:
WITH THIS.pgf_4c_1
    .Height = 635   && runtime: Page.Height = 639 -> DIFERENCA!
    .Tabs   = .F.
ENDWITH

*-- CORRETO - compensar -4 para que runtime = valor original:
WITH THIS.pgf_4c_1
    .Height = 631   && runtime: Page.Height = 635 -> CORRETO
    .Tabs   = .F.
ENDWITH
```

### Problema 50: MsgConfirma() retorna LOGICAL (.T./.F.), NAO numerico 6/7
MsgConfirma() de messages.prg faz RETURN lnResposta = 6 (logical). NUNCA usar IF var = 6.
`oxpro
*-- ERRADO: "Operator/operand type mismatch"
IF MsgConfirma("Confirma?","Titulo") = 6

*-- CORRETO:
IF MsgConfirma("Confirma?","Titulo")
`

### Problema 51: Botoes CRUD devem ficar do lado DIREITO (Grupo_op.Left)
No Framework, Grupo_op.Left = 543 (ou similar). Posicao real = Grupo_op.Left + Botao.Left.
NUNCA posicionar botoes a partir de Left=5 (esquerda). Ler o Left do container original e SOMAR.

### Problema 52: GridLines = 3 (ambas linhas) para grids de listagem
Framework Grade usa linhas H+V. GridLines = 1 mostra so horizontal. SEMPRE usar GridLines = 3.

### Problema 53: Labels ForeColor PRETO em fundo claro, BRANCO em fundo escuro
Labels say do Framework usam ForeColor escuro. Em Page2 com fundo claro, branco fica invisivel.
Posicoes/tamanhos EXATOS do original (Say1.Left, Say1.Top, Say1.Width, Say1.Height).

### Problema 54: Colunas com sufixo 's' (Tipos nao Tipo, Opers nao Oper)
Copiar EXATAMENTE do schema.sql. Original usa alias ('R' as Tipo) - nao confundir com coluna real (Tipos).

### Problema 55: Metodos PROTECTED chamados sem THIS. -> "File not found"
VFP9 busca .prg externo se nao tiver THIS. SEMPRE THIS.NomeMetodo() dentro da classe.

### Problema 56: CATCH NUNCA silencioso - sempre MsgErro no minimo
CATCH vazio engole erros. SEMPRE: MsgErro("Erro: " + loc_oErro.Message, "Erro") antes do cleanup.

### Problema 57: Form chama Excluir() (PUBLIC), BO sobrescreve ExecutarExclusao() (PROTECTED)
NUNCA chamar ExecutarExclusao() do Form - eh PROTECTED. Usar 	his_oBusinessObject.Excluir().

### Problema 58: Container nao tem .Themes em VFP9
Container.Themes = .F. causa "Property THEMES is not found". Remover. So CommandButton/Form/TextBox tem Themes.

### Problema 59: SQLEXEC QueryTimeOut em CarregarParametros/Init -> TIMEOUT no pipeline
Quando o form faz multiplos SQLEXEC no Init/CarregarParametros com QueryTimeOut=60s, e o banco esta lento, 5 queries x 60s = 300s = TIMEOUT do pipeline.
REGRA: Se gb_4c_ValidandoUI = .T. ou se eh CarregarParametros, usar SQLSETPROP(gnConnHandle, "QueryTimeOut", 10) no inicio e restaurar no final.

## Ordem de Desenvolvimento
1. Analisar codigo fonte .txt completo (campos, lookups, validacoes, grid, propriedades visuais)
2. Criar acuBO.prg
3. Criar Formacu.prg
4. **IMPLEMENTAR Init() correto** (OBRIGATORIO): apenas RETURN DODEFAULT()
5. **IMPLEMENTAR metodos auxiliares** (OBRIGATORIO):
   - TornarControlesVisiveis(par_oContainer) - copiar de FormCor.prg (linhas 956-984)
   - FormatarGridLista(par_oGrid) - copiar de FormCor.prg (linhas 945-953)
5. Implementar TODOS os lookups (procurar por fwbuscaext, fwBuscaSel, sigacess)
6. Implementar TODAS as validacoes (procurar por PROCEDURE Valid)
7. Configurar Grid (cabecalhos apos RecordSource!)
8. Compensar PageFrame se Top=-29
9. Criar mapeamento JSON

**IMPORTANTE - Metodos Auxiliares (NAO estao no FormBase):**

**TornarControlesVisiveis():**
- SEMPRE implementar no formulario
- SEMPRE chamar COM parametro: THIS.TornarControlesVisiveis(loc_oPagina)
- NUNCA chamar sem parametro: THIS.TornarControlesVisiveis() -> ERRO!
- Copiar de FormCor.prg (linhas 956-984)

**FormatarGridLista():**
- SEMPRE implementar no formulario
- SEMPRE chamar APOS carregar dados: THIS.FormatarGridLista(loc_oGrid)
- Define FontName="Tahoma", FontSize=8
- Copiar de FormCor.prg (linhas 945-953)

## Integracao com o Sistema (OBRIGATORIO)

Apos criar os arquivos .prg, voce DEVE integra-los ao sistema:

### 1. Atualizar config.prg
Arquivo: **C:\4c\projeto\app\start\config.prg**

Adicionar SET PROCEDURE na funcao ConfigurarAmbiente():

`oxpro
*-- Business Objects (adicionar apos os BOs existentes, linha ~228)
SET PROCEDURE TO (gcCaminhoClasses + "acuBO.prg") ADDITIVE

*-- Formularios (adicionar apos os Forms existentes, linha ~242)
SET PROCEDURE TO (gcCaminhoForms + "cadastros\Formacu.prg") ADDITIVE
`

### 2. Criar funcao no menu.prg
Arquivo: **C:\4c\projeto\app\menu\menu.prg**

Adicionar NO FINAL do arquivo (antes de ENDDEFINE se houver):

`oxpro
*------------------------------------------------------------------------------
* AbrirFormacu - Abre formulario de cadastro de [descricao]
*------------------------------------------------------------------------------
PROCEDURE AbrirFormacu()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("Formacu")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
            *-- NAO chamar loForm.Release() - FormBase cuida disso
        ELSE
            MostrarErro("Erro ao criar formulario Formacu", "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario Formacu:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC
`

### 3. Adicionar item no menu principal
Arquivo: **C:\4c\projeto\app\menu\menu.prg**

Na funcao CriarMenu(), adicionar item no popup CORRETO conforme o tipo:
- **CRUD (frmcadastro)**: popCadastros
- **REPORT (frmrelatorio)**: popRelatorios
- **OPERACIONAL (form)**: popMovimentos

**Passo 1**: Adicionar DEFINE BAR no popup correto (proximo numero disponivel)
`oxpro
*-- CRUD -> popCadastros:
DEFINE BAR N OF popCadastros PROMPT "[Descricao]" ;
       MESSAGE "Cadastro de [Descricao]"

*-- REPORT -> popRelatorios:
DEFINE BAR N OF popRelatorios PROMPT "[Descricao]" ;
       MESSAGE "Relat" + CHR(243) + "rio de [Descricao]"

*-- OPERACIONAL -> popMovimentos:
DEFINE BAR N OF popMovimentos PROMPT "[Descricao]" ;
       MESSAGE "[Descricao]"
`

**Passo 2**: Vincular acao (ON SELECTION no mesmo popup)
`oxpro
ON SELECTION BAR N OF popXxx DO AbrirFormacu
`

**IMPORTANTE**:
- Usar proximo BAR disponivel no popup correto
- Prompt deve ser curto e descritivo (sem acentos se possivel, ou usar CHR())
- MESSAGE e exibido na barra de status
- Criar PROCEDURE AbrirFormacu() no final do menu.prg

## Validacao Final

### Codigo (23 Problemas Criticos)
- [ ] **DEFINE CLASS**: Propriedades visuais (Height, Width, Caption, etc.) na definicao da classe
- [ ] **Init()**: APENAS RETURN DODEFAULT() (NAO chamar InicializarForm explicitamente)
- [ ] **Botoes**: Caption + Picture + PicturePosition=13 em TODOS (8 botoes)
- [ ] **Icones corretos**: Salvar=cadastro_salvar_60.jpg (NAO cadastro_confirmar_60.jpg)
- [ ] **Btn*Click**: Metodos PUBLIC (NAO PROTECTED) para funcionar com BINDEVENT
- [ ] **BtnIncluirClick**: Chamar NovoRegistro() E setar 	his_cModoAtual = "INCLUIR" ANTES de HabilitarCampos()
- [ ] **BtnAlterarClick**: Chamar EditarRegistro() APOS CarregarPorCodigo()
- [ ] **BtnBuscarClick**: FormBuscaAuxiliar com mAddColuna(), Show(1), 	his_lSelecionou, cursor (NAO tem ObterCodigoSelecionado)
- [ ] **Page.Picture**: Usar gc_4c_CaminhoIcones + "arquivo.jpg" (NAO caminho relativo)
- [ ] **CarregarPorCodigo**: Resetar THIS.this_lNovoRegistro = .F. apos carregar registro
- [ ] **BtnCancelarClick**: chama THIS.CarregarLista() ao voltar para lista
- [ ] **BtnSalvarClick**: Salvar() SEM parametro, validacoes FORA do TRY
- [ ] **Labels**: BackColor + ForeColor + FontName + FontSize COPIADOS do original
- [ ] PageFrame.Top e Tabs corretos
- [ ] Containers compensados (+29px se necessario)
- [ ] Grid com cabecalhos reconfigurados
- [ ] TornarControlesVisiveis() implementado + chamado COM parametro
- [ ] FormatarGridLista() implementado + chamado APOS carregar
- [ ] ConfigurarPaginaDados() com ENDPROC e chamada TornarControlesVisiveis()
- [ ] **BO**: Metodos ExecutarExclusao() (NAO Excluir) e CarregarPorCodigo() (NAO CarregarPorId)
- [ ] Todos os lookups funcionam (F4/DblClick)
- [ ] Todas as validacoes funcionam
- [ ] INCLUIR/ALTERAR/EXCLUIR/VISUALIZAR funcionam
- [ ] Form instancia sem erro "property not found"
- [ ] Grid exibe com fonte Tahoma tamanho 8
- [ ] **Queries SQL**: Tabelas e colunas EXATAS do codigo original (NAO inventar - conferir schema.sql)
- [ ] **Containers flutuantes**: Iniciam ocultos se original tinha Visible=.F. (TornarControlesVisiveis preserva)
- [ ] **Botoes alinhados**: Todos os botoes de uma mesma barra com MESMO Top (compensacao correta)

### Integracao (menu.prg + config.prg)
- [ ] SET PROCEDURE para BO adicionado no config.prg
- [ ] SET PROCEDURE para Form adicionado no config.prg
- [ ] **Funcao AbrirFormacu()**: usar VARTYPE, Show() sem parametro, SEM Release()
- [ ] Item do menu adicionado no popup CORRETO: CRUD=popCadastros, REPORT=popRelatorios, OPERACIONAL=popMovimentos (DEFINE BAR + ON SELECTION)

**IMPORTANTE**: So considerar completo apos:
1. Criar AMBOS os arquivos (.prg do BO e do Form)
2. Integrar com config.prg e menu.prg
3. Formulario acessivel via menu do sistema

Comecar agora.


---

## ?? REGRAS CRï¿½TICAS

### 1. Paridade Funcional 100%
**NUNCA criar versï¿½es reduzidas!** Incluir TODOS os campos, TODOS os mï¿½todos, TODAS as funcionalidades.

### 2. Fases Anteriores
Arquivos jï¿½ criados nas fases anteriores:   ? FASE 1: acuBO.prg (BO - propriedades e Init)   ? FASE 2: acuBO.prg (BO - mï¿½todos CRUD completo)   ? FASE 3: Formacu.prg (Form - estrutura base)   ? FASE 4: Formacu.prg (Form - Grid e botï¿½es CRUD)   ? FASE 5: Formacu.prg (Form - campos principais parte 1)   ? FASE 6: Formacu.prg (Form - campos restantes e lookups)

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
EXECUTE A FASE 7 AGORA!

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


