# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 338: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 359: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 380: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 401: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigredco.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (723 linhas total):

*-- Linhas 5 a 26:
5: * Migrado de: SIGREDCO.SCX (frmrelatorio)
6: *
7: * Form modal pequeno (798x128) chamado por Formsigredcu com parametros.
8: * Exibe 2 checkboxes (NF/Incentivos) e 4 botoes (Visualizar/Imprimir/Excel/Sair).
9: * Seleciona FRX correto (SigReDco3/4/5/6) conforme empresa e opcoes.
10: *
11: * FASE 8/8 - IMPLEMENTACAO COMPLETA
12: * Estrutura: SIGREDCO e um dialogo de impressao simples (798x128px) sem
13: * TextBoxes, labels de dados nem campos com lookup (F4/F5). Todos os
14: * componentes originais foram migrados:
15: *   - Init com LPARAMETERS (qbols/Pcnx/cEmail/pEmp/pDop/pNum/pImpress/pForm/pChkImpDoc)
16: *   - InicializarForm: cria BO, CarregarLocalEmp, CarregarParametrosOperacao
17: *   - ConfigurarCabecalho: container escuro com titulo
18: *   - ConfigurarBotoesRelatorio: CommandGroup 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
19: *   - ConfigurarCheckboxes: chk_4c_ChkNf + chk_4c_ChkIcentivo com confirmacao
20: *   - ConfigurarPaginaLista: estado inicial dos checkboxes por parametro
21: *   - ConfigurarPaginaDados: oculta checkboxes (DigItens 6/7) ou renomeia (P&G)
22: *   - FormParaRelatorio, ChkNfClick, ChkIncentivoClick
23: *   - BtnVisualizarClick, BtnImprimirClick, BtnDocExcelClick, BtnSairClick
24: *   - AlternarPagina, Destroy
25: *
26: * INTEGRACAO: config.prg carrega automaticamente via ADIR (sem alteracao manual).

*-- Linhas 89 a 97:
89:         ENDIF
90: 
91:         *-- Caption dinamico: "Impressao de Documento (DOP/NUM)"
92:         THIS.Caption = "Impress" + CHR(227) + "o de Documento (" + ;
93:             ALLTRIM(THIS.this_cDopes) + "/" + ALLTRIM(STR(THIS.this_nNumes)) + ")"
94: 
95:         loc_lSucesso = DODEFAULT()
96: 
97:         *-- TpImpressao 3 ou 4: imprimir direto e nao exibir o form

*-- Linhas 177 a 200:
177:     *
178:     * Form REPORT (frmrelatorio): layout FLAT sem PageFrame CRUD.
179:     * Cabecalho escuro + CommandGroup de botoes de acao (direita) +
180:     * checkboxes de opcoes de impressao (abaixo do cabecalho).
181:     *--------------------------------------------------------------------------
182:     PROTECTED PROCEDURE ConfigurarPageFrame()
183:         THIS.ConfigurarCabecalho()
184:         THIS.ConfigurarBotoesRelatorio()
185:         THIS.ConfigurarCheckboxes()
186:         THIS.ConfigurarPaginaLista()
187:         THIS.ConfigurarPaginaDados()
188:     ENDPROC
189: 
190:     *--------------------------------------------------------------------------
191:     * ConfigurarPaginaLista - Configura estado inicial das opcoes de impressao
192:     *
193:     * Em forms REPORT (frmrelatorio) o layout e FLAT - nao ha Page1 de lista
194:     * nem Page2 de dados. Este metodo equivale a "configurar a lista de opcoes"
195:     * que o usuario tem para o relatorio: marca/desmarca os checkboxes de NF
196:     * e Incentivos conforme parametros recebidos do form chamador
197:     * (this_lChkImpDoc, this_nTpImpressao) e o tipo de empresa (DivNotas).
198:     *
199:     * Logica original (SIGREDCO.Init): se ChkImpDoc=.T. ou TpImpressao=1/3,
200:     * marca chkNf por default; Incentivos sempre comeca desmarcado.

*-- Linhas 213 a 221:
213:             THIS.chk_4c_ChkIcentivo.Value = 0
214:         ENDIF
215: 
216:         *-- Sincroniza estado inicial dos checkboxes para o BO
217:         IF VARTYPE(THIS.this_oRelatorio) = "O"
218:             THIS.this_oRelatorio.this_lImpNf   = loc_lMarcarNf
219:             THIS.this_oRelatorio.this_lImpIcen = .F.
220:         ENDIF
221:     ENDPROC

*-- Linhas 256 a 308:
256: 
257:     *--------------------------------------------------------------------------
258:     * ConfigurarCabecalho - Container escuro com titulo do form (cntSombra do legado)
259:     * Ocupa o topo do form (Height=85); botoes e checkboxes sao adicionados
260:     * sobre/abaixo em fases posteriores
261:     *--------------------------------------------------------------------------
262:     PROTECTED PROCEDURE ConfigurarCabecalho()
263:         LOCAL loc_oCab
264:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
265:         loc_oCab = THIS.cnt_4c_Cabecalho
266:         WITH loc_oCab
267:             .Top           = 0
268:             .Left          = 0
269:             .Width         = THIS.Width
270:             .Height        = 85
271:             .BackStyle     = 1
272:             .BackColor     = RGB(100, 100, 100)
273:             .BorderWidth   = 0
274:             .SpecialEffect = 0
275:             .Themes        = .F.
276: 
277:             .AddObject("lbl_4c_Sombra", "Label")
278:             WITH .lbl_4c_Sombra
279:                 .Top       = 15
280:                 .Left      = 10
281:                 .Width     = THIS.Width
282:                 .Height    = 40
283:                 .FontName  = "Tahoma"
284:                 .FontSize  = 12
285:                 .FontBold  = .T.
286:                 .ForeColor = RGB(0, 0, 0)
287:                 .BackStyle = 0
288:                 .Caption   = "Impress" + CHR(227) + "o de Documento"
289:                 .Visible   = .T.
290:             ENDWITH
291: 
292:             .AddObject("lbl_4c_Titulo", "Label")
293:             WITH .lbl_4c_Titulo
294:                 .Top       = 18
295:                 .Left      = 10
296:                 .Width     = THIS.Width
297:                 .Height    = 46
298:                 .FontName  = "Tahoma"
299:                 .FontSize  = 12
300:                 .FontBold  = .T.
301:                 .ForeColor = RGB(255, 255, 255)
302:                 .BackStyle = 0
303:                 .Caption   = "Impress" + CHR(227) + "o de Documento"
304:                 .Visible   = .T.
305:             ENDWITH
306: 
307:             .Visible = .T.
308:         ENDWITH

*-- Linhas 318 a 344:
318:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
319:         loc_oCmg = THIS.cmg_4c_Botoes
320:         WITH loc_oCmg
321:             .Top           = 0
322:             .Left          = 525
323:             .Width         = 273
324:             .Height        = 80
325:             .ButtonCount   = 4
326:             .BackStyle     = 0
327:             .BorderStyle   = 0
328:             .BorderColor   = RGB(136, 189, 188)
329:             .SpecialEffect = 1
330:             .Themes        = .F.
331: 
332:             WITH .Buttons(1)
333:                 .Caption         = "Visualizar"
334:                 .Left            = 5
335:                 .Top             = 5
336:                 .Width           = 65
337:                 .Height          = 70
338:                 .FontName        = "Comic Sans MS"
339:                 .FontBold        = .T.
340:                 .FontItalic      = .T.
341:                 .FontSize        = 8
342:                 .BackColor       = RGB(255, 255, 255)
343:                 .ForeColor       = RGB(90, 90, 90)
344:                 .PicturePosition = 13

*-- Linhas 351 a 365:
351:             ENDWITH
352: 
353:             WITH .Buttons(2)
354:                 .Caption         = "Imprimir"
355:                 .Left            = 71
356:                 .Top             = 5
357:                 .Width           = 65
358:                 .Height          = 70
359:                 .FontName        = "Comic Sans MS"
360:                 .FontBold        = .T.
361:                 .FontItalic      = .T.
362:                 .FontSize        = 8
363:                 .BackColor       = RGB(255, 255, 255)
364:                 .ForeColor       = RGB(90, 90, 90)
365:                 .PicturePosition = 13

*-- Linhas 372 a 386:
372:             ENDWITH
373: 
374:             WITH .Buttons(3)
375:                 .Caption         = "DocExcel"
376:                 .Left            = 137
377:                 .Top             = 5
378:                 .Width           = 65
379:                 .Height          = 70
380:                 .FontName        = "Comic Sans MS"
381:                 .FontBold        = .T.
382:                 .FontItalic      = .T.
383:                 .FontSize        = 8
384:                 .BackColor       = RGB(255, 255, 255)
385:                 .ForeColor       = RGB(90, 90, 90)
386:                 .PicturePosition = 13

*-- Linhas 393 a 407:
393:             ENDWITH
394: 
395:             WITH .Buttons(4)
396:                 .Caption         = "Sair"
397:                 .Left            = 203
398:                 .Top             = 5
399:                 .Width           = 65
400:                 .Height          = 70
401:                 .FontName        = "Comic Sans MS"
402:                 .FontBold        = .T.
403:                 .FontItalic      = .T.
404:                 .FontSize        = 8
405:                 .BackColor       = RGB(255, 255, 255)
406:                 .ForeColor       = RGB(90, 90, 90)
407:                 .PicturePosition = 13

*-- Linhas 424 a 461:
424:     ENDPROC
425: 
426:     *--------------------------------------------------------------------------
427:     * ConfigurarCheckboxes - Opcoes de impressao (abaixo do cabecalho)
428:     * chkNf (top=87): Imprimir Totais de NF / Descritivo (P&G)
429:     * chkIcentivo (top=104): Imprimir Incentivos / Versao Completa
430:     *--------------------------------------------------------------------------
431:     PROTECTED PROCEDURE ConfigurarCheckboxes()
432:         THIS.AddObject("chk_4c_ChkNf", "CheckBox")
433:         WITH THIS.chk_4c_ChkNf
434:             .Top       = 87
435:             .Left      = 339
436:             .Width     = 170
437:             .Height    = 17
438:             .Caption   = "Imprimir Totais de NF"
439:             .Value     = 0
440:             .FontName  = "Tahoma"
441:             .FontSize  = 8
442:             .AutoSize  = .T.
443:             .Alignment = 0
444:             .BackStyle = 0
445:             .ForeColor = RGB(90, 90, 90)
446:             .Themes    = .F.
447:             .Visible   = .T.
448:         ENDWITH
449: 
450:         THIS.AddObject("chk_4c_ChkIcentivo", "CheckBox")
451:         WITH THIS.chk_4c_ChkIcentivo
452:             .Top       = 104
453:             .Left      = 339
454:             .Width     = 170
455:             .Height    = 17
456:             .Caption   = "Imprimir Incentivos"
457:             .Value     = 0
458:             .FontName  = "Tahoma"
459:             .FontSize  = 8
460:             .AutoSize  = .T.
461:             .Alignment = 0

*-- Linhas 470 a 478:
470:     ENDPROC
471: 
472:     *--------------------------------------------------------------------------
473:     * FormParaRelatorio - Sincroniza opcoes dos checkboxes para o BO
474:     *--------------------------------------------------------------------------
475:     PROTECTED PROCEDURE FormParaRelatorio()
476:         IF VARTYPE(THIS.this_oRelatorio) = "O"
477:             WITH THIS.this_oRelatorio
478:                 .this_lImpNf   = (THIS.chk_4c_ChkNf.Value       = 1)

*-- Linhas 564 a 597:
564:     * ConfigurarPaginaDados - Ajusta UI conforme dados carregados do BO
565:     *
566:     * Equivalente ao bloco pos-DoDefault do Init() original:
567:     *   - DigItens=6/7: oculta checkboxes (usa SigReDco6, opcoes nao se aplicam)
568:     *   - DivNotas=2 (P&G): renomeia captions e pre-calcula Finaliza em TmpRelat
569:     *--------------------------------------------------------------------------
570:     PROTECTED PROCEDURE ConfigurarPaginaDados()
571:         IF VARTYPE(THIS.this_oRelatorio) != "O"
572:             RETURN
573:         ENDIF
574: 
575:         *-- DigItens 6 ou 7: modo SigReDco6 - checkboxes nao tem sentido
576:         IF INLIST(THIS.this_oRelatorio.this_nDigItens, 6, 7)
577:             IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
578:                 THIS.chk_4c_ChkNf.Visible = .F.
579:             ENDIF
580:             IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
581:                 THIS.chk_4c_ChkIcentivo.Visible = .F.
582:             ENDIF
583:             RETURN
584:         ENDIF
585: 
586:         *-- DivNotas=2 (P&G): renomeia checkboxes conforme empresa
587:         IF THIS.this_oRelatorio.this_nDivNotas = 2
588:             IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
589:                 THIS.chk_4c_ChkNf.Caption = "Imprimir Descritivo"
590:             ENDIF
591:             IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
592:                 THIS.chk_4c_ChkIcentivo.Caption = "Impress" + CHR(227) + "o Completa"
593:             ENDIF
594: 
595:             *-- Pre-calcula margem/contingente em TmpRelat (requer cursors abertos pelo chamador)
596:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
597:                 THIS.this_oRelatorio.CalcularFinaliza()

*-- Linhas 615 a 624:
615:     ENDPROC
616: 
617:     *--------------------------------------------------------------------------
618:     * HabilitarCampos - Em REPORT: checkboxes seguem regra de ConfigurarPaginaDados
619:     * Quando DigItens=6/7 ou modo SigReDco6 ativo, checkboxes ficam ocultos.
620:     *--------------------------------------------------------------------------
621:     PROCEDURE HabilitarCampos(par_lHabilitar)
622:         LOCAL loc_lHab
623:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
624:         IF VARTYPE(THIS.chk_4c_ChkNf) = "O" AND THIS.chk_4c_ChkNf.Visible

*-- Linhas 631 a 639:
631:     ENDPROC
632: 
633:     *--------------------------------------------------------------------------
634:     * LimparCampos - Reseta checkboxes para o estado inicial
635:     *--------------------------------------------------------------------------
636:     PROCEDURE LimparCampos()
637:         IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
638:             THIS.chk_4c_ChkNf.Value = 0
639:         ENDIF

*-- Linhas 654 a 662:
654:     ENDPROC
655: 
656:     *--------------------------------------------------------------------------
657:     * BOParaForm - Sincroniza opcoes do BO de volta para os checkboxes
658:     *--------------------------------------------------------------------------
659:     PROTECTED PROCEDURE BOParaForm()
660:         IF VARTYPE(THIS.this_oRelatorio) = "O"
661:             IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
662:                 THIS.chk_4c_ChkNf.Value = IIF(THIS.this_oRelatorio.this_lImpNf, 1, 0)


### BO (C:\4c\projeto\app\classes\sigredcoBO.prg):
*==============================================================================
* SIGREDCOBO.PRG
* Business Object para Impressao de Documento de Ordem (SIGREDCO)
* Herda de RelatorioBase
*
* Responsabilidades:
* - Receber parametros do form chamador (empresa, operacao, numero)
* - Armazenar opcoes de impressao (NF, incentivos)
* - Preparar cursor TmpImpOrc com dados formatados para os FRXs
* - Selecionar e acionar o FRX correto conforme condicoes
*   (SigReDco3, SigReDco4, SigReDco5 ou SigReDco6)
*==============================================================================

DEFINE CLASS sigredcoBO AS RelatorioBase

    *-- Parametros recebidos do form chamador
    this_nQbols          = 0     && Quantidade de documentos/ordens a imprimir
    this_cEmps           = ""    && Codigo da empresa (pcEmps)
    this_cDopes          = ""    && Tipo de operacao (pcDopes)
    this_nNumes          = 0     && Numero do documento (pcNumes)
    this_nTpImpressao    = 0     && Tipo de impressao: 0=normal 2=prompt 3/4=direto
    this_lChkImpDoc      = .F.   && Flag impressao documento (pChkImpDoc)
    this_lChkImpDocAcess = .F.   && Flag impressao documento acesso (chkimpdocacess)
    this_cEmail          = ""    && Email para envio (Contaemail)
    this_cCaption        = ""    && Caption dinamico: "Impressao de Documento (DOP/NUM)"

    *-- Opcoes de impressao controladas pelos checkboxes do form
    this_lImpNf          = .F.   && Imprimir Totais de NF / Descritivo (chkNf)
    this_lImpIcen        = .F.   && Imprimir Incentivos / Versao Completa (chkIcentivo)

    *-- Dados da empresa e operacao (carregados no Init/PrepararDados)
    this_nDivNotas       = 0     && LocalEmp.DIVNOTAS: 1=SRCOM 2=P&G
    this_nDigItens       = 0     && crSigCdOpe.DigItens: 6 ou 7 = modo especial SigReDco6
    this_nCasQtds        = 0     && crSigOpCdd.CasQtds: casas decimais de quantidade
    this_nNcPesos        = 0     && crSigCdOpe.NCPesos: casas decimais de peso
    this_cMasQ           = ""    && Mascara formatada de quantidade (ex: "999999.99")
    this_cMasP           = ""    && Mascara formatada de peso/preco
    this_cFinaliza       = ""    && Texto de margem/contingente/lucro (apenas P&G)

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLocalEmp - Carrega DivNotas da empresa via SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLocalEmp()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("LocalEmp")
                SELECT LocalEmp
                THIS.this_nDivNotas = NVL(DivNotas, 0)
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor LocalEmp n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosOperacao - Le DigItens/CasQtds/NCPesos dos cursors abertos
    * e monta mascaras de formatacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosOperacao()
        TRY
            IF USED("crSigCdOpe")
                SELECT crSigCdOpe
                THIS.this_nDigItens = NVL(DigItens, 0)
                THIS.this_nNcPesos  = NVL(NCPesos,  0)
            ENDIF
            IF USED("crSigOpCdd")
                SELECT crSigOpCdd
                THIS.this_nCasQtds = NVL(CasQtds, 0)
            ENDIF
            THIS.this_cMasQ = "999999" + IIF(THIS.this_nCasQtds > 0, "." + REPL("9", THIS.this_nCasQtds), "")
            THIS.this_cMasP = "999999" + IIF(THIS.this_nNcPesos  > 0, "." + REPL("9", THIS.this_nNcPesos),  "")
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularFinaliza - Calcula texto de Margem/Contingente/Lucro (somente P&G)
    * Grava campo Finaliza em TmpRelat para uso no FRX SigReDco4
    * PUBLIC para permitir pre-calculo no InicializarForm (Init do legado)
    *--------------------------------------------------------------------------
    PROCEDURE CalcularFinaliza()
        TRY
            IF USED("crSigMvOrc") AND USED("TmpRelat") AND USED("TprMvCab")
                SELECT IIF(!EMPTY(Tota5s), ((Tota1s + Tota2s) / Tota5s) * 100, 0) AS PMargens ;
                    FROM crSigMvOrc ;
                    WHERE Cblocos = "TOTALGERAL" ;
                    INTO CURSOR TmpMargem
                IF !EOF("TmpMargem")
                    SELECT TmpMargem
                    REPLACE Finaliza WITH ;
                        "Margem : " + ALLTRIM(STR(TmpMargem.PMargens, 5, 2)) + ;
                        "% / Contingente : " + ALLTRIM(STR(TprMvCab.PTax2s, 5, 2)) + ;
                        "% / Lucro Liquido : " + ALLTRIM(STR(TprMvCab.Descs, 5, 2)) + ;
                        "% / BV Liquido : " + ALLTRIM(STR(TprMvCab.PTax1s, 5, 2)) + ;
                        "% / Custo de Nota Fiscal : " + ALLTRIM(STR(TprMvCab.Acres, 6, 4)) ;
                        IN TmpRelat
                ENDIF
                IF USED("TmpMargem")
                    USE IN TmpMargem
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNomeFRX - Retorna nome do FRX correto conforme condicoes do documento
    * SigReDco6: DigItens 6 ou 7 (modo especial)
    * SigReDco4: P&G (DIVNOTAS=2)
    * SigReDco3: SRCOM com NF ou Incentivos
    * SigReDco5: SRCOM padrao
    *--------------------------------------------------------------------------
    PROCEDURE ObterNomeFRX()
        LOCAL loc_cFRX
        IF INLIST(THIS.this_nDigItens, 6, 7)
            loc_cFRX = "SigReDco6"
        ELSE
            IF THIS.this_nDivNotas = 2
                loc_cFRX = "SigReDco4"
            ELSE
                IF THIS.this_lImpIcen OR THIS.this_lImpNf
                    loc_cFRX = "SigReDco3"
                ELSE
                    loc_cFRX = "SigReDco5"
                ENDIF
            ENDIF
        ENDIF
        RETURN loc_cFRX
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor TmpImpOrc a partir de crSigMvOrc
    * Equivalente ao procedimento 'processamento' do legado
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_cMasQ, loc_cMasP, loc_lImpNf, loc_lImpIcen, loc_nDigItens
        loc_lResultado = .F.
        TRY
            IF !USED("crSigMvOrc")
                THIS.this_cMensagemErro = "Cursor crSigMvOrc n" + CHR(227) + "o est" + CHR(225) + " aberto"
                loc_lResultado = .F.
            ENDIF

            THIS.CarregarParametrosOperacao()

            *-- Normaliza campos memo/nulos
            SELECT crSigMvOrc
            REPLACE ALL Dpro2s WITH NVL(Dpro2s, ""), Obs WITH NVL(Obs, "")
            GO TOP

            *-- Variaveis locais para uso no SELECT VFP (THIS.prop nao funciona em SQL VFP)
            loc_cMasQ    = THIS.this_cMasQ
            loc_cMasP    = THIS.this_cMasP
            loc_lImpNf   = THIS.this_lImpNf
            loc_lImpIcen = THIS.this_lImpIcen
            loc_nDigItens = THIS.this_nDigItens

            *-- Monta TmpImpOrc com colunas formatadas para os FRXs
            SELECT a.Citens, a.Citem2, a.Citem3, a.Cblocos, ;
                a.Dpros, a.Dpro2s, a.Obs, ;
                TRANSFORM(a.Qtds, loc_cMasQ) AS Qtds, ;
                a.Cunis, TRANSFORM(a.Pesos, loc_cMasP) AS Pesos, a.Cunips, ;
                TRANSFORM(a.Fators, loc_cMasP) AS Fators, ;
                a.Units, a.Totas, a.Tota1s, a.Tota2s, a.Tota3s, ;
                a.Tota4s, a.Tota5s, a.Tota6s, a.DAcabs, a.Dcunis, ;
                loc_lImpNf   AS ImpNfs, ;
                loc_lImpIcen AS ImpIcens, ;
                a.RGBS ;
            FROM crSigMvOrc a ;
            WHERE IIF(INLIST(loc_nDigItens, 6, 7), a.Visivels = 1, .T.) ;
            INTO CURSOR TmpImpOrc READWRITE ;
            ORDER BY a.Citens

            IF USED("TmpRelat")
                SELECT TmpRelat
                GO TOP
            ENDIF
            SELECT TmpImpOrc
            GO TOP

            *-- Calcula Finaliza (margem P&G) somente quando necessario
            IF THIS.this_nDivNotas = 2
                THIS.CalcularFinaliza()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Preview do relatorio (equivalente a 'visualizacao' do legado)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_cFRX, loc_nCnt
        loc_lResultado = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF
            loc_cFRX = THIS.ObterNomeFRX()
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            ENDFOR
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime o relatorio (equivalente a 'impressao' do legado)
    * TpImpressao 2 ou 4 = sem dialogo de impressora; outros = com PROMPT
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_cFRX, loc_nCnt, loc_lPrompt
        loc_lResultado = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF
            loc_cFRX   = THIS.ObterNomeFRX()
            loc_lPrompt = !INLIST(THIS.this_nTpImpressao, 2, 4)
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                IF loc_lPrompt
                    REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
                ENDIF
            ENDFOR
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDocumento - Impressao direta sem prompt nem loop de Qbols
    * Equivalente ao procedimento 'documento' do legado
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDocumento()
        LOCAL loc_lResultado, loc_cFRX
        loc_lResultado = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF
            loc_cFRX = THIS.ObterNomeFRX()
            REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor de origem
    * Para relatorios, mapeia parametros de operacao/empresa/casas decimais
    * a partir dos cursors abertos pelo form chamador (crSigCdOpe, crSigOpCdd,
    * cursor_4c_LocalEmp). Usado tambem pelo PrepararDados via
    * CarregarParametrosOperacao().
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias
        loc_lResultado = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o dispon" + ;
                    CHR(237) + "vel: " + TRANSFORM(par_cAliasCursor)
            ELSE
                SELECT (par_cAliasCursor)
                loc_cAlias = UPPER(ALLTRIM(par_cAliasCursor))
                DO CASE
                    CASE loc_cAlias == "CRSIGCDOPE"
                        THIS.this_nDigItens = NVL(DigItens, 0)
                        THIS.this_nNcPesos  = NVL(NCPesos,  0)
                        THIS.this_cMasP     = "999999" + ;
                            IIF(THIS.this_nNcPesos > 0, "." + REPL("9", THIS.this_nNcPesos), "")
                        loc_lResultado = .T.
                    CASE loc_cAlias == "CRSIGOPCDD"
                        THIS.this_nCasQtds = NVL(CasQtds, 0)
                        THIS.this_cMasQ    = "999999" + ;
                            IIF(THIS.this_nCasQtds > 0, "." + REPL("9", THIS.this_nCasQtds), "")
                        loc_lResultado = .T.
                    CASE loc_cAlias == "CURSOR_4C_LOCALEMP"
                        THIS.this_nDivNotas = NVL(DivNotas, 0)
                        loc_lResultado = .T.
                    OTHERWISE
                        THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o reconhecido: " + ;
                            ALLTRIM(par_cAliasCursor)
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - N" + CHR(227) + "o aplicavel a relatorio (sem persistencia)
    * RelatorioBase nao executa INSERT - operacao bloqueada com mensagem clara
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o INSERIR n" + ;
            CHR(227) + "o se aplica a relat" + CHR(243) + "rio de impress" + ;
            CHR(227) + "o de documento"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorio (sem persistencia)
    * RelatorioBase nao executa UPDATE - operacao bloqueada com mensagem clara
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o ATUALIZAR n" + ;
            CHR(227) + "o se aplica a relat" + CHR(243) + "rio de impress" + ;
            CHR(227) + "o de documento"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorio nao gera auditoria (operacao read-only)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE

