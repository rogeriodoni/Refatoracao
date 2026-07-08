# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 246: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 266: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 286: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 306: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREAGV.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (991 linhas total):

*-- Linhas 106 a 114:
106:         loc_lSucesso   = .F.
107:         loc_lContinuar = .T.
108:         TRY
109:             THIS.Caption = "Acompanhamento Por Grupo de Venda"
110: 
111:             IF TYPE("gc_4c_CaminhoIcones") = "U"
112:                 gc_4c_CaminhoIcones = ""
113:             ENDIF
114:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 144 a 153:
144:                 *-- Garantir pagina inicial ativa (Page1: Filtros)
145:                 THIS.AlternarPagina(1)
146: 
147:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
148:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
149: 
150:                 *-- Inicializa valores dos campos de filtro (pula em modo de validacao UI)
151:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
152:                     THIS.LimparCampos()
153:                 ENDIF

*-- Linhas 173 a 212:
173:     PROTECTED PROCEDURE ConfigurarCabecalho()
174:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
175:         WITH THIS.cnt_4c_Cabecalho
176:             .Top         = 0
177:             .Left        = 0
178:             .Width       = THIS.Width
179:             .Height      = 80
180:             .BackColor   = RGB(100, 100, 100)
181:             .BackStyle   = 1
182:             .BorderWidth = 0
183:             .Visible     = .T.
184:         ENDWITH
185: 
186:         *-- Sombra (texto ligeiramente deslocado para efeito 3D)
187:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
188:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
189:             .Top       = 17
190:             .Left      = 12
191:             .AutoSize  = .T.
192:             .Caption   = "Acompanhamento Por Grupo de Venda"
193:             .FontName  = "Tahoma"
194:             .FontSize  = 14
195:             .FontBold  = .T.
196:             .ForeColor = RGB(0, 0, 0)
197:             .BackStyle = 0
198:             .Visible   = .T.
199:         ENDWITH
200: 
201:         *-- Titulo principal (texto branco sobre fundo escuro)
202:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
203:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
204:             .Top       = 20
205:             .Left      = 10
206:             .AutoSize  = .T.
207:             .Caption   = "Acompanhamento Por Grupo de Venda"
208:             .FontName  = "Tahoma"
209:             .FontSize  = 14
210:             .FontBold  = .T.
211:             .ForeColor = RGB(255, 255, 255)
212:             .BackStyle = 0

*-- Linhas 224 a 252:
224:     PROTECTED PROCEDURE ConfigurarBotoes()
225:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
226:         WITH THIS.cmg_4c_Botoes
227:             .Top           = 0
228:             .Left          = 528
229:             .Width         = 273
230:             .Height        = 80
231:             .ButtonCount   = 4
232:             .BackStyle     = 0
233:             .BorderStyle   = 0
234:             .BorderColor   = RGB(136, 189, 188)
235:             .SpecialEffect = 1
236:             .Themes        = .F.
237:             .Visible       = .T.
238:         ENDWITH
239: 
240:         WITH THIS.cmg_4c_Botoes.Buttons(1)
241:             .Top             = 5
242:             .Left            = 5
243:             .Width           = 65
244:             .Height          = 70
245:             .Caption         = "Visualizar"
246:             .FontName        = "Comic Sans MS"
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .FontSize        = 8
250:             .ForeColor       = RGB(90, 90, 90)
251:             .BackColor       = RGB(255, 255, 255)
252:             .PicturePosition = 13

*-- Linhas 258 a 272:
258:         ENDWITH
259: 
260:         WITH THIS.cmg_4c_Botoes.Buttons(2)
261:             .Top             = 5
262:             .Left            = 71
263:             .Width           = 65
264:             .Height          = 70
265:             .Caption         = "Imprimir"
266:             .FontName        = "Comic Sans MS"
267:             .FontBold        = .T.
268:             .FontItalic      = .T.
269:             .FontSize        = 8
270:             .ForeColor       = RGB(90, 90, 90)
271:             .BackColor       = RGB(255, 255, 255)
272:             .PicturePosition = 13

*-- Linhas 278 a 292:
278:         ENDWITH
279: 
280:         WITH THIS.cmg_4c_Botoes.Buttons(3)
281:             .Top             = 5
282:             .Left            = 137
283:             .Width           = 65
284:             .Height          = 70
285:             .Caption         = "Doc Excel"
286:             .FontName        = "Comic Sans MS"
287:             .FontBold        = .T.
288:             .FontItalic      = .T.
289:             .FontSize        = 8
290:             .ForeColor       = RGB(90, 90, 90)
291:             .BackColor       = RGB(255, 255, 255)
292:             .PicturePosition = 13

*-- Linhas 298 a 312:
298:         ENDWITH
299: 
300:         WITH THIS.cmg_4c_Botoes.Buttons(4)
301:             .Top             = 5
302:             .Left            = 203
303:             .Width           = 65
304:             .Height          = 70
305:             .Caption         = "Encerrar"
306:             .FontName        = "Comic Sans MS"
307:             .FontBold        = .T.
308:             .FontItalic      = .T.
309:             .FontSize        = 8
310:             .ForeColor       = RGB(90, 90, 90)
311:             .BackColor       = RGB(255, 255, 255)
312:             .PicturePosition = 13

*-- Linhas 338 a 352:
338:         loc_oPgf.PageCount = 1
339: 
340:         *-- Logo abaixo do cabecalho (80px) ate o fim do form
341:         loc_oPgf.Top    = 85
342:         loc_oPgf.Left   = -1
343:         loc_oPgf.Width  = THIS.Width + 2
344:         loc_oPgf.Height = THIS.Height - 85
345:         loc_oPgf.Tabs   = .F.
346: 
347:         loc_oPgf.Page1.Caption   = "Filtros"
348:         loc_oPgf.Page1.FontName  = "Tahoma"
349:         loc_oPgf.Page1.FontSize  = 8
350:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
351:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
352:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 367 a 469:
367:     *
368:     *   Conteudo desta fase (Fase 5/8 - Campos Principais Parte 1):
369:     *     - cnt_4c_Local (container hospedeiro dos filtros)
370:     *     - lbl_4c_Label3 + txt_4c_Colecao + txt_4c_DColecao (Grupo de Venda)
371:     *     - lbl_4c_Label1 + txt_4c_Moeda + txt_4c_DMoeda    (Moeda de Venda)
372:     *--------------------------------------------------------------------------
373:     PROTECTED PROCEDURE ConfigurarPaginaDados()
374:         LOCAL loc_oPg
375:         loc_oPg = THIS.pgf_4c_Paginas.Page1
376: 
377:         loc_oPg.AddObject("cnt_4c_Local", "Container")
378:         WITH loc_oPg.cnt_4c_Local
379:             .Top           = 59
380:             .Left          = 204
381:             .Width         = 451
382:             .Height        = 61
383:             .BackStyle     = 0
384:             .BorderWidth   = 0
385:             .SpecialEffect = 0
386:             .Visible       = .T.
387:         ENDWITH
388: 
389:         *-- Label "Grupo de Venda :" (Say3 original: Left=16, Top=7)
390:         loc_oPg.cnt_4c_Local.AddObject("lbl_4c_Label3", "Label")
391:         WITH loc_oPg.cnt_4c_Local.lbl_4c_Label3
392:             .AutoSize  = .T.
393:             .FontName  = "Tahoma"
394:             .FontSize  = 8
395:             .Caption   = "Grupo de Venda :"
396:             .Left      = 16
397:             .Top       = 7
398:             .ForeColor = RGB(90, 90, 90)
399:             .BackStyle = 0
400:             .Visible   = .T.
401:         ENDWITH
402: 
403:         *-- TextBox codigo do Grupo de Venda (getColecao: Left=108, Top=4, Width=80)
404:         loc_oPg.cnt_4c_Local.AddObject("txt_4c_Colecao", "TextBox")
405:         WITH loc_oPg.cnt_4c_Local.txt_4c_Colecao
406:             .Height    = 23
407:             .Left      = 108
408:             .Top       = 4
409:             .Width     = 80
410:             .MaxLength = 10
411:             .Format    = "K"
412:             .ForeColor = RGB(0, 0, 0)
413:             .Value     = ""
414:             .Visible   = .T.
415:         ENDWITH
416: 
417:         *-- TextBox descricao do Grupo de Venda (getDColecao: Left=190, Top=4, Width=255)
418:         loc_oPg.cnt_4c_Local.AddObject("txt_4c_DColecao", "TextBox")
419:         WITH loc_oPg.cnt_4c_Local.txt_4c_DColecao
420:             .Height    = 23
421:             .Left      = 190
422:             .Top       = 4
423:             .Width     = 255
424:             .MaxLength = 40
425:             .Format    = "K"
426:             .ForeColor = RGB(0, 0, 0)
427:             .Value     = ""
428:             .Visible   = .T.
429:         ENDWITH
430: 
431:         *-- Label "Moeda de Venda :" (Say1 original: Left=13, Top=32)
432:         loc_oPg.cnt_4c_Local.AddObject("lbl_4c_Label1", "Label")
433:         WITH loc_oPg.cnt_4c_Local.lbl_4c_Label1
434:             .AutoSize  = .T.
435:             .FontName  = "Tahoma"
436:             .FontSize  = 8
437:             .Caption   = "Moeda de Venda :"
438:             .Left      = 13
439:             .Top       = 32
440:             .ForeColor = RGB(90, 90, 90)
441:             .BackStyle = 0
442:             .Visible   = .T.
443:         ENDWITH
444: 
445:         *-- TextBox codigo da Moeda (getMoeda: Left=108, Top=29, Width=31, MaxLength=3)
446:         loc_oPg.cnt_4c_Local.AddObject("txt_4c_Moeda", "TextBox")
447:         WITH loc_oPg.cnt_4c_Local.txt_4c_Moeda
448:             .Height    = 23
449:             .Left      = 108
450:             .Top       = 29
451:             .Width     = 31
452:             .MaxLength = 3
453:             .Format    = "K!"
454:             .ForeColor = RGB(0, 0, 0)
455:             .Value     = ""
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         *-- TextBox descricao da Moeda (getDMoeda: Left=141, Top=29, Width=115, MaxLength=15)
460:         loc_oPg.cnt_4c_Local.AddObject("txt_4c_DMoeda", "TextBox")
461:         WITH loc_oPg.cnt_4c_Local.txt_4c_DMoeda
462:             .Height    = 23
463:             .Left      = 141
464:             .Top       = 29
465:             .Width     = 115
466:             .MaxLength = 15
467:             .Format    = "K!"
468:             .ForeColor = RGB(0, 0, 0)
469:             .Value     = ""

*-- Linhas 479 a 512:
479:     *   PageFrame de filtros, abaixo do container cnt_4c_Local.
480:     *
481:     *   Posicao original: Top=516, Left=175, Width=473, Height=56.
482:     *   Ajustado para Top relativo a Page1 (Page1.Top=85): Top = 516 - 85 = 431.
483:     *   Ocultado inicialmente (Visible=.F.) - exibido apenas durante geracao.
484:     *--------------------------------------------------------------------------
485:     PROTECTED PROCEDURE ConfigurarPaginaLista()
486:         LOCAL loc_oPg
487:         loc_oPg = THIS.pgf_4c_Paginas.Page1
488: 
489:         loc_oPg.AddObject("cnt_4c_Mensagem", "Container")
490:         WITH loc_oPg.cnt_4c_Mensagem
491:             .Top           = 130
492:             .Left          = 175
493:             .Width         = 473
494:             .Height        = 56
495:             .BackStyle     = 0
496:             .BorderWidth   = 0
497:             .SpecialEffect = 0
498:             .Visible       = .F.
499:         ENDWITH
500: 
501:         loc_oPg.cnt_4c_Mensagem.AddObject("lbl_4c_LblMensagem", "Label")
502:         WITH loc_oPg.cnt_4c_Mensagem.lbl_4c_LblMensagem
503:             .Top       = 18
504:             .Left      = 20
505:             .Width     = 445
506:             .Height    = 22
507:             .Caption   = "Aguarde!!!"
508:             .FontName  = "Tahoma"
509:             .FontSize  = 14
510:             .FontBold  = .T.
511:             .ForeColor = RGB(0, 0, 0)
512:             .BackStyle = 0


### BO (C:\4c\projeto\app\classes\SIGREAGVBO.prg):
*==============================================================================
* SIGREAGVBO.PRG
* Business Object - Relatorio de Acompanhamento Por Grupo de Venda
*
* Form origem : SIGREAGV.SCX (frmrelatorio)
* Herda de   : RelatorioBase
* Arquivo FRX: SigReAgv.frx
*
* Filtros do formulario:
*   - Grupo de Venda (Colecoes + Descs) -> SigCdCol
*   - Moeda de Venda (CMoes + DMoes)    -> SigCdMoe
*==============================================================================

DEFINE CLASS SIGREAGVBO AS RelatorioBase

    *-- Filtros do formulario
    this_cColecoes     = ""    && Codigo Grupo de Venda  (C10) - SigCdCol.Colecoes
    this_cDescs        = ""    && Descricao Grupo Venda  (C40) - SigCdCol.Descs
    this_cCMoes        = ""    && Codigo Moeda de Venda  (C03) - SigCdMoe.CMoes
    this_cDMoes        = ""    && Descricao Moeda Venda  (C15) - SigCdMoe.DMoes

    *-- Configuracao do relatorio
    this_cArquivoFRX   = ""    && Caminho completo do arquivo .frx
    this_cTitulo       = ""    && Titulo principal do relatorio
    this_cSubTitulo    = ""    && Sub-titulo (Grupo de Venda selecionado)
    this_cCursorDados  = "cursor_4c_Imprimir"    && Cursor principal para REPORT FORM

    *--------------------------------------------------------------------------
    * Init - Configura metadados do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        THIS.this_cTitulo     = "Acompanhamento Por Grupo de Venda"
        THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "SigReAgv.frx"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio
    * Replica a PROCEDURE processamento do SIGREAGV.SCX original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lMostrouErro, loc_oErro
        LOCAL loc_lcCol, loc_lcDol, loc_lcMoe
        LOCAL loc_lcTit, loc_lcSub, loc_lcCep
        LOCAL loc_lcQuery, loc_lcGrv
        LOCAL loc_lnCnt, loc_lnZer, loc_lnSal
        LOCAL loc_ldDat, loc_lcDtI, loc_lcDtF
        LOCAL loc_nResult, loc_nTaxa

        loc_lSucesso     = .F.
        loc_lMostrouErro = .F.

        TRY
            DO WHILE .T.

                *-- Apanha filtros selecionados no formulario
                loc_lcCol = PADR(THIS.this_cColecoes, 10)
                loc_lcDol = PADR(THIS.this_cDescs,    40)
                loc_lcMoe = PADR(THIS.this_cCMoes,    3)

                *-- Titulo e sub-titulo para o cabecalho do relatorio
                loc_lcTit = THIS.this_cTitulo
                IF EMPTY(loc_lcCol)
                    loc_lcSub = "Grupo de Venda : Geral"
                ELSE
                    loc_lcSub = "Grupo de Venda : " + ALLTRIM(loc_lcCol) + " - " + ALLTRIM(loc_lcDol)
                ENDIF
                THIS.this_cSubTitulo = loc_lcSub

                *-- Cabecalho com dados da empresa
                loc_lcCep = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

                IF USED("crCabecalho")
                    USE IN crCabecalho
                ENDIF
                CREATE CURSOR crCabecalho (Empresa C(80), Titulo C(80), SubTitulo C(80))
                INSERT INTO crCabecalho (Empresa, Titulo, SubTitulo) ;
                    VALUES (loc_lcCep, loc_lcTit, loc_lcSub)

                IF USED("crOrdenados")
                    USE IN crOrdenados
                ENDIF
                CREATE CURSOR crOrdenados (Colecoes C(10), CPros C(14), PrecoMedio N(16,2), ;
                                           DtIncs D(8), Moevs C(3), Promos C(25), ;
                                           Ordem C(10), QtdMedia N(16,2))

                *-- Busca tipos de operacao (entrada=2 ou saida=1)
                loc_lcQuery = "SELECT a.Dopes, a.TipoOps, t.GerGdmis " + ;
                              "FROM SigCdOpe a, SigCdTom t " + ;
                              "WHERE a.TipoOps = t.Codigos " + ;
                              "AND t.GerGdmis IN (1, 2) " + ;
                              "ORDER BY a.Dopes, a.TipoOps"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdOpe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(245) + "es (crSigCdOpe)"
                    EXIT
                ENDIF

                *-- Busca grupos de produtos nao considerados para media de preco de colecoes
                loc_lcQuery = "SELECT a.Promos, a.CPros, MIN(a.Datas) AS Datas " + ;
                              "FROM SigPrPmi a, SigPrPmc b " + ;
                              "WHERE a.Promos = b.Promos " + ;
                              "AND NOT b.Cods = '   ' " + ;
                              "GROUP BY a.Promos, a.CPros"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigPrPmi")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar promo" + CHR(231) + CHR(245) + "es (crSigPrPmi)"
                    EXIT
                ENDIF
                SELECT crSigPrPmi
                INDEX ON CPros TAG CPros

                *-- Busca produtos com grupo de venda e preco de venda definidos
                loc_lcQuery = "SELECT a.Colecoes, a.CPros, a.CGrus, a.PVens, a.Moevs, " + ;
                              "a.DtIncs, a.PVens AS QtdMedia " + ;
                              "FROM SigCdPro a " + ;
                              "WHERE NOT a.Colecoes = '          ' " + ;
                              "AND NOT a.PVens = 0 " + ;
                              "ORDER BY a.Colecoes, a.CPros, a.CGrus, a.PVens, a.Moevs, a.DtIncs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdPro")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar produtos (crSigCdPro)"
                    EXIT
                ENDIF

                *-- Quantidade de produtos por grupo de venda
                SELECT Colecoes, SUM(1) AS QtdMedia ;
                  FROM crSigCdPro ;
                 GROUP BY Colecoes ;
                  INTO CURSOR crQtdMedia
                SELECT crQtdMedia
                INDEX ON Colecoes TAG Colecoes

                *-- Menor data de cadastro por grupo de venda
                SELECT Colecoes, MIN(TTOD(NVL(DtIncs, CTOT("")))) AS DtIncs ;
                  FROM crSigCdPro ;
                 GROUP BY Colecoes ;
                  INTO CURSOR crDtIncs
                SELECT crDtIncs
                INDEX ON Colecoes TAG Colecoes

                *-- Converte preco de venda para Real e atualiza data/qtd do grupo
                WAIT WINDOW "Processando Pre" + CHR(231) + "o de Venda dos Produtos..." NOWAIT
                SELECT crSigCdPro
                SCAN
                    loc_nTaxa = THIS.BuscarCotacao(crSigCdPro.Moevs)
                    REPLACE PVens WITH PVens * loc_nTaxa IN crSigCdPro

                    IF SEEK(crSigCdPro.Colecoes, "crQtdMedia", "Colecoes")
                        REPLACE QtdMedia WITH crQtdMedia.QtdMedia IN crSigCdPro
                    ELSE
                        REPLACE QtdMedia WITH 0 IN crSigCdPro
                    ENDIF

                    IF SEEK(crSigCdPro.Colecoes, "crDtIncs", "Colecoes")
                        REPLACE DtIncs WITH crDtIncs.DtIncs IN crSigCdPro
                    ENDIF
                ENDSCAN
                WAIT CLEAR

                *-- Calcula preco medio por grupo de venda
                SELECT Colecoes, AVG(PVens) AS PVens ;
                  FROM crSigCdPro ;
                 GROUP BY Colecoes ;
                  INTO CURSOR crMedias
                SELECT crMedias
                INDEX ON Colecoes TAG Colecoes

                *-- Monta cursor com preco medio por produto/grupo
                SELECT DISTINCT a.Colecoes, a.CPros, b.PVens AS PrecoMedio, ;
                       a.DtIncs, a.Moevs, a.QtdMedia ;
                  FROM crSigCdPro a, crMedias b ;
                 WHERE a.Colecoes = b.Colecoes ;
                 ORDER BY a.Colecoes, a.CPros, b.PVens, a.DtIncs, a.Moevs ;
                  INTO CURSOR crGrupos

                *-- Para cada produto: busca historico de precos e promocoes
                WAIT WINDOW "Processando Hist" + CHR(243) + "rico dos Produtos..." NOWAIT
                SELECT crGrupos
                SCAN
                    loc_lcCol = PADR(STRTRAN(crGrupos.Colecoes, ['], []), 10)

                    loc_lcQuery = "SELECT Moevs, MIN(DataAlts) AS DataAlts " + ;
                                  "FROM SigCdPrc " + ;
                                  "WHERE CPros = " + EscaparSQL(crGrupos.CPros) + ;
                                  " AND Colecoes = " + EscaparSQL(loc_lcCol) + ;
                                  " GROUP BY Moevs " + ;
                                  "ORDER BY DataAlts, Moevs"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdPrc")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro hist" + CHR(243) + "rico pre" + CHR(231) + "os (crSigCdPrc)"
                        EXIT
                    ENDIF

                    SELECT crSigCdPrc
                    GO TOP
                    IF !EOF("crSigCdPrc")
                        loc_lnCnt = 0
                        SCAN
                            loc_lnCnt = loc_lnCnt + 1
                            INSERT INTO crOrdenados ;
                                (Colecoes, CPros, PrecoMedio, QtdMedia, DtIncs, Moevs, Ordem) ;
                                VALUES (loc_lcCol, crGrupos.CPros, crGrupos.PrecoMedio, ;
                                        crGrupos.QtdMedia, NVL(crSigCdPrc.DataAlts, {}), ;
                                        crSigCdPrc.Moevs, ALLTRIM(STR(loc_lnCnt, 6)))
                        ENDSCAN
                    ELSE
                        INSERT INTO crOrdenados ;
                            (Colecoes, CPros, PrecoMedio, QtdMedia, DtIncs, Moevs, Ordem) ;
                            VALUES (loc_lcCol, crGrupos.CPros, crGrupos.PrecoMedio, ;
                                    crGrupos.QtdMedia, NVL(crGrupos.DtIncs, {}), ;
                                    crGrupos.Moevs, "1")
                    ENDIF
                    IF USED("crSigCdPrc")
                        USE IN crSigCdPrc
                    ENDIF

                    *-- Promocoes do produto
                    SELECT Promos, MIN(Datas) AS Datas ;
                      FROM crSigPrPmi ;
                     WHERE CPros = crGrupos.CPros ;
                     GROUP BY Promos ;
                     ORDER BY 2, 1 ;
                      INTO CURSOR crPromos
                    SELECT crPromos
                    GO TOP
                    IF !EOF("crPromos")
                        loc_lnCnt = 0
                        SCAN
                            loc_lnCnt = loc_lnCnt + 1
                            INSERT INTO crOrdenados ;
                                (Colecoes, CPros, PrecoMedio, QtdMedia, DtIncs, Promos, Ordem) ;
                                VALUES (loc_lcCol, crGrupos.CPros, crGrupos.PrecoMedio, ;
                                        crGrupos.QtdMedia, NVL(crPromos.Datas, {}), ;
                                        crPromos.Promos, ALLTRIM(STR(loc_lnCnt, 6)) + "A")
                        ENDSCAN
                    ENDIF
                    IF USED("crPromos")
                        USE IN crPromos
                    ENDIF
                ENDSCAN
                WAIT CLEAR

                IF !EMPTY(THIS.this_cMensagemErro)
                    EXIT
                ENDIF

                *-- Agrega crOrdenados em dois passos (como o original)
                SELECT Colecoes, PrecoMedio, ;
                       MAX(QtdMedia) AS QtdMedia, ;
                       MAX(IIF(ALLTRIM(Moevs) = ALLTRIM(loc_lcMoe), Moevs, "   ")) AS Moevs, ;
                       Promos, MAX(Ordem) AS Ordem, MIN(DtIncs) AS DtIncs ;
                  FROM crOrdenados ;
                 GROUP BY Colecoes, PrecoMedio, Moevs, Promos ;
                  INTO CURSOR crGroupImp1

                SELECT Colecoes, PrecoMedio, ;
                       MAX(QtdMedia) AS QtdMedia, Moevs, Promos, ;
                       MAX(Ordem) AS Ordem, MIN(DtIncs) AS DtIncs ;
                  FROM crGroupImp1 ;
                 GROUP BY Colecoes, PrecoMedio, Moevs, Promos ;
                  INTO CURSOR crGroupImp2

                loc_lnZer = 0
                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF
                SELECT Colecoes, PrecoMedio, ;
                       MAX(QtdMedia) AS QtdMedia, MAX(Moevs) AS Moevs, Promos, ;
                       MAX(Ordem) AS Ordem, MAX(DtIncs) AS DtIncs, ;
                       MAX(DtIncs) AS DtInicial, MAX(DtIncs) AS DtFinal, ;
                       loc_lnZer AS SaldoIni, loc_lnZer AS Compras, ;
                       loc_lnZer AS Vendas,   loc_lnZer AS SaldoFin, ;
                       loc_lnZer AS Percentual ;
                  FROM crGroupImp2 ;
                 GROUP BY Colecoes, PrecoMedio, Promos, DtIncs ;
                  INTO CURSOR cursor_4c_Imprimir READWRITE

                SELECT cursor_4c_Imprimir
                INDEX ON Colecoes + DTOS(DtIncs) + Ordem TAG Colecoes

                *-- Define intervalos de datas por grupo de venda
                loc_lcGrv = SPACE(10)
                SELECT cursor_4c_Imprimir
                SCAN
                    IF (loc_lcGrv <> cursor_4c_Imprimir.Colecoes)
                        loc_lcGrv = cursor_4c_Imprimir.Colecoes
                        REPLACE DtInicial WITH CTOD("01/01/1900") IN cursor_4c_Imprimir
                        REPLACE DtFinal   WITH DATE()              IN cursor_4c_Imprimir
                        loc_ldDat = cursor_4c_Imprimir.DtFinal
                    ELSE
                        SKIP -1
                        REPLACE DtFinal WITH IIF(EMPTY(DtIncs), CTOD("01/01/1900"), DtIncs) IN cursor_4c_Imprimir
                        loc_ldDat = cursor_4c_Imprimir.DtFinal
                        SKIP +1
                        REPLACE DtInicial WITH loc_ldDat IN cursor_4c_Imprimir
                        REPLACE DtFinal   WITH DATE()    IN cursor_4c_Imprimir
                        loc_ldDat = cursor_4c_Imprimir.DtFinal
                    ENDIF
                ENDSCAN

                *-- Busca todas as movimentacoes de produtos
                WAIT WINDOW "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT
                loc_lcQuery = "SELECT a.TipoOps, b.Datas, c.CPros, c.Qtds, c.Opers, t.GerGdmis " + ;
                              "FROM SigCdOpe a, SigMvCab b, SigMvItn c, SigCdTom t " + ;
                              "WHERE a.Dopes = b.Dopes " + ;
                              "AND b.EmpDopNums = c.EmpDopNums " + ;
                              "AND a.TipoOps = t.Codigos " + ;
                              "AND t.GerGdmis IN (1, 2)"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crMovGeral")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar movimenta" + CHR(231) + CHR(245) + "es (crMovGeral)"
                    WAIT CLEAR
                    EXIT
                ENDIF
                WAIT CLEAR

                SELECT DISTINCT TTOD(Datas) AS Datas, CPros, ;
                       VAL(STR(IIF(GerGdmis = 2, IIF(Opers = "E", Qtds, Qtds * -1), 0), 16, 2)) AS Compras, ;
                       VAL(STR(IIF(GerGdmis = 1, IIF(Opers = "S", Qtds, Qtds * -1), 0), 16, 2)) AS Vendas ;
                  FROM crMovGeral ;
                  INTO CURSOR crMovimento READWRITE

                SELECT crMovimento
                INDEX ON CPros + DTOS(Datas) TAG ProDat

                *-- Acumula compras e vendas por produto/periodo em cursor_4c_Imprimir
                WAIT WINDOW "Processando Movimenta" + CHR(231) + CHR(227) + "o dos Produtos..." NOWAIT
                SELECT cursor_4c_Imprimir
                SCAN
                    loc_lcDtI = DTOS(cursor_4c_Imprimir.DtInicial)
                    loc_lcDtF = DTOS(cursor_4c_Imprimir.DtFinal)

                    SELECT CPros ;
                      FROM crSigCdPro ;
                     WHERE Colecoes = cursor_4c_Imprimir.Colecoes ;
                     ORDER BY CPros ;
                      INTO CURSOR crProdutos
                    SELECT crProdutos
                    SCAN
                        SELECT "" AS Agrupar, SUM(Compras) AS Compras, SUM(Vendas) AS Vendas ;
                          FROM crMovimento ;
                         WHERE CPros + DTOS(Datas) BETWEEN ;
                               crProdutos.CPros + loc_lcDtI AND crProdutos.CPros + loc_lcDtF ;
                         GROUP BY 1 ;
                          INTO CURSOR crValores
                        GO TOP IN crValores
                        IF !EOF("crValores")
                            REPLACE Compras WITH Compras + crValores.Compras, ;
                                    Vendas  WITH Vendas  + crValores.Vendas  IN cursor_4c_Imprimir
                        ENDIF
                        IF USED("crValores")
                            USE IN crValores
                        ENDIF
                    ENDSCAN
                    IF USED("crProdutos")
                        USE IN crProdutos
                    ENDIF
                ENDSCAN
                WAIT CLEAR

                *-- Calcula saldo inicial, final e percentual por grupo
                loc_lcGrv = SPACE(10)
                SELECT cursor_4c_Imprimir
                SCAN
                    IF (loc_lcGrv <> cursor_4c_Imprimir.Colecoes)
                        loc_lcGrv = cursor_4c_Imprimir.Colecoes
                        REPLACE SaldoFin   WITH Compras - Vendas IN cursor_4c_Imprimir
                        REPLACE Percentual WITH IIF(Vendas = 0, 0, ;
                            IIF(SaldoIni + Compras = 0, 100, ;
                                (Vendas / (SaldoIni + Compras)) * 100)) IN cursor_4c_Imprimir
                    ELSE
                        SKIP -1
                        loc_lnSal = cursor_4c_Imprimir.SaldoFin
                        SKIP +1
                        REPLACE SaldoIni WITH loc_lnSal, ;
                                SaldoFin WITH loc_lnSal + (Compras - Vendas) IN cursor_4c_Imprimir
                        REPLACE Percentual WITH IIF(Vendas = 0, 0, ;
                            IIF(SaldoIni + Compras = 0, 100, ;
                                (Vendas / (SaldoIni + Compras)) * 100)) IN cursor_4c_Imprimir
                    ENDIF
                ENDSCAN

                SELECT cursor_4c_Imprimir
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Preparar Dados do Relat" + CHR(243) + "rio")
            loc_lMostrouErro = .T.
        ENDTRY

        *-- Limpa cursores temporarios
        IF USED("crSigCdOpe")
            USE IN crSigCdOpe
        ENDIF
        IF USED("crSigPrPmi")
            USE IN crSigPrPmi
        ENDIF
        IF USED("crSigCdPro")
            USE IN crSigCdPro
        ENDIF
        IF USED("crQtdMedia")
            USE IN crQtdMedia
        ENDIF
        IF USED("crDtIncs")
            USE IN crDtIncs
        ENDIF
        IF USED("crMedias")
            USE IN crMedias
        ENDIF
        IF USED("crGrupos")
            USE IN crGrupos
        ENDIF
        IF USED("crOrdenados")
            USE IN crOrdenados
        ENDIF
        IF USED("crGroupImp1")
            USE IN crGroupImp1
        ENDIF
        IF USED("crGroupImp2")
            USE IN crGroupImp2
        ENDIF
        IF USED("crMovGeral")
            USE IN crMovGeral
        ENDIF
        IF USED("crMovimento")
            USE IN crMovimento
        ENDIF

        IF !loc_lSucesso AND !loc_lMostrouErro AND !EMPTY(THIS.this_cMensagemErro)
            MsgErro(THIS.this_cMensagemErro, "Relat" + CHR(243) + "rio")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime diretamente na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Imprimir Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Visualizar Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e gera documento (imprime para arquivo)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER NOCONSOLE
                THIS.RegistrarAuditoria("EXPORTAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar Documento do Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    * Para REPORT BOs, a chave do registro contem o codigo do grupo+moeda filtrado
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAGV") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            *-- Falha em audit nao deve impedir geracao do relatorio
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca taxa de cambio da moeda em relacao ao Real
    * Substitui fBuscarCotacao() do sistema legado
    * Tabela: SigCdCot (cmoes, datas, valos)
    * Retorna 1.0 se moeda nao encontrada (fallback seguro)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacao(par_cMoeda)
        LOCAL loc_nTaxa, loc_cSQL, loc_nResult, loc_cMoeda

        loc_nTaxa  = 1.0
        loc_cMoeda = ALLTRIM(par_cMoeda)

        IF EMPTY(loc_cMoeda) OR loc_cMoeda = "R"
            RETURN loc_nTaxa
        ENDIF

        loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                   "WHERE cmoes = " + EscaparSQL(loc_cMoeda) + ;
                   " AND datas <= GETDATE() " + ;
                   "ORDER BY datas DESC, horas DESC"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotAgv")
        IF loc_nResult > 0 AND !EOF("cursor_4c_CotAgv")
            SELECT cursor_4c_CotAgv
            IF NVL(valos, 0) > 0
                loc_nTaxa = valos
            ENDIF
        ENDIF

        IF USED("cursor_4c_CotAgv")
            USE IN cursor_4c_CotAgv
        ENDIF

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da execucao do relatorio
    * Combina filtros selecionados (Grupo de Venda + Moeda) como chave de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cCol, loc_cMoe
        loc_cCol = ALLTRIM(THIS.this_cColecoes)
        loc_cMoe = ALLTRIM(THIS.this_cCMoes)

        loc_cChave = IIF(EMPTY(loc_cCol), "GERAL", loc_cCol)
        IF !EMPTY(loc_cMoe)
            loc_cChave = loc_cChave + "/" + loc_cMoe
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crCabecalho")
            USE IN crCabecalho
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

