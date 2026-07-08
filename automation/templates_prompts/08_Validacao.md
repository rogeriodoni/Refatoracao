# MIGRAÇÃO VFP9 - FASE 8: Validação Final

## CONTEXTO
- **Projeto**: Migração VFP9 - Sistema 4C
- **Task**: {{TaskId}}
- **Formulário Original**: {{BaseName}}
- **Fase**: 8 - Validação Final e Testes

## ARQUIVOS DE REFERÊNCIA
- **CLAUDE.md**: `C:\4c\CLAUDE.md` (seção Validação)
- **UI Fidelity Guide**: `C:\4c\docs\ui_fidelity_validation.md`
- **Form Migrado**: `C:\4c\projeto\app\forms\cadastros\Form{{BaseName}}.prg`
- **BO**: `C:\4c\projeto\app\classes\{{BaseName}}BO.prg`

## TAREFA
Executar validação completa e testes finais para garantir paridade funcional 100%.

## VALIDAÇÕES A EXECUTAR

### 1. Validação de UI Fidelity (ValidarUIFidelity.prg)

```foxpro
*-- Executar no VFP9:
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "{{TaskPath}}\{{BaseName}}_codigo_fonte.txt", "Form{{BaseName}}"
```

**Critérios de Aceite**:
- ✅ **Máximo 37 problemas** (4 Dataenvironment + 33 FormBase)
- ✅ **0 erros críticos** (objetos/propriedades faltando)
- ✅ **0 diferenças visuais** (Width, Height, BackColor, etc.)

**Diferenças Aceitáveis**:
- ✅ Dataenvironment (4 erros) - Não afeta UI
- ✅ Controles do FormBase (~33 avisos) - Herdados
- ✅ ForeColor normalizado - "90,90,90" vs "RGB(90,90,90)"

**Diferenças CRÍTICAS (Corrigir)**:
- ❌ Width/Height/Top/Left diferentes
- ❌ BackColor/ForeColor valores RGB diferentes
- ❌ Caption/InputMask diferentes
- ❌ Objetos não encontrados

### 2. Teste de Compilação

```foxpro
*-- Deletar .fxp (CRÍTICO!)
CD C:\4c\projeto\app
DELETE FILE classes\*.fxp
DELETE FILE forms\cadastros\*.fxp
DELETE FILE utils\*.fxp

*-- Tentar abrir form
CD C:\4c\projeto\app\forms\cadastros
DO Form{{BaseName}}
```

**Critérios**:
- ✅ Form compila sem erros
- ✅ Form abre sem erros
- ✅ TODOS os objetos visíveis

### 3. Testes Funcionais CRUD

#### 3.1 Teste INCLUIR
```
[ ] Clicar em "Incluir"
[ ] Preencher TODOS os campos
[ ] Preencher TODOS os lookups (F4)
[ ] Preencher grid de itens (se houver)
[ ] Clicar em "Salvar"
[ ] Verificar mensagem de sucesso
[ ] Verificar no SQL Server:
    SELECT * FROM {{NomeTabela}} WHERE [PK] = [valor]
    → TODOS os campos preenchidos?
[ ] Verificar LogAuditoria:
    SELECT * FROM LogAuditoria WHERE Operacao = 'INSERT'
    → Registro de auditoria existe?
```

#### 3.2 Teste ALTERAR
```
[ ] Clicar em registro no grid da lista
[ ] Clicar em "Alterar"
[ ] Verificar TODOS os campos carregados corretamente
[ ] Modificar alguns campos
[ ] Clicar em "Salvar"
[ ] Verificar mensagem de sucesso
[ ] Verificar no SQL Server:
    → Campos modificados atualizados?
[ ] Verificar LogAuditoria:
    SELECT * FROM LogAuditoria WHERE Operacao = 'UPDATE'
```

#### 3.3 Teste VISUALIZAR
```
[ ] Clicar em registro no grid
[ ] Clicar em "Visualizar"
[ ] Verificar TODOS os campos exibidos (readonly)
[ ] Verificar botão "Salvar" desabilitado
[ ] Verificar botão "Cancelar/Voltar" habilitado
[ ] Clicar em "Voltar"
```

#### 3.4 Teste EXCLUIR
```
[ ] Clicar em registro no grid
[ ] Clicar em "Excluir"
[ ] Verificar mensagem de confirmação
[ ] Confirmar exclusão
[ ] Verificar mensagem de sucesso
[ ] Verificar LogAuditoria:
    SELECT * FROM LogAuditoria WHERE Operacao = 'DELETE'
```

### 4. Testes de Lookups

```
Para CADA lookup identificado:
[ ] F4 abre FormBuscaAuxiliar
[ ] FormBuscaAuxiliar exibe dados da tabela correta
[ ] Busca por código funciona
[ ] Busca por descrição funciona
[ ] Seleção preenche campo principal
[ ] Seleção preenche campos dependentes
[ ] ESC cancela sem preencher
[ ] Código inválido (digitar manualmente) exibe erro
```

### 5. Testes de Grids (Se Aplicável)

```
Para CADA grid:
[ ] Grid exibe dados do cursor
[ ] Adicionar item funciona
[ ] Remover item funciona
[ ] Editar item funciona
[ ] Lookups internos funcionam (F4 dentro do grid)
[ ] Totalizadores atualizam automaticamente
[ ] Navegação com setas funciona
```

### 6. Testes de Lógica de Negócio

```
Para CADA procedure customizado:
[ ] Executar ação que aciona procedure
[ ] Verificar resultado idêntico ao sistema original
[ ] Testar com dados reais
[ ] Comparar cálculos (novo vs original)
[ ] Validações funcionam conforme esperado
```

### 7. Testes de Performance

```
[ ] Abrir formulário: < 3 segundos
[ ] Carregar lista (grid): < 2 segundos
[ ] Salvar registro: < 1 segundo
[ ] Buscar (lookup): < 1 segundo
[ ] Sem travamentos
[ ] Sem memory leaks (testar abrir/fechar 10x)
```

## CHECKLIST FINAL

### ✅ Código
- [ ] TODOS os arquivos .fxp deletados
- [ ] Código compila sem erros
- [ ] Sem warnings relevantes
- [ ] Comentários em lógica complexa
- [ ] Nomenclatura padronizada (_4c_)

### ✅ UI Fidelity
- [ ] ValidarUIFidelity: ≤37 problemas
- [ ] Screenshot lado-a-lado: 0 diferenças visuais
- [ ] Cores idênticas (RGB exatos)
- [ ] Fontes idênticas (nome e tamanho)
- [ ] Posições idênticas (Top, Left, Width, Height)
- [ ] Botões CRUD: Width=75, Height=75
- [ ] Form sem barra de título (ControlBox=.F., TitleBar=0)

### ✅ Funcionalidade
- [ ] CRUD completo funciona (INCLUIR, ALTERAR, VISUALIZAR, EXCLUIR)
- [ ] TODOS os {{TotalCampos}} campos salvam/carregam
- [ ] TODOS os {{NumLookups}} lookups funcionam
- [ ] TODOS os {{NumGrids}} grids funcionam
- [ ] TODAS as validações ativas
- [ ] TODOS os cálculos corretos
- [ ] Lógica de negócio idêntica ao original

### ✅ Banco de Dados
- [ ] TODOS os campos salvam no banco
- [ ] LogAuditoria registra operações (INSERT, UPDATE, DELETE)
- [ ] Chave primária correta
- [ ] Constraints respeitadas
- [ ] Sem dados corrompidos

### ✅ Documentação
- [ ] config.prg atualizado (SET PROCEDURE)
- [ ] README.md da task atualizado
- [ ] Estado da migração salvo (estado_migracao_complexa.json)

## RELATÓRIO DE VALIDAÇÃO

Gerar relatório final em: `{{TaskPath}}\RELATORIO_VALIDACAO_FINAL.md`

```markdown
# Relatório de Validação Final - {{BaseName}}

## Resumo
- Data: {{DataValidacao}}
- Formulário: {{BaseName}}
- Task: {{TaskId}}
- Status: [APROVADO / REPROVADO]

## Validação UI Fidelity
- Total problemas: XX
- Erros críticos: 0
- Avisos aceitáveis: 33
- Diferenças visuais: 0
- Status: [✅ APROVADO]

## Testes Funcionais
- INCLUIR: [✅ PASSOU]
- ALTERAR: [✅ PASSOU]
- VISUALIZAR: [✅ PASSOU]
- EXCLUIR: [✅ PASSOU]
- Lookups ({{NumLookups}}/{{NumLookups}}): [✅ PASSOU]
- Grids ({{NumGrids}}/{{NumGrids}}): [✅ PASSOU]

## Lógica de Negócio
- Procedures testados: {{TotalProcedures}}/{{TotalProcedures}}
- Cálculos corretos: [✅ SIM]
- Comportamento idêntico: [✅ SIM]

## Conclusão
[✅ FORMULÁRIO APROVADO PARA PRODUÇÃO]

Paridade funcional 100% com sistema legado confirmada.
```

## ENTREGA ESPERADA
- Relatório de validação completo
- ValidarUIFidelity: ≤37 problemas
- TODOS os testes funcionais passaram
- Screenshot comparativo (original vs novo)
- Formulário 100% funcional e testado

## CRITÉRIO FINAL DE ACEITE
✅ **Migração está COMPLETA quando**:
1. ValidarUIFidelity ≤ 37 problemas (aceitáveis)
2. TODOS os testes CRUD passam
3. TODOS os lookups funcionam
4. TODOS os grids funcionam (se aplicável)
5. Lógica de negócio idêntica ao original
6. Comparação lado-a-lado: comportamento idêntico
7. Paridade funcional 100% confirmada
