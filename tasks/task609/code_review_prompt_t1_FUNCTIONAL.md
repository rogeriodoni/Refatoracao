# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (24)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterImpressoraSelecionada()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_ImpPar' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Produto' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Referência Fornecedor, Parcelas, Preço, Preço De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Referência Fornecedor, Parcelas, Preço, Preço De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Quantidade' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Referência Fornecedor, Parcelas, Preço, Preço De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Opt_Tipo' (parent: SIGPRETQ): Top original=431 vs migrado 'obj_4c_Opt_Tipo' Top=10 (diff=421px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRETQ): Top original=415 vs migrado 'lbl_4c_Label11' Top=594 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRETQ): Left original=23 vs migrado 'lbl_4c_Label11' Left=556 (diff=533px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRETQ): Top original=431 vs migrado 'obj_4c_Opt_Impressora' Top=52 (diff=379px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRETQ): Left original=260 vs migrado 'obj_4c_Opt_Impressora' Left=9 (diff=251px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_separador' (parent: SIGPRETQ): Top original=412 vs migrado 'obj_4c_Opt_separador' Top=5 (diff=407px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_separador' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_Opt_separador' Left=5 (diff=596px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGPRETQ): Top original=589 vs migrado 'obj_4c_OptOrdem' Top=4 (diff=585px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_OptOrdem' Left=5 (diff=596px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_peso' (parent: SIGPRETQ): Top original=535 vs migrado 'obj_4c_Opt_peso' Top=5 (diff=530px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_peso' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_Opt_peso' Left=5 (diff=596px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCompos' (parent: SIGPRETQ): Top original=562 vs migrado 'obj_4c_OptCompos' Top=5 (diff=557px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCompos' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_OptCompos' Left=5 (diff=596px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Preco' (parent: SIGPRETQ): Top original=439 vs migrado 'obj_4c_Opt_Preco' Top=7 (diff=432px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Preco' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_Opt_Preco' Left=8 (diff=593px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2998 linhas total):

*-- Linhas 77 a 182:
77:     this_lFocoAplicado = .F.
78: 
79:     *==========================================================================
80:     PROCEDURE Init()
81:     *==========================================================================
82:         RETURN DODEFAULT()
83:     ENDPROC
84: 
85:     *==========================================================================
86:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
87:     *==========================================================================
88:     PROTECTED PROCEDURE InicializarForm()
89:         LOCAL loc_lSucesso, loc_oErro
90:         loc_lSucesso = .F.
91: 
92:         TRY
93:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrEtqBO")
94: 
95:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
96: 
97:             THIS.ConfigurarPageFrame()
98:             THIS.ConfigurarPaginaDados()
99:             THIS.CriarCursorDados()
100:             THIS.ConfigurarGridEtiquetas()
101:             THIS.ConfigurarLookupsGrade()
102:             THIS.ConfigurarBotoesGrade()
103:             THIS.CriarCursorImpressorasWindows()
104:             THIS.ConfigurarCamposImpressao()
105:             THIS.PopularOpcoesTipoEtiqueta()
106:             THIS.ConfigurarBotaoRelatorio()
107:             THIS.TornarControlesVisiveis()
108: 
109:             *-- Consolidacao final (ordem do Init legado, apos montar a tela):
110:             *-- 1) parametros de SigCdPam/SigCdPac chegam aos controles;
111:             *-- 2) fChecaAcesso trava os ajustes finos que o usuario nao pode
112:             *--    alterar e HabilitarCampos aplica esse teto + libera/bloqueia
113:             *--    o botao Imprimir conforme (tipos <> 0 And impressoras <> 0);
114:             *-- 3) a grade recebe a linha em branco e o Refresh que o legado
115:             *--    sempre faz (regra CLAUDE.md #21a).
116:             THIS.BOParaForm()
117:             THIS.AplicarAcessosUsuario()
118:             THIS.HabilitarCampos(.T.)
119:             THIS.CarregarLista()
120: 
121:             loc_lSucesso = .T.
122: 
123:         CATCH TO loc_oErro
124:             THIS.this_cMensagemErro = loc_oErro.Message
125:             MsgErro(loc_oErro.Message + CHR(13) + ;
126:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
127:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Inicializar")
128:         ENDTRY
129: 
130:         RETURN loc_lSucesso
131:     ENDPROC
132: 
133:     *==========================================================================
134:     * ConfigurarPageFrame - Constroi a faixa de cabecalho (cntSombra no
135:     * legado -> cnt_4c_Sombra no mapeamento.json). Este form OPERACIONAL nao
136:     * tem PageFrame nenhum no SCX legado (regra CLAUDE.md - "NUNCA inventar"
137:     * estrutura que o legado nao tem): o metodo mantem o nome pelo padrao ja
138:     * adotado nos demais forms FLAT (ver FormSIGMDETQ), mas so monta a faixa
139:     * superior. Grid, OptionGroups, Cnt_Impressora e botoes entram direto
140:     * sobre THIS nas proximas fases (4 a 8).
141:     *==========================================================================
142:     PROTECTED PROCEDURE ConfigurarPageFrame()
143:         THIS.AddObject("cnt_4c_Sombra", "Container")
144:         WITH THIS.cnt_4c_Sombra
145:             .Top         = 0
146:             .Left        = 0
147:             .Width       = THIS.Width
148:             .Height      = 80
149:             .BackColor   = RGB(100, 100, 100)
150:             .BorderWidth = 0
151:             .Visible     = .T.
152: 
153:             .AddObject("lbl_4c_LblSombra", "Label")
154:             WITH .lbl_4c_LblSombra
155:                 .Top       = 18
156:                 .Left      = 10
157:                 .Width     = THIS.Width
158:                 .Height    = 40
159:                 .FontBold  = .T.
160:                 .FontName  = "Tahoma"
161:                 .FontSize  = 18
162:                 .BackStyle = 0
163:                 .WordWrap  = .T.
164:                 .Alignment = 0
165:                 .ForeColor = RGB(0, 0, 0)
166:                 .Caption   = THIS.Caption
167:                 .Visible   = .T.
168:             ENDWITH
169: 
170:             .AddObject("lbl_4c_LblTitulo", "Label")
171:             WITH .lbl_4c_LblTitulo
172:                 .Top       = 17
173:                 .Left      = 10
174:                 .Width     = THIS.Width
175:                 .Height    = 46
176:                 .FontBold  = .T.
177:                 .FontName  = "Tahoma"
178:                 .FontSize  = 18
179:                 .BackStyle = 0
180:                 .WordWrap  = .T.
181:                 .Alignment = 0
182:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 198 a 339:
198:     * runtime). Bloco de Opt_Tipo/Cnt_Impressora/opcoes de relatorio fica
199:     * para a Fase 6 (Parte 2).
200:     *==========================================================================
201:     PROTECTED PROCEDURE ConfigurarPaginaDados()
202: 
203:         *-- Say2 "Lista de Precos" (mnemonico \< do legado preservado)
204:         THIS.AddObject("lbl_4c_Label2", "Label")
205:         WITH THIS.lbl_4c_Label2
206:             .Top       = 86
207:             .Left      = 20
208:             .Width     = 130
209:             .Height    = 15
210:             .BackStyle = 0
211:             .Alignment = 0
212:             .FontName  = "Tahoma"
213:             .FontSize  = 8
214:             .ForeColor = RGB(90, 90, 90)
215:             .Caption   = "\<Lista de Pre" + CHR(231) + "os"
216:             .Visible   = .T.
217:         ENDWITH
218: 
219:         *-- chkLista "Carrega Itens" (Value=1 = marcado por default, legado)
220:         THIS.AddObject("chk_4c_ChkLista", "CheckBox")
221:         WITH THIS.chk_4c_ChkLista
222:             .Top       = 102
223:             .Left      = 24
224:             .Width     = 100
225:             .Height    = 15
226:             .Caption   = "Carrega " + CHR(205) + "tens"
227:             .FontName  = "Tahoma"
228:             .FontSize  = 8
229:             .ForeColor = RGB(90, 90, 90)
230:             .BackStyle = 0
231:             .Value     = IIF(THIS.this_oBusinessObject.this_lCarregaItensLista, 1, 0)
232:             .Visible   = .T.
233:         ENDWITH
234:         BINDEVENT(THIS.chk_4c_ChkLista, "Click", THIS, "ChkListaClick")
235: 
236:         *-- Get_lpreco - lookup fwbuscaext(SigCdLpc, LPrecos) - lista principal
237:         THIS.AddObject("txt_4c_Lpreco", "TextBox")
238:         WITH THIS.txt_4c_Lpreco
239:             .Top       = 105
240:             .Left      = 132
241:             .Width     = 294
242:             .Height    = 22
243:             .MaxLength = 30
244:             .Value     = ""
245:             .FontName  = "Tahoma"
246:             .FontSize  = 8
247:             .ForeColor = RGB(90, 90, 90)
248:             .Visible   = .T.
249:         ENDWITH
250:         BINDEVENT(THIS.txt_4c_Lpreco, "KeyPress", THIS, "Txt4cLprecoKeyPress")
251: 
252:         *-- getLPreco2 - lookup fwbuscaext(SigCdLpc, LPrecos) - lista secundaria
253:         THIS.AddObject("txt_4c_LPreco2", "TextBox")
254:         WITH THIS.txt_4c_LPreco2
255:             .Top       = 128
256:             .Left      = 132
257:             .Width     = 294
258:             .Height    = 22
259:             .MaxLength = 30
260:             .Value     = ""
261:             .FontName  = "Tahoma"
262:             .FontSize  = 8
263:             .ForeColor = RGB(90, 90, 90)
264:             .Visible   = .T.
265:         ENDWITH
266:         BINDEVENT(THIS.txt_4c_LPreco2, "KeyPress", THIS, "Txt4cLPreco2KeyPress")
267: 
268:         *-- Label4 "Movimentacoes"
269:         THIS.AddObject("lbl_4c_Label4", "Label")
270:         WITH THIS.lbl_4c_Label4
271:             .Top       = 154
272:             .Left      = 20
273:             .Width     = 130
274:             .Height    = 15
275:             .BackStyle = 0
276:             .Alignment = 0
277:             .FontName  = "Tahoma"
278:             .FontSize  = 8
279:             .ForeColor = RGB(90, 90, 90)
280:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
281:             .Visible   = .T.
282:         ENDWITH
283: 
284:         *-- chkOperacoes "Carrega Itens" (Value=1 = marcado por default, legado)
285:         THIS.AddObject("chk_4c_ChkOperacoes", "CheckBox")
286:         WITH THIS.chk_4c_ChkOperacoes
287:             .Top       = 169
288:             .Left      = 24
289:             .Width     = 100
290:             .Height    = 15
291:             .Caption   = "Carrega " + CHR(205) + "tens"
292:             .FontName  = "Tahoma"
293:             .FontSize  = 8
294:             .ForeColor = RGB(90, 90, 90)
295:             .BackStyle = 0
296:             .Value     = IIF(THIS.this_oBusinessObject.this_lCarregaItensOperacao, 1, 0)
297:             .Visible   = .T.
298:         ENDWITH
299:         BINDEVENT(THIS.chk_4c_ChkOperacoes, "Click", THIS, "ChkOperacoesClick")
300: 
301:         *-- Label5 "Emp" / Label6 "Movimentacao" / Label7 "Codigo"
302:         THIS.AddObject("lbl_4c_Label5", "Label")
303:         WITH THIS.lbl_4c_Label5
304:             .Top       = 161
305:             .Left      = 132
306:             .Width     = 40
307:             .Height    = 15
308:             .BackStyle = 0
309:             .Alignment = 0
310:             .FontName  = "Tahoma"
311:             .FontSize  = 8
312:             .ForeColor = RGB(90, 90, 90)
313:             .Caption   = "Emp"
314:             .Visible   = .T.
315:         ENDWITH
316: 
317:         THIS.AddObject("lbl_4c_Label6", "Label")
318:         WITH THIS.lbl_4c_Label6
319:             .Top       = 161
320:             .Left      = 165
321:             .Width     = 110
322:             .Height    = 15
323:             .BackStyle = 0
324:             .Alignment = 0
325:             .FontName  = "Tahoma"
326:             .FontSize  = 8
327:             .ForeColor = RGB(90, 90, 90)
328:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
329:             .Visible   = .T.
330:         ENDWITH
331: 
332:         THIS.AddObject("lbl_4c_Label7", "Label")
333:         WITH THIS.lbl_4c_Label7
334:             .Top       = 161
335:             .Left      = 317
336:             .Width     = 55
337:             .Height    = 15
338:             .BackStyle = 0
339:             .Alignment = 0

*-- Linhas 358 a 818:
358:             .ForeColor = RGB(90, 90, 90)
359:             .Visible   = .T.
360:         ENDWITH
361:         BINDEVENT(THIS.txt_4c_Emps, "KeyPress", THIS, "Txt4cEmpsKeyPress")
362: 
363:         *-- getDopes - fAcessoMovmto lookup (SigCdOpe.Dopes, char(20))
364:         THIS.AddObject("txt_4c_Dopes", "TextBox")
365:         WITH THIS.txt_4c_Dopes
366:             .Top       = 174
367:             .Left      = 165
368:             .Width     = 150
369:             .Height    = 23
370:             .MaxLength = 20
371:             .Value     = ""
372:             .FontName  = "Tahoma"
373:             .FontSize  = 8
374:             .ForeColor = RGB(90, 90, 90)
375:             .Visible   = .T.
376:         ENDWITH
377:         BINDEVENT(THIS.txt_4c_Dopes, "KeyPress", THIS, "Txt4cDopesKeyPress")
378: 
379:         *-- getNumes - numero da movimentacao (numerico, legado usa Str(...,6))
380:         THIS.AddObject("txt_4c_Numes", "TextBox")
381:         WITH THIS.txt_4c_Numes
382:             .Top        = 174
383:             .Left       = 317
384:             .Width      = 52
385:             .Height     = 23
386:             .Value      = 0
387:             .InputMask  = "999999"
388:             .Format     = "9"
389:             .FontName   = "Tahoma"
390:             .FontSize   = 8
391:             .ForeColor  = RGB(90, 90, 90)
392:             .Visible    = .T.
393:         ENDWITH
394: 
395:         *-- lbl_titulo (\<Etiquetas Selecionadas) - titulo de secao da grade
396:         THIS.AddObject("lbl_4c_Lbl_titulo", "Label")
397:         WITH THIS.lbl_4c_Lbl_titulo
398:             .Top       = 203
399:             .Left      = 10
400:             .Width     = 200
401:             .Height    = 15
402:             .BackStyle = 0
403:             .Alignment = 0
404:             .FontName  = "Tahoma"
405:             .FontSize  = 8
406:             .FontBold  = .T.
407:             .ForeColor = RGB(90, 90, 90)
408:             .Caption   = "\<Etiquetas Selecionadas"
409:             .Visible   = .T.
410:         ENDWITH
411:     ENDPROC
412: 
413:     *==========================================================================
414:     * ChkListaClick / ChkOperacoesClick - Espelham o CheckBox.Value (numerico)
415:     * na property logical correspondente do BO (regra CLAUDE.md - CheckBox
416:     * Value nunca vai direto para prop LOGICAL sem conversao explicita).
417:     * PUBLIC: bindado via BINDEVENT.
418:     *==========================================================================
419:     PROCEDURE ChkListaClick()
420:         THIS.this_oBusinessObject.this_lCarregaItensLista = (THIS.chk_4c_ChkLista.Value = 1)
421:     ENDPROC
422: 
423:     PROCEDURE ChkOperacoesClick()
424:         THIS.this_oBusinessObject.this_lCarregaItensOperacao = (THIS.chk_4c_ChkOperacoes.Value = 1)
425:     ENDPROC
426: 
427:     *==========================================================================
428:     * Txt4cLprecoKeyPress - Lookup da Lista de Precos principal (Get_lpreco no
429:     * legado). Transcricao do Get_lpreco.Valid: resolve o codigo digitado
430:     * contra SigCdLpc (fwbuscaext no legado -> FormBuscaAuxiliar/
431:     * AbrirLookupCanonico aqui), e ao final SEMPRE reconstroi a grade de
432:     * etiquetas a partir da lista resolvida (mesmo bloco de CarregarDados()).
433:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
434:     *==========================================================================
435:     PROCEDURE Txt4cLprecoKeyPress
436:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
437:         LOCAL loc_cValor
438: 
439:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
440:             RETURN
441:         ENDIF
442: 
443:         loc_cValor = ALLTRIM(THIS.txt_4c_Lpreco.Value)
444:         IF EMPTY(loc_cValor)
445:             RETURN
446:         ENDIF
447: 
448:         IF par_nKeyCode = 115 OR !THIS.this_oBusinessObject.ValidarListaPreco(loc_cValor)
449:             IF !THIS.AbrirLookupCanonico("SigCdLpc", "LPrecos", "LPrecos", ;
450:                     "Sele" + CHR(231) + CHR(227) + "o de Lista de Pre" + CHR(231) + "os", ;
451:                     loc_cValor, THIS.txt_4c_Lpreco, .NULL.)
452:                 *-- Legado: This.Value = Iif(Lastkey()=27, '', crListaRemota.LPrecos)
453:                 THIS.txt_4c_Lpreco.Value = ""
454:             ENDIF
455:         ENDIF
456: 
457:         THIS.CarregarDados()
458:     ENDPROC
459: 
460:     *==========================================================================
461:     * Txt4cLPreco2KeyPress - Lookup da Lista de Precos secundaria (getLPreco2
462:     * no legado). Transcricao do getLPreco2.Valid: so resolve o valor, sem
463:     * disparar carga da grade (o legado nao tem esse bloco nesse campo).
464:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
465:     *==========================================================================
466:     PROCEDURE Txt4cLPreco2KeyPress
467:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
468:         LOCAL loc_cValor
469: 
470:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
471:             RETURN
472:         ENDIF
473: 
474:         loc_cValor = ALLTRIM(THIS.txt_4c_LPreco2.Value)
475:         IF EMPTY(loc_cValor)
476:             RETURN
477:         ENDIF
478: 
479:         IF par_nKeyCode = 115 OR !THIS.this_oBusinessObject.ValidarListaPreco(loc_cValor)
480:             IF !THIS.AbrirLookupCanonico("SigCdLpc", "LPrecos", "LPrecos", ;
481:                     "Sele" + CHR(231) + CHR(227) + "o de Lista de Pre" + CHR(231) + "os", ;
482:                     loc_cValor, THIS.txt_4c_LPreco2, .NULL.)
483:                 THIS.txt_4c_LPreco2.Value = ""
484:             ENDIF
485:         ENDIF
486:     ENDPROC
487: 
488:     *==========================================================================
489:     * Txt4cEmpsKeyPress - Lookup/validacao de Empresa (getEmps no legado,
490:     * fAcessoEmpresa(Usuar,'C',...) - funcao global NAO PORTADA, ver licao
491:     * aprendida feedback_facessoempresa_nao_portada). Substitui por
492:     * BO.ValidarEmpresa + AbrirLookupCanonico sobre SigCdEmp.
493:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
494:     *==========================================================================
495:     PROCEDURE Txt4cEmpsKeyPress
496:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
497:         LOCAL loc_cValor
498: 
499:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
500:             RETURN
501:         ENDIF
502: 
503:         loc_cValor = ALLTRIM(THIS.txt_4c_Emps.Value)
504:         IF EMPTY(loc_cValor)
505:             RETURN
506:         ENDIF
507: 
508:         IF par_nKeyCode = 115 OR !THIS.this_oBusinessObject.ValidarEmpresa(loc_cValor)
509:             IF !THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
510:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
511:                     loc_cValor, THIS.txt_4c_Emps, .NULL.)
512:                 THIS.txt_4c_Emps.Value = ""
513:             ENDIF
514:         ENDIF
515:     ENDPROC
516: 
517:     *==========================================================================
518:     * Txt4cDopesKeyPress - Lookup/validacao de Operacao (getDopes no legado,
519:     * fAcessoMovmto(Usuar,...) - funcao global NAO PORTADA, mesma familia da
520:     * licao fAcessoEmpresa). Substitui por BO.ValidarOperacao +
521:     * AbrirLookupCanonico sobre SigCdOpe. SigCdOpe eh single-column (regra
522:     * CLAUDE.md - "SigCdOpe eh single-column: NUNCA usar descrs/Descrs"): o
523:     * mesmo campo Dopes eh passado como codigo E descricao do helper.
524:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
525:     *==========================================================================
526:     PROCEDURE Txt4cDopesKeyPress
527:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
528:         LOCAL loc_cValor
529: 
530:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
531:             RETURN
532:         ENDIF
533: 
534:         loc_cValor = ALLTRIM(THIS.txt_4c_Dopes.Value)
535:         IF EMPTY(loc_cValor)
536:             RETURN
537:         ENDIF
538: 
539:         IF par_nKeyCode = 115 OR !THIS.this_oBusinessObject.ValidarOperacao(loc_cValor)
540:             IF !THIS.AbrirLookupCanonico("SigCdOpe", "Dopes", "Dopes", ;
541:                     "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o", ;
542:                     loc_cValor, THIS.txt_4c_Dopes, .NULL.)
543:                 THIS.txt_4c_Dopes.Value = ""
544:             ENDIF
545:         ENDIF
546:     ENDPROC
547: 
548:     *==========================================================================
549:     * CriarCursorDados - Cria o cursor da grade de etiquetas selecionadas
550:     * (equivalente ao dbImpressao criado no Load() do form legado). Mantido
551:     * em metodo proprio (nao dentro do Load/Init) porque o novo sistema nao
552:     * separa Load de Init - a estrutura do cursor precisa existir ANTES do
553:     * ConfigurarGridEtiquetas() fazer o bind do Grid (regra CLAUDE.md #41:
554:     * Column.ControlSource de cursor que ainda nao existe derruba o Init).
555:     *==========================================================================
556:     PROTECTED PROCEDURE CriarCursorDados()
557:         IF USED("cursor_4c_Dados")
558:             USE IN cursor_4c_Dados
559:         ENDIF
560: 
561:         CREATE CURSOR cursor_4c_Dados ( ;
562:             Cpros      C(14), ;
563:             DPros      C(40), ;
564:             Reffs      C(40), ;
565:             Qtds       N(10,3), ;
566:             QtdeEtiq   N(10,3), ;
567:             Pedido     C(30), ;
568:             Obs        C(10), ;
569:             PVens      N(12,2), ;
570:             PrecoDe    N(12,2), ;
571:             Parcelas   N(2,0), ;
572:             Cpros2     C(14), ;
573:             Cpros3     C(14), ;
574:             Cpros4     C(14), ;
575:             empos      C(3), ;
576:             empdopnums C(29), ;
577:             citens     N(10), ;
578:             Pesos      N(12,2), ;
579:             CodTams    C(4), ;
580:             DPro2s     C(45))
581: 
582:         INDEX ON Cpros TAG Cpros
583:         INDEX ON RECNO() TAG Registros
584:         SET ORDER TO
585:         APPEND BLANK
586:     ENDPROC
587: 
588:     *==========================================================================
589:     * ConfigurarGridEtiquetas - Monta o Grd_Etiqueta legado (grd_4c_Dados),
590:     * com as 7 colunas e a ordem visual exata do SCX (ColumnOrder: cpros=1,
591:     * DPro2s=2, dpros=3, qtds=4, parcelas=5, PVens=6, PrecoDe=7).
592:     *==========================================================================
593:     PROTECTED PROCEDURE ConfigurarGridEtiquetas()
594:         THIS.AddObject("grd_4c_Dados", "GridBase")
595:         WITH THIS.grd_4c_Dados
596:             .Top          = 216
597:             .Left         = 12
598:             .Width        = 818
599:             .Height       = 157
600:             .ColumnCount  = 7
601:             .RecordSource = "cursor_4c_Dados"
602:             .FontName     = "Tahoma"
603:             .FontSize     = 8
604:             .HeaderHeight = 17
605:             .RowHeight    = 17
606:             .ScrollBars   = 2
607:             .DeleteMark   = .F.
608:             .RecordMark   = .F.
609:             .Visible      = .T.
610: 
611:             WITH .Column1
612:                 .ControlSource     = "cursor_4c_Dados.Cpros"
613:                 .Width             = 110
614:                 .ColumnOrder       = 1
615:                 .Movable           = .F.
616:                 .Resizable         = .F.
617:                 .FontName          = "Tahoma"
618:                 .FontSize          = 8
619:                 .Header1.Caption   = "Produto"
620:                 .Header1.Alignment = 2
621:                 .Header1.ForeColor = RGB(90, 90, 90)
622:             ENDWITH
623: 
624:             WITH .Column2
625:                 .ControlSource     = "cursor_4c_Dados.DPros"
626:                 .Width             = 270
627:                 .ColumnOrder       = 3
628:                 .Movable           = .F.
629:                 .Resizable         = .F.
630:                 .FontName          = "Tahoma"
631:                 .FontSize          = 8
632:                 .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
633:                 .Header1.Alignment = 2
634:                 .Header1.ForeColor = RGB(90, 90, 90)
635:             ENDWITH
636: 
637:             WITH .Column3
638:                 .ControlSource     = "cursor_4c_Dados.Qtds"
639:                 .Width             = 65
640:                 .ColumnOrder       = 4
641:                 .Movable           = .F.
642:                 .Resizable         = .F.
643:                 .FontName          = "Tahoma"
644:                 .FontSize          = 8
645:                 .Format            = "999,999.99"
646:                 .InputMask         = "999,999.99"
647:                 .Header1.Caption   = "Quantidade"
648:                 .Header1.Alignment = 2
649:                 .Header1.ForeColor = RGB(90, 90, 90)
650:             ENDWITH
651: 
652:             WITH .Column4
653:                 .ControlSource     = "cursor_4c_Dados.DPro2s"
654:                 .Width             = 135
655:                 .ColumnOrder       = 2
656:                 .FontName          = "Tahoma"
657:                 .FontSize          = 8
658:                 .Header1.Caption   = "Refer" + CHR(234) + "ncia Fornecedor"
659:                 .Header1.Alignment = 2
660:                 .Header1.ForeColor = RGB(90, 90, 90)
661:             ENDWITH
662: 
663:             WITH .Column5
664:                 .ControlSource     = "cursor_4c_Dados.Parcelas"
665:                 .Width             = 60
666:                 .ColumnOrder       = 5
667:                 .Movable           = .F.
668:                 .Resizable         = .F.
669:                 .FontName          = "Tahoma"
670:                 .FontSize          = 8
671:                 .Header1.Caption   = "Parcelas"
672:                 .Header1.Alignment = 2
673:                 .Header1.ForeColor = RGB(90, 90, 90)
674:             ENDWITH
675: 
676:             WITH .Column6
677:                 .ControlSource     = "cursor_4c_Dados.PVens"
678:                 .Width             = 70
679:                 .ColumnOrder       = 6
680:                 .Movable           = .F.
681:                 .Resizable         = .F.
682:                 .Enabled           = .F.
683:                 .ReadOnly          = .T.
684:                 .FontName          = "Tahoma"
685:                 .FontSize          = 8
686:                 .Header1.Caption   = "Pre" + CHR(231) + "o"
687:                 .Header1.Alignment = 2
688:                 .Header1.ForeColor = RGB(90, 90, 90)
689:             ENDWITH
690: 
691:             WITH .Column7
692:                 .ControlSource     = "cursor_4c_Dados.PrecoDe"
693:                 .Width             = 70
694:                 .ColumnOrder       = 7
695:                 .Movable           = .F.
696:                 .Resizable         = .F.
697:                 .Enabled           = .F.
698:                 .ReadOnly          = .T.
699:                 .FontName          = "Tahoma"
700:                 .FontSize          = 8
701:                 .Header1.Caption   = "Pre" + CHR(231) + "o De"
702:                 .Header1.Alignment = 2
703:                 .Header1.ForeColor = RGB(90, 90, 90)
704:             ENDWITH
705:         ENDWITH
706:     ENDPROC
707: 
708:     *==========================================================================
709:     * ConfigurarLookupsGrade - Registra os BINDEVENT de KeyPress das colunas
710:     * editaveis do grd_4c_Dados (col_cpros/col_dpros/col_qtds/col_DPro2s no
711:     * legado). Colunas de Grid ja nascem com um Text1 default (nao precisa
712:     * AddObject - regra CLAUDE.md #18 so vale para controle CUSTOM tipo
713:     * CheckBox/ComboBox/OptionGroup).
714:     *==========================================================================
715:     PROTECTED PROCEDURE ConfigurarLookupsGrade()
716:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "ValidarProdutoGrid")
717:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "ValidarDescricaoGrid")
718:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "ValidarQtdGrid")
719:         BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "KeyPress", THIS, "ValidarDescritivoGrid")
720:     ENDPROC
721: 
722:     *==========================================================================
723:     * ValidarProdutoGrid - Coluna Produto da grade (col_cpros.txt_cpros no
724:     * legado). Transcricao do Valid legado: resolve EAN13/codigo de barras,
725:     * bloqueia produto com etiqueta individual, resolve por lookup
726:     * (fwbuscaext -> AbrirLookupCanonico) e aplica peso/preco/lista de
727:     * precos na linha corrente do cursor de grade.
728:     * Nota: o legado tambem chama fVerificarBarras(_Prod) - funcao global
729:     * NAO PORTADA (SIGFUNCS.PRG). O resultado dela e combinado com "OR
730:     * Len(_Prod) <= 14" antes de decidir buscar por CBars; como CPros eh
731:     * char(14), essa segunda condicao e sempre verdadeira para um valor de
732:     * produto valido e por isso a busca por codigo de barras SEMPRE
733:     * executa - o wrapper de fVerificarBarras fica sem efeito pratico e foi
734:     * omitido (regra CLAUDE.md #27, categoria "no-op documentado").
735:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
736:     *==========================================================================
737:     PROCEDURE ValidarProdutoGrid
738:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
739:         LOCAL loc_cCursor, loc_cProd, loc_nCod, loc_cUnidade, ;
740:               loc_cCodResolvido, loc_nValLista, loc_nValDeLista
741: 
742:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
743:             RETURN
744:         ENDIF
745: 
746:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
747:         loc_cProd   = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
748: 
749:         IF EMPTY(loc_cProd)
750:             THIS.grd_4c_Dados.Column2.Text1.Value = ""
751:             THIS.grd_4c_Dados.Refresh()
752:             RETURN
753:         ENDIF
754: 
755:         *-- Legado: valor puramente numerico pode ser o EAN13 do produto.
756:         loc_nCod = INT(VAL(loc_cProd))
757:         IF loc_nCod > 0 AND THIS.this_oBusinessObject.BuscarProdutoPorEan13(loc_nCod, "cursor_4c_ProdEan13Grid")
758:             SELECT cursor_4c_ProdEan13Grid
759:             loc_cProd = ALLTRIM(TratarNulo(CPros, ""))
760:         ENDIF
761: 
762:         *-- Busca por codigo de barras interno (ver nota do cabecalho sobre
763:         *-- fVerificarBarras - este bloco SEMPRE roda para CPros char(14)).
764:         loc_nCod = INT(VAL(loc_cProd))
765:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigoBarras(loc_nCod, "cursor_4c_ProdBarrasGrid")
766:             SELECT cursor_4c_ProdBarrasGrid
767:             loc_cProd = ALLTRIM(TratarNulo(CPros, ""))
768:         ELSE
769:             MsgAviso("Produto N" + CHR(227) + "o Cadastrado!!!", "")
770:             RETURN
771:         ENDIF
772: 
773:         *-- Unidade com etiqueta individual bloqueia impressao em lote.
774:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cProd, "cursor_4c_ProdUnidGrid")
775:             SELECT cursor_4c_ProdUnidGrid
776:             loc_cUnidade = ALLTRIM(TratarNulo(CUnis, ""))
777:             IF !EMPTY(loc_cUnidade) AND THIS.this_oBusinessObject.VerificarUnidadeEtiquetaIndividual(loc_cUnidade)
778:                 MsgAviso("Unidade do Produto (" + loc_cUnidade + ") Utiliza Etiqueta Individual !!!" + CHR(13) + ;
779:                          "Utilize o M" + CHR(243) + "dulo de Reimpress" + CHR(227) + "o de Etiquetas Individuais !!!", "")
780:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
781:                 THIS.grd_4c_Dados.Refresh()
782:                 RETURN
783:             ENDIF
784:         ENDIF
785: 
786:         *-- Lookup (fwbuscaext no legado) - so quando nao ha match unico direto.
787:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cProd, "cursor_4c_ProdLookupGrid") AND ;
788:            RECCOUNT("cursor_4c_ProdLookupGrid") = 1
789:             SELECT cursor_4c_ProdLookupGrid
790:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
791:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
792:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
793:         ELSE
794:             IF THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", ;
795:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cProd, ;
796:                     THIS.grd_4c_Dados.Column1.Text1, THIS.grd_4c_Dados.Column2.Text1)
797:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescritivoGrid")
798:                     SELECT cursor_4c_ProdDescritivoGrid
799:                     THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
800:                 ENDIF
801:             ELSE
802:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
803:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
804:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
805:             ENDIF
806:         ENDIF
807: 
808:         *-- Aplica peso/preco do produto na linha corrente do cursor de grade.
809:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
810:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
811:            THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPrecoGrid")
812:             SELECT cursor_4c_ProdPrecoGrid
813:             SELECT (loc_cCursor)
814:             REPLACE Pesos   WITH TratarNulo(cursor_4c_ProdPrecoGrid.PesoMs, 0), ;
815:                     PVens   WITH TratarNulo(cursor_4c_ProdPrecoGrid.PVens, 0), ;
816:                     PrecoDe WITH TratarNulo(cursor_4c_ProdPrecoGrid.PrecoDe, 0)
817:         ENDIF
818: 

*-- Linhas 851 a 896:
851:     * automatico) nao tem equivalente direto e foi omitida - eh conveniencia
852:     * de UI, nao regra de negocio (regra CLAUDE.md #17 se aplica a formula/
853:     * fluxo, nao a atalho de teclado).
854:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
855:     *==========================================================================
856:     PROCEDURE ValidarDescricaoGrid
857:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
858:         LOCAL loc_cCursor, loc_cDesc, loc_cCodResolvido
859: 
860:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
861:             RETURN
862:         ENDIF
863: 
864:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
865:         loc_cDesc   = ALLTRIM(THIS.grd_4c_Dados.Column2.Text1.Value)
866: 
867:         IF EMPTY(loc_cDesc)
868:             THIS.grd_4c_Dados.Column1.Text1.Value = ""
869:             THIS.grd_4c_Dados.Refresh()
870:             RETURN
871:         ENDIF
872: 
873:         IF THIS.this_oBusinessObject.BuscarProdutoPorDescricao(loc_cDesc, "cursor_4c_ProdDescGrid") AND ;
874:            RECCOUNT("cursor_4c_ProdDescGrid") = 1
875:             SELECT cursor_4c_ProdDescGrid
876:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
877:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
878:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
879:         ELSE
880:             IF THIS.AbrirLookupCanonico("SigCdPro", "DPros", "CPros", ;
881:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cDesc, ;
882:                     THIS.grd_4c_Dados.Column2.Text1, THIS.grd_4c_Dados.Column1.Text1)
883:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescritivo2Grid")
884:                     SELECT cursor_4c_ProdDescritivo2Grid
885:                     THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
886:                 ENDIF
887:             ELSE
888:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
889:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
890:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
891:             ENDIF
892:         ENDIF
893: 
894:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
895:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
896:            THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPeso2Grid")

*-- Linhas 912 a 957:
912:     * busca do legado eh feita pelo campo Dpro2s do produto). Transcricao do
913:     * Valid legado: resolve por match exato de Dpro2s e, sem match unico,
914:     * por lookup (fwbuscaext -> AbrirLookupCanonico).
915:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
916:     *==========================================================================
917:     PROCEDURE ValidarDescritivoGrid
918:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
919:         LOCAL loc_cCursor, loc_cDescritivo, loc_cCodResolvido
920: 
921:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
922:             RETURN
923:         ENDIF
924: 
925:         loc_cCursor     = THIS.this_oBusinessObject.this_cCursorDados
926:         loc_cDescritivo = ALLTRIM(THIS.grd_4c_Dados.Column4.Text1.Value)
927: 
928:         IF EMPTY(loc_cDescritivo)
929:             THIS.grd_4c_Dados.Column1.Text1.Value = ""
930:             THIS.grd_4c_Dados.Column2.Text1.Value = ""
931:             THIS.grd_4c_Dados.Refresh()
932:             RETURN
933:         ENDIF
934: 
935:         IF THIS.this_oBusinessObject.BuscarProdutoPorDescritivo(loc_cDescritivo, "cursor_4c_ProdDescrvGrid") AND ;
936:            RECCOUNT("cursor_4c_ProdDescrvGrid") = 1
937:             SELECT cursor_4c_ProdDescrvGrid
938:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
939:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
940:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
941:         ELSE
942:             IF THIS.AbrirLookupCanonico("SigCdPro", "Dpro2s", "CPros", ;
943:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cDescritivo, ;
944:                     THIS.grd_4c_Dados.Column4.Text1, THIS.grd_4c_Dados.Column1.Text1)
945:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescricao3Grid")
946:                     SELECT cursor_4c_ProdDescricao3Grid
947:                     THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
948:                 ENDIF
949:             ELSE
950:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
951:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
952:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
953:             ENDIF
954:         ENDIF
955: 
956:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
957:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;

*-- Linhas 978 a 1108:
978:     * que o guard inicial "If Lastkey()<>13 Return" filtra tudo que nao seja
979:     * Enter antes deles). Mantem sempre uma linha em branco no final para
980:     * digitacao (legado: Set Order To Cpros + Seek(Space(14))).
981:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
982:     *==========================================================================
983:     PROCEDURE ValidarQtdGrid
984:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
985:         LOCAL loc_cCursor, loc_cProduto, loc_nApurado, loc_cChave
986: 
987:         IF par_nKeyCode != 13
988:             RETURN
989:         ENDIF
990: 
991:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
992:         IF !USED(loc_cCursor)
993:             RETURN
994:         ENDIF
995: 
996:         SELECT (loc_cCursor)
997:         loc_cProduto = PADR(Cpros, 14)
998:         loc_nApurado = Qtds
999: 
1000:         IF EMPTY(loc_cProduto)
1001:             RETURN
1002:         ENDIF
1003: 
1004:         IF !THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cProduto), "cursor_4c_ProdValidaQtdGrid")
1005:             MsgAviso("Produto Inv" + CHR(225) + "lido!!!", "")
1006:             RETURN
1007:         ENDIF
1008: 
1009:         IF loc_nApurado <= 0
1010:             MsgAviso("Valor Apurado Inv" + CHR(225) + "lido!!!", "")
1011:             RETURN
1012:         ENDIF
1013: 
1014:         SELECT (loc_cCursor)
1015:         SET ORDER TO Cpros
1016:         loc_cChave = SPACE(14)
1017:         IF !SEEK(loc_cChave)
1018:             APPEND BLANK
1019:         ENDIF
1020:         SET ORDER TO
1021: 
1022:         THIS.grd_4c_Dados.Refresh()
1023:     ENDPROC
1024: 
1025:     *==========================================================================
1026:     * ConfigurarBotoesGrade - Botoes de acao da grade de etiquetas
1027:     * (btnCarregar/btnexcluir no legado - icones-only, SEM CommandGroup).
1028:     *==========================================================================
1029:     PROTECTED PROCEDURE ConfigurarBotoesGrade()
1030:         THIS.AddObject("cmd_4c_BtnCarregar", "CommandButton")
1031:         WITH THIS.cmd_4c_BtnCarregar
1032:             .Top             = 159
1033:             .Left            = 373
1034:             .Width           = 32
1035:             .Height          = 32
1036:             .Caption         = ""
1037:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
1038:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
1039:             .Themes          = .T.
1040:             .ToolTipText     = "Carregar Itens"
1041:             .Visible         = .T.
1042:         ENDWITH
1043:         BINDEVENT(THIS.cmd_4c_BtnCarregar, "Click", THIS, "BtnCarregarClick")
1044: 
1045:         THIS.AddObject("cmd_4c_Btnexcluir", "CommandButton")
1046:         WITH THIS.cmd_4c_Btnexcluir
1047:             .Top             = 374
1048:             .Left            = 21
1049:             .Width           = 32
1050:             .Height          = 32
1051:             .Caption         = ""
1052:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1053:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1054:             .Themes          = .T.
1055:             .ToolTipText     = "Excluir item"
1056:             .Visible         = .T.
1057:         ENDWITH
1058:         BINDEVENT(THIS.cmd_4c_Btnexcluir, "Click", THIS, "BtnExcluirItemClick")
1059:     ENDPROC
1060: 
1061:     *==========================================================================
1062:     * CriarCursorImpressorasWindows - Popula o cursor crImpreV (RowSource do
1063:     * Get_Printer/cbo_4c_Get_Printer) com as impressoras Windows instaladas
1064:     * na estacao. Precisa existir ANTES do ComboBox ser criado (regra
1065:     * CLAUDE.md #41 - ControlSource/RowSource de cursor inexistente derruba
1066:     * o Init).
1067:     *==========================================================================
1068:     PROTECTED PROCEDURE CriarCursorImpressorasWindows()
1069:         LOCAL loc_nImp, loc_nTotal, loc_cAliasAut, loc_lTemAutorizadas, loc_oErro
1070:         LOCAL ARRAY loc_aImpressoras[1, 2]
1071: 
1072:         *-- crImpre: impressoras instaladas no Windows (legado: Create Cursor
1073:         *-- crImpre + laPrinters de APrinters()).
1074:         IF USED("crImpre")
1075:             USE IN crImpre
1076:         ENDIF
1077:         CREATE CURSOR crImpre (Impres C(60))
1078: 
1079:         loc_nTotal = APRINTERS(loc_aImpressoras)
1080:         IF loc_nTotal > 0
1081:             FOR loc_nImp = 1 TO loc_nTotal
1082:                 INSERT INTO crImpre (Impres) VALUES (UPPER(loc_aImpressoras[loc_nImp, 1]))
1083:             ENDFOR
1084:         ENDIF
1085: 
1086:         *-- crSigCdmp: impressoras de ETIQUETA (SigCdmp.nTpImpres = 2) que o
1087:         *-- usuario pode usar - por acesso direto (SigSyImp) ou por grupo
1088:         *-- (SigCdAcG). Legado: quando o UNION ALL nao devolve linha nenhuma,
1089:         *-- ele repete a consulta SEM restricao de acesso.
1090:         loc_cAliasAut      = "cursor_4c_ImpAutTmp"
1091:         loc_lTemAutorizadas = .F.
1092: 
1093:         TRY
1094:             IF USED("crSigCdmp")
1095:                 USE IN crSigCdmp
1096:             ENDIF
1097: 
1098:             IF THIS.this_oBusinessObject.BuscarImpressorasAutorizadas(gc_4c_UsuarioLogado, loc_cAliasAut) ;
1099:                AND RECCOUNT(loc_cAliasAut) > 0
1100: 
1101:                 SELECT DISTINCT Impres FROM (loc_cAliasAut) ;
1102:                     ORDER BY Impres INTO CURSOR crSigCdmp READWRITE
1103:                 loc_lTemAutorizadas = .T.
1104:             ELSE
1105:                 IF THIS.this_oBusinessObject.BuscarImpressorasEtiqueta("crSigCdmp") ;
1106:                    AND RECCOUNT("crSigCdmp") > 0
1107:                     loc_lTemAutorizadas = .T.
1108:                 ENDIF

*-- Linhas 1116 a 1195:
1116:             THIS.this_cMensagemErro = loc_oErro.Message
1117:             MsgErro(loc_oErro.Message + CHR(13) + ;
1118:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1119:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Listar Impressoras")
1120:         ENDTRY
1121: 
1122:         *-- crImpreV: par "impressora do sistema x impressora do Windows".
1123:         *-- Estrutura FIXA nos dois caminhos (regra do CREATE CURSOR com ordem
1124:         *-- identica em todos os locais): IDupla eh a coluna 1 e portanto o
1125:         *-- texto exibido pelo ComboBox; Impres eh o nome Windows que vai para
1126:         *-- a impressao; ImpresS eh o nome de sistema usado no ajuste fino.
1127:         IF USED("cursor_4c_ImpPar")
1128:             USE IN cursor_4c_ImpPar
1129:         ENDIF
1130:         CREATE CURSOR cursor_4c_ImpPar (IDupla C(66), Impres C(60), ImpresS C(60))
1131: 
1132:         IF loc_lTemAutorizadas
1133:             *-- Legado: casa as duas listas por conter-um-ao-outro (o nome
1134:             *-- cadastrado costuma ser um prefixo do nome instalado).
1135:             SELECT crSigCdmp
1136:             SCAN
1137:                 SELECT crImpre
1138:                 SCAN
1139:                     IF ALLTRIM(UPPER(crSigCdmp.Impres)) $ ALLTRIM(UPPER(crImpre.Impres)) ;
1140:                        OR ALLTRIM(UPPER(crImpre.Impres)) $ ALLTRIM(UPPER(crSigCdmp.Impres))
1141: 
1142:                         INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ( ;
1143:                             PADR(ALLTRIM(crSigCdmp.Impres), 15) + " " + ALLTRIM(crImpre.Impres), ;
1144:                             crImpre.Impres, ;
1145:                             crSigCdmp.Impres)
1146:                     ENDIF
1147:                     SELECT crImpre
1148:                 ENDSCAN
1149:                 SELECT crSigCdmp
1150:             ENDSCAN
1151: 
1152:             *-- Legado: com mais de um par casado, a lista ganha uma linha em
1153:             *-- BRANCO que, pela ordenacao por IDupla, fica em PRIMEIRO - a
1154:             *-- tela abre sem impressora escolhida e obriga a escolha
1155:             *-- explicita ("se houver mais de uma impressora na lista,
1156:             *-- posiciona em impressora em branco").
1157:             IF RECCOUNT("cursor_4c_ImpPar") > 1
1158:                 INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ("", "", "")
1159:             ENDIF
1160:         ENDIF
1161: 
1162:         *-- Sem banco (modo de teste/validacao de UI) ou sem nenhum par casado,
1163:         *-- a tela ainda precisa listar as impressoras do Windows - caso
1164:         *-- contrario o ComboBox abre vazio e nao ha como imprimir.
1165:         IF RECCOUNT("cursor_4c_ImpPar") = 0
1166:             SELECT crImpre
1167:             SCAN
1168:                 INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ( ;
1169:                     ALLTRIM(crImpre.Impres), crImpre.Impres, crImpre.Impres)
1170:             ENDSCAN
1171:         ENDIF
1172: 
1173:         IF USED("crImpreV")
1174:             USE IN crImpreV
1175:         ENDIF
1176:         SELECT IDupla, Impres, ImpresS FROM cursor_4c_ImpPar ;
1177:             ORDER BY IDupla INTO CURSOR crImpreV READWRITE
1178: 
1179:         IF USED("cursor_4c_ImpPar")
1180:             USE IN cursor_4c_ImpPar
1181:         ENDIF
1182:         IF USED("crImpre")
1183:             USE IN crImpre
1184:         ENDIF
1185:         IF USED("crSigCdmp")
1186:             USE IN crSigCdmp
1187:         ENDIF
1188: 
1189:         *-- Legado: lnImp = Reccount('crImpreV') - alimenta o Enabled do botao
1190:         *-- Imprimir (ver HabilitarCampos).
1191:         THIS.this_nTotalImpressoras = RECCOUNT("crImpreV")
1192: 
1193:         SELECT crImpreV
1194:         GO TOP
1195:     ENDPROC

*-- Linhas 1204 a 1321:
1204:     * amarra o fluxo de impressao (BTNREPORT), que tambem nao foi criado
1205:     * ainda nesta fase.
1206:     *==========================================================================
1207:     PROTECTED PROCEDURE ConfigurarCamposImpressao()
1208: 
1209:         *-- Shape3 - moldura decorativa em volta do bloco Impressora
1210:         THIS.AddObject("shp_4c_Shape3", "Shape")
1211:         WITH THIS.shp_4c_Shape3
1212:             .Top           = 431
1213:             .Left          = 260
1214:             .Height        = 106
1215:             .Width         = 254
1216:             .BackStyle     = 0
1217:             .BorderWidth   = 1
1218:             .SpecialEffect = 1
1219:             .Visible       = .T.
1220:         ENDWITH
1221: 
1222:         *-- Opt_Tipo - tipo de etiqueta (populado dinamicamente em fase futura)
1223:         THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
1224:         WITH THIS.obj_4c_Opt_Tipo
1225:             .Top           = 431
1226:             .Left          = 13
1227:             .Width         = 240
1228:             .Height        = 182
1229:             .ButtonCount   = 1
1230:             .BackStyle     = 0
1231:             .SpecialEffect = 1
1232:             .Themes        = .F.
1233:             .Value         = THIS.this_oBusinessObject.this_nTipoEtiqueta
1234:             .Visible       = .T.
1235:             WITH .Buttons(1)
1236:                 .Caption   = "Rabicho"
1237:                 .Top       = 10
1238:                 .Left      = 9
1239:                 .Width     = 197
1240:                 .Height    = 16
1241:                 .BackStyle = 0
1242:                 .FontName  = "Tahoma"
1243:                 .FontSize  = 8
1244:                 .ForeColor = RGB(90, 90, 90)
1245:                 .Tag       = "1"
1246:             ENDWITH
1247:         ENDWITH
1248:         BINDEVENT(THIS.obj_4c_Opt_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")
1249: 
1250:         THIS.AddObject("lbl_4c_Label1", "Label")
1251:         WITH THIS.lbl_4c_Label1
1252:             .Top       = 415
1253:             .Left      = 23
1254:             .Width     = 99
1255:             .Height    = 15
1256:             .BackStyle = 0
1257:             .Alignment = 0
1258:             .FontBold  = .T.
1259:             .FontName  = "Tahoma"
1260:             .FontSize  = 8
1261:             .ForeColor = RGB(90, 90, 90)
1262:             .Caption   = "Tipo de Etiqueta"
1263:             .Visible   = .T.
1264:         ENDWITH
1265: 
1266:         *-- Cnt_Impressora - ajustes da impressora de etiqueta (Zebra/Allegro)
1267:         *-- Cnt_Impressora - CUIDADO: AddObject dos filhos fica FORA do WITH do
1268:         *-- container (regra CLAUDE.md - "WITH aninhado em Container/Label/
1269:         *-- CommandGroup AddObject" - WITH THIS.cnt_X / .AddObject(filho) /
1270:         *-- WITH .filho (2+ niveis relativos) ignora propriedade em silencio).
1271:         *-- Cada filho recebe WITH proprio com o CAMINHO COMPLETO.
1272:         THIS.AddObject("cnt_4c__Impressora", "Container")
1273:         WITH THIS.cnt_4c__Impressora
1274:             .Top       = 539
1275:             .Left      = 260
1276:             .Width     = 254
1277:             .Height    = 74
1278:             .BackStyle = 0
1279:             .Visible   = .T.
1280: 
1281:             .AddObject("obj_4c_Opcao_imp", "OptionGroup")
1282:             .AddObject("lbl_4c_Label2", "Label")
1283:             .AddObject("lbl_4c_Label3", "Label")
1284:             .AddObject("obj_4c_Spn_AjVerts", "Spinner")
1285:             .AddObject("obj_4c_Spn_AjHorzs", "Spinner")
1286:             .AddObject("obj_4c_Spn_AjDenss", "Spinner")
1287:             .AddObject("obj_4c_Spn_AjVelos", "Spinner")
1288:             .AddObject("lbl_4c_Label1", "Label")
1289:             .AddObject("lbl_4c_Label20", "Label")
1290:         ENDWITH
1291: 
1292:         WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp
1293:             .Top         = 3
1294:             .Left        = 5
1295:             .Width       = 241
1296:             .Height      = 24
1297:             .ButtonCount = 3
1298:             .Value       = THIS.this_oBusinessObject.this_nOpcaoImp
1299:             .Visible     = .T.
1300:             WITH .Buttons(1)
1301:                 .Caption   = "Allegro"
1302:                 .Top       = 4
1303:                 .Left      = 2
1304:                 .Width     = 51
1305:                 .AutoSize  = .T.
1306:                 .FontName  = "Tahoma"
1307:                 .FontSize  = 8
1308:                 .ForeColor = RGB(90, 90, 90)
1309:             ENDWITH
1310:             WITH .Buttons(2)
1311:                 .Caption   = "Zebra ZPL"
1312:                 .Top       = 4
1313:                 .Left      = 75
1314:                 .Width     = 66
1315:                 .AutoSize  = .T.
1316:                 .FontName  = "Tahoma"
1317:                 .FontSize  = 8
1318:                 .ForeColor = RGB(90, 90, 90)
1319:             ENDWITH
1320:             WITH .Buttons(3)
1321:                 .Caption   = "Zebra EPL"

*-- Linhas 1330 a 1834:
1330:                 .ForeColor = RGB(90, 90, 90)
1331:             ENDWITH
1332:         ENDWITH
1333:         BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Opcao_imp, "InteractiveChange", THIS, "OpcaoImpInteractiveChange")
1334: 
1335:         WITH THIS.cnt_4c__Impressora.lbl_4c_Label2
1336:             .Top       = 29
1337:             .Left      = 10
1338:             .Width     = 33
1339:             .Height    = 13
1340:             .BackStyle = 0
1341:             .Alignment = 0
1342:             .FontName  = "Tahoma"
1343:             .FontSize  = 7
1344:             .ForeColor = RGB(90, 90, 90)
1345:             .Caption   = "Vertical"
1346:             .Visible   = .T.
1347:         ENDWITH
1348: 
1349:         WITH THIS.cnt_4c__Impressora.lbl_4c_Label3
1350:             .Top       = 29
1351:             .Left      = 69
1352:             .Width     = 43
1353:             .Height    = 13
1354:             .BackStyle = 0
1355:             .Alignment = 0
1356:             .FontName  = "Tahoma"
1357:             .FontSize  = 7
1358:             .ForeColor = RGB(90, 90, 90)
1359:             .Caption   = "Horizontal"
1360:             .Visible   = .T.
1361:         ENDWITH
1362: 
1363:         WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts
1364:             .Top               = 42
1365:             .Left              = 10
1366:             .Width             = 56
1367:             .Height            = 26
1368:             .KeyboardLowValue  = 0
1369:             .KeyboardHighValue = 999
1370:             .SpinnerLowValue   = 0.00
1371:             .SpinnerHighValue  = 999.00
1372:             .FontName          = "Tahoma"
1373:             .Value             = THIS.this_oBusinessObject.this_nAjVerts
1374:             .Visible           = .T.
1375:         ENDWITH
1376:         BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts, "InteractiveChange", THIS, "SpnAjVertsInteractiveChange")
1377: 
1378:         WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs
1379:             .Top               = 42
1380:             .Left              = 69
1381:             .Width             = 56
1382:             .Height            = 26
1383:             .KeyboardLowValue  = -999
1384:             .KeyboardHighValue = 999
1385:             .SpinnerLowValue   = -999.00
1386:             .SpinnerHighValue  = 999.00
1387:             .FontName          = "Tahoma"
1388:             .Value             = THIS.this_oBusinessObject.this_nAjHorzs
1389:             .Visible           = .T.
1390:         ENDWITH
1391:         BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs, "InteractiveChange", THIS, "SpnAjHorzsInteractiveChange")
1392: 
1393:         WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss
1394:             .Top               = 42
1395:             .Left              = 128
1396:             .Width             = 56
1397:             .Height            = 26
1398:             .KeyboardLowValue  = 1
1399:             .KeyboardHighValue = 20
1400:             .SpinnerLowValue   = 1.00
1401:             .SpinnerHighValue  = 20.00
1402:             .FontName          = "Tahoma"
1403:             .Value             = 20
1404:             .Visible           = .T.
1405:         ENDWITH
1406:         THIS.this_oBusinessObject.this_nAjDenss = 20
1407:         BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss, "InteractiveChange", THIS, "SpnAjDenssInteractiveChange")
1408: 
1409:         WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos
1410:             .Top               = 42
1411:             .Left              = 188
1412:             .Width             = 54
1413:             .Height            = 26
1414:             .KeyboardLowValue  = 1
1415:             .KeyboardHighValue = 3
1416:             .SpinnerLowValue   = 1.00
1417:             .SpinnerHighValue  = 3.00
1418:             .FontName          = "Tahoma"
1419:             *-- Legado: spn_AjVelos = Iif(Empty(crSigCdPac.AjVelos), 01, ...),
1420:             *-- ou seja, o default SEM parametro cadastrado eh 1, nao o teto da
1421:             *-- faixa. BOParaForm sobrepoe com o valor de SigCdPac quando ha
1422:             *-- banco (ver CarregarParametrosPadrao).
1423:             .Value             = 1
1424:             .Visible           = .T.
1425:         ENDWITH
1426:         THIS.this_oBusinessObject.this_nAjVelos = 1
1427:         BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos, "InteractiveChange", THIS, "SpnAjVelosInteractiveChange")
1428: 
1429:         WITH THIS.cnt_4c__Impressora.lbl_4c_Label1
1430:             .Top       = 29
1431:             .Left      = 128
1432:             .Width     = 60
1433:             .Height    = 13
1434:             .BackStyle = 0
1435:             .Alignment = 0
1436:             .FontName  = "Tahoma"
1437:             .FontSize  = 7
1438:             .ForeColor = RGB(90, 90, 90)
1439:             .Caption   = "Densidade"
1440:             .Visible   = .T.
1441:         ENDWITH
1442: 
1443:         WITH THIS.cnt_4c__Impressora.lbl_4c_Label20
1444:             .Top       = 30
1445:             .Left      = 188
1446:             .Width     = 60
1447:             .Height    = 13
1448:             .BackStyle = 0
1449:             .Alignment = 0
1450:             .FontName  = "Tahoma"
1451:             .FontSize  = 7
1452:             .ForeColor = RGB(90, 90, 90)
1453:             .Caption   = "Velocidade"
1454:             .Visible   = .T.
1455:         ENDWITH
1456: 
1457:         *-- Opt_Impressora - impressora alternativa (OCULTA por padrao no
1458:         *-- legado - Visible = .F. no SCX, e o InteractiveChange dela vem
1459:         *-- COMENTADO no proprio legado - regra CLAUDE.md: transcrever fiel).
1460:         THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
1461:         WITH THIS.obj_4c_Opt_Impressora
1462:             .Top           = 431
1463:             .Left          = 260
1464:             .Width         = 254
1465:             .Height        = 47
1466:             .ButtonCount   = 1
1467:             .BackStyle     = 0
1468:             .SpecialEffect = 1
1469:             .Themes        = .F.
1470:             .Visible       = .F.
1471:             WITH .Buttons(1)
1472:                 .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
1473:                 .Top       = 52
1474:                 .Left      = 9
1475:                 .Width     = 210
1476:                 .Height    = 16
1477:                 .BackStyle = 0
1478:                 .AutoSize  = .F.
1479:                 .FontName  = "Verdana"
1480:                 .FontSize  = 8
1481:                 .ForeColor = RGB(36, 84, 155)
1482:             ENDWITH
1483:         ENDWITH
1484: 
1485:         THIS.AddObject("lbl_4c_Label3", "Label")
1486:         WITH THIS.lbl_4c_Label3
1487:             .Top       = 415
1488:             .Left      = 271
1489:             .Width     = 74
1490:             .Height    = 15
1491:             .BackStyle = 0
1492:             .Alignment = 0
1493:             .FontBold  = .T.
1494:             .FontName  = "Tahoma"
1495:             .FontSize  = 8
1496:             .ForeColor = RGB(90, 90, 90)
1497:             .Caption   = "Impressora"
1498:             .Visible   = .T.
1499:         ENDWITH
1500: 
1501:         *-- opt_separador - imprime separadora de etiquetas
1502:         THIS.AddObject("obj_4c_Opt_separador", "OptionGroup")
1503:         WITH THIS.obj_4c_Opt_separador
1504:             .Top           = 412
1505:             .Left          = 601
1506:             .Width         = 198
1507:             .Height        = 25
1508:             .ButtonCount   = 2
1509:             .BackStyle     = 0
1510:             .SpecialEffect = 1
1511:             .Themes        = .F.
1512:             .Value         = THIS.this_oBusinessObject.this_nSeparador
1513:             .Visible       = .T.
1514:             WITH .Buttons(1)
1515:                 .Caption   = "Sim"
1516:                 .Top       = 5
1517:                 .Left      = 5
1518:                 .Width     = 34
1519:                 .Height    = 15
1520:                 .BackStyle = 0
1521:                 .AutoSize  = .T.
1522:                 .FontName  = "Tahoma"
1523:                 .FontSize  = 8
1524:                 .ForeColor = RGB(90, 90, 90)
1525:             ENDWITH
1526:             WITH .Buttons(2)
1527:                 .Caption   = "N" + CHR(227) + "o"
1528:                 .Top       = 5
1529:                 .Left      = 70
1530:                 .Width     = 37
1531:                 .Height    = 15
1532:                 .BackStyle = 0
1533:                 .AutoSize  = .T.
1534:                 .FontName  = "Tahoma"
1535:                 .FontSize  = 8
1536:                 .ForeColor = RGB(90, 90, 90)
1537:             ENDWITH
1538:         ENDWITH
1539:         BINDEVENT(THIS.obj_4c_Opt_separador, "InteractiveChange", THIS, "OptSeparadorInteractiveChange")
1540: 
1541:         THIS.AddObject("lbl_4c_Lbl_Separador", "Label")
1542:         WITH THIS.lbl_4c_Lbl_Separador
1543:             .Top       = 417
1544:             .Left      = 532
1545:             .Width     = 65
1546:             .Height    = 15
1547:             .BackStyle = 0
1548:             .Alignment = 0
1549:             .FontName  = "Tahoma"
1550:             .FontSize  = 8
1551:             .ForeColor = RGB(90, 90, 90)
1552:             .Caption   = "Separadora :"
1553:             .Visible   = .T.
1554:         ENDWITH
1555: 
1556:         *-- OptOrdem - ordem de impressao
1557:         THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
1558:         WITH THIS.obj_4c_OptOrdem
1559:             .Top           = 589
1560:             .Left          = 601
1561:             .Width         = 198
1562:             .Height        = 25
1563:             .ButtonCount   = 2
1564:             .AutoSize      = .F.
1565:             .BackStyle     = 0
1566:             .SpecialEffect = 1
1567:             .Themes        = .F.
1568:             .Value         = THIS.this_oBusinessObject.this_nOrdem
1569:             .Visible       = .T.
1570:             WITH .Buttons(1)
1571:                 .Caption   = "Produto"
1572:                 .Top       = 4
1573:                 .Left      = 5
1574:                 .Width     = 56
1575:                 .Height    = 15
1576:                 .BackStyle = 0
1577:                 .AutoSize  = .T.
1578:                 .FontName  = "Tahoma"
1579:                 .FontSize  = 8
1580:                 .ForeColor = RGB(90, 90, 90)
1581:             ENDWITH
1582:             WITH .Buttons(2)
1583:                 .Caption   = "Nenhuma"
1584:                 .Top       = 4
1585:                 .Left      = 70
1586:                 .Width     = 63
1587:                 .Height    = 15
1588:                 .BackStyle = 0
1589:                 .AutoSize  = .T.
1590:                 .FontName  = "Tahoma"
1591:                 .FontSize  = 8
1592:                 .ForeColor = RGB(90, 90, 90)
1593:             ENDWITH
1594:         ENDWITH
1595:         BINDEVENT(THIS.obj_4c_OptOrdem, "InteractiveChange", THIS, "OptOrdemInteractiveChange")
1596: 
1597:         THIS.AddObject("lbl_4c_Label11", "Label")
1598:         WITH THIS.lbl_4c_Label11
1599:             .Top       = 594
1600:             .Left      = 556
1601:             .Width     = 41
1602:             .Height    = 15
1603:             .BackStyle = 0
1604:             .Alignment = 0
1605:             .FontName  = "Tahoma"
1606:             .FontSize  = 8
1607:             .ForeColor = RGB(90, 90, 90)
1608:             .Caption   = "Ordem :"
1609:             .Visible   = .T.
1610:         ENDWITH
1611: 
1612:         THIS.AddObject("lbl_4c_Label8", "Label")
1613:         WITH THIS.lbl_4c_Label8
1614:             .Top       = 440
1615:             .Left      = 561
1616:             .Width     = 36
1617:             .Height    = 15
1618:             .BackStyle = 0
1619:             .Alignment = 0
1620:             .FontName  = "Tahoma"
1621:             .FontSize  = 8
1622:             .ForeColor = RGB(90, 90, 90)
1623:             .Caption   = "Pre" + CHR(231) + "o :"
1624:             .Visible   = .T.
1625:         ENDWITH
1626: 
1627:         *-- opt_peso - imprime peso na etiqueta
1628:         THIS.AddObject("obj_4c_Opt_peso", "OptionGroup")
1629:         WITH THIS.obj_4c_Opt_peso
1630:             .Top           = 535
1631:             .Left          = 601
1632:             .Width         = 198
1633:             .Height        = 25
1634:             .ButtonCount   = 2
1635:             .AutoSize      = .F.
1636:             .BackStyle     = 0
1637:             .SpecialEffect = 1
1638:             .Themes        = .F.
1639:             .Value         = THIS.this_oBusinessObject.this_nPeso
1640:             .Visible       = .T.
1641:             WITH .Buttons(1)
1642:                 .Caption   = "Sim"
1643:                 .Top       = 5
1644:                 .Left      = 5
1645:                 .Width     = 41
1646:                 .Height    = 15
1647:                 .BackStyle = 0
1648:                 .AutoSize  = .F.
1649:                 .FontName  = "Tahoma"
1650:                 .FontSize  = 8
1651:                 .ForeColor = RGB(90, 90, 90)
1652:             ENDWITH
1653:             WITH .Buttons(2)
1654:                 .Caption   = "N" + CHR(227) + "o"
1655:                 .Top       = 5
1656:                 .Left      = 70
1657:                 .Width     = 41
1658:                 .Height    = 15
1659:                 .BackStyle = 0
1660:                 .AutoSize  = .F.
1661:                 .FontName  = "Tahoma"
1662:                 .FontSize  = 8
1663:                 .ForeColor = RGB(90, 90, 90)
1664:             ENDWITH
1665:         ENDWITH
1666:         BINDEVENT(THIS.obj_4c_Opt_peso, "InteractiveChange", THIS, "OptPesoInteractiveChange")
1667: 
1668:         THIS.AddObject("lbl_4c_Label9", "Label")
1669:         WITH THIS.lbl_4c_Label9
1670:             .Top       = 540
1671:             .Left      = 565
1672:             .Width     = 32
1673:             .Height    = 15
1674:             .BackStyle = 0
1675:             .Alignment = 0
1676:             .FontName  = "Tahoma"
1677:             .FontSize  = 8
1678:             .ForeColor = RGB(90, 90, 90)
1679:             .Caption   = "Peso :"
1680:             .Visible   = .T.
1681:         ENDWITH
1682: 
1683:         *-- optCompos - imprime composicao na etiqueta
1684:         THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
1685:         WITH THIS.obj_4c_OptCompos
1686:             .Top           = 562
1687:             .Left          = 601
1688:             .Width         = 198
1689:             .Height        = 25
1690:             .ButtonCount   = 2
1691:             .AutoSize      = .F.
1692:             .BackStyle     = 0
1693:             .SpecialEffect = 1
1694:             .Themes        = .F.
1695:             .Value         = THIS.this_oBusinessObject.this_nComposicao
1696:             .Visible       = .T.
1697:             WITH .Buttons(1)
1698:                 .Caption   = "Sim"
1699:                 .Top       = 5
1700:                 .Left      = 5
1701:                 .Width     = 41
1702:                 .Height    = 15
1703:                 .BackStyle = 0
1704:                 .AutoSize  = .F.
1705:                 .FontName  = "Tahoma"
1706:                 .FontSize  = 8
1707:                 .ForeColor = RGB(90, 90, 90)
1708:             ENDWITH
1709:             WITH .Buttons(2)
1710:                 .Caption   = "N" + CHR(227) + "o"
1711:                 .Top       = 5
1712:                 .Left      = 70
1713:                 .Width     = 41
1714:                 .Height    = 15
1715:                 .BackStyle = 0
1716:                 .AutoSize  = .F.
1717:                 .FontName  = "Tahoma"
1718:                 .FontSize  = 8
1719:                 .ForeColor = RGB(90, 90, 90)
1720:             ENDWITH
1721:         ENDWITH
1722:         BINDEVENT(THIS.obj_4c_OptCompos, "InteractiveChange", THIS, "OptComposInteractiveChange")
1723: 
1724:         THIS.AddObject("lbl_4c_Label10", "Label")
1725:         WITH THIS.lbl_4c_Label10
1726:             .Top       = 567
1727:             .Left      = 531
1728:             .Width     = 66
1729:             .Height    = 15
1730:             .BackStyle = 0
1731:             .Alignment = 0
1732:             .FontName  = "Tahoma"
1733:             .FontSize  = 8
1734:             .ForeColor = RGB(90, 90, 90)
1735:             .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
1736:             .Visible   = .T.
1737:         ENDWITH
1738: 
1739:         *-- Get_Printer - impressora Windows destino (RowSource = crImpreV)
1740:         THIS.AddObject("cbo_4c_Get_Printer", "ComboBox")
1741:         WITH THIS.cbo_4c_Get_Printer
1742:             .Top            = 453
1743:             .Left           = 268
1744:             .Width          = 239
1745:             .Height         = 23
1746:             .Style          = 2
1747:             .SpecialEffect  = 1
1748:             .BoundColumn    = 1
1749:             .RowSourceType  = 2
1750:             .RowSource      = "crImpreV"
1751:             .FontName       = "Tahoma"
1752:             .FontSize       = 8
1753:             .Visible        = .T.
1754:         ENDWITH
1755:         IF RECCOUNT("crImpreV") > 0
1756:             THIS.cbo_4c_Get_Printer.ListIndex = 1
1757:             THIS.this_oBusinessObject.this_cImpressora = ALLTRIM(crImpreV.Impres)
1758:         ENDIF
1759:         BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", THIS, "GetPrinterInteractiveChange")
1760: 
1761:         THIS.AddObject("lbl_4c_Label12", "Label")
1762:         WITH THIS.lbl_4c_Label12
1763:             .Top       = 437
1764:             .Left      = 270
1765:             .Width     = 48
1766:             .Height    = 15
1767:             .BackStyle = 0
1768:             .Alignment = 0
1769:             .FontBold  = .T.
1770:             .FontName  = "Tahoma"
1771:             .FontSize  = 8
1772:             .ForeColor = RGB(90, 90, 90)
1773:             .Caption   = "Sistema"
1774:             .Visible   = .T.
1775:         ENDWITH
1776: 
1777:         THIS.AddObject("lbl_4c_Label13", "Label")
1778:         WITH THIS.lbl_4c_Label13
1779:             .Top       = 437
1780:             .Left      = 383
1781:             .Width     = 52
1782:             .Height    = 15
1783:             .BackStyle = 0
1784:             .Alignment = 0
1785:             .FontBold  = .T.
1786:             .FontName  = "Tahoma"
1787:             .FontSize  = 8
1788:             .ForeColor = RGB(90, 90, 90)
1789:             .Caption   = "Windows"
1790:             .Visible   = .T.
1791:         ENDWITH
1792: 
1793:         *-- opt_Preco - modalidade de preco impresso na etiqueta
1794:         THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
1795:         WITH THIS.obj_4c_Opt_Preco
1796:             .Top           = 439
1797:             .Left          = 601
1798:             .Width         = 198
1799:             .Height        = 95
1800:             .ButtonCount   = 6
1801:             .AutoSize      = .F.
1802:             .BackStyle     = 0
1803:             .SpecialEffect = 1
1804:             .Themes        = .F.
1805:             .Value         = THIS.this_oBusinessObject.this_nPreco
1806:             .Visible       = .T.
1807:             WITH .Buttons(1)
1808:                 .Caption   = "Sim"
1809:                 .Top       = 7
1810:                 .Left      = 8
1811:                 .Width     = 34
1812:                 .Height    = 15
1813:                 .BackStyle = 0
1814:                 .AutoSize  = .T.
1815:                 .FontName  = "Tahoma"
1816:                 .FontSize  = 8
1817:                 .ForeColor = RGB(90, 90, 90)
1818:             ENDWITH
1819:             WITH .Buttons(2)
1820:                 .Caption   = "N" + CHR(227) + "o"
1821:                 .Top       = 7
1822:                 .Left      = 61
1823:                 .Width     = 37
1824:                 .Height    = 15
1825:                 .BackStyle = 0
1826:                 .AutoSize  = .T.
1827:                 .FontName  = "Tahoma"
1828:                 .FontSize  = 8
1829:                 .ForeColor = RGB(90, 90, 90)
1830:             ENDWITH
1831:             WITH .Buttons(3)
1832:                 .Caption   = "Ideal"
1833:                 .Top       = 28
1834:                 .Left      = 8

*-- Linhas 1877 a 1932:
1877:                 .ForeColor = RGB(90, 90, 90)
1878:             ENDWITH
1879:         ENDWITH
1880:         BINDEVENT(THIS.obj_4c_Opt_Preco, "InteractiveChange", THIS, "OptPrecoInteractiveChange")
1881:     ENDPROC
1882: 
1883:     *==========================================================================
1884:     * PopularOpcoesTipoEtiqueta - Popula dinamicamente o obj_4c_Opt_Tipo a
1885:     * partir de SigCdTpe (tipos de etiqueta ativos), transcricao literal do
1886:     * bloco "With .Opt_Tipo" do Init legado (regra CLAUDE.md #17 - fluxo de
1887:     * negocio se transcreve, nao se reescreve). Sem tipos ativos, mantem o
1888:     * fallback estatico "Rabicho" ja criado por ConfigurarCamposImpressao().
1889:     * Precisa rodar ANTES de qualquer impressao: eh o .Tag de cada Buttons(N)
1890:     * que BtnProcessarImpressaoClick le para resolver o tipo de etiqueta (nTipos).
1891:     *==========================================================================
1892:     PROTECTED PROCEDURE PopularOpcoesTipoEtiqueta()
1893:         LOCAL loc_cAliasPam, loc_cAliasTipos, loc_nMaxPadrao, loc_nTotal, ;
1894:               loc_nI, loc_nTipoPadrao, loc_nHeight, loc_nTop
1895: 
1896:         loc_cAliasPam = "cursor_4c_Pam"
1897:         IF !USED(loc_cAliasPam)
1898:             THIS.this_oBusinessObject.CarregarParametrosEtiqueta(loc_cAliasPam)
1899:         ENDIF
1900: 
1901:         loc_nMaxPadrao = 7
1902:         IF USED(loc_cAliasPam)
1903:             SELECT (loc_cAliasPam)
1904:             GO TOP
1905:             loc_nMaxPadrao = MAX(TratarNulo(nMaxTpEtis, 0), 7)
1906:         ENDIF
1907: 
1908:         loc_cAliasTipos = "cursor_4c_TiposEtiqueta"
1909:         IF !THIS.this_oBusinessObject.BuscarTiposEtiquetaAtivos(loc_cAliasTipos)
1910:             THIS.this_nTotalTipos = 0
1911:             RETURN
1912:         ENDIF
1913: 
1914:         SELECT (loc_cAliasTipos)
1915:         loc_nTotal = RECCOUNT()
1916: 
1917:         *-- Legado: lnTipos alimenta o Enabled do botao Imprimir
1918:         *-- (.Imprime.Enabled = (lnTipos <> 0 And lnImp <> 0)) e o Enabled do
1919:         *-- proprio Opt_Tipo (.Enabled = (lnTipos > 1)) - ver HabilitarCampos.
1920:         THIS.this_nTotalTipos = loc_nTotal
1921: 
1922:         IF loc_nTotal = 0
1923:             USE IN (loc_cAliasTipos)
1924:             RETURN
1925:         ENDIF
1926: 
1927:         WITH THIS.obj_4c_Opt_Tipo
1928:             loc_nTipoPadrao = 1
1929:             .ButtonCount    = MIN(loc_nTotal, loc_nMaxPadrao)
1930:             loc_nHeight     = 15
1931:             loc_nTop        = 10
1932: 

*-- Linhas 1973 a 2016:
1973:     * selecionadas) e Sair (encerra o form). Transcricao literal das
1974:     * propriedades do SCX (Top/Left/Width/Height/Picture/Caption).
1975:     *==========================================================================
1976:     PROTECTED PROCEDURE ConfigurarBotaoRelatorio()
1977:         THIS.AddObject("obj_4c_BTNREPORT", "CommandGroup")
1978:         WITH THIS.obj_4c_BTNREPORT
1979:             .Top           = -2
1980:             .Left          = 676
1981:             .Width         = 161
1982:             .Height        = 85
1983:             .ButtonCount   = 2
1984:             .BackStyle     = 0
1985:             .SpecialEffect = 1
1986:             .Themes        = .F.
1987:             .Value         = 1
1988:             .Visible       = .T.
1989: 
1990:             WITH .Buttons(1)
1991:                 .Top             = 5
1992:                 .Left            = 5
1993:                 .Width           = 75
1994:                 .Height          = 75
1995:                 .FontBold        = .T.
1996:                 .FontItalic      = .T.
1997:                 .FontName        = "Comic Sans MS"
1998:                 .FontSize        = 8
1999:                 .WordWrap        = .T.
2000:                 .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2001:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2002:                 .Caption         = "\<Imprimir"
2003:                 .ForeColor       = RGB(90, 90, 90)
2004:                 .BackColor       = RGB(255, 255, 255)
2005:                 .Themes          = .F.
2006:             ENDWITH
2007: 
2008:             WITH .Buttons(2)
2009:                 .Top             = 5
2010:                 .Left            = 81
2011:                 .Width           = 75
2012:                 .Height          = 75
2013:                 .FontBold        = .T.
2014:                 .FontItalic      = .T.
2015:                 .FontName        = "Comic Sans MS"
2016:                 .FontSize        = 8

*-- Linhas 2023 a 2135:
2023:                 .Themes          = .F.
2024:             ENDWITH
2025:         ENDWITH
2026:         BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(1), "Click", THIS, "BtnProcessarImpressaoClick")
2027:         BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(2), "Click", THIS, "BtnSairClick")
2028:     ENDPROC
2029: 
2030:     *==========================================================================
2031:     * Handlers de sincronizacao BO <-> OptionGroup/Spinner/ComboBox das
2032:     * opcoes de impressao. PUBLIC: bindados via BINDEVENT (regra CLAUDE.md #3).
2033:     *==========================================================================
2034:     PROCEDURE OptTipoInteractiveChange()
2035:         THIS.this_oBusinessObject.this_nTipoEtiqueta = THIS.obj_4c_Opt_Tipo.Value
2036:     ENDPROC
2037: 
2038:     PROCEDURE OpcaoImpInteractiveChange()
2039:         THIS.this_oBusinessObject.this_nOpcaoImp = THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value
2040:     ENDPROC
2041: 
2042:     PROCEDURE SpnAjVertsInteractiveChange()
2043:         THIS.this_oBusinessObject.this_nAjVerts = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value
2044:     ENDPROC
2045: 
2046:     PROCEDURE SpnAjHorzsInteractiveChange()
2047:         THIS.this_oBusinessObject.this_nAjHorzs = THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value
2048:     ENDPROC
2049: 
2050:     PROCEDURE SpnAjDenssInteractiveChange()
2051:         THIS.this_oBusinessObject.this_nAjDenss = THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value
2052:     ENDPROC
2053: 
2054:     PROCEDURE SpnAjVelosInteractiveChange()
2055:         THIS.this_oBusinessObject.this_nAjVelos = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value
2056:     ENDPROC
2057: 
2058:     PROCEDURE OptSeparadorInteractiveChange()
2059:         THIS.this_oBusinessObject.this_nSeparador = THIS.obj_4c_Opt_separador.Value
2060:     ENDPROC
2061: 
2062:     PROCEDURE OptOrdemInteractiveChange()
2063:         THIS.this_oBusinessObject.this_nOrdem = THIS.obj_4c_OptOrdem.Value
2064:     ENDPROC
2065: 
2066:     PROCEDURE OptPesoInteractiveChange()
2067:         THIS.this_oBusinessObject.this_nPeso = THIS.obj_4c_Opt_peso.Value
2068:     ENDPROC
2069: 
2070:     PROCEDURE OptComposInteractiveChange()
2071:         THIS.this_oBusinessObject.this_nComposicao = THIS.obj_4c_OptCompos.Value
2072:     ENDPROC
2073: 
2074:     PROCEDURE OptPrecoInteractiveChange()
2075:         THIS.this_oBusinessObject.this_nPreco = THIS.obj_4c_Opt_Preco.Value
2076:     ENDPROC
2077: 
2078:     PROCEDURE GetPrinterInteractiveChange()
2079:         *-- Legado (Get_Printer.InteractiveChange): le a COLUNA do cursor de
2080:         *-- RowSource, nunca o texto exibido - a coluna 1 de crImpreV eh o par
2081:         *-- "sistema + windows" (IDupla), que nao eh nome de impressora.
2082:         THIS.this_oBusinessObject.this_cImpressora = THIS.ObterImpressoraSelecionada()
2083:     ENDPROC
2084: 
2085:     *==========================================================================
2086:     * TornarControlesVisiveis - Torna visiveis os controles de topo do form.
2087:     * Os filhos de cnt_4c_Sombra ja nascem Visible = .T. no proprio AddObject
2088:     * (ver ConfigurarPageFrame); este metodo cobre os demais controles de
2089:     * topo criados nas proximas fases direto sobre THIS.
2090:     * EXCECAO: obj_4c_Opt_Impressora fica de fora do loop - o legado
2091:     * declara Visible = .F. no SCX (impressora alternativa nao usada por
2092:     * default, InteractiveChange dela vem COMENTADO no proprio legado) e
2093:     * nao ha nenhum ponto do form que a torne visivel depois.
2094:     *==========================================================================
2095:     PROTECTED PROCEDURE TornarControlesVisiveis()
2096:         LOCAL loc_oCtrl
2097:         FOR EACH loc_oCtrl IN THIS.Controls
2098:             IF VARTYPE(loc_oCtrl) = "O"
2099:                 IF UPPER(loc_oCtrl.Name) == "OBJ_4C_OPT_IMPRESSORA"
2100:                     LOOP
2101:                 ENDIF
2102:                 loc_oCtrl.Visible = .T.
2103:             ENDIF
2104:         ENDFOR
2105:     ENDPROC
2106: 
2107:     *==========================================================================
2108:     * CarregarDados - Popula a grade de etiquetas com os itens de uma LISTA DE
2109:     * PRECOS (SigCdLpi). Transcricao do bloco de CARGA do Get_lpreco.Valid
2110:     * legado (a parte do picker de selecao da lista fica no handler de lookup
2111:     * da Fase 6, que chama este metodo passando o valor escolhido):
2112:     *   - confirma antes de refazer a selecao quando a grade ja tem etiqueta;
2113:     *   - ZAPa a grade e varre os itens da lista;
2114:     *   - para item com vigencia VENCIDA, troca preco/preco-de pelo preco
2115:     *     corrente do produto (SigCdPro).
2116:     * Regra CLAUDE.md #17: criterio/fluxo de negocio se TRANSCREVE, nao se
2117:     * reescreve.
2118:     * par_cListaPreco: lista a carregar. Ausente/vazio -> le o TextBox da tela
2119:     * (como o legado faz com This.Value) e, na falta dele, a property do BO.
2120:     * PUBLIC: chamado pelo handler de lookup do campo Lista de Precos e de fora
2121:     * da classe pelo harness de teste (regra CLAUDE.md #3).
2122:     *==========================================================================
2123:     FUNCTION CarregarDados(par_cListaPreco)
2124:         LOCAL loc_cCursor, loc_cLista, loc_cAliasItens, loc_cAliasProd, ;
2125:               loc_lRefazer, loc_nQtdSelecionadas, loc_lCarregaLista, ;
2126:               loc_nVal, loc_nValDe, loc_cCodProd, loc_cDescProd, ;
2127:               loc_cListaItem, loc_dVencIni, loc_dVencFim, ;
2128:               loc_lSucesso, loc_oErro
2129: 
2130:         loc_lSucesso = .F.
2131: 
2132:         TRY
2133:             loc_cCursor     = THIS.this_oBusinessObject.this_cCursorDados
2134:             loc_cAliasItens = "cursor_4c_ItensListaCarga"
2135:             loc_cAliasProd  = "cursor_4c_ProdutoVencidoCarga"

*-- Linhas 2239 a 2328:
2239:             THIS.this_cMensagemErro = loc_oErro.Message
2240:             MsgErro(loc_oErro.Message + CHR(13) + ;
2241:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2242:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar Etiquetas")
2243:         ENDTRY
2244: 
2245:         RETURN loc_lSucesso
2246:     ENDFUNC
2247: 
2248:     *==========================================================================
2249:     * BtnCarregarClick - Carrega para a grade de etiquetas os itens da
2250:     * movimentacao informada (Empresa+Operacao+Codigo -> chave posicional
2251:     * EmpDopNums), aplicando a lista de precos quando configurado.
2252:     * Transcricao literal do btnCarregar.Click do legado (regra CLAUDE.md
2253:     * #17 - formula/fluxo de negocio nunca se reescreve).
2254:     * PUBLIC: chamado via BINDEVENT (regra CLAUDE.md #3).
2255:     *==========================================================================
2256:     PROCEDURE BtnCarregarClick()
2257:         LOCAL loc_cCursor, loc_cEmpDopNums, loc_cAliasItens, loc_lRefazer, ;
2258:               loc_nQtdSelecionadas, loc_cCodItem, loc_cDescItem, loc_nQtdItem, ;
2259:               loc_nCitemItem, loc_nVenda, loc_nPrecoDeVal, loc_nPeso, ;
2260:               loc_cCodScan, loc_nValLista, loc_nValDeLista
2261: 
2262:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2263: 
2264:         IF EMPTY(THIS.txt_4c_Emps.Value)
2265:             MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!!!", "Dados Incompletos")
2266:             THIS.txt_4c_Emps.SetFocus()
2267:             RETURN
2268:         ENDIF
2269: 
2270:         IF EMPTY(THIS.txt_4c_Dopes.Value)
2271:             MsgAviso("A Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Foi Informada!!!", "Dados Incompletos")
2272:             THIS.txt_4c_Dopes.SetFocus()
2273:             RETURN
2274:         ENDIF
2275: 
2276:         IF EMPTY(THIS.txt_4c_Numes.Value)
2277:             MsgAviso("O C" + CHR(243) + "digo N" + CHR(227) + "o Foi Informado!!!", "Dados Incompletos")
2278:             THIS.txt_4c_Numes.SetFocus()
2279:             RETURN
2280:         ENDIF
2281: 
2282:         loc_cEmpDopNums = PADR(ALLTRIM(THIS.txt_4c_Emps.Value), 3) + ;
2283:                            PADR(ALLTRIM(THIS.txt_4c_Dopes.Value), 20) + ;
2284:                            STR(THIS.txt_4c_Numes.Value, 6)
2285: 
2286:         loc_cAliasItens = "cursor_4c_ItensMovimentoCarga"
2287:         IF !THIS.this_oBusinessObject.BuscarItensMovimento(loc_cEmpDopNums, loc_cAliasItens)
2288:             MsgAviso("A Opera" + CHR(231) + CHR(227) + "o Informada N" + CHR(227) + "o Possui Itens a Serem Carregados!!!", "Dados Incorretos")
2289:             THIS.txt_4c_Emps.SetFocus()
2290:             RETURN
2291:         ENDIF
2292: 
2293:         loc_lRefazer = .T.
2294:         IF USED(loc_cCursor)
2295:             SELECT (loc_cCursor)
2296:             COUNT TO loc_nQtdSelecionadas FOR !EMPTY(Cpros)
2297:             IF loc_nQtdSelecionadas > 0
2298:                 loc_lRefazer = MsgConfirma("Existem Etiquetas na Grade! Deseja Refazer a Sele" + CHR(231) + CHR(227) + "o?", "Aten" + CHR(231) + CHR(227) + "o!!!")
2299:             ENDIF
2300:         ENDIF
2301: 
2302:         IF loc_lRefazer
2303:             IF USED(loc_cCursor)
2304:                 SELECT (loc_cCursor)
2305:                 ZAP
2306:             ENDIF
2307: 
2308:             IF THIS.chk_4c_ChkOperacoes.Value = 1 AND USED(loc_cAliasItens)
2309:                 SELECT (loc_cAliasItens)
2310:                 SCAN
2311:                     loc_cCodItem    = TratarNulo(CPros, "")
2312:                     loc_cDescItem   = TratarNulo(DPros, "")
2313:                     loc_nQtdItem    = TratarNulo(Qtds, 0)
2314:                     loc_nCitemItem  = TratarNulo(Citens, 0)
2315: 
2316:                     loc_nVenda      = 0
2317:                     loc_nPrecoDeVal = 0
2318:                     loc_nPeso       = 0
2319: 
2320:                     IF !EMPTY(loc_cCodItem) AND THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cCodItem), "cursor_4c_ProdutoCarga")
2321:                         SELECT cursor_4c_ProdutoCarga
2322:                         IF NVL(PVens, 0) > 0
2323:                             loc_nVenda = PVens
2324:                         ENDIF
2325:                         IF NVL(PrecoDe, 0) > 0
2326:                             loc_nPrecoDeVal = PrecoDe
2327:                         ENDIF
2328:                         IF NVL(PesoMs, 0) > 0

*-- Linhas 2385 a 2456:
2385:     *==========================================================================
2386:     * BtnExcluirItemClick - Remove o item corrente da grade de etiquetas.
2387:     * Transcricao literal do btnexcluir.Click do legado.
2388:     * PUBLIC: chamado via BINDEVENT (regra CLAUDE.md #3).
2389:     *==========================================================================
2390:     PROCEDURE BtnExcluirItemClick()
2391:         LOCAL loc_cCursor
2392:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2393: 
2394:         IF USED(loc_cCursor)
2395:             SELECT (loc_cCursor)
2396:             DELETE
2397:             *-- Legado: Locate For .f. tira o ponteiro da linha excluida sem
2398:             *-- depender de SET DELETED.
2399:             LOCATE FOR .F.
2400: 
2401:             *-- Linha em branco obrigatoria + Go Top + Refresh (CLAUDE.md #21a)
2402:             THIS.CarregarLista()
2403:         ENDIF
2404:     ENDPROC
2405: 
2406:     *==========================================================================
2407:     * BtnProcessarImpressaoClick - Botao principal do form (BTNREPORT.Imprime no legado):
2408:     * confirma, remove itens sem quantidade apurada, reordena a grade (por
2409:     * Codigo ou por ordem de digitacao) e dispara a impressao fisica das
2410:     * etiquetas. Transcricao literal do fluxo do legado (regra CLAUDE.md #17)
2411:     * - inclusive o SINAL/ordem das validacoes e o criterio de reordenacao
2412:     * via cursor auxiliar (Scatter/Insert), que o legado usa para fisicamente
2413:     * fixar a sequencia de impressao antes de varrer a grade.
2414:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
2415:     *==========================================================================
2416:     PROCEDURE BtnProcessarImpressaoClick()
2417:         LOCAL loc_cCursor, loc_nImpPreco, loc_lImpSepar, loc_lImpPeso, loc_lCompo, ;
2418:               loc_nTipoSel, loc_nTpEti, loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, ;
2419:               loc_nAjDenss, loc_nAjVelos, loc_cNomeImpressora, loc_cLp1, loc_cLp2, ;
2420:               loc_cBop, loc_cAliasOpe, loc_cAliasOrdenado
2421: 
2422:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2423:         IF !USED(loc_cCursor)
2424:             RETURN
2425:         ENDIF
2426: 
2427:         *-- Recolhe a tela inteira para o BO de uma vez so (equivale ao bloco
2428:         *-- de leitura de controles que abre o BTNREPORT.Click legado) e le
2429:         *-- dali - assim a impressao e a auditoria enxergam exatamente os
2430:         *-- mesmos valores.
2431:         IF !THIS.FormParaBO()
2432:             RETURN
2433:         ENDIF
2434: 
2435:         loc_nImpPreco = THIS.this_oBusinessObject.this_nPreco
2436:         loc_lImpSepar = (THIS.this_oBusinessObject.this_nSeparador = 1)
2437:         loc_lImpPeso  = (THIS.this_oBusinessObject.this_nPeso = 1)
2438:         loc_lCompo    = (THIS.this_oBusinessObject.this_nComposicao = 1)
2439: 
2440:         *-- O TIPO de etiqueta que vai para a impressora nao eh o indice do
2441:         *-- botao: eh o codigo em .Tag (SigCdTpe.nTipos) do botao selecionado.
2442:         loc_nTipoSel = THIS.this_oBusinessObject.this_nTipoEtiqueta
2443:         loc_nTpEti   = INT(VAL(TratarNulo(THIS.obj_4c_Opt_Tipo.Buttons(loc_nTipoSel).Tag, "0")))
2444: 
2445:         loc_nTpImp   = THIS.this_oBusinessObject.this_nOpcaoImp
2446:         loc_nAjVerts = THIS.this_oBusinessObject.this_nAjVerts
2447:         loc_nAjHorzs = THIS.this_oBusinessObject.this_nAjHorzs
2448:         loc_nAjDenss = THIS.this_oBusinessObject.this_nAjDenss
2449:         loc_nAjVelos = THIS.this_oBusinessObject.this_nAjVelos
2450: 
2451:         *-- Legado: nome da impressora vem da linha corrente de crImpreV
2452:         *-- (crImpreV.impres), nao do texto exibido no ComboBox.
2453:         loc_cNomeImpressora = THIS.this_oBusinessObject.this_cImpressora
2454: 
2455:         loc_cLp1 = THIS.this_oBusinessObject.this_cLPreco
2456:         loc_cLp2 = THIS.this_oBusinessObject.this_cLPreco2

*-- Linhas 2543 a 2745:
2543: 
2544:     *==========================================================================
2545:     * BtnSairClick - Encerra o form (BTNREPORT.Sair no legado: ThisForm.
2546:     * Release). PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
2547:     *==========================================================================
2548:     PROCEDURE BtnSairClick()
2549:         THIS.Release()
2550:     ENDPROC
2551: 
2552:     *==========================================================================
2553:     * CarregarParametrosPadrao - Le SigCdPam (parametros gerais de etiqueta) e
2554:     * SigCdPac (ajustes de impressao) e guarda os valores nas properties do BO.
2555:     * Transcricao do bloco "With Thisform.Cnt_Impressora" do Init legado, que
2556:     * alimenta os spinners/opcoes a partir desses dois cursores:
2557:     *   Opcao_Imp.Value = Iif(crSigCdPam.ImpEtis <> 0, crSigCdPam.ImpEtis, 1)
2558:     *   Spn_AjVerts     = crSigCdPam.AjVerts
2559:     *   Spn_AjHorzs     = crSigCdPam.AjHorzs
2560:     *   spn_AjDenss     = Iif(Empty(crSigCdPac.AjDens),  20, crSigCdPac.AjDens)
2561:     *   spn_AjVelos     = Iif(Empty(crSigCdPac.AjVelos), 01, crSigCdPac.AjVelos)
2562:     *   opt_separador   = crSigCdPac.EtqSeps
2563:     * Sem banco disponivel (modo de teste/validacao de UI) as properties ficam
2564:     * com o default declarado no BO - a tela abre igual, so sem os parametros.
2565:     *==========================================================================
2566:     PROTECTED PROCEDURE CarregarParametrosPadrao()
2567:         LOCAL loc_oBO, loc_cAliasPam, loc_cAliasPac, loc_nImpEtis, loc_nSep, loc_oErro
2568: 
2569:         loc_oBO       = THIS.this_oBusinessObject
2570:         loc_cAliasPam = "cursor_4c_Pam"
2571:         loc_cAliasPac = "cursor_4c_Pac"
2572: 
2573:         TRY
2574:             IF !USED(loc_cAliasPam)
2575:                 loc_oBO.CarregarParametrosEtiqueta(loc_cAliasPam)
2576:             ENDIF
2577: 
2578:             IF USED(loc_cAliasPam) AND RECCOUNT(loc_cAliasPam) > 0
2579:                 SELECT (loc_cAliasPam)
2580:                 GO TOP
2581: 
2582:                 *-- Legado: Iif(crSigCdPam.ImpEtis <> 0, crSigCdPam.ImpEtis, 1)
2583:                 loc_nImpEtis = TratarNulo(ImpEtis, 0)
2584:                 loc_oBO.this_nOpcaoImp = IIF(loc_nImpEtis <> 0, loc_nImpEtis, 1)
2585: 
2586:                 loc_oBO.this_nAjVerts = TratarNulo(AjVerts, 0)
2587:                 loc_oBO.this_nAjHorzs = TratarNulo(AjHorzs, 0)
2588:             ENDIF
2589: 
2590:             IF !USED(loc_cAliasPac)
2591:                 loc_oBO.CarregarParametrosImpressao(loc_cAliasPac)
2592:             ENDIF
2593: 
2594:             IF USED(loc_cAliasPac) AND RECCOUNT(loc_cAliasPac) > 0
2595:                 SELECT (loc_cAliasPac)
2596:                 GO TOP
2597: 
2598:                 *-- Legado: Iif(Empty(<col>), <default>, <col>)
2599:                 loc_oBO.this_nAjDenss = IIF(EMPTY(TratarNulo(AjDens, 0)), 20, TratarNulo(AjDens, 0))
2600:                 loc_oBO.this_nAjVelos = IIF(EMPTY(TratarNulo(AjVelos, 0)), 1, TratarNulo(AjVelos, 0))
2601: 
2602:                 *-- opt_separador tem 2 botoes: valor fora da faixa derruba o
2603:                 *-- OptionGroup, entao so aplica o parametro quando ele eh um
2604:                 *-- indice valido (o legado atribui cru porque o SCX dele nasce
2605:                 *-- com a mesma quantidade de botoes).
2606:                 loc_nSep = TratarNulo(EtqSeps, 0)
2607:                 IF BETWEEN(loc_nSep, 1, THIS.obj_4c_Opt_separador.ButtonCount)
2608:                     loc_oBO.this_nSeparador = loc_nSep
2609:                 ENDIF
2610:             ENDIF
2611: 
2612:         CATCH TO loc_oErro
2613:             THIS.this_cMensagemErro = loc_oErro.Message
2614:             MsgErro(loc_oErro.Message + CHR(13) + ;
2615:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2616:                     "Procedure: " + loc_oErro.Procedure, ;
2617:                     "Erro ao Carregar Par" + CHR(226) + "metros de Etiqueta")
2618:         ENDTRY
2619:     ENDPROC
2620: 
2621:     *==========================================================================
2622:     * BOParaForm - Espelha as properties do BO nos controles da tela. Alem do
2623:     * espelhamento, dispara CarregarParametrosPadrao() para que os defaults de
2624:     * SigCdPam/SigCdPac cheguem aos controles ANTES de o usuario ver a tela -
2625:     * eh esse bloco do Init legado que define ajuste vertical/horizontal,
2626:     * densidade, velocidade, impressora especial e separadora.
2627:     * PROTECTED: FormBase declara o hook como PROTECTED e VFP9 nao permite a
2628:     * subclasse ALARGAR o escopo - omitir o modificador nao tornaria publico.
2629:     *==========================================================================
2630:     PROTECTED PROCEDURE BOParaForm()
2631:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
2632: 
2633:         loc_lSucesso = .F.
2634:         loc_oBO      = THIS.this_oBusinessObject
2635: 
2636:         TRY
2637:             THIS.CarregarParametrosPadrao()
2638: 
2639:             *-- Bloco Lista de Precos
2640:             THIS.txt_4c_Lpreco.Value       = loc_oBO.this_cLPreco
2641:             THIS.txt_4c_LPreco2.Value      = loc_oBO.this_cLPreco2
2642:             THIS.chk_4c_ChkLista.Value     = IIF(loc_oBO.this_lCarregaItensLista, 1, 0)
2643:             THIS.chk_4c_ChkOperacoes.Value = IIF(loc_oBO.this_lCarregaItensOperacao, 1, 0)
2644: 
2645:             *-- Bloco Movimentacao. txt_4c_Numes eh NUMERICO (o legado o usa em
2646:             *-- Str(...,6) para montar a chave EmpDopNums), entao a property
2647:             *-- character do BO volta pelo VAL - nunca por atribuicao direta.
2648:             THIS.txt_4c_Emps.Value  = loc_oBO.this_cEmps
2649:             THIS.txt_4c_Dopes.Value = loc_oBO.this_cDopes
2650:             THIS.txt_4c_Numes.Value = VAL(loc_oBO.this_cNumes)
2651: 
2652:             *-- Opcoes de impressao (OptionGroup.Value eh SEMPRE o INDICE do
2653:             *-- botao: valor fora de 1..ButtonCount derruba o controle).
2654:             THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_Tipo,        loc_oBO.this_nTipoEtiqueta)
2655:             THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_Impressora,  loc_oBO.this_nTipoImpressora)
2656:             THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_separador,   loc_oBO.this_nSeparador)
2657:             THIS.AplicarValorOptionGroup(THIS.obj_4c_OptOrdem,        loc_oBO.this_nOrdem)
2658:             THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_peso,        loc_oBO.this_nPeso)
2659:             THIS.AplicarValorOptionGroup(THIS.obj_4c_OptCompos,       loc_oBO.this_nComposicao)
2660:             THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_Preco,       loc_oBO.this_nPreco)
2661:             THIS.AplicarValorOptionGroup(THIS.cnt_4c__Impressora.obj_4c_Opcao_imp, loc_oBO.this_nOpcaoImp)
2662: 
2663:             *-- Ajustes finos da impressora de etiqueta
2664:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value = loc_oBO.this_nAjVerts
2665:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value = loc_oBO.this_nAjHorzs
2666:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value = loc_oBO.this_nAjDenss
2667:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value = loc_oBO.this_nAjVelos
2668: 
2669:             loc_lSucesso = .T.
2670: 
2671:         CATCH TO loc_oErro
2672:             THIS.this_cMensagemErro = loc_oErro.Message
2673:             MsgErro(loc_oErro.Message + CHR(13) + ;
2674:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2675:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Exibir Par" + CHR(226) + "metros")
2676:         ENDTRY
2677: 
2678:         RETURN loc_lSucesso
2679:     ENDPROC
2680: 
2681:     *==========================================================================
2682:     * AplicarValorOptionGroup - Atribui o indice a um OptionGroup so quando ele
2683:     * cabe em 1..ButtonCount. OptionGroup.Value eh SEMPRE numerico e indice de
2684:     * botao; valor fora da faixa (tipico de parametro do banco gravado com 0 ou
2685:     * com mais opcoes do que a tela tem) estoura em runtime.
2686:     *==========================================================================
2687:     PROTECTED PROCEDURE AplicarValorOptionGroup(par_oGrupo, par_nValor)
2688:         IF VARTYPE(par_oGrupo) != "O" OR VARTYPE(par_nValor) != "N"
2689:             RETURN
2690:         ENDIF
2691: 
2692:         IF BETWEEN(par_nValor, 1, par_oGrupo.ButtonCount)
2693:             par_oGrupo.Value = par_nValor
2694:         ENDIF
2695:     ENDPROC
2696: 
2697:     *==========================================================================
2698:     * FormParaBO - Recolhe os valores da tela para as properties do BO. Espelha
2699:     * exatamente o bloco de leitura de controles do BTNREPORT.Click legado
2700:     * (Opt_Preco/Opt_Separador/Opt_Peso/optCompos/Opt_Tipo/Cnt_Impressora/
2701:     * get_Printer/get_lpreco/getLPreco2), acrescido dos campos de movimentacao
2702:     * e da chave posicional EmpDopNums.
2703:     * PROTECTED pelo mesmo motivo de BOParaForm (hook declarado em FormBase).
2704:     *==========================================================================
2705:     PROTECTED PROCEDURE FormParaBO()
2706:         LOCAL loc_oBO, loc_lSucesso, loc_oErro, loc_nTipoSel
2707: 
2708:         loc_lSucesso = .F.
2709:         loc_oBO      = THIS.this_oBusinessObject
2710: 
2711:         TRY
2712:             *-- Listas de preco e flags de carga
2713:             loc_oBO.this_cLPreco  = ALLTRIM(THIS.txt_4c_Lpreco.Value)
2714:             loc_oBO.this_cLPreco2 = ALLTRIM(THIS.txt_4c_LPreco2.Value)
2715:             loc_oBO.this_lCarregaItensLista    = (THIS.chk_4c_ChkLista.Value = 1)
2716:             loc_oBO.this_lCarregaItensOperacao = (THIS.chk_4c_ChkOperacoes.Value = 1)
2717: 
2718:             *-- Movimentacao. TRANSFORM porque txt_4c_Numes eh numerico e
2719:             *-- ALLTRIM sobre numerico dispara erro 11 em runtime.
2720:             loc_oBO.this_cEmps  = ALLTRIM(THIS.txt_4c_Emps.Value)
2721:             loc_oBO.this_cDopes = ALLTRIM(THIS.txt_4c_Dopes.Value)
2722:             loc_oBO.this_cNumes = ALLTRIM(TRANSFORM(THIS.txt_4c_Numes.Value))
2723: 
2724:             *-- Chave POSICIONAL Emps(3) + Dopes(20) + Str(Numes,6) = char(29).
2725:             *-- PADR explicito: ALLTRIM nas PARTES encurta a chave e a consulta
2726:             *-- devolve zero linha em silencio (regra CLAUDE.md #42).
2727:             IF EMPTY(loc_oBO.this_cEmps) AND EMPTY(loc_oBO.this_cDopes)
2728:                 loc_oBO.this_cEmpDopNums = ""
2729:             ELSE
2730:                 loc_oBO.this_cEmpDopNums = PADR(loc_oBO.this_cEmps, 3) + ;
2731:                                            PADR(loc_oBO.this_cDopes, 20) + ;
2732:                                            STR(THIS.txt_4c_Numes.Value, 6)
2733:             ENDIF
2734: 
2735:             *-- Opcoes de impressao (indice do botao selecionado)
2736:             loc_oBO.this_nPreco          = THIS.obj_4c_Opt_Preco.Value
2737:             loc_oBO.this_nSeparador      = THIS.obj_4c_Opt_separador.Value
2738:             loc_oBO.this_nPeso           = THIS.obj_4c_Opt_peso.Value
2739:             loc_oBO.this_nComposicao     = THIS.obj_4c_OptCompos.Value
2740:             loc_oBO.this_nOrdem          = THIS.obj_4c_OptOrdem.Value
2741:             loc_oBO.this_nTipoEtiqueta   = THIS.obj_4c_Opt_Tipo.Value
2742:             loc_oBO.this_nTipoImpressora = THIS.obj_4c_Opt_Impressora.Value
2743: 
2744:             *-- Cnt_Impressora
2745:             loc_oBO.this_nOpcaoImp = THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value

*-- Linhas 2759 a 2867:
2759:             THIS.this_cMensagemErro = loc_oErro.Message
2760:             MsgErro(loc_oErro.Message + CHR(13) + ;
2761:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2762:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Ler os Dados da Tela")
2763:         ENDTRY
2764: 
2765:         RETURN loc_lSucesso
2766:     ENDPROC
2767: 
2768:     *==========================================================================
2769:     * ObterImpressoraSelecionada - Nome Windows da impressora escolhida no
2770:     * ComboBox (legado: "lcNomeImp = crImpreV.impres", lido da LINHA CORRENTE
2771:     * do cursor de RowSource, nao do texto do controle).
2772:     *==========================================================================
2773:     PROTECTED FUNCTION ObterImpressoraSelecionada()
2774:         LOCAL loc_cNome
2775: 
2776:         loc_cNome = ""
2777:         IF USED("crImpreV") AND RECCOUNT("crImpreV") > 0
2778:             SELECT crImpreV
2779:             IF BETWEEN(THIS.cbo_4c_Get_Printer.ListIndex, 1, RECCOUNT("crImpreV"))
2780:                 GO (THIS.cbo_4c_Get_Printer.ListIndex)
2781:             ENDIF
2782:             loc_cNome = ALLTRIM(TratarNulo(crImpreV.Impres, ""))
2783:         ENDIF
2784: 
2785:         RETURN loc_cNome
2786:     ENDFUNC
2787: 
2788:     *==========================================================================
2789:     * AplicarAcessosUsuario - Le as permissoes do usuario logado para os
2790:     * ajustes finos da impressora e para o tipo de etiqueta. Transcricao das
2791:     * seis chamadas fChecaAcesso do Init legado:
2792:     *   .spn_AjVerts.Enabled = fChecaAcesso([SigPrEtq], [VERTICAL])   (e irmas)
2793:     *   .opt_Tipo.Enabled    = fChecaAcesso([SigPrEtq], [TIPO])
2794:     * fChecaAcesso mora no framework legado (Framework\sigacess.PRG, carregado
2795:     * por config.prg) e abre conexao propria: TRY aninhado garante que a tela
2796:     * ainda abra num ambiente sem banco, assumindo o default permissivo das
2797:     * properties (mesmo padrao de SIGREADSBO.Init).
2798:     *==========================================================================
2799:     PROTECTED PROCEDURE AplicarAcessosUsuario()
2800:         LOCAL loc_oErroAcesso
2801: 
2802:         TRY
2803:             THIS.this_lAcVertical   = fChecaAcesso("SigPrEtq", "VERTICAL")
2804:             THIS.this_lAcHorizontal = fChecaAcesso("SigPrEtq", "HORIZONTAL")
2805:             THIS.this_lAcDensidade  = fChecaAcesso("SigPrEtq", "DENSIDADE")
2806:             THIS.this_lAcVelocidade = fChecaAcesso("SigPrEtq", "VELOCIDADE")
2807:             THIS.this_lAcTipo       = fChecaAcesso("SigPrEtq", "TIPO")
2808:         CATCH TO loc_oErroAcesso
2809:             MsgErro(loc_oErroAcesso.Message, "fChecaAcesso")
2810:         ENDTRY
2811:     ENDPROC
2812: 
2813:     *==========================================================================
2814:     * HabilitarCampos - Liga/desliga a superficie de captura da tela. Este form
2815:     * OPERACIONAL nao tem modo INCLUIR/ALTERAR (o legado nao tem Page2 nem
2816:     * botao de Salvar/Cancelar): o parametro serve para TRANCAR a tela durante
2817:     * a impressao, que eh demorada, e destrancar no fim.
2818:     * O teto de permissao do usuario (AplicarAcessosUsuario) e a disponibilidade
2819:     * de tipos/impressoras sao respeitados SEMPRE - par_lHabilitar = .T. nunca
2820:     * libera o que o legado mantem bloqueado:
2821:     *   BtnReport.Imprime.Enabled = (lnTipos <> 0 And lnImp <> 0)
2822:     *   BtnReport.Value           = Iif(.Imprime.Enabled, 1, 2)
2823:     * NUNCA mexer em THIS.Enabled: o form eh modal (WindowType = 1) sem
2824:     * TitleBar, e desabilitar o form inteiro deixaria o usuario sem saida.
2825:     * PUBLIC: chamado de fora da classe pelo harness de teste (CLAUDE.md #3).
2826:     *==========================================================================
2827:     PROCEDURE HabilitarCampos(par_lHabilitar)
2828:         LOCAL loc_lLiga, loc_lTemImpressao
2829: 
2830:         loc_lLiga = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2831: 
2832:         *-- Captura de lista de precos e de movimentacao
2833:         THIS.txt_4c_Lpreco.Enabled       = loc_lLiga
2834:         THIS.txt_4c_LPreco2.Enabled      = loc_lLiga
2835:         THIS.chk_4c_ChkLista.Enabled     = loc_lLiga
2836:         THIS.chk_4c_ChkOperacoes.Enabled = loc_lLiga
2837:         THIS.txt_4c_Emps.Enabled         = loc_lLiga
2838:         THIS.txt_4c_Dopes.Enabled        = loc_lLiga
2839:         THIS.txt_4c_Numes.Enabled        = loc_lLiga
2840:         THIS.cmd_4c_BtnCarregar.Enabled  = loc_lLiga
2841: 
2842:         *-- Grade de etiquetas e exclusao de item
2843:         THIS.grd_4c_Dados.Enabled        = loc_lLiga
2844:         THIS.cmd_4c_Btnexcluir.Enabled   = loc_lLiga
2845: 
2846:         *-- Opcoes de impressao
2847:         THIS.obj_4c_Opt_separador.Enabled = loc_lLiga
2848:         THIS.obj_4c_OptOrdem.Enabled      = loc_lLiga
2849:         THIS.obj_4c_Opt_peso.Enabled      = loc_lLiga
2850:         THIS.obj_4c_OptCompos.Enabled     = loc_lLiga
2851:         THIS.obj_4c_Opt_Preco.Enabled     = loc_lLiga
2852:         THIS.cbo_4c_Get_Printer.Enabled   = loc_lLiga
2853:         THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Enabled = loc_lLiga
2854: 
2855:         *-- Legado: o tipo de etiqueta so fica ativo com mais de uma opcao
2856:         *-- (.Enabled = (lnTipos > 1) em PopularOpcoesTipoEtiqueta) e ainda
2857:         *-- depende da permissao TIPO.
2858:         THIS.obj_4c_Opt_Tipo.Enabled = (loc_lLiga AND THIS.this_lAcTipo AND THIS.this_nTotalTipos > 1)
2859: 
2860:         *-- Ajustes finos: permissao por parametro (fChecaAcesso)
2861:         THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Enabled = (loc_lLiga AND THIS.this_lAcVertical)
2862:         THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Enabled = (loc_lLiga AND THIS.this_lAcHorizontal)
2863:         THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Enabled = (loc_lLiga AND THIS.this_lAcDensidade)
2864:         THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Enabled = (loc_lLiga AND THIS.this_lAcVelocidade)
2865: 
2866:         *-- Botao Imprimir: so com tipo de etiqueta E impressora disponiveis.
2867:         loc_lTemImpressao = (THIS.this_nTotalTipos <> 0 AND THIS.this_nTotalImpressoras <> 0)

*-- Linhas 2883 a 2998:
2883:     * redigitar (regra CLAUDE.md #17 - criterio do legado se transcreve).
2884:     * PROTECTED pelo mesmo motivo de FormParaBO/BOParaForm (hook de FormBase).
2885:     *==========================================================================
2886:     PROTECTED PROCEDURE LimparCampos()
2887:         LOCAL loc_cCursor
2888: 
2889:         THIS.txt_4c_Lpreco.Value = ""
2890:         THIS.this_oBusinessObject.this_cLPreco = ""
2891: 
2892:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2893:         IF USED(loc_cCursor)
2894:             SELECT (loc_cCursor)
2895:             ZAP
2896:         ENDIF
2897: 
2898:         THIS.CarregarLista()
2899:     ENDPROC
2900: 
2901:     *==========================================================================
2902:     * CarregarLista - Fecha CADA caminho que popula a grade de etiquetas:
2903:     * garante a linha em branco que o legado sempre mantem em dbImpressao,
2904:     * reposiciona no topo e repinta o Grid.
2905:     * Popular o cursor NAO repinta a grade sozinho (regra CLAUDE.md #21a): o
2906:     * legado encerra cada carga com "Go Top In dbImpressao" + "Grade.Refresh",
2907:     * e esse par vive aqui para nao ser esquecido em nenhum dos quatro
2908:     * caminhos que mexem no cursor (carga por lista de precos, carga por
2909:     * movimentacao, exclusao de item e reset pos-impressao).
2910:     * PUBLIC: chamado de fora da classe pelo harness de teste (CLAUDE.md #3).
2911:     *==========================================================================
2912:     PROCEDURE CarregarLista()
2913:         LOCAL loc_cCursor, loc_lSucesso
2914: 
2915:         loc_lSucesso = .F.
2916:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorDados
2917: 
2918:         IF USED(loc_cCursor)
2919:             SELECT (loc_cCursor)
2920: 
2921:             *-- Legado: "Go Top In dbImpressao / If Eof() / Append Blank".
2922:             *-- O teste eh EOF() DEPOIS do GO TOP, nao RECCOUNT(): RECCOUNT
2923:             *-- conta tambem os registros marcados para exclusao, entao logo
2924:             *-- apos um DELETE a grade pode ficar sem NENHUMA linha visivel
2925:             *-- com RECCOUNT ainda positivo - e sem linha o Grid nao aceita
2926:             *-- digitacao no campo Produto.
2927:             GO TOP
2928:             IF EOF()
2929:                 APPEND BLANK
2930:                 GO TOP
2931:             ENDIF
2932: 
2933:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2934:                 THIS.grd_4c_Dados.Refresh()
2935:             ENDIF
2936: 
2937:             loc_lSucesso = .T.
2938:         ENDIF
2939: 
2940:         RETURN loc_lSucesso
2941:     ENDPROC
2942: 
2943:     *==========================================================================
2944:     * Activate - Legado: o Init termina com
2945:     * ".Grd_Etiqueta.Col_cpros.SetFocus", deixando o cursor do teclado no
2946:     * campo Produto da grade. SetFocus so vale com a tela ja visivel, por isso
2947:     * roda no Activate e uma unica vez (this_lFocoAplicado), para nao roubar o
2948:     * foco toda vez que a tela volta ao topo depois de um dialogo.
2949:     *==========================================================================
2950:     PROCEDURE Activate()
2951:         DODEFAULT()
2952: 
2953:         IF !THIS.this_lFocoAplicado
2954:             THIS.this_lFocoAplicado = .T.
2955: 
2956:             *-- Guarda em vez de TRY/CATCH: SetFocus em controle invisivel ou
2957:             *-- desabilitado eh erro de runtime, e aqui as tres condicoes sao
2958:             *-- verificaveis de antemao. Com a grade posicionada no topo
2959:             *-- (CarregarLista) o foco cai na coluna 1, que eh o campo Produto
2960:             *-- (col_cpros do legado).
2961:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2962:                 IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
2963:                     THIS.grd_4c_Dados.SetFocus()
2964:                 ENDIF
2965:             ENDIF
2966:         ENDIF
2967:     ENDPROC
2968: 
2969:     *==========================================================================
2970:     * Destroy - Libera cursores locais antes de encerrar o form
2971:     *==========================================================================
2972:     PROCEDURE Destroy()
2973:         IF USED("cursor_4c_Dados")
2974:             USE IN cursor_4c_Dados
2975:         ENDIF
2976:         IF USED("crImpreV")
2977:             USE IN crImpreV
2978:         ENDIF
2979:         IF USED("cursor_4c_Pam")
2980:             USE IN cursor_4c_Pam
2981:         ENDIF
2982:         IF USED("cursor_4c_Pac")
2983:             USE IN cursor_4c_Pac
2984:         ENDIF
2985:         IF USED("crImpre")
2986:             USE IN crImpre
2987:         ENDIF
2988:         IF USED("crSigCdmp")
2989:             USE IN crSigCdmp
2990:         ENDIF
2991:         IF USED("cursor_4c_ImpPar")
2992:             USE IN cursor_4c_ImpPar
2993:         ENDIF
2994: 
2995:         DODEFAULT()
2996:     ENDPROC
2997: 
2998: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):
*==============================================================================
* SigPrEtqBO.prg - Business Object para Impressao de Etiquetas Selecionadas
* Herda de: BusinessBase
* Origem legado: SIGPRETQ.SCX (form OPERACIONAL, sem CRUD proprio)
* Tabela de referencia: SigCdPro (produtos que recebem etiqueta)
*==============================================================================
DEFINE CLASS SigPrEtqBO AS BusinessBase

    *-- Identificacao da movimentacao (getEmps / getDopes / getNumes)
    this_cEmps            = ""   && Empresa (SigCdEmp.Cemps, char(3))
    this_cDopes           = ""   && Operacao de movimento (SigCdOpe.Dopes)
    this_cNumes           = ""   && Numero da movimentacao

    *-- Listas de preco (getLPreco / getLPreco2 - lookup SigCdLpc.LPrecos)
    this_cLPreco          = ""   && Lista de preco principal
    this_cLPreco2         = ""   && Lista de preco secundaria

    *-- Flags de carga de itens (chkLista / chkOperacoes)
    this_lCarregaItensLista     = .T.   && Carrega itens da Lista de Precos
    this_lCarregaItensOperacao  = .T.   && Carrega itens da Movimentacao

    *-- Opcoes de impressao de etiqueta (OptionGroups - valor = indice do botao)
    this_nTipoEtiqueta    = 1    && Opt_Tipo (tipo de etiqueta)
    this_nTipoImpressora  = 1    && Opt_Impressora (impressora especial)
    this_nOpcaoImp        = 1    && Cnt_Impressora.Opcao_imp
    this_nSeparador       = 1    && opt_separador
    this_nOrdem           = 1    && OptOrdem
    this_nPeso            = 1    && opt_peso
    this_nComposicao      = 1    && optCompos
    this_nPreco           = 1    && opt_Preco

    *-- Ajustes finos de impressao (Cnt_Impressora.Spn_*)
    this_nAjVerts         = 0    && Ajuste vertical
    this_nAjHorzs         = 0    && Ajuste horizontal
    this_nAjDenss         = 0    && Ajuste de densidade
    this_nAjVelos         = 0    && Ajuste de velocidade

    *-- Impressora do sistema Windows (Get_Printer - combobox)
    this_cImpressora      = ""

    *-- Controle interno / grade de etiquetas (dbImpressao no legado)
    this_cCursorDados     = "cursor_4c_Dados"
    this_lResultadoOk     = .F.
    this_cMensagemErro    = ""

    *-- Espelho da linha corrente do cursor de grade (dbImpressao no legado)
    *-- Preenchido por CarregarDoCursor() - mesma ordem/nomes do CREATE CURSOR
    *-- dbImpressao declarado no Load() do form legado.
    this_cCpros           = ""   && Codigo do produto (SigCdPro.CPros, char(14))
    this_cDPros           = ""   && Descricao do produto
    this_cReffs           = ""   && Referencia do fornecedor
    this_nQtds            = 0    && Quantidade apurada
    this_nQtdeEtiq        = 0    && Quantidade de etiquetas a imprimir
    this_cPedido          = ""   && Pedido/origem do item (Obs de lista de preco)
    this_cObs             = ""   && Observacao (lista de preco aplicada)
    this_nPVens           = 0    && Preco de venda
    this_nPrecoDe         = 0    && Preco "De" (preco cheio antes do desconto)
    this_nParcelas        = 0    && Numero de parcelas
    this_cCpros2          = ""   && Produto complementar 2 (combo/kit)
    this_cCpros3          = ""   && Produto complementar 3
    this_cCpros4          = ""   && Produto complementar 4
    this_cEmpos           = ""   && Empresa de origem do item
    this_cEmpDopNums      = ""   && Chave posicional Emps+Dopes+Numes (char(29))
    this_nCitens          = 0    && Numero do item na movimentacao (SigMvItn.Citens)
    this_nPesos           = 0    && Peso do produto (SigCdPro.PesoMs)
    this_cCodTams         = ""   && Codigo do tamanho (SigCdPro.CodTams)
    this_cDPro2s          = ""   && Descritivo do produto (SigCdPro.Dpro2s)

    *============================================================================
    PROCEDURE Init()
    *============================================================================
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT()
    ENDPROC

    *============================================================================
    * CarregarDoCursor - Mapeia uma linha do cursor de grade de etiquetas
    * (equivalente ao dbImpressao do legado) para as properties this_*.
    * par_cAliasCursor: alias do cursor posicionado na linha a carregar.
    *============================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCpros          = TratarNulo(Cpros, "")
        THIS.this_cDPros          = TratarNulo(DPros, "")
        THIS.this_cReffs          = TratarNulo(Reffs, "")
        THIS.this_nQtds           = TratarNulo(Qtds, 0)
        THIS.this_nQtdeEtiq       = TratarNulo(QtdeEtiq, 0)
        THIS.this_cPedido         = TratarNulo(Pedido, "")
        THIS.this_cObs            = TratarNulo(Obs, "")
        THIS.this_nPVens          = TratarNulo(PVens, 0)
        THIS.this_nPrecoDe        = TratarNulo(PrecoDe, 0)
        THIS.this_nParcelas       = TratarNulo(Parcelas, 0)
        THIS.this_cCpros2         = TratarNulo(Cpros2, "")
        THIS.this_cCpros3         = TratarNulo(Cpros3, "")
        THIS.this_cCpros4         = TratarNulo(Cpros4, "")
        THIS.this_cEmpos          = TratarNulo(empos, "")
        THIS.this_cEmpDopNums     = TratarNulo(empdopnums, "")
        THIS.this_nCitens         = TratarNulo(citens, 0)
        THIS.this_nPesos          = TratarNulo(Pesos, 0)
        THIS.this_cCodTams        = TratarNulo(CodTams, "")
        THIS.this_cDPro2s         = TratarNulo(DPro2s, "")

        RETURN .T.
    ENDFUNC

    *============================================================================
    * ObterChavePrimaria - Chave da linha corrente da grade (produto)
    *============================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDFUNC

    *============================================================================
    * Este BO NAO sobrescreve Inserir()/Atualizar()/ExecutarExclusao().
    *
    * O legado nao grava a selecao de etiquetas via INSERT/UPDATE/DELETE de
    * registro: dbImpressao eh um cursor 100% em memoria, populado a partir de
    * SigMvItn/SigCdLpi (metodos BuscarItensMovimento/BuscarItensListaPreco
    * abaixo) e a "gravacao" da tela eh a rotina de impressao de etiqueta
    * (SigOpEtq no legado) seguida de Commit() da conexao - nao um Salvar()
    * de registro no padrao FormBase/BusinessBase. Como este BO nunca chama
    * THIS.Salvar()/THIS.Excluir(), o comportamento padrao herdado de
    * BusinessBase ja eh o correto.
    *============================================================================

    *============================================================================
    * CarregarParametrosEtiqueta - Carrega SigCdPam (parametros gerais de
    * etiqueta) no cursor de destino. Equivale ao 1o CursorQuery do Init legado.
    *============================================================================
    FUNCTION CarregarParametrosEtiqueta(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Pam")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, TpInstalas, " + ;
                   "AjVerts, AjHorzs, TpCBars, GrPadClis, GrPadVens FROM SigCdPam"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * CarregarParametrosImpressao - Carrega SigCdPac (ajuste de impressao/
    * separador de etiqueta) no cursor de destino.
    *============================================================================
    FUNCTION CarregarParametrosImpressao(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Pac")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT AjDens, AjVelos, EtqSeps FROM SigCdPac"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarTiposEtiquetaAtivos - Tipos de etiqueta ativos (SigCdTpe), na
    * mesma ordem usada pelo legado para montar o Opt_Tipo (cOrdems+cEtiquetas).
    *============================================================================
    FUNCTION BuscarTiposEtiquetaAtivos(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_TiposEtiqueta")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT nTipos, cEtiquetas, cOrdems FROM SigCdTpe " + ;
                   "WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarImpressorasAutorizadas - Impressoras de etiqueta (nTpImpres = 2)
    * liberadas para o usuario, por acesso direto (SigSyImp) ou por grupo
    * (SigCdAcG). Transcricao literal do UNION ALL do Init legado.
    *============================================================================
    FUNCTION BuscarImpressorasAutorizadas(par_cUsuario, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_cUsuario

        IF VARTYPE(par_cUsuario) != "C" OR EMPTY(par_cUsuario)
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ImpressorasAutorizadas")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cUsuario = EscaparSQL(ALLTRIM(par_cUsuario))

        loc_cSQL = "SELECT b.Impres FROM SigSyImp a, SigCdmp b " + ;
                   "WHERE a.UsuAcess = " + loc_cUsuario + " AND a.CImps = b.Impres AND b.nTpImpres = 2 " + ;
                   "UNION ALL " + ;
                   "SELECT c.Impres FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                   "WHERE a.Usuarios = " + loc_cUsuario + " AND a.Grupos = b.GrAcess " + ;
                   "AND b.CImps = c.Impres AND c.nTpImpres = 2"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarImpressorasEtiqueta - Todas as impressoras de etiqueta cadastradas
    * (SigCdmp.nTpImpres = 2), sem filtro de usuario. Transcricao do FALLBACK
    * do Init legado: quando o UNION ALL de BuscarImpressorasAutorizadas nao
    * devolve nenhuma linha, o legado repete a consulta sem restricao de
    * acesso ("Select Distinct Impres From SigCdmp Where nTpImpres = 2
    * Order By Impres") em vez de deixar a lista vazia.
    *============================================================================
    FUNCTION BuscarImpressorasEtiqueta(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ImpressorasEtiqueta")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;
                   "WHERE nTpImpres = 2 ORDER BY Impres"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorEan13 - Localiza produto pelo codigo de barras EAN13.
    *============================================================================
    FUNCTION BuscarProdutoPorEan13(par_nEan, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_nEan) != "N" OR par_nEan <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE Ean13 = " + FormatarNumeroSQL(par_nEan, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorCodigoBarras - Localiza produto pelo codigo de barras
    * interno (CBars), usado quando o valor digitado nao eh um EAN13 valido.
    *============================================================================
    FUNCTION BuscarProdutoPorCodigoBarras(par_nCodigo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_nCodigo) != "N" OR par_nCodigo <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE CBars = " + FormatarNumeroSQL(par_nCodigo, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorCodigo - Localiza produto pelo codigo (CPros).
    *============================================================================
    FUNCTION BuscarProdutoPorCodigo(par_cCodigo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorDescricao - Localiza produto pela descricao (DPros).
    *============================================================================
    FUNCTION BuscarProdutoPorDescricao(par_cDescricao, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cDescricao) != "C" OR EMPTY(par_cDescricao)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE DPros = " + EscaparSQL(ALLTRIM(par_cDescricao))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorDescritivo - Localiza produto pelo descritivo (Dpro2s,
    * usado como "Referencia Fornecedor"/descritivo no grid de etiquetas).
    *============================================================================
    FUNCTION BuscarProdutoPorDescritivo(par_cDescritivo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cDescritivo) != "C" OR EMPTY(par_cDescritivo)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE Dpro2s = " + EscaparSQL(ALLTRIM(par_cDescritivo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * VerificarUnidadeEtiquetaIndividual - .T. quando a unidade do produto
    * usa etiqueta individual e NAO permite duplicidade (Etiqs = 'S' e
    * EtiqDups <> 1) - nesse caso o legado bloqueia a impressao em lote.
    *============================================================================
    FUNCTION VerificarUnidadeEtiquetaIndividual(par_cCodUnidade)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lBloqueia

        loc_lBloqueia = .F.

        IF VARTYPE(par_cCodUnidade) != "C" OR EMPTY(par_cCodUnidade)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_UnidadeEtiqueta"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Etiqs, EtiqDups FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCodUnidade))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0
            SELECT (loc_cAlias)
            loc_lBloqueia = (ALLTRIM(UPPER(TratarNulo(Etiqs, ""))) == "S") AND (TratarNulo(EtiqDups, 0) <> 1)
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lBloqueia
    ENDFUNC

    *============================================================================
    * BuscarItensMovimento - Itens da movimentacao (SigMvItn) para a chave
    * posicional EmpDopNums (Emps char(3) + Dopes char(20) + Numes STR(,6)),
    * usada pelo botao "Carregar" quando chkOperacoes esta marcado.
    *============================================================================
    FUNCTION BuscarItensMovimento(par_cEmpDopNums, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cEmpDopNums) != "C" OR EMPTY(par_cEmpDopNums)
            THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ItensMovimento")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        *-- Chave POSICIONAL (Emps+Dopes+Numes) - NAO fazer ALLTRIM nas partes
        *-- que compoem par_cEmpDopNums; o padding faz parte da chave.
        loc_cSQL = "SELECT CPros, DPros, Units, Qtds, Citens FROM SigMvItn " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarItensListaPreco - Itens de uma lista de precos (SigCdLpi), usada
    * pelo botao "Carregar"/Valid de Get_lpreco quando chkLista esta marcado.
    *============================================================================
    FUNCTION BuscarItensListaPreco(par_cListaPreco, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco)
            THIS.this_cMensagemErro = "Lista de pre" + CHR(231) + "os n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ItensListaPreco")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs FROM SigCdLpi " + ;
                   "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarPrecoItemListaPreco - Preco de um produto especifico dentro de
    * uma lista de precos (usado nos Valid dos campos da grade).
    *============================================================================
    FUNCTION BuscarPrecoItemListaPreco(par_cListaPreco, par_cCodProduto, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco) ;
           OR VARTYPE(par_cCodProduto) != "C" OR EMPTY(par_cCodProduto)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_PrecoItemLista")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs FROM SigCdLpi " + ;
                   "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30)) + ;
                   " AND CPros = " + EscaparSQL(PADR(ALLTRIM(par_cCodProduto), 14))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * ValidarListaPreco - Confere se a lista de precos existe (SigCdLpc),
    * usado no Valid de Get_lpreco/getLPreco2 antes de abrir o picker.
    *============================================================================
    FUNCTION ValidarListaPreco(par_cListaPreco)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaListaPreco"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos FROM SigCdLpc WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * BuscarOperacaoNumero - Le o NDopes (numero curto da operacao) de
    * SigCdOpe, usado para montar o "lcBop" (chave de impressao) antes de
    * chamar a rotina de impressao de etiqueta.
    *============================================================================
    FUNCTION BuscarOperacaoNumero(par_cCodOperacao, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cCodOperacao) != "C" OR EMPTY(par_cCodOperacao)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_OperacaoNumero")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Dopes, NDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodOperacao))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * ValidarOperacao - Confere se o codigo de operacao existe em SigCdOpe.
    * Substitui a chamada legado a fAcessoMovmto() (funcao global nao portada).
    *============================================================================
    FUNCTION ValidarOperacao(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaOperacao"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * ValidarEmpresa - Confere se o codigo de empresa existe em SigCdEmp.
    * Substitui a chamada legado a fAcessoEmpresa() (funcao global nao
    * portada - ver licao aprendida sobre fAcessoEmpresa).
    *============================================================================
    FUNCTION ValidarEmpresa(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaEmpresa"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * ImprimirEtiquetas - Envia para impressao as etiquetas selecionadas na
    * grade (cursor_4c_Dados). O motor de impressao do legado (SigOpEtq, em
    * SIGFUNCS.PRG) gera comandos proprietarios ZPL/EPL/Allegro para
    * impressoras termicas especificas e NAO esta no acervo migrado (mesma
    * familia da licao "funcao global do legado nao portada" - regra
    * CLAUDE.md #27). Como o retorno de SigOpEtq eh descartado pelo legado
    * (=SigOpEtq(...)) e o fluxo segue para "Impressao Concluida!!!"
    * seja qual for o resultado interno dela, este metodo substitui por uma
    * impressao de texto generica e FUNCIONAL (via SET DEVICE TO PRINTER),
    * respeitando quantidade por item (QtdeEtiq), impressora selecionada,
    * exibicao de preco e peso, e separador entre etiquetas - sem reproduzir
    * o layout proprietario exato (codigo de barras/posicionamento termico)
    * que so existe no motor original.
    *============================================================================
    FUNCTION ImprimirEtiquetas(par_nImpPreco, par_lImpSepar, par_nTpEti, par_nTpImp, ;
            par_nAjVerts, par_nAjHorzs, par_nAjDenss, par_nAjVelos, par_cNomeImpressora, ;
            par_lImpPeso, par_cBop, par_cLp1, par_cLp2, par_lCompo)

        LOCAL loc_cCursor, loc_nCopia, loc_nQtdImpressa, loc_lSucesso, loc_oErro

        loc_lSucesso    = .F.
        loc_nQtdImpressa = 0
        loc_cCursor     = THIS.this_cCursorDados

        IF !USED(loc_cCursor)
            THIS.this_cMensagemErro = "Nenhuma etiqueta selecionada para impress" + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            IF !EMPTY(par_cNomeImpressora)
                SET PRINTER TO NAME (par_cNomeImpressora)
            ENDIF

            SET DEVICE TO PRINTER
            SET PRINT ON

            SELECT (loc_cCursor)
            SCAN FOR !EMPTY(Cpros) AND QtdeEtiq > 0
                FOR loc_nCopia = 1 TO QtdeEtiq
                    @ PROW() + 1, 0 SAY PADR(ALLTRIM(Cpros), 14) + "  " + ALLTRIM(TratarNulo(DPros, ""))

                    IF INLIST(par_nImpPreco, 1, 3, 4)
                        @ PROW() + 1, 4 SAY "R$ " + TRANSFORM(PVens, "999,999.99")
                    ENDIF

                    IF par_lImpPeso AND TratarNulo(Pesos, 0) > 0
                        @ PROW() + 1, 4 SAY "Peso: " + TRANSFORM(Pesos, "999,999.999") + " Kg"
                    ENDIF

                    IF par_lCompo AND !EMPTY(TratarNulo(DPro2s, ""))
                        @ PROW() + 1, 4 SAY ALLTRIM(DPro2s)
                    ENDIF

                    IF !EMPTY(par_cBop)
                        @ PROW() + 1, 4 SAY "Ref: " + par_cBop
                    ENDIF

                    IF par_lImpSepar
                        @ PROW() + 1, 0 SAY REPLICATE("-", 40)
                    ENDIF

                    loc_nQtdImpressa = loc_nQtdImpressa + 1
                ENDFOR
                SELECT (loc_cCursor)
            ENDSCAN

            SET PRINT OFF
            SET DEVICE TO SCREEN

            IF loc_nQtdImpressa = 0
                THIS.this_cMensagemErro = "Nenhuma etiqueta com quantidade apurada para imprimir."
            ELSE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            SET PRINT OFF
            SET DEVICE TO SCREEN
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

