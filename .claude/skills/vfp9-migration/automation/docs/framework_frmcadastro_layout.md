# Layout Padrao do Framework - frmcadastro

Extraido de `Framework\framework.vcx` em 2026-04-10.
Estes valores sao OBRIGATORIOS para todos os forms CRUD migrados.
A LLM NAO deve inventar posicoes - deve usar estes valores EXATOS.

## Form
- Width = 1000, Height = 600
- FontName = "Tahoma", FontSize = 8

## Page1 (Lista) - Componentes e Posicoes

### cnt_4c_Cabecalho (cntSombra no legado)
- Top = 2, Left = 0, Width = 800, Height = 80
- BackColor = RGB(53,53,53), BorderWidth = 0
- **lbl_4c_Sombra**: Top=15, Left=10, Width=769, Height=40, FontName="Tahoma", FontSize=16, FontBold=.T., ForeColor=RGB(0,0,0), BackStyle=0
- **lbl_4c_Titulo**: Top=18, Left=10, Width=769, Height=46, FontName="Tahoma", FontSize=16, FontBold=.T., ForeColor=RGB(255,255,255), BackStyle=0
- Caption: usar Caption do DEFINE CLASS do form original

### cnt_4c_Botoes (Grupo_Op no legado) - LADO DIREITO
- Top = 0, Left = 542, Width = 390, Height = 85
- BackStyle = 1, BackColor = RGB(53,53,53), BorderWidth = 0
- **IMPORTANTE**: Left >= 342 (NUNCA lado esquerdo!)
- Valor 542 usado na nova arquitetura (342 no Framework original com form 800px, proporcional a 1000px)

#### Botoes dentro de cnt_4c_Botoes
| Botao | Left | Top | Width | Height | Caption | Picture | FontName |
|-------|------|-----|-------|--------|---------|---------|----------|
| cmd_4c_Incluir | 5 | 5 | 75 | 75 | Incluir | cadastro_inserir_26.jpg | Comic Sans MS |
| cmd_4c_Visualizar | 80 | 5 | 75 | 75 | Visualizar | cadastro_vizualizar_60.jpg | Comic Sans MS |
| cmd_4c_Alterar | 155 | 5 | 75 | 75 | Alterar | cadastro_alterar_60.jpg | Comic Sans MS |
| cmd_4c_Excluir | 230 | 5 | 75 | 75 | Excluir | cadastro_excluir_60.jpg | Comic Sans MS |
| cmd_4c_Buscar | 305 | 5 | 75 | 75 | Buscar | cadastro_procurar_60.jpg | Comic Sans MS |

#### Propriedades comuns de TODOS os botoes
- FontBold = .T., FontItalic = .T., FontSize = 8
- ForeColor = RGB(90,90,90), BackColor = RGB(255,255,255)
- Themes = .F., SpecialEffect = 0, PicturePosition = 13
- MousePointer = 15, WordWrap = .T., AutoSize = .F.

### cnt_4c_Saida (Grupo_Saida no legado) — PADRAO CANONICO PREVALECE SOBRE PILAR 1
- Top = 29 (compensacao PageFrame), Left = **917**, Width = **90**, Height = 85
- BackStyle = 0 (transparente - fundo vem da Page.Picture), BorderWidth = 0
- **cmd_4c_Encerrar**: Left=5, Top=5, Width=**75**, Height=**75**, Caption=**"Encerrar"**
  - Picture = cadastro_sair_60.jpg
  - Mesmas propriedades comuns dos botoes acima (FontName="Comic Sans MS", Themes=.F., etc.)
- **REGRA DE PRECEDENCIA**: Esses valores sao canonicos (definidos por FormCor/FormMoe) e **prevalecem sobre o PILAR 1** (pixel-perfect legado). Se o SCX legado tiver `Grupo_Saida.Left=935, Width=60, cmdSair.Caption="X"/Width=50`, **IGNORAR** e usar os valores acima.
- **Containers de Page NUNCA subtrair "- 60" por causa do Encerrar**: cnt_4c_Saida eh flutuante/transparente sobre a Page, entao `cnt_4c_Cabecalho.Width = THIS.Width` (NAO `THIS.Width - 60`).
- Auto-fix: CorretorAutomatico patterns **#81 #88 #89**.

### cnt_4c_Filtros (cntFiltros no legado)
- Top = 82+29 = 111 (compensacao PageFrame), Left = 2
- Width e Height: variam conforme o form original
- Visible = depende do form (se original tem filtros)
- **NAO inventar filtros que nao existem no original!**

### grd_4c_Lista (Grade no legado)
- Top = 88+29 = 117 (compensacao PageFrame), Left = 26
- Width = 890 (ajustar para nao sobrepor cnt_4c_Saida)
- Height = 498 (ajustar conforme filtros)
- FontName = "Verdana" (NAO Tahoma!)
- ForeColor = RGB(90,90,90) (default, copiar do original se diferente)
- BackColor = RGB(255,255,255)
- GridLineColor = RGB(238,238,238)
- HighlightBackColor = RGB(255,255,255)
- HighlightForeColor = RGB(15,41,104)
- HighlightStyle = 2
- DeleteMark = .F., RecordMark = .F.
- RowHeight = 16, ScrollBars = 2

## Page2 (Dados) - Componentes e Posicoes

### cnt_4c_Salva (Grupo_Salva no legado)
- Top = 4+29 = 33, Left = 842, Width = 160, Height = 85
- BackStyle = 0, BorderStyle = 0, Themes = .F.

#### Botoes dentro de cnt_4c_Salva
| Botao | Left | Top | Width | Height | Caption | Picture |
|-------|------|-----|-------|--------|---------|---------|
| cmd_4c_Confirmar | 5 | 5 | 75 | 75 | Confirmar | cadastro_salvar_60.jpg |
| cmd_4c_Cancelar | 80 | 5 | 75 | 75 | Cancelar | cadastro_cancelar_60.jpg |

- Mesmas propriedades comuns dos botoes de Page1

## Compensacao PageFrame

O PageFrame externo (pgf_4c_Paginas) tem Top = -29.
Todos os controles DENTRO das Pages precisam compensacao +29 no Top.

Exemplo: cntSombra original Top=2, na Page1 fica Top = 2+29 = 31.
Grupo_Op original Top=0, na Page1 fica Top = 0+29 = 29.

## Regras de Ouro

1. **Botoes CRUD sempre no LADO DIREITO** (Left >= 542)
2. **NUNCA inventar filtros** que nao existem no original
3. **NUNCA inventar tabelas de lookup** que nao existem no original
4. **FontName dos botoes = "Comic Sans MS"** (NAO Tahoma)
5. **Grid FontName = "Verdana"** (NAO Tahoma)
6. **Copiar ForeColor do grid do original** (pode ser vermelho, preto, etc.)
7. **Caption do header = Caption do form original**
8. **Padrao canonico SAIDA/ENCERRAR prevalece sobre PILAR 1** — cnt_4c_Saida + cmd_4c_Encerrar usam os valores da secao "cnt_4c_Saida" acima, NUNCA os do SCX legado (mesmo que o SCX tenha Caption="X" ou Width=50). Ver tambem CLAUDE.md regra #10 e migration-patterns #98.
