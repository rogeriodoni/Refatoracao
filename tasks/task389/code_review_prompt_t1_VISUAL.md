# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 186: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 210: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 234: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 258: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 282: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 318: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 404: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCtg.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1004 linhas total):

*-- Linhas 49 a 58:
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51: 
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54: 
55:                 THIS.pgf_4c_Paginas.Visible   = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual           = "LISTA"
58: 

*-- Linhas 82 a 101:
82: 
83:         WITH THIS.pgf_4c_Paginas
84:             .PageCount = 2
85:             .Top       = -29
86:             .Left      = 0
87:             .Width     = THIS.Width
88:             .Height    = THIS.Height + 29
89:             .Tabs      = .F.
90:             .Visible   = .T.
91: 
92:             .Page1.Caption   = "Lista"
93:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(255, 255, 255)
95: 
96:             .Page2.Caption   = "Dados"
97:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page2.BackColor = RGB(255, 255, 255)
99:         ENDWITH
100: 
101:         THIS.ConfigurarPaginaLista()

*-- Linhas 115 a 155:
115:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116: 
117:         *-- Container Cabecalho cinza (cntSombra no legado)
118:         *-- Original: Top=1. Com compensacao PageFrame.Top=-29: Top = 1+29 = 30 => usar 31 (padrao)
119:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH loc_oPagina.cnt_4c_Cabecalho
121:             .Top         = 31
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
135:             .Width     = 769
136:             .Height    = 40
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
151:             .Width     = 769
152:             .Height    = 46
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.

*-- Linhas 162 a 288:
162:         *-- Container Botoes CRUD - Canonico Left=542, Top=29
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
174:         *-- Botao Incluir
175:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
176:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
177:             .Caption         = "Incluir"
178:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
179:             .PicturePosition = 13
180:             .Top             = 5
181:             .Left            = 5
182:             .Width           = 75
183:             .Height          = 75
184:             .BackColor       = RGB(255, 255, 255)
185:             .ForeColor       = RGB(90, 90, 90)
186:             .FontName        = "Comic Sans MS"
187:             .FontBold        = .T.
188:             .FontItalic      = .T.
189:             .FontSize        = 8
190:             .Themes          = .F.
191:             .SpecialEffect   = 0
192:             .MousePointer    = 15
193:             .WordWrap        = .T.
194:             .AutoSize        = .F.
195:             .Visible         = .T.
196:         ENDWITH
197: 
198:         *-- Botao Visualizar
199:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
201:             .Caption         = "Visualizar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 80
206:             .Width           = 75
207:             .Height          = 75
208:             .BackColor       = RGB(255, 255, 255)
209:             .ForeColor       = RGB(90, 90, 90)
210:             .FontName        = "Comic Sans MS"
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .FontSize        = 8
214:             .Themes          = .F.
215:             .SpecialEffect   = 0
216:             .MousePointer    = 15
217:             .WordWrap        = .T.
218:             .AutoSize        = .F.
219:             .Visible         = .T.
220:         ENDWITH
221: 
222:         *-- Botao Alterar
223:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
224:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
225:             .Caption         = "Alterar"
226:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
227:             .PicturePosition = 13
228:             .Top             = 5
229:             .Left            = 155
230:             .Width           = 75
231:             .Height          = 75
232:             .BackColor       = RGB(255, 255, 255)
233:             .ForeColor       = RGB(90, 90, 90)
234:             .FontName        = "Comic Sans MS"
235:             .FontBold        = .T.
236:             .FontItalic      = .T.
237:             .FontSize        = 8
238:             .Themes          = .F.
239:             .SpecialEffect   = 0
240:             .MousePointer    = 15
241:             .WordWrap        = .T.
242:             .AutoSize        = .F.
243:             .Visible         = .T.
244:         ENDWITH
245: 
246:         *-- Botao Excluir
247:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
248:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
249:             .Caption         = "Excluir"
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
251:             .PicturePosition = 13
252:             .Top             = 5
253:             .Left            = 230
254:             .Width           = 75
255:             .Height          = 75
256:             .BackColor       = RGB(255, 255, 255)
257:             .ForeColor       = RGB(90, 90, 90)
258:             .FontName        = "Comic Sans MS"
259:             .FontBold        = .T.
260:             .FontItalic      = .T.
261:             .FontSize        = 8
262:             .Themes          = .F.
263:             .SpecialEffect   = 0
264:             .MousePointer    = 15
265:             .WordWrap        = .T.
266:             .AutoSize        = .F.
267:             .Visible         = .T.
268:         ENDWITH
269: 
270:         *-- Botao Buscar
271:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
272:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
273:             .Caption         = "Buscar"
274:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
275:             .PicturePosition = 13
276:             .Top             = 5
277:             .Left            = 305
278:             .Width           = 75
279:             .Height          = 75
280:             .BackColor       = RGB(255, 255, 255)
281:             .ForeColor       = RGB(90, 90, 90)
282:             .FontName        = "Comic Sans MS"
283:             .FontBold        = .T.
284:             .FontItalic      = .T.
285:             .FontSize        = 8
286:             .Themes          = .F.
287:             .SpecialEffect   = 0
288:             .MousePointer    = 15

*-- Linhas 294 a 324:
294:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
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
306:         *-- Botao Encerrar (padrao canonico)
307:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
308:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
309:             .Caption         = "Encerrar"
310:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
311:             .PicturePosition = 13
312:             .Top             = 5
313:             .Left            = 5
314:             .Width           = 75
315:             .Height          = 75
316:             .BackColor       = RGB(255, 255, 255)
317:             .ForeColor       = RGB(90, 90, 90)
318:             .FontName        = "Comic Sans MS"
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .FontSize        = 8
322:             .Themes          = .F.
323:             .SpecialEffect   = 0
324:             .MousePointer    = 15

*-- Linhas 330 a 339:
330:         *-- Grid de listagem (Grade no legado: colunas Cods=80px, Descs=150px)
331:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
332:         WITH loc_oPagina.grd_4c_Lista
333:             .Top                = 117
334:             .Left               = 12
335:             .Width              = 890
336:             .Height             = 488
337:             .ColumnCount        = 2
338:             .FontName           = "Verdana"
339:             .FontSize           = 8

*-- Linhas 353 a 366:
353:         ENDWITH
354: 
355:         *-- BINDEVENTs dos botoes da Page1
356:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
357:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
358:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
359:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
360:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
361:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
362: 
363:         THIS.TornarControlesVisiveis(loc_oPagina)
364:     ENDPROC
365: 
366:     *===========================================================================

*-- Linhas 379 a 451:
379:         *-- Container BotoesAcao - Grupo_Salva no legado (Left=817, Top=11+29=40)
380:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
381:         WITH loc_oPagina.cnt_4c_BotoesAcao
382:             .Top         = 40
383:             .Left        = 817
384:             .Width       = 160
385:             .Height      = 85
386:             .BackStyle = 1
387:             .BackColor = RGB(255, 255, 255)
388:             .BorderWidth = 0
389:             .Visible     = .T.
390:         ENDWITH
391: 
392:         *-- Botao Confirmar (Salva no legado: Left=5, Top=5)
393:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
394:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
395:             .Caption         = "Confirmar"
396:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
397:             .PicturePosition = 13
398:             .Top             = 5
399:             .Left            = 5
400:             .Width           = 75
401:             .Height          = 75
402:             .BackColor       = RGB(255, 255, 255)
403:             .ForeColor       = RGB(90, 90, 90)
404:             .FontName        = "Comic Sans MS"
405:             .FontBold        = .T.
406:             .FontItalic      = .T.
407:             .FontSize        = 8
408:             .Themes          = .F.
409:             .SpecialEffect   = 0
410:             .MousePointer    = 15
411:             .WordWrap        = .T.
412:             .AutoSize        = .F.
413:             .Visible         = .T.
414:         ENDWITH
415: 
416:         *-- Botao Cancelar (Cancelar no legado: Left=80, Top=5)
417:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
418:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
419:             .Caption         = "Encerrar"
420:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
421:             .PicturePosition = 13
422:             .Top             = 5
423:             .Left            = 80
424:             .Width           = 75
425:             .Height          = 75
426:             .BackColor       = RGB(255, 255, 255)
427:             .ForeColor       = RGB(90, 90, 90)
428:             .FontName        = "Comic Sans MS"
429:             .FontBold        = .T.
430:             .FontItalic      = .T.
431:             .FontSize        = 8
432:             .Themes          = .F.
433:             .SpecialEffect   = 0
434:             .MousePointer    = 15
435:             .WordWrap        = .T.
436:             .AutoSize        = .F.
437:             .Visible         = .T.
438:         ENDWITH
439: 
440:         *-- Label Codigo (Say1 no legado: Top=141, Left=335, ForeColor=90,90,90)
441:         *-- Com compensacao +29: Top=170
442:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
443:         WITH loc_oPagina.lbl_4c_Codigo
444:             .Caption   = "C" + CHR(243) + "digo :"
445:             .Top       = 170
446:             .Left      = 335
447:             .Width     = 55
448:             .Height    = 17
449:             .FontName  = "Tahoma"
450:             .FontSize  = 8
451:             .FontBold  = .F.

*-- Linhas 462 a 471:
462:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
463:         WITH loc_oPagina.txt_4c_Codigo
464:             .Value         = ""
465:             .Top           = 166
466:             .Left          = 382
467:             .Width         = 60
468:             .Height        = 24
469:             .FontName      = "Tahoma"
470:             .FontSize      = 8
471:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 477 a 489:
477: 
478:         *-- Label Descricao (Say2 no legado: Top=167, Left=322, ForeColor=90,90,90)
479:         *-- Com compensacao +29: Top=196
480:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
481:         WITH loc_oPagina.lbl_4c_Descricao
482:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
483:             .Top       = 196
484:             .Left      = 322
485:             .Width     = 60
486:             .Height    = 17
487:             .FontName  = "Tahoma"
488:             .FontSize  = 8
489:             .FontBold  = .F.

*-- Linhas 499 a 521:
499:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
500:         WITH loc_oPagina.txt_4c_Descricao
501:             .Value         = ""
502:             .Top           = 192
503:             .Left          = 382
504:             .Width         = 300
505:             .Height        = 24
506:             .FontName      = "Tahoma"
507:             .FontSize      = 8
508:             .ForeColor     = RGB(90, 90, 90)
509:             .SpecialEffect = 1
510:             .MaxLength     = 50
511:             .Visible       = .T.
512:         ENDWITH
513: 
514:         *-- BINDEVENTs dos botoes da Page2
515:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
516:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
517: 
518:         THIS.TornarControlesVisiveis(loc_oPagina)
519:     ENDPROC
520: 
521:     *===========================================================================

*-- Linhas 544 a 553:
544:                 loc_oGrid.Column1.Width = 80
545:                 loc_oGrid.Column2.Width = 380
546: 
547:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
548:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
549: 
550:                 THIS.FormatarGridLista(loc_oGrid)
551: 
552:                 loc_lSucesso = .T.
553:             ENDIF

*-- Linhas 948 a 957:
948: 
949:         *-- Habilitar/desabilitar Confirmar conforme modo
950:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
951:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
952:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEmEdicao
953:             ENDIF
954:         ENDIF
955: 
956:         *-- SetFocus conforme modo (replica logica legado: Click do Grupo_Op)
957:         DO CASE

*-- Linhas 971 a 980:
971: 
972:             OTHERWISE
973:                 IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
974:                     IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
975:                         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
976:                     ENDIF
977:                 ENDIF
978:         ENDCASE
979:     ENDPROC
980: 


### BO (C:\4c\projeto\app\classes\CtgBO.prg):
*====================================================================
* CtgBO.prg
*
* Business Object para Categorias
* Tabela principal: SigCdCtg (cods PK, descs descricao)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CtgBO AS BusinessBase

	*-- Propriedades da entidade (SigCdCtg)
	this_cCods      = ""   && cods char(6)       - codigo da categoria (PK)
	this_cDescs     = ""   && descs char(40)     - descricao da categoria

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdCtg"
		THIS.this_cCampoChave = "cods"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCods)
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
				THIS.this_cCods      = TratarNulo(cods,      "C")
				THIS.this_cDescs     = TratarNulo(descs,     "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CtgBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(ALLTRIM(THIS.this_cCods))
			MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarCodigoExistente(THIS.this_cCods)
				MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
				loc_lValido = .F.
			ENDIF
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescs))
			MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
			loc_lValido = .F.
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarCodigoExistente - Verifica se cods ja existe na tabela
	*====================================================================
	PROCEDURE VerificarCodigoExistente(par_cCods)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCtg" + ;
				" WHERE cods = " + EscaparSQL(par_cCods)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
				SELECT cursor_4c_ChkCod
				loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
				USE IN cursor_4c_ChkCod
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CtgBO.VerificarCodigoExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdCtg
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdCtg (cods, descs)
				VALUES (
					<<EscaparSQL(THIS.this_cCods)>>,
					<<EscaparSQL(THIS.this_cDescs)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CtgBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdCtg
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdCtg
				SET descs = <<EscaparSQL(THIS.this_cDescs)>>
				WHERE cods = <<EscaparSQL(THIS.this_cCods)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CtgBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdCtg
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdCtg WHERE cods = " + EscaparSQL(THIS.this_cCods)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CtgBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com cods, descs
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (cods C(6), descs C(40))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT cods, descs FROM SigCdCtg"

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
						GO TOP IN cursor_4c_Dados
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ELSE
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
					IF loc_nResultado >= 0
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CtgBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo codigo de negocio (cods)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCods)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cods, descs FROM SigCdCtg" + ;
				" WHERE cods = " + EscaparSQL(par_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Categoria n" + CHR(227) + "o encontrada!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CtgBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

