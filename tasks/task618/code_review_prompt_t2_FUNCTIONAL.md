# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (48)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_CONTAINER5. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.this_lPermiteAjustarPrioridade()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH ENDFOR define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDFOR.RecordSource).
- [GRID-WITH] Bloco WITH 0 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: 0.RecordSource).
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=1 vs migrado 'lbl_4c_Label1' Top=168 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container3): Left original=0 vs migrado 'lbl_4c_Label1' Left=132 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=163 vs migrado 'lbl_4c_label23' Top=18 (diff=145px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page1.Container3): Left original=128 vs migrado 'lbl_4c_label23' Left=448 (diff=320px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=161 vs migrado 'txt_4c_tot_qtd2' Top=113 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=161 vs migrado 'txt_4c_tot_est2' Top=113 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=161 vs migrado 'txt_4c_Tot_Prz' Top=370 (diff=209px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLX.PageDados.Page1.Container3): Left original=292 vs migrado 'txt_4c_Tot_Prz' Left=648 (diff=356px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container5): Top original=18 vs migrado 'lbl_4c_Label1' Top=168 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container5): Left original=269 vs migrado 'lbl_4c_Label1' Left=132 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container1): Top original=1 vs migrado 'lbl_4c_Label1' Top=168 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container1): Left original=1 vs migrado 'lbl_4c_Label1' Left=132 (diff=131px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page1.Container1): Top original=115 vs migrado 'lbl_4c_label23' Top=18 (diff=97px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page1.Container1): Left original=102 vs migrado 'lbl_4c_label23' Left=448 (diff=346px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1): Top original=348 vs migrado 'lbl_4c_Label1' Top=168 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1): Left original=224 vs migrado 'lbl_4c_Label1' Left=132 (diff=92px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page1): Top original=346 vs migrado 'txt_4c_tot_qtd2' Top=113 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page1): Left original=271 vs migrado 'txt_4c_tot_qtd2' Left=145 (diff=126px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page1): Top original=346 vs migrado 'txt_4c_tot_est2' Top=113 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page1): Left original=407 vs migrado 'txt_4c_tot_est2' Left=207 (diff=200px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLX.PageDados.Page1): Left original=476 vs migrado 'txt_4c_Tot_Prz' Left=648 (diff=172px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page2): Top original=372 vs migrado 'lbl_4c_Label1' Top=168 (diff=204px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page2): Left original=403 vs migrado 'lbl_4c_Label1' Left=132 (diff=271px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page2): Top original=370 vs migrado 'txt_4c_tot_qtd2' Top=113 (diff=257px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page2): Left original=449 vs migrado 'txt_4c_tot_qtd2' Left=145 (diff=304px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page2): Top original=370 vs migrado 'txt_4c_tot_est2' Top=113 (diff=257px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page2): Left original=516 vs migrado 'txt_4c_tot_est2' Left=207 (diff=309px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page2): Top original=164 vs migrado 'lbl_4c_label23' Top=18 (diff=146px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page2): Left original=383 vs migrado 'lbl_4c_label23' Left=448 (diff=65px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page3): Top original=147 vs migrado 'lbl_4c_label23' Top=18 (diff=129px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page3): Left original=173 vs migrado 'lbl_4c_label23' Left=448 (diff=275px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page4): Top original=418 vs migrado 'lbl_4c_label23' Top=18 (diff=400px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page4): Left original=220 vs migrado 'lbl_4c_label23' Left=448 (diff=228px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRGLX.PageDados.Page4): Left original=192 vs migrado 'lbl_4c_Label3' Left=261 (diff=69px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Qt_pedida' (parent: SIGPRGLX.PageDados.Page4): Left original=312 vs migrado 'txt_4c_Qt_pedida' Left=379 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Qt_Selec' (parent: SIGPRGLX.PageDados.Page4): Left original=312 vs migrado 'txt_4c_Qt_Selec' Left=379 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page4): Left original=197 vs migrado 'lbl_4c_Label1' Left=132 (diff=65px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page5): Top original=415 vs migrado 'lbl_4c_label23' Top=18 (diff=397px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page5): Left original=289 vs migrado 'lbl_4c_label23' Left=448 (diff=159px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page5): Left original=246 vs migrado 'lbl_4c_Label1' Left=132 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.Aguarde): Top original=18 vs migrado 'lbl_4c_Label1' Top=168 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.Aguarde): Left original=208 vs migrado 'lbl_4c_Label1' Left=132 (diff=76px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.Aguarde): Top original=52 vs migrado 'lbl_4c_label23' Top=18 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.Aguarde): Left original=137 vs migrado 'lbl_4c_label23' Left=448 (diff=311px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4149 linhas total):

*-- Linhas 14 a 141:
14: * principal, selecao de linha/estoque/disponivel/requisicao), navegadas
15: * por botao (Tabs=.F.), nao por cadastro.
16: *
17: * Estrutura ja entregue: DEFINE CLASS, Init, InicializarForm,
18: * ConfigurarPageFrame (PageFrame com as 6 paginas do legado + cabecalho da
19: * Page1) e Destroy (Fase 3); grade principal e botoes de acao da Page1
20: * (Fase 4); grade de selecao, totais, imagem e observacao da Page2
21: * (Fases 5-6); e, nesta Fase 6, as sub-paginas restantes - Page3 (Totais
22: * por Linha), Page4 (Selecionar Estoque), Page5 (Disponivel/Tamanho) e
23: * Page6 (Requisicao Manual de Material), esta ultima com os DOIS unicos
24: * lookups do form (Column1/Column5 de GradePedra -> SigCdPro, via
25: * FormBuscaAuxiliar). Os handlers de Click/navegacao e o processamento
26: * entram nas Fases 7-8.
27: *==============================================================================
28: 
29: DEFINE CLASS FormSigPrGlx AS FormBase
30: 
31:     Height       = 600
32:     Width        = 800
33:     AutoCenter   = .T.
34:     BorderStyle  = 2
35:     ShowWindow   = 0
36:     DataSession  = 2
37:     ShowWindow = 1
38:     MaxButton    = .F.
39:     MinButton    = .F.
40:     FontName     = "Tahoma"
41:     FontSize     = 8
42:     *-- WindowType = 0 na classe (evita timeout em VFP9 -T/harness de teste);
43:     *-- producao promove para modal (1) no Init, como FormICD/FormHOR/FormGps.
44:     WindowType   = 0
45: 
46:     *--------------------------------------------------------------------------
47:     * Parametros recebidos de quem abre a previa - equivalentes ao
48:     * Lparameters _ParentForm, _Data, _ReservaAuto, _nGerEmphPdr, _Autom,
49:     * _numeroOp, _PorDestino do Init legado. Repassados para o BO em
50:     * InicializarForm (SigPrGlxBO.this_lReserva/this_nEmphPdr/
51:     * this_lAutomatico/this_cNumeroDaOp/this_lPorDestino).
52:     *--------------------------------------------------------------------------
53:     this_oFormPai      = .NULL.    && thisform.ParentForm (_ParentForm) - de fato FormSigPrGl2 (CREATEOBJECT("FormSigPrGlx", THIS, ...) em FormSigPrGl2.BtnProcessarClick)
54:     this_dDataAnalise  = {}        && thisform.Data        (_Data) - vestigial: o real 2o parametro enviado por FormSigPrGl2 eh this_nDataSessionId (NUMERICO), nao uma data
55:     this_lReservaAuto  = .F.       && thisform.Reserva     (_ReservaAuto)
56:     this_nGerEmphPdr   = 0         && thisform.EmphPdr      (_nGerEmphPdr)
57:     this_lAutomatico   = .F.       && thisform.Automatico   (_Autom)
58:     this_nNumeroDaOp   = 0         && thisform.Numerodaop   (_numeroOp) - NUMERICO: FormSigPrGl2.BtnProcessarClick envia VAL(this_cNumeroDaOp)
59:     this_lPorDestino   = .F.       && thisform.PorDestino   (_PorDestino)
60: 
61:     *-- Guarda de reentrancia dos lookups de produto da Page6: o Show() do
62:     *-- picker bloqueia, o foco sai e volta da celula da grade e o proprio
63:     *-- gatilho pode disparar de novo, empilhando um segundo picker.
64:     this_lLookupEmCurso = .F.
65: 
66:     *-- ThisForm.OldValue do legado - valor da celula ANTES da edicao, usado
67:     *-- pelos Valid das colunas digitaveis (Page1 e Page2, Column7/Column10)
68:     *-- para restaurar o conteudo quando a validacao recusa.
69:     *--
70:     *-- Tem de ser property do FORM, como no legado: medido no VFP9 em
71:     *-- 2026-10-06 que NEM Column, NEM Column.Text1, NEM TextBox possuem
72:     *-- OldValue (PEMSTATUS = .F. nos tres; ler estoura "Property OLDVALUE
73:     *-- is not found"). O legado captura em "ThisForm.OldValue = This.Value"
74:     *-- no When de cada coluna; aqui a captura vai no GotFocus das mesmas
75:     *-- colunas, porque BINDEVENT em "When" nao dispara de forma confiavel
76:     *-- (regra #3 do CLAUDE.md) e GotFocus tem o mesmo gatilho util: o
77:     *-- usuario entrou na celula e ainda nao digitou.
78:     this_nOldValue = 0
79: 
80:     *-- ThisForm.Liberado do legado - gate de UMA edicao da coluna
81:     *-- "Produzir Estq" (Column8/GradeItens Page1) apos autorizacao de
82:     *-- BtnAlteraqtdClick (DO FORM SigOpSen). Consumido e desarmado no
83:     *-- LostFocus da propria coluna.
84:     this_lLiberadoAlteracao = .F.
85: 
86:     *--------------------------------------------------------------------------
87:     * Init - recebe os parametros do chamador (equivalente ao Lparameters do
88:     * legado) e delega o resto para FormBase.Init() (que chama
89:     * InicializarForm()). Promove WindowType/ShowWindow para modal fora do
90:     * modo de teste, igual ao padrao FormICD/FormHOR/FormGps.
91:     *--------------------------------------------------------------------------
92:     PROCEDURE Init()
93:         LPARAMETERS par_oFormPai, par_dData, par_lReservaAuto, par_nGerEmphPdr, ;
94:                     par_lAutomatico, par_cNumeroOp, par_lPorDestino
95: 
96:         IF PCOUNT() >= 1
97:             IF VARTYPE(par_oFormPai) = "O"
98:                 THIS.this_oFormPai = par_oFormPai
99: 
100:                 *-- CRITICO: assume a DataSessionId do pai ANTES do DODEFAULT()
101:                 *-- (que chama InicializarForm()) - sem isto este form abre
102:                 *-- numa sessao privada NOVA e TmpFinal/TmpFinalg (criados por
103:                 *-- FormSigPrGl2BO.ExecutarProcessamento na sessao do PAI)
104:                 *-- ficam invisiveis: a grade principal abriria sempre vazia.
105:                 *-- Mesmo padrao ja adotado em FormSigPrGlp.Init.
106:                 IF PEMSTATUS(par_oFormPai, "DataSessionId", 5)
107:                     THIS.DataSessionId = par_oFormPai.DataSessionId
108:                 ENDIF
109:             ENDIF
110:         ENDIF
111: 
112:         *-- par_dData (2o parametro) eh vestigial - o chamador real
113:         *-- (FormSigPrGl2.BtnProcessarClick) envia this_nDataSessionId
114:         *-- (NUMERICO), que o Init legado tambem nunca lia. Guardado so
115:         *-- quando vier DATE/DATETIME de fato (chamada manual/teste).
116:         IF PCOUNT() >= 2
117:             IF INLIST(VARTYPE(par_dData), "D", "T")
118:                 THIS.this_dDataAnalise = par_dData
119:             ENDIF
120:         ENDIF
121: 
122:         IF PCOUNT() >= 3
123:             IF VARTYPE(par_lReservaAuto) = "L"
124:                 THIS.this_lReservaAuto = par_lReservaAuto
125:             ENDIF
126:         ENDIF
127: 
128:         IF PCOUNT() >= 4
129:             IF VARTYPE(par_nGerEmphPdr) = "N"
130:                 THIS.this_nGerEmphPdr = par_nGerEmphPdr
131:             ENDIF
132:         ENDIF
133: 
134:         IF PCOUNT() >= 5
135:             IF VARTYPE(par_lAutomatico) = "L"
136:                 THIS.this_lAutomatico = par_lAutomatico
137:             ENDIF
138:         ENDIF
139: 
140:         *-- par_cNumeroOp eh NUMERICO no chamador real (VAL(this_cNumeroDaOp))
141:         IF PCOUNT() >= 6

*-- Linhas 162 a 299:
162:     ENDPROC
163: 
164:     *--------------------------------------------------------------------------
165:     * InicializarForm - cria o Business Object, repassa os parametros
166:     * recebidos no Init e monta a estrutura visual base (PageFrame + as 6
167:     * paginas do legado + cabecalho da Page1).
168:     *--------------------------------------------------------------------------
169:     *
170:     * NAO LIGAR "SET EXACT ON" NESTA TELA. Este form tem DataSession = 2,
171:     * logo nasce com os SETs no default do VFP (EXACT OFF) - e eh disso que
172:     * TODA a navegacao por item depende. Medido no VFP9 em 2026-10-06, com
173:     * chave de 22 chars (CPros+CodCors+CodTams) sobre indice de 34:
174:     *
175:     *   SET EXACT OFF -> SEEK prefixo = .T.   | SET KEY prefixo -> 1 linha
176:     *   SET EXACT ON  -> SEEK prefixo = .F.   | SET KEY prefixo -> 0 linhas
177:     *
178:     * Com EXACT ON as grades de resumo (cursor_4c_TmpSaldg/cursor_4c_TmpFabr,
179:     * cujos indices tem Priors/Grupos/Estos/Emps/Nops DEPOIS da chave do
180:     * item) ficariam PERMANENTEMENTE VAZIAS e os Valid das colunas
181:     * digitaveis deixariam de achar o saldo - sem erro e sem log. O
182:     * config.prg liga EXACT ON na sessao 1; esta sessao privada nao herda, e
183:     * eh justamente o que faz o codigo funcionar igual ao legado.
184:     *--------------------------------------------------------------------------
185:     PROTECTED PROCEDURE InicializarForm()
186:         LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro
187:         loc_lSucesso = .F.
188: 
189:         THIS.Caption = IIF(THIS.this_lReservaAuto, ;
190:             "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica", ;
191:             "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o")
192:         THIS.this_cTituloForm = THIS.Caption
193: 
194:         TRY
195:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlxBO")
196:             loc_lProsseguir = (VARTYPE(THIS.this_oBusinessObject) = "O")
197: 
198:             IF !loc_lProsseguir
199:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrGlxBO.", ;
200:                         "Erro em InicializarForm")
201:             ENDIF
202: 
203:             IF loc_lProsseguir
204:                 THIS.this_oBusinessObject.this_lReserva    = THIS.this_lReservaAuto
205:                 THIS.this_oBusinessObject.this_nEmphPdr     = THIS.this_nGerEmphPdr
206:                 THIS.this_oBusinessObject.this_lAutomatico  = THIS.this_lAutomatico
207:                 THIS.this_oBusinessObject.this_nNumeroDaOp  = THIS.this_nNumeroDaOp
208:                 THIS.this_oBusinessObject.this_lPorDestino  = THIS.this_lPorDestino
209: 
210:                 THIS.ConfigurarPageFrame()
211:                 THIS.ConfigurarPaginaLista()
212:                 THIS.ConfigurarPaginaDados()
213:                 THIS.ConfigurarPaginaTotaisLinha()
214:                 THIS.ConfigurarPaginaEstoque()
215:                 THIS.ConfigurarPaginaTamanhos()
216:                 THIS.ConfigurarPaginaRequisicao()
217: 
218:                 THIS.TornarControlesVisiveis(THIS)
219: 
220:                 *-- BOParaForm DEPOIS de TornarControlesVisiveis: este ultimo
221:                 *-- forca Visible = .T. em todo controle que nao esteja na
222:                 *-- sua lista de excecao, e eh BOParaForm quem decide a
223:                 *-- visibilidade REAL de Pedras/SelEstoque/Disponivel a
224:                 *-- partir de crSigCdPam/fChecaAcesso - rodar antes faria a
225:                 *-- decisao ser sobrescrita se a lista mudar. Tambem repoe o
226:                 *-- titulo e o rotulo "Periodo: NN meses".
227:                 THIS.BOParaForm()
228: 
229:                 *-- Carga da grade principal + filtros relacionais + totais
230:                 *-- (bloco final do Init legado). Em modo de teste/validacao
231:                 *-- de UI nao ha dados do form pai - pular evita o aviso
232:                 *-- "sem dados de globalizacao" num contexto sem usuario.
233:                 IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
234:                      (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
235:                     THIS.CarregarLista()
236:                 ENDIF
237: 
238:                 THIS.pgf_4c_1.ActivePage = 1
239: 
240:                 loc_lSucesso = .T.
241:             ENDIF
242:         CATCH TO loc_oErro
243:             MsgErro(loc_oErro.Message + CHR(13) + ;
244:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
245:                     "Procedure: " + loc_oErro.Procedure, ;
246:                     "Erro em InicializarForm")
247:             loc_lSucesso = .F.
248:         ENDTRY
249: 
250:         RETURN loc_lSucesso
251:     ENDPROC
252: 
253:     *--------------------------------------------------------------------------
254:     * ConfigurarPageFrame - cria o pgf_4c_1 (SIGPRGLX.PageDados no legado)
255:     * com as 6 paginas originais (Tabs=.F. - navegacao por botao, nao por
256:     * aba nativa) e o cabecalho (cntSombra do legado), que so existe na
257:     * Page1. Grid/totais/botoes de cada pagina entram nas proximas fases.
258:     *--------------------------------------------------------------------------
259:     PROTECTED PROCEDURE ConfigurarPageFrame()
260:         LOCAL loc_oPag1, loc_oCab
261: 
262:         THIS.AddObject("pgf_4c_1", "PageFrame")
263: 
264:         WITH THIS.pgf_4c_1
265:             .Top       = -27
266:             .Left      = -1
267:             .Width     = 804
268:             .Height    = 635
269:             .PageCount = 6
270:             .Tabs      = .F.
271:         ENDWITH
272: 
273:         *-- Page1: cabecalho (cntSombra legado) - unico container de titulo
274:         *-- do form; as demais paginas sao sub-telas de selecao/detalhe e nao
275:         *-- repetem a faixa.
276:         loc_oPag1 = THIS.pgf_4c_1.Page1
277: 
278:         loc_oPag1.AddObject("cnt_4c_Sombra", "Container")
279:         loc_oCab = loc_oPag1.cnt_4c_Sombra
280: 
281:         WITH loc_oCab
282:             .Top         = -1
283:             .Left        = 0
284:             .Width       = THIS.Width
285:             .Height      = 80
286:             .BackColor   = RGB(100, 100, 100)
287:             .BackStyle   = 1
288:             .BorderWidth = 0
289:             .SpecialEffect = 0
290:         ENDWITH
291: 
292:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
293:         WITH loc_oCab.lbl_4c_LblSombra
294:             .AutoSize  = .F.
295:             .Top       = 18
296:             .Left      = 10
297:             .Width     = 769
298:             .Height    = 40
299:             .FontName  = "Tahoma"

*-- Linhas 332 a 399:
332:     * Analisada"), a imagem do produto (ImgFigJpg) e os totais gerais da
333:     * pagina (Tot_Qtd/Tot_Est/Tot_Prz/Tot_prdc/Tot_prze), alem dos botoes de
334:     * acao/navegacao - todos filhos DIRETOS da Page1 (mapeamento.json:
335:     * SIGPRGLX.PageDados.Page1.<X>). Posicoes/Top/Left copiadas de
336:     * tasks/task618/layout.json SEM a compensacao +27 do PageFrame, mesmo
337:     * padrao ja usado no cnt_4c_Sombra (Fase 3).
338:     *
339:     * grd_4c_Dados liga DIRETO em TmpFinalg - cursor da MESMA DataSession
340:     * privada que FormSigPrGl2BO.ExecutarProcessamento deixa aberto (nome
341:     * LITERAL, nao cursor_4c_ - regra documentada em
342:     * FormSigPrGl2.BtnProcessarClick), por isso o Init assume
343:     * THIS.DataSessionId = par_oFormPai.DataSessionId. Em modo de teste de
344:     * UI (gb_4c_ValidandoUI), TmpFinalg nao existe - cria-se aqui um
345:     * cursor de apoio com a MESMA estrutura so para a tela abrir sem erro.
346:     * cursor_4c_TmpSaldg/cursor_4c_TmpFabr (Container3/Container1) sao os
347:     * equivalentes migrados de TmpSaldG/TmpFabr - mesma origem compartilhada.
348:     *--------------------------------------------------------------------------
349:     *--------------------------------------------------------------------------
350:     * this_lPermiteAjustarPrioridade - "If fChecaAcesso('SIGPRGLO',
351:     * 'PRIORIDADE')" do legado (Init, Container1/Container3.GradeDisp):
352:     * controla se a coluna Prior das grades de resumo eh editavel e se
353:     * cmd_4c_SelEstoque fica visivel.
354:     *--------------------------------------------------------------------------
355:     PROTECTED FUNCTION this_lPermiteAjustarPrioridade()
356:         RETURN fChecaAcesso("SIGPRGLO", "PRIORIDADE")
357:     ENDFUNC
358: 
359:     PROTECTED PROCEDURE ConfigurarPaginaLista()
360:         LOCAL loc_oPag1, loc_oCnt, loc_nCol
361: 
362:         loc_oPag1 = THIS.pgf_4c_1.Page1
363: 
364:         IF !USED("TmpFinalg")
365:             CREATE CURSOR TmpFinalg (Flag C(1), CPros C(14), CodCors C(4), CodTams C(4), ;
366:                 Linhas C(10), Qtds N(10,3), Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), ;
367:                 Fabrs N(10,3), Produzir2 N(10,3), TotVenda N(10,3), QtdMins N(10,3), ;
368:                 KeySelM L, KeySelMP L, UsuLibs C(10))
369:             INDEX ON Cpros + CodCors + CodTams TAG Cpros
370:         ENDIF
371:         IF !USED("cursor_4c_TmpSaldg")
372:             SET NULL ON
373:             CREATE CURSOR cursor_4c_TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), ;
374:                 CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Priors N(2), Reservs N(12,3))
375:             SET NULL OFF
376:             INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + Grupos + Estos + Emps TAG CPros
377:             INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
378:         ENDIF
379:         IF !USED("cursor_4c_TmpFabr")
380:             SET NULL ON
381:             CREATE CURSOR cursor_4c_TmpFabr (Priors N(2), Nops N(10), Fases C(10), Cpros C(14), ;
382:                 CodCors C(4), CodTams C(4), Qtds N(12,3), Disps N(12,3), Reservs N(12,3))
383:             SET NULL OFF
384:             INDEX ON Cpros + CodCors + CodTams + STR(Priors, 2) + STR(Nops, 10) TAG Cpros
385:         ENDIF
386:         IF !USED("cursor_4c_TmpSaldo")
387:             SET NULL ON
388:             CREATE CURSOR cursor_4c_TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), ;
389:                 Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
390:             SET NULL OFF
391:             INDEX ON CPros + CodCors + CodTams TAG CPros
392:         ENDIF
393:         *-- TmpSaldU (Init legado): marca "produto com selecao manual" por
394:         *-- item (KeySelm/KeySelmp), consultado/alterado pelos Valid das
395:         *-- colunas editaveis (Column7 aqui, Column10 na Page2)
396:         IF !USED("TmpSaldU")
397:             CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L, KeySelmp L)
398:             INDEX ON Cpros TAG Cpros
399:         ENDIF

*-- Linhas 469 a 535:
469:         ENDWITH
470: 
471:         *-- GotFocus -> Column7.SetFocus SO nas colunas que o legado redireciona
472:         *-- (Column1/2/5/6/9 - dump: ver lista de PROCEDURE por coluna). NUNCA
473:         *-- no laco inteiro de 1 a 10: Column7 (Qtd Producao), Column8
474:         *-- (Produzir Estq, liberada por BtnAlteraqtdClick) e Column10 (Qtd
475:         *-- Estoque) sao JUSTAMENTE as digitaveis - redirecionar o foco delas
476:         *-- torna as tres inalcancaveis e o usuario nao consegue digitar nada.
477:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
478:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
479:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column5.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
480:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column6.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
481:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column9.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
482:         loc_oPag1.grd_4c_Dados.Column3.Text1.ReadOnly = .T.
483:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column3.Text1, "DblClick", THIS, "GradeItensPage1Column3DblClick")
484:         *-- Captura do "ThisForm.OldValue = This.Value" do When (as duas
485:         *-- colunas digitaveis) - sem isto o Valid nao tem com que comparar
486:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "CapturarOldValuePage1Col7")
487:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "GotFocus", THIS, "CapturarOldValuePage1Col10")
488:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "Valid", THIS, "GradeItensPage1Column7Valid")
489:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "KeyPress", THIS, "GradeItensPage1LostFocus")
490:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column8.Text1, "KeyPress", THIS, "GradeItensPage1Column8LostFocus")
491:         *-- Column10 (Qtd Estoque) eh a SEGUNDA coluna digitavel do legado -
492:         *-- mesmo par Valid/LostFocus de Column7 (dump 7046-7146)
493:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "Valid", THIS, "GradeItensPage1Column10Valid")
494:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "KeyPress", THIS, "GradeItensPage1LostFocus")
495:         BINDEVENT(loc_oPag1.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensPage1AfterRowColChange")
496: 
497:         *-- Container3 "Estoque Disponivel" (grupo/conta, TmpSaldG) --------
498:         loc_oPag1.AddObject("cnt_4c_Container3", "Container")
499:         loc_oCnt = loc_oPag1.cnt_4c_Container3
500:         WITH loc_oCnt
501:             .Top = 371
502:             .Left = 50
503:             .Width = 363
504:             .Height = 186
505:             .BackStyle = 0
506:             .BorderWidth = 0
507:         ENDWITH
508: 
509:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
510:         WITH loc_oCnt.lbl_4c_Label1
511:             .AutoSize = .F.
512:             .Top = 1
513:             .Left = 0
514:             .Width = 363
515:             .Height = 16
516:             .FontBold = .T.
517:             .BackStyle = 0
518:             .ForeColor = RGB(90, 90, 90)
519:             .Caption = "Estoque Dispon" + CHR(237) + "vel"
520:         ENDWITH
521: 
522:         loc_oCnt.AddObject("grd_4c_DispGrupo", "Grid")
523: 
524:         *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
525:         *-- antes de o bloco abaixo acessar .Column1..Column6.
526:         loc_oCnt.grd_4c_DispGrupo.RecordSource = ""
527:         loc_oCnt.grd_4c_DispGrupo.ColumnCount = 6
528:         loc_oCnt.grd_4c_DispGrupo.RecordSource = "cursor_4c_TmpSaldg"
529: 
530:         WITH loc_oCnt.grd_4c_DispGrupo
531:             .Top = 15
532:             .Left = 3
533:             .Width = 358
534:             .Height = 147
535:             .RecordMark = .F.

*-- Linhas 553 a 607:
553:             .Column6.Header1.Caption = "Prior"
554:             .Column6.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
555:         ENDWITH
556:         BINDEVENT(loc_oCnt.grd_4c_DispGrupo.Column6.Text1, "KeyPress", THIS, "GradeDispGrupoColumn6LostFocus")
557: 
558:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
559:         WITH loc_oCnt.lbl_4c_Label2
560:             .AutoSize = .F.
561:             .Top = 163
562:             .Left = 128
563:             .Width = 42
564:             .Height = 17
565:             .FontBold = .T.
566:             .BackStyle = 0
567:             .ForeColor = RGB(90, 90, 90)
568:             .Caption = "Totais :"
569:         ENDWITH
570: 
571:         loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
572:         WITH loc_oCnt.txt_4c_Tot_Qtd
573:             .Top = 161
574:             .Left = 174
575:             .Width = 58
576:             .Height = 19
577:             .InputMask = "999,999.99"
578:             .ReadOnly = .T.
579:             .Value = 0
580:         ENDWITH
581:         loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
582:         WITH loc_oCnt.txt_4c_Tot_Est
583:             .Top = 161
584:             .Left = 234
585:             .Width = 58
586:             .Height = 19
587:             .InputMask = "999,999.99"
588:             .ReadOnly = .T.
589:             .Value = 0
590:         ENDWITH
591:         loc_oCnt.AddObject("txt_4c_Tot_Prz", "TextBox")
592:         WITH loc_oCnt.txt_4c_Tot_Prz
593:             .Top = 161
594:             .Left = 292
595:             .Width = 58
596:             .Height = 19
597:             .InputMask = "999,999.99"
598:             .ReadOnly = .T.
599:             .Value = 0
600:         ENDWITH
601: 
602:         *-- Container1 "Estoque Em Producao" (fase, TmpFabr) ---------------
603:         loc_oPag1.AddObject("cnt_4c_Container1", "Container")
604:         loc_oCnt = loc_oPag1.cnt_4c_Container1
605:         WITH loc_oCnt
606:             .Top = 371
607:             .Left = 418

*-- Linhas 656 a 699:
656:             .Column6.Header1.Caption = "Nop"
657:             .Column6.Visible = .F.
658:         ENDWITH
659:         BINDEVENT(loc_oCnt.grd_4c_DispFase.Column4.Text1, "KeyPress", THIS, "GradeDispFaseColumn4LostFocus")
660: 
661:         loc_oCnt.AddObject("lbl_4c_label22", "Label")
662:         WITH loc_oCnt.lbl_4c_label22
663:             .AutoSize = .F.
664:             .Top = 115
665:             .Left = 102
666:             .Width = 42
667:             .Height = 17
668:             .FontBold = .T.
669:             .BackStyle = 0
670:             .ForeColor = RGB(90, 90, 90)
671:             .Caption = "Totais :"
672:         ENDWITH
673:         loc_oCnt.AddObject("txt_4c_tot_qtd2", "TextBox")
674:         WITH loc_oCnt.txt_4c_tot_qtd2
675:             .Top = 113
676:             .Left = 145
677:             .Width = 61
678:             .Height = 19
679:             .InputMask = "999,999.99"
680:             .ReadOnly = .T.
681:             .Value = 0
682:         ENDWITH
683:         loc_oCnt.AddObject("txt_4c_tot_est2", "TextBox")
684:         WITH loc_oCnt.txt_4c_tot_est2
685:             .Top = 113
686:             .Left = 207
687:             .Width = 61
688:             .Height = 19
689:             .InputMask = "999,999.99"
690:             .ReadOnly = .T.
691:             .Value = 0
692:         ENDWITH
693: 
694:         *-- Container5 "Periodo/Referencia Analisada" ----------------------
695:         loc_oPag1.AddObject("cnt_4c_Container5", "Container")
696:         loc_oCnt = loc_oPag1.cnt_4c_Container5
697:         WITH loc_oCnt
698:             .Top = 129
699:             .Left = 36

*-- Linhas 787 a 861:
787:             .Stretch = 1
788:             .Visible = .F.
789:         ENDWITH
790:         BINDEVENT(loc_oPag1.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgPage1DblClick")
791: 
792:         *-- Totais gerais da pagina (soma de TmpFinalg) --------------------
793:         loc_oPag1.AddObject("lbl_4c_Label1", "Label")
794:         WITH loc_oPag1.lbl_4c_Label1
795:             .AutoSize = .F.
796:             .Top = 348
797:             .Left = 224
798:             .Width = 42
799:             .Height = 17
800:             .FontBold = .T.
801:             .BackStyle = 0
802:             .ForeColor = RGB(90, 90, 90)
803:             .Caption = "Totais :"
804:         ENDWITH
805:         loc_oPag1.AddObject("txt_4c_Tot_Qtd", "TextBox")
806:         WITH loc_oPag1.txt_4c_Tot_Qtd
807:             .Top = 346
808:             .Left = 271
809:             .Width = 67
810:             .Height = 19
811:             .InputMask = "999,999.99"
812:             .ReadOnly = .T.
813:             .Value = 0
814:         ENDWITH
815:         loc_oPag1.AddObject("txt_4c_Tot_prdc", "TextBox")
816:         WITH loc_oPag1.txt_4c_Tot_prdc
817:             .Top = 346
818:             .Left = 339
819:             .Width = 67
820:             .Height = 19
821:             .InputMask = "999,999.99"
822:             .ReadOnly = .T.
823:             .Value = 0
824:         ENDWITH
825:         loc_oPag1.AddObject("txt_4c_Tot_Est", "TextBox")
826:         WITH loc_oPag1.txt_4c_Tot_Est
827:             .Top = 346
828:             .Left = 407
829:             .Width = 68
830:             .Height = 19
831:             .InputMask = "999,999.99"
832:             .ReadOnly = .T.
833:             .Value = 0
834:         ENDWITH
835:         loc_oPag1.AddObject("txt_4c_Tot_Prz", "TextBox")
836:         WITH loc_oPag1.txt_4c_Tot_Prz
837:             .Top = 346
838:             .Left = 476
839:             .Width = 67
840:             .Height = 19
841:             .InputMask = "999,999.99"
842:             .ReadOnly = .T.
843:             .Value = 0
844:         ENDWITH
845:         loc_oPag1.AddObject("txt_4c_Tot_prze", "TextBox")
846:         WITH loc_oPag1.txt_4c_Tot_prze
847:             .Top = 346
848:             .Left = 543
849:             .Width = 75
850:             .Height = 19
851:             .InputMask = "999,999.99"
852:             .ReadOnly = .T.
853:             .Value = 0
854:         ENDWITH
855: 
856:         *-- Botoes de navegacao/acao - filhos diretos da Page1, posicoes do
857:         *-- legado (tasks/task618/layout.json). Pedras/SelEstoque/Disponivel
858:         *-- nascem ocultos (Visible=.F. no SCX original); a logica que os
859:         *-- exibe por tipo de estoque (TipoEstos) e o restante dos Click
860:         *-- (Processar/TotLinha/Alteraqtd/Pedras/Cancelar) entra na fase de
861:         *-- eventos/handlers.

*-- Linhas 868 a 1009:
868:             .Caption = "\<Requisi" + CHR(231) + CHR(245) + "es"
869:             .Visible = .F.
870:         ENDWITH
871:         BINDEVENT(loc_oPag1.cmd_4c_Pedras, "Click", THIS, "BtnPedrasClick")
872: 
873:         loc_oPag1.AddObject("cmd_4c_SelEstoque", "CommandButton")
874:         WITH loc_oPag1.cmd_4c_SelEstoque
875:             .Top     = 2
876:             .Left    = 423
877:             .Width   = 75
878:             .Height  = 75
879:             .Caption = "\<Estoques"
880:             .Visible = THIS.this_lPermiteAjustarPrioridade()
881:         ENDWITH
882:         BINDEVENT(loc_oPag1.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
883: 
884:         loc_oPag1.AddObject("cmd_4c_Disponivel", "CommandButton")
885:         WITH loc_oPag1.cmd_4c_Disponivel
886:             .Top     = 2
887:             .Left    = 498
888:             .Width   = 75
889:             .Height  = 75
890:             .Caption = "\<Disponiveis"
891:             .Visible = .F.
892:         ENDWITH
893:         BINDEVENT(loc_oPag1.cmd_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")
894: 
895:         loc_oPag1.AddObject("cmd_4c_TotLinha", "CommandButton")
896:         WITH loc_oPag1.cmd_4c_TotLinha
897:             .Top     = 2
898:             .Left    = 573
899:             .Width   = 75
900:             .Height  = 75
901:             .Caption = "\<Total/Linhas"
902:         ENDWITH
903:         BINDEVENT(loc_oPag1.cmd_4c_TotLinha, "Click", THIS, "BtnTotLinhaClick")
904: 
905:         loc_oPag1.AddObject("cmd_4c_Processar", "CommandButton")
906:         WITH loc_oPag1.cmd_4c_Processar
907:             .Top     = 2
908:             .Left    = 648
909:             .Width   = 75
910:             .Height  = 75
911:             .Caption = "\<Processar"
912:         ENDWITH
913:         BINDEVENT(loc_oPag1.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
914: 
915:         loc_oPag1.AddObject("cmd_4c_Cancelar", "CommandButton")
916:         WITH loc_oPag1.cmd_4c_Cancelar
917:             .Top     = 2
918:             .Left    = 723
919:             .Width   = 75
920:             .Height  = 75
921:             .Caption = "Encerrar"
922:         ENDWITH
923:         BINDEVENT(loc_oPag1.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
924: 
925:         loc_oPag1.AddObject("cmd_4c_Alteraqtd", "CommandButton")
926:         WITH loc_oPag1.cmd_4c_Alteraqtd
927:             .Top     = 189
928:             .Left    = 687
929:             .Width   = 40
930:             .Height  = 40
931:             .Caption = ""
932:         ENDWITH
933:         BINDEVENT(loc_oPag1.cmd_4c_Alteraqtd, "Click", THIS, "BtnAlteraqtdClick")
934:     ENDPROC
935: 
936:     *--------------------------------------------------------------------------
937:     * ConfigurarPaginaDados - completa a Page2 (SIGPRGLX.PageDados.Page2 no
938:     * legado) com a grade de selecao de linha (GradeItens -> grd_4c_Dados,
939:     * ligada ao cursor TmpFinal do legado), os totais GERAL (Label1 "Totais :"
940:     * + Tot_Qtd/Tot_Est/Tot_Prz/Tot_prc, azul) e SELECIONADO (Label2 "Qtd
941:     * Selecionada :" + Tot_sEst/Tot_sPrc, vermelho), a imagem do produto
942:     * corrente (img_4c_FigJpg), a observacao do item (obj_4c_ObsItens +
943:     * lbl_4c_Txt_ObsItens) e o botao Cancelar/Voltar - ver
944:     * tasks/task618/SigPrGlx_form_codigo_fonte.txt linhas 2386-2924.
945:     *
946:     * Page2 NAO tem nenhum campo de lookup (F4/fwBuscaExt) no legado - todas
947:     * as colunas da grade sao ReadOnly (dados ja resolvidos na Page1) ou
948:     * quantidade editavel validada por faixa (Column7/Column10.Valid, fase
949:     * de eventos). O unico lookup de todo o form (fwBuscaExt sobre SigCdPro,
950:     * por Cpros) fica em Page6.GradePedra (Requisicao Manual de Material),
951:     * montada em ConfigurarPaginaRequisicao(), com os dois lookups da
952:     * Column1/Column5 completamente implementados.
953:     *
954:     * A grade do legado foi desenhada com colunas RENOMEADAS (Column.Name)
955:     * fora da ordem fisica de criacao - o que importa para a fidelidade
956:     * visual eh a ORDEM mostrada (ColumnOrder) e nao a ordem de criacao.
957:     * Aqui os 10 Column1..Column10 ja nascem na ORDEM VISUAL final do
958:     * legado (Produto/Cor/Tam/Opera??o/N?mero/Quantidade/Estoque/Produzir/
959:     * Obs/Produ??o), evitando reproduzir o artefato de renomeacao do SCX.
960:     * Estoque (editavel, fundo amarelo) e Produ??o (editavel, fundo
961:     * amarelo) sao as 2 colunas que o usuario preenche manualmente - as
962:     * demais ficam ReadOnly, como no legado.
963:     *
964:     * TmpFinal (literal, nao cursor_4c_) eh o cursor de apoio desta grade -
965:     * a populacao real entra em fase posterior; a estrutura aqui tem de
966:     * bater exatamente com o que for populado depois (mesma regra do
967:     * cursor de apoio usada em ConfigurarPaginaLista).
968:     *--------------------------------------------------------------------------
969:     PROTECTED PROCEDURE ConfigurarPaginaDados()
970:         LOCAL loc_oPag2, loc_nCol
971: 
972:         loc_oPag2 = THIS.pgf_4c_1.Page2
973: 
974:         *-- TmpFinal (literal, nao cursor_4c_) - cursor compartilhado criado
975:         *-- por FormSigPrGl2BO.ExecutarProcessamento na MESMA DataSession
976:         *-- (THIS.DataSessionId assumida do pai em Init - ver regra na
977:         *-- cabeca de ConfigurarPaginaLista). Cursor de apoio so para modo
978:         *-- de teste de UI, com a MESMA estrutura exportada pelo pai.
979:         IF !USED("TmpFinal")
980:             CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), Qtds N(10,3), ;
981:                 Peso N(9,3), Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Obs M NULL, ;
982:                 Obsps M NULL, Datas D NULL, Entregas D NULL, CodCors C(4), CodTams C(4), ;
983:                 Linhas C(10), Citens N(10), Reffs C(40), Notas C(6), Dpros C(40), GrupoDs C(10), ;
984:                 ContaDs C(10), KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
985:             INDEX ON Cpros + CodCors + CodTams TAG Cpros
986:         ENDIF
987: 
988:         *-- Grade de selecao de linha (GradeItens / TmpFinal). ControlSource
989:         *-- remapeado conforme SIGPRGLX.Init (dump 4279-4291) - NAO pela
990:         *-- ordem fisica de Column no SCX (ver nota do cabecalho do metodo).
991:         loc_oPag2.AddObject("grd_4c_Dados", "Grid")
992: 
993:         *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
994:         *-- antes de o bloco abaixo acessar .Column1..Column10.
995:         loc_oPag2.grd_4c_Dados.RecordSource = ""
996:         loc_oPag2.grd_4c_Dados.ColumnCount  = 10
997:         loc_oPag2.grd_4c_Dados.RecordSource = "TmpFinal"
998: 
999:         WITH loc_oPag2.grd_4c_Dados
1000:             .Top          = 181
1001:             .Left         = 53
1002:             .Width        = 703
1003:             .Height       = 189
1004:             .FontName     = "Tahoma"
1005:             .FontSize     = 8
1006:             .AllowHeaderSizing = .F.
1007:             .AllowRowSizing    = .F.
1008:             .RowHeight    = 17
1009:             .GridLineColor = RGB(238, 238, 238)

*-- Linhas 1081 a 1135:
1081: 
1082:         FOR loc_nCol = 1 TO 10
1083:             IF !INLIST(loc_nCol, 7, 10)
1084:                 BINDEVENT(loc_oPag2.grd_4c_Dados.Columns(loc_nCol).Text1, "GotFocus", THIS, "GradeItensPage2GotFocus")
1085:             ENDIF
1086:         ENDFOR
1087:         *-- Captura do "ThisForm.OldValue = This.Value" do When (as duas
1088:         *-- colunas digitaveis) - sem isto o Valid nao tem com que comparar
1089:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "CapturarOldValuePage2Col7")
1090:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "GotFocus", THIS, "CapturarOldValuePage2Col10")
1091:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "Valid", THIS, "GradeItensPage2Column7Valid")
1092:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "KeyPress", THIS, "GradeItensPage2LostFocus")
1093:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "Valid", THIS, "GradeItensPage2Column10Valid")
1094:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "KeyPress", THIS, "GradeItensPage2LostFocus")
1095:         BINDEVENT(loc_oPag2.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensPage2AfterRowColChange")
1096: 
1097:         *-- Totais (parte 1 de 2 - Label1 + Tot_Qtd/Tot_Est/Tot_Prz/Tot_prc,
1098:         *-- total GERAL em azul). Parte 2 (Label2/Tot_sEst/Tot_sPrc = total
1099:         *-- SELECIONADO em vermelho, ImgFigJpg, ObsItens, Txt_ObsItens e o
1100:         *-- botao Cancelar) vem a seguir.
1101:         loc_oPag2.AddObject("lbl_4c_Label1", "Label")
1102:         WITH loc_oPag2.lbl_4c_Label1
1103:             .AutoSize  = .F.
1104:             .Top       = 372
1105:             .Left      = 403
1106:             .Width     = 42
1107:             .Height    = 17
1108:             .FontName  = "Tahoma"
1109:             .FontSize  = 8
1110:             .FontBold  = .T.
1111:             .BackStyle = 0
1112:             .ForeColor = RGB(90, 90, 90)
1113:             .Caption   = "Totais :"
1114:         ENDWITH
1115: 
1116:         loc_oPag2.AddObject("txt_4c_Tot_Qtd", "TextBox")
1117:         WITH loc_oPag2.txt_4c_Tot_Qtd
1118:             .Top       = 370
1119:             .Left      = 449
1120:             .Width     = 68
1121:             .Height    = 19
1122:             .FontBold  = .T.
1123:             .InputMask = "999,999.99"
1124:             .Margin    = 0
1125:             .ReadOnly  = .T.
1126:             .ForeColor = RGB(0, 0, 255)
1127:             .Value     = 0
1128:         ENDWITH
1129: 
1130:         loc_oPag2.AddObject("txt_4c_Tot_Est", "TextBox")
1131:         WITH loc_oPag2.txt_4c_Tot_Est
1132:             .Top       = 370
1133:             .Left      = 516
1134:             .Width     = 67
1135:             .Height    = 19

*-- Linhas 1153 a 1174:
1153:             .ReadOnly  = .T.
1154:             .ForeColor = RGB(0, 0, 255)
1155:             .Value     = 0
1156:         ENDWITH
1157: 
1158:         loc_oPag2.AddObject("txt_4c_Tot_Prz", "TextBox")
1159:         WITH loc_oPag2.txt_4c_Tot_Prz
1160:             .Top       = 370
1161:             .Left      = 648
1162:             .Width     = 67
1163:             .Height    = 19
1164:             .FontBold  = .T.
1165:             .InputMask = "999,999.99"
1166:             .Margin    = 0
1167:             .ReadOnly  = .T.
1168:             .ForeColor = RGB(0, 0, 255)
1169:             .Value     = 0
1170:         ENDWITH
1171: 
1172:         *-- Totais (parte 2 de 2) -----------------------------------------
1173:         *-- Label2/Tot_sEst/Tot_sPrc = "Qtd Selecionada" (Estoque/Producao
1174:         *-- somados pelo usuario nas sub-paginas 4/5/6), em VERMELHO para

*-- Linhas 1280 a 1343:
1280:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1281:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1282:         ENDWITH
1283:         BINDEVENT(loc_oPag2.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarPage2Click")
1284:     ENDPROC
1285: 
1286: 
1287:     *--------------------------------------------------------------------------
1288:     * ConfigurarPaginaTotaisLinha - Page3 (SIGPRGLX.PageDados.Page3): grade
1289:     * de totais consolidados por linha de produto (GradeLinhas -> TmpLinha no
1290:     * legado, alimentada pelo Click de cmd_4c_TotLinha). Toda a grade eh
1291:     * somente-leitura no legado (Grid.ReadOnly = .T.), portanto NAO tem
1292:     * lookup - nao ha onde digitar codigo para o picker resolver.
1293:     *
1294:     * Posicoes/Top/Left transcritas da secao "PROPRIEDADES DE:
1295:     * SIGPRGLX.PageDados.Page3.*" do dump legado, SEM compensacao de
1296:     * PageFrame (mesmo criterio das Fases 3-5 deste form, cujo
1297:     * pgf_4c_1.Top = -27 veio cru do SCX).
1298:     *
1299:     * cursor_4c_Linhas eh o cursor de apoio desta grade (TmpLinha no legado) -
1300:     * a estrutura aqui tem de bater EXATAMENTE com a do SELECT que a popula
1301:     * depois (regra do cursor de apoio / APPEND FROM casa por NOME).
1302:     *--------------------------------------------------------------------------
1303:     PROTECTED PROCEDURE ConfigurarPaginaTotaisLinha()
1304:         LOCAL loc_oPag3, loc_nCol
1305: 
1306:         loc_oPag3 = THIS.pgf_4c_1.Page3
1307: 
1308:         WITH loc_oPag3
1309:             .Caption   = "Totais por Linha"
1310:             .FontBold  = .T.
1311:             .ForeColor = RGB(0, 128, 192)
1312:             .Enabled   = .F.
1313:         ENDWITH
1314: 
1315:         SET NULL ON
1316:         IF !USED("cursor_4c_Linhas")
1317:             CREATE CURSOR cursor_4c_Linhas ;
1318:                 (Linhas C(10) NULL, Ordem N(1) NULL, Saldo N(12,3) NULL, ;
1319:                  Estoque N(12,3) NULL, Produzir N(12,3) NULL, Fabrs N(12,3) NULL)
1320:         ENDIF
1321:         SET NULL OFF
1322: 
1323:         *-- Titulo da sub-tela (Label2 + Shape4 no legado) ------------------
1324:         loc_oPag3.AddObject("lbl_4c_Label2", "Label")
1325:         WITH loc_oPag3.lbl_4c_Label2
1326:             .AutoSize   = .F.
1327:             .Top        = 147
1328:             .Left       = 173
1329:             .Width      = 157
1330:             .Height     = 25
1331:             .FontName   = "Tahoma"
1332:             .FontSize   = 14
1333:             .FontBold   = .T.
1334:             .FontItalic = .T.
1335:             .BackStyle  = 0
1336:             .ForeColor  = RGB(90, 90, 90)
1337:             .Caption    = "Totais por Linha"
1338:         ENDWITH
1339: 
1340:         loc_oPag3.AddObject("shp_4c_Shape4", "Shape")
1341:         WITH loc_oPag3.shp_4c_Shape4
1342:             .Top         = 169
1343:             .Left        = 168

*-- Linhas 1451 a 1515:
1451:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1452:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1453:         ENDWITH
1454:         BINDEVENT(loc_oPag3.cmd_4c_CancelaLin, "Click", THIS, "BtnCancelaLinClick")
1455:     ENDPROC
1456: 
1457:     *--------------------------------------------------------------------------
1458:     * ConfigurarPaginaEstoque - Page4 (SIGPRGLX.PageDados.Page4, "Selecionar
1459:     * Estoque"): grade de saldo disponivel POR GRUPO/CONTA (GradeDisp ->
1460:     * TmpDisp no legado, montado pelo Click de cmd_4c_SelEstoque a partir de
1461:     * TmpSaldG) mais os totalizadores Qtde Pedida / Qtde Selecionada.
1462:     *
1463:     * No legado as Pages 4 e 5 compartilham o MESMO alias TmpDisp, recriado
1464:     * com estruturas DIFERENTES a cada clique (Page4 traz Grupo/Conta/Prior,
1465:     * Page5 traz Produto/Cor/Tam). Aqui cada grade recebe o SEU cursor
1466:     * (cursor_4c_DispEstoque / cursor_4c_DispTamanho): manter o alias
1467:     * compartilhado obrigaria a derrubar o alias ligado a outra grade, o que
1468:     * zera o ColumnCount dela e a deixa morta pelo resto da vida do form.
1469:     * Divergencia de CODIGO (PILAR 3) - o que o usuario ve eh identico.
1470:     *
1471:     * Unica coluna editavel: "Utilizar" (Column5) - quantidade que o usuario
1472:     * tira daquele grupo/conta. As outras quatro sao ReadOnly no legado,
1473:     * portanto esta pagina nao tem campo de lookup.
1474:     *--------------------------------------------------------------------------
1475:     PROTECTED PROCEDURE ConfigurarPaginaEstoque()
1476:         LOCAL loc_oPag4, loc_nCol
1477: 
1478:         loc_oPag4 = THIS.pgf_4c_1.Page4
1479: 
1480:         WITH loc_oPag4
1481:             .Caption    = "Selecionar Estoque"
1482:             .FontBold   = .T.
1483:             .FontItalic = .T.
1484:             .ForeColor  = RGB(0, 128, 192)
1485:             .Enabled    = .F.
1486:         ENDWITH
1487: 
1488:         SET NULL ON
1489:         IF !USED("cursor_4c_DispEstoque")
1490:             CREATE CURSOR cursor_4c_DispEstoque ;
1491:                 (Priors N(2) NULL, Grupos C(10) NULL, Estos C(10) NULL, ;
1492:                  Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
1493:                  Disps N(12,3) NULL, Utilizar N(12,3) NULL)
1494:         ENDIF
1495:         SET NULL OFF
1496: 
1497:         *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
1498:         loc_oPag4.AddObject("lbl_4c_Label1", "Label")
1499:         WITH loc_oPag4.lbl_4c_Label1
1500:             .AutoSize   = .F.
1501:             .Top        = 138
1502:             .Left       = 197
1503:             .Width      = 184
1504:             .Height     = 25
1505:             .FontName   = "Tahoma"
1506:             .FontSize   = 14
1507:             .FontBold   = .T.
1508:             .FontItalic = .T.
1509:             .BackStyle  = 0
1510:             .ForeColor  = RGB(90, 90, 90)
1511:             .Caption    = "Selecionar Estoque"
1512:         ENDWITH
1513: 
1514:         loc_oPag4.AddObject("shp_4c_Shape4", "Shape")
1515:         WITH loc_oPag4.shp_4c_Shape4

*-- Linhas 1599 a 1670:
1599:             .Column5.ReadOnly  = .F.
1600:             .Column5.Text1.FontBold = .T.
1601:         ENDWITH
1602:         BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "Valid", THIS, "GradeDispEstoqueColumn5Valid")
1603:         BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")
1604: 
1605:         FOR loc_nCol = 1 TO 5
1606:             WITH EVALUATE("loc_oPag4.grd_4c_DispEstoque.Column" + TRANSFORM(loc_nCol) + ".Header1")
1607:                 .FontName  = "Verdana"
1608:                 .FontSize  = 8
1609:                 .Alignment = 2
1610:                 .ForeColor = RGB(36, 84, 155)
1611:             ENDWITH
1612:         ENDFOR
1613: 
1614:         *-- Totalizadores da selecao ----------------------------------------
1615:         loc_oPag4.AddObject("lbl_4c_Label2", "Label")
1616:         WITH loc_oPag4.lbl_4c_Label2
1617:             .AutoSize  = .F.
1618:             .Top       = 418
1619:             .Left      = 220
1620:             .Width     = 82
1621:             .Height    = 16
1622:             .FontName  = "Tahoma"
1623:             .FontSize  = 8
1624:             .BackStyle = 0
1625:             .ForeColor = RGB(90, 90, 90)
1626:             .Caption   = "Qtde Pedida : "
1627:         ENDWITH
1628: 
1629:         loc_oPag4.AddObject("lbl_4c_Label3", "Label")
1630:         WITH loc_oPag4.lbl_4c_Label3
1631:             .AutoSize  = .F.
1632:             .Top       = 437
1633:             .Left      = 192
1634:             .Width     = 110
1635:             .Height    = 16
1636:             .FontName  = "Tahoma"
1637:             .FontSize  = 8
1638:             .BackStyle = 0
1639:             .ForeColor = RGB(90, 90, 90)
1640:             .Caption   = "Qtde Selecionada : "
1641:         ENDWITH
1642: 
1643:         loc_oPag4.AddObject("txt_4c_Qt_pedida", "TextBox")
1644:         WITH loc_oPag4.txt_4c_Qt_pedida
1645:             .Top       = 413
1646:             .Left      = 312
1647:             .Width     = 67
1648:             .Height    = 23
1649:             .InputMask = "9,999.99"
1650:             .ReadOnly  = .T.
1651:             .Value     = 0
1652:         ENDWITH
1653: 
1654:         loc_oPag4.AddObject("txt_4c_Qt_Selec", "TextBox")
1655:         WITH loc_oPag4.txt_4c_Qt_Selec
1656:             .Top       = 436
1657:             .Left      = 312
1658:             .Width     = 67
1659:             .Height    = 23
1660:             .Alignment = 3
1661:             .InputMask = "9,999.99"
1662:             .ReadOnly  = .T.
1663:             .Value     = 0
1664:         ENDWITH
1665: 
1666:         *-- Voltar (CancelaDisp) --------------------------------------------
1667:         loc_oPag4.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1668:         WITH loc_oPag4.cmd_4c_CancelaDisp
1669:             .Top         = 12
1670:             .Left        = 704

*-- Linhas 1683 a 1740:
1683:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1684:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1685:         ENDWITH
1686:         BINDEVENT(loc_oPag4.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage4Click")
1687:     ENDPROC
1688: 
1689:     *--------------------------------------------------------------------------
1690:     * ConfigurarPaginaTamanhos - Page5 (SIGPRGLX.PageDados.Page5,
1691:     * "Disponivel/Tamanho"): grade do saldo disponivel QUEBRADO POR TAMANHO
1692:     * (GradeDisp -> TmpDisp no legado, montado pelo Click de
1693:     * cmd_4c_Disponivel a partir de TmpSaldo) mais os mesmos totalizadores
1694:     * Qtde Pedida / Qtde Selecionada da Page4.
1695:     *
1696:     * Cursor proprio (cursor_4c_DispTamanho) pelo motivo explicado em
1697:     * ConfigurarPaginaEstoque. Unica coluna editavel: "Utilizar" (Column5) -
1698:     * as demais sao ReadOnly, portanto esta pagina nao tem lookup.
1699:     *--------------------------------------------------------------------------
1700:     PROTECTED PROCEDURE ConfigurarPaginaTamanhos()
1701:         LOCAL loc_oPag5, loc_nCol
1702: 
1703:         loc_oPag5 = THIS.pgf_4c_1.Page5
1704: 
1705:         WITH loc_oPag5
1706:             .Caption   = "Disponivel/Tamanho"
1707:             .FontBold  = .T.
1708:             .ForeColor = RGB(0, 128, 192)
1709:             .Enabled   = .F.
1710:         ENDWITH
1711: 
1712:         SET NULL ON
1713:         IF !USED("cursor_4c_DispTamanho")
1714:             CREATE CURSOR cursor_4c_DispTamanho ;
1715:                 (Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
1716:                  Disps N(12,3) NULL, Utilizar N(12,3) NULL)
1717:         ENDIF
1718:         SET NULL OFF
1719: 
1720:         loc_oPag5.AddObject("lbl_4c_Label1", "Label")
1721:         WITH loc_oPag5.lbl_4c_Label1
1722:             .AutoSize   = .F.
1723:             .Top        = 150
1724:             .Left       = 246
1725:             .Width      = 205
1726:             .Height     = 25
1727:             .FontName   = "Tahoma"
1728:             .FontSize   = 14
1729:             .FontBold   = .T.
1730:             .FontItalic = .T.
1731:             .BackStyle  = 0
1732:             .ForeColor  = RGB(90, 90, 90)
1733:             .Caption    = "Selecionar Tamanhos"
1734:         ENDWITH
1735: 
1736:         loc_oPag5.AddObject("shp_4c_Shape4", "Shape")
1737:         WITH loc_oPag5.shp_4c_Shape4
1738:             .Top         = 171
1739:             .Left        = 240
1740:             .Width       = 328

*-- Linhas 1818 a 1888:
1818:             .Column5.ReadOnly  = .F.
1819:             .Column5.Text1.FontBold = .T.
1820:         ENDWITH
1821:         BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "Valid", THIS, "GradeDispTamanhoColumn5Valid")
1822:         BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")
1823: 
1824:         FOR loc_nCol = 1 TO 5
1825:             WITH EVALUATE("loc_oPag5.grd_4c_DispTamanho.Column" + TRANSFORM(loc_nCol) + ".Header1")
1826:                 .FontName  = "Verdana"
1827:                 .FontSize  = 8
1828:                 .Alignment = 2
1829:                 .ForeColor = RGB(36, 84, 155)
1830:             ENDWITH
1831:         ENDFOR
1832: 
1833:         loc_oPag5.AddObject("lbl_4c_Label2", "Label")
1834:         WITH loc_oPag5.lbl_4c_Label2
1835:             .AutoSize  = .F.
1836:             .Top       = 415
1837:             .Left      = 289
1838:             .Width     = 82
1839:             .Height    = 16
1840:             .FontName  = "Tahoma"
1841:             .FontSize  = 8
1842:             .BackStyle = 0
1843:             .ForeColor = RGB(90, 90, 90)
1844:             .Caption   = "Qtde Pedida : "
1845:         ENDWITH
1846: 
1847:         loc_oPag5.AddObject("lbl_4c_Label3", "Label")
1848:         WITH loc_oPag5.lbl_4c_Label3
1849:             .AutoSize  = .F.
1850:             .Top       = 434
1851:             .Left      = 261
1852:             .Width     = 110
1853:             .Height    = 16
1854:             .FontName  = "Tahoma"
1855:             .FontSize  = 8
1856:             .BackStyle = 0
1857:             .ForeColor = RGB(90, 90, 90)
1858:             .Caption   = "Qtde Selecionada : "
1859:         ENDWITH
1860: 
1861:         loc_oPag5.AddObject("txt_4c_Qt_pedida", "TextBox")
1862:         WITH loc_oPag5.txt_4c_Qt_pedida
1863:             .Top       = 410
1864:             .Left      = 379
1865:             .Width     = 67
1866:             .Height    = 23
1867:             .InputMask = "9,999.99"
1868:             .ReadOnly  = .T.
1869:             .Value     = 0
1870:         ENDWITH
1871: 
1872:         loc_oPag5.AddObject("txt_4c_Qt_Selec", "TextBox")
1873:         WITH loc_oPag5.txt_4c_Qt_Selec
1874:             .Top       = 433
1875:             .Left      = 379
1876:             .Width     = 67
1877:             .Height    = 23
1878:             .Alignment = 3
1879:             .InputMask = "9,999.99"
1880:             .ReadOnly  = .T.
1881:             .Value     = 0
1882:         ENDWITH
1883: 
1884:         loc_oPag5.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1885:         WITH loc_oPag5.cmd_4c_CancelaDisp
1886:             .Top         = 12
1887:             .Left        = 704
1888:             .Width       = 75

*-- Linhas 1900 a 1971:
1900:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1901:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1902:         ENDWITH
1903:         BINDEVENT(loc_oPag5.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage5Click")
1904:     ENDPROC
1905: 
1906:     *--------------------------------------------------------------------------
1907:     * ConfigurarPaginaRequisicao - Page6 (SIGPRGLX.PageDados.Page6,
1908:     * "Requisicao"): "Requisicao Manual de Material" (GradePedra -> SelPedra
1909:     * no legado, aberta pelo Click de cmd_4c_Pedras). Esta eh a UNICA pagina
1910:     * do form que tem campo de lookup - as duas colunas de produto
1911:     * (Column1 "Produto" = material requisitado e Column5 "Produto" =
1912:     * material substituto) tem Valid que abre o picker de SigCdPro:
1913:     *
1914:     *   SIGPRGLX.PageDados.Page6.GradePedra.Column1.Text1.Valid (linha 8093)
1915:     *   SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1.Valid (linha 8176)
1916:     *   CreateObject('fwBuscaExt', ..., 'SigCdPro', 'crListaRemota',
1917:     *                'CPros', This.Value, 'Selecao', 1000)
1918:     *     -> mAddColuna('CPros','','Codigo') / mAddColuna('DPros','','Descricao')
1919:     *
1920:     * Column2 (Descricao) e Column3 (Uni) sao preenchidas pelo proprio
1921:     * lookup da Column1 (o Replace SelPedra.Dpros/Cunis do legado) e tem
1922:     * When -> Return .f. (nao digitaveis). Column4 (Qtde) e Column5 so
1923:     * aceitam digitacao com a Column1 preenchida - o When do legado eh
1924:     * Return (Not EMPTY(Column1.Text1.Value)), reproduzido como guarda no
1925:     * inicio dos handlers.
1926:     *
1927:     * cursor_4c_Requisicao eh o cursor de apoio de SelPedra; o legado garante
1928:     * ao menos UMA linha em branco (Init: "If Reccount('SelPedra') = 0 /
1929:     * Append Blank"), que eh onde o usuario digita o primeiro material.
1930:     *--------------------------------------------------------------------------
1931:     PROTECTED PROCEDURE ConfigurarPaginaRequisicao()
1932:         LOCAL loc_oPag6, loc_nCol
1933: 
1934:         loc_oPag6 = THIS.pgf_4c_1.Page6
1935: 
1936:         WITH loc_oPag6
1937:             .Caption   = "Requisi" + CHR(231) + CHR(227) + "o"
1938:             .FontBold  = .T.
1939:             .ForeColor = RGB(0, 128, 192)
1940:             .Enabled   = .F.
1941:         ENDWITH
1942: 
1943:         SET NULL ON
1944:         IF !USED("cursor_4c_Requisicao")
1945:             CREATE CURSOR cursor_4c_Requisicao ;
1946:                 (Cpros C(14) NULL, Dpros C(65) NULL, Cunis C(3) NULL, ;
1947:                  Qtds N(12,3) NULL, Cpro2s C(14) NULL)
1948:         ENDIF
1949:         SET NULL OFF
1950: 
1951:         *-- Linha em branco inicial (Init legado: If Reccount('SelPedra') = 0
1952:         *-- / Append Blank) - sem ela a grade abre sem nenhuma celula onde
1953:         *-- digitar o primeiro material.
1954:         IF USED("cursor_4c_Requisicao")
1955:             IF RECCOUNT("cursor_4c_Requisicao") = 0
1956:                 SELECT cursor_4c_Requisicao
1957:                 APPEND BLANK
1958:                 REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
1959:                         Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
1960:                 GO TOP IN cursor_4c_Requisicao
1961:             ENDIF
1962:         ENDIF
1963: 
1964:         *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
1965:         loc_oPag6.AddObject("lbl_4c_Label1", "Label")
1966:         WITH loc_oPag6.lbl_4c_Label1
1967:             .AutoSize   = .F.
1968:             .Top        = 168
1969:             .Left       = 132
1970:             .Width      = 294
1971:             .Height     = 25

*-- Linhas 2100 a 2544:
2100: 
2101:         *-- LOOKUPS -------------------------------------------------------
2102:         *-- Column1.Text1 e Column5.Text1 do legado tem Valid com
2103:         *-- fwBuscaExt sobre SigCdPro. BINDEVENT "Valid" NAO dispara de
2104:         *-- forma confiavel em TextBox (regra #3), entao o gatilho vai no
2105:         *-- KeyPress (ENTER/TAB/F4 - o equivalente a "sair do campo") e no
2106:         *-- DblClick, que eh o atalho canonico de lookup do sistema novo.
2107:         BINDEVENT(loc_oPag6.grd_4c_Pedra.Column1.Text1, "KeyPress", THIS, "GrdPedraProdutoKeyPress")
2108:         BINDEVENT(loc_oPag6.grd_4c_Pedra.Column1.Text1, "DblClick", THIS, "GrdPedraProdutoDblClick")
2109: 
2110:         BINDEVENT(loc_oPag6.grd_4c_Pedra.Column5.Text1, "KeyPress", THIS, "GrdPedraSubstitutoKeyPress")
2111:         BINDEVENT(loc_oPag6.grd_4c_Pedra.Column5.Text1, "DblClick", THIS, "GrdPedraSubstitutoDblClick")
2112: 
2113:         *-- Voltar (CancelaDisp) --------------------------------------------
2114:         loc_oPag6.AddObject("cmd_4c_CancelaDisp", "CommandButton")
2115:         WITH loc_oPag6.cmd_4c_CancelaDisp
2116:             .Top         = 12
2117:             .Left        = 704
2118:             .Width       = 75
2119:             .Height      = 75
2120:             .FontName    = "Comic Sans MS"
2121:             .FontSize    = 8
2122:             .FontBold    = .T.
2123:             .FontItalic  = .T.
2124:             .WordWrap    = .T.
2125:             .Cancel      = .T.
2126:             .Caption     = "Voltar"
2127:             .ForeColor   = RGB(90, 90, 90)
2128:             .BackColor   = RGB(255, 255, 255)
2129:             .Themes      = .T.
2130:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2131:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2132:         ENDWITH
2133:         BINDEVENT(loc_oPag6.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage6Click")
2134:     ENDPROC
2135: 
2136:     *--------------------------------------------------------------------------
2137:     * GrdPedraProdutoKeyPress / GrdPedraProdutoDblClick - gatilhos do lookup
2138:     * do MATERIAL REQUISITADO (GradePedra.Column1.Text1.Valid no legado).
2139:     * PUBLIC (sem PROTECTED): BINDEVENT so enxerga metodo publico.
2140:     * LPARAMETERS obrigatorio - sem ele o primeiro keystroke estoura
2141:     * "No PARAMETER statement is found".
2142:     *--------------------------------------------------------------------------
2143:     PROCEDURE GrdPedraProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2144: 
2145:         *-- Guarda obrigatoria: sem ela o picker abriria a CADA tecla
2146:         *-- digitada e o usuario nao conseguiria terminar o codigo.
2147:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2148:             RETURN
2149:         ENDIF
2150: 
2151:         THIS.AbrirLookupProdutoRequisicao()
2152:     ENDPROC
2153: 
2154:     PROCEDURE GrdPedraProdutoDblClick()
2155:         THIS.AbrirLookupProdutoRequisicao()
2156:     ENDPROC
2157: 
2158:     *--------------------------------------------------------------------------
2159:     * AbrirLookupProdutoRequisicao - lookup do material requisitado
2160:     * (Column1 "Produto"), transcrito de
2161:     * SIGPRGLX.PageDados.Page6.GradePedra.Column1.Text1.Valid:
2162:     *
2163:     *   If Not Empty(This.Value)
2164:     *       loLista = CreateObject('fwBuscaExt', ..., 'SigCdPro',
2165:     *                              'crListaRemota', 'CPros', This.Value, 'Selecao', 1000)
2166:     *       If Not loLista.plAchouRegistro
2167:     *           loLista.mAddColuna('CPros','','Codigo')
2168:     *           loLista.mAddColuna('DPros','','Descricao')
2169:     *           loLista.Show()
2170:     *       EndIf
2171:     *       This.Value = CrListaRemota.Cpros
2172:     *       Replace SelPedra.Dpros WITH CrListaRemota.Dpros,
2173:     *               SelPedra.Cunis WITH CrListaRemota.Cunis IN SelPedra
2174:     *       Use In crListaRemota
2175:     *       ThisForm.PageDados.Page6.GradePedra.Refresh
2176:     *   EndIf
2177:     *
2178:     * O Replace de Dpros/Cunis eh o que preenche as colunas Descricao e Uni,
2179:     * que sao ReadOnly e nao tem outra origem - sem ele a linha fica so com
2180:     * o codigo. Cunis vem junto do mesmo SELECT (por isso o lookup consulta
2181:     * CPros/DPros/Cunis, mesmo exibindo so as duas primeiras no picker,
2182:     * exatamente como o legado, cujo fwBuscaExt traz a linha inteira).
2183:     *--------------------------------------------------------------------------
2184:     PROCEDURE AbrirLookupProdutoRequisicao()
2185:         LOCAL loc_oBusca, loc_cValor, loc_oErro
2186:         LOCAL loc_oGrade, loc_oCampo
2187: 
2188:         IF THIS.this_lLookupEmCurso
2189:             RETURN
2190:         ENDIF
2191:         THIS.this_lLookupEmCurso = .T.
2192: 
2193:         TRY
2194:             loc_oGrade = THIS.pgf_4c_1.Page6.grd_4c_Pedra
2195:             loc_oCampo = loc_oGrade.Column1.Text1
2196: 
2197:             *-- Legado: "If Not Empty(This.Value)" - campo vazio nao consulta.
2198:             IF !EMPTY(loc_oCampo.Value) AND !loc_oCampo.ReadOnly
2199:                 loc_cValor = ALLTRIM(loc_oCampo.Value)
2200: 
2201:                 IF USED("cursor_4c_BuscaProduto")
2202:                     USE IN cursor_4c_BuscaProduto
2203:                 ENDIF
2204: 
2205:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2206:                     "SigCdPro", ;
2207:                     "cursor_4c_BuscaProduto", ;
2208:                     "CPros", ;
2209:                     loc_cValor, ;
2210:                     "Sele" + CHR(231) + CHR(227) + "o")
2211: 
2212:                 IF VARTYPE(loc_oBusca) = "O"
2213:                     *-- this_lAchouRegistro: o Init ja resolveu o match exato
2214:                     *-- (1 registro) - nesse caso o picker NAO deve aparecer.
2215:                     IF !loc_oBusca.this_lAchouRegistro
2216:                         loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2217:                         loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2218:                         loc_oBusca.Show()
2219:                     ENDIF
2220: 
2221:                     *-- Atribuicao SO sob a guarda de selecao: fora dela, o
2222:                     *-- usuario que desiste do picker teria o campo ZERADO.
2223:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
2224:                         IF !EOF("cursor_4c_BuscaProduto")
2225:                             loc_oCampo.Value = ALLTRIM(cursor_4c_BuscaProduto.CPros)
2226: 
2227:                             IF USED("cursor_4c_Requisicao") AND !EOF("cursor_4c_Requisicao")
2228:                                 REPLACE Cpros WITH ALLTRIM(cursor_4c_BuscaProduto.CPros), ;
2229:                                         Dpros WITH TratarNulo(cursor_4c_BuscaProduto.DPros, ""), ;
2230:                                         Cunis WITH TratarNulo(cursor_4c_BuscaProduto.Cunis, "") ;
2231:                                    IN cursor_4c_Requisicao
2232:                             ENDIF
2233:                         ENDIF
2234:                     ENDIF
2235: 
2236:                     IF USED("cursor_4c_BuscaProduto")
2237:                         USE IN cursor_4c_BuscaProduto
2238:                     ENDIF
2239: 
2240:                     loc_oBusca.Release()
2241:                     loc_oBusca = .NULL.
2242:                 ENDIF
2243: 
2244:                 loc_oGrade.Refresh()
2245:             ENDIF
2246:         CATCH TO loc_oErro
2247:             MsgErro(loc_oErro.Message + CHR(13) + ;
2248:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2249:                     "Procedure: " + loc_oErro.Procedure, ;
2250:                     "Erro ao buscar Produto")
2251:         ENDTRY
2252: 
2253:         *-- Liberado DEPOIS do ENDTRY para valer tambem quando o CATCH dispara.
2254:         THIS.this_lLookupEmCurso = .F.
2255:     ENDPROC
2256: 
2257:     *--------------------------------------------------------------------------
2258:     * GrdPedraSubstitutoKeyPress / GrdPedraSubstitutoDblClick - gatilhos do
2259:     * lookup do MATERIAL SUBSTITUTO (GradePedra.Column5.Text1.Valid).
2260:     *--------------------------------------------------------------------------
2261:     PROCEDURE GrdPedraSubstitutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2262: 
2263:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2264:             RETURN
2265:         ENDIF
2266: 
2267:         THIS.AbrirLookupProdutoSubstituto()
2268:     ENDPROC
2269: 
2270:     PROCEDURE GrdPedraSubstitutoDblClick()
2271:         THIS.AbrirLookupProdutoSubstituto()
2272:     ENDPROC
2273: 
2274:     *--------------------------------------------------------------------------
2275:     * AbrirLookupProdutoSubstituto - lookup do material substituto
2276:     * (Column5 "Produto"), transcrito de
2277:     * SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1.Valid. Igual ao da
2278:     * Column1, SEM o Replace de Dpros/Cunis - o legado so devolve o codigo
2279:     * aqui, porque Descricao/Uni da linha pertencem ao material PRINCIPAL.
2280:     *
2281:     * A guarda inicial reproduz o When do legado
2282:     * (Return (Not EMPTY(...Column1.Text1.Value))): sem material principal
2283:     * digitado, a coluna do substituto nao aceita entrada e, portanto, nao
2284:     * abre o picker.
2285:     *--------------------------------------------------------------------------
2286:     PROCEDURE AbrirLookupProdutoSubstituto()
2287:         LOCAL loc_oBusca, loc_cValor, loc_oErro
2288:         LOCAL loc_oGrade, loc_oCampo
2289: 
2290:         IF THIS.this_lLookupEmCurso
2291:             RETURN
2292:         ENDIF
2293:         THIS.this_lLookupEmCurso = .T.
2294: 
2295:         TRY
2296:             loc_oGrade = THIS.pgf_4c_1.Page6.grd_4c_Pedra
2297:             loc_oCampo = loc_oGrade.Column5.Text1
2298: 
2299:             *-- When do legado: so ha substituto se ha material principal.
2300:             IF EMPTY(loc_oGrade.Column1.Text1.Value)
2301:                 MsgAviso("Informe primeiro o Produto da requisi" + CHR(231) + ;
2302:                          CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
2303:             ELSE
2304:                 IF !EMPTY(loc_oCampo.Value) AND !loc_oCampo.ReadOnly
2305:                     loc_cValor = ALLTRIM(loc_oCampo.Value)
2306: 
2307:                     IF USED("cursor_4c_BuscaProduto")
2308:                         USE IN cursor_4c_BuscaProduto
2309:                     ENDIF
2310: 
2311:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2312:                         "SigCdPro", ;
2313:                         "cursor_4c_BuscaProduto", ;
2314:                         "CPros", ;
2315:                         loc_cValor, ;
2316:                         "Sele" + CHR(231) + CHR(227) + "o")
2317: 
2318:                     IF VARTYPE(loc_oBusca) = "O"
2319:                         IF !loc_oBusca.this_lAchouRegistro
2320:                             loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2321:                             loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2322:                             loc_oBusca.Show()
2323:                         ENDIF
2324: 
2325:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
2326:                             IF !EOF("cursor_4c_BuscaProduto")
2327:                                 loc_oCampo.Value = ALLTRIM(cursor_4c_BuscaProduto.CPros)
2328: 
2329:                                 IF USED("cursor_4c_Requisicao") AND !EOF("cursor_4c_Requisicao")
2330:                                     REPLACE Cpro2s WITH ALLTRIM(cursor_4c_BuscaProduto.CPros) ;
2331:                                        IN cursor_4c_Requisicao
2332:                                 ENDIF
2333:                             ENDIF
2334:                         ENDIF
2335: 
2336:                         IF USED("cursor_4c_BuscaProduto")
2337:                             USE IN cursor_4c_BuscaProduto
2338:                         ENDIF
2339: 
2340:                         loc_oBusca.Release()
2341:                         loc_oBusca = .NULL.
2342:                     ENDIF
2343: 
2344:                     *-- LostFocus do legado: garante sempre UMA linha em branco
2345:                     *-- no fim, para o usuario digitar o proximo material.
2346:                     THIS.GarantirLinhaLivreRequisicao()
2347: 
2348:                     loc_oGrade.Refresh()
2349:                 ENDIF
2350:             ENDIF
2351:         CATCH TO loc_oErro
2352:             MsgErro(loc_oErro.Message + CHR(13) + ;
2353:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2354:                     "Procedure: " + loc_oErro.Procedure, ;
2355:                     "Erro ao buscar Produto")
2356:         ENDTRY
2357: 
2358:         THIS.this_lLookupEmCurso = .F.
2359:     ENDPROC
2360: 
2361:     *--------------------------------------------------------------------------
2362:     * GarantirLinhaLivreRequisicao - transcricao do LostFocus de
2363:     * SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1:
2364:     *
2365:     *   SELECT SelPedra
2366:     *   xPosicao = RECNO()
2367:     *   Locate For Empty(Cpros)
2368:     *   If Eof()
2369:     *       Append Blank
2370:     *   EndIf
2371:     *   Locate for Recno() = xPosicao
2372:     *
2373:     * Mantem sempre ao menos uma linha em branco disponivel na grade e
2374:     * devolve o ponteiro para onde o usuario estava. O KEYBOARD '{DNARROW}'
2375:     * do legado (que empurra o cursor para a linha de baixo) nao eh
2376:     * reproduzido aqui: la ele vinha do LostFocus real da celula; neste
2377:     * ponto o foco ja voltou do picker e o salto adicional tiraria o
2378:     * usuario da linha que ele acabou de preencher.
2379:     *--------------------------------------------------------------------------
2380:     PROTECTED PROCEDURE GarantirLinhaLivreRequisicao()
2381:         LOCAL loc_nPosicao
2382: 
2383:         IF !USED("cursor_4c_Requisicao")
2384:             RETURN
2385:         ENDIF
2386: 
2387:         SELECT cursor_4c_Requisicao
2388:         loc_nPosicao = RECNO()
2389: 
2390:         LOCATE FOR EMPTY(cursor_4c_Requisicao.Cpros)
2391:         IF EOF("cursor_4c_Requisicao")
2392:             APPEND BLANK
2393:             REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
2394:                     Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
2395:         ENDIF
2396: 
2397:         IF loc_nPosicao > 0 AND loc_nPosicao <= RECCOUNT("cursor_4c_Requisicao")
2398:             GOTO loc_nPosicao IN cursor_4c_Requisicao
2399:         ENDIF
2400:     ENDPROC
2401: 
2402:     *--------------------------------------------------------------------------
2403:     * GradeItensPage1GotFocus - "GotFocus -> Column7.Text1.SetFocus" das
2404:     * colunas 1/2/4/5/6/9/10 do legado (dump 6730-6793): a grade so tem UMA
2405:     * coluna de entrada de verdade (Fabrs); clicar em qualquer outra
2406:     * redireciona o foco para ela.
2407:     *--------------------------------------------------------------------------
2408:     PROCEDURE GradeItensPage1GotFocus()
2409:         THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1.SetFocus()
2410:     ENDPROC
2411: 
2412:     *--------------------------------------------------------------------------
2413:     * CapturarOldValuePage1 / CapturarOldValuePage2 - "ThisForm.OldValue =
2414:     * This.Value" do When das colunas digitaveis (Page1 e Page2,
2415:     * Column7/Column10). Guardam o valor ANTES da edicao para que o Valid
2416:     * possa restaura-lo quando recusar a entrada.
2417:     *
2418:     * Ligados ao GotFocus (nao ao When): BINDEVENT em "When" de TextBox de
2419:     * Grid nao dispara de forma confiavel (regra #3 do CLAUDE.md), e
2420:     * GotFocus cobre o mesmo instante - a celula acabou de receber o foco e
2421:     * o usuario ainda nao digitou.
2422:     *
2423:     * par_nColuna: 7 ou 10 (a coluna que ganhou o foco).
2424:     *--------------------------------------------------------------------------
2425:     PROCEDURE CapturarOldValuePage1()
2426:         LPARAMETERS par_nColuna
2427: 
2428:         DO CASE
2429:             CASE par_nColuna = 10
2430:                 THIS.this_nOldValue = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1.Value
2431:             OTHERWISE
2432:                 THIS.this_nOldValue = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1.Value
2433:         ENDCASE
2434:     ENDPROC
2435: 
2436:     PROCEDURE CapturarOldValuePage1Col7()
2437:         THIS.CapturarOldValuePage1(7)
2438:     ENDPROC
2439: 
2440:     PROCEDURE CapturarOldValuePage1Col10()
2441:         THIS.CapturarOldValuePage1(10)
2442:     ENDPROC
2443: 
2444:     PROCEDURE CapturarOldValuePage2Col7()
2445:         THIS.this_nOldValue = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1.Value
2446:     ENDPROC
2447: 
2448:     PROCEDURE CapturarOldValuePage2Col10()
2449:         THIS.this_nOldValue = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column10.Text1.Value
2450:     ENDPROC
2451: 
2452:     *--------------------------------------------------------------------------
2453:     * GradeItensPage1Column3DblClick - Column3 (Flag) DblClick/Click do
2454:     * legado (dump 6946-6961): atalho para a pagina de selecao de linha.
2455:     *--------------------------------------------------------------------------
2456:     PROCEDURE GradeItensPage1Column3DblClick()
2457:         THIS.AlternarPagina(2)
2458:         THIS.pgf_4c_1.Page2.grd_4c_Dados.SetFocus()
2459:     ENDPROC
2460: 
2461:     *--------------------------------------------------------------------------
2462:     * GradeItensPage1Column7Valid - transcricao de GradeItens.Column7.Text1.
2463:     * Valid (dump 6833-6913): valida a quantidade de Fabrs (producao em
2464:     * fase) reservada manualmente para o item corrente e redistribui o
2465:     * saldo em cursor_4c_TmpSaldo/cursor_4c_TmpFabr/TmpFinal.
2466:     *--------------------------------------------------------------------------
2467:     PROCEDURE GradeItensPage1Column7Valid()
2468:         LOCAL loc_oCampo, loc_nValorNovo, loc_nXBaixa, loc_lOk
2469: 
2470:         loc_oCampo    = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1
2471:         loc_nValorNovo = loc_oCampo.Value
2472: 
2473:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2474:             RETURN
2475:         ENDIF
2476: 
2477:         IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2478:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2479:         ENDIF
2480:         IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelmp
2481:             IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de OP." + CHR(13) + ;
2482:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
2483:                     "Confirmar")
2484:                 loc_oCampo.Value = THIS.this_nOldValue
2485:                 RETURN
2486:             ENDIF
2487:         ENDIF
2488: 
2489:         loc_lOk = .T.
2490:         DO CASE
2491:             CASE loc_nValorNovo = THIS.this_nOldValue
2492:                 * nada a fazer
2493:             CASE loc_nValorNovo < 0
2494:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
2495:                 loc_lOk = .F.
2496:             CASE loc_nValorNovo > TmpFinalg.Saldo
2497:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2498:                 loc_lOk = .F.
2499:             CASE loc_nValorNovo > (TmpFinalg.Saldo - TmpFinalg.Estoque)
2500:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2501:                 loc_lOk = .F.
2502:             CASE !SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, ;
2503:                     "cursor_4c_TmpSaldo", "CPros") AND TmpFinalg.Produzir != TmpFinalg.Saldo
2504:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto Em " + ;
2505:                     "Produ" + CHR(231) + CHR(227) + "o para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2506:                 loc_lOk = .F.
2507:             OTHERWISE
2508:                 IF cursor_4c_TmpSaldo.Fabrs >= loc_nValorNovo
2509:                     REPLACE DispFs WITH Fabrs - loc_nValorNovo IN cursor_4c_TmpSaldo
2510:                     REPLACE Produzir WITH Saldo - Estoque - loc_nValorNovo IN TmpFinalg
2511: 
2512:                     SELECT TmpFinalg
2513:                     REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
2514:                             QtdMins - Produzir, 0), ;
2515:                             UsuLibs WITH " " IN TmpFinalg
2516: 
2517:                     REPLACE KeySelmp WITH .F. IN TmpSaldU
2518: 
2519:                     SELECT cursor_4c_TmpSaldo
2520:                     loc_nXBaixa = Fabrs - DispFs
2521:                     SELECT cursor_4c_TmpFabr
2522:                     SET ORDER TO Cpros
2523:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2524:                     REPLACE Disps WITH 0 WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2525:                             cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2526:                             cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams
2527:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2528:                     SCAN WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2529:                             cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2530:                             cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
2531:                         IF (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps) >= loc_nXBaixa
2532:                             REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Disps + loc_nXBaixa
2533:                             loc_nXBaixa = 0
2534:                         ELSE
2535:                             loc_nXBaixa = loc_nXBaixa - (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps)
2536:                             REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Qtds
2537:                         ENDIF
2538:                         SELECT cursor_4c_TmpFabr
2539:                     ENDSCAN
2540: 
2541:                     loc_nXBaixa = loc_nValorNovo
2542:                     SELECT TmpFinal
2543:                     SET ORDER TO
2544:                     SET ORDER TO Cpros

*-- Linhas 2559 a 2672:
2559:                         SELECT TmpFinal
2560:                     ENDSCAN
2561:                 ELSE
2562:                     MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto Em " + ;
2563:                         "Produ" + CHR(231) + CHR(227) + "o para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2564:                     loc_lOk = .F.
2565:                 ENDIF
2566:         ENDCASE
2567: 
2568:         IF !loc_lOk
2569:             loc_oCampo.Value = THIS.this_nOldValue
2570:         ENDIF
2571:     ENDPROC
2572: 
2573:     *--------------------------------------------------------------------------
2574:     * GradeItensPage1Column10Valid - transcricao de GradeItens.Column10.Text1.
2575:     * Valid (dump 7046-7128): irma exata da Column7 acima, mas para a
2576:     * quantidade de ESTOQUE (TmpFinalg.Estoque). Redistribui o saldo em
2577:     * cursor_4c_TmpSaldo (Disps) -> cursor_4c_TmpSaldg (Disps por
2578:     * grupo/conta) -> TmpFinal (Estoque linha a linha).
2579:     *
2580:     * Duas diferencas de verbo em relacao a Column7, que vem do legado e NAO
2581:     * sao simetria quebrada por descuido:
2582:     *   - o teto eh (Saldo - Fabrs), nao (Saldo - Estoque);
2583:     *   - no cursor_4c_TmpSaldg o legado SATURA primeiro (Replace Disps With
2584:     *     Saldo While ...) e so depois DESCONTA xBaixa no Scan, enquanto na
2585:     *     Column7 ele ZERA (Replace Disps With 0) e depois SOMA. Transcrito
2586:     *     literalmente (regra #17 do CLAUDE.md).
2587:     *
2588:     * UNICA divergencia consciente: no 5o Case o legado escreve
2589:     * "This.Value = This.Value = Thisform.OldValue" - um typo que avalia a
2590:     * comparacao e grava um LOGICO num campo numerico. Aqui restaura o valor
2591:     * anterior (que eh o que os outros quatro Case fazem e o que o typo
2592:     * claramente pretendia); transcrever o typo gravaria .T./.F. em
2593:     * TmpFinalg.Estoque e estouraria "Data type mismatch".
2594:     *--------------------------------------------------------------------------
2595:     PROCEDURE GradeItensPage1Column10Valid()
2596:         LOCAL loc_oCampo, loc_nValorNovo, loc_nXBaixa, loc_lOk
2597: 
2598:         loc_oCampo     = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1
2599:         loc_nValorNovo = loc_oCampo.Value
2600: 
2601:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2602:             RETURN
2603:         ENDIF
2604: 
2605:         IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2606:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2607:         ENDIF
2608:         IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelm
2609:             IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque." + CHR(13) + ;
2610:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
2611:                     "Confirmar")
2612:                 loc_oCampo.Value = THIS.this_nOldValue
2613:                 RETURN
2614:             ENDIF
2615:         ENDIF
2616: 
2617:         loc_lOk = .T.
2618:         DO CASE
2619:             CASE loc_nValorNovo = THIS.this_nOldValue
2620:                 * nada a fazer
2621:             CASE loc_nValorNovo < 0
2622:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
2623:                 loc_lOk = .F.
2624:             CASE loc_nValorNovo > TmpFinalg.Saldo
2625:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2626:                 loc_lOk = .F.
2627:             CASE loc_nValorNovo > (TmpFinalg.Saldo - TmpFinalg.Fabrs)
2628:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2629:                 loc_lOk = .F.
2630:             CASE !SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, ;
2631:                     "cursor_4c_TmpSaldo", "CPros") AND TmpFinalg.Produzir != TmpFinalg.Saldo
2632:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto no " + ;
2633:                     "estoque para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2634:                 loc_lOk = .F.
2635:             OTHERWISE
2636:                 IF cursor_4c_TmpSaldo.Saldo >= loc_nValorNovo
2637:                     REPLACE Disps WITH Saldo - loc_nValorNovo IN cursor_4c_TmpSaldo
2638:                     REPLACE Produzir WITH Saldo - Fabrs - loc_nValorNovo IN TmpFinalg
2639: 
2640:                     SELECT TmpFinalg
2641:                     REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
2642:                             QtdMins - Produzir, 0), ;
2643:                             UsuLibs WITH " " IN TmpFinalg
2644: 
2645:                     REPLACE KeySelm WITH .F. IN TmpSaldU
2646: 
2647:                     SELECT cursor_4c_TmpSaldo
2648:                     loc_nXBaixa = Saldo - Disps
2649: 
2650:                     SELECT cursor_4c_TmpSaldg
2651:                     SET ORDER TO CPros
2652:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2653:                     REPLACE Disps WITH Saldo WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2654:                             cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2655:                             cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams
2656:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2657:                     SCAN WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2658:                             cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2659:                             cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
2660:                         IF cursor_4c_TmpSaldg.Disps >= loc_nXBaixa
2661:                             REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nXBaixa
2662:                             loc_nXBaixa = 0
2663:                         ELSE
2664:                             loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpSaldg.Disps
2665:                             REPLACE cursor_4c_TmpSaldg.Disps WITH 0
2666:                         ENDIF
2667:                         SELECT cursor_4c_TmpSaldg
2668:                     ENDSCAN
2669: 
2670:                     loc_nXBaixa = loc_nValorNovo
2671:                     SELECT TmpFinal
2672:                     SET ORDER TO

*-- Linhas 2690 a 2860:
2690:                         SELECT TmpFinal
2691:                     ENDSCAN
2692:                 ELSE
2693:                     MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto no " + ;
2694:                         "estoque para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2695:                     loc_lOk = .F.
2696:                 ENDIF
2697:         ENDCASE
2698: 
2699:         IF !loc_lOk
2700:             loc_oCampo.Value = THIS.this_nOldValue
2701:         ENDIF
2702: 
2703:         SELECT TmpFinalg
2704:     ENDPROC
2705: 
2706:     *--------------------------------------------------------------------------
2707:     * AtualizarVisibilidadeDisponivel - "When" de GradeItens.Column10.Text1
2708:     * (Page1, dump 7029-7043): o botao "Disponiveis" so aparece quando o
2709:     * form esta em modo RESERVA, o item corrente ainda nao tem estoque
2710:     * reservado e o GRUPO do produto eh de tipo de estoque 3 ou 4.
2711:     *
2712:     *   ThisForm.PageDados.Page1.Disponivel.Visible = .f.
2713:     *   If ThisForm.Reserva And TmpFinalg.Estoque = 0
2714:     *       ... CursorQuery SigCdPro -> Cgrus -> SigCdGrp -> TipoEstos
2715:     *       If InList(CrSigCdGrp.TipoEstos,3,4) -> Visible = .t.
2716:     *
2717:     * Vive num metodo proprio, chamado de AfterRowColChange (troca de item)
2718:     * e de CarregarLista (primeira linha), porque BINDEVENT em "When" de
2719:     * TextBox de Grid nao dispara de forma confiavel (regra #3 do
2720:     * CLAUDE.md) - AfterRowColChange cobre exatamente o mesmo gatilho util,
2721:     * que eh "o item corrente mudou".
2722:     *--------------------------------------------------------------------------
2723:     PROTECTED PROCEDURE AtualizarVisibilidadeDisponivel()
2724:         LOCAL loc_nTipoEsto
2725: 
2726:         THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .F.
2727: 
2728:         IF !THIS.this_lReservaAuto
2729:             RETURN
2730:         ENDIF
2731:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2732:             RETURN
2733:         ENDIF
2734:         IF TmpFinalg.Estoque != 0
2735:             RETURN
2736:         ENDIF
2737:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2738:             RETURN
2739:         ENDIF
2740: 
2741:         loc_nTipoEsto = THIS.this_oBusinessObject.ObterTipoEstoqueProduto(ALLTRIM(TmpFinalg.Cpros))
2742: 
2743:         IF INLIST(loc_nTipoEsto, 3, 4)
2744:             THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .T.
2745:         ENDIF
2746:     ENDPROC
2747: 
2748:     *--------------------------------------------------------------------------
2749:     * GradeItensPage1Column8LostFocus - desarma o gate de liberacao manual
2750:     * (ThisForm.Liberado = .f. do legado) apos UMA edicao de Column8.
2751:     *--------------------------------------------------------------------------
2752:     PROCEDURE GradeItensPage1Column8LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2753:         THIS.this_lLiberadoAlteracao = .F.
2754:         THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.ReadOnly = .T.
2755:     ENDPROC
2756: 
2757:     *--------------------------------------------------------------------------
2758:     * GradeItensPage1LostFocus - recalcula os totais gerais da Page1
2759:     * (Tot_Qtd/Tot_Est/Tot_prdc/Tot_Prz/Tot_prze), igual ao LostFocus de
2760:     * Column7 no legado (dump 6918-6933) - RECNO salvo/restaurado porque
2761:     * SUM percorre o cursor e deixa o ponteiro em EOF.
2762:     *--------------------------------------------------------------------------
2763:     PROCEDURE GradeItensPage1LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2764:         THIS.AtualizarTotaisPage1()
2765:     ENDPROC
2766: 
2767:     PROTECTED PROCEDURE AtualizarTotaisPage1()
2768:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
2769: 
2770:         IF !USED("TmpFinalg")
2771:             RETURN
2772:         ENDIF
2773: 
2774:         SELECT TmpFinalg
2775:         loc_nRecno = RECNO()
2776:         SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
2777:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinalg")
2778:             GOTO loc_nRecno
2779:         ENDIF
2780: 
2781:         WITH THIS.pgf_4c_1.Page1
2782:             .txt_4c_Tot_Qtd.Value  = loc_nSal
2783:             .txt_4c_Tot_Est.Value  = loc_nEst
2784:             .txt_4c_Tot_prdc.Value = loc_nPrc
2785:             .txt_4c_Tot_Prz.Value  = loc_nPrz
2786:             .txt_4c_Tot_prze.Value = loc_nPrze
2787:             .txt_4c_Tot_Qtd.Refresh()
2788:             .txt_4c_Tot_Est.Refresh()
2789:             .txt_4c_Tot_prdc.Refresh()
2790:             .txt_4c_Tot_Prz.Refresh()
2791:             .txt_4c_Tot_prze.Refresh()
2792:         ENDWITH
2793:     ENDPROC
2794: 
2795:     *--------------------------------------------------------------------------
2796:     * GradeItensPage1AfterRowColChange - transcricao de GradeItens.
2797:     * AfterRowColChange (dump 6666-6726): ao trocar de linha na grade
2798:     * principal, reposiciona cursor_4c_TmpSaldg/cursor_4c_TmpFabr no
2799:     * produto/cor/tamanho corrente, atualiza os totais dos paineis
2800:     * Container3/Container1 e carrega a imagem do produto.
2801:     *--------------------------------------------------------------------------
2802:     PROCEDURE GradeItensPage1AfterRowColChange(par_nColIndex)
2803:         LOCAL loc_cChave, loc_cFiltro, loc_cArquivo, loc_oPag1
2804: 
2805:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2806:             RETURN
2807:         ENDIF
2808: 
2809:         loc_oPag1 = THIS.pgf_4c_1.Page1
2810:         *-- Chave POSICIONAL: o padding faz parte dela (CPros C(14) +
2811:         *-- CodCors C(4) + CodTams C(4) = 22). ALLTRIM nas partes encurta a
2812:         *-- chave e ela nunca casa (regra #42 do CLAUDE.md).
2813:         loc_cChave = TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams
2814: 
2815:         = SEEK(loc_cChave, "cursor_4c_TmpSaldo", "CPros")
2816: 
2817:         *-- As duas grades de resumo tem de mostrar SO as linhas do item
2818:         *-- corrente - o legado faz isso com "Set Key To TmpFinalg.Cpros +
2819:         *-- CodCors + CodTams", REEMITIDO aqui a cada troca de linha (medido
2820:         *-- no VFP9 em 2026-10-06: SET KEY TO <expr> eh ESTATICO, congela a
2821:         *-- faixa no valor do momento e nao reavalia). SEEK no lugar dele
2822:         *-- posicionaria o ponteiro mas deixaria a grade exibindo TODOS os
2823:         *-- produtos.
2824:         *--
2825:         *-- Aqui, porem, NAO se usa SET KEY e sim SET FILTER com "==" e o
2826:         *-- valor EMBUTIDO por macro: a faixa do SET KEY eh parcial (22 chars
2827:         *-- contra indices de 34/47) e faixa parcial fica VAZIA sob
2828:         *-- SET EXACT ON - e a faixa eh avaliada na NAVEGACAO, inclusive no
2829:         *-- desenho do Grid, entao nao ha bloco onde salvar/restaurar o SET.
2830:         *-- Hoje esta sessao nasce com EXACT OFF (DataSession = 2) e SET KEY
2831:         *-- funcionaria, mas seria uma mina: ligar EXACT ON por qualquer
2832:         *-- outro motivo apagaria as duas grades em silencio. "==" eh imune
2833:         *-- ao SET EXACT. Mesmo remedio ja adotado no irmao FormSigPrGlp.
2834:         loc_cFiltro = "Cpros + CodCors + CodTams == [" + loc_cChave + "]"
2835: 
2836:         SELECT cursor_4c_TmpSaldg
2837:         SET ORDER TO CPros
2838:         SET KEY TO
2839:         SET FILTER TO &loc_cFiltro
2840:         GO TOP
2841: 
2842:         WITH loc_oPag1.cnt_4c_Container3
2843:             .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0)
2844:             .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0) - TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
2845:             .txt_4c_Tot_Prz.Value = TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
2846:             .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel " + ALLTRIM(TmpFinalg.Cpros) + ;
2847:                 IIF(!EMPTY(TmpFinalg.CodCors), " Cor:" + ALLTRIM(TmpFinalg.CodCors), "") + ;
2848:                 IIF(!EMPTY(TmpFinalg.CodTams), " Tam:" + ALLTRIM(TmpFinalg.CodTams), "")
2849:             .grd_4c_DispGrupo.Refresh()
2850:             .Visible     = .T.
2851:         ENDWITH
2852: 
2853:         SELECT cursor_4c_TmpFabr
2854:         SET ORDER TO Cpros
2855:         SET KEY TO
2856:         SET FILTER TO &loc_cFiltro
2857:         GO TOP
2858: 
2859:         WITH loc_oPag1.cnt_4c_Container1
2860:             .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Fabrs, 0)

*-- Linhas 2884 a 3299:
2884:     * "Skip / Skip -1 / Grid.Refresh" do legado (dump 4439-4444, 6625-6630,
2885:     * 6647-6654): forca a grade a repintar apos editar a coluna Prior.
2886:     *--------------------------------------------------------------------------
2887:     PROCEDURE GradeDispGrupoColumn6LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2888:         THIS.pgf_4c_1.Page1.cnt_4c_Container3.grd_4c_DispGrupo.Refresh()
2889:     ENDPROC
2890: 
2891:     PROCEDURE GradeDispFaseColumn4LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2892:         THIS.pgf_4c_1.Page1.cnt_4c_Container1.grd_4c_DispFase.Refresh()
2893:     ENDPROC
2894: 
2895:     *--------------------------------------------------------------------------
2896:     * ImgFigJpgPage1DblClick - "Do Form SigOpZom" do legado (zoom da
2897:     * imagem). SigOpZom nao foi migrado - ausencia reportada via MsgAviso
2898:     * (regra #27 do CLAUDE.md: ausencia visivel, nunca mascarada), em vez
2899:     * de silenciosamente nao fazer nada.
2900:     *--------------------------------------------------------------------------
2901:     PROCEDURE ImgFigJpgPage1DblClick()
2902:         MsgAviso("Visualiza" + CHR(231) + CHR(227) + "o ampliada da imagem (SigOpZom) " + ;
2903:             "ainda n" + CHR(227) + "o foi portada para o novo sistema.", "Aten" + CHR(231) + CHR(227) + "o")
2904:     ENDPROC
2905: 
2906:     *--------------------------------------------------------------------------
2907:     * AlternarPagina - troca a pagina ativa do pgf_4c_1 (equivalente a
2908:     * ThisForm.PageDados.ActivePage = N do legado, usado por todos os botoes
2909:     * de navegacao entre a grade principal e as sub-paginas de selecao:
2910:     * Disponivel/SelEstoque/Pedras abrem uma pagina de detalhe, Cancela*
2911:     * volta para a Page1). PUBLIC (nao PROTECTED) porque o harness de teste
2912:     * automatizado chama THIS.oForm.AlternarPagina(N) direto de fora da
2913:     * classe (mesma regra de BtnIncluirClick/CarregarLista).
2914:     *--------------------------------------------------------------------------
2915:     PROCEDURE AlternarPagina()
2916:         LPARAMETERS par_nPagina
2917: 
2918:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 ;
2919:                 AND par_nPagina <= THIS.pgf_4c_1.PageCount
2920:             THIS.pgf_4c_1.ActivePage = par_nPagina
2921:         ENDIF
2922:     ENDPROC
2923: 
2924:     *--------------------------------------------------------------------------
2925:     * GradeItensPage2GotFocus - idem GradeItensPage1GotFocus, mas para a
2926:     * grade de selecao de linha (Page2): toda coluna que nao seja a 7
2927:     * (Estoque) ou a 10 (Produ" + "cao") redireciona para a Column7.
2928:     *--------------------------------------------------------------------------
2929:     PROCEDURE GradeItensPage2GotFocus()
2930:         THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1.SetFocus()
2931:     ENDPROC
2932: 
2933:     *--------------------------------------------------------------------------
2934:     * GradeItensPage2Column7Valid / Column10Valid - transcricao de
2935:     * GradeItens.Column7/Column10.Text1.Valid da Page2 (dump 7357-7379,
2936:     * 7477-7499): validacao PURA de faixa (sem redistribuicao - o
2937:     * ControlSource do Grid ja grava o valor em TmpFinal.Estoque/Fabrs).
2938:     *--------------------------------------------------------------------------
2939:     PROCEDURE GradeItensPage2Column7Valid()
2940:         LOCAL loc_oCampo, loc_nPSaldo
2941: 
2942:         loc_oCampo = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1
2943:         loc_nPSaldo = THIS.pgf_4c_1.Page2.txt_4c_Tot_sEst.Value
2944: 
2945:         IF !USED("TmpFinal") OR EOF("TmpFinal") OR loc_oCampo.Value = THIS.this_nOldValue
2946:             RETURN
2947:         ENDIF
2948: 
2949:         DO CASE
2950:             CASE loc_oCampo.Value < 0
2951:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
2952:                 loc_oCampo.Value = THIS.this_nOldValue
2953:             CASE loc_oCampo.Value > TmpFinal.Saldo
2954:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2955:                 loc_oCampo.Value = THIS.this_nOldValue
2956:             CASE loc_oCampo.Value > loc_nPSaldo
2957:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Selecionada...", "Aten" + CHR(231) + CHR(227) + "o")
2958:                 loc_oCampo.Value = THIS.this_nOldValue
2959:             CASE loc_oCampo.Value > (TmpFinal.Saldo - TmpFinal.Fabrs)
2960:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
2961:                 loc_oCampo.Value = THIS.this_nOldValue
2962:         ENDCASE
2963:     ENDPROC
2964: 
2965:     PROCEDURE GradeItensPage2Column10Valid()
2966:         LOCAL loc_oCampo, loc_nPSaldo
2967: 
2968:         loc_oCampo = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column10.Text1
2969:         loc_nPSaldo = THIS.pgf_4c_1.Page2.txt_4c_Tot_sPrc.Value
2970: 
2971:         IF !USED("TmpFinal") OR EOF("TmpFinal") OR loc_oCampo.Value = THIS.this_nOldValue
2972:             RETURN
2973:         ENDIF
2974: 
2975:         DO CASE
2976:             CASE loc_oCampo.Value < 0
2977:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
2978:                 loc_oCampo.Value = THIS.this_nOldValue
2979:             CASE loc_oCampo.Value > TmpFinal.Saldo
2980:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2981:                 loc_oCampo.Value = THIS.this_nOldValue
2982:             CASE loc_oCampo.Value > loc_nPSaldo
2983:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Selecionada...", "Aten" + CHR(231) + CHR(227) + "o")
2984:                 loc_oCampo.Value = THIS.this_nOldValue
2985:             CASE loc_oCampo.Value > (TmpFinal.Saldo - TmpFinal.Estoque)
2986:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
2987:                 loc_oCampo.Value = THIS.this_nOldValue
2988:         ENDCASE
2989:     ENDPROC
2990: 
2991:     *--------------------------------------------------------------------------
2992:     * GradeItensPage2LostFocus - recalcula Tot_Qtd/Tot_Est/Tot_prc/Tot_Prz
2993:     * da Page2 (dump 7384-7398 / 7504-7517, identicos nas duas colunas).
2994:     *--------------------------------------------------------------------------
2995:     PROCEDURE GradeItensPage2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2996:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
2997: 
2998:         IF !USED("TmpFinal")
2999:             RETURN
3000:         ENDIF
3001: 
3002:         SELECT TmpFinal
3003:         loc_nRecno = RECNO()
3004:         SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
3005:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinal")
3006:             GOTO loc_nRecno
3007:         ENDIF
3008: 
3009:         WITH THIS.pgf_4c_1.Page2
3010:             .txt_4c_Tot_Qtd.Value = loc_nSal
3011:             .txt_4c_Tot_Est.Value = loc_nEst
3012:             .txt_4c_Tot_prc.Value = loc_nPrc
3013:             .txt_4c_Tot_Prz.Value = loc_nPrz
3014:             .txt_4c_Tot_Qtd.Refresh()
3015:             .txt_4c_Tot_Est.Refresh()
3016:             .txt_4c_Tot_prc.Refresh()
3017:             .txt_4c_Tot_Prz.Refresh()
3018:         ENDWITH
3019:     ENDPROC
3020: 
3021:     *--------------------------------------------------------------------------
3022:     * GradeItensPage2AfterRowColChange - transcricao de GradeItens.
3023:     * AfterRowColChange da Page2 (dump 7251-7279): atualiza o rotulo e a
3024:     * imagem do produto da linha corrente. Usa o MESMO
3025:     * CarregarFotoProduto() do BO ja usado na Page1 (que decodifica o
3026:     * base64 corretamente) em vez do StrToFile direto do legado - o dump da
3027:     * Page2 grava o campo cru, sem o Strconv/Strtran que a Page1 faz, o que
3028:     * geraria um arquivo .jpg invalido.
3029:     *--------------------------------------------------------------------------
3030:     PROCEDURE GradeItensPage2AfterRowColChange(par_nColIndex)
3031:         LOCAL loc_cArquivo, loc_oPag2
3032: 
3033:         IF !USED("TmpFinal") OR EOF("TmpFinal")
3034:             RETURN
3035:         ENDIF
3036: 
3037:         loc_oPag2 = THIS.pgf_4c_1.Page2
3038:         loc_oPag2.obj_4c_ObsItens.Refresh()
3039:         loc_oPag2.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)
3040: 
3041:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3042:             loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb6_" + SYS(3) + ".jpg"
3043:             loc_oPag2.img_4c_FigJpg.Picture = ""
3044:             loc_oPag2.img_4c_FigJpg.Visible = .F.
3045:             IF THIS.this_oBusinessObject.CarregarFotoProduto(ALLTRIM(TmpFinal.Cpros), loc_cArquivo)
3046:                 loc_oPag2.img_4c_FigJpg.Picture = loc_cArquivo
3047:                 loc_oPag2.img_4c_FigJpg.Visible = .T.
3048:             ENDIF
3049:         ENDIF
3050: 
3051:         SELECT TmpFinal
3052:     ENDPROC
3053: 
3054:     *--------------------------------------------------------------------------
3055:     * GradeDispEstoqueColumn5Valid / GradeDispTamanhoColumn5Valid -
3056:     * transcricao de Page4/Page5.GradeDisp.Column5.Text1.Valid (dump
3057:     * 7754-7785, 8030-8057): valida a quantidade "Utilizar" contra o
3058:     * disponivel da linha e contra o saldo total ainda nao atendido
3059:     * (Qt_pedida), e atualiza Qt_Selec com a soma de Utilizar da grade.
3060:     *--------------------------------------------------------------------------
3061:     PROCEDURE GradeDispEstoqueColumn5Valid()
3062:         LOCAL loc_oCampo, loc_nPSaldo, loc_nQtdUti, loc_nRecno
3063: 
3064:         loc_oCampo = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.Text1
3065: 
3066:         IF !USED("TmpFinalg") OR EOF("TmpFinalg") OR !USED("cursor_4c_DispEstoque")
3067:             RETURN
3068:         ENDIF
3069: 
3070:         loc_nPSaldo = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
3071: 
3072:         IF loc_oCampo.Value > cursor_4c_DispEstoque.Disps
3073:             MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
3074:             loc_oCampo.Value = 0
3075:             loc_oCampo.Refresh()
3076:             RETURN
3077:         ENDIF
3078:         IF loc_oCampo.Value < 0
3079:             MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero...", "Aten" + CHR(231) + CHR(227) + "o")
3080:             loc_oCampo.Value = 0
3081:             loc_oCampo.Refresh()
3082:             RETURN
3083:         ENDIF
3084: 
3085:         loc_nRecno = RECNO("cursor_4c_DispEstoque")
3086:         SELECT cursor_4c_DispEstoque
3087:         SUM Utilizar TO loc_nQtdUti
3088:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispEstoque")
3089:             GOTO loc_nRecno
3090:         ENDIF
3091: 
3092:         IF loc_nQtdUti > loc_nPSaldo
3093:             MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "Aten" + CHR(231) + CHR(227) + "o")
3094:             loc_oCampo.Value = 0
3095:             loc_oCampo.Refresh()
3096:             RETURN
3097:         ENDIF
3098: 
3099:         THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = loc_nQtdUti
3100:         THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Refresh()
3101:     ENDPROC
3102: 
3103:     PROCEDURE GradeDispTamanhoColumn5Valid()
3104:         LOCAL loc_oCampo, loc_nPSaldo, loc_nQtdUti, loc_nRecno
3105: 
3106:         loc_oCampo = THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.Column5.Text1
3107: 
3108:         IF !USED("cursor_4c_DispTamanho")
3109:             RETURN
3110:         ENDIF
3111: 
3112:         loc_nPSaldo = THIS.pgf_4c_1.Page5.txt_4c_Qt_pedida.Value
3113: 
3114:         IF loc_oCampo.Value > cursor_4c_DispTamanho.Disps
3115:             MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
3116:             loc_oCampo.Value = 0
3117:             loc_oCampo.Refresh()
3118:             RETURN
3119:         ENDIF
3120: 
3121:         loc_nRecno = RECNO("cursor_4c_DispTamanho")
3122:         SELECT cursor_4c_DispTamanho
3123:         SUM Utilizar TO loc_nQtdUti
3124:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispTamanho")
3125:             GOTO loc_nRecno
3126:         ENDIF
3127: 
3128:         IF loc_nQtdUti > loc_nPSaldo
3129:             MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Pedida...", "Aten" + CHR(231) + CHR(227) + "o")
3130:             loc_oCampo.Value = 0
3131:             loc_oCampo.Refresh()
3132:             RETURN
3133:         ENDIF
3134: 
3135:         THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = loc_nQtdUti
3136:         THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Refresh()
3137:     ENDPROC
3138: 
3139:     *--------------------------------------------------------------------------
3140:     * GradeDispColumn5LostFocus - "If Lastkey()=13 / Keyboard DNARROW" +
3141:     * Refresh do legado (dump 7790-7795, 8058-7? identico nas duas
3142:     * paginas). O avanco automatico de linha via KEYBOARD nao eh
3143:     * reproduzido (regra geral do projeto contra simular teclado); o
3144:     * Refresh, que corrige o redraw da celula, permanece. BINDEVENT em
3145:     * "LostFocus" nao repassa o controle de origem como parametro -
3146:     * refresca as duas colunas (Page4 e Page5), ambas inofensivas se a
3147:     * pagina correspondente nao estiver ativa.
3148:     *--------------------------------------------------------------------------
3149:     PROCEDURE GradeDispColumn5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
3150:         IF PEMSTATUS(THIS.pgf_4c_1.Page4, "grd_4c_DispEstoque", 5)
3151:             THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.Text1.Refresh()
3152:         ENDIF
3153:         IF PEMSTATUS(THIS.pgf_4c_1.Page5, "grd_4c_DispTamanho", 5)
3154:             THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.Column5.Text1.Refresh()
3155:         ENDIF
3156:     ENDPROC
3157: 
3158:     *--------------------------------------------------------------------------
3159:     * TornarControlesVisiveis - torna visiveis todos os controles criados via
3160:     * AddObject (que nascem com Visible=.F.), percorrendo Pages de PageFrame e
3161:     * Controls de Container recursivamente. cmd_4c_Pedras/SelEstoque/
3162:     * Disponivel nascem Visible=.F. no SCX legado (so aparecem conforme o
3163:     * TipoEstos do produto corrente - logica da fase de eventos) e por isso
3164:     * sao filtrados aqui, senao esta rotina reabre os tres incondicionalmente.
3165:     *--------------------------------------------------------------------------
3166:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3167:         LOCAL loc_nI, loc_oObjeto, loc_nP
3168: 
3169:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3170:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3171: 
3172:             IF VARTYPE(loc_oObjeto) = "O"
3173:                 IF INLIST(UPPER(loc_oObjeto.Name), "CMD_4C_PEDRAS", ;
3174:                         "CMD_4C_SELESTOQUE", "CMD_4C_DISPONIVEL", "IMG_4C_FIGJPG")
3175:                     LOOP
3176:                 ENDIF
3177: 
3178:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3179:                     loc_oObjeto.Visible = .T.
3180:                 ENDIF
3181: 
3182:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3183:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3184:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3185:                     ENDFOR
3186:                 ENDIF
3187: 
3188:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3189:                     IF loc_oObjeto.ControlCount > 0
3190:                         THIS.TornarControlesVisiveis(loc_oObjeto)
3191:                     ENDIF
3192:                 ENDIF
3193:             ENDIF
3194:         ENDFOR
3195:     ENDPROC
3196: 
3197:     *--------------------------------------------------------------------------
3198:     * BtnCancelarClick - "Cancelar" da Page1 (Encerrar). Fecha a tela;
3199:     * Destroy() ja reabilita o form pai (THIS.this_oFormPai).
3200:     *--------------------------------------------------------------------------
3201:     PROCEDURE BtnCancelarClick()
3202:         THIS.Release()
3203:     ENDPROC
3204: 
3205:     *--------------------------------------------------------------------------
3206:     * BtnCancelarPage2Click - transcricao de Page2.Cancelar.Click (dump
3207:     * 7530-7550): so volta para a Page1 se o total de Estoque/Fabrs
3208:     * distribuido na grade de selecao (TmpFinal) bater com o que
3209:     * TmpFinalg espera para o item corrente.
3210:     *--------------------------------------------------------------------------
3211:     PROCEDURE BtnCancelarPage2Click()
3212:         LOCAL loc_nEstoque, loc_nFabrica, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
3213: 
3214:         IF !USED("TmpFinalg") OR !USED("TmpFinal")
3215:             THIS.AlternarPagina(1)
3216:             RETURN
3217:         ENDIF
3218: 
3219:         loc_nEstoque = TmpFinalg.Estoque
3220:         loc_nFabrica = TmpFinalg.Fabrs
3221: 
3222:         SELECT TmpFinal
3223:         SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
3224:         GO TOP
3225: 
3226:         IF loc_nEst != loc_nEstoque
3227:             MsgAviso("A quantidade de Estoque n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
3228:             RETURN
3229:         ENDIF
3230:         IF loc_nPrc != loc_nFabrica
3231:             MsgAviso("A quantidade de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
3232:             RETURN
3233:         ENDIF
3234: 
3235:         THIS.pgf_4c_1.Page1.Enabled = .T.
3236:         THIS.AlternarPagina(1)
3237:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3238:     ENDPROC
3239: 
3240:     *--------------------------------------------------------------------------
3241:     * BtnCancelaLinClick - transcricao de Page3.CancelaLin.Click (dump
3242:     * 7562-7572): volta para a Page1.
3243:     *--------------------------------------------------------------------------
3244:     PROCEDURE BtnCancelaLinClick()
3245:         THIS.pgf_4c_1.Page1.Enabled = .T.
3246:         THIS.pgf_4c_1.Page2.Enabled = .T.
3247:         THIS.pgf_4c_1.Page3.Enabled = .F.
3248:         THIS.pgf_4c_1.Page4.Enabled = .F.
3249:         THIS.pgf_4c_1.Page5.Enabled = .F.
3250:         THIS.AlternarPagina(1)
3251:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3252:     ENDPROC
3253: 
3254:     *--------------------------------------------------------------------------
3255:     * BtnTotLinhaClick - transcricao de Page1.TotLinha.Click (dump
3256:     * 6478-6512): monta TmpLinha (totais por Linha + linha "TOTAIS") a
3257:     * partir de TmpFinalg e liga a grade da Page3.
3258:     *--------------------------------------------------------------------------
3259:     PROCEDURE BtnTotLinhaClick()
3260:         LOCAL loc_oGrid, loc_nCol
3261: 
3262:         IF !USED("TmpFinalg")
3263:             RETURN
3264:         ENDIF
3265: 
3266:         IF USED("TmpLinha")
3267:             USE IN TmpLinha
3268:         ENDIF
3269: 
3270:         SELECT Linhas, 0 AS Ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
3271:                 SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
3272:             FROM TmpFinalg GROUP BY 1 ;
3273:             UNION ALL ;
3274:             SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
3275:                 SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
3276:             FROM TmpFinalg GROUP BY 1 ;
3277:             INTO CURSOR TmpLinha ORDER BY 2, 1
3278: 
3279:         loc_oGrid = THIS.pgf_4c_1.Page3.grd_4c_Linhas
3280:         loc_oGrid.RecordSource = ""
3281:         loc_oGrid.ColumnCount  = 5
3282:         loc_oGrid.RecordSource = "TmpLinha"
3283:         loc_oGrid.Column1.ControlSource = "TmpLinha.Linhas"
3284:         loc_oGrid.Column2.ControlSource = "TmpLinha.Saldo"
3285:         loc_oGrid.Column3.ControlSource = "TmpLinha.Estoque"
3286:         loc_oGrid.Column4.ControlSource = "TmpLinha.Fabrs"
3287:         loc_oGrid.Column5.ControlSource = "TmpLinha.Produzir"
3288: 
3289:         *-- ColumnCount reatribuido RESETA Header1.Caption/Width/ReadOnly/
3290:         *-- Movable/Resizable/Sparse de TODAS as colunas (medido no VFP9 -
3291:         *-- regra do Problema 48/Pattern #180) - reconfigurar na mesma
3292:         *-- ordem de ConfigurarPaginaTotaisLinha.
3293:         loc_oGrid.Column1.Header1.Caption = "Linha"
3294:         loc_oGrid.Column1.Width     = 84
3295:         loc_oGrid.Column1.Movable   = .F.
3296:         loc_oGrid.Column1.Resizable = .F.
3297:         loc_oGrid.Column1.Sparse    = .F.
3298:         loc_oGrid.Column1.ReadOnly  = .T.
3299:         loc_oGrid.Column1.ForeColor = RGB(36, 84, 155)

*-- Linhas 3361 a 3567:
3361:     * corrente (cursor_4c_TmpSaldg) na Page4, para o usuario redistribuir a
3362:     * prioridade/uso manualmente.
3363:     *--------------------------------------------------------------------------
3364:     PROCEDURE BtnSelEstoqueClick()
3365:         LOCAL loc_cCpro, loc_cCor, loc_cTam, loc_oGrid
3366: 
3367:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3368:             RETURN
3369:         ENDIF
3370: 
3371:         loc_cCpro = TmpFinalg.Cpros
3372:         loc_cCor  = TmpFinalg.CodCors
3373:         loc_cTam  = TmpFinalg.CodTams
3374: 
3375:         IF USED("cursor_4c_DispEstoque")
3376:             THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.RecordSource = ""
3377:             USE IN cursor_4c_DispEstoque
3378:         ENDIF
3379: 
3380:         SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
3381:             FROM cursor_4c_TmpSaldg ;
3382:             WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND CodTams = loc_cTam AND Disps > 0 ;
3383:             ORDER BY 1, 2, 3, 4 ;
3384:             INTO CURSOR cursor_4c_DispEstoque READWRITE
3385: 
3386:         IF RECCOUNT("cursor_4c_DispEstoque") = 0
3387:             MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "Aten" + CHR(231) + CHR(227) + "o")
3388:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3389:             RETURN
3390:         ENDIF
3391: 
3392:         loc_oGrid = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque
3393:         loc_oGrid.ColumnCount = 5
3394:         loc_oGrid.RecordSource = "cursor_4c_DispEstoque"
3395:         loc_oGrid.Column1.ControlSource = "cursor_4c_DispEstoque.Grupos"
3396:         loc_oGrid.Column2.ControlSource = "cursor_4c_DispEstoque.Estos"
3397:         loc_oGrid.Column3.ControlSource = "cursor_4c_DispEstoque.Priors"
3398:         loc_oGrid.Column4.ControlSource = "cursor_4c_DispEstoque.Disps"
3399:         loc_oGrid.Column5.ControlSource = "cursor_4c_DispEstoque.Utilizar"
3400: 
3401:         *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
3402:         *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
3403:         *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaEstoque.
3404:         loc_oGrid.Column1.Header1.Caption = "Grupo"
3405:         loc_oGrid.Column1.Width     = 80
3406:         loc_oGrid.Column1.ReadOnly  = .T.
3407:         loc_oGrid.Column2.Header1.Caption = "Conta"
3408:         loc_oGrid.Column2.Width     = 80
3409:         loc_oGrid.Column2.ReadOnly  = .T.
3410:         loc_oGrid.Column3.Header1.Caption = "Prior"
3411:         loc_oGrid.Column3.Width     = 24
3412:         loc_oGrid.Column3.ReadOnly  = .T.
3413:         loc_oGrid.Column4.Header1.Caption = "Disponivel"
3414:         loc_oGrid.Column4.Width     = 75
3415:         loc_oGrid.Column4.ReadOnly  = .T.
3416:         loc_oGrid.Column5.Header1.Caption = "Utilizar"
3417:         loc_oGrid.Column5.Width     = 75
3418:         loc_oGrid.Column5.ReadOnly  = .F.
3419:         loc_oGrid.Column5.Text1.FontBold = .T.
3420: 
3421:         WITH THIS.pgf_4c_1.Page4
3422:             .txt_4c_Qt_pedida.Value = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
3423:             .txt_4c_Qt_Selec.Value  = 0
3424:         ENDWITH
3425:         loc_oGrid.Refresh()
3426: 
3427:         THIS.pgf_4c_1.Page1.Enabled = .F.
3428:         THIS.pgf_4c_1.Page2.Enabled = .F.
3429:         THIS.pgf_4c_1.Page3.Enabled = .F.
3430:         THIS.pgf_4c_1.Page5.Enabled = .F.
3431:         THIS.pgf_4c_1.Page4.Enabled = .T.
3432:         THIS.AlternarPagina(4)
3433:         loc_oGrid.SetFocus()
3434:     ENDPROC
3435: 
3436:     *--------------------------------------------------------------------------
3437:     * BtnDisponivelClick - transcricao de Page1.Disponivel.Click (dump
3438:     * 4487-4550): lista o saldo disponivel do produto/cor corrente
3439:     * QUEBRADO POR TAMANHO (cursor_4c_TmpSaldo) na Page5.
3440:     *--------------------------------------------------------------------------
3441:     PROCEDURE BtnDisponivelClick()
3442:         LOCAL loc_cCpro, loc_cCor, loc_oGrid
3443: 
3444:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3445:             RETURN
3446:         ENDIF
3447: 
3448:         IF TmpFinalg.Estoque != 0 OR TmpFinalg.Fabrs != 0
3449:             MsgAviso("Quantidade de Estoque e Produ" + CHR(231) + CHR(227) + "o tem estar Zero antes deste Processo!!!", ;
3450:                 "Aten" + CHR(231) + CHR(227) + "o")
3451:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3452:             RETURN
3453:         ENDIF
3454: 
3455:         loc_cCpro = TmpFinalg.Cpros
3456:         loc_cCor  = TmpFinalg.CodCors
3457: 
3458:         IF USED("cursor_4c_DispTamanho")
3459:             THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.RecordSource = ""
3460:             USE IN cursor_4c_DispTamanho
3461:         ENDIF
3462: 
3463:         SELECT Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
3464:             FROM cursor_4c_TmpSaldo ;
3465:             WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND Disps > 0 ;
3466:             ORDER BY 1, 2, 3 ;
3467:             INTO CURSOR cursor_4c_DispTamanho READWRITE
3468: 
3469:         IF RECCOUNT("cursor_4c_DispTamanho") = 0
3470:             MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel em Nenhum Tamanho!!!", "Aten" + CHR(231) + CHR(227) + "o")
3471:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3472:             RETURN
3473:         ENDIF
3474: 
3475:         loc_oGrid = THIS.pgf_4c_1.Page5.grd_4c_DispTamanho
3476:         loc_oGrid.ColumnCount = 5
3477:         loc_oGrid.RecordSource = "cursor_4c_DispTamanho"
3478:         loc_oGrid.Column1.ControlSource = "cursor_4c_DispTamanho.Cpros"
3479:         loc_oGrid.Column2.ControlSource = "cursor_4c_DispTamanho.CodCors"
3480:         loc_oGrid.Column3.ControlSource = "cursor_4c_DispTamanho.CodTams"
3481:         loc_oGrid.Column4.ControlSource = "cursor_4c_DispTamanho.Disps"
3482:         loc_oGrid.Column5.ControlSource = "cursor_4c_DispTamanho.Utilizar"
3483: 
3484:         *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
3485:         *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
3486:         *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaTamanhos.
3487:         loc_oGrid.Column1.Header1.Caption = "Produto"
3488:         loc_oGrid.Column1.Width     = 80
3489:         loc_oGrid.Column1.ReadOnly  = .T.
3490:         loc_oGrid.Column2.Header1.Caption = "Cor"
3491:         loc_oGrid.Column2.Width     = 38
3492:         loc_oGrid.Column2.ReadOnly  = .T.
3493:         loc_oGrid.Column2.Text1.FontBold = .T.
3494:         loc_oGrid.Column3.Header1.Caption = "Tam"
3495:         loc_oGrid.Column3.Width     = 24
3496:         loc_oGrid.Column3.ReadOnly  = .T.
3497:         loc_oGrid.Column3.Text1.FontBold = .T.
3498:         loc_oGrid.Column4.Header1.Caption = "Disponivel"
3499:         loc_oGrid.Column4.Width     = 75
3500:         loc_oGrid.Column4.ReadOnly  = .T.
3501:         loc_oGrid.Column5.Header1.Caption = "Utilizar"
3502:         loc_oGrid.Column5.Width     = 75
3503:         loc_oGrid.Column5.ReadOnly  = .F.
3504:         loc_oGrid.Column5.Text1.FontBold = .T.
3505: 
3506:         WITH THIS.pgf_4c_1.Page5
3507:             .txt_4c_Qt_pedida.Value = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
3508:             .txt_4c_Qt_Selec.Value  = 0
3509:         ENDWITH
3510:         loc_oGrid.Refresh()
3511: 
3512:         THIS.pgf_4c_1.Page1.Enabled = .F.
3513:         THIS.pgf_4c_1.Page2.Enabled = .F.
3514:         THIS.pgf_4c_1.Page3.Enabled = .F.
3515:         THIS.pgf_4c_1.Page4.Enabled = .F.
3516:         THIS.pgf_4c_1.Page5.Enabled = .T.
3517:         THIS.AlternarPagina(5)
3518:         loc_oGrid.SetFocus()
3519:     ENDPROC
3520: 
3521:     *--------------------------------------------------------------------------
3522:     * BtnCancelaDispPage4Click - transcricao de Page4.CancelaDisp.Click
3523:     * (dump 7584-7666): devolve o "Utilizar" marcado na grade de
3524:     * grupo/conta para TmpFinalg/cursor_4c_TmpSaldo/cursor_4c_TmpSaldg e
3525:     * TmpFinal, e volta para a Page1.
3526:     *--------------------------------------------------------------------------
3527:     PROCEDURE BtnCancelaDispPage4Click()
3528:         LOCAL loc_nQtdUti, loc_nLnQtUtil, loc_nXBaixa
3529: 
3530:         IF USED("cursor_4c_DispEstoque") AND RECCOUNT("cursor_4c_DispEstoque") > 0
3531:             SELECT cursor_4c_DispEstoque
3532:             SUM Utilizar TO loc_nQtdUti
3533: 
3534:             IF loc_nQtdUti > 0
3535:                 SELECT cursor_4c_DispEstoque
3536:                 SCAN
3537:                     IF cursor_4c_DispEstoque.Utilizar = 0
3538:                         LOOP
3539:                     ENDIF
3540:                     loc_nLnQtUtil = cursor_4c_DispEstoque.Utilizar
3541: 
3542:                     = SEEK(cursor_4c_DispEstoque.CPros + cursor_4c_DispEstoque.CodCors + cursor_4c_DispEstoque.CodTams, ;
3543:                         "cursor_4c_TmpSaldo", "CPros")
3544: 
3545:                     SELECT TmpFinalg
3546:                     REPLACE Produzir WITH Produzir - loc_nLnQtUtil, ;
3547:                             Estoque  WITH Estoque + loc_nLnQtUtil, ;
3548:                             UsuLibs  WITH " " IN TmpFinalg
3549: 
3550:                     SELECT cursor_4c_TmpSaldo
3551:                     REPLACE Disps WITH Disps - loc_nLnQtUtil IN cursor_4c_TmpSaldo
3552: 
3553:                     IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
3554:                         INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
3555:                     ENDIF
3556:                     REPLACE keySelm WITH .T. IN TmpSaldU
3557: 
3558:                     SELECT cursor_4c_TmpSaldg
3559:                     SET ORDER TO CPros
3560:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams + ;
3561:                         STR(cursor_4c_DispEstoque.Priors, 2) + cursor_4c_DispEstoque.Grupos + cursor_4c_DispEstoque.Estos)
3562:                     REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nLnQtUtil
3563:                     SELECT cursor_4c_DispEstoque
3564:                 ENDSCAN
3565: 
3566:                 = SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, "cursor_4c_TmpSaldo", "CPros")
3567: 

*-- Linhas 3607 a 3650:
3607:     * real - a linha de origem, sem tamanho definido, eh dividida numa
3608:     * nova linha com o tamanho escolhido).
3609:     *--------------------------------------------------------------------------
3610:     PROCEDURE BtnCancelaDispPage5Click()
3611:         LOCAL loc_nQtdUti, loc_nRegFinal, loc_nLnQtUtil, loc_cEdn, loc_cQuery
3612: 
3613:         IF !USED("TmpFinal") OR !USED("cursor_4c_DispTamanho")
3614:             THIS.AlternarPagina(1)
3615:             RETURN
3616:         ENDIF
3617: 
3618:         SELECT TmpFinal
3619:         SET ORDER TO
3620:         loc_nRegFinal = RECNO()
3621: 
3622:         SELECT cursor_4c_DispTamanho
3623:         SUM Utilizar TO loc_nQtdUti
3624: 
3625:         IF loc_nQtdUti > 0
3626:             IF USED("Temporario")
3627:                 USE IN Temporario
3628:             ENDIF
3629:             SELECT * FROM TmpFinal WHERE .F. INTO CURSOR Temporario READWRITE
3630: 
3631:             SELECT cursor_4c_DispTamanho
3632:             SCAN
3633:                 IF cursor_4c_DispTamanho.Utilizar = 0
3634:                     LOOP
3635:                 ENDIF
3636:                 loc_nLnQtUtil = cursor_4c_DispTamanho.Utilizar
3637: 
3638:                 = SEEK(cursor_4c_DispTamanho.CPros + cursor_4c_DispTamanho.CodCors + cursor_4c_DispTamanho.CodTams, ;
3639:                     "cursor_4c_TmpSaldo", "CPros")
3640: 
3641:                 SELECT TmpFinal
3642:                 SCATTER MEMVAR
3643:                 SELECT Temporario
3644:                 APPEND BLANK
3645:                 GATHER MEMVAR
3646:                 REPLACE Temporario.Saldo WITH loc_nLnQtUtil, ;
3647:                         Temporario.codTams WITH cursor_4c_DispTamanho.CodTams, ;
3648:                         Temporario.Estoque WITH loc_nLnQtUtil, ;
3649:                         Temporario.Produzir WITH 0
3650: 

*-- Linhas 3746 a 3968:
3746:     * tem Cancelar) - segue o mesmo padrao de retorno das outras
3747:     * sub-paginas, canonico do projeto.
3748:     *--------------------------------------------------------------------------
3749:     PROCEDURE BtnCancelaDispPage6Click()
3750:         THIS.pgf_4c_1.Page1.Enabled = .T.
3751:         THIS.pgf_4c_1.Page2.Enabled = .T.
3752:         THIS.pgf_4c_1.Page6.Enabled = .F.
3753:         THIS.AlternarPagina(1)
3754:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3755:     ENDPROC
3756: 
3757:     *--------------------------------------------------------------------------
3758:     * BtnPedrasClick - transcricao de Page1.Pedras.Click (dump 7216-7239):
3759:     * liga a grade de requisicao manual (SelPedra/cursor_4c_Requisicao) e
3760:     * vai para a Page6.
3761:     *--------------------------------------------------------------------------
3762:     PROCEDURE BtnPedrasClick()
3763:         LOCAL loc_oGrid
3764: 
3765:         loc_oGrid = THIS.pgf_4c_1.Page6.grd_4c_Pedra
3766:         loc_oGrid.RecordSource = ""
3767:         loc_oGrid.ColumnCount  = 5
3768:         loc_oGrid.RecordSource = "cursor_4c_Requisicao"
3769:         loc_oGrid.Column1.ControlSource = "cursor_4c_Requisicao.Cpros"
3770:         loc_oGrid.Column2.ControlSource = "cursor_4c_Requisicao.Dpros"
3771:         loc_oGrid.Column3.ControlSource = "cursor_4c_Requisicao.Cunis"
3772:         loc_oGrid.Column4.ControlSource = "cursor_4c_Requisicao.Qtds"
3773:         loc_oGrid.Column5.ControlSource = "cursor_4c_Requisicao.Cpro2s"
3774: 
3775:         THIS.pgf_4c_1.Page1.Enabled = .F.
3776:         THIS.pgf_4c_1.Page2.Enabled = .F.
3777:         THIS.pgf_4c_1.Page3.Enabled = .F.
3778:         THIS.pgf_4c_1.Page4.Enabled = .F.
3779:         THIS.pgf_4c_1.Page5.Enabled = .F.
3780:         THIS.pgf_4c_1.Page6.Enabled = .T.
3781:         THIS.AlternarPagina(6)
3782:         loc_oGrid.SetFocus()
3783:     ENDPROC
3784: 
3785:     *--------------------------------------------------------------------------
3786:     * BtnAlteraqtdClick - transcricao de Page1.Alteraqtd.Click (dump
3787:     * 7180-7204): autoriza UMA edicao da coluna "Produzir Estq" via dialogo
3788:     * de senha de risco (SigOpSen, "PRDZRISCO"). SigOpSen NAO foi migrado
3789:     * (ver feedback_sigopsen_ausente_gate_autorizacao) - gate de
3790:     * AUTORIZACAO tratado FAIL-CLOSED: dialogo indisponivel = NAO
3791:     * autorizado, nunca MsgConfirma/skip.
3792:     *--------------------------------------------------------------------------
3793:     PROCEDURE BtnAlteraqtdClick()
3794:         LOCAL loc_cString, loc_cRetorno, loc_lOk, loc_oErro
3795: 
3796:         IF !USED("TmpFinalg") OR EOF("TmpFinalg") OR TmpFinalg.Produzir2 = 0
3797:             MsgAviso("Refer" + CHR(234) + "ncia Sem Quantidade a Produzir para Estoque!!!", "Aten" + CHR(231) + CHR(227) + "o")
3798:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3799:             RETURN
3800:         ENDIF
3801: 
3802:         loc_cString = ALLTRIM(TmpFinalg.Cpros) + " Qt.Min:" + ALLTRIM(TRANSFORM(TmpFinalg.QtdMins, "@Z 99999.999")) + ;
3803:             " Qt.Est:" + ALLTRIM(TRANSFORM(TmpFinalg.Produzir2, "@Z 99999.999"))
3804: 
3805:         loc_cRetorno = ""
3806:         loc_lOk = .F.
3807:         TRY
3808:             DO FORM SigOpSen WITH "PRDZRISCO", loc_cString, "" TO loc_cRetorno
3809:             loc_lOk = (LEFT(TratarNulo(loc_cRetorno, ""), 1) = "*")
3810:         CATCH TO loc_oErro
3811:             MsgErro("Dialogo de autoriza" + CHR(231) + CHR(227) + "o (SigOpSen) indispon" + CHR(237) + "vel - " + ;
3812:                 "altera" + CHR(231) + CHR(227) + "o N" + CHR(195) + "O autorizada." + CHR(13) + loc_oErro.Message, ;
3813:                 "Erro de Autoriza" + CHR(231) + CHR(227) + "o")
3814:             loc_lOk = .F.
3815:         ENDTRY
3816: 
3817:         IF !loc_lOk
3818:             MsgAviso("Altera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o autorizada!!!", "Aten" + CHR(231) + CHR(227) + "o")
3819:         ELSE
3820:             REPLACE TmpFinalg.UsuLibs WITH PADR(SUBSTR(loc_cRetorno, 2), 10) IN TmpFinalg
3821:             THIS.this_lLiberadoAlteracao = .T.
3822:             THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.ReadOnly = .F.
3823:         ENDIF
3824:         THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.SetFocus()
3825:     ENDPROC
3826: 
3827:     *--------------------------------------------------------------------------
3828:     * BOParaForm - leva para a tela o que o Init legado lia dos cursores de
3829:     * parametro do sistema (crSigCdPam/CrSigCdPac), hoje carregados uma
3830:     * unica vez em SigPrGlxBO.Init:
3831:     *
3832:     *   Thisform.SigKey = CrSigCdPac.sigKeys                 -> BO.this_cSigKey
3833:     *   lab_periodo.Caption = 'Periodo: '+Alltrim(Str(
3834:     *       CrSigCdPac.nMeses,2))+' meses'                   -> BO.this_nPacNMeses
3835:     *   Pedras.Visible = .f.                                 -> BO.this_cPamDop*
3836:     *   If Not Empty(crSigCdPam.DopEmphs) And Not Empty(DopReqcs)
3837:     *      And Not Empty(DopPedcs) And Not Empty(DopComps)
3838:     *      And Not ThisForm.Reserva -> Pedras.Visible = .t.
3839:     *   SelEstoque.Visible (fChecaAcesso SIGPRGLO/PRIORIDADE)
3840:     *   Caption / lblSombra / lblTitulo (modo Reserva x Globalizacao)
3841:     *
3842:     * PROTECTED EXPLICITO: FormBase ja declara BOParaForm como PROTECTED e
3843:     * o VFP9 nao deixa a subclasse ALARGAR o escopo - omitir o modificador
3844:     * mentiria para quem le, porque o metodo continua protegido.
3845:     *--------------------------------------------------------------------------
3846:     PROTECTED PROCEDURE BOParaForm()
3847:         LOCAL loc_oBO, loc_oPag1, loc_lTemPedras, loc_oErro
3848: 
3849:         TRY
3850:             loc_oBO   = THIS.this_oBusinessObject
3851:             loc_oPag1 = THIS.pgf_4c_1.Page1
3852: 
3853:             *-- Titulo da tela e os dois labels da faixa do cabecalho
3854:             THIS.Caption = IIF(THIS.this_lReservaAuto, ;
3855:                 "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica", ;
3856:                 "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o")
3857:             THIS.this_cTituloForm = THIS.Caption
3858:             loc_oPag1.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
3859:             loc_oPag1.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
3860: 
3861:             IF VARTYPE(loc_oBO) = "O"
3862:                 *-- "Periodo: NN meses" (SigCdPac.nmeses). O legado monta o
3863:                 *-- rotulo INTEIRO aqui; o Caption posto em
3864:                 *-- ConfigurarPaginaLista eh so o texto base de projeto.
3865:                 loc_oPag1.cnt_4c_Container5.lbl_4c_LabPeriodo.Caption = ;
3866:                     "Per" + CHR(237) + "odo: " + ALLTRIM(STR(loc_oBO.this_nPacNMeses, 2)) + " meses"
3867: 
3868:                 *-- "Requisicoes" (cmd_4c_Pedras): so com as QUATRO operacoes
3869:                 *-- de requisicao configuradas em SigCdPam e fora do modo
3870:                 *-- Reserva.
3871:                 loc_lTemPedras = !EMPTY(loc_oBO.this_cPamDopEmphs) AND ;
3872:                                  !EMPTY(loc_oBO.this_cPamDopReqcs) AND ;
3873:                                  !EMPTY(loc_oBO.this_cPamDopPedcs) AND ;
3874:                                  !EMPTY(loc_oBO.this_cPamDopComps) AND ;
3875:                                  !THIS.this_lReservaAuto
3876:                 loc_oPag1.cmd_4c_Pedras.Visible = loc_lTemPedras
3877:             ELSE
3878:                 loc_oPag1.cmd_4c_Pedras.Visible = .F.
3879:             ENDIF
3880: 
3881:             *-- "Estoques" (cmd_4c_SelEstoque): mesma condicao de acesso que
3882:             *-- libera a coluna Prior das grades de resumo.
3883:             loc_oPag1.cmd_4c_SelEstoque.Visible = THIS.this_lPermiteAjustarPrioridade()
3884: 
3885:             *-- "Disponiveis" (cmd_4c_Disponivel) nasce oculto e eh decidido
3886:             *-- por item em AtualizarVisibilidadeDisponivel().
3887:             loc_oPag1.cmd_4c_Disponivel.Visible = .F.
3888:         CATCH TO loc_oErro
3889:             MsgErro(loc_oErro.Message + CHR(13) + ;
3890:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3891:                 "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
3892:         ENDTRY
3893:     ENDPROC
3894: 
3895:     *--------------------------------------------------------------------------
3896:     * CarregarLista - (re)liga a grade principal da Page1 ao cursor
3897:     * TmpFinalg e deixa a tela no estado em que o Init legado a entregava:
3898:     *
3899:     *   With ThisForm.PageDados.page1.GradeItens -> RecordSource/ControlSource
3900:     *   Select TmpSaldG / Set Order To Cpros / Set Key To TmpFinalg.Cpros+
3901:     *       CodCors+CodTams / Go Top          (filtro relacional por item)
3902:     *   Select TmpFabr  / idem
3903:     *   Select TmpFinalg / Sum ... / Tot_* .Value / .Refresh
3904:     *   ThisForm.pageDados.Page1.GradeItens.Setfocus
3905:     *
3906:     * Por que REBIND e nao so Refresh: TmpFinalg/TmpFinal/TmpSaldG/TmpFabr
3907:     * sao criados por FormSigPrGl2BO.ExecutarProcessamento na data session
3908:     * do form PAI (assumida no Init). Quando o pai reprocessa, o alias eh
3909:     * fisicamente RECRIADO e o Grid perde RecordSource/ControlSource,
3910:     * Header1.Caption, Width e ReadOnly (regra #43.1 do CLAUDE.md) - a
3911:     * grade viraria "Column1/Column2" generica e editavel. Por isso a
3912:     * reconfiguracao completa, na ordem ColumnCount -> RecordSource ->
3913:     * ControlSource -> Width -> Header1.Caption -> ReadOnly (regra #41).
3914:     *
3915:     * Fecha com GO TOP + Refresh (regra #21a: popular/religar cursor NAO
3916:     * repinta a grade sozinho).
3917:     *
3918:     * PUBLIC (nao PROTECTED): CarregarLista nao existe em FormBase e o
3919:     * harness de teste automatizado chama THIS.oForm.CarregarLista() direto
3920:     * de fora da classe (regra #3 do CLAUDE.md).
3921:     *--------------------------------------------------------------------------
3922:     PROCEDURE CarregarLista()
3923:         LOCAL loc_lSucesso, loc_oGrid, loc_oErro
3924:         loc_lSucesso = .F.
3925: 
3926:         TRY
3927:             IF !USED("TmpFinalg")
3928:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados de globaliza" + CHR(231) + CHR(227) + ;
3929:                     "o para exibir - reprocesse a gera" + CHR(231) + CHR(227) + "o de O.P.", ;
3930:                     "Aten" + CHR(231) + CHR(227) + "o")
3931:             ELSE
3932:                 loc_oGrid = THIS.pgf_4c_1.Page1.grd_4c_Dados
3933: 
3934:                 WITH loc_oGrid
3935:                     .RecordSource = ""
3936:                     .ColumnCount  = 10
3937:                     .RecordSource = "TmpFinalg"
3938: 
3939:                     .Column1.ControlSource  = "TmpFinalg.Cpros"
3940:                     .Column2.ControlSource  = "TmpFinalg.CodCors"
3941:                     .Column3.ControlSource  = "TmpFinalg.Flag"
3942:                     .Column4.ControlSource  = "TmpFinalg.Qtds"
3943:                     .Column5.ControlSource  = "TmpFinalg.Saldo"
3944:                     .Column6.ControlSource  = "TmpFinalg.Produzir"
3945:                     .Column7.ControlSource  = "TmpFinalg.Fabrs"
3946:                     .Column8.ControlSource  = "TmpFinalg.Produzir2"
3947:                     .Column9.ControlSource  = "TmpFinalg.CodTams"
3948:                     .Column10.ControlSource = "TmpFinalg.Estoque"
3949: 
3950:                     *-- Width DEPOIS do RecordSource/ControlSource: reatribuir
3951:                     *-- a fonte do Grid recalcula toda largura para o default.
3952:                     .Column1.Width  = 90
3953:                     .Column2.Width  = 50
3954:                     .Column3.Width  = 30
3955:                     .Column4.Width  = 60
3956:                     .Column5.Width  = 70
3957:                     .Column6.Width  = 70
3958:                     .Column7.Width  = 80
3959:                     .Column8.Width  = 80
3960:                     .Column9.Width  = 40
3961:                     .Column10.Width = 76
3962: 
3963:                     .Column1.Header1.Caption  = "Produto"
3964:                     .Column2.Header1.Caption  = "Cor"
3965:                     .Column3.Header1.Caption  = ""
3966:                     .Column4.Header1.Caption  = "N" + CHR(250) + "mero"
3967:                     .Column5.Header1.Caption  = "Qtde Pedido"
3968:                     .Column6.Header1.Caption  = "Produzir"

*-- Linhas 4025 a 4149:
4025:         CATCH TO loc_oErro
4026:             MsgErro(loc_oErro.Message + CHR(13) + ;
4027:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4028:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
4029:             loc_lSucesso = .F.
4030:         ENDTRY
4031: 
4032:         RETURN loc_lSucesso
4033:     ENDPROC
4034: 
4035:     *--------------------------------------------------------------------------
4036:     * FormParaBO - repassa a Processar() os dois campos que o Init legado
4037:     * lia do form AVO (_Prev/_DtGera = ThisForm.ParentForm.ParentForm.
4038:     * Cnt_Previsao.GetPrevisao/GetGeracao). THIS.this_oFormPai eh o
4039:     * FormSigPrGl2 (pai direto); THIS.this_oFormPai.this_oParentForm eh o
4040:     * FormSigPrGlo (avo, "Processamento de O.P."). Mesmo padrao ja adotado
4041:     * em FormSigPrGlp.FormParaBO.
4042:     *--------------------------------------------------------------------------
4043:     PROTECTED FUNCTION FormParaBO()
4044:         LOCAL loc_lSucesso, loc_oGlo, loc_oErro
4045:         loc_lSucesso = .F.
4046: 
4047:         TRY
4048:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
4049:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
4050:             ELSE
4051:                 loc_oGlo = .NULL.
4052:                 IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "this_oParentForm", 5)
4053:                     IF VARTYPE(THIS.this_oFormPai.this_oParentForm) = "O"
4054:                         loc_oGlo = THIS.this_oFormPai.this_oParentForm
4055:                     ENDIF
4056:                 ENDIF
4057: 
4058:                 IF VARTYPE(loc_oGlo) = "O" AND PEMSTATUS(loc_oGlo, "cnt_4c_Previsao", 5)
4059:                     THIS.this_oBusinessObject.this_dPrevisao    = ;
4060:                         ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Previsao.Value)
4061:                     THIS.this_oBusinessObject.this_dDataGeracao = ;
4062:                         ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Geracao.Value)
4063:                 ELSE
4064:                     *-- Sem o form avo (ex.: teste direto desta tela), usa a
4065:                     *-- data de hoje para ambos - nunca deixa {} (gravaria
4066:                     *-- a O.P. com data em branco)
4067:                     THIS.this_oBusinessObject.this_dPrevisao    = DATE()
4068:                     THIS.this_oBusinessObject.this_dDataGeracao = DATE()
4069:                 ENDIF
4070: 
4071:                 loc_lSucesso = .T.
4072:             ENDIF
4073:         CATCH TO loc_oErro
4074:             MsgErro(loc_oErro.Message + CHR(13) + ;
4075:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4076:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
4077:         ENDTRY
4078: 
4079:         RETURN loc_lSucesso
4080:     ENDFUNC
4081: 
4082:     *--------------------------------------------------------------------------
4083:     * BtnProcessarClick - "Processar" da Page1 (dump 4562-6466). So
4084:     * ORQUESTRA: repassa ao BO os parametros que o Init legado lia do form
4085:     * avo (FormParaBO) e delega toda a gravacao a SigPrGlxBO.Processar().
4086:     * "Do Form SigReGli" do fecho legado NAO foi migrado - mostra o numero
4087:     * da O.P. via MsgInfo e fecha esta tela, mesmo padrao de
4088:     * FormSigPrGlp.BtnProcessarClick.
4089:     *--------------------------------------------------------------------------
4090:     PROCEDURE BtnProcessarClick()
4091:         LOCAL loc_lSucesso, loc_lFechar, loc_oErro
4092:         loc_lFechar = .F.
4093: 
4094:         TRY
4095:             IF !USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
4096:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens para processar.", "Aten" + CHR(231) + CHR(227) + "o")
4097:             ELSE
4098:                 IF THIS.FormParaBO()
4099:                     THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled    = .F.
4100:                     THIS.pgf_4c_1.Page1.cmd_4c_SelEstoque.Enabled   = .F.
4101:                     THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Enabled   = .F.
4102:                     THIS.pgf_4c_1.Page1.cmd_4c_TotLinha.Enabled     = .F.
4103: 
4104:                     loc_lSucesso = THIS.this_oBusinessObject.Processar()
4105: 
4106:                     IF loc_lSucesso
4107:                         MsgInfo("Processamento efetuado com sucesso!" + CHR(13) + ;
4108:                             "O.P. " + TRANSFORM(THIS.this_oBusinessObject.this_nNumeroOpGerada) + ;
4109:                             " gerada.", "Confirmar")
4110:                         loc_lFechar = .T.
4111:                     ELSE
4112:                         THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled  = .T.
4113:                         THIS.pgf_4c_1.Page1.cmd_4c_SelEstoque.Enabled = THIS.this_lPermiteAjustarPrioridade()
4114:                         THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Enabled = .T.
4115:                         THIS.pgf_4c_1.Page1.cmd_4c_TotLinha.Enabled   = .T.
4116: 
4117:                         IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
4118:                             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Processar")
4119:                         ENDIF
4120:                     ENDIF
4121:                 ENDIF
4122:             ENDIF
4123:         CATCH TO loc_oErro
4124:             MsgErro(loc_oErro.Message + CHR(13) + ;
4125:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4126:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
4127:         ENDTRY
4128: 
4129:         IF loc_lFechar
4130:             THIS.Release()
4131:         ENDIF
4132:     ENDPROC
4133: 
4134:     *--------------------------------------------------------------------------
4135:     * Destroy - reabilita o form pai (padrao do Cancelar.Click legado: a
4136:     * previa eh modeless-sobre-pai, nao modal de verdade, entao quem fecha
4137:     * precisa devolver o Enabled do pai manualmente).
4138:     *--------------------------------------------------------------------------
4139:     PROCEDURE Destroy()
4140:         IF VARTYPE(THIS.this_oFormPai) = "O"
4141:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
4142:                 THIS.this_oFormPai.Enabled = .T.
4143:             ENDIF
4144:         ENDIF
4145: 
4146:         DODEFAULT()
4147:     ENDPROC
4148: 
4149: ENDDEFINE

