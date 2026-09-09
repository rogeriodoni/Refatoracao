# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTAN.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (991 linhas total):

*-- Linhas 87 a 158:
87: 
88:         WITH loc_oPgf
89:             .PageCount = 2
90:             .Top       = -29
91:             .Left      = 0
92:             .Width     = THIS.Width
93:             .Height    = THIS.Height + 29
94:             .Tabs      = .F.
95:             .Visible   = .T.
96:             .Page1.Caption   = "Lista"
97:             .Page1.BackColor = RGB(100, 100, 100)
98:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.Caption   = "Dados"
100:             .Page2.BackColor = RGB(100, 100, 100)
101:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:         ENDWITH
103: 
104:         THIS.ConfigurarPaginaLista()
105:         THIS.ConfigurarPaginaDados()
106:     ENDPROC
107: 
108:     *--------------------------------------------------------------------------
109:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, saida e grid
110:     * Compensacao +29: PageFrame.Top=-29 desloca conteudo 29px para cima
111:     * cnt_4c_Cabecalho: Top=2+29=31 | cnt_4c_Botoes: Top=0+29=29
112:     * grd_4c_Lista: Top=107+29=136, Left=30, Width=941, Height=470
113:     * Colunas (legado pColuna): codigos(80), descs(337)
114:     *--------------------------------------------------------------------------
115:     PROTECTED PROCEDURE ConfigurarPaginaLista()
116:         LOCAL loc_oPg1, loc_oCab
117:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
118: 
119:         *-- Cabecalho cinza com titulo
120:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
121:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
122:         WITH loc_oCab
123:             .Top         = 31
124:             .Left        = 0
125:             .Width       = THIS.Width
126:             .Height      = 80
127:             .BackColor   = RGB(100, 100, 100)
128:             .BorderWidth = 0
129:             .Visible     = .T.
130:         ENDWITH
131: 
132:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
133:         WITH loc_oCab.lbl_4c_Sombra
134:             .AutoSize  = .F.
135:             .Caption   = THIS.Caption
136:             .Top       = 15
137:             .Left      = 10
138:             .Width     = THIS.Width
139:             .Height    = 40
140:             .FontName  = "Tahoma"
141:             .FontSize  = 16
142:             .FontBold  = .T.
143:             .ForeColor = RGB(0, 0, 0)
144:             .BackStyle = 0
145:             .Visible   = .T.
146:         ENDWITH
147: 
148:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oCab.lbl_4c_Titulo
150:             .AutoSize  = .F.
151:             .Caption   = THIS.Caption
152:             .Top       = 18
153:             .Left      = 10
154:             .Width     = THIS.Width
155:             .Height    = 46
156:             .FontName  = "Tahoma"
157:             .FontSize  = 16
158:             .FontBold  = .T.

*-- Linhas 164 a 325:
164:         *-- Container de botoes CRUD (grupo_op: Left=542, Top=0 -> 29, Width=390, Height=85)
165:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
166:         WITH loc_oPg1.cnt_4c_Botoes
167:             .Top         = 29
168:             .Left        = 542
169:             .Width       = 390
170:             .Height      = 85
171:             .BackStyle   = 0
172:             .BorderWidth = 0
173:             .Visible     = .T.
174:         ENDWITH
175: 
176:         *-- Botao Incluir (Left=5)
177:         loc_oPg1.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
178:         WITH loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir
179:             .Caption         = "Incluir"
180:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
181:             .PicturePosition = 13
182:             .Width           = 75
183:             .Height          = 75
184:             .Left            = 5
185:             .Top             = 5
186:             .FontName        = "Tahoma"
187:             .FontSize        = 8
188:             .Themes          = .F.
189:             .SpecialEffect   = 0
190:             .BackColor       = RGB(255, 255, 255)
191:             .ForeColor       = RGB(90, 90, 90)
192:             .WordWrap        = .T.
193:             .Visible         = .T.
194:         ENDWITH
195:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
196: 
197:         *-- Botao Visualizar (Left=80)
198:         loc_oPg1.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Width           = 75
204:             .Height          = 75
205:             .Left            = 80
206:             .Top             = 5
207:             .FontName        = "Tahoma"
208:             .FontSize        = 8
209:             .Themes          = .F.
210:             .SpecialEffect   = 0
211:             .BackColor       = RGB(255, 255, 255)
212:             .ForeColor       = RGB(90, 90, 90)
213:             .WordWrap        = .T.
214:             .Visible         = .T.
215:         ENDWITH
216:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
217: 
218:         *-- Botao Alterar (Left=155)
219:         loc_oPg1.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
220:         WITH loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar
221:             .Caption         = "Alterar"
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:             .PicturePosition = 13
224:             .Width           = 75
225:             .Height          = 75
226:             .Left            = 155
227:             .Top             = 5
228:             .FontName        = "Tahoma"
229:             .FontSize        = 8
230:             .Themes          = .F.
231:             .SpecialEffect   = 0
232:             .BackColor       = RGB(255, 255, 255)
233:             .ForeColor       = RGB(90, 90, 90)
234:             .WordWrap        = .T.
235:             .Visible         = .T.
236:         ENDWITH
237:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
238: 
239:         *-- Botao Excluir (Left=230)
240:         loc_oPg1.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
241:         WITH loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir
242:             .Caption         = "Excluir"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
244:             .PicturePosition = 13
245:             .Width           = 75
246:             .Height          = 75
247:             .Left            = 230
248:             .Top             = 5
249:             .FontName        = "Tahoma"
250:             .FontSize        = 8
251:             .Themes          = .F.
252:             .SpecialEffect   = 0
253:             .BackColor       = RGB(255, 255, 255)
254:             .ForeColor       = RGB(90, 90, 90)
255:             .WordWrap        = .T.
256:             .Visible         = .T.
257:         ENDWITH
258:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
259: 
260:         *-- Botao Buscar (Left=305)
261:         loc_oPg1.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
262:         WITH loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar
263:             .Caption         = "Buscar"
264:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
265:             .PicturePosition = 13
266:             .Width           = 75
267:             .Height          = 75
268:             .Left            = 305
269:             .Top             = 5
270:             .FontName        = "Tahoma"
271:             .FontSize        = 8
272:             .Themes          = .F.
273:             .SpecialEffect   = 0
274:             .BackColor       = RGB(255, 255, 255)
275:             .ForeColor       = RGB(90, 90, 90)
276:             .WordWrap        = .T.
277:             .Visible         = .T.
278:         ENDWITH
279:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
280: 
281:         *-- Container de saida (padrao canonico CLAUDE.md #10: Left=917, Width=90)
282:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
283:         WITH loc_oPg1.cnt_4c_Saida
284:             .Top         = 29
285:             .Left        = 917
286:             .Width       = 90
287:             .Height      = 85
288:             .BackStyle   = 0
289:             .BorderWidth = 0
290:             .Visible     = .T.
291:         ENDWITH
292: 
293:         loc_oPg1.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
294:         WITH loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar
295:             .Caption         = "Encerrar"
296:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
297:             .PicturePosition = 13
298:             .Width           = 75
299:             .Height          = 75
300:             .Left            = 5
301:             .Top             = 5
302:             .FontName        = "Tahoma"
303:             .FontSize        = 8
304:             .Themes          = .F.
305:             .SpecialEffect   = 0
306:             .BackColor       = RGB(255, 255, 255)
307:             .ForeColor       = RGB(90, 90, 90)
308:             .WordWrap        = .T.
309:             .Visible         = .T.
310:         ENDWITH
311:         BINDEVENT(loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
312: 
313:         *-- Grade de lista (grade: Left=30, Top=107 -> 136, Width=941, Height=470)
314:         *-- 2 colunas (legado pColuna): codigos(80), descs(337)
315:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
316:         loc_oPg1.grd_4c_Lista.RecordSource = ""
317:         loc_oPg1.grd_4c_Lista.ColumnCount  = 2
318:         WITH loc_oPg1.grd_4c_Lista
319:             .Top                = 136
320:             .Left               = 30
321:             .Width              = 941
322:             .Height             = 470
323:             .ReadOnly           = .T.
324:             .DeleteMark         = .F.
325:             .RecordMark         = .F.

*-- Linhas 362 a 371:
362:                     loc_oGrid.Column1.Width = 80
363:                     loc_oGrid.Column2.Width = 337
364: 
365:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
366:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
367: 
368:                     THIS.FormatarGridLista(loc_oGrid)
369:                     loc_oGrid.Refresh()
370:                     loc_lResultado = .T.
371:                 ENDIF

*-- Linhas 419 a 427:
419:     * ConfigurarPaginaDados - Page2: cabecalho, botoes de acao e campos
420:     * FASE 5/8: adicionado cabecalho + campo Codigo (50% dos campos)
421:     * FASE 6/8: campo Descricao (50% restante) + botoes Confirmar/Cancelar
422:     * Compensacao +29 (PageFrame.Top=-29):
423:     *   Say1 (Codigo):    Top=167+29=196, Left=242
424:     *   get_Cod:          Top=164+29=193, Left=295, Width=24
425:     *   Say2 (Descricao): Top=194+29=223, Left=226
426:     *   Get_Desc:         Top=192+29=221, Left=295, Width=150
427:     * Sem lookups: comportamento.json confirma temLookup=false em todos os

*-- Linhas 434 a 471:
434:         *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
435:         loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
436:         WITH loc_oPg2.cnt_4c_Cabecalho
437:             .Top           = 29
438:             .Left          = 0
439:             .Width         = THIS.Width
440:             .Height        = 80
441:             .BackColor     = RGB(100, 100, 100)
442:             .BorderWidth   = 0
443:             .SpecialEffect = 0
444:             .Visible       = .T.
445: 
446:             .AddObject("lbl_4c_Sombra", "Label")
447:             WITH .lbl_4c_Sombra
448:                 .Caption   = THIS.Caption
449:                 .Top       = 15
450:                 .Left      = 10
451:                 .Width     = THIS.Width
452:                 .Height    = 40
453:                 .FontName  = "Tahoma"
454:                 .FontSize  = 16
455:                 .FontBold  = .T.
456:                 .ForeColor = RGB(0, 0, 0)
457:                 .BackStyle = 0
458:                 .AutoSize  = .F.
459:                 .Visible   = .T.
460:             ENDWITH
461: 
462:             .AddObject("lbl_4c_Titulo", "Label")
463:             WITH .lbl_4c_Titulo
464:                 .Caption   = THIS.Caption
465:                 .Top       = 18
466:                 .Left      = 10
467:                 .Width     = THIS.Width
468:                 .Height    = 46
469:                 .FontName  = "Tahoma"
470:                 .FontSize  = 16
471:                 .FontBold  = .T.

*-- Linhas 480 a 504:
480:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
481:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
482:         WITH loc_oBotoesAcao
483:             .Top         = 33
484:             .Left        = 842
485:             .Width       = 160
486:             .Height      = 85
487:             .BackStyle   = 0
488:             .BorderWidth = 0
489:             .Visible     = .T.
490:         ENDWITH
491: 
492:         *-- Botao Confirmar/Salvar (Salva: Left=5)
493:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
494:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
495:             .Caption         = "Confirmar"
496:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
497:             .PicturePosition = 13
498:             .Top             = 5
499:             .Left            = 5
500:             .Width           = 75
501:             .Height          = 75
502:             .BackColor       = RGB(255, 255, 255)
503:             .ForeColor       = RGB(90, 90, 90)
504:             .FontName        = "Tahoma"

*-- Linhas 512 a 529:
512:             .AutoSize        = .F.
513:             .Visible         = .T.
514:         ENDWITH
515:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
516: 
517:         *-- Botao Cancelar (Cancelar: Left=88)
518:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
519:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
520:             .Caption         = "Encerrar"
521:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
522:             .PicturePosition = 13
523:             .Top             = 5
524:             .Left            = 80
525:             .Width           = 75
526:             .Height          = 75
527:             .BackColor       = RGB(255, 255, 255)
528:             .ForeColor       = RGB(90, 90, 90)
529:             .FontName        = "Tahoma"

*-- Linhas 537 a 556:
537:             .AutoSize        = .F.
538:             .Visible         = .T.
539:         ENDWITH
540:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
541: 
542:         *======================================================================
543:         * Campo: Codigo (codigos N(2,0) - PK)
544:         * Say1: Top=167+29=196, Left=242 | get_Cod: Top=164+29=193, Left=295, Width=24
545:         *======================================================================
546:         loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
547:         WITH loc_oPg2.lbl_4c_Codigo
548:             .AutoSize  = .F.
549:             .Caption   = "C" + CHR(243) + "digo :"
550:             .Top       = 196
551:             .Left      = 242
552:             .Width     = 45
553:             .Height    = 15
554:             .FontName  = "Tahoma"
555:             .FontSize  = 8
556:             .FontBold  = .F.

*-- Linhas 562 a 571:
562: 
563:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
564:         WITH loc_oPg2.txt_4c_Codigo
565:             .Top          = 193
566:             .Left         = 295
567:             .Width        = 24
568:             .Height       = 24
569:             .InputMask    = "99"
570:             .FontName     = "Tahoma"
571:             .FontSize     = 8

*-- Linhas 579 a 592:
579:         * Campo: Descricao (descs char(20) NOT NULL)
580:         * Say2: Top=194+29=223, Left=226 | Get_Desc: Top=192+29=221, Left=295, Width=150
581:         *======================================================================
582:         loc_oPg2.AddObject("lbl_4c_Descricao", "Label")
583:         WITH loc_oPg2.lbl_4c_Descricao
584:             .AutoSize  = .F.
585:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
586:             .Top       = 223
587:             .Left      = 226
588:             .Width     = 61
589:             .Height    = 15
590:             .FontName  = "Tahoma"
591:             .FontSize  = 8
592:             .FontBold  = .F.

*-- Linhas 598 a 607:
598: 
599:         loc_oPg2.AddObject("txt_4c_Descricao", "TextBox")
600:         WITH loc_oPg2.txt_4c_Descricao
601:             .Top          = 221
602:             .Left         = 295
603:             .Width        = 150
604:             .Height       = 24
605:             .MaxLength    = 20
606:             .FontName     = "Tahoma"
607:             .FontSize     = 8

*-- Linhas 661 a 669:
661:                 THIS.HabilitarCampos(.F.)
662:                 THIS.AjustarBotoesPorModo()
663:                 THIS.AlternarPagina(2)
664:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
665:                 loc_lResultado = .T.
666:             ENDIF
667:         CATCH TO loc_oErro
668:             MsgErro(loc_oErro.Message, "FormTAN.BtnVisualizarClick")
669:         ENDTRY

*-- Linhas 936 a 945:
936:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
937: 
938:         TRY
939:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
940:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
941:         CATCH TO loc_oErro
942:             MsgErro(loc_oErro.Message, "FormTAN.AjustarBotoesPorModo")
943:         ENDTRY
944:     ENDPROC
945: 


### BO (C:\4c\projeto\app\classes\TANBO.prg):
*==============================================================================
* TANBO.prg
*
* Business Object para Tipos de Analises (SigPrTpa)
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS TANBO AS BusinessBase

    *-- Propriedades da tabela SigPrTpa
    this_nCodigo    = 0     && codigos    numeric(2,0)  PK
    this_cDescricao = ""    && descs      char(20)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTpa"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                MostrarErro(loException.Message, "TANBO.Init")
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigo)
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de tipos de analise no cursor_4c_Dados
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigos, descs" + ;
                           " FROM SigPrTpa" + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descs" + ;
                           " FROM SigPrTpa" + ;
                           " WHERE codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
                           " ORDER BY codigos"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tipos de an" + CHR(225) + "lise:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar tipos de an" + CHR(225) + "lise:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs" + ;
                       " FROM SigPrTpa" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar tipo de an" + CHR(225) + "lise:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodigo    = TratarNulo(codigos, "N")
            THIS.this_cDescricao = TratarNulo(descs, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigPrTpa
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrTpa (codigos, descs)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tipo de an" + CHR(225) + "lise:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir tipo de an" + CHR(225) + "lise:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigPrTpa
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrTpa SET" + ;
                       " descs = " + EscaparSQL(THIS.this_cDescricao) + ;
                       " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tipo de an" + CHR(225) + "lise:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar tipo de an" + CHR(225) + "lise:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE da tabela SigPrTpa
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTpa WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tipo de an" + CHR(225) + "lise:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir tipo de an" + CHR(225) + "lise:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

