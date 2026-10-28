# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (17)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.VerificarAcessoConta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExigirChequeSelecionado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Protocolo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ENDFOR define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDFOR.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrade.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrade.RecordSource).
- [NAVEGACAO-PAGINA] Metodo 'InicializarForm' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'FormatarBotoesHistorico' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'BtnEncerrarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [LAYOUT-POSITION] Controle 'optFiltro' (parent: SIGOPCHI.Pagina.Filtro.Origem): Left original=282 vs migrado 'obj_4c_OptFiltro' Left=5 (diff=277px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpChi.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4064 linhas total):

*-- Linhas 9 a 53:
9: * (grades de cheque, movimentacao e prorrogacoes, followup e navegacao para
10: * os formularios de detalhe SigOpChr/SigOpChb/SigOpChp/SigOpFlp/SigOpChc).
11: *
12: * Fase 3: estrutura base (heranca, Init, InicializarForm, PageFrame,
13: * containers de cabecalho vazios, labels de cabecalho, TornarControlesVisiveis,
14: * Destroy).
15: * Fase 4: grades do Historico (grd_4c_Cheque/Movimenta/Prorrog), botoes CRUD/
16: * acao (cmg_4c_Botoes/cmg_4c_Saida), CarregarDados (SqlDados legado) e
17: * AlternarPagina.
18: * Fase 5: campos restantes da Page2/Historico - Cnt_periodo (filtro de
19: * vencimento), Cnt_Followup (ultimo followup, so-leitura) e o container
20: * Emitente (filtro por conta do emitente, com os tres lookups de SigCdCli -
21: * mesmo padrao do container Origem da Page1). Os 8 botoes de cmg_4c_Botoes
22: * (Relatorio/Busca/Prorroga/FollowUp/Carteira/Protocolo/Movimento/FollowUp
23: * Cheque) e o AfterRowColChange de grd_4c_Cheque ficam para a fase de acoes.
24: *==============================================================================
25: 
26: DEFINE CLASS FormSigOpChi AS FormBase
27: 
28:     *-- Propriedades visuais (PILAR 1 - copiadas do SCX original SIGOPCHI)
29:     Width        = 1000
30:     Height       = 600
31:     DataSession  = 2
32:     BorderStyle  = 2
33:     AutoCenter   = .T.
34:     Caption      = "Hist" + CHR(243) + "rico de Cheques"
35:     ControlBox   = .F.
36:     Closable     = .F.
37:     MaxButton    = .F.
38:     MinButton    = .F.
39:     ClipControls = .F.
40:     KeyPreview   = .T.
41:     TitleBar     = 0
42:     ZoomBox      = .T.
43:     Themes       = .F.
44:     ShowWindow   = 1
45:     WindowType   = 1
46: 
47:     *-- Business Object
48:     this_oBusinessObject = .NULL.
49: 
50:     *-- Espelho do "ThisForm.Acesso" do legado - .T. quando pcAcesso eh
51:     *-- 'TOTAL' ou 'CARTEIRA' (acesso irrestrito as contas do historico)
52:     this_lAcesso = .T.
53: 

*-- Linhas 78 a 127:
78:     * Init - Equivalente a:
79:     * LParameters pAcesso, lcNomeFrm1, pBancos, pAgencias, pNContas, pNCheques, pVencs
80:     *--------------------------------------------------------------------------
81:     PROCEDURE Init(par_cAcesso, par_cNomeFrm1, par_cBancos, par_cAgencias, ;
82:                    par_cNContas, par_cNCheques, par_dVencs)
83:         LOCAL loc_lSucesso, loc_oErro
84:         loc_lSucesso = .F.
85: 
86:         TRY
87:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpChiBO")
88: 
89:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
90:                 MsgErro("Erro ao criar SigOpChiBO." + CHR(13) + ;
91:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "FormSigOpChi.Init")
92:             ELSE
93:                 IF VARTYPE(par_cAcesso) = "C" AND !EMPTY(par_cAcesso)
94:                     THIS.this_oBusinessObject.this_cAcesso = par_cAcesso
95:                 ENDIF
96:                 THIS.this_lAcesso = INLIST(THIS.this_oBusinessObject.this_cAcesso, "TOTAL", "CARTEIRA")
97:                 THIS.this_oBusinessObject.this_lAcesso = THIS.this_lAcesso
98: 
99:                 IF VARTYPE(par_cNomeFrm1) = "C"
100:                     THIS.this_cNomeFrmChamador = par_cNomeFrm1
101:                 ENDIF
102:                 IF VARTYPE(par_cBancos) = "C"
103:                     THIS.this_cParamBancos = ALLTRIM(par_cBancos)
104:                 ENDIF
105:                 IF VARTYPE(par_cAgencias) = "C"
106:                     THIS.this_cParamAgencias = ALLTRIM(par_cAgencias)
107:                 ENDIF
108:                 IF VARTYPE(par_cNContas) = "C"
109:                     THIS.this_cParamNContas = ALLTRIM(par_cNContas)
110:                 ENDIF
111:                 IF VARTYPE(par_cNCheques) = "C"
112:                     THIS.this_cParamNCheques = ALLTRIM(par_cNCheques)
113:                 ENDIF
114:                 IF VARTYPE(par_dVencs) = "D" OR VARTYPE(par_dVencs) = "T"
115:                     THIS.this_dParamVencs = ConverterParaData(par_dVencs)
116:                 ENDIF
117: 
118:                 *-- Periodo de vencimento default. Transcrito do Init legado:
119:                 *--   .Cnt_periodo.Dt_inicial.Value = IIF(pcAcesso='CARTEIRA', pcVencs, Date())
120:                 *--   .Cnt_periodo.Dt_Final.Value   = IIF(pcAcesso='CARTEIRA', pcVencs,
121:                 *--                                       CTOD('31/12/'+ALLTRIM(STR(YEAR(DATE())))))
122:                 *-- No acesso CARTEIRA o periodo colapsa no vencimento do cheque
123:                 *-- recebido, porque a consulta eh de UM cheque especifico.
124:                 *-- Os TextBox Dt_inicial/Dt_final espelham estas duas
125:                 *-- propriedades do BO, que sao a fonte unica do periodo.
126:                 IF ALLTRIM(UPPER(THIS.this_oBusinessObject.this_cAcesso)) == "CARTEIRA" ;
127:                         AND !EMPTY(THIS.this_dParamVencs)

*-- Linhas 133 a 359:
133:                         CTOD("31/12/" + ALLTRIM(STR(YEAR(DATE()))))
134:                 ENDIF
135: 
136:                 *-- DODEFAULT() dispara FormBase.Init() -> THIS.InicializarForm()
137:                 *-- Tambem aciona SET DATE TO BRITISH + SET CENTURY ON (DataSession=2)
138:                 loc_lSucesso = DODEFAULT()
139:             ENDIF
140:         CATCH TO loc_oErro
141:             MsgErro(loc_oErro.Message + CHR(13) + ;
142:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
143:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.Init")
144:         ENDTRY
145: 
146:         RETURN loc_lSucesso
147:     ENDPROC
148: 
149:     *--------------------------------------------------------------------------
150:     * KeyPress - Transcricao literal do KeyPress legado (KeyPreview = .T.,
151:     * ja declarado nas propriedades do form): F3/F4/F5/F6/F7/F8/F9/F11 so
152:     * atuam na Pagina 2 (Historico) e delegam para os mesmos metodos dos
153:     * botoes de cmg_4c_Botoes. Os codigos negativos (-2..-8) sao os valores
154:     * que o VFP9 entrega em Form.KeyPress para F3..F9 quando KeyPreview esta
155:     * ligado; F11 chega como 133 (idem legado).
156:     *--------------------------------------------------------------------------
157:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
158:         LOCAL loc_nPagina
159:         loc_nPagina = THIS.pgf_4c_Paginas.ActivePage
160: 
161:         DO CASE
162:             CASE par_nKeyCode = -2 AND loc_nPagina = 2 && <F3> FollowUp Cheque
163:                 NODEFAULT
164:                 THIS.AcaoFollowUpChqClick()
165: 
166:             CASE par_nKeyCode = -3 AND loc_nPagina = 2 && <F4> Documento
167:                 NODEFAULT
168:                 THIS.AcaoDocumentoClick()
169: 
170:             CASE par_nKeyCode = -4 AND loc_nPagina = 2 && <F5> Procurar
171:                 NODEFAULT
172:                 THIS.AcaoProcurarClick()
173: 
174:             CASE par_nKeyCode = -5 AND loc_nPagina = 2 && <F6> Relatorio
175:                 NODEFAULT
176:                 THIS.AcaoRelatorioClick()
177: 
178:             CASE par_nKeyCode = -6 AND loc_nPagina = 2 && <F7> Prorrogar
179:                 NODEFAULT
180:                 THIS.AcaoProrrogaClick()
181: 
182:             CASE par_nKeyCode = -7 AND loc_nPagina = 2 && <F8> FollowUp Cliente
183:                 NODEFAULT
184:                 THIS.AcaoFollowUpClick()
185: 
186:             CASE par_nKeyCode = -8 AND loc_nPagina = 2 && <F9> Protocolo
187:                 NODEFAULT
188:                 THIS.AcaoProtocoloClick()
189: 
190:             CASE par_nKeyCode = 133 AND loc_nPagina = 2 && <F11> Carteira
191:                 NODEFAULT
192:                 THIS.AcaoCarteiraClick()
193:         ENDCASE
194:     ENDPROC
195: 
196:     *--------------------------------------------------------------------------
197:     * InicializarForm - Monta a estrutura visual base do form
198:     * (chamado por FormBase.Init via DODEFAULT)
199:     *--------------------------------------------------------------------------
200:     PROTECTED PROCEDURE InicializarForm()
201:         LOCAL loc_lSucesso, loc_oErro
202:         loc_lSucesso = .F.
203: 
204:         TRY
205:             THIS.ConfigurarPageFrame()
206:             THIS.ConfigurarContainersBase()
207:             THIS.ConfigurarPaginaFiltro()
208:             THIS.ConfigurarPaginaHistorico()
209:             THIS.ConfigurarGradesHistorico()
210:             THIS.ConfigurarBotoesHistorico()
211:             THIS.ConfigurarCursorProtocolo()
212: 
213:             THIS.pgf_4c_Paginas.Visible = .T.
214: 
215:             THIS.TornarControlesVisiveis(THIS)
216: 
217:             *-- Espelha o BO na tela (periodo default resolvido no Init, campos
218:             *-- de Origem/Emitente e Caption) e aplica a cascata dos PROCEDURE
219:             *-- When do legado. TornarControlesVisiveis ja rodou, entao nenhum
220:             *-- Visible declarado aqui eh sobrescrito depois.
221:             THIS.BOParaForm()
222: 
223:             *-- Transcrito do Init legado: com acesso TOTAL/CARTEIRA a tela abre
224:             *-- direto no Historico e ja carrega os dados ("If ThisForm.Acesso
225:             *-- ... .ActivePage = 2 / ThisForm.SqlDados"); sem acesso irrestrito
226:             *-- abre no Filtro, exigindo que o usuario informe a conta
227:             *-- ("Else / ThisForm.Pagina.Filtro.Origem.Get_conta.Setfocus").
228:             *-- ActivePage eh trocada DEPOIS de TornarControlesVisiveis para que
229:             *-- as grades sejam repintadas com a pagina ja visivel.
230:             THIS.AlternarPagina(IIF(THIS.this_lAcesso, 2, 1))
231: 
232:             loc_lSucesso = .T.
233:         CATCH TO loc_oErro
234:             MsgErro(loc_oErro.Message + CHR(13) + ;
235:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
236:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.InicializarForm")
237:         ENDTRY
238: 
239:         RETURN loc_lSucesso
240:     ENDPROC
241: 
242:     *--------------------------------------------------------------------------
243:     * ConfigurarPageFrame - PageFrame com Page1 (Filtro) e Page2 (Historico)
244:     * Tabs ocultas (Top=-29 / Tabs=.F.) - controles internos recebem a
245:     * compensacao +29 quando adicionados nas proximas fases
246:     *--------------------------------------------------------------------------
247:     PROTECTED PROCEDURE ConfigurarPageFrame()
248:         LOCAL loc_oErro
249:         TRY
250:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
251:             WITH THIS.pgf_4c_Paginas
252:                 .Top         = -29
253:                 .Left        = 0
254:                 .Width       = THIS.Width
255:                 .Height      = THIS.Height + 29
256:                 .PageCount   = 2
257:                 .Tabs        = .F.
258:                 .BorderWidth = 0
259: 
260:                 .Page1.Caption = "Filtro"
261:                 .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
262: 
263:                 .Page2.Caption = "Hist" + CHR(243) + "rico"
264:                 .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
265:                 .Page2.Enabled = .F.
266:             ENDWITH
267:         CATCH TO loc_oErro
268:             MsgErro(loc_oErro.Message + CHR(13) + ;
269:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
270:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPageFrame")
271:         ENDTRY
272:     ENDPROC
273: 
274:     *--------------------------------------------------------------------------
275:     * ConfigurarContainersBase - Cria o container de cabecalho (faixa cinza)
276:     * em cada Page. E o PRIMEIRO AddObject de cada pagina, para que os
277:     * controles adicionados depois desenhem por cima dele.
278:     *--------------------------------------------------------------------------
279:     PROTECTED PROCEDURE ConfigurarContainersBase()
280:         LOCAL loc_oPag1, loc_oPag2, loc_oErro
281:         TRY
282:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
283:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
284: 
285:             loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
286:             WITH loc_oPag1.cnt_4c_Cabecalho
287:                 .Top         = 0 + 29
288:                 .Left        = 0
289:                 .Width       = THIS.Width
290:                 .Height      = 80
291:                 .BorderWidth = 0
292:                 .BackStyle   = 1
293:                 .BackColor   = RGB(100, 100, 100)
294:                 .Visible     = .T.
295:             ENDWITH
296: 
297:             loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
298:             WITH loc_oPag2.cnt_4c_Cabecalho
299:                 .Top         = 0 + 29
300:                 .Left        = 0
301:                 .Width       = THIS.Width
302:                 .Height      = 80
303:                 .BorderWidth = 0
304:                 .BackStyle   = 1
305:                 .BackColor   = RGB(100, 100, 100)
306:                 .Visible     = .T.
307:             ENDWITH
308:         CATCH TO loc_oErro
309:             MsgErro(loc_oErro.Message + CHR(13) + ;
310:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
311:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarContainersBase")
312:         ENDTRY
313:     ENDPROC
314: 
315:     *--------------------------------------------------------------------------
316:     * ConfigurarPaginaFiltro - Preenche o cabecalho da Page1 (Filtro) com
317:     * o titulo do formulario (lbl_4c_Sombra atras, lbl_4c_Titulo na frente)
318:     *--------------------------------------------------------------------------
319:     PROTECTED PROCEDURE ConfigurarPaginaFiltro()
320:         LOCAL loc_oCab, loc_oPag1, loc_oErro
321:         TRY
322:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
323:             loc_oCab  = loc_oPag1.cnt_4c_Cabecalho
324: 
325:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
326:             WITH loc_oCab.lbl_4c_Sombra
327:                 .AutoSize  = .F.
328:                 .FontBold  = .T.
329:                 .FontName  = "Tahoma"
330:                 .FontSize  = 18
331:                 .BackStyle = 0
332:                 .Alignment = 0
333:                 .Caption   = THIS.Caption
334:                 .Height    = 40
335:                 .Left      = 10
336:                 .Top       = 18
337:                 .Width     = THIS.Width - 20
338:                 .ForeColor = RGB(0, 0, 0)
339:             ENDWITH
340: 
341:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
342:             WITH loc_oCab.lbl_4c_Titulo
343:                 .AutoSize  = .F.
344:                 .FontBold  = .T.
345:                 .FontName  = "Tahoma"
346:                 .FontSize  = 18
347:                 .BackStyle = 0
348:                 .Alignment = 0
349:                 .Caption   = THIS.Caption
350:                 .Height    = 46
351:                 .Left      = 10
352:                 .Top       = 17
353:                 .Width     = THIS.Width - 20
354:                 .ForeColor = RGB(255, 255, 255)
355:             ENDWITH
356: 
357:             *-- Shape1 (decorativo, sem preenchimento nem borda no SCX legado;
358:             *-- BorderColor transcrito do dump, inerte com BorderStyle = 0)
359:             loc_oPag1.AddObject("shp_4c_Shape1", "Shape")

*-- Linhas 372 a 424:
372:         CATCH TO loc_oErro
373:             MsgErro(loc_oErro.Message + CHR(13) + ;
374:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
375:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPaginaFiltro")
376:         ENDTRY
377:     ENDPROC
378: 
379:     *--------------------------------------------------------------------------
380:     * ConfigurarOrigemFiltro - Container "Origem" da Page1: conta, CPF/CNPJ e
381:     * nome do cliente de origem (ou filtro geral, via optFiltro), com os tres
382:     * lookups ligados por SigCdCli.Iclis/Rclis/Cpfs
383:     *--------------------------------------------------------------------------
384:     PROTECTED PROCEDURE ConfigurarOrigemFiltro(par_oPagina)
385:         LOCAL loc_oOrig, loc_oErro
386:         TRY
387:             par_oPagina.AddObject("cnt_4c_Origem", "Container")
388:             WITH par_oPagina.cnt_4c_Origem
389:                 .Top         = 277 + 29
390:                 .Left        = 230
391:                 .Width       = 539
392:                 .Height      = 50
393:                 .BackStyle   = 0
394:                 .BorderWidth = 1
395:                 .BorderColor = RGB(90, 90, 90)
396:                 .TabIndex    = 1
397:                 .Visible     = .T.
398:             ENDWITH
399:             loc_oOrig = par_oPagina.cnt_4c_Origem
400: 
401:             loc_oOrig.AddObject("lbl_4c_Label2", "Label")
402:             WITH loc_oOrig.lbl_4c_Label2
403:                 .AutoSize  = .F.
404:                 .BackStyle = 0
405:                 .Alignment = 0
406:                 .FontSize  = 8
407:                 .Caption   = "Conta"
408:                 .Left      = 5
409:                 .Top       = 4
410:                 .Width     = 60
411:                 .Height    = 14
412:                 .ForeColor = RGB(90, 90, 90)
413:                 .TabIndex  = 1
414:             ENDWITH
415: 
416:             loc_oOrig.AddObject("lbl_4c__CPF", "Label")
417:             WITH loc_oOrig.lbl_4c__CPF
418:                 .AutoSize  = .F.
419:                 .BackStyle = 0
420:                 .Alignment = 0
421:                 .FontSize  = 8
422:                 .Caption   = "CPF / CNPJ"
423:                 .Left      = 90
424:                 .Top       = 4

*-- Linhas 486 a 702:
486:                 .TabIndex      = 6
487:             ENDWITH
488: 
489:             loc_oOrig.AddObject("obj_4c_OptFiltro", "OptionGroup")
490:             WITH loc_oOrig.obj_4c_OptFiltro
491:                 .ButtonCount = 2
492:                 .Top         = -2
493:                 .Left        = 282
494:                 .Width       = 93
495:                 .Height      = 19
496:                 .BackStyle   = 0
497:                 .Value       = 1
498:                 .TabIndex    = 7
499:                 WITH .Buttons(1)
500:                     .Caption   = "\<Lista"
501:                     .FontName        = "Comic Sans MS"
502:                     .FontSize  = 8
503:                     .Height    = 15
504:                     .Left      = 5
505:                     .Top       = 5
506:                     .Width     = 45
507:                     .Style     = 0
508:                     .BackStyle = 0
509:                 ENDWITH
510:                 WITH .Buttons(2)
511:                     .Caption   = "\<Filtro"
512:                     .FontName        = "Comic Sans MS"
513:                     .FontSize  = 8
514:                     .Height    = 15
515:                     .Left      = 48
516:                     .Top       = 5
517:                     .Width     = 45
518:                     .Style     = 0
519:                     .BackStyle = 0
520:                 ENDWITH
521:             ENDWITH
522: 
523:             BINDEVENT(loc_oOrig.txt_4c__Conta,  "KeyPress", THIS, "ValidarContaOrigem")
524:             BINDEVENT(loc_oOrig.txt_4c__Cpf,     "KeyPress", THIS, "ValidarCpfOrigem")
525:             BINDEVENT(loc_oOrig.txt_4c__DConta,  "KeyPress", THIS, "ValidarNomeOrigem")
526: 
527:             *-- Cascata dos PROCEDURE When do legado (exclusao mutua entre
528:             *-- Conta / CPF / Nome / optFiltro) - reaplicada a cada caractere.
529:             *-- O alvo eh AplicarDependenciaCampos (parametro ZERO) e nao
530:             *-- HabilitarCampos: InteractiveChange nao passa argumento e, em
531:             *-- VFP9, parametro nao passado chega como .F. logico, o que
532:             *-- deixaria a tela inteira somente-leitura
533:             BINDEVENT(loc_oOrig.txt_4c__Conta,  "InteractiveChange", THIS, "AplicarDependenciaCampos")
534:             BINDEVENT(loc_oOrig.txt_4c__Cpf,    "InteractiveChange", THIS, "AplicarDependenciaCampos")
535:             BINDEVENT(loc_oOrig.txt_4c__DConta, "InteractiveChange", THIS, "AplicarDependenciaCampos")
536:         CATCH TO loc_oErro
537:             MsgErro(loc_oErro.Message + CHR(13) + ;
538:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
539:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarOrigemFiltro")
540:         ENDTRY
541:     ENDPROC
542: 
543:     *--------------------------------------------------------------------------
544:     * ConfigurarBotoesFiltro - Botoes "Processar" e "Encerrar" da Page1,
545:     * standalone (sem CommandGroup), posicoes do SCX legado (Top+29)
546:     *--------------------------------------------------------------------------
547:     PROTECTED PROCEDURE ConfigurarBotoesFiltro(par_oPagina)
548:         LOCAL loc_oErro
549:         TRY
550:             par_oPagina.AddObject("cmd_4c_Ok", "CommandButton")
551:             WITH par_oPagina.cmd_4c_Ok
552:                 .Top             = 4 + 29
553:                 .Left            = 849
554:                 .Width           = 75
555:                 .Height          = 75
556:                 .Caption         = "Processar"
557:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
558:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
559:                 .FontName        = "Tahoma"
560:                 .FontBold        = .T.
561:                 .FontItalic      = .T.
562:                 .FontSize        = 8
563:                 .ForeColor       = RGB(90, 90, 90)
564:                 .BackColor       = RGB(255, 255, 255)
565:                 .Themes          = .T.
566:                 .SpecialEffect   = 0
567:                 .PicturePosition = 13
568:                 .MousePointer    = 15
569:                 .WordWrap        = .T.
570:             ENDWITH
571: 
572:             par_oPagina.AddObject("cmd_4c_Cancelar", "CommandButton")
573:             WITH par_oPagina.cmd_4c_Cancelar
574:                 .Top             = 4 + 29
575:                 .Left            = 924
576:                 .Width           = 75
577:                 .Height          = 75
578:                 .Caption         = "Encerrar"
579:                 .Cancel          = .T.
580:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
581:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
582:                 .FontName        = "Tahoma"
583:                 .FontBold        = .T.
584:                 .FontItalic      = .T.
585:                 .FontSize        = 8
586:                 .ForeColor       = RGB(90, 90, 90)
587:                 .BackColor       = RGB(255, 255, 255)
588:                 .Themes          = .T.
589:                 .SpecialEffect   = 0
590:                 .PicturePosition = 13
591:                 .MousePointer    = 15
592:                 .WordWrap        = .T.
593:             ENDWITH
594: 
595:             BINDEVENT(par_oPagina.cmd_4c_Ok,        "Click", THIS, "CmdOkClick")
596:             BINDEVENT(par_oPagina.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
597:         CATCH TO loc_oErro
598:             MsgErro(loc_oErro.Message + CHR(13) + ;
599:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
600:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarBotoesFiltro")
601:         ENDTRY
602:     ENDPROC
603: 
604:     *--------------------------------------------------------------------------
605:     * ConfigurarPaginaHistorico - Preenche o cabecalho da Page2 (Historico)
606:     * com o titulo do formulario (mesmo padrao da Page1)
607:     *--------------------------------------------------------------------------
608:     PROTECTED PROCEDURE ConfigurarPaginaHistorico()
609:         LOCAL loc_oCab, loc_oPag2, loc_oErro
610:         TRY
611:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
612:             loc_oCab  = loc_oPag2.cnt_4c_Cabecalho
613: 
614:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
615:             WITH loc_oCab.lbl_4c_Sombra
616:                 .AutoSize  = .F.
617:                 .FontBold  = .T.
618:                 .FontName  = "Tahoma"
619:                 .FontSize  = 18
620:                 .BackStyle = 0
621:                 .Alignment = 0
622:                 .Caption   = THIS.Caption
623:                 .Height    = 40
624:                 .Left      = 10
625:                 .Top       = 18
626:                 .Width     = THIS.Width - 20
627:                 .ForeColor = RGB(0, 0, 0)
628:             ENDWITH
629: 
630:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
631:             WITH loc_oCab.lbl_4c_Titulo
632:                 .AutoSize  = .F.
633:                 .FontBold  = .T.
634:                 .FontName  = "Tahoma"
635:                 .FontSize  = 18
636:                 .BackStyle = 0
637:                 .Alignment = 0
638:                 .Caption   = THIS.Caption
639:                 .Height    = 46
640:                 .Left      = 10
641:                 .Top       = 17
642:                 .Width     = THIS.Width - 20
643:                 .ForeColor = RGB(255, 255, 255)
644:             ENDWITH
645: 
646:             THIS.ConfigurarPeriodoHistorico(loc_oPag2)
647:             THIS.ConfigurarFollowupHistorico(loc_oPag2)
648:             THIS.ConfigurarEmitenteHistorico(loc_oPag2)
649:         CATCH TO loc_oErro
650:             MsgErro(loc_oErro.Message + CHR(13) + ;
651:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
652:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPaginaHistorico")
653:         ENDTRY
654:     ENDPROC
655: 
656:     *--------------------------------------------------------------------------
657:     * ConfigurarPeriodoHistorico - Container "Cnt_periodo" da Page2: filtro de
658:     * vencimento (Dt_inicial/Dt_final), usado pelos ramos TOTAL/CARTEIRA de
659:     * CarregarDados. Valores iniciais espelham THIS.this_oBusinessObject, ja
660:     * definidos no Init (DATE()/31-12 ou o vencimento unico da CARTEIRA).
661:     *--------------------------------------------------------------------------
662:     PROTECTED PROCEDURE ConfigurarPeriodoHistorico(par_oPagina)
663:         LOCAL loc_oPer, loc_oErro
664:         TRY
665:             par_oPagina.AddObject("cnt_4c__periodo", "Container")
666:             WITH par_oPagina.cnt_4c__periodo
667:                 .Top           = 8 + 29
668:                 .Left          = 647
669:                 .Width         = 230
670:                 .Height        = 67
671:                 .BackStyle     = 1
672:                 .BackColor     = RGB(255, 255, 255)
673:                 .BorderWidth   = 1
674:                 .BorderColor   = RGB(90, 90, 90)
675:                 .SpecialEffect = 1
676:                 .Visible     = .T.
677:             ENDWITH
678:             loc_oPer = par_oPagina.cnt_4c__periodo
679: 
680:             *-- Label1: o dump declara AutoSize = .T., mas AutoSize eh no-op em
681:             *-- Label criado por AddObject (regra #23) - fica .F. com a
682:             *-- Width/Height que o Form Designer calculou (123x15)
683:             loc_oPer.AddObject("lbl_4c_Label1", "Label")
684:             WITH loc_oPer.lbl_4c_Label1
685:                 .AutoSize  = .F.
686:                 .FontBold  = .T.
687:                 .FontName  = "Tahoma"
688:                 .FontSize  = 8
689:                 .BackStyle = 0
690:                 .Alignment = 0
691:                 .Caption   = "Filtro Por Vencimento"
692:                 .Left      = 20
693:                 .Top       = 7
694:                 .Width     = 123
695:                 .Height    = 15
696:                 .ForeColor = RGB(90, 90, 90)
697:                 .TabIndex  = 1
698:             ENDWITH
699: 
700:             loc_oPer.AddObject("lbl_4c_Label2", "Label")
701:             WITH loc_oPer.lbl_4c_Label2
702:                 .AutoSize  = .F.

*-- Linhas 741 a 854:
741:                 .TabIndex      = 7
742:             ENDWITH
743: 
744:             BINDEVENT(loc_oPer.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")
745:             BINDEVENT(loc_oPer.txt_4c_Dt_final,   "KeyPress", THIS, "ValidarDataFinal")
746:         CATCH TO loc_oErro
747:             MsgErro(loc_oErro.Message + CHR(13) + ;
748:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
749:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPeriodoHistorico")
750:         ENDTRY
751:     ENDPROC
752: 
753:     *--------------------------------------------------------------------------
754:     * ValidarDataInicial - KeyPress em txt_4c_Dt_inicial (equivalente ao
755:     * Valid do Dt_inicial legado): se a data inicial ficar depois da final,
756:     * a final eh empurrada para a inicial.
757:     *--------------------------------------------------------------------------
758:     PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
759:         LOCAL loc_oPer, loc_dVal
760: 
761:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
762:             RETURN
763:         ENDIF
764: 
765:         loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
766:         loc_dVal = ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)
767: 
768:         *-- Legado: If This.Value > This.Parent.Dt_final.Value / This.Parent.Dt_Final.Value = This.Value
769:         IF loc_dVal > ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)
770:             loc_oPer.txt_4c_Dt_final.Value = loc_dVal
771:             loc_oPer.txt_4c_Dt_final.Refresh
772:         ENDIF
773: 
774:         THIS.this_oBusinessObject.this_dDataInicial = loc_dVal
775:         THIS.this_oBusinessObject.this_dDataFinal   = ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * ValidarDataFinal - KeyPress em txt_4c_Dt_final (equivalente ao Valid do
780:     * Dt_final legado): se a data final ficar antes da inicial, a inicial eh
781:     * empurrada para a final, e o historico eh recarregado (legado: ThisForm.
782:     * SqlDados). LostFocus do legado (SetFocus na grade) nao tem equivalente
783:     * aqui - navegacao automatica de foco apos ENTER/TAB fica a cargo do VFP.
784:     *--------------------------------------------------------------------------
785:     PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
786:         LOCAL loc_oPer, loc_dVal
787: 
788:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
789:             RETURN
790:         ENDIF
791: 
792:         loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
793:         loc_dVal = ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)
794: 
795:         *-- Legado: If This.Value < This.Parent.Dt_Inicial.Value / This.Parent.Dt_Inicial.Value = This.Value
796:         IF loc_dVal < ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)
797:             loc_oPer.txt_4c_Dt_inicial.Value = loc_dVal
798:             loc_oPer.txt_4c_Dt_inicial.Refresh
799:         ENDIF
800: 
801:         THIS.this_oBusinessObject.this_dDataInicial = ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)
802:         THIS.this_oBusinessObject.this_dDataFinal   = loc_dVal
803: 
804:         *-- Legado: ThisForm.SqlDados. Pelo FUNIL (FormParaBO -> CarregarDados
805:         *-- -> Repintar): popular o cursor nao repinta a grade sozinho
806:         THIS.CarregarLista()
807:     ENDPROC
808: 
809:     *--------------------------------------------------------------------------
810:     * ConfigurarFollowupHistorico - Container "Cnt_Followup" da Page2: exibe
811:     * o ultimo followup do cheque corrente (so-leitura; AfterRowColChange de
812:     * grd_4c_Cheque alimenta this.Value - fase de acoes).
813:     *--------------------------------------------------------------------------
814:     PROTECTED PROCEDURE ConfigurarFollowupHistorico(par_oPagina)
815:         LOCAL loc_oFup, loc_oErro
816:         TRY
817:             par_oPagina.AddObject("cnt_4c__Followup", "Container")
818:             WITH par_oPagina.cnt_4c__Followup
819:                 .Top           = 514 + 29
820:                 .Left          = 10
821:                 .Width         = 558
822:                 .Height        = 27
823:                 .BackStyle     = 1
824:                 .BackColor     = RGB(255, 255, 255)
825:                 .BorderWidth   = 1
826:                 .BorderColor   = RGB(90, 90, 90)
827:                 .SpecialEffect = 1
828:                 .Visible     = .T.
829:             ENDWITH
830:             loc_oFup = par_oPagina.cnt_4c__Followup
831: 
832:             *-- Label1: dump declara AutoSize = .T. (no-op em AddObject, regra
833:             *-- #23) - fica .F. com a Width/Height do SCX (44x15)
834:             loc_oFup.AddObject("lbl_4c_Label1", "Label")
835:             WITH loc_oFup.lbl_4c_Label1
836:                 .AutoSize  = .F.
837:                 .FontName  = "Tahoma"
838:                 .FontSize  = 8
839:                 .BackStyle = 0
840:                 .Alignment = 0
841:                 .Caption   = "Followup"
842:                 .Left      = 8
843:                 .Top       = 6
844:                 .Width     = 44
845:                 .Height    = 15
846:                 .ForeColor = RGB(90, 90, 90)
847:             ENDWITH
848: 
849:             loc_oFup.AddObject("txt_4c_UltFollowup", "TextBox")
850:             WITH loc_oFup.txt_4c_UltFollowup
851:                 .FontName      = "Tahoma"
852:                 .FontSize      = 8
853:                 .Height        = 20
854:                 .Left          = 62

*-- Linhas 864 a 918:
864:         CATCH TO loc_oErro
865:             MsgErro(loc_oErro.Message + CHR(13) + ;
866:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
867:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarFollowupHistorico")
868:         ENDTRY
869:     ENDPROC
870: 
871:     *--------------------------------------------------------------------------
872:     * ConfigurarEmitenteHistorico - Container "Emitente" da Page2: filtro por
873:     * conta do emitente do cheque (usado so no ramo TOTAL de CarregarDados -
874:     * a.ConOrigs/a.Contat). Mesmo padrao de tres campos + tres lookups do
875:     * container Origem da Page1 (regra: so SigCdCli.Iclis/Rclis/Cpfs, sem
876:     * optFiltro - o dump nao tem OptionGroup aqui).
877:     *--------------------------------------------------------------------------
878:     PROTECTED PROCEDURE ConfigurarEmitenteHistorico(par_oPagina)
879:         LOCAL loc_oEmi, loc_oErro
880:         TRY
881:             par_oPagina.AddObject("cnt_4c_Emitente", "Container")
882:             WITH par_oPagina.cnt_4c_Emitente
883:                 .Top         = 543 + 29
884:                 .Left        = 10
885:                 .Width       = 558
886:                 .Height      = 53
887:                 .BackStyle   = 0
888:                 .BorderWidth = 1
889:                 .BorderColor = RGB(90, 90, 90)
890:                 .TabIndex    = 1
891:                 .Visible     = .T.
892:             ENDWITH
893:             loc_oEmi = par_oPagina.cnt_4c_Emitente
894: 
895:             *-- Label1: dump declara AutoSize = .T. (no-op em AddObject, regra
896:             *-- #23) - fica .F. com a Width/Height do SCX (137x15)
897:             loc_oEmi.AddObject("lbl_4c_Label1", "Label")
898:             WITH loc_oEmi.lbl_4c_Label1
899:                 .AutoSize  = .F.
900:                 .FontName  = "Tahoma"
901:                 .FontSize  = 8
902:                 .BackStyle = 0
903:                 .Alignment = 0
904:                 .Caption   = "Filtro por Conta do Emitente"
905:                 .Left      = 5
906:                 .Top       = 0
907:                 .Width     = 137
908:                 .Height    = 15
909:                 .ForeColor = RGB(90, 90, 90)
910:             ENDWITH
911: 
912:             loc_oEmi.AddObject("lbl_4c_Label2", "Label")
913:             WITH loc_oEmi.lbl_4c_Label2
914:                 .AutoSize  = .F.
915:                 .FontName  = "Tahoma"
916:                 .FontSize  = 8
917:                 .BackStyle = 0
918:                 .Alignment = 0

*-- Linhas 1000 a 1056:
1000:                 .TabIndex      = 6
1001:             ENDWITH
1002: 
1003:             BINDEVENT(loc_oEmi.txt_4c__Conta,  "KeyPress", THIS, "ValidarContaEmitente")
1004:             BINDEVENT(loc_oEmi.txt_4c__Cpf,    "KeyPress", THIS, "ValidarCpfEmitente")
1005:             BINDEVENT(loc_oEmi.txt_4c__DConta, "KeyPress", THIS, "ValidarNomeEmitente")
1006: 
1007:             *-- Cascata dos PROCEDURE When do legado neste container (Conta ->
1008:             *-- CPF -> Nome). Mesmo motivo do alvo parametro-zero descrito em
1009:             *-- ConfigurarOrigemFiltro
1010:             BINDEVENT(loc_oEmi.txt_4c__Conta,  "InteractiveChange", THIS, "AplicarDependenciaCampos")
1011:             BINDEVENT(loc_oEmi.txt_4c__Cpf,    "InteractiveChange", THIS, "AplicarDependenciaCampos")
1012:             BINDEVENT(loc_oEmi.txt_4c__DConta, "InteractiveChange", THIS, "AplicarDependenciaCampos")
1013:         CATCH TO loc_oErro
1014:             MsgErro(loc_oErro.Message + CHR(13) + ;
1015:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1016:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarEmitenteHistorico")
1017:         ENDTRY
1018:     ENDPROC
1019: 
1020:     *--------------------------------------------------------------------------
1021:     * VerificarAcessoConta - espelha o "If !fAcessoContas(Usuar, '', 'C'|'D',
1022:     * ...)" que o Valid dos TRES campos de conta do legado executa em TODO
1023:     * caminho de resolucao (dump SigOpChi_form_codigo_fonte.txt linhas 2238,
1024:     * 2317, 2398 e 2422 no container Origem; 3302, 3382 e 3463 no Emitente).
1025:     *
1026:     * Chamada SEM os objetos TextBox (pSt1/pSt2): nessa forma o fAcessoContas
1027:     * portado (utils\functions.prg) entra no ramo "Busca sem UI (apenas
1028:     * verifica acesso)" e so devolve .T./.F., sem o auto-load do primeiro
1029:     * match parcial que a regra do projeto proibe em lookup (Erro16). A conta
1030:     * chega aqui JA resolvida, por isso o tipo eh sempre 'C' (codigo) - o ramo
1031:     * 'D' do legado apenas resolve a descricao para o mesmo codigo antes de
1032:     * checar.
1033:     *
1034:     * Sem conexao (modo de teste / ValidarUIFidelity) nao ha o que consultar:
1035:     * devolve .T. para nao bloquear a tela - o legado sempre roda conectado.
1036:     * Em excecao de infraestrutura tambem devolve .T., mas EXIBINDO o erro:
1037:     * "Acesso Negado" por falha transitoria de SQL seria mensagem mentirosa.
1038:     *--------------------------------------------------------------------------
1039:     PROTECTED FUNCTION VerificarAcessoConta(par_cConta)
1040:         LOCAL loc_lAcesso, loc_cUsuario, loc_oErro
1041: 
1042:         loc_lAcesso = .T.
1043: 
1044:         IF VARTYPE(par_cConta) = "C" AND !EMPTY(ALLTRIM(par_cConta)) AND ;
1045:                 TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1046:             loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
1047:             TRY
1048:                 loc_lAcesso = fAcessoContas(loc_cUsuario, "", "C", ALLTRIM(par_cConta))
1049:             CATCH TO loc_oErro
1050:                 MsgErro("Falha ao verificar acesso " + CHR(224) + " conta:" + CHR(13) + ;
1051:                     loc_oErro.Message, "Erro")
1052:                 loc_lAcesso = .T.
1053:             ENDTRY
1054:         ENDIF
1055: 
1056:         RETURN loc_lAcesso

*-- Linhas 1062 a 1657:
1062:     * unica lida por CarregarDados no ramo TOTAL) o registro de SigCdCli
1063:     * resolvido por qualquer um dos tres lookups
1064:     *--------------------------------------------------------------------------
1065:     PROCEDURE PreencherEmitente(par_cConta, par_cDConta, par_cCpf)
1066:         LOCAL loc_oEmi, loc_cConta, loc_cDConta, loc_cCpf
1067: 
1068:         loc_cConta  = par_cConta
1069:         loc_cDConta = par_cDConta
1070:         loc_cCpf    = par_cCpf
1071: 
1072:         *-- Legado: acesso negado exibe o aviso e limpa os TRES campos
1073:         *-- (get_Conta.Valid linha 3302: MessageBox('Acesso Negado!!!') +
1074:         *-- .get_conta/.get_dconta/.get_cpf = '' + Return 0). O EMPTY espelha
1075:         *-- o "If !Empty(This.Value)" que cerca a checagem no legado - limpar
1076:         *-- os campos nao se re-verifica.
1077:         IF !EMPTY(loc_cConta) AND !THIS.VerificarAcessoConta(loc_cConta)
1078:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1079:             loc_cConta  = ""
1080:             loc_cDConta = ""
1081:             loc_cCpf    = ""
1082:         ENDIF
1083: 
1084:         loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1085:         loc_oEmi.txt_4c__Conta.Value  = loc_cConta
1086:         loc_oEmi.txt_4c__DConta.Value = loc_cDConta
1087:         loc_oEmi.txt_4c__Cpf.Value    = loc_cCpf
1088:         loc_oEmi.txt_4c__Conta.Refresh
1089:         loc_oEmi.txt_4c__DConta.Refresh
1090:         loc_oEmi.txt_4c__Cpf.Refresh
1091: 
1092:         THIS.this_oBusinessObject.this_cContaEmitente  = loc_cConta
1093:         THIS.this_oBusinessObject.this_cDContaEmitente = loc_cDConta
1094:         THIS.this_oBusinessObject.this_cCpfEmitente    = loc_cCpf
1095: 
1096:         *-- A cascata do When (regra de dependencia entre os tres campos)
1097:         *-- depende dos valores que acabaram de ser escritos
1098:         THIS.HabilitarCampos(.T.)
1099:     ENDPROC
1100: 
1101:     PROCEDURE LimparEmitente()
1102:         THIS.PreencherEmitente("", "", "")
1103:     ENDPROC
1104: 
1105:     *--------------------------------------------------------------------------
1106:     * ValidarContaEmitente - KeyPress em txt_4c__Conta do Emitente (Valid do
1107:     * get_Conta legado). F4 abre o picker direto; Enter/Tab faz o SELECT
1108:     * exato por Iclis e, sem match, abre o picker com o valor digitado como
1109:     * prefixo. A checagem de acesso do legado roda no funil PreencherEmitente
1110:     * (ver VerificarAcessoConta), que cobre os tres campos do container.
1111:     *--------------------------------------------------------------------------
1112:     PROCEDURE ValidarContaEmitente(par_nKeyCode, par_nShiftAltCtrl)
1113:         LOCAL loc_cVal, loc_nResult, loc_oEmi, loc_oErro
1114: 
1115:         IF par_nKeyCode = 115
1116:             THIS.AbrirBuscaContaEmitente()
1117:             RETURN
1118:         ENDIF
1119:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1120:             RETURN
1121:         ENDIF
1122: 
1123:         loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1124:         loc_cVal = ALLTRIM(loc_oEmi.txt_4c__Conta.Value)
1125:         IF EMPTY(loc_cVal)
1126:             THIS.PreencherEmitente("", "", "")
1127:             RETURN
1128:         ENDIF
1129: 
1130:         TRY
1131:             loc_nResult = SQLEXEC(gnConnHandle, ;
1132:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal), ;
1133:                 "cursor_4c_EmitenteVal")
1134:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1135:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1136:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1137:             ELSE
1138:                 THIS.AbrirBuscaContaEmitente()
1139:             ENDIF
1140:             IF USED("cursor_4c_EmitenteVal")
1141:                 USE IN cursor_4c_EmitenteVal
1142:             ENDIF
1143:         CATCH TO loc_oErro
1144:             MsgErro(loc_oErro.Message, "Erro")
1145:         ENDTRY
1146:     ENDPROC
1147: 
1148:     *--------------------------------------------------------------------------
1149:     * AbrirBuscaContaEmitente - picker por Iclis/Rclis em SigCdCli (Pattern A),
1150:     * filtrado pelo prefixo ja digitado em txt_4c__Conta (ou lista completa se
1151:     * vazio). Mesmo padrao de AbrirBuscaContaOrigem.
1152:     *--------------------------------------------------------------------------
1153:     PROCEDURE AbrirBuscaContaEmitente()
1154:         LOCAL loc_oEmi, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1155:               loc_cCpf, loc_oErro
1156: 
1157:         IF THIS.this_lEmLookupEmitente
1158:             RETURN
1159:         ENDIF
1160:         THIS.this_lEmLookupEmitente = .T.
1161: 
1162:         loc_oEmi   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1163:         loc_cValor = ALLTRIM(loc_oEmi.txt_4c__Conta.Value)
1164: 
1165:         TRY
1166:             IF USED("cursor_4c_BuscaEmitente")
1167:                 USE IN cursor_4c_BuscaEmitente
1168:             ENDIF
1169: 
1170:             IF EMPTY(loc_cValor)
1171:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis"
1172:             ELSE
1173:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli " + ;
1174:                            "WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1175:                            " ORDER BY Iclis"
1176:             ENDIF
1177:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1178: 
1179:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1180:                     AND !EMPTY(loc_cValor)
1181:                 IF USED("cursor_4c_BuscaEmitente")
1182:                     USE IN cursor_4c_BuscaEmitente
1183:                 ENDIF
1184:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1185:                     "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaEmitente")
1186:             ENDIF
1187: 
1188:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1189:                 MsgAviso("Nenhuma conta encontrada.", "Contas")
1190:             ELSE
1191:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1192:                 IF VARTYPE(loc_oBusca) = "O"
1193:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1194:                         "Sele" + CHR(231) + CHR(227) + "o de Conta")
1195:                     IF loc_oBusca.Mostrar()
1196:                         loc_cCpf = ""
1197:                         IF USED("cursor_4c_BuscaEmitente")
1198:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaEmitente.Cpfs)
1199:                         ENDIF
1200:                         THIS.PreencherEmitente(loc_oBusca.cCodigoSelecionado, ;
1201:                             loc_oBusca.cDescricaoSelecionada, loc_cCpf)
1202:                     ENDIF
1203:                     loc_oBusca.Release()
1204:                 ENDIF
1205:             ENDIF
1206:         CATCH TO loc_oErro
1207:             MsgErro(loc_oErro.Message, "Erro")
1208:         ENDTRY
1209: 
1210:         IF USED("cursor_4c_BuscaEmitente")
1211:             USE IN cursor_4c_BuscaEmitente
1212:         ENDIF
1213:         THIS.this_lEmLookupEmitente = .F.
1214:     ENDPROC
1215: 
1216:     *--------------------------------------------------------------------------
1217:     * ValidarCpfEmitente - KeyPress em txt_4c__Cpf do Emitente (Valid do
1218:     * get_Cpf legado). Mesma montagem de mascara e validacao de digito
1219:     * verificador (ValidarCPF/ValidarCNPJ) do container Origem.
1220:     *--------------------------------------------------------------------------
1221:     PROCEDURE ValidarCpfEmitente(par_nKeyCode, par_nShiftAltCtrl)
1222:         LOCAL loc_cVal, loc_cDigitos, loc_cFormatado, loc_nResult, ;
1223:               loc_oEmi, loc_oErro
1224: 
1225:         IF par_nKeyCode = 115
1226:             THIS.AbrirBuscaCpfEmitente()
1227:             RETURN
1228:         ENDIF
1229:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1230:             RETURN
1231:         ENDIF
1232: 
1233:         loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1234:         loc_cVal = ALLTRIM(loc_oEmi.txt_4c__Cpf.Value)
1235:         IF EMPTY(loc_cVal)
1236:             loc_oEmi.txt_4c__DConta.Value = ""
1237:             loc_oEmi.txt_4c__DConta.Refresh
1238:             RETURN
1239:         ENDIF
1240: 
1241:         loc_cDigitos = STRTRAN(STRTRAN(STRTRAN(loc_cVal, ".", ""), "-", ""), "/", "")
1242: 
1243:         IF LEN(loc_cDigitos) != 14
1244:             loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 999.999.999-99")
1245:         ELSE
1246:             loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 99.999.999/9999-99")
1247:         ENDIF
1248: 
1249:         TRY
1250:             loc_nResult = SQLEXEC(gnConnHandle, ;
1251:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cFormatado), ;
1252:                 "cursor_4c_EmitenteVal")
1253:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1254:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1255:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1256:             ELSE
1257:                 THIS.AbrirBuscaCpfEmitente()
1258:             ENDIF
1259:             IF USED("cursor_4c_EmitenteVal")
1260:                 USE IN cursor_4c_EmitenteVal
1261:             ENDIF
1262:         CATCH TO loc_oErro
1263:             MsgErro(loc_oErro.Message, "Erro")
1264:         ENDTRY
1265: 
1266:         IF LEN(loc_cVal) = 14
1267:             IF !ValidarCPF(loc_cDigitos)
1268:                 MsgAviso("CPF Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1269:             ENDIF
1270:         ELSE
1271:             IF !ValidarCNPJ(loc_cDigitos)
1272:                 MsgAviso("CGC Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1273:             ENDIF
1274:         ENDIF
1275:     ENDPROC
1276: 
1277:     *--------------------------------------------------------------------------
1278:     * AbrirBuscaCpfEmitente - picker por Cpfs/Rclis em SigCdCli (Pattern A),
1279:     * filtrado por "contem". Mesmo padrao de AbrirBuscaCpfOrigem.
1280:     *--------------------------------------------------------------------------
1281:     PROCEDURE AbrirBuscaCpfEmitente()
1282:         LOCAL loc_oEmi, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1283:               loc_cConta, loc_oErro
1284: 
1285:         IF THIS.this_lEmLookupEmitente
1286:             RETURN
1287:         ENDIF
1288:         THIS.this_lEmLookupEmitente = .T.
1289: 
1290:         loc_oEmi   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1291:         loc_cValor = ALLTRIM(loc_oEmi.txt_4c__Cpf.Value)
1292: 
1293:         TRY
1294:             IF USED("cursor_4c_BuscaEmitente")
1295:                 USE IN cursor_4c_BuscaEmitente
1296:             ENDIF
1297: 
1298:             IF EMPTY(loc_cValor)
1299:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs"
1300:             ELSE
1301:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli " + ;
1302:                            "WHERE Cpfs LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1303:                            " ORDER BY Cpfs"
1304:             ENDIF
1305:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1306: 
1307:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1308:                     AND !EMPTY(loc_cValor)
1309:                 IF USED("cursor_4c_BuscaEmitente")
1310:                     USE IN cursor_4c_BuscaEmitente
1311:                 ENDIF
1312:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1313:                     "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs", "cursor_4c_BuscaEmitente")
1314:             ENDIF
1315: 
1316:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1317:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1318:             ELSE
1319:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1320:                 IF VARTYPE(loc_oBusca) = "O"
1321:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1322:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1323:                     IF loc_oBusca.Mostrar()
1324:                         loc_cConta = ""
1325:                         IF USED("cursor_4c_BuscaEmitente")
1326:                             loc_cConta = ALLTRIM(cursor_4c_BuscaEmitente.Iclis)
1327:                         ENDIF
1328:                         THIS.PreencherEmitente(loc_cConta, loc_oBusca.cDescricaoSelecionada, ;
1329:                             loc_oBusca.cCodigoSelecionado)
1330:                     ENDIF
1331:                     loc_oBusca.Release()
1332:                 ENDIF
1333:             ENDIF
1334:         CATCH TO loc_oErro
1335:             MsgErro(loc_oErro.Message, "Erro")
1336:         ENDTRY
1337: 
1338:         IF USED("cursor_4c_BuscaEmitente")
1339:             USE IN cursor_4c_BuscaEmitente
1340:         ENDIF
1341:         THIS.this_lEmLookupEmitente = .F.
1342:     ENDPROC
1343: 
1344:     *--------------------------------------------------------------------------
1345:     * ValidarNomeEmitente - KeyPress em txt_4c__DConta do Emitente (Valid do
1346:     * get_DConta legado). Mesmo padrao de ValidarNomeOrigem.
1347:     *--------------------------------------------------------------------------
1348:     PROCEDURE ValidarNomeEmitente(par_nKeyCode, par_nShiftAltCtrl)
1349:         LOCAL loc_cVal, loc_nResult, loc_oEmi, loc_oErro
1350: 
1351:         IF par_nKeyCode = 115
1352:             THIS.AbrirBuscaNomeEmitente()
1353:             RETURN
1354:         ENDIF
1355:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1356:             RETURN
1357:         ENDIF
1358: 
1359:         loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1360:         loc_cVal = ALLTRIM(loc_oEmi.txt_4c__DConta.Value)
1361:         IF EMPTY(loc_cVal)
1362:             THIS.PreencherEmitente("", "", "")
1363:             RETURN
1364:         ENDIF
1365: 
1366:         TRY
1367:             loc_nResult = SQLEXEC(gnConnHandle, ;
1368:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cVal), ;
1369:                 "cursor_4c_EmitenteVal")
1370:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1371:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1372:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1373:             ELSE
1374:                 THIS.AbrirBuscaNomeEmitente()
1375:             ENDIF
1376:             IF USED("cursor_4c_EmitenteVal")
1377:                 USE IN cursor_4c_EmitenteVal
1378:             ENDIF
1379:         CATCH TO loc_oErro
1380:             MsgErro(loc_oErro.Message, "Erro")
1381:         ENDTRY
1382:     ENDPROC
1383: 
1384:     *--------------------------------------------------------------------------
1385:     * AbrirBuscaNomeEmitente - picker por Rclis/Iclis em SigCdCli (Pattern A),
1386:     * filtrado por "contem". Mesmo padrao de AbrirBuscaNomeOrigem.
1387:     *--------------------------------------------------------------------------
1388:     PROCEDURE AbrirBuscaNomeEmitente()
1389:         LOCAL loc_oEmi, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1390:               loc_cCpf, loc_oErro
1391: 
1392:         IF THIS.this_lEmLookupEmitente
1393:             RETURN
1394:         ENDIF
1395:         THIS.this_lEmLookupEmitente = .T.
1396: 
1397:         loc_oEmi   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1398:         loc_cValor = ALLTRIM(loc_oEmi.txt_4c__DConta.Value)
1399: 
1400:         TRY
1401:             IF USED("cursor_4c_BuscaEmitente")
1402:                 USE IN cursor_4c_BuscaEmitente
1403:             ENDIF
1404: 
1405:             IF EMPTY(loc_cValor)
1406:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis"
1407:             ELSE
1408:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli " + ;
1409:                            "WHERE RTRIM(Rclis) LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1410:                            " ORDER BY Rclis"
1411:             ENDIF
1412:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1413: 
1414:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1415:                     AND !EMPTY(loc_cValor)
1416:                 IF USED("cursor_4c_BuscaEmitente")
1417:                     USE IN cursor_4c_BuscaEmitente
1418:                 ENDIF
1419:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1420:                     "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaEmitente")
1421:             ENDIF
1422: 
1423:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1424:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1425:             ELSE
1426:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1427:                 IF VARTYPE(loc_oBusca) = "O"
1428:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1429:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1430:                     IF loc_oBusca.Mostrar()
1431:                         loc_cCpf = ""
1432:                         IF USED("cursor_4c_BuscaEmitente")
1433:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaEmitente.Cpfs)
1434:                         ENDIF
1435:                         THIS.PreencherEmitente(loc_oBusca.cCodigoSelecionado, ;
1436:                             loc_oBusca.cDescricaoSelecionada, loc_cCpf)
1437:                     ENDIF
1438:                     loc_oBusca.Release()
1439:                 ENDIF
1440:             ENDIF
1441:         CATCH TO loc_oErro
1442:             MsgErro(loc_oErro.Message, "Erro")
1443:         ENDTRY
1444: 
1445:         IF USED("cursor_4c_BuscaEmitente")
1446:             USE IN cursor_4c_BuscaEmitente
1447:         ENDIF
1448:         THIS.this_lEmLookupEmitente = .F.
1449:     ENDPROC
1450: 
1451:     *--------------------------------------------------------------------------
1452:     * PreencherOrigem / LimparOrigem - espelham nos tres campos do container
1453:     * Origem o registro de SigCdCli resolvido por qualquer um dos lookups
1454:     * (conta, CPF/CNPJ ou nome)
1455:     *--------------------------------------------------------------------------
1456:     PROCEDURE PreencherOrigem(par_cConta, par_cDConta, par_cCpf)
1457:         LOCAL loc_oOrig, loc_cConta, loc_cDConta, loc_cCpf
1458: 
1459:         loc_cConta  = par_cConta
1460:         loc_cDConta = par_cDConta
1461:         loc_cCpf    = par_cCpf
1462: 
1463:         *-- Legado: acesso negado exibe o aviso e limpa os TRES campos
1464:         *-- (get_Conta.Valid linha 2238 / get_DConta.Valid linhas 2398 e 2422:
1465:         *-- MessageBox('Acesso Negado!!!') + os tres .Value = '' + Return 0).
1466:         IF !EMPTY(loc_cConta) AND !THIS.VerificarAcessoConta(loc_cConta)
1467:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1468:             loc_cConta  = ""
1469:             loc_cDConta = ""
1470:             loc_cCpf    = ""
1471:         ENDIF
1472: 
1473:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1474:         loc_oOrig.txt_4c__Conta.Value  = loc_cConta
1475:         loc_oOrig.txt_4c__DConta.Value = loc_cDConta
1476:         loc_oOrig.txt_4c__Cpf.Value    = loc_cCpf
1477:         loc_oOrig.txt_4c__Conta.Refresh
1478:         loc_oOrig.txt_4c__DConta.Refresh
1479:         loc_oOrig.txt_4c__Cpf.Refresh
1480: 
1481:         *-- Espelha no BO (fonte unica lida por CarregarDados) e reaplica a
1482:         *-- cascata do When, que depende destes tres valores
1483:         THIS.this_oBusinessObject.this_cContaOrigem  = loc_cConta
1484:         THIS.this_oBusinessObject.this_cDContaOrigem = loc_cDConta
1485:         THIS.this_oBusinessObject.this_cCpfOrigem    = loc_cCpf
1486:         THIS.this_lFiltrado                          = !EMPTY(ALLTRIM(loc_cConta))
1487:         THIS.this_oBusinessObject.this_lFiltrado     = THIS.this_lFiltrado
1488: 
1489:         THIS.HabilitarCampos(.T.)
1490:     ENDPROC
1491: 
1492:     PROCEDURE LimparOrigem()
1493:         THIS.PreencherOrigem("", "", "")
1494:     ENDPROC
1495: 
1496:     *--------------------------------------------------------------------------
1497:     * ValidarContaOrigem - KeyPress em txt_4c__Conta (equivalente ao Valid do
1498:     * get_Conta legado). F4 abre o picker direto; Enter/Tab faz o SELECT exato
1499:     * por Iclis e, sem match, abre o picker com o valor digitado como prefixo.
1500:     *--------------------------------------------------------------------------
1501:     PROCEDURE ValidarContaOrigem(par_nKeyCode, par_nShiftAltCtrl)
1502:         LOCAL loc_cVal, loc_nResult, loc_oOrig, loc_oErro
1503: 
1504:         IF par_nKeyCode = 115
1505:             THIS.AbrirBuscaContaOrigem()
1506:             RETURN
1507:         ENDIF
1508:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1509:             RETURN
1510:         ENDIF
1511: 
1512:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1513:         loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)
1514:         IF EMPTY(loc_cVal)
1515:             loc_oOrig.txt_4c__DConta.Value = ""
1516:             loc_oOrig.txt_4c__Cpf.Value    = ""
1517:             loc_oOrig.txt_4c__DConta.Refresh
1518:             loc_oOrig.txt_4c__Cpf.Refresh
1519:             RETURN
1520:         ENDIF
1521: 
1522:         TRY
1523:             loc_nResult = SQLEXEC(gnConnHandle, ;
1524:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal), ;
1525:                 "cursor_4c_OrigemVal")
1526:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1527:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1528:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1529:             ELSE
1530:                 THIS.AbrirBuscaContaOrigem()
1531:             ENDIF
1532:             IF USED("cursor_4c_OrigemVal")
1533:                 USE IN cursor_4c_OrigemVal
1534:             ENDIF
1535:         CATCH TO loc_oErro
1536:             MsgErro(loc_oErro.Message, "Erro")
1537:         ENDTRY
1538:     ENDPROC
1539: 
1540:     *--------------------------------------------------------------------------
1541:     * AbrirBuscaContaOrigem - picker por Iclis/Rclis em SigCdCli (Pattern A:
1542:     * SQL no caller + CREATEOBJECT sem parametros + DefinirCursor + Mostrar),
1543:     * filtrado pelo prefixo ja digitado em txt_4c__Conta (ou lista completa
1544:     * se vazio). Cpfs eh lido do cursor apos a selecao, pois DefinirCursor/
1545:     * Mostrar so devolvem codigo+descricao.
1546:     *--------------------------------------------------------------------------
1547:     PROCEDURE AbrirBuscaContaOrigem()
1548:         LOCAL loc_oOrig, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1549:               loc_cCpf, loc_oErro
1550: 
1551:         IF THIS.this_lEmLookupOrigem
1552:             RETURN
1553:         ENDIF
1554:         THIS.this_lEmLookupOrigem = .T.
1555: 
1556:         loc_oOrig  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1557:         loc_cValor = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)
1558: 
1559:         TRY
1560:             IF USED("cursor_4c_BuscaOrigem")
1561:                 USE IN cursor_4c_BuscaOrigem
1562:             ENDIF
1563: 
1564:             IF EMPTY(loc_cValor)
1565:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis"
1566:             ELSE
1567:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli " + ;
1568:                            "WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1569:                            " ORDER BY Iclis"
1570:             ENDIF
1571:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1572: 
1573:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1574:                     AND !EMPTY(loc_cValor)
1575:                 IF USED("cursor_4c_BuscaOrigem")
1576:                     USE IN cursor_4c_BuscaOrigem
1577:                 ENDIF
1578:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1579:                     "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaOrigem")
1580:             ENDIF
1581: 
1582:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1583:                 MsgAviso("Nenhuma conta encontrada.", "Contas")
1584:             ELSE
1585:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1586:                 IF VARTYPE(loc_oBusca) = "O"
1587:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1588:                         "Sele" + CHR(231) + CHR(227) + "o de Conta")
1589:                     IF loc_oBusca.Mostrar()
1590:                         loc_cCpf = ""
1591:                         IF USED("cursor_4c_BuscaOrigem")
1592:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaOrigem.Cpfs)
1593:                         ENDIF
1594:                         THIS.PreencherOrigem(loc_oBusca.cCodigoSelecionado, ;
1595:                             loc_oBusca.cDescricaoSelecionada, loc_cCpf)
1596:                     ENDIF
1597:                     loc_oBusca.Release()
1598:                 ENDIF
1599:             ENDIF
1600:         CATCH TO loc_oErro
1601:             MsgErro(loc_oErro.Message, "Erro")
1602:         ENDTRY
1603: 
1604:         IF USED("cursor_4c_BuscaOrigem")
1605:             USE IN cursor_4c_BuscaOrigem
1606:         ENDIF
1607:         THIS.this_lEmLookupOrigem = .F.
1608:     ENDPROC
1609: 
1610:     *--------------------------------------------------------------------------
1611:     * ValidarCpfOrigem - KeyPress em txt_4c__Cpf (equivalente ao Valid do
1612:     * get_Cpf legado). Monta o CPF/CNPJ formatado (com pontuacao, igual ao
1613:     * valor gravado em SigCdCli.Cpfs), faz o SELECT exato e, sem match, abre
1614:     * o picker; ao final valida o digito verificador com ValidarCPF/ValidarCNPJ
1615:     * (regra #13 - delegar ao validador novo, nao ao wrapper do legado).
1616:     *--------------------------------------------------------------------------
1617:     PROCEDURE ValidarCpfOrigem(par_nKeyCode, par_nShiftAltCtrl)
1618:         LOCAL loc_cVal, loc_cDigitos, loc_cFormatado, loc_nResult, ;
1619:               loc_oOrig, loc_oErro
1620: 
1621:         IF par_nKeyCode = 115
1622:             THIS.AbrirBuscaCpfOrigem()
1623:             RETURN
1624:         ENDIF
1625:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1626:             RETURN
1627:         ENDIF
1628: 
1629:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1630:         loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)
1631:         IF EMPTY(loc_cVal)
1632:             loc_oOrig.txt_4c__DConta.Value = ""
1633:             loc_oOrig.txt_4c__DConta.Refresh
1634:             RETURN
1635:         ENDIF
1636: 
1637:         loc_cDigitos = STRTRAN(STRTRAN(STRTRAN(loc_cVal, ".", ""), "-", ""), "/", "")
1638: 
1639:         *-- Igual ao legado: a mascara usada para montar o valor de BUSCA
1640:         *-- (Cpfs = formatado) depende do tamanho dos DIGITOS (sem pontuacao);
1641:         *-- a validacao do digito verificador, mais abaixo, usa o tamanho do
1642:         *-- valor DIGITADO (com pontuacao, se houver) - sao criterios distintos
1643:         *-- no proprio SIGOPCHI.SCX e foram transcritos tal como estao la.
1644:         IF LEN(loc_cDigitos) != 14
1645:             loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 999.999.999-99")
1646:         ELSE
1647:             loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 99.999.999/9999-99")
1648:         ENDIF
1649: 
1650:         TRY
1651:             loc_nResult = SQLEXEC(gnConnHandle, ;
1652:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cFormatado), ;
1653:                 "cursor_4c_OrigemVal")
1654:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1655:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1656:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1657:             ELSE

*-- Linhas 1666 a 1974:
1666: 
1667:         IF LEN(loc_cVal) = 14
1668:             IF !ValidarCPF(loc_cDigitos)
1669:                 MsgAviso("CPF Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1670:             ENDIF
1671:         ELSE
1672:             IF !ValidarCNPJ(loc_cDigitos)
1673:                 MsgAviso("CGC Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1674:             ENDIF
1675:         ENDIF
1676:     ENDPROC
1677: 
1678:     *--------------------------------------------------------------------------
1679:     * AbrirBuscaCpfOrigem - picker por Cpfs/Rclis em SigCdCli (Pattern A),
1680:     * filtrado por "contem" (igual ao Like '%valor%' do legado). Iclis eh
1681:     * lido do cursor apos a selecao.
1682:     *--------------------------------------------------------------------------
1683:     PROCEDURE AbrirBuscaCpfOrigem()
1684:         LOCAL loc_oOrig, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1685:               loc_cConta, loc_oErro
1686: 
1687:         IF THIS.this_lEmLookupOrigem
1688:             RETURN
1689:         ENDIF
1690:         THIS.this_lEmLookupOrigem = .T.
1691: 
1692:         loc_oOrig  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1693:         loc_cValor = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)
1694: 
1695:         TRY
1696:             IF USED("cursor_4c_BuscaOrigem")
1697:                 USE IN cursor_4c_BuscaOrigem
1698:             ENDIF
1699: 
1700:             IF EMPTY(loc_cValor)
1701:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs"
1702:             ELSE
1703:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli " + ;
1704:                            "WHERE Cpfs LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1705:                            " ORDER BY Cpfs"
1706:             ENDIF
1707:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1708: 
1709:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1710:                     AND !EMPTY(loc_cValor)
1711:                 IF USED("cursor_4c_BuscaOrigem")
1712:                     USE IN cursor_4c_BuscaOrigem
1713:                 ENDIF
1714:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1715:                     "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs", "cursor_4c_BuscaOrigem")
1716:             ENDIF
1717: 
1718:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1719:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1720:             ELSE
1721:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1722:                 IF VARTYPE(loc_oBusca) = "O"
1723:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1724:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1725:                     IF loc_oBusca.Mostrar()
1726:                         loc_cConta = ""
1727:                         IF USED("cursor_4c_BuscaOrigem")
1728:                             loc_cConta = ALLTRIM(cursor_4c_BuscaOrigem.Iclis)
1729:                         ENDIF
1730:                         THIS.PreencherOrigem(loc_cConta, loc_oBusca.cDescricaoSelecionada, ;
1731:                             loc_oBusca.cCodigoSelecionado)
1732:                     ENDIF
1733:                     loc_oBusca.Release()
1734:                 ENDIF
1735:             ENDIF
1736:         CATCH TO loc_oErro
1737:             MsgErro(loc_oErro.Message, "Erro")
1738:         ENDTRY
1739: 
1740:         IF USED("cursor_4c_BuscaOrigem")
1741:             USE IN cursor_4c_BuscaOrigem
1742:         ENDIF
1743:         THIS.this_lEmLookupOrigem = .F.
1744:     ENDPROC
1745: 
1746:     *--------------------------------------------------------------------------
1747:     * ValidarNomeOrigem - KeyPress em txt_4c__DConta (equivalente ao Valid do
1748:     * get_DConta legado). Faz o SELECT exato por Rclis e, sem match, abre o
1749:     * picker com o valor digitado como filtro "contem".
1750:     *--------------------------------------------------------------------------
1751:     PROCEDURE ValidarNomeOrigem(par_nKeyCode, par_nShiftAltCtrl)
1752:         LOCAL loc_cVal, loc_nResult, loc_oOrig, loc_oErro
1753: 
1754:         IF par_nKeyCode = 115
1755:             THIS.AbrirBuscaNomeOrigem()
1756:             RETURN
1757:         ENDIF
1758:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1759:             RETURN
1760:         ENDIF
1761: 
1762:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1763:         loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)
1764:         IF EMPTY(loc_cVal)
1765:             loc_oOrig.txt_4c__Conta.Value = ""
1766:             loc_oOrig.txt_4c__Cpf.Value   = ""
1767:             loc_oOrig.txt_4c__Conta.Refresh
1768:             loc_oOrig.txt_4c__Cpf.Refresh
1769:             RETURN
1770:         ENDIF
1771: 
1772:         TRY
1773:             loc_nResult = SQLEXEC(gnConnHandle, ;
1774:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cVal), ;
1775:                 "cursor_4c_OrigemVal")
1776:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1777:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1778:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1779:             ELSE
1780:                 THIS.AbrirBuscaNomeOrigem()
1781:             ENDIF
1782:             IF USED("cursor_4c_OrigemVal")
1783:                 USE IN cursor_4c_OrigemVal
1784:             ENDIF
1785:         CATCH TO loc_oErro
1786:             MsgErro(loc_oErro.Message, "Erro")
1787:         ENDTRY
1788:     ENDPROC
1789: 
1790:     *--------------------------------------------------------------------------
1791:     * AbrirBuscaNomeOrigem - picker por Rclis/Iclis em SigCdCli (Pattern A).
1792:     *
1793:     * O modo de busca vem do OptionGroup optFiltro, que o legado consulta no
1794:     * get_DConta.Valid ("If .optFiltro.Value = 2 && Procura Com Filtro"):
1795:     *   Value = 2 (Filtro) -> Like '%valor%' (contem), igual ao legado
1796:     *   Value = 1 (Lista)  -> Like 'valor%'  (comeca com)
1797:     * O ramo Lista do legado chamava fAcessoContas(Usuar,'','D',...) passando
1798:     * os TextBox, forma proibida no projeto porque auto-preenche o primeiro
1799:     * match PARCIAL sem o usuario escolher (Erro16); o substituto canonico eh
1800:     * o picker filtrado por prefixo, que eh o que se faz aqui.
1801:     *
1802:     * Cpfs eh lido do cursor apos a selecao.
1803:     *--------------------------------------------------------------------------
1804:     PROCEDURE AbrirBuscaNomeOrigem()
1805:         LOCAL loc_oOrig, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1806:               loc_cCpf, loc_cPadrao, loc_oErro
1807: 
1808:         IF THIS.this_lEmLookupOrigem
1809:             RETURN
1810:         ENDIF
1811:         THIS.this_lEmLookupOrigem = .T.
1812: 
1813:         loc_oOrig  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1814:         loc_cValor = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)
1815: 
1816:         TRY
1817:             IF USED("cursor_4c_BuscaOrigem")
1818:                 USE IN cursor_4c_BuscaOrigem
1819:             ENDIF
1820: 
1821:             IF EMPTY(loc_cValor)
1822:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis"
1823:             ELSE
1824:                 *-- optFiltro = 2 ("Filtro") procura por CONTEM; = 1 ("Lista")
1825:                 *-- procura por COMECA COM (ver cabecalho deste metodo)
1826:                 loc_cPadrao = IIF(loc_oOrig.obj_4c_OptFiltro.Value = 2, ;
1827:                     "%" + loc_cValor + "%", loc_cValor + "%")
1828:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli " + ;
1829:                            "WHERE RTRIM(Rclis) LIKE " + EscaparSQL(loc_cPadrao) + ;
1830:                            " ORDER BY Rclis"
1831:             ENDIF
1832:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1833: 
1834:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1835:                     AND !EMPTY(loc_cValor)
1836:                 IF USED("cursor_4c_BuscaOrigem")
1837:                     USE IN cursor_4c_BuscaOrigem
1838:                 ENDIF
1839:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1840:                     "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaOrigem")
1841:             ENDIF
1842: 
1843:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1844:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1845:             ELSE
1846:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1847:                 IF VARTYPE(loc_oBusca) = "O"
1848:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1849:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1850:                     IF loc_oBusca.Mostrar()
1851:                         loc_cCpf = ""
1852:                         IF USED("cursor_4c_BuscaOrigem")
1853:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaOrigem.Cpfs)
1854:                         ENDIF
1855:                         THIS.PreencherOrigem(loc_oBusca.cCodigoSelecionado, ;
1856:                             loc_oBusca.cDescricaoSelecionada, loc_cCpf)
1857:                     ENDIF
1858:                     loc_oBusca.Release()
1859:                 ENDIF
1860:             ENDIF
1861:         CATCH TO loc_oErro
1862:             MsgErro(loc_oErro.Message, "Erro")
1863:         ENDTRY
1864: 
1865:         IF USED("cursor_4c_BuscaOrigem")
1866:             USE IN cursor_4c_BuscaOrigem
1867:         ENDIF
1868:         THIS.this_lEmLookupOrigem = .F.
1869:     ENDPROC
1870: 
1871:     *--------------------------------------------------------------------------
1872:     * CmdOkClick - "Processar" (equivalente ao Ok.Click legado). Valida a
1873:     * conta quando o acesso eh restrito, monta o titulo com os dados de
1874:     * origem resolvidos e troca para a Page2 (Historico).
1875:     *--------------------------------------------------------------------------
1876:     PROCEDURE CmdOkClick()
1877:         LOCAL loc_oOrig, loc_cConta, loc_cDConta, loc_cCpf, loc_oErro
1878: 
1879:         loc_oOrig   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1880:         loc_cConta  = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)
1881: 
1882:         IF !THIS.this_lAcesso AND EMPTY(loc_cConta)
1883:             MsgAviso("Conta Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1884:             loc_oOrig.txt_4c__Conta.SetFocus()
1885:             RETURN
1886:         ENDIF
1887: 
1888:         loc_cDConta = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)
1889:         loc_cCpf    = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)
1890: 
1891:         THIS.this_lFiltrado = !EMPTY(loc_cConta)
1892: 
1893:         THIS.Caption = "Hist" + CHR(243) + "rico de Cheques de: " + loc_cConta + " - " + ;
1894:             loc_cDConta + " / " + loc_cCpf
1895: 
1896:         TRY
1897:             *-- Legado: .Historico.Cnt_periodo.Visible = .f. - o historico por
1898:             *-- conta (ramo 1 de CarregarDados) ignora o periodo de vencimento,
1899:             *-- entao o filtro de data fica escondido neste caminho
1900:             THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo.Visible = .F.
1901: 
1902:             *-- Troca de pagina, carga das grades e ajuste dos botoes do
1903:             *-- Historico moram TODOS em AlternarPagina (funil unico, usado
1904:             *-- tambem pelo Init e pelo Encerrar do Historico)
1905:             THIS.AlternarPagina(2)
1906:         CATCH TO loc_oErro
1907:             MsgErro(loc_oErro.Message + CHR(13) + ;
1908:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1909:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.CmdOkClick")
1910:         ENDTRY
1911:     ENDPROC
1912: 
1913:     *--------------------------------------------------------------------------
1914:     * CmdCancelarClick - "Encerrar" da Page1 (equivalente ao cancelar.Click
1915:     * legado: ThisForm.Release). Alvo do BINDEVENT do botao; o corpo mora em
1916:     * BtnCancelarClick (nome canonico), para existir UM so lugar que fecha.
1917:     *--------------------------------------------------------------------------
1918:     PROCEDURE CmdCancelarClick()
1919:         THIS.BtnCancelarClick()
1920:     ENDPROC
1921: 
1922:     *--------------------------------------------------------------------------
1923:     * ConfigurarGradesHistorico - Cria as TRES grades da Page2 (Historico):
1924:     *   grd_4c_Cheque    <- GradeCheque     (12 colunas, SigChe)
1925:     *   grd_4c_Movimenta <- GradeMovimenta  ( 9 colunas, SigCqChm)
1926:     *   grd_4c_Prorrog   <- GradeProrrog    ( 1 coluna,  SigChea)
1927:     *
1928:     * Geometria/fontes/larguras transcritas do dump do SCX legado. Top recebe
1929:     * a compensacao +29 do pgf_4c_Paginas.Top = -29.
1930:     * RecordSource/ControlSource NAO sao definidos aqui: os cursores so existem
1931:     * depois de CarregarDados, e ControlSource de cursor inexistente derruba o
1932:     * Init. O vinculo mora em VincularGrade*, chamado por CarregarDados.
1933:     *--------------------------------------------------------------------------
1934:     PROTECTED PROCEDURE ConfigurarGradesHistorico()
1935:         LOCAL loc_oPagina, loc_oErro
1936:         TRY
1937:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1938: 
1939:             *-- GradeCheque: Top=124 Left=8 Width=981 Height=228 (dump legado)
1940:             loc_oPagina.AddObject("grd_4c_Cheque", "Grid")
1941:             WITH loc_oPagina.grd_4c_Cheque
1942:                 .Top                = 124 + 29
1943:                 .Left               = 8
1944:                 .Width              = 981
1945:                 .Height             = 228
1946:                 .HeaderHeight       = 0
1947:                 .ColumnCount        = 12
1948:                 .FontName           = "Tahoma"
1949:                 .FontSize           = 8
1950:                 .RowHeight          = 18
1951:                 .ScrollBars         = 2
1952:                 .DeleteMark         = .F.
1953:                 .RecordMark         = .F.
1954:                 .ForeColor          = RGB(0, 0, 0)
1955:                 .BackColor          = RGB(255, 255, 255)
1956:                 .GridLineColor      = RGB(238, 238, 238)
1957:                 .HighlightBackColor = RGB(255, 255, 255)
1958:                 .HighlightForeColor = RGB(15, 41, 104)
1959:                 .HighlightStyle     = 2
1960:                 .ReadOnly           = .T.
1961:                 .Themes             = .F.
1962:                 .Visible            = .T.
1963:             ENDWITH
1964:             THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Cheque, 12)
1965: 
1966:             *-- Colunas 1..10 travadas (Movable/Resizable = .F. no dump); as
1967:             *-- colunas 11 e 12 nao declaram essas duas e ficam no default
1968:             WITH loc_oPagina.grd_4c_Cheque
1969:                 .Column1.Alignment        = 2
1970:                 .Column1.Text1.Alignment  = 2
1971:                 .Column6.InputMask        = "999,999,999.99"
1972:                 .Column12.Alignment       = 2
1973:                 .Column12.Text1.Alignment = 2
1974:                 .Column11.Movable         = .T.

*-- Linhas 1981 a 2024:
1981:             *-- persiste por toda a vida do form (so os Columns sao recriados a
1982:             *-- cada ColumnCount em VincularGradeCheque), por isso o bind e feito
1983:             *-- UMA vez aqui, nao a cada CarregarDados/VincularGradeCheque
1984:             BINDEVENT(loc_oPagina.grd_4c_Cheque, "AfterRowColChange", THIS, "GradeChequeAfterRowColChange")
1985: 
1986:             *-- GradeMovimenta: Top=359 Left=8 Width=858 Height=147 (dump legado)
1987:             loc_oPagina.AddObject("grd_4c_Movimenta", "Grid")
1988:             WITH loc_oPagina.grd_4c_Movimenta
1989:                 .Top                = 359 + 29
1990:                 .Left               = 8
1991:                 .Width              = 858
1992:                 .Height             = 147
1993:                 .HeaderHeight       = 0
1994:                 .ColumnCount        = 9
1995:                 .FontName           = "Tahoma"
1996:                 .FontSize           = 8
1997:                 .RowHeight          = 18
1998:                 .ScrollBars         = 2
1999:                 .DeleteMark         = .F.
2000:                 *-- RecordMark = .T. eh declaracao EXPLICITA do SCX legado -
2001:                 *-- GradeMovimenta eh a unica das tres grades que exibe a barra
2002:                 *-- de marcacao de registro (PILAR 1)
2003:                 .RecordMark         = .T.
2004:                 .ForeColor          = RGB(0, 0, 0)
2005:                 .BackColor          = RGB(255, 255, 255)
2006:                 .GridLineColor      = RGB(238, 238, 238)
2007:                 .HighlightBackColor = RGB(255, 255, 255)
2008:                 .HighlightForeColor = RGB(15, 41, 104)
2009:                 .HighlightStyle     = 2
2010:                 .ReadOnly           = .T.
2011:                 .Themes             = .F.
2012:                 .Visible            = .T.
2013:             ENDWITH
2014:             THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Movimenta, 9)
2015: 
2016:             *-- Conta/Origem alinhada a direita (Column5.Text1.Alignment = 3)
2017:             loc_oPagina.grd_4c_Movimenta.Column5.Text1.Alignment = 3
2018: 
2019:             *-- GradeProrrog: Top=359 Left=875 Width=114 Height=146 (dump legado)
2020:             loc_oPagina.AddObject("grd_4c_Prorrog", "Grid")
2021:             WITH loc_oPagina.grd_4c_Prorrog
2022:                 .Top                = 359 + 29
2023:                 .Left               = 875
2024:                 .Width              = 114

*-- Linhas 2045 a 2141:
2045:         CATCH TO loc_oErro
2046:             MsgErro(loc_oErro.Message + CHR(13) + ;
2047:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2048:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarGradesHistorico")
2049:         ENDTRY
2050:     ENDPROC
2051: 
2052:     *--------------------------------------------------------------------------
2053:     * FormatarGradeHistorico - Propriedades comuns a todas as colunas das
2054:     * grades do Historico (dump legado: Column<N> em Verdana 8, Text1 com
2055:     * BorderStyle = 0 / Margin = 0 / ForeColor 0,0,0 / BackColor 255,255,255 e
2056:     * Header1 em Tahoma 8 centralizado). Chamado uma vez por grade.
2057:     *--------------------------------------------------------------------------
2058:     PROTECTED PROCEDURE FormatarGradeHistorico(par_oGrade, par_nColunas)
2059:         LOCAL loc_nI, loc_oColuna
2060:         WITH par_oGrade
2061:             .FontName = "Verdana"
2062:             .FontSize = 8
2063:             .SetAll("Movable", .F., "Column")
2064:             .SetAll("Resizable", .F., "Column")
2065:         ENDWITH
2066: 
2067:         FOR loc_nI = 1 TO par_nColunas
2068:             loc_oColuna = par_oGrade.Columns(loc_nI)
2069:             WITH loc_oColuna.Header1
2070:                 .FontName  = "Tahoma"
2071:                 .FontSize  = 8
2072:                 .Alignment = 2
2073:                 .ForeColor = RGB(0, 0, 0)
2074:             ENDWITH
2075:             WITH loc_oColuna.Text1
2076:                 .FontName    = "Verdana"
2077:                 .FontSize    = 8
2078:                 .BorderStyle = 0
2079:                 .Margin      = 0
2080:                 .ForeColor   = RGB(0, 0, 0)
2081:                 .BackColor   = RGB(255, 255, 255)
2082:             ENDWITH
2083:         ENDFOR
2084:     ENDPROC
2085: 
2086:     *--------------------------------------------------------------------------
2087:     * ConfigurarBotoesHistorico - Cria as duas barras de botoes da Page2:
2088:     *   cmg_4c_Botoes <- Grupo_op     (8 botoes de acao sobre o cheque)
2089:     *   cmg_4c_Saida  <- Grupo_Saida  (Encerrar)
2090:     *
2091:     * Criadas DEPOIS do cnt_4c_Cabecalho (montado em ConfigurarContainersBase):
2092:     * as duas barras ficam na area da faixa do cabecalho (Top = 29) e precisam
2093:     * ser adicionadas por ultimo para desenhar POR CIMA dela.
2094:     * Geometria, caption, picture e tooltip de cada botao vem do dump do SCX
2095:     * legado; a numeracao Buttons(N) segue a numeracao Command<N> do dump.
2096:     * O Click da barra de saida eh ligado aqui, porque o Sair.Click legado eh
2097:     * autocontido. Os Click dos 8 botoes de Grupo_op abrem os formularios de
2098:     * detalhe (SigOpChr/SigOpChb/SigOpChp/SigOpFlp/SigOpChc/SigCdPgr) e sao
2099:     * ligados na fase de acoes.
2100:     *--------------------------------------------------------------------------
2101:     PROTECTED PROCEDURE ConfigurarBotoesHistorico()
2102:         LOCAL loc_oPagina, loc_oErro
2103:         TRY
2104:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2105: 
2106:             *-- Grupo_op: o dump traz AutoSize = .T.; aqui fica .F. com a
2107:             *-- Width/Height medidas do SCX (610x85), porque AutoSize em grupo
2108:             *-- criado por AddObject deixa a caixa dependente da ordem de
2109:             *-- atribuicao das propriedades dos membros
2110:             loc_oPagina.AddObject("cmg_4c_Botoes", "CommandGroup")
2111:             WITH loc_oPagina.cmg_4c_Botoes
2112:                 .AutoSize      = .F.
2113:                 .ButtonCount   = 8
2114:                 .Top           = 29
2115:                 .Left          = 30
2116:                 .Width         = 610
2117:                 .Height        = 85
2118:                 .BackStyle     = 0
2119:                 .BorderStyle   = 0
2120:                 .SpecialEffect = 1
2121:                 .BorderColor   = RGB(90, 90, 90)
2122:                 .Themes        = .F.
2123:                 .Value         = 0
2124:                 .Visible       = .T.
2125: 
2126:                 *-- Command1 = Relatorio
2127:                 WITH .Buttons(1)
2128:                     .Top             = 5
2129:                     .Left            = 230
2130:                     .Width           = 75
2131:                     .Height          = 75
2132:                     .Caption         = "Relat" + CHR(243) + "rio"
2133:                     .FontName        = "Comic Sans MS"
2134:                     .FontSize        = 8
2135:                     .ToolTipText     = "[F6] Relat" + CHR(243) + "rio"
2136:                     .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2137:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2138:                     .PicturePosition = 13
2139:                 ENDWITH
2140: 
2141:                 *-- Command2 = Procurar ("Busca")

*-- Linhas 2256 a 2536:
2256:             *-- indice (1-based) do botao acionado - despachado em CmgBotoesClick.
2257:             *-- O objeto cmg_4c_Botoes persiste (ButtonCount nao e reatribuido
2258:             *-- depois de criado), por isso o bind e feito uma unica vez aqui
2259:             BINDEVENT(loc_oPagina.cmg_4c_Botoes, "Click", THIS, "CmgBotoesClick")
2260: 
2261:             *-- Grupo_Saida: Left = 917 / Height = 85 com o botao Encerrar 75x75
2262:             *-- em 5,5 - padrao canonico de saida do sistema novo, que coincide
2263:             *-- com o dump legado (o dump traz Width = 85; canonico eh 90)
2264:             loc_oPagina.AddObject("cmg_4c_Saida", "CommandGroup")
2265:             WITH loc_oPagina.cmg_4c_Saida
2266:                 .AutoSize      = .F.
2267:                 .ButtonCount   = 1
2268:                 .Top           = 29
2269:                 .Left          = 917
2270:                 .Width         = 90
2271:                 .Height        = 85
2272:                 .BackStyle     = 0
2273:                 .BorderStyle   = 0
2274:                 .SpecialEffect = 1
2275:                 .BorderColor   = RGB(136, 189, 188)
2276:                 .Themes        = .F.
2277:                 .Value         = 1
2278:                 .Visible       = .T.
2279: 
2280:                 WITH .Buttons(1)
2281:                     .Top             = 5
2282:                     .Left            = 5
2283:                     .Width           = 75
2284:                     .Height          = 75
2285:                     .Caption         = "Encerrar"
2286:                     .FontName        = "Comic Sans MS"
2287:                     .FontSize        = 8
2288:                     .Cancel          = .T.
2289:                     .ToolTipText     = "<ESC> Sair"
2290:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2291:                     .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2292:                     .PicturePosition = 13
2293:                 ENDWITH
2294:             ENDWITH
2295: 
2296:             THIS.FormatarBotoesHistorico(loc_oPagina.cmg_4c_Saida, 1)
2297: 
2298:             BINDEVENT(loc_oPagina.cmg_4c_Saida, "Click", THIS, "CmgSaidaClick")
2299:         CATCH TO loc_oErro
2300:             MsgErro(loc_oErro.Message + CHR(13) + ;
2301:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2302:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarBotoesHistorico")
2303:         ENDTRY
2304:     ENDPROC
2305: 
2306:     *--------------------------------------------------------------------------
2307:     * FormatarBotoesHistorico - Fonte/cores comuns aos membros de um
2308:     * CommandGroup da Page2, transcritas do dump (Comic Sans MS 8 bold italic,
2309:     * ForeColor 90,90,90, BackColor branco, Themes = .F.)
2310:     *--------------------------------------------------------------------------
2311:     PROTECTED PROCEDURE FormatarBotoesHistorico(par_oGrupo, par_nBotoes)
2312:         LOCAL loc_nI
2313:         FOR loc_nI = 1 TO par_nBotoes
2314:             WITH par_oGrupo.Buttons(loc_nI)
2315:                 .FontName      = "Comic Sans MS"
2316:                 .FontSize      = 8
2317:                 .FontBold      = .T.
2318:                 .FontItalic    = .T.
2319:                 .ForeColor     = RGB(90, 90, 90)
2320:                 .BackColor     = RGB(255, 255, 255)
2321:                 .Themes        = .F.
2322:                 .SpecialEffect = 0
2323:                 .MousePointer  = 15
2324:                 .Visible       = .T.
2325:             ENDWITH
2326:         ENDFOR
2327:     ENDPROC
2328: 
2329:     *--------------------------------------------------------------------------
2330:     * AlternarPagina - FUNIL unico de troca entre Filtro (1) e Historico (2).
2331:     * O legado repete o mesmo bloco em tres lugares:
2332:     *   Init       -> .Historico.Enabled = .t. / .Filtro.Enabled = .f. / .ActivePage = 2
2333:     *   Ok.Click   -> idem + SqlDados + Procurar.Enabled = !Filtrado
2334:     *   Sair.Click -> .Filtro.Enabled = .t. / .Historico.Enabled = .f. / .ActivePage = 1
2335:     * Quem desabilita a pagina na ida reabilita na volta - aqui.
2336:     *--------------------------------------------------------------------------
2337:     PROCEDURE AlternarPagina(par_nPagina)
2338:         LOCAL loc_nPagina, loc_oErro
2339:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
2340: 
2341:         TRY
2342:             IF loc_nPagina = 2
2343:                 *-- Espelha "ThisForm.Filtrado = !Empty(Get_Conta.Value)"
2344:                 THIS.this_lFiltrado = ;
2345:                     !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c__Conta.Value))
2346:                 THIS.this_oBusinessObject.this_lFiltrado = THIS.this_lFiltrado
2347: 
2348:                 THIS.pgf_4c_Paginas.Page1.Enabled = .F.
2349:                 THIS.pgf_4c_Paginas.Page2.Enabled = .T.
2350:                 THIS.pgf_4c_Paginas.ActivePage    = 2
2351: 
2352:                 *-- Funil do estado dos botoes/campos (repoe o modo e reabilita
2353:                 *-- o que o caminho de ida desabilitou) e funil de carga
2354:                 *-- (FormParaBO -> CarregarDados -> Repintar). O Repintar fica
2355:                 *-- DEPOIS do ActivePage: Refresh em pagina oculta nao pinta.
2356:                 THIS.AjustarBotoesPorModo()
2357:                 THIS.CarregarLista()
2358:             ELSE
2359:                 THIS.pgf_4c_Paginas.Page2.Enabled = .F.
2360:                 THIS.pgf_4c_Paginas.Page1.Enabled = .T.
2361:                 THIS.pgf_4c_Paginas.ActivePage    = 1
2362: 
2363:                 *-- Caminho de VOLTA: sem esta chamada os botoes/campos que o
2364:                 *-- modo Historico ajustou ficariam no estado anterior
2365:                 THIS.AjustarBotoesPorModo()
2366: 
2367:                 IF THIS.Visible
2368:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c__Conta.SetFocus()
2369:                 ENDIF
2370:             ENDIF
2371:         CATCH TO loc_oErro
2372:             MsgErro(loc_oErro.Message + CHR(13) + ;
2373:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2374:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AlternarPagina")
2375:         ENDTRY
2376:     ENDPROC
2377: 
2378:     *--------------------------------------------------------------------------
2379:     * AjustarBotoesHistorico - Estado dos botoes de Grupo_op, transcrito do
2380:     * legado:
2381:     *   Init/Ok.Click -> .Grupo_op.Procurar.Enabled  = !ThisForm.Filtrado
2382:     *   Init          -> .Grupo_op.Protocolo.Enabled = fChecaAcesso('SigCheHI','PROTOCOLO')
2383:     * Buttons(2) = Procurar ("Busca"), Buttons(6) = Protocolo.
2384:     *--------------------------------------------------------------------------
2385:     PROCEDURE AjustarBotoesHistorico()
2386:         LOCAL loc_oGrupo, loc_oErro
2387:         TRY
2388:             loc_oGrupo = THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes
2389:             loc_oGrupo.Buttons(2).Enabled = !THIS.this_lFiltrado
2390:             loc_oGrupo.Buttons(6).Enabled = fChecaAcesso("SigCheHI", "PROTOCOLO")
2391:         CATCH TO loc_oErro
2392:             MsgErro(loc_oErro.Message + CHR(13) + ;
2393:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2394:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AjustarBotoesHistorico")
2395:         ENDTRY
2396:     ENDPROC
2397: 
2398:     *--------------------------------------------------------------------------
2399:     * CmgSaidaClick - Encerrar do Historico. Transcrito de Sair.Click: sem
2400:     * acesso irrestrito limpa os campos de Origem, volta ao Filtro e restaura
2401:     * o Caption; com acesso irrestrito fecha o formulario.
2402:     *--------------------------------------------------------------------------
2403:     PROCEDURE CmgSaidaClick()
2404:         IF !THIS.this_lAcesso
2405:             *-- LimparCampos zera Origem/Emitente no BO, restaura o periodo
2406:             *-- default e o Caption "Historico de Cheques", e espelha tudo na
2407:             *-- tela via BOParaForm - os tres passos que o Sair.Click legado
2408:             *-- faz a mao
2409:             THIS.LimparCampos()
2410:             THIS.AlternarPagina(1)
2411:         ELSE
2412:             THIS.Release()
2413:         ENDIF
2414:     ENDPROC
2415: 
2416:     *--------------------------------------------------------------------------
2417:     * FecharCursor - Fecha um alias com seguranca. TABLEREVERT EXIGE buffering
2418:     * (sem ele dispara erro 1586), por isso o CURSORGETPROP antes; USE IN fecha
2419:     * o alias mesmo com buffer sujo.
2420:     *--------------------------------------------------------------------------
2421:     PROTECTED PROCEDURE FecharCursor(par_cAlias)
2422:         IF VARTYPE(par_cAlias) = "C" AND !EMPTY(par_cAlias)
2423:             IF USED(par_cAlias)
2424:                 IF CURSORGETPROP("Buffering", par_cAlias) > 1
2425:                     TABLEREVERT(.T., par_cAlias)
2426:                 ENDIF
2427:                 USE IN (par_cAlias)
2428:             ENDIF
2429:         ENDIF
2430:     ENDPROC
2431: 
2432:     *--------------------------------------------------------------------------
2433:     * DesvincularGradesHistorico - Legado: as tres grades recebem
2434:     * RecordSource = ' ' no inicio do SqlDados, antes de os cursores serem
2435:     * refeitos
2436:     *--------------------------------------------------------------------------
2437:     PROTECTED PROCEDURE DesvincularGradesHistorico()
2438:         LOCAL loc_oPagina
2439:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2440:         loc_oPagina.grd_4c_Cheque.RecordSource    = ""
2441:         loc_oPagina.grd_4c_Movimenta.RecordSource = ""
2442:         loc_oPagina.grd_4c_Prorrog.RecordSource   = ""
2443:     ENDPROC
2444: 
2445:     *--------------------------------------------------------------------------
2446:     * RepintarGradesHistorico - Legado: Go Top In <cursor> + <grade>.Refresh.
2447:     * Popular o cursor NAO repinta a grade; e Refresh em pagina oculta nao
2448:     * pinta, por isso AlternarPagina chama este metodo DEPOIS de trocar o
2449:     * ActivePage.
2450:     *--------------------------------------------------------------------------
2451:     PROCEDURE RepintarGradesHistorico()
2452:         LOCAL loc_oPagina, loc_cAliasAnt, loc_oErro
2453:         TRY
2454:             loc_cAliasAnt = ALIAS()
2455:             loc_oPagina   = THIS.pgf_4c_Paginas.Page2
2456: 
2457:             IF USED("cursor_4c_Cheque")
2458:                 GO TOP IN cursor_4c_Cheque
2459:             ENDIF
2460:             IF USED("cursor_4c_Movimento")
2461:                 GO TOP IN cursor_4c_Movimento
2462:             ENDIF
2463:             IF USED("cursor_4c_Prorrog")
2464:                 GO TOP IN cursor_4c_Prorrog
2465:             ENDIF
2466: 
2467:             loc_oPagina.grd_4c_Cheque.Refresh()
2468:             loc_oPagina.grd_4c_Movimenta.Refresh()
2469:             loc_oPagina.grd_4c_Prorrog.Refresh()
2470: 
2471:             IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
2472:                 SELECT (loc_cAliasAnt)
2473:             ENDIF
2474:         CATCH TO loc_oErro
2475:             MsgErro(loc_oErro.Message + CHR(13) + ;
2476:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2477:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.RepintarGradesHistorico")
2478:         ENDTRY
2479:     ENDPROC
2480: 
2481:     *--------------------------------------------------------------------------
2482:     * CarregarDados - Transcricao do SqlDados legado.
2483:     *
2484:     * Monta os cursores do Historico e vincula as grades:
2485:     *   cursor_4c_Cheque    (SigChe + coluna Tipo) -> grd_4c_Cheque
2486:     *   cursor_4c_Movimento (SigCqChm)             -> grd_4c_Movimenta
2487:     *   cursor_4c_Prorrog   (SigChea)              -> grd_4c_Prorrog
2488:     *   cursor_4c_ChequeP   (auxiliar: Nums com historico em SigCheh - eh o
2489:     *                        'LocalChP' do legado, que marca a coluna Tipo)
2490:     * Os alias sao os declarados em SigOpChiBO.this_cCursor*.
2491:     *
2492:     * Cada SQLEXEC vai para cursor_4c_Temp e o alias definitivo eh recriado
2493:     * READWRITE a partir dele: SQLEXEC direto sobre o alias ligado a uma grade
2494:     * fecha e recria o alias, zerando o ColumnCount da grade.
2495:     *--------------------------------------------------------------------------
2496:     PROCEDURE CarregarDados()
2497:         LOCAL loc_lSucesso, loc_lModoTeste, loc_lOk, loc_oErro
2498:         LOCAL loc_dIni, loc_dFim, loc_tIni, loc_tFim
2499:         LOCAL loc_cConta, loc_cEmitente, loc_cFiltroEmi, loc_cNumCheque, loc_cAcesso
2500:         LOCAL loc_cSQLChe, loc_cSQLChP, loc_cSQLMov, loc_cSQLPro
2501:         loc_lSucesso = .F.
2502: 
2503:         loc_lModoTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
2504:                          (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
2505: 
2506:         *-- RETURN sempre FORA de TRY/CATCH
2507:         IF loc_lModoTeste OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
2508:             RETURN .F.
2509:         ENDIF
2510: 
2511:         TRY
2512:             loc_lOk = .T.
2513: 
2514:             *-- Legado: RecordSource = ' ' nas tres grades antes de refazer os
2515:             *-- cursores
2516:             THIS.DesvincularGradesHistorico()
2517: 
2518:             loc_dIni = ConverterParaData(THIS.this_oBusinessObject.this_dDataInicial)
2519:             loc_dFim = ConverterParaData(THIS.this_oBusinessObject.this_dDataFinal)
2520:             IF EMPTY(loc_dIni)
2521:                 loc_dIni = DATE()
2522:             ENDIF
2523:             IF EMPTY(loc_dFim)
2524:                 loc_dFim = CTOD("31/12/" + ALLTRIM(STR(YEAR(DATE()))))
2525:             ENDIF
2526:             *-- Legado: fDtoSQL(llDatai) e fDtoSQL(llDataf,'23:59:59')
2527:             loc_tIni = DTOT(loc_dIni)
2528:             loc_tFim = DTOT(loc_dFim) + 86399
2529: 
2530:             loc_cAcesso = ALLTRIM(UPPER(THIS.this_oBusinessObject.this_cAcesso))
2531:             *-- FONTE UNICA: a conta de origem vem da property que FormParaBO
2532:             *-- alimenta (CarregarLista chama FormParaBO antes deste metodo).
2533:             *-- Ler o TextBox aqui criaria um segundo caminho que divergiria do
2534:             *-- BO no primeiro ponto que mexesse so num dos dois.
2535:             loc_cConta  = ALLTRIM(THIS.this_oBusinessObject.this_cContaOrigem)
2536:             loc_cSQLChe = ""

*-- Linhas 2589 a 2632:
2589:             *-- ramos monta consulta - o legado nem chega aqui, porque o
2590:             *-- Ok.Click exige a conta antes de trocar de pagina
2591:             IF EMPTY(loc_cSQLChe)
2592:                 MsgAviso("Informe a conta de origem antes de consultar o " + ;
2593:                     "hist" + CHR(243) + "rico.", "Aten" + CHR(231) + CHR(227) + "o")
2594:                 loc_lOk = .F.
2595:             ENDIF
2596: 
2597:             *-- 1) cursor auxiliar: Nums que possuem historico em SigCheh
2598:             IF loc_lOk
2599:                 THIS.FecharCursor("cursor_4c_ChequeP")
2600:                 THIS.FecharCursor("cursor_4c_Temp")
2601:                 IF SQLEXEC(gnConnHandle, loc_cSQLChP, "cursor_4c_Temp") < 0
2602:                     MsgErro("Erro ao consultar o hist" + CHR(243) + "rico dos cheques." + ;
2603:                         CHR(13) + CapturarErroSQL(), "FormSigOpChi.CarregarDados")
2604:                     loc_lOk = .F.
2605:                 ELSE
2606:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_ChequeP READWRITE
2607:                     THIS.FecharCursor("cursor_4c_Temp")
2608:                     SELECT cursor_4c_ChequeP
2609:                     INDEX ON Nums TAG Nums
2610:                 ENDIF
2611:             ENDIF
2612: 
2613:             *-- 2) cursor principal da GradeCheque
2614:             IF loc_lOk
2615:                 THIS.FecharCursor("cursor_4c_Cheque")
2616:                 THIS.FecharCursor("cursor_4c_Temp")
2617:                 IF SQLEXEC(gnConnHandle, loc_cSQLChe, "cursor_4c_Temp") < 0
2618:                     MsgErro("Erro ao consultar os cheques." + CHR(13) + CapturarErroSQL(), ;
2619:                         "FormSigOpChi.CarregarDados")
2620:                     loc_lOk = .F.
2621:                 ELSE
2622:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Cheque READWRITE
2623:                     THIS.FecharCursor("cursor_4c_Temp")
2624:                 ENDIF
2625:             ENDIF
2626: 
2627:             *-- 3) marca com "S" o cheque que tem historico (legado: Scan +
2628:             *-- Seek em LocalChP + Replace Tipo With [S]) e cria os TAGs que a
2629:             *-- ordenacao por cabecalho de coluna usa
2630:             loc_cNumCheque = ""
2631:             IF loc_lOk
2632:                 SELECT cursor_4c_Cheque

*-- Linhas 2719 a 2774:
2719:         CATCH TO loc_oErro
2720:             MsgErro(loc_oErro.Message + CHR(13) + ;
2721:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2722:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.CarregarDados")
2723:         ENDTRY
2724: 
2725:         RETURN loc_lSucesso
2726:     ENDPROC
2727: 
2728:     *--------------------------------------------------------------------------
2729:     * VincularGradeCheque - ColumnCount -> RecordSource -> ControlSource ->
2730:     * Width -> Header1.Caption. A ordem eh obrigatoria: RecordSource recalcula
2731:     * as larguras das colunas para o default, entao Width e caption vem por
2732:     * ultimo. ControlSource e DynamicFore/BackColor transcritos do SqlDados.
2733:     *--------------------------------------------------------------------------
2734:     PROTECTED PROCEDURE VincularGradeCheque()
2735:         LOCAL loc_oGrade
2736:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
2737: 
2738:         WITH loc_oGrade
2739:             .ColumnCount  = 12
2740:             .RecordSource = "cursor_4c_Cheque"
2741: 
2742:             .Column1.ControlSource  = "TTOD(cursor_4c_Cheque.Vencs)"
2743:             .Column2.ControlSource  = "cursor_4c_Cheque.Bancos"
2744:             .Column3.ControlSource  = "cursor_4c_Cheque.Agencias"
2745:             .Column4.ControlSource  = "cursor_4c_Cheque.nContas"
2746:             .Column5.ControlSource  = "cursor_4c_Cheque.nCheques"
2747:             .Column6.ControlSource  = "cursor_4c_Cheque.Valors"
2748:             .Column7.ControlSource  = "cursor_4c_Cheque.GruCarts"
2749:             .Column8.ControlSource  = "cursor_4c_Cheque.ConCarts"
2750:             .Column9.ControlSource  = "cursor_4c_Cheque.Emps"
2751:             .Column10.ControlSource = "cursor_4c_Cheque.Numeros"
2752:             .Column11.ControlSource = "cursor_4c_Cheque.UMovs"
2753:             .Column12.ControlSource = "TTOD(cursor_4c_Cheque.DtEmis)"
2754: 
2755:             .Column1.Width  = 80
2756:             .Column2.Width  = 35
2757:             .Column3.Width  = 49
2758:             .Column4.Width  = 90
2759:             .Column5.Width  = 60
2760:             .Column6.Width  = 115
2761:             .Column7.Width  = 95
2762:             .Column8.Width  = 95
2763:             .Column9.Width  = 31
2764:             .Column10.Width = 58
2765:             .Column11.Width = 150
2766:             .Column12.Width = 80
2767: 
2768:             .Column1.Header1.Caption  = "Vencimento"
2769:             .Column2.Header1.Caption  = "Bco"
2770:             .Column3.Header1.Caption  = "Ag" + CHR(234) + "ncia"
2771:             .Column4.Header1.Caption  = "Conta"
2772:             .Column5.Header1.Caption  = "N" + CHR(250) + "mero"
2773:             .Column6.Header1.Caption  = "Valor"
2774:             .Column7.Header1.Caption  = "Grupo Carteira"

*-- Linhas 2803 a 2859:
2803:             *-- RECRIADOS a cada atribuicao de ColumnCount (regra #183), por
2804:             *-- isso o bind tem de ser refeito aqui, a cada chamada, e nao em
2805:             *-- ConfigurarGradesHistorico (que so roda uma vez)
2806:             BINDEVENT(.Column1.Header1, "Click", THIS, "GradeChequeHeader1Click")
2807:             BINDEVENT(.Column2.Header1, "Click", THIS, "GradeChequeHeader2Click")
2808:             BINDEVENT(.Column3.Header1, "Click", THIS, "GradeChequeHeader3Click")
2809:             BINDEVENT(.Column4.Header1, "Click", THIS, "GradeChequeHeader4Click")
2810:             BINDEVENT(.Column5.Header1, "Click", THIS, "GradeChequeHeader5Click")
2811:             BINDEVENT(.Column6.Header1, "Click", THIS, "GradeChequeHeader6Click")
2812:         ENDWITH
2813:     ENDPROC
2814: 
2815:     *--------------------------------------------------------------------------
2816:     * VincularGradeMovimenta - ControlSource/Width/Caption de GradeMovimenta
2817:     * (SigCqChm), transcritos do SqlDados e do dump legado
2818:     *--------------------------------------------------------------------------
2819:     PROTECTED PROCEDURE VincularGradeMovimenta()
2820:         LOCAL loc_oGrade
2821:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Movimenta
2822: 
2823:         WITH loc_oGrade
2824:             .ColumnCount  = 9
2825:             .RecordSource = "cursor_4c_Movimento"
2826: 
2827:             .Column1.ControlSource = "cursor_4c_Movimento.Codigos"
2828:             .Column2.ControlSource = "cursor_4c_Movimento.Nalineas"
2829:             .Column3.ControlSource = "TTOD(cursor_4c_Movimento.DtEnts)"
2830:             .Column4.ControlSource = "cursor_4c_Movimento.GruOrigs"
2831:             .Column5.ControlSource = "cursor_4c_Movimento.ConOrigs"
2832:             .Column6.ControlSource = "cursor_4c_Movimento.Grupos"
2833:             .Column7.ControlSource = "cursor_4c_Movimento.Contas"
2834:             .Column8.ControlSource = "cursor_4c_Movimento.NumLotes"
2835:             .Column9.ControlSource = "cursor_4c_Movimento.Protocolos"
2836: 
2837:             .Column1.Width = 157
2838:             .Column2.Width = 40
2839:             .Column3.Width = 80
2840:             .Column4.Width = 90
2841:             .Column5.Width = 90
2842:             .Column6.Width = 90
2843:             .Column7.Width = 90
2844:             .Column8.Width = 90
2845:             .Column9.Width = 90
2846: 
2847:             .Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2848:             .Column2.Header1.Caption = "Alinea"
2849:             .Column3.Header1.Caption = "Entrada"
2850:             .Column4.Header1.Caption = "Grupo/Origem"
2851:             .Column5.Header1.Caption = "Conta/Origem"
2852:             .Column6.Header1.Caption = "Grupo/Destino"
2853:             .Column7.Header1.Caption = "Conta/Destino"
2854:             .Column8.Header1.Caption = "Lote"
2855:             .Column9.Header1.Caption = "Protocolo"
2856: 
2857:             *-- Dump legado: Column8 e Column9 declaram apenas Movable = .F.;
2858:             *-- so as sete primeiras travam tambem o Resizable
2859:             .Column8.Resizable = .T.

*-- Linhas 2865 a 2990:
2865:     * VincularGradeProrrog - ControlSource/Width/Caption de GradeProrrog
2866:     * (SigChea - vencimentos das prorrogacoes do cheque corrente)
2867:     *--------------------------------------------------------------------------
2868:     PROTECTED PROCEDURE VincularGradeProrrog()
2869:         LOCAL loc_oGrade
2870:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Prorrog
2871: 
2872:         WITH loc_oGrade
2873:             .ColumnCount             = 1
2874:             .RecordSource            = "cursor_4c_Prorrog"
2875:             .Column1.ControlSource   = "TTOD(cursor_4c_Prorrog.Vencs)"
2876:             .Column1.Width           = 83
2877:             .Column1.Header1.Caption = "Prorroga" + CHR(231) + CHR(245) + "es"
2878:         ENDWITH
2879:     ENDPROC
2880: 
2881:     *--------------------------------------------------------------------------
2882:     * IndexarCursorCheque - Os dez TAGs + SET ORDER usados por CarregarDados
2883:     * (carga inicial) e por AcaoProcurarClick (mescla dos cheques encontrados
2884:     * pelo dialogo de busca). Fatorado para nao duplicar o bloco em dois
2885:     * lugares - mesmas dez expressoes do SqlDados legado.
2886:     *--------------------------------------------------------------------------
2887:     PROTECTED PROCEDURE IndexarCursorCheque()
2888:         SELECT cursor_4c_Cheque
2889:         INDEX ON DTOS(Vencs) + Bancos + Agencias + nContas + nCheques TAG Venc
2890:         INDEX ON Bancos + Agencias + nContas + nCheques TAG Cheque
2891:         INDEX ON Agencias + nContas + nCheques TAG Agencia
2892:         INDEX ON Agencias + nContas TAG AgenciaCta
2893:         INDEX ON Agencias + nCheques TAG AgenciaChe
2894:         INDEX ON nContas + nCheques TAG Conta
2895:         INDEX ON nCheques TAG NCheque
2896:         INDEX ON STR(Valors, 12, 2) + Bancos + Agencias + nContas + nCheques TAG Valor
2897:         INDEX ON Numeros TAG Numeros
2898:         INDEX ON Nums TAG Nums
2899:         SET ORDER TO Venc
2900:     ENDPROC
2901: 
2902:     *--------------------------------------------------------------------------
2903:     * ConfigurarCursorProtocolo - Cursor local usado por AcaoProtocoloClick,
2904:     * equivalente ao "Create Cursor TempChq" que o Init legado executa uma
2905:     * unica vez. Chamado uma vez em InicializarForm.
2906:     *--------------------------------------------------------------------------
2907:     PROTECTED PROCEDURE ConfigurarCursorProtocolo()
2908:         LOCAL loc_oErro
2909:         TRY
2910:             IF !USED("cursor_4c_Protocolo")
2911:                 CREATE CURSOR cursor_4c_Protocolo (Bancos C(3), Agencias C(4), ;
2912:                     NContas C(10), NCheques C(6), Vencs D NULL, Valors N(12, 2), ;
2913:                     Emps C(3), Iclis C(10), Grclis C(10), Contas C(10), ;
2914:                     Grupos C(10), ValPags N(12, 2), Nums C(8), Protocolos C(8), Obss M)
2915:                 INDEX ON Bancos + Agencias + NContas + NCheques TAG Cheque
2916:             ENDIF
2917:         CATCH TO loc_oErro
2918:             MsgErro(loc_oErro.Message + CHR(13) + ;
2919:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2920:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarCursorProtocolo")
2921:         ENDTRY
2922:     ENDPROC
2923: 
2924:     *--------------------------------------------------------------------------
2925:     * ExigirChequeSelecionado - Guarda comum aos 8 botoes de cmg_4c_Botoes:
2926:     * nenhum deles tem sentido sem uma linha corrente em cursor_4c_Cheque (o
2927:     * legado presume que a grade sempre tem o cheque corrente porque o Init/
2928:     * SqlDados so chega aqui com Reccount > 0 - aqui a lista pode ficar vazia
2929:     * e os botoes continuam clicaveis)
2930:     *--------------------------------------------------------------------------
2931:     PROTECTED FUNCTION ExigirChequeSelecionado()
2932:         IF !USED("cursor_4c_Cheque") OR RECCOUNT("cursor_4c_Cheque") = 0 OR ;
2933:                 EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cNums))
2934:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
2935:             RETURN .F.
2936:         ENDIF
2937:         RETURN .T.
2938:     ENDFUNC
2939: 
2940:     *--------------------------------------------------------------------------
2941:     * AtualizarEstadoChequeAtual - Recalcula, para o cheque CORRENTE de
2942:     * cursor_4c_Cheque, tudo que o legado recalcula em GradeCheque.
2943:     * AfterRowColChange: BO (CarregarDoCursor), Caption (so quando Acesso eh
2944:     * TOTAL/CARTEIRA - no filtro restrito o Caption ja foi fixado por
2945:     * CmdOkClick e nao muda por linha), Documento.Enabled (ChkRegister
2946:     * SigCdPgr/SigMvCab x2), Carteira.Enabled (ChkRegister SIGCCCHM) e o
2947:     * texto do ultimo Followup (SigCheh). ChkRegister nao existe na nova
2948:     * arquitetura (regra do projeto) - substituido por SELECT COUNT(*).
2949:     *--------------------------------------------------------------------------
2950:     PROTECTED PROCEDURE AtualizarEstadoChequeAtual()
2951:         LOCAL loc_cEmpr, loc_cDope, loc_nNume, loc_cKey1, loc_cKey2, loc_nResultado, ;
2952:               loc_lDocEnab, loc_lCartEnab, loc_cHist, loc_cRclis, loc_cCpfs, loc_oErro
2953: 
2954:         IF !USED("cursor_4c_Cheque") OR EOF("cursor_4c_Cheque")
2955:             RETURN
2956:         ENDIF
2957: 
2958:         TRY
2959:             SELECT cursor_4c_Cheque
2960:             THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Cheque")
2961: 
2962:             *-- Caption (legado: ramo "If ThisForm.Acesso")
2963:             IF THIS.this_lAcesso
2964:                 loc_cRclis = ""
2965:                 loc_cCpfs  = ""
2966:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2967:                     "SELECT TOP 1 Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + ;
2968:                     EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cIClis)), "cursor_4c_CliCaption")
2969:                 IF loc_nResultado > 0 AND USED("cursor_4c_CliCaption") AND !EOF("cursor_4c_CliCaption")
2970:                     loc_cRclis = ALLTRIM(cursor_4c_CliCaption.Rclis)
2971:                     loc_cCpfs  = ALLTRIM(cursor_4c_CliCaption.Cpfs)
2972:                 ENDIF
2973:                 THIS.FecharCursor("cursor_4c_CliCaption")
2974:                 *-- Caption guardado no BO (this_cCaptionAtual eh a fonte unica
2975:                 *-- que BOParaForm espelha ao recarregar a tela)
2976:                 THIS.this_oBusinessObject.this_cCaptionAtual = ;
2977:                     "Hist" + CHR(243) + "rico de Cheques de: " + ;
2978:                     ALLTRIM(THIS.this_oBusinessObject.this_cIClis) + " - " + loc_cRclis + " / " + loc_cCpfs
2979:                 THIS.Caption = THIS.this_oBusinessObject.this_cCaptionAtual
2980:             ENDIF
2981: 
2982:             *-- Documento.Enabled (legado: Do Case com ChkRegister('SigCdPgr',
2983:             *-- laCampo1) / ChkRegister('SigMvCab', laCampo3 - EmpDopNums
2984:             *-- recalculado) / ChkRegister('SigMvCab', laCampo4 - EmpDopNums
2985:             *-- do proprio registro de SigCqChm)
2986:             loc_lDocEnab = .F.
2987:             IF USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
2988:                 loc_cEmpr = THIS.this_oBusinessObject.this_cEmps
2989:                 loc_cDope = cursor_4c_Movimento.Dopes
2990:                 loc_nNume = cursor_4c_Movimento.NumDopes

*-- Linhas 3044 a 4064:
3044:             THIS.FecharCursor("cursor_4c_FollowupVal")
3045:             *-- Fonte unica no BO; a tela espelha (BOParaForm faz o mesmo ao
3046:             *-- recarregar, para o campo nao "esquecer" o texto)
3047:             THIS.this_oBusinessObject.this_cUltimoFollowup = loc_cHist
3048:             THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.Value = loc_cHist
3049:         CATCH TO loc_oErro
3050:             MsgErro(loc_oErro.Message + CHR(13) + ;
3051:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3052:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AtualizarEstadoChequeAtual")
3053:         ENDTRY
3054:     ENDPROC
3055: 
3056:     *--------------------------------------------------------------------------
3057:     * GradeChequeAfterRowColChange - Transcricao do AfterRowColChange de
3058:     * GradeCheque: ao mudar a linha corrente, refaz Movimento/Prorrog para o
3059:     * Nums da NOVA linha e recalcula Documento/Carteira/Followup/Caption
3060:     * (AtualizarEstadoChequeAtual). Dispara tambem na ligacao inicial do
3061:     * RecordSource (VincularGradeCheque), cobrindo o cheque do GO TOP.
3062:     *--------------------------------------------------------------------------
3063:     PROCEDURE GradeChequeAfterRowColChange(par_nColIndex)
3064:         LOCAL loc_cNums, loc_cSQLMov, loc_cSQLPro, loc_oPagina, loc_oErro
3065: 
3066:         IF !USED("cursor_4c_Cheque") OR EOF("cursor_4c_Cheque")
3067:             RETURN
3068:         ENDIF
3069: 
3070:         loc_cNums   = cursor_4c_Cheque.Nums
3071:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
3072: 
3073:         TRY
3074:             *-- Legado: RecordSource = " " antes de refazer os cursores
3075:             loc_oPagina.grd_4c_Movimenta.RecordSource = ""
3076:             loc_oPagina.grd_4c_Prorrog.RecordSource   = ""
3077: 
3078:             loc_cSQLMov = "SELECT * FROM SigCqChm WHERE Nums = " + EscaparSQL(loc_cNums) + ;
3079:                 " ORDER BY Nums, Dtsis DESC"
3080:             loc_cSQLPro = "SELECT * FROM SigChea WHERE Nums = " + EscaparSQL(loc_cNums)
3081: 
3082:             THIS.FecharCursor("cursor_4c_Movimento")
3083:             THIS.FecharCursor("cursor_4c_Temp")
3084:             IF SQLEXEC(gnConnHandle, loc_cSQLMov, "cursor_4c_Temp") < 0
3085:                 MsgErro("Erro ao consultar a movimenta" + CHR(231) + CHR(227) + ;
3086:                     "o do cheque." + CHR(13) + CapturarErroSQL(), ;
3087:                     "FormSigOpChi.GradeChequeAfterRowColChange")
3088:             ELSE
3089:                 SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Movimento READWRITE
3090:             ENDIF
3091:             THIS.FecharCursor("cursor_4c_Temp")
3092: 
3093:             THIS.FecharCursor("cursor_4c_Prorrog")
3094:             THIS.FecharCursor("cursor_4c_Temp")
3095:             IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_Temp") < 0
3096:                 MsgErro("Erro ao consultar as prorroga" + CHR(231) + CHR(245) + ;
3097:                     "es do cheque." + CHR(13) + CapturarErroSQL(), ;
3098:                     "FormSigOpChi.GradeChequeAfterRowColChange")
3099:             ELSE
3100:                 SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Prorrog READWRITE
3101:             ENDIF
3102:             THIS.FecharCursor("cursor_4c_Temp")
3103: 
3104:             THIS.VincularGradeMovimenta()
3105:             THIS.VincularGradeProrrog()
3106:             THIS.AtualizarEstadoChequeAtual()
3107:             THIS.RepintarGradesHistorico()
3108:         CATCH TO loc_oErro
3109:             MsgErro(loc_oErro.Message + CHR(13) + ;
3110:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3111:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.GradeChequeAfterRowColChange")
3112:         ENDTRY
3113:     ENDPROC
3114: 
3115:     *--------------------------------------------------------------------------
3116:     * OrdenarGradeCheque / GradeChequeHeader<N>Click - Transcricao dos SEIS
3117:     * Header1.Click do dump legado (Column1..Column6): reindexa pelo TAG da
3118:     * coluna preservando o registro corrente (legado: _Recno = Recno() / Set
3119:     * Order to &lcOrd. / Go _Recno) e realca o cabecalho clicado em verde
3120:     * claro, os outros cinco em cinza. Colunas 7..12 nao tem Header1.Click no
3121:     * legado. Header1.Click nao recebe parametro nenhum do VFP - por isso sao
3122:     * SEIS wrappers PUBLIC (alvo de BINDEVENT), cada um chamando o metodo
3123:     * compartilhado com a coluna fixa.
3124:     *--------------------------------------------------------------------------
3125:     PROTECTED PROCEDURE OrdenarGradeCheque(par_nColuna)
3126:         LOCAL loc_cOrd, loc_oGrade, loc_nI, loc_nRecno, loc_oErro
3127: 
3128:         IF !USED("cursor_4c_Cheque")
3129:             RETURN
3130:         ENDIF
3131: 
3132:         loc_cOrd = ""
3133:         DO CASE
3134:             CASE par_nColuna = 1
3135:                 loc_cOrd = "Venc"
3136:             CASE par_nColuna = 2
3137:                 loc_cOrd = "Cheque"
3138:             CASE par_nColuna = 3
3139:                 loc_cOrd = "Agencia"
3140:             CASE par_nColuna = 4
3141:                 loc_cOrd = "Conta"
3142:             CASE par_nColuna = 5
3143:                 loc_cOrd = "NCheque"
3144:             CASE par_nColuna = 6
3145:                 loc_cOrd = "Valor"
3146:         ENDCASE
3147:         IF EMPTY(loc_cOrd)
3148:             RETURN
3149:         ENDIF
3150: 
3151:         TRY
3152:             loc_nRecno = RECNO("cursor_4c_Cheque")
3153:             SELECT cursor_4c_Cheque
3154:             SET ORDER TO (loc_cOrd)
3155:             IF BETWEEN(loc_nRecno, 1, RECCOUNT())
3156:                 GO RECORD (loc_nRecno)
3157:             ENDIF
3158: 
3159:             loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
3160:             FOR loc_nI = 1 TO 6
3161:                 loc_oGrade.Columns(loc_nI).Header1.BackColor = ;
3162:                     IIF(loc_nI = par_nColuna, RGB(220, 255, 220), RGB(192, 192, 192))
3163:             ENDFOR
3164:             loc_oGrade.Refresh()
3165:         CATCH TO loc_oErro
3166:             MsgErro(loc_oErro.Message + CHR(13) + ;
3167:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3168:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.OrdenarGradeCheque")
3169:         ENDTRY
3170:     ENDPROC
3171: 
3172:     PROCEDURE GradeChequeHeader1Click()
3173:         THIS.OrdenarGradeCheque(1)
3174:     ENDPROC
3175: 
3176:     PROCEDURE GradeChequeHeader2Click()
3177:         THIS.OrdenarGradeCheque(2)
3178:     ENDPROC
3179: 
3180:     PROCEDURE GradeChequeHeader3Click()
3181:         THIS.OrdenarGradeCheque(3)
3182:     ENDPROC
3183: 
3184:     PROCEDURE GradeChequeHeader4Click()
3185:         THIS.OrdenarGradeCheque(4)
3186:     ENDPROC
3187: 
3188:     PROCEDURE GradeChequeHeader5Click()
3189:         THIS.OrdenarGradeCheque(5)
3190:     ENDPROC
3191: 
3192:     PROCEDURE GradeChequeHeader6Click()
3193:         THIS.OrdenarGradeCheque(6)
3194:     ENDPROC
3195: 
3196:     *--------------------------------------------------------------------------
3197:     * CmgBotoesClick - Despachante unico do CommandGroup cmg_4c_Botoes
3198:     * (Grupo_op legado). .Value do CommandGroup eh o indice (1-based) do
3199:     * botao que disparou o Click, na mesma numeracao Buttons(N) usada em
3200:     * ConfigurarBotoesHistorico (Command1..Command8 do dump).
3201:     *--------------------------------------------------------------------------
3202:     PROCEDURE CmgBotoesClick()
3203:         LOCAL loc_nBotao
3204:         loc_nBotao = THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes.Value
3205: 
3206:         DO CASE
3207:             CASE loc_nBotao = 1
3208:                 THIS.AcaoRelatorioClick()
3209:             CASE loc_nBotao = 2
3210:                 THIS.AcaoProcurarClick()
3211:             CASE loc_nBotao = 3
3212:                 THIS.AcaoProrrogaClick()
3213:             CASE loc_nBotao = 4
3214:                 THIS.AcaoFollowUpClick()
3215:             CASE loc_nBotao = 5
3216:                 THIS.AcaoCarteiraClick()
3217:             CASE loc_nBotao = 6
3218:                 THIS.AcaoProtocoloClick()
3219:             CASE loc_nBotao = 7
3220:                 THIS.AcaoDocumentoClick()
3221:             CASE loc_nBotao = 8
3222:                 THIS.AcaoFollowUpChqClick()
3223:         ENDCASE
3224:     ENDPROC
3225: 
3226:     *--------------------------------------------------------------------------
3227:     * AcaoRelatorioClick - Buttons(1) "Relatorio" ([F6]). Legado: "Do Form
3228:     * SigOpChr With crSigChe.GrClis, crSigChe.IClis, ThisForm". SigOpChr
3229:     * ainda nao foi migrado (sem SCX no acervo desta task) - a acao e
3230:     * tentada de verdade e so degrada com aviso se a classe nao existir.
3231:     *--------------------------------------------------------------------------
3232:     PROCEDURE AcaoRelatorioClick()
3233:         LOCAL loc_oForm, loc_oErro
3234: 
3235:         IF !THIS.ExigirChequeSelecionado()
3236:             RETURN
3237:         ENDIF
3238: 
3239:         TRY
3240:             loc_oForm = CREATEOBJECT("FormSigOpChr", THIS.this_oBusinessObject.this_cGrClis, ;
3241:                 THIS.this_oBusinessObject.this_cIClis, THIS)
3242:             IF VARTYPE(loc_oForm) = "O"
3243:                 loc_oForm.Show()
3244:             ENDIF
3245:         CATCH TO loc_oErro
3246:             MsgAviso("Tela de Relat" + CHR(243) + "rio do Hist" + CHR(243) + "rico (SigOpChr) " + ;
3247:                 "ainda n" + CHR(227) + "o foi migrada.", "Indispon" + CHR(237) + "vel")
3248:         ENDTRY
3249:     ENDPROC
3250: 
3251:     *--------------------------------------------------------------------------
3252:     * AcaoProcurarClick - Buttons(2) "Busca" ([F5]). Legado: "Do Form
3253:     * SigOpChb With Thisform.LeCheque, Thisform.ChqLido, Thisform.Leitor,
3254:     * ThisForm" + Refresh + SetFocus na grade. SIGOPCHI nunca declara/usa as
3255:     * tres propriedades do leitor de codigo de barras (varredura do dump:
3256:     * zero ocorrencias fora desta chamada) - chegam sempre em .F./""/.F.,
3257:     * entao e isso que se passa aqui. FormSigOpChb (ja migrado) devolve o
3258:     * resultado da busca em cursor_4c_SigChe (Hide, nao Release - o
3259:     * CHAMADOR le o cursor e so depois libera o dialogo).
3260:     *--------------------------------------------------------------------------
3261:     PROCEDURE AcaoProcurarClick()
3262:         LOCAL loc_oBusca, loc_oGrid, loc_cNums, loc_oErro
3263: 
3264:         TRY
3265:             loc_oBusca = CREATEOBJECT("FormSigOpChb", .F., "", .F., THIS)
3266:             IF VARTYPE(loc_oBusca) = "O"
3267:                 loc_oBusca.Show()
3268: 
3269:                 IF USED("cursor_4c_SigChe") AND RECCOUNT("cursor_4c_SigChe") > 0 AND ;
3270:                         USED("cursor_4c_Cheque")
3271:                     SELECT cursor_4c_SigChe
3272:                     SCAN
3273:                         loc_cNums = Nums
3274:                         IF !SEEK(loc_cNums, "cursor_4c_Cheque", "Nums")
3275:                             SCATTER MEMVAR MEMO
3276:                             SELECT cursor_4c_Cheque
3277:                             APPEND BLANK
3278:                             GATHER MEMVAR MEMO
3279:                             REPLACE Tipo WITH IIF(USED("cursor_4c_ChequeP") AND ;
3280:                                 SEEK(loc_cNums, "cursor_4c_ChequeP", "Nums"), "S", " ")
3281:                         ENDIF
3282:                         SELECT cursor_4c_SigChe
3283:                     ENDSCAN
3284: 
3285:                     THIS.IndexarCursorCheque()
3286:                     SELECT cursor_4c_Cheque
3287:                     GO TOP
3288:                     THIS.AtualizarEstadoChequeAtual()
3289:                     THIS.RepintarGradesHistorico()
3290:                 ENDIF
3291: 
3292:                 loc_oBusca.Release()
3293:             ENDIF
3294:         CATCH TO loc_oErro
3295:             MsgErro(loc_oErro.Message + CHR(13) + ;
3296:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3297:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoProcurarClick")
3298:         ENDTRY
3299: 
3300:         *-- Legado: ThisForm.Pagina.Historico.Refresh + GradeCheque.SetFocus +
3301:         *-- GradeCheque.Column1.Text1.SetFocus
3302:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
3303:         THIS.pgf_4c_Paginas.Page2.Refresh()
3304:         loc_oGrid.SetFocus()
3305:         loc_oGrid.Column1.Text1.SetFocus()
3306:     ENDPROC
3307: 
3308:     *--------------------------------------------------------------------------
3309:     * AcaoProrrogaClick - Buttons(3) "Prorroga" ([F7]). Legado: Seek em
3310:     * crSigCdOpt (Operacaos = CrSigChe.Umovs); bloqueia com aviso se
3311:     * Tipos = "CR" e Prorrogas <> 1; senao "Do Form SigOpChp With ThisForm".
3312:     * crSigCdOpt nao existe como cursor global nesta migracao - substituido
3313:     * por SELECT direto em SigCdOpt. SigOpChp ainda nao foi migrado.
3314:     *--------------------------------------------------------------------------
3315:     PROCEDURE AcaoProrrogaClick()
3316:         LOCAL loc_nResultado, loc_cTipos, loc_nProrrogas, loc_lPode, loc_oForm, loc_oErro
3317: 
3318:         IF !THIS.ExigirChequeSelecionado()
3319:             RETURN
3320:         ENDIF
3321: 
3322:         loc_lPode = .T.
3323:         TRY
3324:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3325:                 "SELECT TOP 1 Tipos, Prorrogas FROM SigCdOpt WHERE Operacaos = " + ;
3326:                 EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cUMovs)), "cursor_4c_OptVal")
3327:             IF loc_nResultado > 0 AND USED("cursor_4c_OptVal") AND !EOF("cursor_4c_OptVal")
3328:                 loc_cTipos     = ALLTRIM(cursor_4c_OptVal.Tipos)
3329:                 loc_nProrrogas = NVL(cursor_4c_OptVal.Prorrogas, 0)
3330:                 IF loc_cTipos == "CR" AND loc_nProrrogas != 1
3331:                     MsgAviso("Imposs" + CHR(237) + "vel prorrogar cheques que n" + CHR(227) + ;
3332:                         "o estejam pendentes...", "Aten" + CHR(231) + CHR(227) + "o!!!")
3333:                     loc_lPode = .F.
3334:                 ENDIF
3335:             ENDIF
3336:             THIS.FecharCursor("cursor_4c_OptVal")
3337:         CATCH TO loc_oErro
3338:             MsgErro(loc_oErro.Message, "Erro")
3339:             loc_lPode = .F.
3340:         ENDTRY
3341: 
3342:         IF !loc_lPode
3343:             RETURN
3344:         ENDIF
3345: 
3346:         TRY
3347:             loc_oForm = CREATEOBJECT("FormSigOpChp", THIS)
3348:             IF VARTYPE(loc_oForm) = "O"
3349:                 loc_oForm.Show()
3350:             ENDIF
3351:         CATCH TO loc_oErro
3352:             MsgAviso("Tela de Prorroga" + CHR(231) + CHR(227) + "o de Cheques (SigOpChp) " + ;
3353:                 "ainda n" + CHR(227) + "o foi migrada.", "Indispon" + CHR(237) + "vel")
3354:         ENDTRY
3355:     ENDPROC
3356: 
3357:     *--------------------------------------------------------------------------
3358:     * AcaoFollowUpClick - Buttons(4) "Followup Clientes" ([F8]). Legado: usa
3359:     * a conta do FILTRO (Pagina.Filtro.Origem.Get_Conta) se preenchida, senao
3360:     * cai para CrSigChe.Iclis do cheque corrente; "do Form SigOpFlp With
3361:     * lcCliente, ThisForm.DatasessionId". SigOpFlp ainda nao foi migrado.
3362:     *--------------------------------------------------------------------------
3363:     PROCEDURE AcaoFollowUpClick()
3364:         LOCAL loc_cCliente, loc_oForm, loc_oErro
3365: 
3366:         loc_cCliente = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c__Conta.Value)
3367:         IF EMPTY(loc_cCliente)
3368:             IF !THIS.ExigirChequeSelecionado()
3369:                 RETURN
3370:             ENDIF
3371:             loc_cCliente = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
3372:         ENDIF
3373: 
3374:         TRY
3375:             loc_oForm = CREATEOBJECT("FormSigOpFlp", loc_cCliente, THIS.DataSessionId)
3376:             IF VARTYPE(loc_oForm) = "O"
3377:                 loc_oForm.Show()
3378:             ENDIF
3379:         CATCH TO loc_oErro
3380:             MsgAviso("Tela de Followup de Clientes (SigOpFlp) ainda n" + CHR(227) + ;
3381:                 "o foi migrada.", "Indispon" + CHR(237) + "vel")
3382:         ENDTRY
3383:     ENDPROC
3384: 
3385:     *--------------------------------------------------------------------------
3386:     * AcaoCarteiraClick - Buttons(5) "Carteira" ([F11]). Legado: "do Form
3387:     * SigOpChc With ThisForm" + atualiza a grade depois da baixa (comentario
3388:     * do legado: "chama o metodo abaixo para atualizar a grade" via
3389:     * cnt_periodo.dt_final.Valid, aqui pelo funil THIS.CarregarLista()).
3390:     * FormSigOpChc JA FOI MIGRADO (Init recebe o form pai e o Nums do cheque
3391:     * corrente - exatamente o par que este botao fornece).
3392:     *--------------------------------------------------------------------------
3393:     PROCEDURE AcaoCarteiraClick()
3394:         LOCAL loc_oForm, loc_oErro
3395: 
3396:         IF !THIS.ExigirChequeSelecionado()
3397:             RETURN
3398:         ENDIF
3399: 
3400:         TRY
3401:             loc_oForm = CREATEOBJECT("FormSigOpChc", THIS, ALLTRIM(THIS.this_oBusinessObject.this_cNums))
3402:             IF VARTYPE(loc_oForm) = "O"
3403:                 loc_oForm.Show()
3404:             ENDIF
3405:         CATCH TO loc_oErro
3406:             MsgErro(loc_oErro.Message + CHR(13) + ;
3407:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3408:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoCarteiraClick")
3409:         ENDTRY
3410: 
3411:         THIS.CarregarLista()
3412:     ENDPROC
3413: 
3414:     *--------------------------------------------------------------------------
3415:     * AcaoProtocoloClick - Buttons(6) "Protocolo" ([F9]). Legado: sem
3416:     * Protocolos no cheque, apenas avisa; com Protocolos, monta TempChq (aqui
3417:     * cursor_4c_Protocolo) com os dados do cheque + o Protocolos da
3418:     * movimentacao corrente e abre "Do Form SigOpIbo With ThisForm, 1,
3419:     * lcCaption" (impressao). SigOpIbo ainda nao foi migrado - a preparacao
3420:     * do cursor de impressao (o trabalho de dado real do botao) e feita de
3421:     * qualquer forma; so a tela de impressao em si degrada com aviso.
3422:     *--------------------------------------------------------------------------
3423:     PROCEDURE AcaoProtocoloClick()
3424:         LOCAL loc_cCheque, loc_cCaption, loc_cProtocolo, loc_oForm, loc_oErro
3425: 
3426:         IF !THIS.ExigirChequeSelecionado()
3427:             RETURN
3428:         ENDIF
3429: 
3430:         IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cProtocolos))
3431:             MsgAviso("Este lan" + CHR(231) + "amento n" + CHR(227) + "o possui protocolo!", "Aviso...")
3432:             RETURN
3433:         ENDIF
3434: 
3435:         loc_cCheque  = ALLTRIM(THIS.this_oBusinessObject.this_cBancos) + "/" + ;
3436:                        ALLTRIM(THIS.this_oBusinessObject.this_cAgencias) + "/" + ;
3437:                        ALLTRIM(THIS.this_oBusinessObject.this_cNContas) + "/" + ;
3438:                        ALLTRIM(THIS.this_oBusinessObject.this_cNCheques)
3439:         loc_cCaption = "Impress" + CHR(227) + "o do Protocolo do Cheque: " + loc_cCheque
3440: 
3441:         loc_cProtocolo = ""
3442:         IF USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
3443:             loc_cProtocolo = ALLTRIM(cursor_4c_Movimento.Protocolos)
3444:         ENDIF
3445: 
3446:         TRY
3447:             IF USED("cursor_4c_Protocolo")
3448:                 SELECT cursor_4c_Protocolo
3449:                 ZAP
3450:                 INSERT INTO cursor_4c_Protocolo (Bancos, Agencias, NContas, NCheques, Vencs, Valors, Protocolos) ;
3451:                     VALUES (THIS.this_oBusinessObject.this_cBancos, THIS.this_oBusinessObject.this_cAgencias, ;
3452:                             THIS.this_oBusinessObject.this_cNContas, THIS.this_oBusinessObject.this_cNCheques, ;
3453:                             ConverterParaData(THIS.this_oBusinessObject.this_dVencs), ;
3454:                             THIS.this_oBusinessObject.this_nValors, loc_cProtocolo)
3455:             ENDIF
3456:         CATCH TO loc_oErro
3457:             MsgErro(loc_oErro.Message + CHR(13) + ;
3458:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3459:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoProtocoloClick")
3460:         ENDTRY
3461: 
3462:         TRY
3463:             loc_oForm = CREATEOBJECT("FormSigOpIbo", THIS, 1, loc_cCaption)
3464:             IF VARTYPE(loc_oForm) = "O"
3465:                 loc_oForm.Show()
3466:             ENDIF
3467:         CATCH TO loc_oErro
3468:             MsgAviso("Tela de Impress" + CHR(227) + "o de Protocolo (SigOpIbo) ainda n" + ;
3469:                 CHR(227) + "o foi migrada.", "Indispon" + CHR(237) + "vel")
3470:         ENDTRY
3471:     ENDPROC
3472: 
3473:     *--------------------------------------------------------------------------
3474:     * AcaoDocumentoClick - Buttons(7) "Movimento" ([F4], "Documento" no
3475:     * legado). Legado: Do Case com tres ChkRegister (SigCdPgr por Emps/Dopes/
3476:     * Numes; SigMvCab por EmpDopNums recalculado; SigMvCab por EmpDopNums do
3477:     * proprio registro de SigCqChm), abrindo SigCdPgr/SigMvExp conforme o
3478:     * primeiro que casar. ChkRegister nao existe na nova arquitetura -
3479:     * substituido por SELECT COUNT(*). FormSigMvExp JA FOI MIGRADO; SigCdPgr
3480:     * ainda nao. O guard "WExist('FORM_')" do legado (bloqueia abrir SigMvExp
3481:     * com a Movimentacao de Estoque aberta) nao tem equivalente nesta
3482:     * arquitetura - nao ha janela "FORM_" para detectar.
3483:     *--------------------------------------------------------------------------
3484:     PROCEDURE AcaoDocumentoClick()
3485:         LOCAL loc_cEmpr, loc_cDope, loc_nNume, loc_cKey1, loc_cKey2, loc_nResultado, ;
3486:               loc_oForm, loc_oErro
3487: 
3488:         IF !THIS.ExigirChequeSelecionado()
3489:             RETURN
3490:         ENDIF
3491:         IF !USED("cursor_4c_Movimento") OR EOF("cursor_4c_Movimento")
3492:             MsgAviso("Nenhuma movimenta" + CHR(231) + CHR(227) + "o selecionada.", ;
3493:                 "Aten" + CHR(231) + CHR(227) + "o")
3494:             RETURN
3495:         ENDIF
3496: 
3497:         loc_cEmpr = THIS.this_oBusinessObject.this_cEmps
3498:         loc_cDope = cursor_4c_Movimento.Dopes
3499:         loc_nNume = cursor_4c_Movimento.NumDopes
3500:         *-- Chave POSICIONAL (char padded) - NUNCA ALLTRIM nas partes
3501:         loc_cKey1 = loc_cEmpr + loc_cDope + STR(loc_nNume, 6)
3502:         loc_cKey2 = cursor_4c_Movimento.EmpDopNums
3503: 
3504:         loc_oForm = .NULL.
3505:         TRY
3506:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3507:                 "SELECT COUNT(*) AS nExiste FROM SigCdPgr WHERE Emps = " + EscaparSQL(ALLTRIM(loc_cEmpr)) + ;
3508:                 " AND Dopes = " + EscaparSQL(loc_cDope) + " AND Numes = " + FormatarNumeroSQL(loc_nNume, 0), ;
3509:                 "cursor_4c_DocVal")
3510:             IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3511:                 THIS.FecharCursor("cursor_4c_DocVal")
3512:                 TRY
3513:                     loc_oForm = CREATEOBJECT("FormSigCdPgr", LEFT(loc_cDope, 1), .T., loc_cEmpr, loc_cDope, loc_nNume)
3514:                 CATCH TO loc_oErro
3515:                     MsgAviso("Tela de Registro de Pagamentos (SigCdPgr) ainda n" + CHR(227) + ;
3516:                         "o foi migrada.", "Indispon" + CHR(237) + "vel")
3517:                 ENDTRY
3518:             ELSE
3519:                 THIS.FecharCursor("cursor_4c_DocVal")
3520:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3521:                     "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3522:                     EscaparSQL(loc_cKey1), "cursor_4c_DocVal")
3523:                 IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3524:                     THIS.FecharCursor("cursor_4c_DocVal")
3525:                     loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cDope, "C", loc_nNume, loc_cEmpr, .T.)
3526:                 ELSE
3527:                     THIS.FecharCursor("cursor_4c_DocVal")
3528:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
3529:                         "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3530:                         EscaparSQL(loc_cKey2), "cursor_4c_DocVal")
3531:                     IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3532:                         loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cDope, "C", loc_nNume, ;
3533:                             cursor_4c_Movimento.Emps, .T.)
3534:                     ENDIF
3535:                 ENDIF
3536:             ENDIF
3537:             THIS.FecharCursor("cursor_4c_DocVal")
3538: 
3539:             IF VARTYPE(loc_oForm) = "O"
3540:                 loc_oForm.Show()
3541:             ENDIF
3542:         CATCH TO loc_oErro
3543:             MsgErro(loc_oErro.Message + CHR(13) + ;
3544:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3545:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoDocumentoClick")
3546:         ENDTRY
3547:     ENDPROC
3548: 
3549:     *--------------------------------------------------------------------------
3550:     * AcaoFollowUpChqClick - Buttons(8) "Followup Cheques" ([F3],
3551:     * "followUpChq" no legado). Legado: "Do Form SigOpCfl With crSigChe.Nums,
3552:     * ThisForm.DatasessionId" + SetFocus na grade. FormSigOpCfl JA FOI
3553:     * MIGRADO (Init: par_cConta recebe exatamente o SigChe.Nums do cheque
3554:     * consultado - mesma semantica desta chamada).
3555:     *--------------------------------------------------------------------------
3556:     PROCEDURE AcaoFollowUpChqClick()
3557:         LOCAL loc_oForm, loc_oErro
3558: 
3559:         IF !THIS.ExigirChequeSelecionado()
3560:             RETURN
3561:         ENDIF
3562: 
3563:         TRY
3564:             loc_oForm = CREATEOBJECT("FormSigOpCfl", ALLTRIM(THIS.this_oBusinessObject.this_cNums), ;
3565:                 THIS.DataSessionId)
3566:             IF VARTYPE(loc_oForm) = "O"
3567:                 loc_oForm.Show()
3568:             ENDIF
3569:         CATCH TO loc_oErro
3570:             MsgErro(loc_oErro.Message + CHR(13) + ;
3571:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3572:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoFollowUpChqClick")
3573:         ENDTRY
3574: 
3575:         THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque.SetFocus()
3576:     ENDPROC
3577: 
3578:     *==========================================================================
3579:     * FASE 8 - CONSOLIDACAO: hooks de transferencia, funil de carga, estado
3580:     * dos campos e dos botoes.
3581:     *
3582:     * Este form OPERACIONAL nao tem CRUD (o legado SIGOPCHI nao faz Insert/
3583:     * Update/Delete em SigChe - ver cabecalho de SigOpChiBO.prg), mas TEM
3584:     * campos EDITAVEIS que alimentam a operacao: os tres campos do container
3585:     * Origem (Page1) + o OptionGroup Lista/Filtro, os tres campos do container
3586:     * Emitente (Page2) e as duas datas do periodo de vencimento. Por isso
3587:     * FormParaBO/BOParaForm existem de verdade aqui - o bloco ja estava no
3588:     * Init legado, espalhado pelos AddObject, sem esse nome.
3589:     *==========================================================================
3590: 
3591:     *--------------------------------------------------------------------------
3592:     * FormParaBO - Le os campos EDITAVEIS da tela para as propriedades do BO,
3593:     * que sao a FONTE UNICA lida por CarregarDados.
3594:     *
3595:     * PROTECTED porque FormBase declara este hook PROTECTED e VFP9 nao permite
3596:     * ALARGAR o escopo de metodo herdado.
3597:     *
3598:     * Transferencia pura, sem validacao propria: a unica validacao que o
3599:     * legado faz antes de consultar eh a conta obrigatoria quando o acesso eh
3600:     * restrito, e ela mora em CmdOkClick (Ok.Click legado) e no guard de
3601:     * CarregarDados - repeti-la aqui exibiria a mesma mensagem duas vezes.
3602:     *--------------------------------------------------------------------------
3603:     PROTECTED FUNCTION FormParaBO()
3604:         LOCAL loc_lSucesso, loc_oOrig, loc_oEmi, loc_oPer, loc_oBO, loc_oErro
3605:         loc_lSucesso = .F.
3606: 
3607:         TRY
3608:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
3609:                     PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
3610:                 loc_oBO   = THIS.this_oBusinessObject
3611:                 loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3612:                 loc_oEmi  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
3613:                 loc_oPer  = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
3614: 
3615:                 *-- Container Origem (Pagina.Filtro.Origem do legado)
3616:                 loc_oBO.this_cContaOrigem  = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)
3617:                 loc_oBO.this_cDContaOrigem = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)
3618:                 loc_oBO.this_cCpfOrigem    = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)
3619: 
3620:                 *-- optFiltro eh OptionGroup: .Value eh o INDICE 1-based do
3621:                 *-- botao marcado (1 = Lista, 2 = Filtro), NUNCA 0/1 logico
3622:                 loc_oBO.this_nTipoFiltroOrigem = ;
3623:                     IIF(loc_oOrig.obj_4c_OptFiltro.Value >= 1, loc_oOrig.obj_4c_OptFiltro.Value, 1)
3624: 
3625:                 *-- Container Emitente (Pagina.Historico.Emitente do legado)
3626:                 loc_oBO.this_cContaEmitente  = ALLTRIM(loc_oEmi.txt_4c__Conta.Value)
3627:                 loc_oBO.this_cDContaEmitente = ALLTRIM(loc_oEmi.txt_4c__DConta.Value)
3628:                 loc_oBO.this_cCpfEmitente    = ALLTRIM(loc_oEmi.txt_4c__Cpf.Value)
3629: 
3630:                 *-- Periodo de vencimento (Cnt_periodo). ConverterParaData
3631:                 *-- normaliza DATE/DATETIME/CHAR - TTOD() direto estouraria
3632:                 *-- erro 11 com o DATE que o TextBox guarda
3633:                 loc_oBO.this_dDataInicial = ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)
3634:                 loc_oBO.this_dDataFinal   = ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)
3635: 
3636:                 *-- Espelho do "ThisForm.Filtrado = !Empty(Get_Conta.Value)"
3637:                 THIS.this_lFiltrado    = !EMPTY(loc_oBO.this_cContaOrigem)
3638:                 loc_oBO.this_lFiltrado = THIS.this_lFiltrado
3639: 
3640:                 loc_lSucesso = .T.
3641:             ENDIF
3642:         CATCH TO loc_oErro
3643:             MsgErro(loc_oErro.Message + CHR(13) + ;
3644:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3645:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.FormParaBO")
3646:         ENDTRY
3647: 
3648:         RETURN loc_lSucesso
3649:     ENDFUNC
3650: 
3651:     *--------------------------------------------------------------------------
3652:     * BOParaForm - Caminho inverso: escreve as propriedades do BO nos campos
3653:     * editaveis e nos campos somente-exibicao (Followup e Caption).
3654:     *
3655:     * Equivale ao bloco de ".<campo>.Value = ThisForm.<prop>" que o Init
3656:     * legado executa depois de resolver o periodo default e os parametros de
3657:     * pre-filtro (pBancos/pAgencias/pNContas/pNCheques/pVencs no acesso
3658:     * CARTEIRA). Eh o ponto de RECARGA: chamado por AlternarPagina e por
3659:     * LimparCampos, de modo que a tela sempre reflita o BO.
3660:     *
3661:     * PROTECTED pelo mesmo motivo de FormParaBO (hook herdado de FormBase).
3662:     *--------------------------------------------------------------------------
3663:     PROTECTED PROCEDURE BOParaForm()
3664:         LOCAL loc_oOrig, loc_oEmi, loc_oPer, loc_oBO, loc_oErro
3665: 
3666:         TRY
3667:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
3668:                     PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
3669:                 loc_oBO   = THIS.this_oBusinessObject
3670:                 loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3671:                 loc_oEmi  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
3672:                 loc_oPer  = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
3673: 
3674:                 loc_oOrig.txt_4c__Conta.Value    = loc_oBO.this_cContaOrigem
3675:                 loc_oOrig.txt_4c__DConta.Value   = loc_oBO.this_cDContaOrigem
3676:                 loc_oOrig.txt_4c__Cpf.Value      = loc_oBO.this_cCpfOrigem
3677:                 loc_oOrig.obj_4c_OptFiltro.Value = ;
3678:                     IIF(loc_oBO.this_nTipoFiltroOrigem >= 1, loc_oBO.this_nTipoFiltroOrigem, 1)
3679: 
3680:                 loc_oEmi.txt_4c__Conta.Value  = loc_oBO.this_cContaEmitente
3681:                 loc_oEmi.txt_4c__DConta.Value = loc_oBO.this_cDContaEmitente
3682:                 loc_oEmi.txt_4c__Cpf.Value    = loc_oBO.this_cCpfEmitente
3683: 
3684:                 loc_oPer.txt_4c_Dt_inicial.Value = ConverterParaData(loc_oBO.this_dDataInicial)
3685:                 loc_oPer.txt_4c_Dt_final.Value   = ConverterParaData(loc_oBO.this_dDataFinal)
3686: 
3687:                 *-- Campos somente-exibicao: o texto do ultimo followup e o
3688:                 *-- Caption do form sao resolvidos por AtualizarEstadoChequeAtual
3689:                 *-- e guardados no BO; aqui apenas se espelham na tela
3690:                 THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.Value = ;
3691:                     loc_oBO.this_cUltimoFollowup
3692:                 IF !EMPTY(loc_oBO.this_cCaptionAtual)
3693:                     THIS.Caption = loc_oBO.this_cCaptionAtual
3694:                 ENDIF
3695: 
3696:                 loc_oOrig.txt_4c__Conta.Refresh
3697:                 loc_oOrig.txt_4c__DConta.Refresh
3698:                 loc_oOrig.txt_4c__Cpf.Refresh
3699:                 loc_oEmi.txt_4c__Conta.Refresh
3700:                 loc_oEmi.txt_4c__DConta.Refresh
3701:                 loc_oEmi.txt_4c__Cpf.Refresh
3702:                 loc_oPer.txt_4c_Dt_inicial.Refresh
3703:                 loc_oPer.txt_4c_Dt_final.Refresh
3704: 
3705:                 *-- A dependencia entre os campos (When do legado) depende dos
3706:                 *-- valores que acabaram de ser escritos
3707:                 THIS.HabilitarCampos(.T.)
3708:             ENDIF
3709:         CATCH TO loc_oErro
3710:             MsgErro(loc_oErro.Message + CHR(13) + ;
3711:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3712:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.BOParaForm")
3713:         ENDTRY
3714:     ENDPROC
3715: 
3716:     *--------------------------------------------------------------------------
3717:     * CarregarLista - FUNIL UNICO de carga do Historico: transfere a tela para
3718:     * o BO, executa a consulta (CarregarDados = SqlDados legado) e repinta as
3719:     * tres grades.
3720:     *
3721:     * PUBLIC de proposito: TesteAutomatico.prg chama THIS.oForm.CarregarLista()
3722:     * de FORA da classe, e PEMSTATUS(oForm, "CarregarLista", 5) devolve .T.
3723:     * mesmo para metodo PROTECTED (so verifica existencia, nao escopo) - o
3724:     * teste entraria no branch e a chamada estouraria em runtime.
3725:     *
3726:     * Popular cursor NAO repinta a grade, e Refresh em pagina oculta nao
3727:     * pinta: por isso o Repintar vem no FIM e AlternarPagina chama este metodo
3728:     * DEPOIS de trocar o ActivePage.
3729:     *--------------------------------------------------------------------------
3730:     PROCEDURE CarregarLista()
3731:         LOCAL loc_lSucesso
3732:         loc_lSucesso = .F.
3733: 
3734:         IF THIS.FormParaBO()
3735:             loc_lSucesso = THIS.CarregarDados()
3736:             THIS.RepintarGradesHistorico()
3737:         ENDIF
3738: 
3739:         RETURN loc_lSucesso
3740:     ENDPROC
3741: 
3742:     *--------------------------------------------------------------------------
3743:     * HabilitarCampos - Estado de entrada dos campos de filtro. Transcreve os
3744:     * cinco PROCEDURE When do legado, que implementam EXCLUSAO MUTUA entre os
3745:     * campos de conta:
3746:     *
3747:     *   Origem.get_Cpf.When    -> Empty(Get_Conta.Value)
3748:     *   Origem.get_DConta.When -> Empty(Get_Conta.Value) And Empty(Get_Cpf.Value)
3749:     *   Origem.optFiltro.When  -> Empty(Get_Conta) And Empty(Get_Cpf) And Empty(get_DConta)
3750:     *   Emitente.get_Cpf.When    -> Empty(Get_Conta.Value)
3751:     *   Emitente.get_DConta.When -> Empty(Get_Conta) And Empty(Get_Cpf)
3752:     *
3753:     * Preenchido o campo de conta, os seguintes param de aceitar digitacao -
3754:     * o legado limpa os irmaos no Valid do campo resolvido (PreencherOrigem/
3755:     * PreencherEmitente fazem o mesmo), e eh por ali que se recomeca.
3756:     *
3757:     * Mecanismo: TextBox recebe ReadOnly + TabStop (e NAO Enabled), que eh o
3758:     * equivalente de runtime mais fiel ao When - bloqueia foco e digitacao
3759:     * SEM acinzentar o controle (PILAR 1). OptionGroup nao tem ReadOnly, so
3760:     * Enabled; o acinzentamento dele eh divergencia inevitavel do legado.
3761:     * BINDEVENT em "When" nao serve: o BINDEVENT DESCARTA o retorno do
3762:     * delegate, entao um When ligado por ali nao bloquearia nada.
3763:     *
3764:     * par_lHabilitar = .F. forca TODOS os campos somente-leitura, ignorando a
3765:     * cascata. Parametro OMITIDO vale .T. - a distincao usa PCOUNT(), porque
3766:     * em VFP9 parametro nao passado chega como .F. logico e VARTYPE nao
3767:     * distingue um do outro.
3768:     *--------------------------------------------------------------------------
3769:     PROCEDURE HabilitarCampos(par_lHabilitar)
3770:         LOCAL loc_lHab, loc_oOrig, loc_oEmi, loc_oPer, loc_oErro
3771:         LOCAL loc_lContaOrig, loc_lCpfOrig, loc_lNomeOrig
3772:         LOCAL loc_lContaEmi, loc_lCpfEmi, loc_lNomeEmi
3773:         loc_lHab = IIF(PCOUNT() = 0, .T., par_lHabilitar)
3774: 
3775:         TRY
3776:             IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
3777:                 loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3778:                 loc_oEmi  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
3779:                 loc_oPer  = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
3780: 
3781:                 *-- Cascata do When (Origem): a conta eh sempre digitavel; o
3782:                 *-- CPF so com a conta vazia; o nome so com conta E CPF vazios;
3783:                 *-- o optFiltro so com os TRES vazios
3784:                 loc_lContaOrig = loc_lHab
3785:                 loc_lCpfOrig   = loc_lHab AND EMPTY(ALLTRIM(loc_oOrig.txt_4c__Conta.Value))
3786:                 loc_lNomeOrig  = loc_lCpfOrig AND EMPTY(ALLTRIM(loc_oOrig.txt_4c__Cpf.Value))
3787: 
3788:                 loc_oOrig.txt_4c__Conta.ReadOnly   = !loc_lContaOrig
3789:                 loc_oOrig.txt_4c__Conta.TabStop    = loc_lContaOrig
3790:                 loc_oOrig.txt_4c__Cpf.ReadOnly     = !loc_lCpfOrig
3791:                 loc_oOrig.txt_4c__Cpf.TabStop      = loc_lCpfOrig
3792:                 loc_oOrig.txt_4c__DConta.ReadOnly  = !loc_lNomeOrig
3793:                 loc_oOrig.txt_4c__DConta.TabStop   = loc_lNomeOrig
3794:                 loc_oOrig.obj_4c_OptFiltro.Enabled = loc_lNomeOrig AND ;
3795:                     EMPTY(ALLTRIM(loc_oOrig.txt_4c__DConta.Value))
3796: 
3797:                 *-- Cascata do When (Emitente): identica, sem optFiltro - o
3798:                 *-- dump nao declara OptionGroup neste container
3799:                 loc_lContaEmi = loc_lHab
3800:                 loc_lCpfEmi   = loc_lHab AND EMPTY(ALLTRIM(loc_oEmi.txt_4c__Conta.Value))
3801:                 loc_lNomeEmi  = loc_lCpfEmi AND EMPTY(ALLTRIM(loc_oEmi.txt_4c__Cpf.Value))
3802: 
3803:                 loc_oEmi.txt_4c__Conta.ReadOnly  = !loc_lContaEmi
3804:                 loc_oEmi.txt_4c__Conta.TabStop   = loc_lContaEmi
3805:                 loc_oEmi.txt_4c__Cpf.ReadOnly    = !loc_lCpfEmi
3806:                 loc_oEmi.txt_4c__Cpf.TabStop     = loc_lCpfEmi
3807:                 loc_oEmi.txt_4c__DConta.ReadOnly = !loc_lNomeEmi
3808:                 loc_oEmi.txt_4c__DConta.TabStop  = loc_lNomeEmi
3809: 
3810:                 *-- As duas datas do periodo nao tem When no legado: seguem
3811:                 *-- apenas o par_lHabilitar
3812:                 loc_oPer.txt_4c_Dt_inicial.ReadOnly = !loc_lHab
3813:                 loc_oPer.txt_4c_Dt_inicial.TabStop  = loc_lHab
3814:                 loc_oPer.txt_4c_Dt_final.ReadOnly   = !loc_lHab
3815:                 loc_oPer.txt_4c_Dt_final.TabStop    = loc_lHab
3816: 
3817:                 *-- UltFollowup eh somente-exibicao no legado
3818:                 *-- (Cnt_Followup.UltFollowup.When -> Return .f.)
3819:                 THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.ReadOnly = .T.
3820:                 THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.TabStop  = .F.
3821:             ENDIF
3822:         CATCH TO loc_oErro
3823:             MsgErro(loc_oErro.Message + CHR(13) + ;
3824:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3825:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.HabilitarCampos")
3826:         ENDTRY
3827:     ENDPROC
3828: 
3829:     *--------------------------------------------------------------------------
3830:     * AplicarDependenciaCampos - Alvo parametro-zero dos BINDEVENT de
3831:     * InteractiveChange dos seis campos de conta. NAO se liga HabilitarCampos
3832:     * direto ao evento: InteractiveChange nao passa argumento e, em VFP9,
3833:     * parametro nao passado chega como .F. logico - par_lHabilitar viria .F. e
3834:     * a tela inteira ficaria somente-leitura ao primeiro caractere digitado.
3835:     *--------------------------------------------------------------------------
3836:     PROCEDURE AplicarDependenciaCampos()
3837:         THIS.HabilitarCampos(.T.)
3838:     ENDPROC
3839: 
3840:     *--------------------------------------------------------------------------
3841:     * LimparCampos - Zera os dois containers de conta e restaura o periodo de
3842:     * vencimento default, voltando o BO e a tela ao estado de abertura.
3843:     *
3844:     * Transcreve o Sair.Click legado do Historico, que no acesso restrito
3845:     * limpa os TRES campos de Origem e restaura o Caption:
3846:     *   .Filtro.Origem.Get_conta.Value  = ''
3847:     *   .Filtro.Origem.Get_Dconta.Value = ''
3848:     *   .Filtro.Origem.Get_Cpf.Value    = ''
3849:     *   ThisForm.Caption = 'Historico de Cheques'
3850:     * mais o periodo default do Init legado (Date() ate 31/12 do ano corrente;
3851:     * no acesso CARTEIRA, o vencimento do cheque recebido).
3852:     *
3853:     * PROTECTED porque FormBase declara este hook PROTECTED.
3854:     *--------------------------------------------------------------------------
3855:     PROTECTED PROCEDURE LimparCampos()
3856:         LOCAL loc_oBO, loc_oErro
3857: 
3858:         TRY
3859:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3860:                 loc_oBO = THIS.this_oBusinessObject
3861: 
3862:                 loc_oBO.this_cContaOrigem      = ""
3863:                 loc_oBO.this_cDContaOrigem     = ""
3864:                 loc_oBO.this_cCpfOrigem        = ""
3865:                 loc_oBO.this_nTipoFiltroOrigem = 1
3866:                 loc_oBO.this_cContaEmitente    = ""
3867:                 loc_oBO.this_cDContaEmitente   = ""
3868:                 loc_oBO.this_cCpfEmitente      = ""
3869:                 loc_oBO.this_cUltimoFollowup   = ""
3870:                 loc_oBO.this_cCaptionAtual     = "Hist" + CHR(243) + "rico de Cheques"
3871: 
3872:                 *-- Periodo default - mesma regra do Init legado
3873:                 IF ALLTRIM(UPPER(loc_oBO.this_cAcesso)) == "CARTEIRA" AND ;
3874:                         !EMPTY(THIS.this_dParamVencs)
3875:                     loc_oBO.this_dDataInicial = THIS.this_dParamVencs
3876:                     loc_oBO.this_dDataFinal   = THIS.this_dParamVencs
3877:                 ELSE
3878:                     loc_oBO.this_dDataInicial = DATE()
3879:                     loc_oBO.this_dDataFinal   = ;
3880:                         CTOD("31/12/" + ALLTRIM(STR(YEAR(DATE()))))
3881:                 ENDIF
3882: 
3883:                 THIS.this_lFiltrado    = .F.
3884:                 loc_oBO.this_lFiltrado = .F.
3885: 
3886:                 *-- BOParaForm espelha tudo na tela (e reaplica a cascata do
3887:                 *-- When ao fim), inclusive o Caption restaurado
3888:                 THIS.BOParaForm()
3889:             ENDIF
3890:         CATCH TO loc_oErro
3891:             MsgErro(loc_oErro.Message + CHR(13) + ;
3892:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3893:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.LimparCampos")
3894:         ENDTRY
3895:     ENDPROC
3896: 
3897:     *--------------------------------------------------------------------------
3898:     * AjustarBotoesPorModo - FUNIL do estado dos botoes e dos campos conforme
3899:     * a pagina ativa, que eh o "modo" deste form:
3900:     *
3901:     *   Page1 (Filtro)    -> this_cModoAtual = "LISTA"
3902:     *                        Processar/Encerrar habilitados, campos editaveis
3903:     *   Page2 (Historico) -> this_cModoAtual = "VISUALIZAR"
3904:     *                        barra Grupo_op habilitada conforme o legado
3905:     *                        (Procurar = !Filtrado, Protocolo = fChecaAcesso)
3906:     *
3907:     * Chamado por AlternarPagina nos DOIS sentidos - desabilitar no caminho de
3908:     * ida sem reabilitar no de volta deixaria a tela inutilizavel.
3909:     *
3910:     * PUBLIC: TesteAutomatico.prg chama este metodo de fora da classe.
3911:     *--------------------------------------------------------------------------
3912:     PROCEDURE AjustarBotoesPorModo()
3913:         LOCAL loc_nPagina, loc_oPg1, loc_oErro
3914: 
3915:         TRY
3916:             IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
3917:                 loc_nPagina = THIS.pgf_4c_Paginas.ActivePage
3918:                 loc_oPg1    = THIS.pgf_4c_Paginas.Page1
3919: 
3920:                 IF loc_nPagina = 2
3921:                     THIS.this_cModoAtual = "VISUALIZAR"
3922:                     THIS.AjustarBotoesHistorico()
3923:                 ELSE
3924:                     THIS.this_cModoAtual = "LISTA"
3925:                     loc_oPg1.cmd_4c_Ok.Enabled       = .T.
3926:                     loc_oPg1.cmd_4c_Cancelar.Enabled = .T.
3927:                 ENDIF
3928: 
3929:                 *-- Reaplica a cascata do When - os campos seguem editaveis nos
3930:                 *-- dois modos (o Historico tem o filtro de Emitente e o
3931:                 *-- periodo), o que troca eh a pagina ativa
3932:                 THIS.HabilitarCampos(.T.)
3933:             ENDIF
3934:         CATCH TO loc_oErro
3935:             MsgErro(loc_oErro.Message + CHR(13) + ;
3936:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3937:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AjustarBotoesPorModo")
3938:         ENDTRY
3939:     ENDPROC
3940: 
3941:     *--------------------------------------------------------------------------
3942:     * BtnProcessarClick - Nome canonico da ACAO desta tela. O verbo vem do
3943:     * proprio legado: o botao da pagina de Filtro se chama "Ok" no SCX mas tem
3944:     * Caption "\<Processar", e o Click dele eh o que dispara a consulta e leva
3945:     * o usuario ao Historico.
3946:     *
3947:     * Esta tela eh um VISUALIZADOR - o legado SIGOPCHI nao tem botao de gravar
3948:     * (varredura do dump: zero ocorrencia de btnSalvar/btnGravar/mGravaDados) e
3949:     * nao persiste nada em SigChe; quem grava sao os formularios de detalhe que
3950:     * os botoes de Grupo_op abrem. Por isso a acao eh "Processar" (consultar) e
3951:     * NAO existe BtnSalvarClick - inventar um violaria o PILAR 1.
3952:     *
3953:     * Funil PUBLIC: o corpo mora em CmdOkClick (alvo do BINDEVENT do botao).
3954:     *--------------------------------------------------------------------------
3955:     PROCEDURE BtnProcessarClick()
3956:         THIS.CmdOkClick()
3957:     ENDPROC
3958: 
3959:     *--------------------------------------------------------------------------
3960:     * BtnBuscarClick - Nome canonico para a acao de BUSCA desta tela, que eh o
3961:     * botao "Busca" ([F5]) de Grupo_op (Buttons(2) -> Procurar.Click legado,
3962:     * que abre SigOpChb). Funil PUBLIC: nao duplica logica, delega ao handler
3963:     * ja transcrito do legado.
3964:     *--------------------------------------------------------------------------
3965:     PROCEDURE BtnBuscarClick()
3966:         THIS.AcaoProcurarClick()
3967:     ENDPROC
3968: 
3969:     *--------------------------------------------------------------------------
3970:     * BtnEncerrarClick - Nome canonico para o Encerrar. Este form tem DOIS
3971:     * botoes de saida, um por pagina, com comportamentos DIFERENTES no legado:
3972:     *   Page1 (cancelar.Click) -> ThisForm.Release
3973:     *   Page2 (Sair.Click)     -> sem acesso irrestrito volta ao Filtro
3974:     *                             limpando a Origem; com acesso, Release
3975:     * Por isso o funil eh sensivel a pagina ativa, em vez de escolher um dos
3976:     * dois arbitrariamente.
3977:     *--------------------------------------------------------------------------
3978:     PROCEDURE BtnEncerrarClick()
3979:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5) AND THIS.pgf_4c_Paginas.ActivePage = 2
3980:             THIS.CmgSaidaClick()
3981:         ELSE
3982:             THIS.BtnCancelarClick()
3983:         ENDIF
3984:     ENDPROC
3985: 
3986:     *--------------------------------------------------------------------------
3987:     * BtnCancelarClick - Nome canonico do Encerrar da pagina de Filtro
3988:     * (cancelar.Click legado: ThisForm.Release, sem pedir confirmacao - eh um
3989:     * visualizador, nao ha alteracao em aberto para desfazer).
3990:     * CmdCancelarClick (alvo do BINDEVENT do botao) delega para ca, para que
3991:     * exista UM so corpo.
3992:     *--------------------------------------------------------------------------
3993:     PROCEDURE BtnCancelarClick()
3994:         THIS.Release()
3995:     ENDPROC
3996: 
3997:     *--------------------------------------------------------------------------
3998:     * TornarControlesVisiveis - Torna visiveis recursivamente os controles
3999:     * criados via AddObject (percorre tambem as Pages de um PageFrame)
4000:     *--------------------------------------------------------------------------
4001:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4002:         LOCAL loc_nI, loc_nP, loc_oControl, loc_oErro
4003:         TRY
4004:             FOR loc_nI = 1 TO par_oContainer.ControlCount
4005:                 loc_oControl = par_oContainer.Controls(loc_nI)
4006:                 IF VARTYPE(loc_oControl) = "O"
4007:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
4008:                         loc_oControl.Visible = .T.
4009:                     ENDIF
4010:                     IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
4011:                         FOR loc_nP = 1 TO loc_oControl.PageCount
4012:                             THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
4013:                         ENDFOR
4014:                     ENDIF
4015:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
4016:                         THIS.TornarControlesVisiveis(loc_oControl)
4017:                     ENDIF
4018:                 ENDIF
4019:             ENDFOR
4020:         CATCH TO loc_oErro
4021:             MsgErro(loc_oErro.Message + CHR(13) + ;
4022:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4023:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.TornarControlesVisiveis")
4024:         ENDTRY
4025:     ENDPROC
4026: 
4027:     *--------------------------------------------------------------------------
4028:     * Destroy - Fecha os cursores que o form criou e so depois delega.
4029:     *
4030:     * DODEFAULT() eh a ULTIMA linha: FormBase.Destroy libera o BO e refaz os
4031:     * popups de _MSYSMENU (sem isso o menu principal fica visualmente
4032:     * encolhido depois de qualquer form modal).
4033:     *
4034:     * As tres grades ficam desvinculadas antes, porque fechar o alias que esta
4035:     * em RecordSource com a grade ainda ligada deixa o Grid apontando para
4036:     * alias morto.
4037:     *--------------------------------------------------------------------------
4038:     PROCEDURE Destroy()
4039:         LOCAL loc_oErro
4040: 
4041:         TRY
4042:             *-- O PageFrame pode nao existir se o Init falhou antes de cria-lo:
4043:             *-- nesse caso ja houve mensagem de erro, e desvincular grade
4044:             *-- inexistente so somaria um segundo dialogo
4045:             IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
4046:                 THIS.DesvincularGradesHistorico()
4047:             ENDIF
4048: 
4049:             THIS.FecharCursor("cursor_4c_Cheque")
4050:             THIS.FecharCursor("cursor_4c_ChequeP")
4051:             THIS.FecharCursor("cursor_4c_Movimento")
4052:             THIS.FecharCursor("cursor_4c_Prorrog")
4053:             THIS.FecharCursor("cursor_4c_Protocolo")
4054:             THIS.FecharCursor("cursor_4c_Temp")
4055:         CATCH TO loc_oErro
4056:             MsgErro(loc_oErro.Message + CHR(13) + ;
4057:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4058:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.Destroy")
4059:         ENDTRY
4060: 
4061:         DODEFAULT()
4062:     ENDPROC
4063: 
4064: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpChiBO.prg):
*============================================================================
* SigOpChiBO.prg - Business Object para Historico de Cheques
*
* Tabela principal : SigChe    (PK: Nums char(8) - numero sequencial do cheque)
* Tabela detalhe    : SigCqChm (FK: Nums - movimentos/followup do cheque)
* Lookup conta      : SigCdCli (PK: Iclis, desc: Rclis, doc: Cpfs)
*
* Form OPERACIONAL (consulta/historico) - sem Inserir/Atualizar/Excluir.
* Filtra cheques por conta (Origem) ou por conta do Emitente, dentro de um
* periodo de vencimento, e exibe tres grades: Cheque, Movimentacao e
* Prorrogacoes, alem do ultimo Followup registrado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpChiBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigChe (todas as colunas - cheque selecionado
    * na GradeCheque da pagina Historico). Nums eh char(8) NO BANCO - NUNCA
    * numerico (conferido em docs/schema.sql: CONSTRAINT sigche_nums PK em
    * [nums] char(8)).
    *==========================================================================
    this_cNums      = ""    && char(8)  - PK do cheque selecionado na grade
    this_cEmps      = ""    && char(3)  - Empresa do cheque selecionado
    this_cBancos    = ""    && char(3)
    this_cAgencias  = ""    && char(4)
    this_lAutos     = .F.   && bit
    this_cConCarts  = ""    && char(10) - Conta Carteira
    this_cConOrigs  = ""    && char(10) - Conta Origem
    this_cConRes    = ""    && char(10)
    this_cContas    = ""    && char(10)
    this_cCopchs    = ""    && char(15)
    this_dDatas     = {}    && datetime
    this_dDataTrans = {}    && datetime
    this_cFpags     = ""    && char(12)
    this_cGrClis    = ""    && char(10) - Grupo do cliente
    this_cGruCarts  = ""    && char(10) - Grupo Carteira
    this_cGruOrigs  = ""    && char(10) - Grupo Origem
    this_cGrupos    = ""    && char(10)
    this_cGrures    = ""    && char(10)
    this_cGrvends   = ""    && char(10)
    this_cIClis     = ""    && char(10) - Codigo do cliente/conta
    this_cLeituras  = ""    && char(34)
    this_cLocals    = ""    && char(10)
    this_nNalineas  = 0     && numeric(3,0)
    this_cNCheques  = ""    && char(6)
    this_cNContas   = ""    && char(10)
    this_cNotas     = ""    && char(6)
    this_nNtrans    = 0     && numeric(6,0)
    this_cNumeros   = ""    && char(6)
    this_cNumolds   = ""    && char(8)
    this_nNumos     = 0     && numeric(8,0)
    this_cProtocolos = ""   && char(8)
    this_cUMovs     = ""    && char(15) - Ultimo Movimento
    this_nValors    = 0     && numeric(11,2)
    this_nValpags   = 0     && numeric(11,2)
    this_dVencs     = {}    && datetime
    this_cVends     = ""    && char(10)
    this_dDtEmis    = {}    && datetime
    this_dDtAlts    = {}    && datetime
    this_cContat    = ""    && char(10)
    this_cGrupot    = ""    && char(10)
    this_nCotas     = 0     && numeric(11,4)
    this_cMoeds     = ""    && char(3)
    this_nTipoBlq   = 0     && numeric(1,0)
    this_cCustodia  = ""    && char(4)

    *==========================================================================
    * Filtro por Conta de Origem (Pagina.Filtro.Origem)
    *==========================================================================
    this_cContaOrigem     = ""    && Iclis digitado/selecionado
    this_cDContaOrigem    = ""    && Rclis (descricao/nome da conta)
    this_cCpfOrigem       = ""    && Cpfs (CPF/CNPJ da conta)
    this_nTipoFiltroOrigem = 1    && optFiltro.Value: 1=Conta exata, 2=Com Filtro (LIKE)

    *==========================================================================
    * Filtro por Conta do Emitente (Pagina.Historico.Emitente)
    *==========================================================================
    this_cContaEmitente   = ""    && Iclis do emitente
    this_cDContaEmitente  = ""    && Rclis do emitente
    this_cCpfEmitente     = ""    && Cpfs do emitente

    *==========================================================================
    * Filtro por Periodo de Vencimento (Cnt_periodo)
    *==========================================================================
    this_dDataInicial = {}    && Dt_inicial.Value
    this_dDataFinal   = {}    && Dt_final.Value

    *==========================================================================
    * Estado de acesso e navegacao
    *==========================================================================
    this_cAcesso      = "TOTAL"    && Parametro pcAcesso recebido na abertura
    this_lAcesso      = .T.        && INLIST(this_cAcesso,'TOTAL','CARTEIRA')
    this_lFiltrado    = .F.        && .T. quando a Lista foi filtrada por uma conta
    this_cCaptionAtual = ""        && Caption dinamico ("Historico de Cheques de: ...")
    this_cUltimoFollowup = ""      && Texto do ultimo followup do cheque selecionado

    *==========================================================================
    * Alias dos cursores usados pelas grades e pelos lookups
    *==========================================================================
    this_cCursorCheque      = "cursor_4c_Cheque"       && GradeCheque      (SigChe)
    this_cCursorMovimento   = "cursor_4c_Movimento"    && GradeMovimenta   (SigCqChm)
    this_cCursorProrrog     = "cursor_4c_Prorrog"      && GradeProrrog     (prorrogacoes)
    this_cCursorChequeMov   = "cursor_4c_ChequeMov"    && Detalhe do cheque selecionado
    this_cCursorCliente     = "cursor_4c_Cliente"      && Lookup SigCdCli (conta/emitente)
    this_cCursorProtocolo   = "cursor_4c_Protocolo"    && TempChq (impressao de protocolo)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChe"
            THIS.this_cCampoChave = "Nums"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria do cheque selecionado
    * na GradeCheque, usada por RegistrarAuditoria (via BusinessBase) caso
    * algum passo futuro do historico precise identificar o registro.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cNums)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigChe para as
    * propriedades do BO. Alimentado pelo cursor que fica posicionado no
    * cheque corrente da GradeCheque (Pagina.Historico) apos o usuario
    * selecionar uma linha - equivalente ao acesso direto a crSigChe.<col>
    * que o legado faz em Grupo_op.Click (Relatorio/Documento/Prorroga/
    * FollowUp/Protocolo/Carteira) e em GradeCheque.AfterRowColChange.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cNums       = TratarNulo(Nums, "C")
            THIS.this_cEmps       = TratarNulo(Emps, "C")
            THIS.this_cBancos     = TratarNulo(Bancos, "C")
            THIS.this_cAgencias   = TratarNulo(Agencias, "C")
            THIS.this_lAutos      = ConverterParaLogico(Autos)
            THIS.this_cConCarts   = TratarNulo(ConCarts, "C")
            THIS.this_cConOrigs   = TratarNulo(ConOrigs, "C")
            THIS.this_cConRes     = TratarNulo(ConRes, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cCopchs     = TratarNulo(Copchs, "C")
            THIS.this_dDatas      = ConverterParaData(Datas)
            THIS.this_dDataTrans  = ConverterParaData(DataTrans)
            THIS.this_cFpags      = TratarNulo(Fpags, "C")
            THIS.this_cGrClis     = TratarNulo(GrClis, "C")
            THIS.this_cGruCarts   = TratarNulo(GruCarts, "C")
            THIS.this_cGruOrigs   = TratarNulo(GruOrigs, "C")
            THIS.this_cGrupos     = TratarNulo(Grupos, "C")
            THIS.this_cGrures     = TratarNulo(Grures, "C")
            THIS.this_cGrvends    = TratarNulo(Grvends, "C")
            THIS.this_cIClis      = TratarNulo(Iclis, "C")
            THIS.this_cLeituras   = TratarNulo(Leituras, "C")
            THIS.this_cLocals     = TratarNulo(Locals, "C")
            THIS.this_nNalineas   = NVL(Nalineas, 0)
            THIS.this_cNCheques   = TratarNulo(NCheques, "C")
            THIS.this_cNContas    = TratarNulo(NContas, "C")
            THIS.this_cNotas      = TratarNulo(Notas, "C")
            THIS.this_nNtrans     = NVL(Ntrans, 0)
            THIS.this_cNumeros    = TratarNulo(Numeros, "C")
            THIS.this_cNumolds    = TratarNulo(Numolds, "C")
            THIS.this_nNumos      = NVL(Numos, 0)
            THIS.this_cProtocolos = TratarNulo(Protocolos, "C")
            THIS.this_cUMovs      = TratarNulo(UMovs, "C")
            THIS.this_nValors     = NVL(Valors, 0)
            THIS.this_nValpags    = NVL(Valpags, 0)
            THIS.this_dVencs      = ConverterParaData(Vencs)
            THIS.this_cVends      = TratarNulo(Vends, "C")
            THIS.this_dDtEmis     = ConverterParaData(DtEmis)
            THIS.this_dDtAlts     = ConverterParaData(DtAlts)
            THIS.this_cContat     = TratarNulo(Contat, "C")
            THIS.this_cGrupot     = TratarNulo(Grupot, "C")
            THIS.this_nCotas      = NVL(Cotas, 0)
            THIS.this_cMoeds      = TratarNulo(Moeds, "C")
            THIS.this_nTipoBlq    = NVL(TipoBlq, 0)
            THIS.this_cCustodia   = TratarNulo(Custodia, "C")

            RETURN .T.
        ENDIF

        RETURN .F.
    ENDPROC

    *==========================================================================
    * SigOpChi (Historico de Cheques) eh um form de CONSULTA: o legado
    * (SIGOPCHI) nao faz Insert/Update/Delete em SigChe por esta tela - o
    * usuario apenas filtra por conta/periodo e navega para os formularios
    * de detalhe (SigOpChr, SigOpChb, SigOpChp, SigOpFlp, SigOpChc), que sao
    * os responsaveis por qualquer gravacao. Por isso o comportamento padrao
    * herdado de BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao)
    * ja eh o correto para este BO.
    *==========================================================================

ENDDEFINE

