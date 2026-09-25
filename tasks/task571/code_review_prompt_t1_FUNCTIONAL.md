# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (69)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_BARRA_BOTOES, CNT_4C__CONSULTA, CNT_4C_ITEM, CNT_4C__CREDITO, CNT_4C_CAIXALIVRE, CNT_4C__GRDBARRA, CNT_4C__PRODUTO, CNT_4C__SUBTOTAL, CNT_4C_DESCONTO, CNT_4C__CHQ. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.HaPagamentoPendente()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.GravarItensLancados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarChequesLancados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGMVITN.Cnt_Consulta): Top original=277 vs migrado 'lbl_4c_Say1' Top=94 (diff=183px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGMVITN.Cnt_Consulta): Left original=34 vs migrado 'lbl_4c_Say1' Left=66 (diff=32px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITN.Cnt_Consulta): Top original=14 vs migrado 'lbl_4c_Label15' Top=108 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGMVITN.CntItem.Cnt_Desconto): Top original=67 vs migrado 'lbl_4c_label202' Top=1 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGMVITN.CntItem.Cnt_Desconto): Left original=324 vs migrado 'lbl_4c_label202' Left=8 (diff=316px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITN.CntItem.Cnt_Desconto): Top original=40 vs migrado 'lbl_4c_Label15' Top=108 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITN.CntItem.Cnt_Desconto): Left original=324 vs migrado 'lbl_4c_Label15' Left=40 (diff=284px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGMVITN.CntItem.Cnt_Desconto): Top original=126 vs migrado 'lbl_4c_Label3' Top=25 (diff=101px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGMVITN.CntItem.Cnt_Desconto): Left original=324 vs migrado 'lbl_4c_Label3' Left=72 (diff=252px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGMVITN.CntItem.Cnt_Desconto): Top original=97 vs migrado 'lbl_4c_label43' Top=2 (diff=95px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGMVITN.CntItem.Cnt_Desconto): Left original=324 vs migrado 'lbl_4c_label43' Left=10 (diff=314px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Proximo' (parent: SIGMVITN.CntItem): Top original=370 vs migrado 'cmd_4c_Proximo' Top=308 (diff=62px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Excluir' (parent: SIGMVITN.CntFinanc.Cnt_GrdBarra): Left original=82 vs migrado 'cmd_4c_Excluir' Left=230 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Proximo' (parent: SIGMVITN.CntFinanc): Top original=353 vs migrado 'cmd_4c_Proximo' Top=308 (diff=45px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITN.CntFinanc): Top original=11 vs migrado 'lbl_4c_Label15' Top=108 (diff=97px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITN.CntFinanc): Left original=134 vs migrado 'lbl_4c_Label15' Left=40 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Proximo' (parent: SIGMVITN.Cnt_Credito): Top original=394 vs migrado 'cmd_4c_Proximo' Top=308 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGMVITN.Cnt_Credito): Top original=422 vs migrado 'lbl_4c_label202' Top=1 (diff=421px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGMVITN.Cnt_Credito): Left original=194 vs migrado 'lbl_4c_label202' Left=8 (diff=186px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Proximo' (parent: SIGMVITN.Cnt_Pendencia): Top original=382 vs migrado 'cmd_4c_Proximo' Top=308 (diff=74px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGMVITN.Cnt_Pendencia): Top original=413 vs migrado 'lbl_4c_label202' Top=1 (diff=412px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGMVITN.Cnt_Pendencia): Left original=168 vs migrado 'lbl_4c_label202' Left=8 (diff=160px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGMVITN.Cnt_Identifica.TabDesconto): Top original=4 vs migrado 'lbl_4c_Say1' Top=94 (diff=90px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGMVITN.Cnt_Identifica.TabDesconto): Left original=10 vs migrado 'lbl_4c_Say1' Left=66 (diff=56px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Proximo' (parent: SIGMVITN.Cnt_Identifica): Top original=400 vs migrado 'cmd_4c_Proximo' Top=308 (diff=92px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGMVITN.Cnt_Identifica.CodOperacao): Top original=8 vs migrado 'lbl_4c_Say1' Top=94 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGMVITN.Cnt_Identifica.CodOperacao): Left original=9 vs migrado 'lbl_4c_Say1' Left=66 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITN.Cnt_Fpagto.Acrescimo): Top original=4 vs migrado 'lbl_4c_Label15' Top=108 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITN.Cnt_Fpagto.Acrescimo): Left original=96 vs migrado 'lbl_4c_Label15' Left=40 (diff=56px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGMVITN.Cnt_Fpagto.Acrescimo): Left original=96 vs migrado 'lbl_4c_label202' Left=8 (diff=88px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITN.Cnt_Fpagto.Desconto): Top original=4 vs migrado 'lbl_4c_Label15' Top=108 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITN.Cnt_Fpagto.Desconto): Left original=89 vs migrado 'lbl_4c_Label15' Left=40 (diff=49px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGMVITN.Cnt_Fpagto.Desconto): Left original=89 vs migrado 'lbl_4c_label202' Left=8 (diff=81px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGMVITN.Cnt_Fpagto): Top original=160 vs migrado 'lbl_4c_Say1' Top=94 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGMVITN.Cnt_Fpagto.Cnt_ChequepreTef.Cnt_Chq): Top original=25 vs migrado 'lbl_4c_Say1' Top=94 (diff=69px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGMVITN.Cnt_Fpagto.Cnt_ChequepreTef.Cnt_Chq): Left original=5 vs migrado 'lbl_4c_Say1' Left=66 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ins' (parent: SIGMVITN.Cnt_Fpagto.Cnt_ChequepreTef.Cnt_Chq): Top original=36 vs migrado 'cmd_4c_Inserir' Top=131 (diff=95px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ins' (parent: SIGMVITN.Cnt_Fpagto.Cnt_ChequepreTef.Cnt_Chq): Left original=330 vs migrado 'cmd_4c_Inserir' Left=3 (diff=327px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Mensagem' (parent: SIGMVITN.Cnt_Mensagem): Top original=2 vs migrado 'cnt_4c__Mensagem' Top=620 (diff=618px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'credito' (parent: SIGMVITN.Barra_Botoes): Top original=1 vs migrado 'cnt_4c__Credito' Top=124 (diff=123px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'credito' (parent: SIGMVITN.Barra_Botoes): Left original=377 vs migrado 'cnt_4c__Credito' Left=32 (diff=345px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ok' (parent: SIGMVITN.Barra_Botoes): Top original=1 vs migrado 'cmd_4c_OkBarra' Top=131 (diff=130px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ok' (parent: SIGMVITN.Barra_Botoes): Left original=677 vs migrado 'cmd_4c_OkBarra' Left=161 (diff=516px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'identifica' (parent: SIGMVITN.Barra_Botoes): Top original=1 vs migrado 'cnt_4c__Identifica' Top=124 (diff=123px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'identifica' (parent: SIGMVITN.Barra_Botoes): Left original=302 vs migrado 'cnt_4c__Identifica' Left=32 (diff=270px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGMVITN.Barra_Botoes): Top original=1 vs migrado 'cmd_4c_CancelaDisp' Top=89 (diff=88px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGMVITN.Barra_Botoes): Left original=752 vs migrado 'cmd_4c_CancelaDisp' Left=414 (diff=338px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Pagto' (parent: SIGMVITN.Barra_Botoes): Top original=1 vs migrado 'cnt_4c__Fpagto' Top=124 (diff=123px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Pagto' (parent: SIGMVITN.Barra_Botoes): Left original=602 vs migrado 'cnt_4c__Fpagto' Left=32 (diff=570px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'pendencia' (parent: SIGMVITN.Barra_Botoes): Top original=1 vs migrado 'cnt_4c__Pendencia' Top=124 (diff=123px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'pendencia' (parent: SIGMVITN.Barra_Botoes): Left original=452 vs migrado 'cnt_4c__Pendencia' Left=32 (diff=420px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITN.CancelaItem): Top original=2 vs migrado 'lbl_4c_Label15' Top=108 (diff=106px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITN.CancelaItem): Left original=1 vs migrado 'lbl_4c_Label15' Left=40 (diff=39px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGMVITN.CancelaItem): Top original=33 vs migrado 'lbl_4c_label202' Top=1 (diff=32px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGMVITN.CancelaItem): Top original=58 vs migrado 'lbl_4c_Label3' Top=25 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGMVITN.CancelaItem): Left original=12 vs migrado 'lbl_4c_Label3' Left=72 (diff=60px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGMVITN.CancelaItem): Top original=84 vs migrado 'lbl_4c_label43' Top=2 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ok' (parent: SIGMVITN.CancelaItem): Top original=89 vs migrado 'cmd_4c_OkBarra' Top=131 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ok' (parent: SIGMVITN.CancelaItem): Left original=368 vs migrado 'cmd_4c_OkBarra' Left=161 (diff=207px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'CaixaLivre' (parent: SIGMVITN.CaixaLivre): Left original=67 vs migrado 'cnt_4c_CaixaLivre' Left=407 (diff=340px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvitn.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (7683 linhas total):

*-- Linhas 14 a 80:
14: *           desabilitado enquanto este form estiver aberto (mesmo padrao de
15: *           FormDCC.prg) e reabilitado no Destroy().
16: *
17: * FASE 3/8: ESTRUTURA BASE - DEFINE CLASS + propriedades + Init/InicializarForm/
18: * Destroy + TODOS os containers estruturais de topo do legado, criados vazios
19: * com a geometria e o visual EXATOS do SCX:
20: *   lbl_4c_TxtCaption (barra de titulo flat), cnt_4c__Img4c, img_4c_FigJpg,
21: *   obj_4c_Timer1, cnt_4c__Consulta, cnt_4c_Item, cnt_4c_Financ,
22: *   cnt_4c__Credito, cnt_4c__Pendencia, cnt_4c__Identifica, cnt_4c__Fpagto,
23: *   cnt_4c_CancelaItem, cnt_4c_CaixaLivre, cnt_4c__Mensagem, cnt_4c_Mensagems,
24: *   cnt_4c_Barra_Botoes.
25: * ConfigurarPageFrame existe como ORQUESTRADOR de layout base (convencao dos
26: * forms OPERACIONAIS flat - FormVca.prg / FormSigMvExp.prg) e NAO cria
27: * PageFrame nenhum: o SCX legado nao tem PageFrame (zero ocorrencias em
28: * tasks\task571\layout.json e nas 583 KB do dump). O papel que o PageFrame
29: * cumpre nos forms CRUD (alternar Lista/Dados) e cumprido aqui pela
30: * alternancia de .Visible dos containers de operacao.
31: *
32: * FASE 4/8: GRADES + BOTOES DE ACAO DAS GRADES + CARGA DE DADOS. Este form
33: * NAO tem Page1=Lista/Page2=Dados nem os 6 botoes CRUD canonicos (Incluir/
34: * Visualizar/Alterar/Excluir/Buscar/Encerrar) - o legado SIGMVITN.SCX e uma
35: * tela de Caixa (frente de venda), nao um cadastro, e nao tem grid de
36: * LISTAGEM de registros para o usuario selecionar/incluir/alterar/excluir
37: * (ver CLAUDE.md "Form Types" - OPERACIONAL usa layout CUSTOM). Inventar
38: * esses 6 botoes ou uma pagina de Lista violaria o PILAR 1 e a regra "NUNCA
39: * inventar funcionalidade que o legado nao tem". O que esta fase adiciona,
40: * fiel ao dump (layout.json / mapeamento.json / slim.txt / linhas 7427-7518
41: * e 16528-16532 do fonte legado):
42: *
43: *   AS CINCO GRADES do legado e o seu bind:
44: *     grd_4c_Cupom      (GrdCupom, filha direta do form)      -> crTpmMvItnC
45: *     grd_4c_Barras     (CntFinanc.Cnt_GrdBarra.grade)        -> TmpBarFin
46: *     grd_4c_Devolucao  (Cnt_Credito.GradeDevol)              -> TmpDevol
47: *     grd_4c_SubNiveis  (Cnt_Pendencia.GradeMultiSubN)        -> TmpOperacao
48: *     grd_4c_Parcelas   (Cnt_Fpagto.Cnt_ChequepreTef.Grade)   -> xPar
49: *   Junto vao os dois containers que hospedam duas delas (cnt_4c__GrdBarra e
50: *   cnt_4c__ChequepreTef) e os QUATRO botoes de acao que o legado cola nas
51: *   grades: cmd_4c_Inserir (F2-Selec), cmd_4c_Excluir (F4-Excluir),
52: *   cmd_4c_OkBarra (F5-Barra) e cmd_4c_BotPend ([F3]Pend., pendencias do cliente).
53: *
54: *   OS CURSORES (CriarCursoresGrades): no legado os cinco ja existiam, criados
55: *   pela tela de movimentacao na datasession COMPARTILHADA - o SCX so fazia
56: *   "Set DataSession To pnDatSes" e os enxergava prontos. Como o form migrado
57: *   usa DataSession = 2 (isolado, como o proprio SCX declara), eles nascem
58: *   aqui, com a estrutura transcrita do uso real no dump.
59: *
60: *   A CARGA (CarregarDados / MontarLinhasCupom / AtualizarGrades): traz do
61: *   banco, pelo BO, os itens ja lancados da movimentacao corrente, remonta as
62: *   linhas de texto do cupom com a formatacao do AtuaCupom legado e repinta as
63: *   cinco grades.
64: *
65: * Os 17 CommandButtons da barra principal (cnt_4c_Barra_Botoes) foram criados
66: * na Fase 3. TextBoxes/ComboBox de dados (Fases 5-6) e eventos/handlers de
67: * Click/KeyPress (Fases 7-8) ficam para as proximas fases - NAO incluidos aqui.
68: *
69: * FASE 5/8: CAMPOS DE DADOS - PRIMEIRA METADE. Preenche o interior dos
70: * containers estruturais criados na Fase 3 com os TextBoxes/Labels/Containers
71: * filhos que o legado tem (layout.json/mapeamento.json/slim.txt), na ordem em
72: * que sao usados durante uma venda: o logotipo e as faixas de mensagem do
73: * rodape, o painel "CAIXA LIVRE", o painel de cancelamento de item
74: * (CancelaItem), o painel de consulta de preco (Cnt_Consulta) e o container
75: * principal de lancamento de itens (CntItem - Cnt_Produto/Cnt_Subtotal/
76: * Cnt_Desconto) e o painel de crediario (CntFinanc). A segunda metade
77: * (Cnt_Identifica, Cnt_Fpagto, os labels remanescentes de Cnt_Credito/
78: * Cnt_Pendencia e cmbTOpers) fica para a Fase 6. Nenhum ControlSource e usado
79: * nestes campos (o legado liga varios deles a TprMvCab, cursor do form PAI que
80: * fica fora de alcance com DataSession=2 isolado - mesma decisao das Fases

*-- Linhas 102 a 258:
102: * PROIBIDOS de reproduzir direto (auto-preenchem com o primeiro match
103: * parcial sem selecao explicita do usuario - CLAUDE.md "fAcessoContas()
104: * PROIBIDO lookup UX" / "fAcessoEmpresa() NAO EXISTE"). Substituidos pelo
105: * padrao canonico FormBuscaAuxiliar (CLAUDE.md #36/#37), acionado em
106: * ENTER/TAB/F4 via BINDEVENT "KeyPress" (Valid nao dispara de forma
107: * confiavel em TextBox - CLAUDE.md #84):
108: *   Grupo            -> SigCdGcr (codigos/descrs)
109: *   Conta/Nome/Cpf   -> SigCdCli (iclis/rclis/cpfs/grupos - NAO grclis),
110: *                       filtrada pelo Grupo quando ja preenchido
111: *   Tab. Desconto    -> SigOpTdz (codigos/descrs)
112: *   Lista de Preco   -> SigCdLpc (lprecos/tipos)
113: *   Forma Pagamento  -> SigOpFp (fpags/descrs/fparcs)
114: * Os quatro blocos de conta (Destino/Responsavel/Vendedor/Origem) reusam os
115: * MESMOS dois metodos protegidos (AbrirLookupGrupo/AbrirLookupConta) - cada
116: * bloco so tem handlers PUBLIC de KeyPress proprios (BINDEVENT exige metodo
117: * PUBLIC - CLAUDE.md #3) que resolvem o container correto e delegam.
118: *
119: * FASE 7/8: EVENTOS PRINCIPAIS. Liga (RegistrarEventosPrincipais, chamado do
120: * InicializarForm) o Click dos 17 CommandButtons da barra principal, dos 4
121: * botoes de acao das grades, dos paineis CancelaItem/Consulta e das 5 setas
122: * "Proximo". Corrige tambem um bug critico deixado pela Fase 4: os seis
123: * containers de operacao (CntItem/CntFinanc/Cnt_Credito/Cnt_Pendencia/
124: * Cnt_Identifica/Cnt_Fpagto) nasciam TODOS Visible=.T. empilhados na mesma
125: * area (Top=124 Left=32) - o novo AlternarTelaOperacao(par_cTela) garante que
126: * so um fica visivel por vez, como no legado (cada Click de navegacao zera a
127: * visibilidade dos irmaos antes de mostrar o proprio), e o InicializarForm
128: * passa a fixar "ITENS" como tela inicial.
129: * Limite de escopo (heranca das Fases 1-6): DataSession=2 isola este form dos
130: * cursores globais do form de movimentacao pai (crSigCdOpe, CrSigOpCdc,
131: * TprMvCab) e das rotinas dele (AcioSalva, AcioCancela, Cancel_Item_Gen,
132: * AtuaTotal, VerStatus, AciomudaOpe). Guardas do legado que dependem so de
133: * CURSORES/PROPRIEDADES LOCAIS (crTpmMvItn, TmpOperacao, TmpDevol, TmpBarFin,
134: * xPar, this_*) sao transcritos fielmente (Barra_Botoes.Acrescimo/apaga/
135: * MudaOpe/ok/credito/pendencia/Financia); os que dependem de hardware fiscal/
136: * TEF ou senha de supervisor (impressora ECF, SigOpSen, SigOpPen, SIGMEFIS)
137: * nao tem como ser reproduzidos sem esse modulo/hardware - documentados caso
138: * a caso em cada metodo, nunca silenciados. Ok/Confirmar valida os dados
139: * locais (itens lancados, forma de pagamento informada) e devolve o controle
140: * ao form pai via THIS.Release() - a finalizacao fiscal (emissao do cupom)
141: * e responsabilidade dele.
142: *
143: * FASE 8/8: EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Fecha os fluxos que a
144: * Fase 7 deixou parcialmente ligados e os que dependem de controles criados
145: * so na Fase 6:
146: *   - Cancelamento de item (CancelaItem): LimparCntItem/ExcluirItemCorrente
147: *     dao corpo a CancelaItemOkClick/CancelaItemCancelaDispClick (Fase 7),
148: *     reproduzindo o Cancel_Item_Gen local (remove de crTpmMvItn, refaz
149: *     RecalcularTotalCarrinho, refecha o painel).
150: *   - Confirmacao manual de item com preco alterado (CmdEnviaProdClick),
151: *     ligado ao unico CommandButton que o legado mantem oculto por padrao
152: *     (Cnt_Produto.CmdEnviaProd, When = lAlteraPreco).
153: *   - Atalho "Cadastro de Contas" dos blocos Origem/Destino
154: *     (AbrirCadastroConta + BtnCadastrosDestinoClick/BtnCadastrosOrigemClick)
155: *     e a seta Proximo de Identifica (IdentificaProximoClick), que so avanca
156: *     para Pagamento com o mesmo guard HaPagamentoPend() do legado.
157: *   - Conferencia do cheque pre-datado (Cnt_ChequepreTef.Cnt_Chq):
158: *     LimparChequePreTef, ValidarChequesLancados (SCAN de conferencia dos
159: *     numeros lancados em xPar), CmdTefChqClick (rodape do legado - cheque
160: *     invalido limpa e devolve o foco; cheque valido e forma batida reabilita
161: *     Confirmar/Cancelar e dispara o Confirmar) e CmdInsChequeClick (Ins -
162: *     replica banco/agencia/conta/CPF/praca da linha corrente para as
163: *     seguintes, incrementando o numero do cheque). A consulta ao gerenciador
164: *     TEF em si (SigFiTefReq/VerifGP) e o acionamento da impressora de cheque
165: *     (PertoHabilita/ChronoHabilita) ficam fora de alcance (driver de
166: *     hardware) - CmdTefChqClick avisa isso explicitamente ao usuario em vez
167: *     de aprovar calado (CLAUDE.md #27).
168: *
169: *   Consolidacao verificada nesta fase (sem alterar logica ja escrita nas
170: *   Fases 1-7): contagem balanceada de PROCEDURE/FUNCTION (104) contra
171: *   ENDPROC/ENDFUNC (102+2), IF/ENDIF (179/179), WITH/ENDWITH (239/239),
172: *   TRY/ENDTRY (8/8), FOR/ENDFOR (3/3) e DO WHILE/ENDDO (1/1); todo
173: *   THIS.this_oBusinessObject.<metodo> chamado pelo form (CarregarItensMovi-
174: *   mento, CarregarParametrosOperacao) existe em sigmvitnBO.prg; todo handler
175: *   de KeyPress/Click declarado tem o BINDEVENT correspondente (64 ao todo,
176: *   parte em RegistrarEventosPrincipais, parte nos proprios Configurar-
177: *   Campos* que criam o controle); nenhum TODO/FIXME/stub/"sera implementado"
178: *   restou no arquivo.
179: *
180: *   CONSOLIDACAO CANONICA desta fase - o que foi entregue e por que:
181: *
182: *   - FormParaBO / BOParaForm: transferencia real entre o carrinho
183: *     (crTpmMvItn) e as propriedades do sigmvitnBO. NAO existiam no legado
184: *     porque la o cursor pertencia a tela de movimentacao PAI e vivia na
185: *     datasession COMPARTILHADA ("Set DataSession To pnDatSes"), e era o pai
186: *     quem gravava tudo no fim (AcioSalva -> TableUpdate). Com DataSession = 2
187: *     (isolado, como o SCX declara) o pai NAO ve este cursor, entao a
188: *     transferencia e a gravacao passam a ser deste form. Mapeiam SO as
189: *     colunas que a tela possui; as ~100 propriedades fiscais/de rateio do BO
190: *     ficam com o default da Fase 2 - preenche-las aqui seria inventar valor
191: *     de imposto e gravar numero errado em silencio (CLAUDE.md #27).
192: *   - GravarItensLancados: grava item a item via BO (NovoRegistro +
193: *     FormParaBO + Salvar), aborta no primeiro erro e devolve .F. - nao
194: *     existe "gravou metade da venda". Chamado por BtnConfirmarClick ANTES de
195: *     anunciar sucesso: sem isto o Confirmar dizia "venda validada" e fechava
196: *     a tela sem ter escrito nada em SigMvItn (CLAUDE.md #189).
197: *   - BtnConfirmarClick / BtnCancelarClick: sao os DOIS botoes que o legado
198: *     realmente tem na barra (Barra_Botoes.ok Caption "Confirmar" e
199: *     Barra_Botoes.Cancela Caption "Cancelar", Cancel = .T.) - renomeados dos
200: *     provisorios CmdOkClick/CmdCancelaClick para o nome canonico do projeto
201: *     (PILAR 3). Nenhum botao foi inventado.
202: *   - CarregarLista: ponto de entrada canonico de recarga. Este form nao tem
203: *     pagina de LISTA de registros; o que ele lista e o CUPOM da venda
204: *     corrente (grd_4c_Cupom), e e isso que o metodo recarrega e repinta.
205: *   - HabilitarCampos / LimparCampos / AjustarBotoesPorModo: transcricao das
206: *     clausulas When do SCX (Get_*.When e Barra_Botoes.*.When), que sao o
207: *     mecanismo do legado para gate de campo e de botao. Nao ha como delegar
208: *     um When por BINDEVENT (o retorno e descartado - CLAUDE.md #3), por isso
209: *     viraram gate unico. AjustarBotoesPorModo e chamado no fim de
210: *     AlternarTelaOperacao, o FUNIL por onde toda troca de tela passa
211: *     (CLAUDE.md #40).
212: *   - BtnBuscarClick / BtnEncerrarClick continuam NAO existindo: o legado nao
213: *     tem botao de busca de registro nem de "Encerrar" nesta tela (a saida e o
214: *     Cancelar, Cancel = .T.). Cria-los seria inventar botao que o legado nao
215: *     tem (PILAR 1). A consulta de preco, que e o que ha de "busca" aqui, ja
216: *     esta em CmdVerPrecoClick (Ctrl+P, Barra_Botoes.VerPreco).
217: *
218: *   Por ser form filho (aberto via CREATEOBJECT("Formsigmvitn", oParentForm,
219: *   nDataSes) pelo form de movimentacao, nunca pelo usuario direto), NAO ha
220: *   nem deve haver entrada em menu.prg/popMovimentos - end-to-end o form so e
221: *   alcancavel a partir da tela de movimentacao que o instancia.
222: *==============================================================================
223: 
224: DEFINE CLASS Formsigmvitn AS FormBase
225: 
226:     *-- Propriedades nativas do Form (copiadas do dump legado - CLAUDE.md #33)
227:     Width        = 1300
228:     Height       = 1400
229:     AutoCenter   = .T.
230:     TitleBar     = 0
231:     ShowWindow   = 1
232:     WindowType   = 1
233:     ControlBox   = .F.
234:     MaxButton    = .F.
235:     MinButton    = .F.
236:     Movable      = .F.
237:     BorderStyle  = 0
238:     ClipControls = .F.
239:     KeyPreview   = .T.
240:     ShowTips     = .T.
241:     Caption      = "Caixa"
242:     DataSession  = 2
243: 
244:     *--------------------------------------------------------------------------
245:     * Propriedades de integracao com o form pai (padrao FormDCC.prg)
246:     *--------------------------------------------------------------------------
247:     this_oParentForm = .NULL.   && ref. ao form de movimentacao que abriu este
248:     this_nDataSes     = 0        && DataSessionId do pai (so referencia/compat -
249:                                   && este form usa DataSession=2 isolado, NAO
250:                                   && "Set DataSession To" como o legado fazia)
251: 
252:     *--------------------------------------------------------------------------
253:     * Contexto da movimentacao que esta sendo operada no Caixa (Empresa +
254:     * Operacao + Numero do documento). No legado esses tres valores eram lidos
255:     * direto de TprMvCab, o cursor de cabecalho que a tela de movimentacao
256:     * mantinha na datasession COMPARTILHADA. Com DataSession = 2 o cursor do
257:     * pai nao e visivel aqui, entao o contexto e recebido do form pai no Init
258:     * e guardado nestas tres propriedades - sao elas que o BO usa para trazer

*-- Linhas 361 a 604:
361:     * aberto) e o DataSessionId dele (so guardado por compatibilidade - este
362:     * form usa DataSession=2 isolado).
363:     *--------------------------------------------------------------------------
364:     PROCEDURE Init()
365:         LPARAMETERS par_oParentForm, par_nDataSes
366: 
367:         *-- BackColor = RGB(255,255,255) do dump legado (fundo branco). Nao pode
368:         *-- ser default de PEM na DEFINE CLASS (VFP9 so aceita literal simples
369:         *-- na declaracao) - setado aqui em runtime.
370:         THIS.BackColor = RGB(255, 255, 255)
371: 
372:         LOCAL loc_oErro
373:         TRY
374:             IF VARTYPE(par_oParentForm) = "O"
375:                 THIS.this_oParentForm = par_oParentForm
376:                 THIS.this_oParentForm.Enabled = .F.
377:             ENDIF
378: 
379:             THIS.this_nDataSes = IIF(VARTYPE(par_nDataSes) = "N", par_nDataSes, 0)
380: 
381:             *-- Contexto da movimentacao. O legado lia TprMvCab (cursor do pai,
382:             *-- na datasession compartilhada); aqui o pai publica os mesmos tres
383:             *-- valores em propriedades, e o Caixa as copia. PEMSTATUS antes de
384:             *-- cada leitura porque o Caixa tambem e aberto por telas que ainda
385:             *-- nao expoem esse contexto - nesse caso a empresa cai no padrao do
386:             *-- sistema e a venda comeca sem numero (this_nNumes = 0), que e o
387:             *-- estado "caixa livre" do legado.
388:             THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
389: 
390:             IF VARTYPE(THIS.this_oParentForm) = "O"
391:                 IF PEMSTATUS(THIS.this_oParentForm, "this_cEmps", 5)
392:                     IF !EMPTY(THIS.this_oParentForm.this_cEmps)
393:                         THIS.this_cEmps = THIS.this_oParentForm.this_cEmps
394:                     ENDIF
395:                 ENDIF
396: 
397:                 IF PEMSTATUS(THIS.this_oParentForm, "this_cDopes", 5)
398:                     THIS.this_cDopes = THIS.this_oParentForm.this_cDopes
399:                 ENDIF
400: 
401:                 IF PEMSTATUS(THIS.this_oParentForm, "this_nNumes", 5)
402:                     THIS.this_nNumes = THIS.this_oParentForm.this_nNumes
403:                 ENDIF
404:             ENDIF
405:         CATCH TO loc_oErro
406:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
407:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Init")
408:         ENDTRY
409: 
410:         RETURN DODEFAULT()
411:     ENDPROC
412: 
413:     *--------------------------------------------------------------------------
414:     * InicializarForm - cria o Business Object e a estrutura visual base.
415:     * Grid/botoes CRUD, campos e eventos entram nas proximas fases.
416:     *--------------------------------------------------------------------------
417:     PROTECTED PROCEDURE InicializarForm()
418:         LOCAL loc_lSucesso, loc_oErro
419:         loc_lSucesso = .F.
420: 
421:         TRY
422:             *-- DataSession = 2 (privada) nasce com os SET no DEFAULT do VFP9,
423:             *-- nao com os do config.prg - mesma armadilha que o FormBase ja
424:             *-- trata para SET DATE/CENTURY (CLAUDE.md #9.4). Medido no VFP9 em
425:             *-- 2026-09-24: config.prg faz "SET DELETED ON", mas dentro desta
426:             *-- datasession SET("DELETED") volta OFF, e ai linha DELETADA fica
427:             *-- VISIVEL. Consequencia real: o item que o caixa CANCELOU
428:             *-- (ExcluirItemCorrente faz DELETE logico, sem PACK) continuaria
429:             *-- sendo contado no total e GRAVADO em SigMvItn pelo Confirmar -
430:             *-- o cliente pagaria por item cancelado. Normalizado aqui, no
431:             *-- inicio do Init, para valer em TODA operacao de cursor deste
432:             *-- form (COUNT/SUM/SKIP/SCAN e as cinco grades).
433:             SET DELETED ON
434: 
435:             THIS.this_oBusinessObject = CREATEOBJECT("sigmvitnBO")
436: 
437:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
438:                 *-- Os cursores das grades nascem ANTES dos controles: assim o
439:                 *-- MontaGrade, logo abaixo, encontra os alias prontos. Ligar
440:                 *-- Column.ControlSource a cursor inexistente estoura dentro
441:                 *-- deste TRY e o form nao chega a abrir (CLAUDE.md #41).
442:                 THIS.CriarCursoresGrades()
443: 
444:                 THIS.ConfigurarPageFrame()
445: 
446:                 *-- Bind das cinco grades (RecordSource/ControlSource/Width/
447:                 *-- cabecalhos). Separado da criacao dos controles porque
448:                 *-- RecordSource reseta Width, Header1.Caption, CurrentControl
449:                 *-- e Sparse - tudo isso precisa vir DEPOIS dele.
450:                 THIS.MontaGrade()
451: 
452:                 THIS.TornarControlesVisiveis(THIS)
453: 
454:                 *-- Carga inicial: traz do banco os itens ja lancados desta
455:                 *-- movimentacao, remonta as linhas do cupom e repinta as
456:                 *-- grades. Nao aborta a abertura se falhar - a tela do Caixa
457:                 *-- continua utilizavel para lancar item novo.
458:                 THIS.CarregarDados()
459: 
460:                 *-- FASE 7/8: eventos principais. Liga os Click/KeyPress dos
461:                 *-- 17 botoes da barra principal, dos botoes de acao das
462:                 *-- grades, dos paineis CancelaItem/Consulta e das setas
463:                 *-- "Proximo" de cada tela - e define ITENS como tela inicial
464:                 *-- (sem isto, os seis containers de operacao ficam TODOS
465:                 *-- Visible=.T. ao mesmo tempo, empilhados na mesma area).
466:                 THIS.RegistrarEventosPrincipais()
467:                 THIS.AlternarTelaOperacao("ITENS")
468: 
469:                 loc_lSucesso = .T.
470:             ELSE
471:                 MsgErro("Falha ao criar sigmvitnBO.", "Erro em InicializarForm")
472:             ENDIF
473:         CATCH TO loc_oErro
474:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
475:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
476:         ENDTRY
477: 
478:         RETURN loc_lSucesso
479:     ENDPROC
480: 
481:     *--------------------------------------------------------------------------
482:     * ConfigurarPageFrame - orquestrador do layout base.
483:     *
484:     * O SIGMVITN.SCX legado e FLAT: nao ha UMA ocorrencia de PageFrame nem no
485:     * layout.json nem nas 583 KB do dump do fonte. Criar um PageFrame
486:     * Lista/Dados aqui inventaria um controle que o legado nao tem (viola o
487:     * PILAR 1) e ainda cobriria os containers de operacao. Seguindo a convencao
488:     * ja adotada nos forms OPERACIONAIS flat do projeto (FormVca.prg, migrado
489:     * de SIGALTDT, e FormSigMvExp.prg, de SIGMVEXP), o metodo mantem o nome
490:     * canonico de orquestrador de layout base e delega para os metodos que
491:     * montam os controles que o legado REALMENTE tem.
492:     *
493:     * A ORDEM abaixo e a ordem de empilhamento (ZOrder implicito do AddObject:
494:     * o ultimo desenha por cima). Cabecalho e logotipo primeiro, depois os
495:     * containers de operacao, e por fim a barra de botoes - que no legado fica
496:     * SOBRE a area central (Top=20..99 contra containers em Top=124) e por isso
497:     * precisa ser criada DEPOIS deles.
498:     *--------------------------------------------------------------------------
499:     PROTECTED PROCEDURE ConfigurarPageFrame()
500:         THIS.ConfigurarCabecalho()
501:         THIS.ConfigurarElementosAuxiliares()
502:         THIS.ConfigurarGridCupom()
503:         THIS.ConfigurarContainersOperacao()
504:         THIS.ConfigurarGradesOperacao()
505:         THIS.ConfigurarContainersMensagem()
506:         THIS.ConfigurarBarraBotoes()
507: 
508:         *-- FASE 5/8: primeira metade dos campos de dados (ver cabecalho do
509:         *-- arquivo). Chamado por ultimo porque preenche o INTERIOR dos
510:         *-- containers ja criados acima - a ordem entre os proprios containers
511:         *-- de topo nao muda.
512:         THIS.ConfigurarCamposParte1()
513: 
514:         *-- FASE 6/8: segunda metade dos campos de dados - Cnt_Identifica
515:         *-- (COMPLETO, com todos os lookups de Grupo/Conta/Cpf), Cnt_Fpagto
516:         *-- (COMPLETO, incluindo Cnt_ChequepreTef.Cnt_Chq), os labels
517:         *-- remanescentes de Cnt_Credito/Cnt_Pendencia e cmbTOpers.
518:         THIS.ConfigurarCamposParte2()
519:     ENDPROC
520: 
521:     *--------------------------------------------------------------------------
522:     * ConfigurarCabecalho - barra de titulo flat no topo (equivalente ao
523:     * TxtCaption legado). Este form NAO usa o padrao cnt_4c_Cabecalho com
524:     * lbl_4c_Sombra+lbl_4c_Titulo dos forms CRUD (frmcadastro): o legado nao
525:     * tem PageFrame nem faixa decorativa dupla, so um label direto no form.
526:     * Original: TxtCaption Top=0 Left=-1 Width=1300 Height=19 BackColor=90,90,90
527:     * ForeColor=255,255,255 FontName="Tahoma" FontBold=.T. Caption="  Caixa".
528:     *--------------------------------------------------------------------------
529:     PROTECTED PROCEDURE ConfigurarCabecalho()
530:         THIS.AddObject("lbl_4c_TxtCaption", "Label")
531:         WITH THIS.lbl_4c_TxtCaption
532:             .Top       = 0
533:             .Left      = -1
534:             .Width     = THIS.Width
535:             .Height    = 19
536:             .FontName  = "Tahoma"
537:             .FontBold  = .T.
538:             .Alignment = 0
539:             .BackStyle = 1
540:             .BackColor = RGB(90, 90, 90)
541:             .ForeColor = RGB(255, 255, 255)
542:             .Caption   = "  " + THIS.Caption
543:             .Visible   = .T.
544:         ENDWITH
545:     ENDPROC
546: 
547:     *--------------------------------------------------------------------------
548:     * ConfigurarGridCupom - grade READONLY que lista os itens do cupom em
549:     * andamento (GrdCupom no legado). Coluna unica, sem cabecalho (o legado
550:     * usa HeaderHeight=0 - cada linha e uma string formatada, no padrao de
551:     * cupom fiscal), fonte Verdana azul (ForeColor=RGB(0,0,255) no dump).
552:     * RecordSource/ControlSource NAO sao setados aqui de proposito - o cursor
553:     * do carrinho (cursor_4c_Cupom ou equivalente) so existe a partir da fase
554:     * de eventos/CarregarCupom; setar ControlSource contra cursor inexistente
555:     * derruba o Init (CLAUDE.md #41). Fica atras de cnt_4c_CaixaLivre no
556:     * z-order (criado ANTES dele), exatamente como no legado: o painel "CAIXA
557:     * LIVRE" cobre a grade quando nao ha operacao em andamento.
558:     * Original: GrdCupom Top=127 Left=407 Width=340 Height=312 ColumnCount=1
559:     * Enabled=.F. GridLines=0 HeaderHeight=0 ReadOnly=.T. RecordMark=.F.
560:     * ScrollBars=0. Column1: FontName="Verdana" Width=345 Movable=.F.
561:     * ReadOnly=.T. ForeColor=0,0,255. Header1.Caption="Header1" (legado nao
562:     * troca - HeaderHeight=0 o esconde).
563:     *--------------------------------------------------------------------------
564:     PROTECTED PROCEDURE ConfigurarGridCupom()
565:         THIS.AddObject("grd_4c_Cupom", "Grid")
566:         WITH THIS.grd_4c_Cupom
567:             .Top           = 127
568:             .Left          = 407
569:             .Width         = 340
570:             .Height        = 312
571:             .ColumnCount   = 1
572:             .Enabled       = .F.
573:             .GridLines     = 0
574:             .HeaderHeight  = 0
575:             .ReadOnly      = .T.
576:             .RecordMark    = .F.
577:             .DeleteMark    = .F.
578:             .ScrollBars    = 0
579:             .Visible       = .T.
580: 
581:             .Column1.FontBold  = .F.
582:             .Column1.FontName  = "Verdana"
583:             .Column1.Enabled   = .F.
584:             .Column1.Width     = 345
585:             .Column1.Movable   = .F.
586:             .Column1.ReadOnly  = .T.
587:             .Column1.ForeColor = RGB(0, 0, 255)
588:             .Column1.Header1.FontSize = 8
589:             .Column1.Header1.Caption  = "Header1"
590:             .Column1.Text1.FontBold   = .F.
591:             .Column1.Text1.FontName   = "Verdana"
592:             .Column1.Text1.BorderStyle = 0
593:             .Column1.Text1.Enabled    = .F.
594:             .Column1.Text1.Margin     = 0
595:             .Column1.Text1.ReadOnly   = .T.
596:             .Column1.Text1.ForeColor  = RGB(0, 0, 255)
597:             .Column1.Text1.BackColor  = RGB(255, 255, 255)
598:         ENDWITH
599:     ENDPROC
600: 
601:     *--------------------------------------------------------------------------
602:     * ConfigurarBarraBotoes - container da barra de botoes principal e os 17
603:     * CommandButtons que o legado tem dentro dele. Varios pares de botoes
604:     * OCUPAM O MESMO Left (Alteraqtd/Desconto/Acrescimo em Left=77,

*-- Linhas 615 a 1036:
615:     * Original: Barra_Botoes Top=20 Left=470 Width=831 Height=79 BackStyle=0
616:     * BorderWidth=0 SpecialEffect=0 TabIndex=8.
617:     *--------------------------------------------------------------------------
618:     PROTECTED PROCEDURE ConfigurarBarraBotoes()
619:         LOCAL loc_cIcones
620:         loc_cIcones = gc_4c_CaminhoIcones
621: 
622:         THIS.AddObject("cnt_4c_Barra_Botoes", "Container")
623:         WITH THIS.cnt_4c_Barra_Botoes
624:             .Top           = 20
625:             .Left          = 470
626:             .Width         = 831
627:             .Height        = 79
628:             .BackStyle = 1
629:             .BackColor = RGB(255, 255, 255)
630:             .BorderWidth   = 0
631:             .SpecialEffect = 0
632:             .TabIndex      = 8
633:             .Visible       = .T.
634:         ENDWITH
635: 
636:             *-- [F2] Itens - tela padrao de lancamento de itens.
637:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Itens", "CommandButton")
638:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens
639:                 .Top             = 1
640:                 .Left            = 2
641:                 .Width           = 75
642:                 .Height          = 75
643:                 .AutoSize        = .F.
644:                 .FontBold        = .T.
645:                 .FontItalic      = .T.
646:                 .FontName        = "Comic Sans MS"
647:                 .FontSize        = 8
648:                 .WordWrap        = .T.
649:                 .Picture         = loc_cIcones + "geral_palete_60.jpg"
650:                 .Caption         = "[F2]Itens"
651:                 .MousePointer    = 15
652:                 .TabIndex        = 1
653:                 .ToolTipText     = "[F2] Tela de Itens"
654:                 .SpecialEffect   = 0
655:                 .PicturePosition = 13
656:                 .ForeColor          = RGB(90, 90, 90)
657:                 .BackColor          = RGB(255, 255, 255)
658:                 .DisabledForeColor  = RGB(109, 109, 109)
659:                 .DisabledBackColor  = RGB(240, 240, 240)
660:                 .Themes          = .F.
661:                 .Visible         = .T.
662:             ENDWITH
663: 
664:             *-- [F3] Alteraqtd - alterar quantidade do item corrente.
665:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Alteraqtd", "CommandButton")
666:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Alteraqtd
667:                 .Top             = 1
668:                 .Left            = 77
669:                 .Width           = 75
670:                 .Height          = 75
671:                 .FontBold        = .T.
672:                 .FontItalic      = .T.
673:                 .FontName        = "Comic Sans MS"
674:                 .FontSize        = 8
675:                 .Picture         = loc_cIcones + "geral_calculadora_60.jpg"
676:                 .Caption         = "[F3]Qtde"
677:                 .TabIndex        = 2
678:                 .ToolTipText     = "[F3] Quantidades"
679:                 .ForeColor          = RGB(90, 90, 90)
680:                 .BackColor          = RGB(255, 255, 255)
681:                 .DisabledForeColor  = RGB(109, 109, 109)
682:                 .DisabledBackColor  = RGB(240, 240, 240)
683:                 .Themes          = .F.
684:                 .Visible         = .T.
685:             ENDWITH
686: 
687:             *-- [F3] Desconto - desconto do item corrente (mesmo Left do
688:             *-- Alteraqtd - so um dos dois fica visivel por vez).
689:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Desconto", "CommandButton")
690:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Desconto
691:                 .Top             = 1
692:                 .Left            = 77
693:                 .Width           = 75
694:                 .Height          = 75
695:                 .FontBold        = .T.
696:                 .FontItalic      = .T.
697:                 .FontName        = "Comic Sans MS"
698:                 .FontSize        = 8
699:                 .Picture         = loc_cIcones + "geral_calculadora_60.jpg"
700:                 .Caption         = "[F3]Descon."
701:                 .TabIndex        = 3
702:                 .ToolTipText     = "[F3] Descontos"
703:                 .ForeColor          = RGB(90, 90, 90)
704:                 .BackColor          = RGB(255, 255, 255)
705:                 .DisabledForeColor  = RGB(109, 109, 109)
706:                 .DisabledBackColor  = RGB(240, 240, 240)
707:                 .Themes          = .F.
708:                 .Visible         = .T.
709:             ENDWITH
710: 
711:             *-- [Ctrl+F3] Acrescimo - acrescimo do item corrente (mesmo Left
712:             *-- do par Alteraqtd/Desconto).
713:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Acrescimo", "CommandButton")
714:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Acrescimo
715:                 .Top             = 1
716:                 .Left            = 77
717:                 .Width           = 75
718:                 .Height          = 75
719:                 .FontBold        = .T.
720:                 .FontItalic      = .T.
721:                 .FontName        = "Comic Sans MS"
722:                 .FontSize        = 8
723:                 .Picture         = loc_cIcones + "geral_datas_60.jpg"
724:                 .Caption         = "[Ctrl+F3] +"
725:                 .TabIndex        = 3
726:                 .ToolTipText     = "[Ctrl + F3] Acr" + CHR(233) + "scimos"
727:                 .ForeColor          = RGB(90, 90, 90)
728:                 .BackColor          = RGB(255, 255, 255)
729:                 .DisabledForeColor  = RGB(109, 109, 109)
730:                 .DisabledBackColor  = RGB(240, 240, 240)
731:                 .Themes          = .F.
732:                 .Visible         = .T.
733:             ENDWITH
734: 
735:             *-- [F4] CancPagto - cancelar forma de pagamento lancada.
736:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_CancPagto", "CommandButton")
737:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_CancPagto
738:                 .Top             = 1
739:                 .Left            = 152
740:                 .Width           = 75
741:                 .Height          = 75
742:                 .FontBold        = .T.
743:                 .FontItalic      = .T.
744:                 .FontName        = "Comic Sans MS"
745:                 .FontSize        = 8
746:                 .Picture         = loc_cIcones + "cadastro_cancelar_60.jpg"
747:                 .Caption         = "[F4]Canc"
748:                 .TabIndex        = 5
749:                 .ToolTipText     = "[F4] Cancelar Forma de Pagamento"
750:                 .ForeColor          = RGB(90, 90, 90)
751:                 .BackColor          = RGB(255, 255, 255)
752:                 .DisabledForeColor  = RGB(109, 109, 109)
753:                 .DisabledBackColor  = RGB(240, 240, 240)
754:                 .Themes          = .F.
755:                 .Visible         = .T.
756:             ENDWITH
757: 
758:             *-- [F4] Apaga - cancelar a operacao/venda inteira (mesmo Left do
759:             *-- CancPagto).
760:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Apaga", "CommandButton")
761:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Apaga
762:                 .Top             = 1
763:                 .Left            = 152
764:                 .Width           = 75
765:                 .Height          = 75
766:                 .FontBold        = .T.
767:                 .FontItalic      = .T.
768:                 .FontName        = "Comic Sans MS"
769:                 .FontSize        = 8
770:                 .Picture         = loc_cIcones + "cadastro_cancelar_60.jpg"
771:                 .Caption         = "[F4]Canc"
772:                 .TabIndex        = 4
773:                 .ToolTipText     = "[F4] Cancelar Opera" + CHR(231) + CHR(227) + "o"
774:                 .ForeColor          = RGB(90, 90, 90)
775:                 .BackColor          = RGB(255, 255, 255)
776:                 .DisabledForeColor  = RGB(109, 109, 109)
777:                 .DisabledBackColor  = RGB(240, 240, 240)
778:                 .Themes          = .F.
779:                 .Visible         = .T.
780:             ENDWITH
781: 
782:             *-- [F5] AltPreco - alteracao de precos.
783:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_AltPreco", "CommandButton")
784:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_AltPreco
785:                 .Top             = 1
786:                 .Left            = 227
787:                 .Width           = 75
788:                 .Height          = 75
789:                 .FontBold        = .T.
790:                 .FontItalic      = .T.
791:                 .FontName        = "Comic Sans MS"
792:                 .FontSize        = 8
793:                 .WordWrap        = .T.
794:                 .Picture         = loc_cIcones + "geral_cambio_60.jpg"
795:                 .Caption         = "[F5]Alt.$"
796:                 .TabIndex        = 6
797:                 .ToolTipText     = "[F5] Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
798:                 .ForeColor          = RGB(90, 90, 90)
799:                 .BackColor          = RGB(255, 255, 255)
800:                 .DisabledForeColor  = RGB(109, 109, 109)
801:                 .DisabledBackColor  = RGB(240, 240, 240)
802:                 .Themes          = .F.
803:                 .Visible         = .T.
804:             ENDWITH
805: 
806:             *-- [F6] Identifica - identificacao de contas (Origem/Destino/
807:             *-- Vendedor/Responsavel).
808:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Identifica", "CommandButton")
809:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Identifica
810:                 .Top             = 1
811:                 .Left            = 302
812:                 .Width           = 75
813:                 .Height          = 75
814:                 .FontBold        = .T.
815:                 .FontItalic      = .T.
816:                 .FontName        = "Comic Sans MS"
817:                 .FontSize        = 8
818:                 .Picture         = loc_cIcones + "geral_contatos_60.jpg"
819:                 .Caption         = "[F6]Identif"
820:                 .TabIndex        = 7
821:                 .ToolTipText     = "[F6] Identifica" + CHR(231) + CHR(227) + "o de Contas"
822:                 .ForeColor          = RGB(90, 90, 90)
823:                 .BackColor          = RGB(255, 255, 255)
824:                 .DisabledForeColor  = RGB(109, 109, 109)
825:                 .DisabledBackColor  = RGB(240, 240, 240)
826:                 .Themes          = .F.
827:                 .Visible         = .T.
828:             ENDWITH
829: 
830:             *-- [F7] Credito - operacoes de credito/devolucao.
831:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Credito", "CommandButton")
832:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Credito
833:                 .Top             = 1
834:                 .Left            = 377
835:                 .Width           = 75
836:                 .Height          = 75
837:                 .FontBold        = .T.
838:                 .FontItalic      = .T.
839:                 .FontName        = "Comic Sans MS"
840:                 .FontSize        = 8
841:                 .Picture         = loc_cIcones + "cadastro_vizualizar_60.jpg"
842:                 .Caption         = "[F7]Cr" + CHR(233) + "d."
843:                 .TabIndex        = 8
844:                 .ToolTipText     = "[F7] Cr" + CHR(233) + "ditos"
845:                 .ForeColor          = RGB(90, 90, 90)
846:                 .BackColor          = RGB(255, 255, 255)
847:                 .DisabledForeColor  = RGB(109, 109, 109)
848:                 .DisabledBackColor  = RGB(240, 240, 240)
849:                 .Themes          = .F.
850:                 .Visible         = .T.
851:             ENDWITH
852: 
853:             *-- [F8] Financia - crediario (desligado por padrao no legado -
854:             *-- Visible=.F. - mesmo Left de Pendencia).
855:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Financia", "CommandButton")
856:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Financia
857:                 .Top             = 1
858:                 .Left            = 452
859:                 .Width           = 75
860:                 .Height          = 75
861:                 .FontBold        = .T.
862:                 .FontItalic      = .T.
863:                 .FontName        = "Comic Sans MS"
864:                 .FontSize        = 8
865:                 .Picture         = loc_cIcones + "geral_lapis_60.jpg"
866:                 .Caption         = "[F8]Crediario"
867:                 .TabIndex        = 9
868:                 .ForeColor          = RGB(90, 90, 90)
869:                 .BackColor          = RGB(255, 255, 255)
870:                 .DisabledForeColor  = RGB(109, 109, 109)
871:                 .DisabledBackColor  = RGB(240, 240, 240)
872:                 .Themes          = .F.
873:                 .Visible         = .F.
874:             ENDWITH
875: 
876:             *-- [F8] Pendencia - sub-niveis/pendencias (mesmo Left do
877:             *-- Financia).
878:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Pendencia", "CommandButton")
879:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Pendencia
880:                 .Top             = 1
881:                 .Left            = 452
882:                 .Width           = 75
883:                 .Height          = 75
884:                 .FontBold        = .T.
885:                 .FontItalic      = .T.
886:                 .FontName        = "Comic Sans MS"
887:                 .FontSize        = 8
888:                 .Picture         = loc_cIcones + "geral_adicao_60.jpg"
889:                 .Caption         = "[F8]Pend"
890:                 .TabIndex        = 9
891:                 .ToolTipText     = "[F8] Pend" + CHR(234) + "ncias"
892:                 .ForeColor          = RGB(90, 90, 90)
893:                 .BackColor          = RGB(255, 255, 255)
894:                 .DisabledForeColor  = RGB(109, 109, 109)
895:                 .DisabledBackColor  = RGB(240, 240, 240)
896:                 .Themes          = .F.
897:                 .Visible         = .T.
898:             ENDWITH
899: 
900:             *-- <Ctrl+P> VerPreco - abre o painel de consulta de preco
901:             *-- (mesmo Left do impfiscal).
902:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_VerPreco", "CommandButton")
903:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_VerPreco
904:                 .Top             = 1
905:                 .Left            = 527
906:                 .Width           = 75
907:                 .Height          = 75
908:                 .FontBold        = .T.
909:                 .FontItalic      = .T.
910:                 .FontName        = "Comic Sans MS"
911:                 .FontSize        = 8
912:                 .Picture         = loc_cIcones + "geral_lupa_60.jpg"
913:                 .Caption         = "<Ctrl+P>"
914:                 .TabIndex        = 11
915:                 .ForeColor          = RGB(90, 90, 90)
916:                 .BackColor          = RGB(255, 255, 255)
917:                 .DisabledForeColor  = RGB(109, 109, 109)
918:                 .DisabledBackColor  = RGB(240, 240, 240)
919:                 .Themes          = .F.
920:                 .Visible         = .T.
921:             ENDWITH
922: 
923:             *-- [F9] impfiscal - status/comandos da impressora fiscal (mesmo
924:             *-- Left do VerPreco).
925:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Impfiscal", "CommandButton")
926:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Impfiscal
927:                 .Top             = 1
928:                 .Left            = 527
929:                 .Width           = 75
930:                 .Height          = 75
931:                 .FontBold        = .T.
932:                 .FontItalic      = .T.
933:                 .FontName        = "Comic Sans MS"
934:                 .FontSize        = 8
935:                 .Picture         = loc_cIcones + "geral_boleto_60.jpg"
936:                 .Caption         = "[F9]Fiscal"
937:                 .TabIndex        = 10
938:                 .ToolTipText     = "[F9] Impressora Fiscal"
939:                 .ForeColor          = RGB(90, 90, 90)
940:                 .BackColor          = RGB(255, 255, 255)
941:                 .DisabledForeColor  = RGB(109, 109, 109)
942:                 .DisabledBackColor  = RGB(240, 240, 240)
943:                 .Themes          = .F.
944:                 .Visible         = .T.
945:             ENDWITH
946: 
947:             *-- [Ctrl+F11] MudaOpe - trocar operacao (mesmo Left do Pagto).
948:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_MudaOpe", "CommandButton")
949:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_MudaOpe
950:                 .Top             = 1
951:                 .Left            = 602
952:                 .Width           = 75
953:                 .Height          = 75
954:                 .FontBold        = .T.
955:                 .FontItalic      = .T.
956:                 .FontName        = "Comic Sans MS"
957:                 .FontSize        = 8
958:                 .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
959:                 .Caption         = "[Ctrl+F11]Op"
960:                 .TabIndex        = 11
961:                 .ToolTipText     = "[Ctrl + F11] Trocar Opera" + CHR(231) + CHR(227) + "o"
962:                 .ForeColor          = RGB(90, 90, 90)
963:                 .BackColor          = RGB(255, 255, 255)
964:                 .DisabledForeColor  = RGB(109, 109, 109)
965:                 .DisabledBackColor  = RGB(240, 240, 240)
966:                 .Themes          = .F.
967:                 .Visible         = .T.
968:             ENDWITH
969: 
970:             *-- [F11] Pagto - tela de formas de pagamento (mesmo Left do
971:             *-- MudaOpe - visivel por padrao no legado).
972:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Pagto", "CommandButton")
973:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Pagto
974:                 .Top             = 1
975:                 .Left            = 602
976:                 .Width           = 75
977:                 .Height          = 75
978:                 .FontBold        = .T.
979:                 .FontItalic      = .T.
980:                 .FontName        = "Comic Sans MS"
981:                 .FontSize        = 8
982:                 .WordWrap        = .F.
983:                 .Picture         = loc_cIcones + "geral_calculadora_60.jpg"
984:                 .Caption         = "[F11]Pagto"
985:                 .TabIndex        = 11
986:                 .ToolTipText     = "[F11] Tela de Formas de Pagamentos"
987:                 .ForeColor          = RGB(90, 90, 90)
988:                 .BackColor          = RGB(255, 255, 255)
989:                 .DisabledForeColor  = RGB(109, 109, 109)
990:                 .DisabledBackColor  = RGB(240, 240, 240)
991:                 .Themes          = .F.
992:                 .Visible         = .T.
993:             ENDWITH
994: 
995:             *-- Confirmar - confirma/finaliza a operacao corrente.
996:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Ok", "CommandButton")
997:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Ok
998:                 .Top             = 1
999:                 .Left            = 677
1000:                 .Width           = 75
1001:                 .Height          = 75
1002:                 .FontBold        = .T.
1003:                 .FontItalic      = .T.
1004:                 .FontName        = "Comic Sans MS"
1005:                 .FontSize        = 8
1006:                 .Picture         = loc_cIcones + "cadastro_salvar_60.jpg"
1007:                 .Caption         = "Confirmar"
1008:                 .TabIndex        = 13
1009:                 .ToolTipText     = "Confirmar"
1010:                 .PicturePosition = 13
1011:                 .ForeColor          = RGB(90, 90, 90)
1012:                 .BackColor          = RGB(255, 255, 255)
1013:                 .DisabledForeColor  = RGB(109, 109, 109)
1014:                 .DisabledBackColor  = RGB(240, 240, 240)
1015:                 .Themes          = .F.
1016:                 .Visible         = .T.
1017:             ENDWITH
1018: 
1019:             *-- Cancelar [ESC] - cancela a tela/passo corrente.
1020:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Cancela", "CommandButton")
1021:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Cancela
1022:                 .Top             = 1
1023:                 .Left            = 752
1024:                 .Width           = 75
1025:                 .Height          = 75
1026:                 .FontBold        = .T.
1027:                 .FontItalic      = .T.
1028:                 .FontName        = "Comic Sans MS"
1029:                 .FontSize        = 8
1030:                 .Picture         = loc_cIcones + "cadastro_cancelar_60.jpg"
1031:                 .Cancel          = .T.
1032:                 .Caption         = "Cancelar"
1033:                 .TabIndex        = 12
1034:                 .ToolTipText     = "[ESC] Cancelar"
1035:                 .PicturePosition = 13
1036:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 1054 a 1103:
1054:     *
1055:     * O .Visible de cada um reproduz EXATAMENTE o declarado no SCX: os que o
1056:     * legado declara Visible=.F. (Cnt_Consulta, CntFinanc) nascem ocultos e
1057:     * estao na skip-list de TornarControlesVisiveis. A alternancia em runtime
1058:     * (feita pelo Init e pelos Click da barra) entra nas Fases 7-8.
1059:     *
1060:     * Conteudo interno de cada container (labels, TextBoxes, grades) entra nas
1061:     * Fases 4-6 - aqui so a moldura, com a geometria e o visual do legado.
1062:     *--------------------------------------------------------------------------
1063:     PROTECTED PROCEDURE ConfigurarContainersOperacao()
1064: 
1065:         *-- Cnt_Consulta: consulta de preco de produto (Ctrl+P). Unico do
1066:         *-- grupo com BackStyle=1 (opaco) no legado - os demais sao BackStyle=0.
1067:         THIS.AddObject("cnt_4c__Consulta", "Container")
1068:         WITH THIS.cnt_4c__Consulta
1069:             .Top           = 124
1070:             .Left          = 32
1071:             .Width         = 850
1072:             .Height        = 495
1073:             .BackStyle     = 1
1074:             .BorderWidth   = 0
1075:             .SpecialEffect = 2
1076:             .TabIndex      = 5
1077:             .BackColor     = RGB(255, 255, 255)
1078:             .BorderColor   = RGB(100, 100, 100)
1079:             .Visible       = .F.
1080:         ENDWITH
1081: 
1082:         *-- CntItem: lancamento de itens (F2 Itens) - container padrao ao
1083:         *-- iniciar a venda.
1084:         THIS.AddObject("cnt_4c_Item", "Container")
1085:         WITH THIS.cnt_4c_Item
1086:             .Top           = 124
1087:             .Left          = 32
1088:             .Width         = 850
1089:             .Height        = 494
1090:             .BackStyle     = 0
1091:             .BorderWidth   = 0
1092:             .SpecialEffect = 2
1093:             .TabIndex      = 5
1094:             .BackColor     = RGB(255, 255, 255)
1095:             .BorderColor   = RGB(100, 100, 100)
1096:             .Visible       = .T.
1097:         ENDWITH
1098: 
1099:         *-- CntFinanc: crediario / codigos de barras (F8 Crediario).
1100:         THIS.AddObject("cnt_4c_Financ", "Container")
1101:         WITH THIS.cnt_4c_Financ
1102:             .Top           = 124
1103:             .Left          = 32

*-- Linhas 1111 a 1183:
1111:             .BorderColor   = RGB(100, 100, 100)
1112:             .Visible       = .F.
1113:         ENDWITH
1114: 
1115:         *-- Cnt_Credito: operacoes de credito/devolucao (F7 Cred.).
1116:         THIS.AddObject("cnt_4c__Credito", "Container")
1117:         WITH THIS.cnt_4c__Credito
1118:             .Top           = 124
1119:             .Left          = 32
1120:             .Width         = 850
1121:             .Height        = 494
1122:             .BackStyle = 1
1123:             .BorderWidth   = 0
1124:             .SpecialEffect = 2
1125:             .TabIndex      = 6
1126:             .BackColor     = RGB(255, 255, 255)
1127:             .BorderColor   = RGB(100, 100, 100)
1128:             .Visible       = .T.
1129:         ENDWITH
1130: 
1131:         *-- Cnt_Pendencia: sub-niveis / pendencias (F8 Pend).
1132:         THIS.AddObject("cnt_4c__Pendencia", "Container")
1133:         WITH THIS.cnt_4c__Pendencia
1134:             .Top           = 124
1135:             .Left          = 32
1136:             .Width         = 850
1137:             .Height        = 497
1138:             .BackStyle = 1
1139:             .BorderWidth   = 0
1140:             .SpecialEffect = 2
1141:             .TabIndex      = 1
1142:             .BackColor     = RGB(255, 255, 255)
1143:             .BorderColor   = RGB(100, 100, 100)
1144:             .Visible       = .T.
1145:         ENDWITH
1146: 
1147:         *-- Cnt_Identifica: identificacao de contas (F6 Identif) - Origem,
1148:         *-- Destino, Vendedor, Responsavel, Tab. Desconto, Cod. Operacao.
1149:         *-- Unico do grupo com SpecialEffect=0 no legado.
1150:         THIS.AddObject("cnt_4c__Identifica", "Container")
1151:         WITH THIS.cnt_4c__Identifica
1152:             .Top           = 124
1153:             .Left          = 32
1154:             .Width         = 850
1155:             .Height        = 496
1156:             .BackStyle     = 0
1157:             .BorderWidth   = 0
1158:             .SpecialEffect = 0
1159:             .TabIndex      = 4
1160:             .BackColor     = RGB(255, 255, 255)
1161:             .BorderColor   = RGB(100, 100, 100)
1162:             .Visible       = .T.
1163:         ENDWITH
1164: 
1165:         *-- Cnt_Fpagto: formas de pagamento (F11 Pagto). BorderColor preto no
1166:         *-- legado (os irmaos usam RGB(100,100,100)) - transcrito como esta.
1167:         THIS.AddObject("cnt_4c__Fpagto", "Container")
1168:         WITH THIS.cnt_4c__Fpagto
1169:             .Top           = 124
1170:             .Left          = 32
1171:             .Width         = 850
1172:             .Height        = 504
1173:             .BackStyle     = 0
1174:             .BorderWidth   = 0
1175:             .SpecialEffect = 2
1176:             .TabIndex      = 3
1177:             .BackColor     = RGB(255, 255, 255)
1178:             .BorderColor   = RGB(0, 0, 0)
1179:             .Visible       = .T.
1180:         ENDWITH
1181: 
1182:         *-- CancelaItem: painel de cancelamento de item (F4 Canc) - fica sobre
1183:         *-- a area central, fora do grupo dos sete acima.

*-- Linhas 1194 a 1449:
1194:             .Visible       = .F.
1195:         ENDWITH
1196: 
1197:         *-- CaixaLivre: painel "CAIXA LIVRE" exibido quando nao ha operacao em
1198:         *-- andamento (ocupa a area da grade do cupom).
1199:         THIS.AddObject("cnt_4c_CaixaLivre", "Container")
1200:         WITH THIS.cnt_4c_CaixaLivre
1201:             .Top         = 126
1202:             .Left        = 407
1203:             .Width       = 475
1204:             .Height      = 447
1205:             .BackStyle   = 1
1206:             .BorderWidth = 0
1207:             .TabIndex    = 11
1208:             .BackColor   = RGB(255, 255, 255)
1209:             .Visible     = .T.
1210:         ENDWITH
1211:     ENDPROC
1212: 
1213:     *--------------------------------------------------------------------------
1214:     * ConfigurarContainersMensagem - as duas faixas de mensagem do rodape
1215:     * (Cnt_Mensagem, de linha unica, e mensagems, de duas linhas). Os labels
1216:     * internos que exibem o texto entram na Fase 5.
1217:     *--------------------------------------------------------------------------
1218:     PROTECTED PROCEDURE ConfigurarContainersMensagem()
1219: 
1220:         *-- Cnt_Mensagem: faixa de status ("Aguarde... Reconfigurando", etc).
1221:         THIS.AddObject("cnt_4c__Mensagem", "Container")
1222:         WITH THIS.cnt_4c__Mensagem
1223:             .Top           = 620
1224:             .Left          = 31
1225:             .Width         = 1195
1226:             .Height        = 26
1227:             .BorderWidth   = 1
1228:             .SpecialEffect = 2
1229:             .TabIndex      = 9
1230:             .BackColor     = RGB(255, 255, 255)
1231:             .BorderColor   = RGB(100, 100, 100)
1232:             .Visible       = .T.
1233:         ENDWITH
1234: 
1235:         *-- mensagems: faixa de duas linhas com a descricao do item corrente.
1236:         THIS.AddObject("cnt_4c_Mensagems", "Container")
1237:         WITH THIS.cnt_4c_Mensagems
1238:             .Top           = 645
1239:             .Left          = 31
1240:             .Width         = 1195
1241:             .Height        = 46
1242:             .BackStyle     = 1
1243:             .BorderWidth   = 1
1244:             .SpecialEffect = 2
1245:             .TabIndex      = 9
1246:             .BackColor     = RGB(255, 255, 255)
1247:             .BorderColor   = RGB(100, 100, 100)
1248:             .Visible       = .T.
1249:         ENDWITH
1250:     ENDPROC
1251: 
1252:     *--------------------------------------------------------------------------
1253:     * ConfigurarElementosAuxiliares - o container do logotipo, a imagem de
1254:     * produto e o Timer do relogio/caption. Sao objetos de topo do legado que
1255:     * nao pertencem a nenhum dos containers de operacao.
1256:     *
1257:     * NAO criados aqui, de proposito (nao e omissao silenciosa):
1258:     *   - GrdCupom (grade do cupom)     -> Fase 4 (grades)
1259:     *   - cmbTOpers (troca de operacao) -> Fases 5-6 (campos)
1260:     *   - READCOMM (class "readcomm" de Framework\framework.vcx) -> e o leitor
1261:     *     serial de cheque (CMC7). Exige SET CLASSLIB do VCX legado + o
1262:     *     controle OLE MSComm registrado na maquina; so e usado no fluxo de
1263:     *     leitura de cheque (Thisform.ReadComm.leitura()), que entra junto com
1264:     *     esse fluxo nas Fases 7-8.
1265:     *--------------------------------------------------------------------------
1266:     PROTECTED PROCEDURE ConfigurarElementosAuxiliares()
1267: 
1268:         *-- Cnt_Img4c: moldura do logotipo no canto superior esquerdo.
1269:         THIS.AddObject("cnt_4c__Img4c", "Container")
1270:         WITH THIS.cnt_4c__Img4c
1271:             .Top           = 21
1272:             .Left          = 34
1273:             .Width         = 291
1274:             .Height        = 101
1275:             .BackStyle     = 0
1276:             .BorderWidth   = 0
1277:             .SpecialEffect = 2
1278:             .TabIndex      = 13
1279:             .ForeColor     = RGB(255, 255, 255)
1280:             .Visible       = .T.
1281:         ENDWITH
1282: 
1283:         *-- FigJpg: imagem do produto lido (preenchida no fluxo de item).
1284:         *-- Legado: Stretch=1 BackStyle=1 Visible=.F.
1285:         THIS.AddObject("img_4c_FigJpg", "Image")
1286:         WITH THIS.img_4c_FigJpg
1287:             .Top       = 124
1288:             .Left      = 882
1289:             .Width     = 282
1290:             .Height    = 211
1291:             .Stretch   = 1
1292:             .BackStyle = 1
1293:             .Visible   = .F.
1294:         ENDWITH
1295: 
1296:         *-- Timer1: atualiza a barra de titulo (data/hora/operador) a cada 1s.
1297:         *-- O corpo do evento Timer e transcrito na fase de eventos; o objeto e
1298:         *-- estrutural e fica inerte ate la (Timer base sem codigo nao faz nada).
1299:         THIS.AddObject("obj_4c_Timer1", "Timer")
1300:         WITH THIS.obj_4c_Timer1
1301:             .Top      = 547
1302:             .Left     = 655
1303:             .Width    = 27
1304:             .Height   = 26
1305:             .Interval = 1000
1306:         ENDWITH
1307:     ENDPROC
1308: 
1309:     *--------------------------------------------------------------------------
1310:     * ConfigurarGradesOperacao - as QUATRO grades que vivem DENTRO dos
1311:     * containers de operacao (a quinta, grd_4c_Cupom, e filha direta do form e
1312:     * foi criada em ConfigurarGridCupom), mais os botoes de acao que o legado
1313:     * coloca colados a elas:
1314:     *
1315:     *   cnt_4c_Financ.cnt_4c__GrdBarra        (Cnt_GrdBarra)
1316:     *       grd_4c_Barras   (grade)            + cmd_4c_Inserir / cmd_4c_Excluir
1317:     *                                          / cmd_4c_OkBarra
1318:     *   cnt_4c__Credito.grd_4c_Devolucao      (GradeDevol)
1319:     *   cnt_4c__Pendencia.grd_4c_SubNiveis    (GradeMultiSubN) + cmd_4c_BotPend
1320:     *   cnt_4c__Fpagto.cnt_4c__ChequepreTef   (Cnt_ChequepreTef)
1321:     *       grd_4c_Parcelas (Grade)
1322:     *
1323:     * Nomes DIFERENTES do generico "grd_4c_Dados" de mapeamento.json de
1324:     * proposito: o JSON mapeia as CINCO grades do legado para o mesmo nome, e
1325:     * duas delas acabariam como irmas homonimas na mesma arvore. Colisao de
1326:     * nome generico no mapeamento se resolve no JSON, nao no .prg - o
1327:     * mapeamento foi ajustado junto com esta fase.
1328:     *
1329:     * NENHUM RecordSource/ControlSource/Width de coluna e definido aqui: todos
1330:     * ficam em MontaGrade(), que roda DEPOIS de CriarCursoresGrades(). Ligar
1331:     * ControlSource a cursor que ainda nao existe derruba o Init (CLAUDE.md
1332:     * #41), e RecordSource RECALCULA Column.Width para o default 90 e zera
1333:     * Header1.Caption - por isso largura e cabecalho vao por ultimo.
1334:     *--------------------------------------------------------------------------
1335:     PROTECTED PROCEDURE ConfigurarGradesOperacao()
1336:         LOCAL loc_cIcones, loc_oCnt, loc_oGrd
1337:         loc_cIcones = gc_4c_CaminhoIcones
1338: 
1339:         *======================================================================
1340:         * 1) CntFinanc.Cnt_GrdBarra - painel do crediario (codigos de barras)
1341:         *======================================================================
1342:         THIS.cnt_4c_Financ.AddObject("cnt_4c__GrdBarra", "Container")
1343:         loc_oCnt = THIS.cnt_4c_Financ.cnt_4c__GrdBarra
1344:         WITH loc_oCnt
1345:             .Top           = 183
1346:             .Left          = 4
1347:             .Width         = 368
1348:             .Height        = 164
1349:             .BackStyle     = 1
1350:             .BorderWidth   = 1
1351:             .SpecialEffect = 2
1352:             .TabIndex      = 2
1353:             .BackColor     = RGB(255, 255, 255)
1354:             .Visible       = .T.
1355:         ENDWITH
1356: 
1357:         *-- Grade dos codigos de barras lidos (TmpBarFin).
1358:         loc_oCnt.AddObject("grd_4c_Barras", "Grid")
1359:         WITH loc_oCnt.grd_4c_Barras
1360:             .Top         = 4
1361:             .Left        = 2
1362:             .Width       = 364
1363:             .Height      = 129
1364:             .ColumnCount = 4
1365:             .RecordMark  = .F.
1366:             .DeleteMark  = .F.
1367:             .Visible     = .T.
1368:         ENDWITH
1369: 
1370:         *-- F2-Selec: posiciona na grade para digitar um novo par de barras
1371:         *-- (legado: Grade.Column1.SetFocus).
1372:         loc_oCnt.AddObject("cmd_4c_Inserir", "CommandButton")
1373:         WITH loc_oCnt.cmd_4c_Inserir
1374:             .Top             = 131
1375:             .Left            = 3
1376:             .Width           = 80
1377:             .Height          = 30
1378:             .FontBold        = .T.
1379:             .FontName        = "Tahoma"
1380:             .FontSize        = 8
1381:             .Picture         = loc_cIcones + "a_misc7.bmp"
1382:             .Caption         = "F2-\<Selec"
1383:             .TabIndex        = 77
1384:             .PicturePosition = 1
1385:             .ForeColor       = RGB(90, 90, 90)
1386:             .Visible         = .T.
1387:         ENDWITH
1388: 
1389:         *-- F4-Excluir: apaga a linha corrente de TmpBarFin.
1390:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
1391:         WITH loc_oCnt.cmd_4c_Excluir
1392:             .Top             = 131
1393:             .Left = 230
1394:             .Width           = 80
1395:             .Height          = 30
1396:             .FontBold        = .T.
1397:             .FontName        = "Tahoma"
1398:             .FontSize        = 8
1399:             .Picture         = loc_cIcones + "a_delete1.bmp"
1400:             .Caption         = "F4-\<Excluir"
1401:             .TabIndex        = 77
1402:             .PicturePosition = 1
1403:             .ForeColor       = RGB(90, 90, 90)
1404:             .Visible         = .T.
1405:         ENDWITH
1406: 
1407:         *-- F5-Barra: devolve o foco ao campo do primeiro codigo de barras.
1408:         *-- Nome do legado e "ok"; aqui cmd_4c_OkBarra, para nao colidir com os
1409:         *-- outros dois "ok" do form (Barra_Botoes.ok e CancelaItem.ok).
1410:         loc_oCnt.AddObject("cmd_4c_OkBarra", "CommandButton")
1411:         WITH loc_oCnt.cmd_4c_OkBarra
1412:             .Top             = 131
1413:             .Left            = 161
1414:             .Width           = 80
1415:             .Height          = 30
1416:             .FontBold        = .T.
1417:             .FontName        = "Tahoma"
1418:             .FontSize        = 8
1419:             .Picture         = loc_cIcones + "smmail.bmp"
1420:             .Caption         = "F5-\<Barra"
1421:             .TabIndex        = 40
1422:             .PicturePosition = 1
1423:             .ForeColor       = RGB(90, 90, 90)
1424:             .Visible         = .T.
1425:         ENDWITH
1426: 
1427:         *======================================================================
1428:         * 2) Cnt_Credito.GradeDevol - operacoes de credito/devolucao (TmpDevol)
1429:         *======================================================================
1430:         *-- ZOrderSet do dump legado NAO e transcrito: e propriedade so do Form
1431:         *-- Designer (indice de z-order gravado no SCX) e nao existe em runtime
1432:         *-- (CLAUDE.md #33) - atribui-la derrubaria o Init.
1433:         THIS.cnt_4c__Credito.AddObject("grd_4c_Devolucao", "Grid")
1434:         loc_oGrd = THIS.cnt_4c__Credito.grd_4c_Devolucao
1435:         WITH loc_oGrd
1436:             .Top          = 64
1437:             .Left         = 10
1438:             .Width        = 355
1439:             .Height       = 325
1440:             .ColumnCount  = 3
1441:             .FontName     = "Courier New"
1442:             .HeaderHeight = 16
1443:             .RowHeight    = 16
1444:             .ScrollBars   = 2
1445:             .TabIndex     = 4
1446:             .DeleteMark   = .F.
1447:             .RecordMark   = .F.
1448:             .BackColor    = RGB(254, 255, 232)
1449:             .Visible      = .T.

*-- Linhas 1465 a 1532:
1465:         ENDWITH
1466: 
1467:         *======================================================================
1468:         * 3) Cnt_Pendencia.GradeMultiSubN - sub-niveis/pendencias (TmpOperacao)
1469:         *======================================================================
1470:         THIS.cnt_4c__Pendencia.AddObject("grd_4c_SubNiveis", "Grid")
1471:         WITH THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
1472:             .Top          = 8
1473:             .Left         = 14
1474:             .Width        = 274
1475:             .Height       = 397
1476:             .ColumnCount  = 3
1477:             .FontName     = "Verdana"
1478:             .HeaderHeight = 16
1479:             .RowHeight    = 16
1480:             .ScrollBars   = 2
1481:             .TabIndex     = 3
1482:             .DeleteMark   = .F.
1483:             .RecordMark   = .F.
1484:             .ForeColor    = RGB(36, 84, 155)
1485:             .BackColor    = RGB(254, 255, 232)
1486:             .Visible      = .T.
1487:         ENDWITH
1488: 
1489:         *-- [F3]Pend. - abre a tela de pendencias do cliente (SigOpPen no
1490:         *-- legado). Fica ao lado da grade, dentro do mesmo container.
1491:         THIS.cnt_4c__Pendencia.AddObject("cmd_4c_BotPendentes", "CommandButton")
1492:         WITH THIS.cnt_4c__Pendencia.cmd_4c_BotPendentes
1493:             .Top         = 9
1494:             .Left        = 300
1495:             .Width       = 75
1496:             .Height      = 75
1497:             .FontBold    = .T.
1498:             .FontItalic  = .T.
1499:             .FontName    = "Comic Sans MS"
1500:             .FontSize    = 8
1501:             .WordWrap    = .T.
1502:             .Picture     = loc_cIcones + "date2.ico"
1503:             .Caption     = "[F3]Pend."
1504:             .TabIndex    = 4
1505:             .ToolTipText = "Abre Tela de Pend" + CHR(234) + "ncias"
1506:             .ForeColor   = RGB(90, 90, 90)
1507:             .BackColor   = RGB(255, 255, 255)
1508:             .RightToLeft = .T.
1509:             .Themes      = .F.
1510:             .Visible     = .T.
1511:         ENDWITH
1512: 
1513:         *======================================================================
1514:         * 4) Cnt_Fpagto.Cnt_ChequepreTef.Grade - parcelas/cheques (xPar)
1515:         *======================================================================
1516:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c__ChequepreTef", "Container")
1517:         loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef
1518:         WITH loc_oCnt
1519:             .Top           = 358
1520:             .Left          = 2
1521:             .Width         = 371
1522:             .Height        = 139
1523:             .BackStyle     = 1
1524:             .BorderWidth   = 1
1525:             .SpecialEffect = 2
1526:             .TabIndex      = 13
1527:             .BackColor     = RGB(255, 255, 255)
1528:             .Visible       = .F.
1529:         ENDWITH
1530: 
1531:         loc_oCnt.AddObject("grd_4c_Parcelas", "Grid")
1532:         WITH loc_oCnt.grd_4c_Parcelas

*-- Linhas 1557 a 1612:
1557:     * cursores precisam nascer aqui.
1558:     *
1559:     * Roda ANTES de qualquer RecordSource/ControlSource: ligar coluna a alias
1560:     * inexistente estoura "Alias is not found" dentro do TRY do InicializarForm
1561:     * e o form simplesmente nao abre (CLAUDE.md #41).
1562:     *
1563:     * SET NULL ON antes do CREATE CURSOR porque estes cursores recebem dados do
1564:     * SQL Server via APPEND FROM DBF() - coluna nullable do servidor recusa o
1565:     * append num cursor declarado NOT NULL. O estado anterior e restaurado no
1566:     * fim, para nao vazar SET para o resto da datasession.
1567:     *
1568:     * Estruturas transcritas do uso real no dump legado. Nomes de campo
1569:     * PRESERVADOS: sao chave de ControlSource e aparecem literalmente nas
1570:     * expressoes Locate/Replace/Seek das fases de evento.
1571:     *--------------------------------------------------------------------------
1572:     PROTECTED PROCEDURE CriarCursoresGrades()
1573:         LOCAL loc_cNullAnt
1574:         loc_cNullAnt = SET("NULL")
1575:         SET NULL ON
1576: 
1577:         *-- crTpmMvItn: o carrinho - copia local dos itens de SigMvItn da
1578:         *-- movimentacao em andamento. As 23 primeiras colunas sao as de
1579:         *-- SigMvItn que o legado referencia; ImpCupFis e LPrecos NAO existem
1580:         *-- na tabela - sao campos de CONTROLE do cursor local (marcam item ja
1581:         *-- impresso no cupom fiscal e a lista de preco aplicada).
1582:         IF !USED("crTpmMvItn")
1583:             CREATE CURSOR crTpmMvItn ( ;
1584:                 citens     N(10, 0) NULL, ;
1585:                 cpros      C(14)    NULL, ;
1586:                 dpros      C(65)    NULL, ;
1587:                 cunis      C(3)     NULL, ;
1588:                 codbarras  N(14, 0) NULL, ;
1589:                 codlprecs  N(6, 0)  NULL, ;
1590:                 empdopnums C(29)    NULL, ;
1591:                 etiesps    L        NULL, ;
1592:                 fators     N(8, 3)  NULL, ;
1593:                 fatvals    N(15, 6) NULL, ;
1594:                 moedas     C(3)     NULL, ;
1595:                 moefats    C(3)     NULL, ;
1596:                 moevals    N(15, 6) NULL, ;
1597:                 notas      C(6)     NULL, ;
1598:                 opers      C(1)     NULL, ;
1599:                 pesos      N(9, 3)  NULL, ;
1600:                 qtds       N(9, 3)  NULL, ;
1601:                 totas      N(11, 2) NULL, ;
1602:                 units      N(15, 6) NULL, ;
1603:                 univals    N(15, 6) NULL, ;
1604:                 utilizas   N(4, 0)  NULL, ;
1605:                 valdescs   N(9, 2)  NULL, ;
1606:                 obs        M        NULL, ;
1607:                 ImpCupFis  L        NULL, ;
1608:                 LPrecos    N(6, 0)  NULL)
1609:             INDEX ON STR(citens, 10) TAG citens
1610:             INDEX ON cpros TAG cpros
1611:             SET ORDER TO
1612:         ENDIF

*-- Linhas 1745 a 1809:
1745:     * 7427-7446 e 7503-7518 de sigmvitn_form_codigo_fonte.txt) e do proprio
1746:     * SCX (Cnt_ChequepreTef.Grade, RecordSource = "XPAR").
1747:     *--------------------------------------------------------------------------
1748:     PROTECTED PROCEDURE MontaGrade()
1749:         LOCAL loc_oGrd, loc_cDyn
1750: 
1751:         *======================================================================
1752:         * Grade do CUPOM (crTpmMvItnC) - coluna unica, sem cabecalho visivel
1753:         * (HeaderHeight = 0), fonte Courier New como o legado troca em runtime.
1754:         *======================================================================
1755:         IF USED("crTpmMvItnC")
1756:             loc_oGrd = THIS.grd_4c_Cupom
1757:             WITH loc_oGrd
1758:                 .RecordSource = "crTpmMvItnC"
1759: 
1760:                 .Column1.ControlSource = "crTpmMvItnC.Texto"
1761:                 .Column1.Enabled       = .F.
1762:                 .Column1.FontBold      = .T.
1763:                 .Column1.FontName      = "Courier New"
1764:                 .Column1.Movable       = .F.
1765:                 .Column1.ReadOnly      = .T.
1766:                 .Column1.ForeColor     = RGB(0, 0, 255)
1767: 
1768:                 .Column1.Text1.Enabled   = .F.
1769:                 .Column1.Text1.FontBold  = .T.
1770:                 .Column1.Text1.FontName  = "Courier New"
1771:                 .Column1.Text1.ReadOnly  = .T.
1772:                 .Column1.Text1.ForeColor = RGB(0, 0, 255)
1773:                 .Column1.Text1.Width     = 345
1774: 
1775:                 .Column1.Width = 345
1776:                 .Column1.Header1.Caption = ""
1777:             ENDWITH
1778: 
1779:             *-- DynamicForeColor do legado: a cor de cada linha do cupom vem do
1780:             *-- campo Cores (0 item, 1 totalizador, 2 forma de pagamento,
1781:             *-- 3 valor recebido, 4 troco/estorno). Montado em variavel para
1782:             *-- caber em linha e aplicado com SetAll, como no legado.
1783:             loc_cDyn = "(IIF(crTpmMvItnC.Cores=0, RGB(0,0,255), " + ;
1784:                        "IIF(crTpmMvItnC.Cores=1, RGB(0,0,160), " + ;
1785:                        "IIF(crTpmMvItnC.Cores=2, RGB(0,0,64), " + ;
1786:                        "IIF(crTpmMvItnC.Cores=3, RGB(64,0,64), RGB(255,0,0))))))"
1787:             loc_oGrd.SetAll("DynamicForeColor", loc_cDyn, "Column")
1788:         ENDIF
1789: 
1790:         *======================================================================
1791:         * Grade das PENDENCIAS / sub-niveis (TmpOperacao)
1792:         *======================================================================
1793:         IF USED("TmpOperacao")
1794:             loc_oGrd = THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
1795:             WITH loc_oGrd
1796:                 .RecordSource = "TmpOperacao"
1797: 
1798:                 .Column1.ControlSource = "TmpOperacao.Codigos"
1799:                 .Column1.FontName      = "Verdana"
1800:                 .Column1.InputMask     = "9999999999"
1801:                 .Column1.Movable       = .F.
1802:                 .Column1.Resizable     = .F.
1803:                 .Column1.ForeColor     = RGB(36, 84, 155)
1804:                 .Column1.BackColor     = RGB(254, 255, 232)
1805:                 .Column1.Text1.FontName  = "Verdana"
1806:                 .Column1.Text1.Margin    = 0
1807:                 .Column1.Text1.ForeColor = RGB(36, 84, 155)
1808:                 .Column1.Text1.BackColor = RGB(254, 255, 232)
1809: 

*-- Linhas 1855 a 1875:
1855: 
1856:         *======================================================================
1857:         * Grade dos CREDITOS / devolucoes (TmpDevol)
1858:         *======================================================================
1859:         IF USED("TmpDevol")
1860:             loc_oGrd = THIS.cnt_4c__Credito.grd_4c_Devolucao
1861:             WITH loc_oGrd
1862:                 .RecordSource = "TmpDevol"
1863: 
1864:                 *-- CurrentControl DEPOIS do RecordSource (que o devolve para
1865:                 *-- "Text1") e Sparse = .F. para o TextBox proprio aparecer em
1866:                 *-- TODAS as linhas, nao so na corrente (CLAUDE.md #18).
1867:                 .Column1.CurrentControl = "txt_4c__Devol"
1868:                 .Column1.Sparse         = .F.
1869: 
1870:                 .Column1.ControlSource = "TmpDevol.Codigos"
1871:                 .Column1.FontName      = "Courier New"
1872:                 .Column1.InputMask     = "9999999999"
1873:                 .Column1.Movable       = .F.
1874:                 .Column1.Resizable     = .F.
1875:                 .Column1.BackColor     = RGB(254, 255, 232)

*-- Linhas 1966 a 1986:
1966: 
1967:         *======================================================================
1968:         * Grade das PARCELAS / cheques pre-datados (xPar)
1969:         *======================================================================
1970:         IF USED("xPar")
1971:             loc_oGrd = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas
1972:             WITH loc_oGrd
1973:                 .RecordSource = "xPar"
1974: 
1975:                 *-- Column1 (Condicao) e a unica ReadOnly: o legado deixa
1976:                 *-- alterar valor, vencimento e moeda da parcela, mas nunca a
1977:                 *-- forma de pagamento ja escolhida. Column.ReadOnly vem DEPOIS
1978:                 *-- de Grid.ReadOnly, senao o do grid sobrescreve o da coluna.
1979:                 .Column1.ControlSource = "xPar.FPags"
1980:                 .Column1.FontName      = "Tahoma"
1981:                 .Column1.FontSize      = 8
1982:                 .Column1.Movable       = .F.
1983:                 .Column1.Resizable     = .F.
1984:                 .Column1.ReadOnly      = .T.
1985:                 .Column1.Text1.FontName    = "Tahoma"
1986:                 .Column1.Text1.FontSize    = 8

*-- Linhas 2083 a 2200:
2083:     * as grades sao repintadas vazias - que e exatamente o estado inicial do
2084:     * legado quando o caixa abre sem operacao em andamento.
2085:     *--------------------------------------------------------------------------
2086:     PROCEDURE CarregarDados()
2087:         LOCAL loc_lSucesso, loc_oErro
2088:         loc_lSucesso = .F.
2089: 
2090:         TRY
2091:             THIS.CriarCursoresGrades()
2092: 
2093:             IF THIS.this_nNumes > 0 AND !EMPTY(THIS.this_cDopes) AND ;
2094:                     TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2095: 
2096:                 IF THIS.this_oBusinessObject.CarregarItensMovimento( ;
2097:                         THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
2098:                         "cursor_4c_ItensTmp")
2099: 
2100:                     SELECT crTpmMvItn
2101:                     ZAP
2102:                     IF USED("cursor_4c_ItensTmp") AND RECCOUNT("cursor_4c_ItensTmp") > 0
2103:                         APPEND FROM DBF("cursor_4c_ItensTmp")
2104:                     ENDIF
2105: 
2106:                     *-- Numero do proximo item = ultimo lancado, como o legado
2107:                     *-- faz no fim do Init (Goto Bottom / CItem = cItens).
2108:                     SELECT crTpmMvItn
2109:                     GO BOTTOM
2110:                     THIS.this_nCitem = IIF(RECCOUNT("crTpmMvItn") > 0, ;
2111:                         NVL(crTpmMvItn.citens, 0), 0)
2112: 
2113:                     THIS.MontarLinhasCupom()
2114: 
2115:                     IF USED("cursor_4c_ItensTmp")
2116:                         USE IN cursor_4c_ItensTmp
2117:                     ENDIF
2118:                 ENDIF
2119:             ENDIF
2120: 
2121:             THIS.MontaGrade()
2122:             THIS.AtualizarGrades()
2123: 
2124:             loc_lSucesso = .T.
2125:         CATCH TO loc_oErro
2126:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2127:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
2128:         ENDTRY
2129: 
2130:         RETURN loc_lSucesso
2131:     ENDPROC
2132: 
2133:     *--------------------------------------------------------------------------
2134:     * MontarLinhasCupom - transcreve o trecho do AtuaCupom legado que monta as
2135:     * linhas de texto de cada item no cupom, percorrendo a carga recem-feita.
2136:     *
2137:     *   linha 1: numero do item + identificacao do produto + descricao
2138:     *   linha 2: quantidade + unidade + valor unitario + total. Havendo
2139:     *            desconto/acrescimo o legado quebra em DUAS - a de quantidade
2140:     *            x valor ORIGINAL e a do ajuste com o total liquido.
2141:     *
2142:     * Regras de identificacao e descricao, iguais as do legado:
2143:     *   - IdentPro = 1 e OpCrs <> 4 -> descricao = 1a linha da Descricao
2144:     *     Fiscal do produto, truncada em 40 (fLimpaTexto tira acentuacao e
2145:     *     caracteres de controle, como no legado).
2146:     *   - caso contrario -> identifica pelo codigo de barras do item; nao
2147:     *     havendo, usa o numero da nota (quando OpCrs = 4 e a nota esta no
2148:     *     formato de 6 digitos) e, em ultimo caso, o codigo de barras do
2149:     *     cadastro do produto.
2150:     *   - a Descricao para ECF (SigCdPro.DescEcfs), quando preenchida, tem
2151:     *     precedencia sobre as duas anteriores.
2152:     * Produto sem codigo de barras em lugar nenhum e identificado pelo proprio
2153:     * codigo do produto - e o que o legado exibe quando o caixa opera sem
2154:     * impressora fiscal.
2155:     *
2156:     * Le do cursor TEMPORARIO da carga (cursor_4c_ItensTmp) porque e nele que
2157:     * vem, no mesmo SELECT, os campos do cadastro do produto; o carrinho
2158:     * (crTpmMvItn) so tem as colunas da tabela de itens, como no legado.
2159:     *--------------------------------------------------------------------------
2160:     PROTECTED PROCEDURE MontarLinhasCupom()
2161:         LOCAL loc_nIdentPro, loc_nOpCrs, loc_cDescr, loc_nCodBarra, loc_cIdent
2162:         LOCAL loc_nNotas, loc_cTexto, loc_nAreaAnt, loc_lProsseguir
2163: 
2164:         loc_lProsseguir = USED("cursor_4c_ItensTmp") AND USED("crTpmMvItnC")
2165: 
2166:         IF loc_lProsseguir
2167:             loc_nAreaAnt = SELECT()
2168: 
2169:             *-- Parametros da operacao (no legado, cursores globais CrSigOpCdd
2170:             *-- e CrSigCdOpe montados pela tela de movimentacao).
2171:             loc_nIdentPro = 0
2172:             loc_nOpCrs    = 0
2173:             IF THIS.this_oBusinessObject.CarregarParametrosOperacao( ;
2174:                     THIS.this_cDopes, "cursor_4c_ParOperacao")
2175:                 IF USED("cursor_4c_ParOperacao") AND RECCOUNT("cursor_4c_ParOperacao") > 0
2176:                     SELECT cursor_4c_ParOperacao
2177:                     GO TOP
2178:                     loc_nIdentPro = NVL(cursor_4c_ParOperacao.identpro, 0)
2179:                     loc_nOpCrs    = NVL(cursor_4c_ParOperacao.opcrs, 0)
2180:                 ENDIF
2181:                 IF USED("cursor_4c_ParOperacao")
2182:                     USE IN cursor_4c_ParOperacao
2183:                 ENDIF
2184:             ENDIF
2185: 
2186:             SELECT crTpmMvItnC
2187:             ZAP
2188: 
2189:             SELECT cursor_4c_ItensTmp
2190:             SCAN
2191:                 loc_cDescr    = NVL(cursor_4c_ItensTmp.dpros, "")
2192:                 loc_nCodBarra = 0
2193: 
2194:                 IF loc_nIdentPro = 1 AND loc_nOpCrs <> 4
2195:                     loc_cDescr = PADR(fLimpaTexto( ;
2196:                         MLINE(NVL(cursor_4c_ItensTmp.prodescfis, ""), 1)), 40)
2197:                 ELSE
2198:                     IF NVL(cursor_4c_ItensTmp.codbarras, 0) <> 0
2199:                         loc_nCodBarra = NVL(cursor_4c_ItensTmp.codbarras, 0)
2200:                     ELSE

*-- Linhas 2265 a 2487:
2265:     * ("a tela nao traz dados") manda o diagnostico para o SQL, que esta certo.
2266:     * O legado fecha assim toda carga - "Go Top In <cursor>" + "<grade>.Refresh".
2267:     *--------------------------------------------------------------------------
2268:     PROCEDURE AtualizarGrades()
2269:         IF USED("crTpmMvItnC")
2270:             GO TOP IN crTpmMvItnC
2271:             THIS.grd_4c_Cupom.Refresh()
2272:         ENDIF
2273: 
2274:         IF USED("TmpOperacao")
2275:             GO TOP IN TmpOperacao
2276:             THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Refresh()
2277:         ENDIF
2278: 
2279:         IF USED("TmpDevol")
2280:             GO TOP IN TmpDevol
2281:             THIS.cnt_4c__Credito.grd_4c_Devolucao.Refresh()
2282:         ENDIF
2283: 
2284:         IF USED("TmpBarFin")
2285:             GO TOP IN TmpBarFin
2286:             THIS.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras.Refresh()
2287:         ENDIF
2288: 
2289:         IF USED("xPar")
2290:             GO TOP IN xPar
2291:             THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas.Refresh()
2292:         ENDIF
2293: 
2294:         *-- O painel "CAIXA LIVRE" cobre a grade do cupom enquanto nao ha item
2295:         *-- lancado, exatamente como no legado (o AtuaCupom comeca escondendo-o
2296:         *-- assim que o primeiro item entra).
2297:         THIS.cnt_4c_CaixaLivre.Visible = (RECCOUNT("crTpmMvItnC") = 0)
2298:     ENDPROC
2299: 
2300:     *--------------------------------------------------------------------------
2301:     * TornarControlesVisiveis - torna visiveis os controles criados via
2302:     * AddObject (que nascem Visible=.F.), recursivamente. Containers
2303:     * flutuantes do legado (Visible=.F. por padrao, alternados por botao nas
2304:     * proximas fases) sao PULADOS aqui - mas seus FILHOS sao recursados mesmo
2305:     * assim, para nao ficarem presos ocultos quando o container for exibido
2306:     * depois (regra da skip+recursao - ver docs/CLAUDE.md).
2307:     *--------------------------------------------------------------------------
2308:     PROCEDURE TornarControlesVisiveis(par_oContainer)
2309:         LOCAL loc_nI, loc_oObjeto, loc_lOculto, loc_nP
2310: 
2311:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2312:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2313: 
2314:             IF VARTYPE(loc_oObjeto) = "O"
2315:                 *-- Controles que o SCX legado declara Visible=.F. e que sao
2316:                 *-- exibidos sob demanda (botao/fluxo) nas Fases 7-8. Ficam
2317:                 *-- ocultos, mas seus FILHOS sao recursados mesmo assim.
2318:                 loc_lOculto = INLIST(UPPER(loc_oObjeto.Name), ;
2319:                     "CNT_4C__CONSULTA", "CNT_4C_FINANC", ;
2320:                     "CNT_4C__CHEQUEPRETEF", "CNT_4C__CHQ", ;
2321:                     "CNT_4C_ACRESCIMO", "CNT_4C_DESCONTO", ;
2322:                     "CBO_4C_CMBTOPERS", "CNT_4C_CANCELAITEM", "IMG_4C_FIGJPG", ;
2323:                     "OBJ_4C_GETOBS", "LBL_4C_OBS", "CMD_4C_FINANCIA", ;
2324:                     "CMD_4C_CMDENVIAPROD")
2325: 
2326:                 IF loc_lOculto
2327:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2328:                         THIS.TornarControlesVisiveis(loc_oObjeto)
2329:                     ENDIF
2330:                     LOOP
2331:                 ENDIF
2332: 
2333:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2334:                     loc_oObjeto.Visible = .T.
2335:                 ENDIF
2336: 
2337:                 IF PEMSTATUS(loc_oObjeto, "BaseClass", 5) AND UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2338:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2339:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2340:                     ENDFOR
2341:                 ENDIF
2342: 
2343:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2344:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2345:                 ENDIF
2346:             ENDIF
2347:         ENDFOR
2348:     ENDPROC
2349: 
2350:     *--------------------------------------------------------------------------
2351:     * Destroy - fecha os cursores locais das grades, reabilita o form pai (se
2352:     * houver) e libera BO/menu (DODEFAULT chama FormBase.Destroy, que ja cuida
2353:     * do fix menu-shrinks).
2354:     *
2355:     * Os cursores sao fechados um a um porque o form vive numa DataSession
2356:     * propria mas os alias sao compartilhaveis por nome: deixar TmpOperacao /
2357:     * TmpDevol / xPar abertos faria a proxima abertura do Caixa reaproveitar o
2358:     * cursor da venda anterior (o IF !USED de CriarCursoresGrades nao recriaria
2359:     * nada) e a tela comecaria com os dados da venda que ja terminou.
2360:     *--------------------------------------------------------------------------
2361:     PROCEDURE Destroy()
2362:         LOCAL loc_oErro, loc_nI, loc_cAlias, loc_aCursores[7]
2363: 
2364:         loc_aCursores[1] = "crTpmMvItn"
2365:         loc_aCursores[2] = "crTpmMvItnC"
2366:         loc_aCursores[3] = "TmpOperacao"
2367:         loc_aCursores[4] = "TmpDevol"
2368:         loc_aCursores[5] = "TmpBarFin"
2369:         loc_aCursores[6] = "xPar"
2370:         loc_aCursores[7] = "cursor_4c_ItensTmp"
2371: 
2372:         TRY
2373:             FOR loc_nI = 1 TO ALEN(loc_aCursores)
2374:                 loc_cAlias = loc_aCursores[loc_nI]
2375:                 IF USED(loc_cAlias)
2376:                     USE IN (loc_cAlias)
2377:                 ENDIF
2378:             ENDFOR
2379: 
2380:             IF VARTYPE(THIS.this_oParentForm) = "O"
2381:                 THIS.this_oParentForm.Enabled = .T.
2382:             ENDIF
2383:         CATCH TO loc_oErro
2384:             * cursor ou form pai ja liberado - o Destroy nao pode falhar aqui,
2385:             * senao o menu principal nao e reconstruido no DODEFAULT abaixo.
2386:         ENDTRY
2387: 
2388:         DODEFAULT()
2389:     ENDPROC
2390: 
2391:     *--------------------------------------------------------------------------
2392:     * ConfigurarCamposParte1 - primeira metade dos campos de dados do form
2393:     * (FASE 5/8). Cobre os elementos auxiliares de topo (logotipo, faixas de
2394:     * mensagem), o painel "CAIXA LIVRE", o painel de cancelamento de item, o
2395:     * painel de consulta de preco (Ctrl+P) e os dois containers que ficam
2396:     * visiveis por padrao ao abrir o Caixa (CntItem e CntFinanc). A segunda
2397:     * metade (Cnt_Identifica, Cnt_Fpagto, os labels remanescentes de
2398:     * Cnt_Credito/Cnt_Pendencia e cmbTOpers) fica para a Fase 6.
2399:     *--------------------------------------------------------------------------
2400:     PROTECTED PROCEDURE ConfigurarCamposParte1()
2401:         THIS.ConfigurarCamposLogotipo()
2402:         THIS.ConfigurarCamposMensagens()
2403:         THIS.ConfigurarCamposCaixaLivre()
2404:         THIS.ConfigurarCamposCancelaItem()
2405:         THIS.ConfigurarCamposConsulta()
2406:         THIS.ConfigurarCamposItem()
2407:         THIS.ConfigurarCamposFinanc()
2408:     ENDPROC
2409: 
2410:     *--------------------------------------------------------------------------
2411:     * ConfigurarCamposLogotipo - imagem do logotipo dentro de cnt_4c__Img4c
2412:     * (container criado na Fase 3, ainda vazio).
2413:     * Original: SIGMVITN.Cnt_Img4c.figjpg - Picture=..\framework\imagens\
2414:     * 4Control_logo2.png Stretch=1 BackStyle=1 Height=218 Left=-22 Top=-59
2415:     * Width=331 BorderColor=36,84,155.
2416:     *--------------------------------------------------------------------------
2417:     PROTECTED PROCEDURE ConfigurarCamposLogotipo()
2418:         THIS.cnt_4c__Img4c.AddObject("img_4c_Figjpg", "Image")
2419:         WITH THIS.cnt_4c__Img4c.img_4c_Figjpg
2420:             .Top         = -59
2421:             .Left        = -22
2422:             .Width       = 331
2423:             .Height      = 218
2424:             .Stretch     = 1
2425:             .BackStyle   = 1
2426:             .Picture     = gc_4c_CaminhoIcones + "4Control_logo2.png"
2427:             .BorderColor = RGB(36, 84, 155)
2428:             .Visible     = .T.
2429:         ENDWITH
2430:     ENDPROC
2431: 
2432:     *--------------------------------------------------------------------------
2433:     * ConfigurarCamposMensagens - labels das duas faixas de mensagem do
2434:     * rodape (cnt_4c__Mensagem e cnt_4c_Mensagems, containers criados na
2435:     * Fase 3). O texto e atualizado em runtime pelos eventos das proximas
2436:     * fases - nasce vazio, como o proprio Cnt_Mensagem do legado (Caption="").
2437:     * Original Cnt_Mensagem.Mensagem: AutoSize=.T. FontBold=.T. FontName=
2438:     * "Verdana" FontSize=10 BackStyle=0 Height=18 Left=3 Top=2 Width=2
2439:     * ForeColor=36,84,155.
2440:     * Original Cnt_Mensagem.Abertura: AutoSize=.F., mesma fonte/cor, Height=19
2441:     * Left=317 Top=3 Width=55.
2442:     * Original mensagems.Mensage1/Mensage2: AutoSize=.F. FontBold=.T.
2443:     * FontName="Tahoma" BackStyle=0 Left=6 ForeColor=90,90,90 (Mensage1
2444:     * FontSize=13 Top=1 Height=23 Width=709; Mensage2 FontSize=16 Top=19
2445:     * Height=26 Width=709).
2446:     *--------------------------------------------------------------------------
2447:     PROTECTED PROCEDURE ConfigurarCamposMensagens()
2448:         THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Mensagem", "Label")
2449:         WITH THIS.cnt_4c__Mensagem.lbl_4c_Mensagem
2450:             .Top       = 2
2451:             .Left      = 3
2452:             .Width     = 2
2453:             .Height    = 18
2454:             .AutoSize  = .T.
2455:             .FontBold  = .T.
2456:             .FontName  = "Verdana"
2457:             .FontSize  = 10
2458:             .BackStyle = 0
2459:             .Caption   = ""
2460:             .ForeColor = RGB(36, 84, 155)
2461:             .Visible   = .T.
2462:         ENDWITH
2463: 
2464:         THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Abertura", "Label")
2465:         WITH THIS.cnt_4c__Mensagem.lbl_4c_Abertura
2466:             .Top       = 3
2467:             .Left      = 317
2468:             .Width     = 55
2469:             .Height    = 19
2470:             .AutoSize  = .F.
2471:             .FontBold  = .T.
2472:             .FontName  = "Verdana"
2473:             .FontSize  = 10
2474:             .BackStyle = 0
2475:             .Caption   = ""
2476:             .ForeColor = RGB(36, 84, 155)
2477:             .Visible   = .T.
2478:         ENDWITH
2479: 
2480:         THIS.cnt_4c_Mensagems.AddObject("lbl_4c_Mensage1", "Label")
2481:         WITH THIS.cnt_4c_Mensagems.lbl_4c_Mensage1
2482:             .Top       = 1
2483:             .Left      = 6
2484:             .Width     = 709
2485:             .Height    = 23
2486:             .AutoSize  = .F.
2487:             .FontBold  = .T.

*-- Linhas 2510 a 2624:
2510:         ENDWITH
2511:     ENDPROC
2512: 
2513:     *--------------------------------------------------------------------------
2514:     * ConfigurarCamposCaixaLivre - os dois labels sobrepostos do painel
2515:     * "CAIXA LIVRE" (cnt_4c_CaixaLivre, container ja criado). CaixaLivre2 fica
2516:     * 3px deslocado de CaixaLivre e com cor diferente - efeito de sombra do
2517:     * legado, reproduzido na mesma ordem de criacao (Z-order) do dump.
2518:     * Original CaixaLivre: FontBold=.T. FontName="Tahoma" FontSize=60
2519:     * WordWrap=.T. Alignment=2 BackStyle=0 Caption="CAIXA LIVRE" Height=216
2520:     * Left=67 Top=117 Width=336 ForeColor=255,128,64.
2521:     * Original CaixaLivre2: idem, Left=64 Top=120 ForeColor=0,64,183.
2522:     *--------------------------------------------------------------------------
2523:     PROTECTED PROCEDURE ConfigurarCamposCaixaLivre()
2524:         THIS.cnt_4c_CaixaLivre.AddObject("lbl_4c_CaixaLivre", "Label")
2525:         WITH THIS.cnt_4c_CaixaLivre.lbl_4c_CaixaLivre
2526:             .Top        = 117
2527:             .Left       = 67
2528:             .Width      = 336
2529:             .Height     = 216
2530:             .FontBold   = .T.
2531:             .FontItalic = .F.
2532:             .FontName   = "Tahoma"
2533:             .FontSize   = 60
2534:             .WordWrap   = .T.
2535:             .Alignment  = 2
2536:             .BackStyle  = 0
2537:             .Caption    = "CAIXA LIVRE"
2538:             .ForeColor  = RGB(255, 128, 64)
2539:             .Visible    = .T.
2540:         ENDWITH
2541: 
2542:         THIS.cnt_4c_CaixaLivre.AddObject("lbl_4c_CaixaLivre2", "Label")
2543:         WITH THIS.cnt_4c_CaixaLivre.lbl_4c_CaixaLivre2
2544:             .Top        = 120
2545:             .Left       = 64
2546:             .Width      = 336
2547:             .Height     = 216
2548:             .FontBold   = .T.
2549:             .FontItalic = .F.
2550:             .FontName   = "Tahoma"
2551:             .FontSize   = 60
2552:             .WordWrap   = .T.
2553:             .Alignment  = 2
2554:             .BackStyle  = 0
2555:             .Caption    = "CAIXA LIVRE"
2556:             .ForeColor  = RGB(0, 64, 183)
2557:             .Visible    = .T.
2558:         ENDWITH
2559:     ENDPROC
2560: 
2561:     *--------------------------------------------------------------------------
2562:     * ConfigurarCamposCancelaItem - conteudo do painel de cancelamento de item
2563:     * (cnt_4c_CancelaItem, container oculto criado na Fase 3 - acionado por
2564:     * cmd_4c_Apaga/cmd_4c_Excluir nas Fases 7-8). Mostra o item, produto,
2565:     * codigo de barras e descricao do item a cancelar; ok confirma e
2566:     * CancelaDisp desiste.
2567:     * Original (dump slim.txt, SIGMVITN.CancelaItem.*):
2568:     *   Label1 "CANCELAMENTO DE ITEM" Alignment=2 FontSize=10 Height=19 Left=1
2569:     *     Top=2 Width=467 ForeColor=255,255,255 BackColor=90,90,90
2570:     *   Get_Produto Format="K!" InputMask=14x"!" Height=23 Left=78 Top=56
2571:     *     Width=105 BackColor=255,255,185 ForeColor=90,90,90
2572:     *   Label2 "ITEM :" Left=38 Top=33 Width=36
2573:     *   Label3 "PRODUTO :" Left=12 Top=58 Width=62
2574:     *   Label4 "BARRA :" Left=27 Top=84 Width=47
2575:     *   Get_item InputMask="999" MaxLength=3 Height=23 Left=78 Top=31
2576:     *     Width=31 BackColor=255,255,185
2577:     *   Get_Cbarra InputMask="99999999" MaxLength=8 Height=23 Left=78 Top=81
2578:     *     Width=79 BackColor=255,255,185
2579:     *   get_dpro Height=23 Left=183 Top=56 Width=281 BackColor=255,255,185
2580:     *   ok Top=89 Left=368 W=45 H=45 Picture=mouse4.ico ToolTipText="Confirmar"
2581:     *   CancelaDisp Top=89 Left=414 W=45 H=45 Picture="shut down.ico"
2582:     *     Cancel=.T. ToolTipText="Cancelar"
2583:     *--------------------------------------------------------------------------
2584:     PROTECTED PROCEDURE ConfigurarCamposCancelaItem()
2585:         LOCAL loc_cIcones, loc_oCnt
2586:         loc_cIcones = gc_4c_CaminhoIcones
2587:         loc_oCnt    = THIS.cnt_4c_CancelaItem
2588: 
2589:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
2590:         WITH loc_oCnt.lbl_4c_Label1
2591:             .Top            = 2
2592:             .Left           = 1
2593:             .Width          = 467
2594:             .Height         = 19
2595:             .FontBold       = .T.
2596:             .FontName       = "Tahoma"
2597:             .FontSize       = 10
2598:             .FontUnderline  = .F.
2599:             .Alignment      = 2
2600:             .BackStyle      = 1
2601:             .Caption        = "CANCELAMENTO DE ITEM"
2602:             .ForeColor      = RGB(255, 255, 255)
2603:             .BackColor      = RGB(90, 90, 90)
2604:             .Visible        = .T.
2605:         ENDWITH
2606: 
2607:         loc_oCnt.AddObject("txt_4c_Produto", "TextBox")
2608:         WITH loc_oCnt.txt_4c_Produto
2609:             .Top           = 56
2610:             .Left          = 78
2611:             .Width         = 105
2612:             .Height        = 23
2613:             .FontBold      = .T.
2614:             .FontName      = "Tahoma"
2615:             .FontSize      = 8
2616:             .Format        = "K!"
2617:             .InputMask     = "!!!!!!!!!!!!!!"
2618:             .MaxLength     = 14
2619:             .SpecialEffect = 1
2620:             .ForeColor     = RGB(90, 90, 90)
2621:             .BackColor     = RGB(255, 255, 185)
2622:             .Value         = ""
2623:             .Visible       = .T.
2624:         ENDWITH

*-- Linhas 2741 a 2762:
2741:             .BackColor   = RGB(255, 255, 255)
2742:             .Themes      = .F.
2743:             .Visible     = .T.
2744:         ENDWITH
2745: 
2746:         loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
2747:         WITH loc_oCnt.cmd_4c_CancelaDisp
2748:             .Top         = 89
2749:             .Left        = 414
2750:             .Width       = 45
2751:             .Height      = 45
2752:             .FontBold    = .T.
2753:             .FontItalic  = .T.
2754:             .FontName    = "Comic Sans MS"
2755:             .FontSize    = 8
2756:             .Picture     = loc_cIcones + "shut down.ico"
2757:             .Cancel      = .T.
2758:             .Caption     = ""
2759:             .ToolTipText = "Cancelar"
2760:             .ForeColor   = RGB(90, 90, 90)
2761:             .BackColor   = RGB(255, 255, 255)
2762:             .Themes      = .F.

*-- Linhas 2792 a 2835:
2792:     *     Height=46 Left=37 Top=318 Width=249 BorderColor=100,100,100
2793:     *   Proximo Top=319 Left=319 W=45 H=45 Picture=b_arrow2.bmp
2794:     *--------------------------------------------------------------------------
2795:     PROTECTED PROCEDURE ConfigurarCamposConsulta()
2796:         LOCAL loc_cIcones, loc_oCnt, loc_oSub
2797:         loc_cIcones = gc_4c_CaminhoIcones
2798:         loc_oCnt    = THIS.cnt_4c__Consulta
2799: 
2800:         loc_oCnt.AddObject("lbl_4c_Say1", "Label")
2801:         WITH loc_oCnt.lbl_4c_Say1
2802:             .Top       = 277
2803:             .Left      = 34
2804:             .FontBold  = .T.
2805:             .FontName  = "Tahoma"
2806:             .FontSize  = 25
2807:             .Caption   = "Pre" + CHR(231) + "o Unit" + CHR(225) + "rio"
2808:             .ForeColor = RGB(90, 90, 90)
2809:             .Visible   = .T.
2810:         ENDWITH
2811: 
2812:         loc_oCnt.AddObject("cnt_4c__Produto", "Container")
2813:         loc_oSub = loc_oCnt.cnt_4c__Produto
2814:         WITH loc_oSub
2815:             .Top           = 62
2816:             .Left          = 7
2817:             .Width         = 361
2818:             .Height        = 64
2819:             .BackStyle     = 1
2820:             .BorderWidth   = 1
2821:             .SpecialEffect = 2
2822:             .BackColor     = RGB(255, 255, 255)
2823:             .Visible       = .T.
2824:         ENDWITH
2825: 
2826:         loc_oSub.AddObject("txt_4c_Produto", "TextBox")
2827:         WITH loc_oSub.txt_4c_Produto
2828:             .Top       = 28
2829:             .Left      = 39
2830:             .Width     = 178
2831:             .Height    = 30
2832:             .FontBold  = .T.
2833:             .FontName  = "Tahoma"
2834:             .FontSize  = 15
2835:             .Format    = "K!"

*-- Linhas 2941 a 2962:
2941:             .BackColor     = RGB(255, 255, 255)
2942:             .BorderColor   = RGB(100, 100, 100)
2943:             .Visible       = .T.
2944:         ENDWITH
2945: 
2946:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
2947:         WITH loc_oCnt.cmd_4c_Proximo
2948:             .Top           = 319
2949:             .Left          = 319
2950:             .Width         = 45
2951:             .Height        = 45
2952:             .FontName      = "Verdana"
2953:             .FontSize      = 8
2954:             .Picture       = loc_cIcones + "b_arrow2.bmp"
2955:             .Caption       = ""
2956:             .ToolTipText   = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
2957:             .SpecialEffect = 0
2958:             .ForeColor     = RGB(36, 84, 155)
2959:             .BackColor     = RGB(255, 255, 255)
2960:             .Themes        = .F.
2961:             .Visible       = .T.
2962:         ENDWITH

*-- Linhas 3015 a 3058:
3015:     *   Proximo Top=370 Left=323 W=45 H=45 Picture=b_arrow2.bmp
3016:     *   Say8 (filho direto de CntItem) "TOTAL" FontSize=25 Left=61 Top=330
3017:     *--------------------------------------------------------------------------
3018:     PROTECTED PROCEDURE ConfigurarCamposItem()
3019:         LOCAL loc_cIcones, loc_oCnt, loc_oSub
3020:         loc_cIcones = gc_4c_CaminhoIcones
3021:         loc_oCnt    = THIS.cnt_4c_Item
3022: 
3023:         loc_oCnt.AddObject("txt_4c_Total", "TextBox")
3024:         WITH loc_oCnt.txt_4c_Total
3025:             .Top           = 369
3026:             .Left          = 62
3027:             .Width         = 249
3028:             .Height        = 46
3029:             .FontBold      = .T.
3030:             .FontName      = "Verdana"
3031:             .FontSize      = 22
3032:             .Alignment     = 3
3033:             .Value         = 0
3034:             .InputMask     = "9,999,999.99"
3035:             .SpecialEffect = 1
3036:             .BackColor     = RGB(255, 255, 255)
3037:             .Visible       = .T.
3038:         ENDWITH
3039: 
3040:         *-- Cnt_Produto: codigo do produto + quantidade.
3041:         loc_oCnt.AddObject("cnt_4c__Produto", "Container")
3042:         loc_oSub = loc_oCnt.cnt_4c__Produto
3043:         WITH loc_oSub
3044:             .Top           = 8
3045:             .Left          = 7
3046:             .Width         = 360
3047:             .Height        = 92
3048:             .BackStyle     = 1
3049:             .BorderWidth   = 1
3050:             .SpecialEffect = 2
3051:             .BackColor     = RGB(255, 255, 255)
3052:             .Visible       = .T.
3053:         ENDWITH
3054: 
3055:         loc_oSub.AddObject("txt_4c_Produto", "TextBox")
3056:         WITH loc_oSub.txt_4c_Produto
3057:             .Top       = 26
3058:             .Left      = 24

*-- Linhas 3112 a 3155:
3112:         *-- CmdEnviaProd: so aparece quando o legado exige confirmacao manual
3113:         *-- do produto identificado por codigo de barras (leitura ambigua) -
3114:         *-- nasce oculto, como no dump, e entra na skip-list de
3115:         *-- TornarControlesVisiveis.
3116:         loc_oSub.AddObject("cmd_4c_CmdEnviaProd", "CommandButton")
3117:         WITH loc_oSub.cmd_4c_CmdEnviaProd
3118:             .Top             = 58
3119:             .Left            = 203
3120:             .Width           = 104
3121:             .Height          = 29
3122:             .FontBold        = .T.
3123:             .FontItalic      = .T.
3124:             .FontName        = "Comic Sans MS"
3125:             .FontSize        = 8
3126:             .Picture         = loc_cIcones + "b_print2.bmp"
3127:             .Caption         = "\<Confirmar"
3128:             .ToolTipText     = "Confirma o Produto Informado"
3129:             .PicturePosition = 1
3130:             .ForeColor       = RGB(90, 90, 90)
3131:             .BackColor       = RGB(255, 255, 255)
3132:             .Themes          = .F.
3133:             .Visible         = .F.
3134:         ENDWITH
3135: 
3136:         *-- Cnt_Subtotal: valor unitario do item (subtotal antes de
3137:         *-- desconto/acrescimo).
3138:         loc_oCnt.AddObject("cnt_4c__Subtotal", "Container")
3139:         loc_oSub = loc_oCnt.cnt_4c__Subtotal
3140:         WITH loc_oSub
3141:             .Top           = 266
3142:             .Left          = 7
3143:             .Width         = 360
3144:             .Height        = 46
3145:             .BorderWidth   = 1
3146:             .SpecialEffect = 2
3147:             .BackColor     = RGB(255, 255, 255)
3148:             .Visible       = .T.
3149:         ENDWITH
3150: 
3151:         loc_oSub.AddObject("txt_4c_Valor", "TextBox")
3152:         WITH loc_oSub.txt_4c_Valor
3153:             .Top       = 8
3154:             .Left      = 160
3155:             .Width     = 161

*-- Linhas 3367 a 3388:
3367:             .ForeColor = RGB(90, 90, 90)
3368:             .Visible   = .T.
3369:         ENDWITH
3370: 
3371:         *-- Proximo: avanca para a tela de pagamento.
3372:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
3373:         WITH loc_oCnt.cmd_4c_Proximo
3374:             .Top           = 370
3375:             .Left          = 323
3376:             .Width         = 45
3377:             .Height        = 45
3378:             .FontName      = "Verdana"
3379:             .FontSize      = 8
3380:             .Picture       = loc_cIcones + "b_arrow2.bmp"
3381:             .Caption       = ""
3382:             .ToolTipText   = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
3383:             .SpecialEffect = 0
3384:             .ForeColor     = RGB(36, 84, 155)
3385:             .BackColor     = RGB(255, 255, 255)
3386:             .Themes        = .F.
3387:             .Visible       = .T.
3388:         ENDWITH

*-- Linhas 3433 a 3476:
3433:     *     alcance com DataSession=2 isolado (mesma decisao das Fases 1-4); o
3434:     *     valor e populado por evento nas Fases 7-8.
3435:     *--------------------------------------------------------------------------
3436:     PROTECTED PROCEDURE ConfigurarCamposFinanc()
3437:         LOCAL loc_cIcones, loc_oCnt, loc_oSub
3438:         loc_cIcones = gc_4c_CaminhoIcones
3439:         loc_oCnt    = THIS.cnt_4c_Financ
3440: 
3441:         loc_oCnt.AddObject("shp_4c_Shape4", "Shape")
3442:         WITH loc_oCnt.shp_4c_Shape4
3443:             .Top           = 349
3444:             .Left          = 0
3445:             .Width         = 370
3446:             .Height        = 3
3447:             .SpecialEffect = 0
3448:             .Visible       = .T.
3449:         ENDWITH
3450: 
3451:         loc_oCnt.AddObject("cnt_4c__Barras", "Container")
3452:         loc_oSub = loc_oCnt.cnt_4c__Barras
3453:         WITH loc_oSub
3454:             .Top           = 57
3455:             .Left          = 4
3456:             .Width         = 368
3457:             .Height        = 125
3458:             .BackStyle     = 1
3459:             .BorderWidth   = 1
3460:             .SpecialEffect = 2
3461:             .BackColor     = RGB(255, 255, 255)
3462:             .Visible       = .T.
3463:         ENDWITH
3464: 
3465:         loc_oSub.AddObject("img_4c_Image1", "Image")
3466:         WITH loc_oSub.img_4c_Image1
3467:             .Top       = 34
3468:             .Left      = 14
3469:             .Width     = 25
3470:             .Height    = 25
3471:             .Picture   = loc_cIcones + "b_arrow2.bmp"
3472:             .BackStyle = 0
3473:             .Visible   = .T.
3474:         ENDWITH
3475: 
3476:         loc_oSub.AddObject("img_4c_Image2", "Image")

*-- Linhas 3530 a 3551:
3530:             .DisabledBackColor = RGB(128, 128, 128)
3531:             .Value             = ""
3532:             .Visible           = .T.
3533:         ENDWITH
3534: 
3535:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
3536:         WITH loc_oCnt.cmd_4c_Proximo
3537:             .Top           = 353
3538:             .Left          = 320
3539:             .Width         = 45
3540:             .Height        = 45
3541:             .FontName      = "Verdana"
3542:             .FontSize      = 8
3543:             .Picture       = loc_cIcones + "b_arrow2.bmp"
3544:             .Caption       = ""
3545:             .SpecialEffect = 0
3546:             .ForeColor     = RGB(36, 84, 155)
3547:             .BackColor     = RGB(255, 255, 255)
3548:             .Themes        = .F.
3549:             .Visible       = .T.
3550:         ENDWITH
3551: 

*-- Linhas 3602 a 3688:
3602:     * Cnt_Identifica (COMPLETO, com todos os lookups Grupo/Conta/Cpf) e
3603:     * Cnt_Fpagto (COMPLETO, incluindo Cnt_ChequepreTef.Cnt_Chq) + cmbTOpers.
3604:     *--------------------------------------------------------------------------
3605:     PROTECTED PROCEDURE ConfigurarCamposParte2()
3606:         THIS.ConfigurarCamposCreditoPendencia()
3607:         THIS.ConfigurarCamposIdentifica()
3608:         THIS.ConfigurarCamposFpagto()
3609:         THIS.ConfigurarComboOperacao()
3610:     ENDPROC
3611: 
3612:     *--------------------------------------------------------------------------
3613:     * ConfigurarCamposCreditoPendencia - labels/botoes remanescentes de
3614:     * Cnt_Credito e Cnt_Pendencia. As grades (grd_4c_Devolucao/grd_4c_SubNiveis)
3615:     * e o cmd_4c_BotPend ja foram criados na Fase 4
3616:     * (ConfigurarGradesOperacao) - aqui so falta o botao "Proximo" (navegacao
3617:     * ENTER) e o label de instrucao de cada container.
3618:     *--------------------------------------------------------------------------
3619:     PROTECTED PROCEDURE ConfigurarCamposCreditoPendencia()
3620:         LOCAL loc_cIcones
3621:         loc_cIcones = gc_4c_CaminhoIcones
3622: 
3623:         THIS.cnt_4c__Credito.AddObject("cmd_4c_Proximo", "CommandButton")
3624:         WITH THIS.cnt_4c__Credito.cmd_4c_Proximo
3625:             .Top         = 394
3626:             .Left        = 325
3627:             .Width       = 45
3628:             .Height      = 45
3629:             .FontName    = "Verdana"
3630:             .FontSize    = 8
3631:             .Picture     = loc_cIcones + "b_arrow2.bmp"
3632:             .Caption     = ""
3633:             .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
3634:             .ForeColor   = RGB(36, 84, 155)
3635:             .BackColor   = RGB(255, 255, 255)
3636:             .Themes      = .F.
3637:             .Visible     = .T.
3638:         ENDWITH
3639: 
3640:         THIS.cnt_4c__Credito.AddObject("lbl_4c_Label2", "Label")
3641:         WITH THIS.cnt_4c__Credito.lbl_4c_Label2
3642:             .Top       = 422
3643:             .Left      = 194
3644:             .Width     = 135
3645:             .Height    = 16
3646:             .AutoSize  = .T.
3647:             .FontBold  = .T.
3648:             .FontName  = "Tahoma"
3649:             .BackStyle = 0
3650:             .Caption   = "[ENTER] Muda de Tela"
3651:             .ForeColor = RGB(90, 90, 90)
3652:             .Visible   = .T.
3653:         ENDWITH
3654: 
3655:         THIS.cnt_4c__Pendencia.AddObject("cmd_4c_Proximo", "CommandButton")
3656:         WITH THIS.cnt_4c__Pendencia.cmd_4c_Proximo
3657:             .Top         = 382
3658:             .Left        = 311
3659:             .Width       = 45
3660:             .Height      = 45
3661:             .FontName    = "Verdana"
3662:             .FontSize    = 8
3663:             .Picture     = loc_cIcones + "b_arrow2.bmp"
3664:             .Caption     = ""
3665:             .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
3666:             .ForeColor   = RGB(36, 84, 155)
3667:             .BackColor   = RGB(255, 255, 255)
3668:             .Themes      = .F.
3669:             .Visible     = .T.
3670:         ENDWITH
3671: 
3672:         THIS.cnt_4c__Pendencia.AddObject("lbl_4c_Label2", "Label")
3673:         WITH THIS.cnt_4c__Pendencia.lbl_4c_Label2
3674:             .Top       = 413
3675:             .Left      = 168
3676:             .Width     = 135
3677:             .Height    = 16
3678:             .AutoSize  = .T.
3679:             .FontBold  = .T.
3680:             .FontName  = "Tahoma"
3681:             .BackStyle = 0
3682:             .Caption   = "[ENTER] Muda de Tela"
3683:             .ForeColor = RGB(90, 90, 90)
3684:             .Visible   = .T.
3685:         ENDWITH
3686:     ENDPROC
3687: 
3688:     *--------------------------------------------------------------------------

*-- Linhas 3695 a 3746:
3695:     *
3696:     * LOOKUPS (originais fAcessoContab/fAcessoContas/fwBuscaExt - PROIBIDOS de
3697:     * usar direto, CLAUDE.md "fAcessoContas() lookup UX" e "fAcessoEmpresa()
3698:     * NAO EXISTE"): substituidos pelo padrao canonico FormBuscaAuxiliar
3699:     * (CLAUDE.md #36/#37) via os metodos AbrirLookupGrupo/AbrirLookupConta,
3700:     * acionados em ENTER/TAB/F4 (BINDEVENT "KeyPress" - CLAUDE.md #84, Valid
3701:     * nao dispara em TextBox). Grupo -> SigCdGcr (codigos/descrs). Conta ->
3702:     * SigCdCli (iclis/rclis/cpfs/grupos - NAO grclis, CLAUDE.md regra
3703:     * "SigCdCli tem coluna grupos, nao grclis"), filtrada pelo Grupo quando
3704:     * preenchido.
3705:     *--------------------------------------------------------------------------
3706:     PROTECTED PROCEDURE ConfigurarCamposIdentifica()
3707:         LOCAL loc_oCnt, loc_oSub
3708: 
3709:         loc_oCnt = THIS.cnt_4c__Identifica
3710: 
3711:         *======================================================================
3712:         * Destino
3713:         *======================================================================
3714:         loc_oCnt.AddObject("cnt_4c_Destino", "Container")
3715:         loc_oSub = loc_oCnt.cnt_4c_Destino
3716:         WITH loc_oSub
3717:             .Top           = 168
3718:             .Left          = 2
3719:             .Width         = 371
3720:             .Height        = 94
3721:             .BackStyle     = 1
3722:             .BorderWidth   = 1
3723:             .SpecialEffect = 2
3724:             .TabIndex      = 4
3725:             .BackColor     = RGB(255, 255, 255)
3726:             .Visible       = .T.
3727:         ENDWITH
3728: 
3729:         loc_oSub.AddObject("lbl_4c_Label4", "Label")
3730:         WITH loc_oSub.lbl_4c_Label4
3731:             .Top       = 2
3732:             .Left      = 10
3733:             .Width     = 45
3734:             .Height    = 15
3735:             .FontBold  = .T.
3736:             .FontName  = "Tahoma"
3737:             .FontSize  = 8
3738:             .BackStyle = 0
3739:             .Caption   = "Destino"
3740:             .ForeColor = RGB(90, 90, 90)
3741:             .TabIndex  = 26
3742:             .Visible   = .T.
3743:         ENDWITH
3744: 
3745:         loc_oSub.AddObject("lin_4c_Line1", "Line")
3746:         WITH loc_oSub.lin_4c_Line1

*-- Linhas 3895 a 3941:
3895:             .Visible       = .T.
3896:         ENDWITH
3897: 
3898:         BINDEVENT(loc_oSub.txt_4c_Grupo, "KeyPress", THIS, "GrpDestinoKeyPress")
3899:         BINDEVENT(loc_oSub.txt_4c_Conta, "KeyPress", THIS, "CtaDestinoKeyPress")
3900:         BINDEVENT(loc_oSub.txt_4c_Dconta, "KeyPress", THIS, "DctDestinoKeyPress")
3901:         BINDEVENT(loc_oSub.txt_4c_Cpf, "KeyPress", THIS, "CpfDestinoKeyPress")
3902: 
3903:         *======================================================================
3904:         * Responsavel
3905:         *======================================================================
3906:         loc_oCnt.AddObject("cnt_4c_Responsavel", "Container")
3907:         loc_oSub = loc_oCnt.cnt_4c_Responsavel
3908:         WITH loc_oSub
3909:             .Top           = 356
3910:             .Left          = 2
3911:             .Width         = 371
3912:             .Height        = 94
3913:             .BackStyle     = 1
3914:             .BorderWidth   = 1
3915:             .SpecialEffect = 2
3916:             .TabIndex      = 6
3917:             .BackColor     = RGB(255, 255, 255)
3918:             .Visible       = .T.
3919:         ENDWITH
3920: 
3921:         loc_oSub.AddObject("lbl_4c_label42", "Label")
3922:         WITH loc_oSub.lbl_4c_label42
3923:             .Top       = 2
3924:             .Left      = 10
3925:             .Width     = 74
3926:             .Height    = 15
3927:             .FontBold  = .T.
3928:             .FontName  = "Tahoma"
3929:             .FontSize  = 8
3930:             .BackStyle = 0
3931:             .Caption   = "Respons" + CHR(225) + "vel"
3932:             .ForeColor = RGB(90, 90, 90)
3933:             .TabIndex  = 26
3934:             .Visible   = .T.
3935:         ENDWITH
3936: 
3937:         loc_oSub.AddObject("lin_4c_line12", "Line")
3938:         WITH loc_oSub.lin_4c_line12
3939:             .Top         = 17
3940:             .Left        = 10
3941:             .Width       = 320

*-- Linhas 4070 a 4116:
4070:             .Visible           = .T.
4071:         ENDWITH
4072: 
4073:         BINDEVENT(loc_oSub.txt_4c_Grupo, "KeyPress", THIS, "GrpRespKeyPress")
4074:         BINDEVENT(loc_oSub.txt_4c_Conta, "KeyPress", THIS, "CtaRespKeyPress")
4075:         BINDEVENT(loc_oSub.txt_4c_Dconta, "KeyPress", THIS, "DctRespKeyPress")
4076:         BINDEVENT(loc_oSub.txt_4c_Cpf, "KeyPress", THIS, "CpfRespKeyPress")
4077: 
4078:         *======================================================================
4079:         * Vendedor
4080:         *======================================================================
4081:         loc_oCnt.AddObject("cnt_4c_Vendedor", "Container")
4082:         loc_oSub = loc_oCnt.cnt_4c_Vendedor
4083:         WITH loc_oSub
4084:             .Top           = 262
4085:             .Left          = 2
4086:             .Width         = 371
4087:             .Height        = 94
4088:             .BackStyle     = 1
4089:             .BorderWidth   = 1
4090:             .SpecialEffect = 2
4091:             .TabIndex      = 5
4092:             .BackColor     = RGB(255, 255, 255)
4093:             .Visible       = .T.
4094:         ENDWITH
4095: 
4096:         loc_oSub.AddObject("lbl_4c_label43", "Label")
4097:         WITH loc_oSub.lbl_4c_label43
4098:             .Top       = 2
4099:             .Left      = 10
4100:             .Width     = 56
4101:             .Height    = 15
4102:             .FontBold  = .T.
4103:             .FontName  = "Tahoma"
4104:             .FontSize  = 8
4105:             .BackStyle = 0
4106:             .Caption   = "Vendedor"
4107:             .ForeColor = RGB(90, 90, 90)
4108:             .TabIndex  = 26
4109:             .Visible   = .T.
4110:         ENDWITH
4111: 
4112:         loc_oSub.AddObject("lin_4c_line13", "Line")
4113:         WITH loc_oSub.lin_4c_line13
4114:             .Top         = 17
4115:             .Left        = 10
4116:             .Width       = 315

*-- Linhas 4245 a 4291:
4245:             .Visible           = .T.
4246:         ENDWITH
4247: 
4248:         BINDEVENT(loc_oSub.txt_4c_Grupo, "KeyPress", THIS, "GrpVendKeyPress")
4249:         BINDEVENT(loc_oSub.txt_4c_Conta, "KeyPress", THIS, "CtaVendKeyPress")
4250:         BINDEVENT(loc_oSub.txt_4c_Dconta, "KeyPress", THIS, "DctVendKeyPress")
4251:         BINDEVENT(loc_oSub.txt_4c_Cpf, "KeyPress", THIS, "CpfVendKeyPress")
4252: 
4253:         *======================================================================
4254:         * TabDesconto
4255:         *======================================================================
4256:         loc_oCnt.AddObject("cnt_4c_TabDesconto", "Container")
4257:         loc_oSub = loc_oCnt.cnt_4c_TabDesconto
4258:         WITH loc_oSub
4259:             .Top           = 33
4260:             .Left          = 2
4261:             .Width         = 371
4262:             .Height        = 41
4263:             .BackStyle     = 1
4264:             .BorderWidth   = 1
4265:             .SpecialEffect = 2
4266:             .TabIndex      = 2
4267:             .BackColor     = RGB(255, 255, 255)
4268:             .Visible       = .T.
4269:         ENDWITH
4270: 
4271:         loc_oSub.AddObject("lbl_4c_Label1", "Label")
4272:         WITH loc_oSub.lbl_4c_Label1
4273:             .Top       = 4
4274:             .Left      = 10
4275:             .FontBold  = .T.
4276:             .FontName  = "Tahoma"
4277:             .FontSize  = 8
4278:             .BackStyle = 0
4279:             .Caption   = "Tab. Desconto"
4280:             .ForeColor = RGB(90, 90, 90)
4281:             .TabIndex  = 4
4282:             .Visible   = .T.
4283:         ENDWITH
4284: 
4285:         loc_oSub.AddObject("txt_4c_Tabd", "TextBox")
4286:         WITH loc_oSub.txt_4c_Tabd
4287:             .Top           = 18
4288:             .Left          = 10
4289:             .Width         = 80
4290:             .Height        = 20
4291:             .FontName      = "Tahoma"

*-- Linhas 4328 a 4372:
4328:             .Visible   = .T.
4329:         ENDWITH
4330: 
4331:         BINDEVENT(loc_oSub.txt_4c_Tabd, "KeyPress", THIS, "TabdKeyPress")
4332:         BINDEVENT(loc_oSub.txt_4c_ListaPreco, "KeyPress", THIS, "ListaPrecoKeyPress")
4333: 
4334:         *======================================================================
4335:         * CodOperacao
4336:         *======================================================================
4337:         loc_oCnt.AddObject("cnt_4c_CodOperacao", "Container")
4338:         loc_oSub = loc_oCnt.cnt_4c_CodOperacao
4339:         WITH loc_oSub
4340:             .Top           = 2
4341:             .Left          = 2
4342:             .Width         = 371
4343:             .Height        = 31
4344:             .BorderWidth   = 1
4345:             .SpecialEffect = 2
4346:             .TabIndex      = 2
4347:             .BackColor     = RGB(255, 255, 255)
4348:             .Visible       = .T.
4349:         ENDWITH
4350: 
4351:         loc_oSub.AddObject("lbl_4c_label12", "Label")
4352:         WITH loc_oSub.lbl_4c_label12
4353:             .Top       = 8
4354:             .Left      = 9
4355:             .FontBold  = .T.
4356:             .FontName  = "Tahoma"
4357:             .FontSize  = 8
4358:             .BackStyle = 0
4359:             .Caption   = "Documento : "
4360:             .ForeColor = RGB(90, 90, 90)
4361:             .TabIndex  = 4
4362:             .Visible   = .T.
4363:         ENDWITH
4364: 
4365:         loc_oSub.AddObject("txt_4c_Codigo", "TextBox")
4366:         WITH loc_oSub.txt_4c_Codigo
4367:             .Top           = 4
4368:             .Left          = 94
4369:             .Width         = 61
4370:             .Height        = 23
4371:             .FontBold      = .T.
4372:             .FontName      = "Tahoma"

*-- Linhas 4598 a 4677:
4598:             .Visible       = .T.
4599:         ENDWITH
4600: 
4601:         BINDEVENT(loc_oSub.txt_4c_Grupo, "KeyPress", THIS, "GrpOrigKeyPress")
4602:         BINDEVENT(loc_oSub.txt_4c_Conta, "KeyPress", THIS, "CtaOrigKeyPress")
4603:         BINDEVENT(loc_oSub.txt_4c_Dconta, "KeyPress", THIS, "DctOrigKeyPress")
4604:         BINDEVENT(loc_oSub.txt_4c_Cpf, "KeyPress", THIS, "CpfOrigKeyPress")
4605: 
4606:         *======================================================================
4607:         * Proximo (navegacao ENTER, filho direto de Cnt_Identifica)
4608:         *======================================================================
4609:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
4610:         WITH loc_oCnt.cmd_4c_Proximo
4611:             .Top         = 400
4612:             .Left        = 324
4613:             .Width       = 45
4614:             .Height      = 45
4615:             .FontName    = "Verdana"
4616:             .FontSize    = 8
4617:             .Picture     = gc_4c_CaminhoIcones + "b_arrow2.bmp"
4618:             .Caption     = ""
4619:             .ForeColor   = RGB(36, 84, 155)
4620:             .BackColor   = RGB(255, 255, 255)
4621:             .Themes      = .F.
4622:             .Visible     = .T.
4623:         ENDWITH
4624:     ENDPROC
4625: 
4626:     *--------------------------------------------------------------------------
4627:     * ConfigurarCamposFpagto - Cnt_Fpagto (F11 Pagto): forma de pagamento,
4628:     * parcelamento, vencimento, acrescimo/desconto e o painel de conferencia
4629:     * de cheque pre-datado/TEF (Cnt_ChequepreTef.Cnt_Chq). O container
4630:     * cnt_4c__ChequepreTef e o grd_4c_Parcelas ja foram criados na Fase 4
4631:     * (ConfigurarGradesOperacao) - aqui so falta o Cnt_Chq interno.
4632:     *
4633:     * LOOKUP: Get_fpg (forma de pagamento, original CreateObject('fwBuscaSel',
4634:     * 'ccSigOpFp', 'FPags', ...)) -> SigOpFp (fpags/descrs/fparcs), mesmo
4635:     * padrao FormBuscaAuxiliar dos demais lookups deste form.
4636:     *--------------------------------------------------------------------------
4637:     PROTECTED PROCEDURE ConfigurarCamposFpagto()
4638:         LOCAL loc_oCnt, loc_oSub, loc_oChq
4639: 
4640:         loc_oCnt = THIS.cnt_4c__Fpagto
4641: 
4642:         *======================================================================
4643:         * Acrescimo (Visible=.F. no legado - so aparece via Barra_Botoes.
4644:         * Acrescimo, Click e evento de Fase 7-8)
4645:         *======================================================================
4646:         loc_oCnt.AddObject("cnt_4c_Acrescimo", "Container")
4647:         loc_oSub = loc_oCnt.cnt_4c_Acrescimo
4648:         WITH loc_oSub
4649:             .Top         = 31
4650:             .Left        = 17
4651:             .Width       = 303
4652:             .Height      = 52
4653:             .BackStyle   = 1
4654:             .BorderWidth = 1
4655:             .TabIndex    = 3
4656:             .BackColor   = RGB(255, 255, 255)
4657:             .Visible     = .F.
4658:         ENDWITH
4659: 
4660:         loc_oSub.AddObject("txt_4c_TotVariacao", "TextBox")
4661:         WITH loc_oSub.txt_4c_TotVariacao
4662:             .Top           = 25
4663:             .Left          = 117
4664:             .Width         = 185
4665:             .Height        = 24
4666:             .FontBold      = .T.
4667:             .FontName      = "Tahoma"
4668:             .FontSize      = 14
4669:             .Alignment     = 3
4670:             .Margin        = 0
4671:             .InputMask     = "999,999,999.99"
4672:             .SpecialEffect = 1
4673:             .TabIndex      = 43
4674:             .ForeColor     = RGB(90, 90, 90)
4675:             .BackColor     = RGB(255, 255, 255)
4676:             .Value         = 0
4677:             .Visible       = .T.

*-- Linhas 5105 a 5126:
5105:             .ForeColor = RGB(90, 90, 90)
5106:             .TabIndex  = 22
5107:             .Visible   = .T.
5108:         ENDWITH
5109: 
5110:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
5111:         WITH loc_oCnt.cmd_4c_Proximo
5112:             .Top         = 308
5113:             .Left        = 324
5114:             .Width       = 45
5115:             .Height      = 45
5116:             .FontName    = "Verdana"
5117:             .FontSize    = 8
5118:             .Picture     = gc_4c_CaminhoIcones + "b_arrow1.bmp"
5119:             .Caption     = ""
5120:             .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
5121:             .TabIndex    = 26
5122:             .ForeColor   = RGB(36, 84, 155)
5123:             .BackColor   = RGB(255, 255, 255)
5124:             .Themes      = .F.
5125:             .Visible     = .T.
5126:         ENDWITH

*-- Linhas 5221 a 5306:
5221:             .Visible       = .T.
5222:         ENDWITH
5223: 
5224:         BINDEVENT(loc_oCnt.txt_4c_Fpg, "KeyPress", THIS, "FpgKeyPress")
5225: 
5226:         *======================================================================
5227:         * Cnt_ChequepreTef.Cnt_Chq - conferencia de cheque pre-datado/TEF
5228:         *======================================================================
5229:         loc_oChq = loc_oCnt.cnt_4c__ChequepreTef
5230:         loc_oChq.AddObject("cnt_4c__Chq", "Container")
5231:         loc_oSub = loc_oChq.cnt_4c__Chq
5232:         WITH loc_oSub
5233:             .Top         = 0
5234:             .Left        = 0
5235:             .Width       = 371
5236:             .Height      = 60
5237:             .BackStyle   = 1
5238:             .BorderWidth = 1
5239:             .SpecialEffect = 2
5240:             .TabIndex    = 13
5241:             .BackColor   = RGB(255, 255, 255)
5242:             .Visible     = .F.
5243:         ENDWITH
5244: 
5245:         loc_oSub.AddObject("cmd_4c_TefChq", "CommandButton")
5246:         WITH loc_oSub.cmd_4c_TefChq
5247:             .Top         = 5
5248:             .Left        = 259
5249:             .Width       = 108
5250:             .Height      = 20
5251:             .FontBold    = .T.
5252:             .FontItalic  = .T.
5253:             .FontName    = "Comic Sans MS"
5254:             .FontSize    = 8
5255:             .WordWrap    = .T.
5256:             .Caption     = "Consulta C\<heque"
5257:             .TabIndex    = 12
5258:             .TabStop     = .F.
5259:             .ToolTipText = "Verifica e Confirma se a numera" + CHR(231) + CHR(227) + "o dos cheques est" + CHR(225) + " OK."
5260:             .ForeColor   = RGB(90, 90, 90)
5261:             .BackColor   = RGB(255, 255, 255)
5262:             .Themes      = .F.
5263:             .Visible     = .T.
5264:         ENDWITH
5265: 
5266:         loc_oSub.AddObject("obj_4c_Opc_cpf", "OptionGroup")
5267:         WITH loc_oSub.obj_4c_Opc_cpf
5268:             .Top         = 5
5269:             .Left        = 3
5270:             .Width       = 108
5271:             .Height      = 17
5272:             .ButtonCount = 2
5273:             .Value       = 1
5274:             .BackStyle   = 0
5275:             .BorderStyle = 0
5276:             .TabIndex    = 18
5277:             .BorderColor = RGB(192, 192, 192)
5278:             .Visible     = .T.
5279:             WITH .Buttons(1)
5280:                 .BackStyle = 0
5281:                 .Caption   = "CPF"
5282:                 .Height    = 17
5283:                 .Left      = 5
5284:                 .Top       = 1
5285:                 .Width     = 44
5286:             ENDWITH
5287:             WITH .Buttons(2)
5288:                 .FontSize  = 8
5289:                 .BackStyle = 0
5290:                 .Caption   = "CNPJ"
5291:                 .Left      = 57
5292:                 .Top       = 1
5293:             ENDWITH
5294:         ENDWITH
5295: 
5296:         loc_oSub.AddObject("txt_4c_Cpf", "TextBox")
5297:         WITH loc_oSub.txt_4c_Cpf
5298:             .Top               = 4
5299:             .Left              = 112
5300:             .Width             = 140
5301:             .Height            = 20
5302:             .FontName          = "Tahoma"
5303:             .Margin            = 0
5304:             .MaxLength         = 20
5305:             .SpecialEffect     = 1
5306:             .TabIndex          = 1

*-- Linhas 5517 a 6490:
5517:     * (Value); a lista de itens e populada em runtime (Fase 7-8, junto do
5518:     * evento de Click de cmd_4c_MudaOpe que a alimenta) - aqui so a moldura.
5519:     *--------------------------------------------------------------------------
5520:     PROTECTED PROCEDURE ConfigurarComboOperacao()
5521:         THIS.AddObject("cbo_4c_CmbTOpers", "ComboBox")
5522:         WITH THIS.cbo_4c_CmbTOpers
5523:             .Top            = 594
5524:             .Left           = 39
5525:             .Width          = 277
5526:             .Height         = 22
5527:             .FontName       = "Verdana"
5528:             .RowSourceType  = 1
5529:             .SpecialEffect  = 1
5530:             .Visible        = .F.
5531:         ENDWITH
5532:     ENDPROC
5533: 
5534:     *==========================================================================
5535:     * LOOKUPS - Cnt_Identifica (Grupo/Conta) e Cnt_Fpagto (Forma de Pagamento)
5536:     *
5537:     * Substituem fAcessoContab/fAcessoContas/fwBuscaExt/fwBuscaSel do legado
5538:     * (CLAUDE.md: fAcessoContas() PROIBIDO como handler de lookup UX -
5539:     * auto-preenche com o primeiro match parcial sem selecao explicita).
5540:     * Padrao canonico FormBuscaAuxiliar (CLAUDE.md #36/#37): o proprio Init ja
5541:     * tenta o match EXATO e so mostra o picker se nao encontrar - por isso NAO
5542:     * ha um SQLEXEC de pre-checagem aqui, so a chamada direta.
5543:     *==========================================================================
5544: 
5545:     *--------------------------------------------------------------------------
5546:     * AbrirLookupGrupo - Grupo de Contas (SigCdGcr.codigos/descrs).
5547:     *--------------------------------------------------------------------------
5548:     PROTECTED PROCEDURE AbrirLookupGrupo(par_oTxtGrupo)
5549:         LOCAL loc_oBusca
5550: 
5551:         IF USED("cursor_4c_BuscaGrupo")
5552:             USE IN cursor_4c_BuscaGrupo
5553:         ENDIF
5554: 
5555:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
5556:             "cursor_4c_BuscaGrupo", "codigos", ALLTRIM(par_oTxtGrupo.Value), "Grupo de Contas")
5557: 
5558:         IF VARTYPE(loc_oBusca) = "O"
5559:             IF !loc_oBusca.this_lAchouRegistro
5560:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
5561:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5562:                 loc_oBusca.Show()
5563:             ENDIF
5564:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
5565:                 SELECT cursor_4c_BuscaGrupo
5566:                 par_oTxtGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
5567:             ENDIF
5568:             loc_oBusca.Release()
5569:         ENDIF
5570: 
5571:         IF USED("cursor_4c_BuscaGrupo")
5572:             USE IN cursor_4c_BuscaGrupo
5573:         ENDIF
5574:     ENDPROC
5575: 
5576:     *--------------------------------------------------------------------------
5577:     * AbrirLookupConta - Contas (SigCdCli.iclis/rclis/cpfs/grupos). Busca por
5578:     * par_cCampoBusca ("iclis"/"rclis"/"cpfs" - o campo que o usuario digitou)
5579:     * com par_cValorBusca; filtra por Grupo quando par_oTxtGrupo ja tem valor.
5580:     * Preenche Conta+Nome+Cpf sempre; Grupo so se estava vazio (nao sobrescreve
5581:     * filtro que o usuario ja escolheu).
5582:     *--------------------------------------------------------------------------
5583:     PROTECTED PROCEDURE AbrirLookupConta(par_oTxtConta, par_oTxtDconta, par_oTxtCpf, ;
5584:             par_oTxtGrupo, par_cCampoBusca, par_cValorBusca)
5585:         LOCAL loc_oBusca, loc_cFiltro
5586: 
5587:         loc_cFiltro = ""
5588:         IF VARTYPE(par_oTxtGrupo) = "O" AND !EMPTY(ALLTRIM(par_oTxtGrupo.Value))
5589:             loc_cFiltro = "grupos = " + EscaparSQL(PADR(ALLTRIM(par_oTxtGrupo.Value), 10))
5590:         ENDIF
5591: 
5592:         IF USED("cursor_4c_BuscaConta")
5593:             USE IN cursor_4c_BuscaConta
5594:         ENDIF
5595: 
5596:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
5597:             "cursor_4c_BuscaConta", par_cCampoBusca, par_cValorBusca, "Contas", .F., .T., loc_cFiltro)
5598: 
5599:         IF VARTYPE(loc_oBusca) = "O"
5600:             IF !loc_oBusca.this_lAchouRegistro
5601:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
5602:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
5603:                 loc_oBusca.mAddColuna("cpfs",  "", "CPF" + CHR(47) + "CNPJ")
5604:                 loc_oBusca.Show()
5605:             ENDIF
5606:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
5607:                 SELECT cursor_4c_BuscaConta
5608:                 par_oTxtConta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
5609:                 IF VARTYPE(par_oTxtDconta) = "O"
5610:                     par_oTxtDconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
5611:                 ENDIF
5612:                 IF VARTYPE(par_oTxtCpf) = "O"
5613:                     par_oTxtCpf.Value = ALLTRIM(cursor_4c_BuscaConta.cpfs)
5614:                 ENDIF
5615:                 IF VARTYPE(par_oTxtGrupo) = "O" AND EMPTY(ALLTRIM(par_oTxtGrupo.Value))
5616:                     par_oTxtGrupo.Value = ALLTRIM(cursor_4c_BuscaConta.grupos)
5617:                 ENDIF
5618:             ENDIF
5619:             loc_oBusca.Release()
5620:         ENDIF
5621: 
5622:         IF USED("cursor_4c_BuscaConta")
5623:             USE IN cursor_4c_BuscaConta
5624:         ENDIF
5625:     ENDPROC
5626: 
5627:     *--------------------------------------------------------------------------
5628:     * AbrirLookupTabDesconto - Tabela de Desconto (SigOpTdz.codigos/descrs).
5629:     *--------------------------------------------------------------------------
5630:     PROTECTED PROCEDURE AbrirLookupTabDesconto(par_oTxtTabd)
5631:         LOCAL loc_oBusca
5632: 
5633:         IF USED("cursor_4c_BuscaTabd")
5634:             USE IN cursor_4c_BuscaTabd
5635:         ENDIF
5636: 
5637:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigOpTdz", ;
5638:             "cursor_4c_BuscaTabd", "codigos", ALLTRIM(par_oTxtTabd.Value), "Tabelas de Desconto")
5639: 
5640:         IF VARTYPE(loc_oBusca) = "O"
5641:             IF !loc_oBusca.this_lAchouRegistro
5642:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
5643:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5644:                 loc_oBusca.Show()
5645:             ENDIF
5646:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
5647:                 SELECT cursor_4c_BuscaTabd
5648:                 par_oTxtTabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
5649:             ENDIF
5650:             loc_oBusca.Release()
5651:         ENDIF
5652: 
5653:         IF USED("cursor_4c_BuscaTabd")
5654:             USE IN cursor_4c_BuscaTabd
5655:         ENDIF
5656:     ENDPROC
5657: 
5658:     *--------------------------------------------------------------------------
5659:     * AbrirLookupListaPreco - Listas de Preco (SigCdLpc.lprecos).
5660:     *--------------------------------------------------------------------------
5661:     PROTECTED PROCEDURE AbrirLookupListaPreco(par_oTxtListaPreco)
5662:         LOCAL loc_oBusca
5663: 
5664:         IF USED("cursor_4c_BuscaListaPreco")
5665:             USE IN cursor_4c_BuscaListaPreco
5666:         ENDIF
5667: 
5668:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLpc", ;
5669:             "cursor_4c_BuscaListaPreco", "lprecos", ALLTRIM(par_oTxtListaPreco.Value), "Listas de Pre" + CHR(231) + "o")
5670: 
5671:         IF VARTYPE(loc_oBusca) = "O"
5672:             IF !loc_oBusca.this_lAchouRegistro
5673:                 loc_oBusca.mAddColuna("lprecos", "", "Lista")
5674:                 loc_oBusca.mAddColuna("tipos",   "", "Tipo")
5675:                 loc_oBusca.Show()
5676:             ENDIF
5677:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaListaPreco")
5678:                 SELECT cursor_4c_BuscaListaPreco
5679:                 par_oTxtListaPreco.Value = ALLTRIM(cursor_4c_BuscaListaPreco.lprecos)
5680:             ENDIF
5681:             loc_oBusca.Release()
5682:         ENDIF
5683: 
5684:         IF USED("cursor_4c_BuscaListaPreco")
5685:             USE IN cursor_4c_BuscaListaPreco
5686:         ENDIF
5687:     ENDPROC
5688: 
5689:     *--------------------------------------------------------------------------
5690:     * AbrirLookupFormaPagamento - Forma de Pagamento (SigOpFp.fpags/descrs).
5691:     *--------------------------------------------------------------------------
5692:     PROTECTED PROCEDURE AbrirLookupFormaPagamento(par_oTxtFpg)
5693:         LOCAL loc_oBusca
5694: 
5695:         IF USED("cursor_4c_BuscaFpg")
5696:             USE IN cursor_4c_BuscaFpg
5697:         ENDIF
5698: 
5699:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigOpFp", ;
5700:             "cursor_4c_BuscaFpg", "fpags", ALLTRIM(par_oTxtFpg.Value), "Forma de Pagamento")
5701: 
5702:         IF VARTYPE(loc_oBusca) = "O"
5703:             IF !loc_oBusca.this_lAchouRegistro
5704:                 loc_oBusca.mAddColuna("fpags",  "", "C" + CHR(243) + "digo")
5705:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5706:                 loc_oBusca.mAddColuna("fparcs", "", "Parc")
5707:                 loc_oBusca.Show()
5708:             ENDIF
5709:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
5710:                 SELECT cursor_4c_BuscaFpg
5711:                 par_oTxtFpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
5712:             ENDIF
5713:             loc_oBusca.Release()
5714:         ENDIF
5715: 
5716:         IF USED("cursor_4c_BuscaFpg")
5717:             USE IN cursor_4c_BuscaFpg
5718:         ENDIF
5719:     ENDPROC
5720: 
5721:     *==========================================================================
5722:     * FASE 7/8 - EVENTOS PRINCIPAIS
5723:     *
5724:     * Liga os Click/KeyPress dos 17 CommandButtons da barra principal (Fase
5725:     * 3), dos 4 botoes de acao das grades (Fase 4), dos paineis CancelaItem/
5726:     * Consulta (Fase 5) e das setas "Proximo" de cada tela (Fases 5-6).
5727:     *
5728:     * Limite de escopo (arquitetura ja fixada nas Fases 1-6): DataSession=2
5729:     * isola este form dos cursores globais do form de movimentacao pai
5730:     * (crSigCdOpe, CrSigOpCdc, TprMvCab) e das rotinas dele (AcioSalva,
5731:     * AcioCancela, Cancel_Item_Gen, AtuaTotal, VerStatus). Guardas do legado
5732:     * que dependem so de CURSORES/PROPRIEDADES LOCAIS (crTpmMvItn, TmpOperacao,
5733:     * TmpDevol, TmpBarFin, xPar, this_*) sao transcritos fielmente; os que
5734:     * dependem de fiscal/TEF/senha de supervisor (impressora ECF, SigOpSen,
5735:     * SigOpPen, SigMEFIS) nao tem como ser reproduzidos sem esse hardware/
5736:     * modulo - documentados caso a caso, nunca silenciados.
5737:     *
5738:     * PUBLIC (sem PROTECTED) todos os handlers de evento: BINDEVENT so
5739:     * funciona com metodos PUBLIC (CLAUDE.md #3).
5740:     *==========================================================================
5741: 
5742:     *--------------------------------------------------------------------------
5743:     * RegistrarEventosPrincipais - liga (BINDEVENT) todos os botoes/campos
5744:     * desta fase. Chamado uma unica vez a partir de InicializarForm, depois
5745:     * que TODOS os controles ja foram criados (Fases 3-6) - registrar contra
5746:     * um controle inexistente estoura aqui dentro do TRY do InicializarForm.
5747:     *--------------------------------------------------------------------------
5748:     PROTECTED PROCEDURE RegistrarEventosPrincipais()
5749:         LOCAL loc_oCnt
5750: 
5751:         *-- Barra de botoes principal.
5752:         loc_oCnt = THIS.cnt_4c_Barra_Botoes
5753:         BINDEVENT(loc_oCnt.cmd_4c_Itens,      "Click", THIS, "CmdItensClick")
5754:         BINDEVENT(loc_oCnt.cmd_4c_Alteraqtd,  "Click", THIS, "CmdAlteraqtdClick")
5755:         BINDEVENT(loc_oCnt.cmd_4c_Desconto,   "Click", THIS, "CmdDescontoClick")
5756:         BINDEVENT(loc_oCnt.cmd_4c_Acrescimo,  "Click", THIS, "CmdAcrescimoClick")
5757:         BINDEVENT(loc_oCnt.cmd_4c_CancPagto,  "Click", THIS, "CmdCancPagtoClick")
5758:         BINDEVENT(loc_oCnt.cmd_4c_Apaga,      "Click", THIS, "CmdApagaClick")
5759:         BINDEVENT(loc_oCnt.cmd_4c_AltPreco,   "Click", THIS, "CmdAltPrecoClick")
5760:         BINDEVENT(loc_oCnt.cmd_4c_Identifica, "Click", THIS, "CmdIdentificaClick")
5761:         BINDEVENT(loc_oCnt.cmd_4c_Credito,    "Click", THIS, "CmdCreditoClick")
5762:         BINDEVENT(loc_oCnt.cmd_4c_Financia,   "Click", THIS, "CmdFinanciaClick")
5763:         BINDEVENT(loc_oCnt.cmd_4c_Pendencia,  "Click", THIS, "CmdPendenciaClick")
5764:         BINDEVENT(loc_oCnt.cmd_4c_VerPreco,   "Click", THIS, "CmdVerPrecoClick")
5765:         BINDEVENT(loc_oCnt.cmd_4c_Impfiscal,  "Click", THIS, "CmdImpfiscalClick")
5766:         BINDEVENT(loc_oCnt.cmd_4c_MudaOpe,    "Click", THIS, "CmdMudaOpeClick")
5767:         BINDEVENT(loc_oCnt.cmd_4c_Pagto,      "Click", THIS, "CmdPagtoClick")
5768:         BINDEVENT(loc_oCnt.cmd_4c_Ok,         "Click", THIS, "BtnConfirmarClick")
5769:         BINDEVENT(loc_oCnt.cmd_4c_Cancela,    "Click", THIS, "BtnCancelarClick")
5770: 
5771:         *-- Grade de codigos de barras do crediario (CntFinanc).
5772:         loc_oCnt = THIS.cnt_4c_Financ.cnt_4c__GrdBarra
5773:         BINDEVENT(loc_oCnt.cmd_4c_Inserir, "Click", THIS, "CmdInserirBarraClick")
5774:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "CmdExcluirBarraClick")
5775:         BINDEVENT(loc_oCnt.cmd_4c_OkBarra, "Click", THIS, "CmdOkBarraClick")
5776: 
5777:         *-- Sub-niveis/pendencias.
5778:         BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_BotPendentes, "Click", THIS, "CmdBotPendentesClick")
5779: 
5780:         *-- Painel de cancelamento de item.
5781:         BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_Ok,          "Click", THIS, "CancelaItemOkClick")
5782:         BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_CancelaDisp, "Click", THIS, "CancelaItemCancelaDispClick")
5783: 
5784:         *-- Painel de consulta de preco.
5785:         BINDEVENT(THIS.cnt_4c__Consulta.cmd_4c_Command1, "Click", THIS, "ConsultaCommand1Click")
5786:         BINDEVENT(THIS.cnt_4c__Consulta.cmd_4c_Proximo,  "Click", THIS, "ConsultaProximoClick")
5787:         BINDEVENT(THIS.cnt_4c__Consulta.cnt_4c__Produto.txt_4c_Produto, "KeyPress", THIS, "ConsultaProdutoKeyPress")
5788: 
5789:         *-- Setas "Proximo" de cada tela.
5790:         BINDEVENT(THIS.cnt_4c_Item.cmd_4c_Proximo,        "Click", THIS, "ItemProximoClick")
5791:         BINDEVENT(THIS.cnt_4c_Financ.cmd_4c_Proximo,      "Click", THIS, "FinancProximoClick")
5792:         BINDEVENT(THIS.cnt_4c__Credito.cmd_4c_Proximo,    "Click", THIS, "CreditoProximoClick")
5793:         BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_Proximo,  "Click", THIS, "PendenciaProximoClick")
5794:         BINDEVENT(THIS.cnt_4c__Identifica.cmd_4c_Proximo, "Click", THIS, "IdentificaProximoClick")
5795:         BINDEVENT(THIS.cnt_4c__Fpagto.cmd_4c_Proximo,     "Click", THIS, "FpagtoProximoClick")
5796: 
5797:         *-- Confirmacao manual do item (CntItem.Cnt_Produto.CmdEnviaProd) - so
5798:         *-- fica visivel quando o legado exige confirmar o preco alterado.
5799:         BINDEVENT(THIS.cnt_4c_Item.cnt_4c__Produto.cmd_4c_CmdEnviaProd, "Click", THIS, "CmdEnviaProdClick")
5800: 
5801:         *-- Atalho para o Cadastro de Contas a partir dos blocos Origem/Destino
5802:         *-- (btnCadastros de cada um).
5803:         BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_Destino.cmd_4c_BtnCadastros, "Click", THIS, "BtnCadastrosDestinoClick")
5804:         BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_Origem.cmd_4c_BtnCadastros,  "Click", THIS, "BtnCadastrosOrigemClick")
5805: 
5806:         *-- Conferencia de cheque pre-datado (Cnt_ChequepreTef.Cnt_Chq).
5807:         loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
5808:         BINDEVENT(loc_oCnt.cmd_4c_TefChq, "Click", THIS, "CmdTefChqClick")
5809:         BINDEVENT(loc_oCnt.cmd_4c_Ins,    "Click", THIS, "CmdInsChequeClick")
5810: 
5811:         *-- Combo de troca de operacao (Ctrl+F11).
5812:         BINDEVENT(THIS.cbo_4c_CmbTOpers, "KeyPress",  THIS, "CmbTOpersKeyPress")
5813:         BINDEVENT(THIS.cbo_4c_CmbTOpers, "KeyPress", THIS, "CmbTOpersLostFocus")
5814:     ENDPROC
5815: 
5816:     *--------------------------------------------------------------------------
5817:     * AlternarTelaOperacao - mostra EXATAMENTE um dos seis containers de
5818:     * operacao e esconde os outros cinco. No legado cada Click de
5819:     * identifica/credito/pendencia/Financia/Itens comeca zerando a
5820:     * visibilidade dos irmaos antes de mostrar o proprio (ex.: identifica.Click
5821:     * "ThisForm.CntFinanc.Visible=.f. / ThisForm.CntItem.Visible=.f. /
5822:     * ThisForm.Cnt_Credito.Visible=.f. / Thisform.Cnt_pendencia.Visible=.f. /
5823:     * ThisForm.Cnt_fpagto.Visible=.f."). Sem este metodo os seis nasciam todos
5824:     * Visible=.T. (ConfigurarContainersOperacao, Fase 4) empilhados na mesma
5825:     * area (Top=124 Left=32) - bug corrigido aqui.
5826:     * CancelaItem e um painel modal-like a parte (fica por cima da tela
5827:     * ativa) - trocar de tela fecha ele tambem, igual ao CancelaDisp legado.
5828:     *--------------------------------------------------------------------------
5829:     PROTECTED PROCEDURE AlternarTelaOperacao(par_cTela)
5830:         LOCAL loc_cTela
5831:         loc_cTela = UPPER(ALLTRIM(par_cTela))
5832: 
5833:         THIS.cnt_4c_Item.Visible        = (loc_cTela == "ITENS")
5834:         THIS.cnt_4c_Financ.Visible      = (loc_cTela == "FINANC")
5835:         THIS.cnt_4c__Credito.Visible    = (loc_cTela == "CREDITO")
5836:         THIS.cnt_4c__Pendencia.Visible  = (loc_cTela == "PENDENCIA")
5837:         THIS.cnt_4c__Identifica.Visible = (loc_cTela == "IDENTIFICA")
5838:         THIS.cnt_4c__Fpagto.Visible     = (loc_cTela == "FPAGTO")
5839: 
5840:         IF loc_cTela != "ITENS"
5841:             THIS.cnt_4c_CancelaItem.Visible = .F.
5842:             THIS.cnt_4c_Item.Enabled        = .T.
5843:         ENDIF
5844: 
5845:         *-- Quem desabilita botao tem de reabilitar no FUNIL de volta: toda
5846:         *-- troca de tela passa por aqui, entao o gate dos botoes e reaplicado
5847:         *-- aqui e nao em cada Click (CLAUDE.md #40).
5848:         THIS.AjustarBotoesPorModo()
5849:     ENDPROC
5850: 
5851:     *--------------------------------------------------------------------------
5852:     * FocarControle - SetFocus protegido. Falha de SetFocus aqui e sempre um
5853:     * problema de TIMING (controle ainda na tela que acabou de ficar
5854:     * invisivel no mesmo ciclo de evento) - nunca perda de dado. Mesmo
5855:     * criterio ja usado no CATCH silencioso do Destroy() deste form (comentado
5856:     * la: "o Destroy nao pode falhar aqui, senao o menu principal nao e
5857:     * reconstruido"): aqui, mostrar MsgErro por causa de foco de teclado
5858:     * seria pior do que nao mostrar nada.
5859:     *--------------------------------------------------------------------------
5860:     PROTECTED PROCEDURE FocarControle(par_oControle)
5861:         LOCAL loc_oErro
5862:         TRY
5863:             IF VARTYPE(par_oControle) = "O" AND par_oControle.Visible AND par_oControle.Enabled
5864:                 par_oControle.SetFocus
5865:             ENDIF
5866:         CATCH TO loc_oErro
5867:             * silencioso de proposito - ver comentario do metodo.
5868:         ENDTRY
5869:     ENDPROC
5870: 
5871:     *--------------------------------------------------------------------------
5872:     * HaPagamentoPend - .T. quando ha alguma forma de pagamento lancada em
5873:     * xPar que ainda nao foi inserida (Valos>0, FPags preenchido, !InsChs).
5874:     * Mesma condicao do legado em credito/pendencia/Financia.Click ("Count to
5875:     * wxpar for Valos > 0 and not Empty(fpags) And Not xPar.InsChs / If wxpar
5876:     * > 0 / MessageBox('Favor Excluir as Condicoes de Pagamento!!!')").
5877:     *--------------------------------------------------------------------------
5878:     PROTECTED FUNCTION HaPagamentoPendente()
5879:         LOCAL loc_nQt, loc_nAreaAnt
5880:         loc_nQt = 0
5881: 
5882:         IF USED("xPar")
5883:             loc_nAreaAnt = SELECT()
5884:             SELECT xPar
5885:             COUNT FOR Valos > 0 AND !EMPTY(FPags) AND !InsChs TO loc_nQt
5886:             IF loc_nAreaAnt > 0
5887:                 SELECT (loc_nAreaAnt)
5888:             ENDIF
5889:         ENDIF
5890: 
5891:         RETURN (loc_nQt > 0)
5892:     ENDFUNC
5893: 
5894:     *--------------------------------------------------------------------------
5895:     * RecalcularTotalCarrinho - soma crTpmMvItn.totas e atualiza o TOTAL da
5896:     * tela de Itens + a propriedade this_nTotal. Chamado sempre que um item e
5897:     * removido do carrinho localmente (CancelaItemOkClick).
5898:     *--------------------------------------------------------------------------
5899:     PROTECTED PROCEDURE RecalcularTotalCarrinho()
5900:         LOCAL loc_nTotal, loc_nAreaAnt
5901:         loc_nTotal = 0
5902: 
5903:         IF USED("crTpmMvItn")
5904:             loc_nAreaAnt = SELECT()
5905:             SELECT crTpmMvItn
5906:             SUM totas TO loc_nTotal
5907:             IF loc_nAreaAnt > 0
5908:                 SELECT (loc_nAreaAnt)
5909:             ENDIF
5910:         ENDIF
5911: 
5912:         THIS.this_nTotal = loc_nTotal
5913:         THIS.cnt_4c_Item.txt_4c_Total.Value = loc_nTotal
5914:     ENDPROC
5915: 
5916:     *--------------------------------------------------------------------------
5917:     * CancelaItemFechar - fecha o painel de cancelamento e devolve o controle
5918:     * a tela de Itens. Compartilhado por CancelaItemOkClick (apos processar) e
5919:     * CancelaItemCancelaDispClick.
5920:     *--------------------------------------------------------------------------
5921:     PROTECTED PROCEDURE CancelaItemFechar()
5922:         THIS.cnt_4c_CancelaItem.Visible = .F.
5923:         THIS.cnt_4c_Item.Enabled        = .T.
5924:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
5925:     ENDPROC
5926: 
5927:     *==========================================================================
5928:     * HANDLERS - BARRA DE BOTOES PRINCIPAL
5929:     *==========================================================================
5930: 
5931:     *-- [F2] Itens - volta para a tela de lancamento de itens.
5932:     PROCEDURE CmdItensClick()
5933:         THIS.AlternarTelaOperacao("ITENS")
5934:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
5935:     ENDPROC
5936: 
5937:     *-- [F3] Alteraqtd - legado: "If Empty(Get_produto.Value) / lAlteraqtd=.t.
5938:     *-- / focus Get_qtds / Else / focus Get_Produto".
5939:     PROCEDURE CmdAlteraqtdClick()
5940:         LOCAL loc_oProd
5941:         loc_oProd = THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto
5942: 
5943:         IF EMPTY(loc_oProd.Value)
5944:             THIS.this_lLalteraqtd = .T.
5945:             THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Qtds)
5946:         ELSE
5947:             THIS.FocarControle(loc_oProd)
5948:         ENDIF
5949:     ENDPROC
5950: 
5951:     *-- [F3] Desconto - alterna o desconto de venda (Cnt_Fpagto.Desconto),
5952:     *-- espelhando a guarda do irmao Acrescimo (so um dos dois fica aberto).
5953:     PROCEDURE CmdDescontoClick()
5954:         IF THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.Visible
5955:             RETURN
5956:         ENDIF
5957: 
5958:         THIS.this_lValidadesconto = .T.
5959:         WITH THIS.cnt_4c__Fpagto
5960:             .cnt_4c_Desconto.Visible   = .T.
5961:             .cnt_4c_Desconto.Enabled   = .T.
5962:             .txt_4c_TotLiquido.Visible = .T.
5963:             .lbl_4c_Label15.Visible    = .T.
5964:         ENDWITH
5965: 
5966:         THIS.AlternarTelaOperacao("FPAGTO")
5967:         THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_PorcVariacao)
5968:     ENDPROC
5969: 
5970:     *-- [Ctrl+F3] Acrescimo - legado (Barra_Botoes.Acrescimo.Click, 24
5971:     *-- linhas): bloqueia se ja houver desconto informado ou o painel de
5972:     *-- desconto estiver aberto; senao mostra o painel de acrescimo.
5973:     PROCEDURE CmdAcrescimoClick()
5974:         LOCAL loc_lOk
5975:         loc_lOk = .T.
5976: 
5977:         IF THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_TotVariacao.Value > 0
5978:             MsgAviso("Desconto Informado. N" + CHR(227) + "o pode haver Acr" + CHR(233) + "scimo!!!", ;
5979:                 "Aten" + CHR(231) + CHR(227) + "o")
5980:             loc_lOk = .F.
5981:         ENDIF
5982: 
5983:         IF THIS.cnt_4c__Fpagto.cnt_4c_Desconto.Visible
5984:             loc_lOk = .F.
5985:         ENDIF
5986: 
5987:         IF loc_lOk
5988:             THIS.this_lValidadesconto = .T.
5989:             WITH THIS.cnt_4c__Fpagto
5990:                 .cnt_4c_Acrescimo.Visible  = .T.
5991:                 .cnt_4c_Acrescimo.Enabled  = .T.
5992:                 .txt_4c_TotLiquido.Visible = .T.
5993:                 .lbl_4c_Label15.Visible    = .T.
5994:             ENDWITH
5995: 
5996:             THIS.AlternarTelaOperacao("FPAGTO")
5997:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.txt_4c_PorcVariacao)
5998:         ENDIF
5999:     ENDPROC
6000: 
6001:     *-- [F4] CancPagto - cancela a ULTIMA forma de pagamento lancada (xPar).
6002:     *-- A baixa em gateway TEF (DeleteSigTef, do legado) nao tem equivalente
6003:     *-- nesta migracao - so a parcela local (e as demais da mesma "chave" de
6004:     *-- lancamento, nChaves) e removida.
6005:     PROCEDURE CmdCancPagtoClick()
6006:         LOCAL loc_nChave
6007: 
6008:         IF !USED("xPar")
6009:             RETURN
6010:         ENDIF
6011: 
6012:         SELECT xPar
6013:         GO BOTTOM
6014:         IF EOF()
6015:             RETURN
6016:         ENDIF
6017: 
6018:         loc_nChave = xPar.nChaves
6019:         DELETE FOR nChaves == loc_nChave
6020: 
6021:         THIS.AtualizarGrades()
6022:         THIS.FocarControle(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
6023:     ENDPROC
6024: 
6025:     *-- [F4] Apaga - abre o painel de cancelamento com os dados do ULTIMO
6026:     *-- item lancado. Legado (Barra_Botoes.apaga.Click): guarda "Not
6027:     *-- Empty(Get_Produto.Value) Return" + "Get_item.Value = Citem-1" +
6028:     *-- "Locate For citens = Get_item.Value" + preenche Produto/Descricao/
6029:     *-- Barra do painel.
6030:     PROCEDURE CmdApagaClick()
6031:         LOCAL loc_nItem
6032: 
6033:         IF !EMPTY(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Value)
6034:             RETURN
6035:         ENDIF
6036: 
6037:         IF !USED("crTpmMvItn")
6038:             RETURN
6039:         ENDIF
6040: 
6041:         SELECT crTpmMvItn
6042:         LOCATE
6043:         IF EOF()
6044:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " item lan" + CHR(231) + "ado para cancelar.", "Cancelar Item")
6045:             RETURN
6046:         ENDIF
6047: 
6048:         loc_nItem = THIS.this_nCitem - 1
6049: 
6050:         LOCATE FOR citens == loc_nItem
6051:         IF EOF()
6052:             GO BOTTOM
6053:             loc_nItem = NVL(crTpmMvItn.citens, 0)
6054:         ENDIF
6055: 
6056:         WITH THIS.cnt_4c_CancelaItem
6057:             .txt_4c_Item.Value    = loc_nItem
6058:             .txt_4c_Produto.Value = NVL(crTpmMvItn.cpros, "")
6059:             .txt_4c__dpro.Value   = NVL(crTpmMvItn.dpros, "")
6060:             .txt_4c_Cbarra.Value  = NVL(crTpmMvItn.codbarras, 0)
6061:             .Visible              = .T.
6062:             .ZOrder(0)
6063:         ENDWITH
6064: 
6065:         THIS.cnt_4c_Item.Enabled = .F.
6066:         THIS.FocarControle(THIS.cnt_4c_CancelaItem.txt_4c_Item)
6067:     ENDPROC
6068: 
6069:     *-- [F5] AltPreco - legado: "If Not IsEmpty(crTpmMvItn.CPros) /
6070:     *-- lAlteraValor=.t. / zera ValDesc/PValDesc / focus Get_Valor". O
6071:     *-- lancamento linha-a-linha do carrinho (Get_Produto/Get_Qtds) fica para
6072:     *-- a fase de eventos de campo - aqui a mesma condicao e checada pelo
6073:     *-- campo Produto da tela.
6074:     PROCEDURE CmdAltPrecoClick()
6075:         IF EMPTY(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Value)
6076:             RETURN
6077:         ENDIF
6078: 
6079:         THIS.this_lLalteravalor = .T.
6080:         WITH THIS.cnt_4c_Item.cnt_4c__Desconto
6081:             .txt_4c_Valdesc.Value  = 0
6082:             .txt_4c_Pvaldesc.Value = 0
6083:             .Visible     = .T.
6084:         ENDWITH
6085: 
6086:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Subtotal.txt_4c_Valor)
6087:     ENDPROC
6088: 
6089:     *-- [F6] Identifica - legado: guarda "Not Empty(Get_fpg.Value) Return 0"
6090:     *-- (nao sai de uma forma de pagamento em andamento) + troca de tela. A
6091:     *-- leitura de CrSigCdOpe.AcioSens (senha de acionamento) fica fora de
6092:     *-- alcance com DataSession=2.
6093:     PROCEDURE CmdIdentificaClick()
6094:         IF !EMPTY(THIS.cnt_4c__Fpagto.txt_4c_Fpg.Value)
6095:             RETURN
6096:         ENDIF
6097: 
6098:         THIS.AlternarTelaOperacao("IDENTIFICA")
6099:         THIS.FocarControle(THIS.cnt_4c__Identifica.cnt_4c_Destino.txt_4c_Grupo)
6100:     ENDPROC
6101: 
6102:     *-- [F7] Credito - mesma guarda de pagamento em aberto (HaPagamentoPend()).
6103:     PROCEDURE CmdCreditoClick()
6104:         IF THIS.HaPagamentoPendente()
6105:             MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", "Cr" + CHR(233) + "dito")
6106:             RETURN
6107:         ENDIF
6108: 
6109:         THIS.AlternarTelaOperacao("CREDITO")
6110:         THIS.FocarControle(THIS.cnt_4c__Credito.grd_4c_Devolucao)
6111:     ENDPROC
6112: 
6113:     *-- [F8] Financia - crediario/codigos de barras. Visible=.F. por padrao no
6114:     *-- dump legado (recurso desligado), mas o evento e ligado do mesmo jeito.
6115:     PROCEDURE CmdFinanciaClick()
6116:         IF THIS.HaPagamentoPendente()
6117:             MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", "Financiamento")
6118:             RETURN
6119:         ENDIF
6120: 
6121:         THIS.AlternarTelaOperacao("FINANC")
6122:         THIS.FocarControle(THIS.cnt_4c_Financ.cnt_4c__Barras.txt_4c_Barra_1)
6123:     ENDPROC
6124: 
6125:     *-- [F8] Pendencia - sub-niveis/pendencias.
6126:     PROCEDURE CmdPendenciaClick()
6127:         IF THIS.HaPagamentoPendente()
6128:             MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", "Pend" + CHR(234) + "ncia")
6129:             RETURN
6130:         ENDIF
6131: 
6132:         THIS.AlternarTelaOperacao("PENDENCIA")
6133:         THIS.FocarControle(THIS.cnt_4c__Pendencia.grd_4c_SubNiveis)
6134:     ENDPROC
6135: 
6136:     *-- <Ctrl+P> VerPreco - overlay de consulta de preco (nao esconde os
6137:     *-- outros paineis - fica POR CIMA, como no legado). Legado
6138:     *-- (Barra_Botoes.VerPreco.Click, 18 linhas): abre se ainda fechado, limpa
6139:     *-- o campo de produto e o resultado anterior.
6140:     PROCEDURE CmdVerPrecoClick()
6141:         WITH THIS.cnt_4c__Consulta
6142:             IF !.Visible
6143:                 .Visible = .T.
6144:                 .ZOrder(0)
6145:             ENDIF
6146:             .cnt_4c__Produto.txt_4c_Produto.Value       = ""
6147:             .cnt_4c__Resultado.lbl_4c_Mensage1.Caption  = ""
6148:             .cnt_4c__Resultado.lbl_4c_Mensage2.Caption  = ""
6149:             .txt_4c_Unit.Value                          = 0
6150:         ENDWITH
6151: 
6152:         THIS.FocarControle(THIS.cnt_4c__Consulta.cnt_4c__Produto.txt_4c_Produto)
6153:     ENDPROC
6154: 
6155:     *-- [F9] Impfiscal - legado abre SIGMEFIS, monitor de status da
6156:     *-- impressora fiscal (ECF). Sem driver ECF fisico disponivel nesta
6157:     *-- migracao nao ha tela equivalente para abrir - decisao de escopo
6158:     *-- documentada, nao pendencia.
6159:     PROCEDURE CmdImpfiscalClick()
6160:         MsgAviso("O monitor de status da impressora fiscal depende do driver " + ;
6161:             "ECF f" + CHR(237) + "sico do caixa, fora do escopo desta migra" + CHR(231) + CHR(227) + "o.", ;
6162:             "Impressora Fiscal")
6163:     ENDPROC
6164: 
6165:     *-- [Ctrl+F11] MudaOpe - legado (34 linhas): tres guardas locais
6166:     *-- (pagamento/sub-nivel/credito ja lancados bloqueiam a troca) + popula
6167:     *-- cmbTOpers com as operacoes cadastradas. A quarta guarda do legado
6168:     *-- (ThisForm.ParentForm.AbriuCupom) fica fora de alcance com
6169:     *-- DataSession=2. A reconfiguracao completa do Caixa para a nova operacao
6170:     *-- (AciomudaOpe) e responsabilidade da tela de movimentacao.
6171:     PROCEDURE CmdMudaOpeClick()
6172:         LOCAL loc_nQt, loc_oErro
6173: 
6174:         IF USED("xPar")
6175:             SELECT xPar
6176:             COUNT FOR Valos > 0 AND !EMPTY(FPags) TO loc_nQt
6177:             IF loc_nQt > 0
6178:                 MsgAviso("Condi" + CHR(231) + CHR(245) + "es de Pagamento j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
6179:                     "Muda Opera" + CHR(231) + CHR(227) + "o")
6180:                 RETURN
6181:             ENDIF
6182:         ENDIF
6183: 
6184:         IF USED("TmpOperacao")
6185:             SELECT TmpOperacao
6186:             COUNT FOR Codigos > 0 TO loc_nQt
6187:             IF loc_nQt > 0
6188:                 MsgAviso("Opera" + CHR(231) + CHR(245) + "es de SubN" + CHR(237) + "veis j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
6189:                     "Muda Opera" + CHR(231) + CHR(227) + "o")
6190:                 RETURN
6191:             ENDIF
6192:         ENDIF
6193: 
6194:         IF USED("TmpDevol")
6195:             SELECT TmpDevol
6196:             COUNT FOR Codigos > 0 TO loc_nQt
6197:             IF loc_nQt > 0
6198:                 MsgAviso("Opera" + CHR(231) + CHR(245) + "es de Cr" + CHR(233) + "dito j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
6199:                     "Muda Opera" + CHR(231) + CHR(227) + "o")
6200:                 RETURN
6201:             ENDIF
6202:         ENDIF
6203: 
6204:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
6205:             RETURN
6206:         ENDIF
6207: 
6208:         TRY
6209:             IF USED("cursor_4c_ListaOpe")
6210:                 USE IN cursor_4c_ListaOpe
6211:             ENDIF
6212: 
6213:             IF SQLEXEC(gnConnHandle, "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", "cursor_4c_ListaOpe") > 0 ;
6214:                     AND USED("cursor_4c_ListaOpe") AND RECCOUNT("cursor_4c_ListaOpe") > 0
6215: 
6216:                 THIS.cbo_4c_CmbTOpers.RowSourceType = 0
6217:                 THIS.cbo_4c_CmbTOpers.Clear()
6218: 
6219:                 SELECT cursor_4c_ListaOpe
6220:                 SCAN
6221:                     THIS.cbo_4c_CmbTOpers.AddItem(ALLTRIM(cursor_4c_ListaOpe.Dopes))
6222:                 ENDSCAN
6223: 
6224:                 THIS.cbo_4c_CmbTOpers.Visible = .T.
6225:                 THIS.FocarControle(THIS.cbo_4c_CmbTOpers)
6226:             ENDIF
6227: 
6228:             IF USED("cursor_4c_ListaOpe")
6229:                 USE IN cursor_4c_ListaOpe
6230:             ENDIF
6231:         CATCH TO loc_oErro
6232:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
6233:                 "Erro em Muda Opera" + CHR(231) + CHR(227) + "o")
6234:         ENDTRY
6235:     ENDPROC
6236: 
6237:     *-- [F11] Pagto - avanca para a tela de formas de pagamento, exigindo
6238:     *-- pelo menos um item lancado (guia minima do metodo legado de 425
6239:     *-- linhas - o restante e abertura/fechamento de cupom fiscal, fora de
6240:     *-- alcance sem o driver ECF).
6241:     PROCEDURE CmdPagtoClick()
6242:         IF !USED("crTpmMvItn")
6243:             RETURN
6244:         ENDIF
6245: 
6246:         SELECT crTpmMvItn
6247:         LOCATE
6248:         IF EOF()
6249:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens lan" + CHR(231) + "ados para pagamento.", "Pagamento")
6250:             RETURN
6251:         ENDIF
6252: 
6253:         THIS.AlternarTelaOperacao("FPAGTO")
6254:         THIS.FocarControle(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
6255:     ENDPROC
6256: 
6257:     *-- Confirmar (cmd_4c_Ok) - legado (Barra_Botoes.ok.Click, 25 linhas):
6258:     *-- valida sub-nivel/pagamento e chama AcioSalva() no ParentForm, que
6259:     *-- gravava o cursor de itens inteiro com TableUpdate na datasession
6260:     *-- COMPARTILHADA e fechava o cupom fiscal.
6261:     *--
6262:     *-- Aqui: sem item lancado, so fecha o Caixa; havendo itens, exige forma de
6263:     *-- pagamento informada e GRAVA os itens em SigMvItn pelo BO antes de
6264:     *-- devolver o controle a tela de movimentacao. A gravacao acontece NESTE
6265:     *-- form porque DataSession = 2 isola o carrinho (crTpmMvItn) do form pai -
6266:     *-- sem ela os itens morreriam na memoria ao fechar a tela e o Confirmar
6267:     *-- anunciaria "venda validada" sem nada no banco.
6268:     *--
6269:     *-- A finalizacao FISCAL (emissao do cupom / TEF) continua sendo do form
6270:     *-- pai: depende da impressora fiscal, que esta fora de alcance daqui.
6271:     PROCEDURE BtnConfirmarClick()
6272:         LOCAL loc_nItens, loc_lTemPagamento
6273: 
6274:         *-- Conta so as linhas com produto: o carrinho mantem uma linha em
6275:         *-- branco aberta para o proximo item (LimparCntItem), que NAO conta
6276:         *-- como venda.
6277:         loc_nItens = 0
6278:         IF USED("crTpmMvItn")
6279:             SELECT crTpmMvItn
6280:             COUNT FOR !EMPTY(NVL(cpros, "")) AND !DELETED() TO loc_nItens
6281:         ENDIF
6282: 
6283:         IF loc_nItens = 0
6284:             THIS.Release()
6285:             RETURN
6286:         ENDIF
6287: 
6288:         loc_lTemPagamento = .F.
6289:         IF USED("xPar")
6290:             SELECT xPar
6291:             LOCATE FOR !EMPTY(FPags)
6292:             loc_lTemPagamento = !EOF()
6293:         ENDIF
6294: 
6295:         IF !loc_lTemPagamento
6296:             MsgAviso("Informe a forma de pagamento antes de confirmar a venda.", "Confirmar")
6297:             THIS.CmdPagtoClick()
6298:             RETURN
6299:         ENDIF
6300: 
6301:         *-- Grava os itens. Falhando, NAO fecha a tela e NAO anuncia sucesso -
6302:         *-- o caixa continua com o carrinho na tela para corrigir e repetir.
6303:         *-- BusinessBase.Salvar() ja exibiu o motivo (CLAUDE.md #20).
6304:         IF !THIS.GravarItensLancados()
6305:             RETURN
6306:         ENDIF
6307: 
6308:         MsgInfo("Venda gravada com sucesso." + CHR(13) + ;
6309:             "A finaliza" + CHR(231) + CHR(227) + "o fiscal prossegue na tela de " + ;
6310:             "movimenta" + CHR(231) + CHR(227) + "o.", "Confirmar")
6311:         THIS.Release()
6312:     ENDPROC
6313: 
6314:     *-- Cancelar (cmd_4c_Cancela, ESC) - encerra o Caixa e devolve o controle
6315:     *-- ao form pai (Destroy() ja reabilita this_oParentForm).
6316:     PROCEDURE BtnCancelarClick()
6317:         IF MsgConfirma("Deseja realmente cancelar e encerrar o Caixa?", "Cancelar")
6318:             THIS.Release()
6319:         ENDIF
6320:     ENDPROC
6321: 
6322:     *==========================================================================
6323:     * HANDLERS - GRADES (CntFinanc.Cnt_GrdBarra / Cnt_Pendencia)
6324:     *==========================================================================
6325: 
6326:     *-- F2-Selec - legado: "Grade.Column1.SetFocus".
6327:     PROCEDURE CmdInserirBarraClick()
6328:         THIS.FocarControle(THIS.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras.Column1)
6329:     ENDPROC
6330: 
6331:     *-- F5-Barra - legado: "Cnt_Barras.Get_Barra_1.SetFocus()".
6332:     PROCEDURE CmdOkBarraClick()
6333:         THIS.FocarControle(THIS.cnt_4c_Financ.cnt_4c__Barras.txt_4c_Barra_1)
6334:     ENDPROC
6335: 
6336:     *-- F4-Excluir - legado: "Select TmpBarFin / Delete / Go Top /
6337:     *-- ThisForm.parentForm.Atuatot() / Get_total.Refresh() / Grade.Refresh()".
6338:     *-- Atuatot() do form pai fica fora de alcance (DataSession=2) - o total
6339:     *-- do carne e recalculado aqui, localmente, a partir do proprio
6340:     *-- TmpBarFin.
6341:     PROCEDURE CmdExcluirBarraClick()
6342:         LOCAL loc_nTotal
6343:         loc_nTotal = 0
6344: 
6345:         IF !USED("TmpBarFin")
6346:             RETURN
6347:         ENDIF
6348: 
6349:         SELECT TmpBarFin
6350:         DELETE
6351:         GO TOP
6352: 
6353:         SUM ValPs TO loc_nTotal
6354:         THIS.cnt_4c_Financ.txt_4c_Total.Value = loc_nTotal
6355: 
6356:         THIS.AtualizarGrades()
6357:     ENDPROC
6358: 
6359:     *-- [F3]Pend. - legado abre SigOpPen (tela de selecao de pendencias do
6360:     *-- cliente), sem equivalente migrado. A limpeza local de linhas com
6361:     *-- codigo zerado (Delete For Codigos = 0) e feita mesmo assim.
6362:     PROCEDURE CmdBotPendentesClick()
6363:         IF !USED("TmpOperacao")
6364:             RETURN
6365:         ENDIF
6366: 
6367:         SELECT TmpOperacao
6368:         DELETE FOR Codigos = 0
6369:         GO TOP
6370: 
6371:         THIS.AtualizarGrades()
6372:     ENDPROC
6373: 
6374:     *==========================================================================
6375:     * HANDLERS - PAINEL DE CANCELAMENTO DE ITEM (CancelaItem)
6376:     *==========================================================================
6377: 
6378:     *-- CancelaDisp - legado (6 linhas): reabilita CntItem e fecha o painel
6379:     *-- SEM cancelar nada.
6380:     PROCEDURE CancelaItemCancelaDispClick()
6381:         *-- Legado (CancelaDisp.Click): "Select crTpmMvItn / Set Order To".
6382:         *-- SET ORDER TO exige a ORDEM antes do IN (SET ORDER TO 0 IN <alias>);
6383:         *-- "SET ORDER TO IN <alias>" nao compila.
6384:         IF USED("crTpmMvItn")
6385:             SELECT crTpmMvItn
6386:             SET ORDER TO
6387:         ENDIF
6388:         THIS.CancelaItemFechar()
6389:     ENDPROC
6390: 
6391:     *-- Ok (confirmar cancelamento) - o legado abre "Do Form SigOpSen With
6392:     *-- 'CANCITEM',..." (senha de supervisor) antes de cancelar; sem
6393:     *-- equivalente migrado, MsgConfirma() faz o papel do gate de
6394:     *-- confirmacao. Remove o item de crTpmMvItn/crTpmMvItnC (local - a
6395:     *-- exclusao definitiva em SigMvItn e responsabilidade da fase de
6396:     *-- persistencia dos itens, ainda nao lancada nesta tela) e recalcula o
6397:     *-- total.
6398:     PROCEDURE CancelaItemOkClick()
6399:         LOCAL loc_nItem
6400:         loc_nItem = THIS.cnt_4c_CancelaItem.txt_4c_Item.Value
6401: 
6402:         IF loc_nItem <= 0 OR !USED("crTpmMvItn")
6403:             THIS.CancelaItemFechar()
6404:             RETURN
6405:         ENDIF
6406: 
6407:         IF MsgConfirma("Confirma o cancelamento do item " + TRANSFORM(loc_nItem) + "?", "Cancelamento de Item")
6408:             SELECT crTpmMvItn
6409:             DELETE FOR citens == loc_nItem
6410: 
6411:             IF USED("crTpmMvItnC")
6412:                 SELECT crTpmMvItnC
6413:                 DELETE FOR cItens == loc_nItem
6414:             ENDIF
6415: 
6416:             SELECT crTpmMvItn
6417:             GO TOP
6418:             IF EOF()
6419:                 THIS.this_nCitem = 0
6420:             ELSE
6421:                 GO BOTTOM
6422:                 THIS.this_nCitem = NVL(crTpmMvItn.citens, 0)
6423:             ENDIF
6424: 
6425:             THIS.RecalcularTotalCarrinho()
6426:             THIS.AtualizarGrades()
6427:         ENDIF
6428: 
6429:         THIS.CancelaItemFechar()
6430:     ENDPROC
6431: 
6432:     *==========================================================================
6433:     * HANDLERS - PAINEL DE CONSULTA DE PRECO (Cnt_Consulta)
6434:     *==========================================================================
6435: 
6436:     *-- Sair (Command1) - legado: fecha o overlay.
6437:     PROCEDURE ConsultaCommand1Click()
6438:         THIS.cnt_4c__Consulta.Visible = .F.
6439:     ENDPROC
6440: 
6441:     *-- Proximo - o legado so troca a imagem da seta em GotFocus/LostFocus
6442:     *-- (nao ha Click proprio capturado); tratado aqui como equivalente a
6443:     *-- Sair, fechando o overlay.
6444:     PROCEDURE ConsultaProximoClick()
6445:         THIS.cnt_4c__Consulta.Visible = .F.
6446:     ENDPROC
6447: 
6448:     *-- Get_Produto (ENTER/TAB) - consulta simples de preco por codigo do
6449:     *-- produto ou codigo de barras (SigCdPro.cpros/cbars/dpros/pvens).
6450:     PROCEDURE ConsultaProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6451:         LOCAL loc_cValor, loc_oErro
6452: 
6453:         IF !INLIST(par_nKeyCode, 13, 9)
6454:             RETURN
6455:         ENDIF
6456: 
6457:         loc_cValor = ALLTRIM(THIS.cnt_4c__Consulta.cnt_4c__Produto.txt_4c_Produto.Value)
6458:         IF EMPTY(loc_cValor)
6459:             RETURN
6460:         ENDIF
6461: 
6462:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
6463:             RETURN
6464:         ENDIF
6465: 
6466:         TRY
6467:             IF USED("cursor_4c_ConsultaPreco")
6468:                 USE IN cursor_4c_ConsultaPreco
6469:             ENDIF
6470: 
6471:             IF SQLEXEC(gnConnHandle, "SELECT dpros, pvens FROM SigCdPro WHERE cpros = " + ;
6472:                     EscaparSQL(PADR(loc_cValor, 14)) + " OR cbars = " + TRANSFORM(VAL(loc_cValor)), ;
6473:                     "cursor_4c_ConsultaPreco") > 0 ;
6474:                     AND USED("cursor_4c_ConsultaPreco") AND RECCOUNT("cursor_4c_ConsultaPreco") > 0
6475: 
6476:                 SELECT cursor_4c_ConsultaPreco
6477:                 GO TOP
6478:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage1.Caption = ;
6479:                     ALLTRIM(NVL(cursor_4c_ConsultaPreco.dpros, ""))
6480:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage2.Caption = ""
6481:                 THIS.cnt_4c__Consulta.txt_4c_Unit.Value = NVL(cursor_4c_ConsultaPreco.pvens, 0)
6482:             ELSE
6483:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage1.Caption = ;
6484:                     "Produto n" + CHR(227) + "o encontrado."
6485:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage2.Caption = ""
6486:                 THIS.cnt_4c__Consulta.txt_4c_Unit.Value = 0
6487:             ENDIF
6488: 
6489:             IF USED("cursor_4c_ConsultaPreco")
6490:                 USE IN cursor_4c_ConsultaPreco

*-- Linhas 6501 a 6793:
6501:     *-- CntItem.Proximo - legado: "If Get_Produto.Enabled / TotChamada=0 /
6502:     *-- Barra_Botoes.Pagto.Click() / Else / This.SetFocus" - aciona o mesmo
6503:     *-- botao Pagto da barra.
6504:     PROCEDURE ItemProximoClick()
6505:         IF THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Enabled
6506:             THIS.CmdPagtoClick()
6507:         ELSE
6508:             THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
6509:         ENDIF
6510:     ENDPROC
6511: 
6512:     *-- CntFinanc.Proximo - mesmo destino do CntItem.Proximo (Pagto).
6513:     PROCEDURE FinancProximoClick()
6514:         THIS.CmdPagtoClick()
6515:     ENDPROC
6516: 
6517:     *-- Cnt_Credito.Proximo - legado: "If Barra_Botoes.Itens.Visible /
6518:     *-- Itens.Click() / Else / Pagto.Click()" - volta para Itens.
6519:     PROCEDURE CreditoProximoClick()
6520:         THIS.CmdItensClick()
6521:     ENDPROC
6522: 
6523:     *-- Cnt_Pendencia.Proximo - mesmo padrao do Credito.
6524:     PROCEDURE PendenciaProximoClick()
6525:         THIS.CmdItensClick()
6526:     ENDPROC
6527: 
6528:     *-- Cnt_Fpagto.Proximo - avanca para a confirmacao da venda.
6529:     PROCEDURE FpagtoProximoClick()
6530:         THIS.BtnConfirmarClick()
6531:     ENDPROC
6532: 
6533:     *==========================================================================
6534:     * HANDLERS - COMBO DE TROCA DE OPERACAO (cbo_4c_CmbTOpers)
6535:     *==========================================================================
6536: 
6537:     *-- Legado (cmbTOpers.LostFocus): ENTER confirma a operacao escolhida e
6538:     *-- chama ThisForm.parentform.AciomudaOpe(...) - reconfiguracao completa
6539:     *-- do Caixa, fora de alcance deste form filho (DataSession=2). Aqui:
6540:     *-- registra a operacao escolhida localmente (this_cDopes) e avisa que a
6541:     *-- reconfiguracao e feita pela tela de movimentacao.
6542:     PROCEDURE CmbTOpersKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6543:         LOCAL loc_cDope
6544: 
6545:         IF par_nKeyCode != 13
6546:             RETURN
6547:         ENDIF
6548: 
6549:         IF THIS.cbo_4c_CmbTOpers.ListIndex > 0
6550:             loc_cDope = ALLTRIM(THIS.cbo_4c_CmbTOpers.List(THIS.cbo_4c_CmbTOpers.ListIndex))
6551:             THIS.this_cDopes = loc_cDope
6552:             MsgInfo("Opera" + CHR(231) + CHR(227) + "o alterada para " + loc_cDope + "." + CHR(13) + ;
6553:                 "A reconfigura" + CHR(231) + CHR(227) + "o completa do Caixa para a nova opera" + CHR(231) + CHR(227) + "o " + ;
6554:                 "e feita pela tela de movimenta" + CHR(231) + CHR(227) + "o.", "Muda Opera" + CHR(231) + CHR(227) + "o")
6555:         ENDIF
6556: 
6557:         THIS.cbo_4c_CmbTOpers.Visible = .F.
6558:     ENDPROC
6559: 
6560:     PROCEDURE CmbTOpersLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6561:         THIS.cbo_4c_CmbTOpers.Visible = .F.
6562:     ENDPROC
6563: 
6564:     *==========================================================================
6565:     * HANDLERS DE KEYPRESS - disparam o lookup em ENTER(13)/TAB(9)/F4(115).
6566:     * PUBLIC (sem PROTECTED): BINDEVENT so funciona com metodos PUBLIC
6567:     * (CLAUDE.md #3). Cada um resolve o(s) controle(s) do proprio bloco e
6568:     * delega para o AbrirLookupXxx correspondente.
6569:     *==========================================================================
6570: 
6571:     *-- Destino ---------------------------------------------------------------
6572:     PROCEDURE GrpDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6573:         IF INLIST(par_nKeyCode, 13, 9, 115)
6574:             THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Destino.txt_4c_Grupo)
6575:         ENDIF
6576:     ENDPROC
6577: 
6578:     PROCEDURE CtaDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6579:         LOCAL loc_oCnt
6580:         IF INLIST(par_nKeyCode, 13, 9, 115)
6581:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Destino
6582:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6583:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "iclis", ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
6584:         ENDIF
6585:     ENDPROC
6586: 
6587:     PROCEDURE DctDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6588:         LOCAL loc_oCnt
6589:         IF INLIST(par_nKeyCode, 13, 9, 115)
6590:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Destino
6591:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6592:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "rclis", ALLTRIM(loc_oCnt.txt_4c_Dconta.Value))
6593:         ENDIF
6594:     ENDPROC
6595: 
6596:     PROCEDURE CpfDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6597:         LOCAL loc_oCnt
6598:         IF INLIST(par_nKeyCode, 13, 9, 115)
6599:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Destino
6600:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6601:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "cpfs", ;
6602:                 CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value), ".-/", ""))
6603:         ENDIF
6604:     ENDPROC
6605: 
6606:     *-- Responsavel -------------------------------------------------------------
6607:     PROCEDURE GrpRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6608:         IF INLIST(par_nKeyCode, 13, 9, 115)
6609:             THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Responsavel.txt_4c_Grupo)
6610:         ENDIF
6611:     ENDPROC
6612: 
6613:     PROCEDURE CtaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6614:         LOCAL loc_oCnt
6615:         IF INLIST(par_nKeyCode, 13, 9, 115)
6616:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Responsavel
6617:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6618:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "iclis", ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
6619:         ENDIF
6620:     ENDPROC
6621: 
6622:     PROCEDURE DctRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6623:         LOCAL loc_oCnt
6624:         IF INLIST(par_nKeyCode, 13, 9, 115)
6625:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Responsavel
6626:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6627:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "rclis", ALLTRIM(loc_oCnt.txt_4c_Dconta.Value))
6628:         ENDIF
6629:     ENDPROC
6630: 
6631:     PROCEDURE CpfRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6632:         LOCAL loc_oCnt
6633:         IF INLIST(par_nKeyCode, 13, 9, 115)
6634:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Responsavel
6635:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6636:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "cpfs", ;
6637:                 CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value), ".-/", ""))
6638:         ENDIF
6639:     ENDPROC
6640: 
6641:     *-- Vendedor ----------------------------------------------------------------
6642:     PROCEDURE GrpVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6643:         IF INLIST(par_nKeyCode, 13, 9, 115)
6644:             THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Vendedor.txt_4c_Grupo)
6645:         ENDIF
6646:     ENDPROC
6647: 
6648:     PROCEDURE CtaVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6649:         LOCAL loc_oCnt
6650:         IF INLIST(par_nKeyCode, 13, 9, 115)
6651:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Vendedor
6652:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6653:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "iclis", ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
6654:         ENDIF
6655:     ENDPROC
6656: 
6657:     PROCEDURE DctVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6658:         LOCAL loc_oCnt
6659:         IF INLIST(par_nKeyCode, 13, 9, 115)
6660:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Vendedor
6661:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6662:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "rclis", ALLTRIM(loc_oCnt.txt_4c_Dconta.Value))
6663:         ENDIF
6664:     ENDPROC
6665: 
6666:     PROCEDURE CpfVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6667:         LOCAL loc_oCnt
6668:         IF INLIST(par_nKeyCode, 13, 9, 115)
6669:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Vendedor
6670:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6671:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "cpfs", ;
6672:                 CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value), ".-/", ""))
6673:         ENDIF
6674:     ENDPROC
6675: 
6676:     *-- Origem --------------------------------------------------------------
6677:     PROCEDURE GrpOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6678:         IF INLIST(par_nKeyCode, 13, 9, 115)
6679:             THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Origem.txt_4c_Grupo)
6680:         ENDIF
6681:     ENDPROC
6682: 
6683:     PROCEDURE CtaOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6684:         LOCAL loc_oCnt
6685:         IF INLIST(par_nKeyCode, 13, 9, 115)
6686:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Origem
6687:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6688:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "iclis", ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
6689:         ENDIF
6690:     ENDPROC
6691: 
6692:     PROCEDURE DctOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6693:         LOCAL loc_oCnt
6694:         IF INLIST(par_nKeyCode, 13, 9, 115)
6695:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Origem
6696:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6697:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "rclis", ALLTRIM(loc_oCnt.txt_4c_Dconta.Value))
6698:         ENDIF
6699:     ENDPROC
6700: 
6701:     PROCEDURE CpfOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6702:         LOCAL loc_oCnt
6703:         IF INLIST(par_nKeyCode, 13, 9, 115)
6704:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Origem
6705:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6706:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "cpfs", ;
6707:                 CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value), ".-/", ""))
6708:         ENDIF
6709:     ENDPROC
6710: 
6711:     *-- TabDesconto / ListaPreco / Forma de Pagamento --------------------------
6712:     PROCEDURE TabdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6713:         IF INLIST(par_nKeyCode, 13, 9, 115)
6714:             THIS.AbrirLookupTabDesconto(THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_Tabd)
6715:         ENDIF
6716:     ENDPROC
6717: 
6718:     PROCEDURE ListaPrecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6719:         IF INLIST(par_nKeyCode, 13, 9, 115)
6720:             THIS.AbrirLookupListaPreco(THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_ListaPreco)
6721:         ENDIF
6722:     ENDPROC
6723: 
6724:     PROCEDURE FpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6725:         IF INLIST(par_nKeyCode, 13, 9, 115)
6726:             THIS.AbrirLookupFormaPagamento(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
6727:         ENDIF
6728:     ENDPROC
6729: 
6730: 
6731:     *==========================================================================
6732:     * FASE 7 - EVENTOS DOS BOTOES QUE AINDA NAO TINHAM HANDLER
6733:     *
6734:     * Completa a cobertura de Click dos CommandButtons do SCX legado que nao
6735:     * pertencem a barra principal nem as grades: o Confirmar do bloco de item
6736:     * (CmdEnviaProd), a seta Proximo da tela de Identificacao, os dois
6737:     * btnCadastros (Origem/Destino) e os dois botoes do painel de cheque
6738:     * pre-datado (TefChq/ins).
6739:     *==========================================================================
6740: 
6741:     *--------------------------------------------------------------------------
6742:     * LimparCntItem - legado mLimpaCntItem(plInsere). Zera os campos do bloco
6743:     * de lancamento de item e, quando par_lInsere, recicla a linha "corrente"
6744:     * do carrinho: apaga as linhas sem produto e, se nao sobrou nenhuma em
6745:     * branco, cria a proxima (citens = MAX + 1, respeitando UltimoCancel).
6746:     *
6747:     * O INSERT do legado gravava tambem emps/dopes/numes (tirados de TprMvCab,
6748:     * cursor do form pai): crTpmMvItn desta tela NAO tem essas tres colunas
6749:     * (Fase 4, CriarCursoresGrades) - a empresa/operacao/documento da venda
6750:     * vivem nas properties this_cEmps/this_cDopes/this_nNumes e sao aplicadas
6751:     * na persistencia, nao na linha do carrinho. Por isso aqui so citens.
6752:     *--------------------------------------------------------------------------
6753:     PROTECTED PROCEDURE LimparCntItem(par_lInsere)
6754:         LOCAL loc_lInsere, loc_nMaxItem, loc_lTemBranco, loc_oCnt
6755: 
6756:         loc_lInsere = IIF(VARTYPE(par_lInsere) = "L", par_lInsere, .F.)
6757: 
6758:         IF loc_lInsere AND USED("crTpmMvItn")
6759:             SELECT crTpmMvItn
6760:             SET ORDER TO
6761:             GO TOP
6762:             DELETE FOR EMPTY(NVL(cpros, ""))
6763: 
6764:             *-- Sobrou alguma linha em branco utilizavel? (legado:
6765:             *-- "Seek(Spac(14),'crTpmMvItn','Cpros')")
6766:             LOCATE FOR EMPTY(NVL(cpros, "")) AND !DELETED()
6767:             loc_lTemBranco = !EOF()
6768: 
6769:             IF !loc_lTemBranco
6770:                 loc_nMaxItem = 0
6771:                 SELECT MAX(citens) AS nMaxItem ;
6772:                     FROM crTpmMvItn ;
6773:                     WHERE !EMPTY(NVL(cpros, "")) ;
6774:                     INTO CURSOR cursor_4c_MaxItem
6775:                 IF USED("cursor_4c_MaxItem")
6776:                     GO TOP IN cursor_4c_MaxItem
6777:                     loc_nMaxItem = NVL(cursor_4c_MaxItem.nMaxItem, 0)
6778:                     USE IN cursor_4c_MaxItem
6779:                 ENDIF
6780: 
6781:                 IF THIS.this_nUltimocancel > loc_nMaxItem
6782:                     loc_nMaxItem = THIS.this_nUltimocancel
6783:                 ENDIF
6784: 
6785:                 THIS.this_nCitem = loc_nMaxItem + 1
6786: 
6787:                 INSERT INTO crTpmMvItn (citens) VALUES (THIS.this_nCitem)
6788:             ENDIF
6789: 
6790:             SELECT crTpmMvItn
6791:             SET ORDER TO
6792:         ENDIF
6793: 

*-- Linhas 6812 a 7036:
6812:     * global do Fortyus que nao veio no acervo; RecalcularTotalCarrinho() faz
6813:     * a MESMA soma (SUM crTpmMvItn.totas), so localmente.
6814:     *--------------------------------------------------------------------------
6815:     PROTECTED PROCEDURE ExcluirItemCorrente()
6816:         LOCAL loc_nItem
6817: 
6818:         IF !USED("crTpmMvItn")
6819:             RETURN
6820:         ENDIF
6821: 
6822:         SELECT crTpmMvItn
6823:         IF EOF()
6824:             RETURN
6825:         ENDIF
6826: 
6827:         loc_nItem = NVL(citens, 0)
6828:         DELETE
6829: 
6830:         THIS.this_nCitem = THIS.this_nCitem - 1
6831: 
6832:         IF USED("crTpmMvItnC")
6833:             SELECT crTpmMvItnC
6834:             DELETE FOR cItens == loc_nItem
6835:         ENDIF
6836: 
6837:         THIS.RecalcularTotalCarrinho()
6838:         THIS.AtualizarGrades()
6839: 
6840:         SELECT crTpmMvItn
6841:         GO BOTTOM
6842:     ENDPROC
6843: 
6844:     *--------------------------------------------------------------------------
6845:     * CmdEnviaProdClick - Confirmar do bloco de item (CntItem.Cnt_Produto.
6846:     * CmdEnviaProd). Legado (Click): "ThisForm.CmdEnviaProd() / This.Visible =
6847:     * .f. / Get_Produto.SetFocus".
6848:     *
6849:     * O metodo CmdEnviaProd do legado imprime o item no cupom fiscal
6850:     * (ItemFiscal/CancelCupom/AtuaCupom) - impressora ECF, fora de alcance
6851:     * desta tela migrada (mesmo limite ja documentado em BtnConfirmarClick). O que
6852:     * NAO depende do ECF e transcrito fielmente: valor zero rejeita o item
6853:     * (mensagem do legado, remove a linha e remonta o bloco), valor valido
6854:     * marca ImpCupFis, reabilita o [F4]Canc e recicla a linha corrente.
6855:     *--------------------------------------------------------------------------
6856:     PROCEDURE CmdEnviaProdClick()
6857:         LOCAL loc_nValor
6858: 
6859:         loc_nValor = THIS.cnt_4c_Item.cnt_4c__Subtotal.txt_4c_Valor.Value
6860: 
6861:         IF loc_nValor = 0
6862:             *-- Legado: "Messagebox('Valor do Produto Invalido !!',0+48,'')"
6863:             MsgAviso("Valor do Produto Inv" + CHR(225) + "lido !!", "Confirmar Item")
6864:             THIS.ExcluirItemCorrente()
6865:             THIS.LimparCntItem(.T.)
6866:         ELSE
6867:             THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = "Imprimindo Itens..."
6868: 
6869:             IF USED("crTpmMvItn") AND !EOF("crTpmMvItn")
6870:                 SELECT crTpmMvItn
6871:                 REPLACE ImpCupFis WITH .T.
6872:             ENDIF
6873: 
6874:             *-- Legado: "ThisForm.Barra_Botoes.Apaga.Enabled = .T."
6875:             THIS.cnt_4c_Barra_Botoes.cmd_4c_Apaga.Enabled = .T.
6876: 
6877:             THIS.MontarLinhasCupom()
6878:             THIS.AtualizarGrades()
6879:             THIS.LimparCntItem(.T.)
6880:         ENDIF
6881: 
6882:         THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = ""
6883:         THIS.LimparCntItem(.F.)
6884: 
6885:         THIS.cnt_4c_Item.cnt_4c__Produto.cmd_4c_CmdEnviaProd.Visible = .F.
6886:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
6887:     ENDPROC
6888: 
6889:     *--------------------------------------------------------------------------
6890:     * IdentificaProximoClick - seta "Proximo" da tela de Identificacao.
6891:     * Legado (Cnt_Identifica.Proximo.Click): "If Barra_Botoes.Itens.Visible /
6892:     * Itens.Click() ... Else / Pagto.SetFocus + Pagto.Click()". A troca de
6893:     * imagem da seta (GotFocus/LostFocus) e so visual e nao tem efeito de
6894:     * negocio.
6895:     *--------------------------------------------------------------------------
6896:     PROCEDURE IdentificaProximoClick()
6897:         IF THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Visible
6898:             THIS.CmdItensClick()
6899:         ELSE
6900:             THIS.CmdPagtoClick()
6901:         ENDIF
6902:     ENDPROC
6903: 
6904:     *--------------------------------------------------------------------------
6905:     * AbrirCadastroConta - corpo comum dos dois btnCadastros (Origem/Destino).
6906:     * Legado: exige Conta E CPF/CNPJ preenchidos, so age em INSERIR/ALTERAR e
6907:     * abre o Cadastro de Contas ("Do Form SIGCDCTA With 0,[SIGCDCTA],lcCli,
6908:     * .T.,lcCpf,lcGru").
6909:     *
6910:     * SIGCDCTA foi migrado como FormCTA ("Cadastro de Contas"), cujo Init NAO
6911:     * recebe parametros - o posicionamento equivalente e feito preenchendo o
6912:     * filtro de Grupo da pagina Lista e recarregando a grade antes do Show().
6913:     * O grupo de cadastro do legado vinha de crSigCdOpe.GruCadOs/GruCadDs
6914:     * (cursor global do form pai, inalcancavel com DataSession = 2): aqui usa
6915:     * o Grupo do proprio bloco, que e o fallback que o legado ja usava quando
6916:     * GruCad*s estava vazio.
6917:     *
6918:     * Show() fica FORA do TRY (CLAUDE.md #29): FormCTA e modal, entao o Show()
6919:     * bloqueia e TODO o uso da tela correria dentro do bloco - um erro de
6920:     * runtime la dentro saltaria para o CATCH, a referencia LOCAL cairia e a
6921:     * tela fecharia sozinha.
6922:     *--------------------------------------------------------------------------
6923:     PROTECTED PROCEDURE AbrirCadastroConta(par_oBloco)
6924:         LOCAL loc_cConta, loc_cCpf, loc_cGrupo, loc_oForm, loc_oFiltros, loc_oErro
6925:         LOCAL loc_lProsseguir
6926: 
6927:         loc_lProsseguir = .F.
6928:         loc_cConta = ALLTRIM(NVL(par_oBloco.txt_4c_Conta.Value, ""))
6929:         loc_cCpf   = ALLTRIM(NVL(par_oBloco.txt_4c_Cpf.Value, ""))
6930:         loc_cGrupo = ALLTRIM(NVL(par_oBloco.txt_4c_Grupo.Value, ""))
6931: 
6932:         IF EMPTY(loc_cConta) OR EMPTY(loc_cCpf)
6933:             *-- Legado: "E Necessario o Preenchimento Da Conta e Que a Mesma
6934:             *-- Possua Um CPF/CNPJ!!!"
6935:             MsgAviso(CHR(233) + " Necess" + CHR(225) + "rio o Preenchimento Da Conta e Que a Mesma " + ;
6936:                 "Possua Um CPF/CNPJ!!!", "Dados Incompletos")
6937:             THIS.FocarControle(par_oBloco.txt_4c_Conta)
6938:         ELSE
6939:             loc_lProsseguir = INLIST(UPPER(ALLTRIM(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
6940:         ENDIF
6941: 
6942:         IF !loc_lProsseguir
6943:             RETURN
6944:         ENDIF
6945: 
6946:         loc_oForm = .NULL.
6947:         TRY
6948:             loc_oForm = CREATEOBJECT("FormCTA")
6949:         CATCH TO loc_oErro
6950:             MsgErro("Erro ao abrir o Cadastro de Contas:" + CHR(13) + loc_oErro.Message + ;
6951:                 CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
6952:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Cadastro de Contas")
6953:             loc_oForm = .NULL.
6954:         ENDTRY
6955: 
6956:         IF VARTYPE(loc_oForm) = "O"
6957:             *-- Posiciona o filtro de Grupo da Lista no grupo da conta
6958:             *-- escolhida. Os PEMSTATUS ficam em IFs ANINHADOS de proposito:
6959:             *-- VFP9 nao garante short-circuit em AND/OR, entao encadea-los na
6960:             *-- mesma expressao avaliaria loc_oForm.pgf_4c_Paginas.Page1 mesmo
6961:             *-- quando o PageFrame nao existe (CLAUDE.md #27).
6962:             IF !EMPTY(loc_cGrupo)
6963:                 IF PEMSTATUS(loc_oForm, "pgf_4c_Paginas", 5)
6964:                     IF PEMSTATUS(loc_oForm.pgf_4c_Paginas.Page1, "cnt_4c_Filtros", 5)
6965:                         loc_oFiltros = loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Filtros
6966:                         IF PEMSTATUS(loc_oFiltros, "txt_4c_Grupo", 5)
6967:                             loc_oFiltros.txt_4c_Grupo.Value = loc_cGrupo
6968:                             IF PEMSTATUS(loc_oForm, "CarregarLista", 5)
6969:                                 loc_oForm.CarregarLista()
6970:                             ENDIF
6971:                         ENDIF
6972:                     ENDIF
6973:                 ENDIF
6974:             ENDIF
6975: 
6976:             loc_oForm.Show()
6977:         ENDIF
6978:     ENDPROC
6979: 
6980:     *-- btnCadastros do bloco Destino.
6981:     PROCEDURE BtnCadastrosDestinoClick()
6982:         THIS.AbrirCadastroConta(THIS.cnt_4c__Identifica.cnt_4c_Destino)
6983:     ENDPROC
6984: 
6985:     *-- btnCadastros do bloco Origem.
6986:     PROCEDURE BtnCadastrosOrigemClick()
6987:         THIS.AbrirCadastroConta(THIS.cnt_4c__Identifica.cnt_4c_Origem)
6988:     ENDPROC
6989: 
6990:     *--------------------------------------------------------------------------
6991:     * LimparChequePreTef - legado limpa_cheptef. Devolve os campos do painel
6992:     * de cheque aos brancos com o TAMANHO de cada um (space(3)/space(4)/...),
6993:     * exatamente como o legado - o TextBox e char e o InputMask depende do
6994:     * comprimento.
6995:     *--------------------------------------------------------------------------
6996:     PROTECTED PROCEDURE LimparChequePreTef()
6997:         LOCAL loc_oChq
6998:         loc_oChq = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
6999: 
7000:         WITH loc_oChq
7001:             .txt_4c_Bco.Value     = SPACE(3)
7002:             .txt_4c_Age.Value     = SPACE(4)
7003:             .txt_4c_Agendc.Value  = SPACE(1)
7004:             .txt_4c_Conta.Value   = SPACE(10)
7005:             .txt_4c_Contadc.Value = SPACE(1)
7006:             .txt_4c_Num.Value     = SPACE(6)
7007:             .txt_4c_Numdc.Value   = SPACE(6)
7008:             .txt_4c_Pca.Value     = SPACE(34)
7009:             .Refresh()
7010:         ENDWITH
7011:     ENDPROC
7012: 
7013:     *--------------------------------------------------------------------------
7014:     * ValidarChequesLancados - o SCAN de abertura do TefChq.Click legado:
7015:     * percorre xPar e, para cada parcela cuja forma de pagamento e CHEQUE
7016:     * (Infos = "C"), exige banco, agencia, conta, numero e CPF/CNPJ
7017:     * preenchidos. Devolve .T. quando todas passam.
7018:     *
7019:     * xPar.Infos e a copia local de SigOpFp.Infos (Fase 4,
7020:     * CriarCursoresGrades) - e por isso que aqui NAO e preciso repetir o
7021:     * cursorquery('SigOpFp','CrOpFp','Fpags',xPar.Fpags) que o legado fazia
7022:     * linha a linha.
7023:     *
7024:     * Alem do guard do legado, confere numero de cheque REPETIDO dentro da
7025:     * mesma venda: e a inconsistencia que o botao "Ins" (sequenciamento)
7026:     * existe para evitar, e a unica checagem de duplicidade possivel
7027:     * localmente.
7028:     *
7029:     * NAO reproduz a consulta a fChkCheques(banco, agencia, conta, numero, ...)
7030:     * - funcao global do Fortyus (SIGFUNCS.PRG) que NAO veio no acervo e que
7031:     * consulta o historico/restricao do cheque. Um wrapper devolvendo .T.
7032:     * APROVARIA em silencio um cheque que o legado recusaria (CLAUDE.md #27:
7033:     * jamais stub que devolve veredicto), por isso a ausencia fica VISIVEL na
7034:     * mensagem do caminho de sucesso, em vez de ser silenciada.
7035:     *--------------------------------------------------------------------------
7036:     PROTECTED FUNCTION ValidarChequesLancados()

*-- Linhas 7107 a 7230:
7107:     * confirmacao diz explicitamente o que foi e o que NAO foi conferido -
7108:     * aprovar calado seria pior que a ausencia (CLAUDE.md #27).
7109:     *--------------------------------------------------------------------------
7110:     PROCEDURE CmdTefChqClick()
7111:         LOCAL loc_oChq, loc_nTotLiquido, loc_nTotForma
7112: 
7113:         loc_oChq = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
7114: 
7115:         THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = ""
7116:         THIS.this_lNoklostche = .T.
7117: 
7118:         IF !THIS.ValidarChequesLancados()
7119:             *-- Legado: "MessageBox('Cheque Invalido!!!',0+48,'')" + limpa +
7120:             *-- "Replace xPar.nidcheps with 0" + "Get_pca.SetFocus".
7121:             MsgAviso("Cheque Inv" + CHR(225) + "lido!!!", "Conferir Cheque")
7122:             THIS.LimparChequePreTef()
7123:             IF USED("xPar")
7124:                 SELECT xPar
7125:                 IF !EOF()
7126:                     REPLACE nIdCheps WITH 0
7127:                 ENDIF
7128:             ENDIF
7129:             THIS.FocarControle(loc_oChq.txt_4c_Pca)
7130:             RETURN
7131:         ENDIF
7132: 
7133:         MsgInfo("Numera" + CHR(231) + CHR(227) + "o dos cheques conferida." + CHR(13) + ;
7134:             "A consulta ao gerenciador TEF e a impress" + CHR(227) + "o do cheque prosseguem na tela " + ;
7135:             "de movimenta" + CHR(231) + CHR(227) + "o.", "Conferir Cheque")
7136: 
7137:         loc_nTotLiquido = THIS.cnt_4c__Fpagto.txt_4c_TotLiquido.Value
7138:         loc_nTotForma   = THIS.cnt_4c__Fpagto.txt_4c_TotForma.Value
7139: 
7140:         THIS.this_lNoklostche = .F.
7141:         THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Visible = .F.
7142:         THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Refresh()
7143: 
7144:         IF loc_nTotLiquido = loc_nTotForma AND loc_nTotLiquido != 0 AND loc_nTotForma != 0
7145:             THIS.cnt_4c_Barra_Botoes.cmd_4c_Cancela.Enabled = .T.
7146:             THIS.BtnConfirmarClick()
7147:         ELSE
7148:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cmd_4c_Proximo)
7149:         ENDIF
7150:     ENDPROC
7151: 
7152:     *--------------------------------------------------------------------------
7153:     * CmdInsChequeClick - botao "Ins" do painel de cheque. ToolTipText do
7154:     * legado: "insere a sequencia dos numeros dos cheques e mostra na grade".
7155:     *
7156:     * Legado (Cnt_Chq.ins.Click): guarda os dados do cheque da linha CORRENTE
7157:     * de xPar (banco/agencia/conta/digitos/CPF/praca/numero), pula para a linha
7158:     * seguinte, limpa os campos de numero na tela e, da linha seguinte ate o
7159:     * fim, replica esses dados incrementando o numero do cheque de 1 em 1
7160:     * (Transform(...,'@L 999999')); no fim reordena, volta ao topo, refaz o
7161:     * bind da grade e poe o foco na coluna Valor.
7162:     *
7163:     * O SetAll('DynamicForeColor',...) do legado pinta a linha conforme
7164:     * InsChs/NumChqs/nIdCheps/Trocos - transcrito com os nomes das colunas
7165:     * deste cursor. O rebind e feito por MontaGrade(), que ja reaplica na ordem
7166:     * correta RecordSource -> ControlSource -> Width -> Header (Problema 48).
7167:     *--------------------------------------------------------------------------
7168:     PROCEDURE CmdInsChequeClick()
7169:         LOCAL loc_oChq, loc_oGrd
7170:         LOCAL loc_cBco, loc_cAgc, loc_cCta, loc_cDAgc, loc_cDCta, loc_cCpf, loc_cPca, loc_cNum
7171: 
7172:         IF !USED("xPar")
7173:             RETURN
7174:         ENDIF
7175: 
7176:         loc_oChq = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
7177: 
7178:         SELECT xPar
7179:         IF EOF()
7180:             RETURN
7181:         ENDIF
7182: 
7183:         loc_cBco  = NVL(Bancos, "")
7184:         loc_cAgc  = NVL(Agencias, "")
7185:         loc_cCta  = NVL(Contas, "")
7186:         loc_cDAgc = NVL(DigAgencs, "")
7187:         loc_cDCta = NVL(DigContas, "")
7188:         loc_cCpf  = NVL(Cpfs, "")
7189:         loc_cPca  = NVL(Pracas, "")
7190:         loc_cNum  = NVL(Numeros, "")
7191: 
7192:         SKIP
7193:         loc_oChq.txt_4c_Num.Value   = ""
7194:         loc_oChq.txt_4c_Numdc.Value = ""
7195: 
7196:         DO WHILE !EOF()
7197:             loc_cNum = TRANSFORM(VAL(loc_cNum) + 1, "@L 999999")
7198:             REPLACE Bancos    WITH loc_cBco, ;
7199:                     Agencias  WITH loc_cAgc, ;
7200:                     Contas    WITH loc_cCta, ;
7201:                     Numeros   WITH loc_cNum, ;
7202:                     DigAgencs WITH loc_cDAgc, ;
7203:                     DigContas WITH loc_cDCta, ;
7204:                     Cpfs      WITH loc_cCpf, ;
7205:                     Pracas    WITH loc_cPca IN xPar
7206:             SKIP
7207:         ENDDO
7208: 
7209:         SELECT xPar
7210:         SET ORDER TO
7211:         GO TOP
7212: 
7213:         THIS.MontaGrade()
7214: 
7215:         loc_oGrd = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas
7216:         loc_oGrd.SetAll("DynamicForeColor", ;
7217:             "IIF(xPar.InsChs, IIF(!EMPTY(NVL(xPar.NumChqs, '')), RGB(255,0,0), RGB(0,0,255))," + ;
7218:             " IIF(NVL(xPar.nIdCheps, 0) = 0, IIF(NVL(xPar.Trocos, 0) = 1, RGB(0,0,160), RGB(0,0,0)), RGB(0,0,255)))", ;
7219:             "Column")
7220:         loc_oGrd.Refresh()
7221: 
7222:         *-- Legado: ".valor.text1.SetFocus" - o alvo do foco e o TextBox da
7223:         *-- coluna Valor (Column2), nao a Column.
7224:         THIS.FocarControle(loc_oGrd.Column2.Text1)
7225:     ENDPROC
7226: 
7227:     *==========================================================================
7228:     * CONSOLIDACAO FINAL (FASE 8) - TRANSFERENCIA FORM <-> BO, PERSISTENCIA
7229:     * DOS ITENS LANCADOS E GATE DOS BOTOES POR ESTADO DA TELA
7230:     *==========================================================================

*-- Linhas 7353 a 7396:
7353:             MsgErro("Erro ao preparar o item para grava" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
7354:                 loc_oErro.Message + CHR(13) + ;
7355:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
7356:                 "Procedure: " + loc_oErro.Procedure, "FormParaBO")
7357:             loc_lSucesso = .F.
7358:         ENDTRY
7359: 
7360:         RETURN loc_lSucesso
7361:     ENDFUNC
7362: 
7363:     *--------------------------------------------------------------------------
7364:     * BOParaForm - caminho inverso do FormParaBO: joga as propriedades do BO
7365:     * na linha corrente de crTpmMvItn e nos campos de lancamento visiveis do
7366:     * CntItem, para o caixa VER o item que o BO carregou (usado depois de
7367:     * CarregarDoCursor, quando um item ja gravado e retomado para conferencia).
7368:     *
7369:     * REPLACE exige o cursor posicionado na linha certa: quem chama posiciona
7370:     * (LOCATE FOR citens = ...) antes. Sem linha valida o metodo devolve .F. e
7371:     * nao toca em nada.
7372:     *--------------------------------------------------------------------------
7373:     PROTECTED FUNCTION BOParaForm()
7374:         LOCAL loc_oBO, loc_oCnt, loc_lSucesso, loc_oErro
7375:         loc_lSucesso = .F.
7376: 
7377:         TRY
7378:             IF USED("crTpmMvItn") AND !EOF("crTpmMvItn")
7379:                 loc_oBO = THIS.this_oBusinessObject
7380:                 SELECT crTpmMvItn
7381: 
7382:                 REPLACE citens     WITH loc_oBO.this_nCitens, ;
7383:                         cpros      WITH loc_oBO.this_cCpros, ;
7384:                         dpros      WITH loc_oBO.this_cDpros, ;
7385:                         cunis      WITH loc_oBO.this_cCunis, ;
7386:                         codbarras  WITH loc_oBO.this_nCodbarras, ;
7387:                         codlprecs  WITH loc_oBO.this_nCodlprecs, ;
7388:                         empdopnums WITH loc_oBO.this_cEmpdopnums, ;
7389:                         etiesps    WITH loc_oBO.this_lEtiesps, ;
7390:                         fators     WITH loc_oBO.this_nFators, ;
7391:                         fatvals    WITH loc_oBO.this_nFatvals ;
7392:                     IN crTpmMvItn
7393: 
7394:                 REPLACE moedas   WITH loc_oBO.this_cMoedas, ;
7395:                         moefats  WITH loc_oBO.this_cMoefats, ;
7396:                         moevals  WITH loc_oBO.this_nMoevals, ;

*-- Linhas 7432 a 7475:
7432:             MsgErro("Erro ao exibir o item carregado:" + CHR(13) + ;
7433:                 loc_oErro.Message + CHR(13) + ;
7434:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
7435:                 "Procedure: " + loc_oErro.Procedure, "BOParaForm")
7436:             loc_lSucesso = .F.
7437:         ENDTRY
7438: 
7439:         RETURN loc_lSucesso
7440:     ENDFUNC
7441: 
7442:     *--------------------------------------------------------------------------
7443:     * GravarItensLancados - persiste em SigMvItn TODOS os itens do carrinho
7444:     * (crTpmMvItn) que tem produto informado, um a um, via BO.
7445:     *
7446:     * Este e o passo que fechava no legado por outro caminho: la o pai gravava
7447:     * o cursor inteiro com TableUpdate na datasession COMPARTILHADA. Aqui, com
7448:     * DataSession = 2, cada linha vira NovoRegistro() + FormParaBO() +
7449:     * Salvar().
7450:     *
7451:     * Erro em QUALQUER item aborta o laco e devolve .F. - nao existe "gravou
7452:     * metade da venda". Quem chama (BtnConfirmarClick) so anuncia sucesso e
7453:     * fecha a tela se isto devolver .T.
7454:     *
7455:     * BusinessBase.Salvar() ja exibe a falha sozinho (ExibirFalha) e marca
7456:     * this_lErroExibido, entao aqui NAO se repete a mensagem (CLAUDE.md #20).
7457:     *--------------------------------------------------------------------------
7458:     PROTECTED FUNCTION GravarItensLancados()
7459:         LOCAL loc_oBO, loc_lSucesso, loc_nGravados, loc_nRec, loc_oErro
7460:         loc_lSucesso  = .T.
7461:         loc_nGravados = 0
7462: 
7463:         IF !USED("crTpmMvItn")
7464:             RETURN .F.
7465:         ENDIF
7466: 
7467:         TRY
7468:             loc_oBO = THIS.this_oBusinessObject
7469: 
7470:             SELECT crTpmMvItn
7471:             SET ORDER TO
7472:             GO TOP
7473: 
7474:             *-- Laco explicito em vez de SCAN/ENDSCAN de proposito: Salvar()
7475:             *-- faz SQLEXEC e RegistrarAuditoria no meio da iteracao e pode

*-- Linhas 7523 a 7682:
7523:             MsgErro("Erro ao gravar os itens da venda:" + CHR(13) + ;
7524:                 loc_oErro.Message + CHR(13) + ;
7525:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
7526:                 "Procedure: " + loc_oErro.Procedure, "Confirmar")
7527:             loc_lSucesso = .F.
7528:         ENDTRY
7529: 
7530:         *-- Carrinho com produto mas nada gravado nao e sucesso: devolve .F.
7531:         *-- para o Confirmar nao anunciar venda validada sem registro no banco
7532:         *-- (CLAUDE.md #189 - nunca reportar sucesso sem ter gravado).
7533:         IF loc_lSucesso AND loc_nGravados = 0
7534:             loc_lSucesso = .F.
7535:         ENDIF
7536: 
7537:         RETURN loc_lSucesso
7538:     ENDFUNC
7539: 
7540:     *--------------------------------------------------------------------------
7541:     * CarregarLista - ponto de entrada canonico de (re)carga da tela. Este
7542:     * form nao tem pagina de LISTA de registros (nao e cadastro): o que ele
7543:     * lista e o CUPOM da venda corrente, na grade grd_4c_Cupom. Recarrega os
7544:     * itens da movimentacao pelo BO e repinta as cinco grades.
7545:     *
7546:     * Popular cursor NAO repinta grade: a chamada a AtualizarGrades e
7547:     * obrigatoria, senao a tela aparece vazia com o cursor cheio (CLAUDE.md
7548:     * #21). CarregarDados ja chama AtualizarGrades no caminho de sucesso; a
7549:     * chamada aqui cobre o caminho em que ele volta .F. (sem conexao / venda
7550:     * nova sem numero), em que as grades tambem precisam ser repintadas no
7551:     * estado vazio para o painel CAIXA LIVRE aparecer.
7552:     *--------------------------------------------------------------------------
7553:     PROCEDURE CarregarLista()
7554:         LOCAL loc_lSucesso
7555: 
7556:         loc_lSucesso = THIS.CarregarDados()
7557:         THIS.AtualizarGrades()
7558:         THIS.RecalcularTotalCarrinho()
7559: 
7560:         RETURN loc_lSucesso
7561:     ENDPROC
7562: 
7563:     *--------------------------------------------------------------------------
7564:     * HabilitarCampos - liga/desliga os campos de LANCAMENTO de item.
7565:     *
7566:     * No legado o equivalente sao as clausulas When de cada campo do
7567:     * Cnt_Produto/Cnt_Subtotal/Cnt_Desconto, que devolvem .F. (campo
7568:     * inacessivel) quando a operacao nao esta em INSERIR/ALTERAR - por exemplo
7569:     * Get_Produto.When: "InList(ThisForm.Op_Escolha,'INSERIR','ALTERAR') And
7570:     * Empty(This.Value)". Reproduzido aqui como um gate unico, porque
7571:     * BINDEVENT descarta o retorno de um When delegado e por isso nao bloqueia
7572:     * edicao (CLAUDE.md #3).
7573:     *
7574:     * Valor e desconto seguem o gate do legado: so ficam acessiveis quando a
7575:     * alteracao de preco/valor foi liberada (this_lLalterapreco /
7576:     * this_lLalteravalor), como em Get_valor.When e Get_valdesc.When.
7577:     *--------------------------------------------------------------------------
7578:     PROCEDURE HabilitarCampos(par_lHabilitar)
7579:         LOCAL loc_lHab, loc_oCnt
7580: 
7581:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
7582:         loc_oCnt = THIS.cnt_4c_Item
7583: 
7584:         loc_oCnt.cnt_4c__Produto.txt_4c_Produto.Enabled = loc_lHab
7585:         loc_oCnt.cnt_4c__Produto.txt_4c_Qtds.Enabled    = loc_lHab
7586: 
7587:         *-- Preco unitario: no legado o campo so abre com alteracao de valor
7588:         *-- liberada (Barra_Botoes.AltPreco) - fora disso o preco vem da
7589:         *-- tabela e nao se digita.
7590:         loc_oCnt.cnt_4c__Subtotal.txt_4c_Valor.Enabled = ;
7591:             (loc_lHab AND (THIS.this_lLalteravalor OR THIS.this_lLalterapreco))
7592: 
7593:         *-- Desconto/acrescimo: liberados junto com a alteracao de preco.
7594:         loc_oCnt.cnt_4c__Desconto.txt_4c_Valdesc.Enabled   = (loc_lHab AND THIS.this_lLalterapreco)
7595:         loc_oCnt.cnt_4c__Desconto.txt_4c_Pvaldesc.Enabled  = (loc_lHab AND THIS.this_lLalterapreco)
7596:         loc_oCnt.cnt_4c__Desconto.txt_4c_ValAcre.Enabled   = (loc_lHab AND THIS.this_lLalterapreco)
7597:         loc_oCnt.cnt_4c__Desconto.txt_4c__pValAcre.Enabled = (loc_lHab AND THIS.this_lLalterapreco)
7598: 
7599:         *-- Original: somente leitura no legado (Get_unival.When: Return .F.).
7600:         loc_oCnt.cnt_4c__Desconto.txt_4c_Unival.Enabled = .F.
7601: 
7602:         *-- TOTAL da venda: somente leitura no legado (Get_total.When: .F.).
7603:         loc_oCnt.txt_4c_Total.Enabled = .F.
7604:     ENDPROC
7605: 
7606:     *--------------------------------------------------------------------------
7607:     * LimparCampos - limpa os campos de lancamento de item SEM mexer no
7608:     * carrinho. Delega ao LimparCntItem(.F.), que e a transcricao do
7609:     * mLimpaCntItem legado: com .F. ele apenas zera os TextBoxes; com .T. ele
7610:     * tambem reorganiza crTpmMvItn e abre a proxima linha em branco.
7611:     *--------------------------------------------------------------------------
7612:     PROTECTED PROCEDURE LimparCampos()
7613:         THIS.LimparCntItem(.F.)
7614:     ENDPROC
7615: 
7616:     *--------------------------------------------------------------------------
7617:     * AjustarBotoesPorModo - aplica o gate de disponibilidade dos botoes da
7618:     * barra principal conforme o estado da tela. Transcrito das clausulas When
7619:     * do SCX legado (Barra_Botoes.*.When), que sao o mecanismo que o legado
7620:     * usa para isso:
7621:     *
7622:     *   Itens / identifica / credito / pendencia / Financia / Pagto:
7623:     *       "Return ( Not ThisForm.Cnt_Fpagto.Cnt_ChequepreTef.Visible )"
7624:     *       - o painel de cheque pre-datado aberto TRAVA a navegacao.
7625:     *   credito / pendencia / Financia / ok:  "... And ThisForm.Inicia"
7626:     *   identifica:  "... And (ThisForm.Inicia Or ThisForm.LiberaIdent)"
7627:     *   CancPagto:   "Return ( Cnt_Fpagto.Visible And Not Cnt_ChequepreTef.Visible )"
7628:     *   apaga:       "Return (Empty(Get_Produto.Value) And CntItem.Visible )"
7629:     *   Alteraqtd:   "Return (Empty(Get_Produto.Value) And CntItem.Visible
7630:     *                 And Get_Produto.Enabled )"
7631:     *   impfiscal:   "Return (Empty(Get_Produto.Value)
7632:     *                 And Not Cnt_ChequepreTef.Visible And Lastkey() # 13 )"
7633:     *                 - a parte "Lastkey() # 13" pertence ao When (roda a cada
7634:     *                   tentativa de foco) e nao tem sentido num ajuste de
7635:     *                   estado; o resto e transcrito.
7636:     *
7637:     * Chamado no fim de AlternarTelaOperacao, que e o FUNIL por onde toda
7638:     * troca de tela passa - quem desabilita tem de reabilitar no caminho de
7639:     * volta, senao os botoes ficam cinza e a tela fica inutilizavel (CLAUDE.md
7640:     * #40).
7641:     *--------------------------------------------------------------------------
7642:     PROCEDURE AjustarBotoesPorModo()
7643:         LOCAL loc_oCnt, loc_lChequeAberto, loc_lItensVisivel, loc_lFpagtoVisivel
7644:         LOCAL loc_lSemProduto, loc_lInicia
7645: 
7646:         loc_oCnt = THIS.cnt_4c_Barra_Botoes
7647: 
7648:         loc_lChequeAberto  = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Visible
7649:         loc_lItensVisivel  = THIS.cnt_4c_Item.Visible
7650:         loc_lFpagtoVisivel = THIS.cnt_4c__Fpagto.Visible
7651:         loc_lInicia        = THIS.this_lInicia
7652:         loc_lSemProduto    = EMPTY(ALLTRIM(NVL( ;
7653:             THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Value, "")))
7654: 
7655:         *-- Navegacao entre telas - travada com o cheque pre-datado aberto.
7656:         loc_oCnt.cmd_4c_Itens.Enabled      = !loc_lChequeAberto
7657:         loc_oCnt.cmd_4c_Identifica.Enabled = (!loc_lChequeAberto AND ;
7658:             (loc_lInicia OR THIS.this_lLiberaident))
7659:         loc_oCnt.cmd_4c_Credito.Enabled    = (!loc_lChequeAberto AND loc_lInicia)
7660:         loc_oCnt.cmd_4c_Pendencia.Enabled  = (!loc_lChequeAberto AND loc_lInicia)
7661:         loc_oCnt.cmd_4c_Financia.Enabled   = (!loc_lChequeAberto AND loc_lInicia)
7662:         loc_oCnt.cmd_4c_Pagto.Enabled      = !loc_lChequeAberto
7663: 
7664:         *-- Acoes sobre o item corrente - so com o painel de Itens na frente e
7665:         *-- nenhum produto em digitacao.
7666:         loc_oCnt.cmd_4c_Apaga.Enabled     = (loc_lSemProduto AND loc_lItensVisivel)
7667:         loc_oCnt.cmd_4c_Alteraqtd.Enabled = (loc_lSemProduto AND loc_lItensVisivel AND ;
7668:             THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Enabled)
7669: 
7670:         *-- Cancelamento de forma de pagamento - so na tela de Pagamento.
7671:         loc_oCnt.cmd_4c_CancPagto.Enabled = (loc_lFpagtoVisivel AND !loc_lChequeAberto)
7672: 
7673:         *-- Impressora fiscal.
7674:         loc_oCnt.cmd_4c_Impfiscal.Enabled = (loc_lSemProduto AND !loc_lChequeAberto)
7675: 
7676:         *-- Confirmar: no legado "Return (ThisForm.Inicia)". Cancelar fica
7677:         *-- SEMPRE disponivel (Cancel = .T. no SCX) - a saida da tela nunca
7678:         *-- pode ficar bloqueada.
7679:         loc_oCnt.cmd_4c_Ok.Enabled      = loc_lInicia
7680:         loc_oCnt.cmd_4c_Cancela.Enabled = .T.
7681:     ENDPROC
7682: 

