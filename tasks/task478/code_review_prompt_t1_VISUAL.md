# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 166: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 191: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 216: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 241: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 266: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 301: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 389: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 413: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOcc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (794 linhas total):

*-- Linhas 44 a 52:
44:         loc_lSucesso = .F.
45:         TRY
46:             loc_cCaption = "Ocorr" + CHR(234) + "ncias de Corre" + CHR(231) + CHR(227) + "o"
47:             THIS.Caption = loc_cCaption
48: 
49:             THIS.this_oBusinessObject = CREATEOBJECT("OccBO")
50:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
51:                 THIS.ConfigurarPageFrame()
52:                 THIS.ConfigurarPaginaLista()

*-- Linhas 76 a 93:
76:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
77:         WITH THIS.pgf_4c_Paginas
78:             .PageCount  = 2
79:             .Top        = -29
80:             .Left       = 0
81:             .Width      = THIS.Width
82:             .Height     = THIS.Height + 29
83:             .Tabs       = .F.
84:             .TabStretch = 1
85:             .Visible    = .T.
86:             .Page1.Caption = "Lista"
87:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
88:             .Page2.Caption = "Dados"
89:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90:         ENDWITH
91:     ENDPROC
92: 
93:     *--------------------------------------------------------------------------

*-- Linhas 104 a 327:
104:         *-- Container cabecalho (cntSombra: Top=1 -> compensado: Top=30)
105:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
106:         WITH loc_oPagina.cnt_4c_Cabecalho
107:             .Top         = 30
108:             .Left        = 0
109:             .Width       = THIS.Width
110:             .Height      = 80
111:             .BackColor   = RGB(100, 100, 100)
112:             .BorderWidth = 0
113:             .Visible     = .T.
114:         ENDWITH
115:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
116:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
117:             .Top       = 15
118:             .Left      = 10
119:             .Width     = 769
120:             .Height    = 40
121:             .Caption   = loc_cCaption
122:             .FontName  = "Tahoma"
123:             .FontSize  = 16
124:             .FontBold  = .T.
125:             .ForeColor = RGB(0, 0, 0)
126:             .BackStyle = 0
127:             .Visible   = .T.
128:         ENDWITH
129:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
130:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
131:             .Top       = 18
132:             .Left      = 10
133:             .Width     = 769
134:             .Height    = 46
135:             .Caption   = loc_cCaption
136:             .FontName  = "Tahoma"
137:             .FontSize  = 16
138:             .FontBold  = .T.
139:             .ForeColor = RGB(255, 255, 255)
140:             .BackStyle = 0
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         *-- Container botoes CRUD (Grupo_op: Left=544, Top=-1 -> compensado: Top=28)
145:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
146:         WITH loc_oPagina.cnt_4c_Botoes
147:             .Top         = 28
148:             .Left        =  542
149:             .Width       = 385
150:             .Height      = 85
151:             .BackStyle = 0
152:             .BorderWidth = 0
153:             .Visible     = .T.
154:         ENDWITH
155: 
156:         *-- Botao Incluir
157:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
158:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
159:             .Top             = 5
160:             .Left            = 5
161:             .Width           = 75
162:             .Height          = 75
163:             .Caption         = "Incluir"
164:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
165:             .PicturePosition = 13
166:             .FontName        = "Comic Sans MS"
167:             .FontSize        = 8
168:             .FontBold        = .T.
169:             .FontItalic      = .T.
170:             .ForeColor       = RGB(90, 90, 90)
171:             .BackColor       = RGB(255, 255, 255)
172:             .Themes          = .F.
173:             .SpecialEffect   = 0
174:             .MousePointer    = 15
175:             .WordWrap        = .T.
176:             .AutoSize        = .F.
177:             .Visible         = .T.
178:         ENDWITH
179:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
180: 
181:         *-- Botao Visualizar
182:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
183:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
184:             .Top             = 5
185:             .Left            = 80
186:             .Width           = 75
187:             .Height          = 75
188:             .Caption         = "Visualizar"
189:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
190:             .PicturePosition = 13
191:             .FontName        = "Comic Sans MS"
192:             .FontSize        = 8
193:             .FontBold        = .T.
194:             .FontItalic      = .T.
195:             .ForeColor       = RGB(90, 90, 90)
196:             .BackColor       = RGB(255, 255, 255)
197:             .Themes          = .F.
198:             .SpecialEffect   = 0
199:             .MousePointer    = 15
200:             .WordWrap        = .T.
201:             .AutoSize        = .F.
202:             .Visible         = .T.
203:         ENDWITH
204:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
205: 
206:         *-- Botao Alterar
207:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
208:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
209:             .Top             = 5
210:             .Left            = 155
211:             .Width           = 75
212:             .Height          = 75
213:             .Caption         = "Alterar"
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
215:             .PicturePosition = 13
216:             .FontName        = "Comic Sans MS"
217:             .FontSize        = 8
218:             .FontBold        = .T.
219:             .FontItalic      = .T.
220:             .ForeColor       = RGB(90, 90, 90)
221:             .BackColor       = RGB(255, 255, 255)
222:             .Themes          = .F.
223:             .SpecialEffect   = 0
224:             .MousePointer    = 15
225:             .WordWrap        = .T.
226:             .AutoSize        = .F.
227:             .Visible         = .T.
228:         ENDWITH
229:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
230: 
231:         *-- Botao Excluir
232:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
233:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
234:             .Top             = 5
235:             .Left            = 230
236:             .Width           = 75
237:             .Height          = 75
238:             .Caption         = "Excluir"
239:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
240:             .PicturePosition = 13
241:             .FontName        = "Comic Sans MS"
242:             .FontSize        = 8
243:             .FontBold        = .T.
244:             .FontItalic      = .T.
245:             .ForeColor       = RGB(90, 90, 90)
246:             .BackColor       = RGB(255, 255, 255)
247:             .Themes          = .F.
248:             .SpecialEffect   = 0
249:             .MousePointer    = 15
250:             .WordWrap        = .T.
251:             .AutoSize        = .F.
252:             .Visible         = .T.
253:         ENDWITH
254:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
255: 
256:         *-- Botao Buscar
257:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
258:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
259:             .Top             = 5
260:             .Left            = 305
261:             .Width           = 75
262:             .Height          = 75
263:             .Caption         = "Buscar"
264:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
265:             .PicturePosition = 13
266:             .FontName        = "Comic Sans MS"
267:             .FontSize        = 8
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .ForeColor       = RGB(90, 90, 90)
271:             .BackColor       = RGB(255, 255, 255)
272:             .Themes          = .F.
273:             .SpecialEffect   = 0
274:             .MousePointer    = 15
275:             .WordWrap        = .T.
276:             .AutoSize        = .F.
277:             .Visible         = .T.
278:         ENDWITH
279:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
280: 
281:         *-- Container saida - PADRAO CANONICO (CLAUDE.md regra #10)
282:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
283:         WITH loc_oPagina.cnt_4c_Saida
284:             .Top         = 29
285:             .Left        = 917
286:             .Width       = 90
287:             .Height      = 85
288:             .BackStyle   = 0
289:             .BorderWidth = 0
290:             .Visible     = .T.
291:         ENDWITH
292:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
293:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
294:             .Top             = 5
295:             .Left            = 5
296:             .Width           = 75
297:             .Height          = 75
298:             .Caption         = "Encerrar"
299:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
300:             .PicturePosition = 13
301:             .FontName        = "Comic Sans MS"
302:             .FontSize        = 8
303:             .FontBold        = .T.
304:             .FontItalic      = .T.
305:             .ForeColor       = RGB(90, 90, 90)
306:             .BackColor       = RGB(255, 255, 255)
307:             .Themes          = .F.
308:             .SpecialEffect   = 0
309:             .MousePointer    = 15
310:             .WordWrap        = .T.
311:             .AutoSize        = .F.
312:             .Visible         = .T.
313:         ENDWITH
314:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
315: 
316:         *-- Grid de lista (Grade: Top=121, Left=12, Width=971, Height=470)
317:         *-- Compensacao PageFrame.Top=-29: Top = 121+29 = 150
318:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
319:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
320:         WITH loc_oPagina.grd_4c_Lista
321:             .Top               = 150
322:             .Left              = 12
323:             .Width             = 971
324:             .Height            = 470
325:             .FontName          = "Verdana"
326:             .FontSize          = 8
327:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 341 a 356:
341:             .Width             = 80
342:             .Alignment         = 2
343:             .ReadOnly          = .T.
344:             .Header1.Caption   = "C" + CHR(243) + "digo"
345:             .Header1.Alignment = 2
346:         ENDWITH
347:         WITH loc_oPagina.grd_4c_Lista.Column2
348:             .Width             = 200
349:             .Alignment         = 0
350:             .ReadOnly          = .T.
351:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
352:             .Header1.Alignment = 0
353:         ENDWITH
354: 
355:         THIS.TornarControlesVisiveis(loc_oPagina)
356:     ENDPROC

*-- Linhas 369 a 481:
369:         *-- Compensacao: Top = -5+29 = 24
370:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
371:         WITH loc_oPagina.cnt_4c_BotoesAcao
372:             .Top         = 24
373:             .Left        = 836
374:             .Width       = 161
375:             .Height      = 85
376:             .BackStyle   = 0
377:             .BorderWidth = 0
378:             .Visible     = .T.
379:         ENDWITH
380:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
381:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
382:             .Top             = 5
383:             .Left            = 5
384:             .Width           = 75
385:             .Height          = 75
386:             .Caption         = "Confirmar"
387:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
388:             .PicturePosition = 13
389:             .FontName        = "Comic Sans MS"
390:             .FontSize        = 8
391:             .FontBold        = .T.
392:             .FontItalic      = .T.
393:             .ForeColor       = RGB(90, 90, 90)
394:             .BackColor       = RGB(255, 255, 255)
395:             .Themes          = .F.
396:             .SpecialEffect   = 0
397:             .MousePointer    = 15
398:             .WordWrap        = .T.
399:             .AutoSize        = .F.
400:             .Visible         = .T.
401:         ENDWITH
402:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
403: 
404:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
405:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
406:             .Top             = 5
407:             .Left            = 81
408:             .Width           = 75
409:             .Height          = 75
410:             .Caption         = "Encerrar"
411:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
412:             .PicturePosition = 13
413:             .FontName        = "Comic Sans MS"
414:             .FontSize        = 8
415:             .FontBold        = .T.
416:             .FontItalic      = .T.
417:             .ForeColor       = RGB(90, 90, 90)
418:             .BackColor       = RGB(255, 255, 255)
419:             .Themes          = .F.
420:             .SpecialEffect   = 0
421:             .MousePointer    = 15
422:             .WordWrap        = .T.
423:             .AutoSize        = .F.
424:             .Visible         = .T.
425:         ENDWITH
426:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
427: 
428:         *-- Label "Codigo :" (Say1: Top=140, Left=311 -> compensado: Top=169)
429:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
430:         WITH loc_oPagina.lbl_4c_Label1
431:             .Top       = 169
432:             .Left      = 311
433:             .AutoSize  = .T.
434:             .Caption   = "C" + CHR(243) + "digo : "
435:             .FontName  = "Tahoma"
436:             .FontSize  = 8
437:             .ForeColor = RGB(90, 90, 90)
438:             .BackStyle = 0
439:             .Visible   = .T.
440:         ENDWITH
441: 
442:         *-- TextBox Codigo (Get_ncodigo: Top=137, Left=359, Width=31 -> compensado: Top=166)
443:         loc_oPagina.AddObject("txt_4c_Ncodigo", "TextBox")
444:         WITH loc_oPagina.txt_4c_Ncodigo
445:             .Top           = 166
446:             .Left          = 359
447:             .Width         = 31
448:             .Height        = 22
449:             .Value         = 0
450:             .InputMask     = "999"
451:             .FontName      = "Tahoma"
452:             .FontSize      = 8
453:             .ForeColor     = RGB(0, 0, 0)
454:             .SpecialEffect = 1
455:             .Visible       = .T.
456:         ENDWITH
457: 
458:         *-- Label "Descricao :" (Say2: Top=166, Left=298 -> compensado: Top=195)
459:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
460:         WITH loc_oPagina.lbl_4c_Label2
461:             .Top       = 195
462:             .Left      = 298
463:             .AutoSize  = .T.
464:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
465:             .FontName  = "Tahoma"
466:             .FontSize  = 8
467:             .ForeColor = RGB(90, 90, 90)
468:             .BackStyle = 0
469:             .Visible   = .T.
470:         ENDWITH
471: 
472:         *-- TextBox Descricao (Get_cdescr: Top=163, Left=359, Width=220 -> compensado: Top=192)
473:         loc_oPagina.AddObject("txt_4c_Cdescr", "TextBox")
474:         WITH loc_oPagina.txt_4c_Cdescr
475:             .Top           = 192
476:             .Left          = 359
477:             .Width         = 220
478:             .Height        = 22
479:             .Value         = ""
480:             .FontName      = "Tahoma"
481:             .FontSize      = 8

*-- Linhas 507 a 516:
507:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ncodigos"
508:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cdescrs"
509:                 *-- Reconfigurar headers apos RecordSource (obrigatorio - VFP reseta)
510:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
511:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
512:                 THIS.FormatarGridLista(loc_oGrid)
513:                 loc_lSucesso = .T.
514:             ENDIF
515:         CATCH TO loc_oErro
516:             MsgErro(loc_oErro.Message, "FormOcc.CarregarLista")

*-- Linhas 724 a 749:
724:             loc_oPagina.txt_4c_Cdescr.ReadOnly  = !par_lHabilitar
725:         ENDIF
726:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
727:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
728:         ENDIF
729:     ENDPROC
730: 
731:     *--------------------------------------------------------------------------
732:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme modo atual
733:     *--------------------------------------------------------------------------
734:     PROTECTED PROCEDURE AjustarBotoesPorModo()
735:         LOCAL loc_oPg1, loc_lEdicao
736:         loc_oPg1    = THIS.pgf_4c_Paginas.Page1
737:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
738:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
739:             WITH loc_oPg1.cnt_4c_Botoes
740:                 .cmd_4c_Incluir.Enabled    = !loc_lEdicao
741:                 .cmd_4c_Visualizar.Enabled = !loc_lEdicao
742:                 .cmd_4c_Alterar.Enabled    = !loc_lEdicao
743:                 .cmd_4c_Excluir.Enabled    = !loc_lEdicao
744:                 .cmd_4c_Buscar.Enabled     = !loc_lEdicao
745:                 .Visible     = .T.
746:             ENDWITH
747:         ENDIF
748:     ENDPROC
749: 


### BO (C:\4c\projeto\app\classes\OccBO.prg):
*------------------------------------------------------------------------------
* OccBO.prg - Business Object para Ocorrencias de Correcao
* Tabela: SigCcOco
* Herda de: BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS OccBO AS BusinessBase

    *-- Propriedades da entidade SigCcOco
    this_nCodigo    = 0   && ncodigos numeric(3,0) - Chave primaria
    this_cDescricao = ""  && cdescrs  char(30)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCcOco"
            THIS.this_cCampoChave = "ncodigos"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodigo    = TratarNulo(ncodigos, "N")
            THIS.this_cDescricao = TratarNulo(cdescrs,  "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona registros com filtro opcional
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT ncodigos, cdescrs" + ;
                       " FROM SigCcOco" + ;
                       " ORDER BY ncodigos"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT ncodigos, cdescrs" + ;
                           " FROM SigCcOco" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY ncodigos"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro especifico pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_nCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT ncodigos, cdescrs" + ;
                       " FROM SigCcOco" + ;
                       " WHERE ncodigos = " + FormatarNumeroSQL(par_nCodigo, 0)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Codigo obrigatorio
            IF THIS.this_nCodigo <= 0
                MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Descricao obrigatoria
            IF EMPTY(ALLTRIM(THIS.this_cDescricao))
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar duplicidade no INSERT
            IF THIS.this_lNovoRegistro
                loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCcOco" + ;
                           " WHERE ncodigos = " + FormatarNumeroSQL(THIS.this_nCodigo, 0)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkDup")
                    TABLEREVERT(.T., "cursor_4c_ChkDup")
                    USE IN cursor_4c_ChkDup
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_ChkDup
                    IF cursor_4c_ChkDup.Total > 0
                        MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
                        USE IN cursor_4c_ChkDup
                        loc_lSucesso = .F.
                    ENDIF
                    USE IN cursor_4c_ChkDup
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCcOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCcOco (ncodigos, cdescrs)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCcOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCcOco" + ;
                       " SET cdescrs = " + EscaparSQL(THIS.this_cDescricao) + ;
                       " WHERE ncodigos = " + FormatarNumeroSQL(THIS.this_nCodigo, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro (PROTECTED)
    * Verifica referencia em SigNfCor.noccors antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        TRY
            *-- Verificar referencia em SigNfCor antes de excluir
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigNfCor" + ;
                       " WHERE noccors = " + FormatarNumeroSQL(THIS.this_nCodigo, 0)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkRef")
                TABLEREVERT(.T., "cursor_4c_ChkRef")
                USE IN cursor_4c_ChkRef
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkRef")

            IF loc_nResultado >= 0
                SELECT cursor_4c_ChkRef
                IF cursor_4c_ChkRef.Total > 0
                    MsgAviso("Ocorr" + CHR(234) + "ncia com Movimenta" + CHR(231) + CHR(227) + "o, " + ;
                             "Exclus" + CHR(227) + "o Inv" + CHR(225) + "lida!", "")
                    USE IN cursor_4c_ChkRef
                    loc_lSucesso = .F.
                ENDIF
                USE IN cursor_4c_ChkRef
            ENDIF

            loc_cSQL = "DELETE FROM SigCcOco" + ;
                       " WHERE ncodigos = " + FormatarNumeroSQL(THIS.this_nCodigo, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

