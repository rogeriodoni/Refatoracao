# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (64)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_BARRA_BOTOES, CNT_4C__CONSULTA, CNT_4C_ITEM, CNT_4C__CREDITO, CNT_4C_CAIXALIVRE, CNT_4C__GRDBARRA, CNT_4C__PRODUTO, CNT_4C__SUBTOTAL, CNT_4C_DESCONTO, CNT_4C__CHQ. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.HaPagamentoPendente()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.GravarItensLancados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarChequesLancados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvitn.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (7678 linhas total):

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

*-- Linhas 1745 a 1808:
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
1757:             loc_oGrd.RecordSource = "crTpmMvItnC"
1758:             WITH loc_oGrd
1759:                 .Column1.ControlSource = "crTpmMvItnC.Texto"
1760:                 .Column1.Enabled       = .F.
1761:                 .Column1.FontBold      = .T.
1762:                 .Column1.FontName      = "Courier New"
1763:                 .Column1.Movable       = .F.
1764:                 .Column1.ReadOnly      = .T.
1765:                 .Column1.ForeColor     = RGB(0, 0, 255)
1766: 
1767:                 .Column1.Text1.Enabled   = .F.
1768:                 .Column1.Text1.FontBold  = .T.
1769:                 .Column1.Text1.FontName  = "Courier New"
1770:                 .Column1.Text1.ReadOnly  = .T.
1771:                 .Column1.Text1.ForeColor = RGB(0, 0, 255)
1772:                 .Column1.Text1.Width     = 345
1773: 
1774:                 .Column1.Width = 345
1775:                 .Column1.Header1.Caption = ""
1776:             ENDWITH
1777: 
1778:             *-- DynamicForeColor do legado: a cor de cada linha do cupom vem do
1779:             *-- campo Cores (0 item, 1 totalizador, 2 forma de pagamento,
1780:             *-- 3 valor recebido, 4 troco/estorno). Montado em variavel para
1781:             *-- caber em linha e aplicado com SetAll, como no legado.
1782:             loc_cDyn = "(IIF(crTpmMvItnC.Cores=0, RGB(0,0,255), " + ;
1783:                        "IIF(crTpmMvItnC.Cores=1, RGB(0,0,160), " + ;
1784:                        "IIF(crTpmMvItnC.Cores=2, RGB(0,0,64), " + ;
1785:                        "IIF(crTpmMvItnC.Cores=3, RGB(64,0,64), RGB(255,0,0))))))"
1786:             loc_oGrd.SetAll("DynamicForeColor", loc_cDyn, "Column")
1787:         ENDIF
1788: 
1789:         *======================================================================
1790:         * Grade das PENDENCIAS / sub-niveis (TmpOperacao)
1791:         *======================================================================
1792:         IF USED("TmpOperacao")
1793:             loc_oGrd = THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
1794:             loc_oGrd.RecordSource = "TmpOperacao"
1795:             WITH loc_oGrd
1796:                 .Column1.ControlSource = "TmpOperacao.Codigos"
1797:                 .Column1.FontName      = "Verdana"
1798:                 .Column1.InputMask     = "9999999999"
1799:                 .Column1.Movable       = .F.
1800:                 .Column1.Resizable     = .F.
1801:                 .Column1.ForeColor     = RGB(36, 84, 155)
1802:                 .Column1.BackColor     = RGB(254, 255, 232)
1803:                 .Column1.Text1.FontName  = "Verdana"
1804:                 .Column1.Text1.Margin    = 0
1805:                 .Column1.Text1.ForeColor = RGB(36, 84, 155)
1806:                 .Column1.Text1.BackColor = RGB(254, 255, 232)
1807: 
1808:                 .Column2.ControlSource = "TmpOperacao.Notas"

*-- Linhas 1853 a 1873:
1853: 
1854:         *======================================================================
1855:         * Grade dos CREDITOS / devolucoes (TmpDevol)
1856:         *======================================================================
1857:         IF USED("TmpDevol")
1858:             loc_oGrd = THIS.cnt_4c__Credito.grd_4c_Devolucao
1859:             loc_oGrd.RecordSource = "TmpDevol"
1860:             WITH loc_oGrd
1861:                 *-- CurrentControl DEPOIS do RecordSource (que o devolve para
1862:                 *-- "Text1") e Sparse = .F. para o TextBox proprio aparecer em
1863:                 *-- TODAS as linhas, nao so na corrente (CLAUDE.md #18).
1864:                 .Column1.CurrentControl = "txt_4c__Devol"
1865:                 .Column1.Sparse         = .F.
1866: 
1867:                 .Column1.ControlSource = "TmpDevol.Codigos"
1868:                 .Column1.FontName      = "Courier New"
1869:                 .Column1.InputMask     = "9999999999"
1870:                 .Column1.Movable       = .F.
1871:                 .Column1.Resizable     = .F.
1872:                 .Column1.BackColor     = RGB(254, 255, 232)
1873:                 .Column1.txt_4c__Devol.FontName  = "Courier New"

*-- Linhas 1962 a 1982:
1962: 
1963:         *======================================================================
1964:         * Grade das PARCELAS / cheques pre-datados (xPar)
1965:         *======================================================================
1966:         IF USED("xPar")
1967:             loc_oGrd = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas
1968:             loc_oGrd.RecordSource = "xPar"
1969:             WITH loc_oGrd
1970:                 *-- Column1 (Condicao) e a unica ReadOnly: o legado deixa
1971:                 *-- alterar valor, vencimento e moeda da parcela, mas nunca a
1972:                 *-- forma de pagamento ja escolhida. Column.ReadOnly vem DEPOIS
1973:                 *-- de Grid.ReadOnly, senao o do grid sobrescreve o da coluna.
1974:                 .Column1.ControlSource = "xPar.FPags"
1975:                 .Column1.FontName      = "Tahoma"
1976:                 .Column1.FontSize      = 8
1977:                 .Column1.Movable       = .F.
1978:                 .Column1.Resizable     = .F.
1979:                 .Column1.ReadOnly      = .T.
1980:                 .Column1.Text1.FontName    = "Tahoma"
1981:                 .Column1.Text1.FontSize    = 8
1982:                 .Column1.Text1.BorderStyle = 0

*-- Linhas 2078 a 2195:
2078:     * as grades sao repintadas vazias - que e exatamente o estado inicial do
2079:     * legado quando o caixa abre sem operacao em andamento.
2080:     *--------------------------------------------------------------------------
2081:     PROCEDURE CarregarDados()
2082:         LOCAL loc_lSucesso, loc_oErro
2083:         loc_lSucesso = .F.
2084: 
2085:         TRY
2086:             THIS.CriarCursoresGrades()
2087: 
2088:             IF THIS.this_nNumes > 0 AND !EMPTY(THIS.this_cDopes) AND ;
2089:                     TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2090: 
2091:                 IF THIS.this_oBusinessObject.CarregarItensMovimento( ;
2092:                         THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
2093:                         "cursor_4c_ItensTmp")
2094: 
2095:                     SELECT crTpmMvItn
2096:                     ZAP
2097:                     IF USED("cursor_4c_ItensTmp") AND RECCOUNT("cursor_4c_ItensTmp") > 0
2098:                         APPEND FROM DBF("cursor_4c_ItensTmp")
2099:                     ENDIF
2100: 
2101:                     *-- Numero do proximo item = ultimo lancado, como o legado
2102:                     *-- faz no fim do Init (Goto Bottom / CItem = cItens).
2103:                     SELECT crTpmMvItn
2104:                     GO BOTTOM
2105:                     THIS.this_nCitem = IIF(RECCOUNT("crTpmMvItn") > 0, ;
2106:                         NVL(crTpmMvItn.citens, 0), 0)
2107: 
2108:                     THIS.MontarLinhasCupom()
2109: 
2110:                     IF USED("cursor_4c_ItensTmp")
2111:                         USE IN cursor_4c_ItensTmp
2112:                     ENDIF
2113:                 ENDIF
2114:             ENDIF
2115: 
2116:             THIS.MontaGrade()
2117:             THIS.AtualizarGrades()
2118: 
2119:             loc_lSucesso = .T.
2120:         CATCH TO loc_oErro
2121:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2122:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
2123:         ENDTRY
2124: 
2125:         RETURN loc_lSucesso
2126:     ENDPROC
2127: 
2128:     *--------------------------------------------------------------------------
2129:     * MontarLinhasCupom - transcreve o trecho do AtuaCupom legado que monta as
2130:     * linhas de texto de cada item no cupom, percorrendo a carga recem-feita.
2131:     *
2132:     *   linha 1: numero do item + identificacao do produto + descricao
2133:     *   linha 2: quantidade + unidade + valor unitario + total. Havendo
2134:     *            desconto/acrescimo o legado quebra em DUAS - a de quantidade
2135:     *            x valor ORIGINAL e a do ajuste com o total liquido.
2136:     *
2137:     * Regras de identificacao e descricao, iguais as do legado:
2138:     *   - IdentPro = 1 e OpCrs <> 4 -> descricao = 1a linha da Descricao
2139:     *     Fiscal do produto, truncada em 40 (fLimpaTexto tira acentuacao e
2140:     *     caracteres de controle, como no legado).
2141:     *   - caso contrario -> identifica pelo codigo de barras do item; nao
2142:     *     havendo, usa o numero da nota (quando OpCrs = 4 e a nota esta no
2143:     *     formato de 6 digitos) e, em ultimo caso, o codigo de barras do
2144:     *     cadastro do produto.
2145:     *   - a Descricao para ECF (SigCdPro.DescEcfs), quando preenchida, tem
2146:     *     precedencia sobre as duas anteriores.
2147:     * Produto sem codigo de barras em lugar nenhum e identificado pelo proprio
2148:     * codigo do produto - e o que o legado exibe quando o caixa opera sem
2149:     * impressora fiscal.
2150:     *
2151:     * Le do cursor TEMPORARIO da carga (cursor_4c_ItensTmp) porque e nele que
2152:     * vem, no mesmo SELECT, os campos do cadastro do produto; o carrinho
2153:     * (crTpmMvItn) so tem as colunas da tabela de itens, como no legado.
2154:     *--------------------------------------------------------------------------
2155:     PROTECTED PROCEDURE MontarLinhasCupom()
2156:         LOCAL loc_nIdentPro, loc_nOpCrs, loc_cDescr, loc_nCodBarra, loc_cIdent
2157:         LOCAL loc_nNotas, loc_cTexto, loc_nAreaAnt, loc_lProsseguir
2158: 
2159:         loc_lProsseguir = USED("cursor_4c_ItensTmp") AND USED("crTpmMvItnC")
2160: 
2161:         IF loc_lProsseguir
2162:             loc_nAreaAnt = SELECT()
2163: 
2164:             *-- Parametros da operacao (no legado, cursores globais CrSigOpCdd
2165:             *-- e CrSigCdOpe montados pela tela de movimentacao).
2166:             loc_nIdentPro = 0
2167:             loc_nOpCrs    = 0
2168:             IF THIS.this_oBusinessObject.CarregarParametrosOperacao( ;
2169:                     THIS.this_cDopes, "cursor_4c_ParOperacao")
2170:                 IF USED("cursor_4c_ParOperacao") AND RECCOUNT("cursor_4c_ParOperacao") > 0
2171:                     SELECT cursor_4c_ParOperacao
2172:                     GO TOP
2173:                     loc_nIdentPro = NVL(cursor_4c_ParOperacao.identpro, 0)
2174:                     loc_nOpCrs    = NVL(cursor_4c_ParOperacao.opcrs, 0)
2175:                 ENDIF
2176:                 IF USED("cursor_4c_ParOperacao")
2177:                     USE IN cursor_4c_ParOperacao
2178:                 ENDIF
2179:             ENDIF
2180: 
2181:             SELECT crTpmMvItnC
2182:             ZAP
2183: 
2184:             SELECT cursor_4c_ItensTmp
2185:             SCAN
2186:                 loc_cDescr    = NVL(cursor_4c_ItensTmp.dpros, "")
2187:                 loc_nCodBarra = 0
2188: 
2189:                 IF loc_nIdentPro = 1 AND loc_nOpCrs <> 4
2190:                     loc_cDescr = PADR(fLimpaTexto( ;
2191:                         MLINE(NVL(cursor_4c_ItensTmp.prodescfis, ""), 1)), 40)
2192:                 ELSE
2193:                     IF NVL(cursor_4c_ItensTmp.codbarras, 0) <> 0
2194:                         loc_nCodBarra = NVL(cursor_4c_ItensTmp.codbarras, 0)
2195:                     ELSE

*-- Linhas 2260 a 2482:
2260:     * ("a tela nao traz dados") manda o diagnostico para o SQL, que esta certo.
2261:     * O legado fecha assim toda carga - "Go Top In <cursor>" + "<grade>.Refresh".
2262:     *--------------------------------------------------------------------------
2263:     PROCEDURE AtualizarGrades()
2264:         IF USED("crTpmMvItnC")
2265:             GO TOP IN crTpmMvItnC
2266:             THIS.grd_4c_Cupom.Refresh()
2267:         ENDIF
2268: 
2269:         IF USED("TmpOperacao")
2270:             GO TOP IN TmpOperacao
2271:             THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Refresh()
2272:         ENDIF
2273: 
2274:         IF USED("TmpDevol")
2275:             GO TOP IN TmpDevol
2276:             THIS.cnt_4c__Credito.grd_4c_Devolucao.Refresh()
2277:         ENDIF
2278: 
2279:         IF USED("TmpBarFin")
2280:             GO TOP IN TmpBarFin
2281:             THIS.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras.Refresh()
2282:         ENDIF
2283: 
2284:         IF USED("xPar")
2285:             GO TOP IN xPar
2286:             THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas.Refresh()
2287:         ENDIF
2288: 
2289:         *-- O painel "CAIXA LIVRE" cobre a grade do cupom enquanto nao ha item
2290:         *-- lancado, exatamente como no legado (o AtuaCupom comeca escondendo-o
2291:         *-- assim que o primeiro item entra).
2292:         THIS.cnt_4c_CaixaLivre.Visible = (RECCOUNT("crTpmMvItnC") = 0)
2293:     ENDPROC
2294: 
2295:     *--------------------------------------------------------------------------
2296:     * TornarControlesVisiveis - torna visiveis os controles criados via
2297:     * AddObject (que nascem Visible=.F.), recursivamente. Containers
2298:     * flutuantes do legado (Visible=.F. por padrao, alternados por botao nas
2299:     * proximas fases) sao PULADOS aqui - mas seus FILHOS sao recursados mesmo
2300:     * assim, para nao ficarem presos ocultos quando o container for exibido
2301:     * depois (regra da skip+recursao - ver docs/CLAUDE.md).
2302:     *--------------------------------------------------------------------------
2303:     PROCEDURE TornarControlesVisiveis(par_oContainer)
2304:         LOCAL loc_nI, loc_oObjeto, loc_lOculto, loc_nP
2305: 
2306:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2307:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2308: 
2309:             IF VARTYPE(loc_oObjeto) = "O"
2310:                 *-- Controles que o SCX legado declara Visible=.F. e que sao
2311:                 *-- exibidos sob demanda (botao/fluxo) nas Fases 7-8. Ficam
2312:                 *-- ocultos, mas seus FILHOS sao recursados mesmo assim.
2313:                 loc_lOculto = INLIST(UPPER(loc_oObjeto.Name), ;
2314:                     "CNT_4C__CONSULTA", "CNT_4C_FINANC", ;
2315:                     "CNT_4C__CHEQUEPRETEF", "CNT_4C__CHQ", ;
2316:                     "CNT_4C_ACRESCIMO", "CNT_4C_DESCONTO", ;
2317:                     "CBO_4C_CMBTOPERS", "CNT_4C_CANCELAITEM", "IMG_4C_FIGJPG", ;
2318:                     "OBJ_4C_GETOBS", "LBL_4C_OBS", "CMD_4C_FINANCIA", ;
2319:                     "CMD_4C_CMDENVIAPROD")
2320: 
2321:                 IF loc_lOculto
2322:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2323:                         THIS.TornarControlesVisiveis(loc_oObjeto)
2324:                     ENDIF
2325:                     LOOP
2326:                 ENDIF
2327: 
2328:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2329:                     loc_oObjeto.Visible = .T.
2330:                 ENDIF
2331: 
2332:                 IF PEMSTATUS(loc_oObjeto, "BaseClass", 5) AND UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2333:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2334:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2335:                     ENDFOR
2336:                 ENDIF
2337: 
2338:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2339:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2340:                 ENDIF
2341:             ENDIF
2342:         ENDFOR
2343:     ENDPROC
2344: 
2345:     *--------------------------------------------------------------------------
2346:     * Destroy - fecha os cursores locais das grades, reabilita o form pai (se
2347:     * houver) e libera BO/menu (DODEFAULT chama FormBase.Destroy, que ja cuida
2348:     * do fix menu-shrinks).
2349:     *
2350:     * Os cursores sao fechados um a um porque o form vive numa DataSession
2351:     * propria mas os alias sao compartilhaveis por nome: deixar TmpOperacao /
2352:     * TmpDevol / xPar abertos faria a proxima abertura do Caixa reaproveitar o
2353:     * cursor da venda anterior (o IF !USED de CriarCursoresGrades nao recriaria
2354:     * nada) e a tela comecaria com os dados da venda que ja terminou.
2355:     *--------------------------------------------------------------------------
2356:     PROCEDURE Destroy()
2357:         LOCAL loc_oErro, loc_nI, loc_cAlias, loc_aCursores[7]
2358: 
2359:         loc_aCursores[1] = "crTpmMvItn"
2360:         loc_aCursores[2] = "crTpmMvItnC"
2361:         loc_aCursores[3] = "TmpOperacao"
2362:         loc_aCursores[4] = "TmpDevol"
2363:         loc_aCursores[5] = "TmpBarFin"
2364:         loc_aCursores[6] = "xPar"
2365:         loc_aCursores[7] = "cursor_4c_ItensTmp"
2366: 
2367:         TRY
2368:             FOR loc_nI = 1 TO ALEN(loc_aCursores)
2369:                 loc_cAlias = loc_aCursores[loc_nI]
2370:                 IF USED(loc_cAlias)
2371:                     USE IN (loc_cAlias)
2372:                 ENDIF
2373:             ENDFOR
2374: 
2375:             IF VARTYPE(THIS.this_oParentForm) = "O"
2376:                 THIS.this_oParentForm.Enabled = .T.
2377:             ENDIF
2378:         CATCH TO loc_oErro
2379:             * cursor ou form pai ja liberado - o Destroy nao pode falhar aqui,
2380:             * senao o menu principal nao e reconstruido no DODEFAULT abaixo.
2381:         ENDTRY
2382: 
2383:         DODEFAULT()
2384:     ENDPROC
2385: 
2386:     *--------------------------------------------------------------------------
2387:     * ConfigurarCamposParte1 - primeira metade dos campos de dados do form
2388:     * (FASE 5/8). Cobre os elementos auxiliares de topo (logotipo, faixas de
2389:     * mensagem), o painel "CAIXA LIVRE", o painel de cancelamento de item, o
2390:     * painel de consulta de preco (Ctrl+P) e os dois containers que ficam
2391:     * visiveis por padrao ao abrir o Caixa (CntItem e CntFinanc). A segunda
2392:     * metade (Cnt_Identifica, Cnt_Fpagto, os labels remanescentes de
2393:     * Cnt_Credito/Cnt_Pendencia e cmbTOpers) fica para a Fase 6.
2394:     *--------------------------------------------------------------------------
2395:     PROTECTED PROCEDURE ConfigurarCamposParte1()
2396:         THIS.ConfigurarCamposLogotipo()
2397:         THIS.ConfigurarCamposMensagens()
2398:         THIS.ConfigurarCamposCaixaLivre()
2399:         THIS.ConfigurarCamposCancelaItem()
2400:         THIS.ConfigurarCamposConsulta()
2401:         THIS.ConfigurarCamposItem()
2402:         THIS.ConfigurarCamposFinanc()
2403:     ENDPROC
2404: 
2405:     *--------------------------------------------------------------------------
2406:     * ConfigurarCamposLogotipo - imagem do logotipo dentro de cnt_4c__Img4c
2407:     * (container criado na Fase 3, ainda vazio).
2408:     * Original: SIGMVITN.Cnt_Img4c.figjpg - Picture=..\framework\imagens\
2409:     * 4Control_logo2.png Stretch=1 BackStyle=1 Height=218 Left=-22 Top=-59
2410:     * Width=331 BorderColor=36,84,155.
2411:     *--------------------------------------------------------------------------
2412:     PROTECTED PROCEDURE ConfigurarCamposLogotipo()
2413:         THIS.cnt_4c__Img4c.AddObject("img_4c_Figjpg", "Image")
2414:         WITH THIS.cnt_4c__Img4c.img_4c_Figjpg
2415:             .Top         = -59
2416:             .Left        = -22
2417:             .Width       = 331
2418:             .Height      = 218
2419:             .Stretch     = 1
2420:             .BackStyle   = 1
2421:             .Picture     = gc_4c_CaminhoIcones + "4Control_logo2.png"
2422:             .BorderColor = RGB(36, 84, 155)
2423:             .Visible     = .T.
2424:         ENDWITH
2425:     ENDPROC
2426: 
2427:     *--------------------------------------------------------------------------
2428:     * ConfigurarCamposMensagens - labels das duas faixas de mensagem do
2429:     * rodape (cnt_4c__Mensagem e cnt_4c_Mensagems, containers criados na
2430:     * Fase 3). O texto e atualizado em runtime pelos eventos das proximas
2431:     * fases - nasce vazio, como o proprio Cnt_Mensagem do legado (Caption="").
2432:     * Original Cnt_Mensagem.Mensagem: AutoSize=.T. FontBold=.T. FontName=
2433:     * "Verdana" FontSize=10 BackStyle=0 Height=18 Left=3 Top=2 Width=2
2434:     * ForeColor=36,84,155.
2435:     * Original Cnt_Mensagem.Abertura: AutoSize=.F., mesma fonte/cor, Height=19
2436:     * Left=317 Top=3 Width=55.
2437:     * Original mensagems.Mensage1/Mensage2: AutoSize=.F. FontBold=.T.
2438:     * FontName="Tahoma" BackStyle=0 Left=6 ForeColor=90,90,90 (Mensage1
2439:     * FontSize=13 Top=1 Height=23 Width=709; Mensage2 FontSize=16 Top=19
2440:     * Height=26 Width=709).
2441:     *--------------------------------------------------------------------------
2442:     PROTECTED PROCEDURE ConfigurarCamposMensagens()
2443:         THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Mensagem", "Label")
2444:         WITH THIS.cnt_4c__Mensagem.lbl_4c_Mensagem
2445:             .Top       = 2
2446:             .Left      = 3
2447:             .Width     = 2
2448:             .Height    = 18
2449:             .AutoSize  = .T.
2450:             .FontBold  = .T.
2451:             .FontName  = "Verdana"
2452:             .FontSize  = 10
2453:             .BackStyle = 0
2454:             .Caption   = ""
2455:             .ForeColor = RGB(36, 84, 155)
2456:             .Visible   = .T.
2457:         ENDWITH
2458: 
2459:         THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Abertura", "Label")
2460:         WITH THIS.cnt_4c__Mensagem.lbl_4c_Abertura
2461:             .Top       = 3
2462:             .Left      = 317
2463:             .Width     = 55
2464:             .Height    = 19
2465:             .AutoSize  = .F.
2466:             .FontBold  = .T.
2467:             .FontName  = "Verdana"
2468:             .FontSize  = 10
2469:             .BackStyle = 0
2470:             .Caption   = ""
2471:             .ForeColor = RGB(36, 84, 155)
2472:             .Visible   = .T.
2473:         ENDWITH
2474: 
2475:         THIS.cnt_4c_Mensagems.AddObject("lbl_4c_Mensage1", "Label")
2476:         WITH THIS.cnt_4c_Mensagems.lbl_4c_Mensage1
2477:             .Top       = 1
2478:             .Left      = 6
2479:             .Width     = 709
2480:             .Height    = 23
2481:             .AutoSize  = .F.
2482:             .FontBold  = .T.

*-- Linhas 2505 a 2619:
2505:         ENDWITH
2506:     ENDPROC
2507: 
2508:     *--------------------------------------------------------------------------
2509:     * ConfigurarCamposCaixaLivre - os dois labels sobrepostos do painel
2510:     * "CAIXA LIVRE" (cnt_4c_CaixaLivre, container ja criado). CaixaLivre2 fica
2511:     * 3px deslocado de CaixaLivre e com cor diferente - efeito de sombra do
2512:     * legado, reproduzido na mesma ordem de criacao (Z-order) do dump.
2513:     * Original CaixaLivre: FontBold=.T. FontName="Tahoma" FontSize=60
2514:     * WordWrap=.T. Alignment=2 BackStyle=0 Caption="CAIXA LIVRE" Height=216
2515:     * Left=67 Top=117 Width=336 ForeColor=255,128,64.
2516:     * Original CaixaLivre2: idem, Left=64 Top=120 ForeColor=0,64,183.
2517:     *--------------------------------------------------------------------------
2518:     PROTECTED PROCEDURE ConfigurarCamposCaixaLivre()
2519:         THIS.cnt_4c_CaixaLivre.AddObject("lbl_4c_CaixaLivre", "Label")
2520:         WITH THIS.cnt_4c_CaixaLivre.lbl_4c_CaixaLivre
2521:             .Top        = 117
2522:             .Left       = 67
2523:             .Width      = 336
2524:             .Height     = 216
2525:             .FontBold   = .T.
2526:             .FontItalic = .F.
2527:             .FontName   = "Tahoma"
2528:             .FontSize   = 60
2529:             .WordWrap   = .T.
2530:             .Alignment  = 2
2531:             .BackStyle  = 0
2532:             .Caption    = "CAIXA LIVRE"
2533:             .ForeColor  = RGB(255, 128, 64)
2534:             .Visible    = .T.
2535:         ENDWITH
2536: 
2537:         THIS.cnt_4c_CaixaLivre.AddObject("lbl_4c_CaixaLivre2", "Label")
2538:         WITH THIS.cnt_4c_CaixaLivre.lbl_4c_CaixaLivre2
2539:             .Top        = 120
2540:             .Left       = 64
2541:             .Width      = 336
2542:             .Height     = 216
2543:             .FontBold   = .T.
2544:             .FontItalic = .F.
2545:             .FontName   = "Tahoma"
2546:             .FontSize   = 60
2547:             .WordWrap   = .T.
2548:             .Alignment  = 2
2549:             .BackStyle  = 0
2550:             .Caption    = "CAIXA LIVRE"
2551:             .ForeColor  = RGB(0, 64, 183)
2552:             .Visible    = .T.
2553:         ENDWITH
2554:     ENDPROC
2555: 
2556:     *--------------------------------------------------------------------------
2557:     * ConfigurarCamposCancelaItem - conteudo do painel de cancelamento de item
2558:     * (cnt_4c_CancelaItem, container oculto criado na Fase 3 - acionado por
2559:     * cmd_4c_Apaga/cmd_4c_Excluir nas Fases 7-8). Mostra o item, produto,
2560:     * codigo de barras e descricao do item a cancelar; ok confirma e
2561:     * CancelaDisp desiste.
2562:     * Original (dump slim.txt, SIGMVITN.CancelaItem.*):
2563:     *   Label1 "CANCELAMENTO DE ITEM" Alignment=2 FontSize=10 Height=19 Left=1
2564:     *     Top=2 Width=467 ForeColor=255,255,255 BackColor=90,90,90
2565:     *   Get_Produto Format="K!" InputMask=14x"!" Height=23 Left=78 Top=56
2566:     *     Width=105 BackColor=255,255,185 ForeColor=90,90,90
2567:     *   Label2 "ITEM :" Left=38 Top=33 Width=36
2568:     *   Label3 "PRODUTO :" Left=12 Top=58 Width=62
2569:     *   Label4 "BARRA :" Left=27 Top=84 Width=47
2570:     *   Get_item InputMask="999" MaxLength=3 Height=23 Left=78 Top=31
2571:     *     Width=31 BackColor=255,255,185
2572:     *   Get_Cbarra InputMask="99999999" MaxLength=8 Height=23 Left=78 Top=81
2573:     *     Width=79 BackColor=255,255,185
2574:     *   get_dpro Height=23 Left=183 Top=56 Width=281 BackColor=255,255,185
2575:     *   ok Top=89 Left=368 W=45 H=45 Picture=mouse4.ico ToolTipText="Confirmar"
2576:     *   CancelaDisp Top=89 Left=414 W=45 H=45 Picture="shut down.ico"
2577:     *     Cancel=.T. ToolTipText="Cancelar"
2578:     *--------------------------------------------------------------------------
2579:     PROTECTED PROCEDURE ConfigurarCamposCancelaItem()
2580:         LOCAL loc_cIcones, loc_oCnt
2581:         loc_cIcones = gc_4c_CaminhoIcones
2582:         loc_oCnt    = THIS.cnt_4c_CancelaItem
2583: 
2584:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
2585:         WITH loc_oCnt.lbl_4c_Label1
2586:             .Top            = 2
2587:             .Left           = 1
2588:             .Width          = 467
2589:             .Height         = 19
2590:             .FontBold       = .T.
2591:             .FontName       = "Tahoma"
2592:             .FontSize       = 10
2593:             .FontUnderline  = .F.
2594:             .Alignment      = 2
2595:             .BackStyle      = 1
2596:             .Caption        = "CANCELAMENTO DE ITEM"
2597:             .ForeColor      = RGB(255, 255, 255)
2598:             .BackColor      = RGB(90, 90, 90)
2599:             .Visible        = .T.
2600:         ENDWITH
2601: 
2602:         loc_oCnt.AddObject("txt_4c_Produto", "TextBox")
2603:         WITH loc_oCnt.txt_4c_Produto
2604:             .Top           = 56
2605:             .Left          = 78
2606:             .Width         = 105
2607:             .Height        = 23
2608:             .FontBold      = .T.
2609:             .FontName      = "Tahoma"
2610:             .FontSize      = 8
2611:             .Format        = "K!"
2612:             .InputMask     = "!!!!!!!!!!!!!!"
2613:             .MaxLength     = 14
2614:             .SpecialEffect = 1
2615:             .ForeColor     = RGB(90, 90, 90)
2616:             .BackColor     = RGB(255, 255, 185)
2617:             .Value         = ""
2618:             .Visible       = .T.
2619:         ENDWITH

*-- Linhas 2736 a 2757:
2736:             .BackColor   = RGB(255, 255, 255)
2737:             .Themes      = .F.
2738:             .Visible     = .T.
2739:         ENDWITH
2740: 
2741:         loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
2742:         WITH loc_oCnt.cmd_4c_CancelaDisp
2743:             .Top         = 89
2744:             .Left        = 414
2745:             .Width       = 45
2746:             .Height      = 45
2747:             .FontBold    = .T.
2748:             .FontItalic  = .T.
2749:             .FontName    = "Comic Sans MS"
2750:             .FontSize    = 8
2751:             .Picture     = loc_cIcones + "shut down.ico"
2752:             .Cancel      = .T.
2753:             .Caption     = ""
2754:             .ToolTipText = "Cancelar"
2755:             .ForeColor   = RGB(90, 90, 90)
2756:             .BackColor   = RGB(255, 255, 255)
2757:             .Themes      = .F.

*-- Linhas 2787 a 2830:
2787:     *     Height=46 Left=37 Top=318 Width=249 BorderColor=100,100,100
2788:     *   Proximo Top=319 Left=319 W=45 H=45 Picture=b_arrow2.bmp
2789:     *--------------------------------------------------------------------------
2790:     PROTECTED PROCEDURE ConfigurarCamposConsulta()
2791:         LOCAL loc_cIcones, loc_oCnt, loc_oSub
2792:         loc_cIcones = gc_4c_CaminhoIcones
2793:         loc_oCnt    = THIS.cnt_4c__Consulta
2794: 
2795:         loc_oCnt.AddObject("lbl_4c_Say1", "Label")
2796:         WITH loc_oCnt.lbl_4c_Say1
2797:             .Top       = 277
2798:             .Left      = 34
2799:             .FontBold  = .T.
2800:             .FontName  = "Tahoma"
2801:             .FontSize  = 25
2802:             .Caption   = "Pre" + CHR(231) + "o Unit" + CHR(225) + "rio"
2803:             .ForeColor = RGB(90, 90, 90)
2804:             .Visible   = .T.
2805:         ENDWITH
2806: 
2807:         loc_oCnt.AddObject("cnt_4c__Produto", "Container")
2808:         loc_oSub = loc_oCnt.cnt_4c__Produto
2809:         WITH loc_oSub
2810:             .Top           = 62
2811:             .Left          = 7
2812:             .Width         = 361
2813:             .Height        = 64
2814:             .BackStyle     = 1
2815:             .BorderWidth   = 1
2816:             .SpecialEffect = 2
2817:             .BackColor     = RGB(255, 255, 255)
2818:             .Visible       = .T.
2819:         ENDWITH
2820: 
2821:         loc_oSub.AddObject("txt_4c_Produto", "TextBox")
2822:         WITH loc_oSub.txt_4c_Produto
2823:             .Top       = 28
2824:             .Left      = 39
2825:             .Width     = 178
2826:             .Height    = 30
2827:             .FontBold  = .T.
2828:             .FontName  = "Tahoma"
2829:             .FontSize  = 15
2830:             .Format    = "K!"

*-- Linhas 2936 a 2957:
2936:             .BackColor     = RGB(255, 255, 255)
2937:             .BorderColor   = RGB(100, 100, 100)
2938:             .Visible       = .T.
2939:         ENDWITH
2940: 
2941:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
2942:         WITH loc_oCnt.cmd_4c_Proximo
2943:             .Top           = 319
2944:             .Left          = 319
2945:             .Width         = 45
2946:             .Height        = 45
2947:             .FontName      = "Verdana"
2948:             .FontSize      = 8
2949:             .Picture       = loc_cIcones + "b_arrow2.bmp"
2950:             .Caption       = ""
2951:             .ToolTipText   = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
2952:             .SpecialEffect = 0
2953:             .ForeColor     = RGB(36, 84, 155)
2954:             .BackColor     = RGB(255, 255, 255)
2955:             .Themes        = .F.
2956:             .Visible       = .T.
2957:         ENDWITH

*-- Linhas 3010 a 3053:
3010:     *   Proximo Top=370 Left=323 W=45 H=45 Picture=b_arrow2.bmp
3011:     *   Say8 (filho direto de CntItem) "TOTAL" FontSize=25 Left=61 Top=330
3012:     *--------------------------------------------------------------------------
3013:     PROTECTED PROCEDURE ConfigurarCamposItem()
3014:         LOCAL loc_cIcones, loc_oCnt, loc_oSub
3015:         loc_cIcones = gc_4c_CaminhoIcones
3016:         loc_oCnt    = THIS.cnt_4c_Item
3017: 
3018:         loc_oCnt.AddObject("txt_4c_Total", "TextBox")
3019:         WITH loc_oCnt.txt_4c_Total
3020:             .Top           = 369
3021:             .Left          = 62
3022:             .Width         = 249
3023:             .Height        = 46
3024:             .FontBold      = .T.
3025:             .FontName      = "Verdana"
3026:             .FontSize      = 22
3027:             .Alignment     = 3
3028:             .Value         = 0
3029:             .InputMask     = "9,999,999.99"
3030:             .SpecialEffect = 1
3031:             .BackColor     = RGB(255, 255, 255)
3032:             .Visible       = .T.
3033:         ENDWITH
3034: 
3035:         *-- Cnt_Produto: codigo do produto + quantidade.
3036:         loc_oCnt.AddObject("cnt_4c__Produto", "Container")
3037:         loc_oSub = loc_oCnt.cnt_4c__Produto
3038:         WITH loc_oSub
3039:             .Top           = 8
3040:             .Left          = 7
3041:             .Width         = 360
3042:             .Height        = 92
3043:             .BackStyle     = 1
3044:             .BorderWidth   = 1
3045:             .SpecialEffect = 2
3046:             .BackColor     = RGB(255, 255, 255)
3047:             .Visible       = .T.
3048:         ENDWITH
3049: 
3050:         loc_oSub.AddObject("txt_4c_Produto", "TextBox")
3051:         WITH loc_oSub.txt_4c_Produto
3052:             .Top       = 26
3053:             .Left      = 24

*-- Linhas 3107 a 3150:
3107:         *-- CmdEnviaProd: so aparece quando o legado exige confirmacao manual
3108:         *-- do produto identificado por codigo de barras (leitura ambigua) -
3109:         *-- nasce oculto, como no dump, e entra na skip-list de
3110:         *-- TornarControlesVisiveis.
3111:         loc_oSub.AddObject("cmd_4c_CmdEnviaProd", "CommandButton")
3112:         WITH loc_oSub.cmd_4c_CmdEnviaProd
3113:             .Top             = 58
3114:             .Left            = 203
3115:             .Width           = 104
3116:             .Height          = 29
3117:             .FontBold        = .T.
3118:             .FontItalic      = .T.
3119:             .FontName        = "Comic Sans MS"
3120:             .FontSize        = 8
3121:             .Picture         = loc_cIcones + "b_print2.bmp"
3122:             .Caption         = "\<Confirmar"
3123:             .ToolTipText     = "Confirma o Produto Informado"
3124:             .PicturePosition = 1
3125:             .ForeColor       = RGB(90, 90, 90)
3126:             .BackColor       = RGB(255, 255, 255)
3127:             .Themes          = .F.
3128:             .Visible         = .F.
3129:         ENDWITH
3130: 
3131:         *-- Cnt_Subtotal: valor unitario do item (subtotal antes de
3132:         *-- desconto/acrescimo).
3133:         loc_oCnt.AddObject("cnt_4c__Subtotal", "Container")
3134:         loc_oSub = loc_oCnt.cnt_4c__Subtotal
3135:         WITH loc_oSub
3136:             .Top           = 266
3137:             .Left          = 7
3138:             .Width         = 360
3139:             .Height        = 46
3140:             .BorderWidth   = 1
3141:             .SpecialEffect = 2
3142:             .BackColor     = RGB(255, 255, 255)
3143:             .Visible       = .T.
3144:         ENDWITH
3145: 
3146:         loc_oSub.AddObject("txt_4c_Valor", "TextBox")
3147:         WITH loc_oSub.txt_4c_Valor
3148:             .Top       = 8
3149:             .Left      = 160
3150:             .Width     = 161

*-- Linhas 3362 a 3383:
3362:             .ForeColor = RGB(90, 90, 90)
3363:             .Visible   = .T.
3364:         ENDWITH
3365: 
3366:         *-- Proximo: avanca para a tela de pagamento.
3367:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
3368:         WITH loc_oCnt.cmd_4c_Proximo
3369:             .Top           = 370
3370:             .Left          = 323
3371:             .Width         = 45
3372:             .Height        = 45
3373:             .FontName      = "Verdana"
3374:             .FontSize      = 8
3375:             .Picture       = loc_cIcones + "b_arrow2.bmp"
3376:             .Caption       = ""
3377:             .ToolTipText   = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
3378:             .SpecialEffect = 0
3379:             .ForeColor     = RGB(36, 84, 155)
3380:             .BackColor     = RGB(255, 255, 255)
3381:             .Themes        = .F.
3382:             .Visible       = .T.
3383:         ENDWITH

*-- Linhas 3428 a 3471:
3428:     *     alcance com DataSession=2 isolado (mesma decisao das Fases 1-4); o
3429:     *     valor e populado por evento nas Fases 7-8.
3430:     *--------------------------------------------------------------------------
3431:     PROTECTED PROCEDURE ConfigurarCamposFinanc()
3432:         LOCAL loc_cIcones, loc_oCnt, loc_oSub
3433:         loc_cIcones = gc_4c_CaminhoIcones
3434:         loc_oCnt    = THIS.cnt_4c_Financ
3435: 
3436:         loc_oCnt.AddObject("shp_4c_Shape4", "Shape")
3437:         WITH loc_oCnt.shp_4c_Shape4
3438:             .Top           = 349
3439:             .Left          = 0
3440:             .Width         = 370
3441:             .Height        = 3
3442:             .SpecialEffect = 0
3443:             .Visible       = .T.
3444:         ENDWITH
3445: 
3446:         loc_oCnt.AddObject("cnt_4c__Barras", "Container")
3447:         loc_oSub = loc_oCnt.cnt_4c__Barras
3448:         WITH loc_oSub
3449:             .Top           = 57
3450:             .Left          = 4
3451:             .Width         = 368
3452:             .Height        = 125
3453:             .BackStyle     = 1
3454:             .BorderWidth   = 1
3455:             .SpecialEffect = 2
3456:             .BackColor     = RGB(255, 255, 255)
3457:             .Visible       = .T.
3458:         ENDWITH
3459: 
3460:         loc_oSub.AddObject("img_4c_Image1", "Image")
3461:         WITH loc_oSub.img_4c_Image1
3462:             .Top       = 34
3463:             .Left      = 14
3464:             .Width     = 25
3465:             .Height    = 25
3466:             .Picture   = loc_cIcones + "b_arrow2.bmp"
3467:             .BackStyle = 0
3468:             .Visible   = .T.
3469:         ENDWITH
3470: 
3471:         loc_oSub.AddObject("img_4c_Image2", "Image")

*-- Linhas 3525 a 3546:
3525:             .DisabledBackColor = RGB(128, 128, 128)
3526:             .Value             = ""
3527:             .Visible           = .T.
3528:         ENDWITH
3529: 
3530:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
3531:         WITH loc_oCnt.cmd_4c_Proximo
3532:             .Top           = 353
3533:             .Left          = 320
3534:             .Width         = 45
3535:             .Height        = 45
3536:             .FontName      = "Verdana"
3537:             .FontSize      = 8
3538:             .Picture       = loc_cIcones + "b_arrow2.bmp"
3539:             .Caption       = ""
3540:             .SpecialEffect = 0
3541:             .ForeColor     = RGB(36, 84, 155)
3542:             .BackColor     = RGB(255, 255, 255)
3543:             .Themes        = .F.
3544:             .Visible       = .T.
3545:         ENDWITH
3546: 

*-- Linhas 3597 a 3683:
3597:     * Cnt_Identifica (COMPLETO, com todos os lookups Grupo/Conta/Cpf) e
3598:     * Cnt_Fpagto (COMPLETO, incluindo Cnt_ChequepreTef.Cnt_Chq) + cmbTOpers.
3599:     *--------------------------------------------------------------------------
3600:     PROTECTED PROCEDURE ConfigurarCamposParte2()
3601:         THIS.ConfigurarCamposCreditoPendencia()
3602:         THIS.ConfigurarCamposIdentifica()
3603:         THIS.ConfigurarCamposFpagto()
3604:         THIS.ConfigurarComboOperacao()
3605:     ENDPROC
3606: 
3607:     *--------------------------------------------------------------------------
3608:     * ConfigurarCamposCreditoPendencia - labels/botoes remanescentes de
3609:     * Cnt_Credito e Cnt_Pendencia. As grades (grd_4c_Devolucao/grd_4c_SubNiveis)
3610:     * e o cmd_4c_BotPend ja foram criados na Fase 4
3611:     * (ConfigurarGradesOperacao) - aqui so falta o botao "Proximo" (navegacao
3612:     * ENTER) e o label de instrucao de cada container.
3613:     *--------------------------------------------------------------------------
3614:     PROTECTED PROCEDURE ConfigurarCamposCreditoPendencia()
3615:         LOCAL loc_cIcones
3616:         loc_cIcones = gc_4c_CaminhoIcones
3617: 
3618:         THIS.cnt_4c__Credito.AddObject("cmd_4c_Proximo", "CommandButton")
3619:         WITH THIS.cnt_4c__Credito.cmd_4c_Proximo
3620:             .Top         = 394
3621:             .Left        = 325
3622:             .Width       = 45
3623:             .Height      = 45
3624:             .FontName    = "Verdana"
3625:             .FontSize    = 8
3626:             .Picture     = loc_cIcones + "b_arrow2.bmp"
3627:             .Caption     = ""
3628:             .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
3629:             .ForeColor   = RGB(36, 84, 155)
3630:             .BackColor   = RGB(255, 255, 255)
3631:             .Themes      = .F.
3632:             .Visible     = .T.
3633:         ENDWITH
3634: 
3635:         THIS.cnt_4c__Credito.AddObject("lbl_4c_Label2", "Label")
3636:         WITH THIS.cnt_4c__Credito.lbl_4c_Label2
3637:             .Top       = 422
3638:             .Left      = 194
3639:             .Width     = 135
3640:             .Height    = 16
3641:             .AutoSize  = .T.
3642:             .FontBold  = .T.
3643:             .FontName  = "Tahoma"
3644:             .BackStyle = 0
3645:             .Caption   = "[ENTER] Muda de Tela"
3646:             .ForeColor = RGB(90, 90, 90)
3647:             .Visible   = .T.
3648:         ENDWITH
3649: 
3650:         THIS.cnt_4c__Pendencia.AddObject("cmd_4c_Proximo", "CommandButton")
3651:         WITH THIS.cnt_4c__Pendencia.cmd_4c_Proximo
3652:             .Top         = 382
3653:             .Left        = 311
3654:             .Width       = 45
3655:             .Height      = 45
3656:             .FontName    = "Verdana"
3657:             .FontSize    = 8
3658:             .Picture     = loc_cIcones + "b_arrow2.bmp"
3659:             .Caption     = ""
3660:             .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
3661:             .ForeColor   = RGB(36, 84, 155)
3662:             .BackColor   = RGB(255, 255, 255)
3663:             .Themes      = .F.
3664:             .Visible     = .T.
3665:         ENDWITH
3666: 
3667:         THIS.cnt_4c__Pendencia.AddObject("lbl_4c_Label2", "Label")
3668:         WITH THIS.cnt_4c__Pendencia.lbl_4c_Label2
3669:             .Top       = 413
3670:             .Left      = 168
3671:             .Width     = 135
3672:             .Height    = 16
3673:             .AutoSize  = .T.
3674:             .FontBold  = .T.
3675:             .FontName  = "Tahoma"
3676:             .BackStyle = 0
3677:             .Caption   = "[ENTER] Muda de Tela"
3678:             .ForeColor = RGB(90, 90, 90)
3679:             .Visible   = .T.
3680:         ENDWITH
3681:     ENDPROC
3682: 
3683:     *--------------------------------------------------------------------------

*-- Linhas 3690 a 3741:
3690:     *
3691:     * LOOKUPS (originais fAcessoContab/fAcessoContas/fwBuscaExt - PROIBIDOS de
3692:     * usar direto, CLAUDE.md "fAcessoContas() lookup UX" e "fAcessoEmpresa()
3693:     * NAO EXISTE"): substituidos pelo padrao canonico FormBuscaAuxiliar
3694:     * (CLAUDE.md #36/#37) via os metodos AbrirLookupGrupo/AbrirLookupConta,
3695:     * acionados em ENTER/TAB/F4 (BINDEVENT "KeyPress" - CLAUDE.md #84, Valid
3696:     * nao dispara em TextBox). Grupo -> SigCdGcr (codigos/descrs). Conta ->
3697:     * SigCdCli (iclis/rclis/cpfs/grupos - NAO grclis, CLAUDE.md regra
3698:     * "SigCdCli tem coluna grupos, nao grclis"), filtrada pelo Grupo quando
3699:     * preenchido.
3700:     *--------------------------------------------------------------------------
3701:     PROTECTED PROCEDURE ConfigurarCamposIdentifica()
3702:         LOCAL loc_oCnt, loc_oSub
3703: 
3704:         loc_oCnt = THIS.cnt_4c__Identifica
3705: 
3706:         *======================================================================
3707:         * Destino
3708:         *======================================================================
3709:         loc_oCnt.AddObject("cnt_4c_Destino", "Container")
3710:         loc_oSub = loc_oCnt.cnt_4c_Destino
3711:         WITH loc_oSub
3712:             .Top           = 168
3713:             .Left          = 2
3714:             .Width         = 371
3715:             .Height        = 94
3716:             .BackStyle     = 1
3717:             .BorderWidth   = 1
3718:             .SpecialEffect = 2
3719:             .TabIndex      = 4
3720:             .BackColor     = RGB(255, 255, 255)
3721:             .Visible       = .T.
3722:         ENDWITH
3723: 
3724:         loc_oSub.AddObject("lbl_4c_Label4", "Label")
3725:         WITH loc_oSub.lbl_4c_Label4
3726:             .Top       = 2
3727:             .Left      = 10
3728:             .Width     = 45
3729:             .Height    = 15
3730:             .FontBold  = .T.
3731:             .FontName  = "Tahoma"
3732:             .FontSize  = 8
3733:             .BackStyle = 0
3734:             .Caption   = "Destino"
3735:             .ForeColor = RGB(90, 90, 90)
3736:             .TabIndex  = 26
3737:             .Visible   = .T.
3738:         ENDWITH
3739: 
3740:         loc_oSub.AddObject("lin_4c_Line1", "Line")
3741:         WITH loc_oSub.lin_4c_Line1

*-- Linhas 3890 a 3936:
3890:             .Visible       = .T.
3891:         ENDWITH
3892: 
3893:         BINDEVENT(loc_oSub.txt_4c_Grupo, "KeyPress", THIS, "GrpDestinoKeyPress")
3894:         BINDEVENT(loc_oSub.txt_4c_Conta, "KeyPress", THIS, "CtaDestinoKeyPress")
3895:         BINDEVENT(loc_oSub.txt_4c_Dconta, "KeyPress", THIS, "DctDestinoKeyPress")
3896:         BINDEVENT(loc_oSub.txt_4c_Cpf, "KeyPress", THIS, "CpfDestinoKeyPress")
3897: 
3898:         *======================================================================
3899:         * Responsavel
3900:         *======================================================================
3901:         loc_oCnt.AddObject("cnt_4c_Responsavel", "Container")
3902:         loc_oSub = loc_oCnt.cnt_4c_Responsavel
3903:         WITH loc_oSub
3904:             .Top           = 356
3905:             .Left          = 2
3906:             .Width         = 371
3907:             .Height        = 94
3908:             .BackStyle     = 1
3909:             .BorderWidth   = 1
3910:             .SpecialEffect = 2
3911:             .TabIndex      = 6
3912:             .BackColor     = RGB(255, 255, 255)
3913:             .Visible       = .T.
3914:         ENDWITH
3915: 
3916:         loc_oSub.AddObject("lbl_4c_label42", "Label")
3917:         WITH loc_oSub.lbl_4c_label42
3918:             .Top       = 2
3919:             .Left      = 10
3920:             .Width     = 74
3921:             .Height    = 15
3922:             .FontBold  = .T.
3923:             .FontName  = "Tahoma"
3924:             .FontSize  = 8
3925:             .BackStyle = 0
3926:             .Caption   = "Respons" + CHR(225) + "vel"
3927:             .ForeColor = RGB(90, 90, 90)
3928:             .TabIndex  = 26
3929:             .Visible   = .T.
3930:         ENDWITH
3931: 
3932:         loc_oSub.AddObject("lin_4c_line12", "Line")
3933:         WITH loc_oSub.lin_4c_line12
3934:             .Top         = 17
3935:             .Left        = 10
3936:             .Width       = 320

*-- Linhas 4065 a 4111:
4065:             .Visible           = .T.
4066:         ENDWITH
4067: 
4068:         BINDEVENT(loc_oSub.txt_4c_Grupo, "KeyPress", THIS, "GrpRespKeyPress")
4069:         BINDEVENT(loc_oSub.txt_4c_Conta, "KeyPress", THIS, "CtaRespKeyPress")
4070:         BINDEVENT(loc_oSub.txt_4c_Dconta, "KeyPress", THIS, "DctRespKeyPress")
4071:         BINDEVENT(loc_oSub.txt_4c_Cpf, "KeyPress", THIS, "CpfRespKeyPress")
4072: 
4073:         *======================================================================
4074:         * Vendedor
4075:         *======================================================================
4076:         loc_oCnt.AddObject("cnt_4c_Vendedor", "Container")
4077:         loc_oSub = loc_oCnt.cnt_4c_Vendedor
4078:         WITH loc_oSub
4079:             .Top           = 262
4080:             .Left          = 2
4081:             .Width         = 371
4082:             .Height        = 94
4083:             .BackStyle     = 1
4084:             .BorderWidth   = 1
4085:             .SpecialEffect = 2
4086:             .TabIndex      = 5
4087:             .BackColor     = RGB(255, 255, 255)
4088:             .Visible       = .T.
4089:         ENDWITH
4090: 
4091:         loc_oSub.AddObject("lbl_4c_label43", "Label")
4092:         WITH loc_oSub.lbl_4c_label43
4093:             .Top       = 2
4094:             .Left      = 10
4095:             .Width     = 56
4096:             .Height    = 15
4097:             .FontBold  = .T.
4098:             .FontName  = "Tahoma"
4099:             .FontSize  = 8
4100:             .BackStyle = 0
4101:             .Caption   = "Vendedor"
4102:             .ForeColor = RGB(90, 90, 90)
4103:             .TabIndex  = 26
4104:             .Visible   = .T.
4105:         ENDWITH
4106: 
4107:         loc_oSub.AddObject("lin_4c_line13", "Line")
4108:         WITH loc_oSub.lin_4c_line13
4109:             .Top         = 17
4110:             .Left        = 10
4111:             .Width       = 315

*-- Linhas 4240 a 4286:
4240:             .Visible           = .T.
4241:         ENDWITH
4242: 
4243:         BINDEVENT(loc_oSub.txt_4c_Grupo, "KeyPress", THIS, "GrpVendKeyPress")
4244:         BINDEVENT(loc_oSub.txt_4c_Conta, "KeyPress", THIS, "CtaVendKeyPress")
4245:         BINDEVENT(loc_oSub.txt_4c_Dconta, "KeyPress", THIS, "DctVendKeyPress")
4246:         BINDEVENT(loc_oSub.txt_4c_Cpf, "KeyPress", THIS, "CpfVendKeyPress")
4247: 
4248:         *======================================================================
4249:         * TabDesconto
4250:         *======================================================================
4251:         loc_oCnt.AddObject("cnt_4c_TabDesconto", "Container")
4252:         loc_oSub = loc_oCnt.cnt_4c_TabDesconto
4253:         WITH loc_oSub
4254:             .Top           = 33
4255:             .Left          = 2
4256:             .Width         = 371
4257:             .Height        = 41
4258:             .BackStyle     = 1
4259:             .BorderWidth   = 1
4260:             .SpecialEffect = 2
4261:             .TabIndex      = 2
4262:             .BackColor     = RGB(255, 255, 255)
4263:             .Visible       = .T.
4264:         ENDWITH
4265: 
4266:         loc_oSub.AddObject("lbl_4c_Label1", "Label")
4267:         WITH loc_oSub.lbl_4c_Label1
4268:             .Top       = 4
4269:             .Left      = 10
4270:             .FontBold  = .T.
4271:             .FontName  = "Tahoma"
4272:             .FontSize  = 8
4273:             .BackStyle = 0
4274:             .Caption   = "Tab. Desconto"
4275:             .ForeColor = RGB(90, 90, 90)
4276:             .TabIndex  = 4
4277:             .Visible   = .T.
4278:         ENDWITH
4279: 
4280:         loc_oSub.AddObject("txt_4c_Tabd", "TextBox")
4281:         WITH loc_oSub.txt_4c_Tabd
4282:             .Top           = 18
4283:             .Left          = 10
4284:             .Width         = 80
4285:             .Height        = 20
4286:             .FontName      = "Tahoma"

*-- Linhas 4323 a 4367:
4323:             .Visible   = .T.
4324:         ENDWITH
4325: 
4326:         BINDEVENT(loc_oSub.txt_4c_Tabd, "KeyPress", THIS, "TabdKeyPress")
4327:         BINDEVENT(loc_oSub.txt_4c_ListaPreco, "KeyPress", THIS, "ListaPrecoKeyPress")
4328: 
4329:         *======================================================================
4330:         * CodOperacao
4331:         *======================================================================
4332:         loc_oCnt.AddObject("cnt_4c_CodOperacao", "Container")
4333:         loc_oSub = loc_oCnt.cnt_4c_CodOperacao
4334:         WITH loc_oSub
4335:             .Top           = 2
4336:             .Left          = 2
4337:             .Width         = 371
4338:             .Height        = 31
4339:             .BorderWidth   = 1
4340:             .SpecialEffect = 2
4341:             .TabIndex      = 2
4342:             .BackColor     = RGB(255, 255, 255)
4343:             .Visible       = .T.
4344:         ENDWITH
4345: 
4346:         loc_oSub.AddObject("lbl_4c_label12", "Label")
4347:         WITH loc_oSub.lbl_4c_label12
4348:             .Top       = 8
4349:             .Left      = 9
4350:             .FontBold  = .T.
4351:             .FontName  = "Tahoma"
4352:             .FontSize  = 8
4353:             .BackStyle = 0
4354:             .Caption   = "Documento : "
4355:             .ForeColor = RGB(90, 90, 90)
4356:             .TabIndex  = 4
4357:             .Visible   = .T.
4358:         ENDWITH
4359: 
4360:         loc_oSub.AddObject("txt_4c_Codigo", "TextBox")
4361:         WITH loc_oSub.txt_4c_Codigo
4362:             .Top           = 4
4363:             .Left          = 94
4364:             .Width         = 61
4365:             .Height        = 23
4366:             .FontBold      = .T.
4367:             .FontName      = "Tahoma"

*-- Linhas 4593 a 4672:
4593:             .Visible       = .T.
4594:         ENDWITH
4595: 
4596:         BINDEVENT(loc_oSub.txt_4c_Grupo, "KeyPress", THIS, "GrpOrigKeyPress")
4597:         BINDEVENT(loc_oSub.txt_4c_Conta, "KeyPress", THIS, "CtaOrigKeyPress")
4598:         BINDEVENT(loc_oSub.txt_4c_Dconta, "KeyPress", THIS, "DctOrigKeyPress")
4599:         BINDEVENT(loc_oSub.txt_4c_Cpf, "KeyPress", THIS, "CpfOrigKeyPress")
4600: 
4601:         *======================================================================
4602:         * Proximo (navegacao ENTER, filho direto de Cnt_Identifica)
4603:         *======================================================================
4604:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
4605:         WITH loc_oCnt.cmd_4c_Proximo
4606:             .Top         = 400
4607:             .Left        = 324
4608:             .Width       = 45
4609:             .Height      = 45
4610:             .FontName    = "Verdana"
4611:             .FontSize    = 8
4612:             .Picture     = gc_4c_CaminhoIcones + "b_arrow2.bmp"
4613:             .Caption     = ""
4614:             .ForeColor   = RGB(36, 84, 155)
4615:             .BackColor   = RGB(255, 255, 255)
4616:             .Themes      = .F.
4617:             .Visible     = .T.
4618:         ENDWITH
4619:     ENDPROC
4620: 
4621:     *--------------------------------------------------------------------------
4622:     * ConfigurarCamposFpagto - Cnt_Fpagto (F11 Pagto): forma de pagamento,
4623:     * parcelamento, vencimento, acrescimo/desconto e o painel de conferencia
4624:     * de cheque pre-datado/TEF (Cnt_ChequepreTef.Cnt_Chq). O container
4625:     * cnt_4c__ChequepreTef e o grd_4c_Parcelas ja foram criados na Fase 4
4626:     * (ConfigurarGradesOperacao) - aqui so falta o Cnt_Chq interno.
4627:     *
4628:     * LOOKUP: Get_fpg (forma de pagamento, original CreateObject('fwBuscaSel',
4629:     * 'ccSigOpFp', 'FPags', ...)) -> SigOpFp (fpags/descrs/fparcs), mesmo
4630:     * padrao FormBuscaAuxiliar dos demais lookups deste form.
4631:     *--------------------------------------------------------------------------
4632:     PROTECTED PROCEDURE ConfigurarCamposFpagto()
4633:         LOCAL loc_oCnt, loc_oSub, loc_oChq
4634: 
4635:         loc_oCnt = THIS.cnt_4c__Fpagto
4636: 
4637:         *======================================================================
4638:         * Acrescimo (Visible=.F. no legado - so aparece via Barra_Botoes.
4639:         * Acrescimo, Click e evento de Fase 7-8)
4640:         *======================================================================
4641:         loc_oCnt.AddObject("cnt_4c_Acrescimo", "Container")
4642:         loc_oSub = loc_oCnt.cnt_4c_Acrescimo
4643:         WITH loc_oSub
4644:             .Top         = 31
4645:             .Left        = 17
4646:             .Width       = 303
4647:             .Height      = 52
4648:             .BackStyle   = 1
4649:             .BorderWidth = 1
4650:             .TabIndex    = 3
4651:             .BackColor   = RGB(255, 255, 255)
4652:             .Visible     = .F.
4653:         ENDWITH
4654: 
4655:         loc_oSub.AddObject("txt_4c_TotVariacao", "TextBox")
4656:         WITH loc_oSub.txt_4c_TotVariacao
4657:             .Top           = 25
4658:             .Left          = 117
4659:             .Width         = 185
4660:             .Height        = 24
4661:             .FontBold      = .T.
4662:             .FontName      = "Tahoma"
4663:             .FontSize      = 14
4664:             .Alignment     = 3
4665:             .Margin        = 0
4666:             .InputMask     = "999,999,999.99"
4667:             .SpecialEffect = 1
4668:             .TabIndex      = 43
4669:             .ForeColor     = RGB(90, 90, 90)
4670:             .BackColor     = RGB(255, 255, 255)
4671:             .Value         = 0
4672:             .Visible       = .T.

*-- Linhas 5100 a 5121:
5100:             .ForeColor = RGB(90, 90, 90)
5101:             .TabIndex  = 22
5102:             .Visible   = .T.
5103:         ENDWITH
5104: 
5105:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
5106:         WITH loc_oCnt.cmd_4c_Proximo
5107:             .Top         = 308
5108:             .Left        = 324
5109:             .Width       = 45
5110:             .Height      = 45
5111:             .FontName    = "Verdana"
5112:             .FontSize    = 8
5113:             .Picture     = gc_4c_CaminhoIcones + "b_arrow1.bmp"
5114:             .Caption     = ""
5115:             .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
5116:             .TabIndex    = 26
5117:             .ForeColor   = RGB(36, 84, 155)
5118:             .BackColor   = RGB(255, 255, 255)
5119:             .Themes      = .F.
5120:             .Visible     = .T.
5121:         ENDWITH

*-- Linhas 5216 a 5301:
5216:             .Visible       = .T.
5217:         ENDWITH
5218: 
5219:         BINDEVENT(loc_oCnt.txt_4c_Fpg, "KeyPress", THIS, "FpgKeyPress")
5220: 
5221:         *======================================================================
5222:         * Cnt_ChequepreTef.Cnt_Chq - conferencia de cheque pre-datado/TEF
5223:         *======================================================================
5224:         loc_oChq = loc_oCnt.cnt_4c__ChequepreTef
5225:         loc_oChq.AddObject("cnt_4c__Chq", "Container")
5226:         loc_oSub = loc_oChq.cnt_4c__Chq
5227:         WITH loc_oSub
5228:             .Top         = 0
5229:             .Left        = 0
5230:             .Width       = 371
5231:             .Height      = 60
5232:             .BackStyle   = 1
5233:             .BorderWidth = 1
5234:             .SpecialEffect = 2
5235:             .TabIndex    = 13
5236:             .BackColor   = RGB(255, 255, 255)
5237:             .Visible     = .F.
5238:         ENDWITH
5239: 
5240:         loc_oSub.AddObject("cmd_4c_TefChq", "CommandButton")
5241:         WITH loc_oSub.cmd_4c_TefChq
5242:             .Top         = 5
5243:             .Left        = 259
5244:             .Width       = 108
5245:             .Height      = 20
5246:             .FontBold    = .T.
5247:             .FontItalic  = .T.
5248:             .FontName    = "Comic Sans MS"
5249:             .FontSize    = 8
5250:             .WordWrap    = .T.
5251:             .Caption     = "Consulta C\<heque"
5252:             .TabIndex    = 12
5253:             .TabStop     = .F.
5254:             .ToolTipText = "Verifica e Confirma se a numera" + CHR(231) + CHR(227) + "o dos cheques est" + CHR(225) + " OK."
5255:             .ForeColor   = RGB(90, 90, 90)
5256:             .BackColor   = RGB(255, 255, 255)
5257:             .Themes      = .F.
5258:             .Visible     = .T.
5259:         ENDWITH
5260: 
5261:         loc_oSub.AddObject("obj_4c_Opc_cpf", "OptionGroup")
5262:         WITH loc_oSub.obj_4c_Opc_cpf
5263:             .Top         = 5
5264:             .Left        = 3
5265:             .Width       = 108
5266:             .Height      = 17
5267:             .ButtonCount = 2
5268:             .Value       = 1
5269:             .BackStyle   = 0
5270:             .BorderStyle = 0
5271:             .TabIndex    = 18
5272:             .BorderColor = RGB(192, 192, 192)
5273:             .Visible     = .T.
5274:             WITH .Buttons(1)
5275:                 .BackStyle = 0
5276:                 .Caption   = "CPF"
5277:                 .Height    = 17
5278:                 .Left      = 5
5279:                 .Top       = 1
5280:                 .Width     = 44
5281:             ENDWITH
5282:             WITH .Buttons(2)
5283:                 .FontSize  = 8
5284:                 .BackStyle = 0
5285:                 .Caption   = "CNPJ"
5286:                 .Left      = 57
5287:                 .Top       = 1
5288:             ENDWITH
5289:         ENDWITH
5290: 
5291:         loc_oSub.AddObject("txt_4c_Cpf", "TextBox")
5292:         WITH loc_oSub.txt_4c_Cpf
5293:             .Top               = 4
5294:             .Left              = 112
5295:             .Width             = 140
5296:             .Height            = 20
5297:             .FontName          = "Tahoma"
5298:             .Margin            = 0
5299:             .MaxLength         = 20
5300:             .SpecialEffect     = 1
5301:             .TabIndex          = 1

*-- Linhas 5512 a 6485:
5512:     * (Value); a lista de itens e populada em runtime (Fase 7-8, junto do
5513:     * evento de Click de cmd_4c_MudaOpe que a alimenta) - aqui so a moldura.
5514:     *--------------------------------------------------------------------------
5515:     PROTECTED PROCEDURE ConfigurarComboOperacao()
5516:         THIS.AddObject("cbo_4c_CmbTOpers", "ComboBox")
5517:         WITH THIS.cbo_4c_CmbTOpers
5518:             .Top            = 594
5519:             .Left           = 39
5520:             .Width          = 277
5521:             .Height         = 22
5522:             .FontName       = "Verdana"
5523:             .RowSourceType  = 1
5524:             .SpecialEffect  = 1
5525:             .Visible        = .F.
5526:         ENDWITH
5527:     ENDPROC
5528: 
5529:     *==========================================================================
5530:     * LOOKUPS - Cnt_Identifica (Grupo/Conta) e Cnt_Fpagto (Forma de Pagamento)
5531:     *
5532:     * Substituem fAcessoContab/fAcessoContas/fwBuscaExt/fwBuscaSel do legado
5533:     * (CLAUDE.md: fAcessoContas() PROIBIDO como handler de lookup UX -
5534:     * auto-preenche com o primeiro match parcial sem selecao explicita).
5535:     * Padrao canonico FormBuscaAuxiliar (CLAUDE.md #36/#37): o proprio Init ja
5536:     * tenta o match EXATO e so mostra o picker se nao encontrar - por isso NAO
5537:     * ha um SQLEXEC de pre-checagem aqui, so a chamada direta.
5538:     *==========================================================================
5539: 
5540:     *--------------------------------------------------------------------------
5541:     * AbrirLookupGrupo - Grupo de Contas (SigCdGcr.codigos/descrs).
5542:     *--------------------------------------------------------------------------
5543:     PROTECTED PROCEDURE AbrirLookupGrupo(par_oTxtGrupo)
5544:         LOCAL loc_oBusca
5545: 
5546:         IF USED("cursor_4c_BuscaGrupo")
5547:             USE IN cursor_4c_BuscaGrupo
5548:         ENDIF
5549: 
5550:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
5551:             "cursor_4c_BuscaGrupo", "codigos", ALLTRIM(par_oTxtGrupo.Value), "Grupo de Contas")
5552: 
5553:         IF VARTYPE(loc_oBusca) = "O"
5554:             IF !loc_oBusca.this_lAchouRegistro
5555:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
5556:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5557:                 loc_oBusca.Show()
5558:             ENDIF
5559:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
5560:                 SELECT cursor_4c_BuscaGrupo
5561:                 par_oTxtGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
5562:             ENDIF
5563:             loc_oBusca.Release()
5564:         ENDIF
5565: 
5566:         IF USED("cursor_4c_BuscaGrupo")
5567:             USE IN cursor_4c_BuscaGrupo
5568:         ENDIF
5569:     ENDPROC
5570: 
5571:     *--------------------------------------------------------------------------
5572:     * AbrirLookupConta - Contas (SigCdCli.iclis/rclis/cpfs/grupos). Busca por
5573:     * par_cCampoBusca ("iclis"/"rclis"/"cpfs" - o campo que o usuario digitou)
5574:     * com par_cValorBusca; filtra por Grupo quando par_oTxtGrupo ja tem valor.
5575:     * Preenche Conta+Nome+Cpf sempre; Grupo so se estava vazio (nao sobrescreve
5576:     * filtro que o usuario ja escolheu).
5577:     *--------------------------------------------------------------------------
5578:     PROTECTED PROCEDURE AbrirLookupConta(par_oTxtConta, par_oTxtDconta, par_oTxtCpf, ;
5579:             par_oTxtGrupo, par_cCampoBusca, par_cValorBusca)
5580:         LOCAL loc_oBusca, loc_cFiltro
5581: 
5582:         loc_cFiltro = ""
5583:         IF VARTYPE(par_oTxtGrupo) = "O" AND !EMPTY(ALLTRIM(par_oTxtGrupo.Value))
5584:             loc_cFiltro = "grupos = " + EscaparSQL(PADR(ALLTRIM(par_oTxtGrupo.Value), 10))
5585:         ENDIF
5586: 
5587:         IF USED("cursor_4c_BuscaConta")
5588:             USE IN cursor_4c_BuscaConta
5589:         ENDIF
5590: 
5591:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
5592:             "cursor_4c_BuscaConta", par_cCampoBusca, par_cValorBusca, "Contas", .F., .T., loc_cFiltro)
5593: 
5594:         IF VARTYPE(loc_oBusca) = "O"
5595:             IF !loc_oBusca.this_lAchouRegistro
5596:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
5597:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
5598:                 loc_oBusca.mAddColuna("cpfs",  "", "CPF" + CHR(47) + "CNPJ")
5599:                 loc_oBusca.Show()
5600:             ENDIF
5601:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
5602:                 SELECT cursor_4c_BuscaConta
5603:                 par_oTxtConta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
5604:                 IF VARTYPE(par_oTxtDconta) = "O"
5605:                     par_oTxtDconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
5606:                 ENDIF
5607:                 IF VARTYPE(par_oTxtCpf) = "O"
5608:                     par_oTxtCpf.Value = ALLTRIM(cursor_4c_BuscaConta.cpfs)
5609:                 ENDIF
5610:                 IF VARTYPE(par_oTxtGrupo) = "O" AND EMPTY(ALLTRIM(par_oTxtGrupo.Value))
5611:                     par_oTxtGrupo.Value = ALLTRIM(cursor_4c_BuscaConta.grupos)
5612:                 ENDIF
5613:             ENDIF
5614:             loc_oBusca.Release()
5615:         ENDIF
5616: 
5617:         IF USED("cursor_4c_BuscaConta")
5618:             USE IN cursor_4c_BuscaConta
5619:         ENDIF
5620:     ENDPROC
5621: 
5622:     *--------------------------------------------------------------------------
5623:     * AbrirLookupTabDesconto - Tabela de Desconto (SigOpTdz.codigos/descrs).
5624:     *--------------------------------------------------------------------------
5625:     PROTECTED PROCEDURE AbrirLookupTabDesconto(par_oTxtTabd)
5626:         LOCAL loc_oBusca
5627: 
5628:         IF USED("cursor_4c_BuscaTabd")
5629:             USE IN cursor_4c_BuscaTabd
5630:         ENDIF
5631: 
5632:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigOpTdz", ;
5633:             "cursor_4c_BuscaTabd", "codigos", ALLTRIM(par_oTxtTabd.Value), "Tabelas de Desconto")
5634: 
5635:         IF VARTYPE(loc_oBusca) = "O"
5636:             IF !loc_oBusca.this_lAchouRegistro
5637:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
5638:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5639:                 loc_oBusca.Show()
5640:             ENDIF
5641:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
5642:                 SELECT cursor_4c_BuscaTabd
5643:                 par_oTxtTabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
5644:             ENDIF
5645:             loc_oBusca.Release()
5646:         ENDIF
5647: 
5648:         IF USED("cursor_4c_BuscaTabd")
5649:             USE IN cursor_4c_BuscaTabd
5650:         ENDIF
5651:     ENDPROC
5652: 
5653:     *--------------------------------------------------------------------------
5654:     * AbrirLookupListaPreco - Listas de Preco (SigCdLpc.lprecos).
5655:     *--------------------------------------------------------------------------
5656:     PROTECTED PROCEDURE AbrirLookupListaPreco(par_oTxtListaPreco)
5657:         LOCAL loc_oBusca
5658: 
5659:         IF USED("cursor_4c_BuscaListaPreco")
5660:             USE IN cursor_4c_BuscaListaPreco
5661:         ENDIF
5662: 
5663:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLpc", ;
5664:             "cursor_4c_BuscaListaPreco", "lprecos", ALLTRIM(par_oTxtListaPreco.Value), "Listas de Pre" + CHR(231) + "o")
5665: 
5666:         IF VARTYPE(loc_oBusca) = "O"
5667:             IF !loc_oBusca.this_lAchouRegistro
5668:                 loc_oBusca.mAddColuna("lprecos", "", "Lista")
5669:                 loc_oBusca.mAddColuna("tipos",   "", "Tipo")
5670:                 loc_oBusca.Show()
5671:             ENDIF
5672:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaListaPreco")
5673:                 SELECT cursor_4c_BuscaListaPreco
5674:                 par_oTxtListaPreco.Value = ALLTRIM(cursor_4c_BuscaListaPreco.lprecos)
5675:             ENDIF
5676:             loc_oBusca.Release()
5677:         ENDIF
5678: 
5679:         IF USED("cursor_4c_BuscaListaPreco")
5680:             USE IN cursor_4c_BuscaListaPreco
5681:         ENDIF
5682:     ENDPROC
5683: 
5684:     *--------------------------------------------------------------------------
5685:     * AbrirLookupFormaPagamento - Forma de Pagamento (SigOpFp.fpags/descrs).
5686:     *--------------------------------------------------------------------------
5687:     PROTECTED PROCEDURE AbrirLookupFormaPagamento(par_oTxtFpg)
5688:         LOCAL loc_oBusca
5689: 
5690:         IF USED("cursor_4c_BuscaFpg")
5691:             USE IN cursor_4c_BuscaFpg
5692:         ENDIF
5693: 
5694:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigOpFp", ;
5695:             "cursor_4c_BuscaFpg", "fpags", ALLTRIM(par_oTxtFpg.Value), "Forma de Pagamento")
5696: 
5697:         IF VARTYPE(loc_oBusca) = "O"
5698:             IF !loc_oBusca.this_lAchouRegistro
5699:                 loc_oBusca.mAddColuna("fpags",  "", "C" + CHR(243) + "digo")
5700:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5701:                 loc_oBusca.mAddColuna("fparcs", "", "Parc")
5702:                 loc_oBusca.Show()
5703:             ENDIF
5704:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
5705:                 SELECT cursor_4c_BuscaFpg
5706:                 par_oTxtFpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
5707:             ENDIF
5708:             loc_oBusca.Release()
5709:         ENDIF
5710: 
5711:         IF USED("cursor_4c_BuscaFpg")
5712:             USE IN cursor_4c_BuscaFpg
5713:         ENDIF
5714:     ENDPROC
5715: 
5716:     *==========================================================================
5717:     * FASE 7/8 - EVENTOS PRINCIPAIS
5718:     *
5719:     * Liga os Click/KeyPress dos 17 CommandButtons da barra principal (Fase
5720:     * 3), dos 4 botoes de acao das grades (Fase 4), dos paineis CancelaItem/
5721:     * Consulta (Fase 5) e das setas "Proximo" de cada tela (Fases 5-6).
5722:     *
5723:     * Limite de escopo (arquitetura ja fixada nas Fases 1-6): DataSession=2
5724:     * isola este form dos cursores globais do form de movimentacao pai
5725:     * (crSigCdOpe, CrSigOpCdc, TprMvCab) e das rotinas dele (AcioSalva,
5726:     * AcioCancela, Cancel_Item_Gen, AtuaTotal, VerStatus). Guardas do legado
5727:     * que dependem so de CURSORES/PROPRIEDADES LOCAIS (crTpmMvItn, TmpOperacao,
5728:     * TmpDevol, TmpBarFin, xPar, this_*) sao transcritos fielmente; os que
5729:     * dependem de fiscal/TEF/senha de supervisor (impressora ECF, SigOpSen,
5730:     * SigOpPen, SigMEFIS) nao tem como ser reproduzidos sem esse hardware/
5731:     * modulo - documentados caso a caso, nunca silenciados.
5732:     *
5733:     * PUBLIC (sem PROTECTED) todos os handlers de evento: BINDEVENT so
5734:     * funciona com metodos PUBLIC (CLAUDE.md #3).
5735:     *==========================================================================
5736: 
5737:     *--------------------------------------------------------------------------
5738:     * RegistrarEventosPrincipais - liga (BINDEVENT) todos os botoes/campos
5739:     * desta fase. Chamado uma unica vez a partir de InicializarForm, depois
5740:     * que TODOS os controles ja foram criados (Fases 3-6) - registrar contra
5741:     * um controle inexistente estoura aqui dentro do TRY do InicializarForm.
5742:     *--------------------------------------------------------------------------
5743:     PROTECTED PROCEDURE RegistrarEventosPrincipais()
5744:         LOCAL loc_oCnt
5745: 
5746:         *-- Barra de botoes principal.
5747:         loc_oCnt = THIS.cnt_4c_Barra_Botoes
5748:         BINDEVENT(loc_oCnt.cmd_4c_Itens,      "Click", THIS, "CmdItensClick")
5749:         BINDEVENT(loc_oCnt.cmd_4c_Alteraqtd,  "Click", THIS, "CmdAlteraqtdClick")
5750:         BINDEVENT(loc_oCnt.cmd_4c_Desconto,   "Click", THIS, "CmdDescontoClick")
5751:         BINDEVENT(loc_oCnt.cmd_4c_Acrescimo,  "Click", THIS, "CmdAcrescimoClick")
5752:         BINDEVENT(loc_oCnt.cmd_4c_CancPagto,  "Click", THIS, "CmdCancPagtoClick")
5753:         BINDEVENT(loc_oCnt.cmd_4c_Apaga,      "Click", THIS, "CmdApagaClick")
5754:         BINDEVENT(loc_oCnt.cmd_4c_AltPreco,   "Click", THIS, "CmdAltPrecoClick")
5755:         BINDEVENT(loc_oCnt.cmd_4c_Identifica, "Click", THIS, "CmdIdentificaClick")
5756:         BINDEVENT(loc_oCnt.cmd_4c_Credito,    "Click", THIS, "CmdCreditoClick")
5757:         BINDEVENT(loc_oCnt.cmd_4c_Financia,   "Click", THIS, "CmdFinanciaClick")
5758:         BINDEVENT(loc_oCnt.cmd_4c_Pendencia,  "Click", THIS, "CmdPendenciaClick")
5759:         BINDEVENT(loc_oCnt.cmd_4c_VerPreco,   "Click", THIS, "CmdVerPrecoClick")
5760:         BINDEVENT(loc_oCnt.cmd_4c_Impfiscal,  "Click", THIS, "CmdImpfiscalClick")
5761:         BINDEVENT(loc_oCnt.cmd_4c_MudaOpe,    "Click", THIS, "CmdMudaOpeClick")
5762:         BINDEVENT(loc_oCnt.cmd_4c_Pagto,      "Click", THIS, "CmdPagtoClick")
5763:         BINDEVENT(loc_oCnt.cmd_4c_Ok,         "Click", THIS, "BtnConfirmarClick")
5764:         BINDEVENT(loc_oCnt.cmd_4c_Cancela,    "Click", THIS, "BtnCancelarClick")
5765: 
5766:         *-- Grade de codigos de barras do crediario (CntFinanc).
5767:         loc_oCnt = THIS.cnt_4c_Financ.cnt_4c__GrdBarra
5768:         BINDEVENT(loc_oCnt.cmd_4c_Inserir, "Click", THIS, "CmdInserirBarraClick")
5769:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "CmdExcluirBarraClick")
5770:         BINDEVENT(loc_oCnt.cmd_4c_OkBarra, "Click", THIS, "CmdOkBarraClick")
5771: 
5772:         *-- Sub-niveis/pendencias.
5773:         BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_BotPendentes, "Click", THIS, "CmdBotPendentesClick")
5774: 
5775:         *-- Painel de cancelamento de item.
5776:         BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_Ok,          "Click", THIS, "CancelaItemOkClick")
5777:         BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_CancelaDisp, "Click", THIS, "CancelaItemCancelaDispClick")
5778: 
5779:         *-- Painel de consulta de preco.
5780:         BINDEVENT(THIS.cnt_4c__Consulta.cmd_4c_Command1, "Click", THIS, "ConsultaCommand1Click")
5781:         BINDEVENT(THIS.cnt_4c__Consulta.cmd_4c_Proximo,  "Click", THIS, "ConsultaProximoClick")
5782:         BINDEVENT(THIS.cnt_4c__Consulta.cnt_4c__Produto.txt_4c_Produto, "KeyPress", THIS, "ConsultaProdutoKeyPress")
5783: 
5784:         *-- Setas "Proximo" de cada tela.
5785:         BINDEVENT(THIS.cnt_4c_Item.cmd_4c_Proximo,        "Click", THIS, "ItemProximoClick")
5786:         BINDEVENT(THIS.cnt_4c_Financ.cmd_4c_Proximo,      "Click", THIS, "FinancProximoClick")
5787:         BINDEVENT(THIS.cnt_4c__Credito.cmd_4c_Proximo,    "Click", THIS, "CreditoProximoClick")
5788:         BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_Proximo,  "Click", THIS, "PendenciaProximoClick")
5789:         BINDEVENT(THIS.cnt_4c__Identifica.cmd_4c_Proximo, "Click", THIS, "IdentificaProximoClick")
5790:         BINDEVENT(THIS.cnt_4c__Fpagto.cmd_4c_Proximo,     "Click", THIS, "FpagtoProximoClick")
5791: 
5792:         *-- Confirmacao manual do item (CntItem.Cnt_Produto.CmdEnviaProd) - so
5793:         *-- fica visivel quando o legado exige confirmar o preco alterado.
5794:         BINDEVENT(THIS.cnt_4c_Item.cnt_4c__Produto.cmd_4c_CmdEnviaProd, "Click", THIS, "CmdEnviaProdClick")
5795: 
5796:         *-- Atalho para o Cadastro de Contas a partir dos blocos Origem/Destino
5797:         *-- (btnCadastros de cada um).
5798:         BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_Destino.cmd_4c_BtnCadastros, "Click", THIS, "BtnCadastrosDestinoClick")
5799:         BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_Origem.cmd_4c_BtnCadastros,  "Click", THIS, "BtnCadastrosOrigemClick")
5800: 
5801:         *-- Conferencia de cheque pre-datado (Cnt_ChequepreTef.Cnt_Chq).
5802:         loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
5803:         BINDEVENT(loc_oCnt.cmd_4c_TefChq, "Click", THIS, "CmdTefChqClick")
5804:         BINDEVENT(loc_oCnt.cmd_4c_Ins,    "Click", THIS, "CmdInsChequeClick")
5805: 
5806:         *-- Combo de troca de operacao (Ctrl+F11).
5807:         BINDEVENT(THIS.cbo_4c_CmbTOpers, "KeyPress",  THIS, "CmbTOpersKeyPress")
5808:         BINDEVENT(THIS.cbo_4c_CmbTOpers, "KeyPress", THIS, "CmbTOpersLostFocus")
5809:     ENDPROC
5810: 
5811:     *--------------------------------------------------------------------------
5812:     * AlternarTelaOperacao - mostra EXATAMENTE um dos seis containers de
5813:     * operacao e esconde os outros cinco. No legado cada Click de
5814:     * identifica/credito/pendencia/Financia/Itens comeca zerando a
5815:     * visibilidade dos irmaos antes de mostrar o proprio (ex.: identifica.Click
5816:     * "ThisForm.CntFinanc.Visible=.f. / ThisForm.CntItem.Visible=.f. /
5817:     * ThisForm.Cnt_Credito.Visible=.f. / Thisform.Cnt_pendencia.Visible=.f. /
5818:     * ThisForm.Cnt_fpagto.Visible=.f."). Sem este metodo os seis nasciam todos
5819:     * Visible=.T. (ConfigurarContainersOperacao, Fase 4) empilhados na mesma
5820:     * area (Top=124 Left=32) - bug corrigido aqui.
5821:     * CancelaItem e um painel modal-like a parte (fica por cima da tela
5822:     * ativa) - trocar de tela fecha ele tambem, igual ao CancelaDisp legado.
5823:     *--------------------------------------------------------------------------
5824:     PROTECTED PROCEDURE AlternarTelaOperacao(par_cTela)
5825:         LOCAL loc_cTela
5826:         loc_cTela = UPPER(ALLTRIM(par_cTela))
5827: 
5828:         THIS.cnt_4c_Item.Visible        = (loc_cTela == "ITENS")
5829:         THIS.cnt_4c_Financ.Visible      = (loc_cTela == "FINANC")
5830:         THIS.cnt_4c__Credito.Visible    = (loc_cTela == "CREDITO")
5831:         THIS.cnt_4c__Pendencia.Visible  = (loc_cTela == "PENDENCIA")
5832:         THIS.cnt_4c__Identifica.Visible = (loc_cTela == "IDENTIFICA")
5833:         THIS.cnt_4c__Fpagto.Visible     = (loc_cTela == "FPAGTO")
5834: 
5835:         IF loc_cTela != "ITENS"
5836:             THIS.cnt_4c_CancelaItem.Visible = .F.
5837:             THIS.cnt_4c_Item.Enabled        = .T.
5838:         ENDIF
5839: 
5840:         *-- Quem desabilita botao tem de reabilitar no FUNIL de volta: toda
5841:         *-- troca de tela passa por aqui, entao o gate dos botoes e reaplicado
5842:         *-- aqui e nao em cada Click (CLAUDE.md #40).
5843:         THIS.AjustarBotoesPorModo()
5844:     ENDPROC
5845: 
5846:     *--------------------------------------------------------------------------
5847:     * FocarControle - SetFocus protegido. Falha de SetFocus aqui e sempre um
5848:     * problema de TIMING (controle ainda na tela que acabou de ficar
5849:     * invisivel no mesmo ciclo de evento) - nunca perda de dado. Mesmo
5850:     * criterio ja usado no CATCH silencioso do Destroy() deste form (comentado
5851:     * la: "o Destroy nao pode falhar aqui, senao o menu principal nao e
5852:     * reconstruido"): aqui, mostrar MsgErro por causa de foco de teclado
5853:     * seria pior do que nao mostrar nada.
5854:     *--------------------------------------------------------------------------
5855:     PROTECTED PROCEDURE FocarControle(par_oControle)
5856:         LOCAL loc_oErro
5857:         TRY
5858:             IF VARTYPE(par_oControle) = "O" AND par_oControle.Visible AND par_oControle.Enabled
5859:                 par_oControle.SetFocus
5860:             ENDIF
5861:         CATCH TO loc_oErro
5862:             * silencioso de proposito - ver comentario do metodo.
5863:         ENDTRY
5864:     ENDPROC
5865: 
5866:     *--------------------------------------------------------------------------
5867:     * HaPagamentoPend - .T. quando ha alguma forma de pagamento lancada em
5868:     * xPar que ainda nao foi inserida (Valos>0, FPags preenchido, !InsChs).
5869:     * Mesma condicao do legado em credito/pendencia/Financia.Click ("Count to
5870:     * wxpar for Valos > 0 and not Empty(fpags) And Not xPar.InsChs / If wxpar
5871:     * > 0 / MessageBox('Favor Excluir as Condicoes de Pagamento!!!')").
5872:     *--------------------------------------------------------------------------
5873:     PROTECTED FUNCTION HaPagamentoPendente()
5874:         LOCAL loc_nQt, loc_nAreaAnt
5875:         loc_nQt = 0
5876: 
5877:         IF USED("xPar")
5878:             loc_nAreaAnt = SELECT()
5879:             SELECT xPar
5880:             COUNT FOR Valos > 0 AND !EMPTY(FPags) AND !InsChs TO loc_nQt
5881:             IF loc_nAreaAnt > 0
5882:                 SELECT (loc_nAreaAnt)
5883:             ENDIF
5884:         ENDIF
5885: 
5886:         RETURN (loc_nQt > 0)
5887:     ENDFUNC
5888: 
5889:     *--------------------------------------------------------------------------
5890:     * RecalcularTotalCarrinho - soma crTpmMvItn.totas e atualiza o TOTAL da
5891:     * tela de Itens + a propriedade this_nTotal. Chamado sempre que um item e
5892:     * removido do carrinho localmente (CancelaItemOkClick).
5893:     *--------------------------------------------------------------------------
5894:     PROTECTED PROCEDURE RecalcularTotalCarrinho()
5895:         LOCAL loc_nTotal, loc_nAreaAnt
5896:         loc_nTotal = 0
5897: 
5898:         IF USED("crTpmMvItn")
5899:             loc_nAreaAnt = SELECT()
5900:             SELECT crTpmMvItn
5901:             SUM totas TO loc_nTotal
5902:             IF loc_nAreaAnt > 0
5903:                 SELECT (loc_nAreaAnt)
5904:             ENDIF
5905:         ENDIF
5906: 
5907:         THIS.this_nTotal = loc_nTotal
5908:         THIS.cnt_4c_Item.txt_4c_Total.Value = loc_nTotal
5909:     ENDPROC
5910: 
5911:     *--------------------------------------------------------------------------
5912:     * CancelaItemFechar - fecha o painel de cancelamento e devolve o controle
5913:     * a tela de Itens. Compartilhado por CancelaItemOkClick (apos processar) e
5914:     * CancelaItemCancelaDispClick.
5915:     *--------------------------------------------------------------------------
5916:     PROTECTED PROCEDURE CancelaItemFechar()
5917:         THIS.cnt_4c_CancelaItem.Visible = .F.
5918:         THIS.cnt_4c_Item.Enabled        = .T.
5919:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
5920:     ENDPROC
5921: 
5922:     *==========================================================================
5923:     * HANDLERS - BARRA DE BOTOES PRINCIPAL
5924:     *==========================================================================
5925: 
5926:     *-- [F2] Itens - volta para a tela de lancamento de itens.
5927:     PROCEDURE CmdItensClick()
5928:         THIS.AlternarTelaOperacao("ITENS")
5929:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
5930:     ENDPROC
5931: 
5932:     *-- [F3] Alteraqtd - legado: "If Empty(Get_produto.Value) / lAlteraqtd=.t.
5933:     *-- / focus Get_qtds / Else / focus Get_Produto".
5934:     PROCEDURE CmdAlteraqtdClick()
5935:         LOCAL loc_oProd
5936:         loc_oProd = THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto
5937: 
5938:         IF EMPTY(loc_oProd.Value)
5939:             THIS.this_lLalteraqtd = .T.
5940:             THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Qtds)
5941:         ELSE
5942:             THIS.FocarControle(loc_oProd)
5943:         ENDIF
5944:     ENDPROC
5945: 
5946:     *-- [F3] Desconto - alterna o desconto de venda (Cnt_Fpagto.Desconto),
5947:     *-- espelhando a guarda do irmao Acrescimo (so um dos dois fica aberto).
5948:     PROCEDURE CmdDescontoClick()
5949:         IF THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.Visible
5950:             RETURN
5951:         ENDIF
5952: 
5953:         THIS.this_lValidadesconto = .T.
5954:         WITH THIS.cnt_4c__Fpagto
5955:             .cnt_4c_Desconto.Visible   = .T.
5956:             .cnt_4c_Desconto.Enabled   = .T.
5957:             .txt_4c_TotLiquido.Visible = .T.
5958:             .lbl_4c_Label15.Visible    = .T.
5959:         ENDWITH
5960: 
5961:         THIS.AlternarTelaOperacao("FPAGTO")
5962:         THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_PorcVariacao)
5963:     ENDPROC
5964: 
5965:     *-- [Ctrl+F3] Acrescimo - legado (Barra_Botoes.Acrescimo.Click, 24
5966:     *-- linhas): bloqueia se ja houver desconto informado ou o painel de
5967:     *-- desconto estiver aberto; senao mostra o painel de acrescimo.
5968:     PROCEDURE CmdAcrescimoClick()
5969:         LOCAL loc_lOk
5970:         loc_lOk = .T.
5971: 
5972:         IF THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_TotVariacao.Value > 0
5973:             MsgAviso("Desconto Informado. N" + CHR(227) + "o pode haver Acr" + CHR(233) + "scimo!!!", ;
5974:                 "Aten" + CHR(231) + CHR(227) + "o")
5975:             loc_lOk = .F.
5976:         ENDIF
5977: 
5978:         IF THIS.cnt_4c__Fpagto.cnt_4c_Desconto.Visible
5979:             loc_lOk = .F.
5980:         ENDIF
5981: 
5982:         IF loc_lOk
5983:             THIS.this_lValidadesconto = .T.
5984:             WITH THIS.cnt_4c__Fpagto
5985:                 .cnt_4c_Acrescimo.Visible  = .T.
5986:                 .cnt_4c_Acrescimo.Enabled  = .T.
5987:                 .txt_4c_TotLiquido.Visible = .T.
5988:                 .lbl_4c_Label15.Visible    = .T.
5989:             ENDWITH
5990: 
5991:             THIS.AlternarTelaOperacao("FPAGTO")
5992:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.txt_4c_PorcVariacao)
5993:         ENDIF
5994:     ENDPROC
5995: 
5996:     *-- [F4] CancPagto - cancela a ULTIMA forma de pagamento lancada (xPar).
5997:     *-- A baixa em gateway TEF (DeleteSigTef, do legado) nao tem equivalente
5998:     *-- nesta migracao - so a parcela local (e as demais da mesma "chave" de
5999:     *-- lancamento, nChaves) e removida.
6000:     PROCEDURE CmdCancPagtoClick()
6001:         LOCAL loc_nChave
6002: 
6003:         IF !USED("xPar")
6004:             RETURN
6005:         ENDIF
6006: 
6007:         SELECT xPar
6008:         GO BOTTOM
6009:         IF EOF()
6010:             RETURN
6011:         ENDIF
6012: 
6013:         loc_nChave = xPar.nChaves
6014:         DELETE FOR nChaves == loc_nChave
6015: 
6016:         THIS.AtualizarGrades()
6017:         THIS.FocarControle(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
6018:     ENDPROC
6019: 
6020:     *-- [F4] Apaga - abre o painel de cancelamento com os dados do ULTIMO
6021:     *-- item lancado. Legado (Barra_Botoes.apaga.Click): guarda "Not
6022:     *-- Empty(Get_Produto.Value) Return" + "Get_item.Value = Citem-1" +
6023:     *-- "Locate For citens = Get_item.Value" + preenche Produto/Descricao/
6024:     *-- Barra do painel.
6025:     PROCEDURE CmdApagaClick()
6026:         LOCAL loc_nItem
6027: 
6028:         IF !EMPTY(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Value)
6029:             RETURN
6030:         ENDIF
6031: 
6032:         IF !USED("crTpmMvItn")
6033:             RETURN
6034:         ENDIF
6035: 
6036:         SELECT crTpmMvItn
6037:         LOCATE
6038:         IF EOF()
6039:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " item lan" + CHR(231) + "ado para cancelar.", "Cancelar Item")
6040:             RETURN
6041:         ENDIF
6042: 
6043:         loc_nItem = THIS.this_nCitem - 1
6044: 
6045:         LOCATE FOR citens == loc_nItem
6046:         IF EOF()
6047:             GO BOTTOM
6048:             loc_nItem = NVL(crTpmMvItn.citens, 0)
6049:         ENDIF
6050: 
6051:         WITH THIS.cnt_4c_CancelaItem
6052:             .txt_4c_Item.Value    = loc_nItem
6053:             .txt_4c_Produto.Value = NVL(crTpmMvItn.cpros, "")
6054:             .txt_4c__dpro.Value   = NVL(crTpmMvItn.dpros, "")
6055:             .txt_4c_Cbarra.Value  = NVL(crTpmMvItn.codbarras, 0)
6056:             .Visible              = .T.
6057:             .ZOrder(0)
6058:         ENDWITH
6059: 
6060:         THIS.cnt_4c_Item.Enabled = .F.
6061:         THIS.FocarControle(THIS.cnt_4c_CancelaItem.txt_4c_Item)
6062:     ENDPROC
6063: 
6064:     *-- [F5] AltPreco - legado: "If Not IsEmpty(crTpmMvItn.CPros) /
6065:     *-- lAlteraValor=.t. / zera ValDesc/PValDesc / focus Get_Valor". O
6066:     *-- lancamento linha-a-linha do carrinho (Get_Produto/Get_Qtds) fica para
6067:     *-- a fase de eventos de campo - aqui a mesma condicao e checada pelo
6068:     *-- campo Produto da tela.
6069:     PROCEDURE CmdAltPrecoClick()
6070:         IF EMPTY(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Value)
6071:             RETURN
6072:         ENDIF
6073: 
6074:         THIS.this_lLalteravalor = .T.
6075:         WITH THIS.cnt_4c_Item.cnt_4c__Desconto
6076:             .txt_4c_Valdesc.Value  = 0
6077:             .txt_4c_Pvaldesc.Value = 0
6078:             .Visible     = .T.
6079:         ENDWITH
6080: 
6081:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Subtotal.txt_4c_Valor)
6082:     ENDPROC
6083: 
6084:     *-- [F6] Identifica - legado: guarda "Not Empty(Get_fpg.Value) Return 0"
6085:     *-- (nao sai de uma forma de pagamento em andamento) + troca de tela. A
6086:     *-- leitura de CrSigCdOpe.AcioSens (senha de acionamento) fica fora de
6087:     *-- alcance com DataSession=2.
6088:     PROCEDURE CmdIdentificaClick()
6089:         IF !EMPTY(THIS.cnt_4c__Fpagto.txt_4c_Fpg.Value)
6090:             RETURN
6091:         ENDIF
6092: 
6093:         THIS.AlternarTelaOperacao("IDENTIFICA")
6094:         THIS.FocarControle(THIS.cnt_4c__Identifica.cnt_4c_Destino.txt_4c_Grupo)
6095:     ENDPROC
6096: 
6097:     *-- [F7] Credito - mesma guarda de pagamento em aberto (HaPagamentoPend()).
6098:     PROCEDURE CmdCreditoClick()
6099:         IF THIS.HaPagamentoPendente()
6100:             MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", "Cr" + CHR(233) + "dito")
6101:             RETURN
6102:         ENDIF
6103: 
6104:         THIS.AlternarTelaOperacao("CREDITO")
6105:         THIS.FocarControle(THIS.cnt_4c__Credito.grd_4c_Devolucao)
6106:     ENDPROC
6107: 
6108:     *-- [F8] Financia - crediario/codigos de barras. Visible=.F. por padrao no
6109:     *-- dump legado (recurso desligado), mas o evento e ligado do mesmo jeito.
6110:     PROCEDURE CmdFinanciaClick()
6111:         IF THIS.HaPagamentoPendente()
6112:             MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", "Financiamento")
6113:             RETURN
6114:         ENDIF
6115: 
6116:         THIS.AlternarTelaOperacao("FINANC")
6117:         THIS.FocarControle(THIS.cnt_4c_Financ.cnt_4c__Barras.txt_4c_Barra_1)
6118:     ENDPROC
6119: 
6120:     *-- [F8] Pendencia - sub-niveis/pendencias.
6121:     PROCEDURE CmdPendenciaClick()
6122:         IF THIS.HaPagamentoPendente()
6123:             MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", "Pend" + CHR(234) + "ncia")
6124:             RETURN
6125:         ENDIF
6126: 
6127:         THIS.AlternarTelaOperacao("PENDENCIA")
6128:         THIS.FocarControle(THIS.cnt_4c__Pendencia.grd_4c_SubNiveis)
6129:     ENDPROC
6130: 
6131:     *-- <Ctrl+P> VerPreco - overlay de consulta de preco (nao esconde os
6132:     *-- outros paineis - fica POR CIMA, como no legado). Legado
6133:     *-- (Barra_Botoes.VerPreco.Click, 18 linhas): abre se ainda fechado, limpa
6134:     *-- o campo de produto e o resultado anterior.
6135:     PROCEDURE CmdVerPrecoClick()
6136:         WITH THIS.cnt_4c__Consulta
6137:             IF !.Visible
6138:                 .Visible = .T.
6139:                 .ZOrder(0)
6140:             ENDIF
6141:             .cnt_4c__Produto.txt_4c_Produto.Value       = ""
6142:             .cnt_4c__Resultado.lbl_4c_Mensage1.Caption  = ""
6143:             .cnt_4c__Resultado.lbl_4c_Mensage2.Caption  = ""
6144:             .txt_4c_Unit.Value                          = 0
6145:         ENDWITH
6146: 
6147:         THIS.FocarControle(THIS.cnt_4c__Consulta.cnt_4c__Produto.txt_4c_Produto)
6148:     ENDPROC
6149: 
6150:     *-- [F9] Impfiscal - legado abre SIGMEFIS, monitor de status da
6151:     *-- impressora fiscal (ECF). Sem driver ECF fisico disponivel nesta
6152:     *-- migracao nao ha tela equivalente para abrir - decisao de escopo
6153:     *-- documentada, nao pendencia.
6154:     PROCEDURE CmdImpfiscalClick()
6155:         MsgAviso("O monitor de status da impressora fiscal depende do driver " + ;
6156:             "ECF f" + CHR(237) + "sico do caixa, fora do escopo desta migra" + CHR(231) + CHR(227) + "o.", ;
6157:             "Impressora Fiscal")
6158:     ENDPROC
6159: 
6160:     *-- [Ctrl+F11] MudaOpe - legado (34 linhas): tres guardas locais
6161:     *-- (pagamento/sub-nivel/credito ja lancados bloqueiam a troca) + popula
6162:     *-- cmbTOpers com as operacoes cadastradas. A quarta guarda do legado
6163:     *-- (ThisForm.ParentForm.AbriuCupom) fica fora de alcance com
6164:     *-- DataSession=2. A reconfiguracao completa do Caixa para a nova operacao
6165:     *-- (AciomudaOpe) e responsabilidade da tela de movimentacao.
6166:     PROCEDURE CmdMudaOpeClick()
6167:         LOCAL loc_nQt, loc_oErro
6168: 
6169:         IF USED("xPar")
6170:             SELECT xPar
6171:             COUNT FOR Valos > 0 AND !EMPTY(FPags) TO loc_nQt
6172:             IF loc_nQt > 0
6173:                 MsgAviso("Condi" + CHR(231) + CHR(245) + "es de Pagamento j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
6174:                     "Muda Opera" + CHR(231) + CHR(227) + "o")
6175:                 RETURN
6176:             ENDIF
6177:         ENDIF
6178: 
6179:         IF USED("TmpOperacao")
6180:             SELECT TmpOperacao
6181:             COUNT FOR Codigos > 0 TO loc_nQt
6182:             IF loc_nQt > 0
6183:                 MsgAviso("Opera" + CHR(231) + CHR(245) + "es de SubN" + CHR(237) + "veis j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
6184:                     "Muda Opera" + CHR(231) + CHR(227) + "o")
6185:                 RETURN
6186:             ENDIF
6187:         ENDIF
6188: 
6189:         IF USED("TmpDevol")
6190:             SELECT TmpDevol
6191:             COUNT FOR Codigos > 0 TO loc_nQt
6192:             IF loc_nQt > 0
6193:                 MsgAviso("Opera" + CHR(231) + CHR(245) + "es de Cr" + CHR(233) + "dito j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
6194:                     "Muda Opera" + CHR(231) + CHR(227) + "o")
6195:                 RETURN
6196:             ENDIF
6197:         ENDIF
6198: 
6199:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
6200:             RETURN
6201:         ENDIF
6202: 
6203:         TRY
6204:             IF USED("cursor_4c_ListaOpe")
6205:                 USE IN cursor_4c_ListaOpe
6206:             ENDIF
6207: 
6208:             IF SQLEXEC(gnConnHandle, "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", "cursor_4c_ListaOpe") > 0 ;
6209:                     AND USED("cursor_4c_ListaOpe") AND RECCOUNT("cursor_4c_ListaOpe") > 0
6210: 
6211:                 THIS.cbo_4c_CmbTOpers.RowSourceType = 0
6212:                 THIS.cbo_4c_CmbTOpers.Clear()
6213: 
6214:                 SELECT cursor_4c_ListaOpe
6215:                 SCAN
6216:                     THIS.cbo_4c_CmbTOpers.AddItem(ALLTRIM(cursor_4c_ListaOpe.Dopes))
6217:                 ENDSCAN
6218: 
6219:                 THIS.cbo_4c_CmbTOpers.Visible = .T.
6220:                 THIS.FocarControle(THIS.cbo_4c_CmbTOpers)
6221:             ENDIF
6222: 
6223:             IF USED("cursor_4c_ListaOpe")
6224:                 USE IN cursor_4c_ListaOpe
6225:             ENDIF
6226:         CATCH TO loc_oErro
6227:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
6228:                 "Erro em Muda Opera" + CHR(231) + CHR(227) + "o")
6229:         ENDTRY
6230:     ENDPROC
6231: 
6232:     *-- [F11] Pagto - avanca para a tela de formas de pagamento, exigindo
6233:     *-- pelo menos um item lancado (guia minima do metodo legado de 425
6234:     *-- linhas - o restante e abertura/fechamento de cupom fiscal, fora de
6235:     *-- alcance sem o driver ECF).
6236:     PROCEDURE CmdPagtoClick()
6237:         IF !USED("crTpmMvItn")
6238:             RETURN
6239:         ENDIF
6240: 
6241:         SELECT crTpmMvItn
6242:         LOCATE
6243:         IF EOF()
6244:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens lan" + CHR(231) + "ados para pagamento.", "Pagamento")
6245:             RETURN
6246:         ENDIF
6247: 
6248:         THIS.AlternarTelaOperacao("FPAGTO")
6249:         THIS.FocarControle(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
6250:     ENDPROC
6251: 
6252:     *-- Confirmar (cmd_4c_Ok) - legado (Barra_Botoes.ok.Click, 25 linhas):
6253:     *-- valida sub-nivel/pagamento e chama AcioSalva() no ParentForm, que
6254:     *-- gravava o cursor de itens inteiro com TableUpdate na datasession
6255:     *-- COMPARTILHADA e fechava o cupom fiscal.
6256:     *--
6257:     *-- Aqui: sem item lancado, so fecha o Caixa; havendo itens, exige forma de
6258:     *-- pagamento informada e GRAVA os itens em SigMvItn pelo BO antes de
6259:     *-- devolver o controle a tela de movimentacao. A gravacao acontece NESTE
6260:     *-- form porque DataSession = 2 isola o carrinho (crTpmMvItn) do form pai -
6261:     *-- sem ela os itens morreriam na memoria ao fechar a tela e o Confirmar
6262:     *-- anunciaria "venda validada" sem nada no banco.
6263:     *--
6264:     *-- A finalizacao FISCAL (emissao do cupom / TEF) continua sendo do form
6265:     *-- pai: depende da impressora fiscal, que esta fora de alcance daqui.
6266:     PROCEDURE BtnConfirmarClick()
6267:         LOCAL loc_nItens, loc_lTemPagamento
6268: 
6269:         *-- Conta so as linhas com produto: o carrinho mantem uma linha em
6270:         *-- branco aberta para o proximo item (LimparCntItem), que NAO conta
6271:         *-- como venda.
6272:         loc_nItens = 0
6273:         IF USED("crTpmMvItn")
6274:             SELECT crTpmMvItn
6275:             COUNT FOR !EMPTY(NVL(cpros, "")) AND !DELETED() TO loc_nItens
6276:         ENDIF
6277: 
6278:         IF loc_nItens = 0
6279:             THIS.Release()
6280:             RETURN
6281:         ENDIF
6282: 
6283:         loc_lTemPagamento = .F.
6284:         IF USED("xPar")
6285:             SELECT xPar
6286:             LOCATE FOR !EMPTY(FPags)
6287:             loc_lTemPagamento = !EOF()
6288:         ENDIF
6289: 
6290:         IF !loc_lTemPagamento
6291:             MsgAviso("Informe a forma de pagamento antes de confirmar a venda.", "Confirmar")
6292:             THIS.CmdPagtoClick()
6293:             RETURN
6294:         ENDIF
6295: 
6296:         *-- Grava os itens. Falhando, NAO fecha a tela e NAO anuncia sucesso -
6297:         *-- o caixa continua com o carrinho na tela para corrigir e repetir.
6298:         *-- BusinessBase.Salvar() ja exibiu o motivo (CLAUDE.md #20).
6299:         IF !THIS.GravarItensLancados()
6300:             RETURN
6301:         ENDIF
6302: 
6303:         MsgInfo("Venda gravada com sucesso." + CHR(13) + ;
6304:             "A finaliza" + CHR(231) + CHR(227) + "o fiscal prossegue na tela de " + ;
6305:             "movimenta" + CHR(231) + CHR(227) + "o.", "Confirmar")
6306:         THIS.Release()
6307:     ENDPROC
6308: 
6309:     *-- Cancelar (cmd_4c_Cancela, ESC) - encerra o Caixa e devolve o controle
6310:     *-- ao form pai (Destroy() ja reabilita this_oParentForm).
6311:     PROCEDURE BtnCancelarClick()
6312:         IF MsgConfirma("Deseja realmente cancelar e encerrar o Caixa?", "Cancelar")
6313:             THIS.Release()
6314:         ENDIF
6315:     ENDPROC
6316: 
6317:     *==========================================================================
6318:     * HANDLERS - GRADES (CntFinanc.Cnt_GrdBarra / Cnt_Pendencia)
6319:     *==========================================================================
6320: 
6321:     *-- F2-Selec - legado: "Grade.Column1.SetFocus".
6322:     PROCEDURE CmdInserirBarraClick()
6323:         THIS.FocarControle(THIS.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras.Column1)
6324:     ENDPROC
6325: 
6326:     *-- F5-Barra - legado: "Cnt_Barras.Get_Barra_1.SetFocus()".
6327:     PROCEDURE CmdOkBarraClick()
6328:         THIS.FocarControle(THIS.cnt_4c_Financ.cnt_4c__Barras.txt_4c_Barra_1)
6329:     ENDPROC
6330: 
6331:     *-- F4-Excluir - legado: "Select TmpBarFin / Delete / Go Top /
6332:     *-- ThisForm.parentForm.Atuatot() / Get_total.Refresh() / Grade.Refresh()".
6333:     *-- Atuatot() do form pai fica fora de alcance (DataSession=2) - o total
6334:     *-- do carne e recalculado aqui, localmente, a partir do proprio
6335:     *-- TmpBarFin.
6336:     PROCEDURE CmdExcluirBarraClick()
6337:         LOCAL loc_nTotal
6338:         loc_nTotal = 0
6339: 
6340:         IF !USED("TmpBarFin")
6341:             RETURN
6342:         ENDIF
6343: 
6344:         SELECT TmpBarFin
6345:         DELETE
6346:         GO TOP
6347: 
6348:         SUM ValPs TO loc_nTotal
6349:         THIS.cnt_4c_Financ.txt_4c_Total.Value = loc_nTotal
6350: 
6351:         THIS.AtualizarGrades()
6352:     ENDPROC
6353: 
6354:     *-- [F3]Pend. - legado abre SigOpPen (tela de selecao de pendencias do
6355:     *-- cliente), sem equivalente migrado. A limpeza local de linhas com
6356:     *-- codigo zerado (Delete For Codigos = 0) e feita mesmo assim.
6357:     PROCEDURE CmdBotPendentesClick()
6358:         IF !USED("TmpOperacao")
6359:             RETURN
6360:         ENDIF
6361: 
6362:         SELECT TmpOperacao
6363:         DELETE FOR Codigos = 0
6364:         GO TOP
6365: 
6366:         THIS.AtualizarGrades()
6367:     ENDPROC
6368: 
6369:     *==========================================================================
6370:     * HANDLERS - PAINEL DE CANCELAMENTO DE ITEM (CancelaItem)
6371:     *==========================================================================
6372: 
6373:     *-- CancelaDisp - legado (6 linhas): reabilita CntItem e fecha o painel
6374:     *-- SEM cancelar nada.
6375:     PROCEDURE CancelaItemCancelaDispClick()
6376:         *-- Legado (CancelaDisp.Click): "Select crTpmMvItn / Set Order To".
6377:         *-- SET ORDER TO exige a ORDEM antes do IN (SET ORDER TO 0 IN <alias>);
6378:         *-- "SET ORDER TO IN <alias>" nao compila.
6379:         IF USED("crTpmMvItn")
6380:             SELECT crTpmMvItn
6381:             SET ORDER TO
6382:         ENDIF
6383:         THIS.CancelaItemFechar()
6384:     ENDPROC
6385: 
6386:     *-- Ok (confirmar cancelamento) - o legado abre "Do Form SigOpSen With
6387:     *-- 'CANCITEM',..." (senha de supervisor) antes de cancelar; sem
6388:     *-- equivalente migrado, MsgConfirma() faz o papel do gate de
6389:     *-- confirmacao. Remove o item de crTpmMvItn/crTpmMvItnC (local - a
6390:     *-- exclusao definitiva em SigMvItn e responsabilidade da fase de
6391:     *-- persistencia dos itens, ainda nao lancada nesta tela) e recalcula o
6392:     *-- total.
6393:     PROCEDURE CancelaItemOkClick()
6394:         LOCAL loc_nItem
6395:         loc_nItem = THIS.cnt_4c_CancelaItem.txt_4c_Item.Value
6396: 
6397:         IF loc_nItem <= 0 OR !USED("crTpmMvItn")
6398:             THIS.CancelaItemFechar()
6399:             RETURN
6400:         ENDIF
6401: 
6402:         IF MsgConfirma("Confirma o cancelamento do item " + TRANSFORM(loc_nItem) + "?", "Cancelamento de Item")
6403:             SELECT crTpmMvItn
6404:             DELETE FOR citens == loc_nItem
6405: 
6406:             IF USED("crTpmMvItnC")
6407:                 SELECT crTpmMvItnC
6408:                 DELETE FOR cItens == loc_nItem
6409:             ENDIF
6410: 
6411:             SELECT crTpmMvItn
6412:             GO TOP
6413:             IF EOF()
6414:                 THIS.this_nCitem = 0
6415:             ELSE
6416:                 GO BOTTOM
6417:                 THIS.this_nCitem = NVL(crTpmMvItn.citens, 0)
6418:             ENDIF
6419: 
6420:             THIS.RecalcularTotalCarrinho()
6421:             THIS.AtualizarGrades()
6422:         ENDIF
6423: 
6424:         THIS.CancelaItemFechar()
6425:     ENDPROC
6426: 
6427:     *==========================================================================
6428:     * HANDLERS - PAINEL DE CONSULTA DE PRECO (Cnt_Consulta)
6429:     *==========================================================================
6430: 
6431:     *-- Sair (Command1) - legado: fecha o overlay.
6432:     PROCEDURE ConsultaCommand1Click()
6433:         THIS.cnt_4c__Consulta.Visible = .F.
6434:     ENDPROC
6435: 
6436:     *-- Proximo - o legado so troca a imagem da seta em GotFocus/LostFocus
6437:     *-- (nao ha Click proprio capturado); tratado aqui como equivalente a
6438:     *-- Sair, fechando o overlay.
6439:     PROCEDURE ConsultaProximoClick()
6440:         THIS.cnt_4c__Consulta.Visible = .F.
6441:     ENDPROC
6442: 
6443:     *-- Get_Produto (ENTER/TAB) - consulta simples de preco por codigo do
6444:     *-- produto ou codigo de barras (SigCdPro.cpros/cbars/dpros/pvens).
6445:     PROCEDURE ConsultaProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6446:         LOCAL loc_cValor, loc_oErro
6447: 
6448:         IF !INLIST(par_nKeyCode, 13, 9)
6449:             RETURN
6450:         ENDIF
6451: 
6452:         loc_cValor = ALLTRIM(THIS.cnt_4c__Consulta.cnt_4c__Produto.txt_4c_Produto.Value)
6453:         IF EMPTY(loc_cValor)
6454:             RETURN
6455:         ENDIF
6456: 
6457:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
6458:             RETURN
6459:         ENDIF
6460: 
6461:         TRY
6462:             IF USED("cursor_4c_ConsultaPreco")
6463:                 USE IN cursor_4c_ConsultaPreco
6464:             ENDIF
6465: 
6466:             IF SQLEXEC(gnConnHandle, "SELECT dpros, pvens FROM SigCdPro WHERE cpros = " + ;
6467:                     EscaparSQL(PADR(loc_cValor, 14)) + " OR cbars = " + TRANSFORM(VAL(loc_cValor)), ;
6468:                     "cursor_4c_ConsultaPreco") > 0 ;
6469:                     AND USED("cursor_4c_ConsultaPreco") AND RECCOUNT("cursor_4c_ConsultaPreco") > 0
6470: 
6471:                 SELECT cursor_4c_ConsultaPreco
6472:                 GO TOP
6473:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage1.Caption = ;
6474:                     ALLTRIM(NVL(cursor_4c_ConsultaPreco.dpros, ""))
6475:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage2.Caption = ""
6476:                 THIS.cnt_4c__Consulta.txt_4c_Unit.Value = NVL(cursor_4c_ConsultaPreco.pvens, 0)
6477:             ELSE
6478:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage1.Caption = ;
6479:                     "Produto n" + CHR(227) + "o encontrado."
6480:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage2.Caption = ""
6481:                 THIS.cnt_4c__Consulta.txt_4c_Unit.Value = 0
6482:             ENDIF
6483: 
6484:             IF USED("cursor_4c_ConsultaPreco")
6485:                 USE IN cursor_4c_ConsultaPreco

*-- Linhas 6496 a 6788:
6496:     *-- CntItem.Proximo - legado: "If Get_Produto.Enabled / TotChamada=0 /
6497:     *-- Barra_Botoes.Pagto.Click() / Else / This.SetFocus" - aciona o mesmo
6498:     *-- botao Pagto da barra.
6499:     PROCEDURE ItemProximoClick()
6500:         IF THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Enabled
6501:             THIS.CmdPagtoClick()
6502:         ELSE
6503:             THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
6504:         ENDIF
6505:     ENDPROC
6506: 
6507:     *-- CntFinanc.Proximo - mesmo destino do CntItem.Proximo (Pagto).
6508:     PROCEDURE FinancProximoClick()
6509:         THIS.CmdPagtoClick()
6510:     ENDPROC
6511: 
6512:     *-- Cnt_Credito.Proximo - legado: "If Barra_Botoes.Itens.Visible /
6513:     *-- Itens.Click() / Else / Pagto.Click()" - volta para Itens.
6514:     PROCEDURE CreditoProximoClick()
6515:         THIS.CmdItensClick()
6516:     ENDPROC
6517: 
6518:     *-- Cnt_Pendencia.Proximo - mesmo padrao do Credito.
6519:     PROCEDURE PendenciaProximoClick()
6520:         THIS.CmdItensClick()
6521:     ENDPROC
6522: 
6523:     *-- Cnt_Fpagto.Proximo - avanca para a confirmacao da venda.
6524:     PROCEDURE FpagtoProximoClick()
6525:         THIS.BtnConfirmarClick()
6526:     ENDPROC
6527: 
6528:     *==========================================================================
6529:     * HANDLERS - COMBO DE TROCA DE OPERACAO (cbo_4c_CmbTOpers)
6530:     *==========================================================================
6531: 
6532:     *-- Legado (cmbTOpers.LostFocus): ENTER confirma a operacao escolhida e
6533:     *-- chama ThisForm.parentform.AciomudaOpe(...) - reconfiguracao completa
6534:     *-- do Caixa, fora de alcance deste form filho (DataSession=2). Aqui:
6535:     *-- registra a operacao escolhida localmente (this_cDopes) e avisa que a
6536:     *-- reconfiguracao e feita pela tela de movimentacao.
6537:     PROCEDURE CmbTOpersKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6538:         LOCAL loc_cDope
6539: 
6540:         IF par_nKeyCode != 13
6541:             RETURN
6542:         ENDIF
6543: 
6544:         IF THIS.cbo_4c_CmbTOpers.ListIndex > 0
6545:             loc_cDope = ALLTRIM(THIS.cbo_4c_CmbTOpers.List(THIS.cbo_4c_CmbTOpers.ListIndex))
6546:             THIS.this_cDopes = loc_cDope
6547:             MsgInfo("Opera" + CHR(231) + CHR(227) + "o alterada para " + loc_cDope + "." + CHR(13) + ;
6548:                 "A reconfigura" + CHR(231) + CHR(227) + "o completa do Caixa para a nova opera" + CHR(231) + CHR(227) + "o " + ;
6549:                 "e feita pela tela de movimenta" + CHR(231) + CHR(227) + "o.", "Muda Opera" + CHR(231) + CHR(227) + "o")
6550:         ENDIF
6551: 
6552:         THIS.cbo_4c_CmbTOpers.Visible = .F.
6553:     ENDPROC
6554: 
6555:     PROCEDURE CmbTOpersLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6556:         THIS.cbo_4c_CmbTOpers.Visible = .F.
6557:     ENDPROC
6558: 
6559:     *==========================================================================
6560:     * HANDLERS DE KEYPRESS - disparam o lookup em ENTER(13)/TAB(9)/F4(115).
6561:     * PUBLIC (sem PROTECTED): BINDEVENT so funciona com metodos PUBLIC
6562:     * (CLAUDE.md #3). Cada um resolve o(s) controle(s) do proprio bloco e
6563:     * delega para o AbrirLookupXxx correspondente.
6564:     *==========================================================================
6565: 
6566:     *-- Destino ---------------------------------------------------------------
6567:     PROCEDURE GrpDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6568:         IF INLIST(par_nKeyCode, 13, 9, 115)
6569:             THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Destino.txt_4c_Grupo)
6570:         ENDIF
6571:     ENDPROC
6572: 
6573:     PROCEDURE CtaDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6574:         LOCAL loc_oCnt
6575:         IF INLIST(par_nKeyCode, 13, 9, 115)
6576:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Destino
6577:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6578:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "iclis", ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
6579:         ENDIF
6580:     ENDPROC
6581: 
6582:     PROCEDURE DctDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6583:         LOCAL loc_oCnt
6584:         IF INLIST(par_nKeyCode, 13, 9, 115)
6585:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Destino
6586:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6587:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "rclis", ALLTRIM(loc_oCnt.txt_4c_Dconta.Value))
6588:         ENDIF
6589:     ENDPROC
6590: 
6591:     PROCEDURE CpfDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6592:         LOCAL loc_oCnt
6593:         IF INLIST(par_nKeyCode, 13, 9, 115)
6594:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Destino
6595:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6596:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "cpfs", ;
6597:                 CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value), ".-/", ""))
6598:         ENDIF
6599:     ENDPROC
6600: 
6601:     *-- Responsavel -------------------------------------------------------------
6602:     PROCEDURE GrpRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6603:         IF INLIST(par_nKeyCode, 13, 9, 115)
6604:             THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Responsavel.txt_4c_Grupo)
6605:         ENDIF
6606:     ENDPROC
6607: 
6608:     PROCEDURE CtaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6609:         LOCAL loc_oCnt
6610:         IF INLIST(par_nKeyCode, 13, 9, 115)
6611:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Responsavel
6612:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6613:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "iclis", ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
6614:         ENDIF
6615:     ENDPROC
6616: 
6617:     PROCEDURE DctRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6618:         LOCAL loc_oCnt
6619:         IF INLIST(par_nKeyCode, 13, 9, 115)
6620:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Responsavel
6621:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6622:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "rclis", ALLTRIM(loc_oCnt.txt_4c_Dconta.Value))
6623:         ENDIF
6624:     ENDPROC
6625: 
6626:     PROCEDURE CpfRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6627:         LOCAL loc_oCnt
6628:         IF INLIST(par_nKeyCode, 13, 9, 115)
6629:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Responsavel
6630:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6631:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "cpfs", ;
6632:                 CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value), ".-/", ""))
6633:         ENDIF
6634:     ENDPROC
6635: 
6636:     *-- Vendedor ----------------------------------------------------------------
6637:     PROCEDURE GrpVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6638:         IF INLIST(par_nKeyCode, 13, 9, 115)
6639:             THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Vendedor.txt_4c_Grupo)
6640:         ENDIF
6641:     ENDPROC
6642: 
6643:     PROCEDURE CtaVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6644:         LOCAL loc_oCnt
6645:         IF INLIST(par_nKeyCode, 13, 9, 115)
6646:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Vendedor
6647:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6648:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "iclis", ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
6649:         ENDIF
6650:     ENDPROC
6651: 
6652:     PROCEDURE DctVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6653:         LOCAL loc_oCnt
6654:         IF INLIST(par_nKeyCode, 13, 9, 115)
6655:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Vendedor
6656:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6657:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "rclis", ALLTRIM(loc_oCnt.txt_4c_Dconta.Value))
6658:         ENDIF
6659:     ENDPROC
6660: 
6661:     PROCEDURE CpfVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6662:         LOCAL loc_oCnt
6663:         IF INLIST(par_nKeyCode, 13, 9, 115)
6664:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Vendedor
6665:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6666:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "cpfs", ;
6667:                 CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value), ".-/", ""))
6668:         ENDIF
6669:     ENDPROC
6670: 
6671:     *-- Origem --------------------------------------------------------------
6672:     PROCEDURE GrpOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6673:         IF INLIST(par_nKeyCode, 13, 9, 115)
6674:             THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Origem.txt_4c_Grupo)
6675:         ENDIF
6676:     ENDPROC
6677: 
6678:     PROCEDURE CtaOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6679:         LOCAL loc_oCnt
6680:         IF INLIST(par_nKeyCode, 13, 9, 115)
6681:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Origem
6682:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6683:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "iclis", ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
6684:         ENDIF
6685:     ENDPROC
6686: 
6687:     PROCEDURE DctOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6688:         LOCAL loc_oCnt
6689:         IF INLIST(par_nKeyCode, 13, 9, 115)
6690:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Origem
6691:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6692:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "rclis", ALLTRIM(loc_oCnt.txt_4c_Dconta.Value))
6693:         ENDIF
6694:     ENDPROC
6695: 
6696:     PROCEDURE CpfOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6697:         LOCAL loc_oCnt
6698:         IF INLIST(par_nKeyCode, 13, 9, 115)
6699:             loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Origem
6700:             THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
6701:                 loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "cpfs", ;
6702:                 CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value), ".-/", ""))
6703:         ENDIF
6704:     ENDPROC
6705: 
6706:     *-- TabDesconto / ListaPreco / Forma de Pagamento --------------------------
6707:     PROCEDURE TabdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6708:         IF INLIST(par_nKeyCode, 13, 9, 115)
6709:             THIS.AbrirLookupTabDesconto(THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_Tabd)
6710:         ENDIF
6711:     ENDPROC
6712: 
6713:     PROCEDURE ListaPrecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6714:         IF INLIST(par_nKeyCode, 13, 9, 115)
6715:             THIS.AbrirLookupListaPreco(THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_ListaPreco)
6716:         ENDIF
6717:     ENDPROC
6718: 
6719:     PROCEDURE FpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6720:         IF INLIST(par_nKeyCode, 13, 9, 115)
6721:             THIS.AbrirLookupFormaPagamento(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
6722:         ENDIF
6723:     ENDPROC
6724: 
6725: 
6726:     *==========================================================================
6727:     * FASE 7 - EVENTOS DOS BOTOES QUE AINDA NAO TINHAM HANDLER
6728:     *
6729:     * Completa a cobertura de Click dos CommandButtons do SCX legado que nao
6730:     * pertencem a barra principal nem as grades: o Confirmar do bloco de item
6731:     * (CmdEnviaProd), a seta Proximo da tela de Identificacao, os dois
6732:     * btnCadastros (Origem/Destino) e os dois botoes do painel de cheque
6733:     * pre-datado (TefChq/ins).
6734:     *==========================================================================
6735: 
6736:     *--------------------------------------------------------------------------
6737:     * LimparCntItem - legado mLimpaCntItem(plInsere). Zera os campos do bloco
6738:     * de lancamento de item e, quando par_lInsere, recicla a linha "corrente"
6739:     * do carrinho: apaga as linhas sem produto e, se nao sobrou nenhuma em
6740:     * branco, cria a proxima (citens = MAX + 1, respeitando UltimoCancel).
6741:     *
6742:     * O INSERT do legado gravava tambem emps/dopes/numes (tirados de TprMvCab,
6743:     * cursor do form pai): crTpmMvItn desta tela NAO tem essas tres colunas
6744:     * (Fase 4, CriarCursoresGrades) - a empresa/operacao/documento da venda
6745:     * vivem nas properties this_cEmps/this_cDopes/this_nNumes e sao aplicadas
6746:     * na persistencia, nao na linha do carrinho. Por isso aqui so citens.
6747:     *--------------------------------------------------------------------------
6748:     PROTECTED PROCEDURE LimparCntItem(par_lInsere)
6749:         LOCAL loc_lInsere, loc_nMaxItem, loc_lTemBranco, loc_oCnt
6750: 
6751:         loc_lInsere = IIF(VARTYPE(par_lInsere) = "L", par_lInsere, .F.)
6752: 
6753:         IF loc_lInsere AND USED("crTpmMvItn")
6754:             SELECT crTpmMvItn
6755:             SET ORDER TO
6756:             GO TOP
6757:             DELETE FOR EMPTY(NVL(cpros, ""))
6758: 
6759:             *-- Sobrou alguma linha em branco utilizavel? (legado:
6760:             *-- "Seek(Spac(14),'crTpmMvItn','Cpros')")
6761:             LOCATE FOR EMPTY(NVL(cpros, "")) AND !DELETED()
6762:             loc_lTemBranco = !EOF()
6763: 
6764:             IF !loc_lTemBranco
6765:                 loc_nMaxItem = 0
6766:                 SELECT MAX(citens) AS nMaxItem ;
6767:                     FROM crTpmMvItn ;
6768:                     WHERE !EMPTY(NVL(cpros, "")) ;
6769:                     INTO CURSOR cursor_4c_MaxItem
6770:                 IF USED("cursor_4c_MaxItem")
6771:                     GO TOP IN cursor_4c_MaxItem
6772:                     loc_nMaxItem = NVL(cursor_4c_MaxItem.nMaxItem, 0)
6773:                     USE IN cursor_4c_MaxItem
6774:                 ENDIF
6775: 
6776:                 IF THIS.this_nUltimocancel > loc_nMaxItem
6777:                     loc_nMaxItem = THIS.this_nUltimocancel
6778:                 ENDIF
6779: 
6780:                 THIS.this_nCitem = loc_nMaxItem + 1
6781: 
6782:                 INSERT INTO crTpmMvItn (citens) VALUES (THIS.this_nCitem)
6783:             ENDIF
6784: 
6785:             SELECT crTpmMvItn
6786:             SET ORDER TO
6787:         ENDIF
6788: 

*-- Linhas 6807 a 7031:
6807:     * global do Fortyus que nao veio no acervo; RecalcularTotalCarrinho() faz
6808:     * a MESMA soma (SUM crTpmMvItn.totas), so localmente.
6809:     *--------------------------------------------------------------------------
6810:     PROTECTED PROCEDURE ExcluirItemCorrente()
6811:         LOCAL loc_nItem
6812: 
6813:         IF !USED("crTpmMvItn")
6814:             RETURN
6815:         ENDIF
6816: 
6817:         SELECT crTpmMvItn
6818:         IF EOF()
6819:             RETURN
6820:         ENDIF
6821: 
6822:         loc_nItem = NVL(citens, 0)
6823:         DELETE
6824: 
6825:         THIS.this_nCitem = THIS.this_nCitem - 1
6826: 
6827:         IF USED("crTpmMvItnC")
6828:             SELECT crTpmMvItnC
6829:             DELETE FOR cItens == loc_nItem
6830:         ENDIF
6831: 
6832:         THIS.RecalcularTotalCarrinho()
6833:         THIS.AtualizarGrades()
6834: 
6835:         SELECT crTpmMvItn
6836:         GO BOTTOM
6837:     ENDPROC
6838: 
6839:     *--------------------------------------------------------------------------
6840:     * CmdEnviaProdClick - Confirmar do bloco de item (CntItem.Cnt_Produto.
6841:     * CmdEnviaProd). Legado (Click): "ThisForm.CmdEnviaProd() / This.Visible =
6842:     * .f. / Get_Produto.SetFocus".
6843:     *
6844:     * O metodo CmdEnviaProd do legado imprime o item no cupom fiscal
6845:     * (ItemFiscal/CancelCupom/AtuaCupom) - impressora ECF, fora de alcance
6846:     * desta tela migrada (mesmo limite ja documentado em BtnConfirmarClick). O que
6847:     * NAO depende do ECF e transcrito fielmente: valor zero rejeita o item
6848:     * (mensagem do legado, remove a linha e remonta o bloco), valor valido
6849:     * marca ImpCupFis, reabilita o [F4]Canc e recicla a linha corrente.
6850:     *--------------------------------------------------------------------------
6851:     PROCEDURE CmdEnviaProdClick()
6852:         LOCAL loc_nValor
6853: 
6854:         loc_nValor = THIS.cnt_4c_Item.cnt_4c__Subtotal.txt_4c_Valor.Value
6855: 
6856:         IF loc_nValor = 0
6857:             *-- Legado: "Messagebox('Valor do Produto Invalido !!',0+48,'')"
6858:             MsgAviso("Valor do Produto Inv" + CHR(225) + "lido !!", "Confirmar Item")
6859:             THIS.ExcluirItemCorrente()
6860:             THIS.LimparCntItem(.T.)
6861:         ELSE
6862:             THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = "Imprimindo Itens..."
6863: 
6864:             IF USED("crTpmMvItn") AND !EOF("crTpmMvItn")
6865:                 SELECT crTpmMvItn
6866:                 REPLACE ImpCupFis WITH .T.
6867:             ENDIF
6868: 
6869:             *-- Legado: "ThisForm.Barra_Botoes.Apaga.Enabled = .T."
6870:             THIS.cnt_4c_Barra_Botoes.cmd_4c_Apaga.Enabled = .T.
6871: 
6872:             THIS.MontarLinhasCupom()
6873:             THIS.AtualizarGrades()
6874:             THIS.LimparCntItem(.T.)
6875:         ENDIF
6876: 
6877:         THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = ""
6878:         THIS.LimparCntItem(.F.)
6879: 
6880:         THIS.cnt_4c_Item.cnt_4c__Produto.cmd_4c_CmdEnviaProd.Visible = .F.
6881:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
6882:     ENDPROC
6883: 
6884:     *--------------------------------------------------------------------------
6885:     * IdentificaProximoClick - seta "Proximo" da tela de Identificacao.
6886:     * Legado (Cnt_Identifica.Proximo.Click): "If Barra_Botoes.Itens.Visible /
6887:     * Itens.Click() ... Else / Pagto.SetFocus + Pagto.Click()". A troca de
6888:     * imagem da seta (GotFocus/LostFocus) e so visual e nao tem efeito de
6889:     * negocio.
6890:     *--------------------------------------------------------------------------
6891:     PROCEDURE IdentificaProximoClick()
6892:         IF THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Visible
6893:             THIS.CmdItensClick()
6894:         ELSE
6895:             THIS.CmdPagtoClick()
6896:         ENDIF
6897:     ENDPROC
6898: 
6899:     *--------------------------------------------------------------------------
6900:     * AbrirCadastroConta - corpo comum dos dois btnCadastros (Origem/Destino).
6901:     * Legado: exige Conta E CPF/CNPJ preenchidos, so age em INSERIR/ALTERAR e
6902:     * abre o Cadastro de Contas ("Do Form SIGCDCTA With 0,[SIGCDCTA],lcCli,
6903:     * .T.,lcCpf,lcGru").
6904:     *
6905:     * SIGCDCTA foi migrado como FormCTA ("Cadastro de Contas"), cujo Init NAO
6906:     * recebe parametros - o posicionamento equivalente e feito preenchendo o
6907:     * filtro de Grupo da pagina Lista e recarregando a grade antes do Show().
6908:     * O grupo de cadastro do legado vinha de crSigCdOpe.GruCadOs/GruCadDs
6909:     * (cursor global do form pai, inalcancavel com DataSession = 2): aqui usa
6910:     * o Grupo do proprio bloco, que e o fallback que o legado ja usava quando
6911:     * GruCad*s estava vazio.
6912:     *
6913:     * Show() fica FORA do TRY (CLAUDE.md #29): FormCTA e modal, entao o Show()
6914:     * bloqueia e TODO o uso da tela correria dentro do bloco - um erro de
6915:     * runtime la dentro saltaria para o CATCH, a referencia LOCAL cairia e a
6916:     * tela fecharia sozinha.
6917:     *--------------------------------------------------------------------------
6918:     PROTECTED PROCEDURE AbrirCadastroConta(par_oBloco)
6919:         LOCAL loc_cConta, loc_cCpf, loc_cGrupo, loc_oForm, loc_oFiltros, loc_oErro
6920:         LOCAL loc_lProsseguir
6921: 
6922:         loc_lProsseguir = .F.
6923:         loc_cConta = ALLTRIM(NVL(par_oBloco.txt_4c_Conta.Value, ""))
6924:         loc_cCpf   = ALLTRIM(NVL(par_oBloco.txt_4c_Cpf.Value, ""))
6925:         loc_cGrupo = ALLTRIM(NVL(par_oBloco.txt_4c_Grupo.Value, ""))
6926: 
6927:         IF EMPTY(loc_cConta) OR EMPTY(loc_cCpf)
6928:             *-- Legado: "E Necessario o Preenchimento Da Conta e Que a Mesma
6929:             *-- Possua Um CPF/CNPJ!!!"
6930:             MsgAviso(CHR(233) + " Necess" + CHR(225) + "rio o Preenchimento Da Conta e Que a Mesma " + ;
6931:                 "Possua Um CPF/CNPJ!!!", "Dados Incompletos")
6932:             THIS.FocarControle(par_oBloco.txt_4c_Conta)
6933:         ELSE
6934:             loc_lProsseguir = INLIST(UPPER(ALLTRIM(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
6935:         ENDIF
6936: 
6937:         IF !loc_lProsseguir
6938:             RETURN
6939:         ENDIF
6940: 
6941:         loc_oForm = .NULL.
6942:         TRY
6943:             loc_oForm = CREATEOBJECT("FormCTA")
6944:         CATCH TO loc_oErro
6945:             MsgErro("Erro ao abrir o Cadastro de Contas:" + CHR(13) + loc_oErro.Message + ;
6946:                 CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
6947:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Cadastro de Contas")
6948:             loc_oForm = .NULL.
6949:         ENDTRY
6950: 
6951:         IF VARTYPE(loc_oForm) = "O"
6952:             *-- Posiciona o filtro de Grupo da Lista no grupo da conta
6953:             *-- escolhida. Os PEMSTATUS ficam em IFs ANINHADOS de proposito:
6954:             *-- VFP9 nao garante short-circuit em AND/OR, entao encadea-los na
6955:             *-- mesma expressao avaliaria loc_oForm.pgf_4c_Paginas.Page1 mesmo
6956:             *-- quando o PageFrame nao existe (CLAUDE.md #27).
6957:             IF !EMPTY(loc_cGrupo)
6958:                 IF PEMSTATUS(loc_oForm, "pgf_4c_Paginas", 5)
6959:                     IF PEMSTATUS(loc_oForm.pgf_4c_Paginas.Page1, "cnt_4c_Filtros", 5)
6960:                         loc_oFiltros = loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Filtros
6961:                         IF PEMSTATUS(loc_oFiltros, "txt_4c_Grupo", 5)
6962:                             loc_oFiltros.txt_4c_Grupo.Value = loc_cGrupo
6963:                             IF PEMSTATUS(loc_oForm, "CarregarLista", 5)
6964:                                 loc_oForm.CarregarLista()
6965:                             ENDIF
6966:                         ENDIF
6967:                     ENDIF
6968:                 ENDIF
6969:             ENDIF
6970: 
6971:             loc_oForm.Show()
6972:         ENDIF
6973:     ENDPROC
6974: 
6975:     *-- btnCadastros do bloco Destino.
6976:     PROCEDURE BtnCadastrosDestinoClick()
6977:         THIS.AbrirCadastroConta(THIS.cnt_4c__Identifica.cnt_4c_Destino)
6978:     ENDPROC
6979: 
6980:     *-- btnCadastros do bloco Origem.
6981:     PROCEDURE BtnCadastrosOrigemClick()
6982:         THIS.AbrirCadastroConta(THIS.cnt_4c__Identifica.cnt_4c_Origem)
6983:     ENDPROC
6984: 
6985:     *--------------------------------------------------------------------------
6986:     * LimparChequePreTef - legado limpa_cheptef. Devolve os campos do painel
6987:     * de cheque aos brancos com o TAMANHO de cada um (space(3)/space(4)/...),
6988:     * exatamente como o legado - o TextBox e char e o InputMask depende do
6989:     * comprimento.
6990:     *--------------------------------------------------------------------------
6991:     PROTECTED PROCEDURE LimparChequePreTef()
6992:         LOCAL loc_oChq
6993:         loc_oChq = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
6994: 
6995:         WITH loc_oChq
6996:             .txt_4c_Bco.Value     = SPACE(3)
6997:             .txt_4c_Age.Value     = SPACE(4)
6998:             .txt_4c_Agendc.Value  = SPACE(1)
6999:             .txt_4c_Conta.Value   = SPACE(10)
7000:             .txt_4c_Contadc.Value = SPACE(1)
7001:             .txt_4c_Num.Value     = SPACE(6)
7002:             .txt_4c_Numdc.Value   = SPACE(6)
7003:             .txt_4c_Pca.Value     = SPACE(34)
7004:             .Refresh()
7005:         ENDWITH
7006:     ENDPROC
7007: 
7008:     *--------------------------------------------------------------------------
7009:     * ValidarChequesLancados - o SCAN de abertura do TefChq.Click legado:
7010:     * percorre xPar e, para cada parcela cuja forma de pagamento e CHEQUE
7011:     * (Infos = "C"), exige banco, agencia, conta, numero e CPF/CNPJ
7012:     * preenchidos. Devolve .T. quando todas passam.
7013:     *
7014:     * xPar.Infos e a copia local de SigOpFp.Infos (Fase 4,
7015:     * CriarCursoresGrades) - e por isso que aqui NAO e preciso repetir o
7016:     * cursorquery('SigOpFp','CrOpFp','Fpags',xPar.Fpags) que o legado fazia
7017:     * linha a linha.
7018:     *
7019:     * Alem do guard do legado, confere numero de cheque REPETIDO dentro da
7020:     * mesma venda: e a inconsistencia que o botao "Ins" (sequenciamento)
7021:     * existe para evitar, e a unica checagem de duplicidade possivel
7022:     * localmente.
7023:     *
7024:     * NAO reproduz a consulta a fChkCheques(banco, agencia, conta, numero, ...)
7025:     * - funcao global do Fortyus (SIGFUNCS.PRG) que NAO veio no acervo e que
7026:     * consulta o historico/restricao do cheque. Um wrapper devolvendo .T.
7027:     * APROVARIA em silencio um cheque que o legado recusaria (CLAUDE.md #27:
7028:     * jamais stub que devolve veredicto), por isso a ausencia fica VISIVEL na
7029:     * mensagem do caminho de sucesso, em vez de ser silenciada.
7030:     *--------------------------------------------------------------------------
7031:     PROTECTED FUNCTION ValidarChequesLancados()

*-- Linhas 7102 a 7225:
7102:     * confirmacao diz explicitamente o que foi e o que NAO foi conferido -
7103:     * aprovar calado seria pior que a ausencia (CLAUDE.md #27).
7104:     *--------------------------------------------------------------------------
7105:     PROCEDURE CmdTefChqClick()
7106:         LOCAL loc_oChq, loc_nTotLiquido, loc_nTotForma
7107: 
7108:         loc_oChq = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
7109: 
7110:         THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = ""
7111:         THIS.this_lNoklostche = .T.
7112: 
7113:         IF !THIS.ValidarChequesLancados()
7114:             *-- Legado: "MessageBox('Cheque Invalido!!!',0+48,'')" + limpa +
7115:             *-- "Replace xPar.nidcheps with 0" + "Get_pca.SetFocus".
7116:             MsgAviso("Cheque Inv" + CHR(225) + "lido!!!", "Conferir Cheque")
7117:             THIS.LimparChequePreTef()
7118:             IF USED("xPar")
7119:                 SELECT xPar
7120:                 IF !EOF()
7121:                     REPLACE nIdCheps WITH 0
7122:                 ENDIF
7123:             ENDIF
7124:             THIS.FocarControle(loc_oChq.txt_4c_Pca)
7125:             RETURN
7126:         ENDIF
7127: 
7128:         MsgInfo("Numera" + CHR(231) + CHR(227) + "o dos cheques conferida." + CHR(13) + ;
7129:             "A consulta ao gerenciador TEF e a impress" + CHR(227) + "o do cheque prosseguem na tela " + ;
7130:             "de movimenta" + CHR(231) + CHR(227) + "o.", "Conferir Cheque")
7131: 
7132:         loc_nTotLiquido = THIS.cnt_4c__Fpagto.txt_4c_TotLiquido.Value
7133:         loc_nTotForma   = THIS.cnt_4c__Fpagto.txt_4c_TotForma.Value
7134: 
7135:         THIS.this_lNoklostche = .F.
7136:         THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Visible = .F.
7137:         THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Refresh()
7138: 
7139:         IF loc_nTotLiquido = loc_nTotForma AND loc_nTotLiquido != 0 AND loc_nTotForma != 0
7140:             THIS.cnt_4c_Barra_Botoes.cmd_4c_Cancela.Enabled = .T.
7141:             THIS.BtnConfirmarClick()
7142:         ELSE
7143:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cmd_4c_Proximo)
7144:         ENDIF
7145:     ENDPROC
7146: 
7147:     *--------------------------------------------------------------------------
7148:     * CmdInsChequeClick - botao "Ins" do painel de cheque. ToolTipText do
7149:     * legado: "insere a sequencia dos numeros dos cheques e mostra na grade".
7150:     *
7151:     * Legado (Cnt_Chq.ins.Click): guarda os dados do cheque da linha CORRENTE
7152:     * de xPar (banco/agencia/conta/digitos/CPF/praca/numero), pula para a linha
7153:     * seguinte, limpa os campos de numero na tela e, da linha seguinte ate o
7154:     * fim, replica esses dados incrementando o numero do cheque de 1 em 1
7155:     * (Transform(...,'@L 999999')); no fim reordena, volta ao topo, refaz o
7156:     * bind da grade e poe o foco na coluna Valor.
7157:     *
7158:     * O SetAll('DynamicForeColor',...) do legado pinta a linha conforme
7159:     * InsChs/NumChqs/nIdCheps/Trocos - transcrito com os nomes das colunas
7160:     * deste cursor. O rebind e feito por MontaGrade(), que ja reaplica na ordem
7161:     * correta RecordSource -> ControlSource -> Width -> Header (Problema 48).
7162:     *--------------------------------------------------------------------------
7163:     PROCEDURE CmdInsChequeClick()
7164:         LOCAL loc_oChq, loc_oGrd
7165:         LOCAL loc_cBco, loc_cAgc, loc_cCta, loc_cDAgc, loc_cDCta, loc_cCpf, loc_cPca, loc_cNum
7166: 
7167:         IF !USED("xPar")
7168:             RETURN
7169:         ENDIF
7170: 
7171:         loc_oChq = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
7172: 
7173:         SELECT xPar
7174:         IF EOF()
7175:             RETURN
7176:         ENDIF
7177: 
7178:         loc_cBco  = NVL(Bancos, "")
7179:         loc_cAgc  = NVL(Agencias, "")
7180:         loc_cCta  = NVL(Contas, "")
7181:         loc_cDAgc = NVL(DigAgencs, "")
7182:         loc_cDCta = NVL(DigContas, "")
7183:         loc_cCpf  = NVL(Cpfs, "")
7184:         loc_cPca  = NVL(Pracas, "")
7185:         loc_cNum  = NVL(Numeros, "")
7186: 
7187:         SKIP
7188:         loc_oChq.txt_4c_Num.Value   = ""
7189:         loc_oChq.txt_4c_Numdc.Value = ""
7190: 
7191:         DO WHILE !EOF()
7192:             loc_cNum = TRANSFORM(VAL(loc_cNum) + 1, "@L 999999")
7193:             REPLACE Bancos    WITH loc_cBco, ;
7194:                     Agencias  WITH loc_cAgc, ;
7195:                     Contas    WITH loc_cCta, ;
7196:                     Numeros   WITH loc_cNum, ;
7197:                     DigAgencs WITH loc_cDAgc, ;
7198:                     DigContas WITH loc_cDCta, ;
7199:                     Cpfs      WITH loc_cCpf, ;
7200:                     Pracas    WITH loc_cPca IN xPar
7201:             SKIP
7202:         ENDDO
7203: 
7204:         SELECT xPar
7205:         SET ORDER TO
7206:         GO TOP
7207: 
7208:         THIS.MontaGrade()
7209: 
7210:         loc_oGrd = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas
7211:         loc_oGrd.SetAll("DynamicForeColor", ;
7212:             "IIF(xPar.InsChs, IIF(!EMPTY(NVL(xPar.NumChqs, '')), RGB(255,0,0), RGB(0,0,255))," + ;
7213:             " IIF(NVL(xPar.nIdCheps, 0) = 0, IIF(NVL(xPar.Trocos, 0) = 1, RGB(0,0,160), RGB(0,0,0)), RGB(0,0,255)))", ;
7214:             "Column")
7215:         loc_oGrd.Refresh()
7216: 
7217:         *-- Legado: ".valor.text1.SetFocus" - o alvo do foco e o TextBox da
7218:         *-- coluna Valor (Column2), nao a Column.
7219:         THIS.FocarControle(loc_oGrd.Column2.Text1)
7220:     ENDPROC
7221: 
7222:     *==========================================================================
7223:     * CONSOLIDACAO FINAL (FASE 8) - TRANSFERENCIA FORM <-> BO, PERSISTENCIA
7224:     * DOS ITENS LANCADOS E GATE DOS BOTOES POR ESTADO DA TELA
7225:     *==========================================================================

*-- Linhas 7348 a 7391:
7348:             MsgErro("Erro ao preparar o item para grava" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
7349:                 loc_oErro.Message + CHR(13) + ;
7350:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
7351:                 "Procedure: " + loc_oErro.Procedure, "FormParaBO")
7352:             loc_lSucesso = .F.
7353:         ENDTRY
7354: 
7355:         RETURN loc_lSucesso
7356:     ENDFUNC
7357: 
7358:     *--------------------------------------------------------------------------
7359:     * BOParaForm - caminho inverso do FormParaBO: joga as propriedades do BO
7360:     * na linha corrente de crTpmMvItn e nos campos de lancamento visiveis do
7361:     * CntItem, para o caixa VER o item que o BO carregou (usado depois de
7362:     * CarregarDoCursor, quando um item ja gravado e retomado para conferencia).
7363:     *
7364:     * REPLACE exige o cursor posicionado na linha certa: quem chama posiciona
7365:     * (LOCATE FOR citens = ...) antes. Sem linha valida o metodo devolve .F. e
7366:     * nao toca em nada.
7367:     *--------------------------------------------------------------------------
7368:     PROTECTED FUNCTION BOParaForm()
7369:         LOCAL loc_oBO, loc_oCnt, loc_lSucesso, loc_oErro
7370:         loc_lSucesso = .F.
7371: 
7372:         TRY
7373:             IF USED("crTpmMvItn") AND !EOF("crTpmMvItn")
7374:                 loc_oBO = THIS.this_oBusinessObject
7375:                 SELECT crTpmMvItn
7376: 
7377:                 REPLACE citens     WITH loc_oBO.this_nCitens, ;
7378:                         cpros      WITH loc_oBO.this_cCpros, ;
7379:                         dpros      WITH loc_oBO.this_cDpros, ;
7380:                         cunis      WITH loc_oBO.this_cCunis, ;
7381:                         codbarras  WITH loc_oBO.this_nCodbarras, ;
7382:                         codlprecs  WITH loc_oBO.this_nCodlprecs, ;
7383:                         empdopnums WITH loc_oBO.this_cEmpdopnums, ;
7384:                         etiesps    WITH loc_oBO.this_lEtiesps, ;
7385:                         fators     WITH loc_oBO.this_nFators, ;
7386:                         fatvals    WITH loc_oBO.this_nFatvals ;
7387:                     IN crTpmMvItn
7388: 
7389:                 REPLACE moedas   WITH loc_oBO.this_cMoedas, ;
7390:                         moefats  WITH loc_oBO.this_cMoefats, ;
7391:                         moevals  WITH loc_oBO.this_nMoevals, ;

*-- Linhas 7427 a 7470:
7427:             MsgErro("Erro ao exibir o item carregado:" + CHR(13) + ;
7428:                 loc_oErro.Message + CHR(13) + ;
7429:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
7430:                 "Procedure: " + loc_oErro.Procedure, "BOParaForm")
7431:             loc_lSucesso = .F.
7432:         ENDTRY
7433: 
7434:         RETURN loc_lSucesso
7435:     ENDFUNC
7436: 
7437:     *--------------------------------------------------------------------------
7438:     * GravarItensLancados - persiste em SigMvItn TODOS os itens do carrinho
7439:     * (crTpmMvItn) que tem produto informado, um a um, via BO.
7440:     *
7441:     * Este e o passo que fechava no legado por outro caminho: la o pai gravava
7442:     * o cursor inteiro com TableUpdate na datasession COMPARTILHADA. Aqui, com
7443:     * DataSession = 2, cada linha vira NovoRegistro() + FormParaBO() +
7444:     * Salvar().
7445:     *
7446:     * Erro em QUALQUER item aborta o laco e devolve .F. - nao existe "gravou
7447:     * metade da venda". Quem chama (BtnConfirmarClick) so anuncia sucesso e
7448:     * fecha a tela se isto devolver .T.
7449:     *
7450:     * BusinessBase.Salvar() ja exibe a falha sozinho (ExibirFalha) e marca
7451:     * this_lErroExibido, entao aqui NAO se repete a mensagem (CLAUDE.md #20).
7452:     *--------------------------------------------------------------------------
7453:     PROTECTED FUNCTION GravarItensLancados()
7454:         LOCAL loc_oBO, loc_lSucesso, loc_nGravados, loc_nRec, loc_oErro
7455:         loc_lSucesso  = .T.
7456:         loc_nGravados = 0
7457: 
7458:         IF !USED("crTpmMvItn")
7459:             RETURN .F.
7460:         ENDIF
7461: 
7462:         TRY
7463:             loc_oBO = THIS.this_oBusinessObject
7464: 
7465:             SELECT crTpmMvItn
7466:             SET ORDER TO
7467:             GO TOP
7468: 
7469:             *-- Laco explicito em vez de SCAN/ENDSCAN de proposito: Salvar()
7470:             *-- faz SQLEXEC e RegistrarAuditoria no meio da iteracao e pode

*-- Linhas 7518 a 7677:
7518:             MsgErro("Erro ao gravar os itens da venda:" + CHR(13) + ;
7519:                 loc_oErro.Message + CHR(13) + ;
7520:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
7521:                 "Procedure: " + loc_oErro.Procedure, "Confirmar")
7522:             loc_lSucesso = .F.
7523:         ENDTRY
7524: 
7525:         *-- Carrinho com produto mas nada gravado nao e sucesso: devolve .F.
7526:         *-- para o Confirmar nao anunciar venda validada sem registro no banco
7527:         *-- (CLAUDE.md #189 - nunca reportar sucesso sem ter gravado).
7528:         IF loc_lSucesso AND loc_nGravados = 0
7529:             loc_lSucesso = .F.
7530:         ENDIF
7531: 
7532:         RETURN loc_lSucesso
7533:     ENDFUNC
7534: 
7535:     *--------------------------------------------------------------------------
7536:     * CarregarLista - ponto de entrada canonico de (re)carga da tela. Este
7537:     * form nao tem pagina de LISTA de registros (nao e cadastro): o que ele
7538:     * lista e o CUPOM da venda corrente, na grade grd_4c_Cupom. Recarrega os
7539:     * itens da movimentacao pelo BO e repinta as cinco grades.
7540:     *
7541:     * Popular cursor NAO repinta grade: a chamada a AtualizarGrades e
7542:     * obrigatoria, senao a tela aparece vazia com o cursor cheio (CLAUDE.md
7543:     * #21). CarregarDados ja chama AtualizarGrades no caminho de sucesso; a
7544:     * chamada aqui cobre o caminho em que ele volta .F. (sem conexao / venda
7545:     * nova sem numero), em que as grades tambem precisam ser repintadas no
7546:     * estado vazio para o painel CAIXA LIVRE aparecer.
7547:     *--------------------------------------------------------------------------
7548:     PROCEDURE CarregarLista()
7549:         LOCAL loc_lSucesso
7550: 
7551:         loc_lSucesso = THIS.CarregarDados()
7552:         THIS.AtualizarGrades()
7553:         THIS.RecalcularTotalCarrinho()
7554: 
7555:         RETURN loc_lSucesso
7556:     ENDPROC
7557: 
7558:     *--------------------------------------------------------------------------
7559:     * HabilitarCampos - liga/desliga os campos de LANCAMENTO de item.
7560:     *
7561:     * No legado o equivalente sao as clausulas When de cada campo do
7562:     * Cnt_Produto/Cnt_Subtotal/Cnt_Desconto, que devolvem .F. (campo
7563:     * inacessivel) quando a operacao nao esta em INSERIR/ALTERAR - por exemplo
7564:     * Get_Produto.When: "InList(ThisForm.Op_Escolha,'INSERIR','ALTERAR') And
7565:     * Empty(This.Value)". Reproduzido aqui como um gate unico, porque
7566:     * BINDEVENT descarta o retorno de um When delegado e por isso nao bloqueia
7567:     * edicao (CLAUDE.md #3).
7568:     *
7569:     * Valor e desconto seguem o gate do legado: so ficam acessiveis quando a
7570:     * alteracao de preco/valor foi liberada (this_lLalterapreco /
7571:     * this_lLalteravalor), como em Get_valor.When e Get_valdesc.When.
7572:     *--------------------------------------------------------------------------
7573:     PROCEDURE HabilitarCampos(par_lHabilitar)
7574:         LOCAL loc_lHab, loc_oCnt
7575: 
7576:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
7577:         loc_oCnt = THIS.cnt_4c_Item
7578: 
7579:         loc_oCnt.cnt_4c__Produto.txt_4c_Produto.Enabled = loc_lHab
7580:         loc_oCnt.cnt_4c__Produto.txt_4c_Qtds.Enabled    = loc_lHab
7581: 
7582:         *-- Preco unitario: no legado o campo so abre com alteracao de valor
7583:         *-- liberada (Barra_Botoes.AltPreco) - fora disso o preco vem da
7584:         *-- tabela e nao se digita.
7585:         loc_oCnt.cnt_4c__Subtotal.txt_4c_Valor.Enabled = ;
7586:             (loc_lHab AND (THIS.this_lLalteravalor OR THIS.this_lLalterapreco))
7587: 
7588:         *-- Desconto/acrescimo: liberados junto com a alteracao de preco.
7589:         loc_oCnt.cnt_4c__Desconto.txt_4c_Valdesc.Enabled   = (loc_lHab AND THIS.this_lLalterapreco)
7590:         loc_oCnt.cnt_4c__Desconto.txt_4c_Pvaldesc.Enabled  = (loc_lHab AND THIS.this_lLalterapreco)
7591:         loc_oCnt.cnt_4c__Desconto.txt_4c_ValAcre.Enabled   = (loc_lHab AND THIS.this_lLalterapreco)
7592:         loc_oCnt.cnt_4c__Desconto.txt_4c__pValAcre.Enabled = (loc_lHab AND THIS.this_lLalterapreco)
7593: 
7594:         *-- Original: somente leitura no legado (Get_unival.When: Return .F.).
7595:         loc_oCnt.cnt_4c__Desconto.txt_4c_Unival.Enabled = .F.
7596: 
7597:         *-- TOTAL da venda: somente leitura no legado (Get_total.When: .F.).
7598:         loc_oCnt.txt_4c_Total.Enabled = .F.
7599:     ENDPROC
7600: 
7601:     *--------------------------------------------------------------------------
7602:     * LimparCampos - limpa os campos de lancamento de item SEM mexer no
7603:     * carrinho. Delega ao LimparCntItem(.F.), que e a transcricao do
7604:     * mLimpaCntItem legado: com .F. ele apenas zera os TextBoxes; com .T. ele
7605:     * tambem reorganiza crTpmMvItn e abre a proxima linha em branco.
7606:     *--------------------------------------------------------------------------
7607:     PROTECTED PROCEDURE LimparCampos()
7608:         THIS.LimparCntItem(.F.)
7609:     ENDPROC
7610: 
7611:     *--------------------------------------------------------------------------
7612:     * AjustarBotoesPorModo - aplica o gate de disponibilidade dos botoes da
7613:     * barra principal conforme o estado da tela. Transcrito das clausulas When
7614:     * do SCX legado (Barra_Botoes.*.When), que sao o mecanismo que o legado
7615:     * usa para isso:
7616:     *
7617:     *   Itens / identifica / credito / pendencia / Financia / Pagto:
7618:     *       "Return ( Not ThisForm.Cnt_Fpagto.Cnt_ChequepreTef.Visible )"
7619:     *       - o painel de cheque pre-datado aberto TRAVA a navegacao.
7620:     *   credito / pendencia / Financia / ok:  "... And ThisForm.Inicia"
7621:     *   identifica:  "... And (ThisForm.Inicia Or ThisForm.LiberaIdent)"
7622:     *   CancPagto:   "Return ( Cnt_Fpagto.Visible And Not Cnt_ChequepreTef.Visible )"
7623:     *   apaga:       "Return (Empty(Get_Produto.Value) And CntItem.Visible )"
7624:     *   Alteraqtd:   "Return (Empty(Get_Produto.Value) And CntItem.Visible
7625:     *                 And Get_Produto.Enabled )"
7626:     *   impfiscal:   "Return (Empty(Get_Produto.Value)
7627:     *                 And Not Cnt_ChequepreTef.Visible And Lastkey() # 13 )"
7628:     *                 - a parte "Lastkey() # 13" pertence ao When (roda a cada
7629:     *                   tentativa de foco) e nao tem sentido num ajuste de
7630:     *                   estado; o resto e transcrito.
7631:     *
7632:     * Chamado no fim de AlternarTelaOperacao, que e o FUNIL por onde toda
7633:     * troca de tela passa - quem desabilita tem de reabilitar no caminho de
7634:     * volta, senao os botoes ficam cinza e a tela fica inutilizavel (CLAUDE.md
7635:     * #40).
7636:     *--------------------------------------------------------------------------
7637:     PROCEDURE AjustarBotoesPorModo()
7638:         LOCAL loc_oCnt, loc_lChequeAberto, loc_lItensVisivel, loc_lFpagtoVisivel
7639:         LOCAL loc_lSemProduto, loc_lInicia
7640: 
7641:         loc_oCnt = THIS.cnt_4c_Barra_Botoes
7642: 
7643:         loc_lChequeAberto  = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Visible
7644:         loc_lItensVisivel  = THIS.cnt_4c_Item.Visible
7645:         loc_lFpagtoVisivel = THIS.cnt_4c__Fpagto.Visible
7646:         loc_lInicia        = THIS.this_lInicia
7647:         loc_lSemProduto    = EMPTY(ALLTRIM(NVL( ;
7648:             THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Value, "")))
7649: 
7650:         *-- Navegacao entre telas - travada com o cheque pre-datado aberto.
7651:         loc_oCnt.cmd_4c_Itens.Enabled      = !loc_lChequeAberto
7652:         loc_oCnt.cmd_4c_Identifica.Enabled = (!loc_lChequeAberto AND ;
7653:             (loc_lInicia OR THIS.this_lLiberaident))
7654:         loc_oCnt.cmd_4c_Credito.Enabled    = (!loc_lChequeAberto AND loc_lInicia)
7655:         loc_oCnt.cmd_4c_Pendencia.Enabled  = (!loc_lChequeAberto AND loc_lInicia)
7656:         loc_oCnt.cmd_4c_Financia.Enabled   = (!loc_lChequeAberto AND loc_lInicia)
7657:         loc_oCnt.cmd_4c_Pagto.Enabled      = !loc_lChequeAberto
7658: 
7659:         *-- Acoes sobre o item corrente - so com o painel de Itens na frente e
7660:         *-- nenhum produto em digitacao.
7661:         loc_oCnt.cmd_4c_Apaga.Enabled     = (loc_lSemProduto AND loc_lItensVisivel)
7662:         loc_oCnt.cmd_4c_Alteraqtd.Enabled = (loc_lSemProduto AND loc_lItensVisivel AND ;
7663:             THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Enabled)
7664: 
7665:         *-- Cancelamento de forma de pagamento - so na tela de Pagamento.
7666:         loc_oCnt.cmd_4c_CancPagto.Enabled = (loc_lFpagtoVisivel AND !loc_lChequeAberto)
7667: 
7668:         *-- Impressora fiscal.
7669:         loc_oCnt.cmd_4c_Impfiscal.Enabled = (loc_lSemProduto AND !loc_lChequeAberto)
7670: 
7671:         *-- Confirmar: no legado "Return (ThisForm.Inicia)". Cancelar fica
7672:         *-- SEMPRE disponivel (Cancel = .T. no SCX) - a saida da tela nunca
7673:         *-- pode ficar bloqueada.
7674:         loc_oCnt.cmd_4c_Ok.Enabled      = loc_lInicia
7675:         loc_oCnt.cmd_4c_Cancela.Enabled = .T.
7676:     ENDPROC
7677: 

