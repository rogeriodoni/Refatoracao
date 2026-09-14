# Início Rápido

Checklist para começar a usar o sistema.

## 1. Configuração do Banco de Dados

- [ ] Abrir arquivo `app\start\config.prg`
- [ ] Localizar seção "Configurações de Banco de Dados"
- [ ] Ajustar as seguintes constantes:

```foxpro
#DEFINE DB_SERVER "localhost"          && Seu servidor SQL Server
#DEFINE DB_NOME "seu_banco"           && Nome do seu banco de dados
#DEFINE DB_USUARIO "sa"               && Usuário do banco
#DEFINE DB_SENHA "sua_senha"          && Senha do banco
```

## 2. Testar Conexão

- [ ] Abrir Visual FoxPro 9
- [ ] Navegar para `C:\4c\projeto\app\start`
- [ ] Executar: `DO main.prg`
- [ ] Verificar se conecta ao banco
- [ ] No menu, ir em **Ferramentas > Testar Conexão BD**
- [ ] Deve exibir: "Conexão com banco de dados: OK"

Se houver erro de conexão:
- Verificar se SQL Server está rodando
- Verificar se as credenciais estão corretas
- Verificar se o banco existe
- Verificar firewall/permissões de rede

## 3. Preparar Ícones

- [ ] Localizar ícones do sistema antigo (pasta vbmp)
- [ ] Copiar ícones necessários para `C:\4c\projeto\icons\`
- [ ] Manter os nomes originais dos arquivos

## 4. Criar Primeira Tela

Siga o processo documentado:

1. **Receber código original**
   - Arquivo .txt com código antigo
   - Print da tela

2. **Analisar requisitos**
   - Ler [Guia de Desenvolvimento](docs/guia_desenvolvimento.md)
   - Identificar tabelas, validações, funcionalidades

3. **Criar Business Object**
   - Herdar de `BusinessBase`
   - Implementar validações
   - Implementar CRUD

4. **Criar Formulário**
   - Herdar de `FormBase`
   - Replicar layout do print
   - Implementar bindings

5. **Integrar ao menu**
   - Editar `app\menu\menu.prg`
   - Adicionar item de menu

6. **Testar**
   - Inclusão, edição, exclusão
   - Validações
   - Mensagens

## 5. Estudar Exemplo

- [ ] Abrir [Exemplo Completo](docs/exemplo_completo.md)
- [ ] Ler o código do EstadoBO
- [ ] Ler o código do FormEstado
- [ ] Entender o fluxo de dados
- [ ] Usar como referência para suas telas

## 6. Estrutura de Arquivos para Nova Tela

Para cada nova tela, você vai criar:

```
/app/classes/
    NomeDaEntidadeBO.prg        # Business Object

/app/forms/
    /modulo/                    # Ex: cadastros, movimentos
        FormNomeDaTela.prg      # Formulário
```

## 7. Padrão de Trabalho Recomendado

```
1. Análise
   ├─ Ler código original
   ├─ Ver print da tela
   ├─ Identificar tabelas
   ├─ Listar validações
   └─ Listar funcionalidades

2. Desenvolvimento
   ├─ Criar BO
   ├─ Criar Form
   └─ Integrar ao menu

3. Testes
   ├─ Testar inclusão
   ├─ Testar edição
   ├─ Testar exclusão
   ├─ Testar validações
   └─ Verificar mensagens

4. Documentação
   └─ Anotar decisões técnicas
```

## 8. Recursos Disponíveis

### Classes Base
- `DataAccess` - Acesso a dados
- `BusinessBase` - Regras de negócio
- `FormBase` - Interface do usuário
- `GridBase` - Grids de dados

### Utilitários
- `functions.prg` - Funções auxiliares
- `messages.prg` - Mensagens padronizadas
- `validators.prg` - Validações comuns

### Documentação
- `docs/arquitetura.md` - Arquitetura do sistema
- `docs/padroes_codigo.md` - Padrões de código
- `docs/guia_desenvolvimento.md` - Como criar telas
- `docs/exemplo_completo.md` - Exemplo prático

## 9. Dicas Importantes

✓ **SEMPRE** ler a documentação antes de começar
✓ **SEMPRE** usar as classes base (herança)
✓ **SEMPRE** usar funções utilitárias quando disponíveis
✓ **SEMPRE** validar dados no Business Object
✓ **NUNCA** colocar SQL direto no formulário
✓ **NUNCA** copiar código antigo sem refatorar
✓ **SEMPRE** seguir os padrões de nomenclatura
✓ **SEMPRE** comentar o "porquê", não o "o quê"

## 10. Troubleshooting Comum

### Erro: "File 'xxx.prg' does not exist"
→ Verificar se o arquivo está no caminho correto
→ Verificar configuração de PATH em `config.prg`

### Erro: "Variable 'gnConnHandle' not found"
→ Verificar se `main.prg` foi executado
→ Verificar se conexão foi estabelecida

### Erro SQL na conexão
→ Verificar credenciais em `config.prg`
→ Verificar se SQL Server está acessível
→ Verificar se banco existe

### Formulário não abre
→ Verificar sintaxe do código
→ Verificar se herda de FormBase corretamente
→ Verificar mensagens de erro no VFP

### Validações não funcionam
→ Verificar se `ValidarDados()` está implementado
→ Verificar se `FormParaBO()` está transferindo dados
→ Verificar se `Salvar()` chama validação

## 11. Próximos Passos

Após configuração inicial:

1. [ ] Estudar documentação completa
2. [ ] Analisar exemplo completo
3. [ ] Criar tela de teste simples
4. [ ] Começar migração das telas reais
5. [ ] Manter documentação atualizada

## Suporte

- Consulte a documentação em `/docs`
- Revise os exemplos nas classes base
- Leia os comentários no código

**Boa sorte com o desenvolvimento!**
