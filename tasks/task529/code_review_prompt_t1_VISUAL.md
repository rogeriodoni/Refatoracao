# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 320: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 343: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 446: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 470: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormTbd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1259 linhas total):

*-- Linhas 111 a 119:
111:             THIS.CarregarLista()
112: 
113:             *-- 3. Monta o Caption a partir da operacao e propaga para as Pages
114:             *--    (espelha o Init legado: .Caption = [Grupos de Produtos ] +
115:             *--    AllTrim(crSigCdOpe.Dopes) copiado para lblSombra/lblTitulo)
116:             THIS.BOParaForm()
117: 
118:             *-- 4. Ativa Page1 (Lista) como padrao
119:             THIS.pgf_4c_Paginas.Visible    = .T.

*-- Linhas 141 a 158:
141:         TRY
142:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
143:             WITH THIS.pgf_4c_Paginas
144:                 .Top         = -29
145:                 .Left        = 0
146:                 .Width       = THIS.Width
147:                 .Height      = THIS.Height + 29
148:                 .PageCount   = 2
149:                 .Tabs        = .F.
150:                 .BorderWidth = 0
151: 
152:                 .Page1.Caption = "Lista"
153:                 .Page2.Caption = "Dados"
154: 
155:                 *-- Fundo das Pages (espelha SIGCDTBD.Picture do legado:
156:                 *-- ..\framework\imagens\new_background.jpg)
157:                 .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
158:                 .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

*-- Linhas 178 a 245:
178:             *-- Page1: cabecalho escuro (topo)
179:             loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
180:             WITH loc_oPag1.cnt_4c_Cabecalho
181:                 .Top         = 0 + 29
182:                 .Left        = 0
183:                 .Width       = THIS.Width
184:                 .Height      = 80
185:                 .BorderWidth = 0
186:                 .BackStyle   = 1
187:                 .BackColor   = RGB(100, 100, 100)
188:                 .Visible     = .T.
189:             ENDWITH
190: 
191:             *-- Labels no cabecalho escuro (sombra + titulo) - fase 4 refina Caption
192:             loc_oPag1.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
193:             WITH loc_oPag1.cnt_4c_Cabecalho.lbl_4c_Sombra
194:                 .AutoSize  = .F.
195:                 .FontBold  = .T.
196:                 .FontName  = "Tahoma"
197:                 .FontSize  = 18
198:                 .BackStyle = 0
199:                 .Caption   = THIS.Caption
200:                 .Height    = 40
201:                 .Left      = 10
202:                 .Top       = 18
203:                 .Width     = THIS.Width - 31
204:                 .ForeColor = RGB(0, 0, 0)
205:             ENDWITH
206: 
207:             loc_oPag1.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
208:             WITH loc_oPag1.cnt_4c_Cabecalho.lbl_4c_Titulo
209:                 .AutoSize  = .F.
210:                 .FontBold  = .T.
211:                 .FontName  = "Tahoma"
212:                 .FontSize  = 18
213:                 .BackStyle = 0
214:                 .Caption   = THIS.Caption
215:                 .Height    = 46
216:                 .Left      = 10
217:                 .Top       = 17
218:                 .Width     = THIS.Width - 31
219:                 .ForeColor = RGB(255, 255, 255)
220:             ENDWITH
221: 
222:             *-- Page1: container de botoes de manutencao do grid (Inserir/Excluir)
223:             *-- Legado: cmdInserir Left=500, cmdExcluir Left=575 (form Width=800)
224:             loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
225:             WITH loc_oPag1.cnt_4c_Botoes
226:                 .Top         = 0 + 29
227:                 .Left        = 495
228:                 .Width       = 155
229:                 .Height      = 85
230:                 .BorderWidth = 0
231:                 .BackStyle   = 0
232:                 .Visible     = .T.
233:             ENDWITH
234: 
235:             *-- Page2: container de botoes de acao (populado em ConfigurarPaginaDados)
236:             *-- Legado: cmdSair(Confirmar) Left=650, Cancela Left=725 (form Width=800)
237:             loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
238:             WITH loc_oPag2.cnt_4c_BotoesAcao
239:                 .Top         = 4 + 29
240:                 .Left        = 645
241:                 .Width       = 155
242:                 .Height      = 85
243:                 .BorderWidth = 0
244:                 .BackStyle   = 0
245:                 .Visible     = .T.

*-- Linhas 265 a 274:
265:             *-- Grid principal (espelha SIGCDTBD.GradeOpe: Top=98,Left=236,W=313,H=274)
266:             loc_oPag.AddObject("grd_4c_Dados", "Grid")
267:             WITH loc_oPag.grd_4c_Dados
268:                 .Top           = 98 + 29
269:                 .Left          = 236
270:                 .Width         = 313
271:                 .Height        = 274
272:                 .ColumnCount   = 2
273:                 .ScrollBars    = 2
274:                 .DeleteMark    = .F.

*-- Linhas 280 a 288:
280:                 .Column1.Width      = 80
281:                 .Column1.Movable    = .F.
282:                 .Column1.Resizable  = .F.
283:                 .Column1.Header1.Caption   = "Tabela"
284:                 .Column1.Header1.FontName  = "Verdana"
285:                 .Column1.Header1.FontSize  = 8
286:                 .Column1.Header1.Alignment = 2
287:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
288:                 .Column1.Text1.FontName    = "Courier New"

*-- Linhas 294 a 302:
294:                 .Column2.Width      = 200
295:                 .Column2.Movable    = .F.
296:                 .Column2.Resizable  = .F.
297:                 .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
298:                 .Column2.Header1.FontName  = "Verdana"
299:                 .Column2.Header1.FontSize  = 8
300:                 .Column2.Header1.Alignment = 2
301:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
302:                 .Column2.Text1.FontName    = "Courier New"

*-- Linhas 309 a 326:
309: 
310:             *-- Botoes de manutencao do grid (espelham cmdInserir/cmdExcluir)
311:             *-- AddObject SEMPRE fora de WITH aninhado (evita props ignoradas)
312:             loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Inserir", "CommandButton")
313:             WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Inserir
314:                 .Top             = 5
315:                 .Left            = 5
316:                 .Width           = 70
317:                 .Height          = 75
318:                 .Caption         = "Inserir"
319:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
320:                 .FontName        = "Comic Sans MS"
321:                 .FontBold        = .T.
322:                 .FontItalic      = .T.
323:                 .FontSize        = 8
324:                 .ForeColor       = RGB(90, 90, 90)
325:                 .BackColor       = RGB(255, 255, 255)
326:                 .Themes          = .F.

*-- Linhas 332 a 349:
332:                 .Visible         = .T.
333:             ENDWITH
334: 
335:             loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
336:             WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir
337:                 .Top             = 5
338:                 .Left            = 80
339:                 .Width           = 70
340:                 .Height          = 75
341:                 .Caption         = "Excluir"
342:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
343:                 .FontName        = "Comic Sans MS"
344:                 .FontBold        = .T.
345:                 .FontItalic      = .T.
346:                 .FontSize        = 8
347:                 .ForeColor       = RGB(90, 90, 90)
348:                 .BackColor       = RGB(255, 255, 255)
349:                 .Themes          = .F.

*-- Linhas 355 a 364:
355:                 .Visible         = .T.
356:             ENDWITH
357: 
358:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Inserir, "Click", THIS, "BtnIncluirClick")
359:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
360: 
361:             *-- Lookup do codigo da tabela de desconto (espelha Column1.Text1.Valid
362:             *-- do legado: CreateObject('fwbuscaext', ..., 'SigOpTdz', ...)).
363:             *-- F4 abre a busca direto; ENTER/TAB validam o valor digitado.
364:             BINDEVENT(loc_oPag.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "ColCodigosKeyPress")

*-- Linhas 392 a 452:
392: 
393:             loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
394:             WITH loc_oPag.cnt_4c_Cabecalho
395:                 .Top         = 0 + 29
396:                 .Left        = 0
397:                 .Width       = THIS.Width
398:                 .Height      = 80
399:                 .BorderWidth = 0
400:                 .BackStyle   = 1
401:                 .BackColor   = RGB(100, 100, 100)
402:                 .Visible     = .T.
403:             ENDWITH
404: 
405:             loc_oPag.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
406:             WITH loc_oPag.cnt_4c_Cabecalho.lbl_4c_Sombra
407:                 .AutoSize  = .F.
408:                 .FontBold  = .T.
409:                 .FontName  = "Tahoma"
410:                 .FontSize  = 18
411:                 .BackStyle = 0
412:                 .Caption   = THIS.Caption
413:                 .Height    = 40
414:                 .Left      = 10
415:                 .Top       = 18
416:                 .Width     = THIS.Width - 31
417:                 .ForeColor = RGB(0, 0, 0)
418:             ENDWITH
419: 
420:             loc_oPag.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
421:             WITH loc_oPag.cnt_4c_Cabecalho.lbl_4c_Titulo
422:                 .AutoSize  = .F.
423:                 .FontBold  = .T.
424:                 .FontName  = "Tahoma"
425:                 .FontSize  = 18
426:                 .BackStyle = 0
427:                 .Caption   = THIS.Caption
428:                 .Height    = 46
429:                 .Left      = 10
430:                 .Top       = 17
431:                 .Width     = THIS.Width - 31
432:                 .ForeColor = RGB(255, 255, 255)
433:             ENDWITH
434: 
435:             *-- Botoes de acao (espelham cmdSair/Confirmar Left=650 e
436:             *-- Cancela/Cancelar Left=725 do legado - relativos ao container
437:             *-- cnt_4c_BotoesAcao com Left=645: 650-645=5, 725-645=80)
438:             loc_oPag.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
439:             WITH loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar
440:                 .Top             = 5
441:                 .Left            = 5
442:                 .Width           = 75
443:                 .Height          = 75
444:                 .Caption         = "Confirmar"
445:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
446:                 .FontName        = "Comic Sans MS"
447:                 .FontBold        = .T.
448:                 .FontItalic      = .T.
449:                 .FontSize        = 8
450:                 .ForeColor       = RGB(90, 90, 90)
451:                 .BackColor       = RGB(255, 255, 255)
452:                 .Themes          = .F.

*-- Linhas 458 a 476:
458:                 .Visible         = .T.
459:             ENDWITH
460: 
461:             loc_oPag.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
462:             WITH loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar
463:                 .Top             = 5
464:                 .Left            = 80
465:                 .Width           = 75
466:                 .Height          = 75
467:                 .Cancel          = .T.
468:                 .Caption         = "Encerrar"
469:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
470:                 .FontName        = "Comic Sans MS"
471:                 .FontBold        = .T.
472:                 .FontItalic      = .T.
473:                 .FontSize        = 8
474:                 .ForeColor       = RGB(90, 90, 90)
475:                 .BackColor       = RGB(255, 255, 255)
476:                 .Themes          = .F.

*-- Linhas 482 a 491:
482:                 .Visible         = .T.
483:             ENDWITH
484: 
485:             BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
486:             BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
487:         CATCH TO loc_oErro
488:             MsgErro(loc_oErro.Message + CHR(13) + ;
489:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
490:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.ConfigurarPaginaDados")
491:         ENDTRY

*-- Linhas 715 a 725:
715: 
716:                 *-- Reconfigura Width/Header1.Caption (perdidos ao resetar RecordSource)
717:                 loc_oGrid.Column1.Width           = 80
718:                 loc_oGrid.Column1.Header1.Caption = "Tabela"
719:                 loc_oGrid.Column2.Width           = 200
720:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
721:                 loc_oGrid.Column2.Text1.ReadOnly  = .T.
722: 
723:                 loc_oGrid.Refresh
724: 
725:                 THIS.GravaDados = .F.

*-- Linhas 1050 a 1060:
1050:     *--------------------------------------------------------------------------
1051:     * BOParaForm - Transfere as propriedades do TbdBO de volta para o form.
1052:     * Reproduz o trecho do Init legado que monta o titulo a partir da operacao
1053:     *     .Caption = [Grupos de Produtos ] + AllTrim(crSigCdOpe.Dopes)
1054:     *     cntSombra.lblSombra.Caption = ThisForm.Caption
1055:     *     cntSombra.lblTitulo.Caption = ThisForm.Caption
1056:     * e, quando o BO carrega um registro (CarregarPorCodigo/CarregarDoCursor),
1057:     * devolve codigos/descrs para a linha corrente do grid. A descricao eh
1058:     * relida de SigOpTdz - a mesma origem do lookup - porem SEM abrir o
1059:     * FormBuscaAuxiliar quando o codigo nao existe (transferencia de dados
1060:     * nao deve disparar dialogo; quem faz isso eh ValidarCodigoTabela).

*-- Linhas 1079 a 1087:
1079: 
1080:                 *-- 2. Titulo (string exata do legado) propagado para as 2 Pages
1081:                 loc_cCaption = "Grupos de Produtos " + ALLTRIM(THIS.this_cDopes)
1082:                 THIS.Caption = loc_cCaption
1083:                 THIS.AtualizarTitulo(loc_cCaption)
1084: 
1085:                 *-- 3. Linha corrente do grid a partir do registro do BO
1086:                 loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
1087: 

*-- Linhas 1138 a 1150:
1138:                 loc_oPag = THIS.pgf_4c_Paginas.Pages(loc_nPag)
1139: 
1140:                 IF PEMSTATUS(loc_oPag, "cnt_4c_Cabecalho", 5)
1141:                     IF PEMSTATUS(loc_oPag.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
1142:                         loc_oPag.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = par_cCaption
1143:                     ENDIF
1144:                     IF PEMSTATUS(loc_oPag.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
1145:                         loc_oPag.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = par_cCaption
1146:                     ENDIF
1147:                 ENDIF
1148:             ENDFOR
1149:         CATCH TO loc_oErro
1150:             MsgErro(loc_oErro.Message + CHR(13) + ;


### BO (C:\4c\projeto\app\classes\TbdBO.prg):
*====================================================================
* TbdBO.prg
*
* Business Object para Tabelas de Desconto por Operacao
* Tabela principal: SigCdTbd (cidchaves PK)
* Tabela pai: SigCdOpe (dopes) - Operacao a qual as tabelas pertencem
* Tabela de referencia (lookup): SigOpTdz (codigos) - Tabela de Desconto
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TbdBO AS BusinessBase

	*-- Propriedades da entidade (SigCdTbd)
	this_cCodigos     = ""   && codigos char(10)   - codigo da tabela de desconto (FK SigOpTdz.codigos)
	this_cCidChaves   = ""   && cidchaves char(20) - PK (chave unica Fortyus)
	this_cDopes       = ""   && dopes char(20)     - codigo/descricao da operacao (FK SigCdOpe.dopes)

	*-- Propriedades locais (NAO persistem - apenas estado/UI)
	this_cDescOperacao = ""  && descricao da operacao exibida no cabecalho (= crSigCdOpe.Dopes)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdTbd"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCodigos   = TratarNulo(codigos, "C")
			THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
			THIS.this_cDopes     = TratarNulo(dopes, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, dopes" + ;
			           " FROM SigCdTbd" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(THIS.this_cCidChaves)
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			loc_cSQL = "INSERT INTO SigCdTbd (codigos, cidchaves, dopes)" + ;
			           " VALUES (" + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigos), 10)) + "," + ;
			           EscaparSQL(THIS.this_cCidChaves) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdTbd SET" + ;
			           " codigos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigos), 10)) + "," + ;
			           " dopes = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdTbd WHERE RTRIM(cidchaves) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarPorOperacao - Carrega TODAS as tabelas de desconto vinculadas
	* a uma operacao (Dopes), com a descricao da tabela (SigOpTdz.descrs).
	* Espelha o SELECT original do Init() legado:
	*   Select a.*, b.descrs From SigCdTbd a, SigOpTdz b
	*   Where a.Dopes = <dopes> And a.codigos = b.codigos
	* cursor_4c_Dados eh convertido para READWRITE (SQLEXEC gera cursor
	* somente-leitura) pois o grid permite Inserir/Excluir/editar linhas
	* localmente antes de Confirmar (SalvarPorOperacao).
	*====================================================================
	PROCEDURE BuscarPorOperacao(par_cDopes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cSQL = "SELECT a.codigos AS codigos, a.cidchaves AS cidchaves," + ;
			           " a.dopes AS dopes, b.descrs AS descrs" + ;
			           " FROM SigCdTbd a INNER JOIN SigOpTdz b ON a.codigos = b.codigos" + ;
			           " WHERE RTRIM(a.dopes) = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
			           " ORDER BY a.codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
			IF loc_nResultado >= 0
				SELECT codigos, cidchaves, dopes, descrs ;
					FROM cursor_4c_DadosTmp ;
					INTO CURSOR cursor_4c_Dados READWRITE

				IF USED("cursor_4c_DadosTmp")
					USE IN cursor_4c_DadosTmp
				ENDIF

				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_DadosTmp")
				USE IN cursor_4c_DadosTmp
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SalvarPorOperacao - Grava a lista completa de tabelas de desconto
	* de uma operacao (Dopes), substituindo os registros existentes.
	* Espelha o cmdSair.Click original: Delete From SigCdTbd Where dopes = ?
	* seguido de Insert Into SigCdTbd para cada linha nao vazia do grid.
	* par_cAliasCursor: cursor com as linhas do grid (coluna codigos).
	*====================================================================
	PROCEDURE SalvarPorOperacao(par_cDopes, par_cAliasCursor)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChaves

		loc_lSucesso = .F.

		IF !USED(par_cAliasCursor)
			THIS.this_cMensagemErro = "Cursor de dados n" + CHR(227) + "o localizado"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigCdTbd WHERE RTRIM(dopes) = " + ;
			           EscaparSQL(ALLTRIM(par_cDopes))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado < 0
				MsgErro("Erro ao excluir tabelas de desconto anteriores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.

				SELECT (par_cAliasCursor)
				SCAN WHILE loc_lSucesso
					IF !EMPTY(ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos")))
						loc_cCidChaves = LEFT(fUniqueIds(), 20)

						loc_cSQL = "INSERT INTO SigCdTbd (codigos, cidchaves, dopes)" + ;
						           " VALUES (" + ;
						           EscaparSQL(LEFT(ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos")), 10)) + "," + ;
						           EscaparSQL(loc_cCidChaves) + "," + ;
						           EscaparSQL(LEFT(ALLTRIM(par_cDopes), 20)) + ;
						           ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

						IF loc_nResultado < 0
							MsgErro("Erro ao gravar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ELSE
							THIS.this_cCidChaves = loc_cCidChaves
							THIS.this_cCodigos   = ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos"))
							THIS.this_cDopes     = ALLTRIM(par_cDopes)
							THIS.RegistrarAuditoria("INSERT")
						ENDIF
					ENDIF
				ENDSCAN

				SELECT (par_cAliasCursor)
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao gravar tabelas de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Verifica se ha codigos de tabela duplicados
	* no cursor do grid (espelha a checagem do cmdSair.Click original):
	*   Select Codigos, Sum(1) as Qt From xOpe Group by 1
	*   Into Cursor Selecao where codigos <> ' ' having Sum(1) > 1
	*====================================================================
	FUNCTION VerificarDuplicidade(par_cAliasCursor)
		LOCAL loc_lDuplicado

		loc_lDuplicado = .F.

		IF !USED(par_cAliasCursor)
			RETURN .F.
		ENDIF

		IF USED("cursor_4c_Duplicados")
			USE IN cursor_4c_Duplicados
		ENDIF

		SELECT codigos, COUNT(*) AS Qt FROM (par_cAliasCursor) ;
			WHERE ALLTRIM(codigos) <> "" ;
			GROUP BY codigos ;
			HAVING COUNT(*) > 1 ;
			INTO CURSOR cursor_4c_Duplicados

		IF USED("cursor_4c_Duplicados")
			IF RECCOUNT("cursor_4c_Duplicados") > 0
				loc_lDuplicado = .T.
			ENDIF
			USE IN cursor_4c_Duplicados
		ENDIF

		SELECT (par_cAliasCursor)

		RETURN loc_lDuplicado
	ENDFUNC

ENDDEFINE

