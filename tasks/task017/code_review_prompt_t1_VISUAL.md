# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 276: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 298: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 322: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 344: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigtosen.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1558 linhas total):

*-- Linhas 102 a 110:
102:                 THIS.this_oBusinessObject.CarregarParametros()
103: 
104:                 IF THIS.this_oBusinessObject.this_nPafEcf = 1
105:                     THIS.lbl_4c_Label3.Visible = .T.
106:                 ENDIF
107: 
108:                 IF TYPE("_Screen.poTimer") = "O"
109:                     fDelAcesso()
110:                 ENDIF

*-- Linhas 151 a 160:
151:     PROTECTED PROCEDURE CriarImagemLogo()
152:         THIS.AddObject("img_4c_ImgFigJpg", "Image")
153:         WITH THIS.img_4c_ImgFigJpg
154:             .Top         = 0
155:             .Left        = 94
156:             .Width       = 191
157:             .Height      = 72
158:             .Picture     = gc_4c_CaminhoIcones + "4control_logo2.png"
159:             .Stretch     = 1
160:             .BackStyle   = 0

*-- Linhas 168 a 360:
168:     * CriarLabels - Adiciona todos os Labels da tela de login
169:     *==========================================================================
170:     PROTECTED PROCEDURE CriarLabels()
171:         THIS.AddObject("lbl_4c_Label1", "Label")
172:         WITH THIS.lbl_4c_Label1
173:             .AutoSize   = .T.
174:             .FontBold   = .T.
175:             .FontName   = "Tahoma"
176:             .FontSize   = 9
177:             .BackStyle  = 0
178:             .Caption    = "Usu" + CHR(225) + "rio :"
179:             .Height     = 16
180:             .Left       = 22
181:             .Top        = 95
182:             .Width      = 55
183:             .ForeColor  = RGB(128,128,128)
184:             .Visible    = .T.
185:         ENDWITH
186: 
187:         THIS.AddObject("lbl_4c_Label2", "Label")
188:         WITH THIS.lbl_4c_Label2
189:             .AutoSize   = .T.
190:             .FontBold   = .T.
191:             .FontName   = "Tahoma"
192:             .FontSize   = 9
193:             .BackStyle  = 0
194:             .Caption    = "Senha :"
195:             .Height     = 16
196:             .Left       = 22
197:             .Top        = 145
198:             .Width      = 48
199:             .ForeColor  = RGB(128,128,128)
200:             .Visible    = .T.
201:         ENDWITH
202: 
203:         THIS.AddObject("lbl_4c_LblEmpresa", "Label")
204:         WITH THIS.lbl_4c_LblEmpresa
205:             .AutoSize   = .T.
206:             .FontBold   = .T.
207:             .FontName   = "Tahoma"
208:             .FontSize   = 9
209:             .BackStyle  = 0
210:             .Caption    = "Empresa :"
211:             .Height     = 16
212:             .Left       = 22
213:             .Top        = 198
214:             .Width      = 61
215:             .ForeColor  = RGB(128,128,128)
216:             .Visible    = .T.
217:         ENDWITH
218: 
219:         THIS.AddObject("lbl_4c_LbltitT", "Label")
220:         WITH THIS.lbl_4c_LbltitT
221:             .AutoSize   = .T.
222:             .FontBold   = .T.
223:             .FontItalic = .T.
224:             .FontSize   = 18
225:             .BackStyle  = 0
226:             .Caption    = "4Control"
227:             .Height     = 31
228:             .Left       = 271
229:             .Top        = 253
230:             .Width      = 99
231:             .ForeColor  = RGB(128,128,128)
232:             .Visible    = .F.
233:         ENDWITH
234: 
235:         THIS.AddObject("lbl_4c_LblTitF", "Label")
236:         WITH THIS.lbl_4c_LblTitF
237:             .AutoSize   = .T.
238:             .FontBold   = .T.
239:             .FontItalic = .T.
240:             .FontSize   = 18
241:             .BackStyle  = 0
242:             .Caption    = "4Control"
243:             .Height     = 31
244:             .Left       = 272
245:             .Top        = 253
246:             .Width      = 99
247:             .ForeColor  = RGB(36,84,155)
248:             .Visible    = .F.
249:         ENDWITH
250: 
251:         THIS.AddObject("lbl_4c_Label3", "Label")
252:         WITH THIS.lbl_4c_Label3
253:             .AutoSize    = .T.
254:             .FontBold    = .T.
255:             .FontName    = "Tahoma"
256:             .FontSize    = 8
257:             .BackStyle   = 0
258:             .BorderStyle = 0
259:             .Caption     = "MENU FISCAL INACESS" + CHR(205) + "VEL NESTA TELA"
260:             .Height      = 15
261:             .Left        = 32
262:             .Top         = 260
263:             .Width       = 217
264:             .ForeColor   = RGB(128,128,128)
265:             .Visible     = .F.
266:         ENDWITH
267:     ENDPROC
268: 
269:     *==========================================================================
270:     * CriarCamposLogin - Adiciona TextBoxes de usuario, senha e empresa
271:     *==========================================================================
272:     PROTECTED PROCEDURE CriarCamposLogin()
273:         THIS.AddObject("txt_4c_USUARIO", "TextBox")
274:         WITH THIS.txt_4c_USUARIO
275:             .FontBold      = .T.
276:             .FontName      = "Comic Sans MS"
277:             .FontSize      = 11
278:             .BackStyle     = 1
279:             .Format        = "K!"
280:             .Height        = 25
281:             .Left          = 22
282:             .MaxLength     = 10
283:             .SelectOnEntry = .F.
284:             .SpecialEffect = 1
285:             .TabIndex      = 1
286:             .ToolTipText   = "Usu" + CHR(225) + "rio do Sistema"
287:             .Top           = 113
288:             .Width         = 119
289:             .ForeColor     = RGB(90,90,90)
290:             .BorderColor   = RGB(238,238,238)
291:             .Value         = ""
292:             .Visible       = .T.
293:         ENDWITH
294: 
295:         THIS.AddObject("txt_4c_SENHA", "TextBox")
296:         WITH THIS.txt_4c_SENHA
297:             .FontBold      = .T.
298:             .FontName      = "Comic Sans MS"
299:             .FontSize      = 11
300:             .BackStyle     = 1
301:             .BorderStyle   = 1
302:             .Format        = "K!"
303:             .Height        = 26
304:             .Left          = 22
305:             .MaxLength     = 10
306:             .SpecialEffect = 1
307:             .TabIndex      = 2
308:             .ToolTipText   = "Senha do Usu" + CHR(225) + "rio"
309:             .Top           = 166
310:             .Width         = 120
311:             .PasswordChar  = "*"
312:             .ForeColor     = RGB(90,90,90)
313:             .DisabledForeColor = RGB(128,128,128)
314:             .BorderColor   = RGB(238,238,238)
315:             .Value         = ""
316:             .Visible       = .T.
317:         ENDWITH
318: 
319:         THIS.AddObject("txt_4c_EMP", "TextBox")
320:         WITH THIS.txt_4c_EMP
321:             .FontBold      = .T.
322:             .FontName      = "Comic Sans MS"
323:             .FontSize      = 11
324:             .BackStyle     = 1
325:             .BorderStyle   = 1
326:             .Format        = "K"
327:             .Height        = 26
328:             .Left          = 22
329:             .MaxLength     = 3
330:             .SpecialEffect = 1
331:             .TabIndex      = 3
332:             .ToolTipText   = "C" + CHR(243) + "digo da Empresa"
333:             .Top           = 217
334:             .Width         = 45
335:             .ForeColor     = RGB(90,90,90)
336:             .BorderColor   = RGB(238,238,238)
337:             .Value         = ""
338:             .Visible       = .T.
339:         ENDWITH
340: 
341:         THIS.AddObject("txt_4c_Demp", "TextBox")
342:         WITH THIS.txt_4c_Demp
343:             .FontBold      = .T.
344:             .FontName      = "Comic Sans MS"
345:             .FontSize      = 11
346:             .BackStyle     = 1
347:             .BorderStyle   = 1
348:             .Format        = "K"
349:             .Height        = 26
350:             .Left          = 74
351:             .MaxLength     = 40
352:             .SpecialEffect = 1
353:             .TabIndex      = 4
354:             .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o da Empresa"
355:             .Top           = 217
356:             .Width         = 294
357:             .ForeColor     = RGB(90,90,90)
358:             .BorderColor   = RGB(238,238,238)
359:             .Value         = ""
360:             .Visible       = .T.

*-- Linhas 371 a 397:
371:             .BorderStyle = 0
372:             .Value       = 0
373:             .Height      = 80
374:             .Left        = 290
375:             .Top         = 116
376:             .Width       = 78
377:             .TabIndex    = 5
378:             .BackColor   = RGB(255,255,255)
379:             .Visible     = .T.
380:         ENDWITH
381:         WITH THIS.obj_4c_SAIDA.Buttons(1)
382:             .Top         = 2
383:             .Left        = 1
384:             .Height      = 75
385:             .Width       = 75
386:             .FontBold    = .T.
387:             .FontItalic  = .F.
388:             .FontName    = "Small Fonts"
389:             .FontSize    = 7
390:             .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
391:             .Cancel      = .T.
392:             .Caption     = ""
393:             .ToolTipText = "[ESC] Sair do Sistema"
394:             .BackColor   = RGB(255,255,255)
395:             .Themes      = .F.
396:         ENDWITH
397:     ENDPROC

*-- Linhas 412 a 420:
412:             ENDIF
413:         ENDIF
414: 
415:         THIS.lbl_4c_LblEmpresa.Visible = loc_lEmpVisivel
416:         THIS.txt_4c_EMP.Visible        = loc_lEmpVisivel
417:         THIS.txt_4c_Demp.Visible       = loc_lEmpVisivel
418: 
419:         IF THIS.this_lGetUsuario
420:             THIS.txt_4c_USUARIO.Enabled = .T.

*-- Linhas 484 a 492:
484:                     GO TOP IN crEmpresa1
485: 
486:                     IF RECCOUNT("crEmpresa1") > 1
487:                         THIS.lbl_4c_LblEmpresa.Visible = .T.
488:                         THIS.txt_4c_EMP.Visible        = .T.
489:                         THIS.txt_4c_Demp.Visible       = .T.
490:                     ELSE
491:                         IF RECCOUNT("crEmpresa1") = 1
492:                             THIS.txt_4c_EMP.Value  = crEmpresa1.cemps

*-- Linhas 998 a 1006:
998:                 LOCAL loc_lcCaption, loc_lnPos
999:                 loc_lcCaption   = _Screen.Caption
1000:                 loc_lnPos       = AT(" / ", loc_lcCaption, 1)
1001:                 _Screen.Caption = SUBSTR(loc_lcCaption, 1, ;
1002:                     IIF(loc_lnPos <> 0, loc_lnPos - 1, ;
1003:                     LEN(ALLTRIM(loc_lcCaption)))) + ;
1004:                     " / " + ALLTRIM(THIS.txt_4c_Demp.Value) + ;
1005:                     " - " + ALLTRIM(gcUsuar)
1006: 

*-- Linhas 1131 a 1139:
1131: 
1132:             IF VARTYPE(loc_oControl) = "O"
1133:                 IF INLIST(UPPER(loc_oControl.Name), ;
1134:                     "LBL_4C_LBLTITF", "LBL_4C_LBLTITT", "LBL_4C_LABEL3")
1135:                     LOOP
1136:                 ENDIF
1137: 
1138:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1139:                     loc_oControl.Visible = .T.

*-- Linhas 1153 a 1162:
1153:     * Garante que os campos de empresa iniciem ocultos ate autenticacao.
1154:     *==========================================================================
1155:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1156:         IF PEMSTATUS(THIS, "lbl_4c_LblEmpresa", 5)
1157:             THIS.lbl_4c_LblEmpresa.Visible = .F.
1158:         ENDIF
1159:         IF PEMSTATUS(THIS, "txt_4c_EMP", 5)
1160:             THIS.txt_4c_EMP.Visible = .F.
1161:             THIS.txt_4c_EMP.Enabled = .F.
1162:         ENDIF

