# Exemplo Completo: Cadastro de Estados

Este é um exemplo completo e funcional de um cadastro simples para servir de referência.

## Estrutura da Tabela

```sql
CREATE TABLE Estados (
    id INT PRIMARY KEY IDENTITY(1,1),
    sigla CHAR(2) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    ativo BIT DEFAULT 1
)
```

## Business Object: EstadoBO.prg

```foxpro
*==============================================================================
* ESTADOBO.PRG
* Business Object para entidade Estado
*==============================================================================

DEFINE CLASS EstadoBO AS BusinessBase

    *-- Propriedades da entidade
    nId = 0
    cSigla = ""
    cNome = ""
    lAtivo = .T.

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("Estados")
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValoresPadrao - Define valores padrão
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.lAtivo = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validações
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        * Valida sigla
        IF !ValidarCampoObrigatorio(THIS.cSigla)
            THIS.cMensagemErro = "Sigla é obrigatória"
            RETURN .F.
        ENDIF

        IF LEN(ALLTRIM(THIS.cSigla)) != 2
            THIS.cMensagemErro = "Sigla deve ter 2 caracteres"
            RETURN .F.
        ENDIF

        * Valida nome
        IF !ValidarCampoObrigatorio(THIS.cNome)
            THIS.cMensagemErro = "Nome é obrigatório"
            RETURN .F.
        ENDIF

        * Verifica se sigla já existe (para novos ou ao alterar)
        IF !THIS.VerificarSiglaUnica()
            THIS.cMensagemErro = "Já existe um estado com esta sigla"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarSiglaUnica - Verifica se sigla já existe
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerificarSiglaUnica()
        LOCAL lcSQL, lnResultado

        lcSQL = "SELECT COUNT(*) AS total FROM Estados " + ;
                "WHERE sigla = " + EscaparSQL(THIS.cSigla) + ;
                " AND id <> " + TRANSFORM(THIS.nId)

        lnResultado = SQLEXEC(gnConnHandle, lcSQL, "curVerifica")

        IF lnResultado > 0 AND curVerifica.total > 0
            USE IN curVerifica
            RETURN .F.
        ENDIF

        IF USED("curVerifica")
            USE IN curVerifica
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo estado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL lcSQL, lnResultado

        lcSQL = "INSERT INTO Estados (sigla, nome, ativo) VALUES (" + ;
                EscaparSQL(UPPER(ALLTRIM(THIS.cSigla))) + ", " + ;
                EscaparSQL(THIS.cNome) + ", " + ;
                IIF(THIS.lAtivo, "1", "0") + ")"

        lnResultado = SQLEXEC(gnConnHandle, lcSQL)

        IF lnResultado < 0
            THIS.RegistrarErro(lnResultado, "Erro ao inserir estado")
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
    * Atualizar - Atualiza estado existente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL lcSQL, lnResultado

        lcSQL = "UPDATE Estados SET " + ;
                "sigla = " + EscaparSQL(UPPER(ALLTRIM(THIS.cSigla))) + ", " + ;
                "nome = " + EscaparSQL(THIS.cNome) + ", " + ;
                "ativo = " + IIF(THIS.lAtivo, "1", "0") + " " + ;
                "WHERE id = " + TRANSFORM(THIS.nId)

        lnResultado = SQLEXEC(gnConnHandle, lcSQL)

        IF lnResultado < 0
            THIS.RegistrarErro(lnResultado, "Erro ao atualizar estado")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui estado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL lcSQL, lnResultado

        * Verifica se há cidades vinculadas
        lcSQL = "SELECT COUNT(*) AS total FROM Cidades WHERE estado_id = " + TRANSFORM(THIS.nId)
        lnResultado = SQLEXEC(gnConnHandle, lcSQL, "curVerifica")

        IF lnResultado > 0 AND curVerifica.total > 0
            USE IN curVerifica
            THIS.cMensagemErro = "Estado possui cidades vinculadas e não pode ser excluído"
            RETURN .F.
        ENDIF

        IF USED("curVerifica")
            USE IN curVerifica
        ENDIF

        * Exclui estado
        lcSQL = "DELETE FROM Estados WHERE id = " + TRANSFORM(THIS.nId)
        lnResultado = SQLEXEC(gnConnHandle, lcSQL)

        IF lnResultado < 0
            THIS.RegistrarErro(lnResultado, "Erro ao excluir estado")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorId - Carrega estado pelo ID
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorId(pnId)
        LOCAL lcSQL, lnResultado

        lcSQL = "SELECT * FROM Estados WHERE id = " + TRANSFORM(pnId)
        lnResultado = THIS.oDataAccess.ExecutarQuery(lcSQL, "curEstado")

        IF !lnResultado OR RECCOUNT("curEstado") = 0
            IF USED("curEstado")
                USE IN curEstado
            ENDIF
            RETURN .F.
        ENDIF

        THIS.CarregarDoCursor("curEstado")
        USE IN curEstado

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(pcCursor)
        THIS.nId = EVALUATE(pcCursor + ".id")
        THIS.cSigla = TratarNulo(EVALUATE(pcCursor + ".sigla"), "")
        THIS.cNome = TratarNulo(EVALUATE(pcCursor + ".nome"), "")
        THIS.lAtivo = EVALUATE(pcCursor + ".ativo") = 1

        RETURN .T.
    ENDPROC

ENDDEFINE
```

## Formulário: FormEstado.prg

```foxpro
*==============================================================================
* FORMESTADO.PRG
* Formulário de cadastro de estados
*==============================================================================

DEFINE CLASS FormEstado AS FormBase

    *-- Configurações do form
    Width = 600
    Height = 450
    Caption = "Cadastro de Estados"
    cTituloForm = "Cadastro de Estados"

    *-- Controles
    ADD OBJECT lblSigla AS Label
    ADD OBJECT txtSigla AS TextBox
    ADD OBJECT lblNome AS Label
    ADD OBJECT txtNome AS TextBox
    ADD OBJECT chkAtivo AS CheckBox
    ADD OBJECT cmdNovo AS CommandButton
    ADD OBJECT cmdSalvar AS CommandButton
    ADD OBJECT cmdExcluir AS CommandButton
    ADD OBJECT cmdCancelar AS CommandButton
    ADD OBJECT cmdFechar AS CommandButton
    ADD OBJECT grdEstados AS GridBase

    *--------------------------------------------------------------------------
    * InicializarForm
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        * Instancia Business Object
        THIS.oBusinessObject = CREATEOBJECT("EstadoBO")

        * Configura controles
        THIS.ConfigurarControles()

        * Configura grid
        THIS.ConfigurarGrid()

        * Carrega lista
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
        * Label e TextBox Sigla
        WITH THIS.lblSigla
            .Caption = "Sigla:"
            .Left = 20
            .Top = 20
            .AutoSize = .T.
        ENDWITH

        WITH THIS.txtSigla
            .Left = 100
            .Top = 18
            .Width = 60
            .MaxLength = 2
            .InputMask = "!!"
        ENDWITH

        * Label e TextBox Nome
        WITH THIS.lblNome
            .Caption = "Nome:"
            .Left = 20
            .Top = 50
            .AutoSize = .T.
        ENDWITH

        WITH THIS.txtNome
            .Left = 100
            .Top = 48
            .Width = 400
            .MaxLength = 50
        ENDWITH

        * CheckBox Ativo
        WITH THIS.chkAtivo
            .Caption = "Ativo"
            .Left = 100
            .Top = 78
            .Value = .T.
        ENDWITH

        * Botões
        WITH THIS.cmdNovo
            .Caption = "Novo"
            .Left = 20
            .Top = 380
            .Width = 80
            .Height = 28
        ENDWITH

        WITH THIS.cmdSalvar
            .Caption = "Salvar"
            .Left = 110
            .Top = 380
            .Width = 80
            .Height = 28
        ENDWITH

        WITH THIS.cmdExcluir
            .Caption = "Excluir"
            .Left = 200
            .Top = 380
            .Width = 80
            .Height = 28
        ENDWITH

        WITH THIS.cmdCancelar
            .Caption = "Cancelar"
            .Left = 290
            .Top = 380
            .Width = 80
            .Height = 28
        ENDWITH

        WITH THIS.cmdFechar
            .Caption = "Fechar"
            .Left = 500
            .Top = 380
            .Width = 80
            .Height = 28
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        DIMENSION laConfig[4, 4]

        laConfig[1, 1] = "id"
        laConfig[1, 2] = "Código"
        laConfig[1, 3] = 60
        laConfig[1, 4] = 1

        laConfig[2, 1] = "sigla"
        laConfig[2, 2] = "Sigla"
        laConfig[2, 3] = 60
        laConfig[2, 4] = 2

        laConfig[3, 1] = "nome"
        laConfig[3, 2] = "Nome"
        laConfig[3, 3] = 300

        laConfig[4, 1] = "ativo"
        laConfig[4, 2] = "Ativo"
        laConfig[4, 3] = 60
        laConfig[4, 4] = 2

        THIS.grdEstados.ConfigurarColunas(@laConfig)
        THIS.grdEstados.Left = 20
        THIS.grdEstados.Top = 120
        THIS.grdEstados.Width = 560
        THIS.grdEstados.Height = 240
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF THIS.oBusinessObject.Buscar("", "nome")
            THIS.grdEstados.VincularCursor(THIS.oBusinessObject.oDataAccess.cCursorName)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.oBusinessObject
            .cSigla = UPPER(ALLTRIM(THIS.txtSigla.Value))
            .cNome = ALLTRIM(THIS.txtNome.Value)
            .lAtivo = THIS.chkAtivo.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        WITH THIS.oBusinessObject
            THIS.txtSigla.Value = .cSigla
            THIS.txtNome.Value = .cNome
            THIS.chkAtivo.Value = .lAtivo
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txtSigla.Value = ""
        THIS.txtNome.Value = ""
        THIS.chkAtivo.Value = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarPrimeiroCampo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PosicionarPrimeiroCampo()
        THIS.txtSigla.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        * Em modo edição: habilita campos, desabilita grid
        IF THIS.lEmEdicao
            THIS.txtSigla.Enabled = .T.
            THIS.txtNome.Enabled = .T.
            THIS.chkAtivo.Enabled = .T.
            THIS.cmdNovo.Enabled = .F.
            THIS.cmdSalvar.Enabled = .T.
            THIS.cmdExcluir.Enabled = .F.
            THIS.cmdCancelar.Enabled = .T.
            THIS.grdEstados.Enabled = .F.
        ELSE
            * Em modo consulta: desabilita campos, habilita grid
            THIS.txtSigla.Enabled = .F.
            THIS.txtNome.Enabled = .F.
            THIS.chkAtivo.Enabled = .F.
            THIS.cmdNovo.Enabled = .T.
            THIS.cmdSalvar.Enabled = .F.
            THIS.cmdExcluir.Enabled = .T.
            THIS.cmdCancelar.Enabled = .F.
            THIS.grdEstados.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DepoisDeSalvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DepoisDeSalvar()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * DepoisDeExcluir
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
    PROCEDURE grdEstados.DblClick()
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

## Como Usar Este Exemplo

1. **Crie a tabela no SQL Server** usando o script fornecido

2. **Salve os arquivos:**
   - `EstadoBO.prg` em `C:\4c\projeto\app\classes\`
   - `FormEstado.prg` em `C:\4c\projeto\app\forms\cadastros\`

3. **Adicione ao menu:**
   ```foxpro
   DEFINE BAR 6 OF popCadastros PROMPT "Estados"
   ON SELECTION BAR 6 OF popCadastros DO AbrirEstados

   PROCEDURE AbrirEstados()
       DO FORM forms\cadastros\formestado
   ENDPROC
   ```

4. **Execute e teste:**
   - Inclusão de novos estados
   - Edição de estados existentes
   - Exclusão (testará a validação de cidades vinculadas)
   - Validações (sigla obrigatória, nome obrigatório, sigla única)

## Pontos de Aprendizado

Este exemplo demonstra:

1. **Herança:** EstadoBO herda de BusinessBase, FormEstado herda de FormBase
2. **Validações:** No método ValidarDados() do BO
3. **Regra de negócio:** Verificação de sigla única
4. **CRUD completo:** Insert, Update, Delete, Select
5. **Verificação de integridade:** Não permite excluir se houver cidades vinculadas
6. **Binding de dados:** FormParaBO e BOParaForm
7. **Controle de estado:** AtualizarEstadoControles habilita/desabilita campos
8. **Grid integrado:** Listagem e seleção por duplo clique

Use este exemplo como base para criar cadastros mais complexos!
