# ERRO210 — Comparativo Entre Locais (SIGCDCLC / FormCLC)

**Status:** bloqueado, aguardando definição da 4Control
**Data do levantamento:** 2026-10-14
**Banco:** `DB_MBAHIA` em `192.168.200.10`

---

## Sintoma

Ao abrir *Comparativo Entre Locais*:

```
Erro ao buscar registros:
Connectivity error: [Microsoft][ODBC SQL Server Driver][SQL Server]
Nome de objeto 'SigLcLo' inválido.
```

A janela abre, mas com a lista em branco e nenhuma operação funcional
(Incluir / Alterar / Excluir / Buscar passam todas por `SigLcLo`).

## NÃO é defeito de migração

O SCX legado usa exatamente os mesmos nomes de tabela
(`tasks/task370/SIGCDCLC_form_codigo_fonte.txt:2610-2627`):

```foxpro
lcQryCLoc  = [Select * From SigLcLo]
lcQryCLocI = [Select * From SigLcLoI Where Codigos = ?pCod]
lcQryCLocE = [Select * From SigLcLoE Where Codigos = ?pCod]
...
.AddCursor('SigLcLo',  'Codigos',   'crSigLcLo',  '', ThisForm.Pagina.Lista.Grade, lcQryCLoc)
.AddCursor('SigLcLoI', 'cIdChaves', 'crSigLcLoI', '', '', lcQryCLocI)
.AddCursor('SigLcLoE', 'cIdChaves', 'crSigLcLoE', '', '', lcQryCLocE)
```

`FormCLC.prg` / `CLCBO.prg` estão fiéis. A tela **legada quebra igual** neste
banco. O que falta é a tabela — e mexer no código para contornar violaria o
PILAR 2 (apontar o BO para outra tabela gravaria dado no lugar errado).

## As tabelas não existem em NENHUM banco do servidor

Varredura nos **118 bancos online** de `192.168.200.10` (2026-10-14):

| tabela     | em quantos bancos |
|------------|-------------------|
| `SigLcLo`  | **0** |
| `SigLcLoI` | **0** |
| `SigLcLoE` | **0** |

Para comparação, as outras seis tabelas que faltam no `DB_MBAHIA` existem em
16 bancos de cliente cada (`SigCdCcp`, `SigCdCmp`, `SigCdCrf`, `SigCdCri`,
`SigCdEma`, `SigCdOcs`) — mesmo caso já tratado em
`automation/criar_SigCdUep.sql`, onde a definição pôde ser extraída de bancos
de referência.

**Aqui não há banco de referência nenhum.** Indica módulo nunca implantado,
não "o DB_MBAHIA ficou para trás".

## A definição do `docs/schema.sql` não executa

Teste dos três `CREATE TABLE` do schema canônico, em transação revertida:

```
OK    SigLcLo criada
FALHA SigLcLoI -> Os nomes de colunas em cada tabela devem ser exclusivos.
                  O nome da coluna 'cidchaves' na tabela 'SigLcLoI' foi
                  especificado mais de uma vez.
OK    SigLcLoE criada
```

`SigLcLoI` declara duas colunas que o SQL Server considera a mesma
(nomes são case-insensitive):

```sql
[cIdChaves] [char](36) NOT NULL,   -- PK; é a usada pelo legado e pelo migrado
[cidchaves] [char](20) NOT NULL,   -- duplicata, não referenciada por ninguém
```

Outros indícios de que esse trecho do `schema.sql` foi montado à mão e não
gerado de um banco vivo:

- `SigLcLo`: PK **nomeada** `siglclo_cidchaves` mas construída sobre `[Codigos]`
- `SigLcLoI`: PK nomeada `siglcloi_cidchaves` mas construída sobre `[cIdChaves]`

Ou seja: o `schema.sql` **não serve** como fonte confiável para criar essas
tabelas.

---

## Perguntas para a 4Control

1. O módulo **Comparativo Entre Locais (SIGCDCLC)** deve existir para este
   cliente? Ele não está implantado em nenhum dos 118 bancos do servidor.

2. Se deve existir: qual é o **script oficial de criação** de `SigLcLo`,
   `SigLcLoI` e `SigLcLoE` (colunas, tipos, nulabilidade, PK, índices e
   **collation**)?

3. Existe algum banco — neste servidor ou em outro — onde essas tabelas
   estejam criadas, para servir de referência?

4. No `SigLcLoI`, confirmam que a chave é **`cIdChaves char(36)`** e que a
   coluna `cidchaves char(20)` do nosso `schema.sql` entrou por engano?

## Enquanto não houver resposta

Nada a fazer no código. A tela permanece inoperante, do mesmo modo que a
legada. Não criar as tabelas por conta própria: a definição não pode ser
conferida contra nenhum banco, e a tela grava comparativo de estoque entre
locais — erro de largura ou collation só apareceria muito depois.

## Como reproduzir o levantamento

```powershell
# tabelas do schema canonico ausentes no banco
$t = Get-Content 'C:\4c\docs\schema.sql' -Raw   # UTF-16: -Raw obrigatorio
$schema = [regex]::Matches($t,'(?i)CREATE TABLE \[dbo\]\.\[([A-Za-z0-9_]+)\]') |
          ForEach-Object { $_.Groups[1].Value.ToUpper() } | Sort-Object -Unique
# comparar com INFORMATION_SCHEMA.TABLES do DB_MBAHIA

# em quantos bancos do servidor a tabela existe
#   SELECT name FROM sys.databases WHERE state = 0 AND database_id > 4
#   SELECT COUNT(*) FROM [<db>].sys.tables WHERE name IN ('SigLcLo', ...)
```
