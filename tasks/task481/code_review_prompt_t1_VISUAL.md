# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 195: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 220: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 242: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 264: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 286: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 308: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 388: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 410: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOET.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (918 linhas total):

*-- Linhas 50 a 59:
50:             ELSE
51:                 THIS.ConfigurarPageFrame()
52: 
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55: 
56:                 THIS.pgf_4c_Paginas.Visible    = .T.
57:                 THIS.pgf_4c_Paginas.ActivePage = 1
58:                 THIS.this_cModoAtual           = "LISTA"
59: 

*-- Linhas 83 a 102:
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount = 2
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .Tabs      = .F.
91:             .Visible   = .T.
92: 
93:             .Page1.Caption   = "Lista"
94:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page1.BackColor = RGB(255, 255, 255)
96: 
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()

*-- Linhas 119 a 155:
119:         *-- Legado: Top=1 -> com compensacao +29: Top=30
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top       = 30
123:             .Left      = 0
124:             .Width     = THIS.Width
125:             .Height    = 80
126:             .BackColor = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible   = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = 769
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = 769
152:             .Height    = 46
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.

*-- Linhas 161 a 337:
161:         *-- Container Botoes CRUD (Grupo_op no legado) - canonico: Left=542
162:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
163:         WITH loc_oPagina.cnt_4c_Botoes
164:             .Top       = 28
165:             .Left      = 542
166:             .Width     = 390
167:             .Height    = 85
168:             .BackStyle = 0
169:             .BorderWidth = 0
170:             .Visible   = .T.
171:         ENDWITH
172: 
173:         *-- Container Saida (canonical - CLAUDE.md regra #10)
174:         *-- Prevalece sobre SCX legado: Left=917, Width=90, cmd_4c_Encerrar Width=75
175:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
176:         WITH loc_oPagina.cnt_4c_Saida
177:             .Top       = 29
178:             .Left      = 917
179:             .Width     = 90
180:             .Height    = 85
181:             .BackStyle = 0
182:             .BorderWidth = 0
183:             .Visible   = .T.
184:         ENDWITH
185: 
186:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
187:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
188:             .Caption         = "Encerrar"
189:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
190:             .PicturePosition = 13
191:             .Top             = 5
192:             .Left            = 5
193:             .Width           = 75
194:             .Height          = 75
195:             .FontName        = "Comic Sans MS"
196:             .FontBold        = .T.
197:             .FontItalic      = .T.
198:             .FontSize        = 8
199:             .ForeColor       = RGB(90, 90, 90)
200:             .BackColor       = RGB(255, 255, 255)
201:             .Themes          = .F.
202:             .SpecialEffect   = 0
203:             .MousePointer    = 15
204:             .WordWrap        = .T.
205:             .Visible         = .T.
206:         ENDWITH
207: 
208:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
209: 
210:         *-- Botoes CRUD dentro de cnt_4c_Botoes
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
213:             .Caption         = "Incluir"
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
215:             .PicturePosition = 13
216:             .Top             = 5
217:             .Left            = 5
218:             .Width           = 75
219:             .Height          = 75
220:             .FontName        = "Comic Sans MS"
221:             .FontBold        = .T.
222:             .FontItalic      = .T.
223:             .FontSize        = 8
224:             .ForeColor       = RGB(90, 90, 90)
225:             .BackColor       = RGB(255, 255, 255)
226:             .Themes          = .F.
227:             .SpecialEffect   = 0
228:             .MousePointer    = 15
229:             .WordWrap        = .T.
230:             .Visible         = .T.
231:         ENDWITH
232: 
233:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
234:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
235:             .Caption         = "Visualizar"
236:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
237:             .PicturePosition = 13
238:             .Top             = 5
239:             .Left            = 80
240:             .Width           = 75
241:             .Height          = 75
242:             .FontName        = "Comic Sans MS"
243:             .FontBold        = .T.
244:             .FontItalic      = .T.
245:             .FontSize        = 8
246:             .ForeColor       = RGB(90, 90, 90)
247:             .BackColor       = RGB(255, 255, 255)
248:             .Themes          = .F.
249:             .SpecialEffect   = 0
250:             .MousePointer    = 15
251:             .WordWrap        = .T.
252:             .Visible         = .T.
253:         ENDWITH
254: 
255:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
256:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
257:             .Caption         = "Alterar"
258:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
259:             .PicturePosition = 13
260:             .Top             = 5
261:             .Left            = 155
262:             .Width           = 75
263:             .Height          = 75
264:             .FontName        = "Comic Sans MS"
265:             .FontBold        = .T.
266:             .FontItalic      = .T.
267:             .FontSize        = 8
268:             .ForeColor       = RGB(90, 90, 90)
269:             .BackColor       = RGB(255, 255, 255)
270:             .Themes          = .F.
271:             .SpecialEffect   = 0
272:             .MousePointer    = 15
273:             .WordWrap        = .T.
274:             .Visible         = .T.
275:         ENDWITH
276: 
277:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
278:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
279:             .Caption         = "Excluir"
280:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
281:             .PicturePosition = 13
282:             .Top             = 5
283:             .Left            = 230
284:             .Width           = 75
285:             .Height          = 75
286:             .FontName        = "Comic Sans MS"
287:             .FontBold        = .T.
288:             .FontItalic      = .T.
289:             .FontSize        = 8
290:             .ForeColor       = RGB(90, 90, 90)
291:             .BackColor       = RGB(255, 255, 255)
292:             .Themes          = .F.
293:             .SpecialEffect   = 0
294:             .MousePointer    = 15
295:             .WordWrap        = .T.
296:             .Visible         = .T.
297:         ENDWITH
298: 
299:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
300:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
301:             .Caption         = "Buscar"
302:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
303:             .PicturePosition = 13
304:             .Top             = 5
305:             .Left            = 305
306:             .Width           = 75
307:             .Height          = 75
308:             .FontName        = "Comic Sans MS"
309:             .FontBold        = .T.
310:             .FontItalic      = .T.
311:             .FontSize        = 8
312:             .ForeColor       = RGB(90, 90, 90)
313:             .BackColor       = RGB(255, 255, 255)
314:             .Themes          = .F.
315:             .SpecialEffect   = 0
316:             .MousePointer    = 15
317:             .WordWrap        = .T.
318:             .Visible         = .T.
319:         ENDWITH
320: 
321:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
322:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
323:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
324:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
325:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
326: 
327:         *-- Grid Lista (Grade no legado: colunas Cods(50) e Descrs(290))
328:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
329:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
330:         WITH loc_oPagina.grd_4c_Lista
331:             .Top                = 123
332:             .Left               = 32
333:             .Width              = 880
334:             .Height             = 470
335:             .FontName           = "Verdana"
336:             .FontSize           = 8
337:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 367 a 439:
367:         *-- Legado: Left=619, Top=8 -> com compensacao +29: Top=37
368:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
369:         WITH loc_oPagina.cnt_4c_BotoesAcao
370:             .Top       = 37
371:             .Left      = 619
372:             .Width     = 172
373:             .Height    = 85
374:             .BackStyle = 0
375:             .BorderWidth = 0
376:             .Visible   = .T.
377:         ENDWITH
378: 
379:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
380:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
381:             .Caption         = "Confirmar"
382:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
383:             .PicturePosition = 13
384:             .Top             = 5
385:             .Left            = 12
386:             .Width           = 75
387:             .Height          = 75
388:             .FontName        = "Comic Sans MS"
389:             .FontBold        = .T.
390:             .FontItalic      = .T.
391:             .FontSize        = 8
392:             .ForeColor       = RGB(90, 90, 90)
393:             .BackColor       = RGB(255, 255, 255)
394:             .Themes          = .F.
395:             .SpecialEffect   = 0
396:             .MousePointer    = 15
397:             .WordWrap        = .T.
398:             .Visible         = .T.
399:         ENDWITH
400: 
401:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
402:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
403:             .Caption         = "Encerrar"
404:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
405:             .PicturePosition = 13
406:             .Top             = 5
407:             .Left            = 88
408:             .Width           = 75
409:             .Height          = 75
410:             .FontName        = "Comic Sans MS"
411:             .FontBold        = .T.
412:             .FontItalic      = .T.
413:             .FontSize        = 8
414:             .ForeColor       = RGB(90, 90, 90)
415:             .BackColor       = RGB(255, 255, 255)
416:             .Themes          = .F.
417:             .SpecialEffect   = 0
418:             .MousePointer    = 15
419:             .WordWrap        = .T.
420:             .Visible         = .T.
421:         ENDWITH
422: 
423:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
424:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click",  THIS, "BtnCancelarClick")
425: 
426:         *-- === FASE 5: Campos Principais (Parte 1) ===
427:         *-- Posicoes compensadas: Top_original + 29 (PageFrame.Top = -29)
428: 
429:         *-- Label "Codigo :" (Say8: Top=170, Left=185, Width=42)
430:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
431:         WITH loc_oPagina.lbl_4c_Label8
432:             .Caption   = "C" + CHR(243) + "digo :"
433:             .Top       = 199
434:             .Left      = 185
435:             .Width     = 42
436:             .Height    = 17
437:             .FontName  = "Tahoma"
438:             .FontSize  = 8
439:             .FontBold  = .F.

*-- Linhas 449 a 474:
449:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
450:         WITH loc_oPagina.txt_4c_Codigo
451:             .Value    = ""
452:             .Top      = 196
453:             .Left     = 231
454:             .Width    = 31
455:             .Height   = 21
456:             .FontName = "Tahoma"
457:             .FontSize = 8
458:             .MaxLength = 5
459:             .Visible  = .T.
460:         ENDWITH
461: 
462:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarCodigo")
463: 
464:         *-- Label "Descricao :" (Say1: Top=197, Left=172, Width=55)
465:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
466:         WITH loc_oPagina.lbl_4c_Label1
467:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
468:             .Top       = 226
469:             .Left      = 172
470:             .Width     = 55
471:             .Height    = 17
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .FontBold  = .F.

*-- Linhas 482 a 507:
482:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
483:         WITH loc_oPagina.txt_4c_Descrs
484:             .Value    = ""
485:             .Top      = 223
486:             .Left     = 231
487:             .Width    = 290
488:             .Height   = 21
489:             .FontName = "Tahoma"
490:             .FontSize = 8
491:             .MaxLength = 50
492:             .Visible  = .T.
493:         ENDWITH
494: 
495:         *-- CheckBox Justificativa Obrigatoria (Opt_Justif: Top=222, Left=231, Width=152, Height=18)
496:         *-- Caption original: "Justificativa Obrigatoria" (com acentos via CHR)
497:         loc_oPagina.AddObject("chk_4c_Opt_Justif", "CheckBox")
498:         WITH loc_oPagina.chk_4c_Opt_Justif
499:             .Caption  = "Justificativa Obrigat" + CHR(243) + "ria"
500:             .Value    = 0
501:             .Top      = 251
502:             .Left     = 231
503:             .Width    = 152
504:             .Height   = 18
505:             .FontName = "Tahoma"
506:             .FontSize = 8
507:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 567 a 576:
567:                 loc_oGrid.Column1.Width = 50
568:                 loc_oGrid.Column2.Width = 290
569: 
570:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
571:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
572: 
573:                 THIS.FormatarGridLista(loc_oGrid)
574: 
575:                 loc_lResultado = .T.
576:             ENDIF

*-- Linhas 641 a 650:
641:             THIS.AjustarBotoesPorModo()
642:             THIS.AlternarPagina(2)
643:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
644:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
645:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
646:             ENDIF
647:         ENDIF
648:     ENDPROC
649: 
650:     *===========================================================================

*-- Linhas 861 a 873:
861:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
862:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
863: 
864:         IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
865:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
866:         ENDIF
867:         IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
868:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
869:         ENDIF
870:     ENDPROC
871: 
872:     *===========================================================================
873:     * TornarControlesVisiveis - Torna controles visiveis recursivamente


### BO (C:\4c\projeto\app\classes\OETBO.prg):
*==============================================================================
* OETBO.prg - Business Object para Ocorrencias de Etiquetas
* Tabela: SigEtOco
* Chave: cods (char 3)
*==============================================================================
DEFINE CLASS OETBO AS BusinessBase

    *-- Propriedades dos campos da tabela SigEtOco
    this_cCodigo  = ""      && cods  char(3)
    this_cDescrs  = ""      && descrs char(40)
    this_lJustifs = .F.     && justifs numeric(1,0) - Justificativa Obrigatoria

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigEtOco"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtro opcional, popula cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cods, a.descrs, a.justifs" + ;
                       " FROM SigEtOco a"
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY a.cods"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT por PK, popula propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cods, a.descrs, a.justifs" + ;
                       " FROM SigEtOco a" + ;
                       " WHERE a.cods = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo  = TratarNulo(cods,   "C")
            THIS.this_cDescrs  = TratarNulo(descrs,  "C")
            THIS.this_lJustifs = ConverterParaLogico(justifs)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigEtOco (chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigEtOco (cods, descrs, justifs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       IIF(THIS.this_lJustifs, "1", "0") + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigEtOco (chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigEtOco SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " justifs = " + IIF(THIS.this_lJustifs, "1", "0") + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar ocorr" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigEtOco (chamado por Excluir)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigEtOco WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

ENDDEFINE

