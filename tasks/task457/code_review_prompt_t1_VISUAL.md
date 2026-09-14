# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 182: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 205: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 228: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 251: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 274: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 310: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 397: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 421: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formlct.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (887 linhas total):

*-- Linhas 52 a 60:
52:         loc_lResultado = .F.
53: 
54:         TRY
55:             THIS.Caption = "Cadastro de Lan" + CHR(231) + "amentos"
56: 
57:             THIS.this_oBusinessObject = CREATEOBJECT("lctBO")
58: 
59:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
60:                 MsgErro("Falha ao criar lctBO", "Formlct.InicializarForm")

*-- Linhas 88 a 104:
88: 
89:         WITH loc_oPgf
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97:             .Page1.Caption  = "Lista"
98:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.Caption  = "Dados"
100:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:         ENDWITH
102: 
103:         THIS.ConfigurarPaginaLista()
104:         THIS.ConfigurarPaginaDados()

*-- Linhas 115 a 153:
115:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
116:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
117:         WITH loc_oCab
118:             .Top         = 31
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oCab.lbl_4c_Sombra
129:             .AutoSize  = .F.
130:             .Caption   = THIS.Caption
131:             .Top       = 15
132:             .Left      = 10
133:             .Width     = THIS.Width
134:             .Height    = 40
135:             .FontName  = "Tahoma"
136:             .FontSize  = 16
137:             .FontBold  = .T.
138:             .ForeColor = RGB(0, 0, 0)
139:             .BackStyle = 0
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oCab.lbl_4c_Titulo
145:             .AutoSize  = .F.
146:             .Caption   = THIS.Caption
147:             .Top       = 18
148:             .Left      = 10
149:             .Width     = THIS.Width
150:             .Height    = 46
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.

*-- Linhas 160 a 336:
160:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
161:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
162:         WITH loc_oBotoes
163:             .Top         = 29
164:             .Left        = 542
165:             .Width       = 390
166:             .Height      = 85
167:             .BackColor   = RGB(53, 53, 53)
168:             .BackStyle   = 1
169:             .BorderWidth = 0
170:             .Visible     = .T.
171:         ENDWITH
172: 
173:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
174:         WITH loc_oBotoes.cmd_4c_Incluir
175:             .Caption         = "Incluir"
176:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
177:             .PicturePosition = 13
178:             .Top             = 5
179:             .Left            = 5
180:             .Width           = 75
181:             .Height          = 75
182:             .FontName        = "Comic Sans MS"
183:             .FontSize        = 8
184:             .FontBold        = .T.
185:             .FontItalic      = .T.
186:             .ForeColor       = RGB(90, 90, 90)
187:             .BackColor       = RGB(255, 255, 255)
188:             .Themes          = .F.
189:             .SpecialEffect   = 0
190:             .WordWrap        = .T.
191:             .MousePointer    = 15
192:             .Visible         = .T.
193:         ENDWITH
194:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
195: 
196:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
197:         WITH loc_oBotoes.cmd_4c_Visualizar
198:             .Caption         = "Visualizar"
199:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
200:             .PicturePosition = 13
201:             .Top             = 5
202:             .Left            = 80
203:             .Width           = 75
204:             .Height          = 75
205:             .FontName        = "Comic Sans MS"
206:             .FontSize        = 8
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .ForeColor       = RGB(90, 90, 90)
210:             .BackColor       = RGB(255, 255, 255)
211:             .Themes          = .F.
212:             .SpecialEffect   = 0
213:             .WordWrap        = .T.
214:             .MousePointer    = 15
215:             .Visible         = .T.
216:         ENDWITH
217:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
218: 
219:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
220:         WITH loc_oBotoes.cmd_4c_Alterar
221:             .Caption         = "Alterar"
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:             .PicturePosition = 13
224:             .Top             = 5
225:             .Left            = 155
226:             .Width           = 75
227:             .Height          = 75
228:             .FontName        = "Comic Sans MS"
229:             .FontSize        = 8
230:             .FontBold        = .T.
231:             .FontItalic      = .T.
232:             .ForeColor       = RGB(90, 90, 90)
233:             .BackColor       = RGB(255, 255, 255)
234:             .Themes          = .F.
235:             .SpecialEffect   = 0
236:             .WordWrap        = .T.
237:             .MousePointer    = 15
238:             .Visible         = .T.
239:         ENDWITH
240:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
241: 
242:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
243:         WITH loc_oBotoes.cmd_4c_Excluir
244:             .Caption         = "Excluir"
245:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
246:             .PicturePosition = 13
247:             .Top             = 5
248:             .Left            = 230
249:             .Width           = 75
250:             .Height          = 75
251:             .FontName        = "Comic Sans MS"
252:             .FontSize        = 8
253:             .FontBold        = .T.
254:             .FontItalic      = .T.
255:             .ForeColor       = RGB(90, 90, 90)
256:             .BackColor       = RGB(255, 255, 255)
257:             .Themes          = .F.
258:             .SpecialEffect   = 0
259:             .WordWrap        = .T.
260:             .MousePointer    = 15
261:             .Visible         = .T.
262:         ENDWITH
263:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
264: 
265:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
266:         WITH loc_oBotoes.cmd_4c_Buscar
267:             .Caption         = "Buscar"
268:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
269:             .PicturePosition = 13
270:             .Top             = 5
271:             .Left            = 305
272:             .Width           = 75
273:             .Height          = 75
274:             .FontName        = "Comic Sans MS"
275:             .FontSize        = 8
276:             .FontBold        = .T.
277:             .FontItalic      = .T.
278:             .ForeColor       = RGB(90, 90, 90)
279:             .BackColor       = RGB(255, 255, 255)
280:             .Themes          = .F.
281:             .SpecialEffect   = 0
282:             .WordWrap        = .T.
283:             .MousePointer    = 15
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
287: 
288:         *-- Container encerrar/saida (canonico: Left=917, Width=90)
289:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
290:         loc_oSaida = loc_oPg1.cnt_4c_Saida
291:         WITH loc_oSaida
292:             .Top         = 29
293:             .Left        = 917
294:             .Width       = 90
295:             .Height      = 85
296:             .BackStyle   = 0
297:             .BorderWidth = 0
298:             .Visible     = .T.
299:         ENDWITH
300: 
301:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
302:         WITH loc_oSaida.cmd_4c_Encerrar
303:             .Caption         = "Encerrar"
304:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
305:             .PicturePosition = 13
306:             .Top             = 5
307:             .Left            = 5
308:             .Width           = 75
309:             .Height          = 75
310:             .FontName        = "Comic Sans MS"
311:             .FontSize        = 8
312:             .FontBold        = .T.
313:             .FontItalic      = .T.
314:             .ForeColor       = RGB(90, 90, 90)
315:             .BackColor       = RGB(255, 255, 255)
316:             .Themes          = .F.
317:             .SpecialEffect   = 0
318:             .WordWrap        = .T.
319:             .MousePointer    = 15
320:             .Visible         = .T.
321:         ENDWITH
322:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
323: 
324:         *-- Grid de lista (Problema 36: RecordSource e ColumnCount FORA do WITH)
325:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
326:         loc_oGrid = loc_oPg1.grd_4c_Lista
327:         loc_oGrid.RecordSource = ""
328:         loc_oGrid.ColumnCount  = 2
329:         WITH loc_oGrid
330:             .Top                = 121
331:             .Left               = 12
332:             .Width              = 940
333:             .Height             = 470
334:             .FontName           = "Verdana"
335:             .FontSize           = 8
336:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 347 a 360:
347:             .Visible            = .T.
348:         ENDWITH
349:         WITH loc_oGrid.Column1
350:             .Header1.Caption = "C" + CHR(243) + "digo"
351:             .Width           = 90
352:             .ReadOnly        = .T.
353:         ENDWITH
354:         WITH loc_oGrid.Column2
355:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
356:             .Width           = 337
357:             .ReadOnly        = .T.
358:         ENDWITH
359: 
360:         THIS.TornarControlesVisiveis(loc_oPg1)

*-- Linhas 376 a 445:
376:         loc_oPg2.AddObject("cnt_4c_Salva", "Container")
377:         loc_oSalva = loc_oPg2.cnt_4c_Salva
378:         WITH loc_oSalva
379:             .Top         = 46
380:             .Left        = 611
381:             .Width       = 160
382:             .Height      = 85
383:             .BackStyle   = 0
384:             .Visible     = .T.
385:         ENDWITH
386: 
387:         *-- Botao Confirmar (Salva: Top=5, Left=5)
388:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
389:         WITH loc_oSalva.cmd_4c_Confirmar
390:             .Caption         = "Confirmar"
391:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
392:             .PicturePosition = 13
393:             .Top             = 5
394:             .Left            = 5
395:             .Width           = 75
396:             .Height          = 75
397:             .FontName        = "Comic Sans MS"
398:             .FontSize        = 8
399:             .FontBold        = .T.
400:             .FontItalic      = .T.
401:             .ForeColor       = RGB(90, 90, 90)
402:             .BackColor       = RGB(255, 255, 255)
403:             .Themes          = .F.
404:             .SpecialEffect   = 0
405:             .WordWrap        = .T.
406:             .MousePointer    = 15
407:             .Visible         = .T.
408:         ENDWITH
409:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
410: 
411:         *-- Botao Cancelar (Cancelar: Top=5, Left=80)
412:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
413:         WITH loc_oSalva.cmd_4c_Cancelar
414:             .Caption         = "Encerrar"
415:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
416:             .PicturePosition = 13
417:             .Top             = 5
418:             .Left            = 80
419:             .Width           = 75
420:             .Height          = 75
421:             .FontName        = "Comic Sans MS"
422:             .FontSize        = 8
423:             .FontBold        = .T.
424:             .FontItalic      = .T.
425:             .ForeColor       = RGB(90, 90, 90)
426:             .BackColor       = RGB(255, 255, 255)
427:             .Themes          = .F.
428:             .SpecialEffect   = 0
429:             .WordWrap        = .T.
430:             .MousePointer    = 15
431:             .Visible         = .T.
432:         ENDWITH
433:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
434: 
435:         *-- Say1/lbl_4c_Label1: "Codigo : " Top=153, Left=215, ForeColor=90,90,90
436:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
437:         WITH loc_oPg2.lbl_4c_Label1
438:             .Caption   = "C" + CHR(243) + "digo : "
439:             .Top       = 153
440:             .Left      = 215
441:             .Width     = 45
442:             .Height    = 17
443:             .FontName  = "Tahoma"
444:             .FontSize  = 8
445:             .FontBold  = .F.

*-- Linhas 453 a 480:
453:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
454:         WITH loc_oPg2.txt_4c_Codigo
455:             .Value       = ""
456:             .Top         = 150
457:             .Left        = 263
458:             .Width       = 72
459:             .Height      = 23
460:             .MaxLength   = 10
461:             .FontName    = "Tahoma"
462:             .FontSize    = 8
463:             .FontItalic  = .F.
464:             .ForeColor   = RGB(90, 90, 90)
465:             .BackColor   = RGB(255, 255, 255)
466:             .BorderStyle = 1
467:             .Visible     = .T.
468:         ENDWITH
469: 
470:         *-- Say2/lbl_4c_Label2: "Descricao : " Top=178, Left=202, ForeColor=90,90,90
471:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
472:         WITH loc_oPg2.lbl_4c_Label2
473:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
474:             .Top       = 178
475:             .Left      = 202
476:             .Width     = 59
477:             .Height    = 17
478:             .FontName  = "Tahoma"
479:             .FontSize  = 8
480:             .FontBold  = .F.

*-- Linhas 488 a 497:
488:         loc_oPg2.AddObject("txt_4c_Desc", "TextBox")
489:         WITH loc_oPg2.txt_4c_Desc
490:             .Value       = ""
491:             .Top         = 175
492:             .Left        = 263
493:             .Width       = 240
494:             .Height      = 23
495:             .MaxLength   = 40
496:             .FontName    = "Tahoma"
497:             .FontSize    = 8

*-- Linhas 523 a 532:
523:                         loc_oPg1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
524:                         loc_oPg1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.cods"
525:                         loc_oPg1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descs"
526:                         loc_oPg1.grd_4c_Lista.Column1.Header1.Caption = "C" + CHR(243) + "digo"
527:                         loc_oPg1.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
528:                         THIS.FormatarGridLista(loc_oPg1.grd_4c_Lista)
529:                     ENDIF
530: 
531:                     loc_lResultado = .T.
532:                 ENDIF

*-- Linhas 745 a 754:
745:                         loc_oPg1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
746:                         loc_oPg1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.cods"
747:                         loc_oPg1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descs"
748:                         loc_oPg1.grd_4c_Lista.Column1.Header1.Caption = "C" + CHR(243) + "digo"
749:                         loc_oPg1.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
750:                         THIS.FormatarGridLista(loc_oPg1.grd_4c_Lista)
751:                     ENDIF
752:                 ENDIF
753: 
754:                 loc_oBusca.Release()

*-- Linhas 860 a 869:
860: 
861:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
862:             WITH loc_oPg2.cnt_4c_Salva
863:                 .cmd_4c_Confirmar.Enabled = loc_lEdicao
864:                 .cmd_4c_Cancelar.Enabled  = .T.
865:                 .Visible     = .T.
866:             ENDWITH
867:         ENDIF
868: 
869:         THIS.HabilitarCampos(loc_lEdicao)


### BO (C:\4c\projeto\app\classes\lctBO.prg):
*==============================================================================
* lctBO.prg - Business Object: Cadastro de Lancamentos
* Tabela: SigCdLct
* PK: cidchaves (char 20, gerada por GerarIdUnico())
* Chave negocio: cods (char 10, unica, validada no Inserir)
*==============================================================================
DEFINE CLASS lctBO AS BusinessBase

    *-- Propriedades da tabela SigCdLct
    this_cCods      = ""   && char(10) - Codigo de lancamento (chave negocio)
    this_cCidChaves = ""   && char(20) - Chave primaria interna (PK)
    this_cDescs     = ""   && char(40) - Descricao do lancamento

    *-- Configuracao do BO
    this_cTabela     = "SigCdLct"
    this_cCampoChave = "cidchaves"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdLct"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro(loException.Message, "lctBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCods      = TratarNulo(cods,      "C")
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDescs     = TratarNulo(descs,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "lctBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCods)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCods)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdLct" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkLct")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkLct")
                SELECT cursor_4c_ChkLct
                loc_lExiste = (cursor_4c_ChkLct.qtd > 0)
                USE IN cursor_4c_ChkLct
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "lctBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cNovaChave
        loc_lSucesso = .F.

        TRY
            loc_cNovaChave = fUniqueIds()
            THIS.this_cCidChaves = loc_cNovaChave

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdLct (cods, cidchaves, descs)
                VALUES (
                    <<EscaparSQL(THIS.this_cCods)>>,
                    <<EscaparSQL(loc_cNovaChave)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "lctBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdLct
                SET descs = <<EscaparSQL(THIS.this_cDescs)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCods)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "lctBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdLct WHERE cods = " + EscaparSQL(THIS.this_cCods)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "lctBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(10), descs C(40))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cods, descs FROM SigCdLct"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY cods"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "lctBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, cidchaves, descs FROM SigCdLct" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Lan" + CHR(231) + "amento n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "lctBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

