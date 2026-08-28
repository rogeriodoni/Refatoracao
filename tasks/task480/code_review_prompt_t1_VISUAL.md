# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 158: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 182: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 206: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 230: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 254: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 289: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 385: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 408: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOCS.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (842 linhas total):

*-- Linhas 36 a 44:
36:         loc_lSucesso = .F.
37: 
38:         TRY
39:             THIS.Caption = "Cadastro de Ocasi" + CHR(227) + "o"
40: 
41:             THIS.this_oBusinessObject = CREATEOBJECT("OCSBO")
42: 
43:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
44:                 THIS.ConfigurarPageFrame()

*-- Linhas 63 a 78:
63:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
64:         WITH THIS.pgf_4c_Paginas
65:             .PageCount = 2
66:             .Top       = -29
67:             .Left      = 0
68:             .Width     = THIS.Width
69:             .Height    = THIS.Height + 29
70:             .Tabs      = .F.
71:             .Visible   = .T.
72:             .Page1.Caption = "Lista"
73:             .Page2.Caption = "Dados"
74:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
75:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
76:         ENDWITH
77: 
78:         THIS.ConfigurarPaginaLista()

*-- Linhas 93 a 164:
93:         *-- Container cabecalho com titulo do formulario
94:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
95:         WITH loc_oPagina.cnt_4c_Cabecalho
96:             .Top           = 31
97:             .Left          = 0
98:             .Width         = THIS.Width
99:             .Height        = 80
100:             .BackColor     = RGB(100, 100, 100)
101:             .BorderWidth   = 0
102:             .SpecialEffect = 0
103:             .Visible       = .T.
104:         ENDWITH
105: 
106:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
107:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
108:             .Top       = 15
109:             .Left      = 12
110:             .Width     = THIS.Width - 31
111:             .Height    = 40
112:             .Caption   = "Cadastro de Ocasi" + CHR(227) + "o"
113:             .FontName  = "Tahoma"
114:             .FontSize  = 16
115:             .FontBold  = .T.
116:             .ForeColor = RGB(0, 0, 0)
117:             .BackStyle = 0
118:             .Visible   = .T.
119:         ENDWITH
120: 
121:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
122:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
123:             .Top       = 18
124:             .Left      = 10
125:             .Width     = THIS.Width - 31
126:             .Height    = 46
127:             .Caption   = "Cadastro de Ocasi" + CHR(227) + "o"
128:             .FontName  = "Tahoma"
129:             .FontSize  = 16
130:             .FontBold  = .T.
131:             .ForeColor = RGB(255, 255, 255)
132:             .BackStyle = 0
133:             .Visible   = .T.
134:         ENDWITH
135: 
136:         *-- Container botoes CRUD (lado direito, sobre o cabecalho)
137:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
138:         WITH loc_oPagina.cnt_4c_Botoes
139:             .Top         = 29
140:             .Left        = 542
141:             .Width       = 390
142:             .Height      = 85
143:             .BackStyle = 0
144:             .BorderWidth = 0
145:             .Visible     = .T.
146:         ENDWITH
147: 
148:         *-- Botao Incluir
149:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
150:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
151:             .Caption         = "Incluir"
152:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
153:             .PicturePosition = 13
154:             .Top             = 5
155:             .Left            = 5
156:             .Width           = 75
157:             .Height          = 75
158:             .FontName        = "Comic Sans MS"
159:             .FontBold        = .T.
160:             .FontItalic      = .T.
161:             .FontSize        = 8
162:             .ForeColor       = RGB(90, 90, 90)
163:             .BackColor       = RGB(255, 255, 255)
164:             .Themes          = .F.

*-- Linhas 170 a 188:
170:         ENDWITH
171: 
172:         *-- Botao Visualizar
173:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
174:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
175:             .Caption         = "Visualizar"
176:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
177:             .PicturePosition = 13
178:             .Top             = 5
179:             .Left            = 80
180:             .Width           = 75
181:             .Height          = 75
182:             .FontName        = "Comic Sans MS"
183:             .FontBold        = .T.
184:             .FontItalic      = .T.
185:             .FontSize        = 8
186:             .ForeColor       = RGB(90, 90, 90)
187:             .BackColor       = RGB(255, 255, 255)
188:             .Themes          = .F.

*-- Linhas 194 a 212:
194:         ENDWITH
195: 
196:         *-- Botao Alterar
197:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
198:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
199:             .Caption         = "Alterar"
200:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
201:             .PicturePosition = 13
202:             .Top             = 5
203:             .Left            = 155
204:             .Width           = 75
205:             .Height          = 75
206:             .FontName        = "Comic Sans MS"
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .FontSize        = 8
210:             .ForeColor       = RGB(90, 90, 90)
211:             .BackColor       = RGB(255, 255, 255)
212:             .Themes          = .F.

*-- Linhas 218 a 236:
218:         ENDWITH
219: 
220:         *-- Botao Excluir
221:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
222:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
223:             .Caption         = "Excluir"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
225:             .PicturePosition = 13
226:             .Top             = 5
227:             .Left            = 230
228:             .Width           = 75
229:             .Height          = 75
230:             .FontName        = "Comic Sans MS"
231:             .FontBold        = .T.
232:             .FontItalic      = .T.
233:             .FontSize        = 8
234:             .ForeColor       = RGB(90, 90, 90)
235:             .BackColor       = RGB(255, 255, 255)
236:             .Themes          = .F.

*-- Linhas 242 a 260:
242:         ENDWITH
243: 
244:         *-- Botao Buscar
245:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
246:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
247:             .Caption         = "Buscar"
248:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
249:             .PicturePosition = 13
250:             .Top             = 5
251:             .Left            = 305
252:             .Width           = 75
253:             .Height          = 75
254:             .FontName        = "Comic Sans MS"
255:             .FontBold        = .T.
256:             .FontItalic      = .T.
257:             .FontSize        = 8
258:             .ForeColor       = RGB(90, 90, 90)
259:             .BackColor       = RGB(255, 255, 255)
260:             .Themes          = .F.

*-- Linhas 268 a 295:
268:         *-- Container Encerrar (canto direito, transparente, flutuante)
269:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
270:         WITH loc_oPagina.cnt_4c_Saida
271:             .Top         = 29
272:             .Left        = 917
273:             .Width       = 90
274:             .Height      = 85
275:             .BackStyle   = 0
276:             .BorderWidth = 0
277:             .Visible     = .T.
278:         ENDWITH
279: 
280:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
281:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
282:             .Caption         = "Encerrar"
283:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
284:             .PicturePosition = 13
285:             .Top             = 5
286:             .Left            = 5
287:             .Width           = 75
288:             .Height          = 75
289:             .FontName        = "Comic Sans MS"
290:             .FontBold        = .T.
291:             .FontItalic      = .T.
292:             .FontSize        = 8
293:             .ForeColor       = RGB(90, 90, 90)
294:             .BackColor       = RGB(255, 255, 255)
295:             .Themes          = .F.

*-- Linhas 307 a 316:
307:         loc_oGrid.ColumnCount  = 2
308: 
309:         WITH loc_oGrid
310:             .Top                = 117
311:             .Left               = 26
312:             .Width              = 890
313:             .Height             = 450
314:             .FontName           = "Verdana"
315:             .FontSize           = 8
316:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 330 a 353:
330:         WITH loc_oGrid.Column1
331:             .Width           = 90
332:             .Alignment       = 0
333:             .Header1.Caption = "C" + CHR(243) + "digo"
334:         ENDWITH
335: 
336:         WITH loc_oGrid.Column2
337:             .Width           = 337
338:             .Alignment       = 0
339:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
340:         ENDWITH
341: 
342:         *-- BINDEVENTs para botoes CRUD
343:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
344:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
345:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
346:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
347:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
348:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
349: 
350:         THIS.TornarControlesVisiveis(loc_oPagina)
351:         THIS.CarregarLista()
352:     ENDPROC
353: 

*-- Linhas 364 a 435:
364:         *-- Container botoes Confirmar/Cancelar (original: Grupo_Salva top=4, left=842)
365:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
366:         WITH loc_oPagina.cnt_4c_Salva
367:             .Top         = 33
368:             .Left        = 842
369:             .Width       = 160
370:             .Height      = 85
371:             .BackStyle   = 0
372:             .BorderWidth = 0
373:             .Visible     = .T.
374:         ENDWITH
375: 
376:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
377:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
378:             .Caption         = "Confirmar"
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
380:             .PicturePosition = 13
381:             .Top             = 5
382:             .Left            = 5
383:             .Width           = 75
384:             .Height          = 75
385:             .FontName        = "Comic Sans MS"
386:             .FontBold        = .T.
387:             .FontItalic      = .T.
388:             .FontSize        = 8
389:             .ForeColor       = RGB(90, 90, 90)
390:             .BackColor       = RGB(255, 255, 255)
391:             .Themes          = .F.
392:             .SpecialEffect   = 0
393:             .MousePointer    = 15
394:             .WordWrap        = .T.
395:             .AutoSize        = .F.
396:             .Visible         = .T.
397:         ENDWITH
398: 
399:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
400:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
401:             .Caption         = "Encerrar"
402:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
403:             .PicturePosition = 13
404:             .Top             = 5
405:             .Left            = 80
406:             .Width           = 75
407:             .Height          = 75
408:             .FontName        = "Comic Sans MS"
409:             .FontBold        = .T.
410:             .FontItalic      = .T.
411:             .FontSize        = 8
412:             .ForeColor       = RGB(90, 90, 90)
413:             .BackColor       = RGB(255, 255, 255)
414:             .Themes          = .F.
415:             .SpecialEffect   = 0
416:             .MousePointer    = 15
417:             .WordWrap        = .T.
418:             .AutoSize        = .F.
419:             .Visible         = .T.
420:         ENDWITH
421: 
422:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
423:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
424: 
425:         *-- Label Codigo (Say1: original top=124, left=215; compensado +29)
426:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
427:         WITH loc_oPagina.lbl_4c_Codigo
428:             .Caption   = "C" + CHR(243) + "digo :"
429:             .Top       = 153
430:             .Left      = 215
431:             .Width     = 48
432:             .Height    = 17
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .FontBold  = .F.

*-- Linhas 442 a 468:
442:         *-- TextBox Codigo (Get_codigo: original top=121, left=263, w=72, h=23; compensado +29)
443:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
444:         WITH loc_oPagina.txt_4c_Codigo
445:             .Top           = 150
446:             .Left          = 263
447:             .Width         = 72
448:             .Height        = 23
449:             .Value         = ""
450:             .FontName      = "Tahoma"
451:             .FontSize      = 8
452:             .MaxLength     = 10
453:             .SpecialEffect = 0
454:             .ReadOnly      = .F.
455:             .Visible       = .T.
456:         ENDWITH
457: 
458:         *-- Label Descricao (Say2: original top=149, left=202; compensado +29)
459:         loc_oPagina.AddObject("lbl_4c_Desc", "Label")
460:         WITH loc_oPagina.lbl_4c_Desc
461:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
462:             .Top       = 178
463:             .Left      = 202
464:             .Width     = 61
465:             .Height    = 17
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .FontBold  = .F.

*-- Linhas 475 a 484:
475:         *-- TextBox Descricao (Get_desc: original top=146, left=263, w=240, h=23; compensado +29)
476:         loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
477:         WITH loc_oPagina.txt_4c_Desc
478:             .Top           = 175
479:             .Left          = 263
480:             .Width         = 240
481:             .Height        = 23
482:             .Value         = ""
483:             .FontName      = "Tahoma"
484:             .FontSize      = 8

*-- Linhas 566 a 575:
566:                 loc_oGrid.RecordSource            = "cursor_4c_Dados"
567:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.cods"
568:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descs"
569:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
570:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
571:                 loc_oGrid.Column1.Width           = 90
572:                 loc_oGrid.Column2.Width           = 337
573:                 THIS.FormatarGridLista(loc_oGrid)
574:                 loc_lResultado = .T.
575:             ENDIF

*-- Linhas 764 a 779:
764: 
765:         DO CASE
766:         CASE THIS.this_cModoAtual = "VISUALIZAR"
767:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
768:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
769:         CASE THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
770:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .T.
771:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
772:         OTHERWISE
773:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
774:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
775:         ENDCASE
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * BOParaForm - Carrega dados do BO nos campos da Page2


### BO (C:\4c\projeto\app\classes\OCSBO.prg):
*====================================================================
* OCSBO.prg
*
* Business Object para Ocasiao
* Tabela principal: SigCdOcs (cidchaves PK, cods chave de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS OCSBO AS BusinessBase

	*-- Propriedades da entidade (SigCdOcs)
	*-- SigCdOcs nao encontrada no schema.sql snapshot; tipos inferidos do
	*-- fonte legado SIGCDOCS.SCX e padrao fUniqueIds/ChkRegister.
	this_cCidchaves = ""   && cidchaves char(20)  - PK tecnica gerada por fUniqueIds
	this_cCods      = ""   && cods char(10)       - codigo de ocasiao (chave de negocio)
	this_cDescs     = ""   && descs char(40)      - descricao da ocasiao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdOcs"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Lista registros com filtro opcional sobre cods/descs
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cWhere = ""
			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
				loc_cWhere = " WHERE cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
			ENDIF

			loc_cSQL = "SELECT cods, descs FROM SigCdOcs" + ;
			           loc_cWhere + ;
			           " ORDER BY cods"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado > 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo codigo de negocio (cods)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descs FROM SigCdOcs" + ;
			           " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Registro n" + CHR(227) + "o encontrado!", "Aviso")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cCods      = TratarNulo(cods, "C")
			THIS.this_cDescs     = TratarNulo(descs, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT INTO SigCdOcs
	* Gera cidchaves via fUniqueIds() (funcao do framework legado)
	* Valida: cods nao pode ser vazio nem duplicado
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCods))
				MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
			ELSE
				*-- Verificar duplicidade de codigo
				loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdOcs WHERE cods = " + ;
				           EscaparSQL(ALLTRIM(THIS.this_cCods))
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCods")
				IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkCods") > 0
					SELECT cursor_4c_ChkCods
					IF cursor_4c_ChkCods.qtd > 0
						MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
						IF USED("cursor_4c_ChkCods")
							USE IN cursor_4c_ChkCods
						ENDIF
					ELSE
						IF USED("cursor_4c_ChkCods")
							USE IN cursor_4c_ChkCods
						ENDIF
						THIS.this_cCidchaves = fUniqueIds()

						loc_cSQL = "INSERT INTO SigCdOcs (cidchaves, cods, descs)" + ;
						           " VALUES (" + ;
						           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
						           EscaparSQL(THIS.this_cCods) + ", " + ;
						           EscaparSQL(THIS.this_cDescs) + ;
						           ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado >= 0
							THIS.RegistrarAuditoria("INSERT")
							loc_lSucesso = .T.
						ELSE
							MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
						ENDIF
					ENDIF
				ELSE
					MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					IF USED("cursor_4c_ChkCods")
						USE IN cursor_4c_ChkCods
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Inserir:" + CHR(13) + loException.Message, "Erro")
			IF USED("cursor_4c_ChkCods")
				USE IN cursor_4c_ChkCods
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE SigCdOcs (apenas descs; cods e cidchaves sao imutaveis)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdOcs SET" + ;
			           " descs = " + EscaparSQL(THIS.this_cDescs) + ;
			           " WHERE cods = " + EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE FROM SigCdOcs
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdOcs WHERE cods = " + ;
			           EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

