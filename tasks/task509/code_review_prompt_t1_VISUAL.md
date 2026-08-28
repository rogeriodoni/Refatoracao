# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 185: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 209: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 257: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 281: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 317: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 393: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 417: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRec.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (986 linhas total):

*-- Linhas 55 a 64:
55:                 ELSE
56:                     THIS.ConfigurarPageFrame()
57: 
58:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
59:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60: 
61:                     THIS.pgf_4c_Paginas.Visible   = .T.
62:                     THIS.pgf_4c_Paginas.ActivePage = 1
63:                     THIS.this_cModoAtual = "LISTA"
64: 

*-- Linhas 86 a 105:
86: 
87:         WITH THIS.pgf_4c_Paginas
88:             .PageCount = 2
89:             .Top       = -29
90:             .Left      = 0
91:             .Width     = THIS.Width
92:             .Height    = THIS.Height + 29
93:             .Tabs      = .F.
94:             .Visible   = .T.
95: 
96:             .Page1.Caption   = "Lista"
97:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page1.BackColor = RGB(255, 255, 255)
99: 
100:             .Page2.Caption   = "Dados"
101:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page2.BackColor = RGB(255, 255, 255)
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()

*-- Linhas 118 a 155:
118:         *-- Container Cabecalho - Top=30 (1+29 compensacao PageFrame)
119:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH loc_oPagina.cnt_4c_Cabecalho
121:             .Top         = 30
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
132:             .Caption   = THIS.Caption
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = THIS.Width - 20
136:             .Height    = 46
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .AutoSize  = .F.
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = THIS.Width - 20
152:             .Height    = 46
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.

*-- Linhas 162 a 339:
162:         *-- Container botoes CRUD - canonico Left=542, Top=29 (0+29 compensacao)
163:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
164:         WITH loc_oPagina.cnt_4c_Botoes
165:             .Top         = 29
166:             .Left        = 542
167:             .Width       = 390
168:             .Height      = 85
169:             .BackStyle   = 0
170:             .BorderWidth = 0
171:             .Visible     = .T.
172:         ENDWITH
173: 
174:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
175:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
176:             .Caption         = "Incluir"
177:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
178:             .PicturePosition = 13
179:             .Top             = 5
180:             .Left            = 5
181:             .Width           = 75
182:             .Height          = 75
183:             .BackColor       = RGB(255, 255, 255)
184:             .ForeColor       = RGB(90, 90, 90)
185:             .FontName        = "Comic Sans MS"
186:             .FontBold        = .T.
187:             .FontItalic      = .T.
188:             .FontSize        = 8
189:             .Themes          = .F.
190:             .SpecialEffect   = 0
191:             .MousePointer    = 15
192:             .WordWrap        = .T.
193:             .AutoSize        = .F.
194:             .Visible         = .T.
195:         ENDWITH
196:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
197: 
198:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .BackColor       = RGB(255, 255, 255)
208:             .ForeColor       = RGB(90, 90, 90)
209:             .FontName        = "Comic Sans MS"
210:             .FontBold        = .T.
211:             .FontItalic      = .T.
212:             .FontSize        = 8
213:             .Themes          = .F.
214:             .SpecialEffect   = 0
215:             .MousePointer    = 15
216:             .WordWrap        = .T.
217:             .AutoSize        = .F.
218:             .Visible         = .T.
219:         ENDWITH
220:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
221: 
222:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
223:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
224:             .Caption         = "Alterar"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .BackColor       = RGB(255, 255, 255)
232:             .ForeColor       = RGB(90, 90, 90)
233:             .FontName        = "Comic Sans MS"
234:             .FontBold        = .T.
235:             .FontItalic      = .T.
236:             .FontSize        = 8
237:             .Themes          = .F.
238:             .SpecialEffect   = 0
239:             .MousePointer    = 15
240:             .WordWrap        = .T.
241:             .AutoSize        = .F.
242:             .Visible         = .T.
243:         ENDWITH
244:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
245: 
246:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
247:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
248:             .Caption         = "Excluir"
249:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
250:             .PicturePosition = 13
251:             .Top             = 5
252:             .Left            = 230
253:             .Width           = 75
254:             .Height          = 75
255:             .BackColor       = RGB(255, 255, 255)
256:             .ForeColor       = RGB(90, 90, 90)
257:             .FontName        = "Comic Sans MS"
258:             .FontBold        = .T.
259:             .FontItalic      = .T.
260:             .FontSize        = 8
261:             .Themes          = .F.
262:             .SpecialEffect   = 0
263:             .MousePointer    = 15
264:             .WordWrap        = .T.
265:             .AutoSize        = .F.
266:             .Visible         = .T.
267:         ENDWITH
268:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
269: 
270:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
271:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
272:             .Caption         = "Buscar"
273:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
274:             .PicturePosition = 13
275:             .Top             = 5
276:             .Left            = 305
277:             .Width           = 75
278:             .Height          = 75
279:             .BackColor       = RGB(255, 255, 255)
280:             .ForeColor       = RGB(90, 90, 90)
281:             .FontName        = "Comic Sans MS"
282:             .FontBold        = .T.
283:             .FontItalic      = .T.
284:             .FontSize        = 8
285:             .Themes          = .F.
286:             .SpecialEffect   = 0
287:             .MousePointer    = 15
288:             .WordWrap        = .T.
289:             .AutoSize        = .F.
290:             .Visible         = .T.
291:         ENDWITH
292:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
293: 
294:         *-- Container Saida - valores canonicos CLAUDE.md regra #10
295:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
296:         WITH loc_oPagina.cnt_4c_Saida
297:             .Top         = 29
298:             .Left        = 917
299:             .Width       = 90
300:             .Height      = 85
301:             .BackStyle   = 0
302:             .BorderWidth = 0
303:             .Visible     = .T.
304:         ENDWITH
305: 
306:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
307:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
308:             .Caption         = "Encerrar"
309:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
310:             .PicturePosition = 13
311:             .Top             = 5
312:             .Left            = 5
313:             .Width           = 75
314:             .Height          = 75
315:             .BackColor       = RGB(255, 255, 255)
316:             .ForeColor       = RGB(90, 90, 90)
317:             .FontName        = "Comic Sans MS"
318:             .FontBold        = .T.
319:             .FontItalic      = .T.
320:             .FontSize        = 8
321:             .Themes          = .F.
322:             .SpecialEffect   = 0
323:             .MousePointer    = 15
324:             .WordWrap        = .T.
325:             .AutoSize        = .F.
326:             .Visible         = .T.
327:         ENDWITH
328:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
329: 
330:         *-- Grid de listagem: Top=117 (88+29), Left=26, Width=890, Height=498
331:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
332:         WITH loc_oPagina.grd_4c_Lista
333:             .Top                = 117
334:             .Left               = 26
335:             .Width              = 890
336:             .Height             = 498
337:             .ColumnCount        = 2
338:             .FontName           = "Verdana"
339:             .FontSize           = 8

*-- Linhas 369 a 456:
369:         *-- Container botoes Confirmar/Cancelar - Top=33 (4+29 compensacao PageFrame)
370:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
371:         WITH loc_oPagina.cnt_4c_BotoesAcao
372:             .Top         = 33
373:             .Left        = 842
374:             .Width       = 160
375:             .Height      = 85
376:             .BackStyle = 1
377:             .BackColor = RGB(255, 255, 255)
378:             .BorderWidth = 0
379:             .Visible     = .T.
380:         ENDWITH
381: 
382:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
383:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
384:             .Caption         = "Confirmar"
385:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
386:             .PicturePosition = 13
387:             .Top             = 5
388:             .Left            = 5
389:             .Width           = 75
390:             .Height          = 75
391:             .BackColor       = RGB(255, 255, 255)
392:             .ForeColor       = RGB(90, 90, 90)
393:             .FontName        = "Comic Sans MS"
394:             .FontBold        = .T.
395:             .FontItalic      = .T.
396:             .FontSize        = 8
397:             .Themes          = .F.
398:             .SpecialEffect   = 0
399:             .MousePointer    = 15
400:             .WordWrap        = .T.
401:             .AutoSize        = .F.
402:             .Visible         = .T.
403:         ENDWITH
404:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
405: 
406:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
407:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
408:             .Caption         = "Encerrar"
409:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
410:             .PicturePosition = 13
411:             .Top             = 5
412:             .Left            = 80
413:             .Width           = 75
414:             .Height          = 75
415:             .BackColor       = RGB(255, 255, 255)
416:             .ForeColor       = RGB(90, 90, 90)
417:             .FontName        = "Comic Sans MS"
418:             .FontBold        = .T.
419:             .FontItalic      = .T.
420:             .FontSize        = 8
421:             .Themes          = .F.
422:             .SpecialEffect   = 0
423:             .MousePointer    = 15
424:             .WordWrap        = .T.
425:             .AutoSize        = .F.
426:             .Visible         = .T.
427:         ENDWITH
428:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
429: 
430:         *-- Label titulo secao (lbl_cadastro legado: top=175, left=255; compensado +29=204)
431:         loc_oPagina.AddObject("lbl_4c_Cadastro", "Label")
432:         WITH loc_oPagina.lbl_4c_Cadastro
433:             .Caption   = "Cadastro de Contas a Receber"
434:             .Top       = 204
435:             .Left      = 255
436:             .Width     = 280
437:             .Height    = 17
438:             .FontName  = "Tahoma"
439:             .FontSize  = 8
440:             .FontBold  = .F.
441:             .ForeColor = RGB(90, 90, 90)
442:             .BackStyle = 0
443:             .Visible   = .T.
444:         ENDWITH
445: 
446:         *-- Label "Grupo :" (lbl_grupo legado: top=198, left=206, width=38; compensado +29=227)
447:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
448:         WITH loc_oPagina.lbl_4c_Grupo
449:             .Caption   = "Grupo :"
450:             .Top       = 227
451:             .Left      = 206
452:             .Width     = 38
453:             .Height    = 17
454:             .FontName  = "Tahoma"
455:             .FontSize  = 8
456:             .FontBold  = .F.

*-- Linhas 464 a 473:
464:         loc_oPagina.AddObject("txt_4c_CdGrupo", "TextBox")
465:         WITH loc_oPagina.txt_4c_CdGrupo
466:             .Value     = ""
467:             .Top       = 222
468:             .Left      = 253
469:             .Width     = 79
470:             .Height    = 23
471:             .FontName  = "Tahoma"
472:             .FontSize  = 8
473:             .MaxLength = 10

*-- Linhas 483 a 492:
483:         loc_oPagina.AddObject("txt_4c_DsGrupo", "TextBox")
484:         WITH loc_oPagina.txt_4c_DsGrupo
485:             .Value     = ""
486:             .Top       = 222
487:             .Left      = 335
488:             .Width     = 150
489:             .Height    = 23
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .MaxLength = 40

*-- Linhas 522 a 534:
522:                     WITH loc_oGrid
523:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
524:                         .Column1.Width           = 100
525:                         .Column1.Header1.Caption = "Grupo"
526: 
527:                         .Column2.ControlSource   = "cursor_4c_Dados.descrs"
528:                         .Column2.Width           = 780
529:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
530:                     ENDWITH
531: 
532:                     THIS.FormatarGridLista(loc_oGrid)
533:                     loc_lResultado = .T.
534:                 ELSE

*-- Linhas 802 a 817:
802: 
803:         DO CASE
804:             CASE THIS.this_cModoAtual = "VISUALIZAR"
805:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
806:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
807:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
808:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
809:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
810:             OTHERWISE
811:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
812:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
813:         ENDCASE
814:     ENDPROC
815: 
816:     *==========================================================================
817:     * CdGrupoKeyPress - F4 em txt_4c_CdGrupo abre lookup SigCdGcr


### BO (C:\4c\projeto\app\classes\RecBO.prg):
*====================================================================
* RecBO.prg
*
* Business Object para Cadastro Financeiro de Recebimentos
* Tabela: SIGCDREC
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS RecBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SIGCDREC)
    this_cGrupos    = ""    && grupos char(10) - PK (FK -> SigCdGcr.codigos)
    this_cDescrs    = ""    && descrs char(20)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SIGCDREC"
            THIS.this_cCampoChave = "grupos"
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro ao inicializar RecBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna PK atual para auditoria (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cGrupos
    ENDFUNC

    *====================================================================
    * Buscar - SELECT todos os registros (PUBLIC)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs" + ;
                       " FROM SIGCDREC" + ;
                       " ORDER BY grupos"

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar recebimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar recebimentos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo PK (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cGrupos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs" + ;
                       " FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos)

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos = TratarNulo(grupos, "C")
            THIS.this_cDescrs = TratarNulo(descrs, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Inserir - INSERT na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCDREC (grupos, descrs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cGrupos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDREC SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ValidarDados - Valida regras de negocio antes de salvar (PUBLIC)
    *====================================================================
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cGrupos))
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * VerificarCodigoExiste - Verifica se grupo ja cadastrado em SIGCDREC (PUBLIC)
    * Equivalente ao ChkRegister('SigCdRec','grupos',...) do legado
    *====================================================================
    FUNCTION VerificarCodigoExiste(par_cGrupos)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT grupos FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos)

            IF USED("cursor_4c_ChkCod")
                TABLEREVERT(.T., "cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkCod") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *====================================================================
    * BuscarGrupoGcr - Busca grupo em SigCdGcr por codigo ou descricao (PUBLIC)
    * Equivalente ao fAcessoContab() do legado
    * par_cTipo = 'C' busca por codigo, 'D' busca por descricao
    *====================================================================
    FUNCTION BuscarGrupoGcr(par_cValor, par_cTipo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF par_cTipo = "C"
                loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                           " WHERE codigos = " + EscaparSQL(par_cValor) + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                           " WHERE descrs LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + ;
                           " ORDER BY descrs"
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                TABLEREVERT(.T., "cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Destroy - Libera cursores
    *====================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_ChkCod")
            USE IN cursor_4c_ChkCod
        ENDIF
        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

