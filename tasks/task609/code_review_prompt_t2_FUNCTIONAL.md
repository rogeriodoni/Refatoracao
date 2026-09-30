# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (22)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterImpressoraSelecionada()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3002 linhas total):

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

*-- Linhas 358 a 635:
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
561:         SET NULL ON
562:         CREATE CURSOR cursor_4c_Dados ( ;
563:             Cpros      C(14), ;
564:             DPros      C(40), ;
565:             Reffs      C(40), ;
566:             Qtds       N(10,3), ;
567:             QtdeEtiq   N(10,3), ;
568:             Pedido     C(30), ;
569:             Obs        C(10), ;
570:             PVens      N(12,2), ;
571:             PrecoDe    N(12,2), ;
572:             Parcelas   N(2,0), ;
573:             Cpros2     C(14), ;
574:             Cpros3     C(14), ;
575:             Cpros4     C(14), ;
576:             empos      C(3), ;
577:             empdopnums C(29), ;
578:             citens     N(10), ;
579:             Pesos      N(12,2), ;
580:             CodTams    C(4), ;
581:             DPro2s     C(45))
582:         SET NULL OFF
583: 
584:         INDEX ON Cpros TAG Cpros
585:         INDEX ON RECNO() TAG Registros
586:         SET ORDER TO
587:         APPEND BLANK
588:     ENDPROC
589: 
590:     *==========================================================================
591:     * ConfigurarGridEtiquetas - Monta o Grd_Etiqueta legado (grd_4c_Dados),
592:     * com as 7 colunas e a ordem visual exata do SCX (ColumnOrder: cpros=1,
593:     * DPro2s=2, dpros=3, qtds=4, parcelas=5, PVens=6, PrecoDe=7).
594:     *==========================================================================
595:     PROTECTED PROCEDURE ConfigurarGridEtiquetas()
596:         THIS.AddObject("grd_4c_Dados", "GridBase")
597:         WITH THIS.grd_4c_Dados
598:             .Top          = 216
599:             .Left         = 12
600:             .Width        = 818
601:             .Height       = 157
602:             .ColumnCount  = 7
603:             .RecordSource = "cursor_4c_Dados"
604:             .FontName     = "Tahoma"
605:             .FontSize     = 8
606:             .HeaderHeight = 17
607:             .RowHeight    = 17
608:             .ScrollBars   = 2
609:             .DeleteMark   = .F.
610:             .RecordMark   = .F.
611:             .Visible      = .T.
612: 
613:             WITH .Column1
614:                 .ControlSource     = "cursor_4c_Dados.Cpros"
615:                 .Width             = 110
616:                 .ColumnOrder       = 1
617:                 .Movable           = .F.
618:                 .Resizable         = .F.
619:                 .FontName          = "Tahoma"
620:                 .FontSize          = 8
621:                 .Header1.Caption   = "Produto"
622:                 .Header1.Alignment = 2
623:                 .Header1.ForeColor = RGB(90, 90, 90)
624:             ENDWITH
625: 
626:             WITH .Column2
627:                 .ControlSource     = "cursor_4c_Dados.DPros"
628:                 .Width             = 270
629:                 .ColumnOrder       = 3
630:                 .Movable           = .F.
631:                 .Resizable         = .F.
632:                 .FontName          = "Tahoma"
633:                 .FontSize          = 8
634:                 .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
635:                 .Header1.Alignment = 2

*-- Linhas 708 a 820:
708:     ENDPROC
709: 
710:     *==========================================================================
711:     * ConfigurarLookupsGrade - Registra os BINDEVENT de KeyPress das colunas
712:     * editaveis do grd_4c_Dados (col_cpros/col_dpros/col_qtds/col_DPro2s no
713:     * legado). Colunas de Grid ja nascem com um Text1 default (nao precisa
714:     * AddObject - regra CLAUDE.md #18 so vale para controle CUSTOM tipo
715:     * CheckBox/ComboBox/OptionGroup).
716:     *==========================================================================
717:     PROTECTED PROCEDURE ConfigurarLookupsGrade()
718:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "ValidarProdutoGrid")
719:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "ValidarDescricaoGrid")
720:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "ValidarQtdGrid")
721:         BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "KeyPress", THIS, "ValidarDescritivoGrid")
722:     ENDPROC
723: 
724:     *==========================================================================
725:     * ValidarProdutoGrid - Coluna Produto da grade (col_cpros.txt_cpros no
726:     * legado). Transcricao do Valid legado: resolve EAN13/codigo de barras,
727:     * bloqueia produto com etiqueta individual, resolve por lookup
728:     * (fwbuscaext -> AbrirLookupCanonico) e aplica peso/preco/lista de
729:     * precos na linha corrente do cursor de grade.
730:     * Nota: o legado tambem chama fVerificarBarras(_Prod) - funcao global
731:     * NAO PORTADA (SIGFUNCS.PRG). O resultado dela e combinado com "OR
732:     * Len(_Prod) <= 14" antes de decidir buscar por CBars; como CPros eh
733:     * char(14), essa segunda condicao e sempre verdadeira para um valor de
734:     * produto valido e por isso a busca por codigo de barras SEMPRE
735:     * executa - o wrapper de fVerificarBarras fica sem efeito pratico e foi
736:     * omitido (regra CLAUDE.md #27, categoria "no-op documentado").
737:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
738:     *==========================================================================
739:     PROCEDURE ValidarProdutoGrid
740:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
741:         LOCAL loc_cCursor, loc_cProd, loc_nCod, loc_cUnidade, ;
742:               loc_cCodResolvido, loc_nValLista, loc_nValDeLista
743: 
744:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
745:             RETURN
746:         ENDIF
747: 
748:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
749:         loc_cProd   = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
750: 
751:         IF EMPTY(loc_cProd)
752:             THIS.grd_4c_Dados.Column2.Text1.Value = ""
753:             THIS.grd_4c_Dados.Refresh()
754:             RETURN
755:         ENDIF
756: 
757:         *-- Legado: valor puramente numerico pode ser o EAN13 do produto.
758:         loc_nCod = INT(VAL(loc_cProd))
759:         IF loc_nCod > 0 AND THIS.this_oBusinessObject.BuscarProdutoPorEan13(loc_nCod, "cursor_4c_ProdEan13Grid")
760:             SELECT cursor_4c_ProdEan13Grid
761:             loc_cProd = ALLTRIM(TratarNulo(CPros, ""))
762:         ENDIF
763: 
764:         *-- Busca por codigo de barras interno (ver nota do cabecalho sobre
765:         *-- fVerificarBarras - este bloco SEMPRE roda para CPros char(14)).
766:         loc_nCod = INT(VAL(loc_cProd))
767:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigoBarras(loc_nCod, "cursor_4c_ProdBarrasGrid")
768:             SELECT cursor_4c_ProdBarrasGrid
769:             loc_cProd = ALLTRIM(TratarNulo(CPros, ""))
770:         ELSE
771:             MsgAviso("Produto N" + CHR(227) + "o Cadastrado!!!", "")
772:             RETURN
773:         ENDIF
774: 
775:         *-- Unidade com etiqueta individual bloqueia impressao em lote.
776:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cProd, "cursor_4c_ProdUnidGrid")
777:             SELECT cursor_4c_ProdUnidGrid
778:             loc_cUnidade = ALLTRIM(TratarNulo(CUnis, ""))
779:             IF !EMPTY(loc_cUnidade) AND THIS.this_oBusinessObject.VerificarUnidadeEtiquetaIndividual(loc_cUnidade)
780:                 MsgAviso("Unidade do Produto (" + loc_cUnidade + ") Utiliza Etiqueta Individual !!!" + CHR(13) + ;
781:                          "Utilize o M" + CHR(243) + "dulo de Reimpress" + CHR(227) + "o de Etiquetas Individuais !!!", "")
782:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
783:                 THIS.grd_4c_Dados.Refresh()
784:                 RETURN
785:             ENDIF
786:         ENDIF
787: 
788:         *-- Lookup (fwbuscaext no legado) - so quando nao ha match unico direto.
789:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cProd, "cursor_4c_ProdLookupGrid") AND ;
790:            RECCOUNT("cursor_4c_ProdLookupGrid") = 1
791:             SELECT cursor_4c_ProdLookupGrid
792:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
793:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
794:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
795:         ELSE
796:             IF THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", ;
797:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cProd, ;
798:                     THIS.grd_4c_Dados.Column1.Text1, THIS.grd_4c_Dados.Column2.Text1)
799:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescritivoGrid")
800:                     SELECT cursor_4c_ProdDescritivoGrid
801:                     THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
802:                 ENDIF
803:             ELSE
804:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
805:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
806:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
807:             ENDIF
808:         ENDIF
809: 
810:         *-- Aplica peso/preco do produto na linha corrente do cursor de grade.
811:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
812:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
813:            THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPrecoGrid")
814:             SELECT cursor_4c_ProdPrecoGrid
815:             SELECT (loc_cCursor)
816:             REPLACE Pesos   WITH TratarNulo(cursor_4c_ProdPrecoGrid.PesoMs, 0), ;
817:                     PVens   WITH TratarNulo(cursor_4c_ProdPrecoGrid.PVens, 0), ;
818:                     PrecoDe WITH TratarNulo(cursor_4c_ProdPrecoGrid.PrecoDe, 0)
819:         ENDIF
820: 

*-- Linhas 853 a 898:
853:     * automatico) nao tem equivalente direto e foi omitida - eh conveniencia
854:     * de UI, nao regra de negocio (regra CLAUDE.md #17 se aplica a formula/
855:     * fluxo, nao a atalho de teclado).
856:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
857:     *==========================================================================
858:     PROCEDURE ValidarDescricaoGrid
859:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
860:         LOCAL loc_cCursor, loc_cDesc, loc_cCodResolvido
861: 
862:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
863:             RETURN
864:         ENDIF
865: 
866:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
867:         loc_cDesc   = ALLTRIM(THIS.grd_4c_Dados.Column2.Text1.Value)
868: 
869:         IF EMPTY(loc_cDesc)
870:             THIS.grd_4c_Dados.Column1.Text1.Value = ""
871:             THIS.grd_4c_Dados.Refresh()
872:             RETURN
873:         ENDIF
874: 
875:         IF THIS.this_oBusinessObject.BuscarProdutoPorDescricao(loc_cDesc, "cursor_4c_ProdDescGrid") AND ;
876:            RECCOUNT("cursor_4c_ProdDescGrid") = 1
877:             SELECT cursor_4c_ProdDescGrid
878:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
879:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
880:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
881:         ELSE
882:             IF THIS.AbrirLookupCanonico("SigCdPro", "DPros", "CPros", ;
883:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cDesc, ;
884:                     THIS.grd_4c_Dados.Column2.Text1, THIS.grd_4c_Dados.Column1.Text1)
885:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescritivo2Grid")
886:                     SELECT cursor_4c_ProdDescritivo2Grid
887:                     THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
888:                 ENDIF
889:             ELSE
890:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
891:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
892:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
893:             ENDIF
894:         ENDIF
895: 
896:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
897:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
898:            THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPeso2Grid")

*-- Linhas 914 a 959:
914:     * busca do legado eh feita pelo campo Dpro2s do produto). Transcricao do
915:     * Valid legado: resolve por match exato de Dpro2s e, sem match unico,
916:     * por lookup (fwbuscaext -> AbrirLookupCanonico).
917:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
918:     *==========================================================================
919:     PROCEDURE ValidarDescritivoGrid
920:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
921:         LOCAL loc_cCursor, loc_cDescritivo, loc_cCodResolvido
922: 
923:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
924:             RETURN
925:         ENDIF
926: 
927:         loc_cCursor     = THIS.this_oBusinessObject.this_cCursorDados
928:         loc_cDescritivo = ALLTRIM(THIS.grd_4c_Dados.Column4.Text1.Value)
929: 
930:         IF EMPTY(loc_cDescritivo)
931:             THIS.grd_4c_Dados.Column1.Text1.Value = ""
932:             THIS.grd_4c_Dados.Column2.Text1.Value = ""
933:             THIS.grd_4c_Dados.Refresh()
934:             RETURN
935:         ENDIF
936: 
937:         IF THIS.this_oBusinessObject.BuscarProdutoPorDescritivo(loc_cDescritivo, "cursor_4c_ProdDescrvGrid") AND ;
938:            RECCOUNT("cursor_4c_ProdDescrvGrid") = 1
939:             SELECT cursor_4c_ProdDescrvGrid
940:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
941:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
942:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
943:         ELSE
944:             IF THIS.AbrirLookupCanonico("SigCdPro", "Dpro2s", "CPros", ;
945:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cDescritivo, ;
946:                     THIS.grd_4c_Dados.Column4.Text1, THIS.grd_4c_Dados.Column1.Text1)
947:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescricao3Grid")
948:                     SELECT cursor_4c_ProdDescricao3Grid
949:                     THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
950:                 ENDIF
951:             ELSE
952:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
953:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
954:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
955:             ENDIF
956:         ENDIF
957: 
958:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
959:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;

*-- Linhas 980 a 1110:
980:     * que o guard inicial "If Lastkey()<>13 Return" filtra tudo que nao seja
981:     * Enter antes deles). Mantem sempre uma linha em branco no final para
982:     * digitacao (legado: Set Order To Cpros + Seek(Space(14))).
983:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
984:     *==========================================================================
985:     PROCEDURE ValidarQtdGrid
986:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
987:         LOCAL loc_cCursor, loc_cProduto, loc_nApurado, loc_cChave
988: 
989:         IF par_nKeyCode != 13
990:             RETURN
991:         ENDIF
992: 
993:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
994:         IF !USED(loc_cCursor)
995:             RETURN
996:         ENDIF
997: 
998:         SELECT (loc_cCursor)
999:         loc_cProduto = PADR(Cpros, 14)
1000:         loc_nApurado = Qtds
1001: 
1002:         IF EMPTY(loc_cProduto)
1003:             RETURN
1004:         ENDIF
1005: 
1006:         IF !THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cProduto), "cursor_4c_ProdValidaQtdGrid")
1007:             MsgAviso("Produto Inv" + CHR(225) + "lido!!!", "")
1008:             RETURN
1009:         ENDIF
1010: 
1011:         IF loc_nApurado <= 0
1012:             MsgAviso("Valor Apurado Inv" + CHR(225) + "lido!!!", "")
1013:             RETURN
1014:         ENDIF
1015: 
1016:         SELECT (loc_cCursor)
1017:         SET ORDER TO Cpros
1018:         loc_cChave = SPACE(14)
1019:         IF !SEEK(loc_cChave)
1020:             APPEND BLANK
1021:         ENDIF
1022:         SET ORDER TO
1023: 
1024:         THIS.grd_4c_Dados.Refresh()
1025:     ENDPROC
1026: 
1027:     *==========================================================================
1028:     * ConfigurarBotoesGrade - Botoes de acao da grade de etiquetas
1029:     * (btnCarregar/btnexcluir no legado - icones-only, SEM CommandGroup).
1030:     *==========================================================================
1031:     PROTECTED PROCEDURE ConfigurarBotoesGrade()
1032:         THIS.AddObject("cmd_4c_BtnCarregar", "CommandButton")
1033:         WITH THIS.cmd_4c_BtnCarregar
1034:             .Top             = 159
1035:             .Left            = 373
1036:             .Width           = 32
1037:             .Height          = 32
1038:             .Caption         = ""
1039:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
1040:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
1041:             .Themes          = .T.
1042:             .ToolTipText     = "Carregar Itens"
1043:             .Visible         = .T.
1044:         ENDWITH
1045:         BINDEVENT(THIS.cmd_4c_BtnCarregar, "Click", THIS, "BtnCarregarClick")
1046: 
1047:         THIS.AddObject("cmd_4c_Btnexcluir", "CommandButton")
1048:         WITH THIS.cmd_4c_Btnexcluir
1049:             .Top             = 374
1050:             .Left            = 21
1051:             .Width           = 32
1052:             .Height          = 32
1053:             .Caption         = ""
1054:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1055:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1056:             .Themes          = .T.
1057:             .ToolTipText     = "Excluir item"
1058:             .Visible         = .T.
1059:         ENDWITH
1060:         BINDEVENT(THIS.cmd_4c_Btnexcluir, "Click", THIS, "BtnExcluirItemClick")
1061:     ENDPROC
1062: 
1063:     *==========================================================================
1064:     * CriarCursorImpressorasWindows - Popula o cursor crImpreV (RowSource do
1065:     * Get_Printer/cbo_4c_Get_Printer) com as impressoras Windows instaladas
1066:     * na estacao. Precisa existir ANTES do ComboBox ser criado (regra
1067:     * CLAUDE.md #41 - ControlSource/RowSource de cursor inexistente derruba
1068:     * o Init).
1069:     *==========================================================================
1070:     PROTECTED PROCEDURE CriarCursorImpressorasWindows()
1071:         LOCAL loc_nImp, loc_nTotal, loc_cAliasAut, loc_lTemAutorizadas, loc_oErro
1072:         LOCAL ARRAY loc_aImpressoras[1, 2]
1073: 
1074:         *-- crImpre: impressoras instaladas no Windows (legado: Create Cursor
1075:         *-- crImpre + laPrinters de APrinters()).
1076:         IF USED("crImpre")
1077:             USE IN crImpre
1078:         ENDIF
1079:         CREATE CURSOR crImpre (Impres C(60))
1080: 
1081:         loc_nTotal = APRINTERS(loc_aImpressoras)
1082:         IF loc_nTotal > 0
1083:             FOR loc_nImp = 1 TO loc_nTotal
1084:                 INSERT INTO crImpre (Impres) VALUES (UPPER(loc_aImpressoras[loc_nImp, 1]))
1085:             ENDFOR
1086:         ENDIF
1087: 
1088:         *-- crSigCdmp: impressoras de ETIQUETA (SigCdmp.nTpImpres = 2) que o
1089:         *-- usuario pode usar - por acesso direto (SigSyImp) ou por grupo
1090:         *-- (SigCdAcG). Legado: quando o UNION ALL nao devolve linha nenhuma,
1091:         *-- ele repete a consulta SEM restricao de acesso.
1092:         loc_cAliasAut      = "cursor_4c_ImpAutTmp"
1093:         loc_lTemAutorizadas = .F.
1094: 
1095:         TRY
1096:             IF USED("crSigCdmp")
1097:                 USE IN crSigCdmp
1098:             ENDIF
1099: 
1100:             IF THIS.this_oBusinessObject.BuscarImpressorasAutorizadas(gc_4c_UsuarioLogado, loc_cAliasAut) ;
1101:                AND RECCOUNT(loc_cAliasAut) > 0
1102: 
1103:                 SELECT DISTINCT Impres FROM (loc_cAliasAut) ;
1104:                     ORDER BY Impres INTO CURSOR crSigCdmp READWRITE
1105:                 loc_lTemAutorizadas = .T.
1106:             ELSE
1107:                 IF THIS.this_oBusinessObject.BuscarImpressorasEtiqueta("crSigCdmp") ;
1108:                    AND RECCOUNT("crSigCdmp") > 0
1109:                     loc_lTemAutorizadas = .T.
1110:                 ENDIF

*-- Linhas 1118 a 1161:
1118:             THIS.this_cMensagemErro = loc_oErro.Message
1119:             MsgErro(loc_oErro.Message + CHR(13) + ;
1120:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1121:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Listar Impressoras")
1122:         ENDTRY
1123: 
1124:         *-- crImpreV: par "impressora do sistema x impressora do Windows".
1125:         *-- Estrutura FIXA nos dois caminhos (regra do CREATE CURSOR com ordem
1126:         *-- identica em todos os locais): IDupla eh a coluna 1 e portanto o
1127:         *-- texto exibido pelo ComboBox; Impres eh o nome Windows que vai para
1128:         *-- a impressao; ImpresS eh o nome de sistema usado no ajuste fino.
1129:         IF USED("cursor_4c_ImpPar")
1130:             USE IN cursor_4c_ImpPar
1131:         ENDIF
1132:         SET NULL ON
1133:         CREATE CURSOR cursor_4c_ImpPar (IDupla C(66), Impres C(60), ImpresS C(60))
1134:         SET NULL OFF
1135: 
1136:         IF loc_lTemAutorizadas
1137:             *-- Legado: casa as duas listas por conter-um-ao-outro (o nome
1138:             *-- cadastrado costuma ser um prefixo do nome instalado).
1139:             SELECT crSigCdmp
1140:             SCAN
1141:                 SELECT crImpre
1142:                 SCAN
1143:                     IF ALLTRIM(UPPER(crSigCdmp.Impres)) $ ALLTRIM(UPPER(crImpre.Impres)) ;
1144:                        OR ALLTRIM(UPPER(crImpre.Impres)) $ ALLTRIM(UPPER(crSigCdmp.Impres))
1145: 
1146:                         INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ( ;
1147:                             PADR(ALLTRIM(crSigCdmp.Impres), 15) + " " + ALLTRIM(crImpre.Impres), ;
1148:                             crImpre.Impres, ;
1149:                             crSigCdmp.Impres)
1150:                     ENDIF
1151:                     SELECT crImpre
1152:                 ENDSCAN
1153:                 SELECT crSigCdmp
1154:             ENDSCAN
1155: 
1156:             *-- Legado: com mais de um par casado, a lista ganha uma linha em
1157:             *-- BRANCO que, pela ordenacao por IDupla, fica em PRIMEIRO - a
1158:             *-- tela abre sem impressora escolhida e obriga a escolha
1159:             *-- explicita ("se houver mais de uma impressora na lista,
1160:             *-- posiciona em impressora em branco").
1161:             IF RECCOUNT("cursor_4c_ImpPar") > 1

*-- Linhas 1208 a 1325:
1208:     * amarra o fluxo de impressao (BTNREPORT), que tambem nao foi criado
1209:     * ainda nesta fase.
1210:     *==========================================================================
1211:     PROTECTED PROCEDURE ConfigurarCamposImpressao()
1212: 
1213:         *-- Shape3 - moldura decorativa em volta do bloco Impressora
1214:         THIS.AddObject("shp_4c_Shape3", "Shape")
1215:         WITH THIS.shp_4c_Shape3
1216:             .Top           = 431
1217:             .Left          = 260
1218:             .Height        = 106
1219:             .Width         = 254
1220:             .BackStyle     = 0
1221:             .BorderWidth   = 1
1222:             .SpecialEffect = 1
1223:             .Visible       = .T.
1224:         ENDWITH
1225: 
1226:         *-- Opt_Tipo - tipo de etiqueta (populado dinamicamente em fase futura)
1227:         THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
1228:         WITH THIS.obj_4c_Opt_Tipo
1229:             .Top           = 431
1230:             .Left          = 13
1231:             .Width         = 240
1232:             .Height        = 182
1233:             .ButtonCount   = 1
1234:             .BackStyle     = 0
1235:             .SpecialEffect = 1
1236:             .Themes        = .F.
1237:             .Value         = THIS.this_oBusinessObject.this_nTipoEtiqueta
1238:             .Visible       = .T.
1239:             WITH .Buttons(1)
1240:                 .Caption   = "Rabicho"
1241:                 .Top       = 10
1242:                 .Left      = 9
1243:                 .Width     = 197
1244:                 .Height    = 16
1245:                 .BackStyle = 0
1246:                 .FontName  = "Tahoma"
1247:                 .FontSize  = 8
1248:                 .ForeColor = RGB(90, 90, 90)
1249:                 .Tag       = "1"
1250:             ENDWITH
1251:         ENDWITH
1252:         BINDEVENT(THIS.obj_4c_Opt_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")
1253: 
1254:         THIS.AddObject("lbl_4c_Label1", "Label")
1255:         WITH THIS.lbl_4c_Label1
1256:             .Top       = 415
1257:             .Left      = 23
1258:             .Width     = 99
1259:             .Height    = 15
1260:             .BackStyle = 0
1261:             .Alignment = 0
1262:             .FontBold  = .T.
1263:             .FontName  = "Tahoma"
1264:             .FontSize  = 8
1265:             .ForeColor = RGB(90, 90, 90)
1266:             .Caption   = "Tipo de Etiqueta"
1267:             .Visible   = .T.
1268:         ENDWITH
1269: 
1270:         *-- Cnt_Impressora - ajustes da impressora de etiqueta (Zebra/Allegro)
1271:         *-- Cnt_Impressora - CUIDADO: AddObject dos filhos fica FORA do WITH do
1272:         *-- container (regra CLAUDE.md - "WITH aninhado em Container/Label/
1273:         *-- CommandGroup AddObject" - WITH THIS.cnt_X / .AddObject(filho) /
1274:         *-- WITH .filho (2+ niveis relativos) ignora propriedade em silencio).
1275:         *-- Cada filho recebe WITH proprio com o CAMINHO COMPLETO.
1276:         THIS.AddObject("cnt_4c__Impressora", "Container")
1277:         WITH THIS.cnt_4c__Impressora
1278:             .Top       = 539
1279:             .Left      = 260
1280:             .Width     = 254
1281:             .Height    = 74
1282:             .BackStyle = 0
1283:             .Visible   = .T.
1284: 
1285:             .AddObject("obj_4c_Opcao_imp", "OptionGroup")
1286:             .AddObject("lbl_4c_Label2", "Label")
1287:             .AddObject("lbl_4c_Label3", "Label")
1288:             .AddObject("obj_4c_Spn_AjVerts", "Spinner")
1289:             .AddObject("obj_4c_Spn_AjHorzs", "Spinner")
1290:             .AddObject("obj_4c_Spn_AjDenss", "Spinner")
1291:             .AddObject("obj_4c_Spn_AjVelos", "Spinner")
1292:             .AddObject("lbl_4c_Label1", "Label")
1293:             .AddObject("lbl_4c_Label20", "Label")
1294:         ENDWITH
1295: 
1296:         WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp
1297:             .Top         = 3
1298:             .Left        = 5
1299:             .Width       = 241
1300:             .Height      = 24
1301:             .ButtonCount = 3
1302:             .Value       = THIS.this_oBusinessObject.this_nOpcaoImp
1303:             .Visible     = .T.
1304:             WITH .Buttons(1)
1305:                 .Caption   = "Allegro"
1306:                 .Top       = 4
1307:                 .Left      = 2
1308:                 .Width     = 51
1309:                 .AutoSize  = .T.
1310:                 .FontName  = "Tahoma"
1311:                 .FontSize  = 8
1312:                 .ForeColor = RGB(90, 90, 90)
1313:             ENDWITH
1314:             WITH .Buttons(2)
1315:                 .Caption   = "Zebra ZPL"
1316:                 .Top       = 4
1317:                 .Left      = 75
1318:                 .Width     = 66
1319:                 .AutoSize  = .T.
1320:                 .FontName  = "Tahoma"
1321:                 .FontSize  = 8
1322:                 .ForeColor = RGB(90, 90, 90)
1323:             ENDWITH
1324:             WITH .Buttons(3)
1325:                 .Caption   = "Zebra EPL"

*-- Linhas 1334 a 1838:
1334:                 .ForeColor = RGB(90, 90, 90)
1335:             ENDWITH
1336:         ENDWITH
1337:         BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Opcao_imp, "InteractiveChange", THIS, "OpcaoImpInteractiveChange")
1338: 
1339:         WITH THIS.cnt_4c__Impressora.lbl_4c_Label2
1340:             .Top       = 29
1341:             .Left      = 10
1342:             .Width     = 33
1343:             .Height    = 13
1344:             .BackStyle = 0
1345:             .Alignment = 0
1346:             .FontName  = "Tahoma"
1347:             .FontSize  = 7
1348:             .ForeColor = RGB(90, 90, 90)
1349:             .Caption   = "Vertical"
1350:             .Visible   = .T.
1351:         ENDWITH
1352: 
1353:         WITH THIS.cnt_4c__Impressora.lbl_4c_Label3
1354:             .Top       = 29
1355:             .Left      = 69
1356:             .Width     = 43
1357:             .Height    = 13
1358:             .BackStyle = 0
1359:             .Alignment = 0
1360:             .FontName  = "Tahoma"
1361:             .FontSize  = 7
1362:             .ForeColor = RGB(90, 90, 90)
1363:             .Caption   = "Horizontal"
1364:             .Visible   = .T.
1365:         ENDWITH
1366: 
1367:         WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts
1368:             .Top               = 42
1369:             .Left              = 10
1370:             .Width             = 56
1371:             .Height            = 26
1372:             .KeyboardLowValue  = 0
1373:             .KeyboardHighValue = 999
1374:             .SpinnerLowValue   = 0.00
1375:             .SpinnerHighValue  = 999.00
1376:             .FontName          = "Tahoma"
1377:             .Value             = THIS.this_oBusinessObject.this_nAjVerts
1378:             .Visible           = .T.
1379:         ENDWITH
1380:         BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts, "InteractiveChange", THIS, "SpnAjVertsInteractiveChange")
1381: 
1382:         WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs
1383:             .Top               = 42
1384:             .Left              = 69
1385:             .Width             = 56
1386:             .Height            = 26
1387:             .KeyboardLowValue  = -999
1388:             .KeyboardHighValue = 999
1389:             .SpinnerLowValue   = -999.00
1390:             .SpinnerHighValue  = 999.00
1391:             .FontName          = "Tahoma"
1392:             .Value             = THIS.this_oBusinessObject.this_nAjHorzs
1393:             .Visible           = .T.
1394:         ENDWITH
1395:         BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs, "InteractiveChange", THIS, "SpnAjHorzsInteractiveChange")
1396: 
1397:         WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss
1398:             .Top               = 42
1399:             .Left              = 128
1400:             .Width             = 56
1401:             .Height            = 26
1402:             .KeyboardLowValue  = 1
1403:             .KeyboardHighValue = 20
1404:             .SpinnerLowValue   = 1.00
1405:             .SpinnerHighValue  = 20.00
1406:             .FontName          = "Tahoma"
1407:             .Value             = 20
1408:             .Visible           = .T.
1409:         ENDWITH
1410:         THIS.this_oBusinessObject.this_nAjDenss = 20
1411:         BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss, "InteractiveChange", THIS, "SpnAjDenssInteractiveChange")
1412: 
1413:         WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos
1414:             .Top               = 42
1415:             .Left              = 188
1416:             .Width             = 54
1417:             .Height            = 26
1418:             .KeyboardLowValue  = 1
1419:             .KeyboardHighValue = 3
1420:             .SpinnerLowValue   = 1.00
1421:             .SpinnerHighValue  = 3.00
1422:             .FontName          = "Tahoma"
1423:             *-- Legado: spn_AjVelos = Iif(Empty(crSigCdPac.AjVelos), 01, ...),
1424:             *-- ou seja, o default SEM parametro cadastrado eh 1, nao o teto da
1425:             *-- faixa. BOParaForm sobrepoe com o valor de SigCdPac quando ha
1426:             *-- banco (ver CarregarParametrosPadrao).
1427:             .Value             = 1
1428:             .Visible           = .T.
1429:         ENDWITH
1430:         THIS.this_oBusinessObject.this_nAjVelos = 1
1431:         BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos, "InteractiveChange", THIS, "SpnAjVelosInteractiveChange")
1432: 
1433:         WITH THIS.cnt_4c__Impressora.lbl_4c_Label1
1434:             .Top       = 29
1435:             .Left      = 128
1436:             .Width     = 60
1437:             .Height    = 13
1438:             .BackStyle = 0
1439:             .Alignment = 0
1440:             .FontName  = "Tahoma"
1441:             .FontSize  = 7
1442:             .ForeColor = RGB(90, 90, 90)
1443:             .Caption   = "Densidade"
1444:             .Visible   = .T.
1445:         ENDWITH
1446: 
1447:         WITH THIS.cnt_4c__Impressora.lbl_4c_Label20
1448:             .Top       = 30
1449:             .Left      = 188
1450:             .Width     = 60
1451:             .Height    = 13
1452:             .BackStyle = 0
1453:             .Alignment = 0
1454:             .FontName  = "Tahoma"
1455:             .FontSize  = 7
1456:             .ForeColor = RGB(90, 90, 90)
1457:             .Caption   = "Velocidade"
1458:             .Visible   = .T.
1459:         ENDWITH
1460: 
1461:         *-- Opt_Impressora - impressora alternativa (OCULTA por padrao no
1462:         *-- legado - Visible = .F. no SCX, e o InteractiveChange dela vem
1463:         *-- COMENTADO no proprio legado - regra CLAUDE.md: transcrever fiel).
1464:         THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
1465:         WITH THIS.obj_4c_Opt_Impressora
1466:             .Top           = 431
1467:             .Left          = 260
1468:             .Width         = 254
1469:             .Height        = 47
1470:             .ButtonCount   = 1
1471:             .BackStyle     = 0
1472:             .SpecialEffect = 1
1473:             .Themes        = .F.
1474:             .Visible       = .F.
1475:             WITH .Buttons(1)
1476:                 .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
1477:                 .Top       = 52
1478:                 .Left      = 9
1479:                 .Width     = 210
1480:                 .Height    = 16
1481:                 .BackStyle = 0
1482:                 .AutoSize  = .F.
1483:                 .FontName  = "Verdana"
1484:                 .FontSize  = 8
1485:                 .ForeColor = RGB(36, 84, 155)
1486:             ENDWITH
1487:         ENDWITH
1488: 
1489:         THIS.AddObject("lbl_4c_Label3", "Label")
1490:         WITH THIS.lbl_4c_Label3
1491:             .Top       = 415
1492:             .Left      = 271
1493:             .Width     = 74
1494:             .Height    = 15
1495:             .BackStyle = 0
1496:             .Alignment = 0
1497:             .FontBold  = .T.
1498:             .FontName  = "Tahoma"
1499:             .FontSize  = 8
1500:             .ForeColor = RGB(90, 90, 90)
1501:             .Caption   = "Impressora"
1502:             .Visible   = .T.
1503:         ENDWITH
1504: 
1505:         *-- opt_separador - imprime separadora de etiquetas
1506:         THIS.AddObject("obj_4c_Opt_separador", "OptionGroup")
1507:         WITH THIS.obj_4c_Opt_separador
1508:             .Top           = 412
1509:             .Left          = 601
1510:             .Width         = 198
1511:             .Height        = 25
1512:             .ButtonCount   = 2
1513:             .BackStyle     = 0
1514:             .SpecialEffect = 1
1515:             .Themes        = .F.
1516:             .Value         = THIS.this_oBusinessObject.this_nSeparador
1517:             .Visible       = .T.
1518:             WITH .Buttons(1)
1519:                 .Caption   = "Sim"
1520:                 .Top       = 5
1521:                 .Left      = 5
1522:                 .Width     = 34
1523:                 .Height    = 15
1524:                 .BackStyle = 0
1525:                 .AutoSize  = .T.
1526:                 .FontName  = "Tahoma"
1527:                 .FontSize  = 8
1528:                 .ForeColor = RGB(90, 90, 90)
1529:             ENDWITH
1530:             WITH .Buttons(2)
1531:                 .Caption   = "N" + CHR(227) + "o"
1532:                 .Top       = 5
1533:                 .Left      = 70
1534:                 .Width     = 37
1535:                 .Height    = 15
1536:                 .BackStyle = 0
1537:                 .AutoSize  = .T.
1538:                 .FontName  = "Tahoma"
1539:                 .FontSize  = 8
1540:                 .ForeColor = RGB(90, 90, 90)
1541:             ENDWITH
1542:         ENDWITH
1543:         BINDEVENT(THIS.obj_4c_Opt_separador, "InteractiveChange", THIS, "OptSeparadorInteractiveChange")
1544: 
1545:         THIS.AddObject("lbl_4c_Lbl_Separador", "Label")
1546:         WITH THIS.lbl_4c_Lbl_Separador
1547:             .Top       = 417
1548:             .Left      = 532
1549:             .Width     = 65
1550:             .Height    = 15
1551:             .BackStyle = 0
1552:             .Alignment = 0
1553:             .FontName  = "Tahoma"
1554:             .FontSize  = 8
1555:             .ForeColor = RGB(90, 90, 90)
1556:             .Caption   = "Separadora :"
1557:             .Visible   = .T.
1558:         ENDWITH
1559: 
1560:         *-- OptOrdem - ordem de impressao
1561:         THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
1562:         WITH THIS.obj_4c_OptOrdem
1563:             .Top           = 589
1564:             .Left          = 601
1565:             .Width         = 198
1566:             .Height        = 25
1567:             .ButtonCount   = 2
1568:             .AutoSize      = .F.
1569:             .BackStyle     = 0
1570:             .SpecialEffect = 1
1571:             .Themes        = .F.
1572:             .Value         = THIS.this_oBusinessObject.this_nOrdem
1573:             .Visible       = .T.
1574:             WITH .Buttons(1)
1575:                 .Caption   = "Produto"
1576:                 .Top       = 4
1577:                 .Left      = 5
1578:                 .Width     = 56
1579:                 .Height    = 15
1580:                 .BackStyle = 0
1581:                 .AutoSize  = .T.
1582:                 .FontName  = "Tahoma"
1583:                 .FontSize  = 8
1584:                 .ForeColor = RGB(90, 90, 90)
1585:             ENDWITH
1586:             WITH .Buttons(2)
1587:                 .Caption   = "Nenhuma"
1588:                 .Top       = 4
1589:                 .Left      = 70
1590:                 .Width     = 63
1591:                 .Height    = 15
1592:                 .BackStyle = 0
1593:                 .AutoSize  = .T.
1594:                 .FontName  = "Tahoma"
1595:                 .FontSize  = 8
1596:                 .ForeColor = RGB(90, 90, 90)
1597:             ENDWITH
1598:         ENDWITH
1599:         BINDEVENT(THIS.obj_4c_OptOrdem, "InteractiveChange", THIS, "OptOrdemInteractiveChange")
1600: 
1601:         THIS.AddObject("lbl_4c_Label11", "Label")
1602:         WITH THIS.lbl_4c_Label11
1603:             .Top       = 594
1604:             .Left      = 556
1605:             .Width     = 41
1606:             .Height    = 15
1607:             .BackStyle = 0
1608:             .Alignment = 0
1609:             .FontName  = "Tahoma"
1610:             .FontSize  = 8
1611:             .ForeColor = RGB(90, 90, 90)
1612:             .Caption   = "Ordem :"
1613:             .Visible   = .T.
1614:         ENDWITH
1615: 
1616:         THIS.AddObject("lbl_4c_Label8", "Label")
1617:         WITH THIS.lbl_4c_Label8
1618:             .Top       = 440
1619:             .Left      = 561
1620:             .Width     = 36
1621:             .Height    = 15
1622:             .BackStyle = 0
1623:             .Alignment = 0
1624:             .FontName  = "Tahoma"
1625:             .FontSize  = 8
1626:             .ForeColor = RGB(90, 90, 90)
1627:             .Caption   = "Pre" + CHR(231) + "o :"
1628:             .Visible   = .T.
1629:         ENDWITH
1630: 
1631:         *-- opt_peso - imprime peso na etiqueta
1632:         THIS.AddObject("obj_4c_Opt_peso", "OptionGroup")
1633:         WITH THIS.obj_4c_Opt_peso
1634:             .Top           = 535
1635:             .Left          = 601
1636:             .Width         = 198
1637:             .Height        = 25
1638:             .ButtonCount   = 2
1639:             .AutoSize      = .F.
1640:             .BackStyle     = 0
1641:             .SpecialEffect = 1
1642:             .Themes        = .F.
1643:             .Value         = THIS.this_oBusinessObject.this_nPeso
1644:             .Visible       = .T.
1645:             WITH .Buttons(1)
1646:                 .Caption   = "Sim"
1647:                 .Top       = 5
1648:                 .Left      = 5
1649:                 .Width     = 41
1650:                 .Height    = 15
1651:                 .BackStyle = 0
1652:                 .AutoSize  = .F.
1653:                 .FontName  = "Tahoma"
1654:                 .FontSize  = 8
1655:                 .ForeColor = RGB(90, 90, 90)
1656:             ENDWITH
1657:             WITH .Buttons(2)
1658:                 .Caption   = "N" + CHR(227) + "o"
1659:                 .Top       = 5
1660:                 .Left      = 70
1661:                 .Width     = 41
1662:                 .Height    = 15
1663:                 .BackStyle = 0
1664:                 .AutoSize  = .F.
1665:                 .FontName  = "Tahoma"
1666:                 .FontSize  = 8
1667:                 .ForeColor = RGB(90, 90, 90)
1668:             ENDWITH
1669:         ENDWITH
1670:         BINDEVENT(THIS.obj_4c_Opt_peso, "InteractiveChange", THIS, "OptPesoInteractiveChange")
1671: 
1672:         THIS.AddObject("lbl_4c_Label9", "Label")
1673:         WITH THIS.lbl_4c_Label9
1674:             .Top       = 540
1675:             .Left      = 565
1676:             .Width     = 32
1677:             .Height    = 15
1678:             .BackStyle = 0
1679:             .Alignment = 0
1680:             .FontName  = "Tahoma"
1681:             .FontSize  = 8
1682:             .ForeColor = RGB(90, 90, 90)
1683:             .Caption   = "Peso :"
1684:             .Visible   = .T.
1685:         ENDWITH
1686: 
1687:         *-- optCompos - imprime composicao na etiqueta
1688:         THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
1689:         WITH THIS.obj_4c_OptCompos
1690:             .Top           = 562
1691:             .Left          = 601
1692:             .Width         = 198
1693:             .Height        = 25
1694:             .ButtonCount   = 2
1695:             .AutoSize      = .F.
1696:             .BackStyle     = 0
1697:             .SpecialEffect = 1
1698:             .Themes        = .F.
1699:             .Value         = THIS.this_oBusinessObject.this_nComposicao
1700:             .Visible       = .T.
1701:             WITH .Buttons(1)
1702:                 .Caption   = "Sim"
1703:                 .Top       = 5
1704:                 .Left      = 5
1705:                 .Width     = 41
1706:                 .Height    = 15
1707:                 .BackStyle = 0
1708:                 .AutoSize  = .F.
1709:                 .FontName  = "Tahoma"
1710:                 .FontSize  = 8
1711:                 .ForeColor = RGB(90, 90, 90)
1712:             ENDWITH
1713:             WITH .Buttons(2)
1714:                 .Caption   = "N" + CHR(227) + "o"
1715:                 .Top       = 5
1716:                 .Left      = 70
1717:                 .Width     = 41
1718:                 .Height    = 15
1719:                 .BackStyle = 0
1720:                 .AutoSize  = .F.
1721:                 .FontName  = "Tahoma"
1722:                 .FontSize  = 8
1723:                 .ForeColor = RGB(90, 90, 90)
1724:             ENDWITH
1725:         ENDWITH
1726:         BINDEVENT(THIS.obj_4c_OptCompos, "InteractiveChange", THIS, "OptComposInteractiveChange")
1727: 
1728:         THIS.AddObject("lbl_4c_Label10", "Label")
1729:         WITH THIS.lbl_4c_Label10
1730:             .Top       = 567
1731:             .Left      = 531
1732:             .Width     = 66
1733:             .Height    = 15
1734:             .BackStyle = 0
1735:             .Alignment = 0
1736:             .FontName  = "Tahoma"
1737:             .FontSize  = 8
1738:             .ForeColor = RGB(90, 90, 90)
1739:             .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
1740:             .Visible   = .T.
1741:         ENDWITH
1742: 
1743:         *-- Get_Printer - impressora Windows destino (RowSource = crImpreV)
1744:         THIS.AddObject("cbo_4c_Get_Printer", "ComboBox")
1745:         WITH THIS.cbo_4c_Get_Printer
1746:             .Top            = 453
1747:             .Left           = 268
1748:             .Width          = 239
1749:             .Height         = 23
1750:             .Style          = 2
1751:             .SpecialEffect  = 1
1752:             .BoundColumn    = 1
1753:             .RowSourceType  = 2
1754:             .RowSource      = "crImpreV"
1755:             .FontName       = "Tahoma"
1756:             .FontSize       = 8
1757:             .Visible        = .T.
1758:         ENDWITH
1759:         IF RECCOUNT("crImpreV") > 0
1760:             THIS.cbo_4c_Get_Printer.ListIndex = 1
1761:             THIS.this_oBusinessObject.this_cImpressora = ALLTRIM(crImpreV.Impres)
1762:         ENDIF
1763:         BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", THIS, "GetPrinterInteractiveChange")
1764: 
1765:         THIS.AddObject("lbl_4c_Label12", "Label")
1766:         WITH THIS.lbl_4c_Label12
1767:             .Top       = 437
1768:             .Left      = 270
1769:             .Width     = 48
1770:             .Height    = 15
1771:             .BackStyle = 0
1772:             .Alignment = 0
1773:             .FontBold  = .T.
1774:             .FontName  = "Tahoma"
1775:             .FontSize  = 8
1776:             .ForeColor = RGB(90, 90, 90)
1777:             .Caption   = "Sistema"
1778:             .Visible   = .T.
1779:         ENDWITH
1780: 
1781:         THIS.AddObject("lbl_4c_Label13", "Label")
1782:         WITH THIS.lbl_4c_Label13
1783:             .Top       = 437
1784:             .Left      = 383
1785:             .Width     = 52
1786:             .Height    = 15
1787:             .BackStyle = 0
1788:             .Alignment = 0
1789:             .FontBold  = .T.
1790:             .FontName  = "Tahoma"
1791:             .FontSize  = 8
1792:             .ForeColor = RGB(90, 90, 90)
1793:             .Caption   = "Windows"
1794:             .Visible   = .T.
1795:         ENDWITH
1796: 
1797:         *-- opt_Preco - modalidade de preco impresso na etiqueta
1798:         THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
1799:         WITH THIS.obj_4c_Opt_Preco
1800:             .Top           = 439
1801:             .Left          = 601
1802:             .Width         = 198
1803:             .Height        = 95
1804:             .ButtonCount   = 6
1805:             .AutoSize      = .F.
1806:             .BackStyle     = 0
1807:             .SpecialEffect = 1
1808:             .Themes        = .F.
1809:             .Value         = THIS.this_oBusinessObject.this_nPreco
1810:             .Visible       = .T.
1811:             WITH .Buttons(1)
1812:                 .Caption   = "Sim"
1813:                 .Top       = 7
1814:                 .Left      = 8
1815:                 .Width     = 34
1816:                 .Height    = 15
1817:                 .BackStyle = 0
1818:                 .AutoSize  = .T.
1819:                 .FontName  = "Tahoma"
1820:                 .FontSize  = 8
1821:                 .ForeColor = RGB(90, 90, 90)
1822:             ENDWITH
1823:             WITH .Buttons(2)
1824:                 .Caption   = "N" + CHR(227) + "o"
1825:                 .Top       = 7
1826:                 .Left      = 61
1827:                 .Width     = 37
1828:                 .Height    = 15
1829:                 .BackStyle = 0
1830:                 .AutoSize  = .T.
1831:                 .FontName  = "Tahoma"
1832:                 .FontSize  = 8
1833:                 .ForeColor = RGB(90, 90, 90)
1834:             ENDWITH
1835:             WITH .Buttons(3)
1836:                 .Caption   = "Ideal"
1837:                 .Top       = 28
1838:                 .Left      = 8

*-- Linhas 1881 a 1936:
1881:                 .ForeColor = RGB(90, 90, 90)
1882:             ENDWITH
1883:         ENDWITH
1884:         BINDEVENT(THIS.obj_4c_Opt_Preco, "InteractiveChange", THIS, "OptPrecoInteractiveChange")
1885:     ENDPROC
1886: 
1887:     *==========================================================================
1888:     * PopularOpcoesTipoEtiqueta - Popula dinamicamente o obj_4c_Opt_Tipo a
1889:     * partir de SigCdTpe (tipos de etiqueta ativos), transcricao literal do
1890:     * bloco "With .Opt_Tipo" do Init legado (regra CLAUDE.md #17 - fluxo de
1891:     * negocio se transcreve, nao se reescreve). Sem tipos ativos, mantem o
1892:     * fallback estatico "Rabicho" ja criado por ConfigurarCamposImpressao().
1893:     * Precisa rodar ANTES de qualquer impressao: eh o .Tag de cada Buttons(N)
1894:     * que BtnProcessarImpressaoClick le para resolver o tipo de etiqueta (nTipos).
1895:     *==========================================================================
1896:     PROTECTED PROCEDURE PopularOpcoesTipoEtiqueta()
1897:         LOCAL loc_cAliasPam, loc_cAliasTipos, loc_nMaxPadrao, loc_nTotal, ;
1898:               loc_nI, loc_nTipoPadrao, loc_nHeight, loc_nTop
1899: 
1900:         loc_cAliasPam = "cursor_4c_Pam"
1901:         IF !USED(loc_cAliasPam)
1902:             THIS.this_oBusinessObject.CarregarParametrosEtiqueta(loc_cAliasPam)
1903:         ENDIF
1904: 
1905:         loc_nMaxPadrao = 7
1906:         IF USED(loc_cAliasPam)
1907:             SELECT (loc_cAliasPam)
1908:             GO TOP
1909:             loc_nMaxPadrao = MAX(TratarNulo(nMaxTpEtis, 0), 7)
1910:         ENDIF
1911: 
1912:         loc_cAliasTipos = "cursor_4c_TiposEtiqueta"
1913:         IF !THIS.this_oBusinessObject.BuscarTiposEtiquetaAtivos(loc_cAliasTipos)
1914:             THIS.this_nTotalTipos = 0
1915:             RETURN
1916:         ENDIF
1917: 
1918:         SELECT (loc_cAliasTipos)
1919:         loc_nTotal = RECCOUNT()
1920: 
1921:         *-- Legado: lnTipos alimenta o Enabled do botao Imprimir
1922:         *-- (.Imprime.Enabled = (lnTipos <> 0 And lnImp <> 0)) e o Enabled do
1923:         *-- proprio Opt_Tipo (.Enabled = (lnTipos > 1)) - ver HabilitarCampos.
1924:         THIS.this_nTotalTipos = loc_nTotal
1925: 
1926:         IF loc_nTotal = 0
1927:             USE IN (loc_cAliasTipos)
1928:             RETURN
1929:         ENDIF
1930: 
1931:         WITH THIS.obj_4c_Opt_Tipo
1932:             loc_nTipoPadrao = 1
1933:             .ButtonCount    = MIN(loc_nTotal, loc_nMaxPadrao)
1934:             loc_nHeight     = 15
1935:             loc_nTop        = 10
1936: 

*-- Linhas 1977 a 2020:
1977:     * selecionadas) e Sair (encerra o form). Transcricao literal das
1978:     * propriedades do SCX (Top/Left/Width/Height/Picture/Caption).
1979:     *==========================================================================
1980:     PROTECTED PROCEDURE ConfigurarBotaoRelatorio()
1981:         THIS.AddObject("obj_4c_BTNREPORT", "CommandGroup")
1982:         WITH THIS.obj_4c_BTNREPORT
1983:             .Top           = -2
1984:             .Left          = 676
1985:             .Width         = 161
1986:             .Height        = 85
1987:             .ButtonCount   = 2
1988:             .BackStyle     = 0
1989:             .SpecialEffect = 1
1990:             .Themes        = .F.
1991:             .Value         = 1
1992:             .Visible       = .T.
1993: 
1994:             WITH .Buttons(1)
1995:                 .Top             = 5
1996:                 .Left            = 5
1997:                 .Width           = 75
1998:                 .Height          = 75
1999:                 .FontBold        = .T.
2000:                 .FontItalic      = .T.
2001:                 .FontName        = "Comic Sans MS"
2002:                 .FontSize        = 8
2003:                 .WordWrap        = .T.
2004:                 .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2005:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2006:                 .Caption         = "\<Imprimir"
2007:                 .ForeColor       = RGB(90, 90, 90)
2008:                 .BackColor       = RGB(255, 255, 255)
2009:                 .Themes          = .F.
2010:             ENDWITH
2011: 
2012:             WITH .Buttons(2)
2013:                 .Top             = 5
2014:                 .Left            = 81
2015:                 .Width           = 75
2016:                 .Height          = 75
2017:                 .FontBold        = .T.
2018:                 .FontItalic      = .T.
2019:                 .FontName        = "Comic Sans MS"
2020:                 .FontSize        = 8

*-- Linhas 2027 a 2139:
2027:                 .Themes          = .F.
2028:             ENDWITH
2029:         ENDWITH
2030:         BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(1), "Click", THIS, "BtnProcessarImpressaoClick")
2031:         BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(2), "Click", THIS, "BtnSairClick")
2032:     ENDPROC
2033: 
2034:     *==========================================================================
2035:     * Handlers de sincronizacao BO <-> OptionGroup/Spinner/ComboBox das
2036:     * opcoes de impressao. PUBLIC: bindados via BINDEVENT (regra CLAUDE.md #3).
2037:     *==========================================================================
2038:     PROCEDURE OptTipoInteractiveChange()
2039:         THIS.this_oBusinessObject.this_nTipoEtiqueta = THIS.obj_4c_Opt_Tipo.Value
2040:     ENDPROC
2041: 
2042:     PROCEDURE OpcaoImpInteractiveChange()
2043:         THIS.this_oBusinessObject.this_nOpcaoImp = THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value
2044:     ENDPROC
2045: 
2046:     PROCEDURE SpnAjVertsInteractiveChange()
2047:         THIS.this_oBusinessObject.this_nAjVerts = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value
2048:     ENDPROC
2049: 
2050:     PROCEDURE SpnAjHorzsInteractiveChange()
2051:         THIS.this_oBusinessObject.this_nAjHorzs = THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value
2052:     ENDPROC
2053: 
2054:     PROCEDURE SpnAjDenssInteractiveChange()
2055:         THIS.this_oBusinessObject.this_nAjDenss = THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value
2056:     ENDPROC
2057: 
2058:     PROCEDURE SpnAjVelosInteractiveChange()
2059:         THIS.this_oBusinessObject.this_nAjVelos = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value
2060:     ENDPROC
2061: 
2062:     PROCEDURE OptSeparadorInteractiveChange()
2063:         THIS.this_oBusinessObject.this_nSeparador = THIS.obj_4c_Opt_separador.Value
2064:     ENDPROC
2065: 
2066:     PROCEDURE OptOrdemInteractiveChange()
2067:         THIS.this_oBusinessObject.this_nOrdem = THIS.obj_4c_OptOrdem.Value
2068:     ENDPROC
2069: 
2070:     PROCEDURE OptPesoInteractiveChange()
2071:         THIS.this_oBusinessObject.this_nPeso = THIS.obj_4c_Opt_peso.Value
2072:     ENDPROC
2073: 
2074:     PROCEDURE OptComposInteractiveChange()
2075:         THIS.this_oBusinessObject.this_nComposicao = THIS.obj_4c_OptCompos.Value
2076:     ENDPROC
2077: 
2078:     PROCEDURE OptPrecoInteractiveChange()
2079:         THIS.this_oBusinessObject.this_nPreco = THIS.obj_4c_Opt_Preco.Value
2080:     ENDPROC
2081: 
2082:     PROCEDURE GetPrinterInteractiveChange()
2083:         *-- Legado (Get_Printer.InteractiveChange): le a COLUNA do cursor de
2084:         *-- RowSource, nunca o texto exibido - a coluna 1 de crImpreV eh o par
2085:         *-- "sistema + windows" (IDupla), que nao eh nome de impressora.
2086:         THIS.this_oBusinessObject.this_cImpressora = THIS.ObterImpressoraSelecionada()
2087:     ENDPROC
2088: 
2089:     *==========================================================================
2090:     * TornarControlesVisiveis - Torna visiveis os controles de topo do form.
2091:     * Os filhos de cnt_4c_Sombra ja nascem Visible = .T. no proprio AddObject
2092:     * (ver ConfigurarPageFrame); este metodo cobre os demais controles de
2093:     * topo criados nas proximas fases direto sobre THIS.
2094:     * EXCECAO: obj_4c_Opt_Impressora fica de fora do loop - o legado
2095:     * declara Visible = .F. no SCX (impressora alternativa nao usada por
2096:     * default, InteractiveChange dela vem COMENTADO no proprio legado) e
2097:     * nao ha nenhum ponto do form que a torne visivel depois.
2098:     *==========================================================================
2099:     PROTECTED PROCEDURE TornarControlesVisiveis()
2100:         LOCAL loc_oCtrl
2101:         FOR EACH loc_oCtrl IN THIS.Controls
2102:             IF VARTYPE(loc_oCtrl) = "O"
2103:                 IF UPPER(loc_oCtrl.Name) == "OBJ_4C_OPT_IMPRESSORA"
2104:                     LOOP
2105:                 ENDIF
2106:                 loc_oCtrl.Visible = .T.
2107:             ENDIF
2108:         ENDFOR
2109:     ENDPROC
2110: 
2111:     *==========================================================================
2112:     * CarregarDados - Popula a grade de etiquetas com os itens de uma LISTA DE
2113:     * PRECOS (SigCdLpi). Transcricao do bloco de CARGA do Get_lpreco.Valid
2114:     * legado (a parte do picker de selecao da lista fica no handler de lookup
2115:     * da Fase 6, que chama este metodo passando o valor escolhido):
2116:     *   - confirma antes de refazer a selecao quando a grade ja tem etiqueta;
2117:     *   - ZAPa a grade e varre os itens da lista;
2118:     *   - para item com vigencia VENCIDA, troca preco/preco-de pelo preco
2119:     *     corrente do produto (SigCdPro).
2120:     * Regra CLAUDE.md #17: criterio/fluxo de negocio se TRANSCREVE, nao se
2121:     * reescreve.
2122:     * par_cListaPreco: lista a carregar. Ausente/vazio -> le o TextBox da tela
2123:     * (como o legado faz com This.Value) e, na falta dele, a property do BO.
2124:     * PUBLIC: chamado pelo handler de lookup do campo Lista de Precos e de fora
2125:     * da classe pelo harness de teste (regra CLAUDE.md #3).
2126:     *==========================================================================
2127:     FUNCTION CarregarDados(par_cListaPreco)
2128:         LOCAL loc_cCursor, loc_cLista, loc_cAliasItens, loc_cAliasProd, ;
2129:               loc_lRefazer, loc_nQtdSelecionadas, loc_lCarregaLista, ;
2130:               loc_nVal, loc_nValDe, loc_cCodProd, loc_cDescProd, ;
2131:               loc_cListaItem, loc_dVencIni, loc_dVencFim, ;
2132:               loc_lSucesso, loc_oErro
2133: 
2134:         loc_lSucesso = .F.
2135: 
2136:         TRY
2137:             loc_cCursor     = THIS.this_oBusinessObject.this_cCursorDados
2138:             loc_cAliasItens = "cursor_4c_ItensListaCarga"
2139:             loc_cAliasProd  = "cursor_4c_ProdutoVencidoCarga"

*-- Linhas 2243 a 2332:
2243:             THIS.this_cMensagemErro = loc_oErro.Message
2244:             MsgErro(loc_oErro.Message + CHR(13) + ;
2245:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2246:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar Etiquetas")
2247:         ENDTRY
2248: 
2249:         RETURN loc_lSucesso
2250:     ENDFUNC
2251: 
2252:     *==========================================================================
2253:     * BtnCarregarClick - Carrega para a grade de etiquetas os itens da
2254:     * movimentacao informada (Empresa+Operacao+Codigo -> chave posicional
2255:     * EmpDopNums), aplicando a lista de precos quando configurado.
2256:     * Transcricao literal do btnCarregar.Click do legado (regra CLAUDE.md
2257:     * #17 - formula/fluxo de negocio nunca se reescreve).
2258:     * PUBLIC: chamado via BINDEVENT (regra CLAUDE.md #3).
2259:     *==========================================================================
2260:     PROCEDURE BtnCarregarClick()
2261:         LOCAL loc_cCursor, loc_cEmpDopNums, loc_cAliasItens, loc_lRefazer, ;
2262:               loc_nQtdSelecionadas, loc_cCodItem, loc_cDescItem, loc_nQtdItem, ;
2263:               loc_nCitemItem, loc_nVenda, loc_nPrecoDeVal, loc_nPeso, ;
2264:               loc_cCodScan, loc_nValLista, loc_nValDeLista
2265: 
2266:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2267: 
2268:         IF EMPTY(THIS.txt_4c_Emps.Value)
2269:             MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!!!", "Dados Incompletos")
2270:             THIS.txt_4c_Emps.SetFocus()
2271:             RETURN
2272:         ENDIF
2273: 
2274:         IF EMPTY(THIS.txt_4c_Dopes.Value)
2275:             MsgAviso("A Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Foi Informada!!!", "Dados Incompletos")
2276:             THIS.txt_4c_Dopes.SetFocus()
2277:             RETURN
2278:         ENDIF
2279: 
2280:         IF EMPTY(THIS.txt_4c_Numes.Value)
2281:             MsgAviso("O C" + CHR(243) + "digo N" + CHR(227) + "o Foi Informado!!!", "Dados Incompletos")
2282:             THIS.txt_4c_Numes.SetFocus()
2283:             RETURN
2284:         ENDIF
2285: 
2286:         loc_cEmpDopNums = PADR(ALLTRIM(THIS.txt_4c_Emps.Value), 3) + ;
2287:                            PADR(ALLTRIM(THIS.txt_4c_Dopes.Value), 20) + ;
2288:                            STR(THIS.txt_4c_Numes.Value, 6)
2289: 
2290:         loc_cAliasItens = "cursor_4c_ItensMovimentoCarga"
2291:         IF !THIS.this_oBusinessObject.BuscarItensMovimento(loc_cEmpDopNums, loc_cAliasItens)
2292:             MsgAviso("A Opera" + CHR(231) + CHR(227) + "o Informada N" + CHR(227) + "o Possui Itens a Serem Carregados!!!", "Dados Incorretos")
2293:             THIS.txt_4c_Emps.SetFocus()
2294:             RETURN
2295:         ENDIF
2296: 
2297:         loc_lRefazer = .T.
2298:         IF USED(loc_cCursor)
2299:             SELECT (loc_cCursor)
2300:             COUNT TO loc_nQtdSelecionadas FOR !EMPTY(Cpros)
2301:             IF loc_nQtdSelecionadas > 0
2302:                 loc_lRefazer = MsgConfirma("Existem Etiquetas na Grade! Deseja Refazer a Sele" + CHR(231) + CHR(227) + "o?", "Aten" + CHR(231) + CHR(227) + "o!!!")
2303:             ENDIF
2304:         ENDIF
2305: 
2306:         IF loc_lRefazer
2307:             IF USED(loc_cCursor)
2308:                 SELECT (loc_cCursor)
2309:                 ZAP
2310:             ENDIF
2311: 
2312:             IF THIS.chk_4c_ChkOperacoes.Value = 1 AND USED(loc_cAliasItens)
2313:                 SELECT (loc_cAliasItens)
2314:                 SCAN
2315:                     loc_cCodItem    = TratarNulo(CPros, "")
2316:                     loc_cDescItem   = TratarNulo(DPros, "")
2317:                     loc_nQtdItem    = TratarNulo(Qtds, 0)
2318:                     loc_nCitemItem  = TratarNulo(Citens, 0)
2319: 
2320:                     loc_nVenda      = 0
2321:                     loc_nPrecoDeVal = 0
2322:                     loc_nPeso       = 0
2323: 
2324:                     IF !EMPTY(loc_cCodItem) AND THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cCodItem), "cursor_4c_ProdutoCarga")
2325:                         SELECT cursor_4c_ProdutoCarga
2326:                         IF NVL(PVens, 0) > 0
2327:                             loc_nVenda = PVens
2328:                         ENDIF
2329:                         IF NVL(PrecoDe, 0) > 0
2330:                             loc_nPrecoDeVal = PrecoDe
2331:                         ENDIF
2332:                         IF NVL(PesoMs, 0) > 0

*-- Linhas 2389 a 2460:
2389:     *==========================================================================
2390:     * BtnExcluirItemClick - Remove o item corrente da grade de etiquetas.
2391:     * Transcricao literal do btnexcluir.Click do legado.
2392:     * PUBLIC: chamado via BINDEVENT (regra CLAUDE.md #3).
2393:     *==========================================================================
2394:     PROCEDURE BtnExcluirItemClick()
2395:         LOCAL loc_cCursor
2396:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2397: 
2398:         IF USED(loc_cCursor)
2399:             SELECT (loc_cCursor)
2400:             DELETE
2401:             *-- Legado: Locate For .f. tira o ponteiro da linha excluida sem
2402:             *-- depender de SET DELETED.
2403:             LOCATE FOR .F.
2404: 
2405:             *-- Linha em branco obrigatoria + Go Top + Refresh (CLAUDE.md #21a)
2406:             THIS.CarregarLista()
2407:         ENDIF
2408:     ENDPROC
2409: 
2410:     *==========================================================================
2411:     * BtnProcessarImpressaoClick - Botao principal do form (BTNREPORT.Imprime no legado):
2412:     * confirma, remove itens sem quantidade apurada, reordena a grade (por
2413:     * Codigo ou por ordem de digitacao) e dispara a impressao fisica das
2414:     * etiquetas. Transcricao literal do fluxo do legado (regra CLAUDE.md #17)
2415:     * - inclusive o SINAL/ordem das validacoes e o criterio de reordenacao
2416:     * via cursor auxiliar (Scatter/Insert), que o legado usa para fisicamente
2417:     * fixar a sequencia de impressao antes de varrer a grade.
2418:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
2419:     *==========================================================================
2420:     PROCEDURE BtnProcessarImpressaoClick()
2421:         LOCAL loc_cCursor, loc_nImpPreco, loc_lImpSepar, loc_lImpPeso, loc_lCompo, ;
2422:               loc_nTipoSel, loc_nTpEti, loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, ;
2423:               loc_nAjDenss, loc_nAjVelos, loc_cNomeImpressora, loc_cLp1, loc_cLp2, ;
2424:               loc_cBop, loc_cAliasOpe, loc_cAliasOrdenado
2425: 
2426:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2427:         IF !USED(loc_cCursor)
2428:             RETURN
2429:         ENDIF
2430: 
2431:         *-- Recolhe a tela inteira para o BO de uma vez so (equivale ao bloco
2432:         *-- de leitura de controles que abre o BTNREPORT.Click legado) e le
2433:         *-- dali - assim a impressao e a auditoria enxergam exatamente os
2434:         *-- mesmos valores.
2435:         IF !THIS.FormParaBO()
2436:             RETURN
2437:         ENDIF
2438: 
2439:         loc_nImpPreco = THIS.this_oBusinessObject.this_nPreco
2440:         loc_lImpSepar = (THIS.this_oBusinessObject.this_nSeparador = 1)
2441:         loc_lImpPeso  = (THIS.this_oBusinessObject.this_nPeso = 1)
2442:         loc_lCompo    = (THIS.this_oBusinessObject.this_nComposicao = 1)
2443: 
2444:         *-- O TIPO de etiqueta que vai para a impressora nao eh o indice do
2445:         *-- botao: eh o codigo em .Tag (SigCdTpe.nTipos) do botao selecionado.
2446:         loc_nTipoSel = THIS.this_oBusinessObject.this_nTipoEtiqueta
2447:         loc_nTpEti   = INT(VAL(TratarNulo(THIS.obj_4c_Opt_Tipo.Buttons(loc_nTipoSel).Tag, "0")))
2448: 
2449:         loc_nTpImp   = THIS.this_oBusinessObject.this_nOpcaoImp
2450:         loc_nAjVerts = THIS.this_oBusinessObject.this_nAjVerts
2451:         loc_nAjHorzs = THIS.this_oBusinessObject.this_nAjHorzs
2452:         loc_nAjDenss = THIS.this_oBusinessObject.this_nAjDenss
2453:         loc_nAjVelos = THIS.this_oBusinessObject.this_nAjVelos
2454: 
2455:         *-- Legado: nome da impressora vem da linha corrente de crImpreV
2456:         *-- (crImpreV.impres), nao do texto exibido no ComboBox.
2457:         loc_cNomeImpressora = THIS.this_oBusinessObject.this_cImpressora
2458: 
2459:         loc_cLp1 = THIS.this_oBusinessObject.this_cLPreco
2460:         loc_cLp2 = THIS.this_oBusinessObject.this_cLPreco2

*-- Linhas 2547 a 2749:
2547: 
2548:     *==========================================================================
2549:     * BtnSairClick - Encerra o form (BTNREPORT.Sair no legado: ThisForm.
2550:     * Release). PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
2551:     *==========================================================================
2552:     PROCEDURE BtnSairClick()
2553:         THIS.Release()
2554:     ENDPROC
2555: 
2556:     *==========================================================================
2557:     * CarregarParametrosPadrao - Le SigCdPam (parametros gerais de etiqueta) e
2558:     * SigCdPac (ajustes de impressao) e guarda os valores nas properties do BO.
2559:     * Transcricao do bloco "With Thisform.Cnt_Impressora" do Init legado, que
2560:     * alimenta os spinners/opcoes a partir desses dois cursores:
2561:     *   Opcao_Imp.Value = Iif(crSigCdPam.ImpEtis <> 0, crSigCdPam.ImpEtis, 1)
2562:     *   Spn_AjVerts     = crSigCdPam.AjVerts
2563:     *   Spn_AjHorzs     = crSigCdPam.AjHorzs
2564:     *   spn_AjDenss     = Iif(Empty(crSigCdPac.AjDens),  20, crSigCdPac.AjDens)
2565:     *   spn_AjVelos     = Iif(Empty(crSigCdPac.AjVelos), 01, crSigCdPac.AjVelos)
2566:     *   opt_separador   = crSigCdPac.EtqSeps
2567:     * Sem banco disponivel (modo de teste/validacao de UI) as properties ficam
2568:     * com o default declarado no BO - a tela abre igual, so sem os parametros.
2569:     *==========================================================================
2570:     PROTECTED PROCEDURE CarregarParametrosPadrao()
2571:         LOCAL loc_oBO, loc_cAliasPam, loc_cAliasPac, loc_nImpEtis, loc_nSep, loc_oErro
2572: 
2573:         loc_oBO       = THIS.this_oBusinessObject
2574:         loc_cAliasPam = "cursor_4c_Pam"
2575:         loc_cAliasPac = "cursor_4c_Pac"
2576: 
2577:         TRY
2578:             IF !USED(loc_cAliasPam)
2579:                 loc_oBO.CarregarParametrosEtiqueta(loc_cAliasPam)
2580:             ENDIF
2581: 
2582:             IF USED(loc_cAliasPam) AND RECCOUNT(loc_cAliasPam) > 0
2583:                 SELECT (loc_cAliasPam)
2584:                 GO TOP
2585: 
2586:                 *-- Legado: Iif(crSigCdPam.ImpEtis <> 0, crSigCdPam.ImpEtis, 1)
2587:                 loc_nImpEtis = TratarNulo(ImpEtis, 0)
2588:                 loc_oBO.this_nOpcaoImp = IIF(loc_nImpEtis <> 0, loc_nImpEtis, 1)
2589: 
2590:                 loc_oBO.this_nAjVerts = TratarNulo(AjVerts, 0)
2591:                 loc_oBO.this_nAjHorzs = TratarNulo(AjHorzs, 0)
2592:             ENDIF
2593: 
2594:             IF !USED(loc_cAliasPac)
2595:                 loc_oBO.CarregarParametrosImpressao(loc_cAliasPac)
2596:             ENDIF
2597: 
2598:             IF USED(loc_cAliasPac) AND RECCOUNT(loc_cAliasPac) > 0
2599:                 SELECT (loc_cAliasPac)
2600:                 GO TOP
2601: 
2602:                 *-- Legado: Iif(Empty(<col>), <default>, <col>)
2603:                 loc_oBO.this_nAjDenss = IIF(EMPTY(TratarNulo(AjDens, 0)), 20, TratarNulo(AjDens, 0))
2604:                 loc_oBO.this_nAjVelos = IIF(EMPTY(TratarNulo(AjVelos, 0)), 1, TratarNulo(AjVelos, 0))
2605: 
2606:                 *-- opt_separador tem 2 botoes: valor fora da faixa derruba o
2607:                 *-- OptionGroup, entao so aplica o parametro quando ele eh um
2608:                 *-- indice valido (o legado atribui cru porque o SCX dele nasce
2609:                 *-- com a mesma quantidade de botoes).
2610:                 loc_nSep = TratarNulo(EtqSeps, 0)
2611:                 IF BETWEEN(loc_nSep, 1, THIS.obj_4c_Opt_separador.ButtonCount)
2612:                     loc_oBO.this_nSeparador = loc_nSep
2613:                 ENDIF
2614:             ENDIF
2615: 
2616:         CATCH TO loc_oErro
2617:             THIS.this_cMensagemErro = loc_oErro.Message
2618:             MsgErro(loc_oErro.Message + CHR(13) + ;
2619:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2620:                     "Procedure: " + loc_oErro.Procedure, ;
2621:                     "Erro ao Carregar Par" + CHR(226) + "metros de Etiqueta")
2622:         ENDTRY
2623:     ENDPROC
2624: 
2625:     *==========================================================================
2626:     * BOParaForm - Espelha as properties do BO nos controles da tela. Alem do
2627:     * espelhamento, dispara CarregarParametrosPadrao() para que os defaults de
2628:     * SigCdPam/SigCdPac cheguem aos controles ANTES de o usuario ver a tela -
2629:     * eh esse bloco do Init legado que define ajuste vertical/horizontal,
2630:     * densidade, velocidade, impressora especial e separadora.
2631:     * PROTECTED: FormBase declara o hook como PROTECTED e VFP9 nao permite a
2632:     * subclasse ALARGAR o escopo - omitir o modificador nao tornaria publico.
2633:     *==========================================================================
2634:     PROTECTED PROCEDURE BOParaForm()
2635:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
2636: 
2637:         loc_lSucesso = .F.
2638:         loc_oBO      = THIS.this_oBusinessObject
2639: 
2640:         TRY
2641:             THIS.CarregarParametrosPadrao()
2642: 
2643:             *-- Bloco Lista de Precos
2644:             THIS.txt_4c_Lpreco.Value       = loc_oBO.this_cLPreco
2645:             THIS.txt_4c_LPreco2.Value      = loc_oBO.this_cLPreco2
2646:             THIS.chk_4c_ChkLista.Value     = IIF(loc_oBO.this_lCarregaItensLista, 1, 0)
2647:             THIS.chk_4c_ChkOperacoes.Value = IIF(loc_oBO.this_lCarregaItensOperacao, 1, 0)
2648: 
2649:             *-- Bloco Movimentacao. txt_4c_Numes eh NUMERICO (o legado o usa em
2650:             *-- Str(...,6) para montar a chave EmpDopNums), entao a property
2651:             *-- character do BO volta pelo VAL - nunca por atribuicao direta.
2652:             THIS.txt_4c_Emps.Value  = loc_oBO.this_cEmps
2653:             THIS.txt_4c_Dopes.Value = loc_oBO.this_cDopes
2654:             THIS.txt_4c_Numes.Value = VAL(loc_oBO.this_cNumes)
2655: 
2656:             *-- Opcoes de impressao (OptionGroup.Value eh SEMPRE o INDICE do
2657:             *-- botao: valor fora de 1..ButtonCount derruba o controle).
2658:             THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_Tipo,        loc_oBO.this_nTipoEtiqueta)
2659:             THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_Impressora,  loc_oBO.this_nTipoImpressora)
2660:             THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_separador,   loc_oBO.this_nSeparador)
2661:             THIS.AplicarValorOptionGroup(THIS.obj_4c_OptOrdem,        loc_oBO.this_nOrdem)
2662:             THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_peso,        loc_oBO.this_nPeso)
2663:             THIS.AplicarValorOptionGroup(THIS.obj_4c_OptCompos,       loc_oBO.this_nComposicao)
2664:             THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_Preco,       loc_oBO.this_nPreco)
2665:             THIS.AplicarValorOptionGroup(THIS.cnt_4c__Impressora.obj_4c_Opcao_imp, loc_oBO.this_nOpcaoImp)
2666: 
2667:             *-- Ajustes finos da impressora de etiqueta
2668:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value = loc_oBO.this_nAjVerts
2669:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value = loc_oBO.this_nAjHorzs
2670:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value = loc_oBO.this_nAjDenss
2671:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value = loc_oBO.this_nAjVelos
2672: 
2673:             loc_lSucesso = .T.
2674: 
2675:         CATCH TO loc_oErro
2676:             THIS.this_cMensagemErro = loc_oErro.Message
2677:             MsgErro(loc_oErro.Message + CHR(13) + ;
2678:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2679:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Exibir Par" + CHR(226) + "metros")
2680:         ENDTRY
2681: 
2682:         RETURN loc_lSucesso
2683:     ENDPROC
2684: 
2685:     *==========================================================================
2686:     * AplicarValorOptionGroup - Atribui o indice a um OptionGroup so quando ele
2687:     * cabe em 1..ButtonCount. OptionGroup.Value eh SEMPRE numerico e indice de
2688:     * botao; valor fora da faixa (tipico de parametro do banco gravado com 0 ou
2689:     * com mais opcoes do que a tela tem) estoura em runtime.
2690:     *==========================================================================
2691:     PROTECTED PROCEDURE AplicarValorOptionGroup(par_oGrupo, par_nValor)
2692:         IF VARTYPE(par_oGrupo) != "O" OR VARTYPE(par_nValor) != "N"
2693:             RETURN
2694:         ENDIF
2695: 
2696:         IF BETWEEN(par_nValor, 1, par_oGrupo.ButtonCount)
2697:             par_oGrupo.Value = par_nValor
2698:         ENDIF
2699:     ENDPROC
2700: 
2701:     *==========================================================================
2702:     * FormParaBO - Recolhe os valores da tela para as properties do BO. Espelha
2703:     * exatamente o bloco de leitura de controles do BTNREPORT.Click legado
2704:     * (Opt_Preco/Opt_Separador/Opt_Peso/optCompos/Opt_Tipo/Cnt_Impressora/
2705:     * get_Printer/get_lpreco/getLPreco2), acrescido dos campos de movimentacao
2706:     * e da chave posicional EmpDopNums.
2707:     * PROTECTED pelo mesmo motivo de BOParaForm (hook declarado em FormBase).
2708:     *==========================================================================
2709:     PROTECTED PROCEDURE FormParaBO()
2710:         LOCAL loc_oBO, loc_lSucesso, loc_oErro, loc_nTipoSel
2711: 
2712:         loc_lSucesso = .F.
2713:         loc_oBO      = THIS.this_oBusinessObject
2714: 
2715:         TRY
2716:             *-- Listas de preco e flags de carga
2717:             loc_oBO.this_cLPreco  = ALLTRIM(THIS.txt_4c_Lpreco.Value)
2718:             loc_oBO.this_cLPreco2 = ALLTRIM(THIS.txt_4c_LPreco2.Value)
2719:             loc_oBO.this_lCarregaItensLista    = (THIS.chk_4c_ChkLista.Value = 1)
2720:             loc_oBO.this_lCarregaItensOperacao = (THIS.chk_4c_ChkOperacoes.Value = 1)
2721: 
2722:             *-- Movimentacao. TRANSFORM porque txt_4c_Numes eh numerico e
2723:             *-- ALLTRIM sobre numerico dispara erro 11 em runtime.
2724:             loc_oBO.this_cEmps  = ALLTRIM(THIS.txt_4c_Emps.Value)
2725:             loc_oBO.this_cDopes = ALLTRIM(THIS.txt_4c_Dopes.Value)
2726:             loc_oBO.this_cNumes = ALLTRIM(TRANSFORM(THIS.txt_4c_Numes.Value))
2727: 
2728:             *-- Chave POSICIONAL Emps(3) + Dopes(20) + Str(Numes,6) = char(29).
2729:             *-- PADR explicito: ALLTRIM nas PARTES encurta a chave e a consulta
2730:             *-- devolve zero linha em silencio (regra CLAUDE.md #42).
2731:             IF EMPTY(loc_oBO.this_cEmps) AND EMPTY(loc_oBO.this_cDopes)
2732:                 loc_oBO.this_cEmpDopNums = ""
2733:             ELSE
2734:                 loc_oBO.this_cEmpDopNums = PADR(loc_oBO.this_cEmps, 3) + ;
2735:                                            PADR(loc_oBO.this_cDopes, 20) + ;
2736:                                            STR(THIS.txt_4c_Numes.Value, 6)
2737:             ENDIF
2738: 
2739:             *-- Opcoes de impressao (indice do botao selecionado)
2740:             loc_oBO.this_nPreco          = THIS.obj_4c_Opt_Preco.Value
2741:             loc_oBO.this_nSeparador      = THIS.obj_4c_Opt_separador.Value
2742:             loc_oBO.this_nPeso           = THIS.obj_4c_Opt_peso.Value
2743:             loc_oBO.this_nComposicao     = THIS.obj_4c_OptCompos.Value
2744:             loc_oBO.this_nOrdem          = THIS.obj_4c_OptOrdem.Value
2745:             loc_oBO.this_nTipoEtiqueta   = THIS.obj_4c_Opt_Tipo.Value
2746:             loc_oBO.this_nTipoImpressora = THIS.obj_4c_Opt_Impressora.Value
2747: 
2748:             *-- Cnt_Impressora
2749:             loc_oBO.this_nOpcaoImp = THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value

*-- Linhas 2763 a 2871:
2763:             THIS.this_cMensagemErro = loc_oErro.Message
2764:             MsgErro(loc_oErro.Message + CHR(13) + ;
2765:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2766:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Ler os Dados da Tela")
2767:         ENDTRY
2768: 
2769:         RETURN loc_lSucesso
2770:     ENDPROC
2771: 
2772:     *==========================================================================
2773:     * ObterImpressoraSelecionada - Nome Windows da impressora escolhida no
2774:     * ComboBox (legado: "lcNomeImp = crImpreV.impres", lido da LINHA CORRENTE
2775:     * do cursor de RowSource, nao do texto do controle).
2776:     *==========================================================================
2777:     PROTECTED FUNCTION ObterImpressoraSelecionada()
2778:         LOCAL loc_cNome
2779: 
2780:         loc_cNome = ""
2781:         IF USED("crImpreV") AND RECCOUNT("crImpreV") > 0
2782:             SELECT crImpreV
2783:             IF BETWEEN(THIS.cbo_4c_Get_Printer.ListIndex, 1, RECCOUNT("crImpreV"))
2784:                 GO (THIS.cbo_4c_Get_Printer.ListIndex)
2785:             ENDIF
2786:             loc_cNome = ALLTRIM(TratarNulo(crImpreV.Impres, ""))
2787:         ENDIF
2788: 
2789:         RETURN loc_cNome
2790:     ENDFUNC
2791: 
2792:     *==========================================================================
2793:     * AplicarAcessosUsuario - Le as permissoes do usuario logado para os
2794:     * ajustes finos da impressora e para o tipo de etiqueta. Transcricao das
2795:     * seis chamadas fChecaAcesso do Init legado:
2796:     *   .spn_AjVerts.Enabled = fChecaAcesso([SigPrEtq], [VERTICAL])   (e irmas)
2797:     *   .opt_Tipo.Enabled    = fChecaAcesso([SigPrEtq], [TIPO])
2798:     * fChecaAcesso mora no framework legado (Framework\sigacess.PRG, carregado
2799:     * por config.prg) e abre conexao propria: TRY aninhado garante que a tela
2800:     * ainda abra num ambiente sem banco, assumindo o default permissivo das
2801:     * properties (mesmo padrao de SIGREADSBO.Init).
2802:     *==========================================================================
2803:     PROTECTED PROCEDURE AplicarAcessosUsuario()
2804:         LOCAL loc_oErroAcesso
2805: 
2806:         TRY
2807:             THIS.this_lAcVertical   = fChecaAcesso("SigPrEtq", "VERTICAL")
2808:             THIS.this_lAcHorizontal = fChecaAcesso("SigPrEtq", "HORIZONTAL")
2809:             THIS.this_lAcDensidade  = fChecaAcesso("SigPrEtq", "DENSIDADE")
2810:             THIS.this_lAcVelocidade = fChecaAcesso("SigPrEtq", "VELOCIDADE")
2811:             THIS.this_lAcTipo       = fChecaAcesso("SigPrEtq", "TIPO")
2812:         CATCH TO loc_oErroAcesso
2813:             MsgErro(loc_oErroAcesso.Message, "fChecaAcesso")
2814:         ENDTRY
2815:     ENDPROC
2816: 
2817:     *==========================================================================
2818:     * HabilitarCampos - Liga/desliga a superficie de captura da tela. Este form
2819:     * OPERACIONAL nao tem modo INCLUIR/ALTERAR (o legado nao tem Page2 nem
2820:     * botao de Salvar/Cancelar): o parametro serve para TRANCAR a tela durante
2821:     * a impressao, que eh demorada, e destrancar no fim.
2822:     * O teto de permissao do usuario (AplicarAcessosUsuario) e a disponibilidade
2823:     * de tipos/impressoras sao respeitados SEMPRE - par_lHabilitar = .T. nunca
2824:     * libera o que o legado mantem bloqueado:
2825:     *   BtnReport.Imprime.Enabled = (lnTipos <> 0 And lnImp <> 0)
2826:     *   BtnReport.Value           = Iif(.Imprime.Enabled, 1, 2)
2827:     * NUNCA mexer em THIS.Enabled: o form eh modal (WindowType = 1) sem
2828:     * TitleBar, e desabilitar o form inteiro deixaria o usuario sem saida.
2829:     * PUBLIC: chamado de fora da classe pelo harness de teste (CLAUDE.md #3).
2830:     *==========================================================================
2831:     PROCEDURE HabilitarCampos(par_lHabilitar)
2832:         LOCAL loc_lLiga, loc_lTemImpressao
2833: 
2834:         loc_lLiga = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2835: 
2836:         *-- Captura de lista de precos e de movimentacao
2837:         THIS.txt_4c_Lpreco.Enabled       = loc_lLiga
2838:         THIS.txt_4c_LPreco2.Enabled      = loc_lLiga
2839:         THIS.chk_4c_ChkLista.Enabled     = loc_lLiga
2840:         THIS.chk_4c_ChkOperacoes.Enabled = loc_lLiga
2841:         THIS.txt_4c_Emps.Enabled         = loc_lLiga
2842:         THIS.txt_4c_Dopes.Enabled        = loc_lLiga
2843:         THIS.txt_4c_Numes.Enabled        = loc_lLiga
2844:         THIS.cmd_4c_BtnCarregar.Enabled  = loc_lLiga
2845: 
2846:         *-- Grade de etiquetas e exclusao de item
2847:         THIS.grd_4c_Dados.Enabled        = loc_lLiga
2848:         THIS.cmd_4c_Btnexcluir.Enabled   = loc_lLiga
2849: 
2850:         *-- Opcoes de impressao
2851:         THIS.obj_4c_Opt_separador.Enabled = loc_lLiga
2852:         THIS.obj_4c_OptOrdem.Enabled      = loc_lLiga
2853:         THIS.obj_4c_Opt_peso.Enabled      = loc_lLiga
2854:         THIS.obj_4c_OptCompos.Enabled     = loc_lLiga
2855:         THIS.obj_4c_Opt_Preco.Enabled     = loc_lLiga
2856:         THIS.cbo_4c_Get_Printer.Enabled   = loc_lLiga
2857:         THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Enabled = loc_lLiga
2858: 
2859:         *-- Legado: o tipo de etiqueta so fica ativo com mais de uma opcao
2860:         *-- (.Enabled = (lnTipos > 1) em PopularOpcoesTipoEtiqueta) e ainda
2861:         *-- depende da permissao TIPO.
2862:         THIS.obj_4c_Opt_Tipo.Enabled = (loc_lLiga AND THIS.this_lAcTipo AND THIS.this_nTotalTipos > 1)
2863: 
2864:         *-- Ajustes finos: permissao por parametro (fChecaAcesso)
2865:         THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Enabled = (loc_lLiga AND THIS.this_lAcVertical)
2866:         THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Enabled = (loc_lLiga AND THIS.this_lAcHorizontal)
2867:         THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Enabled = (loc_lLiga AND THIS.this_lAcDensidade)
2868:         THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Enabled = (loc_lLiga AND THIS.this_lAcVelocidade)
2869: 
2870:         *-- Botao Imprimir: so com tipo de etiqueta E impressora disponiveis.
2871:         loc_lTemImpressao = (THIS.this_nTotalTipos <> 0 AND THIS.this_nTotalImpressoras <> 0)

*-- Linhas 2887 a 3002:
2887:     * redigitar (regra CLAUDE.md #17 - criterio do legado se transcreve).
2888:     * PROTECTED pelo mesmo motivo de FormParaBO/BOParaForm (hook de FormBase).
2889:     *==========================================================================
2890:     PROTECTED PROCEDURE LimparCampos()
2891:         LOCAL loc_cCursor
2892: 
2893:         THIS.txt_4c_Lpreco.Value = ""
2894:         THIS.this_oBusinessObject.this_cLPreco = ""
2895: 
2896:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2897:         IF USED(loc_cCursor)
2898:             SELECT (loc_cCursor)
2899:             ZAP
2900:         ENDIF
2901: 
2902:         THIS.CarregarLista()
2903:     ENDPROC
2904: 
2905:     *==========================================================================
2906:     * CarregarLista - Fecha CADA caminho que popula a grade de etiquetas:
2907:     * garante a linha em branco que o legado sempre mantem em dbImpressao,
2908:     * reposiciona no topo e repinta o Grid.
2909:     * Popular o cursor NAO repinta a grade sozinho (regra CLAUDE.md #21a): o
2910:     * legado encerra cada carga com "Go Top In dbImpressao" + "Grade.Refresh",
2911:     * e esse par vive aqui para nao ser esquecido em nenhum dos quatro
2912:     * caminhos que mexem no cursor (carga por lista de precos, carga por
2913:     * movimentacao, exclusao de item e reset pos-impressao).
2914:     * PUBLIC: chamado de fora da classe pelo harness de teste (CLAUDE.md #3).
2915:     *==========================================================================
2916:     PROCEDURE CarregarLista()
2917:         LOCAL loc_cCursor, loc_lSucesso
2918: 
2919:         loc_lSucesso = .F.
2920:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorDados
2921: 
2922:         IF USED(loc_cCursor)
2923:             SELECT (loc_cCursor)
2924: 
2925:             *-- Legado: "Go Top In dbImpressao / If Eof() / Append Blank".
2926:             *-- O teste eh EOF() DEPOIS do GO TOP, nao RECCOUNT(): RECCOUNT
2927:             *-- conta tambem os registros marcados para exclusao, entao logo
2928:             *-- apos um DELETE a grade pode ficar sem NENHUMA linha visivel
2929:             *-- com RECCOUNT ainda positivo - e sem linha o Grid nao aceita
2930:             *-- digitacao no campo Produto.
2931:             GO TOP
2932:             IF EOF()
2933:                 APPEND BLANK
2934:                 GO TOP
2935:             ENDIF
2936: 
2937:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2938:                 THIS.grd_4c_Dados.Refresh()
2939:             ENDIF
2940: 
2941:             loc_lSucesso = .T.
2942:         ENDIF
2943: 
2944:         RETURN loc_lSucesso
2945:     ENDPROC
2946: 
2947:     *==========================================================================
2948:     * Activate - Legado: o Init termina com
2949:     * ".Grd_Etiqueta.Col_cpros.SetFocus", deixando o cursor do teclado no
2950:     * campo Produto da grade. SetFocus so vale com a tela ja visivel, por isso
2951:     * roda no Activate e uma unica vez (this_lFocoAplicado), para nao roubar o
2952:     * foco toda vez que a tela volta ao topo depois de um dialogo.
2953:     *==========================================================================
2954:     PROCEDURE Activate()
2955:         DODEFAULT()
2956: 
2957:         IF !THIS.this_lFocoAplicado
2958:             THIS.this_lFocoAplicado = .T.
2959: 
2960:             *-- Guarda em vez de TRY/CATCH: SetFocus em controle invisivel ou
2961:             *-- desabilitado eh erro de runtime, e aqui as tres condicoes sao
2962:             *-- verificaveis de antemao. Com a grade posicionada no topo
2963:             *-- (CarregarLista) o foco cai na coluna 1, que eh o campo Produto
2964:             *-- (col_cpros do legado).
2965:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2966:                 IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
2967:                     THIS.grd_4c_Dados.SetFocus()
2968:                 ENDIF
2969:             ENDIF
2970:         ENDIF
2971:     ENDPROC
2972: 
2973:     *==========================================================================
2974:     * Destroy - Libera cursores locais antes de encerrar o form
2975:     *==========================================================================
2976:     PROCEDURE Destroy()
2977:         IF USED("cursor_4c_Dados")
2978:             USE IN cursor_4c_Dados
2979:         ENDIF
2980:         IF USED("crImpreV")
2981:             USE IN crImpreV
2982:         ENDIF
2983:         IF USED("cursor_4c_Pam")
2984:             USE IN cursor_4c_Pam
2985:         ENDIF
2986:         IF USED("cursor_4c_Pac")
2987:             USE IN cursor_4c_Pac
2988:         ENDIF
2989:         IF USED("crImpre")
2990:             USE IN crImpre
2991:         ENDIF
2992:         IF USED("crSigCdmp")
2993:             USE IN crSigCdmp
2994:         ENDIF
2995:         IF USED("cursor_4c_ImpPar")
2996:             USE IN cursor_4c_ImpPar
2997:         ENDIF
2998: 
2999:         DODEFAULT()
3000:     ENDPROC
3001: 
3002: ENDDEFINE


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

