# Checklist Rápido de Migração (Tasks 2-5)

Use este checklist para task2 (FormCargo), task3 (FormDepartamento), task4 (FormPlanoContas), task5 (FormProduto).

## ⚙️ Setup Inicial (5 min)

```
[ ] Identificar arquivos:
    - Original: C:\4c\tasks\taskX\ARQUIVO_form_codigo_fonte.txt
    - Form novo: C:\4c\projeto\app\forms\cadastros\FormXxx.prg
    - BO novo: C:\4c\projeto\app\classes\XxxBO.prg
    - JSON: C:\4c\projeto\app\utils\mapeamentos\FormXxx_mapeamento.json

[ ] Criar estrutura:
    mkdir backup_taskX (se refazendo)
```

## 📋 Análise (30 min)

```
[ ] Extrair propriedades visuais do .txt
[ ] Mapear campos (original → novo):
    | Original | Novo | Tipo | InputMask | Lookup |
[ ] Identificar lookups (procurar SIGACESS)
[ ] Identificar validações (procurar VALID)
[ ] Verificar tabela no banco (docs/schema.sql)
```

## 💼 Business Object (60 min)

```
[ ] Criar XxxBO.prg:
    [ ] Propriedades (this_cXxx, this_nXxx, this_dXxx)
    [ ] CarregarDoCursor() - mapear TODOS os campos
    [ ] Validar() - regras de negócio
    [ ] Inserir() - SQL INSERT
    [ ] Atualizar() - SQL UPDATE
    [ ] Excluir() - SQL DELETE
    [ ] ObterChavePrimaria() - retornar PK

[ ] Registrar em config.prg:
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "XxxBO.prg") ADDITIVE

[ ] Testar isoladamente:
    loBO = CREATEOBJECT("XxxBO")
    loBO.this_cCampo = "teste"
    ? loBO.this_cCampo
```

## 🖥️ Form (120 min)

```
[ ] Criar FormXxx.prg:
    [ ] Width/Height/Caption EXATOS do original
    [ ] this_oBusinessObject = .NULL.
    [ ] this_cEntidade = "Tabela"
    [ ] this_cCampoChave = "campo_pk"

[ ] ConfigurarFormulario():
    [ ] AddObject PageFrame (pgf_4c_Principal)
    [ ] AddObject Page (Page2)
    [ ] Para cada campo:
        [ ] AddObject Label (lbl_4c_Xxx) - Top/Left/Caption/ForeColor
        [ ] AddObject TextBox (txt_4c_Xxx) - Top/Left/Width/Height/InputMask/BackColor

[ ] ConfigurarLookups():
    [ ] BINDEVENT para cada campo com F4/F5
    [ ] Criar LookupXxx() com sigacess()

[ ] FormParaBO():
    [ ] Mapear TODOS os campos: this_oBusinessObject.this_cXxx = txt_4c_Xxx.Value

[ ] BOParaForm():
    [ ] Mapear TODOS os campos: txt_4c_Xxx.Value = this_oBusinessObject.this_cXxx

[ ] Registrar em config.prg:
    SET PROCEDURE TO (gc_4c_CaminhoForms + "cadastros\FormXxx.prg") ADDITIVE

[ ] Testar isoladamente:
    loForm = CREATEOBJECT("FormXxx")
    loForm.Show()
    *-- Verificar visualmente
```

## 🗺️ Mapeamento JSON (30 min)

```
[ ] Gerar mapeamento:
    CD C:\4c\projeto\app\utils
    DO GeradorMapeamento WITH "taskX\ARQUIVO_codigo_fonte.txt", "FormXxx"

[ ] Corrigir manualmente:
    [ ] Abrir FormXxx.prg
    [ ] Para cada objeto, atualizar JSON com nome REAL:
        "Original.Say1": "lbl_4c_Codigo" (não "lbl_4c_Label1")
        "Original.Get1": "txt_4c_Codigo" (não "txt_4c_TextBox1")

[ ] Salvar JSON
```

## ✅ VALIDAÇÃO (30 min) - OBRIGATÓRIO!

```
[ ] Limpar .fxp:
    DELETE FILE C:\4c\projeto\app\*.fxp /S

[ ] Executar ValidarUIFidelity:
    CD C:\4c\projeto\app\utils
    DO ValidarUIFidelity WITH "taskX\ARQUIVO_codigo_fonte.txt", "FormXxx"

[ ] Verificar resultado:
    META: ≤ 37 problemas (4 Dataenvironment + 33 FormBase + 0 diferenças)

[ ] Se mais de 37:
    [ ] Abrir relatório HTML
    [ ] Identificar erros ALÉM dos 37
    [ ] Corrigir FormXxx.prg
    [ ] Reexecutar validação

[ ] Abrir relatório HTML:
    [ ] Total: 37 problemas ✅
    [ ] 4 erros (Dataenvironment) ✅
    [ ] 33 avisos (FormBase) ✅
    [ ] 0 diferenças ✅
```

## 🧪 Testes Manuais (60 min)

```
[ ] Testar INCLUIR:
    [ ] Preencher todos os campos
    [ ] Confirmar
    [ ] Verificar mensagem de sucesso
    [ ] Verificar no banco (SELECT)

[ ] Testar VISUALIZAR:
    [ ] Abrir registro existente
    [ ] Campos preenchidos corretamente
    [ ] Campos desabilitados

[ ] Testar ALTERAR:
    [ ] Modificar dados
    [ ] Confirmar
    [ ] Verificar no banco

[ ] Testar EXCLUIR:
    [ ] Selecionar registro
    [ ] Confirmar exclusão
    [ ] Verificar no banco

[ ] Testar Lookups:
    [ ] F4/F5 em cada campo
    [ ] FormBuscaAuxiliar abre
    [ ] Seleção funciona

[ ] Testar Grid:
    [ ] Carrega registros
    [ ] Duplo-clique abre registro
```

## 📝 Conclusão

```
[ ] Checklist final completo (ver acima)
[ ] ValidarUIFidelity: 37 problemas ✅
[ ] Todos os testes manuais: PASS ✅
[ ] Commit (opcional)
[ ] Documentar problemas encontrados (se houver)
```

## ⏱️ Tempo Estimado por Task

| Fase | Tempo |
|------|-------|
| Análise | 30 min |
| BO | 60 min |
| Form | 120 min |
| JSON | 30 min |
| Validação | 30 min |
| Testes | 60 min |
| **TOTAL** | **5h 30min** |

## 🎯 Meta de Sucesso

```
✅ ValidarUIFidelity: 37 problemas
✅ Testes CRUD: 4/4 PASS
✅ Lookups: Todos funcionando
✅ Grid: Carregando
✅ Interface: Pixel-perfect
```

## 🚨 REGRAS CRÍTICAS

1. **NUNCA pule a validação** - ValidarUIFidelity é OBRIGATÓRIO
2. **37 problemas é a meta** - Se tiver mais, CORRIJA antes de continuar
3. **Pixel-perfect é mandatório** - Copie Width/Height/Top/Left EXATOS
4. **FormParaBO/BOParaForm completos** - TODOS os campos devem ser mapeados
5. **Teste TODOS os modos** - INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR

## 📚 Referências Rápidas

- Guia completo: `docs/task1_guia_completo.md`
- Refazer do zero: `docs/REFAZER_TASK1.md`
- Validação: `docs/ui_fidelity_validation.md`
- CLAUDE.md: Seção "UI FIDELITY"

---

**Use este checklist para task2, task3, task4, task5 e economize tempo!** ⚡
