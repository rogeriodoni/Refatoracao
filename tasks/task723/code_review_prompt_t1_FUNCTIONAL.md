# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Arquivos Relacionados [Incluindo ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Arquivos Relacionados [Incluindo Diretório, Caminho de Rede, Mapeamento, etc]. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDoc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1417 linhas total):

*-- Linhas 32 a 75:
32: * NAO ha lookup neste form: o dump do SIGOPDOC.SCX nao casa nenhum padrao de
33: * busca do Framework legado (zero fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/
34: * mAddColuna) e comportamento.json traz temLookup = .F. em todos os 19
35: * metodos - o unico CreateObject do legado eh Shell.Application. Inventar
36: * lookup aqui violaria o PILAR 1 e a regra "NUNCA inventar tabelas de lookup
37: * que nao existem no original".
38: * FASE 7/8 - Bloco de saida (cmdBtnForm: CommandGroup Sair/Confirmar) +
39: * SalvarDados(). O legado liga crSigOpArq a um cursor COM BUFFERING
40: * (.poDataMgr.AddCursor) - btnInsArqs/btnExcArqs so editam o buffer local, e
41: * salvardados() eh quem de fato grava tudo no SQL Server
42: * (.poDataMgr.Update/.Commit, com .RollBack() se falhar). Na arquitetura
43: * nova esse buffering nao existe: BtnInsArqsClick/BtnExcArqsClick ja gravam
44: * direto via BO.Inserir()/BO.Excluir() (fase 4). O que ainda exigia
45: * confirmacao explicita era a edicao do campo Observacao
46: * (obj_4c_GetObsArqs, ligado a cursor_4c_Dados - cursor LOCAL/desconectado
47: * do servidor): SalvarDados() varre esse cursor e empurra cada linha para
48: * SigOpArq via BO.Atualizar(), que eh o equivalente funcional do
49: * Update()/Commit() do legado para este form.
50: * FASE 8/8 - Consolidacao: os hooks de transferencia Form<->BO (FormParaBO/
51: * BOParaForm), o controle unico da superficie editavel (HabilitarCampos), a
52: * limpeza do painel de detalhe (LimparCampos) e o nome canonico do botao de
53: * cancelar (BtnCancelarClick, que eh o btnSair Cancel=.T. do SCX).
54: *
55: * Dois defeitos de parida de funcional foram corrigidos aqui, ambos silenciosos:
56: *
57: * 1) cursor_4c_Dados chegava SOMENTE-LEITURA. O EditBox de observacao
58: *    (obj_4c_GetObsArqs) esta ligado a ele por ControlSource, e cursor de
59: *    SQLEXEC nasce read-only - o campo nao aceitava uma tecla e SalvarDados
60: *    nunca teria o que gravar, sem erro nenhum na tela (medido no VFP9:
61: *    REPLACE em cursor assim estoura erro 111 "Cannot update the cursor ...,
62: *    since it is read-only"). O legado liga crSigOpArq por .AddCursor, cursor
63: *    COM buffering e gravavel - a prova esta no proprio Init legado, que faz
64: *    "Update crSigOpArq Set ObsArqs = Nvl(ObsArqs, [])". Conserto em
65: *    SigOpDocBO.Buscar: SQLEXEC vai para alias temporario e o alias da grade
66: *    eh recriado com SELECT ... INTO CURSOR ... READWRITE.
67: *
68: * 2) A normalizacao "Set ObsArqs = Nvl(ObsArqs, [])" do Init legado nao tinha
69: *    sido migrada: coluna TEXT nula chega ao EditBox como .NULL. e eh isso que
70: *    o usuario le na tela (mesma familia do mRetiraNull do legado). Agora
71: *    acontece no BO.Buscar (todas as linhas) e em BOParaForm (linha corrente).
72: *==============================================================================
73: 
74: DEFINE CLASS FormSigOpDoc AS FormBase
75: 

*-- Linhas 104 a 229:
104:     *==========================================================================
105:     * Init - Recebe a chave de amarracao e o modo de acesso, cria o Business
106:     * Object e delega a montagem da tela ao FormBase.Init (que chama
107:     * THIS.InicializarForm()). Equivalente a "Lparameters pKey, pEsc" + o
108:     * guard "If Empty(pKey) Or Empty(pEsc)" do Init legado.
109:     *==========================================================================
110:     FUNCTION Init(par_cChave, par_cEscolha)
111:         THIS.this_cArqChaves = ALLTRIM(NVL(par_cChave, ""))
112:         THIS.this_cEscolha   = ALLTRIM(UPPER(NVL(par_cEscolha, "")))
113: 
114:         IF EMPTY(THIS.this_cArqChaves) OR EMPTY(THIS.this_cEscolha)
115:             MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos para " + ;
116:                 "abrir a rela" + CHR(231) + CHR(227) + "o de arquivos.", "Erro")
117:             RETURN .F.
118:         ENDIF
119: 
120:         THIS.this_oBusinessObject = CREATEOBJECT("SigOpDocBO")
121:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
122:             MsgErro("Erro ao criar SigOpDocBO.", "Erro")
123:             RETURN .F.
124:         ENDIF
125: 
126:         RETURN DODEFAULT()
127:     ENDFUNC
128: 
129:     *==========================================================================
130:     * InicializarForm - Monta a estrutura base do form (chamado pelo
131:     * FormBase.Init). Deve retornar .T. em sucesso e .F. em falha.
132:     *==========================================================================
133:     PROTECTED PROCEDURE InicializarForm()
134:         LOCAL loc_lSucesso, loc_oErro
135:         loc_lSucesso = .F.
136: 
137:         TRY
138:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
139: 
140:             THIS.ConfigurarCabecalho()
141:             THIS.ConfigurarGrid()
142:             THIS.ConfigurarBotoesArquivos()
143:             THIS.ConfigurarPainelObservacao()
144:             THIS.ConfigurarCamposAuditoria()
145:             THIS.ConfigurarBotaoFechar()
146: 
147:             THIS.TornarControlesVisiveis(THIS)
148: 
149:             *-- Preview de imagem (img_4c_ImgArqJpg) nasce oculto de proposito
150:             *-- (legado: imgArqJpg.Visible=.f. no SCX) - so aparece quando o
151:             *-- arquivo da linha corrente da grade for .jpg/.ico/.bmp/.jpeg
152:             THIS.img_4c_ImgArqJpg.Visible = .F.
153: 
154:             THIS.CarregarLista()
155:             THIS.AjustarBotoesPorModo()
156: 
157:             *-- Legado: o Init termina com ".grdArquivos.Column1.SetFocus" +
158:             *-- ".grdArquivos.AfterRowColChange()" - a chamada explicita eh o
159:             *-- que deixa preview e campos de detalhe coerentes com a PRIMEIRA
160:             *-- linha, antes de o usuario mexer na grade.
161:             THIS.GradeAfterRowColChange(1)
162: 
163:             loc_lSucesso = .T.
164: 
165:         CATCH TO loc_oErro
166:             THIS.this_cMensagemErro = loc_oErro.Message
167:             MsgErro(loc_oErro.Message + CHR(13) + ;
168:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
169:                     "Procedure: " + loc_oErro.Procedure, ;
170:                     "Erro em FormSigOpDoc.InicializarForm")
171:         ENDTRY
172: 
173:         RETURN loc_lSucesso
174:     ENDPROC
175: 
176:     *==========================================================================
177:     * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
178:     * cnt_4c_Cabecalho: Top=0 Left=0 Width=THIS.Width Height=80
179:     * BackColor=RGB(100,100,100) - identificado por BackColor+altura, nunca
180:     * pelo nome (regra do CLAUDE.md sobre deteccao de cabecalho).
181:     *==========================================================================
182:     PROTECTED PROCEDURE ConfigurarCabecalho()
183:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
184:         WITH THIS.cnt_4c_Cabecalho
185:             .Top         = 0
186:             .Left        = 0
187:             .Width       = THIS.Width
188:             .Height      = 80
189:             .BackStyle   = 1
190:             .BackColor   = RGB(100, 100, 100)
191:             .BorderWidth = 0
192:             .Visible     = .T.
193:         ENDWITH
194: 
195:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblSombra", "Label")
196:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra
197:             .Top        = 18
198:             .Left       = 10
199:             .Width      = 769
200:             .Height     = 40
201:             .FontName   = "Tahoma"
202:             .FontSize   = 18
203:             .FontBold   = .T.
204:             .ForeColor  = RGB(0, 0, 0)
205:             .BackStyle  = 0
206:             .WordWrap   = .T.
207:             .AutoSize   = .F.
208:             .Alignment  = 0
209:             .Caption    = THIS.Caption
210:             .Visible    = .T.
211:         ENDWITH
212: 
213:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblTitulo", "Label")
214:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo
215:             .Top        = 17
216:             .Left       = 10
217:             .Width      = 769
218:             .Height     = 46
219:             .FontName   = "Tahoma"
220:             .FontSize   = 18
221:             .FontBold   = .T.
222:             .ForeColor  = RGB(255, 255, 255)
223:             .BackStyle  = 0
224:             .WordWrap   = .T.
225:             .AutoSize   = .F.
226:             .Alignment  = 0
227:             .Caption    = THIS.Caption
228:             .Visible    = .T.
229:         ENDWITH

*-- Linhas 236 a 279:
236:     * Header1.Caption/Width sao definidos em CarregarLista() (DEPOIS do
237:     * RecordSource - Problema 2/48, RecordSource reseta ambos).
238:     *==========================================================================
239:     PROTECTED PROCEDURE ConfigurarGrid()
240:         THIS.AddObject("grd_4c_Dados", "Grid")
241:         WITH THIS.grd_4c_Dados
242:             .Top             = 96
243:             .Left            = 5
244:             .Width           = 810
245:             .Height          = 288
246:             .FontName        = "Arial"
247:             .DeleteMark      = .F.
248:             .RecordMark      = .F.
249:             .ReadOnly        = .T.
250:             .ScrollBars      = 2
251:             .ColumnCount     = 1
252:             .GridLineColor   = RGB(238, 238, 238)
253:             .HighlightBackColor = RGB(255, 255, 255)
254:             .HighlightForeColor = RGB(15, 41, 104)
255:             .HighlightStyle  = 2
256:             .Visible         = .T.
257:         ENDWITH
258: 
259:         WITH THIS.grd_4c_Dados.Column1
260:             .FontName   = "Verdana"
261:             .FontSize   = 8
262:             .Enabled    = .T.
263:             .Width      = 778
264:             .Movable    = .F.
265:             .Resizable  = .F.
266:             .ReadOnly   = .T.
267:             .Visible    = .T.
268:         ENDWITH
269: 
270:         WITH THIS.grd_4c_Dados.Column1.Header1
271:             .FontBold  = .F.
272:             .FontName  = "Tahoma"
273:             .FontSize  = 8
274:             .Alignment = 2
275:             .Caption   = "Arquivos Relacionados [Incluindo Diret" + CHR(243) + ;
276:                 "rio, Caminho de Rede, Mapeamento, etc]"
277:             .ForeColor = RGB(90, 90, 90)
278:         ENDWITH
279: 

*-- Linhas 294 a 435:
294:         *-- AfterRowColChange eh o CORRETO (regra #46): nao ha filtro de coluna
295:         *-- e o que se carrega eh o DETALHE da linha corrente, nao validacao de
296:         *-- celula digitada - a Column1 eh ReadOnly nos dois sistemas.
297:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
298:     ENDPROC
299: 
300:     *==========================================================================
301:     * ConfigurarBotoesArquivos - Botoes standalone ao lado da grade (Inserir/
302:     * Abrir/Excluir/Abrir Diretorio) + os dois shapes decorativos do bloco
303:     * (shpAlterar/Shape3). Standalone CommandButton com .Picture + Enabled
304:     * alternavel exige Themes=.T. + DisabledPicture (regra de icone-only nao
305:     * se aplica aqui - os 4 botoes tem Caption).
306:     *==========================================================================
307:     PROTECTED PROCEDURE ConfigurarBotoesArquivos()
308:         THIS.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
309:         WITH THIS.cmd_4c_BtnInsArqs
310:             .Top             = 96
311:             .Left            = 833
312:             .Width           = 75
313:             .Height          = 75
314:             .FontName        = "Comic Sans MS"
315:             .FontBold        = .T.
316:             .FontItalic      = .T.
317:             .FontSize        = 8
318:             .ForeColor       = RGB(90, 90, 90)
319:             .BackColor       = RGB(255, 255, 255)
320:             .Caption         = "Inserir Arquivo"
321:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_60.jpg"
322:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_60.jpg"
323:             .Themes          = .T.
324:             .PicturePosition = 7
325:             .ToolTipText     = "Inserir Um Link de Arquivo"
326:             .Visible         = .T.
327:         ENDWITH
328:         BINDEVENT(THIS.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
329: 
330:         THIS.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
331:         WITH THIS.cmd_4c_BtnOpnArqs
332:             .Top             = 172
333:             .Left            = 833
334:             .Width           = 75
335:             .Height          = 75
336:             .FontName        = "Comic Sans MS"
337:             .FontBold        = .T.
338:             .FontItalic      = .T.
339:             .FontSize        = 8
340:             .ForeColor       = RGB(90, 90, 90)
341:             .BackColor       = RGB(255, 255, 255)
342:             .Caption         = "Abrir Arquivo"
343:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
344:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
345:             .Themes          = .T.
346:             .PicturePosition = 7
347:             .ToolTipText     = "Abrir Arquivo (Caso o Computado Suporte)"
348:             .Visible         = .T.
349:         ENDWITH
350:         BINDEVENT(THIS.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")
351: 
352:         THIS.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
353:         WITH THIS.cmd_4c_BtnExcArqs
354:             .Top             = 96
355:             .Left            = 908
356:             .Width           = 75
357:             .Height          = 75
358:             .FontName        = "Comic Sans MS"
359:             .FontBold        = .T.
360:             .FontItalic      = .T.
361:             .FontSize        = 8
362:             .ForeColor       = RGB(90, 90, 90)
363:             .BackColor       = RGB(255, 255, 255)
364:             .Caption         = "Excluir Arquivo"
365:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
366:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
367:             .Themes          = .T.
368:             .PicturePosition = 7
369:             .ToolTipText     = "Excluir Um Link de Arquivo (N" + CHR(227) + ;
370:                 "o Apaga o Arquivo Fisicamente)"
371:             .Visible         = .T.
372:         ENDWITH
373:         BINDEVENT(THIS.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")
374: 
375:         THIS.AddObject("cmd_4c_BtnOpnDirs", "CommandButton")
376:         WITH THIS.cmd_4c_BtnOpnDirs
377:             .Top             = 172
378:             .Left            = 908
379:             .Width           = 75
380:             .Height          = 75
381:             .FontName        = "Comic Sans MS"
382:             .FontBold        = .T.
383:             .FontItalic      = .T.
384:             .FontSize        = 8
385:             .ForeColor       = RGB(90, 90, 90)
386:             .BackColor       = RGB(255, 255, 255)
387:             .Caption         = "Abrir Diret" + CHR(243) + "rio"
388:             .Picture         = gc_4c_CaminhoIcones + "geral_pasta_60.jpg"
389:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_60.jpg"
390:             .Themes          = .T.
391:             .PicturePosition = 7
392:             .ToolTipText     = "Abrir a Pasta Onde o Arquivo Est" + CHR(225) + " Gravado"
393:             .Visible         = .T.
394:         ENDWITH
395:         BINDEVENT(THIS.cmd_4c_BtnOpnDirs, "Click", THIS, "BtnOpnDirsClick")
396: 
397:         *-- Shapes decorativos do bloco de botoes (shpAlterar/Shape3 legado)
398:         THIS.AddObject("shp_4c_ShpAlterar", "Shape")
399:         WITH THIS.shp_4c_ShpAlterar
400:             .Top           = 113
401:             .Left          = 822
402:             .Width         = 25
403:             .Height        = 31
404:             .BackStyle     = 0
405:             .BorderStyle   = 0
406:             .BorderWidth   = 1
407:             .SpecialEffect = 1
408:             .BorderColor   = RGB(136, 189, 188)
409:             .Visible       = .T.
410:         ENDWITH
411: 
412:         THIS.AddObject("shp_4c_Shape3", "Shape")
413:         WITH THIS.shp_4c_Shape3
414:             .Top           = 262
415:             .Left          = 823
416:             .Width         = 25
417:             .Height        = 31
418:             .BackStyle     = 0
419:             .BorderStyle   = 0
420:             .BorderWidth   = 1
421:             .SpecialEffect = 1
422:             .BorderColor   = RGB(136, 189, 188)
423:             .Visible       = .T.
424:         ENDWITH
425:     ENDPROC
426: 
427:     *==========================================================================
428:     * ConfigurarBotaoFechar - cmdBtnForm (CommandGroup Sair/Confirmar) do SCX
429:     * legado. Buttons(1) = btnSair (Command1 no dump - Cancel=.T., fecha sem
430:     * gravar) e Buttons(2) = btnConfirmar (Command2 - grava a observacao
431:     * nao confirmado antes de fechar), na MESMA ordem de criacao do dump.
432:     *
433:     * Legado (cmdBtnForm): AutoSize=.T. ButtonCount=2 BackStyle=0
434:     *   BorderStyle=0 Value=0 Top=-2 Left=840 Width=160 Height=85
435:     *   SpecialEffect=1 BorderColor=136,189,188 Themes=.F.

*-- Linhas 459 a 502:
459:     * btnConfirmar.Enabled eh alternado em AjustarBotoesPorModo (legado:
460:     * ".cmdBtnForm.btnConfirmar.Enabled = .f." fora de INSERIR/ALTERAR).
461:     *==========================================================================
462:     PROTECTED PROCEDURE ConfigurarBotaoFechar()
463:         THIS.AddObject("cmg_4c_CmdBtnForm", "CommandGroup")
464:         WITH THIS.cmg_4c_CmdBtnForm
465:             .ButtonCount   = 2
466:             .BackStyle     = 0
467:             .BorderStyle   = 0
468:             .Value         = 0
469:             .SpecialEffect = 1
470:             .BorderColor   = RGB(136, 189, 188)
471:             .Themes        = .F.
472: 
473:             *-- Buttons(1) = btnSair (Command1 no dump)
474:             WITH .Buttons(1)
475:                 .Top             = 5
476:                 .Left            = 80
477:                 .Height          = 75
478:                 .Width           = 75
479:                 .FontName        = "Tahoma"
480:                 .FontSize        = 8
481:                 .FontBold        = .T.
482:                 .FontItalic      = .T.
483:                 .Cancel          = .T.
484:                 .Caption         = "Sair"
485:                 .ForeColor       = RGB(90, 90, 90)
486:                 .BackColor       = RGB(255, 255, 255)
487:                 .Themes          = .F.
488:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
489:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
490:                 .Visible         = .T.
491:             ENDWITH
492: 
493:             *-- Buttons(2) = btnConfirmar (Command2 no dump)
494:             WITH .Buttons(2)
495:                 .Top             = 5
496:                 .Left            = 5
497:                 .Height          = 75
498:                 .Width           = 75
499:                 .FontName        = "Tahoma"
500:                 .FontSize        = 8
501:                 .FontBold        = .T.
502:                 .FontItalic      = .T.

*-- Linhas 521 a 669:
521: 
522:         *-- Buttons(1) eh o btnSair do legado, que tem Cancel=.T. - ou seja, eh
523:         *-- o CANCELAR da tela; o handler canonico eh BtnCancelarClick
524:         BINDEVENT(THIS.cmg_4c_CmdBtnForm.Buttons(1), "Click", THIS, "BtnCancelarClick")
525:         BINDEVENT(THIS.cmg_4c_CmdBtnForm.Buttons(2), "Click", THIS, "BtnConfirmarClick")
526:     ENDPROC
527: 
528:     *==========================================================================
529:     * ConfigurarPainelObservacao - Preview da imagem (imgArqJpg legado) +
530:     * observacao sobre o arquivo corrente (Say31/getObsArqs legado).
531:     * shp_4c_Shape1: Top=392 Left=8 Width=395 Height=231 - moldura decorativa
532:     * em volta da area de preview (shp_4c_Shape1/shp_4c_Shape3 legado usam a
533:     * mesma moldura 3D - CommandButton/Shape nao tem FontName/propriedade de
534:     * texto, so BorderColor/FillColor - regra #33).
535:     * img_4c_ImgArqJpg: Top=394 Left=10 Width=391 Height=227, Visible=.F. -
536:     * so aparece quando a linha corrente da grade aponta para .jpg/.ico/.bmp/
537:     * .jpeg (grdArquivos.AfterRowColChange legado, fase 7/8). Picture NAO eh
538:     * ControlSource - eh atribuido em codigo a cada troca de linha.
539:     * lbl_4c_Label31 (Say31): Top=391 Left=411 - classe say sem Width/
540:     * Alignment no dump -> AutoSize=.F. + ForeColor=RGB(90,90,90) (regra #12/
541:     * #23, NUNCA inventar Width+Alignment=1).
542:     * obj_4c_GetObsArqs (getObsArqs/fwmemo): Top=407 Left=411 Width=580
543:     * Height=181, ControlSource=cursor_4c_Dados.ObsArqs (coluna TEXT/memo).
544:     * ReadOnly inicial=.T., alternado em AjustarBotoesPorModo junto com os
545:     * botoes de manutencao (legado: getObsArqs.When = InList(pcEscolha,
546:     * "INSERIR","ALTERAR")).
547:     *==========================================================================
548:     PROTECTED PROCEDURE ConfigurarPainelObservacao()
549:         THIS.AddObject("shp_4c_Shape1", "Shape")
550:         WITH THIS.shp_4c_Shape1
551:             .Top           = 392
552:             .Left          = 8
553:             .Width         = 395
554:             .Height        = 231
555:             .BackStyle     = 0
556:             .BorderStyle   = 0
557:             .BorderWidth   = 1
558:             .SpecialEffect = 1
559:             .BorderColor   = RGB(136, 189, 188)
560:             .Visible       = .T.
561:         ENDWITH
562: 
563:         THIS.AddObject("img_4c_ImgArqJpg", "Image")
564:         WITH THIS.img_4c_ImgArqJpg
565:             .Top         = 394
566:             .Left        = 10
567:             .Width       = 391
568:             .Height      = 227
569:             .BackStyle   = 0
570:             .BorderStyle = 0
571:             .Stretch     = 1
572:             .Picture     = ""
573:             .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
574:             .Visible     = .F.
575:         ENDWITH
576:         *-- Legado: imgArqJpg.DblClick abre o zoom da imagem corrente
577:         BINDEVENT(THIS.img_4c_ImgArqJpg, "DblClick", THIS, "ImgArqJpgDblClick")
578: 
579:         THIS.AddObject("lbl_4c_Label31", "Label")
580:         WITH THIS.lbl_4c_Label31
581:             .Top       = 391
582:             .Left      = 411
583:             .Width     = 162
584:             .Height    = 15
585:             .FontName  = "Verdana"
586:             .FontSize  = 8
587:             .ForeColor = RGB(90, 90, 90)
588:             .BackStyle = 0
589:             .AutoSize  = .F.
590:             .Alignment = 0
591:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o Sobre o Arquivo"
592:             .Visible   = .T.
593:         ENDWITH
594: 
595:         THIS.AddObject("obj_4c_GetObsArqs", "EditBox")
596:         WITH THIS.obj_4c_GetObsArqs
597:             .Top          = 407
598:             .Left         = 411
599:             .Width        = 580
600:             .Height       = 181
601:             .FontName     = "Verdana"
602:             .FontSize     = 8
603:             .ForeColor    = RGB(0, 0, 0)
604:             .BackColor    = RGB(255, 255, 255)
605:             .ReadOnly     = .T.
606:             .ScrollBars   = 2
607:             .Visible      = .T.
608:         ENDWITH
609:         *-- ControlSource NAO vai aqui: este metodo roda ANTES de CarregarLista
610:         *-- criar cursor_4c_Dados, e ligar ControlSource a alias inexistente
611:         *-- estoura "Alias 'CURSOR_4C_DADOS' is not found" dentro do TRY do
612:         *-- InicializarForm - CREATEOBJECT devolveria .F. e a tela nunca
613:         *-- abriria (regra #41). O vinculo mora em VincularCamposDetalhe(),
614:         *-- chamado por CarregarLista com o cursor ja existente.
615:     ENDPROC
616: 
617:     *==========================================================================
618:     * ConfigurarCamposAuditoria - Campos somente-leitura de quem/quando o
619:     * vinculo foi incluido (getUsuars/getDatas legado). Enabled=.F. SEMPRE
620:     * (legado: getUsuars.When/getDatas.When = Return .f. - nao alterna por
621:     * modo como getObsArqs, por isso NAO entram em AjustarBotoesPorModo).
622:     * txt_4c_Usuars (getUsuars): Top=595 Left=535 Width=130, ControlSource=
623:     * cursor_4c_Dados.Usuars.
624:     * txt_4c_Datas (getDatas): Top=595 Left=772 Width=143, ControlSource=
625:     * cursor_4c_Dados.Datas.
626:     * lbl_4c_Label1 (Say1) / lbl_4c_Label2 (Say2): classes say com Width no
627:     * dump -> AutoSize=.F. + Alignment=0 (regra #23), ForeColor=RGB(90,90,90).
628:     *==========================================================================
629:     PROTECTED PROCEDURE ConfigurarCamposAuditoria()
630:         THIS.AddObject("lbl_4c_Label1", "Label")
631:         WITH THIS.lbl_4c_Label1
632:             .Top       = 599
633:             .Left      = 414
634:             .Width     = 119
635:             .Height    = 15
636:             .FontName  = "Tahoma"
637:             .FontSize  = 8
638:             .FontBold  = .T.
639:             .ForeColor = RGB(90, 90, 90)
640:             .BackStyle = 0
641:             .AutoSize  = .F.
642:             .Alignment = 0
643:             .Caption   = "Usu" + CHR(225) + "rio de Inclus" + CHR(227) + "o :"
644:             .Visible   = .T.
645:         ENDWITH
646: 
647:         THIS.AddObject("txt_4c_Usuars", "TextBox")
648:         WITH THIS.txt_4c_Usuars
649:             .Top               = 595
650:             .Left              = 535
651:             .Width             = 130
652:             .FontName          = "Tahoma"
653:             .FontSize          = 8
654:             .ForeColor         = RGB(0, 0, 0)
655:             .DisabledForeColor = RGB(0, 0, 0)
656:             .DisabledBackColor = RGB(255, 255, 255)
657:             .SpecialEffect     = 1
658:             .Enabled           = .F.
659:             .Visible           = .T.
660:         ENDWITH
661: 
662:         THIS.AddObject("lbl_4c_Label2", "Label")
663:         WITH THIS.lbl_4c_Label2
664:             .Top       = 599
665:             .Left      = 667
666:             .Width     = 103
667:             .Height    = 15
668:             .FontName  = "Tahoma"
669:             .FontSize  = 8

*-- Linhas 698 a 1071:
698:     *==========================================================================
699:     * VincularCamposDetalhe - Liga os tres campos de detalhe as colunas de
700:     * cursor_4c_Dados. Fica SEPARADO dos metodos Configurar*: estes rodam no
701:     * InicializarForm, ANTES de o cursor existir, e ControlSource de alias
702:     * ausente derruba o Init (medido no VFP9: "Alias 'CURSOR_4C_DADOS' is not
703:     * found" tanto em TextBox como em EditBox) - regra #41. Chamado por
704:     * CarregarLista, que eh o unico ponto onde o cursor esta garantido.
705:     * Idempotente: reatribuir o mesmo ControlSource nao tem efeito colateral.
706:     *==========================================================================
707:     PROTECTED PROCEDURE VincularCamposDetalhe()
708:         IF !USED("cursor_4c_Dados")
709:             RETURN
710:         ENDIF
711: 
712:         THIS.obj_4c_GetObsArqs.ControlSource = "cursor_4c_Dados.ObsArqs"
713:         THIS.txt_4c_Usuars.ControlSource     = "cursor_4c_Dados.Usuars"
714:         THIS.txt_4c_Datas.ControlSource      = "cursor_4c_Dados.Datas"
715:     ENDPROC
716: 
717:     *==========================================================================
718:     * ObterArquivoCorrente - Caminho do arquivo da linha corrente da grade.
719:     * Equivale ao "lcArq = Alltrim(crSigOpArq.Arquivos)" que o legado repete
720:     * em grdArquivos.AfterRowColChange, imgArqJpg.DblClick, btnOpnArqs.Click e
721:     * btnOpnDirs.Click. Devolve "" com o cursor ausente ou em EOF - no legado
722:     * a leitura em EOF trazia o registro em branco e caia no mesmo guard de
723:     * Empty(), entao o resultado eh o mesmo.
724:     *==========================================================================
725:     PROTECTED PROCEDURE ObterArquivoCorrente()
726:         LOCAL loc_cArquivo
727:         loc_cArquivo = ""
728: 
729:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
730:             SELECT cursor_4c_Dados
731:             loc_cArquivo = ALLTRIM(NVL(cursor_4c_Dados.Arquivos, ""))
732:         ENDIF
733: 
734:         RETURN loc_cArquivo
735:     ENDPROC
736: 
737:     *==========================================================================
738:     * ValidarArquivoSelecionado - Guard "Not Empty(lcArq) And File(lcArq)" que
739:     * o legado escreve IDENTICO em tres lugares (btnOpnArqs.Click,
740:     * btnOpnDirs.Click e imgArqJpg.DblClick). Como SigOpArq guarda apenas o
741:     * ENDERECO do arquivo (caminho de rede/mapeamento), o vinculo pode existir
742:     * em banco e o arquivo ja ter sido movido ou apagado - por isso o legado
743:     * testa File() antes de entregar o caminho ao Shell.
744:     *==========================================================================
745:     PROTECTED PROCEDURE ValidarArquivoSelecionado(par_cArquivo)
746:         LOCAL loc_cArquivo
747:         loc_cArquivo = ALLTRIM(NVL(par_cArquivo, ""))
748: 
749:         RETURN !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
750:     ENDPROC
751: 
752:     *==========================================================================
753:     * ValidarExtensaoImagem - Teste de extensao que o legado escreve IDENTICO
754:     * em grdArquivos.AfterRowColChange e imgArqJpg.DblClick:
755:     *   InList(Alltrim(Upper(Substr(lcArq, At([.],lcArq), 5))), ;
756:     *          [.JPG], [.ICO], [.BMP], [.JPEG])
757:     * Transcrito literalmente, inclusive o At(".") - que pega o PRIMEIRO ponto
758:     * do caminho, nao o ultimo (regra #17: formula do legado se transcreve, nao
759:     * se reescreve). O unico acrescimo eh o guard "AT(...) > 0": sem ponto no
760:     * nome o legado chamaria SUBSTR() com posicao inicial zero, e nome sem
761:     * ponto nao casa nenhuma das quatro extensoes de qualquer forma - o
762:     * resultado eh o mesmo em todo caso em que o legado funciona.
763:     *==========================================================================
764:     PROTECTED PROCEDURE ValidarExtensaoImagem(par_cArquivo)
765:         LOCAL loc_cArquivo, loc_nPonto, loc_cExtensao
766:         loc_cArquivo = ALLTRIM(NVL(par_cArquivo, ""))
767: 
768:         IF EMPTY(loc_cArquivo)
769:             RETURN .F.
770:         ENDIF
771: 
772:         loc_nPonto = AT(".", loc_cArquivo)
773:         IF loc_nPonto <= 0
774:             RETURN .F.
775:         ENDIF
776: 
777:         loc_cExtensao = ALLTRIM(UPPER(SUBSTR(loc_cArquivo, loc_nPonto, 5)))
778: 
779:         RETURN INLIST(loc_cExtensao, ".JPG", ".ICO", ".BMP", ".JPEG")
780:     ENDPROC
781: 
782:     *==========================================================================
783:     * GradeAfterRowColChange - grdArquivos.AfterRowColChange do legado: ao
784:     * trocar de linha, repinta o preview da imagem e re-le os tres campos de
785:     * detalhe ligados por ControlSource (txt_4c_Usuars/txt_4c_Datas criados
786:     * nesta fase e obj_4c_GetObsArqs criado na fase 5). Sem este handler os
787:     * campos ficam parados no primeiro registro e o preview nunca aparece -
788:     * popular o cursor nao repinta controle vinculado sozinho (regra #21).
789:     *
790:     * par_nColIndex eh declarado porque BINDEVENT exige a assinatura do evento
791:     * (regra #3), e NAO eh usado como filtro de proposito: o legado tambem nao
792:     * filtra, e o uso correto de AfterRowColChange eh exatamente este - carregar
793:     * o detalhe da linha corrente (regra #46).
794:     *
795:     * O teste de exibicao eh so a extensao, sem File(), igual ao legado: o
796:     * legado reserva o File() para o DblClick do zoom. Picture apontando para
797:     * arquivo inexistente nao estoura em VFP9 - apenas nao desenha (regra #25).
798:     * PUBLIC porque eh alvo de BINDEVENT (regra #3).
799:     *==========================================================================
800:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
801:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
802:             *-- Sem linha corrente nao ha detalhe a exibir: limpar o painel em
803:             *-- vez de deixa-lo parado no registro que acabou de sair da grade
804:             *-- (acontece com a lista vazia e depois de excluir o ultimo
805:             *-- vinculo).
806:             THIS.LimparCampos()
807:             RETURN
808:         ENDIF
809: 
810:         *-- Carga do registro corrente no BO: eh ele que alimenta o painel de
811:         *-- detalhe (cursor -> BO -> controles), para a tela e a gravacao lerem
812:         *-- a MESMA fonte. CarregarDoCursor eh PUBLIC no BO (regra #51).
813:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
814:             THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
815:         ENDIF
816: 
817:         THIS.BOParaForm()
818:     ENDPROC
819: 
820:     *==========================================================================
821:     * ImgArqJpgDblClick - imgArqJpg.DblClick do legado:
822:     *   If Not Empty(lcArq) And File(lcArq) And InList(<extensao>, ...)
823:     *       Do Form SigOpZom With lcArq, [Arquivo : ] + lcArq
824:     *   EndIf
825:     * As duas condicoes viram as duas validacoes desta fase. PUBLIC porque eh
826:     * alvo de BINDEVENT (regra #3).
827:     *==========================================================================
828:     PROCEDURE ImgArqJpgDblClick()
829:         LOCAL loc_cArquivo
830:         loc_cArquivo = THIS.ObterArquivoCorrente()
831: 
832:         IF THIS.ValidarArquivoSelecionado(loc_cArquivo) AND ;
833:            THIS.ValidarExtensaoImagem(loc_cArquivo)
834:             THIS.AbrirFormZoomImagem(loc_cArquivo)
835:         ENDIF
836:     ENDPROC
837: 
838:     *==========================================================================
839:     * AbrirFormZoomImagem - "Do Form SigOpZom With lcArq, [Arquivo : ] + lcArq"
840:     * do legado. DO FORM procura um .SCX, que nao existe no projeto novo (os
841:     * forms sao DEFINE CLASS em .prg), entao o dialogo filho eh aberto com
842:     * CREATEOBJECT do nome LITERAL - assim a classe tambem entra no indice de
843:     * carga sob demanda do config.prg.
844:     *
845:     * SigOpZom esta FORA do escopo desta task e ainda nao foi migrado: o
846:     * CREATEOBJECT vai guardado e a ausencia eh AVISADA ao usuario, em vez de
847:     * estourar "Class definition ... is not found". Quando o modulo for
848:     * migrado esta chamada passa a funcionar sem nenhuma alteracao aqui (mesmo
849:     * tratamento de FormSigMvSbn.AbrirFormZoomImagem).
850:     *
851:     * Show() fica FORA do TRY: form modal chamado dentro de TRY faz qualquer
852:     * erro de runtime da tela filha cair no CATCH do pai, derrubando a
853:     * referencia LOCAL e fechando a janela sozinha (regra #29).
854:     *==========================================================================
855:     PROTECTED PROCEDURE AbrirFormZoomImagem(par_cArquivo)
856:         LOCAL loc_oForm, loc_oErro
857: 
858:         TRY
859:             loc_oForm = CREATEOBJECT("FormSigOpZom", par_cArquivo, ;
860:                 "Arquivo : " + ALLTRIM(par_cArquivo))
861:         CATCH TO loc_oErro
862:             loc_oForm = .NULL.
863:         ENDTRY
864: 
865:         IF VARTYPE(loc_oForm) = "O"
866:             loc_oForm.Show()
867:         ELSE
868:             MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + ;
869:                 CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta " + ;
870:                 "vers" + CHR(227) + "o.", "Aviso")
871:         ENDIF
872:     ENDPROC
873: 
874:     *==========================================================================
875:     * CarregarLista - Popula cursor_4c_Dados via BO.Buscar(fkChaves) e
876:     * reconfigura RecordSource/ControlSource do grid. Width e Header1.Caption
877:     * sao reaplicados DEPOIS do RecordSource (Problema 2/48 - RecordSource
878:     * reseta ambos). GO TOP + Refresh no fim (regra #21/#48 - popular cursor
879:     * nao repinta a grade sozinho). PUBLIC - chamado direto pelo
880:     * TesteAutomatico (regra #3).
881:     *==========================================================================
882:     PROCEDURE CarregarLista()
883:         LOCAL loc_lSucesso
884:         loc_lSucesso = .F.
885: 
886:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
887:             loc_lSucesso = THIS.this_oBusinessObject.Buscar(THIS.this_cArqChaves)
888:         ENDIF
889: 
890:         IF loc_lSucesso AND USED("cursor_4c_Dados")
891:             THIS.grd_4c_Dados.RecordSource = ""
892:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
893:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.Arquivos"
894: 
895:             THIS.grd_4c_Dados.Column1.Width = 778
896:             THIS.grd_4c_Dados.Column1.Header1.Caption = "Arquivos Relacionados [Incluindo " + ;
897:                 "Diret" + CHR(243) + "rio, Caminho de Rede, Mapeamento, etc]"
898: 
899:             *-- Vinculo dos campos de detalhe: aqui o cursor existe (regra #41)
900:             THIS.VincularCamposDetalhe()
901: 
902:             SELECT cursor_4c_Dados
903:             GO TOP
904:             THIS.grd_4c_Dados.Refresh()
905:         ENDIF
906: 
907:         RETURN loc_lSucesso
908:     ENDPROC
909: 
910:     *==========================================================================
911:     * AjustarBotoesPorModo - Transcricao do guard do Init legado:
912:     *
913:     *   If Not InList(.pcEscolha, [INSERIR], [ALTERAR])
914:     *       .shpAlterar.Visible = .f.
915:     *       .btnInsArqs.Visible = .f.
916:     *       .btnExcArqs.Visible = .f.
917:     *       .cmdBtnForm.btnConfirmar.Enabled = .f.
918:     *   EndIf
919:     *
920:     * Inserir/Excluir (e o shape decorativo shpAlterar ao lado deles) ficam
921:     * OCULTOS (Visible, nao so Enabled) fora do modo de manutencao - o
922:     * legado esconde, nao apenas desabilita. Confirmar fica DESABILITADO
923:     * (Enabled), nao oculto - o legado so cita .Enabled para esse botao.
924:     * Abrir Arquivo/Abrir Diretorio ficam sempre ativos (When = .T. no
925:     * legado) e shp_4c_Shape3 nunca eh citado no guard - nenhum dos dois
926:     * entra aqui. O campo de observacao (getObsArqs) segue o MESMO guard
927:     * (getObsArqs.When legado). PUBLIC - chamado direto pelo TesteAutomatico
928:     * (regra #3).
929:     *==========================================================================
930:     PROCEDURE AjustarBotoesPorModo()
931:         LOCAL loc_lPermiteManutencao
932:         loc_lPermiteManutencao = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
933: 
934:         THIS.shp_4c_ShpAlterar.Visible            = loc_lPermiteManutencao
935:         THIS.cmd_4c_BtnInsArqs.Visible             = loc_lPermiteManutencao
936:         THIS.cmd_4c_BtnExcArqs.Visible             = loc_lPermiteManutencao
937:         THIS.cmg_4c_CmdBtnForm.Buttons(2).Enabled  = loc_lPermiteManutencao
938: 
939:         *-- A parte EDITAVEL fica num lugar so (HabilitarCampos), para o modo
940:         *-- nao ser decidido em dois lugares que podem divergir.
941:         THIS.HabilitarCampos(loc_lPermiteManutencao)
942:     ENDPROC
943: 
944:     *==========================================================================
945:     * HabilitarCampos - Liga/desliga a superficie EDITAVEL da tela. Neste form
946:     * ela eh uma so: o EditBox de observacao (getObsArqs legado, cujo
947:     * "When = InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])" eh exatamente
948:     * este guard). Os dois campos de auditoria (txt_4c_Usuars/txt_4c_Datas)
949:     * NAO entram: o legado os trava com "When -> Return .f." em todo modo, sem
950:     * alternar - por isso nascem Enabled=.F. no Configurar* e ficam assim.
951:     * A grade tambem nao: Column1.Text1.When do legado tambem eh "Return .f."
952:     * (o caminho do arquivo se escolhe no GETFILE, nao se digita na celula).
953:     *
954:     * Ponto UNICO de decisao, chamado por AjustarBotoesPorModo - que eh quem
955:     * conhece o modo (this_cEscolha). PUBLIC: chamado pelo harness de teste
956:     * automatico, que invoca os metodos de fora da classe (regra #3).
957:     *==========================================================================
958:     PROCEDURE HabilitarCampos(par_lHabilitar)
959:         LOCAL loc_lHabilitar
960: 
961:         *-- Parametro LOGICO omitido chega como .F. em VFP9; PCOUNT() distingue
962:         *-- "chamou sem argumento" de "pediu desabilitar"
963:         loc_lHabilitar = IIF(PCOUNT() < 1 OR VARTYPE(par_lHabilitar) != "L", ;
964:             INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR"), par_lHabilitar)
965: 
966:         THIS.obj_4c_GetObsArqs.ReadOnly = !loc_lHabilitar
967: 
968:         RETURN loc_lHabilitar
969:     ENDPROC
970: 
971:     *==========================================================================
972:     * LimparCampos - Zera o painel de detalhe (preview + os tres campos
973:     * ligados por ControlSource) quando NAO ha linha corrente na grade: lista
974:     * vazia na abertura, ou exclusao do ultimo vinculo. Sem isto o painel fica
975:     * parado no registro que acabou de sair da grade - o usuario exclui o
976:     * arquivo, ve a grade esvaziar e continua lendo a observacao e o preview
977:     * dele (nao ha erro, nao ha log: so o dado errado na tela).
978:     *
979:     * O preview eh apagado em codigo (Picture nao eh ControlSource - eh
980:     * atribuido a cada troca de linha, legado grdArquivos.AfterRowColChange).
981:     * Os tres campos de detalhe sao ligados por ControlSource, entao em EOF
982:     * basta o Refresh que o legado ja fazia - atribuir .Value neles escreveria
983:     * DE VOLTA no cursor.
984:     *
985:     * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE LimparCampos"
986:     * e o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever sem o
987:     * modificador nao torna o metodo publico, so esconde que ele continua
988:     * protegido (medido no VFP9: PEMSTATUS(oForm,"LimparCampos",2) = .T. mesmo
989:     * sem o PROTECTED escrito, e a chamada de fora estoura "Property
990:     * LIMPARCAMPOS is not found"). Chamado so por THIS., de dentro da classe.
991:     *==========================================================================
992:     PROTECTED PROCEDURE LimparCampos()
993:         *-- Legado: "Clear Resources" antes de trocar o Picture - libera a
994:         *-- imagem anterior do cache do VFP (sem isso o arquivo fica preso em
995:         *-- disco e uma troca de conteudo nao eh relida).
996:         CLEAR RESOURCES
997: 
998:         THIS.img_4c_ImgArqJpg.Picture = ""
999:         THIS.img_4c_ImgArqJpg.Visible = .F.
1000: 
1001:         *-- Legado: getDatas.Refresh / getUsuars.Refresh / getObsArqs.Refresh
1002:         THIS.txt_4c_Usuars.Refresh()
1003:         THIS.txt_4c_Datas.Refresh()
1004:         THIS.obj_4c_GetObsArqs.Refresh()
1005: 
1006:         RETURN .T.
1007:     ENDPROC
1008: 
1009:     *==========================================================================
1010:     * FormParaBO - Transfere o registro corrente da TELA para o Business
1011:     * Object. Direcao form -> BO, usada por SalvarDados antes de gravar.
1012:     *
1013:     * O unico campo que o usuario edita eh a observacao (obj_4c_GetObsArqs):
1014:     * ele eh lido do CONTROLE, nao do cursor, para capturar tambem a digitacao
1015:     * que ainda nao foi descarregada pelo ControlSource (o clique em Confirmar
1016:     * costuma tirar o foco e descarregar, mas confirmar por tecla nao) - e o
1017:     * valor eh devolvido ao cursor com REPLACE, que eh o equivalente do
1018:     * .poDataMgr.Update([crSigOpArq]) do legado empurrando o buffer.
1019:     *
1020:     * pkChaves / fkChaves / Arquivos / Usuars / Datas vem do CURSOR, nao dos
1021:     * controles: sao somente-exibicao (o legado trava os tres com When->.f.) e
1022:     * ler Datas do TextBox devolveria o tipo do controle, nao o DATETIME da
1023:     * coluna - TTOD/comparacao com DATE estouraria erro 11 em runtime
1024:     * (regra #16). A coluna do cursor eh garantidamente datetime.
1025:     *
1026:     * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE FormParaBO"
1027:     * e o VFP9 NAO deixa a subclasse ALARGAR o escopo (mesma razao de
1028:     * LimparCampos, acima). Chamado so por THIS.SalvarDados, de dentro da
1029:     * classe - nada de fora precisa dele.
1030:     *==========================================================================
1031:     PROTECTED PROCEDURE FormParaBO()
1032:         LOCAL loc_lSucesso, loc_cObs
1033:         loc_lSucesso = .F.
1034: 
1035:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Dados") ;
1036:            AND !EOF("cursor_4c_Dados")
1037: 
1038:             SELECT cursor_4c_Dados
1039:             loc_cObs = TratarNulo(THIS.obj_4c_GetObsArqs.Value, "")
1040: 
1041:             *-- Descarrega a observacao digitada no cursor. O guard de
1042:             *-- ReadOnly evita REPLACE em cursor nao gravavel (o BO ja entrega
1043:             *-- cursor_4c_Dados READWRITE) e o de diferenca evita marcar a
1044:             *-- linha quando nada mudou.
1045:             IF !ISREADONLY("cursor_4c_Dados") ;
1046:                AND TratarNulo(cursor_4c_Dados.ObsArqs, "") != loc_cObs
1047:                 REPLACE cursor_4c_Dados.ObsArqs WITH loc_cObs
1048:             ENDIF
1049: 
1050:             WITH THIS.this_oBusinessObject
1051:                 .this_cPkChaves = ALLTRIM(TratarNulo(cursor_4c_Dados.pkChaves, ""))
1052:                 .this_cArquivos = ALLTRIM(TratarNulo(cursor_4c_Dados.Arquivos, ""))
1053:                 .this_cObsArqs  = loc_cObs
1054:                 .this_cUsuars   = ALLTRIM(TratarNulo(cursor_4c_Dados.Usuars, ""))
1055:                 .this_dDatas    = TratarNulo(cursor_4c_Dados.Datas, {})
1056: 
1057:                 *-- fkChaves eh a chave de amarracao que o form PAI passou no
1058:                 *-- Init: o cursor so a traz nas linhas ja gravadas, entao o
1059:                 *-- valor do form eh o fallback (nunca gravar em branco - eh a
1060:                 *-- coluna que liga o arquivo ao registro do pai).
1061:                 .this_cFkChaves = ALLTRIM(TratarNulo(cursor_4c_Dados.fkChaves, ""))
1062:                 IF EMPTY(.this_cFkChaves)
1063:                     .this_cFkChaves = THIS.this_cArqChaves
1064:                 ENDIF
1065:             ENDWITH
1066: 
1067:             loc_lSucesso = .T.
1068:         ENDIF
1069: 
1070:         RETURN loc_lSucesso
1071:     ENDPROC

*-- Linhas 1088 a 1222:
1088:     * o File() para o DblClick do zoom, e Picture apontando para arquivo
1089:     * inexistente nao estoura em VFP9, apenas nao desenha - regra #25).
1090:     *
1091:     * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE BOParaForm"
1092:     * e o VFP9 NAO deixa a subclasse ALARGAR o escopo (mesma razao de
1093:     * LimparCampos, acima). Chamado so por THIS.GradeAfterRowColChange, de
1094:     * dentro da classe - nada de fora precisa dele.
1095:     *==========================================================================
1096:     PROTECTED PROCEDURE BOParaForm()
1097:         LOCAL loc_lSucesso, loc_cArquivo
1098:         loc_lSucesso = .F.
1099: 
1100:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1101:             THIS.LimparCampos()
1102:         ELSE
1103:             SELECT cursor_4c_Dados
1104: 
1105:             *-- Legado: "Update crSigOpArq Set ObsArqs = Nvl(ObsArqs, [])"
1106:             IF ISNULL(cursor_4c_Dados.ObsArqs) ;
1107:                AND !ISREADONLY("cursor_4c_Dados")
1108:                 REPLACE cursor_4c_Dados.ObsArqs WITH ""
1109:             ENDIF
1110: 
1111:             *-- Preview: o caminho vem do BO quando ele esta carregado (fonte
1112:             *-- unica com a gravacao), e do cursor quando nao esta.
1113:             IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
1114:                AND !EMPTY(ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cArquivos, "")))
1115:                 loc_cArquivo = ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cArquivos, ""))
1116:             ELSE
1117:                 loc_cArquivo = THIS.ObterArquivoCorrente()
1118:             ENDIF
1119: 
1120:             CLEAR RESOURCES
1121: 
1122:             THIS.img_4c_ImgArqJpg.Picture = ""
1123:             THIS.img_4c_ImgArqJpg.Visible = .F.
1124: 
1125:             IF THIS.ValidarExtensaoImagem(loc_cArquivo)
1126:                 THIS.img_4c_ImgArqJpg.Picture = loc_cArquivo
1127:                 THIS.img_4c_ImgArqJpg.Visible = .T.
1128:             ENDIF
1129: 
1130:             *-- Legado: getDatas.Refresh / getUsuars.Refresh / getObsArqs.Refresh
1131:             THIS.txt_4c_Usuars.Refresh()
1132:             THIS.txt_4c_Datas.Refresh()
1133:             THIS.obj_4c_GetObsArqs.Refresh()
1134: 
1135:             loc_lSucesso = .T.
1136:         ENDIF
1137: 
1138:         RETURN loc_lSucesso
1139:     ENDPROC
1140: 
1141:     *==========================================================================
1142:     * SalvarDados - "salvardados" PROCEDURE do legado SIGOPDOC.SCX:
1143:     *
1144:     *   Local llOks
1145:     *   llOks = .t.
1146:     *   If Not ThisForm.poDataMgr.Update([crSigOpArq])
1147:     *       =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
1148:     *       llOks = .f.
1149:     *   EndIf
1150:     *   If llOks And (ThisForm.poDataMgr.Commit() < 1)
1151:     *       =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
1152:     *       llOks = .f.
1153:     *   EndIf
1154:     *   If Not llOks
1155:     *       ThisForm.poDataMgr.RollBack()
1156:     *   EndIf
1157:     *   Return llOks
1158:     *
1159:     * O legado liga crSigOpArq a um cursor COM BUFFERING (.AddCursor): os
1160:     * Inserts/Deletes de btnInsArqs/btnExcArqs so editam o buffer local, e
1161:     * eh aqui - no clique de Confirmar - que .Update()/.Commit() de fato
1162:     * grava tudo no SQL Server (desfazendo com .RollBack() se falhar).
1163:     *
1164:     * Na arquitetura nova esse buffering nao existe: BtnInsArqsClick/
1165:     * BtnExcArqsClick ja gravam direto via BO.Inserir()/BO.Excluir() (fase
1166:     * 4 - "equivalente ao legado, mas gravando direto"). O que continua
1167:     * sujeito a confirmacao explicita eh a edicao do campo Observacao
1168:     * (obj_4c_GetObsArqs), ligado por ControlSource a cursor_4c_Dados - um
1169:     * cursor LOCAL (populado por SQLEXEC), desconectado do servidor: editar
1170:     * ali muda o cursor na memoria, nao a tabela. Varrer o cursor e
1171:     * empurrar cada linha para SigOpArq via BO.Atualizar() (que grava
1172:     * Arquivos/ObsArqs/Usuars/Datas - regra #41-like, cada UPDATE confirma
1173:     * por si so) eh o equivalente funcional do Update()/Commit() do legado.
1174:     *
1175:     * BO.Atualizar() ja exibe o proprio MsgErro com o texto do SQL Server em
1176:     * caso de falha (igual a Inserir/Excluir/ExecutarExclusao) - nao
1177:     * duplicar a mensagem aqui (regra #20: falha de gravacao ja eh
1178:     * reportada por quem grava).
1179:     *
1180:     * PUBLIC: chamado por BtnConfirmarClick (BINDEVENT) e pelo harness.
1181:     *==========================================================================
1182:     PROCEDURE SalvarDados()
1183:         LOCAL loc_lSucesso, loc_nRegistro
1184: 
1185:         loc_lSucesso = .T.
1186: 
1187:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Dados")
1188:             SELECT cursor_4c_Dados
1189: 
1190:             *-- FormParaBO primeiro, na linha CORRENTE: eh ele que descarrega
1191:             *-- no cursor a observacao que esta na tela e ainda pode nao ter
1192:             *-- passado pelo ControlSource (confirmar por tecla nao tira o foco
1193:             *-- do EditBox). Sem isto a ultima digitacao do usuario se perde
1194:             *-- SEM aviso - ele ve "salvo com sucesso" e o texto nao foi.
1195:             THIS.FormParaBO()
1196: 
1197:             *-- O SCAN mexe no ponteiro; guardar para devolver a grade a linha
1198:             *-- em que o usuario estava (COUNT/SCAN tem de repor o RECNO).
1199:             loc_nRegistro = IIF(EOF("cursor_4c_Dados"), 0, RECNO("cursor_4c_Dados"))
1200: 
1201:             SELECT cursor_4c_Dados
1202:             SCAN
1203:                 IF !(THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados") AND ;
1204:                      THIS.this_oBusinessObject.Atualizar())
1205:                     loc_lSucesso = .F.
1206:                 ENDIF
1207:             ENDSCAN
1208: 
1209:             SELECT cursor_4c_Dados
1210:             IF loc_nRegistro > 0 AND loc_nRegistro <= RECCOUNT("cursor_4c_Dados")
1211:                 GO loc_nRegistro
1212:             ELSE
1213:                 GO TOP
1214:             ENDIF
1215: 
1216:             *-- Repor o BO na linha corrente: o SCAN deixou nele o ULTIMO
1217:             *-- registro do cursor, e quem ler o BO depois disso (BOParaForm,
1218:             *-- auditoria) veria o registro errado.
1219:             THIS.FormParaBO()
1220:         ENDIF
1221: 
1222:         RETURN loc_lSucesso

*-- Linhas 1234 a 1417:
1234:     * .RollBack() do legado. As inclusoes e exclusoes de vinculo NAO sao
1235:     * desfeitas porque elas ja gravaram direto (BtnInsArqsClick/
1236:     * BtnExcArqsClick via BO.Inserir()/BO.Excluir()).
1237:     * PUBLIC: chamado por BINDEVENT (regra #3) e pelo harness.
1238:     *==========================================================================
1239:     PROCEDURE BtnCancelarClick()
1240:         THIS.Release()
1241:     ENDPROC
1242: 
1243:     *==========================================================================
1244:     * BtnSairClick - Nome do OBJETO no legado (btnSair). Mantido como ponto de
1245:     * entrada para quem referencia o nome do legado; a logica mora em
1246:     * BtnCancelarClick, que eh o nome canonico desta acao no sistema novo.
1247:     * PUBLIC: alvo de BINDEVENT (regra #3) e do harness de teste automatico.
1248:     *==========================================================================
1249:     PROCEDURE BtnSairClick()
1250:         THIS.BtnCancelarClick()
1251:     ENDPROC
1252: 
1253:     *==========================================================================
1254:     * BtnConfirmarClick - btnConfirmar.Click do legado:
1255:     *
1256:     *   If ThisForm.SalvarDados()
1257:     *       ThisForm.Release
1258:     *   Else
1259:     *       Return .f.
1260:     *   EndIf
1261:     *
1262:     * SalvarDados() ja exibe o proprio erro em caso de falha (via
1263:     * BO.Atualizar) - retornar .F. aqui apenas mantem a tela aberta para o
1264:     * usuario corrigir e tentar de novo, igual ao legado.
1265:     * PUBLIC: chamado por BINDEVENT (regra #3) e pelo harness.
1266:     *==========================================================================
1267:     PROCEDURE BtnConfirmarClick()
1268:         IF THIS.SalvarDados()
1269:             THIS.Release()
1270:         ENDIF
1271:     ENDPROC
1272: 
1273:     *==========================================================================
1274:     * BtnInsArqsClick - Seleciona um arquivo via GETFILE() e grava o vinculo
1275:     * (equivalente ao "Insert Into crSigOpArq" do legado, mas gravando direto
1276:     * via BO.Inserir()). Recarrega a grade e posiciona no registro incluido.
1277:     *==========================================================================
1278:     PROCEDURE BtnInsArqsClick()
1279:         LOCAL loc_cArquivo
1280:         loc_cArquivo = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
1281:             "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
1282: 
1283:         IF !EMPTY(loc_cArquivo)
1284:             THIS.this_oBusinessObject.this_cPkChaves = ""
1285:             THIS.this_oBusinessObject.this_cFkChaves = THIS.this_cArqChaves
1286:             THIS.this_oBusinessObject.this_cArquivos = UPPER(loc_cArquivo)
1287:             THIS.this_oBusinessObject.this_cObsArqs  = ""
1288:             THIS.this_oBusinessObject.this_cUsuars   = ""
1289:             THIS.this_oBusinessObject.this_dDatas    = {}
1290: 
1291:             IF THIS.this_oBusinessObject.Inserir()
1292:                 THIS.CarregarLista()
1293:                 IF USED("cursor_4c_Dados")
1294:                     *-- Posiciona na linha recem-incluida (pela PK que o BO
1295:                     *-- acabou de gerar), nao no fim do cursor: a lista nao
1296:                     *-- volta do banco necessariamente na ordem de inclusao.
1297:                     SELECT cursor_4c_Dados
1298:                     LOCATE FOR ALLTRIM(TratarNulo(cursor_4c_Dados.pkChaves, "")) == ;
1299:                         ALLTRIM(THIS.this_oBusinessObject.this_cPkChaves)
1300:                     IF !FOUND()
1301:                         GO BOTTOM
1302:                     ENDIF
1303:                     THIS.grd_4c_Dados.Refresh()
1304:                 ENDIF
1305:                 *-- Repintar o painel de detalhe TAMBEM aqui: a grade acabou de
1306:                 *-- ser reposicionada e Grid.Refresh nao dispara
1307:                 *-- AfterRowColChange (regra #21 - o metodo unico roda em todo
1308:                 *-- caminho que popula/reposiciona o cursor).
1309:                 THIS.GradeAfterRowColChange(1)
1310:                 THIS.grd_4c_Dados.SetFocus()
1311:                 THIS.grd_4c_Dados.Column1.SetFocus()
1312:             ENDIF
1313:         ENDIF
1314:     ENDPROC
1315: 
1316:     *==========================================================================
1317:     * BtnOpnArqsClick - Abre o arquivo da linha corrente da grade via Shell
1318:     * (equivalente ao legado, que usava Shell.Application.Open()).
1319:     *==========================================================================
1320:     PROCEDURE BtnOpnArqsClick()
1321:         LOCAL loc_cArquivo, loc_oApp
1322:         loc_cArquivo = THIS.ObterArquivoCorrente()
1323: 
1324:         IF THIS.ValidarArquivoSelecionado(loc_cArquivo)
1325:             loc_oApp = CREATEOBJECT("Shell.Application")
1326:             loc_oApp.Open(loc_cArquivo)
1327:         ELSE
1328:             MsgAviso("Arquivo n" + CHR(227) + "o encontrado!", "Aten" + CHR(231) + CHR(227) + "o")
1329:         ENDIF
1330:     ENDPROC
1331: 
1332:     *==========================================================================
1333:     * BtnExcArqsClick - Remove o vinculo do arquivo corrente (via BO.Excluir -
1334:     * PUBLIC, regra #51). NAO apaga o arquivo fisico, so o vinculo em
1335:     * SigOpArq (equivalente ao "Delete In crSigOpArq" do legado).
1336:     *==========================================================================
1337:     PROCEDURE BtnExcArqsClick()
1338:         LOCAL loc_lConfirma
1339: 
1340:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1341:             RETURN
1342:         ENDIF
1343: 
1344:         SELECT cursor_4c_Dados
1345:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do v" + ;
1346:             CHR(237) + "nculo deste arquivo?" + CHR(13) + ;
1347:             "(O arquivo f" + CHR(237) + "sico N" + CHR(227) + "O ser" + CHR(225) + ;
1348:             " apagado)", "Confirmar")
1349: 
1350:         IF loc_lConfirma
1351:             THIS.this_oBusinessObject.this_cPkChaves = ALLTRIM(cursor_4c_Dados.pkChaves)
1352: 
1353:             IF THIS.this_oBusinessObject.Excluir()
1354:                 THIS.CarregarLista()
1355:                 *-- Mesma razao do BtnInsArqsClick: a linha que o painel de
1356:                 *-- detalhe exibia acabou de desaparecer (regra #21).
1357:                 THIS.GradeAfterRowColChange(1)
1358:                 THIS.grd_4c_Dados.SetFocus()
1359:                 THIS.grd_4c_Dados.Column1.SetFocus()
1360:             ENDIF
1361:         ENDIF
1362:     ENDPROC
1363: 
1364:     *==========================================================================
1365:     * BtnOpnDirsClick - Abre o diretorio (JUSTPATH) onde o arquivo corrente
1366:     * esta gravado, via Shell (equivalente ao legado).
1367:     *==========================================================================
1368:     PROCEDURE BtnOpnDirsClick()
1369:         LOCAL loc_cArquivo, loc_oApp
1370:         loc_cArquivo = THIS.ObterArquivoCorrente()
1371: 
1372:         IF THIS.ValidarArquivoSelecionado(loc_cArquivo)
1373:             loc_oApp = CREATEOBJECT("Shell.Application")
1374:             loc_oApp.Open(JUSTPATH(loc_cArquivo))
1375:         ELSE
1376:             MsgAviso("Arquivo n" + CHR(227) + "o encontrado!", "Aten" + CHR(231) + CHR(227) + "o")
1377:         ENDIF
1378:     ENDPROC
1379: 
1380:     *==========================================================================
1381:     * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda a
1382:     * hierarquia. Form flat sem containers flutuantes, portanto sem lista de
1383:     * skip (a imagem de preview - imgArqJpg/img_4c_ImgArqJpg - nasce oculta
1384:     * de proposito e sera tratada na fase que a criar).
1385:     *==========================================================================
1386:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1387:         LOCAL loc_i, loc_oControl
1388: 
1389:         FOR loc_i = 1 TO par_oContainer.ControlCount
1390:             loc_oControl = par_oContainer.Controls(loc_i)
1391: 
1392:             IF VARTYPE(loc_oControl) = "O"
1393:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1394:                     loc_oControl.Visible = .T.
1395:                 ENDIF
1396:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1397:                     THIS.TornarControlesVisiveis(loc_oControl)
1398:                 ENDIF
1399:             ENDIF
1400:         ENDFOR
1401:     ENDPROC
1402: 
1403:     *==========================================================================
1404:     * Destroy - Libera o cursor de dados e o Business Object. DODEFAULT no
1405:     * fim (FormBase.Destroy reconstroi o menu principal apos form modal).
1406:     *==========================================================================
1407:     PROCEDURE Destroy()
1408:         IF USED("cursor_4c_Dados")
1409:             USE IN cursor_4c_Dados
1410:         ENDIF
1411: 
1412:         THIS.this_oBusinessObject = .NULL.
1413: 
1414:         DODEFAULT()
1415:     ENDPROC
1416: 
1417: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpDocBO.prg):
*==============================================================================
* SigOpDocBO.prg - Business Object para Relacao de Arquivos e Documentos
* Form OPERACIONAL - dialogo filho instanciado com DO FORM SigOpDoc WITH
* par_cChave, par_cEscolha (legado: Lparameters pKey, pEsc)
* Legado: SIGOPDOC.SCX
* Tabela principal: SigOpArq | PK: pkChaves (gerada por fUniqueIds())
* Chave de amarracao (fkChaves): recebida do form pai - EmpDopNums, CPros,
* IClis, etc., conforme a tela que abriu este dialogo
*==============================================================================

DEFINE CLASS SigOpDocBO AS BusinessBase

    *-- Propriedades de SigOpArq (registro corrente da grade de arquivos)
    this_cPkChaves = ""    && pkChaves  CHAR(20) NOT NULL - chave primaria (fUniqueIds)
    this_cFkChaves = ""    && fkChaves  CHAR(30)          - chave de amarracao ao registro pai
    this_cArquivos = ""    && Arquivos  CHAR(250) NOT NULL - caminho/nome do arquivo vinculado
    this_cObsArqs  = ""    && ObsArqs   TEXT             - observacao sobre o arquivo
    this_cUsuars   = ""    && Usuars    CHAR(10) NOT NULL - usuario que incluiu o vinculo
    this_dDatas    = {}    && Datas     DATETIME          - data/hora de inclusao do vinculo

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigOpArq"
        THIS.this_cCampoChave = "pkChaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria (pkChaves) para uso em
    * RegistrarAuditoria(). PROTECTED (regra #51 - nunca chamado de fora).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cPkChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia todas as colunas de SigOpArq (vindas do
    * cursor crSigOpArq/cursor_4c_Dados, uma linha = um arquivo vinculado)
    * para as propriedades do BO. SEMPRE SELECT (par_cAliasCursor) antes de
    * acessar os campos (regra #9 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cPkChaves = TratarNulo(pkChaves, "")
                THIS.this_cFkChaves = TratarNulo(fkChaves, "")
                THIS.this_cArquivos = TratarNulo(Arquivos, "")
                THIS.this_cObsArqs  = TratarNulo(ObsArqs, "")
                THIS.this_cUsuars   = TratarNulo(Usuars, "")
                THIS.this_dDatas    = TratarNulo(Datas, {})

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista os arquivos vinculados a chave de amarracao recebida do
    * form pai (fkChaves). Retorna cursor_4c_Dados com pkChaves/fkChaves/
    * Arquivos/ObsArqs/Usuars/Datas (regra #42 - chave char(30), PADR ao
    * montar o WHERE, nunca ALLTRIM nas partes). Equivalente a
    * "Select * From SigOpArq Where fkChaves = Padr(pKey, 30)" do Init legado.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (pkChaves C(20), fkChaves C(30), ;
                        Arquivos C(250), ObsArqs M, Usuars C(10), Datas T)
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT pkchaves, fkchaves, arquivos, obsarqs, usuars, datas"
                loc_cSQL = loc_cSQL + " FROM SigOpArq"
                loc_cSQL = loc_cSQL + " WHERE fkchaves = " + ;
                    EscaparSQL(PADR(ALLTRIM(NVL(par_cChave, "")), 30))

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

                IF loc_nResultado >= 0
                    *-- Cursor de SQL pass-through nasce SOMENTE-LEITURA. O
                    *-- EditBox da observacao (getObsArqs) esta ligado a este
                    *-- cursor por ControlSource: sem READWRITE ele nao aceita
                    *-- uma tecla sequer e SalvarDados nunca teria o que gravar
                    *-- - e nao ha erro nenhum na tela, so o campo inerte.
                    *-- O legado liga crSigOpArq por .AddCursor (cursor COM
                    *-- buffering, gravavel - a prova esta no proprio Init,
                    *-- que faz "Update crSigOpArq Set ObsArqs = ..."), entao
                    *-- converter para READWRITE eh o que REPRODUZ o legado.
                    *-- SQLEXEC vai para alias TEMPORARIO porque derrubar o
                    *-- alias ligado ao Grid zera o ColumnCount.
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF

                    SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE

                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF

                    *-- Legado, logo depois do Requery: "Update crSigOpArq Set
                    *-- ObsArqs = Nvl(ObsArqs, [])". Sem isto a coluna TEXT
                    *-- nula chega ao EditBox como .NULL. e eh isso que o
                    *-- usuario le na tela.
                    SELECT cursor_4c_Dados
                    SCAN FOR ISNULL(cursor_4c_Dados.ObsArqs)
                        REPLACE cursor_4c_Dados.ObsArqs WITH ""
                    ENDSCAN

                    *-- Legado: "Go Top In crSigOpArq"
                    SELECT cursor_4c_Dados
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar os arquivos vinculados:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo vinculo de arquivo em SigOpArq.
    * PK (pkChaves) gerada via fUniqueIds() se ainda nao preenchida -
    * equivalente a "fUniqueIds()" do btnInsArqs.Click legado.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cPkChaves, "")))
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Usuars/Datas = usuario e data/hora da inclusao do vinculo
            *-- (equivalente a "Usuar, Datetime()" do legado)
            IF EMPTY(ALLTRIM(NVL(THIS.this_cUsuars, "")))
                THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpArq ("
            loc_cSQL = loc_cSQL + "pkchaves, fkchaves, arquivos, obsarqs, usuars, datas"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPkChaves, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cFkChaves, 30)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cArquivos, 250)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObsArqs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir o v" + CHR(237) + "nculo do arquivo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza vinculo de arquivo existente em SigOpArq
    * (por pkChaves). fkChaves nao muda depois de gravado - o UPDATE cobre
    * apenas os campos que a tela permite editar (Arquivos, ObsArqs).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpArq SET"
            loc_cSQL = loc_cSQL + " arquivos = " + EscaparSQL(LEFT(THIS.this_cArquivos, 250)) + ","
            loc_cSQL = loc_cSQL + " obsarqs = " + EscaparSQL(THIS.this_cObsArqs) + ","
            loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas)
            loc_cSQL = loc_cSQL + " WHERE pkchaves = " + EscaparSQL(LEFT(THIS.this_cPkChaves, 20))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar o v" + CHR(237) + "nculo do arquivo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove o vinculo de arquivo corrente de SigOpArq
    * (por pkChaves). PROTECTED (regra #51 - de fora sempre Excluir()).
    * Equivalente a "Delete In crSigOpArq" do btnExcArqs.Click legado, mas
    * gravando a exclusao direto no SQL Server (nao ha mais commit em lote).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cPkChaves, "")))
                THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                    " v" + CHR(237) + "nculo de arquivo selecionado para excluir."
            ELSE
                loc_cSQL = "DELETE FROM SigOpArq WHERE pkchaves = " + ;
                    EscaparSQL(LEFT(THIS.this_cPkChaves, 20))

                IF USED("cursor_4c_Delete")
                    USE IN cursor_4c_Delete
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir o v" + CHR(237) + "nculo do arquivo:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    IF USED("cursor_4c_Delete")
                        USE IN cursor_4c_Delete
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

