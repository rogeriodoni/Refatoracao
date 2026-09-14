# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 182: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 206: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 230: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 254: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 278: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 314: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 391: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 415: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormLOC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1065 linhas total):

*-- Linhas 48 a 57:
48:                     "FormLOC.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Visible   = .T.
54:                 THIS.pgf_4c_Paginas.ActivePage = 1
55:                 THIS.this_cModoAtual = "LISTA"
56: 
57:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 80 a 99:
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount = 2
83:             .Top       = -29
84:             .Left      = 0
85:             .Width     = THIS.Width
86:             .Height    = THIS.Height + 29
87:             .Tabs      = .F.
88:             .Visible   = .T.
89: 
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93: 
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(255, 255, 255)
97:         ENDWITH
98: 
99:         THIS.ConfigurarPaginaLista()

*-- Linhas 112 a 152:
112:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113: 
114:         *-- Container Cabecalho (cntSombra no legado)
115:         *-- Legado: cntSombra.Top=1. Com compensacao PageFrame.Top=-29: Top=30 (1+29)
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 30
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption   = THIS.Caption
130:             .Top       = 15
131:             .Left      = 10
132:             .Width     = 769
133:             .Height    = 40
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .AutoSize  = .F.
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = THIS.Caption
146:             .Top       = 18
147:             .Left      = 10
148:             .Width     = 769
149:             .Height    = 46
150:             .FontName  = "Tahoma"
151:             .FontSize  = 16
152:             .FontBold  = .T.

*-- Linhas 160 a 338:
160:         *-- Canonico: Left=542, Top=29 (-1+29+1=29), Width=390, Height=85
161:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
162:         WITH loc_oPagina.cnt_4c_Botoes
163:             .Top         = 29
164:             .Left        = 542
165:             .Width       = 390
166:             .Height      = 85
167:             .BackStyle   = 0
168:             .BorderWidth = 0
169:             .Visible     = .T.
170:         ENDWITH
171: 
172:         *-- Botao Incluir
173:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
174:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
175:             .Caption         = "Incluir"
176:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
177:             .PicturePosition = 13
178:             .Top             = 5
179:             .Left            = 5
180:             .Width           = 75
181:             .Height          = 75
182:             .FontName        = "Comic Sans MS"
183:             .FontBold        = .T.
184:             .FontItalic      = .T.
185:             .FontSize        = 8
186:             .ForeColor       = RGB(90, 90, 90)
187:             .BackColor       = RGB(255, 255, 255)
188:             .Themes          = .F.
189:             .SpecialEffect   = 0
190:             .MousePointer    = 15
191:             .WordWrap        = .T.
192:             .AutoSize        = .F.
193:         ENDWITH
194:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
195: 
196:         *-- Botao Visualizar
197:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
198:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
199:             .Caption         = "Visualizar"
200:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
201:             .PicturePosition = 13
202:             .Top             = 5
203:             .Left            = 80
204:             .Width           = 75
205:             .Height          = 75
206:             .FontName        = "Comic Sans MS"
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .FontSize        = 8
210:             .ForeColor       = RGB(90, 90, 90)
211:             .BackColor       = RGB(255, 255, 255)
212:             .Themes          = .F.
213:             .SpecialEffect   = 0
214:             .MousePointer    = 15
215:             .WordWrap        = .T.
216:             .AutoSize        = .F.
217:         ENDWITH
218:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
219: 
220:         *-- Botao Alterar
221:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
222:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
223:             .Caption         = "Alterar"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
225:             .PicturePosition = 13
226:             .Top             = 5
227:             .Left            = 155
228:             .Width           = 75
229:             .Height          = 75
230:             .FontName        = "Comic Sans MS"
231:             .FontBold        = .T.
232:             .FontItalic      = .T.
233:             .FontSize        = 8
234:             .ForeColor       = RGB(90, 90, 90)
235:             .BackColor       = RGB(255, 255, 255)
236:             .Themes          = .F.
237:             .SpecialEffect   = 0
238:             .MousePointer    = 15
239:             .WordWrap        = .T.
240:             .AutoSize        = .F.
241:         ENDWITH
242:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
243: 
244:         *-- Botao Excluir
245:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
246:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
247:             .Caption         = "Excluir"
248:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
249:             .PicturePosition = 13
250:             .Top             = 5
251:             .Left            = 230
252:             .Width           = 75
253:             .Height          = 75
254:             .FontName        = "Comic Sans MS"
255:             .FontBold        = .T.
256:             .FontItalic      = .T.
257:             .FontSize        = 8
258:             .ForeColor       = RGB(90, 90, 90)
259:             .BackColor       = RGB(255, 255, 255)
260:             .Themes          = .F.
261:             .SpecialEffect   = 0
262:             .MousePointer    = 15
263:             .WordWrap        = .T.
264:             .AutoSize        = .F.
265:         ENDWITH
266:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
267: 
268:         *-- Botao Buscar
269:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
270:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
271:             .Caption         = "Buscar"
272:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
273:             .PicturePosition = 13
274:             .Top             = 5
275:             .Left            = 305
276:             .Width           = 75
277:             .Height          = 75
278:             .FontName        = "Comic Sans MS"
279:             .FontBold        = .T.
280:             .FontItalic      = .T.
281:             .FontSize        = 8
282:             .ForeColor       = RGB(90, 90, 90)
283:             .BackColor       = RGB(255, 255, 255)
284:             .Themes          = .F.
285:             .SpecialEffect   = 0
286:             .MousePointer    = 15
287:             .WordWrap        = .T.
288:             .AutoSize        = .F.
289:         ENDWITH
290:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
291: 
292:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
293:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
294:         WITH loc_oPagina.cnt_4c_Saida
295:             .Top         = 29
296:             .Left        = 917
297:             .Width       = 90
298:             .Height      = 85
299:             .BackStyle   = 0
300:             .BorderWidth = 0
301:             .Visible     = .T.
302:         ENDWITH
303: 
304:         *-- Botao Encerrar - PADRAO CANONICO (CLAUDE.md regra #10)
305:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
306:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
307:             .Caption         = "Encerrar"
308:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
309:             .PicturePosition = 13
310:             .Top             = 5
311:             .Left            = 5
312:             .Width           = 75
313:             .Height          = 75
314:             .FontName        = "Comic Sans MS"
315:             .FontBold        = .T.
316:             .FontItalic      = .T.
317:             .FontSize        = 8
318:             .ForeColor       = RGB(90, 90, 90)
319:             .BackColor       = RGB(255, 255, 255)
320:             .Themes          = .F.
321:             .SpecialEffect   = 0
322:             .MousePointer    = 15
323:             .WordWrap        = .T.
324:             .AutoSize        = .F.
325:         ENDWITH
326:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
327: 
328:         *-- Grid de Lista (Grade no legado: top=121, left=12, width=940)
329:         *-- Com compensacao PageFrame.Top=-29: Top = 121 + 29 = 150
330:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
331:         WITH loc_oPagina.grd_4c_Lista
332:             .Top                = 150
333:             .Left               = 12
334:             .Width              = 940
335:             .Height             = 469
336:             .FontName           = "Verdana"
337:             .FontSize           = 8
338:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 368 a 440:
368:         *-- Com compensacao PageFrame +29: Top=38 (9+29)
369:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
370:         WITH loc_oPagina.cnt_4c_BotoesAcao
371:             .Top         = 38
372:             .Left        = 842
373:             .Width       = 160
374:             .Height      = 85
375:             .BackStyle = 0
376:             .BackColor   = RGB(255, 255, 255)
377:             .BorderWidth = 0
378:             .Visible     = .T.
379:         ENDWITH
380: 
381:         *-- Botao Confirmar (Salva.Left=5, Top=5)
382:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
383:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
384:             .Caption         = "Confirmar"
385:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
386:             .PicturePosition = 13
387:             .Top             = 5
388:             .Left            = 5
389:             .Width           = 75
390:             .Height          = 75
391:             .FontName        = "Comic Sans MS"
392:             .FontBold        = .T.
393:             .FontItalic      = .T.
394:             .FontSize        = 8
395:             .ForeColor       = RGB(90, 90, 90)
396:             .BackColor       = RGB(255, 255, 255)
397:             .Themes          = .F.
398:             .SpecialEffect   = 0
399:             .MousePointer    = 15
400:             .WordWrap        = .T.
401:             .AutoSize        = .F.
402:         ENDWITH
403:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
404: 
405:         *-- Botao Cancelar (Cancelar.Left=88, Top=5)
406:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
407:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
408:             .Caption         = "Encerrar"
409:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
410:             .PicturePosition = 13
411:             .Top             = 5
412:             .Left            = 80
413:             .Width           = 75
414:             .Height          = 75
415:             .FontName        = "Comic Sans MS"
416:             .FontBold        = .T.
417:             .FontItalic      = .T.
418:             .FontSize        = 8
419:             .ForeColor       = RGB(90, 90, 90)
420:             .BackColor       = RGB(255, 255, 255)
421:             .Themes          = .F.
422:             .SpecialEffect   = 0
423:             .MousePointer    = 15
424:             .WordWrap        = .T.
425:             .AutoSize        = .F.
426:         ENDWITH
427:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
428: 
429:         *-- Label1: " Codigo " (Top=126+29=155, Left=112, Width=50)
430:         *-- ForeColor=RGB(36,84,155), FontName="Verdana", FontSize=8 - EXATO do original
431:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
432:         WITH loc_oPagina.lbl_4c_Label1
433:             .Caption   = " C" + CHR(243) + "digo "
434:             .Top       = 155
435:             .Left      = 112
436:             .Width     = 50
437:             .Height    = 15
438:             .FontName  = "Verdana"
439:             .FontSize  = 8
440:             .FontBold  = .F.

*-- Linhas 450 a 475:
450:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
451:         WITH loc_oPagina.txt_4c_Codigo
452:             .Value     = ""
453:             .Top       = 171
454:             .Left      = 112
455:             .Width     = 80
456:             .Height    = 23
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .MaxLength = 10
460:             .TabIndex  = 1
461:             .Visible   = .T.
462:         ENDWITH
463: 
464:         *-- Label3: " Conexao em SQL " (Top=174+29=203, Left=112, Width=114)
465:         *-- ForeColor=RGB(36,84,155), FontName="Verdana", FontSize=8 - EXATO do original
466:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
467:         WITH loc_oPagina.lbl_4c_Label3
468:             .Caption   = " Conex" + CHR(227) + "o  em SQL "
469:             .Top       = 203
470:             .Left      = 112
471:             .Width     = 114
472:             .Height    = 15
473:             .FontName  = "Verdana"
474:             .FontSize  = 8
475:             .FontBold  = .F.

*-- Linhas 485 a 511:
485:         loc_oPagina.AddObject("txt_4c_Conexao", "TextBox")
486:         WITH loc_oPagina.txt_4c_Conexao
487:             .Value     = ""
488:             .Top       = 220
489:             .Left      = 112
490:             .Width     = 150
491:             .Height    = 23
492:             .FontName  = "Tahoma"
493:             .FontSize  = 8
494:             .MaxLength = 30
495:             .TabIndex  = 2
496:             .Visible   = .T.
497:         ENDWITH
498:         BINDEVENT(loc_oPagina.txt_4c_Conexao, "KeyPress", THIS, "ValidarConexao")
499: 
500:         *-- Label2: " Caminho dos Arquivos em .DBF " (Top=225+29=254, Left=112, Width=192)
501:         *-- ForeColor=RGB(36,84,155), FontName="Verdana", FontSize=8 - EXATO do original
502:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
503:         WITH loc_oPagina.lbl_4c_Label2
504:             .Caption   = " Caminho dos Arquivos em .DBF "
505:             .Top       = 254
506:             .Left      = 112
507:             .Width     = 192
508:             .Height    = 15
509:             .FontName  = "Verdana"
510:             .FontSize  = 8
511:             .FontBold  = .F.

*-- Linhas 521 a 530:
521:         loc_oPagina.AddObject("txt_4c_Dbfs", "TextBox")
522:         WITH loc_oPagina.txt_4c_Dbfs
523:             .Value     = ""
524:             .Top       = 271
525:             .Left      = 112
526:             .Width     = 570
527:             .Height    = 23
528:             .FontName  = "Tahoma"
529:             .FontSize  = 8
530:             .MaxLength = 250

*-- Linhas 569 a 579:
569:                 loc_oGrid.Column3.Width = 400
570: 
571:                 *-- Headers APOS RecordSource (Problema 2/32: RecordSource reseta captions)
572:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
573:                 loc_oGrid.Column2.Header1.Caption = "Conex" + CHR(227) + "o"
574:                 loc_oGrid.Column3.Header1.Caption = "Caminho Para Tabelas"
575: 
576:                 THIS.FormatarGridLista(loc_oGrid)
577:                 loc_lResultado = .T.
578:             ENDIF
579: 

*-- Linhas 1002 a 1014:
1002:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1003: 
1004:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1005:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1006:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1007:             ENDIF
1008:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1009:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1010:             ENDIF
1011:         ENDIF
1012:     ENDPROC
1013: 
1014:     *==========================================================================


### BO (C:\4c\projeto\app\classes\LOCBO.prg):
*==============================================================================
* LOCBO.prg - Business Object para Cadastro de Locais
* Tabela: SigCdLoc
* PK: cods (char 10)
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS LOCBO AS BusinessBase

    *-- Propriedades de dados (this_c* = Character)
    this_cCodigo  = ""    && cods     char(10) PK
    this_cConexao = ""    && cidconns char(20)
    this_cDrives  = ""    && drives   char(80)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdLoc"
            THIS.this_cCampoChave = "cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "LOCBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCodigo  = ""
        THIS.this_cConexao = ""
        THIS.this_cDrives  = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo  = TratarNulo(cods,     "C")
                THIS.this_cConexao = TratarNulo(cidconns, "C")
                THIS.this_cDrives  = TratarNulo(drives,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "LOCBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cCaminho
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cConexao))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conex" + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cDrives))
            loc_cCaminho = ALLTRIM(THIS.this_cDrives)
            IF RIGHT(loc_cCaminho, 1) <> "\"
                loc_cCaminho = loc_cCaminho + "\"
            ENDIF
            IF !FILE(loc_cCaminho + "SigCdLoc.DBF")
                MsgAviso("O Diret" + CHR(243) + "rio de Destino " + CHR(34) + loc_cCaminho + CHR(34) + ;
                    " N" + CHR(227) + "o " + CHR(233) + " Um Diret" + CHR(243) + "rio V" + CHR(225) + "lido!!!" + CHR(13) + ;
                    "O Mesmo Pode N" + CHR(227) + "o Existir, N" + CHR(227) + "o Estar Acess" + CHR(237) + "vel" + ;
                    " ou N" + CHR(227) + "o Conter o Arquivo " + CHR(34) + "SigCdLoc.DBF" + CHR(34) + "!!!")
                loc_lValido = .F.
            ELSE
                THIS.this_cDrives = loc_cCaminho
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se cods ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdLoc" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkLoc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkLoc")
                SELECT cursor_4c_ChkLoc
                loc_lExiste = (cursor_4c_ChkLoc.qtd > 0)
                USE IN cursor_4c_ChkLoc
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "LOCBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdLoc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdLoc (cods, cidconns, drives)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cConexao)>>,
                    <<EscaparSQL(THIS.this_cDrives)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir local:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "LOCBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdLoc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdLoc
                SET cidconns = <<EscaparSQL(THIS.this_cConexao)>>,
                    drives   = <<EscaparSQL(THIS.this_cDrives)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar local:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "LOCBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdLoc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdLoc WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir local:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "LOCBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, cidconns, drives
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(10), cidconns C(20), drives C(80))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cods, cidconns, drives FROM SigCdLoc"

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
                        MostrarErro("Erro ao buscar locais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar locais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "LOCBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, cidconns, drives FROM SigCdLoc" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Local n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar local:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "LOCBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

