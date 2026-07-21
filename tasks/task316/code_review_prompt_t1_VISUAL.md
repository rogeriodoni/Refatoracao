# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [GRID-HEADER] Header Caption 'No.Autorização' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Hora' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cupom' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'No.Autorização' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Hora' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cupom' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigproef.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1220 linhas total):

*-- Linhas 54 a 86:
54:         loc_lConfOk  = .F.
55: 
56:         TRY
57:             THIS.Caption = "Sele" + CHR(231) + CHR(227) + "o da Transa" + CHR(231) + CHR(227) + "o"
58: 
59:             THIS.this_oBusinessObject = CREATEOBJECT("sigproefBO")
60:             loc_lBOOk = (VARTYPE(THIS.this_oBusinessObject) = "O")
61: 
62:             IF loc_lBOOk
63:                 loc_lConfOk = THIS.this_oBusinessObject.CarregarConfiguracao()
64:             ENDIF
65: 
66:             IF loc_lBOOk AND loc_lConfOk
67:                 THIS.ConfigurarPageFrame()
68:                 THIS.cnt_4c_Transa.lbl_4c_Titulo.Caption = THIS.Caption
69:                 THIS.this_cNsuRetorno = ""
70: 
71:                 *-- Propagar configuracoes da impressora fiscal para o form
72:                 THIS.this_cNoCaixa  = THIS.this_oBusinessObject.this_cCnCaixas
73:                 THIS.this_cOperacao = PADR(THIS.this_cNoCaixa + THIS.this_cNoFab + "ADM", 20)
74: 
75:                 THIS.TornarControlesVisiveis(THIS.cnt_4c_Transa)
76: 
77:                 BINDEVENT(THIS.cnt_4c_Transa.cmd_4c_Gerencial,                       "Click",    THIS, "BtnGerencialClick")
78:                 BINDEVENT(THIS.cnt_4c_Transa.cmd_4c_Ultimo,                          "Click",    THIS, "BtnUltimoClick")
79:                 BINDEVENT(THIS.cnt_4c_Transa.cmd_4c_Reimprime,                       "Click",    THIS, "BtnReimprimirClick")
80:                 BINDEVENT(THIS.cnt_4c_Transa.cmd_4c_Cancela,                         "Click",    THIS, "BtnCancelaClick")
81:                 BINDEVENT(THIS.cnt_4c_Transa.cmd_4c_Sair,                            "Click",    THIS, "BtnSairClick")
82:                 BINDEVENT(THIS,                                                       "KeyPress", THIS, "FormKeyPress")
83:                 BINDEVENT(THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial,        "KeyPress", THIS, "DtInicialKeyPress")
84:                 BINDEVENT(THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal,          "KeyPress", THIS, "DtFinalKeyPress")
85: 
86:                 THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Value = DATE()

*-- Linhas 116 a 125:
116:     PROTECTED PROCEDURE ConfigurarPageFrame()
117:         THIS.AddObject("cnt_4c_Transa", "Container")
118:         WITH THIS.cnt_4c_Transa
119:             .Top           = 3
120:             .Left          = 1
121:             .Height        = THIS.Height - 3
122:             .Width         = THIS.Width  - 2
123:             .SpecialEffect = 0
124:             .BorderWidth   = 0
125:             .BackStyle     = 1

*-- Linhas 138 a 166:
138:         LOCAL loc_oCnt
139:         loc_oCnt = THIS.cnt_4c_Transa
140: 
141:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oCnt.lbl_4c_Titulo
143:             .Caption    = "Transa" + CHR(231) + CHR(245) + "es Efetuadas"
144:             .FontBold   = .T.
145:             .FontItalic = .T.
146:             .FontSize   = 12
147:             .FontName   = "Tahoma"
148:             .ForeColor  = RGB(0, 0, 160)
149:             .Left       = 191
150:             .Top        = 9
151:             .AutoSize   = .T.
152:             .BackStyle  = 0
153:             .Visible    = .T.
154:         ENDWITH
155: 
156:         loc_oCnt.AddObject("lin_4c_Separador", "Line")
157:         WITH loc_oCnt.lin_4c_Separador
158:             .BorderWidth = 4
159:             .Height      = 0
160:             .Left        = 7
161:             .Top         = 29
162:             .Width       = 571
163:             .BorderColor = RGB(0, 0, 160)
164:             .Visible     = .T.
165:         ENDWITH
166:     ENDPROC

*-- Linhas 235 a 244:
235:             *-- Grid de transacoes TEF (pixel-perfect: Top=41, Left=8, 569x230, 7 colunas)
236:             loc_oCnt.AddObject("grd_4c_Dados", "Grid")
237:             WITH loc_oCnt.grd_4c_Dados
238:                 .Top           = 41
239:                 .Left          = 8
240:                 .Width         = 569
241:                 .Height        = 230
242:                 .ColumnCount   = 7
243:                 .ReadOnly      = .T.
244:                 .DeleteMark    = .F.

*-- Linhas 257 a 454:
257:             WITH loc_oCnt.grd_4c_Dados
258:                 .ColumnCount                  = 7
259:                 .Column1.Width                = 70
260:                 .Column1.Header1.Caption      = "Rede"
261:                 .Column1.Header1.Alignment    = 2
262:                 .Column1.Header1.FontSize     = 8
263:                 .Column2.Width                = 78
264:                 .Column2.Header1.Caption      = "No.Autoriza" + CHR(231) + CHR(227) + "o"
265:                 .Column2.Header1.Alignment    = 2
266:                 .Column2.Header1.FontSize     = 8
267:                 .Column3.Width                = 75
268:                 .Column3.Header1.Caption      = "Valor"
269:                 .Column3.Header1.Alignment    = 2
270:                 .Column3.Header1.FontSize     = 8
271:                 .Column4.Width                = 65
272:                 .Column4.Alignment            = 2
273:                 .Column4.Header1.Caption      = "Data"
274:                 .Column4.Header1.Alignment    = 2
275:                 .Column4.Header1.FontSize     = 8
276:                 .Column5.Width                = 55
277:                 .Column5.Header1.Caption      = "Hora"
278:                 .Column5.Header1.Alignment    = 2
279:                 .Column5.Header1.FontSize     = 8
280:                 .Column6.Width                = 60
281:                 .Column6.Header1.Caption      = "Cupom"
282:                 .Column6.Header1.Alignment    = 2
283:                 .Column6.Header1.FontSize     = 8
284:                 .Column7.Width                = 120
285:                 .Column7.Header1.Caption      = "Opera" + CHR(231) + CHR(227) + "o"
286:                 .Column7.Header1.Alignment    = 2
287:                 .Column7.Header1.FontSize     = 8
288:             ENDWITH
289: 
290:             *-- Container do filtro de periodo (pixel-perfect: Top=278, Left=7, 217x52)
291:             loc_oCnt.AddObject("cnt_4c_Periodo", "Container")
292:             WITH loc_oCnt.cnt_4c_Periodo
293:                 .Top           = 278
294:                 .Left          = 7
295:                 .Width         = 217
296:                 .Height        = 52
297:                 .SpecialEffect = 0
298:                 .BorderWidth   = 0
299:                 .BackStyle     = 1
300:                 .BackColor     = RGB(240, 240, 240)
301:                 .Visible       = .T.
302:             ENDWITH
303: 
304:             loc_oPer = loc_oCnt.cnt_4c_Periodo
305: 
306:             loc_oPer.AddObject("lbl_4c_Periodo", "Label")
307:             WITH loc_oPer.lbl_4c_Periodo
308:                 .Caption       = "Per" + CHR(237) + "odo"
309:                 .FontBold      = .T.
310:                 .FontItalic    = .T.
311:                 .FontSize      = 10
312:                 .FontUnderline = .T.
313:                 .AutoSize      = .F.
314:                 .Width         = 59
315:                 .Height        = 18
316:                 .Left          = 16
317:                 .Top           = 3
318:                 .ForeColor     = RGB(0, 0, 160)
319:                 .BackStyle     = 0
320:                 .Visible       = .T.
321:             ENDWITH
322: 
323:             loc_oPer.AddObject("txt_4c_DtInicial", "TextBox")
324:             WITH loc_oPer.txt_4c_DtInicial
325:                 .Value     = {}
326:                 .Alignment = 3
327:                 .Height    = 23
328:                 .Left      = 14
329:                 .Top       = 22
330:                 .Width     = 81
331:                 .FontName  = "Tahoma"
332:                 .FontSize  = 8
333:                 .Visible   = .T.
334:             ENDWITH
335: 
336:             loc_oPer.AddObject("lbl_4c_A", "Label")
337:             WITH loc_oPer.lbl_4c_A
338:                 .Caption   = "a"
339:                 .Left      = 103
340:                 .Top       = 25
341:                 .AutoSize  = .T.
342:                 .BackStyle = 0
343:                 .Visible   = .T.
344:             ENDWITH
345: 
346:             loc_oPer.AddObject("txt_4c_DtFinal", "TextBox")
347:             WITH loc_oPer.txt_4c_DtFinal
348:                 .Value     = {}
349:                 .Alignment = 3
350:                 .Height    = 23
351:                 .Left      = 119
352:                 .Top       = 22
353:                 .Width     = 81
354:                 .FontName  = "Tahoma"
355:                 .FontSize  = 8
356:                 .Visible   = .T.
357:             ENDWITH
358: 
359:             *-- Shape decorativo de fundo dos botoes (pixel-perfect: Top=277, Left=245, 331x53)
360:             loc_oCnt.AddObject("shp_4c_Botoes", "Shape")
361:             WITH loc_oCnt.shp_4c_Botoes
362:                 .Top           = 277
363:                 .Left          = 245
364:                 .Height        = 53
365:                 .Width         = 331
366:                 .SpecialEffect = 0
367:                 .Visible       = .T.
368:             ENDWITH
369: 
370:             *-- Botao Gerencial F2 (pixel-perfect: Top=281, Left=251, 64x46)
371:             loc_oCnt.AddObject("cmd_4c_Gerencial", "CommandButton")
372:             WITH loc_oCnt.cmd_4c_Gerencial
373:                 .Top      = 281
374:                 .Left     = 251
375:                 .Height   = 46
376:                 .Width    = 64
377:                 .Caption  = "<F2> Gerencial"
378:                 .FontBold = .T.
379:                 .FontName = "Small Fonts"
380:                 .FontSize = 7
381:                 .ForeColor = RGB(0, 0, 255)
382:                 .WordWrap  = .T.
383:                 .Picture   = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
384:                 .Themes    = .T.
385:                 .Visible   = .T.
386:             ENDWITH
387: 
388:             *-- Botao Ultimo F3 (pixel-perfect: Top=281, Left=315, 64x46)
389:             loc_oCnt.AddObject("cmd_4c_Ultimo", "CommandButton")
390:             WITH loc_oCnt.cmd_4c_Ultimo
391:                 .Top      = 281
392:                 .Left     = 315
393:                 .Height   = 46
394:                 .Width    = 64
395:                 .Caption  = "<F3> " + CHR(218) + "ltimo"
396:                 .FontBold = .T.
397:                 .FontName = "Small Fonts"
398:                 .FontSize = 7
399:                 .ForeColor = RGB(0, 0, 255)
400:                 .WordWrap  = .T.
401:                 .Picture   = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
402:                 .Themes    = .T.
403:                 .Visible   = .T.
404:             ENDWITH
405: 
406:             *-- Botao Reimprimir F4 (pixel-perfect: Top=281, Left=379, 64x46)
407:             loc_oCnt.AddObject("cmd_4c_Reimprime", "CommandButton")
408:             WITH loc_oCnt.cmd_4c_Reimprime
409:                 .Top      = 281
410:                 .Left     = 379
411:                 .Height   = 46
412:                 .Width    = 64
413:                 .Caption  = "<F4> Reimprimir"
414:                 .FontBold = .T.
415:                 .FontName = "Small Fonts"
416:                 .FontSize = 7
417:                 .ForeColor = RGB(0, 0, 255)
418:                 .WordWrap  = .T.
419:                 .Picture   = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
420:                 .Themes    = .T.
421:                 .Visible   = .T.
422:             ENDWITH
423: 
424:             *-- Botao Cancelar F5 (pixel-perfect: Top=281, Left=443, 64x46)
425:             loc_oCnt.AddObject("cmd_4c_Cancela", "CommandButton")
426:             WITH loc_oCnt.cmd_4c_Cancela
427:                 .Top      = 281
428:                 .Left     = 443
429:                 .Height   = 46
430:                 .Width    = 64
431:                 .Caption  = "<F5> Cancelar"
432:                 .FontBold = .T.
433:                 .FontName = "Small Fonts"
434:                 .FontSize = 7
435:                 .ForeColor = RGB(0, 0, 255)
436:                 .WordWrap  = .T.
437:                 .Picture   = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
438:                 .Themes    = .T.
439:                 .Visible   = .T.
440:             ENDWITH
441: 
442:             *-- Botao Sair ESC (pixel-perfect: Top=281, Left=507, 64x46)
443:             loc_oCnt.AddObject("cmd_4c_Sair", "CommandButton")
444:             WITH loc_oCnt.cmd_4c_Sair
445:                 .Top      = 281
446:                 .Left     = 507
447:                 .Height   = 75
448:                 .Width    = 75
449:                 .Caption  = "<ESC> Sair"
450:                 .Cancel   = .T.
451:                 .FontBold = .T.
452:                 .FontName = "Small Fonts"
453:                 .FontSize = 7
454:                 .ForeColor = RGB(0, 0, 255)

*-- Linhas 637 a 706:
637:                 loc_oGrid.Column1.Movable          = .F.
638:                 loc_oGrid.Column1.Resizable        = .F.
639:                 loc_oGrid.Column1.ReadOnly         = .T.
640:                 loc_oGrid.Column1.Header1.Caption  = "Rede"
641:                 loc_oGrid.Column1.Header1.Alignment = 2
642:                 loc_oGrid.Column1.Header1.FontSize  = 8
643: 
644:                 loc_oGrid.Column2.ControlSource    = "Transacao.cnnsus"
645:                 loc_oGrid.Column2.Width            = 78
646:                 loc_oGrid.Column2.FontSize         = 8
647:                 loc_oGrid.Column2.Movable          = .F.
648:                 loc_oGrid.Column2.Resizable        = .F.
649:                 loc_oGrid.Column2.ReadOnly         = .T.
650:                 loc_oGrid.Column2.Header1.Caption  = "No.Autoriza" + CHR(231) + CHR(227) + "o"
651:                 loc_oGrid.Column2.Header1.Alignment = 2
652:                 loc_oGrid.Column2.Header1.FontSize  = 8
653: 
654:                 loc_oGrid.Column3.ControlSource    = "Transacao.cnValors"
655:                 loc_oGrid.Column3.Width            = 75
656:                 loc_oGrid.Column3.FontSize         = 8
657:                 loc_oGrid.Column3.Movable          = .F.
658:                 loc_oGrid.Column3.Resizable        = .F.
659:                 loc_oGrid.Column3.ReadOnly         = .T.
660:                 loc_oGrid.Column3.Header1.Caption  = "Valor"
661:                 loc_oGrid.Column3.Header1.Alignment = 2
662:                 loc_oGrid.Column3.Header1.FontSize  = 8
663: 
664:                 loc_oGrid.Column4.ControlSource    = "Transacao.cnDtTrans"
665:                 loc_oGrid.Column4.Width            = 65
666:                 loc_oGrid.Column4.FontSize         = 8
667:                 loc_oGrid.Column4.Movable          = .F.
668:                 loc_oGrid.Column4.Resizable        = .F.
669:                 loc_oGrid.Column4.ReadOnly         = .T.
670:                 loc_oGrid.Column4.Alignment        = 2
671:                 loc_oGrid.Column4.Header1.Caption  = "Data"
672:                 loc_oGrid.Column4.Header1.Alignment = 2
673:                 loc_oGrid.Column4.Header1.FontSize  = 8
674: 
675:                 loc_oGrid.Column5.ControlSource    = "Transacao.CnHrTrans"
676:                 loc_oGrid.Column5.Width            = 55
677:                 loc_oGrid.Column5.FontSize         = 8
678:                 loc_oGrid.Column5.Movable          = .F.
679:                 loc_oGrid.Column5.Resizable        = .F.
680:                 loc_oGrid.Column5.ReadOnly         = .T.
681:                 loc_oGrid.Column5.Header1.Caption  = "Hora"
682:                 loc_oGrid.Column5.Header1.Alignment = 2
683:                 loc_oGrid.Column5.Header1.FontSize  = 8
684: 
685:                 loc_oGrid.Column6.ControlSource    = "Transacao.cnCupoms"
686:                 loc_oGrid.Column6.Width            = 60
687:                 loc_oGrid.Column6.FontSize         = 8
688:                 loc_oGrid.Column6.Movable          = .F.
689:                 loc_oGrid.Column6.Resizable        = .F.
690:                 loc_oGrid.Column6.ReadOnly         = .T.
691:                 loc_oGrid.Column6.Header1.Caption  = "Cupom"
692:                 loc_oGrid.Column6.Header1.Alignment = 2
693:                 loc_oGrid.Column6.Header1.FontSize  = 8
694: 
695:                 loc_oGrid.Column7.ControlSource    = "Transacao.cDopes"
696:                 loc_oGrid.Column7.Width            = 120
697:                 loc_oGrid.Column7.FontSize         = 8
698:                 loc_oGrid.Column7.Movable          = .F.
699:                 loc_oGrid.Column7.Resizable        = .F.
700:                 loc_oGrid.Column7.ReadOnly         = .T.
701:                 loc_oGrid.Column7.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
702:                 loc_oGrid.Column7.Header1.Alignment = 2
703:                 loc_oGrid.Column7.Header1.FontSize  = 8
704: 
705:                 loc_oGrid.SetAll("DynamicForeColor", ;
706:                     "IIF(Transacao.lCancel, RGB(255,0,0), RGB(0,0,0))", "Column")

*-- Linhas 734 a 742:
734:             CASE par_nKeyCode = -3
735:                 NODEFAULT
736:                 THIS.BtnReimprimirClick()
737:             CASE par_nKeyCode = -4 AND THIS.cnt_4c_Transa.cmd_4c_Cancela.Visible
738:                 NODEFAULT
739:                 THIS.BtnCancelaClick()
740:         ENDCASE
741:     ENDPROC
742: 

*-- Linhas 1190 a 1198:
1190:             THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Enabled = .T.
1191:             THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal.Enabled   = .T.
1192: 
1193:             THIS.cnt_4c_Transa.cmd_4c_Cancela.Visible = loc_lTemTransacao
1194: 
1195:         CATCH TO loc_oErro
1196:             MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
1197:         ENDTRY
1198:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigproefBO.prg):
*====================================================================
* sigproefBO.prg
* Business Object para Selecao de Transacao TEF (sigproef)
* Tabela principal: SigOpFp | Chave: Fpags
*====================================================================

DEFINE CLASS sigproefBO AS BusinessBase

    *-- ===================================================================
    *-- IDENTIFICACAO DA ENTIDADE
    *-- ===================================================================
    this_cTabela     = "SigOpFp"
    this_cCampoChave = "Fpags"

    *-- ===================================================================
    *-- CONFIGURACAO DE HARDWARE - SigCdPam
    *-- ===================================================================
    this_nNcChequeps = 0
    this_nSistef     = 0
    this_cNumIps     = ""

    *-- ===================================================================
    *-- CONFIGURACAO DO SISTEMA - SigCdPac
    *-- ===================================================================
    this_cVerSitefs  = ""

    *-- ===================================================================
    *-- IMPRESSORA FISCAL - SIGFIMPF
    *-- ===================================================================
    this_cCImpFabs   = ""
    this_cCnCaixas   = ""

    *-- ===================================================================
    *-- ESTADO OPERACIONAL DO FORM
    *-- ===================================================================
    this_cOperacao   = ""
    this_cNoCaixa    = ""
    this_cNoFab      = ""
    this_lCancelaVisivel = .F.

    *-- ===================================================================
    *-- FILTRO DE PERIODO
    *-- ===================================================================
    this_dDataInicial = {}
    this_dDataFinal   = {}

    *-- ===================================================================
    *-- PAGAMENTO FP - SigOpFp (campos usados pelo form)
    *-- ===================================================================
    this_cCodEstabs   = ""

    *-- ===================================================================
    *-- TRANSACAO CORRENTE (campos do cursor Transacao)
    *-- ===================================================================
    this_cDopes       = ""
    this_cCnCupoms    = ""
    this_cCCupomNvs   = ""
    this_cCnNsus      = ""
    this_nCnValors    = 0
    this_dCnDtTrans   = {}
    this_cCnHrTrans   = ""
    this_cStatus      = ""
    this_cFPags       = ""
    this_lCancel      = .F.
    this_nCupFis      = 0
    this_cEmpDopNums  = ""
    this_cCnIdents    = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigOpFp"
            THIS.this_cCampoChave = "Fpags"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarConfiguracao - Carrega SigCdPam e SigCdPac em cursores
    * Chamado pelo form apos conexao estabelecida
    *====================================================================
    PROCEDURE CarregarConfiguracao()
        LOCAL loc_lResultado, loc_nRes
        loc_lResultado = .F.

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT ncchequeps, Sistef, NumIps FROM SigCdPam", ;
                "crSigCdPam")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdPam"
                loc_lResultado = .F.
            ENDIF

            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT VerSitefs FROM SigCdPac", ;
                "crSigCdPac")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdPac"
                loc_lResultado = .F.
            ENDIF

            IF USED("crSigCdPam")
                SELECT crSigCdPam
                GO TOP
                THIS.this_nNcChequeps = NVL(ncchequeps, 0)
                THIS.this_nSistef     = NVL(Sistef, 0)
                THIS.this_cNumIps     = ALLTRIM(NVL(NumIps, ""))
            ENDIF

            IF USED("crSigCdPac")
                SELECT crSigCdPac
                GO TOP
                THIS.this_cVerSitefs  = ALLTRIM(NVL(VerSitefs, ""))
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarImpressoraFiscal - Carrega SIGFIMPF pelo numero de fabricacao
    * par_cNoFab: numero de fabricacao da impressora (cImpFabs)
    *====================================================================
    PROCEDURE CarregarImpressoraFiscal(par_cNoFab)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cImpFabs, CnCaixas FROM SIGFIMPF"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiMpF")

            IF loc_nRes >= 0 AND USED("crSigFiMpF")
                SELECT crSigFiMpF
                IF !EOF()
                    THIS.this_cCImpFabs = ALLTRIM(NVL(cImpFabs, ""))
                    THIS.this_cCnCaixas = ALLTRIM(NVL(CnCaixas, ""))
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Impressora Fiscal inv" + CHR(225) + "lida para esta Loja"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar impressora fiscal"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarTransacoes - Busca transacoes TEF no periodo informado
    * Equivalente ao metodo SqlTrans do form original
    * Popula cursor "Transacao" com os dados formatados
    *====================================================================
    PROCEDURE BuscarTransacoes(par_dDataInicial, par_dDataFinal)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        LOCAL loc_cDtI, loc_cDtF, loc_cDtISQL, loc_cDtFSQL
        loc_lResultado = .F.

        TRY
            THIS.this_dDataInicial = par_dDataInicial
            THIS.this_dDataFinal   = par_dDataFinal

            loc_cDtI    = DTOS(par_dDataInicial)
            loc_cDtF    = DTOS(par_dDataFinal)
            loc_cDtISQL = FormatarDataSQL(par_dDataInicial)
            loc_cDtFSQL = FormatarDataSQL(par_dDataFinal)

            loc_cSQL = "SELECT DISTINCT a.Cemps, a.cDopes, a.cncupoms, a.cnIdents, " + ;
                       "a.cCupomNvs, a.cNnsus, a.cNValors, a.cnDtTrans, " + ;
                       "a.CnHrTrans, a.cStatus, a.FPags " + ;
                       "FROM SigFiTef a " + ;
                       "WHERE cndttransI BETWEEN " + EscaparSQL(loc_cDtI) + " AND " + EscaparSQL(loc_cDtF) + " " + ;
                       "AND a.ctipos = 'R' " + ;
                       "AND (a.cHeaders = 'CRT' OR a.cHeaders = 'CHQ') " + ;
                       "AND NOT a.cnnsus = '   ' " + ;
                       "ORDER BY a.cnDtTrans, a.CnHrTrans"

            IF USED("Selecao")
                USE IN Selecao
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "Selecao")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao buscar transa" + CHR(231) + CHR(245) + "es TEF"
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Notas, b.CupFis " + ;
                       "FROM SigMvCab a, SigCdOpe b " + ;
                       "WHERE a.Datas BETWEEN " + loc_cDtISQL + " AND " + loc_cDtFSQL + " " + ;
                       "AND a.dopes = b.dopes " + ;
                       "AND b.Cupfis IN (1, 3)"

            IF USED("Selecao2")
                USE IN Selecao2
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "Selecao2")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de cupom"
                loc_lResultado = .F.
            ENDIF

            SELECT Selecao2
            INDEX ON EmpDopNums TAG EmpDopNums

            IF USED("Transacao")
                USE IN Transacao
            ENDIF
            CREATE CURSOR Transacao ( ;
                cDopes      C(20), ;
                cnCupoms    C(10), ;
                cCupomNvs   C(20), ;
                cnnsus      C(12), ;
                cnValors    N(12,2), ;
                cnDtTrans   D, ;
                CnHrTrans   C(8), ;
                cStatus     C(3), ;
                FPags       C(12), ;
                lCancel     L, ;
                CupFis      N(1), ;
                EmpDopNums  C(29), ;
                cnIdents    C(10) ;
            )
            INDEX ON cnDtTrans TAG Datas

            SELECT Selecao
            SCAN
                SCATTER MEMVAR
                m.CnHrTrans = TRANSFORM(m.CnHrTrans, "@R xx:xx:xx")
                m.CnValors  = ROUND(VAL(STRTRAN(m.cnValors, ',', '')) / 100, 2)
                m.CnDtTrans = CTOD(SUBSTR(m.CnDtTrans, 1, 2) + '/' + ;
                              SUBSTR(m.CnDtTrans, 3, 2) + '/' + ;
                              RIGHT(m.CnDtTrans, 4))

                =SEEK(m.Cemps + PADR(m.Cdopes, 20) + STR(VAL(m.cncupoms), 6), 'Selecao2')

                IF !EOF('Selecao2')
                    m.cnCupoms   = Selecao2.Notas
                    m.CupFis     = Selecao2.CupFis
                    m.EmpDopNums = Selecao2.EmpDopNums
                ELSE
                    m.cnCupoms   = ""
                    m.CupFis     = 0
                    m.EmpDopNums = ""
                ENDIF

                SELECT Transacao
                APPEND BLANK
                GATHER MEMVAR
                REPLACE cnnsus   WITH SUBSTR(cnnsus, 1, 12)
                REPLACE lCancel  WITH IIF(cStatus = "CNC", .T., .F.)
            ENDSCAN

            SELECT Transacao
            GO BOTTOM

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarPagamentoFP - Carrega dados de SigOpFp para transacao corrente
    * par_cFPags: chave Fpags da transacao
    *====================================================================
    PROCEDURE CarregarPagamentoFP(par_cFPags)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("csSigOpFp")
                USE IN csSigOpFp
            ENDIF

            loc_cSQL = "SELECT * FROM SigOpFp WHERE Fpags = " + EscaparSQL(par_cFPags)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "csSigOpFp")

            IF loc_nRes >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar pagamento"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CancelarTransacao - Cancela transacao TEF selecionada
    * Atualiza SigFiTef e SigMvPar
    * par_cCnNsus:     NSU da transacao
    * par_cEmpDopNums: chave EmpDopNums para SigMvPar
    * par_cCnIdents:   identidade da transacao em SigMvPar
    *====================================================================
    PROCEDURE CancelarTransacao(par_cCnNsus, par_cEmpDopNums, par_cCnIdents)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = 'CNC', " + ;
                       "UsuCancs = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
                       "WHERE ctipos = 'R' AND cHeaders = 'CRT' " + ;
                       "AND CNNSUS = " + EscaparSQL(ALLTRIM(par_cCnNsus))

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRes > 0
                loc_cSQL = "SELECT EmpDopNums, Valos, CnIdTefs, cidChaves " + ;
                           "FROM SigMvPar WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

                IF USED("LocalPar")
                    USE IN LocalPar
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "LocalPar")

                SELECT LocalPar
                LOCATE FOR CnIdTefs = par_cCnIdents
                IF !EOF() AND loc_nRes > 0
                    loc_cSQL = "UPDATE SigMvPar SET lCancelas = 1 " + ;
                               "WHERE CidChaves = " + EscaparSQL(LocalPar.Cidchaves)
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF

                IF loc_nRes > 0
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar SigMvPar"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao cancelar em SigFiTef"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarTransacaoCorrente - Preenche this_* com dados da linha do grid
    * par_cAlias: alias do cursor Transacao (normalmente "Transacao")
    *====================================================================
    PROCEDURE CarregarTransacaoCorrente(par_cAlias)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAlias)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAlias)
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            THIS.this_cDopes      = ALLTRIM(NVL(cDopes, ""))
            THIS.this_cCnCupoms   = ALLTRIM(NVL(cnCupoms, ""))
            THIS.this_cCCupomNvs  = ALLTRIM(NVL(cCupomNvs, ""))
            THIS.this_cCnNsus     = ALLTRIM(NVL(cnnsus, ""))
            THIS.this_nCnValors   = NVL(cnValors, 0)
            THIS.this_dCnDtTrans  = NVL(cnDtTrans, {})
            THIS.this_cCnHrTrans  = ALLTRIM(NVL(CnHrTrans, ""))
            THIS.this_cStatus     = ALLTRIM(NVL(cStatus, ""))
            THIS.this_cFPags      = ALLTRIM(NVL(FPags, ""))
            THIS.this_lCancel     = NVL(lCancel, .F.)
            THIS.this_nCupFis     = NVL(CupFis, 0)
            THIS.this_cEmpDopNums = ALLTRIM(NVL(EmpDopNums, ""))
            THIS.this_cCnIdents   = ALLTRIM(NVL(cnIdents, ""))

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega campos de SigOpFp nas propriedades this_*
    * par_cAliasCursor: alias do cursor com dados de SigOpFp (ex: csSigOpFp)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            THIS.this_cFPags     = ALLTRIM(NVL(Fpags, ""))
            THIS.this_cCodEstabs = ALLTRIM(NVL(CodEstabs, ""))

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cFPags
    ENDPROC

    *====================================================================
    * Inserir - Insere transacao no cursor local Transacao
    * Usado para registrar transacoes TEF processadas pelo form
    * Preenche todos os campos usando as propriedades this_*
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cValFmt
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cFPags)
                THIS.this_cMensagemErro = "Forma de pagamento (Fpags) obrigat" + CHR(243) + "ria"
                loc_lResultado = .F.
            ENDIF

            IF !USED("Transacao")
                CREATE CURSOR Transacao ( ;
                    cDopes      C(20), ;
                    cnCupoms    C(10), ;
                    cCupomNvs   C(20), ;
                    cnnsus      C(12), ;
                    cnValors    N(12,2), ;
                    cnDtTrans   D, ;
                    CnHrTrans   C(8), ;
                    cStatus     C(3), ;
                    FPags       C(12), ;
                    lCancel     L, ;
                    CupFis      N(1), ;
                    EmpDopNums  C(29), ;
                    cnIdents    C(10) ;
                )
                INDEX ON cnDtTrans TAG Datas
            ENDIF

            SELECT Transacao
            APPEND BLANK
            REPLACE cDopes      WITH THIS.this_cDopes, ;
                    cnCupoms    WITH THIS.this_cCnCupoms, ;
                    cCupomNvs   WITH THIS.this_cCCupomNvs, ;
                    cnnsus      WITH THIS.this_cCnNsus, ;
                    cnValors    WITH THIS.this_nCnValors, ;
                    cnDtTrans   WITH THIS.this_dCnDtTrans, ;
                    CnHrTrans   WITH THIS.this_cCnHrTrans, ;
                    cStatus     WITH THIS.this_cStatus, ;
                    FPags       WITH THIS.this_cFPags, ;
                    lCancel     WITH THIS.this_lCancel, ;
                    CupFis      WITH THIS.this_nCupFis, ;
                    EmpDopNums  WITH THIS.this_cEmpDopNums, ;
                    cnIdents    WITH THIS.this_cCnIdents

            THIS.RegistrarAuditoria("INSERT")
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir transa" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza transacao no cursor local Transacao
    * Localiza pela chave FPags e atualiza campos mutaveis
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cFPags)
                THIS.this_cMensagemErro = "Forma de pagamento (Fpags) obrigat" + CHR(243) + "ria"
                loc_lResultado = .F.
            ENDIF

            IF !USED("Transacao")
                THIS.this_cMensagemErro = "Cursor Transacao n" + CHR(227) + "o est" + CHR(225) + " aberto"
                loc_lResultado = .F.
            ENDIF

            SELECT Transacao
            LOCATE FOR ALLTRIM(FPags) == ALLTRIM(THIS.this_cFPags) ;
                       AND ALLTRIM(cnnsus) == ALLTRIM(THIS.this_cCnNsus)

            IF !FOUND()
                THIS.this_cMensagemErro = "Transa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada"
                loc_lResultado = .F.
            ENDIF

            REPLACE cStatus    WITH THIS.this_cStatus, ;
                    lCancel    WITH THIS.this_lCancel, ;
                    cnValors   WITH THIS.this_nCnValors, ;
                    CnHrTrans  WITH THIS.this_cCnHrTrans, ;
                    CupFis     WITH THIS.this_nCupFis, ;
                    EmpDopNums WITH THIS.this_cEmpDopNums, ;
                    cnIdents   WITH THIS.this_cCnIdents

            THIS.RegistrarAuditoria("UPDATE")
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar transa" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

