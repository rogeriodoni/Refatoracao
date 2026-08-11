CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~994: Tabela 'SigCdEma' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1025: Tabela 'SigCdEma' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1064: Tabela 'SigCdEma' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1078: Tabela 'SigCdEma' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1111: Tabela 'SigCdEma' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1138: Tabela 'SigCdEma' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formema.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\emaBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formema.prg
- BO: C:\4c\projeto\app\classes\emaBO.prg
