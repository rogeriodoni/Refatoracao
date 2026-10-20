# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.ObterResultadoSaida()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPBIN.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (498 linhas total):

*-- Linhas 1 a 90:
1: *==============================================================================
2: * FormSIGOPBIN.prg - Validacao de BIN do cartao para liberacao de pagamento
3: * Form OPERACIONAL FLAT (sem PageFrame) - dialogo modal de entrada unica.
4: * Chamada: CREATEOBJECT("FormSIGOPBIN", cFpagto)
5: * Herda de: FormBase
6: *
7: * Legado (SIGOPBIN.SCX): BaseClass = form (generico), sem PageFrame, sem
8: * grid, sem botao algum. Um unico TextBox (Get_Bin) recebe o BIN digitado; o
9: * Valid consulta SigOpFpb e fecha o form (ThisForm.Release) definindo o
10: * resultado em ThisForm.ZSen/UsuLibs, lido pelo Unload do form chamador
11: * (Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs).
12: *
13: * Historico de fases:
14: *   Fase 1/2: SIGOPBINBO.prg (propriedades + ValidarBin + ObterResultadoSaida)
15: *   Fase 3:   FormSIGOPBIN.prg - estrutura base (Init, InicializarForm,
16: *             ConfigurarPageFrame com cnt_4c_Sombra/lbl_4c_LblSombra/
17: *             lbl_4c_LblTitulo). Form FLAT: o legado nao tem PageFrame nem
18: *             Page nenhuma - nenhum pgf_4c_* eh criado neste form.
19: *   Fase 4/8 (CONCLUIDA COMO NO-OP JUSTIFICADO): nao ha Grid nem botoes
20: *             CRUD a acrescentar - analise.json/layout.json nao declaram
21: *             grid nem PageFrame, e o SCX legado (SIGOPBIN) nao tem UM
22: *             botao sequer: a arvore inteira eh Form + Frase (Label) +
23: *             Say2 (Label) + Get_Bin (TextBox) + cntSombra decorativo. O
24: *             dialogo fecha pelo Valid do proprio Get_Bin (consulta SQL +
25: *             ThisForm.Release) ou pelo KeyPress dele (ESC com campo
26: *             vazio) - nunca por um botao Confirmar/Encerrar. Este eh um
27: *             dialogo FLAT de CAPTURA (1 campo editavel, sem lista, sem
28: *             botao) - mesma familia do SIGMVVDE/FormSigMvVde e do
29: *             SIGOPATU/FormSigOpAtu, documentada no gate da Fase 4 do
30: *             OrquestradorMigracao.ps1 (ramo "layout captura"). Inventar
31: *             Page1/Grid/6 botoes CRUD aqui violaria o PILAR 1 (o legado
32: *             eh um popup de 600x200 com 1 campo, nao um cadastro) e a
33: *             regra "NUNCA inventar" (CLAUDE.md). lbl_4c_Frase,
34: *             lbl_4c_Label2 e txt_4c_Bin (com o Valid/KeyPress) ficam
35: *             para as Fases 5 a 7 (campos + evento).
36: *   Fase 5/8 (Parte 1): ConfigurarPaginaDados() - lbl_4c_Frase e
37: *             lbl_4c_Label2 (labels de instrucao, filhos diretos de THIS -
38: *             form FLAT). txt_4c_Bin (com Valid/KeyPress) entra na
39: *             Fase 6/8, descrita abaixo.
40: *   Fase 6/8: txt_4c_Bin (Get_Bin) criado em ConfigurarPaginaDados(). NAO
41: *             HA LOOKUP neste campo - o legado nao abre fwBuscaExt/sigacess
42: *             algum (conferido em tasks\task646\SIGOPBIN_form_codigo_fonte.txt
43: *             e tasks\task646\comportamento.json: temLookup = false nos 5
44: *             metodos). O Get_Bin.Valid SEMPRE termina em ThisForm.Release
45: *             (achou e vigente, achou fora da vigencia, nao achou, falha de
46: *             conexao OU campo vazio) - eh um dialogo de UMA tentativa so,
47: *             nao um campo com retry/picker. Equivalente migrado:
48: *             ValidarCampoBin() (chama SIGOPBINBO.ValidarBin() e fecha o
49: *             form), ligado via BINDEVENT KeyPress testando ENTER(13)/TAB(9)
50: *             - BINDEVENT "Valid" nao dispara de forma confiavel em TextBox
51: *             (regra conhecida do projeto). O KeyPress legado (ESC com
52: *             campo vazio) tambem delega para ValidarCampoBin(), que trata
53: *             EMPTY() do mesmo jeito do ramo "If Empty(This.Value)" do Valid.
54: *   Fase 7/8 (CONCLUIDA COMO NO-OP JUSTIFICADO): os quatro nomes
55: *             canonicos BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
56: *             BtnExcluirClick NAO existem aqui, e isso eh deliberado: sao a
57: *             barra CRUD da Page1 do frmcadastro, e este legado nao tem CRUD
58: *             nenhum (Class: form puro, sem frmcadastro, sem Grupo_Op, sem
59: *             pcEscolha, sem X.Click de verbo CRUD). A arvore inteira do dump
60: *             (tasks\task646\layout.json/SIGOPBIN_form_codigo_fonte.txt) eh
61: *             Form + Frase (Label) + Say2 (Label) + Get_Bin (TextBox) +
62: *             cntSombra decorativo - NENHUM CommandButton existe no legado
63: *             (diferente do SIGOPATU/FormSigOpAtu, que tem o Command1/"Ok").
64: *             O dialogo fecha exclusivamente pelo Valid/KeyPress do proprio
65: *             Get_Bin, cujo equivalente (ValidarCampoBin/BinKeyPress) ja foi
66: *             entregue na Fase 6/8 e ja termina em THIS.Release() em TODOS
67: *             os caminhos (achou e vigente, achou fora da vigencia, nao
68: *             achou, falha de conexao, campo vazio, ESC) - exatamente como o
69: *             "Thisform.release" incondicional no fim do Valid legado.
70: *             Inventar os 4 botoes CRUD aqui so poderia gerar metodo vazio
71: *             (nao ha Grid/lista para Incluir/Alterar/Visualizar/Excluir
72: *             operarem sobre), o que o pipeline proibe, e violaria o PILAR 1
73: *             (o legado eh um popup de 600x200 com 1 campo, nao um
74: *             cadastro). Nao sobra "evento principal" em aberto: o unico
75: *             evento do dump (Get_Bin.Valid) ja esta completo.
76: *   Fase 8/8: consolidacao final. FormParaBO() e BOParaForm() implementados
77: *             DE VERDADE (hooks PROTECTED que FormBase.Salvar/Cancelar
78: *             chamam por THIS.) - sao a camada de transferencia do PILAR 3
79: *             para o unico campo do dialogo: FormParaBO le txt_4c_Bin e
80: *             alimenta SIGOPBINBO.this_cCodBins (chamado por
81: *             ValidarCampoBin, no caminho VIVO do form), e BOParaForm faz o
82: *             contrario, inicializando o controle a partir do BO no fim de
83: *             ConfigurarPaginaDados. Declarados PROTECTED EXPLICITO porque
84: *             FormBase ja os declara assim e o VFP9 nao deixa a subclasse
85: *             ALARGAR escopo - omitir o modificador mentiria para quem le.
86: *
87: *             Os demais nomes do roteiro padrao NAO existem aqui, e isso eh
88: *             deliberado - o legado (SIGOPBIN.SCX) nao tem UM botao sequer
89: *             (arvore completa: Form + Frase/Say2 (Labels) + Get_Bin
90: *             (TextBox) + cntSombra decorativo com 2 Labels), nao tem Grid,

*-- Linhas 134 a 245:
134: 
135:     *--------------------------------------------------------------------------
136:     * Init - Recebe a condicao de pagamento (equivale ao LPARAMETERS pPag do
137:     * PROCEDURE Init legado) e cria o Business Object antes de inicializar
138:     * a parte visual (DODEFAULT -> FormBase.Init -> THIS.InicializarForm).
139:     *--------------------------------------------------------------------------
140:     PROCEDURE Init(par_cFpagto)
141:         LOCAL loc_lSucesso, loc_oErro
142:         loc_lSucesso = .F.
143: 
144:         TRY
145:             THIS.this_cFpagto = IIF(VARTYPE(par_cFpagto) = "C", ALLTRIM(par_cFpagto), "")
146: 
147:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPBINBO", THIS.this_cFpagto)
148:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
149:                 MsgErro("Erro ao criar SIGOPBINBO." + CHR(13) + ;
150:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
151:                     "FormSIGOPBIN.Init")
152:             ELSE
153:                 *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
154:                 loc_lSucesso = DODEFAULT()
155:             ENDIF
156:         CATCH TO loc_oErro
157:             MsgErro(loc_oErro.Message + CHR(13) + ;
158:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
159:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.Init")
160:         ENDTRY
161: 
162:         RETURN loc_lSucesso
163:     ENDPROC
164: 
165:     *--------------------------------------------------------------------------
166:     * InicializarForm - Monta a estrutura visual base
167:     * (chamado por FormBase.Init via DODEFAULT)
168:     *--------------------------------------------------------------------------
169:     PROTECTED PROCEDURE InicializarForm()
170:         LOCAL loc_lSucesso, loc_oErro
171:         loc_lSucesso = .F.
172: 
173:         TRY
174:             *-- Fundo do form (imagem do Framework Fortyus legado)
175:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
176: 
177:             *-- Monta o cabecalho (unico elemento estrutural deste form FLAT)
178:             THIS.ConfigurarPageFrame()
179: 
180:             *-- Monta os labels de instrucao (campos de dados - Fase 5/8 Parte 1)
181:             THIS.ConfigurarPaginaDados()
182: 
183:             *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
184:             THIS.TornarControlesVisiveis(THIS)
185: 
186:             loc_lSucesso = .T.
187:         CATCH TO loc_oErro
188:             MsgErro(loc_oErro.Message + CHR(13) + ;
189:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
190:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.InicializarForm")
191:         ENDTRY
192: 
193:         RETURN loc_lSucesso
194:     ENDPROC
195: 
196:     *--------------------------------------------------------------------------
197:     * ConfigurarPageFrame - Cria o cabecalho (cnt_4c_Sombra + labels).
198:     *   Form OPERACIONAL FLAT: o legado (SIGOPBIN.SCX) nao tem PageFrame nem
199:     *   Page nenhuma - todos os controles sao filhos diretos do form. Nome do
200:     *   metodo mantido por convencao do orquestrador de migracao (nenhum
201:     *   AddObject("pgf_4c_...") eh feito aqui).
202:     *   Demais controles do legado (Frase, Say2, Get_Bin) entram em fase
203:     *   posterior (campos de dados).
204:     *--------------------------------------------------------------------------
205:     PROTECTED PROCEDURE ConfigurarPageFrame()
206:         LOCAL loc_oCab, loc_oErro
207:         TRY
208:             *-- cntSombra original: Top=0, Left=0, Width=800 (-> THIS.Width), Height=80
209:             THIS.AddObject("cnt_4c_Sombra", "Container")
210:             loc_oCab = THIS.cnt_4c_Sombra
211:             WITH loc_oCab
212:                 .Top         = 0
213:                 .Left        = 0
214:                 .Width       = THIS.Width
215:                 .Height      = 80
216:                 .BorderWidth = 0
217:                 .BackStyle   = 1
218:                 .BackColor   = RGB(100, 100, 100)
219:             ENDWITH
220: 
221:             *-- Labels adicionados FORA do WITH do container (WITH aninhado com
222:             *-- AddObject ignora propriedades silenciosamente - regra conhecida)
223:             loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
224:             WITH loc_oCab.lbl_4c_LblSombra
225:                 .FontBold      = .T.
226:                 .FontName      = "Tahoma"
227:                 .FontSize      = 18
228:                 .FontUnderline = .F.
229:                 .WordWrap      = .T.
230:                 .AutoSize      = .F.
231:                 .Alignment     = 0
232:                 .BackStyle     = 0
233:                 .Caption       = "Cadastro de Testes"
234:                 .Height        = 40
235:                 .Left          = 10
236:                 .Top           = 18
237:                 .Width         = 769
238:                 .ForeColor     = RGB(0, 0, 0)
239:             ENDWITH
240: 
241:             loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
242:             WITH loc_oCab.lbl_4c_LblTitulo
243:                 .FontBold    = .T.
244:                 .FontName    = "Tahoma"
245:                 .FontSize    = 18

*-- Linhas 258 a 317:
258:         CATCH TO loc_oErro
259:             MsgErro(loc_oErro.Message + CHR(13) + ;
260:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
261:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.ConfigurarPageFrame")
262:         ENDTRY
263:     ENDPROC
264: 
265:     *--------------------------------------------------------------------------
266:     * ConfigurarPaginaDados - Cria os campos de dados do dialogo: os labels
267:     *   de instrucao (Fase 5/8) e o TextBox Get_Bin com o Valid/KeyPress que
268:     *   fecha o dialogo (Fase 6/8). Form FLAT (sem PageFrame/Page) - os
269:     *   controles sao filhos diretos de THIS, igual ao legado (Frase, Say2 e
270:     *   Get_Bin sao filhos diretos de SIGOPBIN).
271:     *
272:     *   Mapeamento (tasks\task646\mapeamento.json):
273:     *     SIGOPBIN.Frase  -> lbl_4c_Frase
274:     *     SIGOPBIN.Say2   -> lbl_4c_Label2
275:     *     SIGOPBIN.Get_Bin -> txt_4c_Bin
276:     *--------------------------------------------------------------------------
277:     PROTECTED PROCEDURE ConfigurarPaginaDados()
278:         LOCAL loc_oErro
279:         TRY
280:             *-- Frase: classe "say", AutoSize = .F. explicito no dump legado
281:             THIS.AddObject("lbl_4c_Frase", "Label")
282:             WITH THIS.lbl_4c_Frase
283:                 .FontBold  = .T.
284:                 .FontName  = "Tahoma"
285:                 .FontSize  = 8
286:                 .WordWrap  = .T.
287:                 .AutoSize  = .F.
288:                 .Alignment = 0
289:                 .BackStyle = 0
290:                 .Caption   = "Informe os 6 Primeiros D" + CHR(237) + ;
291:                     "gitos do Cart" + CHR(227) + "o (BIN)"
292:                 .Height    = 34
293:                 .Left      = 145
294:                 .Top       = 110
295:                 .Width     = 310
296:                 .ForeColor = RGB(90, 90, 90)
297:                 .TabIndex  = 1
298:             ENDWITH
299: 
300:             *-- Say2: classe "say" PURA (sem Width/Alignment no dump) - regra
301:             *-- #23: AutoSize=.T. e no-op em Label via AddObject, entao usar
302:             *-- Alignment=0 + Width explicita medida para o texto (nao inventar
303:             *-- Alignment=1). Get_Bin.Left=283 -> Width=63 encosta no campo.
304:             THIS.AddObject("lbl_4c_Label2", "Label")
305:             WITH THIS.lbl_4c_Label2
306:                 .FontBold  = .T.
307:                 .FontName  = "Tahoma"
308:                 .FontSize  = 8
309:                 .AutoSize  = .F.
310:                 .Alignment = 0
311:                 .BackStyle = 0
312:                 .Caption   = "C" + CHR(243) + "digo BIN:"
313:                 .Height    = 17
314:                 .Left      = 216
315:                 .Top       = 151
316:                 .Width     = 63
317:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 338 a 498:
338:                 .TabIndex   = 3
339:             ENDWITH
340: 
341:             *-- BINDEVENT precisa do objeto ja criado (feito acima)
342:             BINDEVENT(THIS.txt_4c_Bin, "KeyPress", THIS, "BinKeyPress")
343: 
344:             *-- Valor inicial do controle vem do BO (fonte unica), nao de literal
345:             THIS.BOParaForm()
346:         CATCH TO loc_oErro
347:             MsgErro(loc_oErro.Message + CHR(13) + ;
348:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
349:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.ConfigurarPaginaDados")
350:         ENDTRY
351:     ENDPROC
352: 
353:     *--------------------------------------------------------------------------
354:     * BinKeyPress - Equivalente ao PROCEDURE KeyPress do Get_Bin legado
355:     * (If (Lastkey() = 27) And Empty(This.Value) ... ThisForm.Release), mais
356:     * ENTER/TAB simulando o Valid (BINDEVENT "Valid" nao dispara de forma
357:     * confiavel em TextBox). PUBLIC (sem PROTECTED) - BINDEVENT exige metodo
358:     * publico.
359:     *--------------------------------------------------------------------------
360:     PROCEDURE BinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
361:         IF par_nKeyCode = 27 AND EMPTY(THIS.txt_4c_Bin.Value)
362:             *-- ESC com campo vazio: mesmo ramo "Empty(This.Value)" do Valid
363:             THIS.ValidarCampoBin()
364:         ELSE
365:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
366:                 THIS.ValidarCampoBin()
367:             ENDIF
368:         ENDIF
369:     ENDPROC
370: 
371:     *--------------------------------------------------------------------------
372:     * ValidarCampoBin - Equivalente ao PROCEDURE Valid do Get_Bin legado.
373:     * Consulta SigOpFpb (via SIGOPBINBO.ValidarBin) e SEMPRE fecha o dialogo
374:     * ao final - "Thisform.release" eh a ultima linha do Valid legado e roda
375:     * em TODOS os caminhos (achou e vigente, achou fora da vigencia, nao
376:     * achou, falha de conexao, campo vazio). O form chamador le o resultado
377:     * depois do Show() via THIS.ObterResultadoSaida().
378:     *--------------------------------------------------------------------------
379:     PROCEDURE ValidarCampoBin()
380:         LOCAL loc_cValor, loc_lProsseguir, loc_oErro
381:         loc_lProsseguir = .T.
382: 
383:         TRY
384:             *-- Transfere o valor digitado para o BO pelo hook do FormBase.
385:             *-- O legado le "This.Value" direto no Valid; no PILAR 3 esse
386:             *-- acesso mora em FormParaBO (camada de transferencia).
387:             THIS.FormParaBO()
388:             loc_cValor = THIS.this_oBusinessObject.this_cCodBins
389: 
390:             *-- If Empty(This.Value) -> ZSen = .f. / ThisForm.Release
391:             IF EMPTY(loc_cValor)
392:                 THIS.this_oBusinessObject.this_lZSen = .F.
393:                 loc_lProsseguir = .F.
394:             ENDIF
395: 
396:             IF loc_lProsseguir
397:                 THIS.this_oBusinessObject.ValidarBin(loc_cValor)
398:             ENDIF
399:         CATCH TO loc_oErro
400:             MsgErro(loc_oErro.Message + CHR(13) + ;
401:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
402:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.ValidarCampoBin")
403:         ENDTRY
404: 
405:         *-- "Thisform.release" (ultima linha do Valid legado, fora do IF/ELSE)
406:         THIS.Release()
407:     ENDPROC
408: 
409:     *--------------------------------------------------------------------------
410:     * FormParaBO - Hook PROTECTED do FormBase (chamado por FormBase.Salvar e,
411:     * neste form, por ValidarCampoBin). Transfere o unico campo editavel do
412:     * dialogo (txt_4c_Bin) para a property correspondente do Business Object
413:     * (SigOpFpb.codbins char(6) - docs/schema.sql).
414:     *
415:     * PROTECTED EXPLICITO: FormBase ja declara este hook como PROTECTED e o
416:     * VFP9 NAO permite que a subclasse ALARGUE o escopo - escrever
417:     * "PROCEDURE FormParaBO" sem o modificador nao o tornaria publico, so
418:     * esconderia que ele continua protegido.
419:     *--------------------------------------------------------------------------
420:     PROTECTED PROCEDURE FormParaBO()
421:         LOCAL loc_lSucesso, loc_oErro
422:         loc_lSucesso = .F.
423: 
424:         TRY
425:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
426:                 THIS.this_oBusinessObject.this_cCodBins = ALLTRIM(THIS.txt_4c_Bin.Value)
427:                 loc_lSucesso = .T.
428:             ENDIF
429:         CATCH TO loc_oErro
430:             MsgErro(loc_oErro.Message + CHR(13) + ;
431:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
432:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.FormParaBO")
433:         ENDTRY
434: 
435:         RETURN loc_lSucesso
436:     ENDPROC
437: 
438:     *--------------------------------------------------------------------------
439:     * BOParaForm - Hook PROTECTED do FormBase (caminho inverso do FormParaBO).
440:     * Reflete no controle o BIN que o Business Object tem no momento. Chamado
441:     * no fim de ConfigurarPaginaDados para que o valor inicial de txt_4c_Bin
442:     * venha do BO (fonte unica), e nao de um literal no meio do AddObject.
443:     *
444:     * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO acima.
445:     *--------------------------------------------------------------------------
446:     PROTECTED PROCEDURE BOParaForm()
447:         LOCAL loc_lSucesso, loc_oErro
448:         loc_lSucesso = .F.
449: 
450:         TRY
451:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
452:                 THIS.txt_4c_Bin.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodBins)
453:                 loc_lSucesso = .T.
454:             ENDIF
455:         CATCH TO loc_oErro
456:             MsgErro(loc_oErro.Message + CHR(13) + ;
457:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
458:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.BOParaForm")
459:         ENDTRY
460: 
461:         RETURN loc_lSucesso
462:     ENDPROC
463: 
464:     *--------------------------------------------------------------------------
465:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
466:     *--------------------------------------------------------------------------
467:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
468:         LOCAL loc_i, loc_oControl, loc_oErro
469:         TRY
470:             FOR loc_i = 1 TO par_oContainer.ControlCount
471:                 loc_oControl = par_oContainer.Controls(loc_i)
472:                 IF VARTYPE(loc_oControl) = "O"
473:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
474:                         loc_oControl.Visible = .T.
475:                     ENDIF
476:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
477:                        loc_oControl.ControlCount > 0
478:                         THIS.TornarControlesVisiveis(loc_oControl)
479:                     ENDIF
480:                 ENDIF
481:             ENDFOR
482:         CATCH TO loc_oErro
483:             MsgErro(loc_oErro.Message + CHR(13) + ;
484:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
485:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.TornarControlesVisiveis")
486:         ENDTRY
487:     ENDPROC
488: 
489:     *--------------------------------------------------------------------------
490:     * ObterResultadoSaida - Equivalente ao PROCEDURE Unload do legado
491:     * (Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs). O form chamador le
492:     * este valor apos o Show() modal retornar, antes de liberar o form.
493:     *--------------------------------------------------------------------------
494:     FUNCTION ObterResultadoSaida()
495:         RETURN THIS.this_oBusinessObject.ObterResultadoSaida()
496:     ENDFUNC
497: 
498: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPBINBO.prg):
*==============================================================================
* SIGOPBINBO.prg - Business Object: Valida BIN do Cartao (SIGOPBIN)
* Tabela: SigOpFpb
* PK: cidchaves char(20)
* Herda de: BusinessBase
*
* Origem legado: SIGOPBIN.SCX (form OPERACIONAL modal, WindowType = 1)
*   - Init recebe pPag (condicao de pagamento) e guarda em ThisForm.Fpagto
*   - Get_Bin.Valid consulta SigOpFpB por Fpags + CodBins e, achando registro,
*     confere a vigencia com Between(Dtos(Date()), Dtos(Nvl(Datais, 01/01/1900)),
*     Dtos(Nvl(DataFs, 31/12/9999))); autorizado -> UsuLibs = BIN e ZSen = .T.
*   - Unload devolve Iif(ZSen, "*", " ") + UsuLibs para o form chamador
*
* O legado NAO grava em tabela nenhuma (apenas Select), portanto este BO eh de
* SOMENTE LEITURA: para Inserir/Atualizar/ExecutarExclusao o comportamento
* padrao herdado de BusinessBase ja eh o correto.
*
* O metodo de negocio real (equivalente ao Get_Bin.Valid do legado) eh
* ValidarBin(par_cCodBin) - consulta SigOpFpb, confere a vigencia e resolve
* this_lZSen/this_cUsuLibs; ObterResultadoSaida() equivale ao PROCEDURE Unload.
*==============================================================================
DEFINE CLASS SIGOPBINBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Chave Primaria da tabela SigOpFpb
    *--------------------------------------------------------------------------
    this_cCidChaves = ""    && cidchaves char(20) NOT NULL - PK tecnica Fortyus

    *--------------------------------------------------------------------------
    * Propriedades - Campos da tabela SigOpFpb
    * Nomes das colunas conforme docs/schema.sql (PILAR 2 - schema identico)
    *--------------------------------------------------------------------------
    this_cCodBins = ""      && codbins char(6)  NOT NULL - codigo BIN do cartao
    this_cDescs   = ""      && descs   char(30) NOT NULL - descricao do BIN
    this_dDataIs  = {}      && datais  datetime NULL     - inicio da vigencia
    this_dDataFs  = {}      && datafs  datetime NULL     - fim da vigencia
    this_cFpags   = ""      && fpags   char(12) NOT NULL - condicao de pagamento

    *--------------------------------------------------------------------------
    * Propriedades - Contexto recebido do form chamador
    * Equivale a ThisForm.Fpagto do legado, alimentada pelo parametro pPag
    *--------------------------------------------------------------------------
    this_cFpagto = ""       && condicao de pagamento usada no filtro da consulta

    *--------------------------------------------------------------------------
    * Propriedades - Resultado da validacao (devolvido ao form chamador)
    * Equivalem a ThisForm.UsuLibs e ThisForm.ZSen do legado
    *--------------------------------------------------------------------------
    this_cUsuLibs = ""      && BIN liberado; vazio quando nao houve liberacao
    this_lZSen    = .F.      && .T. = BIN autorizado e dentro da vigencia

    *--------------------------------------------------------------------------
    * Propriedades - Detalhe do resultado (usado nas mensagens ao usuario)
    *--------------------------------------------------------------------------
    this_lRegistroEncontrado = .F.   && Reccount('LocalFpagB') > 0 no legado
    this_lVigenciaValida     = .F.   && resultado do Between() de datas
    this_lFalhaConexao       = .F.   && SqlExecute < 1 no legado

    *--------------------------------------------------------------------------
    * Propriedades - Demais properties declaradas no SCX legado
    * Mantidas para paridade com o contrato do form (ClassInfo do SIGOPBIN)
    *--------------------------------------------------------------------------
    this_lLibFpag2 = .F.    && libfpag2 = .F. no SCX
    this_cLibOpe   = ""      && libope (display "LibOpe" no _memberdata do SCX)

    *--------------------------------------------------------------------------
    * Propriedades - Vigencia
    * Sentinelas transcritas LITERALMENTE do legado (Nvl do Get_Bin.Valid):
    *   Nvl(LocalFpagB.Datais, Ctod('01/01/1900'))
    *   Nvl(LocalFpagB.DataFs, Ctod('31/12/9999'))
    * Literal {^AAAA-MM-DD} nao varia com SET DATE / SET CENTURY
    *--------------------------------------------------------------------------
    this_dDataReferencia      = {}              && Date() do legado
    this_dVigenciaInicioPadrao = {^1900-01-01}   && usada quando datais eh NULL
    this_dVigenciaFimPadrao    = {^9999-12-31}   && usada quando datafs eh NULL

    *--------------------------------------------------------------------------
    * Propriedades - Cursores
    * O legado usa o alias local 'LocalFpagB' (SqlExecute do fSqlConector)
    *--------------------------------------------------------------------------
    this_cCursorDados = ""  && alias do cursor da consulta de BIN

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    * par_cFpagto: condicao de pagamento (equivale ao pPag do Init legado).
    *              Opcional - o form pode informar depois via this_cFpagto.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cFpagto)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- Tabela e chave primaria (nomes EXATOS do schema)
            THIS.this_cTabela     = "SigOpFpb"
            THIS.this_cCampoChave = "cidchaves"

            *-- Alias do cursor da consulta (LocalFpagB no legado)
            THIS.this_cCursorDados = "cursor_4c_FpagB"

            *-- Contexto: Fpagto chega do form chamador (pPag do legado)
            IF VARTYPE(par_cFpagto) = "C"
                THIS.this_cFpagto = ALLTRIM(par_cFpagto)
            ELSE
                THIS.this_cFpagto = ""
            ENDIF

            *-- Data de referencia da vigencia (Date() do Get_Bin.Valid)
            THIS.this_dDataReferencia = DATE()

            *-- Estado inicial: nada liberado (ThisForm.UsuLibs = [] do legado)
            THIS.this_cUsuLibs            = ""
            THIS.this_lZSen               = .F.
            THIS.this_lRegistroEncontrado = .F.
            THIS.this_lVigenciaValida     = .F.
            THIS.this_lFalhaConexao       = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SIGOPBINBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia os campos do cursor de consulta (LocalFpagB no
    * legado) para as properties do BO. Chamado por ValidarBin() apos o
    * SQLEXEC confirmar RECCOUNT > 0.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCidChaves = TratarNulo(cidchaves, "")
        THIS.this_cCodBins   = TratarNulo(CodBins, "")
        THIS.this_cDescs     = TratarNulo(Descs, "")
        THIS.this_cFpags     = TratarNulo(Fpags, "")
        THIS.this_dDataIs    = TratarNulo(Datais, {})
        THIS.this_dDataFs    = TratarNulo(DataFs, {})

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarBin - Equivalente ao Get_Bin.Valid do legado.
    *
    * Consulta SigOpFpb por Fpags (this_cFpagto, contexto recebido no Init) +
    * CodBins (par_cCodBin, digitado pelo usuario) e, achando o registro,
    * confere a vigencia com o mesmo Between(Dtos(...)) do legado, usando as
    * sentinelas 01/01/1900 e 31/12/9999 quando Datais/DataFs estao NULL.
    *
    * Resultado fica em this_lZSen/this_cUsuLibs (equivalem a ThisForm.ZSen e
    * ThisForm.UsuLibs) - o form chamador le essas properties (ou chama
    * ObterResultadoSaida()) para decidir o fechamento, igual ao legado faz em
    * ThisForm.Release dentro do proprio Valid.
    *
    * par_cCodBin vazio reproduz "If Empty(This.Value) ... Return .t." do
    * legado: nao faz SQL, so garante o estado default (nao autorizado).
    *--------------------------------------------------------------------------
    FUNCTION ValidarBin(par_cCodBin)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado, ;
            loc_dDataIniVigencia, loc_dDataFimVigencia
        loc_lSucesso = .F.

        THIS.this_cUsuLibs           = ""
        THIS.this_lZSen              = .F.
        THIS.this_lRegistroEncontrado = .F.
        THIS.this_lVigenciaValida    = .F.
        THIS.this_lFalhaConexao      = .F.

        IF EMPTY(par_cCodBin)
            RETURN .T.
        ENDIF

        TRY
            THIS.this_dDataReferencia = DATE()

            loc_cSQL = "SELECT * FROM SigOpFpb" + ;
                " WHERE Fpags = " + EscaparSQL(THIS.this_cFpagto) + ;
                " AND CodBins = " + EscaparSQL(par_cCodBin)

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResultado < 1
                THIS.this_lFalhaConexao = .T.
                THIS.this_lZSen         = .F.
                MsgErro("Falha na Conex" + CHR(227) + "o. Tente Novamente!!!", "SIGOPBINBO.ValidarBin")
            ELSE
                IF RECCOUNT(THIS.this_cCursorDados) > 0
                    THIS.this_lRegistroEncontrado = .T.
                    THIS.CarregarDoCursor(THIS.this_cCursorDados)

                    loc_dDataIniVigencia = IIF(EMPTY(THIS.this_dDataIs), ;
                        THIS.this_dVigenciaInicioPadrao, THIS.this_dDataIs)
                    loc_dDataFimVigencia = IIF(EMPTY(THIS.this_dDataFs), ;
                        THIS.this_dVigenciaFimPadrao, THIS.this_dDataFs)

                    THIS.this_lVigenciaValida = BETWEEN(DTOS(THIS.this_dDataReferencia), ;
                        DTOS(loc_dDataIniVigencia), DTOS(loc_dDataFimVigencia))

                    IF THIS.this_lVigenciaValida
                        THIS.this_cUsuLibs = par_cCodBin
                        THIS.this_lZSen    = .T.
                    ELSE
                        THIS.this_lZSen    = .F.
                    ENDIF
                ELSE
                    THIS.this_lZSen = .F.
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SIGOPBINBO.ValidarBin")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterResultadoSaida - Equivalente ao PROCEDURE Unload do legado:
    *   Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
    * O form chamador le este retorno no lugar do valor que o legado devolvia
    * via ThisForm ao form pai que abriu o modal.
    *--------------------------------------------------------------------------
    FUNCTION ObterResultadoSaida()
        RETURN IIF(THIS.this_lZSen, "*", " ") + THIS.this_cUsuLibs
    ENDFUNC

ENDDEFINE

