# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvcot.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (9095 linhas total):

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

*-- Linhas 1040 a 1048:
1040:     *   crCotaPends  -> grade de Cotacoes Realizadas (grd_4c_CotaPends, cursor local)
1041:     *
1042:     * CREATE CURSOR nasce READWRITE, o que eh pre-requisito para a coluna de
1043:     * marcacao (CheckBox) do grid de Movimentacoes aceitar o REPLACE feito
1044:     * pelos handlers de clique/tecla. Tipos e tamanhos transcritos do legado
1045:     * sem "correcoes" (Nops n(6) e Itens n(6) sao os do Load original).
1046:     *--------------------------------------------------------------------------
1047:     PROTECTED PROCEDURE CriarCursoresLista()
1048:         IF USED("cursor_4c_Movimentacao")

*-- Linhas 1093 a 1105:
1093:         loc_oPag = THIS.pgf_4c_Paginas.Page2
1094: 
1095:         *-- Titulo da grade de Movimentacoes (Say5 do legado)
1096:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
1097:         WITH loc_oPag.lbl_4c_Label5
1098:             .Caption   = "\<Movimenta" + CHR(231) + CHR(245) + "es"
1099:             .Top       = 7
1100:             .Left      = 250
1101:             .Width     = 110
1102:             .Height    = 15
1103:             .Alignment = 0
1104:             .AutoSize  = .F.
1105:             .BackStyle = 0

*-- Linhas 1121 a 1161:
1121:             .BackStyle   = 0
1122:             .BorderStyle = 0
1123:             .Value       = 0
1124:             .Top         = 169
1125:             .Left        = 668
1126:             .Width       = 160
1127:             .Height      = 100
1128:             .Visible     = .T.
1129: 
1130:             WITH .Buttons(1)
1131:                 .Top             = 0
1132:                 .Left            = 0
1133:                 .Height          = 100
1134:                 .Width           = 80
1135:                 .WordWrap        = .T.
1136:                 .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_60.jpg"
1137:                 .Caption         = "Marcar Todas"
1138:                 .MousePointer    = 15
1139:                 .ToolTipText     = "Marcar Todas as Opera" + CHR(231) + CHR(245) + "es"
1140:                 .SpecialEffect   = 0
1141:                 .PicturePosition = 7
1142:                 .ForeColor       = RGB(36, 84, 155)
1143:                 .BackColor       = RGB(255, 255, 255)
1144:                 .Themes          = .F.
1145:             ENDWITH
1146: 
1147:             WITH .Buttons(2)
1148:                 .Top             = 0
1149:                 .Left            = 80
1150:                 .Height          = 100
1151:                 .Width           = 80
1152:                 .FontName        = "Verdana"
1153:                 .FontSize        = 8
1154:                 .WordWrap        = .T.
1155:                 .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
1156:                 .Caption         = "Desmarcar Todas "
1157:                 .MousePointer    = 15
1158:                 .ToolTipText     = "Desmarcar Todas as Opera" + CHR(231) + CHR(245) + "es"
1159:                 .SpecialEffect   = 0
1160:                 .PicturePosition = 7
1161:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1172 a 1193:
1172:             .BackStyle   = 0
1173:             .BorderStyle = 0
1174:             .Value       = 1
1175:             .Top         = 169
1176:             .Left        = 828
1177:             .Width       = 80
1178:             .Height      = 100
1179:             .Visible     = .T.
1180: 
1181:             WITH .Buttons(1)
1182:                 .Top             = 0
1183:                 .Left            = 0
1184:                 .Height          = 100
1185:                 .Width           = 80
1186:                 .WordWrap        = .T.
1187:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1188:                 .Caption         = "Gerar Cota" + CHR(231) + CHR(245) + "es"
1189:                 .MousePointer    = 15
1190:                 .ToolTipText     = "Gerar Cota" + CHR(231) + CHR(245) + "es"
1191:                 .SpecialEffect   = 0
1192:                 .PicturePosition = 7
1193:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1205 a 1226:
1205:             .BackStyle   = 0
1206:             .BorderStyle = 0
1207:             .Value       = 1
1208:             .Top         = 169
1209:             .Left        = 908
1210:             .Width       = 80
1211:             .Height      = 100
1212:             .Visible     = .T.
1213: 
1214:             WITH .Buttons(1)
1215:                 .Top             = 0
1216:                 .Left            = 0
1217:                 .Height          = 100
1218:                 .Width           = 80
1219:                 .WordWrap        = .T.
1220:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1221:                 .Caption         = "Cota" + CHR(231) + CHR(227) + "o Livre"
1222:                 .MousePointer    = 15
1223:                 .ToolTipText     = "Gerar Cota" + CHR(231) + CHR(227) + "o Sem Origem"
1224:                 .SpecialEffect   = 0
1225:                 .PicturePosition = 7
1226:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1236 a 1294:
1236:             .AutoSize    = .F.
1237:             .BackStyle   = 0
1238:             .BorderStyle = 0
1239:             .Top         = 277
1240:             .Left        = 875
1241:             .Width       = 105
1242:             .Height      = 64
1243:             .Value       = 1
1244:             .Visible     = .T.
1245: 
1246:             WITH .Buttons(1)
1247:                 .Caption   = "Todos"
1248:                 .Left      = 5
1249:                 .Top       = 5
1250:                 .Width     = 94
1251:                 .Height    = 15
1252:                 .AutoSize  = .F.
1253:                 .BackStyle = 0
1254:                 .ForeColor = RGB(36, 84, 155)
1255:             ENDWITH
1256: 
1257:             WITH .Buttons(2)
1258:                 .Caption   = "Com Estoque"
1259:                 .Left      = 5
1260:                 .Top       = 24
1261:                 .Width     = 94
1262:                 .Height    = 15
1263:                 .AutoSize  = .F.
1264:                 .BackStyle = 0
1265:                 .FontName  = "Verdana"
1266:                 .FontSize  = 8
1267:                 .ForeColor = RGB(36, 84, 155)
1268:             ENDWITH
1269: 
1270:             WITH .Buttons(3)
1271:                 .Caption   = "Sem Estoque"
1272:                 .Left      = 5
1273:                 .Top       = 44
1274:                 .Width     = 94
1275:                 .Height    = 15
1276:                 .AutoSize  = .F.
1277:                 .BackStyle = 0
1278:                 .FontName  = "Verdana"
1279:                 .FontSize  = 8
1280:                 .ForeColor = RGB(36, 84, 155)
1281:             ENDWITH
1282:         ENDWITH
1283: 
1284:         *-- Rotulo do filtro "Gerar Produtos :" (Say2 do legado)
1285:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
1286:         WITH loc_oPag.lbl_4c_Label2
1287:             .Caption   = "\<Gerar Produtos :"
1288:             .Top       = 283
1289:             .Left      = 765
1290:             .Width     = 105
1291:             .Height    = 15
1292:             .Alignment = 0
1293:             .AutoSize  = .F.
1294:             .BackStyle = 0

*-- Linhas 1300 a 1312:
1300:         ENDWITH
1301: 
1302:         *-- Titulo da grade de Cotacoes Realizadas (Say1 do legado)
1303:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
1304:         WITH loc_oPag.lbl_4c_Label1
1305:             .Caption   = "Cota" + CHR(231) + CHR(245) + "es \<Realizadas"
1306:             .Top       = 294
1307:             .Left      = 250
1308:             .Width     = 140
1309:             .Height    = 15
1310:             .Alignment = 0
1311:             .AutoSize  = .F.
1312:             .BackStyle = 0

*-- Linhas 1328 a 1349:
1328:             .BackStyle   = 0
1329:             .BorderStyle = 0
1330:             .Value       = 1
1331:             .Top         = 453
1332:             .Left        = 668
1333:             .Width       = 90
1334:             .Height      = 100
1335:             .Visible     = .T.
1336: 
1337:             WITH .Buttons(1)
1338:                 .Top             = 0
1339:                 .Left            = 0
1340:                 .Height          = 100
1341:                 .Width           = 80
1342:                 .WordWrap        = .T.
1343:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
1344:                 .Caption         = "Visualizar Cota" + CHR(231) + CHR(227) + "o"
1345:                 .MousePointer    = 15
1346:                 .ToolTipText     = "Consultar Cota" + CHR(231) + CHR(245) + "es"
1347:                 .SpecialEffect   = 0
1348:                 .PicturePosition = 7
1349:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1360 a 1400:
1360:             .BackStyle   = 0
1361:             .BorderStyle = 0
1362:             .Value       = 0
1363:             .Top         = 453
1364:             .Left        = 748
1365:             .Width       = 159
1366:             .Height      = 102
1367:             .Visible     = .T.
1368: 
1369:             WITH .Buttons(1)
1370:                 .Top             = 0
1371:                 .Left            = 0
1372:                 .Height          = 100
1373:                 .Width           = 80
1374:                 .WordWrap        = .T.
1375:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
1376:                 .Caption         = "Alterar Cota" + CHR(231) + CHR(227) + "o"
1377:                 .MousePointer    = 15
1378:                 .ToolTipText     = "Alterar Cota" + CHR(231) + CHR(245) + "es"
1379:                 .SpecialEffect   = 0
1380:                 .PicturePosition = 7
1381:                 .ForeColor       = RGB(36, 84, 155)
1382:                 .BackColor       = RGB(255, 255, 255)
1383:                 .Themes          = .F.
1384:             ENDWITH
1385: 
1386:             WITH .Buttons(2)
1387:                 .Top             = 0
1388:                 .Left            = 80
1389:                 .Height          = 100
1390:                 .Width           = 80
1391:                 .FontName        = "Verdana"
1392:                 .FontSize        = 8
1393:                 .WordWrap        = .T.
1394:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1395:                 .Caption         = "Excluir Cota" + CHR(231) + CHR(227) + "o"
1396:                 .MousePointer    = 15
1397:                 .ToolTipText     = "Excluir Cota" + CHR(231) + CHR(245) + "es"
1398:                 .SpecialEffect   = 0
1399:                 .PicturePosition = 7
1400:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1411 a 1432:
1411:             .BackStyle   = 0
1412:             .BorderStyle = 0
1413:             .Value       = 1
1414:             .Top         = 454
1415:             .Left        = 908
1416:             .Width       = 79
1417:             .Height      = 101
1418:             .Visible     = .T.
1419: 
1420:             WITH .Buttons(1)
1421:                 .Top             = 0
1422:                 .Left            = 0
1423:                 .Height          = 100
1424:                 .Width           = 80
1425:                 .WordWrap        = .T.
1426:                 .Picture         = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
1427:                 .Caption         = "Copiar Cota" + CHR(231) + CHR(227) + "o"
1428:                 .MousePointer    = 15
1429:                 .ToolTipText     = "Copiar Cota" + CHR(231) + CHR(245) + "es"
1430:                 .SpecialEffect   = 0
1431:                 .PicturePosition = 7
1432:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1444 a 1466:
1444:             .BackStyle   = 0
1445:             .BorderStyle = 0
1446:             .Value       = 0
1447:             .Top         = 7
1448:             .Left        = 902
1449:             .Width       = 90
1450:             .Height      = 110
1451:             .Visible     = .T.
1452: 
1453:             WITH .Buttons(1)
1454:                 .Top             = 5
1455:                 .Left            = 5
1456:                 .Height          = 100
1457:                 .Width           = 80
1458:                 .WordWrap        = .T.
1459:                 .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1460:                 .Cancel          = .T.
1461:                 .Caption         = " Retornar  aos Filtros"
1462:                 .MousePointer    = 15
1463:                 .ToolTipText     = "Voltar Para a P" + CHR(225) + "gina de Filtros"
1464:                 .SpecialEffect   = 0
1465:                 .PicturePosition = 7
1466:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1509 a 1523:
1509:         loc_oPag = THIS.pgf_4c_Paginas.Page3
1510: 
1511:         *-- Codigo (crSigCtTDc.Codigos) - somente leitura, gerado pelo BO
1512:         loc_oPag.AddObject("lbl_4c_Label12", "Label")
1513:         WITH loc_oPag.lbl_4c_Label12
1514:             .FontBold  = .T.
1515:             .FontSize  = 8
1516:             .Caption   = "C" + CHR(243) + "digo"
1517:             .Left      = 9
1518:             .Top       = 120
1519:             .Width     = 40
1520:             .ForeColor = RGB(36, 84, 155)
1521:             .BackStyle = 0
1522:             .Alignment = 0
1523:             .Visible   = .T.

*-- Linhas 1530 a 1556:
1530:             .FontBold      = .T.
1531:             .Format        = "K"
1532:             .Height        = 20
1533:             .Left          = 9
1534:             .Top           = 136
1535:             .Width         = 48
1536:             .SpecialEffect = 1
1537:             .ForeColor     = RGB(0, 0, 128)
1538:             .BorderColor   = RGB(0, 0, 128)
1539:             .ReadOnly      = .T.
1540:             .Value         = ""
1541:             .Visible       = .T.
1542:         ENDWITH
1543: 
1544:         *-- Solicitante (SigCdUsu.Usuarios/NComps)
1545:         loc_oPag.AddObject("lbl_4c_Label4", "Label")
1546:         WITH loc_oPag.lbl_4c_Label4
1547:             .FontBold  = .T.
1548:             .FontSize  = 8
1549:             .Caption   = "Solicitante"
1550:             .Left      = 86
1551:             .Top       = 120
1552:             .Width     = 62
1553:             .ForeColor = RGB(36, 84, 155)
1554:             .BackStyle = 0
1555:             .Alignment = 0
1556:             .Visible   = .T.

*-- Linhas 1562 a 1587:
1562:             .FontSize      = 8
1563:             .Format        = "K"
1564:             .Height        = 20
1565:             .Left          = 86
1566:             .Top           = 136
1567:             .Width         = 80
1568:             .MaxLength     = 10
1569:             .SpecialEffect = 1
1570:             .BorderColor   = RGB(0, 0, 128)
1571:             .Value         = ""
1572:             .Visible       = .T.
1573:         ENDWITH
1574: 
1575:         *-- Depto. (SigCdDpt.Codigos/Descricaos)
1576:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
1577:         WITH loc_oPag.lbl_4c_Label5
1578:             .FontBold  = .T.
1579:             .FontSize  = 8
1580:             .Caption   = "Depto."
1581:             .Left      = 195
1582:             .Top       = 120
1583:             .Width     = 39
1584:             .ForeColor = RGB(36, 84, 155)
1585:             .BackStyle = 0
1586:             .Alignment = 0
1587:             .Visible   = .T.

*-- Linhas 1593 a 1618:
1593:             .FontSize      = 8
1594:             .Format        = "K"
1595:             .Height        = 20
1596:             .Left          = 195
1597:             .Top           = 136
1598:             .Width         = 80
1599:             .MaxLength     = 10
1600:             .SpecialEffect = 1
1601:             .BorderColor   = RGB(0, 0, 128)
1602:             .Value         = ""
1603:             .Visible       = .T.
1604:         ENDWITH
1605: 
1606:         *-- Comprador (SigCdUsu.Usuarios/NComps)
1607:         loc_oPag.AddObject("lbl_4c_Label10", "Label")
1608:         WITH loc_oPag.lbl_4c_Label10
1609:             .FontBold  = .T.
1610:             .FontSize  = 8
1611:             .Caption   = "Comprador"
1612:             .Left      = 304
1613:             .Top       = 120
1614:             .Width     = 65
1615:             .ForeColor = RGB(36, 84, 155)
1616:             .BackStyle = 0
1617:             .Alignment = 0
1618:             .Visible   = .T.

*-- Linhas 1624 a 1652:
1624:             .FontSize      = 8
1625:             .Format        = "K"
1626:             .Height        = 20
1627:             .Left          = 304
1628:             .Top           = 136
1629:             .Width         = 80
1630:             .MaxLength     = 10
1631:             .SpecialEffect = 1
1632:             .BorderColor   = RGB(0, 0, 128)
1633:             .Value         = ""
1634:             .Visible       = .T.
1635:         ENDWITH
1636: 
1637:         *-- Aprovador (espelho de LEITURA do cabecalho - crSigCtTDc.Aprovador.
1638:         *-- O campo EDITAVEL com o lookup fwBuscaExt fica em pgfComplCots.
1639:         *-- pgAprovacao (Fase 6) - por isso o nome NAO repete txt_4c_Aprovador,
1640:         *-- que sera usado la, evitando a colisao de objeto da regra #11.
1641:         loc_oPag.AddObject("lbl_4c_Label15", "Label")
1642:         WITH loc_oPag.lbl_4c_Label15
1643:             .FontBold  = .T.
1644:             .FontSize  = 8
1645:             .Caption   = "Aprovador"
1646:             .Left      = 413
1647:             .Top       = 120
1648:             .Width     = 62
1649:             .ForeColor = RGB(36, 84, 155)
1650:             .BackStyle = 0
1651:             .Alignment = 0
1652:             .Visible   = .T.

*-- Linhas 1658 a 1806:
1658:             .FontSize      = 8
1659:             .Format        = "K"
1660:             .Height        = 20
1661:             .Left          = 413
1662:             .Top           = 136
1663:             .Width         = 80
1664:             .MaxLength     = 10
1665:             .SpecialEffect = 1
1666:             .ReadOnly      = .T.
1667:             .BorderColor   = RGB(0, 0, 128)
1668:             .Value         = ""
1669:             .Visible       = .T.
1670:         ENDWITH
1671: 
1672:         *-- Solicitacao (data - crSigCtTDc.DtSolics)
1673:         loc_oPag.AddObject("lbl_4c_Label6", "Label")
1674:         WITH loc_oPag.lbl_4c_Label6
1675:             .FontBold  = .T.
1676:             .FontSize  = 8
1677:             .Caption   = "Solicita" + CHR(231) + CHR(227) + "o"
1678:             .Left      = 522
1679:             .Top       = 120
1680:             .Width     = 63
1681:             .ForeColor = RGB(36, 84, 155)
1682:             .BackStyle = 0
1683:             .Alignment = 0
1684:             .Visible   = .T.
1685:         ENDWITH
1686: 
1687:         loc_oPag.AddObject("txt_4c_DtSolics", "TextBox")
1688:         WITH loc_oPag.txt_4c_DtSolics
1689:             .FontName      = "Arial"
1690:             .FontSize      = 8
1691:             .Height        = 20
1692:             .Left          = 522
1693:             .Top           = 136
1694:             .Width         = 64
1695:             .InputMask     = "99/99/9999"
1696:             .SpecialEffect = 1
1697:             .BorderColor   = RGB(0, 0, 128)
1698:             .Value         = {}
1699:             .Visible       = .T.
1700:         ENDWITH
1701: 
1702:         *-- Cotacao (data - crSigCtTDc.DtCotas)
1703:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
1704:         WITH loc_oPag.lbl_4c_Label7
1705:             .FontBold  = .T.
1706:             .FontSize  = 8
1707:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
1708:             .Left      = 615
1709:             .Top       = 120
1710:             .Width     = 48
1711:             .ForeColor = RGB(36, 84, 155)
1712:             .BackStyle = 0
1713:             .Alignment = 0
1714:             .Visible   = .T.
1715:         ENDWITH
1716: 
1717:         loc_oPag.AddObject("txt_4c_DtCotas", "TextBox")
1718:         WITH loc_oPag.txt_4c_DtCotas
1719:             .FontName      = "Arial"
1720:             .FontSize      = 8
1721:             .Height        = 20
1722:             .Left          = 615
1723:             .Top           = 136
1724:             .Width         = 64
1725:             .InputMask     = "99/99/9999"
1726:             .SpecialEffect = 1
1727:             .BorderColor   = RGB(0, 0, 128)
1728:             .Value         = {}
1729:             .Visible       = .T.
1730:         ENDWITH
1731: 
1732:         *-- Validade (data - crSigCtTDc.DtValids)
1733:         loc_oPag.AddObject("lbl_4c_Label8", "Label")
1734:         WITH loc_oPag.lbl_4c_Label8
1735:             .FontBold  = .T.
1736:             .FontSize  = 8
1737:             .Caption   = "Validade"
1738:             .Left      = 708
1739:             .Top       = 120
1740:             .Width     = 50
1741:             .ForeColor = RGB(36, 84, 155)
1742:             .BackStyle = 0
1743:             .Alignment = 0
1744:             .Visible   = .T.
1745:         ENDWITH
1746: 
1747:         loc_oPag.AddObject("txt_4c_DtValids", "TextBox")
1748:         WITH loc_oPag.txt_4c_DtValids
1749:             .FontName      = "Arial"
1750:             .FontSize      = 8
1751:             .Height        = 20
1752:             .Left          = 708
1753:             .Top           = 136
1754:             .Width         = 64
1755:             .InputMask     = "99/99/9999"
1756:             .SpecialEffect = 1
1757:             .BorderColor   = RGB(0, 0, 128)
1758:             .Value         = {}
1759:             .Visible       = .T.
1760:         ENDWITH
1761: 
1762:         *-- Pagamento (data - crSigCtTDc.DtPagtos)
1763:         loc_oPag.AddObject("lbl_4c_Label9", "Label")
1764:         WITH loc_oPag.lbl_4c_Label9
1765:             .FontBold  = .T.
1766:             .FontSize  = 8
1767:             .Caption   = "Pagamento"
1768:             .Left      = 801
1769:             .Top       = 120
1770:             .Width     = 67
1771:             .ForeColor = RGB(36, 84, 155)
1772:             .BackStyle = 0
1773:             .Alignment = 0
1774:             .Visible   = .T.
1775:         ENDWITH
1776: 
1777:         loc_oPag.AddObject("txt_4c_DtPagtos", "TextBox")
1778:         WITH loc_oPag.txt_4c_DtPagtos
1779:             .FontName      = "Arial"
1780:             .FontSize      = 8
1781:             .Height        = 20
1782:             .Left          = 801
1783:             .Top           = 136
1784:             .Width         = 64
1785:             .InputMask     = "99/99/9999"
1786:             .SpecialEffect = 1
1787:             .BorderColor   = RGB(0, 0, 128)
1788:             .Value         = {}
1789:             .Visible       = .T.
1790:         ENDWITH
1791: 
1792:         *-- Prioridade (crSigCtTDc.Prioris - 1=Normal, 2=Media, 3=Alta;
1793:         *-- RowSource TRANSCRITO do legado, indice 1-based - regra CLAUDE.md
1794:         *-- #188, NUNCA inventar lista placeholder)
1795:         loc_oPag.AddObject("lbl_4c_Label11", "Label")
1796:         WITH loc_oPag.lbl_4c_Label11
1797:             .FontBold  = .T.
1798:             .FontSize  = 8
1799:             .Caption   = "Prioridade"
1800:             .Left      = 900
1801:             .Top       = 120
1802:             .Width     = 60
1803:             .ForeColor = RGB(36, 84, 155)
1804:             .BackStyle = 0
1805:             .Alignment = 0
1806:             .Visible   = .T.

*-- Linhas 1812 a 1821:
1812:             .FontSize      = 8
1813:             .FontBold      = .T.
1814:             .Height        = 20
1815:             .Left          = 900
1816:             .Top           = 136
1817:             .Width         = 90
1818:             .Style         = 2
1819:             .RowSourceType = 1
1820:             .RowSource     = "  Normal,  " + CHR(205) + CHR(233) + "dia,  Alta"
1821:             .SpecialEffect = 1

*-- Linhas 1866 a 1892:
1866:         *-- Moldura decorativa do rodape (Shape2 do legado)
1867:         loc_oPag.AddObject("shp_4c_Shape2", "Shape")
1868:         WITH loc_oPag.shp_4c_Shape2
1869:             .Top           = 482
1870:             .Left          = 8
1871:             .Width         = 987
1872:             .Height        = 76
1873:             .BackStyle     = 0
1874:             .SpecialEffect = 1
1875:             .BorderColor   = RGB(36, 84, 155)
1876:             .Visible       = .T.
1877:         ENDWITH
1878: 
1879:         *-- "Descricao do Produto" (Say2) + getDPros (espelho de leitura de
1880:         *-- crSigCtTCt.DPros da linha corrente do grdCotacoes)
1881:         loc_oPag.AddObject("lbl_4c_Label2b", "Label")
1882:         WITH loc_oPag.lbl_4c_Label2b
1883:             .FontBold  = .T.
1884:             .FontSize  = 8
1885:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
1886:             .Left      = 15
1887:             .Top       = 484
1888:             .Width     = 122
1889:             .ForeColor = RGB(36, 84, 155)
1890:             .BackStyle = 0
1891:             .Alignment = 0
1892:             .Visible   = .T.

*-- Linhas 1898 a 1983:
1898:             .FontSize      = 8
1899:             .Format        = "K"
1900:             .Height        = 20
1901:             .Left          = 15
1902:             .Top           = 498
1903:             .Width         = 258
1904:             .MaxLength     = 65
1905:             .SpecialEffect = 1
1906:             .BorderColor   = RGB(0, 0, 128)
1907:             .Value         = ""
1908:             .Visible       = .T.
1909:         ENDWITH
1910: 
1911:         *-- "Observacao do Produto" (Say1) + getObs (crSigCtTCt.Obs, editavel)
1912:         loc_oPag.AddObject("lbl_4c_Label1b", "Label")
1913:         WITH loc_oPag.lbl_4c_Label1b
1914:             .FontBold  = .T.
1915:             .FontSize  = 8
1916:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
1917:             .Left      = 277
1918:             .Top       = 484
1919:             .Width     = 134
1920:             .ForeColor = RGB(36, 84, 155)
1921:             .BackStyle = 0
1922:             .Alignment = 0
1923:             .Visible   = .T.
1924:         ENDWITH
1925: 
1926:         loc_oPag.AddObject("obj_4c_GetObs", "EditBox")
1927:         WITH loc_oPag.obj_4c_GetObs
1928:             .FontName      = "Arial"
1929:             .FontSize      = 8
1930:             .Height        = 20
1931:             .Left          = 277
1932:             .Top           = 498
1933:             .Width         = 384
1934:             .SpecialEffect = 1
1935:             .BorderColor   = RGB(0, 0, 128)
1936:             .Value         = ""
1937:             .Visible       = .T.
1938:         ENDWITH
1939: 
1940:         *-- "Justificativa do Produto" (Say3) + getJustificas (crSigCtTCt.Justificas)
1941:         loc_oPag.AddObject("lbl_4c_Label3b", "Label")
1942:         WITH loc_oPag.lbl_4c_Label3b
1943:             .FontBold  = .T.
1944:             .FontSize  = 8
1945:             .Caption   = "Justificativa do Produto"
1946:             .Left      = 16
1947:             .Top       = 519
1948:             .Width     = 136
1949:             .ForeColor = RGB(36, 84, 155)
1950:             .BackStyle = 0
1951:             .Alignment = 0
1952:             .Visible   = .T.
1953:         ENDWITH
1954: 
1955:         loc_oPag.AddObject("obj_4c_GetJustificas", "EditBox")
1956:         WITH loc_oPag.obj_4c_GetJustificas
1957:             .FontName      = "Arial"
1958:             .FontSize      = 8
1959:             .Height        = 20
1960:             .Left          = 16
1961:             .Top           = 533
1962:             .Width         = 644
1963:             .SpecialEffect = 1
1964:             .BorderColor   = RGB(0, 0, 128)
1965:             .Value         = ""
1966:             .Visible       = .T.
1967:         ENDWITH
1968: 
1969:         *-- "Cotacao Original :" (Say13 de Page3) + getCopias (crSigCtTDc.Copias -
1970:         *-- codigo da cotacao que deu origem a esta, quando copiada - When
1971:         *-- sempre .F. no legado, so exibicao)
1972:         loc_oPag.AddObject("lbl_4c_Label13b", "Label")
1973:         WITH loc_oPag.lbl_4c_Label13b
1974:             .FontBold  = .T.
1975:             .FontSize  = 8
1976:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o Original :"
1977:             .Left      = 782
1978:             .Top       = 511
1979:             .Width     = 100
1980:             .ForeColor = RGB(36, 84, 155)
1981:             .BackStyle = 0
1982:             .Alignment = 0
1983:             .Visible   = .T.

*-- Linhas 1990 a 1999:
1990:             .Format        = "999999"
1991:             .InputMask     = "999999"
1992:             .Height        = 20
1993:             .Left          = 905
1994:             .Top           = 508
1995:             .Width         = 57
1996:             .SpecialEffect = 1
1997:             .BorderColor   = RGB(0, 0, 128)
1998:             .ReadOnly      = .T.
1999:             .Value         = 0

*-- Linhas 2070 a 2100:
2070:         loc_oPgf = par_oPagina.pgf_4c_ComplCots
2071: 
2072:         WITH loc_oPgf
2073:             .Top       = 6
2074:             .Left      = 407
2075:             .Width     = 500
2076:             .Height    = 100
2077:             .PageCount = 3
2078:             .Tabs      = .T.
2079:             .Visible   = .T.
2080: 
2081:             .Page1.Caption   = "Complementos"
2082:             .Page1.FontName  = "Verdana"
2083:             .Page1.FontSize  = 8
2084:             .Page1.FontBold  = .T.
2085:             .Page1.BackColor = RGB(255, 255, 255)
2086:             .Page1.ForeColor = RGB(36, 84, 155)
2087: 
2088:             .Page2.Caption   = "Aprova" + CHR(231) + CHR(227) + "o Final"
2089:             .Page2.FontName  = "Verdana"
2090:             .Page2.FontSize  = 8
2091:             .Page2.FontBold  = .T.
2092:             .Page2.BackColor = RGB(255, 255, 255)
2093:             .Page2.ForeColor = RGB(36, 84, 155)
2094: 
2095:             .Page3.Caption   = "Aprova" + CHR(231) + CHR(227) + "o Solicitante"
2096:             .Page3.FontName  = "Verdana"
2097:             .Page3.FontSize  = 8
2098:             .Page3.FontBold  = .T.
2099:             .Page3.BackColor = RGB(255, 255, 255)
2100:             .Page3.ForeColor = RGB(36, 84, 155)

*-- Linhas 2107 a 2162:
2107:         *====================================================================
2108:         * Page1 - pgAdicionais (Entrega geral / Justificativa geral)
2109:         *====================================================================
2110:         loc_oPg1.AddObject("lbl_4c_Label14", "Label")
2111:         WITH loc_oPg1.lbl_4c_Label14
2112:             .FontBold  = .T.
2113:             .FontSize  = 8
2114:             .Caption   = "Justificativa :"
2115:             .Left      = 5
2116:             .Top       = 20
2117:             .ForeColor = RGB(36, 84, 155)
2118:             .BackStyle = 0
2119:             .Alignment = 0
2120:             .Visible   = .T.
2121:         ENDWITH
2122: 
2123:         loc_oPg1.AddObject("obj_4c_GetJustGeral", "EditBox")
2124:         WITH loc_oPg1.obj_4c_GetJustGeral
2125:             .FontName      = "Arial"
2126:             .FontSize      = 8
2127:             .Height        = 20
2128:             .Left          = 96
2129:             .Top           = 18
2130:             .Width         = 353
2131:             .SpecialEffect = 1
2132:             .BorderColor   = RGB(0, 0, 128)
2133:             .Value         = ""
2134:             .Visible       = .T.
2135:         ENDWITH
2136: 
2137:         loc_oPg1.AddObject("lbl_4c_Label13", "Label")
2138:         WITH loc_oPg1.lbl_4c_Label13
2139:             .FontBold  = .T.
2140:             .FontSize  = 8
2141:             .Caption   = "Entrega :"
2142:             .Left      = 33
2143:             .Top       = 42
2144:             .ForeColor = RGB(36, 84, 155)
2145:             .BackStyle = 0
2146:             .Alignment = 0
2147:             .Visible   = .T.
2148:         ENDWITH
2149: 
2150:         loc_oPg1.AddObject("txt_4c_ContaEs", "TextBox")
2151:         WITH loc_oPg1.txt_4c_ContaEs
2152:             .FontName      = "Arial"
2153:             .FontSize      = 8
2154:             .Alignment     = 3
2155:             .Height        = 20
2156:             .Left          = 96
2157:             .Top           = 40
2158:             .Width         = 80
2159:             .MaxLength     = 10
2160:             .SpecialEffect = 1
2161:             .BorderColor   = RGB(0, 0, 128)
2162:             .Value         = ""

*-- Linhas 2169 a 2178:
2169:             .FontSize      = 8
2170:             .Alignment     = 3
2171:             .Height        = 20
2172:             .Left          = 178
2173:             .Top           = 40
2174:             .Width         = 271
2175:             .MaxLength     = 50
2176:             .SpecialEffect = 1
2177:             .BorderColor   = RGB(0, 0, 128)
2178:             .ReadOnly      = .T.

*-- Linhas 2185 a 2222:
2185:         *-- do cliente/grupo pela ContaEs eh transcrita; o passo de abrir a
2186:         *-- tela de endereco vira um aviso encaminhando para o cadastro de
2187:         *-- Clientes, que eh onde os enderecos de entrega devem ser mantidos.
2188:         loc_oPg1.AddObject("cmd_4c_CmdEntrega", "CommandButton")
2189:         WITH loc_oPg1.cmd_4c_CmdEntrega
2190:             .Top           = 20
2191:             .Left          = 451
2192:             .Height        = 20
2193:             .Width         = 20
2194:             .Picture       = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
2195:             .Caption       = ""
2196:             .ToolTipText   = "Local de Entrega"
2197:             .SpecialEffect = 0
2198:             .BackColor     = RGB(255, 255, 255)
2199:             .Themes        = .F.
2200:             .Visible       = .T.
2201:         ENDWITH
2202: 
2203:         BINDEVENT(loc_oPg1.obj_4c_GetJustGeral, "KeyPress", THIS, "ValidarJustGeral")
2204:         BINDEVENT(loc_oPg1.txt_4c_ContaEs,      "KeyPress",  THIS, "TeclaContaEsGeral")
2205:         BINDEVENT(loc_oPg1.txt_4c_DContaEs,     "KeyPress",  THIS, "TeclaDContaEsGeral")
2206:         BINDEVENT(loc_oPg1.cmd_4c_CmdEntrega,   "Click",     THIS, "BtnEntregaGeralClick")
2207: 
2208:         *====================================================================
2209:         * Page2 - pgAprovacao (Aprovacao Final)
2210:         *====================================================================
2211:         loc_oPg2.AddObject("lbl_4c_Label15", "Label")
2212:         WITH loc_oPg2.lbl_4c_Label15
2213:             .FontBold  = .T.
2214:             .FontSize  = 8
2215:             .Caption   = "Aprovador"
2216:             .Left      = 7
2217:             .Top       = 20
2218:             .Width     = 71
2219:             .ForeColor = RGB(36, 84, 155)
2220:             .BackStyle = 0
2221:             .Alignment = 0
2222:             .Visible   = .T.

*-- Linhas 2228 a 2252:
2228:             .FontSize      = 8
2229:             .Format        = "K"
2230:             .Height        = 20
2231:             .Left          = 7
2232:             .Top           = 36
2233:             .Width         = 80
2234:             .MaxLength     = 10
2235:             .SpecialEffect = 1
2236:             .BorderColor   = RGB(0, 0, 128)
2237:             .Value         = ""
2238:             .Visible       = .T.
2239:         ENDWITH
2240: 
2241:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
2242:         WITH loc_oPg2.lbl_4c_Label6
2243:             .FontBold  = .T.
2244:             .FontSize  = 8
2245:             .Caption   = "Data"
2246:             .Left      = 89
2247:             .Top       = 20
2248:             .Width     = 32
2249:             .ForeColor = RGB(36, 84, 155)
2250:             .BackStyle = 0
2251:             .Alignment = 0
2252:             .Visible   = .T.

*-- Linhas 2258 a 2314:
2258:             .FontSize      = 8
2259:             .InputMask     = "99/99/9999"
2260:             .Height        = 20
2261:             .Left          = 89
2262:             .Top           = 36
2263:             .Width         = 64
2264:             .SpecialEffect = 1
2265:             .BorderColor   = RGB(0, 0, 128)
2266:             .Value         = {}
2267:             .Visible       = .T.
2268:         ENDWITH
2269: 
2270:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
2271:         WITH loc_oPg2.lbl_4c_Label1
2272:             .FontBold  = .T.
2273:             .FontSize  = 8
2274:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Aprova" + CHR(231) + CHR(227) + "o"
2275:             .Left      = 155
2276:             .Top       = 21
2277:             .Width     = 173
2278:             .ForeColor = RGB(36, 84, 155)
2279:             .BackStyle = 0
2280:             .Alignment = 0
2281:             .Visible   = .T.
2282:         ENDWITH
2283: 
2284:         loc_oPg2.AddObject("obj_4c_GetObsAprovs", "EditBox")
2285:         WITH loc_oPg2.obj_4c_GetObsAprovs
2286:             .FontName      = "Arial"
2287:             .FontSize      = 8
2288:             .Height        = 20
2289:             .Left          = 155
2290:             .Top           = 36
2291:             .Width         = 295
2292:             .SpecialEffect = 1
2293:             .BorderColor   = RGB(0, 0, 128)
2294:             .Value         = ""
2295:             .Visible       = .T.
2296:         ENDWITH
2297: 
2298:         *-- chkAprovador - Picture normal (nao aprovado) / DownPicture (aprovado)
2299:         loc_oPg2.AddObject("chk_4c_ChkAprovador", "CheckBox")
2300:         WITH loc_oPg2.chk_4c_ChkAprovador
2301:             .Top            = 17
2302:             .Left           = 451
2303:             .Height         = 40
2304:             .Width          = 40
2305:             .Style          = 1
2306:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
2307:             .DownPicture    = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
2308:             .Alignment      = 0
2309:             .Caption        = ""
2310:             .SpecialEffect  = 1
2311:             .BackColor      = RGB(255, 255, 255)
2312:             .Value          = 0
2313:             .Visible        = .T.
2314:         ENDWITH

*-- Linhas 2321 a 2364:
2321:         *====================================================================
2322:         * Page3 - pgSolicitas (Aprovacao do Solicitante)
2323:         *====================================================================
2324:         loc_oPg3.AddObject("lbl_4c_Label15", "Label")
2325:         WITH loc_oPg3.lbl_4c_Label15
2326:             .FontBold  = .T.
2327:             .FontSize  = 8
2328:             .Caption   = "Aprovador"
2329:             .Left      = 5
2330:             .Top       = 19
2331:             .Width     = 71
2332:             .ForeColor = RGB(36, 84, 155)
2333:             .BackStyle = 0
2334:             .Alignment = 0
2335:             .Visible   = .T.
2336:         ENDWITH
2337: 
2338:         loc_oPg3.AddObject("txt_4c_AprSols", "TextBox")
2339:         WITH loc_oPg3.txt_4c_AprSols
2340:             .FontName      = "Arial"
2341:             .FontSize      = 8
2342:             .Height        = 20
2343:             .Left          = 5
2344:             .Top           = 35
2345:             .Width         = 80
2346:             .SpecialEffect = 1
2347:             .BorderColor   = RGB(0, 0, 128)
2348:             .ReadOnly      = .T.
2349:             .Value         = ""
2350:             .Visible       = .T.
2351:         ENDWITH
2352: 
2353:         loc_oPg3.AddObject("lbl_4c_Label6", "Label")
2354:         WITH loc_oPg3.lbl_4c_Label6
2355:             .FontBold  = .T.
2356:             .FontSize  = 8
2357:             .Caption   = "Data"
2358:             .Left      = 87
2359:             .Top       = 19
2360:             .Width     = 32
2361:             .ForeColor = RGB(36, 84, 155)
2362:             .BackStyle = 0
2363:             .Alignment = 0
2364:             .Visible   = .T.

*-- Linhas 2370 a 2407:
2370:             .FontSize      = 8
2371:             .InputMask     = "99/99/9999"
2372:             .Height        = 20
2373:             .Left          = 87
2374:             .Top           = 35
2375:             .Width         = 64
2376:             .SpecialEffect = 1
2377:             .BorderColor   = RGB(0, 0, 128)
2378:             .Value         = {}
2379:             .Visible       = .T.
2380:         ENDWITH
2381: 
2382:         loc_oPg3.AddObject("lbl_4c_Label1", "Label")
2383:         WITH loc_oPg3.lbl_4c_Label1
2384:             .FontBold  = .T.
2385:             .FontSize  = 8
2386:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Aprova" + CHR(231) + CHR(227) + "o"
2387:             .Left      = 153
2388:             .Top       = 20
2389:             .Width     = 173
2390:             .ForeColor = RGB(36, 84, 155)
2391:             .BackStyle = 0
2392:             .Alignment = 0
2393:             .Visible   = .T.
2394:         ENDWITH
2395: 
2396:         loc_oPg3.AddObject("obj_4c_GetObsAprSols", "EditBox")
2397:         WITH loc_oPg3.obj_4c_GetObsAprSols
2398:             .FontName      = "Arial"
2399:             .FontSize      = 8
2400:             .Height        = 20
2401:             .Left          = 153
2402:             .Top           = 35
2403:             .Width         = 339
2404:             .SpecialEffect = 1
2405:             .BorderColor   = RGB(0, 0, 128)
2406:             .Value         = ""
2407:             .Visible       = .T.

*-- Linhas 2441 a 2450:
2441:         loc_oGrid.ColumnCount = 9
2442: 
2443:         WITH loc_oGrid
2444:             .Top           = 164
2445:             .Left          = 7
2446:             .Width         = 984
2447:             .Height        = 81
2448:             .FontName      = "Tahoma"
2449:             .FontSize      = 8
2450:             .HeaderHeight  = 16

*-- Linhas 2477 a 2548:
2477:             .ReadOnly          = .T.
2478:             .Sparse            = .F.
2479:             .DynamicForeColor  = loc_cCor
2480:             .Header1.Caption   = ""
2481:             .Header1.FontSize  = 8
2482:         ENDWITH
2483: 
2484:         WITH loc_oGrid.Column2
2485:             .FontBold          = .T.
2486:             .Movable           = .F.
2487:             .Resizable         = .F.
2488:             .DynamicForeColor  = loc_cCor
2489:             .Format            = "K"
2490:             .Text1.MaxLength         = 10
2491:             .Header1.Caption   = "C" + CHR(243) + "digo"
2492:             .Header1.Alignment = 2
2493:             .Header1.FontSize  = 8
2494:         ENDWITH
2495: 
2496:         WITH loc_oGrid.Column3
2497:             .Movable           = .F.
2498:             .Resizable         = .F.
2499:             .DynamicForeColor  = loc_cCor
2500:             .Format            = "K"
2501:             .Text1.MaxLength         = 40
2502:             .Header1.Caption   = "Fornecedor"
2503:             .Header1.Alignment = 2
2504:             .Header1.FontSize  = 8
2505:         ENDWITH
2506: 
2507:         WITH loc_oGrid.Column4
2508:             .Movable           = .F.
2509:             .Resizable         = .F.
2510:             .Format            = "K"
2511:             .Text1.MaxLength         = 20
2512:             .Header1.Caption   = "Contato"
2513:             .Header1.Alignment = 2
2514:             .Header1.FontSize  = 8
2515:         ENDWITH
2516: 
2517:         WITH loc_oGrid.Column5
2518:             .Movable           = .F.
2519:             .Resizable         = .F.
2520:             .Format            = "K"
2521:             .Text1.MaxLength         = 20
2522:             .Header1.Caption   = "Telefone"
2523:             .Header1.Alignment = 2
2524:             .Header1.FontSize  = 8
2525:         ENDWITH
2526: 
2527:         WITH loc_oGrid.Column6
2528:             .Movable           = .F.
2529:             .Resizable         = .F.
2530:             .Format            = "K"
2531:             .Text1.MaxLength         = 12
2532:             .Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o"
2533:             .Header1.Alignment = 2
2534:             .Header1.FontSize  = 8
2535:         ENDWITH
2536: 
2537:         WITH loc_oGrid.Column7
2538:             .Alignment         = 3
2539:             .Movable           = .F.
2540:             .Resizable         = .F.
2541:             .Format            = "E"
2542:             .InputMask         = "99/99/9999"
2543:             .Header1.Caption   = "Entrega"
2544:             .Header1.Alignment = 2
2545:             .Header1.FontSize  = 8
2546:         ENDWITH
2547: 
2548:         *-- Frete: lista fechada de 2 valores (Emitente/Destinatario), sem

*-- Linhas 2554 a 2573:
2554:             .Resizable         = .F.
2555:             .Format            = "KM"
2556:             .InputMask         = "Emitente,Destinatario"
2557:             .Header1.Caption   = "Frete"
2558:             .Header1.Alignment = 2
2559:             .Header1.FontSize  = 8
2560:         ENDWITH
2561: 
2562:         WITH loc_oGrid.Column9
2563:             .Alignment         = 3
2564:             .Movable           = .F.
2565:             .Resizable         = .F.
2566:             .Format            = "999,999.99"
2567:             .InputMask        = "999,999.99"
2568:             .Header1.Caption   = "Valor Frete"
2569:             .Header1.Alignment = 2
2570:             .Header1.FontSize  = 8
2571:         ENDWITH
2572: 
2573:         *-- Larguras por ULTIMO (valores EXATOS do SCX, na ordem renumerada)

*-- Linhas 2622 a 2631:
2622:         loc_oGrid.ColumnCount = 25
2623: 
2624:         WITH loc_oGrid
2625:             .Top           = 260
2626:             .Left          = 7
2627:             .Width         = 984
2628:             .Height        = 216
2629:             .FontName      = "Tahoma"
2630:             .FontSize      = 8
2631:             .HeaderHeight  = 16

*-- Linhas 2674 a 2682:
2674:             .Sparse            = .F.
2675:             .Format            = "K"
2676:             .Text1.MaxLength         = 14
2677:             .Header1.Caption   = "Produto"
2678:             .Header1.Alignment = 2
2679:             .Header1.FontBold  = .T.
2680:             .Header1.FontSize  = 8
2681:             .Text1.FontBold    = .T.
2682:             .Text1.FontUnderline = .T.

*-- Linhas 2689 a 2722:
2689:             .ReadOnly          = .T.
2690:             .Format            = "999,999.99"
2691:             .InputMask         = "999,999.99"
2692:             .Header1.Caption   = "Solicitada"
2693:             .Header1.Alignment = 2
2694:             .Header1.FontSize  = 8
2695:         ENDWITH
2696: 
2697:         WITH loc_oGrid.Column3
2698:             .Format            = "999,999.99"
2699:             .InputMask         = "999,999.99"
2700:             .Header1.Caption   = "Adquirida"
2701:             .Header1.Alignment = 2
2702:             .Header1.FontSize  = 8
2703:         ENDWITH
2704: 
2705:         WITH loc_oGrid.Column4
2706:             .Format            = "K"
2707:             .Text1.MaxLength         = 3
2708:             .Header1.Caption   = "Uni"
2709:             .Header1.Alignment = 2
2710:             .Header1.FontSize  = 8
2711:         ENDWITH
2712: 
2713:         WITH loc_oGrid.Column5
2714:             .Format            = "999,999.999999"
2715:             .InputMask         = "999,999.999999"
2716:             .ToolTipText       = "Duplo Click - Sele" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica de Valores"
2717:             .Header1.Caption   = "Valor Adq."
2718:             .Header1.Alignment = 2
2719:             .Header1.FontSize  = 8
2720:         ENDWITH
2721: 
2722:         *-- Pares Check/Unitario/Total dos 6 fornecedores (A..F)

*-- Linhas 2730 a 2746:
2730:         WITH loc_oGrid.Column24
2731:             .Format            = "K"
2732:             .Text1.MaxLength         = 4
2733:             .Header1.Caption   = "Tam"
2734:             .Header1.Alignment = 2
2735:             .Header1.FontSize  = 8
2736:         ENDWITH
2737: 
2738:         WITH loc_oGrid.Column25
2739:             .Format            = "K"
2740:             .Text1.MaxLength         = 4
2741:             .Header1.Caption   = "Cor"
2742:             .Header1.Alignment = 2
2743:             .Header1.FontSize  = 8
2744:         ENDWITH
2745: 
2746:         *-- Larguras por ULTIMO (valores EXATOS do SCX)

*-- Linhas 2806 a 2824:
2806:         loc_cDinBack = "IIF(cursor_4c_Produtos.Marca" + loc_cNum + ", RGB(255,255,223), RGB(255,255,255))"
2807: 
2808:         IF !PEMSTATUS(loc_oColChk, "chk_4c_Marca" + loc_cNum, 5)
2809:             loc_oColChk.AddObject("chk_4c_Marca" + loc_cNum, "CheckBox")
2810:         ENDIF
2811: 
2812:         WITH EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum)
2813:             .Top       = 9
2814:             .Left      = 2
2815:             .Height    = 17
2816:             .Width     = 60
2817:             .FontSize  = 8
2818:             .Alignment = 0
2819:             .Caption   = ""
2820:             .BackStyle = 0
2821:             .ReadOnly  = .F.
2822:             .ToolTipText = "Duplo Click - Sele" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica do Fornecedor"
2823:             .Visible   = .T.
2824:         ENDWITH

*-- Linhas 2830 a 2868:
2830:             .Movable          = .F.
2831:             .Resizable        = .F.
2832:             .BackColor        = par_nCor
2833:             .Header1.Caption  = par_cLetra
2834:             .Header1.ForeColor = par_nCor
2835:             .Header1.FontBold = .T.
2836:             .Header1.FontSize = 8
2837:             .Header1.Alignment = 2
2838:         ENDWITH
2839: 
2840:         WITH loc_oColUnit
2841:             .Format           = "99999.999999"
2842:             .InputMask        = "99999.999999"
2843:             .DynamicBackColor = loc_cDinBack
2844:             .Header1.Caption  = "Unit" + CHR(225) + "rio"
2845:             .Header1.ForeColor = par_nCor
2846:             .Header1.FontBold = .T.
2847:             .Header1.Alignment = 2
2848:             .Header1.FontSize = 8
2849:         ENDWITH
2850: 
2851:         WITH loc_oColTot
2852:             .Format           = "999999.999999"
2853:             .InputMask        = "999999.999999"
2854:             .DynamicBackColor = loc_cDinBack
2855:             .Header1.Caption  = "Total"
2856:             .Header1.ForeColor = par_nCor
2857:             .Header1.FontBold = .T.
2858:             .Header1.Alignment = 2
2859:             .Header1.FontSize = 8
2860:         ENDWITH
2861: 
2862:         *-- Toggle de marcacao: NoDefault + 4 handlers manuais (regra CLAUDE.md
2863:         *-- "CheckBox em Grid Column nao alterna pelo binding nativo")
2864:         DO CASE
2865:             CASE par_cLetra = "A"
2866:                 BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "Click",     THIS, "GridMarcaClickNoDefault")
2867:                 BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseUp",   THIS, "GridMarcaMouseUpNoDefault")
2868:                 BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseDown", THIS, "ChkMarcaAMouseDown")

*-- Linhas 2941 a 2981:
2941:             .ButtonCount = 2
2942:             .BackStyle   = 0
2943:             .BorderStyle = 0
2944:             .Top         = 7
2945:             .Left        = 246
2946:             .Width       = 162
2947:             .Height      = 100
2948:             .Visible     = .T.
2949: 
2950:             WITH .Buttons(1)
2951:                 .Top             = 0
2952:                 .Left            = 0
2953:                 .Height          = 100
2954:                 .Width           = 80
2955:                 .WordWrap        = .T.
2956:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
2957:                 .Caption         = "Excluir Produto"
2958:                 .MousePointer    = 15
2959:                 .ToolTipText     = "Excluir o Produto da Cota" + CHR(231) + CHR(227) + "o"
2960:                 .SpecialEffect   = 0
2961:                 .PicturePosition = 7
2962:                 .ForeColor       = RGB(36, 84, 155)
2963:                 .BackColor       = RGB(255, 255, 255)
2964:                 .Themes          = .F.
2965:             ENDWITH
2966: 
2967:             WITH .Buttons(2)
2968:                 .Top             = 0
2969:                 .Left            = 80
2970:                 .Height          = 100
2971:                 .Width           = 80
2972:                 .FontName        = "Verdana"
2973:                 .FontSize        = 8
2974:                 .WordWrap        = .T.
2975:                 .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2976:                 .Caption         = "Hist" + CHR(243) + "rico do Produto"
2977:                 .MousePointer    = 15
2978:                 .ToolTipText     = "Hist" + CHR(243) + "rico do Produto"
2979:                 .SpecialEffect   = 0
2980:                 .PicturePosition = 7
2981:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 2990 a 3012:
2990:             .ButtonCount = 1
2991:             .BackStyle   = 0
2992:             .BorderStyle = 0
2993:             .Top         = 7
2994:             .Left        = 910
2995:             .Width       = 90
2996:             .Height      = 100
2997:             .Visible     = .T.
2998: 
2999:             WITH .Buttons(1)
3000:                 .Top             = 0
3001:                 .Left            = 0
3002:                 .Height          = 100
3003:                 .Width           = 80
3004:                 .WordWrap        = .T.
3005:                 .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
3006:                 .Cancel          = .T.
3007:                 .Caption         = "P" + CHR(225) + "gina de Dados"
3008:                 .MousePointer    = 15
3009:                 .ToolTipText     = "Voltar Para a P" + CHR(225) + "gina de Dados"
3010:                 .SpecialEffect   = 0
3011:                 .PicturePosition = 7
3012:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 3021 a 3080:
3021:             .ButtonCount = 3
3022:             .BackStyle   = 0
3023:             .BorderStyle = 0
3024:             .Top         = 7
3025:             .Left        = 6
3026:             .Width       = 240
3027:             .Height      = 100
3028:             .Visible     = .T.
3029: 
3030:             WITH .Buttons(1)
3031:                 .Top             = 0
3032:                 .Left            = 0
3033:                 .Height          = 100
3034:                 .Width           = 80
3035:                 .WordWrap        = .T.
3036:                 .Picture         = gc_4c_CaminhoIcones + "geral_disco_60.jpg"
3037:                 .Caption         = "Gravar Cota" + CHR(231) + CHR(227) + "o"
3038:                 .MousePointer    = 15
3039:                 .ToolTipText     = "Gravar Dados da Cota" + CHR(231) + CHR(227) + "o"
3040:                 .SpecialEffect   = 0
3041:                 .PicturePosition = 7
3042:                 .ForeColor       = RGB(36, 84, 155)
3043:                 .BackColor       = RGB(255, 255, 255)
3044:                 .Themes          = .F.
3045:             ENDWITH
3046: 
3047:             WITH .Buttons(2)
3048:                 .Top             = 0
3049:                 .Left            = 80
3050:                 .Height          = 100
3051:                 .Width           = 80
3052:                 .FontName        = "Verdana"
3053:                 .FontSize        = 8
3054:                 .WordWrap        = .T.
3055:                 .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
3056:                 .Caption         = "Gerar Pedidos"
3057:                 .MousePointer    = 15
3058:                 .ToolTipText     = "Gerar Pedidos"
3059:                 .SpecialEffect   = 0
3060:                 .PicturePosition = 7
3061:                 .ForeColor       = RGB(36, 84, 155)
3062:                 .BackColor       = RGB(255, 255, 255)
3063:                 .Themes          = .F.
3064:             ENDWITH
3065: 
3066:             WITH .Buttons(3)
3067:                 .Top             = 0
3068:                 .Left            = 160
3069:                 .Height          = 100
3070:                 .Width           = 80
3071:                 .FontName        = "Verdana"
3072:                 .FontSize        = 8
3073:                 .WordWrap        = .T.
3074:                 .Picture         = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
3075:                 .Caption         = "Imprimir Cota" + CHR(231) + CHR(227) + "o"
3076:                 .MousePointer    = 15
3077:                 .ToolTipText     = "Imprimir Cota" + CHR(231) + CHR(227) + "o"
3078:                 .SpecialEffect   = 0
3079:                 .PicturePosition = 7
3080:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 3091 a 3126:
3091:             .AutoSize    = .T.
3092:             .BackStyle   = 0
3093:             .BorderStyle = 0
3094:             .Top         = 492
3095:             .Left        = 663
3096:             .Width       = 91
3097:             .Height      = 50
3098:             .Visible     = .T.
3099: 
3100:             WITH .Buttons(1)
3101:                 .Top           = 5
3102:                 .Left          = 5
3103:                 .Height        = 40
3104:                 .Width         = 40
3105:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3106:                 .Caption       = ""
3107:                 .ToolTipText   = "Inserir Produto na Grade"
3108:                 .SpecialEffect = 0
3109:                 .BackColor     = RGB(255, 255, 255)
3110:                 .Themes        = .F.
3111:             ENDWITH
3112: 
3113:             WITH .Buttons(2)
3114:                 .Top           = 5
3115:                 .Left          = 46
3116:                 .Height        = 40
3117:                 .Width         = 40
3118:                 .FontName      = "Verdana"
3119:                 .FontSize      = 8
3120:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3121:                 .Caption       = ""
3122:                 .ToolTipText   = "Excluir Produto da Grade"
3123:                 .SpecialEffect = 0
3124:                 .BackColor     = RGB(255, 255, 255)
3125:                 .Themes        = .F.
3126:             ENDWITH

*-- Linhas 3160 a 3168:
3160:     *--------------------------------------------------------------------------
3161:     * AjustarCamposCotacao - Reproduz TODOS os PROCEDURE When de Page3 (campos
3162:     * de cabecalho, sub-abas de pgfComplCots e colunas das duas grades),
3163:     * usando ReadOnly (ou Enabled, no caso do CheckBox chk_4c_ChkAprovador) em
3164:     * vez de esconder o controle - exatamente como o legado faz.
3165:     *
3166:     * Gates usados (traduzidos das propriedades do BO/form, ja que este form
3167:     * nao mantem os cursores crSigCtTDc/crCotaPends do legado):
3168:     *   pcEscolha  -> THIS.this_cPcEscolha

*-- Linhas 3380 a 3388:
3380:     ENDPROC
3381: 
3382:     *--------------------------------------------------------------------------
3383:     * Marcacao de fornecedor (A..F) na grd_4c_Produtos - o CheckBox de Column
3384:     * NAO alterna pelo binding nativo (regra CLAUDE.md): Click/MouseUp so dao
3385:     * NODEFAULT; o toggle de verdade acontece no MouseDown/KeyPress(Enter/
3386:     * Espaco), chamando o helper generico AlternarMarcaCotacao. O DblClick do
3387:     * Header1 chama SelecionarTodosFornecedor (selecao em massa do legado).
3388:     *--------------------------------------------------------------------------

*-- Linhas 4365 a 4373:
4365: 
4366:     *--------------------------------------------------------------------------
4367:     * pgAprovacao - Aprovador Final (Usuario ativo, fwBuscaExt), Data e
4368:     * Observacao (sem lookup, so gravam no BO) e o CheckBox de aprovacao.
4369:     *--------------------------------------------------------------------------
4370:     PROCEDURE TeclaAprovadorFinal(par_nKeyCode, par_nShiftAltCtrl)
4371:         IF par_nKeyCode = 115
4372:             THIS.AbrirBuscaAprovadorFinal()
4373:         ENDIF

*-- Linhas 6110 a 6132:
6110:             .BackStyle   = 0
6111:             .BorderStyle = 0
6112:             .Value       = 0
6113:             .Top         = 7
6114:             .Left        = 910
6115:             .Width       = 80
6116:             .Height      = 100
6117:             .Visible     = .T.
6118: 
6119:             WITH .Buttons(1)
6120:                 .Top             = 0
6121:                 .Left            = 0
6122:                 .Height          = 100
6123:                 .Width           = 80
6124:                 .WordWrap        = .T.
6125:                 .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
6126:                 .Cancel          = .T.
6127:                 .Caption         = "P" + CHR(225) + "gina de Dados"
6128:                 .MousePointer    = 15
6129:                 .ToolTipText     = "Voltar Para a P" + CHR(225) + "gina de Dados"
6130:                 .SpecialEffect   = 0
6131:                 .PicturePosition = 7
6132:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 6146 a 6167:
6146:             .BackStyle   = 0
6147:             .BorderStyle = 0
6148:             .Value       = 0
6149:             .Top         = 7
6150:             .Left        = 748
6151:             .Width       = 80
6152:             .Height      = 100
6153:             .Visible     = .T.
6154: 
6155:             WITH .Buttons(1)
6156:                 .Top             = 0
6157:                 .Left            = 0
6158:                 .Height          = 100
6159:                 .Width           = 80
6160:                 .WordWrap        = .T.
6161:                 .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
6162:                 .Caption         = "Processar Pedidos"
6163:                 .MousePointer    = 15
6164:                 .ToolTipText     = "Gerar Opera" + CHR(231) + CHR(245) + "es dos Pedidos"
6165:                 .SpecialEffect   = 0
6166:                 .PicturePosition = 7
6167:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 6183 a 6204:
6183:             .BackStyle   = 0
6184:             .BorderStyle = 0
6185:             .Value       = 0
6186:             .Top         = 7
6187:             .Left        = 829
6188:             .Width       = 80
6189:             .Height      = 100
6190:             .Visible     = .T.
6191: 
6192:             WITH .Buttons(1)
6193:                 .Top             = 0
6194:                 .Left            = 0
6195:                 .Height          = 100
6196:                 .Width           = 80
6197:                 .WordWrap        = .T.
6198:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
6199:                 .Caption         = "Alterar Pedidos"
6200:                 .MousePointer    = 15
6201:                 .ToolTipText     = "Alterar a Opera" + CHR(231) + CHR(227) + "o Gerada"
6202:                 .SpecialEffect   = 0
6203:                 .PicturePosition = 7
6204:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 6213 a 6222:
6213:         *----------------------------------------------------------------------
6214:         loc_oPag.AddObject("cnt_4c_Operacao", "Container")
6215:         WITH loc_oPag.cnt_4c_Operacao
6216:             .Top           = 4
6217:             .Left          = 3
6218:             .Width         = 564
6219:             .Height        = 172
6220:             .BackStyle     = 0
6221:             .BorderWidth   = 0
6222:             .SpecialEffect = 0

*-- Linhas 6234 a 6339:
6234:         *-- uma caixa cinza no meio do container transparente.
6235: 
6236:         *-- "Destino :" (Say8) - grupo/conta contabil de destino
6237:         loc_oCnt.AddObject("lbl_4c_Label8", "Label")
6238:         WITH loc_oCnt.lbl_4c_Label8
6239:             .FontName  = "Tahoma"
6240:             .FontSize  = 8
6241:             .FontBold  = .T.
6242:             .Caption   = "Destino :"
6243:             .Left      = 12
6244:             .Top       = 53
6245:             .Width     = 55
6246:             .Height    = 15
6247:             .Alignment = 0
6248:             .AutoSize  = .F.
6249:             .BackStyle = 0
6250:             .ForeColor = RGB(36, 84, 155)
6251:             .Visible   = .T.
6252:         ENDWITH
6253: 
6254:         *-- "Entrega :" (Say2) - conta de entrega do pedido
6255:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
6256:         WITH loc_oCnt.lbl_4c_Label2
6257:             .FontName  = "Tahoma"
6258:             .FontSize  = 8
6259:             .FontBold  = .T.
6260:             .Caption   = "Entrega :"
6261:             .Left      = 10
6262:             .Top       = 75
6263:             .Width     = 55
6264:             .Height    = 15
6265:             .Alignment = 0
6266:             .AutoSize  = .F.
6267:             .BackStyle = 0
6268:             .ForeColor = RGB(36, 84, 155)
6269:             .Visible   = .T.
6270:         ENDWITH
6271: 
6272:         *-- "Empresa :" (Say3)
6273:         loc_oCnt.AddObject("lbl_4c_Label3", "Label")
6274:         WITH loc_oCnt.lbl_4c_Label3
6275:             .FontName  = "Tahoma"
6276:             .FontSize  = 8
6277:             .FontBold  = .T.
6278:             .Caption   = "Empresa :"
6279:             .Left      = 4
6280:             .Top       = 9
6281:             .Width     = 60
6282:             .Height    = 15
6283:             .Alignment = 0
6284:             .AutoSize  = .F.
6285:             .BackStyle = 0
6286:             .ForeColor = RGB(36, 84, 155)
6287:             .Visible   = .T.
6288:         ENDWITH
6289: 
6290:         *-- "Data :" (Say4)
6291:         loc_oCnt.AddObject("lbl_4c_Label4", "Label")
6292:         WITH loc_oCnt.lbl_4c_Label4
6293:             .FontName  = "Tahoma"
6294:             .FontSize  = 8
6295:             .FontBold  = .T.
6296:             .Caption   = "Data :"
6297:             .Left      = 106
6298:             .Top       = 9
6299:             .Width     = 38
6300:             .Height    = 15
6301:             .Alignment = 0
6302:             .AutoSize  = .F.
6303:             .BackStyle = 0
6304:             .ForeColor = RGB(36, 84, 155)
6305:             .Visible   = .T.
6306:         ENDWITH
6307: 
6308:         *-- "Operacao :" (Say5)
6309:         loc_oCnt.AddObject("lbl_4c_Label5", "Label")
6310:         WITH loc_oCnt.lbl_4c_Label5
6311:             .FontName  = "Tahoma"
6312:             .FontSize  = 8
6313:             .FontBold  = .T.
6314:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
6315:             .Left      = 216
6316:             .Top       = 9
6317:             .Width     = 65
6318:             .Height    = 15
6319:             .Alignment = 0
6320:             .AutoSize  = .F.
6321:             .BackStyle = 0
6322:             .ForeColor = RGB(36, 84, 155)
6323:             .Visible   = .T.
6324:         ENDWITH
6325: 
6326:         *-- "Moeda :" (Say6)
6327:         loc_oCnt.AddObject("lbl_4c_Label6", "Label")
6328:         WITH loc_oCnt.lbl_4c_Label6
6329:             .FontName  = "Tahoma"
6330:             .FontSize  = 8
6331:             .FontBold  = .T.
6332:             .Caption   = "Moeda :"
6333:             .Left      = 431
6334:             .Top       = 9
6335:             .Width     = 50
6336:             .Height    = 15
6337:             .Alignment = 0
6338:             .AutoSize  = .F.
6339:             .BackStyle = 0

*-- Linhas 6349 a 6358:
6349:             .FontBold          = .T.
6350:             .Format            = "K"
6351:             .Height            = 20
6352:             .Left              = 73
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
6372:             .Left              = 149
6373:             .Top               = 51
6374:             .Width             = 73
6375:             .Margin            = 2
6376:             .MaxLength         = 10
6377:             .SpecialEffect     = 1
6378:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6389 a 6398:
6389:             .FontSize          = 8
6390:             .Format            = "K"
6391:             .Height            = 20
6392:             .Left              = 225
6393:             .Top               = 51
6394:             .Width             = 287
6395:             .Margin            = 2
6396:             .MaxLength         = 50
6397:             .SpecialEffect     = 1
6398:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6409 a 6418:
6409:             .FontName          = "Arial"
6410:             .FontSize          = 8
6411:             .Height            = 20
6412:             .Left              = 73
6413:             .Top               = 73
6414:             .Width             = 73
6415:             .Margin            = 2
6416:             .MaxLength         = 10
6417:             .SpecialEffect     = 1
6418:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6428 a 6437:
6428:             .FontName          = "Arial"
6429:             .FontSize          = 8
6430:             .Height            = 20
6431:             .Left              = 149
6432:             .Top               = 73
6433:             .Width             = 362
6434:             .Margin            = 2
6435:             .MaxLength         = 50
6436:             .SpecialEffect     = 1
6437:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6451 a 6472:
6451:             .BackStyle   = 0
6452:             .BorderStyle = 0
6453:             .Value       = 1
6454:             .Top         = 57
6455:             .Left        = 520
6456:             .Width       = 40
6457:             .Height      = 40
6458:             .Themes      = .F.
6459:             .Visible     = .T.
6460: 
6461:             WITH .Buttons(1)
6462:                 .Top           = 0
6463:                 .Left          = 0
6464:                 .Height        = 40
6465:                 .Width         = 40
6466:                 .Picture       = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
6467:                 .Caption       = ""
6468:                 .ToolTipText   = "Local de Entrega"
6469:                 .SpecialEffect = 0
6470:                 .BackColor     = RGB(255, 255, 255)
6471:                 .Themes        = .F.
6472:             ENDWITH

*-- Linhas 6479 a 6508:
6479:             .FontSize          = 8
6480:             .Format            = "K"
6481:             .Height            = 20
6482:             .Left              = 73
6483:             .Top               = 7
6484:             .Width             = 27
6485:             .Margin            = 2
6486:             .MaxLength         = 3
6487:             .SpecialEffect     = 1
6488:             .BorderColor       = RGB(0, 0, 128)
6489:             .DisabledBackColor = RGB(255, 255, 255)
6490:             .DisabledForeColor = RGB(0, 0, 255)
6491:             .Value             = ""
6492:             .Visible           = .T.
6493:         ENDWITH
6494: 
6495:         *-- "Obs. :" (Say_Obs)
6496:         loc_oCnt.AddObject("lbl_4c__Obs", "Label")
6497:         WITH loc_oCnt.lbl_4c__Obs
6498:             .FontName  = "Tahoma"
6499:             .FontSize  = 8
6500:             .FontBold  = .T.
6501:             .Caption   = "Obs. :"
6502:             .Left      = 33
6503:             .Top       = 95
6504:             .Width     = 36
6505:             .Height    = 15
6506:             .Alignment = 0
6507:             .AutoSize  = .F.
6508:             .BackStyle = 0

*-- Linhas 6516 a 6525:
6516:             .FontName      = "Arial"
6517:             .FontSize      = 8
6518:             .Height        = 72
6519:             .Left          = 104
6520:             .Top           = 95
6521:             .Width         = 407
6522:             .SpecialEffect = 1
6523:             .BorderColor   = RGB(0, 0, 128)
6524:             .Value         = ""
6525:             .Visible       = .T.

*-- Linhas 6533 a 6542:
6533:             .Format            = "KE"
6534:             .InputMask         = "99/99/9999"
6535:             .Height            = 20
6536:             .Left              = 149
6537:             .Top               = 7
6538:             .Width             = 62
6539:             .Margin            = 2
6540:             .MaxLength         = 10
6541:             .SpecialEffect     = 1
6542:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6553 a 6562:
6553:             .FontSize          = 8
6554:             .Format            = "K"
6555:             .Height            = 20
6556:             .Left              = 289
6557:             .Top               = 7
6558:             .Width             = 135
6559:             .Margin            = 2
6560:             .MaxLength         = 20
6561:             .SpecialEffect     = 1
6562:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6573 a 6582:
6573:             .FontSize          = 8
6574:             .Format            = "K"
6575:             .Height            = 20
6576:             .Left              = 485
6577:             .Top               = 7
6578:             .Width             = 27
6579:             .Margin            = 2
6580:             .MaxLength         = 3
6581:             .SpecialEffect     = 1
6582:             .BorderColor       = RGB(0, 0, 128)

*-- Linhas 6596 a 6625:
6596:             .Alignment         = 3
6597:             .Format            = "K"
6598:             .Height            = 20
6599:             .Left              = 73
6600:             .Top               = 95
6601:             .Width             = 27
6602:             .Margin            = 2
6603:             .MaxLength         = 3
6604:             .SpecialEffect     = 1
6605:             .BorderColor       = RGB(0, 0, 128)
6606:             .DisabledBackColor = RGB(255, 255, 255)
6607:             .DisabledForeColor = RGB(0, 0, 255)
6608:             .Value             = 0
6609:             .Visible           = .T.
6610:         ENDWITH
6611: 
6612:         *-- "Job :" (Say25 - unico label do container com FontName proprio)
6613:         loc_oCnt.AddObject("lbl_4c_Label25", "Label")
6614:         WITH loc_oCnt.lbl_4c_Label25
6615:             .FontName  = "Verdana"
6616:             .FontSize  = 8
6617:             .FontBold  = .T.
6618:             .Caption   = "Job :"
6619:             .Left      = 39
6620:             .Top       = 31
6621:             .Width     = 32
6622:             .Height    = 15
6623:             .Alignment = 0
6624:             .AutoSize  = .F.
6625:             .BackStyle = 0

*-- Linhas 6643 a 6652:
6643:             .BorderStyle   = 1
6644:             .Format        = "K"
6645:             .Height        = 20
6646:             .Left          = 73
6647:             .Top           = 29
6648:             .Width         = 73
6649:             .MaxLength     = 10
6650:             .SpecialEffect = 1
6651:             .ForeColor     = RGB(0, 0, 0)
6652:             .BorderColor   = RGB(0, 0, 128)

*-- Linhas 6662 a 6671:
6662:             .FontSize      = 8
6663:             .Format        = "K"
6664:             .Height        = 20
6665:             .Left          = 149
6666:             .Top           = 29
6667:             .Width         = 304
6668:             .MaxLength     = 40
6669:             .SpecialEffect = 1
6670:             .BorderColor   = RGB(0, 0, 128)
6671:             .Themes        = .F.

*-- Linhas 7243 a 7265:
7243:         loc_oPgf = par_oPagina.pgf_4c_PgOperacoes
7244: 
7245:         WITH loc_oPgf
7246:             .Top       = 182
7247:             .Left      = 1
7248:             .Width     = 997
7249:             .Height    = 377
7250:             .PageCount = 2
7251:             .Tabs      = .T.
7252:             .Visible   = .T.
7253: 
7254:             .Page1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
7255:             .Page1.FontName  = "Verdana"
7256:             .Page1.FontSize  = 8
7257:             .Page1.FontBold  = .T.
7258:             .Page1.ForeColor = RGB(36, 84, 155)
7259: 
7260:             .Page2.Caption   = "Itens"
7261:             .Page2.FontName  = "Verdana"
7262:             .Page2.FontSize  = 8
7263:             .Page2.FontBold  = .T.
7264:             .Page2.ForeColor = RGB(36, 84, 155)
7265:         ENDWITH

*-- Linhas 7309 a 7318:
7309:         loc_oGrid.ColumnCount = 9
7310: 
7311:         WITH loc_oGrid
7312:             .Top           = 6
7313:             .Left          = 9
7314:             .Width         = 975
7315:             .Height        = 339
7316:             .FontName      = "Tahoma"
7317:             .FontSize      = 8
7318:             .HeaderHeight  = 16

*-- Linhas 7339 a 7403:
7339: 
7340:         WITH loc_oGrid.Column1
7341:             .Alignment         = 3
7342:             .Header1.Caption   = "Ord."
7343:             .Header1.Alignment = 2
7344:             .Header1.FontSize  = 8
7345:         ENDWITH
7346: 
7347:         WITH loc_oGrid.Column2
7348:             .Header1.Caption   = "C" + CHR(243) + "digo"
7349:             .Header1.Alignment = 2
7350:             .Header1.FontSize  = 8
7351:         ENDWITH
7352: 
7353:         WITH loc_oGrid.Column3
7354:             .Header1.Caption   = "Fornecedor"
7355:             .Header1.Alignment = 2
7356:             .Header1.FontSize  = 8
7357:         ENDWITH
7358: 
7359:         WITH loc_oGrid.Column4
7360:             .Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o"
7361:             .Header1.Alignment = 2
7362:             .Header1.FontSize  = 8
7363:         ENDWITH
7364: 
7365:         WITH loc_oGrid.Column5
7366:             .Alignment         = 3
7367:             .Format            = "E"
7368:             .Header1.Caption   = "Entrega"
7369:             .Header1.Alignment = 2
7370:             .Header1.FontSize  = 8
7371:         ENDWITH
7372: 
7373:         WITH loc_oGrid.Column6
7374:             .Alignment         = 3
7375:             .Format            = "999,999.99"
7376:             .Header1.Caption   = "Quantidade"
7377:             .Header1.Alignment = 2
7378:             .Header1.FontSize  = 8
7379:         ENDWITH
7380: 
7381:         WITH loc_oGrid.Column7
7382:             .Alignment         = 3
7383:             .Format            = "999,999.99"
7384:             .Header1.Caption   = "Valor"
7385:             .Header1.Alignment = 2
7386:             .Header1.FontSize  = 8
7387:         ENDWITH
7388: 
7389:         WITH loc_oGrid.Column8
7390:             .Header1.Caption   = "F"
7391:             .Header1.Alignment = 2
7392:             .Header1.FontSize  = 8
7393:         ENDWITH
7394: 
7395:         WITH loc_oGrid.Column9
7396:             .Alignment         = 3
7397:             .Format            = "999,999.99"
7398:             .Header1.Caption   = "Frete"
7399:             .Header1.Alignment = 2
7400:             .Header1.FontSize  = 8
7401:         ENDWITH
7402: 
7403:         loc_oGrid.Column1.Width = 35

*-- Linhas 7438 a 7447:
7438:         loc_oGrid.ColumnCount = 9
7439: 
7440:         WITH loc_oGrid
7441:             .Top           = 5
7442:             .Left          = 9
7443:             .Width         = 975
7444:             .Height        = 340
7445:             .FontName      = "Tahoma"
7446:             .FontSize      = 8
7447:             .HeaderHeight  = 16

*-- Linhas 7468 a 7530:
7468: 
7469:         WITH loc_oGrid.Column1
7470:             .Alignment         = 3
7471:             .Header1.Caption   = "Ord."
7472:             .Header1.Alignment = 2
7473:             .Header1.FontSize  = 8
7474:         ENDWITH
7475: 
7476:         WITH loc_oGrid.Column2
7477:             .Header1.Caption   = "C" + CHR(243) + "digo"
7478:             .Header1.Alignment = 2
7479:             .Header1.FontSize  = 8
7480:         ENDWITH
7481: 
7482:         WITH loc_oGrid.Column3
7483:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
7484:             .Header1.Alignment = 2
7485:             .Header1.FontSize  = 8
7486:         ENDWITH
7487: 
7488:         WITH loc_oGrid.Column4
7489:             .Header1.Caption   = "Uni"
7490:             .Header1.Alignment = 2
7491:             .Header1.FontSize  = 8
7492:         ENDWITH
7493: 
7494:         WITH loc_oGrid.Column5
7495:             .Alignment         = 3
7496:             .Format            = "999,999.99"
7497:             .Header1.Caption   = "Quantidade"
7498:             .Header1.Alignment = 2
7499:             .Header1.FontSize  = 8
7500:         ENDWITH
7501: 
7502:         WITH loc_oGrid.Column6
7503:             .Alignment         = 3
7504:             .Format            = "999999.999999"
7505:             .Header1.Caption   = "Unit" + CHR(225) + "rio"
7506:             .Header1.Alignment = 2
7507:             .Header1.FontSize  = 8
7508:         ENDWITH
7509: 
7510:         WITH loc_oGrid.Column7
7511:             .Alignment         = 3
7512:             .Format            = "999,999.99"
7513:             .Header1.Caption   = "Total"
7514:             .Header1.Alignment = 2
7515:             .Header1.FontSize  = 8
7516:         ENDWITH
7517: 
7518:         WITH loc_oGrid.Column8
7519:             .Header1.Caption   = "Cor"
7520:             .Header1.Alignment = 2
7521:             .Header1.FontSize  = 8
7522:         ENDWITH
7523: 
7524:         WITH loc_oGrid.Column9
7525:             .Header1.Caption   = "Tam"
7526:             .Header1.Alignment = 2
7527:             .Header1.FontSize  = 8
7528:         ENDWITH
7529: 
7530:         loc_oGrid.Column1.Width = 40

*-- Linhas 7618 a 7626:
7618:     *--------------------------------------------------------------------------
7619:     * ConfigurarGridOperacoes - Grade de Movimentacoes em aberto (grdOperacoes
7620:     * do legado, ligada a crOperacoes). A Column1 eh a coluna de MARCACAO:
7621:     * exige AddObject + CurrentControl + Sparse = .F., senao o CheckBox nunca
7622:     * aparece (a coluna continua desenhando o Text1 dela) - e Column.ReadOnly
7623:     * tem de vir DEPOIS de Grid.ReadOnly, que propaga para as colunas.
7624:     *
7625:     * Column.Width por ULTIMO: mexer em RecordSource/ControlSource faz o VFP
7626:     * recalcular todas as larguras para o default.

*-- Linhas 7634 a 7643:
7634:         loc_oGrid.ColumnCount = 6
7635: 
7636:         WITH loc_oGrid
7637:             .Top               = 25
7638:             .Left              = 250
7639:             .Width             = 407
7640:             .Height            = 244
7641:             .FontName          = "Tahoma"
7642:             .FontSize          = 8
7643:             .RowHeight         = 16

*-- Linhas 7661 a 7723:
7661:         loc_oGrid.Column6.ControlSource = "cursor_4c_Movimentacao.Itens"
7662: 
7663:         IF !PEMSTATUS(loc_oGrid.Column1, "chk_4c_Marcas", 5)
7664:             loc_oGrid.Column1.AddObject("chk_4c_Marcas", "CheckBox")
7665:         ENDIF
7666: 
7667:         WITH loc_oGrid.Column1.chk_4c_Marcas
7668:             .Top       = 9
7669:             .Left      = 2
7670:             .Height    = 17
7671:             .Width     = 22
7672:             .FontName  = "Arial"
7673:             .FontSize  = 8
7674:             .Alignment = 0
7675:             .Caption   = ""
7676:             .BackStyle = 0
7677:             .ReadOnly  = .F.
7678:             .Visible   = .T.
7679:         ENDWITH
7680: 
7681:         WITH loc_oGrid.Column1
7682:             .CurrentControl   = "chk_4c_Marcas"
7683:             .Sparse           = .F.
7684:             .ReadOnly         = .F.
7685:             .Movable          = .F.
7686:             .Resizable        = .F.
7687:             .FontSize         = 8
7688:             .Header1.Caption  = ""
7689:             .Header1.FontSize = 8
7690:         ENDWITH
7691: 
7692:         WITH loc_oGrid.Column2
7693:             .FontSize          = 8
7694:             .ReadOnly          = .T.
7695:             .Header1.Caption   = "Data"
7696:             .Header1.Alignment = 2
7697:             .Header1.FontSize  = 8
7698:             .Text1.FontName    = "Arial"
7699:             .Text1.FontSize    = 8
7700:             .Text1.BorderStyle = 1
7701:             .Text1.Margin      = 0
7702:             .Text1.ForeColor   = RGB(0, 0, 0)
7703:         ENDWITH
7704: 
7705:         WITH loc_oGrid.Column3
7706:             .FontSize          = 8
7707:             .ReadOnly          = .T.
7708:             .Header1.Caption   = "Emp"
7709:             .Header1.Alignment = 2
7710:             .Header1.FontSize  = 8
7711:             .Text1.FontSize    = 8
7712:             .Text1.Margin      = 0
7713:         ENDWITH
7714: 
7715:         WITH loc_oGrid.Column4
7716:             .FontSize          = 8
7717:             .ReadOnly          = .T.
7718:             .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
7719:             .Header1.Alignment = 2
7720:             .Header1.FontSize  = 8
7721:             .Text1.FontSize    = 8
7722:             .Text1.BorderStyle = 0
7723:             .Text1.Margin      = 0

*-- Linhas 7730 a 7750:
7730:             .ReadOnly          = .T.
7731:             .Format            = "999999"
7732:             .InputMask         = "999999"
7733:             .Header1.Caption   = "C" + CHR(243) + "digo"
7734:             .Header1.Alignment = 2
7735:             .Header1.FontSize  = 8
7736:             .Text1.FontSize    = 8
7737:             .Text1.Margin      = 0
7738:         ENDWITH
7739: 
7740:         WITH loc_oGrid.Column6
7741:             .FontSize          = 8
7742:             .ReadOnly          = .T.
7743:             .Format            = "999999"
7744:             .InputMask         = "999999"
7745:             .Header1.Caption   = "Itens"
7746:             .Header1.Alignment = 2
7747:             .Header1.FontSize  = 8
7748:             .Text1.FontSize    = 8
7749:             .Text1.Margin      = 0
7750:         ENDWITH

*-- Linhas 7757 a 7765:
7757:         loc_oGrid.Column5.Width = 56
7758:         loc_oGrid.Column6.Width = 56
7759: 
7760:         *-- O CheckBox de grid NAO alterna pelo binding nativo: o legado
7761:         *-- suprime o toggle padrao (NoDefault) e inverte Marcas por codigo,
7762:         *-- para poder validar a regra de Job.
7763:         BINDEVENT(loc_oGrid.Column1.chk_4c_Marcas, "Click",     THIS, "ChkMarcasClick")
7764:         BINDEVENT(loc_oGrid.Column1.chk_4c_Marcas, "MouseDown", THIS, "ChkMarcasMouseDown")
7765:         BINDEVENT(loc_oGrid.Column1.chk_4c_Marcas, "MouseUp",   THIS, "ChkMarcasMouseUp")

*-- Linhas 7780 a 7789:
7780:         loc_oGrid.ColumnCount = 6
7781: 
7782:         WITH loc_oGrid
7783:             .Top           = 311
7784:             .Left          = 250
7785:             .Width         = 407
7786:             .Height        = 244
7787:             .FontName      = "Tahoma"
7788:             .FontSize      = 8
7789:             .RowHeight     = 16

*-- Linhas 7811 a 7819:
7811:             .Movable           = .F.
7812:             .Resizable         = .F.
7813:             .Sparse            = .F.
7814:             .Header1.Caption   = "C" + CHR(243) + "digo"
7815:             .Header1.Alignment = 2
7816:             .Header1.FontSize  = 8
7817:             .Text1.FontBold    = .T.
7818:             .Text1.FontSize    = 8
7819:             .Text1.Alignment   = 3

*-- Linhas 7828 a 7836:
7828:             .FontBold          = .T.
7829:             .Movable           = .F.
7830:             .Resizable         = .F.
7831:             .Header1.Caption   = "Solicita" + CHR(231) + CHR(227) + "o"
7832:             .Header1.Alignment = 2
7833:             .Header1.FontSize  = 8
7834:             .Text1.FontBold    = .T.
7835:             .Text1.FontSize    = 8
7836:             .Text1.BorderStyle = 0

*-- Linhas 7843 a 7862:
7843:             .FontSize          = 8
7844:             .Movable           = .F.
7845:             .Resizable         = .F.
7846:             .Header1.Caption   = "Solicitante"
7847:             .Header1.Alignment = 2
7848:             .Header1.FontSize  = 8
7849:             .Text1.FontSize    = 8
7850:             .Text1.Margin      = 0
7851:         ENDWITH
7852: 
7853:         WITH loc_oGrid.Column4
7854:             .FontSize          = 8
7855:             .Movable           = .F.
7856:             .Resizable         = .F.
7857:             .Header1.Caption   = "Departamento"
7858:             .Header1.Alignment = 2
7859:             .Header1.FontSize  = 8
7860:             .Text1.FontSize    = 8
7861:             .Text1.Margin      = 0
7862:         ENDWITH

*-- Linhas 7874 a 7895:
7874:             .Movable           = .F.
7875:             .Resizable         = .F.
7876:             .DynamicForeColor  = loc_cCorPrioridade
7877:             .Header1.Caption   = "Prioridade"
7878:             .Header1.Alignment = 2
7879:             .Header1.FontSize  = 8
7880:             .Text1.FontBold    = .T.
7881:             .Text1.FontSize    = 8
7882:             .Text1.Margin      = 0
7883:         ENDWITH
7884: 
7885:         WITH loc_oGrid.Column6
7886:             .FontSize          = 8
7887:             .Alignment         = 3
7888:             .Movable           = .F.
7889:             .Resizable         = .F.
7890:             .Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
7891:             .Header1.Alignment = 2
7892:             .Header1.FontSize  = 8
7893:             .Text1.FontSize    = 8
7894:             .Text1.Alignment   = 3
7895:             .Text1.Margin      = 0

*-- Linhas 8349 a 8359:
8349: 
8350:     *--------------------------------------------------------------------------
8351:     * ChkMarcas* - Coluna de marcacao da grade de Movimentacoes. O legado
8352:     * SUPRIME o toggle nativo do CheckBox (NoDefault em Click/MouseDown/
8353:     * MouseUp) e inverte crOperacoes.Marcas por codigo, para poder validar a
8354:     * regra de Job. Sem os quatro handlers o CheckBox nao alterna.
8355:     *--------------------------------------------------------------------------
8356:     PROCEDURE ChkMarcasClick()
8357:         NODEFAULT
8358:     ENDPROC
8359: 

*-- Linhas 8910 a 8918:
8910:     *                                     manda nele sao ChkAprovadorClick e
8911:     *                                     AprovarCotacao, que o ZERAM no BO e
8912:     *                                     so DEPOIS de GravaDados zeram o
8913:     *                                     CheckBox (ordem transcrita do
8914:     *                                     legado). Le-lo aqui desfaria esse
8915:     *                                     zero e gravaria como aprovada uma
8916:     *                                     cotacao que a validacao recusou.
8917:     *--------------------------------------------------------------------------
8918:     PROTECTED PROCEDURE FormParaBO()


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

