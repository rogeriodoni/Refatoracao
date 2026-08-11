# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 162: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 184: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 207: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 230: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 288: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 365: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 387: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDIC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (898 linhas total):

*-- Linhas 66 a 86:
66:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
67:         WITH THIS.pgf_4c_Paginas
68:             .PageCount = 2
69:             .Top       = -29
70:             .Left      = 0
71:             .Width     = THIS.Width
72:             .Height    = THIS.Height + 29
73:             .Tabs      = .F.
74:             .Visible   = .T.
75:         ENDWITH
76: 
77:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
78:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(100, 100, 100)
79:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
80: 
81:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
82:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(100, 100, 100)
83:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
84: 
85:         THIS.ConfigurarPaginaLista()
86:         THIS.ConfigurarPaginaDados()

*-- Linhas 97 a 133:
97:         *-- Container cabecalho (cntSombra no legado: Top=1, compensacao +29 = 30)
98:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
99:         WITH loc_oPagina.cnt_4c_Cabecalho
100:             .Top         = 30
101:             .Left        = 0
102:             .Width       = THIS.Width
103:             .Height      = 80
104:             .BackColor   = RGB(100, 100, 100)
105:             .BorderWidth = 0
106:             .Visible     = .T.
107: 
108:             .AddObject("lbl_4c_Sombra", "Label")
109:             WITH .lbl_4c_Sombra
110:                 .Caption   = THIS.Caption
111:                 .Top       = 15
112:                 .Left      = 11
113:                 .Width     = THIS.Width
114:                 .Height    = 40
115:                 .FontName  = "Tahoma"
116:                 .FontSize  = 16
117:                 .FontBold  = .T.
118:                 .ForeColor = RGB(0, 0, 0)
119:                 .BackStyle = 0
120:                 .AutoSize  = .F.
121:                 .Visible   = .T.
122:             ENDWITH
123: 
124:             .AddObject("lbl_4c_Titulo", "Label")
125:             WITH .lbl_4c_Titulo
126:                 .Caption   = THIS.Caption
127:                 .Top       = 18
128:                 .Left      = 10
129:                 .Width     = THIS.Width
130:                 .Height    = 46
131:                 .FontName  = "Tahoma"
132:                 .FontSize  = 16
133:                 .FontBold  = .T.

*-- Linhas 141 a 259:
141:         *-- Container botoes CRUD (Grupo_op no legado: Top=-1, compensacao +29 = 28 -> canonico 29)
142:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
143:         WITH loc_oPagina.cnt_4c_Botoes
144:             .Top         = 29
145:             .Left        = 542
146:             .Width       = 390
147:             .Height      = 85
148:             .BackStyle   = 1
149:             .BackColor   = RGB(53, 53, 53)
150:             .BorderWidth = 0
151:             .Visible     = .T.
152: 
153:             .AddObject("cmd_4c_Incluir", "CommandButton")
154:             WITH .cmd_4c_Incluir
155:                 .Caption         = "Incluir"
156:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
157:                 .PicturePosition = 13
158:                 .Top             = 5
159:                 .Left            =  542
160:                 .Width           = 75
161:                 .Height          = 75
162:                 .FontName        = "Comic Sans MS"
163:                 .FontSize        = 8
164:                 .FontBold        = .T.
165:                 .FontItalic      = .T.
166:                 .ForeColor       = RGB(90, 90, 90)
167:                 .BackColor       = RGB(255, 255, 255)
168:                 .SpecialEffect   = 0
169:                 .MousePointer    = 15
170:                 .WordWrap        = .T.
171:                 .AutoSize        = .F.
172:                 .Visible         = .T.
173:             ENDWITH
174: 
175:             .AddObject("cmd_4c_Visualizar", "CommandButton")
176:             WITH .cmd_4c_Visualizar
177:                 .Caption         = "Visualizar"
178:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
179:                 .PicturePosition = 13
180:                 .Top             = 5
181:                 .Left            =  542
182:                 .Width           = 75
183:                 .Height          = 75
184:                 .FontName        = "Comic Sans MS"
185:                 .FontSize        = 8
186:                 .FontBold        = .T.
187:                 .FontItalic      = .T.
188:                 .ForeColor       = RGB(90, 90, 90)
189:                 .BackColor       = RGB(255, 255, 255)
190:                 .Themes          = .F.
191:                 .SpecialEffect   = 0
192:                 .MousePointer    = 15
193:                 .WordWrap        = .T.
194:                 .AutoSize        = .F.
195:                 .Visible         = .T.
196:             ENDWITH
197: 
198:             .AddObject("cmd_4c_Alterar", "CommandButton")
199:             WITH .cmd_4c_Alterar
200:                 .Caption         = "Alterar"
201:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
202:                 .PicturePosition = 13
203:                 .Top             = 5
204:                 .Left            =  542
205:                 .Width           = 75
206:                 .Height          = 75
207:                 .FontName        = "Comic Sans MS"
208:                 .FontSize        = 8
209:                 .FontBold        = .T.
210:                 .FontItalic      = .T.
211:                 .ForeColor       = RGB(90, 90, 90)
212:                 .BackColor       = RGB(255, 255, 255)
213:                 .Themes          = .F.
214:                 .SpecialEffect   = 0
215:                 .MousePointer    = 15
216:                 .WordWrap        = .T.
217:                 .AutoSize        = .F.
218:                 .Visible         = .T.
219:             ENDWITH
220: 
221:             .AddObject("cmd_4c_Excluir", "CommandButton")
222:             WITH .cmd_4c_Excluir
223:                 .Caption         = "Excluir"
224:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
225:                 .PicturePosition = 13
226:                 .Top             = 5
227:                 .Left            =  542
228:                 .Width           = 75
229:                 .Height          = 75
230:                 .FontName        = "Comic Sans MS"
231:                 .FontSize        = 8
232:                 .FontBold        = .T.
233:                 .FontItalic      = .T.
234:                 .ForeColor       = RGB(90, 90, 90)
235:                 .BackColor       = RGB(255, 255, 255)
236:                 .Themes          = .F.
237:                 .SpecialEffect   = 0
238:                 .MousePointer    = 15
239:                 .WordWrap        = .T.
240:                 .AutoSize        = .F.
241:                 .Visible         = .T.
242:             ENDWITH
243: 
244:             .AddObject("cmd_4c_Buscar", "CommandButton")
245:             WITH .cmd_4c_Buscar
246:                 .Caption         = "Buscar"
247:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
248:                 .PicturePosition = 13
249:                 .Top             = 5
250:                 .Left            =  542
251:                 .Width           = 75
252:                 .Height          = 75
253:                 .FontName        = "Comic Sans MS"
254:                 .FontSize        = 8
255:                 .FontBold        = .T.
256:                 .FontItalic      = .T.
257:                 .ForeColor       = RGB(90, 90, 90)
258:                 .BackColor       = RGB(255, 255, 255)
259:                 .Themes          = .F.

*-- Linhas 268 a 294:
268:         *-- Container saida - padrao canonico (PREVALECE sobre PILAR 1)
269:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
270:         WITH loc_oPagina.cnt_4c_Saida
271:             .Top         = 29
272:             .Left        = 917
273:             .Width       = 90
274:             .Height      = 85
275:             .BackStyle   = 0
276:             .BorderWidth = 0
277:             .Visible     = .T.
278: 
279:             .AddObject("cmd_4c_Encerrar", "CommandButton")
280:             WITH .cmd_4c_Encerrar
281:                 .Caption         = "Encerrar"
282:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
283:                 .PicturePosition = 13
284:                 .Top             = 5
285:                 .Left            = 917
286:                 .Width           = 75
287:                 .Height          = 75
288:                 .FontName        = "Comic Sans MS"
289:                 .FontSize        = 8
290:                 .FontBold        = .T.
291:                 .FontItalic      = .T.
292:                 .ForeColor       = RGB(90, 90, 90)
293:                 .BackColor       = RGB(255, 255, 255)
294:                 .SpecialEffect   = 0

*-- Linhas 302 a 311:
302:         *-- Grid de listagem (grade no legado: Top=88, compensacao +29 = 117)
303:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
304:         WITH loc_oPagina.grd_4c_Dados
305:             .Top                = 117
306:             .Left               = 0
307:             .Width              = 910
308:             .Height             = 455
309:             .ColumnCount        = 3
310:             .FontName           = "Verdana"
311:             .FontSize           = 8

*-- Linhas 324 a 337:
324:         ENDWITH
325: 
326:         *-- BINDEVENT: vincular botoes
327:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
328:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
329:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
330:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
331:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
332:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
333: 
334:         THIS.TornarControlesVisiveis(loc_oPagina)
335:     ENDPROC
336: 
337:     *--------------------------------------------------------------------------

*-- Linhas 345 a 393:
345:         *-- Container botoes acao (Grupo_Salva: Top=4+29=33, Left=842, Width=160)
346:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
347:         WITH loc_oPagina.cnt_4c_BotoesAcao
348:             .Top         = 33
349:             .Left        = 842
350:             .Width       = 160
351:             .Height      = 85
352:             .BackStyle   = 0
353:             .BorderWidth = 0
354:             .Visible     = .T.
355: 
356:             .AddObject("cmd_4c_Confirmar", "CommandButton")
357:             WITH .cmd_4c_Confirmar
358:                 .Caption         = "Confirmar"
359:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
360:                 .PicturePosition = 13
361:                 .Top             = 5
362:                 .Left            = 5
363:                 .Width           = 75
364:                 .Height          = 75
365:                 .FontName        = "Comic Sans MS"
366:                 .FontSize        = 8
367:                 .FontBold        = .T.
368:                 .FontItalic      = .T.
369:                 .ForeColor       = RGB(90, 90, 90)
370:                 .BackColor       = RGB(255, 255, 255)
371:                 .SpecialEffect   = 0
372:                 .MousePointer    = 15
373:                 .WordWrap        = .T.
374:                 .AutoSize        = .F.
375:                 .Visible         = .T.
376:             ENDWITH
377: 
378:             .AddObject("cmd_4c_Cancelar", "CommandButton")
379:             WITH .cmd_4c_Cancelar
380:                 .Caption         = "Encerrar"
381:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
382:                 .PicturePosition = 13
383:                 .Top             = 5
384:                 .Left            = 80
385:                 .Width           = 75
386:                 .Height          = 75
387:                 .FontName        = "Comic Sans MS"
388:                 .FontSize        = 8
389:                 .FontBold        = .T.
390:                 .FontItalic      = .T.
391:                 .ForeColor       = RGB(90, 90, 90)
392:                 .BackColor       = RGB(255, 255, 255)
393:                 .Themes          = .F.

*-- Linhas 399 a 416:
399:             ENDWITH
400:         ENDWITH
401: 
402:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
403:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
404: 
405:         *-- Idioma (Say1 + GetIdioma)
406:         *-- Legado: Say1.Top=144->173, Say1.Left=63 | GetIdioma.Top=139->168, Left=116, Width=87
407:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
408:         WITH loc_oPagina.lbl_4c_Label1
409:             .Caption   = "Idioma :"
410:             .Top       = 173
411:             .Left      = 63
412:             .Width     = 51
413:             .Height    = 15
414:             .FontName  = "Tahoma"
415:             .FontSize  = 8
416:             .FontBold  = .F.

*-- Linhas 424 a 433:
424:         loc_oPagina.AddObject("txt_4c_Idioma", "TextBox")
425:         WITH loc_oPagina.txt_4c_Idioma
426:             .Value       = ""
427:             .Top         = 168
428:             .Left        = 116
429:             .Width       = 87
430:             .Height      = 24
431:             .FontName    = "Tahoma"
432:             .FontSize    = 8
433:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 439 a 452:
439:         ENDWITH
440: 
441:         *-- Expressao (Say2 + GetExpressao)
442:         *-- Legado: Say2.Top=183->212, Say2.Left=42 | GetExpressao.Top=179->208, Left=116, Width=525
443:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
444:         WITH loc_oPagina.lbl_4c_Label2
445:             .Caption   = "Express" + CHR(227) + "o :"
446:             .Top       = 212
447:             .Left      = 42
448:             .Width     = 70
449:             .Height    = 15
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8
452:             .FontBold  = .F.

*-- Linhas 460 a 469:
460:         loc_oPagina.AddObject("txt_4c_Expressao", "TextBox")
461:         WITH loc_oPagina.txt_4c_Expressao
462:             .Value       = ""
463:             .Top         = 208
464:             .Left        = 116
465:             .Width       = 525
466:             .Height      = 24
467:             .FontName    = "Tahoma"
468:             .FontSize    = 8
469:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 475 a 488:
475:         ENDWITH
476: 
477:         *-- Traducao (Say3 + GetTraducao)
478:         *-- Legado: Say3.Top=226->255, Say3.Left=49 | GetTraducao.Top=222->251, Left=117, Width=525
479:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
480:         WITH loc_oPagina.lbl_4c_Label3
481:             .Caption   = "Tradu" + CHR(231) + CHR(227) + "o :"
482:             .Top       = 255
483:             .Left      = 49
484:             .Width     = 64
485:             .Height    = 15
486:             .FontName  = "Tahoma"
487:             .FontSize  = 8
488:             .FontBold  = .F.

*-- Linhas 496 a 505:
496:         loc_oPagina.AddObject("txt_4c_Traducao", "TextBox")
497:         WITH loc_oPagina.txt_4c_Traducao
498:             .Value       = ""
499:             .Top         = 251
500:             .Left        = 117
501:             .Width       = 525
502:             .Height      = 24
503:             .FontName    = "Tahoma"
504:             .FontSize    = 8
505:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 537 a 547:
537:                     loc_oGrid.Column2.Width = 280
538:                     loc_oGrid.Column3.Width = 280
539: 
540:                     loc_oGrid.Column1.Header1.Caption = "Idioma"
541:                     loc_oGrid.Column2.Header1.Caption = "Express" + CHR(227) + "o"
542:                     loc_oGrid.Column3.Header1.Caption = "Tradu" + CHR(231) + CHR(227) + "o"
543: 
544:                     loc_oGrid.Refresh()
545:                     THIS.FormatarGridLista(loc_oGrid)
546:                     loc_lResultado = .T.
547:                 ENDIF

*-- Linhas 642 a 654:
642:         loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
643:         loc_lConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
644: 
645:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
646:             loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lConfirmar
647:         ENDIF
648:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
649:             loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
650:         ENDIF
651:     ENDPROC
652: 
653:     *--------------------------------------------------------------------------
654:     PROTECTED PROCEDURE BOParaForm()


### BO (C:\4c\projeto\app\classes\DICBO.prg):
*==============================================================================
* DICBO.prg - Business Object para Dicionario de Idiomas
* Tabela: SigCdDic
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DICBO AS BusinessBase

    *-- Chave primaria (PK: cidchaves char(20), gerada por fUniqueIds())
    this_cIdChaves  = ""

    *-- Campos da tabela SigCdDic
    this_dDatas     = {}    && datas datetime NULL
    this_cExpressao = ""    && expressao char(60) NOT NULL
    this_cIdioma    = ""    && idioma char(10) NOT NULL
    this_cTraducao  = ""    && traducao char(60) NOT NULL
    this_cUsuars    = ""    && usuars char(10) NOT NULL

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdDic"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros do dicionario filtrados por par_cFiltro
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Idioma, Expressao, Traducao, cidchaves" + ;
                    " FROM SigCdDic" + ;
                    " ORDER BY Expressao, Idioma"
            ELSE
                loc_cSQL = "SELECT Idioma, Expressao, Traducao, cidchaves" + ;
                    " FROM SigCdDic" + ;
                    " WHERE Expressao LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    "    OR Idioma LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY Expressao, Idioma"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, datas, expressao, idioma, traducao, usuars" + ;
                " FROM SigCdDic" + ;
                " WHERE cidchaves = " + EscaparSQL(par_cIdChaves)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_dDatas     = TratarNulo(datas,      "D")
            THIS.this_cExpressao = TratarNulo(expressao,  "C")
            THIS.this_cIdioma    = TratarNulo(idioma,     "C")
            THIS.this_cTraducao  = TratarNulo(traducao,   "C")
            THIS.this_cUsuars    = TratarNulo(usuars,     "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de inserir/atualizar
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cExpressao))
            MsgAviso("Express" + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cIdioma))
            MsgAviso("Idioma Inv" + CHR(225) + "lido !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cTraducao))
            MsgAviso("Tradu" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se Expressao+Idioma ja existe (apenas no INSERT)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDic" + ;
                " WHERE Expressao = " + EscaparSQL(THIS.this_cExpressao) + ;
                "   AND Idioma    = " + EscaparSQL(THIS.this_cIdioma)

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.Total > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = fUniqueIds()
            ENDIF

            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            IF THIS.VerificarDuplicidade()
                MsgAviso(CHR(67) + CHR(243) + "digo j" + CHR(225) + " Cadastrado !!", "Duplicado")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdDic" + ;
                    " (cidchaves, datas, expressao, idioma, traducao, usuars)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                    "GETDATE(), " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cExpressao), 60)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cIdioma), 10)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cTraducao), 60)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuars), 10)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE SigCdDic SET" + ;
                " traducao = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTraducao), 60)) + "," + ;
                " usuars   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuars), 10)) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDic" + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

