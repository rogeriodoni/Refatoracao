# Solicitacao de Teste Manual

**Task ID:** task388
**Formulario:** FormCTA (origem: SIGCDCTA)
**Data:** 2026-07-31
**Tabela:** SigCdCli (chave: IClis char(10), Grupos char(10))

---

## 1. Objetivo do Teste

Validar se o formulario migrado (**FormCTA**) esta funcionando corretamente com paridade funcional ao SIGCDCTA.SCX original.

## 2. Pre-Requisitos

- [ ] Codigo migrado em: `C:\4c\projeto\app\forms\cadastros\FormCTA.prg`
- [ ] Business Object em: `C:\4c\projeto\app\classes\CTABO.prg`
- [ ] Banco de dados acessivel: 192.168.15.101 (DB_MBAHIA)
- [ ] Tabela SigCdCli com registros de teste
- [ ] Deletar .fxp antigos antes do primeiro teste

## 3. Como Abrir o Formulario

No VFP9:
```foxpro
DO C:\4c\projeto\app\start\main.prg
* Menu: Cadastros > Clientes (ou chamar diretamente)
* OU:
loForm = CREATEOBJECT("FormCTA")
loForm.Show()
```

## 4. Casos de Teste

### 4.1. Abertura e Listagem

- [ ] Formulario abre sem erros
- [ ] Grid da Page1 carrega registros de SigCdCli
- [ ] Colunas do grid: Codigo (IClis), Nome (Rclis), CPF/CNPJ (Cpfs), Ultima Compra (Ultcomps), Dt. Alteracao (DtAlts)
- [ ] Filtro por Grupo de Contas funciona (digitar codigo + ENTER)
- [ ] Filtro por data (Alterados entre DtIni e DtFim) funciona
- [ ] Descricao do grupo preenche automaticamente no campo ao lado

### 4.2. Sub-paginas de Dados (Page2)

Ao entrar no modo Incluir/Alterar, verificar que as 12 sub-paginas sao acessiveis:

- [ ] Pg1 - Principal: IClis, Rclis, Cpfs, Rgs, Grupos, endere+o, telefones, email, obs
- [ ] Pg2 - Comercial: Tpcads, Tpclis, tabelas de desconto, limites, juros
- [ ] Pg3 - Bancarios: endere+o de cobranca
- [ ] Pg4 - Follow-up: endere+o de trabalho/outros
- [ ] Pg5 - Financeiro: dados financeiros
- [ ] Pg6 - Fiscal: configuracoes fiscais gerais
- [ ] Pg7 - Complemento: contatos, observacoes complementares
- [ ] Pg8 - Empresa: codigo empresa, usuarios
- [ ] Pg9 - Config. Fiscal: ICMS, IPI, II, ISS, IRRF, INSS, PIS, CSSL, COFINS
- [ ] Pg10 - Cadastrais: LGPD (Autdados, Autemail, Autsms, Autwhats, Autteleg), dados pessoais
- [ ] Pg11 - Caracteristicas: flags (Gerbals, Pagfals, Recfals, Valemail, Invisivel, Aptos, Patrietqs, Restfors, Consigs)
- [ ] Pg12 - Perfil: memo Perfils, Pastas

### 4.3. INCLUIR

- [ ] Clicar "Incluir" - muda para Page2 modo edicao
- [ ] Campos habilitados para digitacao
- [ ] Preencher: Grupos (lookup F4/F5), IClis (codigo), Rclis (nome), Cpfs (CPF/CNPJ)
- [ ] Preencher endereco basico
- [ ] Clicar "Salvar" - registro salvo em SigCdCli
- [ ] Verificar auditoria em LogAuditoria

### 4.4. VISUALIZAR

- [ ] Selecionar registro no grid, clicar "Visualizar"
- [ ] Page2 abre com dados preenchidos e campos DESABILITADOS
- [ ] Botao Salvar desabilitado
- [ ] Clicar "Cancelar" volta para lista

### 4.5. ALTERAR

- [ ] Selecionar registro, clicar "Alterar"
- [ ] Page2 abre com dados preenchidos e campos HABILITADOS
- [ ] Modificar Rclis (nome)
- [ ] Clicar "Salvar" - registro atualizado
- [ ] Verificar DtAlts atualizado no banco

### 4.6. EXCLUIR

- [ ] Selecionar registro de TESTE, clicar "Excluir"
- [ ] Dialog de confirmacao aparece
- [ ] Confirmar exclusao
- [ ] Registro removido de SigCdCli
- [ ] Auditoria em LogAuditoria

### 4.7. Lookup Grupo de Contas

- [ ] No campo Grupos (Pg1), digitar codigo parcial + F4/F5/ENTER
- [ ] FormBuscaAuxiliar abre com lista de grupos (SigCdGrc)
- [ ] Selecionar grupo - codigo e descricao preenchidos automaticamente

### 4.8. Encerrar

- [ ] Clicar "Encerrar" volta ao menu principal
- [ ] Menu restaurado completamente (sem itens faltando)
- [ ] Sem cursores abertos apos fechar

## 5. Campos Criticos para Validar

| Campo | Controle | Sub-pag | Banco |
|-------|----------|---------|-------|
| Codigo (PK) | txt_4c_IClis | Pg1 | IClis char(10) |
| Grupo | txt_4c_Grupos | Pg1 | Grupos char(10) |
| Nome Curto | txt_4c_Rclis | Pg1 | Rclis char(20) |
| Nome Completo | txt_4c_Razaos | Pg1 | Razaos char(60) |
| CPF/CNPJ | txt_4c_Cpfs | Pg1 | Cpfs char(18) |
| Inativo | chk_4c_Inativas | Pg1 | Inativas bit |
| ICMS config | txt_4c_CfgFis1 | Pg9 | CfgFisICs |
| LGPD Dados | chk_4c_Autdados | Pg10 | Autdados bit |

## 6. Resultado do Teste

### Resumo

- [ ] Abertura/Listagem: **APROVADO / REPROVADO**
- [ ] 12 Sub-paginas navegaveis: **APROVADO / REPROVADO**
- [ ] INCLUIR: **APROVADO / REPROVADO**
- [ ] VISUALIZAR: **APROVADO / REPROVADO**
- [ ] ALTERAR: **APROVADO / REPROVADO**
- [ ] EXCLUIR: **APROVADO / REPROVADO**
- [ ] Lookup Grupos: **APROVADO / REPROVADO**
- [ ] Encerrar + menu: **APROVADO / REPROVADO**

### Problemas Encontrados

1.
2.
3.

### Aprovacao

- [ ] **APROVADO** - FormCTA pronto para integracao no menu
- [ ] **REPROVADO** - Necessita correcoes (detalhar acima)

**Testador:** ___________________________
**Data:** ___________________________

---

**Proximos Passos apos aprovacao:**
1. Adicionar entrada no menu.prg (popCadastros, bar 5 -> FormCTA ou novo bar)
2. `ON SELECTION BAR X OF popCadastros DO AbrirFormCTA`
3. Adicionar `PROCEDURE AbrirFormCTA()` em menu.prg
4. Commit no git
