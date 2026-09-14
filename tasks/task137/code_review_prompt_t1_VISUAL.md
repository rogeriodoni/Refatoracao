# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 82: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM12.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (749 linhas total):

*-- Linhas 60 a 68:
60:         Visible = .F.
61: 
62:     *-- Label "Funcionario :" abaixo do grid (Label3 do legado)
63:     ADD OBJECT lbl_4c_Label3 AS Label WITH ;
64:         AutoSize = .T., FontName = "Tahoma", FontSize = 8, ;
65:         BackStyle = 0, ;
66:         Caption = "Funcion" + CHR(225) + "rio : ", ;
67:         Height = 15, Left = 217, Top = 479, Width = 67, ;
68:         ForeColor = RGB(90,90,90), Visible = .F.

*-- Linhas 76 a 88:
76:         Value = "", Visible = .F.
77: 
78:     *-- Botao OK (ok do legado)
79:     ADD OBJECT cmd_4c_Ok AS CommandButton WITH ;
80:         Top = 3, Left = 725, Width = 75, Height = 75, ;
81:         Caption = "\<Ok", Cancel = .T., ;
82:         FontName = "Comic Sans MS", FontBold = .T., FontItalic = .T., FontSize = 8, ;
83:         ForeColor = RGB(90,90,90), BackColor = RGB(255,255,255), ;
84:         Themes = .F., SpecialEffect = 0, PicturePosition = 13, ;
85:         MousePointer = 15, WordWrap = .T., ;
86:         Visible = .F.
87: 
88:     *==========================================================================

*-- Linhas 126 a 134:
126: 
127:             THIS.TornarControlesVisiveis(THIS)
128: 
129:             BINDEVENT(THIS.cmd_4c_Ok,   "Click",              THIS, "BtnOkClick")
130:             BINDEVENT(THIS.grd_4c_Dados,"AfterRowColChange",  THIS, "GrdDadosAfterRowColChange")
131: 
132:             THIS.LockScreen = .F.
133:             loc_lSucesso = .T.
134:         CATCH TO loc_oErro

*-- Linhas 149 a 157:
149:     * derivados do Caption do form.
150:     *==========================================================================
151:     PROTECTED PROCEDURE ConfigurarPageFrame()
152:         THIS.Caption = "Retrabalhos j" + CHR(225) + " Realizados"
153:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
154: 
155:         *-- Form modal popup: WindowType ja e 1 (modal); AutoCenter centra na tela
156:         THIS.WindowType = 1
157:         THIS.AutoCenter = .T.

*-- Linhas 201 a 261:
201:     * Equivalente ao cntSombra.lblSombra + cntSombra.lblTitulo do legado
202:     *==========================================================================
203:     PROTECTED PROCEDURE ConfigurarCabecalho()
204:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
205:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
206:             .Top      = 18
207:             .Left     = 10
208:             .Width    = 769
209:             .Height   = 40
210:             .FontName = "Tahoma"
211:             .FontSize = 18
212:             .FontBold = .T.
213:             .BackStyle = 0
214:             .WordWrap  = .T.
215:             .Caption   = THIS.Caption
216:             .ForeColor = RGB(0, 0, 0)
217:         ENDWITH
218: 
219:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
220:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
221:             .Top      = 17
222:             .Left     = 10
223:             .Width    = 769
224:             .Height   = 46
225:             .FontName = "Tahoma"
226:             .FontSize = 18
227:             .FontBold = .T.
228:             .BackStyle = 0
229:             .WordWrap  = .T.
230:             .Caption   = THIS.Caption
231:             .ForeColor = RGB(255, 255, 255)
232:         ENDWITH
233:     ENDPROC
234: 
235:     *==========================================================================
236:     * ConfigurarAreaOperacao - Adiciona label e campos ao container de operacao
237:     * Equivalente ao container Opera...o do legado (campos tmpnens.*)
238:     *==========================================================================
239:     PROTECTED PROCEDURE ConfigurarAreaOperacao()
240:         THIS.cnt_4c_Operacao.AddObject("lbl_4c_Label4", "Label")
241:         WITH THIS.cnt_4c_Operacao.lbl_4c_Label4
242:             .Top       = 14
243:             .Left      = 10
244:             .AutoSize  = .T.
245:             .FontName  = "Tahoma"
246:             .FontSize  = 8
247:             .BackStyle = 0
248:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
249:             .ForeColor = RGB(90, 90, 90)
250:         ENDWITH
251: 
252:         *-- Empresa (tmpnens.emps)
253:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Empresa", "TextBox")
254:         WITH THIS.cnt_4c_Operacao.txt_4c_Empresa
255:             .Top               = 10
256:             .Left              = 80
257:             .Width             = 36
258:             .Height            = 23
259:             .Value             = ""
260:             .FontName          = "Tahoma"
261:             .FontSize          = 8

*-- Linhas 268 a 277:
268:         *-- Descricao da operacao (tmpnens.dopps)
269:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
270:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
271:             .Top               = 10
272:             .Left              = 118
273:             .Width             = 156
274:             .Height            = 23
275:             .Value             = ""
276:             .FontName          = "Tahoma"
277:             .FontSize          = 8

*-- Linhas 284 a 293:
284:         *-- Codigo numerico da operacao (tmpnens.numps)
285:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Codigo", "TextBox")
286:         WITH THIS.cnt_4c_Operacao.txt_4c_Codigo
287:             .Top               = 10
288:             .Left              = 276
289:             .Width             = 81
290:             .Height            = 23
291:             .Value             = 0
292:             .FontName          = "Tahoma"
293:             .FontSize          = 8

*-- Linhas 304 a 312:
304:     * ConfigurarBotaoOk - Associa icone ao botao OK
305:     *==========================================================================
306:     PROTECTED PROCEDURE ConfigurarBotaoOk()
307:         THIS.cmd_4c_Ok.Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
308:     ENDPROC
309: 
310:     *==========================================================================
311:     * ConfigurarGrid - Configura colunas, headers e ControlSources do grid
312:     * Equivalente a Grade.RecordSource + Column*.ControlSource do legado

*-- Linhas 328 a 384:
328:             .Column1.InputMask      = "9999999999"
329:             .Column1.Movable        = .F.
330:             .Column1.Resizable      = .F.
331:             .Column1.Header1.Caption    = "O.S."
332:             .Column1.Header1.FontName   = "Tahoma"
333:             .Column1.Header1.FontSize   = 8
334:             .Column1.Header1.FontBold   = .F.
335:             .Column1.Header1.Alignment  = 2
336: 
337:             *-- Coluna 2: Operacao (xnensir.EmpDopNums)
338:             .Column2.ControlSource  = "xNensiR.EmpDopNums"
339:             .Column2.Width          = 185
340:             .Column2.ReadOnly       = .T.
341:             .Column2.Movable        = .F.
342:             .Column2.Resizable      = .F.
343:             .Column2.Header1.Caption    = "Opera" + CHR(231) + CHR(227) + "o"
344:             .Column2.Header1.FontName   = "Tahoma"
345:             .Column2.Header1.FontSize   = 8
346:             .Column2.Header1.FontBold   = .F.
347:             .Column2.Header1.Alignment  = 2
348: 
349:             *-- Coluna 3: Data (xnensir.Datas)
350:             .Column3.ControlSource  = "xNensiR.Datas"
351:             .Column3.Width          = 75
352:             .Column3.ReadOnly       = .T.
353:             .Column3.Movable        = .F.
354:             .Column3.Resizable      = .F.
355:             .Column3.Header1.Caption    = "Data"
356:             .Column3.Header1.FontName   = "Tahoma"
357:             .Column3.Header1.FontSize   = 8
358:             .Column3.Header1.FontBold   = .F.
359:             .Column3.Header1.Alignment  = 2
360: 
361:             *-- Coluna 4: Grupo/Conta (xnensir.Destinos)
362:             .Column4.ControlSource  = "xNensiR.Destinos"
363:             .Column4.Width          = 135
364:             .Column4.ReadOnly       = .T.
365:             .Column4.Movable        = .F.
366:             .Column4.Resizable      = .F.
367:             .Column4.Header1.Caption    = "Grupo/Conta"
368:             .Column4.Header1.FontName   = "Tahoma"
369:             .Column4.Header1.FontSize   = 8
370:             .Column4.Header1.FontBold   = .F.
371:             .Column4.Header1.Alignment  = 2
372: 
373:             *-- Coluna 5: Retrabalho (xnensir.Retrabs)
374:             .Column5.ControlSource  = "xNensiR.Retrabs"
375:             .Column5.Width          = 175
376:             .Column5.ReadOnly       = .T.
377:             .Column5.Movable        = .F.
378:             .Column5.Resizable      = .F.
379:             .Column5.Header1.Caption    = "Retrabalhos"
380:             .Column5.Header1.FontName   = "Tahoma"
381:             .Column5.Header1.FontSize   = 8
382:             .Column5.Header1.FontBold   = .F.
383:             .Column5.Header1.Alignment  = 2
384: 

*-- Linhas 407 a 419:
407:                 THIS.grd_4c_Dados.RecordSource = "xNensiR"
408: 
409:                 *-- ControlSources reconfigurados apos RecordSource (VFP reseta headers)
410:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "O.S."
411:                 THIS.grd_4c_Dados.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
412:                 THIS.grd_4c_Dados.Column3.Header1.Caption = "Data"
413:                 THIS.grd_4c_Dados.Column4.Header1.Caption = "Grupo/Conta"
414:                 THIS.grd_4c_Dados.Column5.Header1.Caption = "Retrabalhos"
415: 
416:                 THIS.grd_4c_Dados.Refresh()
417:             ENDIF
418: 
419:         CATCH TO loc_oErro

*-- Linhas 613 a 641:
613:     *==========================================================================
614:     PROTECTED PROCEDURE ConfigurarPaginaDados()
615:         *-- Label "Funcionario :" (Label3 do legado)
616:         WITH THIS.lbl_4c_Label3
617:             .AutoSize  = .T.
618:             .FontName  = "Tahoma"
619:             .FontSize  = 8
620:             .BackStyle = 0
621:             .Caption   = "Funcion" + CHR(225) + "rio : "
622:             .Height    = 15
623:             .Left      = 217
624:             .Top       = 479
625:             .Width     = 67
626:             .ForeColor = RGB(90, 90, 90)
627:         ENDWITH
628: 
629:         *-- TextBox nome do funcionario (getRclis do legado)
630:         *-- ControlSource vinculado a xNensir na data session do form pai
631:         WITH THIS.txt_4c_Rclis
632:             .FontName          = "Tahoma"
633:             .FontSize          = 8
634:             .Height            = 23
635:             .Left              = 286
636:             .Top               = 476
637:             .Width             = 297
638:             .ReadOnly          = .T.
639:             .DisabledBackColor = RGB(255, 255, 255)
640:             .ControlSource     = "xNensir.rclis"
641:         ENDWITH

*-- Linhas 704 a 712:
704:     * Popup com unico botao OK: sempre habilitado
705:     *==========================================================================
706:     PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
707:         THIS.cmd_4c_Ok.Enabled = .T.
708:     ENDPROC
709: 
710:     *==========================================================================
711:     * BtnBuscarClick - Reposiciona grid ao topo e recarrega exibicao
712:     *==========================================================================


### BO (C:\4c\projeto\app\classes\SigPdM12BO.prg):
*====================================================================
* SigPdM12BO.prg
*
* Business Object para SigPdM12 - Retrabalhos ja Realizados
* Form popup read-only: exibe dados dos cursores xNensiR e tmpnens
* fornecidos pelo form pai via DataSession compartilhada.
* Nao possui tabela propria - operacoes de escrita sao rejeitadas.
*====================================================================

DEFINE CLASS SigPdM12BO AS BusinessBase

	*-- Campos do cursor xNensiR (grid de retrabalhos)
	this_nNenvs      = 0    && O.S. (numero envelope)
	this_cEmpDopNums = ""   && Operacao (descricao)
	this_dDatas      = {}   && Data do retrabalho
	this_cDestinos   = ""   && Grupo/Conta destino
	this_cRetrabs    = ""   && Descricao do retrabalho
	this_cRclis      = ""   && Funcionario (nome)

	*-- Campos do cursor tmpnens (cabecalho da operacao)
	this_nNumps      = 0    && Codigo da operacao (numps)
	this_cEmps       = ""   && Empresa (emps)
	this_cDopps      = ""   && Descricao da operacao (dopps)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = ""   && Sem tabela propria (usa cursores do form pai)
		THIS.this_cCampoChave = ""   && Sem chave primaria

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades a partir do cursor xNensiR
	* par_cAliasCursor: alias do cursor (normalmente "xNensiR")
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nNenvs      = TratarNulo(Nenvs,      "N")
			THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
			THIS.this_dDatas      = TratarNulo(Datas,      "D")
			THIS.this_cDestinos   = TratarNulo(Destinos,   "C")
			THIS.this_cRetrabs    = TratarNulo(Retrabs,    "C")
			THIS.this_cRclis      = TratarNulo(Rclis,      "C")
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* CarregarCabecalhoDoCursor - Carrega cabecalho a partir do cursor tmpnens
	* par_cAliasCursor: alias do cursor (normalmente "tmpnens")
	*====================================================================
	PROCEDURE CarregarCabecalhoDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nNumps  = TratarNulo(numps, "N")
			THIS.this_cEmps   = TratarNulo(emps,  "C")
			THIS.this_cDopps  = TratarNulo(dopps, "C")
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave do registro corrente (Nenvs)
	* Usado para auditoria; identifica unicamente o envelope/O.S.
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nNenvs)
	ENDFUNC

	*====================================================================
	* Inserir - Operacao nao suportada (form read-only)
	* Form SigPdM12 e um popup de consulta de retrabalhos ja realizados.
	* Os cursores xNensiR e tmpnens sao fornecidos pelo form pai via
	* DataSession compartilhada e nao podem ser modificados aqui.
	* Comportamento original (SCX): apenas exibicao em grid, botao OK fecha.
	*====================================================================
	PROCEDURE Inserir()
		THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
		                         "o suportada: formul" + CHR(225) + "rio de consulta " + ;
		                         "de retrabalhos " + CHR(233) + " somente leitura."
		RETURN .F.
	ENDPROC

	*====================================================================
	* Atualizar - Operacao nao suportada (form read-only)
	* Form SigPdM12 nao permite alteracao dos retrabalhos exibidos.
	* Manutencao dos registros deve ser feita atraves do form pai
	* (SigPdM01/SigPdM10) que possui a logica de cadastro.
	*====================================================================
	PROCEDURE Atualizar()
		THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
		                         "o suportada: utilize o formul" + CHR(225) + "rio de " + ;
		                         "cadastro de retrabalhos para alterar registros."
		RETURN .F.
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Operacao nao suportada (form read-only)
	* Exclusao de retrabalhos deve ser feita pelo form pai responsavel
	* pelo cadastro original. Este form apenas exibe os dados.
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
		                         "o suportada: utilize o formul" + CHR(225) + "rio de " + ;
		                         "cadastro de retrabalhos para excluir registros."
		RETURN .F.
	ENDPROC

	*====================================================================
	* ValidarDados - Sempre invalido (sem operacoes de escrita)
	* Como nao ha Inserir/Atualizar suportados, nao ha dados a validar.
	*====================================================================
	PROTECTED FUNCTION ValidarDados()
		THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de consulta n" + CHR(227) + ;
		                         "o suporta valida" + CHR(231) + CHR(227) + "o de escrita."
		RETURN .F.
	ENDFUNC

ENDDEFINE

