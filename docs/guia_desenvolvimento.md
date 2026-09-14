# Guia de Desenvolvimento

## Como Criar uma Nova Tela

Este guia explica o processo passo a passo para criar uma nova funcionalidade no sistema.

### Etapa 1: Análise do Código Original

Quando receber o código original (.txt) e print da tela:

1. **Identifique as funcionalidades:**
   - Quais operações a tela permite? (inclusão, edição, exclusão, consulta)
   - Há cálculos ou processamentos especiais?
   - Quais validações são aplicadas?

2. **Identifique as tabelas:**
   - Tabelas principais e relacionadas
   - Campos utilizados
   - Relacionamentos (chaves estrangeiras)

3. **Identifique as regras de negócio:**
   - Validações específicas
   - Campos obrigatórios
   - Valores padrão
   - Restrições

4. **Documente as mensagens:**
   - Liste todas as mensagens exibidas ao usuário
   - Mensagens de erro
   - Mensagens de sucesso
   - Mensagens de confirmação

### Etapa 2: Criar o Business Object

O Business Object encapsula as regras de negócio e validações.

#### Exemplo: ClienteBO

```foxpro
*==============================================================================
* CLIENTEBO.PRG
* Business Object para entidade Cliente
*==============================================================================

DEFINE CLASS ClienteBO AS BusinessBase

    *-- Propriedades da entidade
    nId = 0
    cNome = ""
    cCPF = ""
    cTelefone = ""
    cEmail = ""
    cEndereco = ""
    cCidade = ""
    cEstado = ""
    cCEP = ""
    lAtivo = .T.
    dDataCadastro = {}

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        * Chama construtor da classe base
        DODEFAULT("Clientes")
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValoresPadrao - Define valores padrão para novo registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.lAtivo = .T.
        THIS.dDataCadastro = DATE()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validações específicas do cliente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        * Valida nome
        IF !ValidarCampoObrigatorio(THIS.cNome)
            THIS.cMensagemErro = "Nome é obrigatório"
            RETURN .F.
        ENDIF

        * Valida CPF
        IF !EMPTY(THIS.cCPF) AND !ValidarCPF(THIS.cCPF)
            THIS.cMensagemErro = "CPF inválido"
            RETURN .F.
        ENDIF

        * Valida e-mail
        IF !EMPTY(THIS.cEmail) AND !ValidarEmail(THIS.cEmail)
            THIS.cMensagemErro = "E-mail inválido"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo cliente no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL lcSQL, lnResultado

        lcSQL = "INSERT INTO Clientes " + ;
                "(nome, cpf, telefone, email, endereco, cidade, estado, cep, ativo, data_cadastro) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.cNome) + ", " + ;
                EscaparSQL(THIS.cCPF) + ", " + ;
                EscaparSQL(THIS.cTelefone) + ", " + ;
                EscaparSQL(THIS.cEmail) + ", " + ;
                EscaparSQL(THIS.cEndereco) + ", " + ;
                EscaparSQL(THIS.cCidade) + ", " + ;
                EscaparSQL(THIS.cEstado) + ", " + ;
                EscaparSQL(THIS.cCEP) + ", " + ;
                IIF(THIS.lAtivo, "1", "0") + ", " + ;
                EscaparSQL(FormatarData(THIS.dDataCadastro, "YYYY-MM-DD")) + ")"

        lnResultado = SQLEXEC(gnConnHandle, lcSQL)

        IF lnResultado < 0
            THIS.RegistrarErro(lnResultado, "Erro ao inserir cliente")
            RETURN .F.
        ENDIF

        * Obtém ID gerado
        lcSQL = "SELECT @@IDENTITY AS novo_id"
        lnResultado = SQLEXEC(gnConnHandle, lcSQL, "curNovoId")

        IF lnResultado > 0 AND RECCOUNT("curNovoId") > 0
            THIS.nId = curNovoId.novo_id
            USE IN curNovoId
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza cliente existente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL lcSQL, lnResultado

        lcSQL = "UPDATE Clientes SET " + ;
                "nome = " + EscaparSQL(THIS.cNome) + ", " + ;
                "cpf = " + EscaparSQL(THIS.cCPF) + ", " + ;
                "telefone = " + EscaparSQL(THIS.cTelefone) + ", " + ;
                "email = " + EscaparSQL(THIS.cEmail) + ", " + ;
                "endereco = " + EscaparSQL(THIS.cEndereco) + ", " + ;
                "cidade = " + EscaparSQL(THIS.cCidade) + ", " + ;
                "estado = " + EscaparSQL(THIS.cEstado) + ", " + ;
                "cep = " + EscaparSQL(THIS.cCEP) + ", " + ;
                "ativo = " + IIF(THIS.lAtivo, "1", "0") + " " + ;
                "WHERE id = " + TRANSFORM(THIS.nId)

        lnResultado = SQLEXEC(gnConnHandle, lcSQL)

        IF lnResultado < 0
            THIS.RegistrarErro(lnResultado, "Erro ao atualizar cliente")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui cliente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL lcSQL, lnResultado

        * Verifica se cliente tem pedidos vinculados
        lcSQL = "SELECT COUNT(*) AS total FROM Pedidos WHERE cliente_id = " + TRANSFORM(THIS.nId)
        lnResultado = SQLEXEC(gnConnHandle, lcSQL, "curVerifica")

        IF lnResultado > 0 AND curVerifica.total > 0
            USE IN curVerifica
            THIS.cMensagemErro = "Cliente possui pedidos vinculados e não pode ser excluído"
            RETURN .F.
        ENDIF

        IF USED("curVerifica")
            USE IN curVerifica
        ENDIF

        * Exclui cliente
        lcSQL = "DELETE FROM Clientes WHERE id = " + TRANSFORM(THIS.nId)
        lnResultado = SQLEXEC(gnConnHandle, lcSQL)

        IF lnResultado < 0
            THIS.RegistrarErro(lnResultado, "Erro ao excluir cliente")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorId - Carrega cliente pelo ID
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorId(pnId)
        LOCAL lcSQL, lnResultado

        lcSQL = "SELECT * FROM Clientes WHERE id = " + TRANSFORM(pnId)
        lnResultado = THIS.oDataAccess.ExecutarQuery(lcSQL, "curCliente")

        IF !lnResultado OR RECCOUNT("curCliente") = 0
            IF USED("curCliente")
                USE IN curCliente
            ENDIF
            RETURN .F.
        ENDIF

        * Carrega dados do cursor para as propriedades
        THIS.CarregarDoCursor("curCliente")

        USE IN curCliente
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor para as propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(pcCursor)
        THIS.nId = EVALUATE(pcCursor + ".id")
        THIS.cNome = TratarNulo(EVALUATE(pcCursor + ".nome"), "")
        THIS.cCPF = TratarNulo(EVALUATE(pcCursor + ".cpf"), "")
        THIS.cTelefone = TratarNulo(EVALUATE(pcCursor + ".telefone"), "")
        THIS.cEmail = TratarNulo(EVALUATE(pcCursor + ".email"), "")
        THIS.cEndereco = TratarNulo(EVALUATE(pcCursor + ".endereco"), "")
        THIS.cCidade = TratarNulo(EVALUATE(pcCursor + ".cidade"), "")
        THIS.cEstado = TratarNulo(EVALUATE(pcCursor + ".estado"), "")
        THIS.cCEP = TratarNulo(EVALUATE(pcCursor + ".cep"), "")
        THIS.lAtivo = EVALUATE(pcCursor + ".ativo") = 1
        THIS.dDataCadastro = TratarNulo(EVALUATE(pcCursor + ".data_cadastro"), {})

        RETURN .T.
    ENDPROC

ENDDEFINE
```

### Etapa 3: Criar o Formulário

O formulário é responsável apenas pela interface do usuário.

#### Exemplo: FormCliente (estrutura programática)

```foxpro
*==============================================================================
* FORMCLIENTE.PRG
* Formulário de cadastro de clientes
*==============================================================================

DEFINE CLASS FormCliente AS FormBase

    *-- Configurações do form
    Width = 600
    Height = 500
    Caption = "Cadastro de Clientes"
    cTituloForm = "Cadastro de Clientes"

    *-- Controles (declaração)
    ADD OBJECT txtNome AS TextBox
    ADD OBJECT txtCPF AS TextBox
    ADD OBJECT txtTelefone AS TextBox
    ADD OBJECT txtEmail AS TextBox
    ADD OBJECT txtEndereco AS TextBox
    ADD OBJECT txtCidade AS TextBox
    ADD OBJECT cboEstado AS ComboBox
    ADD OBJECT txtCEP AS TextBox
    ADD OBJECT chkAtivo AS CheckBox
    ADD OBJECT cmdNovo AS CommandButton
    ADD OBJECT cmdSalvar AS CommandButton
    ADD OBJECT cmdExcluir AS CommandButton
    ADD OBJECT cmdCancelar AS CommandButton
    ADD OBJECT cmdFechar AS CommandButton
    ADD OBJECT grdClientes AS GridBase

    *--------------------------------------------------------------------------
    * InicializarForm - Inicialização específica do formulário
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        * Instancia Business Object
        THIS.oBusinessObject = CREATEOBJECT("ClienteBO")

        * Configura controles
        THIS.ConfigurarControles()

        * Configura grid
        THIS.ConfigurarGrid()

        * Carrega lista de clientes
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControles - Configura posições e propriedades dos controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
        * Labels e TextBoxes (configurar posições conforme layout original)
        WITH THIS.txtNome
            .Left = 100
            .Top = 50
            .Width = 400
            .MaxLength = 100
        ENDWITH

        * ... configurar demais controles ...

        * Botões
        WITH THIS.cmdNovo
            .Caption = "Novo"
            .Left = 20
            .Top = 420
            .Width = 80
        ENDWITH

        * ... configurar demais botões ...
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Configura grid de clientes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        DIMENSION laConfig[5, 4]

        * Define colunas do grid
        laConfig[1, 1] = "id"
        laConfig[1, 2] = "Código"
        laConfig[1, 3] = 60
        laConfig[1, 4] = 1  && Alinhamento direita

        laConfig[2, 1] = "nome"
        laConfig[2, 2] = "Nome"
        laConfig[2, 3] = 200

        laConfig[3, 1] = "cpf"
        laConfig[3, 2] = "CPF"
        laConfig[3, 3] = 100

        laConfig[4, 1] = "telefone"
        laConfig[4, 2] = "Telefone"
        laConfig[4, 3] = 100

        laConfig[5, 1] = "cidade"
        laConfig[5, 2] = "Cidade"
        laConfig[5, 3] = 150

        * Configura o grid
        THIS.grdClientes.ConfigurarColunas(@laConfig)
        THIS.grdClientes.Left = 20
        THIS.grdClientes.Top = 250
        THIS.grdClientes.Width = 560
        THIS.grdClientes.Height = 150
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega lista de clientes no grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF THIS.oBusinessObject.Buscar("", "nome")
            THIS.grdClientes.VincularCursor(THIS.oBusinessObject.oDataAccess.cCursorName)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do formulário para Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.oBusinessObject
            .cNome = ALLTRIM(THIS.txtNome.Value)
            .cCPF = SomenteNumeros(THIS.txtCPF.Value)
            .cTelefone = SomenteNumeros(THIS.txtTelefone.Value)
            .cEmail = ALLTRIM(THIS.txtEmail.Value)
            .cEndereco = ALLTRIM(THIS.txtEndereco.Value)
            .cCidade = ALLTRIM(THIS.txtCidade.Value)
            .cEstado = THIS.cboEstado.Value
            .cCEP = SomenteNumeros(THIS.txtCEP.Value)
            .lAtivo = THIS.chkAtivo.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object para formulário
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        WITH THIS.oBusinessObject
            THIS.txtNome.Value = .cNome
            THIS.txtCPF.Value = FormatarCPF(.cCPF)
            THIS.txtTelefone.Value = FormatarTelefone(.cTelefone)
            THIS.txtEmail.Value = .cEmail
            THIS.txtEndereco.Value = .cEndereco
            THIS.txtCidade.Value = .cCidade
            THIS.cboEstado.Value = .cEstado
            THIS.txtCEP.Value = FormatarCEP(.cCEP)
            THIS.chkAtivo.Value = .lAtivo
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos do formulário
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txtNome.Value = ""
        THIS.txtCPF.Value = ""
        THIS.txtTelefone.Value = ""
        THIS.txtEmail.Value = ""
        THIS.txtEndereco.Value = ""
        THIS.txtCidade.Value = ""
        THIS.cboEstado.Value = ""
        THIS.txtCEP.Value = ""
        THIS.chkAtivo.Value = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarPrimeiroCampo - Posiciona no primeiro campo editável
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PosicionarPrimeiroCampo()
        THIS.txtNome.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * DepoisDeSalvar - Ações após salvar com sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DepoisDeSalvar()
        * Recarrega lista
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * DepoisDeExcluir - Ações após excluir com sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DepoisDeExcluir()
        * Recarrega lista
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
    PROCEDURE grdClientes.DblClick()
        LOCAL lnId

        IF THIS.TemRegistros()
            lnId = THIS.ObterValorColunaAtual("id")

            IF lnId > 0
                * Carrega cliente selecionado
                THISFORM.oBusinessObject.CarregarPorId(lnId)
                THISFORM.BOParaForm()
                THISFORM.EditarRegistro()
            ENDIF
        ENDIF
    ENDPROC

ENDDEFINE
```

### Etapa 4: Integrar ao Menu

Adicionar item no menu para abrir o formulário:

```foxpro
* No menu.prg ou menu.mnx:
ON SELECTION BAR 1 OF popCadastros DO AbrirClientes

PROCEDURE AbrirClientes()
    DO FORM forms\formcliente
ENDPROC
```

### Etapa 5: Testar

Checklist de testes:

- [ ] Inclusão de novo registro
- [ ] Edição de registro existente
- [ ] Exclusão de registro
- [ ] Validações funcionando
- [ ] Mensagens corretas
- [ ] Layout idêntico ao original
- [ ] Botões funcionando
- [ ] Grid carregando dados
- [ ] Duplo clique no grid
- [ ] Teclas de atalho

## Estrutura de Arquivos por Módulo

Recomenda-se organizar os forms por módulo:

```
/app/forms/
    /cadastros/
        formcliente.prg
        formproduto.prg
        formfornecedor.prg
    /movimentos/
        formpedido.prg
        formnotafiscal.prg
    /relatorios/
        relatorioclientes.prg
```

## Dicas Importantes

1. **Sempre comece pela análise** - Entenda completamente o código original antes de reescrever

2. **Business Object primeiro** - Crie o BO antes do Form para ter as regras de negócio definidas

3. **Reutilize validações** - Use as funções de validators.prg sempre que possível

4. **Mensagens padronizadas** - Use messages.prg para todas as mensagens

5. **Teste incremental** - Teste cada parte antes de passar para a próxima

6. **Mantenha o visual original** - Use o print fornecido como referência exata

7. **Documente decisões** - Se tomar decisões diferentes do original, documente o porquê

8. **Nunca copie código antigo** - Sempre reescreva aplicando a nova arquitetura

## Exemplo Completo de Workflow

1. Recebo: `cliente.txt` + `print_cliente.png`

2. Analiso o código original:
   - Tabela: Clientes
   - Campos: id, nome, cpf, telefone, email, endereco, cidade, estado, cep, ativo
   - Operações: CRUD completo
   - Validações: nome obrigatório, CPF válido, email válido
   - Mensagem de sucesso: "Cliente salvo com sucesso!"

3. Crio `ClienteBO.prg` com todas as regras

4. Crio `FormCliente.prg` seguindo o layout do print

5. Testo todas as operações

6. Adiciono ao menu

7. Entrego:
   - Análise documentada
   - ClienteBO.prg
   - FormCliente.prg
   - Observações sobre decisões tomadas
