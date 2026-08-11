# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 179: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 322: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 342: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 363: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 384: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 405: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 735: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 755: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFAPF.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (808 linhas total):

*-- Linhas 77 a 124:
77:         TRY
78:             THIS.AddObject("cnt_4c_Sombra", "Container")
79:             WITH THIS.cnt_4c_Sombra
80:                 .Top         = 0
81:                 .Left        = 0
82:                 .Width       = THIS.Width
83:                 .Height      = 80
84:                 .BackColor   = RGB(100, 100, 100)
85:                 .BackStyle   = 1
86:                 .BorderWidth = 0
87: 
88:                 .AddObject("lbl_4c_LblSombra", "Label")
89:                 WITH .lbl_4c_LblSombra
90:                     .Top       = 18
91:                     .Left      = 10
92:                     .Width     = THIS.Width
93:                     .Height    = 40
94:                     .FontBold  = .T.
95:                     .FontName  = "Tahoma"
96:                     .FontSize  = 16
97:                     .AutoSize  = .F.
98:                     .BackStyle = 0
99:                     .WordWrap  = .T.
100:                     .Alignment = 0
101:                     .ForeColor = RGB(0, 0, 0)
102:                     .Caption   = "FAPF"
103:                 ENDWITH
104: 
105:                 .AddObject("lbl_4c_LblTitulo", "Label")
106:                 WITH .lbl_4c_LblTitulo
107:                     .Top       = 17
108:                     .Left      = 10
109:                     .Width     = THIS.Width
110:                     .Height    = 46
111:                     .FontBold  = .T.
112:                     .FontName  = "Tahoma"
113:                     .FontSize  = 16
114:                     .AutoSize  = .F.
115:                     .BackStyle = 0
116:                     .WordWrap  = .T.
117:                     .Alignment = 0
118:                     .ForeColor = RGB(255, 255, 255)
119:                     .Caption   = "FAPF"
120:                 ENDWITH
121: 
122:                 .Visible = .T.
123:             ENDWITH
124: 

*-- Linhas 153 a 185:
153: 
154:     *==========================================================================
155:     * ConfigurarBotoesAcao - Cria o container canonico de saida (Encerrar)
156:     * Padrao canonico: cnt_4c_Saida.Left=917 (adaptado para Width=718: Left=638)
157:     * cmd_4c_Encerrar: Left=5, Top=5, Width=75, Height=75, Caption="Encerrar"
158:     *==========================================================================
159:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
160:         LOCAL loc_oErro
161: 
162:         TRY
163:             THIS.AddObject("cnt_4c_Saida", "Container")
164:             WITH THIS.cnt_4c_Saida
165:                 .Top         = 5
166:                 .Left        = 917
167:                 .Width       = 90
168:                 .Height      = 85
169:                 .BackStyle   = 0
170:                 .BorderWidth = 0
171: 
172:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
173:                 WITH .cmd_4c_Encerrar
174:                     .Top             = 5
175:                     .Left            = 917
176:                     .Width           = 75
177:                     .Height          = 75
178:                     .Caption         = "Encerrar"
179:                     .FontBold        = .T.
180:                     .FontItalic      = .T.
181:                     .FontName        = "Comic Sans MS"
182:                     .FontSize        = 8
183:                     .WordWrap        = .T.
184:                     .ForeColor       = RGB(90, 90, 90)
185:                     .BackColor       = RGB(255, 255, 255)

*-- Linhas 251 a 267:
251:         LOCAL loc_oErro
252: 
253:         TRY
254:             BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
255:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
256:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
257:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
258:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
259:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
260:             BINDEVENT(THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar, ;
261:                       "Click", THIS, "BtnConfirmarClick")
262:             BINDEVENT(THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Cancelar, ;
263:                       "Click", THIS, "BtnCancelarClick")
264: 
265:         CATCH TO loc_oErro
266:             MsgErro(loc_oErro.Message + CHR(13) + ;
267:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 299 a 348:
299:         TRY
300:             THIS.AddObject("cnt_4c_Botoes", "Container")
301:             WITH THIS.cnt_4c_Botoes
302:                 .Top         = 5
303:                 .Left        = THIS.Width - 85 - 390 - 5
304:                 .Width       = 390
305:                 .Height      = 85
306:                 .BackStyle   = 0
307:                 .BorderWidth = 0
308:                 .AddObject("cmd_4c_Incluir",    "CommandButton")
309:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
310:                 .AddObject("cmd_4c_Alterar",    "CommandButton")
311:                 .AddObject("cmd_4c_Excluir",    "CommandButton")
312:                 .AddObject("cmd_4c_Buscar",     "CommandButton")
313:                 .Visible     = .T.
314:             ENDWITH
315: 
316:             WITH THIS.cnt_4c_Botoes.cmd_4c_Incluir
317:                 .Top             = 5
318:                 .Left            = 5
319:                 .Width           = 75
320:                 .Height          = 75
321:                 .Caption         = "Incluir"
322:                 .FontBold        = .T.
323:                 .FontItalic      = .T.
324:                 .FontName        = "Comic Sans MS"
325:                 .FontSize        = 8
326:                 .WordWrap        = .T.
327:                 .ForeColor       = RGB(90, 90, 90)
328:                 .BackColor       = RGB(255, 255, 255)
329:                 .SpecialEffect   = 0
330:                 .Themes          = .F.
331:                 .MousePointer    = 15
332:                 .PicturePosition = 13
333:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
334:             ENDWITH
335: 
336:             WITH THIS.cnt_4c_Botoes.cmd_4c_Visualizar
337:                 .Top             = 5
338:                 .Left            = 80
339:                 .Width           = 75
340:                 .Height          = 75
341:                 .Caption         = "Visualizar"
342:                 .FontBold        = .T.
343:                 .FontItalic      = .T.
344:                 .FontName        = "Comic Sans MS"
345:                 .FontSize        = 8
346:                 .WordWrap        = .T.
347:                 .ForeColor       = RGB(90, 90, 90)
348:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 354 a 369:
354:                 .Enabled         = .F.
355:             ENDWITH
356: 
357:             WITH THIS.cnt_4c_Botoes.cmd_4c_Alterar
358:                 .Top             = 5
359:                 .Left            = 155
360:                 .Width           = 75
361:                 .Height          = 75
362:                 .Caption         = "Alterar"
363:                 .FontBold        = .T.
364:                 .FontItalic      = .T.
365:                 .FontName        = "Comic Sans MS"
366:                 .FontSize        = 8
367:                 .WordWrap        = .T.
368:                 .ForeColor       = RGB(90, 90, 90)
369:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 375 a 390:
375:                 .Enabled         = .F.
376:             ENDWITH
377: 
378:             WITH THIS.cnt_4c_Botoes.cmd_4c_Excluir
379:                 .Top             = 5
380:                 .Left            = 230
381:                 .Width           = 75
382:                 .Height          = 75
383:                 .Caption         = "Excluir"
384:                 .FontBold        = .T.
385:                 .FontItalic      = .T.
386:                 .FontName        = "Comic Sans MS"
387:                 .FontSize        = 8
388:                 .WordWrap        = .T.
389:                 .ForeColor       = RGB(90, 90, 90)
390:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 396 a 411:
396:                 .Enabled         = .F.
397:             ENDWITH
398: 
399:             WITH THIS.cnt_4c_Botoes.cmd_4c_Buscar
400:                 .Top             = 5
401:                 .Left            = 305
402:                 .Width           = 75
403:                 .Height          = 75
404:                 .Caption         = "Buscar"
405:                 .FontBold        = .T.
406:                 .FontItalic      = .T.
407:                 .FontName        = "Comic Sans MS"
408:                 .FontSize        = 8
409:                 .WordWrap        = .T.
410:                 .ForeColor       = RGB(90, 90, 90)
411:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 437 a 446:
437: 
438:             THIS.AddObject("grd_4c_Lista", "Grid")
439:             WITH THIS.grd_4c_Lista
440:                 .Top                = 95
441:                 .Left               = 5
442:                 .Width              = THIS.Width - 10
443:                 .Height             = THIS.Height - 100
444:                 .FontName           = "Verdana"
445:                 .FontSize           = 8
446:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 458 a 469:
458:             THIS.grd_4c_Lista.RecordSource              = "cursor_4c_Dados"
459:             THIS.grd_4c_Lista.Column1.ControlSource     = "cursor_4c_Dados.Codigo"
460:             THIS.grd_4c_Lista.Column1.Width              = 150
461:             THIS.grd_4c_Lista.Column1.Header1.Caption   = "C" + CHR(243) + "digo"
462:             THIS.grd_4c_Lista.Column2.ControlSource     = "cursor_4c_Dados.Descricao"
463:             THIS.grd_4c_Lista.Column2.Width              = THIS.Width - 10 - 150 - 5
464:             THIS.grd_4c_Lista.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
465: 
466:         CATCH TO loc_oErro
467:             MsgErro(loc_oErro.Message + CHR(13) + ;
468:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
469:                 "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 493 a 502:
493:                 THIS.grd_4c_Lista.RecordSource                = "cursor_4c_Dados"
494:                 THIS.grd_4c_Lista.Column1.ControlSource       = "cursor_4c_Dados.Codigo"
495:                 THIS.grd_4c_Lista.Column2.ControlSource       = "cursor_4c_Dados.Descricao"
496:                 THIS.grd_4c_Lista.Column1.Header1.Caption     = "C" + CHR(243) + "digo"
497:                 THIS.grd_4c_Lista.Column2.Header1.Caption     = ;
498:                     "Descri" + CHR(231) + CHR(227) + "o"
499:             ENDIF
500: 
501:             THIS.AlternarPagina(1)
502: 

*-- Linhas 529 a 554:
529:             IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
530:                 THIS.cnt_4c_PainelDados.Visible = .F.
531:             ENDIF
532:             THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
533:             THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
534:             THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
535:             THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
536:             THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
537:         ELSE
538:             *-- Modo Dados: oculta grid, exibe painel de dados
539:             IF VARTYPE(THIS.grd_4c_Lista) = "O"
540:                 THIS.grd_4c_Lista.Visible = .F.
541:             ENDIF
542:             IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
543:                 THIS.cnt_4c_PainelDados.Visible = .T.
544:             ENDIF
545:             THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .F.
546:             THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .F.
547:             THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .F.
548:             THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .F.
549:             THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .F.
550:         ENDIF
551:     ENDPROC
552: 
553:     *==========================================================================
554:     * BtnIncluirClick - Inicia inclusao de novo registro

*-- Linhas 688 a 696:
688:     *==========================================================================
689:     PROCEDURE HabilitarCampos(par_lHabilitar)
690:         IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
691:             THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar.Enabled = ;
692:                 par_lHabilitar
693:         ENDIF
694:     ENDPROC
695: 
696:     *==========================================================================

*-- Linhas 703 a 741:
703:         TRY
704:             THIS.AddObject("cnt_4c_PainelDados", "Container")
705:             WITH THIS.cnt_4c_PainelDados
706:                 .Top         = 95
707:                 .Left        = 0
708:                 .Width       = THIS.Width
709:                 .Height      = THIS.Height - 95
710:                 .BackStyle   = 1
711:                 .BackColor   = RGB(255, 255, 255)
712:                 .BorderWidth = 0
713: 
714:                 .AddObject("cnt_4c_BotoesDados", "Container")
715:                 .Visible     = .T.
716:             ENDWITH
717: 
718:             WITH THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados
719:                 .Top         = THIS.Height - 185
720:                 .Left        = THIS.Width - 170
721:                 .Width       = 165
722:                 .Height      = 85
723:                 .BackStyle   = 0
724:                 .BorderWidth = 0
725: 
726:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
727:                 .AddObject("cmd_4c_Cancelar",  "CommandButton")
728:                 .Visible     = .T.
729:             ENDWITH
730: 
731:             WITH THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar
732:                 .Top             = 5
733:                 .Left            = 5
734:                 .Width           = 75
735:                 .Height          = 75
736:                 .Caption         = "Confirmar"
737:                 .FontBold        = .T.
738:                 .FontItalic      = .T.
739:                 .FontName        = "Comic Sans MS"
740:                 .FontSize        = 8
741:                 .WordWrap        = .T.

*-- Linhas 748 a 761:
748:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
749:             ENDWITH
750: 
751:             WITH THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Cancelar
752:                 .Top             = 5
753:                 .Left            = 85
754:                 .Width           = 75
755:                 .Height          = 75
756:                 .Caption         = "Cancelar"
757:                 .FontBold        = .T.
758:                 .FontItalic      = .T.
759:                 .FontName        = "Comic Sans MS"
760:                 .FontSize        = 8
761:                 .WordWrap        = .T.

*-- Linhas 798 a 808:
798:             RETURN
799:         ENDIF
800:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
801:         THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
802:         THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
803:         THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
804:         THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
805:         THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
806:     ENDPROC
807: 
808: ENDDEFINE


### BO (C:\4c\projeto\app\classes\FAPFBO.prg):
*====================================================================
* FAPFBO.prg
*
* Business Object para FAPF
* Form OPERACIONAL - formulario sem tabela propria no banco
*====================================================================

DEFINE CLASS FAPFBO AS BusinessBase

	*-- Identificacao da entidade (sem tabela propria - form operacional)
	this_cTabela      = ""
	this_cCampoChave  = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = ""
		THIS.this_cCampoChave = ""

		RETURN .T.
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Form operacional sem campos - sempre valido
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega dados do cursor para propriedades
	* Sem campos mapeados neste form operacional
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			IF !USED(par_cAliasCursor)
				loc_lResultado = .F.
			ENDIF

			SELECT (par_cAliasCursor)
			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em CarregarDoCursor")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro
	* Form operacional sem tabela - sem persistencia SQL
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			*-- Form operacional sem tabela propria
			*-- Registra auditoria da operacao (padrao arquitetural)
			THIS.RegistrarAuditoria("INSERT")
			loc_lResultado = .T.

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente
	* Form operacional sem tabela - sem persistencia SQL
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			*-- Form operacional sem tabela propria
			*-- Registra auditoria da operacao (padrao arquitetural)
			THIS.RegistrarAuditoria("UPDATE")
			loc_lResultado = .T.

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Executa exclusao de registro
	* Form operacional sem tabela - sem persistencia SQL
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			*-- Form operacional sem tabela propria
			THIS.RegistrarAuditoria("DELETE")
			loc_lResultado = .T.

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	* Sem chave primaria neste form operacional
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ""
	ENDPROC

ENDDEFINE

