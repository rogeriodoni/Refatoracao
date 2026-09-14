# Templates para Novas Telas

Use estes templates como ponto de partida para criar novas funcionalidades.

## Template: Business Object

Copie e modifique conforme sua necessidade.

```foxpro
*==============================================================================
* NOMEENTIDADEBO.PRG
* Business Object para entidade [NomeEntidade]
*
* Tabela(s): [nome_tabela]
* Descrição: [Descreva a responsabilidade deste BO]
*==============================================================================

DEFINE CLASS [NomeEntidade]BO AS BusinessBase

    *-- Propriedades da entidade
    nId = 0
    * Adicione aqui as propriedades que representam os campos da tabela
    * cNomeCampo = ""
    * nValorCampo = 0
    * dDataCampo = {}
    * lBooleanCampo = .F.

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        * Chama construtor da classe base passando nome da tabela
        DODEFAULT("[nome_tabela]")
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValoresPadrao - Define valores padrão para novo registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValoresPadrao()
        * Defina valores padrão aqui
        * THIS.lAtivo = .T.
        * THIS.dDataCadastro = DATE()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validações específicas da entidade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        * Implemente suas validações aqui

        * Exemplo: Campo obrigatório
        * IF !ValidarCampoObrigatorio(THIS.cNome)
        *     THIS.cMensagemErro = "Nome é obrigatório"
        *     RETURN .F.
        * ENDIF

        * Exemplo: Validação de CPF
        * IF !EMPTY(THIS.cCPF) AND !ValidarCPF(THIS.cCPF)
        *     THIS.cMensagemErro = "CPF inválido"
        *     RETURN .F.
        * ENDIF

        * Exemplo: Validação de e-mail
        * IF !EMPTY(THIS.cEmail) AND !ValidarEmail(THIS.cEmail)
        *     THIS.cMensagemErro = "E-mail inválido"
        *     RETURN .F.
        * ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AntesDeGravar - Executado antes de inserir ou atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AntesDeGravar()
        * Implemente lógica de negócio que deve executar antes de salvar
        * Ex: calcular valores, normalizar dados, etc.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * DepoisDeGravar - Executado após inserir ou atualizar com sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DepoisDeGravar()
        * Implemente ações que devem executar após salvar
        * Ex: atualizar tabelas relacionadas, logs, etc.
    ENDPROC

    *--------------------------------------------------------------------------
    * AntesDeExcluir - Executado antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AntesDeExcluir()
        * Implemente validações antes de excluir
        * Ex: verificar se há registros dependentes

        * Exemplo: Verifica relacionamentos
        * LOCAL lcSQL, lnResultado
        * lcSQL = "SELECT COUNT(*) AS total FROM TabelaDependente WHERE chave_estrangeira = " + TRANSFORM(THIS.nId)
        * lnResultado = SQLEXEC(gnConnHandle, lcSQL, "cursor_4c_Verifica")
        * IF lnResultado > 0 AND cursor_4c_Verifica.total > 0
        *     USE IN cursor_4c_Verifica
        *     THIS.cMensagemErro = "Registro possui dependencias e nao pode ser excluido"
        *     RETURN .F.
        * ENDIF
        * IF USED("cursor_4c_Verifica")
        *     USE IN cursor_4c_Verifica
        * ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL lcSQL, lnResultado

        * Monte o SQL INSERT com os campos da sua tabela
        lcSQL = "INSERT INTO [nome_tabela] " + ;
                "(campo1, campo2, campo3) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.cCampo1) + ", " + ;
                TRANSFORM(THIS.nCampo2) + ", " + ;
                IIF(THIS.lCampo3, "1", "0") + ")"

        lnResultado = SQLEXEC(gnConnHandle, lcSQL)

        IF lnResultado < 0
            THIS.RegistrarErro(lnResultado, "Erro ao inserir [nome_entidade]")
            RETURN .F.
        ENDIF

        * Obtem ID gerado (se a tabela usar IDENTITY)
        lcSQL = "SELECT @@IDENTITY AS novo_id"
        lnResultado = SQLEXEC(gnConnHandle, lcSQL, "cursor_4c_NovoId")

        IF lnResultado > 0 AND RECCOUNT("cursor_4c_NovoId") > 0
            THIS.nId = cursor_4c_NovoId.novo_id
            USE IN cursor_4c_NovoId
        ENDIF

        * Registrar auditoria
        THIS.RegistrarAuditoria("INSERT")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL lcSQL, lnResultado

        * Monte o SQL UPDATE com os campos da sua tabela
        lcSQL = "UPDATE [nome_tabela] SET " + ;
                "campo1 = " + EscaparSQL(THIS.cCampo1) + ", " + ;
                "campo2 = " + TRANSFORM(THIS.nCampo2) + ", " + ;
                "campo3 = " + IIF(THIS.lCampo3, "1", "0") + " " + ;
                "WHERE id = " + TRANSFORM(THIS.nId)

        lnResultado = SQLEXEC(gnConnHandle, lcSQL)

        IF lnResultado < 0
            THIS.RegistrarErro(lnResultado, "Erro ao atualizar [nome_entidade]")
            RETURN .F.
        ENDIF

        * Registrar auditoria
        THIS.RegistrarAuditoria("UPDATE")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL lcSQL, lnResultado

        lcSQL = "DELETE FROM [nome_tabela] WHERE id = " + TRANSFORM(THIS.nId)
        lnResultado = SQLEXEC(gnConnHandle, lcSQL)

        IF lnResultado < 0
            THIS.RegistrarErro(lnResultado, "Erro ao excluir [nome_entidade]")
            RETURN .F.
        ENDIF

        * Registrar auditoria
        THIS.RegistrarAuditoria("DELETE")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.nId)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorId - Carrega registro pelo ID
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorId(pnId)
        LOCAL lcSQL, lnResultado

        lcSQL = "SELECT * FROM [nome_tabela] WHERE id = " + TRANSFORM(pnId)
        lnResultado = THIS.oDataAccess.ExecutarQuery(lcSQL, "cursor_4c_Dados")

        IF !lnResultado OR RECCOUNT("cursor_4c_Dados") = 0
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            RETURN .F.
        ENDIF

        THIS.CarregarDoCursor("cursor_4c_Dados")
        USE IN cursor_4c_Dados

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor para as propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(pcCursor)
        * Carregue cada campo do cursor para a propriedade correspondente
        THIS.nId = EVALUATE(pcCursor + ".id")
        * THIS.cCampo1 = TratarNulo(EVALUATE(pcCursor + ".campo1"), "")
        * THIS.nCampo2 = TratarNulo(EVALUATE(pcCursor + ".campo2"), 0)
        * THIS.dCampo3 = TratarNulo(EVALUATE(pcCursor + ".campo3"), {})
        * THIS.lCampo4 = EVALUATE(pcCursor + ".campo4") = 1

        RETURN .T.
    ENDPROC

ENDDEFINE
```

## Template: Formulário

```foxpro
*==============================================================================
* FORM[NOMEENTIDADE].PRG
* Formulário de cadastro de [Nome Entidade]
*
* Descrição: [Descreva a funcionalidade deste formulário]
*==============================================================================

DEFINE CLASS Form[NomeEntidade] AS FormBase

    *-- Configurações do form
    Width = 600
    Height = 500
    Caption = "Cadastro de [Nome Entidade]"
    cTituloForm = "Cadastro de [Nome Entidade]"

    *-- Controles (declare aqui os controles do formulário)
    * Labels
    * ADD OBJECT lblCampo1 AS Label

    * TextBoxes
    * ADD OBJECT txtCampo1 AS TextBox

    * ComboBoxes
    * ADD OBJECT cboCampo2 AS ComboBox

    * CheckBoxes
    * ADD OBJECT chkCampo3 AS CheckBox

    * Botões
    ADD OBJECT cmdNovo AS CommandButton
    ADD OBJECT cmdSalvar AS CommandButton
    ADD OBJECT cmdExcluir AS CommandButton
    ADD OBJECT cmdCancelar AS CommandButton
    ADD OBJECT cmdFechar AS CommandButton

    * Grid
    ADD OBJECT grd[NomeEntidade]s AS GridBase

    *--------------------------------------------------------------------------
    * InicializarForm - Inicialização específica do formulário
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        * Instancia Business Object
        THIS.oBusinessObject = CREATEOBJECT("[NomeEntidade]BO")

        * Configura controles
        THIS.ConfigurarControles()

        * Configura grid
        THIS.ConfigurarGrid()

        * Carrega lista inicial
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControles - Configura posições e propriedades dos controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
        * Configure cada controle aqui
        * Defina: Left, Top, Width, Height, Caption, MaxLength, etc.

        * Exemplo de Label e TextBox
        * WITH THIS.lblCampo1
        *     .Caption = "Campo 1:"
        *     .Left = 20
        *     .Top = 20
        *     .AutoSize = .T.
        * ENDWITH

        * WITH THIS.txtCampo1
        *     .Left = 100
        *     .Top = 18
        *     .Width = 300
        *     .MaxLength = 100
        * ENDWITH

        * Botões
        WITH THIS.cmdNovo
            .Caption = "Novo"
            .Left = 20
            .Top = 420
            .Width = 80
            .Height = 28
        ENDWITH

        WITH THIS.cmdSalvar
            .Caption = "Salvar"
            .Left = 110
            .Top = 420
            .Width = 80
            .Height = 28
        ENDWITH

        WITH THIS.cmdExcluir
            .Caption = "Excluir"
            .Left = 200
            .Top = 420
            .Width = 80
            .Height = 28
        ENDWITH

        WITH THIS.cmdCancelar
            .Caption = "Cancelar"
            .Left = 290
            .Top = 420
            .Width = 80
            .Height = 28
        ENDWITH

        WITH THIS.cmdFechar
            .Caption = "Fechar"
            .Left = 500
            .Top = 420
            .Width = 80
            .Height = 28
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Configura grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        DIMENSION laConfig[3, 4]

        * Configure as colunas do grid
        * [n, 1] = Nome do campo
        * [n, 2] = Caption
        * [n, 3] = Largura
        * [n, 4] = Alinhamento (0=Esq, 1=Dir, 2=Centro)

        laConfig[1, 1] = "id"
        laConfig[1, 2] = "Código"
        laConfig[1, 3] = 60
        laConfig[1, 4] = 1

        laConfig[2, 1] = "campo1"
        laConfig[2, 2] = "Campo 1"
        laConfig[2, 3] = 200

        laConfig[3, 1] = "campo2"
        laConfig[3, 2] = "Campo 2"
        laConfig[3, 3] = 150

        THIS.grd[NomeEntidade]s.ConfigurarColunas(@laConfig)
        THIS.grd[NomeEntidade]s.Left = 20
        THIS.grd[NomeEntidade]s.Top = 250
        THIS.grd[NomeEntidade]s.Width = 560
        THIS.grd[NomeEntidade]s.Height = 150
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega lista de registros no grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        * Busca registros e vincula ao grid
        IF THIS.oBusinessObject.Buscar("", "campo_ordenacao")
            THIS.grd[NomeEntidade]s.VincularCursor(THIS.oBusinessObject.oDataAccess.cCursorName)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do formulário para Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        * Transfira o valor de cada controle para a propriedade correspondente do BO
        WITH THIS.oBusinessObject
            * .cCampo1 = ALLTRIM(THIS.txtCampo1.Value)
            * .nCampo2 = THIS.txtCampo2.Value
            * .dCampo3 = THIS.txtCampo3.Value
            * .lCampo4 = THIS.chkCampo4.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object para formulário
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        * Transfira o valor de cada propriedade do BO para o controle correspondente
        WITH THIS.oBusinessObject
            * THIS.txtCampo1.Value = .cCampo1
            * THIS.txtCampo2.Value = .nCampo2
            * THIS.txtCampo3.Value = .dCampo3
            * THIS.chkCampo4.Value = .lCampo4
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos do formulário
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        * Limpe cada controle
        * THIS.txtCampo1.Value = ""
        * THIS.txtCampo2.Value = 0
        * THIS.txtCampo3.Value = {}
        * THIS.chkCampo4.Value = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarPrimeiroCampo - Posiciona no primeiro campo editável
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PosicionarPrimeiroCampo()
        * Coloque o foco no primeiro campo editável
        * THIS.txtCampo1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Atualiza habilitação/desabilitação de controles
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        IF THIS.lEmEdicao
            * Modo edição: habilita campos, desabilita grid
            * THIS.txtCampo1.Enabled = .T.
            THIS.cmdNovo.Enabled = .F.
            THIS.cmdSalvar.Enabled = .T.
            THIS.cmdExcluir.Enabled = .F.
            THIS.cmdCancelar.Enabled = .T.
            THIS.grd[NomeEntidade]s.Enabled = .F.
        ELSE
            * Modo consulta: desabilita campos, habilita grid
            * THIS.txtCampo1.Enabled = .F.
            THIS.cmdNovo.Enabled = .T.
            THIS.cmdSalvar.Enabled = .F.
            THIS.cmdExcluir.Enabled = .T.
            THIS.cmdCancelar.Enabled = .F.
            THIS.grd[NomeEntidade]s.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DepoisDeSalvar - Ações após salvar com sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DepoisDeSalvar()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * DepoisDeExcluir - Ações após excluir com sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DepoisDeExcluir()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * Eventos dos botões
    *--------------------------------------------------------------------------
    PROCEDURE cmdNovo.Click()
        THISFORM.Novo()
    ENDPROC

    PROCEDURE cmdSalvar.Click()
        THISFORM.Salvar()
    ENDPROC

    PROCEDURE cmdExcluir.Click()
        THISFORM.Excluir()
    ENDPROC

    PROCEDURE cmdCancelar.Click()
        THISFORM.Cancelar()
    ENDPROC

    PROCEDURE cmdFechar.Click()
        THISFORM.Fechar()
    ENDPROC

    *--------------------------------------------------------------------------
    * Evento do grid - Duplo clique para editar
    *--------------------------------------------------------------------------
    PROCEDURE grd[NomeEntidade]s.DblClick()
        LOCAL lnId

        IF THIS.TemRegistros()
            lnId = THIS.ObterValorColunaAtual("id")

            IF lnId > 0
                THISFORM.oBusinessObject.CarregarPorId(lnId)
                THISFORM.BOParaForm()
                THISFORM.IniciarEdicao()
            ENDIF
        ENDIF
    ENDPROC

ENDDEFINE
```

## Como Usar os Templates

1. **Copie o template** apropriado (BO ou Form)
2. **Substitua** `[NomeEntidade]` pelo nome da sua entidade
3. **Substitua** `[nome_tabela]` pelo nome da tabela no banco
4. **Adicione** as propriedades específicas da entidade
5. **Implemente** as validações necessárias
6. **Configure** os controles do formulário
7. **Teste** todas as operações

## Checklist ao Usar Template

### Business Object
- [ ] Nome da classe correto
- [ ] Nome da tabela correto
- [ ] Todas as propriedades declaradas
- [ ] ValidarDados() implementado
- [ ] Inserir() implementado
- [ ] Atualizar() implementado
- [ ] ExecutarExclusao() implementado
- [ ] CarregarDoCursor() implementado

### Formulário
- [ ] Nome da classe correto
- [ ] Todos os controles declarados
- [ ] ConfigurarControles() com posições corretas
- [ ] ConfigurarGrid() com colunas corretas
- [ ] FormParaBO() implementado
- [ ] BOParaForm() implementado
- [ ] LimparCampos() implementado
- [ ] PosicionarPrimeiroCampo() implementado
- [ ] AtualizarEstadoControles() implementado
