# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (16)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Movimentacao' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_CotasPendentes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Produtos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Fornecedores' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Pedidos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_CabOperas' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_ItnOperas' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Subniveis' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [LAYOUT-POSITION] Controle 'optFiltro' (parent: SIGMVCOT.pgfPagina.pgDados): Top original=277 vs migrado 'obj_4c_OptFiltro' Top=5 (diff=272px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optFiltro' (parent: SIGMVCOT.pgfPagina.pgDados): Left original=875 vs migrado 'obj_4c_OptFiltro' Left=5 (diff=870px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvcot.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (9067 linhas total):

*-- Linhas 166 a 211:
166:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
167: 
168:         WITH THIS.pgf_4c_Paginas
169:             .Top         = -1
170:             .Left        = 0
171:             .Width       = 1003
172:             .Height      = 589
173:             .PageCount   = 4
174:             .Tabs        = .T.
175:             .Visible     = .F.
176:             *-- PageFrame.BorderWidth eh READ-ONLY em runtime ("Property
177:             *-- BORDERWIDTH is read-only") e o SCX legado nao a declara.
178: 
179:             .Page1.Caption   = "Filtros"
180:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
181:             .Page1.FontName  = "Verdana"
182:             .Page1.FontSize  = 8
183:             .Page1.FontBold  = .T.
184:             .Page1.BackColor = RGB(255, 255, 255)
185:             .Page1.ForeColor = RGB(36, 84, 155)
186:             .Page1.Enabled   = .T.
187: 
188:             .Page2.Caption   = "Dados"
189:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
190:             .Page2.FontName  = "Verdana"
191:             .Page2.FontSize  = 8
192:             .Page2.FontBold  = .T.
193:             .Page2.BackColor = RGB(255, 255, 255)
194:             .Page2.ForeColor = RGB(36, 84, 155)
195:             .Page2.Enabled   = .F.
196: 
197:             .Page3.Caption   = "Cota" + CHR(231) + CHR(245) + "es"
198:             .Page3.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
199:             .Page3.FontName  = "Verdana"
200:             .Page3.FontSize  = 8
201:             .Page3.FontBold  = .T.
202:             .Page3.BackColor = RGB(255, 255, 255)
203:             .Page3.ForeColor = RGB(36, 84, 155)
204:             .Page3.Enabled   = .F.
205: 
206:             .Page4.Caption   = "Pedidos"
207:             .Page4.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
208:             .Page4.FontName  = "Verdana"
209:             .Page4.FontSize  = 8
210:             .Page4.FontBold  = .T.
211:             .Page4.BackColor = RGB(255, 255, 255)

*-- Linhas 219 a 305:
219:     * shape de agrupamento visual, filtros de Periodo/Operacao/Empresa/Job
220:     * e o CommandGroup de navegacao (Processar/Encerrar). Espelha
221:     * SIGMVCOT.pgfPagina.pgFiltros do legado - Top/Left EXATOS do SCX
222:     * (pgf_4c_Paginas.Top = -1, sem a compensacao +29 do padrao CRUD).
223:     *--------------------------------------------------------------------------
224:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
225:         LOCAL loc_oPag
226: 
227:         loc_oPag = THIS.pgf_4c_Paginas.Page1
228: 
229:         *-- Shape de agrupamento visual dos filtros
230:         loc_oPag.AddObject("shp_4c_Shape1", "Shape")
231:         WITH loc_oPag.shp_4c_Shape1
232:             .Top           = 180
233:             .Left          = 16
234:             .Width         = 967
235:             .Height        = 119
236:             .BackStyle     = 0
237:             .SpecialEffect = 1
238:             .BorderColor   = RGB(36, 84, 155)
239:             .Visible       = .T.
240:         ENDWITH
241: 
242:         *-- Periodo (Data Inicial a Data Final)
243:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
244:         WITH loc_oPag.lbl_4c_Label5
245:             .FontBold  = .T.
246:             .FontSize  = 8
247:             .Caption   = "Per" + CHR(237) + "odo :"
248:             .Left      = 319
249:             .Top       = 194
250:             .ForeColor = RGB(36, 84, 155)
251:             .BackStyle = 0
252:             .Alignment = 0
253:             .Visible   = .T.
254:         ENDWITH
255: 
256:         loc_oPag.AddObject("txt_4c_DtPerI", "TextBox")
257:         WITH loc_oPag.txt_4c_DtPerI
258:             .Height        = 22
259:             .Left          = 385
260:             .Top           = 191
261:             .Width         = 80
262:             .SpecialEffect = 1
263:             .BorderColor   = RGB(0, 0, 128)
264:             .Value         = DATE()
265:             .Visible       = .T.
266:         ENDWITH
267: 
268:         loc_oPag.AddObject("lbl_4c_Label9", "Label")
269:         WITH loc_oPag.lbl_4c_Label9
270:             .FontBold  = .T.
271:             .FontSize  = 8
272:             .Caption   = CHR(224)
273:             .Left      = 471
274:             .Top       = 194
275:             .ForeColor = RGB(36, 84, 155)
276:             .BackStyle = 0
277:             .Alignment = 0
278:             .Visible   = .T.
279:         ENDWITH
280: 
281:         loc_oPag.AddObject("txt_4c_DtPerF", "TextBox")
282:         WITH loc_oPag.txt_4c_DtPerF
283:             .Height        = 22
284:             .Left          = 485
285:             .Top           = 191
286:             .Width         = 80
287:             .SpecialEffect = 1
288:             .BorderColor   = RGB(0, 0, 128)
289:             .Value         = DATE()
290:             .Visible       = .T.
291:         ENDWITH
292: 
293:         *-- Operacao (SigCdOpe.Dopes)
294:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
295:         WITH loc_oPag.lbl_4c_Label2
296:             .FontBold  = .T.
297:             .FontSize  = 8
298:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
299:             .Left      = 307
300:             .Top       = 219
301:             .Width     = 62
302:             .ForeColor = RGB(36, 84, 155)
303:             .BackStyle = 0
304:             .Alignment = 0
305:             .Visible   = .T.

*-- Linhas 311 a 336:
311:             .FontSize      = 9
312:             .Format        = "K"
313:             .Height        = 22
314:             .Left          = 385
315:             .MaxLength     = 20
316:             .SpecialEffect = 1
317:             .Top           = 216
318:             .Width         = 150
319:             .BorderColor   = RGB(0, 0, 128)
320:             .Value         = ""
321:             .Visible       = .T.
322:         ENDWITH
323: 
324:         *-- Empresa (SigCdEmp.Cemps/Razas)
325:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
326:         WITH loc_oPag.lbl_4c_Label1
327:             .FontBold  = .T.
328:             .FontSize  = 8
329:             .Caption   = "Empresa :"
330:             .Left      = 312
331:             .Top       = 244
332:             .Width     = 57
333:             .ForeColor = RGB(36, 84, 155)
334:             .BackStyle = 0
335:             .Alignment = 0
336:             .Visible   = .T.

*-- Linhas 344 a 386:
344:             .Format        = "K"
345:             .Height        = 22
346:             .InputMask     = "!!!"
347:             .Left          = 385
348:             .MaxLength     = 3
349:             .SpecialEffect = 1
350:             .Top           = 241
351:             .Width         = 31
352:             .BorderColor   = RGB(0, 0, 128)
353:             .Value         = ""
354:             .Visible       = .T.
355:         ENDWITH
356: 
357:         loc_oPag.AddObject("txt_4c_DEmps", "TextBox")
358:         WITH loc_oPag.txt_4c_DEmps
359:             .FontName      = "Courier New"
360:             .Format        = "K"
361:             .Height        = 22
362:             .Left          = 419
363:             .MaxLength     = 40
364:             .SpecialEffect = 1
365:             .Top           = 241
366:             .Width         = 238
367:             .BorderColor   = RGB(0, 0, 128)
368:             .Value         = ""
369:             .Visible       = .T.
370:         ENDWITH
371: 
372:         *-- Job/Conta (SigCdCli.IClis/RClis)
373:         loc_oPag.AddObject("lbl_4c_Label25", "Label")
374:         WITH loc_oPag.lbl_4c_Label25
375:             .AutoSize  = .T.
376:             .FontBold  = .T.
377:             .FontName  = "Verdana"
378:             .FontSize  = 8
379:             .Caption   = "Job :"
380:             .Left      = 347
381:             .Top       = 268
382:             .Width     = 32
383:             .ForeColor = RGB(36, 84, 155)
384:             .BackStyle = 0
385:             .Alignment = 0
386:             .Visible   = .T.

*-- Linhas 395 a 406:
395:             .BorderStyle   = 1
396:             .Format        = "K"
397:             .Height        = 21
398:             .Left          = 385
399:             .MaxLength     = 10
400:             .SpecialEffect = 1
401:             .Top           = 266
402:             .Width         = 80
403:             .ForeColor     = RGB(0, 0, 0)
404:             .BorderColor   = RGB(0, 0, 128)
405:             .Themes        = .F.
406:             .Value         = ""

*-- Linhas 412 a 423:
412:             .FontName      = "Courier New"
413:             .Format        = "K"
414:             .Height        = 21
415:             .Left          = 467
416:             .MaxLength     = 40
417:             .SpecialEffect = 1
418:             .Top           = 266
419:             .Width         = 304
420:             .BorderColor   = RGB(0, 0, 128)
421:             .Themes        = .F.
422:             .Value         = ""
423:             .Visible       = .T.

*-- Linhas 430 a 468:
430:             .BackStyle   = 0
431:             .BorderStyle = 0
432:             .Height      = 110
433:             .Left        = 823
434:             .Top         = 7
435:             .Width       = 170
436:             .Visible     = .T.
437: 
438:             WITH .Buttons(1)
439:                 .Top           = 5
440:                 .Left          = 5
441:                 .Height        = 100
442:                 .Width         = 80
443:                 .WordWrap      = .T.
444:                 .Picture       = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
445:                 .Caption       = "Processar"
446:                 .MousePointer  = 15
447:                 .ToolTipText   = "Processar os Dados"
448:                 .SpecialEffect = 0
449:                 .ForeColor     = RGB(36, 84, 155)
450:                 .BackColor     = RGB(255, 255, 255)
451:                 .Themes        = .F.
452:             ENDWITH
453: 
454:             WITH .Buttons(2)
455:                 .Top           = 5
456:                 .Left          = 85
457:                 .Height        = 100
458:                 .Width         = 80
459:                 .FontSize      = 8
460:                 .WordWrap      = .T.
461:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
462:                 .Cancel        = .T.
463:                 .Caption       = "Encerrar"
464:                 .MousePointer  = 15
465:                 .ToolTipText   = "Sair do Cadastro"
466:                 .SpecialEffect = 0
467:                 .ForeColor     = RGB(36, 84, 155)
468:                 .BackColor     = RGB(255, 255, 255)

*-- Linhas 1034 a 1080:
1034: 
1035:     *--------------------------------------------------------------------------
1036:     * CriarCursoresLista - Cria os cursores das duas grades da pagina Dados,
1037:     * com a estrutura EXATA do PROCEDURE Load legado:
1038:     *
1039:     *   crOperacoes  -> cursor_4c_Movimentacao    (grade de Movimentacoes)
1040:     *   crCotaPends  -> grade de Cotacoes Realizadas (grd_4c_CotaPends, cursor local)
1041:     *
1042:     * CREATE CURSOR nasce READWRITE, o que eh pre-requisito para a coluna de
1043:     * marcacao (CheckBox) do grid de Movimentacoes aceitar o REPLACE feito
1044:     * pelos handlers de clique/tecla. Tipos e tamanhos transcritos do legado
1045:     * sem "correcoes" (Nops n(6) e Itens n(6) sao os do Load original).
1046:     *--------------------------------------------------------------------------
1047:     PROTECTED PROCEDURE CriarCursoresLista()
1048:         IF USED("cursor_4c_Movimentacao")
1049:             USE IN cursor_4c_Movimentacao
1050:         ENDIF
1051: 
1052:         CREATE CURSOR cursor_4c_Movimentacao ( ;
1053:             Marcas     L(1),  Emps       C(3),  Dopes      C(20), Numes      N(6), ;
1054:             Datas      D(8),  Itens      N(6),  EmpDopNums C(29), Nops       N(6), ;
1055:             ChkSubn    L(1),  LCancelas  L(1),  ChkBxParcs L(1),  ChkPagos   L(1), ;
1056:             ProcBals   L(1),  ProcDBal   L(1),  Destinos   N(1),  EstDests   N(1), ;
1057:             EstOrigs   N(1),  Origems    N(1),  Produc     N(1),  Jobs       C(10))
1058: 
1059:         INDEX ON DTOS(Datas) + EmpDopNums TAG Ordem
1060: 
1061:         IF USED("cursor_4c_CotasPendentes")
1062:             USE IN cursor_4c_CotasPendentes
1063:         ENDIF
1064: 
1065:         CREATE CURSOR cursor_4c_CotasPendentes ( ;
1066:             Situas     N(1),  Codigos    N(6),  DtSolics   D(8),  Solicitas  C(10), ;
1067:             Deptos     C(10), Prioris    C(10), DtCotas    D(8),  DtAprovs   D(8), ;
1068:             Aprovador  C(10), ContaEs    C(10), LocalEnts  N(10), Justificas M(4), ;
1069:             Copias     N(6))
1070: 
1071:         INDEX ON Codigos TAG Ordem
1072:     ENDPROC
1073: 
1074:     *--------------------------------------------------------------------------
1075:     * ConfigurarPaginaLista - Monta a Page2 (pgDados do legado), que eh a
1076:     * pagina de LISTA deste form OPERACIONAL: as duas grades (Movimentacoes
1077:     * em aberto e Cotacoes Realizadas) e os CommandGroups de acao sobre elas.
1078:     *
1079:     * Top/Left EXATOS do SCX. O PageFrame deste form tem Top = -1 e abas
1080:     * VISIVEIS - NAO existe aqui a compensacao +29 do padrao CRUD.

*-- Linhas 1089 a 1101:
1089:         loc_oPag = THIS.pgf_4c_Paginas.Page2
1090: 
1091:         *-- Titulo da grade de Movimentacoes (Say5 do legado)
1092:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
1093:         WITH loc_oPag.lbl_4c_Label5
1094:             .Caption   = "\<Movimenta" + CHR(231) + CHR(245) + "es"
1095:             .Top       = 7
1096:             .Left      = 250
1097:             .Width     = 110
1098:             .Height    = 15
1099:             .Alignment = 0
1100:             .AutoSize  = .F.
1101:             .BackStyle = 0

*-- Linhas 1117 a 1157:
1117:             .BackStyle   = 0
1118:             .BorderStyle = 0
1119:             .Value       = 0
1120:             .Top         = 169
1121:             .Left        = 668
1122:             .Width       = 160
1123:             .Height      = 100
1124:             .Visible     = .T.
1125: 
1126:             WITH .Buttons(1)
1127:                 .Top             = 0
1128:                 .Left            = 0
1129:                 .Height          = 100
1130:                 .Width           = 80
1131:                 .WordWrap        = .T.
1132:                 .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_60.jpg"
1133:                 .Caption         = "Marcar Todas"
1134:                 .MousePointer    = 15
1135:                 .ToolTipText     = "Marcar Todas as Opera" + CHR(231) + CHR(245) + "es"
1136:                 .SpecialEffect   = 0
1137:                 .PicturePosition = 7
1138:                 .ForeColor       = RGB(36, 84, 155)
1139:                 .BackColor       = RGB(255, 255, 255)
1140:                 .Themes          = .F.
1141:             ENDWITH
1142: 
1143:             WITH .Buttons(2)
1144:                 .Top             = 0
1145:                 .Left            = 80
1146:                 .Height          = 100
1147:                 .Width           = 80
1148:                 .FontName        = "Verdana"
1149:                 .FontSize        = 8
1150:                 .WordWrap        = .T.
1151:                 .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
1152:                 .Caption         = "Desmarcar Todas "
1153:                 .MousePointer    = 15
1154:                 .ToolTipText     = "Desmarcar Todas as Opera" + CHR(231) + CHR(245) + "es"
1155:                 .SpecialEffect   = 0
1156:                 .PicturePosition = 7
1157:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1168 a 1189:
1168:             .BackStyle   = 0
1169:             .BorderStyle = 0
1170:             .Value       = 1
1171:             .Top         = 169
1172:             .Left        = 828
1173:             .Width       = 80
1174:             .Height      = 100
1175:             .Visible     = .T.
1176: 
1177:             WITH .Buttons(1)
1178:                 .Top             = 0
1179:                 .Left            = 0
1180:                 .Height          = 100
1181:                 .Width           = 80
1182:                 .WordWrap        = .T.
1183:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1184:                 .Caption         = "Gerar Cota" + CHR(231) + CHR(245) + "es"
1185:                 .MousePointer    = 15
1186:                 .ToolTipText     = "Gerar Cota" + CHR(231) + CHR(245) + "es"
1187:                 .SpecialEffect   = 0
1188:                 .PicturePosition = 7
1189:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1201 a 1222:
1201:             .BackStyle   = 0
1202:             .BorderStyle = 0
1203:             .Value       = 1
1204:             .Top         = 169
1205:             .Left        = 908
1206:             .Width       = 80
1207:             .Height      = 100
1208:             .Visible     = .T.
1209: 
1210:             WITH .Buttons(1)
1211:                 .Top             = 0
1212:                 .Left            = 0
1213:                 .Height          = 100
1214:                 .Width           = 80
1215:                 .WordWrap        = .T.
1216:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1217:                 .Caption         = "Cota" + CHR(231) + CHR(227) + "o Livre"
1218:                 .MousePointer    = 15
1219:                 .ToolTipText     = "Gerar Cota" + CHR(231) + CHR(227) + "o Sem Origem"
1220:                 .SpecialEffect   = 0
1221:                 .PicturePosition = 7
1222:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1232 a 1290:
1232:             .AutoSize    = .F.
1233:             .BackStyle   = 0
1234:             .BorderStyle = 0
1235:             .Top         = 277
1236:             .Left        = 875
1237:             .Width       = 105
1238:             .Height      = 64
1239:             .Value       = 1
1240:             .Visible     = .T.
1241: 
1242:             WITH .Buttons(1)
1243:                 .Caption   = "Todos"
1244:                 .Left      = 5
1245:                 .Top       = 5
1246:                 .Width     = 94
1247:                 .Height    = 15
1248:                 .AutoSize  = .F.
1249:                 .BackStyle = 0
1250:                 .ForeColor = RGB(36, 84, 155)
1251:             ENDWITH
1252: 
1253:             WITH .Buttons(2)
1254:                 .Caption   = "Com Estoque"
1255:                 .Left      = 5
1256:                 .Top       = 24
1257:                 .Width     = 94
1258:                 .Height    = 15
1259:                 .AutoSize  = .F.
1260:                 .BackStyle = 0
1261:                 .FontName  = "Verdana"
1262:                 .FontSize  = 8
1263:                 .ForeColor = RGB(36, 84, 155)
1264:             ENDWITH
1265: 
1266:             WITH .Buttons(3)
1267:                 .Caption   = "Sem Estoque"
1268:                 .Left      = 5
1269:                 .Top       = 44
1270:                 .Width     = 94
1271:                 .Height    = 15
1272:                 .AutoSize  = .F.
1273:                 .BackStyle = 0
1274:                 .FontName  = "Verdana"
1275:                 .FontSize  = 8
1276:                 .ForeColor = RGB(36, 84, 155)
1277:             ENDWITH
1278:         ENDWITH
1279: 
1280:         *-- Rotulo do filtro "Gerar Produtos :" (Say2 do legado)
1281:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
1282:         WITH loc_oPag.lbl_4c_Label2
1283:             .Caption   = "\<Gerar Produtos :"
1284:             .Top       = 283
1285:             .Left      = 765
1286:             .Width     = 105
1287:             .Height    = 15
1288:             .Alignment = 0
1289:             .AutoSize  = .F.
1290:             .BackStyle = 0

*-- Linhas 1296 a 1308:
1296:         ENDWITH
1297: 
1298:         *-- Titulo da grade de Cotacoes Realizadas (Say1 do legado)
1299:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
1300:         WITH loc_oPag.lbl_4c_Label1
1301:             .Caption   = "Cota" + CHR(231) + CHR(245) + "es \<Realizadas"
1302:             .Top       = 294
1303:             .Left      = 250
1304:             .Width     = 140
1305:             .Height    = 15
1306:             .Alignment = 0
1307:             .AutoSize  = .F.
1308:             .BackStyle = 0

*-- Linhas 1324 a 1345:
1324:             .BackStyle   = 0
1325:             .BorderStyle = 0
1326:             .Value       = 1
1327:             .Top         = 453
1328:             .Left        = 668
1329:             .Width       = 90
1330:             .Height      = 100
1331:             .Visible     = .T.
1332: 
1333:             WITH .Buttons(1)
1334:                 .Top             = 0
1335:                 .Left            = 0
1336:                 .Height          = 100
1337:                 .Width           = 80
1338:                 .WordWrap        = .T.
1339:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
1340:                 .Caption         = "Visualizar Cota" + CHR(231) + CHR(227) + "o"
1341:                 .MousePointer    = 15
1342:                 .ToolTipText     = "Consultar Cota" + CHR(231) + CHR(245) + "es"
1343:                 .SpecialEffect   = 0
1344:                 .PicturePosition = 7
1345:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1356 a 1396:
1356:             .BackStyle   = 0
1357:             .BorderStyle = 0
1358:             .Value       = 0
1359:             .Top         = 453
1360:             .Left        = 748
1361:             .Width       = 159
1362:             .Height      = 102
1363:             .Visible     = .T.
1364: 
1365:             WITH .Buttons(1)
1366:                 .Top             = 0
1367:                 .Left            = 0
1368:                 .Height          = 100
1369:                 .Width           = 80
1370:                 .WordWrap        = .T.
1371:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
1372:                 .Caption         = "Alterar Cota" + CHR(231) + CHR(227) + "o"
1373:                 .MousePointer    = 15
1374:                 .ToolTipText     = "Alterar Cota" + CHR(231) + CHR(245) + "es"
1375:                 .SpecialEffect   = 0
1376:                 .PicturePosition = 7
1377:                 .ForeColor       = RGB(36, 84, 155)
1378:                 .BackColor       = RGB(255, 255, 255)
1379:                 .Themes          = .F.
1380:             ENDWITH
1381: 
1382:             WITH .Buttons(2)
1383:                 .Top             = 0
1384:                 .Left            = 80
1385:                 .Height          = 100
1386:                 .Width           = 80
1387:                 .FontName        = "Verdana"
1388:                 .FontSize        = 8
1389:                 .WordWrap        = .T.
1390:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1391:                 .Caption         = "Excluir Cota" + CHR(231) + CHR(227) + "o"
1392:                 .MousePointer    = 15
1393:                 .ToolTipText     = "Excluir Cota" + CHR(231) + CHR(245) + "es"
1394:                 .SpecialEffect   = 0
1395:                 .PicturePosition = 7
1396:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1407 a 1428:
1407:             .BackStyle   = 0
1408:             .BorderStyle = 0
1409:             .Value       = 1
1410:             .Top         = 454
1411:             .Left        = 908
1412:             .Width       = 79
1413:             .Height      = 101
1414:             .Visible     = .T.
1415: 
1416:             WITH .Buttons(1)
1417:                 .Top             = 0
1418:                 .Left            = 0
1419:                 .Height          = 100
1420:                 .Width           = 80
1421:                 .WordWrap        = .T.
1422:                 .Picture         = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
1423:                 .Caption         = "Copiar Cota" + CHR(231) + CHR(227) + "o"
1424:                 .MousePointer    = 15
1425:                 .ToolTipText     = "Copiar Cota" + CHR(231) + CHR(245) + "es"
1426:                 .SpecialEffect   = 0
1427:                 .PicturePosition = 7
1428:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1440 a 1462:
1440:             .BackStyle   = 0
1441:             .BorderStyle = 0
1442:             .Value       = 0
1443:             .Top         = 7
1444:             .Left        = 902
1445:             .Width       = 90
1446:             .Height      = 110
1447:             .Visible     = .T.
1448: 
1449:             WITH .Buttons(1)
1450:                 .Top             = 5
1451:                 .Left            = 5
1452:                 .Height          = 100
1453:                 .Width           = 80
1454:                 .WordWrap        = .T.
1455:                 .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1456:                 .Cancel          = .T.
1457:                 .Caption         = " Retornar  aos Filtros"
1458:                 .MousePointer    = 15
1459:                 .ToolTipText     = "Voltar Para a P" + CHR(225) + "gina de Filtros"
1460:                 .SpecialEffect   = 0
1461:                 .PicturePosition = 7
1462:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1505 a 1519:
1505:         loc_oPag = THIS.pgf_4c_Paginas.Page3
1506: 
1507:         *-- Codigo (crSigCtTDc.Codigos) - somente leitura, gerado pelo BO
1508:         loc_oPag.AddObject("lbl_4c_Label12", "Label")
1509:         WITH loc_oPag.lbl_4c_Label12
1510:             .FontBold  = .T.
1511:             .FontSize  = 8
1512:             .Caption   = "C" + CHR(243) + "digo"
1513:             .Left      = 9
1514:             .Top       = 120
1515:             .Width     = 40
1516:             .ForeColor = RGB(36, 84, 155)
1517:             .BackStyle = 0
1518:             .Alignment = 0
1519:             .Visible   = .T.

*-- Linhas 1526 a 1552:
1526:             .FontBold      = .T.
1527:             .Format        = "K"
1528:             .Height        = 20
1529:             .Left          = 9
1530:             .Top           = 136
1531:             .Width         = 48
1532:             .SpecialEffect = 1
1533:             .ForeColor     = RGB(0, 0, 128)
1534:             .BorderColor   = RGB(0, 0, 128)
1535:             .ReadOnly      = .T.
1536:             .Value         = ""
1537:             .Visible       = .T.
1538:         ENDWITH
1539: 
1540:         *-- Solicitante (SigCdUsu.Usuarios/NComps)
1541:         loc_oPag.AddObject("lbl_4c_Label4", "Label")
1542:         WITH loc_oPag.lbl_4c_Label4
1543:             .FontBold  = .T.
1544:             .FontSize  = 8
1545:             .Caption   = "Solicitante"
1546:             .Left      = 86
1547:             .Top       = 120
1548:             .Width     = 62
1549:             .ForeColor = RGB(36, 84, 155)
1550:             .BackStyle = 0
1551:             .Alignment = 0
1552:             .Visible   = .T.

*-- Linhas 1558 a 1583:
1558:             .FontSize      = 8
1559:             .Format        = "K"
1560:             .Height        = 20
1561:             .Left          = 86
1562:             .Top           = 136
1563:             .Width         = 80
1564:             .MaxLength     = 10
1565:             .SpecialEffect = 1
1566:             .BorderColor   = RGB(0, 0, 128)
1567:             .Value         = ""
1568:             .Visible       = .T.
1569:         ENDWITH
1570: 
1571:         *-- Depto. (SigCdDpt.Codigos/Descricaos)
1572:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
1573:         WITH loc_oPag.lbl_4c_Label5
1574:             .FontBold  = .T.
1575:             .FontSize  = 8
1576:             .Caption   = "Depto."
1577:             .Left      = 195
1578:             .Top       = 120
1579:             .Width     = 39
1580:             .ForeColor = RGB(36, 84, 155)
1581:             .BackStyle = 0
1582:             .Alignment = 0
1583:             .Visible   = .T.

*-- Linhas 1589 a 1614:
1589:             .FontSize      = 8
1590:             .Format        = "K"
1591:             .Height        = 20
1592:             .Left          = 195
1593:             .Top           = 136
1594:             .Width         = 80
1595:             .MaxLength     = 10
1596:             .SpecialEffect = 1
1597:             .BorderColor   = RGB(0, 0, 128)
1598:             .Value         = ""
1599:             .Visible       = .T.
1600:         ENDWITH
1601: 
1602:         *-- Comprador (SigCdUsu.Usuarios/NComps)
1603:         loc_oPag.AddObject("lbl_4c_Label10", "Label")
1604:         WITH loc_oPag.lbl_4c_Label10
1605:             .FontBold  = .T.
1606:             .FontSize  = 8
1607:             .Caption   = "Comprador"
1608:             .Left      = 304
1609:             .Top       = 120
1610:             .Width     = 65
1611:             .ForeColor = RGB(36, 84, 155)
1612:             .BackStyle = 0
1613:             .Alignment = 0
1614:             .Visible   = .T.

*-- Linhas 1620 a 1648:
1620:             .FontSize      = 8
1621:             .Format        = "K"
1622:             .Height        = 20
1623:             .Left          = 304
1624:             .Top           = 136
1625:             .Width         = 80
1626:             .MaxLength     = 10
1627:             .SpecialEffect = 1
1628:             .BorderColor   = RGB(0, 0, 128)
1629:             .Value         = ""
1630:             .Visible       = .T.
1631:         ENDWITH
1632: 
1633:         *-- Aprovador (espelho de LEITURA do cabecalho - crSigCtTDc.Aprovador.
1634:         *-- O campo EDITAVEL com o lookup fwBuscaExt fica em pgfComplCots.
1635:         *-- pgAprovacao (Fase 6) - por isso o nome NAO repete txt_4c_Aprovador,
1636:         *-- que sera usado la, evitando a colisao de objeto da regra #11.
1637:         loc_oPag.AddObject("lbl_4c_Label15", "Label")
1638:         WITH loc_oPag.lbl_4c_Label15
1639:             .FontBold  = .T.
1640:             .FontSize  = 8
1641:             .Caption   = "Aprovador"
1642:             .Left      = 413
1643:             .Top       = 120
1644:             .Width     = 62
1645:             .ForeColor = RGB(36, 84, 155)
1646:             .BackStyle = 0
1647:             .Alignment = 0
1648:             .Visible   = .T.

*-- Linhas 1654 a 1802:
1654:             .FontSize      = 8
1655:             .Format        = "K"
1656:             .Height        = 20
1657:             .Left          = 413
1658:             .Top           = 136
1659:             .Width         = 80
1660:             .MaxLength     = 10
1661:             .SpecialEffect = 1
1662:             .ReadOnly      = .T.
1663:             .BorderColor   = RGB(0, 0, 128)
1664:             .Value         = ""
1665:             .Visible       = .T.
1666:         ENDWITH
1667: 
1668:         *-- Solicitacao (data - crSigCtTDc.DtSolics)
1669:         loc_oPag.AddObject("lbl_4c_Label6", "Label")
1670:         WITH loc_oPag.lbl_4c_Label6
1671:             .FontBold  = .T.
1672:             .FontSize  = 8
1673:             .Caption   = "Solicita" + CHR(231) + CHR(227) + "o"
1674:             .Left      = 522
1675:             .Top       = 120
1676:             .Width     = 63
1677:             .ForeColor = RGB(36, 84, 155)
1678:             .BackStyle = 0
1679:             .Alignment = 0
1680:             .Visible   = .T.
1681:         ENDWITH
1682: 
1683:         loc_oPag.AddObject("txt_4c_DtSolics", "TextBox")
1684:         WITH loc_oPag.txt_4c_DtSolics
1685:             .FontName      = "Arial"
1686:             .FontSize      = 8
1687:             .Height        = 20
1688:             .Left          = 522
1689:             .Top           = 136
1690:             .Width         = 64
1691:             .InputMask     = "99/99/9999"
1692:             .SpecialEffect = 1
1693:             .BorderColor   = RGB(0, 0, 128)
1694:             .Value         = {}
1695:             .Visible       = .T.
1696:         ENDWITH
1697: 
1698:         *-- Cotacao (data - crSigCtTDc.DtCotas)
1699:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
1700:         WITH loc_oPag.lbl_4c_Label7
1701:             .FontBold  = .T.
1702:             .FontSize  = 8
1703:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
1704:             .Left      = 615
1705:             .Top       = 120
1706:             .Width     = 48
1707:             .ForeColor = RGB(36, 84, 155)
1708:             .BackStyle = 0
1709:             .Alignment = 0
1710:             .Visible   = .T.
1711:         ENDWITH
1712: 
1713:         loc_oPag.AddObject("txt_4c_DtCotas", "TextBox")
1714:         WITH loc_oPag.txt_4c_DtCotas
1715:             .FontName      = "Arial"
1716:             .FontSize      = 8
1717:             .Height        = 20
1718:             .Left          = 615
1719:             .Top           = 136
1720:             .Width         = 64
1721:             .InputMask     = "99/99/9999"
1722:             .SpecialEffect = 1
1723:             .BorderColor   = RGB(0, 0, 128)
1724:             .Value         = {}
1725:             .Visible       = .T.
1726:         ENDWITH
1727: 
1728:         *-- Validade (data - crSigCtTDc.DtValids)
1729:         loc_oPag.AddObject("lbl_4c_Label8", "Label")
1730:         WITH loc_oPag.lbl_4c_Label8
1731:             .FontBold  = .T.
1732:             .FontSize  = 8
1733:             .Caption   = "Validade"
1734:             .Left      = 708
1735:             .Top       = 120
1736:             .Width     = 50
1737:             .ForeColor = RGB(36, 84, 155)
1738:             .BackStyle = 0
1739:             .Alignment = 0
1740:             .Visible   = .T.
1741:         ENDWITH
1742: 
1743:         loc_oPag.AddObject("txt_4c_DtValids", "TextBox")
1744:         WITH loc_oPag.txt_4c_DtValids
1745:             .FontName      = "Arial"
1746:             .FontSize      = 8
1747:             .Height        = 20
1748:             .Left          = 708
1749:             .Top           = 136
1750:             .Width         = 64
1751:             .InputMask     = "99/99/9999"
1752:             .SpecialEffect = 1
1753:             .BorderColor   = RGB(0, 0, 128)
1754:             .Value         = {}
1755:             .Visible       = .T.
1756:         ENDWITH
1757: 
1758:         *-- Pagamento (data - crSigCtTDc.DtPagtos)
1759:         loc_oPag.AddObject("lbl_4c_Label9", "Label")
1760:         WITH loc_oPag.lbl_4c_Label9
1761:             .FontBold  = .T.
1762:             .FontSize  = 8
1763:             .Caption   = "Pagamento"
1764:             .Left      = 801
1765:             .Top       = 120
1766:             .Width     = 67
1767:             .ForeColor = RGB(36, 84, 155)
1768:             .BackStyle = 0
1769:             .Alignment = 0
1770:             .Visible   = .T.
1771:         ENDWITH
1772: 
1773:         loc_oPag.AddObject("txt_4c_DtPagtos", "TextBox")
1774:         WITH loc_oPag.txt_4c_DtPagtos
1775:             .FontName      = "Arial"
1776:             .FontSize      = 8
1777:             .Height        = 20
1778:             .Left          = 801
1779:             .Top           = 136
1780:             .Width         = 64
1781:             .InputMask     = "99/99/9999"
1782:             .SpecialEffect = 1
1783:             .BorderColor   = RGB(0, 0, 128)
1784:             .Value         = {}
1785:             .Visible       = .T.
1786:         ENDWITH
1787: 
1788:         *-- Prioridade (crSigCtTDc.Prioris - 1=Normal, 2=Media, 3=Alta;
1789:         *-- RowSource TRANSCRITO do legado, indice 1-based - regra CLAUDE.md
1790:         *-- #188, NUNCA inventar lista placeholder)
1791:         loc_oPag.AddObject("lbl_4c_Label11", "Label")
1792:         WITH loc_oPag.lbl_4c_Label11
1793:             .FontBold  = .T.
1794:             .FontSize  = 8
1795:             .Caption   = "Prioridade"
1796:             .Left      = 900
1797:             .Top       = 120
1798:             .Width     = 60
1799:             .ForeColor = RGB(36, 84, 155)
1800:             .BackStyle = 0
1801:             .Alignment = 0
1802:             .Visible   = .T.

*-- Linhas 1808 a 1817:
1808:             .FontSize      = 8
1809:             .FontBold      = .T.
1810:             .Height        = 20
1811:             .Left          = 900
1812:             .Top           = 136
1813:             .Width         = 90
1814:             .Style         = 2
1815:             .RowSourceType = 1
1816:             .RowSource     = "  Normal,  " + CHR(205) + CHR(233) + "dia,  Alta"
1817:             .SpecialEffect = 1

*-- Linhas 1862 a 1888:
1862:         *-- Moldura decorativa do rodape (Shape2 do legado)
1863:         loc_oPag.AddObject("shp_4c_Shape2", "Shape")
1864:         WITH loc_oPag.shp_4c_Shape2
1865:             .Top           = 482
1866:             .Left          = 8
1867:             .Width         = 987
1868:             .Height        = 76
1869:             .BackStyle     = 0
1870:             .SpecialEffect = 1
1871:             .BorderColor   = RGB(36, 84, 155)
1872:             .Visible       = .T.
1873:         ENDWITH
1874: 
1875:         *-- "Descricao do Produto" (Say2) + getDPros (espelho de leitura de
1876:         *-- crSigCtTCt.DPros da linha corrente do grdCotacoes)
1877:         loc_oPag.AddObject("lbl_4c_Label2b", "Label")
1878:         WITH loc_oPag.lbl_4c_Label2b
1879:             .FontBold  = .T.
1880:             .FontSize  = 8
1881:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
1882:             .Left      = 15
1883:             .Top       = 484
1884:             .Width     = 122
1885:             .ForeColor = RGB(36, 84, 155)
1886:             .BackStyle = 0
1887:             .Alignment = 0
1888:             .Visible   = .T.

*-- Linhas 1894 a 1979:
1894:             .FontSize      = 8
1895:             .Format        = "K"
1896:             .Height        = 20
1897:             .Left          = 15
1898:             .Top           = 498
1899:             .Width         = 258
1900:             .MaxLength     = 65
1901:             .SpecialEffect = 1
1902:             .BorderColor   = RGB(0, 0, 128)
1903:             .Value         = ""
1904:             .Visible       = .T.
1905:         ENDWITH
1906: 
1907:         *-- "Observacao do Produto" (Say1) + getObs (crSigCtTCt.Obs, editavel)
1908:         loc_oPag.AddObject("lbl_4c_Label1b", "Label")
1909:         WITH loc_oPag.lbl_4c_Label1b
1910:             .FontBold  = .T.
1911:             .FontSize  = 8
1912:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
1913:             .Left      = 277
1914:             .Top       = 484
1915:             .Width     = 134
1916:             .ForeColor = RGB(36, 84, 155)
1917:             .BackStyle = 0
1918:             .Alignment = 0
1919:             .Visible   = .T.
1920:         ENDWITH
1921: 
1922:         loc_oPag.AddObject("obj_4c_GetObs", "EditBox")
1923:         WITH loc_oPag.obj_4c_GetObs
1924:             .FontName      = "Arial"
1925:             .FontSize      = 8
1926:             .Height        = 20
1927:             .Left          = 277
1928:             .Top           = 498
1929:             .Width         = 384
1930:             .SpecialEffect = 1
1931:             .BorderColor   = RGB(0, 0, 128)
1932:             .Value         = ""
1933:             .Visible       = .T.
1934:         ENDWITH
1935: 
1936:         *-- "Justificativa do Produto" (Say3) + getJustificas (crSigCtTCt.Justificas)
1937:         loc_oPag.AddObject("lbl_4c_Label3b", "Label")
1938:         WITH loc_oPag.lbl_4c_Label3b
1939:             .FontBold  = .T.
1940:             .FontSize  = 8
1941:             .Caption   = "Justificativa do Produto"
1942:             .Left      = 16
1943:             .Top       = 519
1944:             .Width     = 136
1945:             .ForeColor = RGB(36, 84, 155)
1946:             .BackStyle = 0
1947:             .Alignment = 0
1948:             .Visible   = .T.
1949:         ENDWITH
1950: 
1951:         loc_oPag.AddObject("obj_4c_GetJustificas", "EditBox")
1952:         WITH loc_oPag.obj_4c_GetJustificas
1953:             .FontName      = "Arial"
1954:             .FontSize      = 8
1955:             .Height        = 20
1956:             .Left          = 16
1957:             .Top           = 533
1958:             .Width         = 644
1959:             .SpecialEffect = 1
1960:             .BorderColor   = RGB(0, 0, 128)
1961:             .Value         = ""
1962:             .Visible       = .T.
1963:         ENDWITH
1964: 
1965:         *-- "Cotacao Original :" (Say13 de Page3) + getCopias (crSigCtTDc.Copias -
1966:         *-- codigo da cotacao que deu origem a esta, quando copiada - When
1967:         *-- sempre .F. no legado, so exibicao)
1968:         loc_oPag.AddObject("lbl_4c_Label13b", "Label")
1969:         WITH loc_oPag.lbl_4c_Label13b
1970:             .FontBold  = .T.
1971:             .FontSize  = 8
1972:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o Original :"
1973:             .Left      = 782
1974:             .Top       = 511
1975:             .Width     = 100
1976:             .ForeColor = RGB(36, 84, 155)
1977:             .BackStyle = 0
1978:             .Alignment = 0
1979:             .Visible   = .T.

*-- Linhas 1986 a 1995:
1986:             .Format        = "999999"
1987:             .InputMask     = "999999"
1988:             .Height        = 20
1989:             .Left          = 905
1990:             .Top           = 508
1991:             .Width         = 57
1992:             .SpecialEffect = 1
1993:             .BorderColor   = RGB(0, 0, 128)
1994:             .ReadOnly      = .T.
1995:             .Value         = 0

*-- Linhas 2007 a 2054:
2007:     ENDPROC
2008: 
2009:     *--------------------------------------------------------------------------
2010:     * CriarCursoresCotacao - Cursores locais das grades de Page3 (Cotacoes):
2011:     *
2012:     *   cursor_4c_Produtos      -> crSigCtTCt  (grdCotacoes, itens da cotacao)
2013:     *   cursor_4c_Fornecedores  -> crSigCtTFn  (grdFornecs, fornecedores A..F)
2014:     *
2015:     * Estrutura espelha docs/schema.sql (SigCtTCt/SigCtTFn), NUNCA o dump do
2016:     * legado (regra #22). CREATE CURSOR nasce READWRITE - pre-requisito para os
2017:     * REPLACE feitos pelos handlers de Valid/toggle das grades.
2018:     *--------------------------------------------------------------------------
2019:     PROTECTED PROCEDURE CriarCursoresCotacao()
2020:         IF USED("cursor_4c_Produtos")
2021:             USE IN cursor_4c_Produtos
2022:         ENDIF
2023: 
2024:         CREATE CURSOR cursor_4c_Produtos ( ;
2025:             cIdChaves  C(20), Codigos N(6),    CItens     N(6),    CPros   C(14), ;
2026:             DPros      C(65), CUnis   C(3),    CodCors    C(4),    CodTams C(4), ;
2027:             EmpDopNums C(29), Obs     M(4),    Justificas M(4), ;
2028:             Qtds       N(15,2), QtdAdqs  N(15,2), ValAdqs N(15,6), ;
2029:             Marca01 L(1), Marca02 L(1), Marca03 L(1), Marca04 L(1), Marca05 L(1), Marca06 L(1), ;
2030:             Unit01 N(15,6), Unit02 N(15,6), Unit03 N(15,6), Unit04 N(15,6), Unit05 N(15,6), Unit06 N(15,6), ;
2031:             Tota01 N(15,6), Tota02 N(15,6), Tota03 N(15,6), Tota04 N(15,6), Tota05 N(15,6), Tota06 N(15,6))
2032: 
2033:         INDEX ON CItens TAG Ordem
2034: 
2035:         IF USED("cursor_4c_Fornecedores")
2036:             USE IN cursor_4c_Fornecedores
2037:         ENDIF
2038: 
2039:         CREATE CURSOR cursor_4c_Fornecedores ( ;
2040:             cIdChaves C(20), Codigos N(6), Grades C(1), IClis C(10), Fornecs C(40), ;
2041:             Contatos  C(20), Tel1s   C(20), FPags  C(12), DtEnts D(8), ;
2042:             Fretes    C(12), VlFretes N(11,2))
2043: 
2044:         INDEX ON Grades TAG Ordem
2045:     ENDPROC
2046: 
2047:     *--------------------------------------------------------------------------
2048:     * ConfigurarComplCots - Item B da Fase 6: PageFrame interno pgf_4c_ComplCots
2049:     * (3 sub-abas: Adicionais/Aprovacao Final/Aprovacao Solicitante), criado em
2050:     * Page3 - Top/Left/Width/Height EXATOS do SCX (pgfComplCots). Tabs = .T.:
2051:     * sao 3 sub-telas alternadas manualmente pelo usuario (Complementos /
2052:     * Aprovacao Final / Aprovacao Solicitante), nao um wizard escondido.
2053:     *
2054:     * Page1=pgAdicionais, Page2=pgAprovacao, Page3=pgSolicitas - mesma ordem de

*-- Linhas 2062 a 2092:
2062:         loc_oPgf = par_oPagina.pgf_4c_ComplCots
2063: 
2064:         WITH loc_oPgf
2065:             .Top       = 6
2066:             .Left      = 407
2067:             .Width     = 500
2068:             .Height    = 100
2069:             .PageCount = 3
2070:             .Tabs      = .T.
2071:             .Visible   = .T.
2072: 
2073:             .Page1.Caption   = "Complementos"
2074:             .Page1.FontName  = "Verdana"
2075:             .Page1.FontSize  = 8
2076:             .Page1.FontBold  = .T.
2077:             .Page1.BackColor = RGB(255, 255, 255)
2078:             .Page1.ForeColor = RGB(36, 84, 155)
2079: 
2080:             .Page2.Caption   = "Aprova" + CHR(231) + CHR(227) + "o Final"
2081:             .Page2.FontName  = "Verdana"
2082:             .Page2.FontSize  = 8
2083:             .Page2.FontBold  = .T.
2084:             .Page2.BackColor = RGB(255, 255, 255)
2085:             .Page2.ForeColor = RGB(36, 84, 155)
2086: 
2087:             .Page3.Caption   = "Aprova" + CHR(231) + CHR(227) + "o Solicitante"
2088:             .Page3.FontName  = "Verdana"
2089:             .Page3.FontSize  = 8
2090:             .Page3.FontBold  = .T.
2091:             .Page3.BackColor = RGB(255, 255, 255)
2092:             .Page3.ForeColor = RGB(36, 84, 155)

*-- Linhas 2099 a 2154:
2099:         *====================================================================
2100:         * Page1 - pgAdicionais (Entrega geral / Justificativa geral)
2101:         *====================================================================
2102:         loc_oPg1.AddObject("lbl_4c_Label14", "Label")
2103:         WITH loc_oPg1.lbl_4c_Label14
2104:             .FontBold  = .T.
2105:             .FontSize  = 8
2106:             .Caption   = "Justificativa :"
2107:             .Left      = 5
2108:             .Top       = 20
2109:             .ForeColor = RGB(36, 84, 155)
2110:             .BackStyle = 0
2111:             .Alignment = 0
2112:             .Visible   = .T.
2113:         ENDWITH
2114: 
2115:         loc_oPg1.AddObject("obj_4c_GetJustGeral", "EditBox")
2116:         WITH loc_oPg1.obj_4c_GetJustGeral
2117:             .FontName      = "Arial"
2118:             .FontSize      = 8
2119:             .Height        = 20
2120:             .Left          = 96
2121:             .Top           = 18
2122:             .Width         = 353
2123:             .SpecialEffect = 1
2124:             .BorderColor   = RGB(0, 0, 128)
2125:             .Value         = ""
2126:             .Visible       = .T.
2127:         ENDWITH
2128: 
2129:         loc_oPg1.AddObject("lbl_4c_Label13", "Label")
2130:         WITH loc_oPg1.lbl_4c_Label13
2131:             .FontBold  = .T.
2132:             .FontSize  = 8
2133:             .Caption   = "Entrega :"
2134:             .Left      = 33
2135:             .Top       = 42
2136:             .ForeColor = RGB(36, 84, 155)
2137:             .BackStyle = 0
2138:             .Alignment = 0
2139:             .Visible   = .T.
2140:         ENDWITH
2141: 
2142:         loc_oPg1.AddObject("txt_4c_ContaEs", "TextBox")
2143:         WITH loc_oPg1.txt_4c_ContaEs
2144:             .FontName      = "Arial"
2145:             .FontSize      = 8
2146:             .Alignment     = 3
2147:             .Height        = 20
2148:             .Left          = 96
2149:             .Top           = 40
2150:             .Width         = 80
2151:             .MaxLength     = 10
2152:             .SpecialEffect = 1
2153:             .BorderColor   = RGB(0, 0, 128)
2154:             .Value         = ""

*-- Linhas 2161 a 2170:
2161:             .FontSize      = 8
2162:             .Alignment     = 3
2163:             .Height        = 20
2164:             .Left          = 178
2165:             .Top           = 40
2166:             .Width         = 271
2167:             .MaxLength     = 50
2168:             .SpecialEffect = 1
2169:             .BorderColor   = RGB(0, 0, 128)
2170:             .ReadOnly      = .T.

*-- Linhas 2177 a 2214:
2177:         *-- do cliente/grupo pela ContaEs eh transcrita; o passo de abrir a
2178:         *-- tela de endereco vira um aviso encaminhando para o cadastro de
2179:         *-- Clientes, que eh onde os enderecos de entrega devem ser mantidos.
2180:         loc_oPg1.AddObject("cmd_4c_CmdEntrega", "CommandButton")
2181:         WITH loc_oPg1.cmd_4c_CmdEntrega
2182:             .Top           = 20
2183:             .Left          = 451
2184:             .Height        = 20
2185:             .Width         = 20
2186:             .Picture       = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
2187:             .Caption       = ""
2188:             .ToolTipText   = "Local de Entrega"
2189:             .SpecialEffect = 0
2190:             .BackColor     = RGB(255, 255, 255)
2191:             .Themes        = .F.
2192:             .Visible       = .T.
2193:         ENDWITH
2194: 
2195:         BINDEVENT(loc_oPg1.obj_4c_GetJustGeral, "KeyPress", THIS, "ValidarJustGeral")
2196:         BINDEVENT(loc_oPg1.txt_4c_ContaEs,      "KeyPress",  THIS, "TeclaContaEsGeral")
2197:         BINDEVENT(loc_oPg1.txt_4c_DContaEs,     "KeyPress",  THIS, "TeclaDContaEsGeral")
2198:         BINDEVENT(loc_oPg1.cmd_4c_CmdEntrega,   "Click",     THIS, "BtnEntregaGeralClick")
2199: 
2200:         *====================================================================
2201:         * Page2 - pgAprovacao (Aprovacao Final)
2202:         *====================================================================
2203:         loc_oPg2.AddObject("lbl_4c_Label15", "Label")
2204:         WITH loc_oPg2.lbl_4c_Label15
2205:             .FontBold  = .T.
2206:             .FontSize  = 8
2207:             .Caption   = "Aprovador"
2208:             .Left      = 7
2209:             .Top       = 20
2210:             .Width     = 71
2211:             .ForeColor = RGB(36, 84, 155)
2212:             .BackStyle = 0
2213:             .Alignment = 0
2214:             .Visible   = .T.

*-- Linhas 2220 a 2244:
2220:             .FontSize      = 8
2221:             .Format        = "K"
2222:             .Height        = 20
2223:             .Left          = 7
2224:             .Top           = 36
2225:             .Width         = 80
2226:             .MaxLength     = 10
2227:             .SpecialEffect = 1
2228:             .BorderColor   = RGB(0, 0, 128)
2229:             .Value         = ""
2230:             .Visible       = .T.
2231:         ENDWITH
2232: 
2233:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
2234:         WITH loc_oPg2.lbl_4c_Label6
2235:             .FontBold  = .T.
2236:             .FontSize  = 8
2237:             .Caption   = "Data"
2238:             .Left      = 89
2239:             .Top       = 20
2240:             .Width     = 32
2241:             .ForeColor = RGB(36, 84, 155)
2242:             .BackStyle = 0
2243:             .Alignment = 0
2244:             .Visible   = .T.

*-- Linhas 2250 a 2306:
2250:             .FontSize      = 8
2251:             .InputMask     = "99/99/9999"
2252:             .Height        = 20
2253:             .Left          = 89
2254:             .Top           = 36
2255:             .Width         = 64
2256:             .SpecialEffect = 1
2257:             .BorderColor   = RGB(0, 0, 128)
2258:             .Value         = {}
2259:             .Visible       = .T.
2260:         ENDWITH
2261: 
2262:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
2263:         WITH loc_oPg2.lbl_4c_Label1
2264:             .FontBold  = .T.
2265:             .FontSize  = 8
2266:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Aprova" + CHR(231) + CHR(227) + "o"
2267:             .Left      = 155
2268:             .Top       = 21
2269:             .Width     = 173
2270:             .ForeColor = RGB(36, 84, 155)
2271:             .BackStyle = 0
2272:             .Alignment = 0
2273:             .Visible   = .T.
2274:         ENDWITH
2275: 
2276:         loc_oPg2.AddObject("obj_4c_GetObsAprovs", "EditBox")
2277:         WITH loc_oPg2.obj_4c_GetObsAprovs
2278:             .FontName      = "Arial"
2279:             .FontSize      = 8
2280:             .Height        = 20
2281:             .Left          = 155
2282:             .Top           = 36
2283:             .Width         = 295
2284:             .SpecialEffect = 1
2285:             .BorderColor   = RGB(0, 0, 128)
2286:             .Value         = ""
2287:             .Visible       = .T.
2288:         ENDWITH
2289: 
2290:         *-- chkAprovador - Picture normal (nao aprovado) / DownPicture (aprovado)
2291:         loc_oPg2.AddObject("chk_4c_ChkAprovador", "CheckBox")
2292:         WITH loc_oPg2.chk_4c_ChkAprovador
2293:             .Top            = 17
2294:             .Left           = 451
2295:             .Height         = 40
2296:             .Width          = 40
2297:             .Style          = 1
2298:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
2299:             .DownPicture    = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
2300:             .Alignment      = 0
2301:             .Caption        = ""
2302:             .SpecialEffect  = 1
2303:             .BackColor      = RGB(255, 255, 255)
2304:             .Value          = 0
2305:             .Visible        = .T.
2306:         ENDWITH

*-- Linhas 2313 a 2356:
2313:         *====================================================================
2314:         * Page3 - pgSolicitas (Aprovacao do Solicitante)
2315:         *====================================================================
2316:         loc_oPg3.AddObject("lbl_4c_Label15", "Label")
2317:         WITH loc_oPg3.lbl_4c_Label15
2318:             .FontBold  = .T.
2319:             .FontSize  = 8
2320:             .Caption   = "Aprovador"
2321:             .Left      = 5
2322:             .Top       = 19
2323:             .Width     = 71
2324:             .ForeColor = RGB(36, 84, 155)
2325:             .BackStyle = 0
2326:             .Alignment = 0
2327:             .Visible   = .T.
2328:         ENDWITH
2329: 
2330:         loc_oPg3.AddObject("txt_4c_AprSols", "TextBox")
2331:         WITH loc_oPg3.txt_4c_AprSols
2332:             .FontName      = "Arial"
2333:             .FontSize      = 8
2334:             .Height        = 20
2335:             .Left          = 5
2336:             .Top           = 35
2337:             .Width         = 80
2338:             .SpecialEffect = 1
2339:             .BorderColor   = RGB(0, 0, 128)
2340:             .ReadOnly      = .T.
2341:             .Value         = ""
2342:             .Visible       = .T.
2343:         ENDWITH
2344: 
2345:         loc_oPg3.AddObject("lbl_4c_Label6", "Label")
2346:         WITH loc_oPg3.lbl_4c_Label6
2347:             .FontBold  = .T.
2348:             .FontSize  = 8
2349:             .Caption   = "Data"
2350:             .Left      = 87
2351:             .Top       = 19
2352:             .Width     = 32
2353:             .ForeColor = RGB(36, 84, 155)
2354:             .BackStyle = 0
2355:             .Alignment = 0
2356:             .Visible   = .T.

*-- Linhas 2362 a 2538:
2362:             .FontSize      = 8
2363:             .InputMask     = "99/99/9999"
2364:             .Height        = 20
2365:             .Left          = 87
2366:             .Top           = 35
2367:             .Width         = 64
2368:             .SpecialEffect = 1
2369:             .BorderColor   = RGB(0, 0, 128)
2370:             .Value         = {}
2371:             .Visible       = .T.
2372:         ENDWITH
2373: 
2374:         loc_oPg3.AddObject("lbl_4c_Label1", "Label")
2375:         WITH loc_oPg3.lbl_4c_Label1
2376:             .FontBold  = .T.
2377:             .FontSize  = 8
2378:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Aprova" + CHR(231) + CHR(227) + "o"
2379:             .Left      = 153
2380:             .Top       = 20
2381:             .Width     = 173
2382:             .ForeColor = RGB(36, 84, 155)
2383:             .BackStyle = 0
2384:             .Alignment = 0
2385:             .Visible   = .T.
2386:         ENDWITH
2387: 
2388:         loc_oPg3.AddObject("obj_4c_GetObsAprSols", "EditBox")
2389:         WITH loc_oPg3.obj_4c_GetObsAprSols
2390:             .FontName      = "Arial"
2391:             .FontSize      = 8
2392:             .Height        = 20
2393:             .Left          = 153
2394:             .Top           = 35
2395:             .Width         = 339
2396:             .SpecialEffect = 1
2397:             .BorderColor   = RGB(0, 0, 128)
2398:             .Value         = ""
2399:             .Visible       = .T.
2400:         ENDWITH
2401: 
2402:         BINDEVENT(loc_oPg3.txt_4c_DtAprSols,     "KeyPress", THIS, "ValidarDtAprSols")
2403:         BINDEVENT(loc_oPg3.obj_4c_GetObsAprSols, "KeyPress", THIS, "ValidarObsAprSols")
2404:     ENDPROC
2405: 
2406:     *--------------------------------------------------------------------------
2407:     * ConfigurarGridFornecs - Item D da Fase 6: grade de Fornecedores A..F
2408:     * (grdFornecs do legado, ligada a crSigCtTFn -> cursor_4c_Fornecedores).
2409:     *
2410:     * RENUMERACAO (PILAR 3): o SCX legado tem ColumnCount=9 mas usa nomes de
2411:     * Column INVERTIDOS/reaproveitados (Column2 do codigo eh a 7a coluna
2412:     * fisica, Column3/5/6/7/8/9/10 pulam o "Column4") - artefato de edicao do
2413:     * Form Designer, documentado no CLAUDE.md como "numeracao rara". Aqui a
2414:     * grade eh RENUMERADA em ordem natural e crescente, sem lacunas:
2415:     *
2416:     *   Column1=indicador(cor+Grades) Column2=Codigo   Column3=Fornecedor
2417:     *   Column4=Contato               Column5=Telefone Column6=Condicao
2418:     *   Column7=Entrega               Column8=Frete     Column9=Valor Frete
2419:     *--------------------------------------------------------------------------
2420:     PROTECTED PROCEDURE ConfigurarGridFornecs(par_oPagina)
2421:         LOCAL loc_oGrid, loc_cCor
2422: 
2423:         par_oPagina.AddObject("grd_4c_Fornecedores", "Grid")
2424:         loc_oGrid = par_oPagina.grd_4c_Fornecedores
2425: 
2426:         loc_cCor = ;
2427:             "IIF(cursor_4c_Fornecedores.Grades = [A], RGB(0,0,128), " + ;
2428:             "IIF(cursor_4c_Fornecedores.Grades = [B], RGB(0,128,0), " + ;
2429:             "IIF(cursor_4c_Fornecedores.Grades = [C], RGB(185,0,0), " + ;
2430:             "IIF(cursor_4c_Fornecedores.Grades = [D], RGB(128,64,0), " + ;
2431:             "IIF(cursor_4c_Fornecedores.Grades = [E], RGB(255,128,0), RGB(128,128,192))))))"
2432: 
2433:         WITH loc_oGrid
2434:             .ColumnCount   = 9
2435:             .Top           = 164
2436:             .Left          = 7
2437:             .Width         = 984
2438:             .Height        = 81
2439:             .FontName      = "Tahoma"
2440:             .FontSize      = 8
2441:             .HeaderHeight  = 16
2442:             .RowHeight     = 15
2443:             .ScrollBars    = 3
2444:             .DeleteMark    = .F.
2445:             .RecordMark    = .F.
2446:             .ReadOnly      = .F.
2447:             .GridLineColor = RGB(128, 128, 128)
2448:             .Visible       = .T.
2449: 
2450:             .RecordSource          = "cursor_4c_Fornecedores"
2451:             .Column1.ControlSource = "cursor_4c_Fornecedores.Grades"
2452:             .Column2.ControlSource = "cursor_4c_Fornecedores.IClis"
2453:             .Column3.ControlSource = "cursor_4c_Fornecedores.Fornecs"
2454:             .Column4.ControlSource = "cursor_4c_Fornecedores.Contatos"
2455:             .Column5.ControlSource = "cursor_4c_Fornecedores.Tel1s"
2456:             .Column6.ControlSource = "cursor_4c_Fornecedores.FPags"
2457:             .Column7.ControlSource = "cursor_4c_Fornecedores.DtEnts"
2458:             .Column8.ControlSource = "cursor_4c_Fornecedores.Fretes"
2459:             .Column9.ControlSource = "cursor_4c_Fornecedores.VlFretes"
2460:         ENDWITH
2461: 
2462:         WITH loc_oGrid.Column1
2463:             .FontBold          = .T.
2464:             .Alignment         = 2
2465:             .Movable           = .F.
2466:             .Resizable         = .F.
2467:             .ReadOnly          = .T.
2468:             .Sparse            = .F.
2469:             .DynamicForeColor  = loc_cCor
2470:             .Header1.Caption   = ""
2471:             .Header1.FontSize  = 8
2472:         ENDWITH
2473: 
2474:         WITH loc_oGrid.Column2
2475:             .FontBold          = .T.
2476:             .Movable           = .F.
2477:             .Resizable         = .F.
2478:             .DynamicForeColor  = loc_cCor
2479:             .Format            = "K"
2480:             .Text1.MaxLength         = 10
2481:             .Header1.Caption   = "C" + CHR(243) + "digo"
2482:             .Header1.Alignment = 2
2483:             .Header1.FontSize  = 8
2484:         ENDWITH
2485: 
2486:         WITH loc_oGrid.Column3
2487:             .Movable           = .F.
2488:             .Resizable         = .F.
2489:             .DynamicForeColor  = loc_cCor
2490:             .Format            = "K"
2491:             .Text1.MaxLength         = 40
2492:             .Header1.Caption   = "Fornecedor"
2493:             .Header1.Alignment = 2
2494:             .Header1.FontSize  = 8
2495:         ENDWITH
2496: 
2497:         WITH loc_oGrid.Column4
2498:             .Movable           = .F.
2499:             .Resizable         = .F.
2500:             .Format            = "K"
2501:             .Text1.MaxLength         = 20
2502:             .Header1.Caption   = "Contato"
2503:             .Header1.Alignment = 2
2504:             .Header1.FontSize  = 8
2505:         ENDWITH
2506: 
2507:         WITH loc_oGrid.Column5
2508:             .Movable           = .F.
2509:             .Resizable         = .F.
2510:             .Format            = "K"
2511:             .Text1.MaxLength         = 20
2512:             .Header1.Caption   = "Telefone"
2513:             .Header1.Alignment = 2
2514:             .Header1.FontSize  = 8
2515:         ENDWITH
2516: 
2517:         WITH loc_oGrid.Column6
2518:             .Movable           = .F.
2519:             .Resizable         = .F.
2520:             .Format            = "K"
2521:             .Text1.MaxLength         = 12
2522:             .Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o"
2523:             .Header1.Alignment = 2
2524:             .Header1.FontSize  = 8
2525:         ENDWITH
2526: 
2527:         WITH loc_oGrid.Column7
2528:             .Alignment         = 3
2529:             .Movable           = .F.
2530:             .Resizable         = .F.
2531:             .Format            = "E"
2532:             .InputMask         = "99/99/9999"
2533:             .Header1.Caption   = "Entrega"
2534:             .Header1.Alignment = 2
2535:             .Header1.FontSize  = 8
2536:         ENDWITH
2537: 
2538:         *-- Frete: lista fechada de 2 valores (Emitente/Destinatario), sem

*-- Linhas 2544 a 2563:
2544:             .Resizable         = .F.
2545:             .Format            = "KM"
2546:             .InputMask         = "Emitente,Destinatario"
2547:             .Header1.Caption   = "Frete"
2548:             .Header1.Alignment = 2
2549:             .Header1.FontSize  = 8
2550:         ENDWITH
2551: 
2552:         WITH loc_oGrid.Column9
2553:             .Alignment         = 3
2554:             .Movable           = .F.
2555:             .Resizable         = .F.
2556:             .Format            = "999,999.99"
2557:             .InputMask        = "999,999.99"
2558:             .Header1.Caption   = "Valor Frete"
2559:             .Header1.Alignment = 2
2560:             .Header1.FontSize  = 8
2561:         ENDWITH
2562: 
2563:         *-- Larguras por ULTIMO (valores EXATOS do SCX, na ordem renumerada)

*-- Linhas 2591 a 2670:
2591:         BINDEVENT(loc_oGrid.Column6.Text1, "KeyPress", THIS, "ValidarCondicaoPagtoGrid")
2592:     ENDPROC
2593: 
2594:     *--------------------------------------------------------------------------
2595:     * ConfigurarGridCotacoes - Item C da Fase 6: grade de Produtos da cotacao
2596:     * (grdCotacoes do legado, ligada a crSigCtTCt -> cursor_4c_Produtos).
2597:     * ColumnCount=25 - numeracao IGUAL a legada (Column1..Column25), pois o
2598:     * SCX aqui usa a ordem natural (o ColumnOrder do legado so muda a ordem
2599:     * VISUAL de exibicao, nao a identidade das colunas - transcrito o dump de
2600:     * comportamento por NUMERO de Column, nao por posicao na tela):
2601:     *
2602:     *   1=Produto 2=Solicitada(RO) 3=Adquirida 4=Uni 5=ValorAdq.
2603:     *   6/9/12/15/18/21 = Check A/B/C/D/E/F     7/10/13/16/19/22 = Unitario A..F
2604:     *   8/11/14/17/20/23 = Total A..F           24=Tam 25=Cor
2605:     *--------------------------------------------------------------------------
2606:     PROTECTED PROCEDURE ConfigurarGridCotacoes(par_oPagina)
2607:         LOCAL loc_oGrid
2608: 
2609:         par_oPagina.AddObject("grd_4c_Produtos", "Grid")
2610:         loc_oGrid = par_oPagina.grd_4c_Produtos
2611: 
2612:         WITH loc_oGrid
2613:             .ColumnCount   = 25
2614:             .Top           = 260
2615:             .Left          = 7
2616:             .Width         = 984
2617:             .Height        = 216
2618:             .FontName      = "Tahoma"
2619:             .FontSize      = 8
2620:             .HeaderHeight  = 16
2621:             .RowHeight     = 15
2622:             .ScrollBars    = 3
2623:             .DeleteMark    = .F.
2624:             .RecordMark    = .F.
2625:             .ReadOnly      = .F.
2626:             .GridLineColor = RGB(128, 128, 128)
2627:             .Visible       = .T.
2628: 
2629:             .RecordSource           = "cursor_4c_Produtos"
2630:             .Column1.ControlSource  = "cursor_4c_Produtos.CPros"
2631:             .Column2.ControlSource  = "cursor_4c_Produtos.Qtds"
2632:             .Column3.ControlSource  = "cursor_4c_Produtos.QtdAdqs"
2633:             .Column4.ControlSource  = "cursor_4c_Produtos.CUnis"
2634:             .Column5.ControlSource  = "cursor_4c_Produtos.ValAdqs"
2635:             .Column6.ControlSource  = "cursor_4c_Produtos.Marca01"
2636:             .Column7.ControlSource  = "cursor_4c_Produtos.Unit01"
2637:             .Column8.ControlSource  = "cursor_4c_Produtos.Tota01"
2638:             .Column9.ControlSource  = "cursor_4c_Produtos.Marca02"
2639:             .Column10.ControlSource = "cursor_4c_Produtos.Unit02"
2640:             .Column11.ControlSource = "cursor_4c_Produtos.Tota02"
2641:             .Column12.ControlSource = "cursor_4c_Produtos.Marca03"
2642:             .Column13.ControlSource = "cursor_4c_Produtos.Unit03"
2643:             .Column14.ControlSource = "cursor_4c_Produtos.Tota03"
2644:             .Column15.ControlSource = "cursor_4c_Produtos.Marca04"
2645:             .Column16.ControlSource = "cursor_4c_Produtos.Unit04"
2646:             .Column17.ControlSource = "cursor_4c_Produtos.Tota04"
2647:             .Column18.ControlSource = "cursor_4c_Produtos.Marca05"
2648:             .Column19.ControlSource = "cursor_4c_Produtos.Unit05"
2649:             .Column20.ControlSource = "cursor_4c_Produtos.Tota05"
2650:             .Column21.ControlSource = "cursor_4c_Produtos.Marca06"
2651:             .Column22.ControlSource = "cursor_4c_Produtos.Unit06"
2652:             .Column23.ControlSource = "cursor_4c_Produtos.Tota06"
2653:             .Column24.ControlSource = "cursor_4c_Produtos.CodTams"
2654:             .Column25.ControlSource = "cursor_4c_Produtos.CodCors"
2655:         ENDWITH
2656: 
2657:         *-- Column1 (Produto) - link azul sublinhado, igual ao legado
2658:         WITH loc_oGrid.Column1
2659:             .FontBold          = .T.
2660:             .FontUnderline     = .T.
2661:             .ReadOnly          = .F.
2662:             .Sparse            = .F.
2663:             .Format            = "K"
2664:             .Text1.MaxLength         = 14
2665:             .Header1.Caption   = "Produto"
2666:             .Header1.Alignment = 2
2667:             .Header1.FontBold  = .T.
2668:             .Header1.FontSize  = 8
2669:             .Text1.FontBold    = .T.
2670:             .Text1.FontUnderline = .T.

*-- Linhas 2677 a 2710:
2677:             .ReadOnly          = .T.
2678:             .Format            = "999,999.99"
2679:             .InputMask         = "999,999.99"
2680:             .Header1.Caption   = "Solicitada"
2681:             .Header1.Alignment = 2
2682:             .Header1.FontSize  = 8
2683:         ENDWITH
2684: 
2685:         WITH loc_oGrid.Column3
2686:             .Format            = "999,999.99"
2687:             .InputMask         = "999,999.99"
2688:             .Header1.Caption   = "Adquirida"
2689:             .Header1.Alignment = 2
2690:             .Header1.FontSize  = 8
2691:         ENDWITH
2692: 
2693:         WITH loc_oGrid.Column4
2694:             .Format            = "K"
2695:             .Text1.MaxLength         = 3
2696:             .Header1.Caption   = "Uni"
2697:             .Header1.Alignment = 2
2698:             .Header1.FontSize  = 8
2699:         ENDWITH
2700: 
2701:         WITH loc_oGrid.Column5
2702:             .Format            = "999,999.999999"
2703:             .InputMask         = "999,999.999999"
2704:             .ToolTipText       = "Duplo Click - Sele" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica de Valores"
2705:             .Header1.Caption   = "Valor Adq."
2706:             .Header1.Alignment = 2
2707:             .Header1.FontSize  = 8
2708:         ENDWITH
2709: 
2710:         *-- Pares Check/Unitario/Total dos 6 fornecedores (A..F)

*-- Linhas 2718 a 2734:
2718:         WITH loc_oGrid.Column24
2719:             .Format            = "K"
2720:             .Text1.MaxLength         = 4
2721:             .Header1.Caption   = "Tam"
2722:             .Header1.Alignment = 2
2723:             .Header1.FontSize  = 8
2724:         ENDWITH
2725: 
2726:         WITH loc_oGrid.Column25
2727:             .Format            = "K"
2728:             .Text1.MaxLength         = 4
2729:             .Header1.Caption   = "Cor"
2730:             .Header1.Alignment = 2
2731:             .Header1.FontSize  = 8
2732:         ENDWITH
2733: 
2734:         *-- Larguras por ULTIMO (valores EXATOS do SCX)

*-- Linhas 2789 a 2812:
2789:         loc_cNum     = par_cNum
2790:         loc_oColChk  = EVALUATE("par_oGrid.Column" + TRANSFORM(par_nColChk))
2791:         loc_oColUnit = EVALUATE("par_oGrid.Column" + TRANSFORM(par_nColUnit))
2792:         loc_oColTot  = EVALUATE("par_oGrid.Column" + TRANSFORM(par_nColTot))
2793: 
2794:         loc_cDinBack = "IIF(cursor_4c_Produtos.Marca" + loc_cNum + ", RGB(255,255,223), RGB(255,255,255))"
2795: 
2796:         IF !PEMSTATUS(loc_oColChk, "chk_4c_Marca" + loc_cNum, 5)
2797:             loc_oColChk.AddObject("chk_4c_Marca" + loc_cNum, "CheckBox")
2798:         ENDIF
2799: 
2800:         WITH EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum)
2801:             .Top       = 9
2802:             .Left      = 2
2803:             .Height    = 17
2804:             .Width     = 60
2805:             .FontSize  = 8
2806:             .Alignment = 0
2807:             .Caption   = ""
2808:             .BackStyle = 0
2809:             .ReadOnly  = .F.
2810:             .ToolTipText = "Duplo Click - Sele" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica do Fornecedor"
2811:             .Visible   = .T.
2812:         ENDWITH

*-- Linhas 2818 a 2856:
2818:             .Movable          = .F.
2819:             .Resizable        = .F.
2820:             .BackColor        = par_nCor
2821:             .Header1.Caption  = par_cLetra
2822:             .Header1.ForeColor = par_nCor
2823:             .Header1.FontBold = .T.
2824:             .Header1.FontSize = 8
2825:             .Header1.Alignment = 2
2826:         ENDWITH
2827: 
2828:         WITH loc_oColUnit
2829:             .Format           = "99999.999999"
2830:             .InputMask        = "99999.999999"
2831:             .DynamicBackColor = loc_cDinBack
2832:             .Header1.Caption  = "Unit" + CHR(225) + "rio"
2833:             .Header1.ForeColor = par_nCor
2834:             .Header1.FontBold = .T.
2835:             .Header1.Alignment = 2
2836:             .Header1.FontSize = 8
2837:         ENDWITH
2838: 
2839:         WITH loc_oColTot
2840:             .Format           = "999999.999999"
2841:             .InputMask        = "999999.999999"
2842:             .DynamicBackColor = loc_cDinBack
2843:             .Header1.Caption  = "Total"
2844:             .Header1.ForeColor = par_nCor
2845:             .Header1.FontBold = .T.
2846:             .Header1.Alignment = 2
2847:             .Header1.FontSize = 8
2848:         ENDWITH
2849: 
2850:         *-- Toggle de marcacao: NoDefault + 4 handlers manuais (regra CLAUDE.md
2851:         *-- "CheckBox em Grid Column nao alterna pelo binding nativo")
2852:         DO CASE
2853:             CASE par_cLetra = "A"
2854:                 BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "Click",     THIS, "GridMarcaClickNoDefault")
2855:                 BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseUp",   THIS, "GridMarcaMouseUpNoDefault")
2856:                 BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseDown", THIS, "ChkMarcaAMouseDown")

*-- Linhas 2929 a 2969:
2929:             .ButtonCount = 2
2930:             .BackStyle   = 0
2931:             .BorderStyle = 0
2932:             .Top         = 7
2933:             .Left        = 246
2934:             .Width       = 162
2935:             .Height      = 100
2936:             .Visible     = .T.
2937: 
2938:             WITH .Buttons(1)
2939:                 .Top             = 0
2940:                 .Left            = 0
2941:                 .Height          = 100
2942:                 .Width           = 80
2943:                 .WordWrap        = .T.
2944:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
2945:                 .Caption         = "Excluir Produto"
2946:                 .MousePointer    = 15
2947:                 .ToolTipText     = "Excluir o Produto da Cota" + CHR(231) + CHR(227) + "o"
2948:                 .SpecialEffect   = 0
2949:                 .PicturePosition = 7
2950:                 .ForeColor       = RGB(36, 84, 155)
2951:                 .BackColor       = RGB(255, 255, 255)
2952:                 .Themes          = .F.
2953:             ENDWITH
2954: 
2955:             WITH .Buttons(2)
2956:                 .Top             = 0
2957:                 .Left            = 80
2958:                 .Height          = 100
2959:                 .Width           = 80
2960:                 .FontName        = "Verdana"
2961:                 .FontSize        = 8
2962:                 .WordWrap        = .T.
2963:                 .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2964:                 .Caption         = "Hist" + CHR(243) + "rico do Produto"
2965:                 .MousePointer    = 15
2966:                 .ToolTipText     = "Hist" + CHR(243) + "rico do Produto"
2967:                 .SpecialEffect   = 0
2968:                 .PicturePosition = 7
2969:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 2978 a 3000:
2978:             .ButtonCount = 1
2979:             .BackStyle   = 0
2980:             .BorderStyle = 0
2981:             .Top         = 7
2982:             .Left        = 910
2983:             .Width       = 90
2984:             .Height      = 100
2985:             .Visible     = .T.
2986: 
2987:             WITH .Buttons(1)
2988:                 .Top             = 0
2989:                 .Left            = 0
2990:                 .Height          = 100
2991:                 .Width           = 80
2992:                 .WordWrap        = .T.
2993:                 .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2994:                 .Cancel          = .T.
2995:                 .Caption         = "P" + CHR(225) + "gina de Dados"
2996:                 .MousePointer    = 15
2997:                 .ToolTipText     = "Voltar Para a P" + CHR(225) + "gina de Dados"
2998:                 .SpecialEffect   = 0
2999:                 .PicturePosition = 7
3000:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 3009 a 3068:
3009:             .ButtonCount = 3
3010:             .BackStyle   = 0
3011:             .BorderStyle = 0
3012:             .Top         = 7
3013:             .Left        = 6
3014:             .Width       = 240
3015:             .Height      = 100
3016:             .Visible     = .T.
3017: 
3018:             WITH .Buttons(1)
3019:                 .Top             = 0
3020:                 .Left            = 0
3021:                 .Height          = 100
3022:                 .Width           = 80
3023:                 .WordWrap        = .T.
3024:                 .Picture         = gc_4c_CaminhoIcones + "geral_disco_60.jpg"
3025:                 .Caption         = "Gravar Cota" + CHR(231) + CHR(227) + "o"
3026:                 .MousePointer    = 15
3027:                 .ToolTipText     = "Gravar Dados da Cota" + CHR(231) + CHR(227) + "o"
3028:                 .SpecialEffect   = 0
3029:                 .PicturePosition = 7
3030:                 .ForeColor       = RGB(36, 84, 155)
3031:                 .BackColor       = RGB(255, 255, 255)
3032:                 .Themes          = .F.
3033:             ENDWITH
3034: 
3035:             WITH .Buttons(2)
3036:                 .Top             = 0
3037:                 .Left            = 80
3038:                 .Height          = 100
3039:                 .Width           = 80
3040:                 .FontName        = "Verdana"
3041:                 .FontSize        = 8
3042:                 .WordWrap        = .T.
3043:                 .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
3044:                 .Caption         = "Gerar Pedidos"
3045:                 .MousePointer    = 15
3046:                 .ToolTipText     = "Gerar Pedidos"
3047:                 .SpecialEffect   = 0
3048:                 .PicturePosition = 7
3049:                 .ForeColor       = RGB(36, 84, 155)
3050:                 .BackColor       = RGB(255, 255, 255)
3051:                 .Themes          = .F.
3052:             ENDWITH
3053: 
3054:             WITH .Buttons(3)
3055:                 .Top             = 0
3056:                 .Left            = 160
3057:                 .Height          = 100
3058:                 .Width           = 80
3059:                 .FontName        = "Verdana"
3060:                 .FontSize        = 8
3061:                 .WordWrap        = .T.
3062:                 .Picture         = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
3063:                 .Caption         = "Imprimir Cota" + CHR(231) + CHR(227) + "o"
3064:                 .MousePointer    = 15
3065:                 .ToolTipText     = "Imprimir Cota" + CHR(231) + CHR(227) + "o"
3066:                 .SpecialEffect   = 0
3067:                 .PicturePosition = 7
3068:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 3079 a 3114:
3079:             .AutoSize    = .T.
3080:             .BackStyle   = 0
3081:             .BorderStyle = 0
3082:             .Top         = 492
3083:             .Left        = 663
3084:             .Width       = 91
3085:             .Height      = 50
3086:             .Visible     = .T.
3087: 
3088:             WITH .Buttons(1)
3089:                 .Top           = 5
3090:                 .Left          = 5
3091:                 .Height        = 40
3092:                 .Width         = 40
3093:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3094:                 .Caption       = ""
3095:                 .ToolTipText   = "Inserir Produto na Grade"
3096:                 .SpecialEffect = 0
3097:                 .BackColor     = RGB(255, 255, 255)
3098:                 .Themes        = .F.
3099:             ENDWITH
3100: 
3101:             WITH .Buttons(2)
3102:                 .Top           = 5
3103:                 .Left          = 46
3104:                 .Height        = 40
3105:                 .Width         = 40
3106:                 .FontName      = "Verdana"
3107:                 .FontSize      = 8
3108:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3109:                 .Caption       = ""
3110:                 .ToolTipText   = "Excluir Produto da Grade"
3111:                 .SpecialEffect = 0
3112:                 .BackColor     = RGB(255, 255, 255)
3113:                 .Themes        = .F.
3114:             ENDWITH

*-- Linhas 3148 a 3156:
3148:     *--------------------------------------------------------------------------
3149:     * AjustarCamposCotacao - Reproduz TODOS os PROCEDURE When de Page3 (campos
3150:     * de cabecalho, sub-abas de pgfComplCots e colunas das duas grades),
3151:     * usando ReadOnly (ou Enabled, no caso do CheckBox chk_4c_ChkAprovador) em
3152:     * vez de esconder o controle - exatamente como o legado faz.
3153:     *
3154:     * Gates usados (traduzidos das propriedades do BO/form, ja que este form
3155:     * nao mantem os cursores crSigCtTDc/crCotaPends do legado):
3156:     *   pcEscolha  -> THIS.this_cPcEscolha

*-- Linhas 3301 a 3356:
3301:         ENDIF
3302:     ENDPROC
3303: 
3304:     *--------------------------------------------------------------------------
3305:     * SalvarRodapeProdutoAtual - Copia getDPros/getObs/getJustificas (rodape
3306:     * de Page3) para a linha CORRENTE de cursor_4c_Produtos. Sao campos que o
3307:     * legado liga por ControlSource direto a crSigCtTCt; aqui, como o valor
3308:     * fica em controles de nivel de Page (fora da grade), a copia manual eh
3309:     * feita ao perder o foco - equivalente ao LostFocus nativo do binding.
3310:     *--------------------------------------------------------------------------
3311:     PROCEDURE SalvarRodapeProdutoAtual()
3312:         LOCAL loc_oPag
3313: 
3314:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3315:             RETURN
3316:         ENDIF
3317: 
3318:         loc_oPag = THIS.pgf_4c_Paginas.Page3
3319: 
3320:         SELECT cursor_4c_Produtos
3321:         REPLACE DPros      WITH ALLTRIM(loc_oPag.txt_4c_DPros.Value), ;
3322:                 Obs        WITH loc_oPag.obj_4c_GetObs.Value, ;
3323:                 Justificas WITH loc_oPag.obj_4c_GetJustificas.Value ;
3324:             IN cursor_4c_Produtos
3325:     ENDPROC
3326: 
3327:     *--------------------------------------------------------------------------
3328:     * GridCotacoesAfterRowColChange - Espelha a linha corrente do grd_4c_Produtos
3329:     * nos campos de rodape (equivalente ao Refresh dos 3 controles no legado,
3330:     * que estao ligados por ControlSource direto).
3331:     *--------------------------------------------------------------------------
3332:     PROCEDURE GridCotacoesAfterRowColChange(par_nColIndex)
3333:         LOCAL loc_oPag
3334: 
3335:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3336:             RETURN
3337:         ENDIF
3338: 
3339:         loc_oPag = THIS.pgf_4c_Paginas.Page3
3340: 
3341:         SELECT cursor_4c_Produtos
3342:         loc_oPag.txt_4c_DPros.Value         = ALLTRIM(NVL(DPros, ""))
3343:         loc_oPag.obj_4c_GetObs.Value        = NVL(Obs, "")
3344:         loc_oPag.obj_4c_GetJustificas.Value = NVL(Justificas, "")
3345:     ENDPROC
3346: 
3347:     *--------------------------------------------------------------------------
3348:     * GridCotacoesKeyPressComum / GridFornecsKeyPressComum - Navegacao comum
3349:     * Tab/Shift+Tab das colunas de texto das duas grades de Page3, transcrita
3350:     * do KeyPress identico presente em TODAS as colunas do dump legado.
3351:     *--------------------------------------------------------------------------
3352:     PROCEDURE GridCotacoesKeyPressComum(par_nKeyCode, par_nShiftAltCtrl)
3353:         DO CASE
3354:             CASE par_nKeyCode = 9   && TAB
3355:                 THIS.pgf_4c_Paginas.Page3.txt_4c_DPros.SetFocus()
3356:             CASE par_nKeyCode = 15  && SHIFT+TAB

*-- Linhas 3368 a 3376:
3368:     ENDPROC
3369: 
3370:     *--------------------------------------------------------------------------
3371:     * Marcacao de fornecedor (A..F) na grd_4c_Produtos - o CheckBox de Column
3372:     * NAO alterna pelo binding nativo (regra CLAUDE.md): Click/MouseUp so dao
3373:     * NODEFAULT; o toggle de verdade acontece no MouseDown/KeyPress(Enter/
3374:     * Espaco), chamando o helper generico AlternarMarcaCotacao. O DblClick do
3375:     * Header1 chama SelecionarTodosFornecedor (selecao em massa do legado).
3376:     *--------------------------------------------------------------------------

*-- Linhas 3551 a 3809:
3551:     * ValAdqs. Formula/sinal EXATOS do legado (regra CLAUDE.md #17).
3552:     *--------------------------------------------------------------------------
3553:     PROCEDURE AlternarMarcaCotacao(par_cNum)
3554:         LOCAL loc_lMarcado, loc_cCampo
3555: 
3556:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3557:             RETURN
3558:         ENDIF
3559: 
3560:         loc_cCampo  = "Marca" + par_cNum
3561:         loc_lMarcado = EVALUATE("cursor_4c_Produtos." + loc_cCampo)
3562: 
3563:         SELECT cursor_4c_Produtos
3564:         IF loc_lMarcado
3565:             REPLACE (loc_cCampo) WITH .F., ValAdqs WITH 0 IN cursor_4c_Produtos
3566:         ELSE
3567:             REPLACE Marca01 WITH .F., Marca02 WITH .F., Marca03 WITH .F., ;
3568:                     Marca04 WITH .F., Marca05 WITH .F., Marca06 WITH .F. IN cursor_4c_Produtos
3569:             REPLACE (loc_cCampo) WITH .T., ;
3570:                     ValAdqs WITH EVALUATE("cursor_4c_Produtos.Tota" + par_cNum) IN cursor_4c_Produtos
3571:         ENDIF
3572: 
3573:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
3574:     ENDPROC
3575: 
3576:     *--------------------------------------------------------------------------
3577:     * SelecionarTodosFornecedor - Header1.DblClick do legado: marca <par_cNum>
3578:     * em TODAS as linhas com Total preenchido e ValAdqs = Total, desmarcando os
3579:     * outros 5 fornecedores em todas as linhas (Update sem Where -> todas).
3580:     *--------------------------------------------------------------------------
3581:     PROCEDURE SelecionarTodosFornecedor(par_cNum)
3582:         LOCAL loc_cCampo, loc_cCampoTota, loc_nRegAtual, loc_nI, loc_cOutro
3583: 
3584:         IF !USED("cursor_4c_Produtos") ;
3585:            OR !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
3586:             RETURN
3587:         ENDIF
3588: 
3589:         loc_cCampo     = "Marca" + par_cNum
3590:         loc_cCampoTota = "Tota"  + par_cNum
3591:         loc_nRegAtual  = RECNO("cursor_4c_Produtos")
3592: 
3593:         *-- Transcrito literal do Header1.DblClick legado (3 passos
3594:         *-- distintos - inclusive a assimetria: so as OUTRAS 5 letras sao
3595:         *-- limpas incondicionalmente, a marcada so muda onde o Total dela
3596:         *-- esta preenchido). REPLACE...FOR (nao UPDATE-SQL) porque so REPLACE
3597:         *-- aceita nome de campo DINAMICO via parenteses em VFP9:
3598:         *-- Update Set Marca<N>=.t. Where Not Empty(Tota<N>)
3599:         *-- Update Set ValAdqs=Tota<N> Where Marca<N>
3600:         *-- Update Set Marca<outras 5>=.f. (todas as linhas)
3601:         SELECT cursor_4c_Produtos
3602:         REPLACE (loc_cCampo) WITH .T. FOR !EMPTY(EVALUATE(loc_cCampoTota)) IN cursor_4c_Produtos
3603:         REPLACE ValAdqs WITH EVALUATE(loc_cCampoTota) FOR EVALUATE(loc_cCampo) IN cursor_4c_Produtos
3604: 
3605:         FOR loc_nI = 1 TO 6
3606:             loc_cOutro = "Marca" + PADL(loc_nI, 2, "0")
3607:             IF loc_cOutro != loc_cCampo
3608:                 REPLACE (loc_cOutro) WITH .F. ALL IN cursor_4c_Produtos
3609:             ENDIF
3610:         ENDFOR
3611: 
3612:         GO TOP IN cursor_4c_Produtos
3613:         IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Produtos"))
3614:             GO loc_nRegAtual IN cursor_4c_Produtos
3615:         ENDIF
3616: 
3617:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
3618:     ENDPROC
3619: 
3620:     *--------------------------------------------------------------------------
3621:     * RecalcularTotalPorUnitario / RecalcularUnitarioPorTotal - Formulas
3622:     * TRANSCRITAS literalmente do Valid das colunas Unitario/Total (regra
3623:     * CLAUDE.md #17): Total = Unitario * QtdAdqs (com guard de negativo) e
3624:     * Unitario = Total / QtdAdqs (guard de divisao por zero).
3625:     *--------------------------------------------------------------------------
3626:     PROCEDURE RecalcularTotalPorUnitario(par_cNum)
3627:         LOCAL loc_nUnit, loc_nQtd, loc_nTotalNovo
3628: 
3629:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3630:             RETURN
3631:         ENDIF
3632: 
3633:         SELECT cursor_4c_Produtos
3634:         loc_nUnit = EVALUATE("Unit" + par_cNum)
3635: 
3636:         IF loc_nUnit < 0
3637:             REPLACE ("Unit" + par_cNum) WITH 0 IN cursor_4c_Produtos
3638:             loc_nUnit = 0
3639:         ENDIF
3640: 
3641:         loc_nQtd      = QtdAdqs
3642:         loc_nTotalNovo = loc_nUnit * loc_nQtd
3643: 
3644:         IF EVALUATE("Tota" + par_cNum) != loc_nTotalNovo
3645:             REPLACE ("Tota" + par_cNum) WITH loc_nTotalNovo IN cursor_4c_Produtos
3646:         ENDIF
3647: 
3648:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
3649:     ENDPROC
3650: 
3651:     PROCEDURE RecalcularUnitarioPorTotal(par_cNum)
3652:         LOCAL loc_nTotal, loc_nQtd, loc_nUnitNovo
3653: 
3654:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3655:             RETURN
3656:         ENDIF
3657: 
3658:         SELECT cursor_4c_Produtos
3659:         loc_nTotal = EVALUATE("Tota" + par_cNum)
3660: 
3661:         IF loc_nTotal < 0
3662:             REPLACE ("Tota" + par_cNum) WITH 0 IN cursor_4c_Produtos
3663:             loc_nTotal = 0
3664:         ENDIF
3665: 
3666:         loc_nQtd     = IIF(QtdAdqs = 0, 1, QtdAdqs)
3667:         loc_nUnitNovo = loc_nTotal / loc_nQtd
3668: 
3669:         IF EVALUATE("Unit" + par_cNum) != loc_nUnitNovo
3670:             REPLACE ("Unit" + par_cNum) WITH loc_nUnitNovo IN cursor_4c_Produtos
3671:         ENDIF
3672: 
3673:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
3674:     ENDPROC
3675: 
3676:     *--------------------------------------------------------------------------
3677:     * RecalcularTotaisPorQuantidade - Valid da Column3 (QtdAdqs): recalcula os
3678:     * 6 Totais quando a quantidade adquirida muda (Tota0N = Unit0N * Value),
3679:     * so para os fornecedores com Unitario preenchido - transcrito literal.
3680:     *--------------------------------------------------------------------------
3681:     PROCEDURE RecalcularTotaisPorQuantidade()
3682:         LOCAL loc_nQtd, loc_nI, loc_cNum
3683: 
3684:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3685:             RETURN
3686:         ENDIF
3687: 
3688:         SELECT cursor_4c_Produtos
3689:         loc_nQtd = QtdAdqs
3690: 
3691:         IF loc_nQtd < 0
3692:             REPLACE QtdAdqs WITH 0 IN cursor_4c_Produtos
3693:             loc_nQtd = 0
3694:         ENDIF
3695: 
3696:         FOR loc_nI = 1 TO 6
3697:             loc_cNum = PADL(loc_nI, 2, "0")
3698:             IF EVALUATE("Unit" + loc_cNum) > 0
3699:                 REPLACE ("Tota" + loc_cNum) WITH EVALUATE("Unit" + loc_cNum) * loc_nQtd IN cursor_4c_Produtos
3700:             ENDIF
3701:         ENDFOR
3702: 
3703:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
3704:     ENDPROC
3705: 
3706:     *--------------------------------------------------------------------------
3707:     * SelecaoAutomaticaMelhorPreco - Header1.DblClick da Column5 (ValAdqs):
3708:     * para cada linha, escolhe automaticamente o MENOR Total entre os 6
3709:     * fornecedores (so troca se o total for menor que o ValAdqs atual ou se
3710:     * ValAdqs estiver vazio) - transcrito do DblClick legado.
3711:     *--------------------------------------------------------------------------
3712:     PROCEDURE SelecaoAutomaticaMelhorPreco()
3713:         LOCAL loc_lConfirma, loc_nI, loc_cNum, loc_nRegAtual
3714: 
3715:         IF !USED("cursor_4c_Produtos")
3716:             RETURN
3717:         ENDIF
3718: 
3719:         loc_lConfirma = .T.
3720:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
3721:             loc_lConfirma = MsgConfirma("Deseja Realizar a Sele" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + ;
3722:                 "tica de Valores?", "Aten" + CHR(231) + CHR(227) + "o!!!")
3723:         ENDIF
3724: 
3725:         IF !loc_lConfirma
3726:             RETURN
3727:         ENDIF
3728: 
3729:         loc_nRegAtual = RECNO("cursor_4c_Produtos")
3730: 
3731:         SELECT cursor_4c_Produtos
3732:         SCAN
3733:             FOR loc_nI = 1 TO 6
3734:                 loc_cNum = PADL(loc_nI, 2, "0")
3735:                 IF !EMPTY(EVALUATE("Tota" + loc_cNum)) AND ;
3736:                    (EMPTY(ValAdqs) OR ValAdqs > EVALUATE("Tota" + loc_cNum))
3737:                     REPLACE Marca01 WITH .F., Marca02 WITH .F., Marca03 WITH .F., ;
3738:                             Marca04 WITH .F., Marca05 WITH .F., Marca06 WITH .F. IN cursor_4c_Produtos
3739:                     REPLACE ValAdqs WITH EVALUATE("Tota" + loc_cNum), ;
3740:                             ("Marca" + loc_cNum) WITH .T. IN cursor_4c_Produtos
3741:                 ENDIF
3742:             ENDFOR
3743:         ENDSCAN
3744: 
3745:         IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Produtos"))
3746:             GO loc_nRegAtual IN cursor_4c_Produtos
3747:         ENDIF
3748: 
3749:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
3750:     ENDPROC
3751: 
3752:     *--------------------------------------------------------------------------
3753:     * Column1 (Produto) da grd_4c_Produtos - GotFocus guarda o valor original
3754:     * (Tag), LostFocus reverte se a linha ja estiver vinculada a uma operacao
3755:     * (EmpDopNums preenchido - so entao o produto fica travado), e o lookup
3756:     * (ValidarProdutoGrid) so roda quando a linha AINDA esta livre.
3757:     *--------------------------------------------------------------------------
3758:     PROCEDURE GridCotacoesProdutoGotFocus()
3759:         IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos")
3760:             THIS.this_cTagProduto = ALLTRIM(cursor_4c_Produtos.CPros)
3761:         ENDIF
3762:     ENDPROC
3763: 
3764:     PROCEDURE GridCotacoesProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3765:         IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos")
3766:             IF !EMPTY(cursor_4c_Produtos.EmpDopNums)
3767:                 SELECT cursor_4c_Produtos
3768:                 REPLACE CPros WITH THIS.this_cTagProduto IN cursor_4c_Produtos
3769:                 THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
3770:             ENDIF
3771:         ENDIF
3772:     ENDPROC
3773: 
3774:     PROCEDURE GridCotacoesProdutoDblClick()
3775:         *-- Legado: Do Form SigOpCgp.Scx (tela de consulta de movimentacoes por
3776:         *-- produto) - form de CONSULTA externo, nao portado nesta fase.
3777:         MsgAviso("Consulta de movimenta" + CHR(231) + CHR(245) + "es por produto (SigOpCgp) " + ;
3778:             "n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
3779:             "Aviso")
3780:     ENDPROC
3781: 
3782:     *--------------------------------------------------------------------------
3783:     * ValidarProdutoGrid - Valid da Column1: so faz sentido buscar/gravar
3784:     * quando a linha AINDA nao esta vinculada a uma operacao (EmpDopNums
3785:     * vazio) - transcrito literal do guard do legado.
3786:     *--------------------------------------------------------------------------
3787:     PROCEDURE ValidarProdutoGrid(par_nKeyCode, par_nShiftAltCtrl)
3788:         LOCAL loc_oGrid, loc_cValor, loc_oBusca
3789: 
3790:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3791:             RETURN
3792:         ENDIF
3793: 
3794:         IF !EMPTY(cursor_4c_Produtos.EmpDopNums)
3795:             RETURN
3796:         ENDIF
3797: 
3798:         loc_oGrid  = THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos
3799:         loc_cValor = ALLTRIM(loc_oGrid.Column1.Text1.Value)
3800: 
3801:         IF EMPTY(loc_cValor)
3802:             RETURN
3803:         ENDIF
3804: 
3805:         *-- Guarda de reentrancia: o Show() modal abaixo, disparado por
3806:         *-- LostFocus, pode reentrar neste mesmo metodo quando o foco sai e
3807:         *-- volta - sem a guarda, um segundo picker fica empilhado por cima.
3808:         IF THIS.this_lAbrindoLookupGrid
3809:             RETURN

*-- Linhas 3820 a 3867:
3820:                 loc_oBusca.mAddColuna("CUnis", "", "Uni")
3821:                 loc_oBusca.Show()
3822:             ENDIF
3823: 
3824:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
3825:                 SELECT cursor_4c_Produtos
3826:                 REPLACE CPros     WITH ALLTRIM(cursor_4c_BuscaProduto.CPros), ;
3827:                         DPros     WITH ALLTRIM(cursor_4c_BuscaProduto.DPros), ;
3828:                         CUnis     WITH ALLTRIM(cursor_4c_BuscaProduto.CUnis), ;
3829:                         cIdChaves WITH LEFT(fUniqueIds(), 20) IN cursor_4c_Produtos
3830:                 loc_oGrid.Refresh()
3831:                 THIS.GridCotacoesAfterRowColChange(1)
3832:             ENDIF
3833: 
3834:             loc_oBusca.Release()
3835:         ENDIF
3836: 
3837:         IF USED("cursor_4c_BuscaProduto")
3838:             USE IN cursor_4c_BuscaProduto
3839:         ENDIF
3840: 
3841:         THIS.this_lAbrindoLookupGrid = .F.
3842:     ENDPROC
3843: 
3844:     *--------------------------------------------------------------------------
3845:     * ValidarUnidadeGrid - Valid da Column4 (CUnis): lookup em SigCdUni e, se
3846:     * o produto ja tem unidade cadastrada em SigCdPro, avisa quando o valor
3847:     * digitado diverge (mesma checagem do legado, sem alterar o Value).
3848:     *--------------------------------------------------------------------------
3849:     PROCEDURE ValidarUnidadeGrid(par_nKeyCode, par_nShiftAltCtrl)
3850:         LOCAL loc_oGrid, loc_cValor, loc_oBusca, loc_cSQL, loc_nResultado
3851: 
3852:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3853:             RETURN
3854:         ENDIF
3855: 
3856:         loc_oGrid  = THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos
3857:         loc_cValor = ALLTRIM(loc_oGrid.Column4.Text1.Value)
3858: 
3859:         IF !EMPTY(loc_cValor)
3860:             *-- Guarda de reentrancia (ver ValidarProdutoGrid) - o Show() modal
3861:             *-- disparado por LostFocus pode reentrar neste mesmo metodo.
3862:             IF THIS.this_lAbrindoLookupGrid
3863:                 RETURN
3864:             ENDIF
3865:             THIS.this_lAbrindoLookupGrid = .T.
3866: 
3867:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;

*-- Linhas 3873 a 3917:
3873:                     loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
3874:                     loc_oBusca.Show()
3875:                 ENDIF
3876: 
3877:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnidade")
3878:                     SELECT cursor_4c_Produtos
3879:                     REPLACE CUnis WITH ALLTRIM(cursor_4c_BuscaUnidade.CUnis) IN cursor_4c_Produtos
3880:                 ELSE
3881:                     SELECT cursor_4c_Produtos
3882:                     REPLACE CUnis WITH "" IN cursor_4c_Produtos
3883:                 ENDIF
3884: 
3885:                 loc_oBusca.Release()
3886:             ENDIF
3887: 
3888:             IF USED("cursor_4c_BuscaUnidade")
3889:                 USE IN cursor_4c_BuscaUnidade
3890:             ENDIF
3891: 
3892:             loc_oGrid.Refresh()
3893: 
3894:             *-- Confere contra a unidade cadastrada no produto (aviso, nao bloqueio)
3895:             IF !EMPTY(cursor_4c_Produtos.CPros)
3896:                 loc_cSQL = "SELECT CUnis FROM SigCdPro WHERE CPros = " + ;
3897:                     EscaparSQL(cursor_4c_Produtos.CPros)
3898:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniPro")
3899: 
3900:                 IF loc_nResultado > 0 AND USED("cursor_4c_UniPro") AND !EOF("cursor_4c_UniPro")
3901:                     IF !EMPTY(cursor_4c_UniPro.CUnis) AND ;
3902:                        ALLTRIM(cursor_4c_UniPro.CUnis) != ALLTRIM(cursor_4c_Produtos.CUnis)
3903:                         MsgAviso("A Unidade de Medida Deste Produto no Cadastro " + CHR(233) + ' "' + ;
3904:                             ALLTRIM(cursor_4c_UniPro.CUnis) + '"!!!', "Aten" + CHR(231) + CHR(227) + "o!!!")
3905:                     ENDIF
3906:                 ENDIF
3907: 
3908:                 IF USED("cursor_4c_UniPro")
3909:                     USE IN cursor_4c_UniPro
3910:                 ENDIF
3911:             ENDIF
3912: 
3913:             THIS.this_lAbrindoLookupGrid = .F.
3914:         ENDIF
3915:     ENDPROC
3916: 
3917:     *--------------------------------------------------------------------------

*-- Linhas 3929 a 4018:
3929:     ENDPROC
3930: 
3931:     PROTECTED PROCEDURE ValidarFornecedorGrid(par_cCampo)
3932:         LOCAL loc_oGrid, loc_cValor, loc_oBusca, loc_cTitulo
3933: 
3934:         IF !USED("cursor_4c_Fornecedores") OR EOF("cursor_4c_Fornecedores")
3935:             RETURN
3936:         ENDIF
3937: 
3938:         loc_oGrid = THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores
3939: 
3940:         IF par_cCampo = "IClis"
3941:             loc_cValor = ALLTRIM(loc_oGrid.Column2.Text1.Value)
3942:         ELSE
3943:             loc_cValor = ALLTRIM(loc_oGrid.Column3.Text1.Value)
3944:         ENDIF
3945: 
3946:         IF EMPTY(loc_cValor)
3947:             SELECT cursor_4c_Fornecedores
3948:             REPLACE IClis WITH "", Fornecs WITH "", Contatos WITH "", Tel1s WITH "", Fretes WITH "" ;
3949:                 IN cursor_4c_Fornecedores
3950:             loc_oGrid.Refresh()
3951:             RETURN
3952:         ENDIF
3953: 
3954:         *-- Guarda de reentrancia (ver ValidarProdutoGrid).
3955:         IF THIS.this_lAbrindoLookupGrid
3956:             RETURN
3957:         ENDIF
3958:         THIS.this_lAbrindoLookupGrid = .T.
3959: 
3960:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
3961:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3962:             "SigCdCli", "cursor_4c_BuscaFornec", par_cCampo, loc_cValor, loc_cTitulo, .F., .T., "")
3963: 
3964:         IF VARTYPE(loc_oBusca) = "O"
3965:             IF !loc_oBusca.this_lAchouRegistro
3966:                 loc_oBusca.mAddColuna("IClis",   "", "C" + CHR(243) + "digo")
3967:                 loc_oBusca.mAddColuna("RClis",   "", "Nome")
3968:                 loc_oBusca.mAddColuna("Contato", "", "Contato")
3969:                 loc_oBusca.mAddColuna("Tel1s",   "", "Telefone")
3970:                 loc_oBusca.Show()
3971:             ENDIF
3972: 
3973:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFornec")
3974:                 SELECT cursor_4c_Fornecedores
3975:                 REPLACE IClis    WITH ALLTRIM(cursor_4c_BuscaFornec.IClis), ;
3976:                         Fornecs  WITH ALLTRIM(cursor_4c_BuscaFornec.RClis), ;
3977:                         Contatos WITH ALLTRIM(NVL(cursor_4c_BuscaFornec.Contato, "")), ;
3978:                         Tel1s    WITH ALLTRIM(NVL(cursor_4c_BuscaFornec.Tel1s, "")), ;
3979:                         Fretes   WITH "Emitente" IN cursor_4c_Fornecedores
3980:             ELSE
3981:                 SELECT cursor_4c_Fornecedores
3982:                 REPLACE IClis WITH "", Fornecs WITH "", Contatos WITH "", Tel1s WITH "", Fretes WITH "" ;
3983:                     IN cursor_4c_Fornecedores
3984:             ENDIF
3985: 
3986:             loc_oBusca.Release()
3987:         ENDIF
3988: 
3989:         IF USED("cursor_4c_BuscaFornec")
3990:             USE IN cursor_4c_BuscaFornec
3991:         ENDIF
3992: 
3993:         loc_oGrid.Refresh()
3994:         THIS.this_lAbrindoLookupGrid = .F.
3995:     ENDPROC
3996: 
3997:     *--------------------------------------------------------------------------
3998:     * ValidarCondicaoPagtoGrid - Column6 (FPags) do grd_4c_Fornecedores.
3999:     *--------------------------------------------------------------------------
4000:     PROCEDURE ValidarCondicaoPagtoGrid(par_nKeyCode, par_nShiftAltCtrl)
4001:         LOCAL loc_oGrid, loc_cValor, loc_oBusca
4002: 
4003:         IF !USED("cursor_4c_Fornecedores") OR EOF("cursor_4c_Fornecedores")
4004:             RETURN
4005:         ENDIF
4006: 
4007:         loc_oGrid  = THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores
4008:         loc_cValor = ALLTRIM(loc_oGrid.Column6.Text1.Value)
4009: 
4010:         IF EMPTY(loc_cValor)
4011:             RETURN
4012:         ENDIF
4013: 
4014:         *-- Guarda de reentrancia (ver ValidarProdutoGrid).
4015:         IF THIS.this_lAbrindoLookupGrid
4016:             RETURN
4017:         ENDIF
4018:         THIS.this_lAbrindoLookupGrid = .T.

*-- Linhas 4026 a 4050:
4026:                 loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
4027:                 loc_oBusca.Show()
4028:             ENDIF
4029: 
4030:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFPag")
4031:                 SELECT cursor_4c_Fornecedores
4032:                 REPLACE FPags WITH ALLTRIM(cursor_4c_BuscaFPag.FPags) IN cursor_4c_Fornecedores
4033:             ELSE
4034:                 SELECT cursor_4c_Fornecedores
4035:                 REPLACE FPags WITH "" IN cursor_4c_Fornecedores
4036:             ENDIF
4037: 
4038:             loc_oBusca.Release()
4039:         ENDIF
4040: 
4041:         IF USED("cursor_4c_BuscaFPag")
4042:             USE IN cursor_4c_BuscaFPag
4043:         ENDIF
4044: 
4045:         THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores.Refresh()
4046:         THIS.this_lAbrindoLookupGrid = .F.
4047:     ENDPROC
4048: 
4049:     *--------------------------------------------------------------------------
4050:     * Solicitante / Departamento / Comprador (cabecalho de Page3) -

*-- Linhas 4353 a 4361:
4353: 
4354:     *--------------------------------------------------------------------------
4355:     * pgAprovacao - Aprovador Final (Usuario ativo, fwBuscaExt), Data e
4356:     * Observacao (sem lookup, so gravam no BO) e o CheckBox de aprovacao.
4357:     *--------------------------------------------------------------------------
4358:     PROCEDURE TeclaAprovadorFinal(par_nKeyCode, par_nShiftAltCtrl)
4359:         IF par_nKeyCode = 115
4360:             THIS.AbrirBuscaAprovadorFinal()
4361:         ENDIF

*-- Linhas 4485 a 4620:
4485: 
4486:     PROCEDURE BtnHistoricoProdutoClick()
4487:         *-- Legado: Do Form SigMvCth (historico de compras do produto). Form
4488:         *-- nao portado para o sistema novo (ver docs/GUIA_RAPIDO_MIGRACAO.md /
4489:         *-- ProximasMigracoes\SigMvCth.SCX, ainda nao migrado).
4490:         IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos") AND !EMPTY(cursor_4c_Produtos.CPros)
4491:             MsgAviso("Hist" + CHR(243) + "rico de compras do produto (SigMvCth) n" + CHR(227) + "o " + ;
4492:                 "dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", "Aviso")
4493:         ENDIF
4494:     ENDPROC
4495: 
4496:     *--------------------------------------------------------------------------
4497:     * ExcluiProduto - cmdEscolha.btnExcluirItem / Valid de cmdProdutos.
4498:     * btnExcluir: remove a linha corrente de cursor_4c_Produtos, renumera
4499:     * CItens e, se a operacao de origem (EmpDopNums) nao ficar mais referenciada
4500:     * por NENHUM outro item, desmarca SigMvCab.Utilizados para liberar a
4501:     * movimentacao. Nunca deixa a grade com menos de 1 linha (regra do legado:
4502:     * "So Ha Um Produto - Nao E Possivel Excluir").
4503:     *--------------------------------------------------------------------------
4504:     PROCEDURE ExcluiProduto()
4505:         LOCAL loc_cEdn, loc_cIdAtual, loc_nRec, loc_nCod, loc_nItn, loc_cSQL, loc_nResultado
4506: 
4507:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
4508:             MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Nenhum Produto Selecionado na Grade!!!", ;
4509:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
4510:             RETURN .F.
4511:         ENDIF
4512: 
4513:         IF RECCOUNT("cursor_4c_Produtos") = 1
4514:             MsgAviso("S" + CHR(243) + " H" + CHR(225) + " Um Produto na Grade!!! N" + CHR(227) + ;
4515:                 "o " + CHR(233) + " Poss" + CHR(237) + "vel Efetuar a Exclus" + CHR(227) + "o!!!", ;
4516:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
4517:             RETURN .F.
4518:         ENDIF
4519: 
4520:         loc_cEdn = cursor_4c_Produtos.EmpDopNums
4521:         loc_cIdAtual = cursor_4c_Produtos.cIdChaves
4522:         loc_nRec = RECNO("cursor_4c_Produtos")
4523: 
4524:         IF !EMPTY(loc_cEdn) AND VARTYPE(THIS.this_oBusinessObject) = "O"
4525:             loc_nCod = THIS.this_oBusinessObject.this_nCodigos
4526: 
4527:             *-- So desmarca o SigMvCab se NENHUMA outra linha (desta ou de
4528:             *-- OUTRAS cotacoes ja gravadas) ainda usar a mesma operacao
4529:             SELECT COUNT(*) AS Total FROM cursor_4c_Produtos ;
4530:                 WHERE EmpDopNums = loc_cEdn AND cIdChaves != loc_cIdAtual ;
4531:                 INTO CURSOR cursor_4c_ChecagemLocal
4532: 
4533:             IF cursor_4c_ChecagemLocal.Total = 0
4534:                 loc_cSQL = "SELECT EmpDopNums FROM SigCtTCt WHERE EmpDopNums = " + ;
4535:                     EscaparSQL(loc_cEdn) + " AND Codigos != " + FormatarNumeroSQL(loc_nCod, 0)
4536: 
4537:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChecagemSQL")
4538: 
4539:                 IF loc_nResultado >= 0 AND USED("cursor_4c_ChecagemSQL") AND EOF("cursor_4c_ChecagemSQL")
4540:                     SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Utilizados = 0 WHERE EmpDopNums = " + ;
4541:                         EscaparSQL(loc_cEdn))
4542:                 ENDIF
4543: 
4544:                 IF USED("cursor_4c_ChecagemSQL")
4545:                     USE IN cursor_4c_ChecagemSQL
4546:                 ENDIF
4547:             ENDIF
4548: 
4549:             IF USED("cursor_4c_ChecagemLocal")
4550:                 USE IN cursor_4c_ChecagemLocal
4551:             ENDIF
4552:         ENDIF
4553: 
4554:         SELECT cursor_4c_Produtos
4555:         DELETE IN cursor_4c_Produtos
4556: 
4557:         loc_nItn = 1
4558:         SCAN
4559:             REPLACE CItens WITH loc_nItn IN cursor_4c_Produtos
4560:             loc_nItn = loc_nItn + 1
4561:         ENDSCAN
4562: 
4563:         GO TOP IN cursor_4c_Produtos
4564:         IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Produtos")
4565:             GO loc_nRec IN cursor_4c_Produtos
4566:         ENDIF
4567: 
4568:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
4569:         THIS.GridCotacoesAfterRowColChange(1)
4570: 
4571:         RETURN .T.
4572:     ENDPROC
4573: 
4574:     *--------------------------------------------------------------------------
4575:     * AdicionarLinhaProduto - cmdProdutos.btnInserir/btnExcluir.Valid: os dois
4576:     * botoes do legado fazem EXATAMENTE a mesma coisa (renumerar CItens,
4577:     * remover linhas com CPros vazio e inserir uma linha em branco no final).
4578:     *--------------------------------------------------------------------------
4579:     PROCEDURE AdicionarLinhaProduto()
4580:         LOCAL loc_nItn, loc_nCod
4581: 
4582:         IF !USED("cursor_4c_Produtos")
4583:             RETURN
4584:         ENDIF
4585: 
4586:         loc_nCod = 0
4587:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
4588:             loc_nCod = THIS.this_oBusinessObject.this_nCodigos
4589:         ENDIF
4590: 
4591:         loc_nItn = 1
4592:         SELECT cursor_4c_Produtos
4593:         SCAN
4594:             REPLACE CItens WITH loc_nItn IN cursor_4c_Produtos
4595:             IF EMPTY(cursor_4c_Produtos.CPros)
4596:                 DELETE IN cursor_4c_Produtos
4597:             ELSE
4598:                 loc_nItn = loc_nItn + 1
4599:             ENDIF
4600:         ENDSCAN
4601: 
4602:         INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
4603:             VALUES (LEFT(fUniqueIds(), 20), loc_nCod, loc_nItn, "", "", "", 0, "", 0)
4604: 
4605:         GO BOTTOM IN cursor_4c_Produtos
4606:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
4607:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Column1.SetFocus()
4608:         THIS.GridCotacoesAfterRowColChange(1)
4609:     ENDPROC
4610: 
4611:     *--------------------------------------------------------------------------
4612:     * BtnSairCotacoesClick - cmdBotoes.btnSair.Click de Page3: confirma
4613:     * abandono em modo de edicao, desfaz a edicao em curso do BO e volta para
4614:     * a pagina de Dados (Page2).
4615:     *--------------------------------------------------------------------------
4616:     PROCEDURE BtnSairCotacoesClick()
4617:         LOCAL loc_lConfirma
4618: 
4619:         loc_lConfirma = .T.
4620: 

*-- Linhas 4671 a 4717:
4671:         ENDIF
4672: 
4673:         loc_lOk = .T.
4674: 
4675:         *-- ValAdqs = Total do fornecedor marcado (ou 0 se nenhum) - transcrito
4676:         IF USED("cursor_4c_Produtos")
4677:             loc_nRec = RECNO("cursor_4c_Produtos")
4678:             SELECT cursor_4c_Produtos
4679:             SCAN
4680:                 loc_cNum = ""
4681:                 FOR loc_nI = 1 TO 6
4682:                     IF EVALUATE("Marca" + PADL(loc_nI, 2, "0"))
4683:                         loc_cNum = PADL(loc_nI, 2, "0")
4684:                     ENDIF
4685:                 ENDFOR
4686:                 IF EMPTY(loc_cNum)
4687:                     REPLACE ValAdqs WITH 0 IN cursor_4c_Produtos
4688:                 ELSE
4689:                     REPLACE ValAdqs WITH EVALUATE("Tota" + loc_cNum) IN cursor_4c_Produtos
4690:                 ENDIF
4691:             ENDSCAN
4692:             IF BETWEEN(loc_nRec, 1, RECCOUNT("cursor_4c_Produtos"))
4693:                 GO loc_nRec IN cursor_4c_Produtos
4694:             ENDIF
4695:         ENDIF
4696: 
4697:         IF THIS.this_cPcEscolha = "EXCLUIR"
4698:             loc_nCod = THIS.this_oBusinessObject.this_nCodigos
4699: 
4700:             *-- Libera as operacoes (SigMvCab) que so eram usadas por esta cotacao
4701:             IF USED("cursor_4c_Produtos")
4702:                 SELECT DISTINCT EmpDopNums FROM cursor_4c_Produtos ;
4703:                     WHERE !EMPTY(EmpDopNums) INTO CURSOR cursor_4c_ApagarEdn
4704: 
4705:                 SELECT cursor_4c_ApagarEdn
4706:                 SCAN
4707:                     loc_cSQL = "SELECT EmpDopNums FROM SigCtTCt WHERE EmpDopNums = " + ;
4708:                         EscaparSQL(cursor_4c_ApagarEdn.EmpDopNums) + " AND Codigos != " + ;
4709:                         FormatarNumeroSQL(loc_nCod, 0)
4710: 
4711:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ApagarChk") >= 0
4712:                         IF USED("cursor_4c_ApagarChk") AND EOF("cursor_4c_ApagarChk")
4713:                             SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Utilizados = 0 WHERE EmpDopNums = " + ;
4714:                                 EscaparSQL(cursor_4c_ApagarEdn.EmpDopNums))
4715:                         ENDIF
4716:                     ENDIF
4717:                     IF USED("cursor_4c_ApagarChk")

*-- Linhas 4763 a 4809:
4763:         IF SQLEXEC(gnConnHandle, "DELETE FROM SigCtTCt WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)) < 0
4764:             MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - SigCtTCt)" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4765:             RETURN .F.
4766:         ENDIF
4767: 
4768:         IF USED("cursor_4c_Fornecedores")
4769:             SELECT cursor_4c_Fornecedores
4770:             SCAN
4771:                 loc_cSQL = "INSERT INTO SigCtTFn (cidchaves, codigos, grades, iclis, fornecs, contatos, " + ;
4772:                     "tel1s, fpags, dtents, fretes, vlfretes) VALUES (" + ;
4773:                     EscaparSQL(IIF(EMPTY(cIdChaves), LEFT(fUniqueIds(), 20), cIdChaves)) + ", " + ;
4774:                     FormatarNumeroSQL(loc_nCod, 0) + ", " + ;
4775:                     EscaparSQL(Grades) + ", " + ;
4776:                     EscaparSQL(LEFT(ALLTRIM(IClis), 10)) + ", " + ;
4777:                     EscaparSQL(LEFT(ALLTRIM(Fornecs), 40)) + ", " + ;
4778:                     EscaparSQL(LEFT(ALLTRIM(Contatos), 20)) + ", " + ;
4779:                     EscaparSQL(LEFT(ALLTRIM(Tel1s), 20)) + ", " + ;
4780:                     EscaparSQL(LEFT(ALLTRIM(FPags), 12)) + ", " + ;
4781:                     FormatarDataSQL(DtEnts) + ", " + ;
4782:                     EscaparSQL(LEFT(IIF(EMPTY(Fretes), "Emitente", ALLTRIM(Fretes)), 12)) + ", " + ;
4783:                     FormatarNumeroSQL(VlFretes, 2) + ")"
4784: 
4785:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
4786:                     MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - INSERT SigCtTFn)" + CHR(13) + ;
4787:                         CapturarErroSQL(), "Erro SQL")
4788:                     RETURN .F.
4789:                 ENDIF
4790:             ENDSCAN
4791:         ENDIF
4792: 
4793:         IF USED("cursor_4c_Produtos")
4794:             SELECT cursor_4c_Produtos
4795:             SCAN FOR !EMPTY(CPros)
4796:                 loc_cSQL = "INSERT INTO SigCtTCt (cidchaves, codigos, citens, cpros, dpros, cunis, " + ;
4797:                     "codcors, codtams, empdopnums, obs, justificas, qtds, qtdadqs, valadqs, " + ;
4798:                     "marca01, marca02, marca03, marca04, marca05, marca06, " + ;
4799:                     "unit01, unit02, unit03, unit04, unit05, unit06, " + ;
4800:                     "tota01, tota02, tota03, tota04, tota05, tota06) VALUES (" + ;
4801:                     EscaparSQL(IIF(EMPTY(cIdChaves), LEFT(fUniqueIds(), 20), cIdChaves)) + ", " + ;
4802:                     FormatarNumeroSQL(loc_nCod, 0) + ", " + ;
4803:                     FormatarNumeroSQL(CItens, 0) + ", " + ;
4804:                     EscaparSQL(LEFT(ALLTRIM(CPros), 14)) + ", " + ;
4805:                     EscaparSQL(LEFT(ALLTRIM(DPros), 65)) + ", " + ;
4806:                     EscaparSQL(LEFT(ALLTRIM(CUnis), 3)) + ", " + ;
4807:                     EscaparSQL(LEFT(ALLTRIM(NVL(CodCors, "")), 4)) + ", " + ;
4808:                     EscaparSQL(LEFT(ALLTRIM(NVL(CodTams, "")), 4)) + ", " + ;
4809:                     EscaparSQL(LEFT(NVL(EmpDopNums, ""), 29)) + ", " + ;

*-- Linhas 4823 a 4843:
4823:                     MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - INSERT SigCtTCt)" + CHR(13) + ;
4824:                         CapturarErroSQL(), "Erro SQL")
4825:                     RETURN .F.
4826:                 ENDIF
4827: 
4828:                 SELECT cursor_4c_Produtos
4829:             ENDSCAN
4830:         ENDIF
4831: 
4832:         RETURN .T.
4833:     ENDPROC
4834: 
4835:     *--------------------------------------------------------------------------
4836:     * AprovarCotacao - Equivalente ao PROCEDURE aprovarcotacao legado.
4837:     * Transcrito literal: cada guarda de validacao, ao falhar, zera ChkAprovs,
4838:     * regrava (GravaDados) e devolve o foco ao campo correspondente.
4839:     *--------------------------------------------------------------------------
4840:     PROCEDURE AprovarCotacao()
4841:         LOCAL loc_oApr, loc_oBO, loc_cSQL, loc_nResultado, loc_nVlLib, loc_nTotalCotacao
4842: 
4843:         loc_oApr = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page2

*-- Linhas 4978 a 4999:
4978:             loc_oApr.txt_4c_Aprovador.SetFocus()
4979:             RETURN .F.
4980:         ENDIF
4981: 
4982:         loc_nTotalCotacao = 0
4983:         IF USED("cursor_4c_CabOperas")
4984:             SELECT SUM(Valors) AS Total FROM cursor_4c_CabOperas INTO CURSOR cursor_4c_SomaCab
4985:             IF USED("cursor_4c_SomaCab") AND !EOF("cursor_4c_SomaCab")
4986:                 loc_nTotalCotacao = NVL(cursor_4c_SomaCab.Total, 0)
4987:             ENDIF
4988:             IF USED("cursor_4c_SomaCab")
4989:                 USE IN cursor_4c_SomaCab
4990:             ENDIF
4991:         ENDIF
4992: 
4993:         IF loc_nTotalCotacao <= 0 OR loc_nTotalCotacao > loc_nVlLib
4994:             MsgAviso("O Cargo do Aprovador N" + CHR(227) + "o Permite a Aprova" + CHR(231) + CHR(227) + ;
4995:                 "o Do Valor Desta Cota" + CHR(231) + CHR(227) + "o!!!" + CHR(13) + CHR(13) + ;
4996:                 "Valor da Cota" + CHR(231) + CHR(227) + "o : " + ALLTRIM(STR(loc_nTotalCotacao, 12, 2)) + ;
4997:                 "  -  Limite Para Aprova" + CHR(231) + CHR(227) + "o : " + ALLTRIM(STR(loc_nVlLib, 12, 2)), ;
4998:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
4999:             loc_oBO.this_nChkAprovs = 0

*-- Linhas 5012 a 5066:
5012:     ENDPROC
5013: 
5014:     *--------------------------------------------------------------------------
5015:     * CriarCursoresPedidos - Cursores locais da pagina de Pedidos (Page4):
5016:     *
5017:     *   cursor_4c_Pedidos    -> crPedidos    (staging por produto/fornecedor)
5018:     *   cursor_4c_CabOperas  -> crCabOperas  (grdCabOperas, 1 linha por Numes)
5019:     *   cursor_4c_ItnOperas  -> crItnOperas  (grdItnOperas, itens de cada Numes)
5020:     *   cursor_4c_Subniveis  -> crSubniveis  (operacoes de subnivel do Dopes)
5021:     *--------------------------------------------------------------------------
5022:     PROTECTED PROCEDURE CriarCursoresPedidos()
5023:         IF USED("cursor_4c_Pedidos")
5024:             USE IN cursor_4c_Pedidos
5025:         ENDIF
5026:         CREATE CURSOR cursor_4c_Pedidos ( ;
5027:             IFors C(10), Fornecs C(40), FPags C(12), DtEnts D(8), CPros C(14), DPros C(65), ;
5028:             CUnis C(3), Obs M(4), Qtds N(15,2), Valors N(15,2), Fretes C(12), VlFretes N(11,2), ;
5029:             CodCors C(4), CodTams C(4))
5030: 
5031:         IF USED("cursor_4c_CabOperas")
5032:             USE IN cursor_4c_CabOperas
5033:         ENDIF
5034:         CREATE CURSOR cursor_4c_CabOperas ( ;
5035:             Numes N(6), IFors C(10), Fornecs C(40), FPags C(12), DtEnts D(8), ;
5036:             Qtds N(15,2), Valors N(15,2), Fretes C(12), VlFretes N(11,2), Jobs C(10))
5037:         INDEX ON IFors TAG IFors
5038:         INDEX ON Numes TAG Ordem
5039: 
5040:         IF USED("cursor_4c_ItnOperas")
5041:             USE IN cursor_4c_ItnOperas
5042:         ENDIF
5043:         CREATE CURSOR cursor_4c_ItnOperas ( ;
5044:             Numes N(6), CItens N(6), CPros C(14), DPros C(65), CodCors C(4), CodTams C(4), ;
5045:             CUnis C(3), Obs M(4), Qtds N(15,2), Units N(15,6), Valors N(15,2))
5046:         INDEX ON STR(Numes, 6) + STR(CItens, 6) TAG Ordem
5047: 
5048:         IF USED("cursor_4c_Subniveis")
5049:             USE IN cursor_4c_Subniveis
5050:         ENDIF
5051:         CREATE CURSOR cursor_4c_Subniveis ( ;
5052:             Dopes C(20), GruOrigs C(10), GruDests C(10), ConDests C(10), Opers N(1), ;
5053:             CMoes C(3), NFiscals N(1), Series C(3), Especies C(2), TipoNfs N(1), ;
5054:             MarcaSubns C(1), Cfos C(10), Casas N(1), GrVends C(10), ChkLimOps N(1))
5055:         INDEX ON Dopes TAG Dopes
5056:     ENDPROC
5057: 
5058:     *--------------------------------------------------------------------------
5059:     * GeraPedidos - Equivalente ao PROCEDURE gerapedidos legado: valida os
5060:     * dados de cada fornecedor marcado na grade de Produtos, monta os cursores
5061:     * de cabecalho/itens da pagina de Pedidos e navega para Page4 (a menos que
5062:     * par_lChk seja .T., usado por AprovarCotacao so para CALCULAR o total).
5063:     *
5064:     * NAO inclui a gravacao fisica (SigMvCab/SigMvItn/financeiro) - essa parte
5065:     * (GravaPedidos do legado) esta em THIS.GravaPedidos(), acionada pelo
5066:     * botao "Processar Pedidos" (BtnProcessarPedidosClick).

*-- Linhas 5080 a 5330:
5080:                 "Data de Pagamento N" + CHR(227) + "o Informada")
5081:             THIS.pgf_4c_Paginas.Page3.txt_4c_DtPagtos.SetFocus()
5082:             RETURN .F.
5083:         ENDIF
5084: 
5085:         IF !USED("cursor_4c_Pedidos")
5086:             THIS.CriarCursoresPedidos()
5087:         ENDIF
5088: 
5089:         ZAP IN cursor_4c_Pedidos
5090:         ZAP IN cursor_4c_CabOperas
5091:         ZAP IN cursor_4c_ItnOperas
5092: 
5093:         IF USED("cursor_4c_Produtos")
5094:             SELECT cursor_4c_Produtos
5095:             SCAN
5096:                 loc_cLetra = ""
5097:                 DO CASE
5098:                     CASE cursor_4c_Produtos.Marca01
5099:                         loc_cLetra = "A"
5100:                     CASE cursor_4c_Produtos.Marca02
5101:                         loc_cLetra = "B"
5102:                     CASE cursor_4c_Produtos.Marca03
5103:                         loc_cLetra = "C"
5104:                     CASE cursor_4c_Produtos.Marca04
5105:                         loc_cLetra = "D"
5106:                     CASE cursor_4c_Produtos.Marca05
5107:                         loc_cLetra = "E"
5108:                     CASE cursor_4c_Produtos.Marca06
5109:                         loc_cLetra = "F"
5110:                     OTHERWISE
5111:                         REPLACE ValAdqs WITH 0 IN cursor_4c_Produtos
5112:                 ENDCASE
5113: 
5114:                 IF !EMPTY(loc_cLetra)
5115:                     loc_lAchouFn = SEEK(loc_cLetra, "cursor_4c_Fornecedores", "Ordem")
5116: 
5117:                     IF !loc_lAchouFn
5118:                         MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + "-" + ;
5119:                             ALLTRIM(cursor_4c_Produtos.DPros) + CHR(13) + ;
5120:                             "N" + CHR(227) + "o Tem o Fornecedor Informado!!! Corrija os Dados e Tente " + ;
5121:                             "Novamente!!!", "Fornecedor N" + CHR(227) + "o Informado")
5122:                         RETURN .F.
5123:                     ENDIF
5124: 
5125:                     IF EMPTY(cursor_4c_Fornecedores.FPags)
5126:                         MsgAviso("O Fornecedor " + loc_cLetra + " - " + ALLTRIM(cursor_4c_Fornecedores.IClis) + ;
5127:                             "-" + ALLTRIM(cursor_4c_Fornecedores.Fornecs) + CHR(13) + ;
5128:                             "N" + CHR(227) + "o Tem a Condi" + CHR(231) + CHR(227) + "o de Pagamento " + ;
5129:                             "Informada!!! Corrija os Dados e Tente Novamente!!!", ;
5130:                             "Condi" + CHR(231) + CHR(227) + "o de Pagamento N" + CHR(227) + "o Informada")
5131:                         RETURN .F.
5132:                     ENDIF
5133: 
5134:                     IF EMPTY(cursor_4c_Fornecedores.DtEnts)
5135:                         MsgAviso("O Fornecedor " + loc_cLetra + " - " + ALLTRIM(cursor_4c_Fornecedores.IClis) + ;
5136:                             "-" + ALLTRIM(cursor_4c_Fornecedores.Fornecs) + CHR(13) + ;
5137:                             "N" + CHR(227) + "o Tem a Data de Entrega Informada!!! Corrija os Dados e " + ;
5138:                             "Tente Novamente!!!", "Data de Entrega N" + CHR(227) + "o Informada")
5139:                         RETURN .F.
5140:                     ENDIF
5141: 
5142:                     IF EMPTY(cursor_4c_Fornecedores.Fretes)
5143:                         MsgAviso("O Fornecedor " + loc_cLetra + " - " + ALLTRIM(cursor_4c_Fornecedores.IClis) + ;
5144:                             "-" + ALLTRIM(cursor_4c_Fornecedores.Fornecs) + CHR(13) + ;
5145:                             "N" + CHR(227) + "o Tem o Frete (Emitente/Destinat" + CHR(225) + "rio) Informado!!! " + ;
5146:                             "Corrija os Dados e Tente Novamente!!!", "Frete N" + CHR(227) + "o Informado")
5147:                         RETURN .F.
5148:                     ENDIF
5149: 
5150:                     IF ALLTRIM(cursor_4c_Fornecedores.Fretes) == "Destinatario" AND EMPTY(cursor_4c_Fornecedores.VlFretes)
5151:                         MsgAviso("O Fornecedor " + loc_cLetra + " - " + ALLTRIM(cursor_4c_Fornecedores.IClis) + ;
5152:                             "-" + ALLTRIM(cursor_4c_Fornecedores.Fornecs) + CHR(13) + ;
5153:                             "N" + CHR(227) + "o Tem o Valor do Frete Informado!!! Corrija os Dados e Tente " + ;
5154:                             "Novamente!!!", "Valor do Frete N" + CHR(227) + "o Informado")
5155:                         RETURN .F.
5156:                     ENDIF
5157: 
5158:                     IF EMPTY(cursor_4c_Produtos.QtdAdqs)
5159:                         MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + " N" + CHR(227) + "o Tem a " + ;
5160:                             "Quantidade Adquirida Informada!!!" + CHR(13) + "Corrija os Dados e Tente " + ;
5161:                             "Novamente!!!", "Quantidade Adquirida N" + CHR(227) + "o Informada")
5162:                         RETURN .F.
5163:                     ENDIF
5164: 
5165:                     IF EMPTY(cursor_4c_Produtos.ValAdqs)
5166:                         MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + " N" + CHR(227) + "o Tem o " + ;
5167:                             "Valor Adquirido Informado!!!" + CHR(13) + "Corrija os Dados e Tente Novamente!!!", ;
5168:                             "Valor Adquirido N" + CHR(227) + "o Informado")
5169:                         RETURN .F.
5170:                     ENDIF
5171: 
5172:                     IF EMPTY(cursor_4c_Fornecedores.IClis)
5173:                         MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + "-" + ;
5174:                             ALLTRIM(cursor_4c_Produtos.DPros) + CHR(13) + "Foi Solicitado ao Fornecedor " + ;
5175:                             loc_cLetra + " Que Est" + CHR(225) + " Sem o C" + CHR(243) + "digo Informado!!!" + ;
5176:                             CHR(13) + "Para Gerar Pedidos " + CHR(233) + " Necess" + CHR(225) + "rio Realizar " + ;
5177:                             "o Cadastro Deste Fornecedor!!!", "Fornecedor N" + CHR(227) + "o Informado")
5178:                         RETURN .F.
5179:                     ENDIF
5180: 
5181:                     loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
5182:                         EscaparSQL(cursor_4c_Fornecedores.IClis)
5183:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ForneCliChk")
5184: 
5185:                     IF loc_nResultado < 0 OR !USED("cursor_4c_ForneCliChk") OR EOF("cursor_4c_ForneCliChk")
5186:                         MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + "-" + ;
5187:                             ALLTRIM(cursor_4c_Produtos.DPros) + CHR(13) + "Foi Solicitado ao Fornecedor " + ;
5188:                             loc_cLetra + " Que Est" + CHR(225) + " Sem o C" + CHR(243) + "digo Informado!!!" + ;
5189:                             CHR(13) + "Para Gerar Pedidos " + CHR(233) + " Necess" + CHR(225) + "rio Realizar " + ;
5190:                             "o Cadastro Deste Fornecedor!!!", "Fornecedor N" + CHR(227) + "o Informado")
5191:                         IF USED("cursor_4c_ForneCliChk")
5192:                             USE IN cursor_4c_ForneCliChk
5193:                         ENDIF
5194:                         RETURN .F.
5195:                     ENDIF
5196:                     IF USED("cursor_4c_ForneCliChk")
5197:                         USE IN cursor_4c_ForneCliChk
5198:                     ENDIF
5199: 
5200:                     INSERT INTO cursor_4c_Pedidos (IFors, Fornecs, FPags, DtEnts, CPros, DPros, CUnis, Obs, ;
5201:                             Qtds, Valors, Fretes, VlFretes, CodCors, CodTams) ;
5202:                         VALUES (ALLTRIM(cursor_4c_Fornecedores.IClis), ALLTRIM(cursor_4c_Fornecedores.Fornecs), ;
5203:                             ALLTRIM(cursor_4c_Fornecedores.FPags), NVL(cursor_4c_Fornecedores.DtEnts, {}), ;
5204:                             ALLTRIM(cursor_4c_Produtos.CPros), ALLTRIM(cursor_4c_Produtos.DPros), ;
5205:                             ALLTRIM(cursor_4c_Produtos.CUnis), NVL(cursor_4c_Produtos.Obs, ""), ;
5206:                             cursor_4c_Produtos.QtdAdqs, cursor_4c_Produtos.ValAdqs, ;
5207:                             ALLTRIM(cursor_4c_Fornecedores.Fretes), cursor_4c_Fornecedores.VlFretes, ;
5208:                             NVL(cursor_4c_Produtos.CodCors, ""), NVL(cursor_4c_Produtos.CodTams, ""))
5209:                 ENDIF
5210:             ENDSCAN
5211:         ENDIF
5212: 
5213:         IF !USED("cursor_4c_Pedidos") OR EOF("cursor_4c_Pedidos")
5214:             MsgAviso("Nenhum Produto Foi Selecionado Para Gerar Cota" + CHR(231) + CHR(245) + "es!!!", ;
5215:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
5216:             RETURN .F.
5217:         ENDIF
5218: 
5219:         *-- Agrupa por fornecedor (crCabOperas: 1 linha por IFors)
5220:         loc_nNum = 0
5221:         SELECT cursor_4c_Pedidos
5222:         SCAN
5223:             IF !SEEK(cursor_4c_Pedidos.IFors, "cursor_4c_CabOperas", "IFors")
5224:                 loc_nNum = loc_nNum + 1
5225:                 INSERT INTO cursor_4c_CabOperas (Numes, IFors, Fornecs, FPags, DtEnts, Fretes, VlFretes, Jobs) ;
5226:                     VALUES (loc_nNum, cursor_4c_Pedidos.IFors, cursor_4c_Pedidos.Fornecs, cursor_4c_Pedidos.FPags, ;
5227:                         cursor_4c_Pedidos.DtEnts, cursor_4c_Pedidos.Fretes, cursor_4c_Pedidos.VlFretes, ;
5228:                         THIS.this_cJobs)
5229:             ENDIF
5230: 
5231:             loc_nNumAtual = cursor_4c_CabOperas.Numes
5232:             SELECT cursor_4c_CabOperas
5233:             REPLACE Qtds WITH Qtds + cursor_4c_Pedidos.Qtds, ;
5234:                     Valors WITH Valors + cursor_4c_Pedidos.Valors IN cursor_4c_CabOperas
5235: 
5236:             INSERT INTO cursor_4c_ItnOperas (Numes, CPros, DPros, CodCors, CodTams, CUnis, Obs, Qtds, Units, Valors) ;
5237:                 VALUES (loc_nNumAtual, cursor_4c_Pedidos.CPros, cursor_4c_Pedidos.DPros, cursor_4c_Pedidos.CodCors, ;
5238:                     cursor_4c_Pedidos.CodTams, cursor_4c_Pedidos.CUnis, cursor_4c_Pedidos.Obs, ;
5239:                     cursor_4c_Pedidos.Qtds, IIF(cursor_4c_Pedidos.Qtds = 0, 0, cursor_4c_Pedidos.Valors / cursor_4c_Pedidos.Qtds), ;
5240:                     cursor_4c_Pedidos.Valors)
5241: 
5242:             SELECT cursor_4c_Pedidos
5243:         ENDSCAN
5244: 
5245:         *-- Renumera CItens dentro de cada Numes
5246:         loc_nNumAtual = -1
5247:         loc_nItn = 0
5248:         SELECT cursor_4c_ItnOperas
5249:         SCAN
5250:             IF loc_nNumAtual != cursor_4c_ItnOperas.Numes
5251:                 loc_nItn     = 0
5252:                 loc_nNumAtual = cursor_4c_ItnOperas.Numes
5253:             ENDIF
5254:             loc_nItn = loc_nItn + 1
5255:             REPLACE CItens WITH loc_nItn IN cursor_4c_ItnOperas
5256:         ENDSCAN
5257: 
5258:         *-- Operacoes de subnivel do Dopes filtrado em Page1
5259:         loc_cSQL = ;
5260:             "SELECT a.Dopes, a.GruOrigs, a.GruDests, a.ConDests, a.Opers, a.CMoes, a.NFiscals, " + ;
5261:             "a.Series, a.Especies, a.TipoNfs, a.MarcaSubns, a.Cfos, a.Casas, a.GrVends, b.ChkLimOps " + ;
5262:             "FROM SigCdOpe a INNER JOIN SigOpCdd b ON a.Dopes = b.Dopes " + ;
5263:             "WHERE a.Nivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + " " + ;
5264:             "UNION ALL " + ;
5265:             "SELECT b.CDopes AS Dopes, c.GruOrigs, c.GruDests, c.ConDests, c.Opers, c.CMoes, c.NFiscals, " + ;
5266:             "c.Series, c.Especies, c.TipoNfs, c.MarcaSubns, c.Cfos, c.Casas, c.GrVends, d.ChkLimOps " + ;
5267:             "FROM SigOpCsn b INNER JOIN SigCdOpe c ON b.CDopes = c.Dopes " + ;
5268:             "INNER JOIN SigOpCdd d ON b.CDopes = d.Dopes " + ;
5269:             "WHERE b.CNivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20))
5270: 
5271:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubTemp")
5272: 
5273:         IF loc_nResultado < 0
5274:             MsgErro("Falha na Conex" + CHR(227) + "o (GeraPedidos - Subn" + CHR(237) + "veis)" + CHR(13) + ;
5275:                 CapturarErroSQL(), "Erro SQL")
5276:             RETURN .F.
5277:         ENDIF
5278: 
5279:         IF !USED("cursor_4c_Subniveis")
5280:             THIS.CriarCursoresPedidos()
5281:         ENDIF
5282:         ZAP IN cursor_4c_Subniveis
5283: 
5284:         IF USED("cursor_4c_SubTemp")
5285:             SELECT DISTINCT * FROM cursor_4c_SubTemp INTO CURSOR cursor_4c_SubDistinct
5286:             SELECT cursor_4c_SubDistinct
5287:             SCAN
5288:                 INSERT INTO cursor_4c_Subniveis (Dopes, GruOrigs, GruDests, ConDests, Opers, CMoes, ;
5289:                         NFiscals, Series, Especies, TipoNfs, MarcaSubns, Cfos, Casas, GrVends, ChkLimOps) ;
5290:                     VALUES (cursor_4c_SubDistinct.Dopes, cursor_4c_SubDistinct.GruOrigs, cursor_4c_SubDistinct.GruDests, ;
5291:                         cursor_4c_SubDistinct.ConDests, cursor_4c_SubDistinct.Opers, cursor_4c_SubDistinct.CMoes, ;
5292:                         cursor_4c_SubDistinct.NFiscals, cursor_4c_SubDistinct.Series, cursor_4c_SubDistinct.Especies, ;
5293:                         cursor_4c_SubDistinct.TipoNfs, cursor_4c_SubDistinct.MarcaSubns, cursor_4c_SubDistinct.Cfos, ;
5294:                         cursor_4c_SubDistinct.Casas, cursor_4c_SubDistinct.GrVends, cursor_4c_SubDistinct.ChkLimOps)
5295:             ENDSCAN
5296:             IF USED("cursor_4c_SubDistinct")
5297:                 USE IN cursor_4c_SubDistinct
5298:             ENDIF
5299:             USE IN cursor_4c_SubTemp
5300:         ENDIF
5301: 
5302:         GO TOP IN cursor_4c_Subniveis
5303: 
5304:         *-- Preenche o cabecalho da operacao de pedido (cnt_4c_Operacao)
5305:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "cnt_4c_Operacao", 5)
5306:             WITH THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
5307:                 .txt_4c_Emps.Value  = THIS.this_cEmps
5308:                 .txt_4c_Job.Value   = THIS.this_cJobs
5309:                 .txt_4c_Datas.Value = DATE()
5310: 
5311:                 IF !EOF("cursor_4c_Subniveis")
5312:                     .txt_4c_Dopes.Value  = ALLTRIM(cursor_4c_Subniveis.Dopes)
5313:                     .txt_4c_CMoes.Value  = ALLTRIM(cursor_4c_Subniveis.CMoes)
5314:                     .txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_Subniveis.GruDests)
5315:                     .txt_4c_ContaDs.Value = ALLTRIM(cursor_4c_Subniveis.ConDests)
5316:                 ENDIF
5317: 
5318:                 .txt_4c_ContaEs.Value = ALLTRIM(loc_oBO.this_cContaEs)
5319:                 .obj_4c_GetObs.Value = "Cota" + CHR(231) + CHR(227) + "o " + ;
5320:                     ALLTRIM(STR(loc_oBO.this_nCodigos, 6)) + ;
5321:                     IIF(EMPTY(ALLTRIM(loc_oBO.this_cJustificas)), "", " - ") + ALLTRIM(loc_oBO.this_cJustificas)
5322: 
5323:                 IF !EMPTY(.txt_4c_ContaDs.Value)
5324:                     loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(.txt_4c_ContaDs.Value)
5325:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DContaDsTmp") > 0 AND ;
5326:                        USED("cursor_4c_DContaDsTmp") AND !EOF("cursor_4c_DContaDsTmp")
5327:                         .txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_DContaDsTmp.RClis)
5328:                     ENDIF
5329:                     IF USED("cursor_4c_DContaDsTmp")
5330:                         USE IN cursor_4c_DContaDsTmp

*-- Linhas 5342 a 5368:
5342:                     ENDIF
5343:                 ENDIF
5344:             ENDWITH
5345:         ENDIF
5346: 
5347:         IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")
5348:             MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Processar!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5349:             THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Column1.SetFocus()
5350:             RETURN .F.
5351:         ENDIF
5352: 
5353:         GO TOP IN cursor_4c_CabOperas
5354: 
5355:         IF par_lChk
5356:             RETURN .T.
5357:         ENDIF
5358: 
5359:         THIS.this_cModoAtual = "PEDIDOS"
5360:         THIS.AlternarPagina(4)
5361: 
5362:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "obj_4c_CmdProcessar", 5)
5363:             THIS.pgf_4c_Paginas.Page4.obj_4c_CmdProcessar.Visible = .T.
5364:         ENDIF
5365: 
5366:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "pgf_4c_PgOperacoes", 5)
5367:             THIS.pgf_4c_Paginas.Page4.pgf_4c_PgOperacoes.ActivePage = 1
5368:             THIS.pgf_4c_Paginas.Page4.pgf_4c_PgOperacoes.Page1.grd_4c_CabOperas.Refresh()

*-- Linhas 5386 a 5412:
5386:             RETURN .F.
5387:         ENDIF
5388: 
5389:         loc_nCod = loc_oBO.this_nCodigos
5390: 
5391:         IF !USED("cursor_4c_Pedidos")
5392:             THIS.CriarCursoresPedidos()
5393:         ENDIF
5394: 
5395:         ZAP IN cursor_4c_Pedidos
5396:         ZAP IN cursor_4c_CabOperas
5397:         ZAP IN cursor_4c_ItnOperas
5398: 
5399:         loc_cSQL = "SELECT * FROM SigCtTPc WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
5400:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaPc")
5401: 
5402:         IF loc_nResultado < 0
5403:             MsgErro("Falha na Conex" + CHR(227) + "o (ConsultaPedidos - SigCtTPc)" + CHR(13) + ;
5404:                 CapturarErroSQL(), "Erro SQL")
5405:             RETURN .F.
5406:         ENDIF
5407: 
5408:         IF USED("cursor_4c_ConsultaPc") AND !EOF("cursor_4c_ConsultaPc")
5409:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "cnt_4c_Operacao", 5)
5410:                 WITH THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
5411:                     .txt_4c_Datas.Value   = ConverterParaData(NVL(cursor_4c_ConsultaPc.Datas, {}))
5412:                     .txt_4c_Emps.Value    = ALLTRIM(NVL(cursor_4c_ConsultaPc.Emps, ""))

*-- Linhas 5452 a 5516:
5452:             ENDIF
5453: 
5454:             IF USED("cursor_4c_ConsultaPe")
5455:                 SELECT cursor_4c_ConsultaPe
5456:                 SCAN
5457:                     INSERT INTO cursor_4c_CabOperas (Numes, IFors, Fornecs, FPags, DtEnts, Qtds, Valors, Fretes, VlFretes) ;
5458:                         VALUES (cursor_4c_ConsultaPe.Numes, ALLTRIM(cursor_4c_ConsultaPe.IFors), ;
5459:                             ALLTRIM(cursor_4c_ConsultaPe.Fornecs), ALLTRIM(cursor_4c_ConsultaPe.FPags), ;
5460:                             ConverterParaData(NVL(cursor_4c_ConsultaPe.DtEnts, {})), cursor_4c_ConsultaPe.Qtds, ;
5461:                             cursor_4c_ConsultaPe.Valors, ALLTRIM(NVL(cursor_4c_ConsultaPe.Fretes, "")), ;
5462:                             NVL(cursor_4c_ConsultaPe.VlFretes, 0))
5463:                 ENDSCAN
5464:                 USE IN cursor_4c_ConsultaPe
5465:             ENDIF
5466: 
5467:             loc_cSQL = "SELECT * FROM SigCtTPi WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0) + ;
5468:                 " ORDER BY Numes, CItens"
5469:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaPi")
5470: 
5471:             IF loc_nResultado < 0
5472:                 MsgErro("Falha na Conex" + CHR(227) + "o (ConsultaPedidos - SigCtTPi)" + CHR(13) + ;
5473:                     CapturarErroSQL(), "Erro SQL")
5474:                 RETURN .F.
5475:             ENDIF
5476: 
5477:             IF USED("cursor_4c_ConsultaPi")
5478:                 SELECT cursor_4c_ConsultaPi
5479:                 SCAN
5480:                     INSERT INTO cursor_4c_ItnOperas (CItens, Numes, CPros, DPros, CodCors, CodTams, CUnis, Obs, Qtds, Units, Valors) ;
5481:                         VALUES (cursor_4c_ConsultaPi.CItens, cursor_4c_ConsultaPi.Numes, ALLTRIM(cursor_4c_ConsultaPi.CPros), ;
5482:                             ALLTRIM(cursor_4c_ConsultaPi.DPros), ALLTRIM(NVL(cursor_4c_ConsultaPi.CodCors, "")), ;
5483:                             ALLTRIM(NVL(cursor_4c_ConsultaPi.CodTams, "")), ALLTRIM(cursor_4c_ConsultaPi.CUnis), ;
5484:                             NVL(cursor_4c_ConsultaPi.Obs, ""), cursor_4c_ConsultaPi.Qtds, cursor_4c_ConsultaPi.Units, ;
5485:                             cursor_4c_ConsultaPi.Valors)
5486:                 ENDSCAN
5487:                 USE IN cursor_4c_ConsultaPi
5488:             ENDIF
5489:         ENDIF
5490: 
5491:         IF USED("cursor_4c_ConsultaPc")
5492:             USE IN cursor_4c_ConsultaPc
5493:         ENDIF
5494: 
5495:         IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")
5496:             MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Processar!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5497:             THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Column1.SetFocus()
5498:             RETURN .F.
5499:         ENDIF
5500: 
5501:         GO TOP IN cursor_4c_CabOperas
5502: 
5503:         THIS.this_cModoAtual = "PEDIDOS"
5504:         THIS.AlternarPagina(4)
5505: 
5506:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "obj_4c_CmdProcessar", 5)
5507:             THIS.pgf_4c_Paginas.Page4.obj_4c_CmdProcessar.Visible = .F.
5508:         ENDIF
5509: 
5510:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "pgf_4c_PgOperacoes", 5)
5511:             THIS.pgf_4c_Paginas.Page4.pgf_4c_PgOperacoes.ActivePage = 1
5512:             THIS.pgf_4c_Paginas.Page4.pgf_4c_PgOperacoes.Page1.grd_4c_CabOperas.Refresh()
5513:         ENDIF
5514: 
5515:         THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao.txt_4c_Dopes.SetFocus()
5516: 

*-- Linhas 5529 a 5549:
5529:     * na data) feita duas linhas acima para a moeda padrao.
5530:     *--------------------------------------------------------------------------
5531:     PROTECTED FUNCTION LiberaPagto(par_nValTit, par_cMoeTit, par_dDatTit)
5532:         LOCAL loc_cSQL, loc_cCargo, loc_nVlLib, loc_nCotP, loc_nVlL, loc_lLib
5533: 
5534:         IF !USED("cursor_4c_Subniveis") OR cursor_4c_Subniveis.ChkLimOps != 1
5535:             RETURN .T.
5536:         ENDIF
5537: 
5538:         loc_cSQL = "SELECT CCargs FROM SigCdUsu WHERE Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado)
5539:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LibUsu") < 1 OR !USED("cursor_4c_LibUsu") OR EOF("cursor_4c_LibUsu")
5540:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + ;
5541:                 "o (CrSigCdUsu)", "Erro SQL")
5542:             IF USED("cursor_4c_LibUsu")
5543:                 USE IN cursor_4c_LibUsu
5544:             ENDIF
5545:             RETURN .F.
5546:         ENDIF
5547:         loc_cCargo = ALLTRIM(NVL(cursor_4c_LibUsu.CCargs, ""))
5548:         USE IN cursor_4c_LibUsu
5549: 

*-- Linhas 5564 a 5594:
5564:             fBuscarCotacao(par_cMoeTit, par_dDatTit) / loc_nCotP)
5565:         loc_lLib  = (loc_nVlLib >= loc_nVlL)
5566: 
5567:         IF !loc_lLib
5568:             MsgAviso("Usu" + CHR(225) + "rio n" + CHR(227) + "o autorizado a liberar pagamento na " + ;
5569:                 "movimenta" + CHR(231) + CHR(227) + "o: " + TRANSFORM(cursor_4c_CabOperas.Numes), loc_cCargo)
5570:         ENDIF
5571: 
5572:         RETURN loc_lLib
5573:     ENDFUNC
5574: 
5575:     *--------------------------------------------------------------------------
5576:     * GravaPedidos - Equivalente ao PROCEDURE gravapedidos legado: grava
5577:     * fisicamente as operacoes de compra (SigMvCab/SigMvItn/SigMvIts/SigMvPar)
5578:     * e o espelho da cotacao convertida em pedido (SigCtTPc/Pe/Pi/Ps), 1
5579:     * conjunto de SigMvCab/Itn/Par por fornecedor marcado (cursor_4c_CabOperas).
5580:     *
5581:     * Adaptacoes de arquitetura (regra ja usada em GravaDados/AprovarCotacao
5582:     * deste form): SQLEXEC direto por registro em vez de cursor bufferizado +
5583:     * TableUpdate/Rollback. Como a conexao deste ambiente nasce com
5584:     * Transactions=2 (manual - medido, ver functions.prg:fGerUniqueKey), o
5585:     * "tudo ou nada" do Commit/Rollback legado equivale a SQLCOMMIT/SQLROLLBACK
5586:     * explicitos ao final (mesmo padrao de SIGMVCMVBO.GravarLancamentos).
5587:     *
5588:     * Duas funcoes GLOBAIS do legado ficam FORA do dump (regra #27 - nunca
5589:     * chutar valor de calculo/lancamento financeiro):
5590:     *   fCalcularImpostos  - calcula impostos da Nota Fiscal (NFiscals 1/2).
5591:     *                        Operacoes que emitem NF automaticamente por essa
5592:     *                        tela ficam BLOQUEADAS ate a funcao ser portada -
5593:     *                        aviso claro em vez de estourar em runtime.
5594:     *   fSigOpFin_Lancs    - lancamentos financeiros automaticos configurados

*-- Linhas 5631 a 5708:
5631:             loc_oCnt.txt_4c_Datas.SetFocus()
5632:             RETURN .F.
5633:         ENDIF
5634: 
5635:         loc_cDop = ALLTRIM(loc_oCnt.txt_4c_Dopes.Value)
5636:         IF !USED("cursor_4c_Subniveis") OR EMPTY(loc_cDop) OR ;
5637:             !SEEK(PADR(loc_cDop, 20), "cursor_4c_Subniveis", "Dopes")
5638:             MsgAviso("A Opera" + CHR(231) + CHR(227) + "o de Lan" + CHR(231) + "amento N" + CHR(227) + ;
5639:                 "o Foi Informada!!!", "Dados Inv" + CHR(225) + "lidos!!!")
5640:             loc_oCnt.txt_4c_Dopes.SetFocus()
5641:             RETURN .F.
5642:         ENDIF
5643: 
5644:         loc_cMoe = ALLTRIM(loc_oCnt.txt_4c_CMoes.Value)
5645:         IF EMPTY(loc_cMoe)
5646:             MsgAviso("A Moeda de Lan" + CHR(231) + "amento N" + CHR(227) + "o Foi Informada!!!", ;
5647:                 "Dados Inv" + CHR(225) + "lidos!!!")
5648:             loc_oCnt.txt_4c_CMoes.SetFocus()
5649:             RETURN .F.
5650:         ENDIF
5651: 
5652:         IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")
5653:             MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Para Gravar!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5654:             RETURN .F.
5655:         ENDIF
5656: 
5657:         *-- cursor_4c_Subniveis ja esta posicionado pelo SEEK acima
5658:         loc_cGrO = ALLTRIM(cursor_4c_Subniveis.GruOrigs)
5659:         loc_cGrD = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
5660:         loc_cCtD = ALLTRIM(loc_oCnt.txt_4c_ContaDs.Value)
5661:         loc_cCtE = ALLTRIM(loc_oCnt.txt_4c_ContaEs.Value)
5662:         loc_nObs = loc_oCnt.txt_4c_CodObs.Value
5663:         loc_cObs = loc_oCnt.obj_4c_GetObs.Value
5664:         loc_nEnt = loc_oBO.this_nLocalEnts
5665:         loc_cOpe = IIF(cursor_4c_Subniveis.Opers = 1, "E", "S")
5666:         loc_nENF = cursor_4c_Subniveis.NFiscals
5667:         loc_cGrv = ALLTRIM(cursor_4c_Subniveis.GrVends)
5668: 
5669:         IF INLIST(loc_nENF, 1, 2)
5670:             MsgErro("Esta opera" + CHR(231) + CHR(227) + "o emite Nota Fiscal automaticamente ao " + ;
5671:                 "gerar o pedido (c" + CHR(225) + "lculo de impostos), funcionalidade ainda n" + ;
5672:                 CHR(227) + "o portada para o sistema novo." + CHR(13) + ;
5673:                 "Selecione uma opera" + CHR(231) + CHR(227) + "o de lan" + CHR(231) + "amento que N" + ;
5674:                 CHR(227) + "o emita NF, ou gere este pedido pelo sistema legado.", ;
5675:                 "Funcionalidade N" + CHR(227) + "o Dispon" + CHR(237) + "vel")
5676:             RETURN .F.
5677:         ENDIF
5678: 
5679:         *-- Limite de valor por cargo (Tiago - 22/09/2014 - CC2016)
5680:         IF cursor_4c_Subniveis.ChkLimOps = 1
5681:             loc_nCotP = fBuscarCotacao(THIS.this_cMoedaPs, loc_dDat)
5682:             loc_lOk   = .T.
5683:             SELECT cursor_4c_CabOperas
5684:             GO TOP
5685:             DO WHILE loc_lOk AND !EOF("cursor_4c_CabOperas")
5686:                 loc_nCotPen = IIF(EMPTY(loc_cMoe), 1, fBuscarCotacao(loc_cMoe, loc_dDat))
5687:                 loc_nTtPen  = cursor_4c_CabOperas.Valors * loc_nCotPen
5688:                 loc_nTtGer  = IIF(loc_nCotP = 0, 0, loc_nTtPen / loc_nCotP)
5689:                 IF !THIS.LiberaPagto(loc_nTtGer, THIS.this_cMoedaPs, loc_dDat)
5690:                     loc_lOk = .F.
5691:                 ENDIF
5692:                 IF loc_lOk
5693:                     SKIP IN cursor_4c_CabOperas
5694:                 ENDIF
5695:             ENDDO
5696:             IF !loc_lOk
5697:                 RETURN .F.
5698:             ENDIF
5699:         ENDIF
5700: 
5701:         loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
5702:         loc_lOk     = .T.
5703:         loc_cErro   = ""
5704: 
5705:         TRY
5706:             *-- SigCtTPc - cabecalho da cotacao-pedido (1 registro, fora do loop
5707:             *-- por fornecedor - Insert Into crSigCtTPc do legado)
5708:             loc_cSQL = "INSERT INTO SigCtTPc (cidchaves, codigos, datars, datas, emps, dopes, cmoes, " + ;

*-- Linhas 5717 a 5921:
5717:             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5718:                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPc)" + CHR(13) + CapturarErroSQL()
5719:                 loc_lOk = .F.
5720:             ENDIF
5721: 
5722:             SELECT cursor_4c_CabOperas
5723:             GO TOP
5724:             DO WHILE loc_lOk AND !EOF("cursor_4c_CabOperas")
5725:                 loc_nNumesGrupo = cursor_4c_CabOperas.Numes
5726: 
5727:                 loc_nNum = fGerUniqueKey(ALLTRIM(loc_cDop) + loc_cEmp)
5728:                 loc_nNop = fGerUniqueKey("SIGMVCCR")
5729:                 loc_cEmpDopNums = loc_cEmp + loc_cDop + STR(loc_nNum, 6)
5730:                 loc_cEmpGopNums = loc_cEmp + SPACE(20) + STR(loc_nNum, 6)
5731: 
5732:                 *-- SigMvCab - cabecalho da movimentacao (1 por fornecedor)
5733:                 loc_cSQL = "INSERT INTO SigMvCab (cidchaves, emps, dopes, numes, empdopnums, mascnum, " + ;
5734:                     "opers, datas, datars, dtalts, grupoos, contaos, grupods, contads, contaes, " + ;
5735:                     "localents, codobs, obses, valos, valinis, usuars, prazoents, empgopnums, " + ;
5736:                     "usupagos, grvends, resps, jobs) VALUES (" + ;
5737:                     EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
5738:                     EscaparSQL(loc_cEmp) + ", " + EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5739:                     EscaparSQL(loc_cEmpDopNums) + ", " + EscaparSQL(ALLTRIM(fGerMascara(loc_nNum))) + ", " + ;
5740:                     EscaparSQL(loc_cOpe) + ", " + FormatarDataSQL(loc_dDat) + ", GETDATE(), GETDATE(), " + ;
5741:                     EscaparSQL(loc_cGrO) + ", " + EscaparSQL(cursor_4c_CabOperas.IFors) + ", " + ;
5742:                     EscaparSQL(loc_cGrD) + ", " + EscaparSQL(loc_cCtD) + ", " + EscaparSQL(loc_cCtE) + ", " + ;
5743:                     FormatarNumeroSQL(loc_nEnt, 0) + ", " + FormatarNumeroSQL(loc_nObs, 0) + ", " + ;
5744:                     EscaparSQL(loc_cObs) + ", " + FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 2) + ", " + ;
5745:                     FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 2) + ", " + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
5746:                     FormatarDataSQL(cursor_4c_CabOperas.DtEnts) + ", " + EscaparSQL(loc_cEmpGopNums) + ", " + ;
5747:                     EscaparSQL(LEFT(loc_oBO.this_cAprovador, 10)) + ", " + EscaparSQL(loc_cGrv) + ", " + ;
5748:                     EscaparSQL(LEFT(loc_oBO.this_cComprador, 12)) + ", " + ;
5749:                     EscaparSQL(LEFT(NVL(cursor_4c_CabOperas.Jobs, ""), 10)) + ")"
5750: 
5751:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5752:                     loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvCab)" + CHR(13) + CapturarErroSQL()
5753:                     loc_lOk = .F.
5754:                 ENDIF
5755: 
5756:                 *-- SigCtTPs - liga o Codigos da cotacao ao EmpDopNums gerado
5757:                 IF loc_lOk
5758:                     loc_cSQL = "INSERT INTO SigCtTPs (cidchaves, codigos, empdopnums) VALUES (" + ;
5759:                         EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
5760:                         EscaparSQL(loc_cEmpDopNums) + ")"
5761:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5762:                         loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPs)" + CHR(13) + CapturarErroSQL()
5763:                         loc_lOk = .F.
5764:                     ENDIF
5765:                 ENDIF
5766: 
5767:                 *-- SigCtTPe - fornecedor/condicao/entrega do pedido (1 por fornecedor)
5768:                 IF loc_lOk
5769:                     loc_cSQL = "INSERT INTO SigCtTPe (cidchaves, codigos, numes, ifors, fornecs, fpags, " + ;
5770:                         "dtents, qtds, valors, fretes, vlfretes) VALUES (" + ;
5771:                         EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
5772:                         FormatarNumeroSQL(loc_nNumesGrupo, 0) + ", " + ;
5773:                         EscaparSQL(LEFT(cursor_4c_CabOperas.IFors, 10)) + ", " + ;
5774:                         EscaparSQL(LEFT(cursor_4c_CabOperas.Fornecs, 50)) + ", " + ;
5775:                         EscaparSQL(LEFT(cursor_4c_CabOperas.FPags, 12)) + ", " + ;
5776:                         FormatarDataSQL(cursor_4c_CabOperas.DtEnts) + ", " + ;
5777:                         FormatarNumeroSQL(cursor_4c_CabOperas.Qtds, 2) + ", " + ;
5778:                         FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 6) + ", " + ;
5779:                         EscaparSQL(LEFT(NVL(cursor_4c_CabOperas.Fretes, ""), 12)) + ", " + ;
5780:                         FormatarNumeroSQL(cursor_4c_CabOperas.VlFretes, 2) + ")"
5781:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5782:                         loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPe)" + CHR(13) + CapturarErroSQL()
5783:                         loc_lOk = .F.
5784:                     ENDIF
5785:                 ENDIF
5786: 
5787:                 *-- Itens do fornecedor corrente (cursor_4c_ItnOperas.Numes = loc_nNumesGrupo)
5788:                 IF loc_lOk
5789:                     SELECT cursor_4c_ItnOperas
5790:                     GO TOP
5791:                     LOCATE FOR cursor_4c_ItnOperas.Numes = loc_nNumesGrupo
5792:                     DO WHILE loc_lOk AND !EOF("cursor_4c_ItnOperas") AND cursor_4c_ItnOperas.Numes = loc_nNumesGrupo
5793:                         loc_cSQL = "INSERT INTO SigMvItn (cidchaves, emps, dopes, numes, empdopnums, dtalts, " + ;
5794:                             "citens, cpros, dpros, obs, opers, moedas, moefats, moevals, qtds, aqtds, units, " + ;
5795:                             "totas, cunis) VALUES (" + ;
5796:                             EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5797:                             EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5798:                             EscaparSQL(loc_cEmpDopNums) + ", GETDATE(), " + ;
5799:                             FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5800:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5801:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.DPros), 65)) + ", " + ;
5802:                             EscaparSQL(NVL(cursor_4c_ItnOperas.Obs, "")) + ", " + ;
5803:                             EscaparSQL(loc_cOpe) + ", " + EscaparSQL(loc_cMoe) + ", " + EscaparSQL(loc_cMoe) + ", " + ;
5804:                             FormatarNumeroSQL(1, 0) + ", " + ;
5805:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5806:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5807:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Units, 6) + ", " + ;
5808:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Valors, 2) + ", " + ;
5809:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CUnis), 3)) + ")"
5810: 
5811:                         IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5812:                             loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvItn)" + CHR(13) + CapturarErroSQL()
5813:                             loc_lOk = .F.
5814:                         ENDIF
5815: 
5816:                         IF loc_lOk
5817:                             loc_cSQL = "INSERT INTO SigCtTPi (cidchaves, codigos, citens, numes, cpros, " + ;
5818:                                 "dpros, codcors, codtams, cunis, obs, qtds, units, valors) VALUES (" + ;
5819:                                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
5820:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5821:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Numes, 0) + ", " + ;
5822:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5823:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.DPros), 50)) + ", " + ;
5824:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodCors, ""), 4)) + ", " + ;
5825:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodTams, ""), 4)) + ", " + ;
5826:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CUnis), 3)) + ", " + ;
5827:                                 EscaparSQL(NVL(cursor_4c_ItnOperas.Obs, "")) + ", " + ;
5828:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 2) + ", " + ;
5829:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Units, 6) + ", " + ;
5830:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Valors, 6) + ")"
5831:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5832:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPi)" + CHR(13) + CapturarErroSQL()
5833:                                 loc_lOk = .F.
5834:                             ENDIF
5835:                         ENDIF
5836: 
5837:                         *-- SigMvIts - detalhe de cor/tamanho, so quando informado
5838:                         IF loc_lOk AND (!EMPTY(cursor_4c_ItnOperas.CodCors) OR !EMPTY(cursor_4c_ItnOperas.CodTams))
5839:                             loc_cSQL = "INSERT INTO SigMvIts (cidchaves, emps, dopes, numes, citens, cpros, " + ;
5840:                                 "codcors, codtams, qtds, aqtds, empdopnums, chksubn) VALUES (" + ;
5841:                                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5842:                                 EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5843:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5844:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5845:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodCors, ""), 4)) + ", " + ;
5846:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodTams, ""), 4)) + ", " + ;
5847:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5848:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5849:                                 EscaparSQL(loc_cEmpDopNums) + ", 0)"
5850:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5851:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvIts)" + CHR(13) + CapturarErroSQL()
5852:                                 loc_lOk = .F.
5853:                             ENDIF
5854:                         ENDIF
5855: 
5856:                         IF loc_lOk
5857:                             SKIP IN cursor_4c_ItnOperas
5858:                         ENDIF
5859:                     ENDDO
5860:                 ENDIF
5861: 
5862:                 *-- SigMvPar - parcelas financeiras conforme a condicao de pagamento
5863:                 IF loc_lOk
5864:                     loc_cSQL = "SELECT FParcs, MoeFpgs, TVens, Dias FROM SigOpFp WHERE FPags = " + ;
5865:                         EscaparSQL(ALLTRIM(cursor_4c_CabOperas.FPags))
5866:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalFPag")
5867: 
5868:                     IF loc_nResultado >= 0 AND USED("cursor_4c_LocalFPag") AND !EOF("cursor_4c_LocalFPag")
5869:                         loc_nPar = IIF(NVL(cursor_4c_LocalFPag.FParcs, 0) < 1, 1, cursor_4c_LocalFPag.FParcs)
5870:                         loc_dDtV = loc_dDat
5871:                         loc_cMdf = IIF(EMPTY(NVL(cursor_4c_LocalFPag.MoeFpgs, "")), loc_cMoe, ;
5872:                             ALLTRIM(cursor_4c_LocalFPag.MoeFpgs))
5873: 
5874:                         FOR loc_nI = 1 TO loc_nPar
5875:                             loc_cSQL = "INSERT INTO SigMvPar (cidchaves, emps, dopes, numes, empdopnums, " + ;
5876:                                 "datas, cotfpgs, fpags, moefpgs, nopers, valos, vencs, parcs, pagos, dtalts) VALUES (" + ;
5877:                                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5878:                                 EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5879:                                 EscaparSQL(loc_cEmpDopNums) + ", " + FormatarDataSQL(loc_dDat) + ", " + ;
5880:                                 FormatarNumeroSQL(1, 4) + ", " + EscaparSQL(LEFT(cursor_4c_CabOperas.FPags, 12)) + ", " + ;
5881:                                 EscaparSQL(LEFT(loc_cMdf, 3)) + ", " + FormatarNumeroSQL(loc_nNop, 0) + ", " + ;
5882:                                 FormatarNumeroSQL(cursor_4c_CabOperas.Valors / loc_nPar, 2) + ", " + ;
5883:                                 FormatarDataSQL(loc_dDtV) + ", " + FormatarNumeroSQL(loc_nI, 0) + ", " + ;
5884:                                 EscaparSQL("1") + ", GETDATE())"
5885: 
5886:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5887:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvPar)" + CHR(13) + CapturarErroSQL()
5888:                                 loc_lOk = .F.
5889:                             ENDIF
5890: 
5891:                             IF UPPER(ALLTRIM(NVL(cursor_4c_LocalFPag.TVens, ""))) == "F"
5892:                                 loc_dDtV = GOMONTH(loc_dDat, loc_nI)
5893:                             ELSE
5894:                                 loc_dDtV = loc_dDtV + NVL(cursor_4c_LocalFPag.Dias, 0)
5895:                             ENDIF
5896:                         ENDFOR
5897:                     ENDIF
5898: 
5899:                     IF USED("cursor_4c_LocalFPag")
5900:                         USE IN cursor_4c_LocalFPag
5901:                     ENDIF
5902:                 ENDIF
5903: 
5904:                 IF loc_lOk
5905:                     SELECT cursor_4c_CabOperas
5906:                     SKIP IN cursor_4c_CabOperas
5907:                 ENDIF
5908:             ENDDO
5909: 
5910:             *-- Marca a cotacao como Pedido Gerado
5911:             IF loc_lOk
5912:                 loc_cSQL = "UPDATE SigCtTDc SET Situas = 1 WHERE Codigos = " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0)
5913:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5914:                     loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - Update SigCtTDc)" + CHR(13) + CapturarErroSQL()
5915:                     loc_lOk = .F.
5916:                 ENDIF
5917:             ENDIF
5918: 
5919:             *-- "Lanca movimentacoes financeiras conforme configurado" (Tiago,
5920:             *-- 23/09/2014). fSigOpFin_Lancs eh funcao GLOBAL fora do dump -
5921:             *-- so dispara quando ha config em SigOpCdi para esta operacao;

*-- Linhas 6090 a 6112:
6090:             .BackStyle   = 0
6091:             .BorderStyle = 0
6092:             .Value       = 0
6093:             .Top         = 7
6094:             .Left        = 910
6095:             .Width       = 80
6096:             .Height      = 100
6097:             .Visible     = .T.
6098: 
6099:             WITH .Buttons(1)
6100:                 .Top             = 0
6101:                 .Left            = 0
6102:                 .Height          = 100
6103:                 .Width           = 80
6104:                 .WordWrap        = .T.
6105:                 .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
6106:                 .Cancel          = .T.
6107:                 .Caption         = "P" + CHR(225) + "gina de Dados"
6108:                 .MousePointer    = 15
6109:                 .ToolTipText     = "Voltar Para a P" + CHR(225) + "gina de Dados"
6110:                 .SpecialEffect   = 0
6111:                 .PicturePosition = 7
6112:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 6126 a 6147:
6126:             .BackStyle   = 0
6127:             .BorderStyle = 0
6128:             .Value       = 0
6129:             .Top         = 7
6130:             .Left        = 748
6131:             .Width       = 80
6132:             .Height      = 100
6133:             .Visible     = .T.
6134: 
6135:             WITH .Buttons(1)
6136:                 .Top             = 0
6137:                 .Left            = 0
6138:                 .Height          = 100
6139:                 .Width           = 80
6140:                 .WordWrap        = .T.
6141:                 .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
6142:                 .Caption         = "Processar Pedidos"
6143:                 .MousePointer    = 15
6144:                 .ToolTipText     = "Gerar Opera" + CHR(231) + CHR(245) + "es dos Pedidos"
6145:                 .SpecialEffect   = 0
6146:                 .PicturePosition = 7
6147:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 6163 a 6184:
6163:             .BackStyle   = 0
6164:             .BorderStyle = 0
6165:             .Value       = 0
6166:             .Top         = 7
6167:             .Left        = 829
6168:             .Width       = 80
6169:             .Height      = 100
6170:             .Visible     = .T.
6171: 
6172:             WITH .Buttons(1)
6173:                 .Top             = 0
6174:                 .Left            = 0
6175:                 .Height          = 100
6176:                 .Width           = 80
6177:                 .WordWrap        = .T.
6178:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
6179:                 .Caption         = "Alterar Pedidos"
6180:                 .MousePointer    = 15
6181:                 .ToolTipText     = "Alterar a Opera" + CHR(231) + CHR(227) + "o Gerada"
6182:                 .SpecialEffect   = 0
6183:                 .PicturePosition = 7
6184:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 6193 a 6202:
6193:         *----------------------------------------------------------------------
6194:         loc_oPag.AddObject("cnt_4c_Operacao", "Container")
6195:         WITH loc_oPag.cnt_4c_Operacao
6196:             .Top           = 4
6197:             .Left          = 3
6198:             .Width         = 564
6199:             .Height        = 172
6200:             .BackStyle     = 0
6201:             .BorderWidth   = 0
6202:             .SpecialEffect = 0

*-- Linhas 6214 a 6319:
6214:         *-- uma caixa cinza no meio do container transparente.
6215: 
6216:         *-- "Destino :" (Say8) - grupo/conta contabil de destino
6217:         loc_oCnt.AddObject("lbl_4c_Label8", "Label")
6218:         WITH loc_oCnt.lbl_4c_Label8
6219:             .FontName  = "Tahoma"
6220:             .FontSize  = 8
6221:             .FontBold  = .T.
6222:             .Caption   = "Destino :"
6223:             .Left      = 12
6224:             .Top       = 53
6225:             .Width     = 55
6226:             .Height    = 15
6227:             .Alignment = 0
6228:             .AutoSize  = .F.
6229:             .BackStyle = 0
6230:             .ForeColor = RGB(36, 84, 155)
6231:             .Visible   = .T.
6232:         ENDWITH
6233: 
6234:         *-- "Entrega :" (Say2) - conta de entrega do pedido
6235:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
6236:         WITH loc_oCnt.lbl_4c_Label2
6237:             .FontName  = "Tahoma"
6238:             .FontSize  = 8
6239:             .FontBold  = .T.
6240:             .Caption   = "Entrega :"
6241:             .Left      = 10
6242:             .Top       = 75
6243:             .Width     = 55
6244:             .Height    = 15
6245:             .Alignment = 0
6246:             .AutoSize  = .F.
6247:             .BackStyle = 0
6248:             .ForeColor = RGB(36, 84, 155)
6249:             .Visible   = .T.
6250:         ENDWITH
6251: 
6252:         *-- "Empresa :" (Say3)
6253:         loc_oCnt.AddObject("lbl_4c_Label3", "Label")
6254:         WITH loc_oCnt.lbl_4c_Label3
6255:             .FontName  = "Tahoma"
6256:             .FontSize  = 8
6257:             .FontBold  = .T.
6258:             .Caption   = "Empresa :"
6259:             .Left      = 4
6260:             .Top       = 9
6261:             .Width     = 60
6262:             .Height    = 15
6263:             .Alignment = 0
6264:             .AutoSize  = .F.
6265:             .BackStyle = 0
6266:             .ForeColor = RGB(36, 84, 155)
6267:             .Visible   = .T.
6268:         ENDWITH
6269: 
6270:         *-- "Data :" (Say4)
6271:         loc_oCnt.AddObject("lbl_4c_Label4", "Label")
6272:         WITH loc_oCnt.lbl_4c_Label4
6273:             .FontName  = "Tahoma"
6274:             .FontSize  = 8
6275:             .FontBold  = .T.
6276:             .Caption   = "Data :"
6277:             .Left      = 106
6278:             .Top       = 9
6279:             .Width     = 38
6280:             .Height    = 15
6281:             .Alignment = 0
6282:             .AutoSize  = .F.
6283:             .BackStyle = 0
6284:             .ForeColor = RGB(36, 84, 155)
6285:             .Visible   = .T.
6286:         ENDWITH
6287: 
6288:         *-- "Operacao :" (Say5)
6289:         loc_oCnt.AddObject("lbl_4c_Label5", "Label")
6290:         WITH loc_oCnt.lbl_4c_Label5
6291:             .FontName  = "Tahoma"
6292:             .FontSize  = 8
6293:             .FontBold  = .T.
6294:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
6295:             .Left      = 216
6296:             .Top       = 9
6297:             .Width     = 65
6298:             .Height    = 15
6299:             .Alignment = 0
6300:             .AutoSize  = .F.
6301:             .BackStyle = 0
6302:             .ForeColor = RGB(36, 84, 155)
6303:             .Visible   = .T.
6304:         ENDWITH
6305: 
6306:         *-- "Moeda :" (Say6)
6307:         loc_oCnt.AddObject("lbl_4c_Label6", "Label")
6308:         WITH loc_oCnt.lbl_4c_Label6
6309:             .FontName  = "Tahoma"
6310:             .FontSize  = 8
6311:             .FontBold  = .T.
6312:             .Caption   = "Moeda :"
6313:             .Left      = 431
6314:             .Top       = 9
6315:             .Width     = 50
6316:             .Height    = 15
6317:             .Alignment = 0
6318:             .AutoSize  = .F.
6319:             .BackStyle = 0

*-- Linhas 6329 a 6338:
6329:             .FontBold          = .T.
6330:             .Format            = "K"
6331:             .Height            = 20
6332:             .Left              = 73
6333:             .Top               = 51
6334:             .Width             = 73
6335:             .Margin            = 2
6336:             .MaxLength         = 10
6337:             .SpecialEffect     = 1
6338:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6349 a 6358:
6349:             .FontSize          = 8
6350:             .Format            = "K"
6351:             .Height            = 20
6352:             .Left              = 149
6353:             .Top               = 51
6354:             .Width             = 73
6355:             .Margin            = 2
6356:             .MaxLength         = 10
6357:             .SpecialEffect     = 1
6358:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6369 a 6378:
6369:             .FontSize          = 8
6370:             .Format            = "K"
6371:             .Height            = 20
6372:             .Left              = 225
6373:             .Top               = 51
6374:             .Width             = 287
6375:             .Margin            = 2
6376:             .MaxLength         = 50
6377:             .SpecialEffect     = 1
6378:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6389 a 6398:
6389:             .FontName          = "Arial"
6390:             .FontSize          = 8
6391:             .Height            = 20
6392:             .Left              = 73
6393:             .Top               = 73
6394:             .Width             = 73
6395:             .Margin            = 2
6396:             .MaxLength         = 10
6397:             .SpecialEffect     = 1
6398:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6408 a 6417:
6408:             .FontName          = "Arial"
6409:             .FontSize          = 8
6410:             .Height            = 20
6411:             .Left              = 149
6412:             .Top               = 73
6413:             .Width             = 362
6414:             .Margin            = 2
6415:             .MaxLength         = 50
6416:             .SpecialEffect     = 1
6417:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6431 a 6452:
6431:             .BackStyle   = 0
6432:             .BorderStyle = 0
6433:             .Value       = 1
6434:             .Top         = 57
6435:             .Left        = 520
6436:             .Width       = 40
6437:             .Height      = 40
6438:             .Themes      = .F.
6439:             .Visible     = .T.
6440: 
6441:             WITH .Buttons(1)
6442:                 .Top           = 0
6443:                 .Left          = 0
6444:                 .Height        = 40
6445:                 .Width         = 40
6446:                 .Picture       = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
6447:                 .Caption       = ""
6448:                 .ToolTipText   = "Local de Entrega"
6449:                 .SpecialEffect = 0
6450:                 .BackColor     = RGB(255, 255, 255)
6451:                 .Themes        = .F.
6452:             ENDWITH

*-- Linhas 6459 a 6488:
6459:             .FontSize          = 8
6460:             .Format            = "K"
6461:             .Height            = 20
6462:             .Left              = 73
6463:             .Top               = 7
6464:             .Width             = 27
6465:             .Margin            = 2
6466:             .MaxLength         = 3
6467:             .SpecialEffect     = 1
6468:             .BorderColor       = RGB(0, 0, 128)
6469:             .DisabledBackColor = RGB(255, 255, 255)
6470:             .DisabledForeColor = RGB(0, 0, 255)
6471:             .Value             = ""
6472:             .Visible           = .T.
6473:         ENDWITH
6474: 
6475:         *-- "Obs. :" (Say_Obs)
6476:         loc_oCnt.AddObject("lbl_4c__Obs", "Label")
6477:         WITH loc_oCnt.lbl_4c__Obs
6478:             .FontName  = "Tahoma"
6479:             .FontSize  = 8
6480:             .FontBold  = .T.
6481:             .Caption   = "Obs. :"
6482:             .Left      = 33
6483:             .Top       = 95
6484:             .Width     = 36
6485:             .Height    = 15
6486:             .Alignment = 0
6487:             .AutoSize  = .F.
6488:             .BackStyle = 0

*-- Linhas 6496 a 6505:
6496:             .FontName      = "Arial"
6497:             .FontSize      = 8
6498:             .Height        = 72
6499:             .Left          = 104
6500:             .Top           = 95
6501:             .Width         = 407
6502:             .SpecialEffect = 1
6503:             .BorderColor   = RGB(0, 0, 128)
6504:             .Value         = ""
6505:             .Visible       = .T.

*-- Linhas 6513 a 6522:
6513:             .Format            = "KE"
6514:             .InputMask         = "99/99/9999"
6515:             .Height            = 20
6516:             .Left              = 149
6517:             .Top               = 7
6518:             .Width             = 62
6519:             .Margin            = 2
6520:             .MaxLength         = 10
6521:             .SpecialEffect     = 1
6522:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6533 a 6542:
6533:             .FontSize          = 8
6534:             .Format            = "K"
6535:             .Height            = 20
6536:             .Left              = 289
6537:             .Top               = 7
6538:             .Width             = 135
6539:             .Margin            = 2
6540:             .MaxLength         = 20
6541:             .SpecialEffect     = 1
6542:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6553 a 6562:
6553:             .FontSize          = 8
6554:             .Format            = "K"
6555:             .Height            = 20
6556:             .Left              = 485
6557:             .Top               = 7
6558:             .Width             = 27
6559:             .Margin            = 2
6560:             .MaxLength         = 3
6561:             .SpecialEffect     = 1
6562:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6576 a 6605:
6576:             .Alignment         = 3
6577:             .Format            = "K"
6578:             .Height            = 20
6579:             .Left              = 73
6580:             .Top               = 95
6581:             .Width             = 27
6582:             .Margin            = 2
6583:             .MaxLength         = 3
6584:             .SpecialEffect     = 1
6585:             .BorderColor       = RGB(0, 0, 128)
6586:             .DisabledBackColor = RGB(255, 255, 255)
6587:             .DisabledForeColor = RGB(0, 0, 255)
6588:             .Value             = 0
6589:             .Visible           = .T.
6590:         ENDWITH
6591: 
6592:         *-- "Job :" (Say25 - unico label do container com FontName proprio)
6593:         loc_oCnt.AddObject("lbl_4c_Label25", "Label")
6594:         WITH loc_oCnt.lbl_4c_Label25
6595:             .FontName  = "Verdana"
6596:             .FontSize  = 8
6597:             .FontBold  = .T.
6598:             .Caption   = "Job :"
6599:             .Left      = 39
6600:             .Top       = 31
6601:             .Width     = 32
6602:             .Height    = 15
6603:             .Alignment = 0
6604:             .AutoSize  = .F.
6605:             .BackStyle = 0

*-- Linhas 6623 a 6632:
6623:             .BorderStyle   = 1
6624:             .Format        = "K"
6625:             .Height        = 20
6626:             .Left          = 73
6627:             .Top           = 29
6628:             .Width         = 73
6629:             .MaxLength     = 10
6630:             .SpecialEffect = 1
6631:             .ForeColor     = RGB(0, 0, 0)
6632:             .BorderColor   = RGB(0, 0, 128)

*-- Linhas 6642 a 6651:
6642:             .FontSize      = 8
6643:             .Format        = "K"
6644:             .Height        = 20
6645:             .Left          = 149
6646:             .Top           = 29
6647:             .Width         = 304
6648:             .MaxLength     = 40
6649:             .SpecialEffect = 1
6650:             .BorderColor   = RGB(0, 0, 128)
6651:             .Themes        = .F.

*-- Linhas 7049 a 7069:
7049:         ENDIF
7050:     ENDPROC
7051: 
7052:     *--------------------------------------------------------------------------
7053:     * Operacao de lancamento (getDopes -> operacoes de subnivel do Dopes
7054:     * filtrado em Page1, cursor_4c_Subniveis - equivalente ao fwBuscaInt do
7055:     * legado sobre crSubniveis, aqui implementado como FormBuscaAuxiliar sobre
7056:     * uma SUBCONSULTA SQL Server derivada (nao um cursor VFP local - o
7057:     * contrato de FormBuscaAuxiliar exige "SELECT * FROM <tabela>", e uma
7058:     * expressao "(SELECT ... ) AS X" e uma tabela derivada valida no SQL
7059:     * Server, preservando o padrao canonico do projeto).
7060:     *--------------------------------------------------------------------------
7061:     PROCEDURE TeclaOperacaoLancamento(par_nKeyCode, par_nShiftAltCtrl)
7062:         IF par_nKeyCode = 115
7063:             THIS.AbrirBuscaOperacaoLancamento()
7064:         ENDIF
7065:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
7066:             THIS.ValidarOperacaoLancamento()
7067:         ENDIF
7068:     ENDPROC
7069: 

*-- Linhas 7223 a 7245:
7223:         loc_oPgf = par_oPagina.pgf_4c_PgOperacoes
7224: 
7225:         WITH loc_oPgf
7226:             .Top       = 182
7227:             .Left      = 1
7228:             .Width     = 997
7229:             .Height    = 377
7230:             .PageCount = 2
7231:             .Tabs      = .T.
7232:             .Visible   = .T.
7233: 
7234:             .Page1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
7235:             .Page1.FontName  = "Verdana"
7236:             .Page1.FontSize  = 8
7237:             .Page1.FontBold  = .T.
7238:             .Page1.ForeColor = RGB(36, 84, 155)
7239: 
7240:             .Page2.Caption   = "Itens"
7241:             .Page2.FontName  = "Verdana"
7242:             .Page2.FontSize  = 8
7243:             .Page2.FontBold  = .T.
7244:             .Page2.ForeColor = RGB(36, 84, 155)
7245:         ENDWITH

*-- Linhas 7261 a 7381:
7261:     PROCEDURE PgItensActivate()
7262:         LOCAL loc_oPgf, loc_nNumes
7263: 
7264:         loc_oPgf = THIS.pgf_4c_Paginas.Page4.pgf_4c_PgOperacoes
7265: 
7266:         IF USED("cursor_4c_CabOperas") AND !EOF("cursor_4c_CabOperas") AND USED("cursor_4c_ItnOperas")
7267:             loc_nNumes = cursor_4c_CabOperas.Numes
7268: 
7269:             SELECT cursor_4c_ItnOperas
7270:             SET ORDER TO Ordem
7271:             SET FILTER TO Numes = loc_nNumes
7272:             GO TOP IN cursor_4c_ItnOperas
7273: 
7274:             loc_oPgf.Page2.grd_4c_ItnOperas.Refresh()
7275:             loc_oPgf.Page2.grd_4c_ItnOperas.Column1.SetFocus()
7276:         ENDIF
7277:     ENDPROC
7278: 
7279:     *--------------------------------------------------------------------------
7280:     * ConfigurarGridCabOperas - grdCabOperas (cabecalho das operacoes de
7281:     * pedido, 1 linha por fornecedor -> cursor_4c_CabOperas).
7282:     *--------------------------------------------------------------------------
7283:     PROTECTED PROCEDURE ConfigurarGridCabOperas(par_oPagina)
7284:         LOCAL loc_oGrid
7285: 
7286:         par_oPagina.AddObject("grd_4c_CabOperas", "Grid")
7287:         loc_oGrid = par_oPagina.grd_4c_CabOperas
7288: 
7289:         WITH loc_oGrid
7290:             .ColumnCount   = 9
7291:             .Top           = 6
7292:             .Left          = 9
7293:             .Width         = 975
7294:             .Height        = 339
7295:             .FontName      = "Tahoma"
7296:             .FontSize      = 8
7297:             .HeaderHeight  = 16
7298:             .RowHeight     = 15
7299:             .ScrollBars    = 3
7300:             .DeleteMark    = .F.
7301:             .RecordMark    = .F.
7302:             .ReadOnly      = .T.
7303:             .GridLineColor = RGB(128, 128, 128)
7304:             .Visible       = .T.
7305: 
7306:             .RecordSource          = "cursor_4c_CabOperas"
7307:             .Column1.ControlSource = "cursor_4c_CabOperas.Numes"
7308:             .Column2.ControlSource = "cursor_4c_CabOperas.IFors"
7309:             .Column3.ControlSource = "cursor_4c_CabOperas.Fornecs"
7310:             .Column4.ControlSource = "cursor_4c_CabOperas.FPags"
7311:             .Column5.ControlSource = "cursor_4c_CabOperas.DtEnts"
7312:             .Column6.ControlSource = "cursor_4c_CabOperas.Qtds"
7313:             .Column7.ControlSource = "cursor_4c_CabOperas.Valors"
7314:             .Column8.ControlSource = "cursor_4c_CabOperas.Fretes"
7315:             .Column9.ControlSource = "cursor_4c_CabOperas.VlFretes"
7316:         ENDWITH
7317: 
7318:         WITH loc_oGrid.Column1
7319:             .Alignment         = 3
7320:             .Header1.Caption   = "Ord."
7321:             .Header1.Alignment = 2
7322:             .Header1.FontSize  = 8
7323:         ENDWITH
7324: 
7325:         WITH loc_oGrid.Column2
7326:             .Header1.Caption   = "C" + CHR(243) + "digo"
7327:             .Header1.Alignment = 2
7328:             .Header1.FontSize  = 8
7329:         ENDWITH
7330: 
7331:         WITH loc_oGrid.Column3
7332:             .Header1.Caption   = "Fornecedor"
7333:             .Header1.Alignment = 2
7334:             .Header1.FontSize  = 8
7335:         ENDWITH
7336: 
7337:         WITH loc_oGrid.Column4
7338:             .Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o"
7339:             .Header1.Alignment = 2
7340:             .Header1.FontSize  = 8
7341:         ENDWITH
7342: 
7343:         WITH loc_oGrid.Column5
7344:             .Alignment         = 3
7345:             .Format            = "E"
7346:             .Header1.Caption   = "Entrega"
7347:             .Header1.Alignment = 2
7348:             .Header1.FontSize  = 8
7349:         ENDWITH
7350: 
7351:         WITH loc_oGrid.Column6
7352:             .Alignment         = 3
7353:             .Format            = "999,999.99"
7354:             .Header1.Caption   = "Quantidade"
7355:             .Header1.Alignment = 2
7356:             .Header1.FontSize  = 8
7357:         ENDWITH
7358: 
7359:         WITH loc_oGrid.Column7
7360:             .Alignment         = 3
7361:             .Format            = "999,999.99"
7362:             .Header1.Caption   = "Valor"
7363:             .Header1.Alignment = 2
7364:             .Header1.FontSize  = 8
7365:         ENDWITH
7366: 
7367:         WITH loc_oGrid.Column8
7368:             .Header1.Caption   = "F"
7369:             .Header1.Alignment = 2
7370:             .Header1.FontSize  = 8
7371:         ENDWITH
7372: 
7373:         WITH loc_oGrid.Column9
7374:             .Alignment         = 3
7375:             .Format            = "999,999.99"
7376:             .Header1.Caption   = "Frete"
7377:             .Header1.Alignment = 2
7378:             .Header1.FontSize  = 8
7379:         ENDWITH
7380: 
7381:         loc_oGrid.Column1.Width = 35

*-- Linhas 7392 a 7506:
7392:     ENDPROC
7393: 
7394:     PROCEDURE GridCabOperasAfterRowColChange(par_nColIndex)
7395:         LOCAL loc_nNumes
7396: 
7397:         IF USED("cursor_4c_CabOperas") AND !EOF("cursor_4c_CabOperas") AND USED("cursor_4c_ItnOperas")
7398:             loc_nNumes = cursor_4c_CabOperas.Numes
7399:             SELECT cursor_4c_ItnOperas
7400:             SET ORDER TO Ordem
7401:             SET FILTER TO Numes = loc_nNumes
7402:             GO TOP IN cursor_4c_ItnOperas
7403:         ENDIF
7404:     ENDPROC
7405: 
7406:     *--------------------------------------------------------------------------
7407:     * ConfigurarGridItnOperas - grdItnOperas (itens de UMA operacao de pedido,
7408:     * filtrados pelo Numes corrente de grdCabOperas -> cursor_4c_ItnOperas).
7409:     *--------------------------------------------------------------------------
7410:     PROTECTED PROCEDURE ConfigurarGridItnOperas(par_oPagina)
7411:         LOCAL loc_oGrid
7412: 
7413:         par_oPagina.AddObject("grd_4c_ItnOperas", "Grid")
7414:         loc_oGrid = par_oPagina.grd_4c_ItnOperas
7415: 
7416:         WITH loc_oGrid
7417:             .ColumnCount   = 9
7418:             .Top           = 5
7419:             .Left          = 9
7420:             .Width         = 975
7421:             .Height        = 340
7422:             .FontName      = "Tahoma"
7423:             .FontSize      = 8
7424:             .HeaderHeight  = 16
7425:             .RowHeight     = 15
7426:             .ScrollBars    = 3
7427:             .DeleteMark    = .F.
7428:             .RecordMark    = .F.
7429:             .ReadOnly      = .T.
7430:             .GridLineColor = RGB(128, 128, 128)
7431:             .Visible       = .T.
7432: 
7433:             .RecordSource          = "cursor_4c_ItnOperas"
7434:             .Column1.ControlSource = "cursor_4c_ItnOperas.CItens"
7435:             .Column2.ControlSource = "cursor_4c_ItnOperas.CPros"
7436:             .Column3.ControlSource = "cursor_4c_ItnOperas.DPros"
7437:             .Column4.ControlSource = "cursor_4c_ItnOperas.CUnis"
7438:             .Column5.ControlSource = "cursor_4c_ItnOperas.Qtds"
7439:             .Column6.ControlSource = "cursor_4c_ItnOperas.Units"
7440:             .Column7.ControlSource = "cursor_4c_ItnOperas.Valors"
7441:             .Column8.ControlSource = "cursor_4c_ItnOperas.CodCors"
7442:             .Column9.ControlSource = "cursor_4c_ItnOperas.CodTams"
7443:         ENDWITH
7444: 
7445:         WITH loc_oGrid.Column1
7446:             .Alignment         = 3
7447:             .Header1.Caption   = "Ord."
7448:             .Header1.Alignment = 2
7449:             .Header1.FontSize  = 8
7450:         ENDWITH
7451: 
7452:         WITH loc_oGrid.Column2
7453:             .Header1.Caption   = "C" + CHR(243) + "digo"
7454:             .Header1.Alignment = 2
7455:             .Header1.FontSize  = 8
7456:         ENDWITH
7457: 
7458:         WITH loc_oGrid.Column3
7459:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
7460:             .Header1.Alignment = 2
7461:             .Header1.FontSize  = 8
7462:         ENDWITH
7463: 
7464:         WITH loc_oGrid.Column4
7465:             .Header1.Caption   = "Uni"
7466:             .Header1.Alignment = 2
7467:             .Header1.FontSize  = 8
7468:         ENDWITH
7469: 
7470:         WITH loc_oGrid.Column5
7471:             .Alignment         = 3
7472:             .Format            = "999,999.99"
7473:             .Header1.Caption   = "Quantidade"
7474:             .Header1.Alignment = 2
7475:             .Header1.FontSize  = 8
7476:         ENDWITH
7477: 
7478:         WITH loc_oGrid.Column6
7479:             .Alignment         = 3
7480:             .Format            = "999999.999999"
7481:             .Header1.Caption   = "Unit" + CHR(225) + "rio"
7482:             .Header1.Alignment = 2
7483:             .Header1.FontSize  = 8
7484:         ENDWITH
7485: 
7486:         WITH loc_oGrid.Column7
7487:             .Alignment         = 3
7488:             .Format            = "999,999.99"
7489:             .Header1.Caption   = "Total"
7490:             .Header1.Alignment = 2
7491:             .Header1.FontSize  = 8
7492:         ENDWITH
7493: 
7494:         WITH loc_oGrid.Column8
7495:             .Header1.Caption   = "Cor"
7496:             .Header1.Alignment = 2
7497:             .Header1.FontSize  = 8
7498:         ENDWITH
7499: 
7500:         WITH loc_oGrid.Column9
7501:             .Header1.Caption   = "Tam"
7502:             .Header1.Alignment = 2
7503:             .Header1.FontSize  = 8
7504:         ENDWITH
7505: 
7506:         loc_oGrid.Column1.Width = 40

*-- Linhas 7594 a 7602:
7594:     *--------------------------------------------------------------------------
7595:     * ConfigurarGridOperacoes - Grade de Movimentacoes em aberto (grdOperacoes
7596:     * do legado, ligada a crOperacoes). A Column1 eh a coluna de MARCACAO:
7597:     * exige AddObject + CurrentControl + Sparse = .F., senao o CheckBox nunca
7598:     * aparece (a coluna continua desenhando o Text1 dela) - e Column.ReadOnly
7599:     * tem de vir DEPOIS de Grid.ReadOnly, que propaga para as colunas.
7600:     *
7601:     * Column.Width por ULTIMO: mexer em RecordSource/ControlSource faz o VFP
7602:     * recalcular todas as larguras para o default.

*-- Linhas 7609 a 7697:
7609: 
7610:         WITH loc_oGrid
7611:             .ColumnCount       = 6
7612:             .Top               = 25
7613:             .Left              = 250
7614:             .Width             = 407
7615:             .Height            = 244
7616:             .FontName          = "Tahoma"
7617:             .FontSize          = 8
7618:             .RowHeight         = 16
7619:             .ScrollBars        = 2
7620:             .DeleteMark        = .F.
7621:             .RecordMark        = .F.
7622:             .AllowHeaderSizing = .F.
7623:             .AllowRowSizing    = .F.
7624:             .ReadOnly          = .F.
7625:             .GridLineColor     = RGB(128, 128, 128)
7626:             .Visible           = .T.
7627: 
7628:             .RecordSource          = "cursor_4c_Movimentacao"
7629:             .Column1.ControlSource = "cursor_4c_Movimentacao.Marcas"
7630:             .Column2.ControlSource = "cursor_4c_Movimentacao.Datas"
7631:             .Column3.ControlSource = "cursor_4c_Movimentacao.Emps"
7632:             .Column4.ControlSource = "cursor_4c_Movimentacao.Dopes"
7633:             .Column5.ControlSource = "cursor_4c_Movimentacao.Numes"
7634:             .Column6.ControlSource = "cursor_4c_Movimentacao.Itens"
7635:         ENDWITH
7636: 
7637:         IF !PEMSTATUS(loc_oGrid.Column1, "chk_4c_Marcas", 5)
7638:             loc_oGrid.Column1.AddObject("chk_4c_Marcas", "CheckBox")
7639:         ENDIF
7640: 
7641:         WITH loc_oGrid.Column1.chk_4c_Marcas
7642:             .Top       = 9
7643:             .Left      = 2
7644:             .Height    = 17
7645:             .Width     = 22
7646:             .FontName  = "Arial"
7647:             .FontSize  = 8
7648:             .Alignment = 0
7649:             .Caption   = ""
7650:             .BackStyle = 0
7651:             .ReadOnly  = .F.
7652:             .Visible   = .T.
7653:         ENDWITH
7654: 
7655:         WITH loc_oGrid.Column1
7656:             .CurrentControl   = "chk_4c_Marcas"
7657:             .Sparse           = .F.
7658:             .ReadOnly         = .F.
7659:             .Movable          = .F.
7660:             .Resizable        = .F.
7661:             .FontSize         = 8
7662:             .Header1.Caption  = ""
7663:             .Header1.FontSize = 8
7664:         ENDWITH
7665: 
7666:         WITH loc_oGrid.Column2
7667:             .FontSize          = 8
7668:             .ReadOnly          = .T.
7669:             .Header1.Caption   = "Data"
7670:             .Header1.Alignment = 2
7671:             .Header1.FontSize  = 8
7672:             .Text1.FontName    = "Arial"
7673:             .Text1.FontSize    = 8
7674:             .Text1.BorderStyle = 1
7675:             .Text1.Margin      = 0
7676:             .Text1.ForeColor   = RGB(0, 0, 0)
7677:         ENDWITH
7678: 
7679:         WITH loc_oGrid.Column3
7680:             .FontSize          = 8
7681:             .ReadOnly          = .T.
7682:             .Header1.Caption   = "Emp"
7683:             .Header1.Alignment = 2
7684:             .Header1.FontSize  = 8
7685:             .Text1.FontSize    = 8
7686:             .Text1.Margin      = 0
7687:         ENDWITH
7688: 
7689:         WITH loc_oGrid.Column4
7690:             .FontSize          = 8
7691:             .ReadOnly          = .T.
7692:             .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
7693:             .Header1.Alignment = 2
7694:             .Header1.FontSize  = 8
7695:             .Text1.FontSize    = 8
7696:             .Text1.BorderStyle = 0
7697:             .Text1.Margin      = 0

*-- Linhas 7704 a 7724:
7704:             .ReadOnly          = .T.
7705:             .Format            = "999999"
7706:             .InputMask         = "999999"
7707:             .Header1.Caption   = "C" + CHR(243) + "digo"
7708:             .Header1.Alignment = 2
7709:             .Header1.FontSize  = 8
7710:             .Text1.FontSize    = 8
7711:             .Text1.Margin      = 0
7712:         ENDWITH
7713: 
7714:         WITH loc_oGrid.Column6
7715:             .FontSize          = 8
7716:             .ReadOnly          = .T.
7717:             .Format            = "999999"
7718:             .InputMask         = "999999"
7719:             .Header1.Caption   = "Itens"
7720:             .Header1.Alignment = 2
7721:             .Header1.FontSize  = 8
7722:             .Text1.FontSize    = 8
7723:             .Text1.Margin      = 0
7724:         ENDWITH

*-- Linhas 7731 a 7739:
7731:         loc_oGrid.Column5.Width = 56
7732:         loc_oGrid.Column6.Width = 56
7733: 
7734:         *-- O CheckBox de grid NAO alterna pelo binding nativo: o legado
7735:         *-- suprime o toggle padrao (NoDefault) e inverte Marcas por codigo,
7736:         *-- para poder validar a regra de Job.
7737:         BINDEVENT(loc_oGrid.Column1.chk_4c_Marcas, "Click",     THIS, "ChkMarcasClick")
7738:         BINDEVENT(loc_oGrid.Column1.chk_4c_Marcas, "MouseDown", THIS, "ChkMarcasMouseDown")
7739:         BINDEVENT(loc_oGrid.Column1.chk_4c_Marcas, "MouseUp",   THIS, "ChkMarcasMouseUp")

*-- Linhas 7753 a 7791:
7753: 
7754:         WITH loc_oGrid
7755:             .ColumnCount   = 6
7756:             .Top           = 311
7757:             .Left          = 250
7758:             .Width         = 407
7759:             .Height        = 244
7760:             .FontName      = "Tahoma"
7761:             .FontSize      = 8
7762:             .RowHeight     = 16
7763:             .ScrollBars    = 2
7764:             .DeleteMark    = .F.
7765:             .RecordMark    = .F.
7766:             .ReadOnly      = .T.
7767:             .GridLineColor = RGB(128, 128, 128)
7768:             .Visible       = .T.
7769: 
7770:             .RecordSource          = "cursor_4c_CotasPendentes"
7771:             .Column1.ControlSource = "cursor_4c_CotasPendentes.Codigos"
7772:             .Column2.ControlSource = "cursor_4c_CotasPendentes.DtSolics"
7773:             .Column3.ControlSource = "cursor_4c_CotasPendentes.Solicitas"
7774:             .Column4.ControlSource = "cursor_4c_CotasPendentes.Deptos"
7775:             .Column5.ControlSource = "cursor_4c_CotasPendentes.Prioris"
7776:             .Column6.ControlSource = "cursor_4c_CotasPendentes.DtCotas"
7777:         ENDWITH
7778: 
7779:         WITH loc_oGrid.Column1
7780:             .FontSize          = 8
7781:             .FontBold          = .T.
7782:             .Alignment         = 3
7783:             .Movable           = .F.
7784:             .Resizable         = .F.
7785:             .Sparse            = .F.
7786:             .Header1.Caption   = "C" + CHR(243) + "digo"
7787:             .Header1.Alignment = 2
7788:             .Header1.FontSize  = 8
7789:             .Text1.FontBold    = .T.
7790:             .Text1.FontSize    = 8
7791:             .Text1.Alignment   = 3

*-- Linhas 7800 a 7808:
7800:             .FontBold          = .T.
7801:             .Movable           = .F.
7802:             .Resizable         = .F.
7803:             .Header1.Caption   = "Solicita" + CHR(231) + CHR(227) + "o"
7804:             .Header1.Alignment = 2
7805:             .Header1.FontSize  = 8
7806:             .Text1.FontBold    = .T.
7807:             .Text1.FontSize    = 8
7808:             .Text1.BorderStyle = 0

*-- Linhas 7815 a 7867:
7815:             .FontSize          = 8
7816:             .Movable           = .F.
7817:             .Resizable         = .F.
7818:             .Header1.Caption   = "Solicitante"
7819:             .Header1.Alignment = 2
7820:             .Header1.FontSize  = 8
7821:             .Text1.FontSize    = 8
7822:             .Text1.Margin      = 0
7823:         ENDWITH
7824: 
7825:         WITH loc_oGrid.Column4
7826:             .FontSize          = 8
7827:             .Movable           = .F.
7828:             .Resizable         = .F.
7829:             .Header1.Caption   = "Departamento"
7830:             .Header1.Alignment = 2
7831:             .Header1.FontSize  = 8
7832:             .Text1.FontSize    = 8
7833:             .Text1.Margin      = 0
7834:         ENDWITH
7835: 
7836:         *-- Cor da prioridade: Alta = vermelho, Media = laranja,
7837:         *-- Ped.Gerado = azul, Normal = preto (DynamicForeColor do SCX)
7838:         loc_cCorPrioridade = ;
7839:             "IIF(cursor_4c_CotasPendentes.Prioris = [Alta], RGB(185,0,0), " + ;
7840:             "IIF(cursor_4c_CotasPendentes.Prioris = [M" + CHR(233) + "dia], RGB(255,128,64), " + ;
7841:             "IIF(cursor_4c_CotasPendentes.Prioris = [Ped.Gerado], RGB(0,0,255), RGB(0,0,0))))"
7842: 
7843:         WITH loc_oGrid.Column5
7844:             .FontSize          = 8
7845:             .FontBold          = .T.
7846:             .Movable           = .F.
7847:             .Resizable         = .F.
7848:             .DynamicForeColor  = loc_cCorPrioridade
7849:             .Header1.Caption   = "Prioridade"
7850:             .Header1.Alignment = 2
7851:             .Header1.FontSize  = 8
7852:             .Text1.FontBold    = .T.
7853:             .Text1.FontSize    = 8
7854:             .Text1.Margin      = 0
7855:         ENDWITH
7856: 
7857:         WITH loc_oGrid.Column6
7858:             .FontSize          = 8
7859:             .Alignment         = 3
7860:             .Movable           = .F.
7861:             .Resizable         = .F.
7862:             .Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
7863:             .Header1.Alignment = 2
7864:             .Header1.FontSize  = 8
7865:             .Text1.FontSize    = 8
7866:             .Text1.Alignment   = 3
7867:             .Text1.Margin      = 0

*-- Linhas 7915 a 7936:
7915:                 IF VARTYPE(loc_oProgresso) = "O"
7916:                     loc_oProgresso.Show()
7917:                     loc_oProgresso.Update("Montando Telas", .T.)
7918:                 ENDIF
7919: 
7920:                 ZAP IN cursor_4c_Movimentacao
7921:                 ZAP IN cursor_4c_CotasPendentes
7922: 
7923:                 loc_cDtI = FormatarDataSQL(THIS.this_dDtPerI)
7924:                 loc_cDtF = FormatarDataSQL(DTOT(THIS.this_dDtPerF) + 86399)
7925: 
7926:                 *-- Filtro de operacao/empresa transcrito do legado: com a
7927:                 *-- empresa informada ele troca Dopes por uma faixa de
7928:                 *-- EmpDopNums (Emps + Dopes + Numes de 0 a 999999).
7929:                 IF EMPTY(THIS.this_cEmps)
7930:                     loc_cFiltro = "a.Dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20))
7931:                 ELSE
7932:                     loc_cEd1 = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(0, 6)
7933:                     loc_cEd2 = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(999999, 6)
7934:                     loc_cFiltro = "a.EmpDopNums BETWEEN " + EscaparSQL(loc_cEd1) + ;
7935:                                   " AND " + EscaparSQL(loc_cEd2)
7936:                 ENDIF

*-- Linhas 8019 a 8073:
8019:                 SCAN
8020:                     loc_dData = ConverterParaData(NVL(cursor_4c_MovTemp.Datas, {}))
8021:                     loc_cEdn  = cursor_4c_MovTemp.Emps + cursor_4c_MovTemp.Dopes + ;
8022:                                 STR(cursor_4c_MovTemp.Numes, 6)
8023: 
8024:                     IF !SEEK(DTOS(loc_dData) + loc_cEdn, "cursor_4c_Movimentacao", "Ordem")
8025:                         INSERT INTO cursor_4c_Movimentacao ;
8026:                             (Emps, Dopes, Numes, Datas, EmpDopNums, Nops, ChkSubn, ;
8027:                              LCancelas, ChkBxParcs, ChkPagos, ProcBals, ProcDBal, ;
8028:                              Destinos, EstDests, EstOrigs, Origems, Produc, Jobs) ;
8029:                             VALUES ;
8030:                             (cursor_4c_MovTemp.Emps, cursor_4c_MovTemp.Dopes, ;
8031:                              cursor_4c_MovTemp.Numes, loc_dData, loc_cEdn, ;
8032:                              NVL(cursor_4c_MovTemp.Nops, 0), ;
8033:                              ConverterParaLogico(cursor_4c_MovTemp.ChkSubn), ;
8034:                              ConverterParaLogico(cursor_4c_MovTemp.LCancelas), ;
8035:                              ConverterParaLogico(cursor_4c_MovTemp.ChkBxParcs), ;
8036:                              ConverterParaLogico(cursor_4c_MovTemp.ChkPagos), ;
8037:                              ConverterParaLogico(cursor_4c_MovTemp.ProcBals), ;
8038:                              ConverterParaLogico(cursor_4c_MovTemp.ProcDBal), ;
8039:                              NVL(cursor_4c_MovTemp.Destinos, 0), ;
8040:                              NVL(cursor_4c_MovTemp.EstDests, 0), ;
8041:                              NVL(cursor_4c_MovTemp.EstOrigs, 0), ;
8042:                              NVL(cursor_4c_MovTemp.Origems, 0), ;
8043:                              NVL(cursor_4c_MovTemp.Produc, 0), ;
8044:                              NVL(cursor_4c_MovTemp.Jobs, ""))
8045:                     ENDIF
8046: 
8047:                     REPLACE Itens WITH Itens + NVL(cursor_4c_MovTemp.Qtds, 0) ;
8048:                         IN cursor_4c_Movimentacao
8049: 
8050:                     SELECT cursor_4c_MovTemp
8051:                 ENDSCAN
8052: 
8053:                 IF USED("cursor_4c_MovTemp")
8054:                     USE IN cursor_4c_MovTemp
8055:                 ENDIF
8056: 
8057:                 SELECT cursor_4c_Movimentacao
8058:                 GO TOP IN cursor_4c_Movimentacao
8059: 
8060:                 THIS.AplicarCoresGridOperacoes()
8061: 
8062:                 IF VARTYPE(loc_oProgresso) = "O"
8063:                     loc_oProgresso.Update("Carregando as Cota" + CHR(231) + CHR(245) + ;
8064:                         "es Pendentes", .T.)
8065:                 ENDIF
8066: 
8067:                 *-- Cotacoes ja realizadas: as que estao em aberto (Situas = 0)
8068:                 *-- mais as que geraram pedido dentro do periodo filtrado
8069:                 loc_cSQL = "SELECT a.Situas, a.Codigos, a.DtSolics, a.Solicitas, " + ;
8070:                            "a.Deptos, a.Prioris, a.DtCotas, a.DtAprovs, a.Aprovador, " + ;
8071:                            "a.ContaEs, a.LocalEnts, a.Justificas, a.Copias " + ;
8072:                            "FROM SigCtTDc a " + ;
8073:                            "WHERE a.Situas = 0 OR " + ;

*-- Linhas 8102 a 8122:
8102:                             OTHERWISE
8103:                                 loc_cPrioridade = "Normal"
8104:                         ENDCASE
8105:                     ENDIF
8106: 
8107:                     INSERT INTO cursor_4c_CotasPendentes ;
8108:                         (Situas, Codigos, DtSolics, Solicitas, Deptos, Prioris, ;
8109:                          DtCotas, DtAprovs, Aprovador, ContaEs, LocalEnts, ;
8110:                          Justificas, Copias) ;
8111:                         VALUES ;
8112:                         (NVL(cursor_4c_CotDcTemp.Situas, 0), ;
8113:                          NVL(cursor_4c_CotDcTemp.Codigos, 0), ;
8114:                          ConverterParaData(NVL(cursor_4c_CotDcTemp.DtSolics, {})), ;
8115:                          NVL(cursor_4c_CotDcTemp.Solicitas, ""), ;
8116:                          NVL(cursor_4c_CotDcTemp.Deptos, ""), ;
8117:                          loc_cPrioridade, ;
8118:                          ConverterParaData(NVL(cursor_4c_CotDcTemp.DtCotas, {})), ;
8119:                          ConverterParaData(NVL(cursor_4c_CotDcTemp.DtAprovs, {})), ;
8120:                          NVL(cursor_4c_CotDcTemp.Aprovador, ""), ;
8121:                          NVL(cursor_4c_CotDcTemp.ContaEs, ""), ;
8122:                          NVL(cursor_4c_CotDcTemp.LocalEnts, 0), ;

*-- Linhas 8133 a 8164:
8133:                 IF VARTYPE(loc_oProgresso) = "O"
8134:                     loc_oProgresso.Complete(.T.)
8135:                     loc_oProgresso = .NULL.
8136:                 ENDIF
8137: 
8138:                 IF RECCOUNT("cursor_4c_Movimentacao") < 1 AND ;
8139:                    RECCOUNT("cursor_4c_CotasPendentes") < 1
8140:                     MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Processar!!!", ;
8141:                         "Aten" + CHR(231) + CHR(227) + "o!!!")
8142:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DtPerI.SetFocus()
8143:                 ELSE
8144:                     *-- Popular o cursor NAO repinta a grade: GO TOP + Refresh
8145:                     SELECT cursor_4c_CotasPendentes
8146:                     GO TOP IN cursor_4c_CotasPendentes
8147: 
8148:                     SELECT cursor_4c_Movimentacao
8149:                     GO TOP IN cursor_4c_Movimentacao
8150: 
8151:                     loc_oPag.obj_4c_CmdProblemas.Visible = THIS.PossuiAcessoCotacaoLivre()
8152: 
8153:                     loc_oPag.grd_4c_Operacoes.Refresh()
8154:                     loc_oPag.grd_4c_CotaPends.Refresh()
8155: 
8156:                     THIS.AjustarBotoesPorModo()
8157: 
8158:                     loc_lSucesso = .T.
8159:                 ENDIF
8160:             ENDIF
8161:         CATCH TO loc_oErro
8162:             MsgErro(loc_oErro.Message + CHR(13) + ;
8163:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
8164:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")

*-- Linhas 8223 a 8314:
8223:         LOCAL loc_oGrid
8224: 
8225:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes
8226: 
8227:         IF THIS.this_nGesind = 1
8228:             IF cursor_4c_Movimentacao.Produc <> 1
8229:                 loc_oGrid.SetAll("DynamicForeColor", ;
8230:                     "IIF(cursor_4c_Movimentacao.LCancelas, RGB(255,0,0), " + ;
8231:                     "IIF(cursor_4c_Movimentacao.ChkSubn, RGB(0,0,255), RGB(0,0,0)))", ;
8232:                     "Column")
8233: 
8234:                 IF (cursor_4c_Movimentacao.Origems = 1 AND ;
8235:                     INLIST(cursor_4c_Movimentacao.EstOrigs, 1, 2, 4)) OR ;
8236:                    (cursor_4c_Movimentacao.Destinos = 1 AND ;
8237:                     INLIST(cursor_4c_Movimentacao.EstDests, 1, 2, 4))
8238: 
8239:                     loc_oGrid.SetAll("DynamicBackColor", ;
8240:                         "IIF(cursor_4c_Movimentacao.ProcBals AND " + ;
8241:                         "cursor_4c_Movimentacao.ProcDBal, RGB(220,255,220), " + ;
8242:                         "IIF(cursor_4c_Movimentacao.ProcBals, RGB(255,209,164), " + ;
8243:                         "IIF(cursor_4c_Movimentacao.ProcDBal, RGB(255,255,196), " + ;
8244:                         "IIF(cursor_4c_Movimentacao.ChkPagos, RGB(160,243,231), " + ;
8245:                         "RGB(255,255,255)))))", "Column")
8246:                 ENDIF
8247:             ELSE
8248:                 loc_oGrid.SetAll("DynamicForeColor", ;
8249:                     "IIF(cursor_4c_Movimentacao.ChkSubn, RGB(0,0,225), " + ;
8250:                     "IIF(cursor_4c_Movimentacao.ChkBxParcs, RGB(255,0,255), " + ;
8251:                     "IIF(cursor_4c_Movimentacao.Nops > 0, RGB(255,0,0), RGB(0,0,0))))", ;
8252:                     "Column")
8253: 
8254:                 loc_oGrid.SetAll("DynamicBackColor", ;
8255:                     "IIF(cursor_4c_Movimentacao.Nops > 0 AND " + ;
8256:                     "(cursor_4c_Movimentacao.ChkSubn OR " + ;
8257:                     "cursor_4c_Movimentacao.ChkBxParcs), RGB(249,249,0), " + ;
8258:                     "RGB(255,255,255))", "Column")
8259:             ENDIF
8260:         ELSE
8261:             loc_oGrid.SetAll("DynamicBackColor", ;
8262:                 "IIF(cursor_4c_Movimentacao.ChkPagos, RGB(160,243,231), " + ;
8263:                 "RGB(255,255,255))", "Column")
8264: 
8265:             loc_oGrid.SetAll("DynamicForeColor", ;
8266:                 "IIF(cursor_4c_Movimentacao.LCancelas, RGB(255,0,0), " + ;
8267:                 "IIF(cursor_4c_Movimentacao.ChkSubn, RGB(0,0,255), " + ;
8268:                 "IIF(cursor_4c_Movimentacao.ChkBxParcs, RGB(255,0,255), " + ;
8269:                 "RGB(0,0,0))))", "Column")
8270:         ENDIF
8271:     ENDPROC
8272: 
8273:     *--------------------------------------------------------------------------
8274:     * AjustarBotoesPorModo - Habilita/desabilita os botoes de acao sobre a
8275:     * cotacao corrente. Transcreve as regras do legado, presentes tanto no fim
8276:     * do processamento quanto no AfterRowColChange da grade:
8277:     *
8278:     *   Alterar/Excluir -> so com a cotacao ainda em aberto (Situas = 0)
8279:     *   Copiar          -> so com aprovacao final E do solicitante, e desde
8280:     *                      que a cotacao ainda nao tenha sido copiada
8281:     *--------------------------------------------------------------------------
8282:     PROCEDURE AjustarBotoesPorModo()
8283:         LOCAL loc_oPag, loc_lTemLinha, loc_lEmAberto, loc_lPodeCopiar
8284: 
8285:         loc_oPag = THIS.pgf_4c_Paginas.Page2
8286: 
8287:         loc_lTemLinha = USED("cursor_4c_CotasPendentes") AND ;
8288:                         RECCOUNT("cursor_4c_CotasPendentes") > 0 AND ;
8289:                         !EOF("cursor_4c_CotasPendentes")
8290: 
8291:         IF loc_lTemLinha
8292:             THIS.this_nCodigoSelecionado = cursor_4c_CotasPendentes.Codigos
8293:             loc_lEmAberto = (cursor_4c_CotasPendentes.Situas = 0)
8294: 
8295:             loc_lPodeCopiar = !EMPTY(cursor_4c_CotasPendentes.DtAprovs) AND ;
8296:                               !EMPTY(cursor_4c_CotasPendentes.Aprovador) AND ;
8297:                               !EMPTY(cursor_4c_CotasPendentes.DtSolics) AND ;
8298:                               !EMPTY(cursor_4c_CotasPendentes.Solicitas) AND ;
8299:                               EMPTY(cursor_4c_CotasPendentes.Copias)
8300:         ELSE
8301:             THIS.this_nCodigoSelecionado = 0
8302:             loc_lEmAberto   = .F.
8303:             loc_lPodeCopiar = .F.
8304:         ENDIF
8305: 
8306:         loc_oPag.obj_4c_CmdCotacoes.Buttons(1).Enabled = loc_lEmAberto
8307:         loc_oPag.obj_4c_CmdCotacoes.Buttons(2).Enabled = loc_lEmAberto
8308: 
8309:         IF loc_oPag.obj_4c_CmdCopiar.Visible
8310:             loc_oPag.obj_4c_CmdCopiar.Buttons(1).Enabled = loc_lPodeCopiar
8311:         ENDIF
8312:     ENDPROC
8313: 
8314:     *--------------------------------------------------------------------------

*-- Linhas 8321 a 8331:
8321: 
8322:     *--------------------------------------------------------------------------
8323:     * ChkMarcas* - Coluna de marcacao da grade de Movimentacoes. O legado
8324:     * SUPRIME o toggle nativo do CheckBox (NoDefault em Click/MouseDown/
8325:     * MouseUp) e inverte crOperacoes.Marcas por codigo, para poder validar a
8326:     * regra de Job. Sem os quatro handlers o CheckBox nao alterna.
8327:     *--------------------------------------------------------------------------
8328:     PROCEDURE ChkMarcasClick()
8329:         NODEFAULT
8330:     ENDPROC
8331: 

*-- Linhas 8351 a 8419:
8351:     * movimentacoes de JOBS DIFERENTES - nesse caso a marcacao eh desfeita.
8352:     *--------------------------------------------------------------------------
8353:     PROTECTED PROCEDURE AlternarMarcacaoOperacao()
8354:         LOCAL loc_oGrid, loc_cJob
8355: 
8356:         IF !USED("cursor_4c_Movimentacao") OR EOF("cursor_4c_Movimentacao")
8357:             RETURN
8358:         ENDIF
8359: 
8360:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes
8361: 
8362:         REPLACE Marcas WITH !Marcas IN cursor_4c_Movimentacao
8363:         loc_oGrid.Refresh()
8364: 
8365:         IF cursor_4c_Movimentacao.Marcas AND !EMPTY(cursor_4c_Movimentacao.Jobs)
8366:             loc_cJob = cursor_4c_Movimentacao.Jobs
8367: 
8368:             SELECT EmpDopNums ;
8369:               FROM cursor_4c_Movimentacao ;
8370:              WHERE Marcas AND Jobs <> m.loc_cJob ;
8371:               INTO CURSOR cursor_4c_MarcaJob
8372: 
8373:             IF !EOF("cursor_4c_MarcaJob")
8374:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " permitido marcar " + ;
8375:                     "movimenta" + CHR(231) + CHR(227) + "o de jobs diferentes.", "Aviso")
8376:                 REPLACE Marcas WITH !Marcas IN cursor_4c_Movimentacao
8377:                 loc_oGrid.Refresh()
8378:             ENDIF
8379: 
8380:             IF USED("cursor_4c_MarcaJob")
8381:                 USE IN cursor_4c_MarcaJob
8382:             ENDIF
8383: 
8384:             SELECT cursor_4c_Movimentacao
8385:         ENDIF
8386:     ENDPROC
8387: 
8388:     *--------------------------------------------------------------------------
8389:     * BtnMarcarTodasClick / BtnDesmarcarTodasClick - Marcam ou desmarcam todas
8390:     * as movimentacoes (cmdMarcaDesmarca.Click do legado:
8391:     * Update crOperacoes Set Marcas = (This.Value = 1)).
8392:     *--------------------------------------------------------------------------
8393:     PROCEDURE BtnMarcarTodasClick()
8394:         IF USED("cursor_4c_Movimentacao")
8395:             UPDATE cursor_4c_Movimentacao SET Marcas = .T.
8396:             GO TOP IN cursor_4c_Movimentacao
8397:             THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Refresh()
8398:         ENDIF
8399:     ENDPROC
8400: 
8401:     PROCEDURE BtnDesmarcarTodasClick()
8402:         IF USED("cursor_4c_Movimentacao")
8403:             UPDATE cursor_4c_Movimentacao SET Marcas = .F.
8404:             GO TOP IN cursor_4c_Movimentacao
8405:             THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Refresh()
8406:         ENDIF
8407:     ENDPROC
8408: 
8409:     *--------------------------------------------------------------------------
8410:     * BtnRetornarFiltrosClick - cmdBotoes.btnSair.Click da pagina Dados:
8411:     * volta para a pagina de Filtros com o foco na data inicial.
8412:     *--------------------------------------------------------------------------
8413:     PROCEDURE BtnRetornarFiltrosClick()
8414:         THIS.this_cModoAtual = "FILTROS"
8415:         THIS.AlternarPagina(1)
8416:         THIS.pgf_4c_Paginas.Page1.txt_4c_DtPerI.SetFocus()
8417:     ENDPROC
8418: 
8419:     *--------------------------------------------------------------------------

*-- Linhas 8487 a 8528:
8487: 
8488:         loc_lSucesso    = .F.
8489:         loc_lProsseguir = .T.
8490: 
8491:         IF par_lDaGrade
8492:             IF !USED("cursor_4c_Movimentacao")
8493:                 loc_lProsseguir = .F.
8494:             ENDIF
8495: 
8496:             IF loc_lProsseguir
8497:                 SELECT EmpDopNums, Jobs ;
8498:                   FROM cursor_4c_Movimentacao ;
8499:                  WHERE Marcas ;
8500:                   INTO CURSOR cursor_4c_CotarProds
8501: 
8502:                 GO TOP IN cursor_4c_CotarProds
8503: 
8504:                 IF EOF("cursor_4c_CotarProds")
8505:                     MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada " + ;
8506:                         "Para Gerar Cota" + CHR(231) + CHR(245) + "es!!!", ;
8507:                         "Aten" + CHR(231) + CHR(227) + "o!!!")
8508:                     loc_lProsseguir = .F.
8509:                 ELSE
8510:                     THIS.this_cJobs = ALLTRIM(cursor_4c_CotarProds.Jobs)
8511:                 ENDIF
8512: 
8513:                 SELECT cursor_4c_Movimentacao
8514:             ENDIF
8515:         ENDIF
8516: 
8517:         IF loc_lProsseguir
8518:             THIS.this_nCodigoSelecionado = 0
8519:             THIS.this_oBusinessObject.NovoRegistro()
8520:             THIS.PreencherPadroesNovaCotacao(par_lDaGrade)
8521:             THIS.PopularCamposCotacaoNoFormulario()
8522:             THIS.ZerarCursoresCotacao()
8523: 
8524:             THIS.this_cModoAtual = "COTACOES"
8525:             THIS.AlternarPagina(3)
8526:             THIS.AjustarCamposCotacao()
8527: 
8528:             loc_lSucesso = .T.

*-- Linhas 8544 a 8565:
8544:         IF VARTYPE(loc_oBO) != "O"
8545:             RETURN
8546:         ENDIF
8547: 
8548:         loc_dDtSolic = DATE()
8549:         IF par_lDaGrade AND USED("cursor_4c_Movimentacao") AND !EOF("cursor_4c_Movimentacao")
8550:             loc_dDtSolic = ConverterParaData(cursor_4c_Movimentacao.Datas)
8551:         ENDIF
8552: 
8553:         loc_nDias = 0
8554:         IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) AND !EMPTY(THIS.this_cDopes)
8555:             IF SQLEXEC(gnConnHandle, "SELECT NDdVals FROM SigOpCdc WHERE Dopes = " + ;
8556:                 EscaparSQL(PADR(THIS.this_cDopes, 20)), "cursor_4c_NDdValsTmp") > 0 AND ;
8557:                USED("cursor_4c_NDdValsTmp") AND !EOF("cursor_4c_NDdValsTmp")
8558:                 loc_nDias = NVL(cursor_4c_NDdValsTmp.NDdVals, 0)
8559:             ENDIF
8560:             IF USED("cursor_4c_NDdValsTmp")
8561:                 USE IN cursor_4c_NDdValsTmp
8562:             ENDIF
8563:         ENDIF
8564: 
8565:         loc_oBO.this_cSolicitas  = gc_4c_UsuarioLogado

*-- Linhas 8593 a 8712:
8593:     * crSigCtTCt do PROCEDURE geracotacao legado (Reccount = 0 -> ramo Else).
8594:     *--------------------------------------------------------------------------
8595:     PROTECTED PROCEDURE ZerarCursoresCotacao()
8596:         LOCAL loc_nI
8597: 
8598:         IF !USED("cursor_4c_Produtos")
8599:             THIS.CriarCursoresCotacao()
8600:         ENDIF
8601: 
8602:         ZAP IN cursor_4c_Produtos
8603:         ZAP IN cursor_4c_Fornecedores
8604: 
8605:         INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
8606:             VALUES (LEFT(fUniqueIds(), 20), 0, 1, "", "", "", 0, "", 0)
8607: 
8608:         FOR loc_nI = 1 TO 6
8609:             INSERT INTO cursor_4c_Fornecedores (cIdChaves, Codigos, Grades, Fretes) ;
8610:                 VALUES (LEFT(fUniqueIds(), 20), 0, CHR(64 + loc_nI), "Emitente")
8611:         ENDFOR
8612: 
8613:         GO TOP IN cursor_4c_Produtos
8614:         GO TOP IN cursor_4c_Fornecedores
8615: 
8616:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5) AND PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "grd_4c_Produtos", 5)
8617:             THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
8618:             THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores.Refresh()
8619:             THIS.GridCotacoesAfterRowColChange(1)
8620:         ENDIF
8621:     ENDPROC
8622: 
8623:     *--------------------------------------------------------------------------
8624:     * AlteraCotacao - Leva para a pagina de Cotacoes a cotacao SELECIONADA na
8625:     * grade de Cotacoes Realizadas, nos modos ALTERAR / EXCLUIR / CONSULTAR.
8626:     * Transcreve a guarda do legado (grade vazia ou Codigos < 1 avisa e devolve
8627:     * o foco para a grade) e carrega o cabecalho (SigCtTDc) no BO.
8628:     *--------------------------------------------------------------------------
8629:     PROCEDURE AlteraCotacao()
8630:         LOCAL loc_lSucesso, loc_lProsseguir
8631: 
8632:         loc_lSucesso    = .F.
8633:         loc_lProsseguir = .T.
8634: 
8635:         IF !USED("cursor_4c_CotasPendentes") OR EOF("cursor_4c_CotasPendentes") OR ;
8636:            cursor_4c_CotasPendentes.Codigos < 1
8637:             MsgAviso("Nenhuma Cota" + CHR(231) + CHR(227) + "o Foi Selecionada na Grade!!!", ;
8638:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
8639:             THIS.pgf_4c_Paginas.Page2.grd_4c_CotaPends.SetFocus()
8640:             loc_lProsseguir = .F.
8641:         ENDIF
8642: 
8643:         IF loc_lProsseguir
8644:             THIS.this_nCodigoSelecionado = cursor_4c_CotasPendentes.Codigos
8645: 
8646:             IF THIS.CarregarCotacaoSelecionada(THIS.this_nCodigoSelecionado)
8647:                 THIS.this_cModoAtual = "COTACOES"
8648:                 THIS.AlternarPagina(3)
8649:                 loc_lSucesso = .T.
8650:             ENDIF
8651:         ENDIF
8652: 
8653:         RETURN loc_lSucesso
8654:     ENDPROC
8655: 
8656:     *--------------------------------------------------------------------------
8657:     * CopiaCotacao - Leva para a pagina de Cotacoes uma copia da cotacao
8658:     * selecionada. O legado so libera o botao quando a cotacao ja tem aprovacao
8659:     * final e do solicitante e ainda nao foi copiada (ver AjustarBotoesPorModo);
8660:     * a mesma condicao eh revalidada aqui, porque o botao pode ser acionado por
8661:     * teclado antes de o AfterRowColChange atualizar o estado.
8662:     *--------------------------------------------------------------------------
8663:     PROCEDURE CopiaCotacao()
8664:         LOCAL loc_lSucesso, loc_lProsseguir
8665: 
8666:         loc_lSucesso    = .F.
8667:         loc_lProsseguir = .T.
8668: 
8669:         IF !USED("cursor_4c_CotasPendentes") OR EOF("cursor_4c_CotasPendentes") OR ;
8670:            cursor_4c_CotasPendentes.Codigos < 1
8671:             MsgAviso("Nenhuma Cota" + CHR(231) + CHR(227) + "o Foi Selecionada na Grade!!!", ;
8672:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
8673:             THIS.pgf_4c_Paginas.Page2.grd_4c_CotaPends.SetFocus()
8674:             loc_lProsseguir = .F.
8675:         ENDIF
8676: 
8677:         IF loc_lProsseguir
8678:             IF !EMPTY(cursor_4c_CotasPendentes.Copias)
8679:                 MsgAviso("Esta Cota" + CHR(231) + CHR(227) + "o J" + CHR(225) + ;
8680:                     " Foi Copiada!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
8681:                 loc_lProsseguir = .F.
8682:             ENDIF
8683:         ENDIF
8684: 
8685:         IF loc_lProsseguir
8686:             IF EMPTY(cursor_4c_CotasPendentes.DtAprovs) OR ;
8687:                EMPTY(cursor_4c_CotasPendentes.Aprovador) OR ;
8688:                EMPTY(cursor_4c_CotasPendentes.DtSolics) OR ;
8689:                EMPTY(cursor_4c_CotasPendentes.Solicitas)
8690:                 MsgAviso("A Cota" + CHR(231) + CHR(227) + "o Ainda N" + CHR(227) + ;
8691:                     "o Foi Aprovada!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
8692:                 loc_lProsseguir = .F.
8693:             ENDIF
8694:         ENDIF
8695: 
8696:         IF loc_lProsseguir
8697:             THIS.this_nCodigoSelecionado = cursor_4c_CotasPendentes.Codigos
8698: 
8699:             IF THIS.CarregarCotacaoSelecionada(THIS.this_nCodigoSelecionado)
8700:                 THIS.this_cModoAtual = "COTACOES"
8701:                 THIS.AlternarPagina(3)
8702:                 loc_lSucesso = .T.
8703:             ENDIF
8704:         ENDIF
8705: 
8706:         RETURN loc_lSucesso
8707:     ENDPROC
8708: 
8709:     *--------------------------------------------------------------------------
8710:     * CarregarCotacaoSelecionada - Le o cabecalho da cotacao (SigCtTDc) e o
8711:     * entrega ao Business Object. Equivale ao primeiro bloco do PROCEDURE
8712:     * alteracotacao legado (SqlExecute + Scatter/Insert em crSigCtTDc), aqui

*-- Linhas 8771 a 8862:
8771:         RETURN loc_lSucesso
8772:     ENDPROC
8773: 
8774:     *--------------------------------------------------------------------------
8775:     * CarregarItensEFornecedoresCotacao - Le SigCtTCt/SigCtTFn da cotacao
8776:     * <par_nCodigo> para cursor_4c_Produtos/cursor_4c_Fornecedores (equivalente
8777:     * ao SELECT * ... Order By Codigos, CItens/Grades do PROCEDURE
8778:     * alteracotacao legado - aqui usado tanto por Alterar quanto Consultar/
8779:     * Excluir, ja que a estrutura de carga eh identica).
8780:     *--------------------------------------------------------------------------
8781:     PROTECTED PROCEDURE CarregarItensEFornecedoresCotacao(par_nCodigo)
8782:         LOCAL loc_cSQL, loc_nResultado
8783: 
8784:         IF !USED("cursor_4c_Produtos")
8785:             THIS.CriarCursoresCotacao()
8786:         ENDIF
8787: 
8788:         ZAP IN cursor_4c_Produtos
8789:         ZAP IN cursor_4c_Fornecedores
8790: 
8791:         loc_cSQL = "SELECT * FROM SigCtTCt WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
8792:             " ORDER BY Codigos, CItens"
8793:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTemp")
8794: 
8795:         IF loc_nResultado > 0 AND USED("cursor_4c_ProdutosTemp")
8796:             SELECT cursor_4c_ProdutosTemp
8797:             SCAN
8798:                 INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, CUnis, CodCors, CodTams, ;
8799:                         EmpDopNums, Obs, Justificas, Qtds, QtdAdqs, ValAdqs, ;
8800:                         Marca01, Marca02, Marca03, Marca04, Marca05, Marca06, ;
8801:                         Unit01, Unit02, Unit03, Unit04, Unit05, Unit06, ;
8802:                         Tota01, Tota02, Tota03, Tota04, Tota05, Tota06) ;
8803:                     VALUES (cursor_4c_ProdutosTemp.cIdChaves, cursor_4c_ProdutosTemp.Codigos, ;
8804:                         cursor_4c_ProdutosTemp.CItens, ALLTRIM(cursor_4c_ProdutosTemp.CPros), ;
8805:                         ALLTRIM(cursor_4c_ProdutosTemp.DPros), ALLTRIM(cursor_4c_ProdutosTemp.CUnis), ;
8806:                         ALLTRIM(NVL(cursor_4c_ProdutosTemp.CodCors, "")), ALLTRIM(NVL(cursor_4c_ProdutosTemp.CodTams, "")), ;
8807:                         ALLTRIM(NVL(cursor_4c_ProdutosTemp.EmpDopNums, "")), NVL(cursor_4c_ProdutosTemp.Obs, ""), ;
8808:                         NVL(cursor_4c_ProdutosTemp.Justificas, ""), cursor_4c_ProdutosTemp.Qtds, ;
8809:                         cursor_4c_ProdutosTemp.QtdAdqs, cursor_4c_ProdutosTemp.ValAdqs, ;
8810:                         ConverterParaLogico(cursor_4c_ProdutosTemp.Marca01), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca02), ;
8811:                         ConverterParaLogico(cursor_4c_ProdutosTemp.Marca03), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca04), ;
8812:                         ConverterParaLogico(cursor_4c_ProdutosTemp.Marca05), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca06), ;
8813:                         cursor_4c_ProdutosTemp.Unit01, cursor_4c_ProdutosTemp.Unit02, cursor_4c_ProdutosTemp.Unit03, ;
8814:                         cursor_4c_ProdutosTemp.Unit04, cursor_4c_ProdutosTemp.Unit05, cursor_4c_ProdutosTemp.Unit06, ;
8815:                         cursor_4c_ProdutosTemp.Tota01, cursor_4c_ProdutosTemp.Tota02, cursor_4c_ProdutosTemp.Tota03, ;
8816:                         cursor_4c_ProdutosTemp.Tota04, cursor_4c_ProdutosTemp.Tota05, cursor_4c_ProdutosTemp.Tota06)
8817:             ENDSCAN
8818:             USE IN cursor_4c_ProdutosTemp
8819:         ENDIF
8820: 
8821:         *-- Sem linhas (nao deveria acontecer, mas o legado sempre garante ao
8822:         *-- menos 1 linha para a grade nao ficar sem cursor posicionavel)
8823:         IF RECCOUNT("cursor_4c_Produtos") < 1
8824:             INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
8825:                 VALUES (LEFT(fUniqueIds(), 20), par_nCodigo, 1, "", "", "", 0, "", 0)
8826:         ENDIF
8827: 
8828:         loc_cSQL = "SELECT * FROM SigCtTFn WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
8829:             " ORDER BY Codigos, Grades"
8830:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornecTemp")
8831: 
8832:         IF loc_nResultado > 0 AND USED("cursor_4c_FornecTemp")
8833:             SELECT cursor_4c_FornecTemp
8834:             SCAN
8835:                 INSERT INTO cursor_4c_Fornecedores (cIdChaves, Codigos, Grades, IClis, Fornecs, Contatos, ;
8836:                         Tel1s, FPags, DtEnts, Fretes, VlFretes) ;
8837:                     VALUES (cursor_4c_FornecTemp.cIdChaves, cursor_4c_FornecTemp.Codigos, cursor_4c_FornecTemp.Grades, ;
8838:                         ALLTRIM(cursor_4c_FornecTemp.IClis), ALLTRIM(cursor_4c_FornecTemp.Fornecs), ;
8839:                         ALLTRIM(cursor_4c_FornecTemp.Contatos), ALLTRIM(cursor_4c_FornecTemp.Tel1s), ;
8840:                         ALLTRIM(cursor_4c_FornecTemp.FPags), ConverterParaData(NVL(cursor_4c_FornecTemp.DtEnts, {})), ;
8841:                         ALLTRIM(NVL(cursor_4c_FornecTemp.Fretes, "Emitente")), NVL(cursor_4c_FornecTemp.VlFretes, 0))
8842:             ENDSCAN
8843:             USE IN cursor_4c_FornecTemp
8844:         ENDIF
8845: 
8846:         GO TOP IN cursor_4c_Produtos
8847:         GO TOP IN cursor_4c_Fornecedores
8848: 
8849:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5) AND PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "grd_4c_Produtos", 5)
8850:             THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
8851:             THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores.Refresh()
8852:             THIS.GridCotacoesAfterRowColChange(1)
8853:         ENDIF
8854:     ENDPROC
8855: 
8856:     *--------------------------------------------------------------------------
8857:     * FormParaBO - Recolhe para o BusinessObject (cabecalho SigCtTDc) o que
8858:     * esta NOS CONTROLES da pagina de Cotacoes (Page3 + pgf_4c_ComplCots).
8859:     *
8860:     * Override do hook PROTECTED de FormBase (formbase.prg:285), que o
8861:     * FormBase.Salvar() ja chama antes do BO.Salvar(). PROTECTED e obrigatorio
8862:     * aqui: o escopo vem da classe pai, entao declarar sem o modificador nao

*-- Linhas 8882 a 8890:
8882:     *                                     manda nele sao ChkAprovadorClick e
8883:     *                                     AprovarCotacao, que o ZERAM no BO e
8884:     *                                     so DEPOIS de GravaDados zeram o
8885:     *                                     CheckBox (ordem transcrita do
8886:     *                                     legado). Le-lo aqui desfaria esse
8887:     *                                     zero e gravaria como aprovada uma
8888:     *                                     cotacao que a validacao recusou.
8889:     *--------------------------------------------------------------------------
8890:     PROTECTED PROCEDURE FormParaBO()


### BO (C:\4c\projeto\app\classes\sigmvcotBO.prg):
*============================================================================
* sigmvcotBO.prg - Business Object para Cotacao de Compras
*
* Tabela principal : SigCtTDc  (PK: cidchaves char(20), business key: codigos)
* Tabela fornecs    : SigCtTFn  (FK: cidchaves)
* Tabela itens/prods: SigCtTCt  (FK: cidchaves)
*
* Form legado (SIGMVCOT) e um form OPERACIONAL com 4 paginas:
*   Filtros -> Dados (movimentacoes) -> Cotacoes (fornecedores/produtos) -> Pedidos
* As grades (Movimentacoes, Cotacoes em Aberto, Fornecedores, Produtos,
* Pedidos/Itens de Pedido) sao manipuladas via cursores populados por
* SQLEXEC (ver aliases HIDDEN abaixo) - nao viram propriedades this_ do BO,
* que representa apenas o cabecalho da Cotacao (SigCtTDc) sendo editado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigmvcotBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigCtTDc (campos do banco)
    *==========================================================================
    this_cCidChaves  = ""   && char(20) NOT NULL - Chave primaria Fortyus (fUniqueIds())
    this_nCodigos    = 0    && numeric(6,0) NOT NULL - Codigo da cotacao (chave de negocio)
    this_cComprador  = ""   && char(12) NOT NULL - Usuario comprador (SigCdUsu.Usuarios)
    this_cDeptos     = ""   && char(10) NOT NULL - Departamento solicitante (SigCdDpt.Codigos)
    this_dDtCotas    = {}   && datetime NULL - Data da cotacao
    this_dDtPagtos   = {}   && datetime NULL - Data de pagamento
    this_dDtSolics   = {}   && datetime NULL - Data da solicitacao
    this_dDtValids   = {}   && datetime NULL - Data de validade da cotacao
    this_cJustificas = ""   && text NULL - Justificativa geral da cotacao
    this_nPrioris    = 0    && numeric(1,0) NOT NULL - Prioridade (1=Normal,2=Media,3=Alta)
    this_nSituas     = 0    && numeric(1,0) NOT NULL - Situacao (0=Em cotacao, >0=Pedido gerado)
    this_cSolicitas  = ""   && char(10) NOT NULL - Usuario solicitante (SigCdUsu.Usuarios)
    this_cAprovador  = ""   && char(10) NOT NULL - Usuario aprovador (SigCdUsu.Usuarios)
    this_cAprSols    = ""   && char(10) NOT NULL - Usuario que aprova a solicitacao
    this_nChkAprovs  = 0    && numeric(1,0) NOT NULL - Flag aprovacao final (0/1)
    this_cContaEs    = ""   && char(10) NOT NULL - Conta de entrega (SigCdCli.IClis)
    this_dDtAprovs   = {}   && datetime NULL - Data da aprovacao final
    this_dDtAprSols  = {}   && datetime NULL - Data da aprovacao da solicitacao
    this_nLocalEnts  = 0    && numeric(10,0) NOT NULL - Local de entrega (SigCdEnd)
    this_cObsAprovs  = ""   && text NULL - Observacao da aprovacao final
    this_cObsAprSols = ""   && text NULL - Observacao da aprovacao da solicitacao
    this_nCopias     = 0    && numeric(6,0) NOT NULL - Codigo da cotacao original (copia)

    *==========================================================================
    * Propriedades de exibicao - nao armazenadas no banco (descricoes de lookup)
    *==========================================================================
    this_cDComprador = ""   && Nome do comprador (SigCdUsu.NComps, exibicao)
    this_cDDeptos    = ""   && Descricao do departamento (SigCdDpt.Descricaos, exibicao)
    this_cDSolicitas = ""   && Nome do solicitante (SigCdUsu.NComps, exibicao)
    this_cDAprovador = ""   && Nome do aprovador (SigCdUsu.NComps, exibicao)
    this_cDAprSols   = ""   && Nome do aprovador da solicitacao (SigCdUsu.NComps, exibicao)
    this_cDContaEs   = ""   && Nome da conta de entrega (SigCdCli.RClis, exibicao)

    *==========================================================================
    * Aliases de cursores das grades da tela (populados via SQLEXEC nas fases
    * seguintes) - HIDDEN para nao aparecer em FormParaBO/BOParaForm
    *==========================================================================
    HIDDEN this_cCursorFornecedores
    HIDDEN this_cCursorProdutos
    HIDDEN this_cCursorMovimentacao
    HIDDEN this_cCursorCotasPendentes
    HIDDEN this_cCursorPedidos
    HIDDEN this_cCursorItensPedido

    this_cCursorFornecedores  = "cursor_4c_Fornecedores"
    this_cCursorProdutos      = "cursor_4c_Produtos"
    this_cCursorMovimentacao  = "cursor_4c_Movimentacao"
    this_cCursorCotasPendentes = "cursor_4c_CotasPendentes"
    this_cCursorPedidos       = "cursor_4c_Pedidos"
    this_cCursorItensPedido   = "cursor_4c_ItensPedido"

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCtTDc"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do cabecalho da cotacao
    * (SigCtTDc) a partir de um cursor ja aberto.
    *
    * As colunas cD<Campo> (this_cDComprador, this_cDDeptos, this_cDSolicitas,
    * this_cDAprovador, this_cDAprSols, this_cDContaEs) sao descricoes de
    * lookup que so existem quando o SELECT de origem faz JOIN com
    * SigCdUsu/SigCdDpt/SigCdCli - por isso sao carregadas so quando presentes
    * no cursor (regra #34: nunca checar por nome via Controls, aqui via TYPE).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "")
            THIS.this_nCodigos    = TratarNulo(codigos,    0)
            THIS.this_cComprador  = TratarNulo(comprador,  "")
            THIS.this_cDeptos     = TratarNulo(deptos,     "")
            THIS.this_dDtCotas    = TratarNulo(dtcotas,    {})
            THIS.this_dDtPagtos   = TratarNulo(dtpagtos,   {})
            THIS.this_dDtSolics   = TratarNulo(dtsolics,   {})
            THIS.this_dDtValids   = TratarNulo(dtvalids,   {})
            THIS.this_cJustificas = TratarNulo(justificas, "")
            THIS.this_nPrioris    = TratarNulo(prioris,    0)
            THIS.this_nSituas     = TratarNulo(situas,     0)
            THIS.this_cSolicitas  = TratarNulo(solicitas,  "")
            THIS.this_cAprovador  = TratarNulo(aprovador,  "")
            THIS.this_cAprSols    = TratarNulo(aprsols,    "")
            THIS.this_nChkAprovs  = TratarNulo(chkaprovs,  0)
            THIS.this_cContaEs    = TratarNulo(contaes,    "")
            THIS.this_dDtAprovs   = TratarNulo(dtaprovs,   {})
            THIS.this_dDtAprSols  = TratarNulo(dtaprsols,  {})
            THIS.this_nLocalEnts  = TratarNulo(localents,  0)
            THIS.this_cObsAprovs  = TratarNulo(obsaprovs,  "")
            THIS.this_cObsAprSols = TratarNulo(obsaprsols, "")
            THIS.this_nCopias     = TratarNulo(copias,     0)

            * Descricoes de lookup - presentes so quando o SELECT de origem
            * faz JOIN trazendo essas colunas extras.
            IF TYPE(par_cAliasCursor + ".dcomprador") != "U"
                THIS.this_cDComprador = TratarNulo(dcomprador, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".ddeptos") != "U"
                THIS.this_cDDeptos = TratarNulo(ddeptos, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".dsolicitas") != "U"
                THIS.this_cDSolicitas = TratarNulo(dsolicitas, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".daprovador") != "U"
                THIS.this_cDAprovador = TratarNulo(daprovador, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".daprsols") != "U"
                THIS.this_cDAprSols = TratarNulo(daprsols, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".dcontaes") != "U"
                THIS.this_cDContaEs = TratarNulo(dcontaes, "")
            ENDIF

            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Inclui o cabecalho da cotacao (SigCtTDc) - PROTECTED
    *
    * cidchaves (PK Fortyus) sempre gerado por fUniqueIds() - NUNCA string
    * vazia, senao o 2o registro colide no indice unico (regra #22).
    * codigos (chave de negocio) gerado por fGerUniqueKey("SIGMVCOT"), igual
    * ao legado (Insert Into crSigCtTDc ... fGerUniqueKey([SIGMVCOT])).
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)

            IF THIS.this_nCodigos <= 0
                THIS.this_nCodigos = fGerUniqueKey("SIGMVCOT")
            ENDIF

            IF THIS.this_nCodigos <= 0
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel gerar o c" + CHR(243) + "digo da cota" + CHR(231) + CHR(227) + "o."
            ELSE
                loc_cSQL = "INSERT INTO SigCtTDc" + ;
                           " (cidchaves, codigos, comprador, deptos, dtcotas, dtpagtos," + ;
                           "  dtsolics, dtvalids, justificas, prioris, situas, solicitas," + ;
                           "  aprovador, aprsols, chkaprovs, contaes, dtaprovs, dtaprsols," + ;
                           "  localents, obsaprovs, obsaprsols, copias)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCodigos, 0) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cComprador, 12)) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cDeptos, 10)) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtCotas) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtPagtos) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtSolics) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtValids) + ", " + ;
                           EscaparSQL(THIS.this_cJustificas) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nPrioris, 0) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cSolicitas, 10)) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cAprovador, 10)) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cAprSols, 10)) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nChkAprovs, 0) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cContaEs, 10)) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtAprovs) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtAprSols) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLocalEnts, 0) + ", " + ;
                           EscaparSQL(THIS.this_cObsAprovs) + ", " + ;
                           EscaparSQL(THIS.this_cObsAprSols) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCopias, 0) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao incluir cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvcotBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza o cabecalho da cotacao (SigCtTDc) - PROTECTED
    * cidchaves e codigos NUNCA sao alterados apos a inclusao.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCtTDc SET" + ;
                       " comprador   = " + EscaparSQL(LEFT(THIS.this_cComprador, 12)) + "," + ;
                       " deptos      = " + EscaparSQL(LEFT(THIS.this_cDeptos, 10)) + "," + ;
                       " dtcotas     = " + FormatarDataSQL(THIS.this_dDtCotas) + "," + ;
                       " dtpagtos    = " + FormatarDataSQL(THIS.this_dDtPagtos) + "," + ;
                       " dtsolics    = " + FormatarDataSQL(THIS.this_dDtSolics) + "," + ;
                       " dtvalids    = " + FormatarDataSQL(THIS.this_dDtValids) + "," + ;
                       " justificas  = " + EscaparSQL(THIS.this_cJustificas) + "," + ;
                       " prioris     = " + FormatarNumeroSQL(THIS.this_nPrioris, 0) + "," + ;
                       " situas      = " + FormatarNumeroSQL(THIS.this_nSituas, 0) + "," + ;
                       " solicitas   = " + EscaparSQL(LEFT(THIS.this_cSolicitas, 10)) + "," + ;
                       " aprovador   = " + EscaparSQL(LEFT(THIS.this_cAprovador, 10)) + "," + ;
                       " aprsols     = " + EscaparSQL(LEFT(THIS.this_cAprSols, 10)) + "," + ;
                       " chkaprovs   = " + FormatarNumeroSQL(THIS.this_nChkAprovs, 0) + "," + ;
                       " contaes     = " + EscaparSQL(LEFT(THIS.this_cContaEs, 10)) + "," + ;
                       " dtaprovs    = " + FormatarDataSQL(THIS.this_dDtAprovs) + "," + ;
                       " dtaprsols   = " + FormatarDataSQL(THIS.this_dDtAprSols) + "," + ;
                       " localents   = " + FormatarNumeroSQL(THIS.this_nLocalEnts, 0) + "," + ;
                       " obsaprovs   = " + EscaparSQL(THIS.this_cObsAprovs) + "," + ;
                       " obsaprsols  = " + EscaparSQL(THIS.this_cObsAprSols) + "," + ;
                       " copias      = " + FormatarNumeroSQL(THIS.this_nCopias, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvcotBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

