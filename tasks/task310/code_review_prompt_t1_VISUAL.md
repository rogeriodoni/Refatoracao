# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 290: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 312: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 334: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 356: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 379: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1187 linhas total):

*-- Linhas 95 a 136:
95:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
96:         loc_oCab = THIS.cnt_4c_Cabecalho
97:         WITH loc_oCab
98:             .Top         = 0
99:             .Left        = 0
100:             .Width       = THIS.Width
101:             .Height      = 80
102:             .BackStyle   = 1
103:             .BackColor   = RGB(100, 100, 100)
104:             .BorderWidth = 0
105:         ENDWITH
106:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
107:         WITH loc_oCab.lbl_4c_Sombra
108:             .Top       = 18
109:             .Left      = 10
110:             .Width     = THIS.Width - 20
111:             .Height    = 40
112:             .AutoSize  = .F.
113:             .FontName  = "Tahoma"
114:             .FontSize  = 18
115:             .FontBold  = .T.
116:             .BackStyle = 0
117:             .Caption   = THIS.Caption
118:             .ForeColor = RGB(0, 0, 0)
119:         ENDWITH
120:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
121:         WITH loc_oCab.lbl_4c_Titulo
122:             .Top       = 17
123:             .Left      = 10
124:             .Width     = THIS.Width - 20
125:             .Height    = 46
126:             .AutoSize  = .F.
127:             .FontName  = "Tahoma"
128:             .FontSize  = 18
129:             .FontBold  = .T.
130:             .BackStyle = 0
131:             .Caption   = THIS.Caption
132:             .ForeColor = RGB(255, 255, 255)
133:         ENDWITH
134:     ENDPROC
135: 
136:     *--------------------------------------------------------------------------

*-- Linhas 143 a 152:
143:         THIS.AddObject("cnt_4c_Botoes", "Container")
144:         loc_oCnt = THIS.cnt_4c_Botoes
145:         WITH loc_oCnt
146:             .Top         = 80
147:             .Left        =  542
148:             .Width       = THIS.Width
149:             .Height      = 90
150:             .BackStyle   = 0
151:             .BorderWidth = 0
152:         ENDWITH

*-- Linhas 162 a 171:
162:         THIS.AddObject("cnt_4c_Resultado", "Container")
163:         loc_oCnt = THIS.cnt_4c_Resultado
164:         WITH loc_oCnt
165:             .Top         = 170
166:             .Left        = 490
167:             .Width       = 297
168:             .Height      = 183
169:             .BackStyle   = 1
170:             .BackColor   = RGB(255, 255, 255)
171:             .SpecialEffect = 0

*-- Linhas 190 a 198:
190:                 THIS.cnt_4c_Resultado.txt_4c_Arquivo.Refresh
191:                 loc_nLargura = INT((par_nPct * 275) / 100)
192:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.shp_4c_Barra.Width = loc_nLargura
193:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.lbl_4c_Porcento.Caption = ;
194:                     ALLTRIM(TRANSFORM(par_nPct)) + " %"
195:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.Refresh
196:             ENDIF
197:         CATCH TO loc_oErro
198:             *-- progresso nao e critico, pular silenciosamente

*-- Linhas 260 a 385:
260:     *--------------------------------------------------------------------------
261:     * ConfigurarPaginaLista
262:     * Configura o corpo principal do form OPERACIONAL: botoes de acao, grid
263:     * de pares de contas, checkboxes e internos do painel de progresso.
264:     *--------------------------------------------------------------------------
265:     PROTECTED PROCEDURE ConfigurarPaginaLista()
266:         THIS.ConfigurarBotoesAcao()
267:         THIS.ConfigurarGrid()
268:         THIS.ConfigurarCheckboxes()
269:         THIS.ConfigurarResultadoInternos()
270:         THIS.VincularEventos()
271:     ENDPROC
272: 
273:     *--------------------------------------------------------------------------
274:     * ConfigurarBotoesAcao
275:     * Adiciona os botoes de acao ao container cnt_4c_Botoes.
276:     *--------------------------------------------------------------------------
277:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
278:         LOCAL loc_oCnt
279:         loc_oCnt = THIS.cnt_4c_Botoes
280: 
281:         loc_oCnt.AddObject("cmd_4c_BtnIncluir", "CommandButton")
282:         WITH loc_oCnt.cmd_4c_BtnIncluir
283:             .Top             = 7
284:             .Left            = 425
285:             .Width           = 75
286:             .Height          = 75
287:             .Caption         = "\<Incluir"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
289:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
290:             .FontName        = "Comic Sans MS"
291:             .FontBold        = .T.
292:             .FontItalic      = .T.
293:             .FontSize        = 8
294:             .ForeColor       = RGB(90, 90, 90)
295:             .BackColor       = RGB(255, 255, 255)
296:             .Themes          = .T.
297:             .SpecialEffect   = 0
298:             .PicturePosition = 13
299:             .WordWrap        = .T.
300:             .MousePointer    = 15
301:         ENDWITH
302: 
303:         loc_oCnt.AddObject("cmd_4c_BtnExcluir", "CommandButton")
304:         WITH loc_oCnt.cmd_4c_BtnExcluir
305:             .Top             = 7
306:             .Left            = 500
307:             .Width           = 75
308:             .Height          = 75
309:             .Caption         = "\<Excluir"
310:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
311:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
312:             .FontName        = "Comic Sans MS"
313:             .FontBold        = .T.
314:             .FontItalic      = .T.
315:             .FontSize        = 8
316:             .ForeColor       = RGB(90, 90, 90)
317:             .BackColor       = RGB(255, 255, 255)
318:             .Themes          = .T.
319:             .SpecialEffect   = 0
320:             .PicturePosition = 13
321:             .WordWrap        = .T.
322:             .MousePointer    = 15
323:         ENDWITH
324: 
325:         loc_oCnt.AddObject("cmd_4c_Exporta", "CommandButton")
326:         WITH loc_oCnt.cmd_4c_Exporta
327:             .Top             = 7
328:             .Left            = 575
329:             .Width           = 75
330:             .Height          = 75
331:             .Caption         = "I\<mportar"
332:             .Picture         = gc_4c_CaminhoIcones + "geral_multiplos_60.jpg"
333:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_multiplos_60.jpg"
334:             .FontName        = "Comic Sans MS"
335:             .FontBold        = .T.
336:             .FontItalic      = .T.
337:             .FontSize        = 8
338:             .ForeColor       = RGB(90, 90, 90)
339:             .BackColor       = RGB(255, 255, 255)
340:             .Themes          = .T.
341:             .SpecialEffect   = 0
342:             .PicturePosition = 13
343:             .WordWrap        = .T.
344:             .MousePointer    = 15
345:         ENDWITH
346: 
347:         loc_oCnt.AddObject("cmd_4c_BtnProcessar", "CommandButton")
348:         WITH loc_oCnt.cmd_4c_BtnProcessar
349:             .Top             = 7
350:             .Left            = 650
351:             .Width           = 75
352:             .Height          = 75
353:             .Caption         = "\<Processar"
354:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
355:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
356:             .FontName        = "Comic Sans MS"
357:             .FontBold        = .T.
358:             .FontItalic      = .T.
359:             .FontSize        = 8
360:             .ForeColor       = RGB(90, 90, 90)
361:             .BackColor       = RGB(255, 255, 255)
362:             .Themes          = .T.
363:             .SpecialEffect   = 0
364:             .PicturePosition = 13
365:             .WordWrap        = .T.
366:             .MousePointer    = 15
367:         ENDWITH
368: 
369:         loc_oCnt.AddObject("cmd_4c_BtnSair", "CommandButton")
370:         WITH loc_oCnt.cmd_4c_BtnSair
371:             .Top             = 7
372:             .Left            = 915
373:             .Width           = 75
374:             .Height          = 75
375:             .Caption         = "Encerrar"
376:             .Cancel          = .T.
377:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
378:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
379:             .FontName        = "Comic Sans MS"
380:             .FontBold        = .T.
381:             .FontItalic      = .T.
382:             .FontSize        = 8
383:             .ForeColor       = RGB(90, 90, 90)
384:             .BackColor       = RGB(255, 255, 255)
385:             .Themes          = .T.

*-- Linhas 400 a 409:
400:         THIS.AddObject("grd_4c_Dados", "Grid")
401:         loc_oGrid = THIS.grd_4c_Dados
402:         WITH loc_oGrid
403:             .Top               = 170
404:             .Left              = 12
405:             .Width             = 460
406:             .Height            = 400
407:             .AllowHeaderSizing = .F.
408:             .AllowRowSizing    = .F.
409:             .DeleteMark        = .F.

*-- Linhas 427 a 472:
427:         loc_oGrid.Column2.Width         = 220
428:         loc_oGrid.Column2.Sparse        = .F.
429:         *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
430:         loc_oGrid.Column1.Header1.Caption   = "Conta Antiga"
431:         loc_oGrid.Column1.Header1.Alignment = 2
432:         loc_oGrid.Column1.Header1.FontName  = "Tahoma"
433:         loc_oGrid.Column1.Header1.FontSize  = 8
434:         loc_oGrid.Column1.Header1.ForeColor = RGB(0, 0, 0)
435:         loc_oGrid.Column2.Header1.Caption   = "Conta Nova"
436:         loc_oGrid.Column2.Header1.Alignment = 2
437:         loc_oGrid.Column2.Header1.FontName  = "Tahoma"
438:         loc_oGrid.Column2.Header1.FontSize  = 8
439:         loc_oGrid.Column2.Header1.ForeColor = RGB(0, 0, 0)
440:     ENDPROC
441: 
442:     *--------------------------------------------------------------------------
443:     * ConfigurarCheckboxes
444:     * Adiciona checkboxes de controle ao form.
445:     *--------------------------------------------------------------------------
446:     PROTECTED PROCEDURE ConfigurarCheckboxes()
447:         THIS.AddObject("chk_4c_ChkReps", "CheckBox")
448:         WITH THIS.chk_4c_ChkReps
449:             .Top       = 297
450:             .Left      = 393
451:             .Height    = 20
452:             .Width     = 240
453:             .Caption   = "Trocar Apenas Representantes"
454:             .Value     = 0
455:             .AutoSize  = .F.
456:             .BackStyle = 0
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .ForeColor = RGB(90, 90, 90)
460:         ENDWITH
461:         THIS.AddObject("chk_4c_Chk_DelCT", "CheckBox")
462:         WITH THIS.chk_4c_Chk_DelCT
463:             .Top       = 278
464:             .Left      = 393
465:             .Height    = 20
466:             .Width     = 260
467:             .Caption   = "Apagar a Conta Antiga do Cadastro"
468:             .Value     = 0
469:             .AutoSize  = .F.
470:             .BackStyle = 0
471:             .FontName  = "Tahoma"
472:             .FontSize  = 8

*-- Linhas 483 a 506:
483:         LOCAL loc_oCnt
484:         loc_oCnt = THIS.cnt_4c_Resultado
485: 
486:         loc_oCnt.AddObject("lbl_4c_Label5", "Label")
487:         WITH loc_oCnt.lbl_4c_Label5
488:             .Caption   = "Arquivo/Campo :"
489:             .Left      = 7
490:             .Top       = 9
491:             .AutoSize  = .T.
492:             .BackStyle = 0
493:             .FontName  = "Tahoma"
494:             .FontSize  = 8
495:             .ForeColor = RGB(0, 0, 0)
496:         ENDWITH
497: 
498:         loc_oCnt.AddObject("txt_4c_Arquivo", "TextBox")
499:         WITH loc_oCnt.txt_4c_Arquivo
500:             .Top               = 26
501:             .Left              = 7
502:             .Width             = 278
503:             .Height            = 24
504:             .Enabled           = .F.
505:             .Value             = ""
506:             .Alignment         = 3

*-- Linhas 512 a 558:
512:             .FontSize          = 8
513:         ENDWITH
514: 
515:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
516:         WITH loc_oCnt.lbl_4c_Label1
517:             .Caption   = "Progresso :"
518:             .Left      = 7
519:             .Top       = 100
520:             .AutoSize  = .T.
521:             .BackStyle = 0
522:             .FontName  = "Tahoma"
523:             .FontSize  = 8
524:             .ForeColor = RGB(0, 0, 0)
525:         ENDWITH
526: 
527:         loc_oCnt.AddObject("cnt_4c_Barra", "Container")
528:         WITH loc_oCnt.cnt_4c_Barra
529:             .Top         = 116
530:             .Left        = 5
531:             .Width       = 280
532:             .Height      = 21
533:             .BorderWidth = 1
534:             .BackStyle   = 1
535:             .BackColor   = RGB(200, 200, 200)
536:             .Visible     = .T.
537:         ENDWITH
538: 
539:         loc_oCnt.cnt_4c_Barra.AddObject("shp_4c_Barra", "Shape")
540:         WITH loc_oCnt.cnt_4c_Barra.shp_4c_Barra
541:             .Top         = 1
542:             .Left        = 1
543:             .Height      = 19
544:             .Width       = 0
545:             .BackColor   = RGB(0, 128, 255)
546:             .BorderColor = RGB(100, 100, 100)
547:         ENDWITH
548: 
549:         loc_oCnt.cnt_4c_Barra.AddObject("lbl_4c_Porcento", "Label")
550:         WITH loc_oCnt.cnt_4c_Barra.lbl_4c_Porcento
551:             .Caption   = "0 %"
552:             .Left      = 120
553:             .Top       = 4
554:             .AutoSize  = .T.
555:             .BackStyle = 0
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8
558:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 564 a 573:
564:     * NAO APLICAVEL para este form OPERACIONAL de layout plano (sem PageFrame).
565:     * Todos os controles de dados foram criados em ConfigurarPaginaLista():
566:     *   grd_4c_Dados      - grade de pares ContaAnt/ContaNov
567:     *   chk_4c_ChkReps    - checkbox "Trocar Apenas Representantes"
568:     *   chk_4c_Chk_DelCT  - checkbox "Apagar a Conta Antiga do Cadastro"
569:     *   cnt_4c_Resultado  - painel de progresso (flutuante)
570:     * Metodo mantido para compatibilidade com o template multi-fase.
571:     *--------------------------------------------------------------------------
572:     PROTECTED PROCEDURE ConfigurarPaginaDados()
573:         *-- Form OPERACIONAL plano: nao ha Page2 separada de edicao de dados.

*-- Linhas 582 a 594:
582:     PROTECTED PROCEDURE VincularEventos()
583:         LOCAL loc_oCnt
584:         loc_oCnt = THIS.cnt_4c_Botoes
585:         BINDEVENT(loc_oCnt.cmd_4c_BtnIncluir,  "Click", THIS, "CmdIncluirClick")
586:         BINDEVENT(loc_oCnt.cmd_4c_BtnExcluir,  "Click", THIS, "CmdExcluirClick")
587:         BINDEVENT(loc_oCnt.cmd_4c_Exporta,     "Click", THIS, "CmdExportaClick")
588:         BINDEVENT(loc_oCnt.cmd_4c_BtnProcessar,"Click", THIS, "CmdProcessarClick")
589:         BINDEVENT(loc_oCnt.cmd_4c_BtnSair,     "Click", THIS, "CmdSairClick")
590:         BINDEVENT(THIS.chk_4c_ChkReps, "Click", THIS, "ChkRepsClick")
591:         BINDEVENT(THIS.grd_4c_Dados, "KeyPress",          THIS, "GrdDadosKeyPress")
592:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
593:     ENDPROC
594: 

*-- Linhas 677 a 685:
677:             *-- Confirmar com usuario
678:             IF NOT MsgConfirma("Confirma a Troca das Contas ?", ;
679:                 "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
680:                 THIS.cnt_4c_Botoes.cmd_4c_BtnSair.SetFocus()
681:                 RETURN
682:             ENDIF
683: 
684:             loc_lTrocarReps        = (THIS.chk_4c_ChkReps.Value   = 1)
685:             loc_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)

*-- Linhas 691 a 699:
691:                 *-- Processamento completo via catalogo ArqDBF
692:                 THIS.cnt_4c_Resultado.Visible = .T.
693:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.shp_4c_Barra.Width   = 0
694:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.lbl_4c_Porcento.Caption = "0 %"
695:                 THIS.cnt_4c_Resultado.Refresh()
696:                 loc_lSucesso = THIS.this_oBusinessObject.ProcessarMudancaContas( ;
697:                     loc_lApagarContaAntiga, THIS)
698:                 THIS.cnt_4c_Resultado.Visible = .F.
699:                 THIS.Refresh()

*-- Linhas 1057 a 1065:
1057:     *--------------------------------------------------------------------------
1058:     * FormParaBO
1059:     * Transfere estado dos controles do form para propriedades do BO.
1060:     * Para este OPERACIONAL: repassa flags dos checkboxes.
1061:     *--------------------------------------------------------------------------
1062:     PROCEDURE FormParaBO()
1063:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1064:             RETURN
1065:         ENDIF

*-- Linhas 1075 a 1083:
1075:     *--------------------------------------------------------------------------
1076:     * BOParaForm
1077:     * Carrega propriedades do BO nos controles do form.
1078:     * Para este OPERACIONAL: reflete flags de configuracao nos checkboxes.
1079:     *--------------------------------------------------------------------------
1080:     PROCEDURE BOParaForm()
1081:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1082:             RETURN
1083:         ENDIF

*-- Linhas 1099 a 1120:
1099:         loc_lAtivar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1100:         TRY
1101:             WITH THIS.cnt_4c_Botoes
1102:                 .cmd_4c_BtnIncluir.Enabled   = loc_lAtivar
1103:                 .cmd_4c_BtnExcluir.Enabled   = loc_lAtivar
1104:                 .cmd_4c_Exporta.Enabled      = loc_lAtivar
1105:                 .cmd_4c_BtnProcessar.Enabled = loc_lAtivar
1106:                 .Visible     = .T.
1107:             ENDWITH
1108:         CATCH TO loc_oErro
1109:             *-- ignorar erro de habilitacao
1110:         ENDTRY
1111:     ENDPROC
1112: 
1113:     *--------------------------------------------------------------------------
1114:     * LimparCampos
1115:     * Reinicia cursor_4c_Contas com um registro em branco e limpa checkboxes.
1116:     *--------------------------------------------------------------------------
1117:     PROCEDURE LimparCampos()
1118:         TRY
1119:             IF USED("cursor_4c_Contas")
1120:                 SELECT cursor_4c_Contas

*-- Linhas 1164 a 1173:
1164:                             NOT EMPTY(NVL(cursor_4c_Contas.ContaAnt, ""))
1165:         TRY
1166:             WITH THIS.cnt_4c_Botoes
1167:                 .cmd_4c_BtnExcluir.Enabled   = loc_lTemRegistros
1168:                 .cmd_4c_BtnProcessar.Enabled = loc_lTemRegistros
1169:                 .Visible     = .T.
1170:             ENDWITH
1171:         CATCH TO loc_oErro
1172:             *-- ignorar erro de ajuste
1173:         ENDTRY


### BO (C:\4c\projeto\app\classes\SigPrMdcBO.prg):
*==============================================================================
* Classe  : SigPrMdcBO
* Herda de: BusinessBase
* Descricao: BO para processamento de mudanca de conta (Muda Conta)
*            Valida pares ContaAnt/ContaNov, importa de XLS e aplica UPDATE
*            em multiplas tabelas do banco conforme catalogo ArqDBF.
*            Form OPERACIONAL - sem CRUD padrao, sem this_cTabela/CampoChave.
*==============================================================================
DEFINE CLASS SigPrMdcBO AS BusinessBase

    *-- Flags de configuracao do processamento
    this_lCheckCadPro       = .F.   && Validar codigo de conta contra SigCdCli
    this_lTrocarReps        = .F.   && Trocar apenas representantes (ContaVens em SigCdCli)
    this_lApagarContaAntiga = .F.   && Apagar conta antiga de SigCdCli apos troca

    *-- Estado do progresso (lido pelo Form para atualizar UI)
    this_cArquivoAtual      = ""    && Arquivo/campo em processamento
    this_nProgresso         = 0     && Progresso 0-100

    *-- Caminho completo do ArqDBF.DBF (sem extensao) - setado por ValidarArqDBF
    this_cArqDBFPath        = ""

    *-- Par corrente de contas (usado por CarregarDoCursor/Inserir/Atualizar)
    this_cContaAnt          = ""
    this_cContaNov          = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - override para auditoria operacional
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "MUDACONTA"
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursorContas
    * Cria cursor_4c_Contas com estrutura e registro inicial em branco.
    * Deve ser chamado por FormSigPrMdc.InicializarForm().
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarCursorContas()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Contas (ContaAnt C(10) NULL, ContaNov C(10) NULL)
            SET NULL OFF
            INDEX ON ContaAnt + ContaNov TAG Duplica
            INDEX ON ContaAnt            TAG ContaAnt
            INDEX ON ContaNov            TAG ContaNov
            SET ORDER TO
            INSERT INTO cursor_4c_Contas (ContaAnt, ContaNov) VALUES ('', '')
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarArqDBF
    * Verifica se ArqDBF.DBF existe no diretorio corrente do sistema.
    * Seta this_cArqDBFPath com caminho completo (sem extensao).
    * Returns: .T. se existe, .F. se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarArqDBF()
        LOCAL loc_lSucesso, loc_cCaminho
        loc_lSucesso = .F.
        loc_cCaminho = ""
        TRY
            loc_cCaminho = SYS(5) + SYS(2003) + "\ArqDBF"
            IF NOT FILE(loc_cCaminho + ".dbf")
                MsgAviso("O ArqDBF n" + CHR(227) + "o est" + CHR(225) + ;
                    " no diret" + CHR(243) + "rio do Sistema!!!", "Aviso")
            ELSE
                THIS.this_cArqDBFPath = loc_cCaminho
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * IncluirParConta
    * Adiciona linha em branco ao cursor_4c_Contas somente se a linha
    * corrente ja estiver preenchida (ContaAnt e ContaNov nao vazios).
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION IncluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            IF !EMPTY(cursor_4c_Contas.ContaAnt) .AND. !EMPTY(cursor_4c_Contas.ContaNov)
                APPEND BLANK
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirParConta
    * Marca o registro corrente de cursor_4c_Contas como excluido.
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ExcluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            DELETE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParesContas
    * Valida todos os pares em cursor_4c_Contas:
    *   - Nao pode estar vazio (ContaAnt ou ContaNov)
    *   - Nao pode ter ContaAnt = ContaNov
    * par_cMensagem: [BYREF] mensagem de erro se houver
    * Returns: .T. se todos validos, .F. se houver erro
    *--------------------------------------------------------------------------
    FUNCTION ValidarParesContas(par_cMensagem)
        LOCAL loc_lValido
        loc_lValido   = .F.
        par_cMensagem = ""
        TRY
            SELECT cursor_4c_Contas
            GO TOP
            IF EOF()
                par_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
            ELSE
                loc_lValido = .T.
                SCAN
                    IF EMPTY(cursor_4c_Contas.ContaAnt)
                        par_cMensagem = "Existe Uma Conta Antiga Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF EMPTY(cursor_4c_Contas.ContaNov)
                        par_cMensagem = "Existe Uma Conta Nova Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF cursor_4c_Contas.ContaAnt = cursor_4c_Contas.ContaNov
                        par_cMensagem = "Existe Uma Conta Antiga e Uma Conta Nova " + ;
                            "Com o Mesmo C" + CHR(243) + "digo!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCodigoConta
    * Verifica se um codigo de conta existe em SigCdCli.
    * par_cConta: codigo a validar
    * Returns: ALLTRIM(Iclis) se encontrado, "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_ValidCli") > 0
                    SELECT cursor_4c_ValidCli
                    loc_cResultado = ALLTRIM(cursor_4c_ValidCli.Iclis)
                ENDIF
                IF USED("cursor_4c_ValidCli")
                    USE IN cursor_4c_ValidCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValidCli")
                USE IN cursor_4c_ValidCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoConta
    * Retorna a Razao Social (Rclis) da conta em SigCdCli. String vazia se
    * conta nao existir. Usada por BtnVisualizarClick do Form.
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_DescCli") > 0
                    SELECT cursor_4c_DescCli
                    loc_cResultado = ALLTRIM(NVL(cursor_4c_DescCli.Rclis, ""))
                ENDIF
                IF USED("cursor_4c_DescCli")
                    USE IN cursor_4c_DescCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DescCli")
                USE IN cursor_4c_DescCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarDeXLS
    * Importa arquivo XLS e carrega pares em cursor_4c_Contas.
    * Valida ContaAnt contra SigCdCli (se this_lCheckCadPro = .F.).
    * Deduplica via TAG Duplica antes de inserir.
    * par_cArquivo: caminho completo do arquivo XLS (ja validado pela UI)
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ImportarDeXLS(par_cArquivo)
        LOCAL loc_lSucesso, loc_nTotal, loc_nCont
        LOCAL loc_cContaAnt, loc_cContaNov, loc_cSQL, loc_nRet
        loc_lSucesso  = .F.
        loc_nTotal    = 0
        loc_nCont     = 0
        loc_cContaAnt = ""
        loc_cContaNov = ""
        loc_cSQL      = ""
        loc_nRet      = 0
        TRY
            IF EMPTY(par_cArquivo)
                MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o informado!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT FILE(par_cArquivo)
                MsgAviso("O Arquivo [" + ALLTRIM(par_cArquivo) + "]" + CHR(13) + ;
                    "N" + CHR(227) + "o Foi Encontrado ou o Acesso " + ;
                    "Foi Negado!!! Verifique!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor temporario de importacao
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            CREATE CURSOR cursor_4c_Importa (ContaAnt C(10), ContaNov C(10))
            INDEX ON ContaAnt TAG Contas
            SET ORDER TO

            *-- Importar registros do XLS
            SELECT cursor_4c_Importa
            APPEND FROM (par_cArquivo) TYPE XLS

            loc_nTotal = RECCOUNT("cursor_4c_Importa")
            loc_nCont  = 0

            SELECT cursor_4c_Importa
            SCAN
                loc_nCont     = loc_nCont + 1
                loc_cContaAnt = cursor_4c_Importa.ContaAnt
                loc_cContaNov = cursor_4c_Importa.ContaNov

                IF EMPTY(loc_cContaAnt) OR EMPTY(loc_cContaNov)
                    LOOP
                ENDIF
                IF loc_cContaAnt = loc_cContaNov
                    LOOP
                ENDIF

                *-- Validar ContaAnt contra SigCdCli se nao em modo CheckCadPro
                IF NOT THIS.this_lCheckCadPro
                    loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                        EscaparSQL(ALLTRIM(loc_cContaAnt))
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp")
                    IF loc_nRet < 1 OR RECCOUNT("cursor_4c_CliImp") = 0
                        IF USED("cursor_4c_CliImp")
                            USE IN cursor_4c_CliImp
                        ENDIF
                        LOOP
                    ENDIF
                    IF USED("cursor_4c_CliImp")
                        USE IN cursor_4c_CliImp
                    ENDIF
                ENDIF

                *-- Inserir em cursor_4c_Contas somente se nao duplicado
                SELECT cursor_4c_Contas
                SET ORDER TO Duplica
                IF NOT SEEK(m.loc_cContaAnt + m.loc_cContaNov)
                    APPEND BLANK
                    REPLACE cursor_4c_Contas.ContaAnt WITH loc_cContaAnt, ;
                            cursor_4c_Contas.ContaNov WITH loc_cContaNov
                ENDIF

                *-- Restaurar para o cursor de importacao (proxima iteracao SCAN)
                SELECT cursor_4c_Importa
            ENDSCAN

            *-- Posicionar no final e limpar ordem
            SELECT cursor_4c_Contas
            SET ORDER TO
            GO BOTTOM

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            IF USED("cursor_4c_CliImp")
                USE IN cursor_4c_CliImp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * TrocarContaRepresentantes
    * Troca ContaVens em SigCdCli para todos os pares em cursor_4c_Contas.
    * Executa em transacao SQL Server (COMMIT em sucesso, ROLLBACK em falha).
    * Permite retry interativo em caso de falha (mesma logica do legado).
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION TrocarContaRepresentantes()
        LOCAL loc_lSucesso, loc_cUpdate, loc_nErro
        loc_lSucesso = .F.
        loc_nErro    = 1
        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            SELECT cursor_4c_Contas
            SCAN
                loc_cUpdate = "UPDATE SigCdCli SET ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov)) + ;
                    " WHERE ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))

                loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_TrocaRet")
                IF USED("cursor_4c_TrocaRet")
                    USE IN cursor_4c_TrocaRet
                ENDIF

                IF loc_nErro < 1
                    IF MsgConfirma("Falha ao Tentar Trocar a Conta '" + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + "'" + CHR(13) + ;
                        "Deseja Tentar Novamente?", "Aten" + CHR(231) + CHR(227) + "o!!!")
                        SELECT cursor_4c_Contas
                        SKIP -1
                        LOOP
                    ELSE
                        EXIT
                    ENDIF
                ENDIF
            ENDSCAN

            IF loc_nErro < 1
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA_REP: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + " -> " + ;
                        ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarMudancaContas
    * Processamento principal: itera sobre o catalogo ArqDBF.DBF e aplica
    * UPDATE (ou DELETE para SIGMVSLC/SIGMVEST) em todos os campos de todas
    * as tabelas que referenciam os codigos de conta em cursor_4c_Contas.
    *
    * Casos especiais:
    *   SIGMVCCR/CONTAS   -> atualiza GruConMoes + chama fRecalculaS
    *   SIGCDCLI/ICLIS    -> verifica se ContaNov existe; deleta ContaAnt se par_lApagarContaAntiga
    *   SIGMVHST/ESTOS    -> atualiza EmpGruEsts + chama fRecalculaP + fRecalculaC
    *   SIGCDCLH/ICLIS    -> atualiza GruContas
    *   SIGMVSLC/SIGMVEST -> DELETE (nao UPDATE)
    *
    * par_lApagarContaAntiga: apagar ContaAnt de SigCdCli apos troca
    * par_oForm: referencia ao Form para atualizacao de progresso (opcional)
    *            O Form deve ter PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION ProcessarMudancaContas(par_lApagarContaAntiga, par_oForm)
        LOCAL loc_lSucesso, loc_nErro, loc_nRec, loc_nCnt
        LOCAL loc_cArq, loc_cCpo, loc_cUpdate, loc_cDelete, loc_cWhere
        LOCAL loc_cContaNovSalvo, loc_lContaNovExiste, loc_nChkRet, loc_cChkSQL
        loc_lSucesso        = .F.
        loc_nErro           = 1
        loc_nRec            = 0
        loc_nCnt            = 0
        loc_cArq            = ""
        loc_cCpo            = ""
        loc_cUpdate         = ""
        loc_cDelete         = ""
        loc_cWhere          = ""
        loc_cContaNovSalvo  = ""
        loc_lContaNovExiste = .F.
        loc_nChkRet         = 0
        loc_cChkSQL         = ""
        TRY
            IF NOT THIS.ValidarArqDBF()
                loc_lSucesso = .F.
            ENDIF

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            *-- Fechar cursores anteriores se abertos
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

            *-- Consultar catalogo ArqDBF (SELECT VFP local sobre DBF)
            SELECT Arquivos, Campos ;
            FROM (THIS.this_cArqDBFPath) ;
            WHERE (Tamanhos = 10 OR UPPER(Campos) = 'CLIFORS') AND ;
                  UPPER(Tipos) = 'C' AND ;
                  NOT EMPTY(Dbcs) AND ;
                  Arquivos # 'ArqDBF.DBF' AND ;
                  UPPER(Arquivos) # 'SIGTEMPC.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCEE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGALERT.DBF' AND ;
                  INLIST(UPPER(SUBS(Arquivos, 1, 3)), 'SIG') AND ;
                  (AT('CON',    UPPER(Campos)) # 0 OR ;
                   AT('IFOR',   UPPER(Campos)) # 0 OR ;
                   AT('ESTOS',  UPPER(Campos)) # 0 OR ;
                   AT('CLI',    UPPER(Campos)) # 0 OR ;
                   AT('VEN',    UPPER(Campos)) # 0 OR ;
                   AT('RESP',   UPPER(Campos)) # 0) AND ;
                  AT('USU',     UPPER(Campos)) = 0 AND ;
                  AT('GR',      UPPER(Campos)) = 0 AND ;
                  AT('NCONTAS', UPPER(Campos)) = 0 AND ;
                  AT('NRCONS',  UPPER(Campos)) = 0 AND ;
                  AT('CCUSTOS', UPPER(Campos)) = 0 ;
            ORDER BY Arquivos ;
            INTO CURSOR csCampos READWRITE
            INDEX ON Arquivos + Campos TAG ArqCpo

            SELECT DISTINCT Arquivos ;
            FROM csCampos ;
            ORDER BY Arquivos ;
            INTO CURSOR csArquivos READWRITE

            loc_nCnt               = RECCOUNT("csArquivos")
            THIS.this_nProgresso   = 0
            THIS.this_cArquivoAtual = ""

            *-- SCAN externo: cada arquivo do catalogo
            SELECT csArquivos
            SCAN
                loc_cArq = ALLTRIM(STRTRAN(csArquivos.Arquivos, '.DBF', ''))
                THIS.this_cArquivoAtual = loc_cArq
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(loc_cArq, THIS.this_nProgresso)
                ENDIF

                *-- SCAN medio: cada campo deste arquivo
                SELECT csCampos
                SEEK csArquivos.Arquivos
                SCAN WHILE csArquivos.Arquivos = csCampos.Arquivos .AND. !EOF()
                    loc_cCpo = ALLTRIM(csCampos.Campos)
                    THIS.this_cArquivoAtual = loc_cArq + ' / ' + loc_cCpo
                    IF VARTYPE(par_oForm) = "O"
                        par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                    ENDIF

                    *-- SCAN interno: cada par de contas
                    SELECT cursor_4c_Contas
                    SCAN
                        *-- Caso especial: SIGMVCCR/CONTAS -> recalcular saldo antes de UPDATE
                        IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                            loc_cWhere = "SELECT DISTINCT Emps, Grupos, Contas, Moedas " + ;
                                "FROM SigMvCcr WHERE " + loc_cCpo + " = '" + ;
                                PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                            SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_Mccr")
                            IF USED("cursor_4c_Mccr") AND RECCOUNT("cursor_4c_Mccr") > 0
                                loc_cContaNovSalvo = cursor_4c_Contas.ContaNov
                                SELECT cursor_4c_Mccr
                                SCAN
                                    TRY
                                        =fRecalculaS(cursor_4c_Mccr.Grupos, ;
                                            m.loc_cContaNovSalvo, ;
                                            CTOD('01/01/1900'), ;
                                            cursor_4c_Mccr.Moedas, ;
                                            gnConnHandle)
                                    CATCH TO loc_oErroF
                                        *-- fRecalculaS nao portada - pular recalculo
                                    ENDTRY
                                ENDSCAN
                                IF USED("cursor_4c_Mccr")
                                    USE IN cursor_4c_Mccr
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Caso especial: SIGCDCLI/ICLIS
                        *-- Verifica se ContaNov ja existe; se sim, deleta ContaAnt e pula UPDATE
                        IF loc_cArq == 'SIGCDCLI' AND loc_cCpo = 'ICLIS'
                            loc_cChkSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli " + ;
                                "WHERE Iclis = " + EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov))
                            loc_nChkRet = SQLEXEC(gnConnHandle, loc_cChkSQL, "cursor_4c_ChkCli")
                            loc_lContaNovExiste = .F.
                            IF loc_nChkRet >= 1 AND RECCOUNT("cursor_4c_ChkCli") > 0
                                SELECT cursor_4c_ChkCli
                                loc_lContaNovExiste = (NVL(cursor_4c_ChkCli.nExiste, 0) > 0)
                            ENDIF
                            IF USED("cursor_4c_ChkCli")
                                USE IN cursor_4c_ChkCli
                            ENDIF

                            IF loc_lContaNovExiste
                                *-- ContaNov ja existe: deletar ContaAnt se solicitado
                                IF par_lApagarContaAntiga
                                    loc_cDelete = "DELETE FROM SigCdCli WHERE Iclis = " + ;
                                        EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))
                                    SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelCli")
                                    IF USED("cursor_4c_DelCli")
                                        USE IN cursor_4c_DelCli
                                    ENDIF
                                ENDIF
                                SELECT cursor_4c_Contas
                                LOOP
                            ENDIF
                            *-- ContaNov nao existe: cai no UPDATE padrao abaixo (UPDATE ICLIS)
                        ENDIF

                        *-- Caso especial: SIGMVSLC ou SIGMVEST -> DELETE em vez de UPDATE
                        IF loc_cArq == 'SIGMVSLC' OR loc_cArq == 'SIGMVEST'
                            loc_cDelete = "DELETE FROM " + loc_cArq + ;
                                " WHERE " + loc_cCpo + " = '" + ;
                                cursor_4c_Contas.ContaAnt + "'"
                            loc_nErro = SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelRet")
                            IF USED("cursor_4c_DelRet")
                                USE IN cursor_4c_DelRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ELSE
                            *-- UPDATE padrao (casos gerais e casos especiais com campos extras)
                            IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                                loc_cUpdate = "UPDATE " + loc_cArq + ;
                                    " SET " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "', GruConMoes = Grupos + '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "' + Moedas WHERE " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaAnt + "'"
                            ELSE
                                IF loc_cArq == 'SIGMVHST' AND loc_cCpo = 'ESTOS'
                                    *-- Recalcular historico antes de UPDATE
                                    loc_cWhere = "SELECT DISTINCT Emps, Grupos, Estos, " + ;
                                        "Cpros, CodCors, CodTams FROM SigMvHst WHERE " + ;
                                        loc_cCpo + " = '" + ;
                                        PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                                    SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_His")
                                    IF USED("cursor_4c_His") AND RECCOUNT("cursor_4c_His") > 0
                                        loc_cContaNovSalvo = cursor_4c_Contas.ContaNov
                                        SELECT cursor_4c_His
                                        SCAN
                                            TRY
                                                =fRecalculaP(cursor_4c_His.Emps, ;
                                                    cursor_4c_His.Grupos, ;
                                                    m.loc_cContaNovSalvo, ;
                                                    cursor_4c_His.Cpros, ;
                                                    CTOD('01/01/1900'), ;
                                                    cursor_4c_His.CodCors, ;
                                                    cursor_4c_His.CodTams, ;
                                                    gnConnHandle)
                                                =fRecalculaC(cursor_4c_His.Emps, ;
                                                    cursor_4c_His.Cpros, ;
                                                    CTOD('01/01/1900'), ;
                                                    gnConnHandle)
                                            CATCH TO loc_oErroF
                                                *-- fRecalculaP/C nao portadas - pular recalculo
                                            ENDTRY
                                        ENDSCAN
                                        IF USED("cursor_4c_His")
                                            USE IN cursor_4c_His
                                        ENDIF
                                    ENDIF
                                    loc_cUpdate = "UPDATE " + loc_cArq + ;
                                        " SET " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "', EmpGruEsts = Emps + Grupos + '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "' WHERE " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaAnt + "'"
                                ELSE
                                    IF loc_cArq == 'SIGCDCLH' AND loc_cCpo = 'ICLIS'
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "', GruContas = Grupos + '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ELSE
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ENDIF
                                ENDIF
                            ENDIF

                            loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_UpdRet")
                            IF USED("cursor_4c_UpdRet")
                                USE IN cursor_4c_UpdRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN  && cursor_4c_Contas

                    IF loc_nErro < 1
                        EXIT
                    ENDIF
                ENDSCAN  && csCampos WHILE

                IF loc_nErro < 1
                    EXIT
                ENDIF

                *-- Atualizar progresso
                SELECT csArquivos
                loc_nRec             = loc_nRec + 1
                THIS.this_nProgresso  = INT((loc_nRec * 100) / IIF(loc_nCnt > 0, loc_nCnt, 1))
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                ENDIF
            ENDSCAN  && csArquivos

            *-- Recalculos finais (funcoes legado - pular se nao portadas)
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaS(.T., gnConnHandle, .T.)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaS nao portada - ignorar
                ENDTRY
            ENDIF
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaP(.T., gnConnHandle)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaP nao portada - ignorar
                ENDTRY
            ENDIF
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaC(.T., .F., .F., gnConnHandle)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaC nao portada - ignorar
                ENDTRY
            ENDIF

            *-- Commit ou Rollback
            IF loc_nErro < 1
                MsgAviso("Favor reinicializar o processo.", ;
                    "Falha na Conex" + CHR(227) + "o")
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria de todas as trocas realizadas
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + ;
                        IIF(par_lApagarContaAntiga, ;
                            " (Exclu" + CHR(237) + "da)", "") + ;
                        " -> " + ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF

            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Processamento")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor
    * Carrega o par (ContaAnt, ContaNov) do registro corrente de um cursor
    * (tipicamente cursor_4c_Contas) para as propriedades da instancia.
    * Usado antes de operacoes de auditoria/edicao individual do par.
    * par_cAliasCursor: nome do cursor (default "cursor_4c_Contas")
    * Returns: .T. em sucesso, .F. se cursor nao existe ou EOF
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Contas", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                IF NOT EOF() AND NOT BOF()
                    THIS.this_cContaAnt = NVL(EVALUATE(loc_cAlias + ".ContaAnt"), "")
                    THIS.this_cContaNov = NVL(EVALUATE(loc_cAlias + ".ContaNov"), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir
    * Insere o par (this_cContaAnt, this_cContaNov) em cursor_4c_Contas apos
    * validar duplicidade via TAG Duplica e igualdade de codigos.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            IF NOT USED("cursor_4c_Contas")
                THIS.InicializarCursorContas()
            ENDIF

            SELECT cursor_4c_Contas
            SET ORDER TO Duplica
            IF SEEK(THIS.this_cContaAnt + THIS.this_cContaNov)
                SET ORDER TO
                MsgAviso("Par de Contas j" + CHR(225) + " existe na lista.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            SET ORDER TO

            APPEND BLANK
            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("INCLUSAO_PAR: " + ;
                ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov))

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Incluir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar
    * Atualiza o registro corrente de cursor_4c_Contas com
    * (this_cContaAnt, this_cContaNov) apos validar duplicidade e igualdade.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido, EOF ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cAntigoAnt, loc_cAntigoNov
        loc_lSucesso  = .F.
        loc_cAntigoAnt = ""
        loc_cAntigoNov = ""
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT USED("cursor_4c_Contas")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Contas
            IF EOF() OR BOF()
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            loc_cAntigoAnt = cursor_4c_Contas.ContaAnt
            loc_cAntigoNov = cursor_4c_Contas.ContaNov

            *-- Se par nao mudou, nada a fazer
            IF loc_cAntigoAnt == THIS.this_cContaAnt AND ;
               loc_cAntigoNov == THIS.this_cContaNov
                loc_lSucesso = .T.
            ENDIF

            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("ALTERACAO_PAR: (" + ;
                ALLTRIM(loc_cAntigoAnt) + " -> " + ALLTRIM(loc_cAntigoNov) + ;
                ") para (" + ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov) + ")")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

