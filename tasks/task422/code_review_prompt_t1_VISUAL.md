# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [FONTNAME-ERRADO] Linha 184: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 208: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 232: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 256: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 280: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 403: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 428: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFornecedor.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1027 linhas total):

*-- Linhas 48 a 57:
48:                     "FormFornecedor.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Visible    = .T.
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

*-- Linhas 115 a 152:
115:         *-- Original: Top=1. Com compensacao PageFrame +29: Top=31
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 31
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

*-- Linhas 161 a 320:
161:         *-- Botoes Incluir/Visualizar/Alterar/Excluir/Buscar adicionados na Fase 4
162:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
163:         WITH loc_oPagina.cnt_4c_Botoes
164:             .Top         = 29
165:             .Left        = 542
166:             .Width       = 390
167:             .Height      = 85
168:             .BackStyle   = 0
169:             .BorderWidth = 0
170:             .Visible     = .T.
171:         ENDWITH
172: 
173:         *-- Botoes CRUD dentro de cnt_4c_Botoes (framework: Left=5/80/155/230/305, Top=5)
174:         *-- FontName="Comic Sans MS" conforme framework_frmcadastro_layout.md
175:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
176:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
177:             .Caption         = "Incluir"
178:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
179:             .PicturePosition = 13
180:             .Top             = 5
181:             .Left            = 5
182:             .Width           = 75
183:             .Height          = 75
184:             .FontName        = "Comic Sans MS"
185:             .FontBold        = .T.
186:             .FontItalic      = .T.
187:             .FontSize        = 8
188:             .ForeColor       = RGB(90, 90, 90)
189:             .BackColor       = RGB(255, 255, 255)
190:             .Themes          = .F.
191:             .SpecialEffect   = 0
192:             .MousePointer    = 15
193:             .WordWrap        = .T.
194:             .AutoSize        = .F.
195:             .Visible         = .T.
196:         ENDWITH
197:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
198: 
199:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
201:             .Caption         = "Visualizar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 80
206:             .Width           = 75
207:             .Height          = 75
208:             .FontName        = "Comic Sans MS"
209:             .FontBold        = .T.
210:             .FontItalic      = .T.
211:             .FontSize        = 8
212:             .ForeColor       = RGB(90, 90, 90)
213:             .BackColor       = RGB(255, 255, 255)
214:             .Themes          = .F.
215:             .SpecialEffect   = 0
216:             .MousePointer    = 15
217:             .WordWrap        = .T.
218:             .AutoSize        = .F.
219:             .Visible         = .T.
220:         ENDWITH
221:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
222: 
223:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
224:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
225:             .Caption         = "Alterar"
226:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
227:             .PicturePosition = 13
228:             .Top             = 5
229:             .Left            = 155
230:             .Width           = 75
231:             .Height          = 75
232:             .FontName        = "Comic Sans MS"
233:             .FontBold        = .T.
234:             .FontItalic      = .T.
235:             .FontSize        = 8
236:             .ForeColor       = RGB(90, 90, 90)
237:             .BackColor       = RGB(255, 255, 255)
238:             .Themes          = .F.
239:             .SpecialEffect   = 0
240:             .MousePointer    = 15
241:             .WordWrap        = .T.
242:             .AutoSize        = .F.
243:             .Visible         = .T.
244:         ENDWITH
245:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
246: 
247:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
248:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
249:             .Caption         = "Excluir"
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
251:             .PicturePosition = 13
252:             .Top             = 5
253:             .Left            = 230
254:             .Width           = 75
255:             .Height          = 75
256:             .FontName        = "Comic Sans MS"
257:             .FontBold        = .T.
258:             .FontItalic      = .T.
259:             .FontSize        = 8
260:             .ForeColor       = RGB(90, 90, 90)
261:             .BackColor       = RGB(255, 255, 255)
262:             .Themes          = .F.
263:             .SpecialEffect   = 0
264:             .MousePointer    = 15
265:             .WordWrap        = .T.
266:             .AutoSize        = .F.
267:             .Visible         = .T.
268:         ENDWITH
269:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
270: 
271:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
272:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
273:             .Caption         = "Buscar"
274:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
275:             .PicturePosition = 13
276:             .Top             = 5
277:             .Left            = 305
278:             .Width           = 75
279:             .Height          = 75
280:             .FontName        = "Comic Sans MS"
281:             .FontBold        = .T.
282:             .FontItalic      = .T.
283:             .FontSize        = 8
284:             .ForeColor       = RGB(90, 90, 90)
285:             .BackColor       = RGB(255, 255, 255)
286:             .Themes          = .F.
287:             .SpecialEffect   = 0
288:             .MousePointer    = 15
289:             .WordWrap        = .T.
290:             .AutoSize        = .F.
291:             .Visible         = .T.
292:         ENDWITH
293:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
294: 
295:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
296:         *-- Legado: Grupo_Saida.Left=719, Top=-1. Canonico: Left=917, Top=29, Width=90
297:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
298:         WITH loc_oPagina.cnt_4c_Saida
299:             .Top         = 29
300:             .Left        = 917
301:             .Width       = 90
302:             .Height      = 85
303:             .BackStyle   = 0
304:             .BorderWidth = 0
305:             .Visible     = .T.
306:         ENDWITH
307: 
308:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
309:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 5
316:             .Width           = 75
317:             .Height          = 75
318:             .FontName        = "Tahoma"
319:             .FontBold        = .T.
320:             .FontItalic      = .T.

*-- Linhas 328 a 345:
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid de lista (grade no legado: Top=121, Left=12, 1 coluna Formas w=94)
334:         *-- Framework canonico: Top=117(88+29), Left=26, Width=890, Height=498
335:         *-- Problema 36: ColumnCount FORA do WITH; ControlSource definido em CarregarLista()
336:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
337:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
338:         WITH loc_oPagina.grd_4c_Lista
339:             .Top                = 117
340:             .Left               = 26
341:             .Width              = 890
342:             .Height             = 498
343:             .FontName           = "Verdana"
344:             .FontSize           = 8
345:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 356 a 454:
356:             .Visible            = .T.
357:             .Column1.Width      = 200
358:             .Column2.Width      = 400
359:             .Column1.Header1.Caption = "Forma de Pagamento"
360:             .Column2.Header1.Caption = "Inf. Complementar"
361:         ENDWITH
362: 
363:         THIS.TornarControlesVisiveis(loc_oPagina)
364:     ENDPROC
365: 
366:     *=========================================================================
367:     * ConfigurarPaginaDados - Configura Page2 com containers principais
368:     * Fase 3: cnt_4c_BotoesAcao (vazio)
369:     * Fase 4 adiciona: botoes Confirmar/Cancelar em cnt_4c_BotoesAcao
370:     * Fases 5-6 adicionam: txt_4c_Formas, lbl_4c_FormasPgto,
371:     *                       txt_4c_Infos, lbl_4c_InfComplementar
372:     *=========================================================================
373:     PROTECTED PROCEDURE ConfigurarPaginaDados()
374:         LOCAL loc_oPagina
375:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
376: 
377:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
378: 
379:         *-- Container BotoesAcao (Grupo_Salva no legado: Salva.Left=5, Cancelar.Left=81)
380:         *-- Canonico framework: Top=4+29=33, Left=842, Width=160, Height=85
381:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
382:         WITH loc_oPagina.cnt_4c_BotoesAcao
383:             .Top         = 33
384:             .Left        = 842
385:             .Width       = 160
386:             .Height      = 85
387:             .BackStyle = 1
388:             .BackColor   = RGB(255, 255, 255)
389:             .BorderWidth = 0
390:             .Visible     = .T.
391:         ENDWITH
392: 
393:         *-- Botao Confirmar (Salvar) - Left=5 conforme legado Grupo_Salva
394:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
395:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
396:             .Caption         = "Confirmar"
397:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
398:             .PicturePosition = 13
399:             .Top             = 5
400:             .Left            = 5
401:             .Width           = 75
402:             .Height          = 75
403:             .FontName        = "Comic Sans MS"
404:             .FontBold        = .T.
405:             .FontItalic      = .T.
406:             .FontSize        = 8
407:             .ForeColor       = RGB(90, 90, 90)
408:             .BackColor       = RGB(255, 255, 255)
409:             .Themes          = .F.
410:             .SpecialEffect   = 0
411:             .MousePointer    = 15
412:             .WordWrap        = .T.
413:             .AutoSize        = .F.
414:             .Visible         = .T.
415:         ENDWITH
416:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
417: 
418:         *-- Botao Cancelar - Left=80 conforme legado Grupo_Salva
419:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
420:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
421:             .Caption         = "Encerrar"
422:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
423:             .PicturePosition = 13
424:             .Top             = 5
425:             .Left            = 80
426:             .Width           = 75
427:             .Height          = 75
428:             .FontName        = "Comic Sans MS"
429:             .FontBold        = .T.
430:             .FontItalic      = .T.
431:             .FontSize        = 8
432:             .ForeColor       = RGB(90, 90, 90)
433:             .BackColor       = RGB(255, 255, 255)
434:             .Themes          = .F.
435:             .SpecialEffect   = 0
436:             .MousePointer    = 15
437:             .WordWrap        = .T.
438:             .AutoSize        = .F.
439:             .Visible         = .T.
440:         ENDWITH
441:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
442: 
443:         *-- Label "Forma de Pagamento : " (Say8 original: Top=173, Left=196; +29 compensacao)
444:         *-- ForeColor=RGB(90,90,90) copiado do original
445:         loc_oPagina.AddObject("lbl_4c_FormasPgto", "Label")
446:         WITH loc_oPagina.lbl_4c_FormasPgto
447:             .Caption   = "Forma de Pagamento : "
448:             .Top       = 202
449:             .Left      = 196
450:             .Width     = 110
451:             .Height    = 17
452:             .FontName  = "Tahoma"
453:             .FontSize  = 8
454:             .FontBold  = .F.

*-- Linhas 463 a 472:
463:         loc_oPagina.AddObject("txt_4c_Formas", "TextBox")
464:         WITH loc_oPagina.txt_4c_Formas
465:             .Value         = ""
466:             .Top           = 198
467:             .Left          = 311
468:             .Width         = 94
469:             .Height        = 20
470:             .FontName      = "Tahoma"
471:             .FontSize      = 8
472:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 478 a 490:
478: 
479:         *-- Label "Inf. Complementar : " (Say7 original: Top=197, Left=208; +29 compensacao)
480:         *-- ForeColor=RGB(90,90,90) copiado do original
481:         loc_oPagina.AddObject("lbl_4c_InfComplementar", "Label")
482:         WITH loc_oPagina.lbl_4c_InfComplementar
483:             .Caption   = "Inf. Complementar : "
484:             .Top       = 226
485:             .Left      = 208
486:             .Width     = 100
487:             .Height    = 17
488:             .FontName  = "Tahoma"
489:             .FontSize  = 8
490:             .FontBold  = .F.

*-- Linhas 499 a 508:
499:         loc_oPagina.AddObject("txt_4c_Infos", "TextBox")
500:         WITH loc_oPagina.txt_4c_Infos
501:             .Value       = ""
502:             .Top         = 223
503:             .Left        = 311
504:             .Width       = 24
505:             .Height      = 20
506:             .FontName    = "Tahoma"
507:             .FontSize    = 8
508:             .ForeColor   = RGB(0, 0, 0)

*-- Linhas 548 a 557:
548:                     loc_oGrid.Column2.Width = 400
549: 
550:                     *-- Problema 2/32: Headers APOS RecordSource (RecordSource reseta captions)
551:                     loc_oGrid.Column1.Header1.Caption = "Forma de Pagamento"
552:                     loc_oGrid.Column2.Header1.Caption = "Inf. Complementar"
553: 
554:                     THIS.FormatarGridLista(loc_oGrid)
555:                 ENDIF
556: 
557:                 loc_lResultado = .T.

*-- Linhas 901 a 913:
901:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
902: 
903:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
904:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
905:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
906:             ENDIF
907:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
908:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
909:             ENDIF
910:         ENDIF
911:     ENDPROC
912: 
913:     *=========================================================================


### BO (C:\4c\projeto\app\classes\FornecedorBO.prg):
*====================================================================
* FornecedorBO.prg
*
* Business Object para Cadastro de Formas de Pagamento
* Tabela: SigCdFrm
* Herda de: BusinessBase
*
* Origem: SIGCDFOR (SIG CaDastro FORmas de pagamento)
*====================================================================

DEFINE CLASS FornecedorBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdFrm)
    this_cFormas = ""    && formas char(12) NOT NULL - PK (Forma de Pagamento)
    this_cInfos  = ""    && infos  char(1)  NOT NULL - Inf. Complementar (FK SigPrInf.Infos)

    *====================================================================
    * Init - Inicializa Business Object
    *
    * Define nome da tabela e campo chave para uso pela BusinessBase
    * (Buscar, CarregarPorCodigo, Inserir, Atualizar, ExecutarExclusao,
    *  RegistrarAuditoria, etc.)
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFrm"
            THIS.this_cCampoChave = "formas"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro("Erro ao inicializar FornecedorBO:" + CHR(13) + ;
                        loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cFormas)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cFormas = TratarNulo(formas, "C")
                THIS.this_cInfos  = TratarNulo(infos,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "FornecedorBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Logica original: formas nao pode ser vazio + check duplicata em INSERIR
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cFormas)
            MsgAviso("Forma de Pagamento Inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarFormaExistente(THIS.this_cFormas)
                MsgAviso("Forma de Pagamento j" + CHR(225) + " cadastrada.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarFormaExistente - Verifica se formas ja existe no banco
    *====================================================================
    PROCEDURE VerificarFormaExistente(par_cFormas)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdFrm" + ;
                " WHERE formas = " + EscaparSQL(par_cFormas)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFrm")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkFrm")
                SELECT cursor_4c_ChkFrm
                loc_lExiste = (cursor_4c_ChkFrm.qtd > 0)
                USE IN cursor_4c_ChkFrm
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar forma:" + CHR(13) + loException.Message, "FornecedorBO.VerificarFormaExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdFrm
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdFrm (formas, infos)
                VALUES (
                    <<EscaparSQL(THIS.this_cFormas)>>,
                    <<EscaparSQL(THIS.this_cInfos)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir Forma de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "FornecedorBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdFrm
    * Nota: formas e a PK e nao pode ser alterada
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdFrm
                SET infos = <<EscaparSQL(THIS.this_cInfos)>>
                WHERE formas = <<EscaparSQL(THIS.this_cFormas)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar Forma de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "FornecedorBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdFrm
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFrm WHERE formas = " + EscaparSQL(THIS.this_cFormas)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir Forma de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "FornecedorBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com formas, infos, descrs (JOIN SigPrInf)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (formas C(12), infos C(1), descrs C(15))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.formas, a.infos, ISNULL(b.descrs,'') AS descrs" + ;
                    " FROM SigCdFrm a" + ;
                    " LEFT JOIN SigPrInf b ON b.infos = a.infos"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.formas"

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
                        MostrarErro("Erro ao buscar Formas de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar Formas de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FornecedorBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (formas)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT formas, infos FROM SigCdFrm" + ;
                " WHERE formas = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Forma de Pagamento n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar Forma de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "FornecedorBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

