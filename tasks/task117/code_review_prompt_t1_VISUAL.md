# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 283: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 306: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 330: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIdt.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (813 linhas total):

*-- Linhas 72 a 84:
72:         *-- Caption dinamico com numero do documento (reproduz original)
73:         *-- "Impressao de Documento de Titulo (DOP/NUM)"
74:         IF !EMPTY(THIS.this_cDopes) AND !EMPTY(THIS.this_cNumes)
75:             THIS.Caption = "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + ;
76:                            "tulo (" + ALLTRIM(THIS.this_cDopes) + "/" + ;
77:                            ALLTRIM(THIS.this_cNumes) + ")"
78:         ELSE
79:             THIS.Caption = "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + "tulo"
80:         ENDIF
81: 
82:         RETURN DODEFAULT()
83:     ENDPROC
84: 

*-- Linhas 109 a 118:
109:                 THIS.ConfigurarPageFrame()
110: 
111:                 *-- Atualizar labels do cabecalho com caption dinamico
112:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
113:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
114: 
115:                 *-- Vincular Click dos botoes
116:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
117:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
118:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")

*-- Linhas 190 a 228:
190: 
191:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
192:         WITH THIS.cnt_4c_Cabecalho
193:             .Top         = 0
194:             .Left        = 0
195:             .Width       = THIS.Width
196:             .Height      = 80
197:             .BackStyle   = 1
198:             .BackColor   = RGB(100, 100, 100)
199:             .BorderWidth = 0
200:             .Visible     = .T.
201: 
202:             .AddObject("lbl_4c_Sombra", "Label")
203:             WITH .lbl_4c_Sombra
204:                 .Top       = 22
205:                 .Left      = 22
206:                 .Width     = THIS.Width
207:                 .Height    = 30
208:                 .Caption   = loc_cCaption
209:                 .FontName  = "Tahoma"
210:                 .FontSize  = 14
211:                 .FontBold  = .T.
212:                 .ForeColor = RGB(0, 0, 0)
213:                 .BackStyle = 0
214:                 .Visible   = .T.
215:             ENDWITH
216: 
217:             .AddObject("lbl_4c_Titulo", "Label")
218:             WITH .lbl_4c_Titulo
219:                 .Top       = 20
220:                 .Left      = 20
221:                 .Width     = THIS.Width
222:                 .Height    = 30
223:                 .Caption   = loc_cCaption
224:                 .FontName  = "Tahoma"
225:                 .FontSize  = 14
226:                 .FontBold  = .T.
227:                 .ForeColor = RGB(255, 255, 255)
228:                 .BackStyle = 0

*-- Linhas 239 a 248:
239:     PROTECTED PROCEDURE ConfigurarBotoes()
240:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
241:         WITH THIS.cmg_4c_Botoes
242:             .Top           = 0
243:             .Left          = 529
244:             .Width         = 273
245:             .Height        = 80
246:             .ButtonCount   = 4
247:             .BackStyle     = 0
248:             .BorderStyle   = 0

*-- Linhas 254 a 266:
254:             *-- Botao 1: Visualizar (preview na tela)
255:             *-- Original: btnReport.Visualiza (Left=5, Width=75)
256:             WITH .Buttons(1)
257:                 .Top             = 5
258:                 .Left            = 5
259:                 .Width           = 65
260:                 .Height          = 70
261:                 .Caption         = "Visualizar"
262:                 .FontBold        = .T.
263:                 .FontItalic      = .T.
264:                 .BackColor       = RGB(255, 255, 255)
265:                 .ForeColor       = RGB(90, 90, 90)
266:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 275 a 289:
275:             *-- Botao 2: Imprimir (com prompt de impressora)
276:             *-- Original: btnReport.Imprime (Left=80, Width=75)
277:             WITH .Buttons(2)
278:                 .Top             = 5
279:                 .Left            = 71
280:                 .Width           = 65
281:                 .Height          = 70
282:                 .Caption         = "Imprimir"
283:                 .FontName        = "Comic Sans MS"
284:                 .FontBold        = .T.
285:                 .FontItalic      = .T.
286:                 .FontSize        = 8
287:                 .BackColor       = RGB(255, 255, 255)
288:                 .ForeColor       = RGB(90, 90, 90)
289:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 298 a 312:
298:             *-- Botao 3: Documento (impressao direta sem prompt)
299:             *-- Original: btnReport.DocExcel (Left=155, Width=75) - PROCEDURE documento
300:             WITH .Buttons(3)
301:                 .Top             = 5
302:                 .Left            = 137
303:                 .Width           = 65
304:                 .Height          = 70
305:                 .Caption         = "Documento"
306:                 .FontName        = "Comic Sans MS"
307:                 .FontBold        = .T.
308:                 .FontItalic      = .T.
309:                 .FontSize        = 8
310:                 .BackColor       = RGB(255, 255, 255)
311:                 .ForeColor       = RGB(90, 90, 90)
312:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 321 a 336:
321:             *-- Botao 4: Encerrar (fecha o form, tecla ESC)
322:             *-- Original: btnReport.Sair (Left=230, Width=75, Cancel=.T.)
323:             WITH .Buttons(4)
324:                 .Top             = 5
325:                 .Left            = 203
326:                 .Width           = 65
327:                 .Height          = 70
328:                 .Caption         = "Encerrar"
329:                 .Cancel          = .T.
330:                 .FontName        = "Comic Sans MS"
331:                 .FontBold        = .T.
332:                 .FontItalic      = .T.
333:                 .FontSize        = 8
334:                 .BackColor       = RGB(255, 255, 255)
335:                 .ForeColor       = RGB(90, 90, 90)
336:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 350 a 367:
350:     *--------------------------------------------------------------------------
351:     PROTECTED PROCEDURE ConfigurarFiltros()
352:         *-- Label "Tipo de Impressao :" (original: Label1, Top=105, Left=253)
353:         THIS.AddObject("lbl_4c_Label1", "Label")
354:         WITH THIS.lbl_4c_Label1
355:             .AutoSize  = .T.
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .BackStyle = 0
359:             .Caption   = "Tipo de Impress" + CHR(227) + "o :"
360:             .Height    = 15
361:             .Left      = 253
362:             .Top       = 105
363:             .Width     = 97
364:             .ForeColor = RGB(90, 90, 90)
365:             .Visible   = .T.
366:         ENDWITH
367: 

*-- Linhas 379 a 427:
379: 
380:             WITH .Buttons(1)
381:                 .BackStyle = 0
382:                 .Caption   = "T" + CHR(237) + "tulo"
383:                 .Value     = 0
384:                 .Height    = 15
385:                 .Left      = 6
386:                 .Top       = 4
387:                 .Width     = 44
388:                 .AutoSize  = .T.
389:                 .ForeColor = RGB(90, 90, 90)
390:                 .Themes    = .F.
391:             ENDWITH
392: 
393:             WITH .Buttons(2)
394:                 .FontName  = "Tahoma"
395:                 .FontSize  = 8
396:                 .BackStyle = 0
397:                 .Caption   = "Autoriza" + CHR(231) + CHR(227) + "o de Gasto"
398:                 .Value     = 1
399:                 .Height    = 15
400:                 .Left      = 60
401:                 .Top       = 4
402:                 .Width     = 121
403:                 .AutoSize  = .T.
404:                 .ForeColor = RGB(90, 90, 90)
405:                 .Themes    = .F.
406:             ENDWITH
407: 
408:             .Left = 346
409:             .Top  = 102
410:         ENDWITH
411: 
412:         *-- Label "Imprimir Recorrencia : " (original: SayAgrupa, Top=132, Left=243)
413:         THIS.AddObject("lbl_4c_Agrupa", "Label")
414:         WITH THIS.lbl_4c_Agrupa
415:             .AutoSize  = .T.
416:             .FontName  = "Tahoma"
417:             .FontSize  = 8
418:             .BackStyle = 0
419:             .Caption   = "Imprimir Recorr" + CHR(234) + "ncia : "
420:             .Height    = 15
421:             .Left      = 243
422:             .Top       = 132
423:             .Width     = 110
424:             .ForeColor = RGB(90, 90, 90)
425:             .Visible   = .T.
426:         ENDWITH
427: 

*-- Linhas 439 a 489:
439: 
440:             WITH .Buttons(1)
441:                 .BackStyle = 0
442:                 .Caption   = "Sim"
443:                 .Value     = 0
444:                 .Height    = 15
445:                 .Left      = 6
446:                 .Top       = 4
447:                 .Width     = 34
448:                 .AutoSize  = .T.
449:                 .ForeColor = RGB(90, 90, 90)
450:                 .Themes    = .F.
451:             ENDWITH
452: 
453:             WITH .Buttons(2)
454:                 .FontName  = "Tahoma"
455:                 .FontSize  = 8
456:                 .BackStyle = 0
457:                 .Caption   = "Agrupada"
458:                 .Value     = 0
459:                 .Height    = 15
460:                 .Left      = 60
461:                 .Top       = 4
462:                 .Width     = 65
463:                 .AutoSize  = .T.
464:                 .ForeColor = RGB(90, 90, 90)
465:                 .Themes    = .F.
466:             ENDWITH
467: 
468:             WITH .Buttons(3)
469:                 .FontName  = "Tahoma"
470:                 .FontSize  = 8
471:                 .BackStyle = 0
472:                 .Caption   = "Nenhum"
473:                 .Value     = 1
474:                 .Height    = 15
475:                 .Left      = 143
476:                 .Top       = 4
477:                 .Width     = 57
478:                 .AutoSize  = .T.
479:                 .ForeColor = RGB(90, 90, 90)
480:                 .Themes    = .F.
481:             ENDWITH
482: 
483:             .Left = 346
484:             .Top  = 129
485:         ENDWITH
486:     ENDPROC
487: 
488:     *--------------------------------------------------------------------------
489:     * ConfigurarPaginaDados - Finalizacao da configuracao visual e pre-populacao do BO.

*-- Linhas 503 a 517:
503:             *-- 1. Sincronizar largura do cabecalho com largura real do form
504:             IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
505:                 THIS.cnt_4c_Cabecalho.Width = THIS.Width
506:                 IF VARTYPE(THIS.cnt_4c_Cabecalho.lbl_4c_Sombra) = "O"
507:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Width  = THIS.Width
508:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cCaption
509:                 ENDIF
510:                 IF VARTYPE(THIS.cnt_4c_Cabecalho.lbl_4c_Titulo) = "O"
511:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Width  = THIS.Width
512:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cCaption
513:                 ENDIF
514:             ENDIF
515: 
516:             *-- 2. Pre-popular BO com parametros recebidos no Init para que
517:             *--    PrepararDados() possa ser chamado mesmo antes do primeiro clique


### BO (C:\4c\projeto\app\classes\SigReIdtBO.prg):
*==============================================================================
* SigReIdtBO.prg
* Business Object para Relatorio de Documento de Titulo
*
* Herda de RelatorioBase
* Form original: SIGREIDT (frmrelatorio)
* Reports: SigReIdt.frx, SigReIdA.frx, SigReIag.frx
*==============================================================================

DEFINE CLASS SigReIdtBO AS RelatorioBase

    *-- Parametros do relatorio (definidos pelo form via FormParaRelatorio)
    this_cEmps       = ""   && Codigo da empresa (3 chars, ex: "001")
    this_cDopes      = ""   && Operacao/documento (20 chars padded)
    this_cNumes      = ""   && Numero do titulo
    this_nNumef      = 0    && Numero fiscal (numerico - Numef no original)
    this_cDiretorio  = ""   && Diretorio de saida opcional (pcDiretorio)
    this_cDirFiscais = ""   && Diretorio fiscal (goSistema.DirFiscais)

    *-- Opcoes de impressao (mapeados dos OptionGroups do form)
    *   this_nOptTipo:   1=Titulo, 2=Autorizacao de Gasto (default=2)
    *   this_nOptAgrupa: 1=Sim, 2=Agrupada, 3=Nenhum (default=3)
    this_nOptTipo    = 2
    this_nOptAgrupa  = 3

    *-- Controle interno carregado de SigCdPam (GrupoRecs/GrupoPags, ContaRecs/ContaPags)
    this_cContaTran  = ""
    this_cGrupoTran  = ""

    *-- Nome do cursor principal do relatorio (referenciado pelos FRX)
    this_cCursorDados = "crDBImp"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara dados do relatorio de documento de titulo
    * Logica original: PROCEDURE processamento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cTabMov, loc_cSinalOper, loc_cEDNE
        LOCAL loc_cObs, loc_nRecor, loc_nReg
        LOCAL loc_laTitulo, loc_lnTotVal
        LOCAL loc_cTxt01, loc_cTxt02, loc_cTxt03, loc_cTxt04
        LOCAL loc_cRclis1, loc_cRclis2, loc_cRclis3, loc_cRclis4
        LOCAL loc_cCpfs2, loc_cContaLkp
        LOCAL loc_cGrupoPortador, loc_cContaPortador
        LOCAL loc_cObsd, loc_cHists, loc_cOpersFiltro

        loc_lSucesso = .F.
        TRY
            *-- 1. Carregar dados da empresa
            loc_cSQL = "SELECT RazSocs, Cgcs, Ies, Tel1s, Tel2s " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Emps = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps), 3))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar empresa"
                THROW
            ENDIF
            SELECT cursor_4c_LocalEmp
            GO TOP
            IF EOF()
                THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ALLTRIM(THIS.this_cEmps)
                THROW
            ENDIF

            *-- 2. Criar cursor de cabecalho do relatorio (csCabecalho - referenciado pelos FRX)
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (Empresa c(80), Titulo c(80))
            SELECT csCabecalho
            APPEND BLANK
            REPLACE Empresa WITH ALLTRIM(THIS.this_cEmps) + " - " + ALLTRIM(cursor_4c_LocalEmp.RazSocs)
            REPLACE Titulo  WITH PADR(ALLTRIM(THIS.this_cDopes), 20)

            *-- 3. Criar cursor principal de impressao (crDBImp - referenciado pelos FRX)
            IF USED("crDBImp")
                USE IN crDBImp
            ENDIF
            CREATE CURSOR crDBImp (;
                Emps c(3), RazSocs c(50), Titulo c(10), Nfs c(10), DtMovs d, ;
                Txt01 c(20), GrupEm c(10), Contem c(10), dContem c(50), ;
                Txt02 c(20), Grupo c(10), Conta c(10), dConta c(50), cpfs c(20), ;
                Txt03 c(20), sGrupos c(10), sContas c(10), sdConta c(50), Obsc c(50), Valorc n(12,2), ;
                Txt04 c(20), Gruage c(10), contag c(10), dContag c(50), ;
                DtEmis d, Titban c(10), dtVencs d, bContas c(20), ;
                bGrupos c(20), DopCs c(20), ;
                Obs c(50), Usuars c(10), ;
                Valor n(12,2), Moeda c(3), Cotacao n(12,2), ;
                Obss m, Recors m, Hists m, ;
                ValPrev n(13,2), ValOrig n(13,2), ValOco n(13,2), ;
                ValLiq n(13,2), EspecieNfs c(6), TpDocNf c(2), Compet c(7))

            *-- 4. Carregar operacoes (SigOpOpe) com indice em Dopes
            loc_cSQL = "SELECT Dopes, Opers, NDopes, RealPrevs, " + ;
                       "Txt01, Txt02, Txt03, Txt04 FROM SigOpOpe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar opera" + CHR(231) + CHR(245) + "es"
                THROW
            ENDIF
            SELECT cursor_4c_LocalOpe
            INDEX ON Dopes TAG dopes ADDITIVE
            IF NOT SEEK(PADR(ALLTRIM(THIS.this_cDopes), 20))
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                          "o encontrada: " + ALLTRIM(THIS.this_cDopes)
                THROW
            ENDIF

            *-- 5. Carregar parametros do sistema (SigCdPam)
            loc_cSQL = "SELECT GrupoRecs, GrupoPags, ContaRecs, ContaPags FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalParam")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + "metros do sistema"
                THROW
            ENDIF
            SELECT cursor_4c_LocalParam
            GO TOP

            *-- 6. Determinar tabela de movimento e sinal da operacao
            SELECT cursor_4c_LocalOpe
            loc_cTabMov    = IIF(cursor_4c_LocalOpe.RealPrevs = 2, "SigMvCpv", "SigMvCcr")
            loc_cSinalOper = IIF(ALLTRIM(cursor_4c_LocalOpe.Opers) = "CR", "C", "D")

            *-- 7. Carregar registro principal (crLocMccr - Tipos=' ')
            loc_cSQL = "SELECT empdopncs, Titulos, nfs, datas, grupems, contems, " + ;
                       "grupos, contas, sgrupos, scontas, hist2s, grupages, UsuAlts, " + ;
                       "contages, dtemis, titbans, vencs, valprev, valors, moedas, cotacaos, " + ;
                       "bgrupos, bcontas, dopcs, tipos, emps, opers, " + ;
                       "valocurs, ValPags, EspecieNfs, TpDocNf, Compet " + ;
                       "FROM " + loc_cTabMov + ;
                       " WHERE Titulos = " + EscaparSQL(ALLTRIM(THIS.this_cNumes)) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ;
                       " AND Opers = " + EscaparSQL(loc_cSinalOper) + ;
                       " AND Dopcs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + ;
                       " AND Numcs = " + ALLTRIM(STR(THIS.this_nNumef)) + ;
                       " AND Tipos = ' '"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocMccr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar movimento principal"
                THROW
            ENDIF
            SELECT crLocMccr
            GO TOP
            IF EOF()
                THIS.this_cMensagemErro = "Movimento n" + CHR(227) + "o encontrado para o t" + ;
                                          CHR(237) + "tulo informado"
                THROW
            ENDIF

            *-- 8. Carregar crTmpMccr com filtro de tipo conforme optTipo
            loc_cSQL = "SELECT empdopncs, Titulos, nfs, datas, grupems, contems, " + ;
                       "grupos, contas, sgrupos, scontas, hist2s, grupages, UsuAlts, " + ;
                       "contages, dtemis, titbans, vencs, valprev, valors, moedas, cotacaos, " + ;
                       "bgrupos, bcontas, dopcs, tipos, emps, opers, " + ;
                       "valocurs, ValPags, EspecieNfs, TpDocNf, Compet " + ;
                       "FROM " + loc_cTabMov + ;
                       " WHERE Titulos = " + EscaparSQL(ALLTRIM(THIS.this_cNumes)) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ;
                       " AND Opers = " + EscaparSQL(loc_cSinalOper) + ;
                       " AND Dopcs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + ;
                       " AND Numcs = " + ALLTRIM(STR(THIS.this_nNumef)) + ;
                       IIF(THIS.this_nOptTipo = 1, " AND Tipos = 'C'", "")
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpMccr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar dados de movimento"
                THROW
            ENDIF
            SELECT crTmpMccr
            GO TOP
            IF EOF()
                *-- Se vazio, copiar crLocMccr como base
                IF USED("crTmpMccr")
                    USE IN crTmpMccr
                ENDIF
                SELECT * FROM crLocMccr INTO CURSOR crTmpMccr READWRITE
                SELECT crLocMccr
                GO TOP
            ENDIF

            *-- 9. Se OptAgrupa 1 ou 2, carregar recorrencias
            IF INLIST(THIS.this_nOptAgrupa, 1, 2)
                SELECT crTmpMccr
                GO TOP
                loc_cEDNE = ALLTRIM(crTmpMccr.EmpDopNcs)

                loc_cSQL = "SELECT nRecors FROM SigTtRec " + ;
                           "WHERE EmpdopNcs = " + EscaparSQL(loc_cEDNE)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalRecor")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao carregar recorr" + CHR(234) + "ncias"
                    THROW
                ENDIF
                SELECT cursor_4c_LocalRecor
                GO TOP
                loc_nRecor = cursor_4c_LocalRecor.nRecors

                *-- Buscar registros de recorrencia via UNION ALL (SigMvCcr e SigMvCpv)
                loc_cSQL = "SELECT a.empdopncs, a.Titulos, a.nfs, a.datas, " + ;
                           "a.grupems, a.contems, a.grupos, a.contas, " + ;
                           "a.sgrupos, a.scontas, a.hist2s, a.grupages, " + ;
                           "a.contages, a.dtemis, a.titbans, a.vencs, a.valprev, a.valors, " + ;
                           "a.moedas, a.cotacaos, a.bgrupos, a.bcontas, " + ;
                           "a.dopcs, a.tipos, a.emps, a.opers, " + ;
                           "a.UsuAlts, a.EspecieNfs, a.TpDocNf, a.Compet " + ;
                           "FROM SigTtRec b, SigMvCcr a " + ;
                           "WHERE b.nRecors = " + ALLTRIM(STR(loc_nRecor)) + ;
                           " AND b.EmpDopNcs = a.EmpdopNcs " + ;
                           "UNION ALL " + ;
                           "SELECT a.empdopncs, a.Titulos, a.nfs, a.datas, " + ;
                           "a.grupems, a.contems, a.grupos, a.contas, " + ;
                           "a.sgrupos, a.scontas, a.hist2s, a.grupages, " + ;
                           "a.contages, a.dtemis, a.titbans, a.vencs, a.valprev, a.valors, " + ;
                           "a.moedas, a.cotacaos, a.bgrupos, a.bcontas, " + ;
                           "a.dopcs, a.tipos, a.emps, a.opers, " + ;
                           "a.UsuAlts, a.EspecieNfs, a.TpDocNf, a.Compet " + ;
                           "FROM SigTtRec b, SigMvCpv a " + ;
                           "WHERE b.nRecors = " + ALLTRIM(STR(loc_nRecor)) + ;
                           " AND b.EmpDopNcs = a.EmpdopNcs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMccr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao carregar recorr" + CHR(234) + "ncias detalhadas"
                    THROW
                ENDIF

                *-- Filtrar registros relacionados (excluindo o registro principal)
                loc_cOpersFiltro = loc_cSinalOper
                SELECT a.* ;
                    FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                    WHERE a.Dopcs = b.dopes ;
                    AND a.Opers = loc_cOpersFiltro ;
                    AND a.EmpdopNcs <> loc_cEDNE ;
                    INTO CURSOR cursor_4c_LocalMccr1 ;
                    ORDER BY a.vencs

                IF RECCOUNT("cursor_4c_LocalMccr1") = 0
                    SELECT a.* ;
                        FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                        WHERE a.Dopcs = b.dopes ;
                        AND a.Opers = loc_cOpersFiltro ;
                        AND a.Tipos = " " ;
                        AND a.EmpdopNcs <> loc_cEDNE ;
                        INTO CURSOR cursor_4c_LocalMccr1 ;
                        ORDER BY a.vencs
                ENDIF

                *-- Se OptAgrupa=1, adicionar recorrencias ao crTmpMccr
                IF THIS.this_nOptAgrupa = 1
                    SELECT crTmpMccr
                    APPEND FROM DBF("cursor_4c_LocalMccr1")
                ENDIF
            ENDIF

            *-- 10. Processar cada registro de crTmpMccr e popular crDBImp
            SELECT crLocMccr
            GO TOP

            SELECT crTmpMccr
            GO TOP
            SCAN
                *-- Determinar GrupoTran/ContaTran para a operacao do registro atual
                IF SEEK(crTmpMccr.Dopcs, "cursor_4c_LocalOpe", "dopes")
                    SELECT cursor_4c_LocalParam
                    GO TOP
                    IF ALLTRIM(cursor_4c_LocalOpe.Opers) = "CR"
                        THIS.this_cGrupoTran = ALLTRIM(cursor_4c_LocalParam.GrupoPags)
                        THIS.this_cContaTran = ALLTRIM(cursor_4c_LocalParam.ContaPags)
                    ELSE
                        THIS.this_cGrupoTran = ALLTRIM(cursor_4c_LocalParam.GrupoRecs)
                        THIS.this_cContaTran = ALLTRIM(cursor_4c_LocalParam.ContaRecs)
                    ENDIF
                ENDIF

                *-- Carregar detalhes complementares do titulo (SigTtCcd)
                loc_cSQL = "SELECT obsd, Hists FROM SigTtCcd " + ;
                           "WHERE EmpDopNcs = " + EscaparSQL(crTmpMccr.EmpDopNcs)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccrd")
                SELECT cursor_4c_TmpMccrd
                GO TOP
                IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_TmpMccrd.obsd))
                    loc_cObsd = ALLTRIM(cursor_4c_TmpMccrd.obsd)
                ELSE
                    loc_cObsd = " "
                ENDIF
                IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_TmpMccrd.Hists))
                    loc_cHists = ALLTRIM(cursor_4c_TmpMccrd.Hists)
                ELSE
                    loc_cHists = " "
                ENDIF

                *-- Buscar nome do emitente (contems)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.contems)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli1")
                SELECT cursor_4c_TmpCli1
                GO TOP
                loc_cRclis1 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli1.Rclis), "")

                *-- Buscar nome e CPF do portador (conta ou contems conforme ContaTran)
                IF ALLTRIM(crTmpMccr.Contas) = THIS.this_cContaTran
                    loc_cContaLkp = crTmpMccr.Contems
                ELSE
                    loc_cContaLkp = crTmpMccr.Contas
                ENDIF
                loc_cSQL = "SELECT Rclis, Cpfs FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(loc_cContaLkp)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli2")
                SELECT cursor_4c_TmpCli2
                GO TOP
                loc_cRclis2 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli2.Rclis), "")
                loc_cCpfs2  = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli2.Cpfs), "")

                *-- Buscar nome do centro de custo (scontas)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.scontas)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli3")
                SELECT cursor_4c_TmpCli3
                GO TOP
                loc_cRclis3 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli3.Rclis), "")

                *-- Buscar nome do agente cobrador (contages)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.contages)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli4")
                SELECT cursor_4c_TmpCli4
                GO TOP
                loc_cRclis4 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli4.Rclis), "")

                *-- Labels de texto dos campos (Txt01-Txt04)
                SELECT cursor_4c_LocalOpe
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt01))
                    loc_cTxt01 = ALLTRIM(cursor_4c_LocalOpe.Txt01) + " :"
                ELSE
                    loc_cTxt01 = "Emitente :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt02))
                    loc_cTxt02 = ALLTRIM(cursor_4c_LocalOpe.Txt02) + " :"
                ELSE
                    loc_cTxt02 = "Portador :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt03))
                    loc_cTxt03 = ALLTRIM(cursor_4c_LocalOpe.Txt03) + " :"
                ELSE
                    loc_cTxt03 = "Centro de Custo :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt04))
                    loc_cTxt04 = ALLTRIM(cursor_4c_LocalOpe.Txt04) + " :"
                ELSE
                    loc_cTxt04 = "Agente Cobrador :"
                ENDIF

                *-- Grupo e conta do portador (podem ser transpostos com emitente)
                IF ALLTRIM(crTmpMccr.Grupos) = THIS.this_cGrupoTran
                    loc_cGrupoPortador = crTmpMccr.Grupems
                ELSE
                    loc_cGrupoPortador = crTmpMccr.Grupos
                ENDIF
                IF ALLTRIM(crTmpMccr.Contas) = THIS.this_cContaTran
                    loc_cContaPortador = crTmpMccr.ContEms
                ELSE
                    loc_cContaPortador = crTmpMccr.Contas
                ENDIF

                *-- Adicionar registro ao cursor crDBImp
                SELECT crDBImp
                APPEND BLANK
                REPLACE ;
                    Emps      WITH crTmpMccr.Emps, ;
                    RazSocs   WITH ALLTRIM(cursor_4c_LocalEmp.RazSocs), ;
                    Titulo    WITH crTmpMccr.Titulos, ;
                    Nfs       WITH crTmpMccr.Nfs, ;
                    DtMovs    WITH crTmpMccr.datas, ;
                    Txt01     WITH loc_cTxt01, ;
                    GrupEm    WITH crTmpMccr.Grupems, ;
                    Contem    WITH crTmpMccr.Contems, ;
                    dContem   WITH loc_cRclis1, ;
                    Txt02     WITH loc_cTxt02, ;
                    Grupo     WITH loc_cGrupoPortador, ;
                    Conta     WITH loc_cContaPortador, ;
                    dConta    WITH loc_cRclis2, ;
                    cpfs      WITH loc_cCpfs2, ;
                    Txt03     WITH loc_cTxt03, ;
                    sGrupos   WITH crTmpMccr.sgrupos, ;
                    sContas   WITH crTmpMccr.sContas, ;
                    sdConta   WITH loc_cRclis3, ;
                    Obsc      WITH NVL(crTmpMccr.hist2s, " "), ;
                    Txt04     WITH loc_cTxt04, ;
                    Gruage    WITH crTmpMccr.Grupages, ;
                    contag    WITH crTmpMccr.Contages, ;
                    dContag   WITH loc_cRclis4, ;
                    DtEmis    WITH NVL(crTmpMccr.dtemis, DATE()), ;
                    Titban    WITH crTmpMccr.Titbans, ;
                    dtVencs   WITH crTmpMccr.Vencs, ;
                    Obs       WITH NVL(crTmpMccr.hist2s, " "), ;
                    Valor     WITH crTmpMccr.Valors, ;
                    Moeda     WITH crTmpMccr.Moedas, ;
                    Cotacao   WITH crTmpMccr.Cotacaos, ;
                    bgrupos   WITH crTmpMccr.bGrupos, ;
                    bContas   WITH crTmpMccr.bContas, ;
                    Obss      WITH loc_cObsd, ;
                    Hists     WITH loc_cHists, ;
                    DopCs     WITH crTmpMccr.Dopcs, ;
                    Usuars    WITH crTmpMccr.UsuAlts, ;
                    ValPrev   WITH crLocMccr.Valprev, ;
                    ValOrig   WITH crLocMccr.Valors, ;
                    ValOco    WITH crLocMccr.Valocurs, ;
                    EspecieNfs WITH crLocMccr.EspecieNfs, ;
                    TpDocNf   WITH crLocMccr.TpDocNf, ;
                    Compet    WITH crLocMccr.Compet, ;
                    ValLiq    WITH crTmpMccr.Valors + crLocMccr.Valocurs - ;
                                  (crTmpMccr.ValPags + crLocMccr.Valocurs)

                SELECT crTmpMccr
            ENDSCAN

            *-- 11. Se OptAgrupa=2, montar texto de recorrencias agrupadas
            IF THIS.this_nOptAgrupa = 2
                loc_cOpersFiltro = loc_cSinalOper
                SELECT a.* ;
                    FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                    WHERE a.Dopcs = b.dopes ;
                    AND a.Opers = loc_cOpersFiltro ;
                    AND a.Tipos = " " ;
                    AND a.EmpdopNcs <> loc_cEDNE ;
                    INTO CURSOR cursor_4c_LocalMccr1 ;
                    ORDER BY a.vencs

                loc_cObs = ""
                SELECT cursor_4c_LocalMccr1
                SCAN
                    IF cursor_4c_LocalMccr1.valprev = 0
                        loc_cObs = loc_cObs + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Emps) + "  " + ;
                            DTOC(cursor_4c_LocalMccr1.Datas) + "   " + ;
                            DTOC(cursor_4c_LocalMccr1.Vencs) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Titulos) + "   " + ;
                            TRANSFORM(cursor_4c_LocalMccr1.valors, "@Z 999,999,999.99") + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.bGrupos) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.DopCs) + CHR(13) + CHR(10)
                    ELSE
                        loc_cObs = loc_cObs + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Emps) + "  " + ;
                            DTOC(cursor_4c_LocalMccr1.Datas) + "   " + ;
                            DTOC(cursor_4c_LocalMccr1.Vencs) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Titulos) + "   " + ;
                            TRANSFORM(cursor_4c_LocalMccr1.valprev, "@Z 999,999,999.99") + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.bGrupos) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.DopCs) + CHR(13) + CHR(10)
                    ENDIF
                ENDSCAN

                SELECT crDBImp
                REPLACE ALL Recors WITH loc_cObs
            ENDIF

            *-- 12. Calcular totais por titulo
            SELECT Titulo, SUM(1) AS Qtdes ;
                FROM crDBImp ;
                GROUP BY Titulo ;
                ORDER BY Titulo ;
                INTO CURSOR cursor_4c_TmpCC

            SELECT crDBImp
            GO TOP
            loc_laTitulo = crDBImp.Titulo
            loc_lnTotVal = 0
            SCAN
                IF loc_laTitulo <> crDBImp.Titulo
                    loc_nReg = RECNO()
                    REPLACE ALL Valor WITH loc_lnTotVal FOR Titulo = loc_laTitulo
                    GO loc_nReg
                    loc_lnTotVal = 0
                    loc_laTitulo = crDBImp.Titulo
                ENDIF
                SELECT cursor_4c_TmpCC
                LOCATE FOR Titulo = crDBImp.Titulo
                IF cursor_4c_TmpCC.Qtdes = 1
                    SELECT crDBImp
                    REPLACE Obsc WITH ""
                    loc_lnTotVal = crDBImp.Valor
                ELSE
                    SELECT crDBImp
                    REPLACE Obs WITH ""
                    loc_lnTotVal = loc_lnTotVal + crDBImp.Valor
                    REPLACE Valorc WITH crDBImp.Valor
                    REPLACE Valor WITH 0
                ENDIF
                SELECT crDBImp
            ENDSCAN
            REPLACE ALL Valor WITH loc_lnTotVal FOR Titulo = loc_laTitulo
            GO TOP

            *-- 13. Atualizar DirFiscais se diretorio alternativo informado
            IF !EMPTY(ALLTRIM(THIS.this_cDiretorio))
                goSistema.DirFiscais = THIS.this_cDiretorio
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNomeFrx - Retorna caminho do FRX conforme opcoes de impressao
    * Logica original: procedures visualizacao/impressao/documento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    FUNCTION ObterNomeFrx()
        LOCAL loc_cFrx
        IF THIS.this_nOptTipo = 1
            IF THIS.this_nOptAgrupa = 2
                loc_cFrx = gc_4c_CaminhoReports + "SigReIdA"
            ELSE
                loc_cFrx = gc_4c_CaminhoReports + "SigReIdt"
            ENDIF
        ELSE
            loc_cFrx = gc_4c_CaminhoReports + "SigReIag"
        ENDIF
        RETURN loc_cFrx
    ENDFUNC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    * Logica original: PROCEDURE visualizacao em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com prompt de selecao de impressora
    * Logica original: PROCEDURE impressao em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Imprimir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Imprime relatorio sem prompt
    * Logica original: PROCEDURE documento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Documento")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem de erro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores e recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crDBImp")
            USE IN crDBImp
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

