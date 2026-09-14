# Lookup Implementation Guide

## Lookup Tables Reference

Tabelas auxiliares usadas para lookups em formulários:

| Tabela | Campo Código | Campo Descrição | Uso |
|--------|--------------|-----------------|-----|
| SigCdGrp | cgrus | dgrus | Grupos de produtos |
| SigCdPsg | codigos | descricaos | SubGrupos (filtrar por cgrus) |
| SigCdUni | cunis | dunis | Unidades de medida |
| SigCdLin | codigos | descrs | Linhas de produtos |
| SigCdCol | codigos | descrs | Coleções |
| SigCdMoe | cmoes | dmoes | Moedas |
| SigCdTam | cods | descs | Tamanhos |
| SigCdCor | cods | descs | Cores |
| SigCdAca | cods | descrs | Acabamentos |
| SIGCDFIP | cods | descs | Códigos Fiscais |
| SigPrLcl | codigos | descricaos | Localizações |
| SIGCDCLI | iclis | nomes | Clientes/Fornecedores |
| SigCdPro | cpros | dpros | Produtos (auto-referência) |
| SigCdGcr | codigos | descrs | Grupos Financeiros (Cargos) |
| SigCdCrg | ccargs | dcargs | Cargos |
| SigReCtb | contas | descs | Contas Contabeis |
| SIGCRRCC | - | - | Centro de Custo por Cargo (subtabela) |

## Implementação de Lookups em Formulários

Cada campo com lookup requer 3 métodos e 3 BINDEVENTs:

```foxpro
*-- 1. Adicionar BINDEVENTs na configuração do form
BINDEVENT(loc_oAba.txt_4c_Campo, "DblClick", THIS, "AbrirBuscaCampo")
BINDEVENT(loc_oAba.txt_4c_Campo, "KeyPress", THIS, "TeclaLookupCampo")
BINDEVENT(loc_oAba.txt_4c_Campo, "LostFocus", THIS, "ValidarCampo")

*-- 2. Método TeclaLookup - Dispara busca com F4/F5
PROCEDURE TeclaLookupCampo(par_nKeyCode, par_nShiftAltCtrl)
    IF INLIST(par_nKeyCode, 115, 116)  && F4=115, F5=116
        THIS.AbrirBuscaCampo()
    ENDIF
ENDPROC

*-- 3. Método AbrirBusca - Usa FormBuscaAuxiliar
PROCEDURE AbrirBuscaCampo()
    LOCAL loc_oAba, loc_cValor, loc_oForm
    loc_oAba = THIS.pgf_4c_Principal.Page2.pgf_4c_Abas.Page1
    loc_cValor = ALLTRIM(loc_oAba.txt_4c_Campo.Value)

    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
        "TabelaLookup", "cursor_4c_Busca", "campo_codigo", loc_cValor, ;
        "Titulo da Busca")

    IF ISNULL(loc_oForm)
        RETURN
    ENDIF

    IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
        loc_oAba.txt_4c_Campo.Value = ALLTRIM(cursor_4c_Busca.campo_codigo)
    ELSEIF !loc_oForm.this_lAchouRegistro
        loc_oForm.mAddColuna("campo_codigo", "", "Codigo")
        loc_oForm.mAddColuna("campo_descricao", "", "Descricao")
        loc_oForm.Show(1)
        IF loc_oForm.this_lSelecionou
            loc_oAba.txt_4c_Campo.Value = ALLTRIM(cursor_4c_Busca.campo_codigo)
        ENDIF
    ENDIF

    IF USED("cursor_4c_Busca")
        USE IN cursor_4c_Busca
    ENDIF
    loc_oForm.Release()
ENDPROC

*-- 4. Método Validar - Valida ao sair do campo
PROCEDURE ValidarCampo()
    LOCAL loc_oAba, loc_cValor, loc_cSQL, loc_nResultado
    loc_oAba = THIS.pgf_4c_Principal.Page2.pgf_4c_Abas.Page1
    loc_cValor = UPPER(ALLTRIM(loc_oAba.txt_4c_Campo.Value))

    IF EMPTY(loc_cValor)
        RETURN
    ENDIF

    * IMPORTANTE: Usar CAST para evitar erro de conversão varchar/numeric
    loc_cSQL = "SELECT campo_codigo, campo_descricao FROM TabelaLookup " + ;
               "WHERE CAST(campo_codigo AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valida")

    IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Valida") = 1
        loc_oAba.txt_4c_Campo.Value = ALLTRIM(cursor_4c_Valida.campo_codigo)
    ELSE
        IF USED("cursor_4c_Valida")
            USE IN cursor_4c_Valida
        ENDIF
        MsgAviso("Valor nao encontrado.")
        loc_oAba.txt_4c_Campo.Value = ""
        THIS.AbrirBuscaCampo()
        RETURN
    ENDIF

    IF USED("cursor_4c_Valida")
        USE IN cursor_4c_Valida
    ENDIF
ENDPROC
```

**IMPORTANTE**: Sempre usar `CAST(campo AS VARCHAR(n))` nas consultas WHERE para evitar erro "converting varchar to numeric" quando o campo do banco é numérico mas o valor digitado é string.

## FormBuscaAuxiliar - Dois Modos de Uso

O FormBuscaAuxiliar suporta **dois modos** de uso, dependendo de onde vem o cursor:

### Modo 1: Com parametros no Init (busca em TABELA SQL)

Usado para lookups padrao em tabelas do banco. O Init faz o SELECT automaticamente:

```foxpro
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
    "SigCdGrp", "cursor_4c_Busca", "cgrus", loc_cValor, ;
    "Busca de Grupos")

IF VARTYPE(loc_oBusca) = "O"
    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
        loc_oAba.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Busca.cgrus)
    ELSEIF !loc_oBusca.this_lAchouRegistro
        loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
            loc_oAba.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Busca.cgrus)
        ENDIF
    ENDIF
    loc_oBusca.Release()
ENDIF
IF USED("cursor_4c_Busca")
    USE IN cursor_4c_Busca
ENDIF
```

### Modo 2: Sem parametros no Init (cursor LOCAL pre-existente)

Usado quando o cursor ja foi criado por um metodo do BO (ex: BuscarContaPorGrupo).
O Init NAO faz SELECT - apenas cria o form vazio para exibir o cursor existente.

```foxpro
*-- 1. Carregar cursor via BO ANTES de criar o FormBuscaAuxiliar
THIS.this_oBusinessObject.BuscarContaPorGrupo(loc_cGrupo, "")

*-- 2. Criar FormBuscaAuxiliar SEM parametros
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
IF VARTYPE(loc_oBusca) = "O"
    *-- 3. Configurar manualmente
    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
    loc_oBusca.this_cTitulo = "Contas do Grupo"

    *-- 4. Adicionar colunas e mostrar
    loc_oBusca.mAddColuna("Contas", "", "Conta")
    loc_oBusca.mAddColuna("RClis", "", "Nome")
    loc_oBusca.Show()

    *-- 5. Verificar selecao
    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
        loc_oAba.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.Contas)
    ENDIF
    loc_oBusca.Release()
ENDIF
IF USED("cursor_4c_BuscaConta")
    USE IN cursor_4c_BuscaConta
ENDIF
```

### Quando usar cada modo

| Situacao | Modo | Exemplo |
|----------|------|---------|
| Lookup em tabela SQL padrao | Modo 1 (com params) | SigCdGrp, SigCdCli, SigCdMoe |
| Cursor criado pelo BO | Modo 2 (sem params) | cursor_4c_BuscaConta |
| Busca com filtro WHERE extra | Modo 1 (par_cFiltro) | Tabela com restricao |

### Assinatura do Init (Modo 1)

```foxpro
PROCEDURE Init(par_nConn, par_cTabela, par_cCursor, par_cCampo, par_cValor, par_cTitulo, par_lBuscaExata, par_lMostraGrid, par_cFiltro)
```

### Assinatura do mAddColuna

```foxpro
PROCEDURE mAddColuna(par_cCampo, par_cMascara, par_cTitulo)
*-- par_cCampo: nome do campo no cursor (string)
*-- par_cMascara: InputMask (string vazia "" se nao tiver mascara)
*-- par_cTitulo: titulo da coluna no grid (string)
*-- NUNCA passar largura como parametro - eh calculada automaticamente
```

## Legacy Functions Library (sigacess.PRG)

O arquivo `Framework\sigacess.PRG` contem uma biblioteca de funcoes utilitarias do sistema legado. Estas funcoes sao usadas para:
- Validacao de acesso/permissoes de usuarios
- Busca/Lookup/Validacao de dados em tabelas
- Controle de restricoes por grupo

### Funcoes Principais em sigacess.PRG

| Funcao | Descricao | Uso |
|--------|-----------|-----|
| fRestritos | Verifica restricoes entre grupos | Controle de acesso |
| fChecaAcesso | Valida permissao do usuario para programa/parametro | Seguranca |
| fChecaAcessoJOB | Valida acesso a jobs especificos | Seguranca |
| fAcessoContab | Valida/busca grupos contabeis | Lookup + Validacao |
| fAcessoProduto | Valida/busca produtos por grupo | Lookup + Validacao |
| fAcessoContas | Valida/busca contas contabeis | Lookup + Validacao |

### fAcessoContab - Funcao de Lookup Contabil

A funcao `fAcessoContab` eh um exemplo importante pois serve tanto para **validacao de acesso** quanto como **ferramenta de busca/lookup**:

```foxpro
* Assinatura:
Function fAcessoContab(pUsu, pTip, pTxt, pCod, pDsc, pCta, pCnx, pDat, pArr, pRecPag) as Variant

* Parametros principais:
* pUsu - Usuario
* pTip - Tipo de busca: 'C' (codigo) ou 'D' (descricao)
* pTxt - Texto para busca
* pCnx - Objeto de conexao SQL
```

**Comportamento**:
1. Verifica se usuario tem acesso aos grupos contabeis (SigSyAgc, SigCdAcG)
2. Se usuario for '4CONTROL' (superusuario), tem acesso total
3. Se nao encontrar exato, abre tela de busca (fwBuscaInt) para selecao
4. Retorna grupo selecionado ou validado

**Tabelas utilizadas**:
- `SigCdGcr` - Grupos contabeis (Codigos, Descrs)
- `SigSyAgc` - Acessos por grupo contabil
- `SigCdAcG` - Acessos por grupo de usuario
- `SigCdUsu` - Usuarios

### Padrao de Lookup nas Funcoes Legadas

As funcoes de acesso seguem um padrao comum:
1. Validar permissao do usuario
2. Buscar registro exato (se texto informado)
3. Se nao encontrar exato, abrir tela de selecao (fwBuscaInt ou fwBuscaSel)
4. Retornar valor selecionado

Este padrao deve ser replicado nas funcoes de lookup do novo sistema.

### Uso de fAcessoContab nas Tarefas de Migracao

| Tarefa | Formulario | Campo | Chamada Legada | Implementacao Nova | Status |
|--------|------------|-------|----------------|-------------------|--------|
| task2 | SIGCDCAR (Cargos) | get_Grupo | `fAcessoContab(Usuar,'C',This.value,This,'')` | AbrirBuscaGrupoFin/ValidarGrupoFin | OK |
| task5 | SIGCDPRO (Produtos) | get_gruccus | `fAcessoContab(Usuar,'C',This.value,This,dgruccus)` | AbrirBuscaGruCCus/ValidarGruCCus | **BUG** |
| task5 | SIGCDPRO (Produtos) | get_dgruccus | `fAcessoContab(Usuar,'D',This.value,gruccus,This)` | (nao implementado) | **BUG** |
| task5 | SIGCDPRO (Produtos) | get_contaccus | `fAcessoContas(Usuar,grupo,'C',...)` | AbrirBuscaContaCCus/ValidarContaCCus | **BUG** |

**Legenda**:
- **OK**: Implementacao funciona corretamente e salva dados
- **BUG**: Lookup funciona visualmente mas dados NAO sao salvos (falta propriedade no BO)

**Padrao 'C' (Codigo)**: Busca por codigo, retorna codigo selecionado
**Padrao 'D' (Descricao)**: Busca por descricao, retorna codigo correspondente

**IMPORTANTE**: Ao migrar formularios que usam fAcessoContab, verificar:
1. Se o BO tem propriedade para o campo
2. Se FormParaBO transfere o valor do form para o BO
3. Se BOParaForm carrega o valor do BO para o form
4. Se INSERT/UPDATE incluem o campo no SQL

## Padrao Completo de Implementacao

### 1. Adicionar BINDEVENT em ConfigurarAba
```foxpro
* Em ConfigurarAbaDadosPrincipais (ou metodo similar):
BINDEVENT(loc_oAba.txt_4c_Grupo, "DblClick", THIS, "AbrirBuscaGrupo")
BINDEVENT(loc_oAba.txt_4c_Grupo, "KeyPress", THIS, "TeclaLookupGrupo")
BINDEVENT(loc_oAba.txt_4c_Grupo, "LostFocus", THIS, "ValidarGrupo")
```

### 2. Criar metodo TeclaLookup para capturar F4/F5
```foxpro
PROCEDURE TeclaLookupGrupo(par_nKeyCode, par_nShiftAltCtrl)
    * F4 (115) ou F5 (116) abre a busca
    IF INLIST(par_nKeyCode, 115, 116)
        THIS.AbrirBuscaGrupo()
    ENDIF
ENDPROC
```

### 3. Criar metodo AbrirBusca usando FormBuscaAuxiliar
```foxpro
PROCEDURE AbrirBuscaGrupo()
    LOCAL loc_oAba, loc_cValorAtual, loc_oBusca

    loc_oAba = THIS.pgf_4c_Principal.Page2.pgf_4c_Abas.Page1
    loc_cValorAtual = ALLTRIM(loc_oAba.txt_4c_Grupo.Value)

    * FormBuscaAuxiliar(nConnHandle, cTabela, cCursor, cCampoBusca, cValor, cTitulo, lBuscaExata)
    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
        gnConnHandle, ;              && Handle conexao
        "SigCdGrp", ;                && Tabela
        "cursor_4c_Busca", ;         && Nome do cursor
        "cgrus", ;                   && Campo de busca
        loc_cValorAtual, ;           && Valor atual
        "Busca de Grupos", ;         && Titulo
        .F.)                         && Busca exata (false = parcial)

    IF VARTYPE(loc_oBusca) = "O"
        IF loc_oBusca.this_lSelecionou
            * Registro exato encontrado - usa direto
            IF USED("cursor_4c_Busca") AND RECCOUNT("cursor_4c_Busca") > 0
                loc_oAba.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Busca.cgrus)
            ENDIF
        ELSE
            * Mostra grid para selecao
            IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oAba.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Busca.cgrus)
                ENDIF
            ENDIF
        ENDIF
        loc_oBusca.Release()
    ENDIF

    IF USED("cursor_4c_Busca")
        USE IN cursor_4c_Busca
    ENDIF
ENDPROC
```

### 4. Criar metodo Validar para LostFocus
```foxpro
PROCEDURE ValidarGrupo()
    LOCAL loc_oAba, loc_cValor, loc_cSQL, loc_nResultado

    loc_oAba = THIS.pgf_4c_Principal.Page2.pgf_4c_Abas.Page1
    loc_cValor = UPPER(ALLTRIM(loc_oAba.txt_4c_Grupo.Value))

    * Se vazio, permite sair sem validar
    IF EMPTY(loc_cValor)
        RETURN
    ENDIF

    * Busca exata no banco - usa CAST para evitar erro se campo for numerico
    loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp WHERE CAST(cgrus AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valida")

    IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Valida") = 1
        * Encontrou exato - atualiza com valor correto do banco
        loc_oAba.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Valida.cgrus)
    ELSEIF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Valida") > 1
        * Multiplos registros - abre busca
        USE IN cursor_4c_Valida
        THIS.AbrirBuscaGrupo()
        RETURN
    ELSE
        * Nao encontrou - limpa e abre busca
        IF USED("cursor_4c_Valida")
            USE IN cursor_4c_Valida
        ENDIF
        MsgAviso("Grupo '" + loc_cValor + "' n" + CHR(227) + "o encontrado.")
        loc_oAba.txt_4c_Grupo.Value = ""
        THIS.AbrirBuscaGrupo()
        RETURN
    ENDIF

    IF USED("cursor_4c_Valida")
        USE IN cursor_4c_Valida
    ENDIF
ENDPROC
```
