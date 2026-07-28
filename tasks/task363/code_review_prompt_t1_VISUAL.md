# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 176: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 199: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 222: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 245: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 268: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 303: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 382: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 405: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCES.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1191 linhas total):

*-- Linhas 78 a 98:
78:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
79: 
80:         WITH THIS.pgf_4c_Paginas
81:             .Top       = -29
82:             .Left      = 0
83:             .Width     = THIS.Width
84:             .Height    = THIS.Height + 29
85:             .PageCount = 2
86:             .Tabs      = .F.
87:             .Visible   = .T.
88: 
89:             .Page1.Caption   = "Lista"
90:             .Page1.BackColor = RGB(255, 255, 255)
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92: 
93:             .Page2.Caption   = "Dados"
94:             .Page2.BackColor = RGB(255, 255, 255)
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:         ENDWITH
97:     ENDPROC
98: 

*-- Linhas 109 a 146:
109:         *-- Cabe&#231;alho cinza escuro (cntSombra do legado)
110:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH loc_oPagina.cnt_4c_Cabecalho
112:             .Top         = 31
113:             .Left        = 0
114:             .Width       = THIS.Width
115:             .Height      = 80
116:             .BackColor   = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible     = .T.
119:         ENDWITH
120: 
121:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
122:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
123:             .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Estoque"
124:             .Top       = 15
125:             .Left      = 12
126:             .Width     = THIS.Width
127:             .Height    = 40
128:             .FontName  = "Tahoma"
129:             .FontSize  = 16
130:             .FontBold  = .T.
131:             .ForeColor = RGB(0, 0, 0)
132:             .BackStyle = 0
133:             .AutoSize  = .F.
134:             .Visible   = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
139:             .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Estoque"
140:             .Top       = 18
141:             .Left      = 10
142:             .Width     = THIS.Width
143:             .Height    = 46
144:             .FontName  = "Tahoma"
145:             .FontSize  = 16
146:             .FontBold  = .T.

*-- Linhas 153 a 274:
153:         *-- Container de bot&#245;es CRUD (lado direito) - bot&#245;es adicionados na Fase 4
154:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
155:         WITH loc_oPagina.cnt_4c_Botoes
156:             .Top         = 29
157:             .Left        = 542
158:             .Width       = 390
159:             .Height      = 85
160:             .BackStyle = 0
161:             .BorderWidth = 0
162:             .Visible     = .T.
163:         ENDWITH
164: 
165:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
166:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
167:             .Caption         = "Incluir"
168:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
169:             .PicturePosition = 13
170:             .Top             = 5
171:             .Left            = 5
172:             .Width           = 75
173:             .Height          = 75
174:             .BackColor       = RGB(255, 255, 255)
175:             .ForeColor       = RGB(90, 90, 90)
176:             .FontName        = "Comic Sans MS"
177:             .FontBold        = .T.
178:             .FontItalic      = .T.
179:             .FontSize        = 8
180:             .Themes          = .F.
181:             .SpecialEffect   = 0
182:             .MousePointer    = 15
183:             .WordWrap        = .T.
184:             .AutoSize        = .F.
185:             .Visible         = .T.
186:         ENDWITH
187: 
188:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
189:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
190:             .Caption         = "Visualizar"
191:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
192:             .PicturePosition = 13
193:             .Top             = 5
194:             .Left            = 80
195:             .Width           = 75
196:             .Height          = 75
197:             .BackColor       = RGB(255, 255, 255)
198:             .ForeColor       = RGB(90, 90, 90)
199:             .FontName        = "Comic Sans MS"
200:             .FontBold        = .T.
201:             .FontItalic      = .T.
202:             .FontSize        = 8
203:             .Themes          = .F.
204:             .SpecialEffect   = 0
205:             .MousePointer    = 15
206:             .WordWrap        = .T.
207:             .AutoSize        = .F.
208:             .Visible         = .T.
209:         ENDWITH
210: 
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
213:             .Caption         = "Alterar"
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
215:             .PicturePosition = 13
216:             .Top             = 5
217:             .Left            = 155
218:             .Width           = 75
219:             .Height          = 75
220:             .BackColor       = RGB(255, 255, 255)
221:             .ForeColor       = RGB(90, 90, 90)
222:             .FontName        = "Comic Sans MS"
223:             .FontBold        = .T.
224:             .FontItalic      = .T.
225:             .FontSize        = 8
226:             .Themes          = .F.
227:             .SpecialEffect   = 0
228:             .MousePointer    = 15
229:             .WordWrap        = .T.
230:             .AutoSize        = .F.
231:             .Visible         = .T.
232:         ENDWITH
233: 
234:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
235:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
236:             .Caption         = "Excluir"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
238:             .PicturePosition = 13
239:             .Top             = 5
240:             .Left            = 230
241:             .Width           = 75
242:             .Height          = 75
243:             .BackColor       = RGB(255, 255, 255)
244:             .ForeColor       = RGB(90, 90, 90)
245:             .FontName        = "Comic Sans MS"
246:             .FontBold        = .T.
247:             .FontItalic      = .T.
248:             .FontSize        = 8
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .MousePointer    = 15
252:             .WordWrap        = .T.
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256: 
257:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
258:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
259:             .Caption         = "Buscar"
260:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
261:             .PicturePosition = 13
262:             .Top             = 5
263:             .Left            = 305
264:             .Width           = 75
265:             .Height          = 75
266:             .BackColor       = RGB(255, 255, 255)
267:             .ForeColor       = RGB(90, 90, 90)
268:             .FontName        = "Comic Sans MS"
269:             .FontBold        = .T.
270:             .FontItalic      = .T.
271:             .FontSize        = 8
272:             .Themes          = .F.
273:             .SpecialEffect   = 0
274:             .MousePointer    = 15

*-- Linhas 280 a 332:
280:         *-- Container Encerrar (can&#244;nico - posi&#231;&#227;o fixa Left=917)
281:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
282:         WITH loc_oPagina.cnt_4c_Saida
283:             .Top         = 29
284:             .Left        = 917
285:             .Width       = 90
286:             .Height      = 85
287:             .BackStyle   = 0
288:             .BorderWidth = 0
289:             .Visible     = .T.
290:         ENDWITH
291: 
292:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
293:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
294:             .Caption         = "Encerrar"
295:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
296:             .PicturePosition = 13
297:             .Top             = 5
298:             .Left            = 5
299:             .Width           = 75
300:             .Height          = 75
301:             .BackColor       = RGB(255, 255, 255)
302:             .ForeColor       = RGB(90, 90, 90)
303:             .FontName        = "Comic Sans MS"
304:             .FontBold        = .T.
305:             .FontItalic      = .T.
306:             .FontSize        = 8
307:             .Themes          = .F.
308:             .SpecialEffect   = 0
309:             .MousePointer    = 15
310:             .WordWrap        = .T.
311:             .AutoSize        = .F.
312:             .Visible         = .T.
313:         ENDWITH
314: 
315:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
316: 
317:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
318:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
319:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
320:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
321:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
322: 
323:         *-- Grid de listagem: clacods, clagrupos, clacontas, setors
324:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
325:         WITH loc_oPagina.grd_4c_Lista
326:             .Top                = 127
327:             .Left               = 30
328:             .Width              = 939
329:             .Height             = 487
330:             .ColumnCount        = 4
331:             .FontName           = "Verdana"
332:             .FontSize           = 8

*-- Linhas 360 a 430:
360:         *-- Container Salvar/Cancelar (Grupo_Salva do legado)
361:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
362:         WITH loc_oPagina.cnt_4c_Salva
363:             .Top         = 33
364:             .Left        = 842
365:             .Width       = 160
366:             .Height      = 85
367:             .BackStyle   = 0
368:             .Visible     = .T.
369:         ENDWITH
370: 
371:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
372:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
373:             .Caption         = "Confirmar"
374:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
375:             .PicturePosition = 13
376:             .Top             = 5
377:             .Left            = 5
378:             .Width           = 75
379:             .Height          = 75
380:             .BackColor       = RGB(255, 255, 255)
381:             .ForeColor       = RGB(90, 90, 90)
382:             .FontName        = "Comic Sans MS"
383:             .FontBold        = .T.
384:             .FontItalic      = .T.
385:             .FontSize        = 8
386:             .Themes          = .F.
387:             .SpecialEffect   = 0
388:             .MousePointer    = 15
389:             .WordWrap        = .T.
390:             .AutoSize        = .F.
391:             .Visible         = .T.
392:         ENDWITH
393: 
394:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
395:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
396:             .Caption         = "Encerrar"
397:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
398:             .PicturePosition = 13
399:             .Top             = 5
400:             .Left            = 80
401:             .Width           = 75
402:             .Height          = 75
403:             .BackColor       = RGB(255, 255, 255)
404:             .ForeColor       = RGB(90, 90, 90)
405:             .FontName        = "Comic Sans MS"
406:             .FontBold        = .T.
407:             .FontItalic      = .T.
408:             .FontSize        = 8
409:             .Themes          = .F.
410:             .SpecialEffect   = 0
411:             .MousePointer    = 15
412:             .WordWrap        = .T.
413:             .AutoSize        = .F.
414:             .Visible         = .T.
415:         ENDWITH
416: 
417:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
418:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
419: 
420:         *-- Label: C&#243;digo (Say2 do legado - Top=190+29=219, Left=411)
421:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
422:         WITH loc_oPagina.lbl_4c_Codigo
423:             .Caption   = "C" + CHR(243) + "digo :"
424:             .Top       = 219
425:             .Left      = 411
426:             .Width     = 60
427:             .Height    = 17
428:             .FontName  = "Tahoma"
429:             .FontSize  = 8
430:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 437 a 463:
437:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
438:         WITH loc_oPagina.txt_4c_Codigo
439:             .Value         = ""
440:             .Top           = 215
441:             .Left          = 455
442:             .Width         = 132
443:             .Height        = 23
444:             .FontName      = "Tahoma"
445:             .FontSize      = 8
446:             .ForeColor     = RGB(0, 0, 0)
447:             .BorderColor   = RGB(100, 100, 100)
448:             .SpecialEffect = 1
449:             .MaxLength     = 20
450:             .Visible       = .T.
451:         ENDWITH
452: 
453:         *-- Label: Grupo (Say1 do legado - Top=215+29=244, Left=415)
454:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
455:         WITH loc_oPagina.lbl_4c_Grupo
456:             .Caption   = "Grupo :"
457:             .Top       = 244
458:             .Left      = 415
459:             .Width     = 60
460:             .Height    = 17
461:             .FontName  = "Tahoma"
462:             .FontSize  = 8
463:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 471 a 480:
471:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
472:         WITH loc_oPagina.txt_4c_Grupo
473:             .Value         = ""
474:             .Top           = 240
475:             .Left          = 455
476:             .Width         = 80
477:             .Height        = 21
478:             .FontName      = "Tahoma"
479:             .FontSize      = 8
480:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 489 a 501:
489:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick",  THIS, "GrupoDblClick")
490: 
491:         *-- Label: Conta (Say3 do legado - Top=241+29=270, Left=415)
492:         loc_oPagina.AddObject("lbl_4c_Conta", "Label")
493:         WITH loc_oPagina.lbl_4c_Conta
494:             .Caption   = "Conta :"
495:             .Top       = 270
496:             .Left      = 415
497:             .Width     = 60
498:             .Height    = 17
499:             .FontName  = "Tahoma"
500:             .FontSize  = 8
501:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 509 a 518:
509:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
510:         WITH loc_oPagina.txt_4c_Conta
511:             .Value         = ""
512:             .Top           = 265
513:             .Left          = 455
514:             .Width         = 80
515:             .Height        = 21
516:             .FontName      = "Tahoma"
517:             .FontSize      = 8
518:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 527 a 539:
527:         BINDEVENT(loc_oPagina.txt_4c_Conta, "DblClick",  THIS, "ContaDblClick")
528: 
529:         *-- Label: Setor (Say4 do legado - Top=265+29=294, Left=418)
530:         loc_oPagina.AddObject("lbl_4c_Setor", "Label")
531:         WITH loc_oPagina.lbl_4c_Setor
532:             .Caption   = "Setor :"
533:             .Top       = 294
534:             .Left      = 418
535:             .Width     = 60
536:             .Height    = 17
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 547 a 556:
547:         loc_oPagina.AddObject("txt_4c_Setor", "TextBox")
548:         WITH loc_oPagina.txt_4c_Setor
549:             .Value         = ""
550:             .Top           = 290
551:             .Left          = 455
552:             .Width         = 80
553:             .Height        = 21
554:             .FontName      = "Tahoma"
555:             .FontSize      = 8
556:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 599 a 610:
599:                     loc_oGrid.Column3.Width = 80
600:                     loc_oGrid.Column4.Width = 80
601: 
602:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
603:                     loc_oGrid.Column2.Header1.Caption = "Grupo"
604:                     loc_oGrid.Column3.Header1.Caption = "Conta"
605:                     loc_oGrid.Column4.Header1.Caption = "Setor"
606: 
607:                     THIS.FormatarGridLista(loc_oGrid)
608:                     loc_lResultado = .T.
609:                 ENDIF
610:             ENDIF

*-- Linhas 881 a 890:
881:         loc_oPagina.txt_4c_Conta.ReadOnly  = !loc_lEditarContaSeto
882:         loc_oPagina.txt_4c_Setor.ReadOnly  = !loc_lEditarContaSeto
883: 
884:         loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditarContaSeto OR loc_lEditarCodGrp
885:         loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
886:     ENDPROC
887: 
888:     *==========================================================================
889:     * ValidarGrupo - Lookup em SigCdGcr (LostFocus de txt_4c_Grupo)
890:     * Original: Get_Grupo.Valid com fwBuscaExt em SigCdGcr/Codigos

*-- Linhas 1171 a 1180:
1171:         loc_oSalva = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
1172: 
1173:         TRY
1174:             loc_oSalva.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1175:             loc_oSalva.cmd_4c_Cancelar.Enabled  = .T.
1176:         CATCH TO loException
1177:             MsgErro("Erro em FormCES.AjustarBotoesPorModo:" + CHR(13) + loException.Message, "Erro")
1178:         ENDTRY
1179:     ENDPROC
1180: 


### BO (C:\4c\projeto\app\classes\CESBO.prg):
*==============================================================================
* CESBO.prg - Business Object para Classifica" + CHR(231) + CHR(227) + "o de Estoque
* Tabela: SigCdCle
* PK: cidchaves (char 20, gerada por fUniqueIds)
* Indice de busca: clacods (char 15)
*==============================================================================

DEFINE CLASS CESBO AS BusinessBase

    *-- Propriedades da tabela SigCdCle
    this_cChaveUnica = ""    && cidchaves char(20) - PK gerada por fUniqueIds
    this_cCodigo     = ""    && clacods   char(15) - C" + CHR(243) + "digo (indice de busca)
    this_cGrupo      = ""    && clagrupos char(10) - Grupo (FK SigCdGcr.Codigos)
    this_cConta      = ""    && clacontas char(10) - Conta (FK SigCdCli.iclis)
    this_cSetor      = ""    && setors    char(10) - Setor (FK SigCdGcr.Codigos)

    *==========================================================================
    * Init - Configura tabela e campo chave do BusinessBase
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCle"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna PK para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cChaveUnica
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia cursor -> propriedades (PROTECTED)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cChaveUnica   = TratarNulo(cidchaves, "C")
            THIS.this_cCodigo       = TratarNulo(clacods,   "C")
            THIS.this_cGrupo        = TratarNulo(clagrupos, "C")
            THIS.this_cConta        = TratarNulo(clacontas, "C")
            THIS.this_cSetor        = TratarNulo(setors,    "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros (PUBLIC)
    * Inclui cidchaves no SELECT para que o Form possa carregar por PK
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, clacods, clagrupos, clacontas, setors" + ;
                       " FROM SigCdCle"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY clacods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o de estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PUBLIC)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, clacods, clagrupos, clacontas, setors" + ;
                       " FROM SigCdCle" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarDuplicata - Verifica duplicidade de clacods+clagrupos+clacontas
    * Reproduz ChkRegister('SigCdCle') do legado
    *==========================================================================
    FUNCTION VerificarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicata
        loc_lDuplicata = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdCle" + ;
                       " WHERE clacods   = " + EscaparSQL(THIS.this_cCodigo) + ;
                       "   AND clagrupos = " + EscaparSQL(THIS.this_cGrupo) + ;
                       "   AND clacontas = " + EscaparSQL(THIS.this_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicata = (cursor_4c_Dup.total > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.VerificarDuplicata:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicata
    ENDFUNC

    *==========================================================================
    * Inserir - Inclui novo registro (PROTECTED)
    * cidchaves gerado por fUniqueIds(); valida grupo + duplicata antes
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cGrupo))
                MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.VerificarDuplicata()
                    MsgAviso("C" + CHR(243) + "digo, Grupo e Conta j" + CHR(225) + " Cadastrado!", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.this_cChaveUnica = fUniqueIds()

                    loc_cSQL = "INSERT INTO SigCdCle" + ;
                               " (cidchaves, clacods, clagrupos, clacontas, setors)" + ;
                               " VALUES (" + ;
                               EscaparSQL(THIS.this_cChaveUnica) + ", " + ;
                               EscaparSQL(THIS.this_cCodigo)     + ", " + ;
                               EscaparSQL(THIS.this_cGrupo)      + ", " + ;
                               EscaparSQL(THIS.this_cConta)      + ", " + ;
                               EscaparSQL(THIS.this_cSetor)      + ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao incluir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF

                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente (PROTECTED)
    * clacods e fixo ao alterar (desabilitado no legado em modo ALTERAR)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCle SET" + ;
                       " clagrupos = " + EscaparSQL(THIS.this_cGrupo) + "," + ;
                       " clacontas = " + EscaparSQL(THIS.this_cConta) + "," + ;
                       " setors    = " + EscaparSQL(THIS.this_cSetor) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cChaveUnica)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Remove registro do banco (PROTECTED)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCle" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cChaveUnica)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

