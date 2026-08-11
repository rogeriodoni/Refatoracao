# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 174: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 196: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 218: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 240: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 262: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 302: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 387: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 409: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDpi.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (876 linhas total):

*-- Linhas 75 a 95:
75:     PROTECTED PROCEDURE ConfigurarPageFrame()
76:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
77:         WITH THIS.pgf_4c_Paginas
78:             .Top       = -29
79:             .Left      = 0
80:             .Width     = THIS.Width
81:             .Height    = THIS.Height + 29
82:             .PageCount = 2
83:             .Tabs      = .F.
84:             .Visible   = .T.
85: 
86:             .Page1.Caption    = "Lista"
87:             .Page1.BackColor  = RGB(100, 100, 100)
88:             .Page1.Picture    = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
89: 
90:             .Page2.Caption    = "Dados"
91:             .Page2.BackColor  = RGB(100, 100, 100)
92:             .Page2.Picture    = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:         ENDWITH
94: 
95:         THIS.ConfigurarPaginaLista()

*-- Linhas 109 a 146:
109:         *-- Container sombra/cabecalho cinza superior
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
123:             .Caption   = THIS.Caption
124:             .Top       = 15
125:             .Left      = 10
126:             .Width     = THIS.Width - 10
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
139:             .Caption   = THIS.Caption
140:             .Top       = 18
141:             .Left      = 10
142:             .Width     = THIS.Width - 10
143:             .Height    = 46
144:             .FontName  = "Tahoma"
145:             .FontSize  = 16
146:             .FontBold  = .T.

*-- Linhas 153 a 326:
153:         *-- Container botoes CRUD lado direito
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
174:             .FontName        = "Comic Sans MS"
175:             .FontBold        = .T.
176:             .FontItalic      = .T.
177:             .FontSize        = 8
178:             .BackColor       = RGB(255, 255, 255)
179:             .ForeColor       = RGB(90, 90, 90)
180:             .Themes          = .F.
181:             .SpecialEffect   = 0
182:             .WordWrap        = .T.
183:             .AutoSize        = .F.
184:             .Visible         = .T.
185:         ENDWITH
186: 
187:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
188:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
189:             .Caption         = "Visualizar"
190:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
191:             .PicturePosition = 13
192:             .Top             = 5
193:             .Left            = 80
194:             .Width           = 75
195:             .Height          = 75
196:             .FontName        = "Comic Sans MS"
197:             .FontBold        = .T.
198:             .FontItalic      = .T.
199:             .FontSize        = 8
200:             .BackColor       = RGB(255, 255, 255)
201:             .ForeColor       = RGB(90, 90, 90)
202:             .Themes          = .F.
203:             .SpecialEffect   = 0
204:             .WordWrap        = .T.
205:             .AutoSize        = .F.
206:             .Visible         = .T.
207:         ENDWITH
208: 
209:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
210:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
211:             .Caption         = "Alterar"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
213:             .PicturePosition = 13
214:             .Top             = 5
215:             .Left            = 155
216:             .Width           = 75
217:             .Height          = 75
218:             .FontName        = "Comic Sans MS"
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .FontSize        = 8
222:             .BackColor       = RGB(255, 255, 255)
223:             .ForeColor       = RGB(90, 90, 90)
224:             .Themes          = .F.
225:             .SpecialEffect   = 0
226:             .WordWrap        = .T.
227:             .AutoSize        = .F.
228:             .Visible         = .T.
229:         ENDWITH
230: 
231:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
232:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
233:             .Caption         = "Excluir"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
235:             .PicturePosition = 13
236:             .Top             = 5
237:             .Left            = 230
238:             .Width           = 75
239:             .Height          = 75
240:             .FontName        = "Comic Sans MS"
241:             .FontBold        = .T.
242:             .FontItalic      = .T.
243:             .FontSize        = 8
244:             .BackColor       = RGB(255, 255, 255)
245:             .ForeColor       = RGB(90, 90, 90)
246:             .Themes          = .F.
247:             .SpecialEffect   = 0
248:             .WordWrap        = .T.
249:             .AutoSize        = .F.
250:             .Visible         = .T.
251:         ENDWITH
252: 
253:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
254:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
255:             .Caption         = "Buscar"
256:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
257:             .PicturePosition = 13
258:             .Top             = 5
259:             .Left            = 305
260:             .Width           = 75
261:             .Height          = 75
262:             .FontName        = "Comic Sans MS"
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .FontSize        = 8
266:             .BackColor       = RGB(255, 255, 255)
267:             .ForeColor       = RGB(90, 90, 90)
268:             .Themes          = .F.
269:             .SpecialEffect   = 0
270:             .WordWrap        = .T.
271:             .AutoSize        = .F.
272:             .Visible         = .T.
273:         ENDWITH
274: 
275:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
276:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
277:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
278:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
279:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
280: 
281:         *-- Container Saida - padrao canonico (Left=917, Width=90)
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
292: 
293:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
294:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
295:             .Caption         = "Encerrar"
296:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
297:             .PicturePosition = 13
298:             .Top             = 5
299:             .Left            = 5
300:             .Width           = 75
301:             .Height          = 75
302:             .FontName        = "Comic Sans MS"
303:             .FontBold        = .T.
304:             .FontItalic      = .T.
305:             .FontSize        = 8
306:             .BackColor       = RGB(255, 255, 255)
307:             .ForeColor       = RGB(90, 90, 90)
308:             .Themes          = .F.
309:             .SpecialEffect   = 0
310:             .WordWrap        = .T.
311:             .AutoSize        = .F.
312:             .Visible         = .T.
313:         ENDWITH
314: 
315:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
316: 
317:         *-- Grid de lista de departamentos
318:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
319:         WITH loc_oPagina.grd_4c_Lista
320:             .Top                = 117
321:             .Left               = 26
322:             .Width              = 890
323:             .Height             = 478
324:             .FontName           = "Verdana"
325:             .FontSize           = 8
326:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 365 a 435:
365:         *-- Container botoes Confirmar/Cancelar (padrao canonico Left=842, Width=160)
366:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
367:         WITH loc_oPagina.cnt_4c_BotoesAcao
368:             .Top         = 33
369:             .Left        = 842
370:             .Width       = 160
371:             .Height      = 85
372:             .BackStyle = 1
373:             .BackColor = RGB(255, 255, 255)
374:             .BorderWidth = 0
375:             .Visible     = .T.
376:         ENDWITH
377: 
378:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
379:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
380:             .Caption         = "Confirmar"
381:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
382:             .PicturePosition = 13
383:             .Top             = 5
384:             .Left            = 5
385:             .Width           = 75
386:             .Height          = 75
387:             .FontName        = "Comic Sans MS"
388:             .FontBold        = .T.
389:             .FontItalic      = .T.
390:             .FontSize        = 8
391:             .BackColor       = RGB(255, 255, 255)
392:             .ForeColor       = RGB(90, 90, 90)
393:             .Themes          = .F.
394:             .SpecialEffect   = 0
395:             .WordWrap        = .T.
396:             .AutoSize        = .F.
397:             .Visible         = .T.
398:         ENDWITH
399: 
400:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
401:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
402:             .Caption         = "Encerrar"
403:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
404:             .PicturePosition = 13
405:             .Top             = 5
406:             .Left            = 80
407:             .Width           = 75
408:             .Height          = 75
409:             .FontName        = "Comic Sans MS"
410:             .FontBold        = .T.
411:             .FontItalic      = .T.
412:             .FontSize        = 8
413:             .BackColor       = RGB(255, 255, 255)
414:             .ForeColor       = RGB(90, 90, 90)
415:             .Themes          = .F.
416:             .SpecialEffect   = 0
417:             .WordWrap        = .T.
418:             .AutoSize        = .F.
419:             .Visible         = .T.
420:         ENDWITH
421: 
422:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
423:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
424: 
425:         *-- Label Codigo (Say1: top=141+29=170, left=354)
426:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
427:         WITH loc_oPagina.lbl_4c_Codigo
428:             .Caption   = "C" + CHR(243) + "digo :"
429:             .Top       = 170
430:             .Left      = 354
431:             .Width     = 45
432:             .Height    = 17
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .FontBold  = .F.

*-- Linhas 444 a 469:
444:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
445:         WITH loc_oPagina.txt_4c_Codigo
446:             .Value         = ""
447:             .Top           = 166
448:             .Left          = 400
449:             .Width         = 40
450:             .Height        = 24
451:             .FontName      = "Tahoma"
452:             .FontSize      = 8
453:             .MaxLength     = 2
454:             .Themes        = .F.
455:             .SpecialEffect = 0
456:             .Visible       = .T.
457:         ENDWITH
458: 
459:         *-- Label Descricao (Say2: top=167+29=196, left=341)
460:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
461:         WITH loc_oPagina.lbl_4c_Descricao
462:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
463:             .Top       = 196
464:             .Left      = 341
465:             .Width     = 58
466:             .Height    = 17
467:             .FontName  = "Tahoma"
468:             .FontSize  = 8
469:             .FontBold  = .F.

*-- Linhas 478 a 487:
478:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
479:         WITH loc_oPagina.txt_4c_Descricao
480:             .Value         = ""
481:             .Top           = 192
482:             .Left          = 400
483:             .Width         = 264
484:             .Height        = 24
485:             .FontName      = "Tahoma"
486:             .FontSize      = 8
487:             .MaxLength     = 30

*-- Linhas 514 a 523:
514:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
515: 
516:                 *-- Reconfigurar headers apos RecordSource (VFP reseta captions)
517:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
518:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
519: 
520:                 THIS.FormatarGridLista(loc_oGrid)
521:                 loc_lResultado = .T.
522:             ELSE
523:                 MsgErro("Erro ao carregar departamentos.", "Erro")

*-- Linhas 651 a 667:
651:         loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
652: 
653:         *-- Botoes da Page1: habilitados apenas no modo LISTA
654:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lModoLista
655:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lModoLista
656:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lModoLista
657:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lModoLista
658:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lModoLista
659: 
660:         *-- Botoes da Page2: Confirmar habilitado apenas em edicao, Cancelar sempre
661:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lModoEdicao
662:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
663:     ENDPROC
664: 
665:     *--------------------------------------------------------------------------
666:     * BtnIncluirClick - Novo registro: limpa campos, vai para Page2
667:     *--------------------------------------------------------------------------

*-- Linhas 701 a 709:
701:             THIS.HabilitarCampos(.F.)
702:             THIS.AjustarBotoesPorModo()
703:             THIS.pgf_4c_Paginas.ActivePage = 2
704:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
705:         ENDIF
706:     ENDPROC
707: 
708:     *--------------------------------------------------------------------------
709:     * BtnAlterarClick - Carrega registro selecionado para edicao

*-- Linhas 811 a 819:
811:                     THIS.HabilitarCampos(.F.)
812:                     THIS.AjustarBotoesPorModo()
813:                     THIS.pgf_4c_Paginas.ActivePage = 2
814:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
815:                 ENDIF
816:             ENDIF
817:         CATCH TO loc_oErro
818:             MsgErro(loc_oErro.Message, "FormDpi.BtnBuscarClick")
819:             IF USED("cursor_4c_BuscaDpi")


### BO (C:\4c\projeto\app\classes\DpiBO.prg):
*==============================================================================
* DpiBO.prg - Business Object para Departamentos do Site
* Tabela: SigCdDpi (cods char(2), descs char(30), pkchaves char(20))
*==============================================================================
DEFINE CLASS DpiBO AS BusinessBase

    *-- Propriedades da entidade
    this_cCods      = ""   && cods     char(2)  - codigo do departamento
    this_cDescs     = ""   && descs    char(30) - descricao
    this_cPkChaves  = ""   && pkchaves char(20) - chave primaria (PK)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdDpi"
            THIS.this_cCampoChave = "pkchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK atual para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCods     = TratarNulo(cods,     "C")
            THIS.this_cDescs    = TratarNulo(descs,    "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros (ou filtrados por texto livre)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT cods, descs, pkchaves FROM SigCdDpi"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                           " WHERE cods LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar departamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pela chave de negocio (cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, pkchaves FROM SigCdDpi" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdDpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cSQLDup, loc_nDup
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Verificar duplicidade de codigo
            loc_cSQLDup = "SELECT cods FROM SigCdDpi WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods))
            loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_Dup")
            IF loc_nDup >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF

                *-- Gerar PK
                THIS.this_cPkChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO SigCdDpi (cods, descs, pkchaves)" + ;
                           " VALUES (" + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ;
                           ", " + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
                           ", " + EscaparSQL(THIS.this_cPkChaves) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdDpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdDpi" + ;
                       " SET descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdDpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDpi WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

