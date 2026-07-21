# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 260: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 279: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 298: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 318: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 337: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprmdp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1377 linhas total):

*-- Linhas 108 a 157:
108:             *-- Container do cabecalho (cntSombra do legado)
109:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
110:             WITH THIS.cnt_4c_Cabecalho
111:                 .Top         = 0
112:                 .Left        = 0
113:                 .Width       = THIS.Width
114:                 .Height      = 80
115:                 .BackStyle   = 1
116:                 .BackColor   = RGB(100, 100, 100)
117:                 .BorderWidth = 0
118:                 .Visible     = .T.
119:             ENDWITH
120: 
121:             *-- Label sombra ? efeito de sombra no titulo (lblSombra do legado)
122:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
123:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
124:                 .AutoSize   = .F.
125:                 .FontBold   = .T.
126:                 .FontName   = "Tahoma"
127:                 .FontSize   = 18
128:                 .WordWrap   = .T.
129:                 .Alignment  = 0
130:                 .BackStyle  = 0
131:                 .Caption    = THIS.Caption
132:                 .Height     = 40
133:                 .Left       = 10
134:                 .Top        = 18
135:                 .Width      = THIS.cnt_4c_Cabecalho.Width
136:                 .ForeColor  = RGB(0, 0, 0)
137:             ENDWITH
138: 
139:             *-- Label titulo ? texto visivel sobre a sombra (lblTitulo do legado)
140:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
141:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
142:                 .AutoSize    = .F.
143:                 .FontBold    = .T.
144:                 .FontName    = "Tahoma"
145:                 .FontSize    = 18
146:                 .WordWrap    = .T.
147:                 .Alignment   = 0
148:                 .BackStyle   = 0
149:                 .Caption     = THIS.Caption
150:                 .Height      = 46
151:                 .Left        = 10
152:                 .Top         = 17
153:                 .Width       = THIS.cnt_4c_Cabecalho.Width
154:                 .ForeColor   = RGB(255, 255, 255)
155:                 .ToolTipText = "T" + CHR(237) + "tulo"
156:             ENDWITH
157: 

*-- Linhas 223 a 231:
223:     * ConfigurarPaginaDados
224:     * Form OPERACIONAL de layout flat (800x270, sem PageFrame): nao existe Page2.
225:     * Todos os campos de exibicao (cnt_4c_Result com txt_4c_Cpros, txt_4c_Arquivo,
226:     * cnt_4c_Barra com shp_4c_ShpBarra e lbl_4c_LblPorcento, alem dos labels
227:     * "Produto :", "Arquivo/Campo :" e "Progresso :") sao criados em
228:     * ConfigurarPainelResultado, delegada aqui para satisfazer o contrato da
229:     * pipeline multi-fase.
230:     *==========================================================================
231:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 240 a 359:
240:             *-- Shape decorativo de fundo (Shape1 do legado): Top=7,Left=502,W=90,H=110
241:             THIS.AddObject("shp_4c_Shape1", "Shape")
242:             WITH THIS.shp_4c_Shape1
243:                 .Top         = 7
244:                 .Left        = 502
245:                 .Height      = 110
246:                 .Width       = 90
247:                 .BackStyle   = 0
248:                 .BorderStyle = 0
249:                 .BorderColor = RGB(136, 189, 188)
250:                 .Visible     = .T.
251:             ENDWITH
252: 
253:             THIS.AddObject("cmd_4c_BtnIncluir", "CommandButton")
254:             WITH THIS.cmd_4c_BtnIncluir
255:                 .Top        = 3
256:                 .Left       = 425
257:                 .Height     = 75
258:                 .Width      = 75
259:                 .FontBold   = .T.
260:                 .FontItalic = .T.
261:                 .FontName   = "Comic Sans MS"
262:                 .FontSize   = 8
263:                 .ForeColor  = RGB(90, 90, 90)
264:                 .BackColor  = RGB(255, 255, 255)
265:                 .Themes           = .T.
266:                 .Caption    = "\<Incluir"
267:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
268:                 .TabIndex   = 1
269:                 .Visible    = .T.
270:             ENDWITH
271: 
272:             THIS.AddObject("cmd_4c_BtnExcluir", "CommandButton")
273:             WITH THIS.cmd_4c_BtnExcluir
274:                 .Top        = 3
275:                 .Left       = 500
276:                 .Height     = 75
277:                 .Width      = 75
278:                 .FontBold   = .T.
279:                 .FontItalic = .T.
280:                 .FontName   = "Comic Sans MS"
281:                 .FontSize   = 8
282:                 .ForeColor  = RGB(90, 90, 90)
283:                 .BackColor  = RGB(255, 255, 255)
284:                 .Themes           = .T.
285:                 .Caption    = "\<Excluir"
286:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
287:                 .TabIndex   = 2
288:                 .Visible    = .T.
289:             ENDWITH
290: 
291:             THIS.AddObject("cmd_4c_Exporta", "CommandButton")
292:             WITH THIS.cmd_4c_Exporta
293:                 .Top        = 3
294:                 .Left       = 575
295:                 .Height     = 75
296:                 .Width      = 75
297:                 .FontBold   = .T.
298:                 .FontItalic = .T.
299:                 .FontName   = "Comic Sans MS"
300:                 .FontSize   = 8
301:                 .WordWrap   = .T.
302:                 .ForeColor  = RGB(90, 90, 90)
303:                 .BackColor  = RGB(255, 255, 255)
304:                 .Themes           = .T.
305:                 .Caption    = "\<Importar"
306:                 .Picture    = gc_4c_CaminhoIcones + "importar_72.png"
307:                 .TabIndex   = 3
308:                 .Visible    = .T.
309:             ENDWITH
310: 
311:             THIS.AddObject("cmd_4c_BtnProcessar", "CommandButton")
312:             WITH THIS.cmd_4c_BtnProcessar
313:                 .Top        = 3
314:                 .Left       = 650
315:                 .Height     = 75
316:                 .Width      = 75
317:                 .FontBold   = .T.
318:                 .FontItalic = .T.
319:                 .FontName   = "Comic Sans MS"
320:                 .FontSize   = 8
321:                 .ForeColor  = RGB(90, 90, 90)
322:                 .BackColor  = RGB(255, 255, 255)
323:                 .Themes           = .T.
324:                 .Caption    = "\<Processar"
325:                 .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
326:                 .TabIndex   = 4
327:                 .Visible    = .T.
328:             ENDWITH
329: 
330:             THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
331:             WITH THIS.cmd_4c_BtnSair
332:                 .Top        = 3
333:                 .Left       = 725
334:                 .Height     = 75
335:                 .Width      = 75
336:                 .FontBold   = .T.
337:                 .FontItalic = .T.
338:                 .FontName   = "Comic Sans MS"
339:                 .FontSize   = 8
340:                 .ForeColor  = RGB(90, 90, 90)
341:                 .BackColor  = RGB(255, 255, 255)
342:                 .Themes           = .T.
343:                 .Caption    = "Encerrar"
344:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
345:                 .Cancel     = .T.
346:                 .TabIndex   = 7
347:                 .Visible    = .T.
348:             ENDWITH
349: 
350:             BINDEVENT(THIS.cmd_4c_BtnIncluir,   "Click", THIS, "BtnIncluirClick")
351:             BINDEVENT(THIS.cmd_4c_BtnExcluir,   "Click", THIS, "BtnExcluirClick")
352:             BINDEVENT(THIS.cmd_4c_Exporta,      "Click", THIS, "BtnExportaClick")
353:             BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "BtnProcessarClick")
354:             BINDEVENT(THIS.cmd_4c_BtnSair,      "Click", THIS, "BtnSairClick")
355: 
356:         CATCH TO loc_oErro
357:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
358:                 "Erro ConfigurarBotoes Formsigprmdp")
359:         ENDTRY

*-- Linhas 367 a 376:
367:             THIS.AddObject("grd_4c_Dados", "Grid")
368:             loc_oGrd = THIS.grd_4c_Dados
369:             WITH loc_oGrd
370:                 .Top               = 101
371:                 .Left              = 147
372:                 .Width             = 269
373:                 .Height            = 148
374:                 .ColumnCount       = 2
375:                 .AllowHeaderSizing = .F.
376:                 .AllowRowSizing    = .F.

*-- Linhas 394 a 402:
394:                         .FontName  = "Tahoma"
395:                         .FontSize  = 8
396:                         .Alignment = 2
397:                         .Caption   = "C" + CHR(243) + "digo Original"
398:                     ENDWITH
399:                     WITH .Text1
400:                         .BorderStyle = 0
401:                         .Margin      = 0
402:                         .ForeColor   = RGB(0, 0, 0)

*-- Linhas 410 a 418:
410:                         .FontName  = "Tahoma"
411:                         .FontSize  = 8
412:                         .Alignment = 2
413:                         .Caption   = "Novo C" + CHR(243) + "digo"
414:                     ENDWITH
415:                     WITH .Text1
416:                         .BorderStyle = 0
417:                         .Margin      = 0
418:                         .ForeColor   = RGB(0, 0, 0)

*-- Linhas 437 a 470:
437:         TRY
438:             THIS.AddObject("cnt_4c_Result", "Container")
439:             WITH THIS.cnt_4c_Result
440:                 .Top           = 101
441:                 .Left          = 440
442:                 .Width         = 213
443:                 .Height        = 146
444:                 .BackStyle     = 0
445:                 .BorderWidth   = 0
446:                 .SpecialEffect = 0
447:                 .TabIndex      = 6
448:                 .Visible     = .T.
449:             ENDWITH
450: 
451:             THIS.cnt_4c_Result.AddObject("lbl_4c_Label2", "Label")
452:             WITH THIS.cnt_4c_Result.lbl_4c_Label2
453:                 .Caption   = "Produto : "
454:                 .Left      = 8
455:                 .Top       = 2
456:                 .FontName  = "Tahoma"
457:                 .FontSize  = 8
458:                 .BackStyle = 0
459:                 .AutoSize  = .T.
460:             ENDWITH
461: 
462:             THIS.cnt_4c_Result.AddObject("txt_4c_Cpros", "TextBox")
463:             WITH THIS.cnt_4c_Result.txt_4c_Cpros
464:                 .Top               = 19
465:                 .Left              = 5
466:                 .Width             = 108
467:                 .Height            = 24
468:                 .FontName          = "Tahoma"
469:                 .FontSize          = 8
470:                 .Alignment         = 3

*-- Linhas 479 a 501:
479:                 .BorderColor       = RGB(100, 100, 100)
480:             ENDWITH
481: 
482:             THIS.cnt_4c_Result.AddObject("lbl_4c_Label5", "Label")
483:             WITH THIS.cnt_4c_Result.lbl_4c_Label5
484:                 .Caption   = "Arquivo/Campo :"
485:                 .Left      = 7
486:                 .Top       = 45
487:                 .FontName  = "Tahoma"
488:                 .FontSize  = 8
489:                 .BackStyle = 0
490:                 .AutoSize  = .T.
491:             ENDWITH
492: 
493:             THIS.cnt_4c_Result.AddObject("txt_4c_Arquivo", "TextBox")
494:             WITH THIS.cnt_4c_Result.txt_4c_Arquivo
495:                 .Top               = 62
496:                 .Left              = 4
497:                 .Width             = 204
498:                 .Height            = 24
499:                 .FontName          = "Tahoma"
500:                 .FontSize          = 8
501:                 .Alignment         = 3

*-- Linhas 510 a 554:
510:                 .BorderColor       = RGB(100, 100, 100)
511:             ENDWITH
512: 
513:             THIS.cnt_4c_Result.AddObject("lbl_4c_Label1", "Label")
514:             WITH THIS.cnt_4c_Result.lbl_4c_Label1
515:                 .Caption   = "Progresso :"
516:                 .Left      = 7
517:                 .Top       = 100
518:                 .FontName  = "Tahoma"
519:                 .FontSize  = 8
520:                 .BackStyle = 0
521:                 .AutoSize  = .T.
522:             ENDWITH
523: 
524:             THIS.cnt_4c_Result.AddObject("cnt_4c_Barra", "Container")
525:             WITH THIS.cnt_4c_Result.cnt_4c_Barra
526:                 .Top         = 116
527:                 .Left        = 5
528:                 .Width       = 202
529:                 .Height      = 21
530:                 .BorderColor = RGB(100, 100, 100)
531:                 .Visible     = .T.
532:             ENDWITH
533: 
534:             THIS.cnt_4c_Result.cnt_4c_Barra.AddObject("shp_4c_ShpBarra", "Shape")
535:             WITH THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra
536:                 .Top         = 1
537:                 .Left        = 1
538:                 .Height      = 19
539:                 .Width       = 0
540:                 .BackColor   = RGB(0, 128, 0)
541:                 .BorderColor = RGB(100, 100, 100)
542:                 .Visible     = .T.
543:             ENDWITH
544: 
545:             THIS.cnt_4c_Result.cnt_4c_Barra.AddObject("lbl_4c_LblPorcento", "Label")
546:             WITH THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento
547:                 .Caption   = "0 %"
548:                 .Left      = 93
549:                 .Top       = 4
550:                 .FontName  = "Tahoma"
551:                 .FontSize  = 8
552:                 .ForeColor = RGB(255, 255, 255)
553:                 .BackStyle = 0
554:                 .AutoSize  = .T.

*-- Linhas 570 a 578:
570:             THIS.cnt_4c_Result.Visible = par_lMostrar
571:             IF par_lMostrar
572:                 THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
573:                 THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
574:                 THIS.cnt_4c_Result.txt_4c_Cpros.Value   = ""
575:                 THIS.cnt_4c_Result.txt_4c_Arquivo.Value = ""
576:             ENDIF
577:         ENDIF
578:     ENDPROC

*-- Linhas 805 a 813:
805:                 loc_nCnt = 1
806:             ENDIF
807: 
808:             THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
809:             THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
810: 
811:             SELECT csContas
812:             SCAN
813:                 THIS.cnt_4c_Result.txt_4c_Cpros.Value = ALLTRIM(NVL(csContas.CprosAnt, ""))

*-- Linhas 1032 a 1040:
1032:                     loc_nRec = loc_nRec + 1
1033:                     loc_nPct = INT((loc_nRec * 100) / loc_nCnt)
1034:                     THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width = loc_nPct * 2
1035:                     THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = ;
1036:                         ALLTRIM(STR(loc_nPct)) + " %"
1037:                     THIS.cnt_4c_Result.cnt_4c_Barra.Refresh
1038:                     SELECT csArquivos
1039:                 ENDSCAN  && csArquivos
1040: 

*-- Linhas 1268 a 1286:
1268:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1269:             THIS.grd_4c_Dados.Enabled = par_lHabilitar
1270:         ENDIF
1271:         IF PEMSTATUS(THIS, "cmd_4c_BtnIncluir", 5)
1272:             THIS.cmd_4c_BtnIncluir.Enabled = par_lHabilitar
1273:         ENDIF
1274:         IF PEMSTATUS(THIS, "cmd_4c_BtnExcluir", 5)
1275:             THIS.cmd_4c_BtnExcluir.Enabled = par_lHabilitar
1276:         ENDIF
1277:         IF PEMSTATUS(THIS, "cmd_4c_Exporta", 5)
1278:             THIS.cmd_4c_Exporta.Enabled = par_lHabilitar
1279:         ENDIF
1280:         IF PEMSTATUS(THIS, "cmd_4c_BtnProcessar", 5)
1281:             THIS.cmd_4c_BtnProcessar.Enabled = par_lHabilitar
1282:         ENDIF
1283:     ENDPROC
1284: 
1285:     *==========================================================================
1286:     * LimparCampos - Reseta csContas para linha em branco unica + limpa painel

*-- Linhas 1299 a 1307:
1299:             THIS.cnt_4c_Result.txt_4c_Arquivo.Value = ""
1300:             IF PEMSTATUS(THIS.cnt_4c_Result, "cnt_4c_Barra", 5)
1301:                 THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
1302:                 THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
1303:             ENDIF
1304:             THIS.cnt_4c_Result.Visible = .F.
1305:         ENDIF
1306: 
1307:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)


### BO (C:\4c\projeto\app\classes\sigprmdpBO.prg):
*==============================================================================
* sigprmdpBO.prg - Business Object para Substitui??o de Refer?ncias de Produtos
* Tabela: SigOpClC (opera??es de recalculo de custo/estoque)
* Heran?a: BusinessBase
* Data: 2026-07-17
*==============================================================================
* FASE 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigprmdpBO AS BusinessBase

    *-- Chave e tabela principal (SigOpClC: recalculo de custo/estoque)
    this_cTabela      = "SigOpClC"
    this_cCampoChave  = "CidChaves"

    *-- Flags de controle de comportamento (parametros do form original)
    this_lCheckCadPro   = .F.   && Se .T., pula valida??o do produto no SigCdPro
    this_lManterBarra   = .F.   && Se .T., mant?m o c?digo de barras do produto antigo
    this_lCalculaCusto  = .F.   && Se .T., recalcula custo ap?s substitui??o

    *-- Par de c?digos sendo processado no loop atual
    this_cCprosAnt      = ""    && C?digo de produto antigo (Cpros char(14))
    this_cCprosNov      = ""    && C?digo de produto novo (Cpros char(14))

    *-- Atributos do produto antigo capturados antes do processamento
    this_nBarraAnt      = 0     && C?digo de barras (Cbars) do produto antigo

    *-- Estado de progresso do processamento em lote
    this_nTotal         = 0     && Total de pares a processar (csContas * csCampos)
    this_nProcessados   = 0     && Pares j? processados (para barra de progresso)
    this_nErro          = 0     && C?digo do ?ltimo erro de SQL (< 1 = falha)

    *-- Feedback visual do arquivo/campo sendo processado no momento
    this_cArquivoAtual  = ""    && Nome do arquivo DBF sendo atualizado
    this_cCampoAtual    = ""    && Nome do campo sendo atualizado no arquivo

    *-- C?digo do usu?rio logado (capturado no Init para auditoria)
    this_cUsuar         = ""    && Usuar - usu?rio logado

    *--------------------------------------------------------------------------
    * Init - Configura??o inicial do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        this.this_cTabela     = "SigOpClC"
        this.this_cCampoChave = "CidChaves"

        *-- Captura usu?rio logado para auditoria (fGravarLog)
        IF TYPE("gc_4c_UsuarioLogado") = "C" AND !EMPTY(gc_4c_UsuarioLogado)
            this.this_cUsuar = gc_4c_UsuarioLogado
        ENDIF
    ENDPROC


    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor (csContas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCprosAnt = TratarNulo(CprosAnt, "C")
            THIS.this_cCprosNov = TratarNulo(CprosNov, "C")
            THIS.this_nBarraAnt = TratarNulo(BarraAnt, "N")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna campo chave prim?ria de SigOpClC
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCampoChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados m?nimos antes de Inserir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCprosNov)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto novo " + ;
                CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF EMPTY(go_4c_Sistema.cCodEmpresa)
            THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o configurada no sistema."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere pendencia de recalculo em SigOpClC
    * Sobrescreve BusinessBase.Inserir (chamado por Salvar quando lNovoRegistro=.T.)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves) VALUES (" + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                EscaparSQL(THIS.this_cCprosNov) + ", " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa + THIS.this_cCprosNov) + ", " + ;
                FormatarDataSQL(DATE()) + ", " + ;
                EscaparSQL(THIS.this_cUsuar) + ", " + ;
                EscaparSQL(loc_cCidChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao inserir pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cCampoChave = loc_cCidChaves
            THIS.RegistrarAuditoria("INSERT")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir em SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza pendencia em SigOpClC (data/usuario da requisicao)
    * Sobrescreve BusinessBase.Atualizar (chamado por Salvar quando lNovoRegistro=.F.)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCampoChave)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria ausente para atualiza" + CHR(231) + CHR(227) + "o."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigOpClC SET " + ;
                "CPros = " + EscaparSQL(THIS.this_cCprosNov) + ", " + ;
                "EmpCPros = " + EscaparSQL(go_4c_Sistema.cCodEmpresa + THIS.this_cCprosNov) + ", " + ;
                "Datas = " + FormatarDataSQL(DATE()) + ", " + ;
                "Usuars = " + EscaparSQL(THIS.this_cUsuar) + " " + ;
                "WHERE CidChaves = " + EscaparSQL(THIS.this_cCampoChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao atualizar pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove pend?ncia de rec?lculo de SigOpClC
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpClC WHERE CidChaves = " + ;
                EscaparSQL(THIS.this_cCampoChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao excluir pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir de SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursorContas - Cria cursor local de pares de substitui??o
    *--------------------------------------------------------------------------
    FUNCTION InicializarCursorContas()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("csContas")
                USE IN csContas
            ENDIF

            SET NULL ON
            CREATE CURSOR csContas (CprosAnt C(14) NULL, CprosNov C(14) NULL, Flag L NULL, BarraAnt N(8) NULL)
            SET NULL OFF

            INDEX ON CprosAnt + CprosNov TAG Duplica
            INDEX ON CprosAnt TAG CprosAnt
            INDEX ON CprosNov TAG CprosNov
            SET ORDER TO

            INSERT INTO csContas (CprosAnt, CprosNov) VALUES ("", "")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar cursor de substitui" + CHR(231) + CHR(245) + "es")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarCalcCustos - Busca configura??o de c?lculo de custos em SigCdPaC
    * Seta this_lCalculaCusto = .T. se CalcCustos <> 3
    *--------------------------------------------------------------------------
    FUNCTION BuscarCalcCustos()
        LOCAL loc_nCalcCustos, loc_oErro, loc_cSQL
        loc_nCalcCustos = 0

        TRY
            loc_cSQL = "SELECT CalcCustos FROM SigCdPaC ORDER BY CalcCustos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CalcCustos") > 0
                IF USED("cursor_4c_CalcCustos") AND RECCOUNT("cursor_4c_CalcCustos") > 0
                    SELECT cursor_4c_CalcCustos
                    loc_nCalcCustos = NVL(CalcCustos, 0)
                ENDIF
                IF USED("cursor_4c_CalcCustos")
                    USE IN cursor_4c_CalcCustos
                ENDIF
            ELSE
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigCdPaC)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de c" + CHR(225) + "lculo")
        ENDTRY

        THIS.this_lCalculaCusto = (loc_nCalcCustos <> 3)
        RETURN loc_nCalcCustos
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParesNoGrid - Valida todos os pares em csContas antes do processamento
    * Retorna "" se OK, mensagem de erro se houver inconsist?ncia
    *--------------------------------------------------------------------------
    FUNCTION ValidarParesNoGrid(par_lCheckCadPro, par_lManterBarra)
        LOCAL loc_cMensagem, loc_oErro, loc_cSQL, loc_nErro, loc_cEstoqsNov
        loc_cMensagem = ""

        TRY
            SELECT csContas
            GO TOP

            IF EOF()
                loc_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
                loc_lSucesso = loc_cMensagem
            ENDIF

            SELECT csContas
            SCAN
                IF EMPTY(csContas.CprosAnt)
                    loc_cMensagem = "Existe Uma Referencia Antiga Inv" + CHR(225) + "lida!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF !par_lCheckCadPro
                    loc_cSQL = "SELECT TOP 1 Cpros, Cbars FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(ALLTRIM(csContas.CprosAnt))
                    loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
                    IF loc_nErro < 1 OR (USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") = 0)
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        loc_cMensagem = "Existe Uma Referencia Antiga Inv" + CHR(225) + "lida!!!"
                        loc_lSucesso = loc_cMensagem
                    ENDIF
                    IF USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                        SELECT cursor_4c_TmpPro
                        REPLACE BarraAnt WITH NVL(cursor_4c_TmpPro.Cbars, 0) IN csContas
                        USE IN cursor_4c_TmpPro
                    ENDIF
                ENDIF

                IF par_lManterBarra AND csContas.BarraAnt = 0
                    loc_cMensagem = "Existe Uma Referencia Antigo Sem Barra !!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF EMPTY(csContas.CprosNov)
                    loc_cMensagem = "Existe Uma Referencia Nova Inv" + CHR(225) + "lida!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF csContas.CprosAnt = csContas.CprosNov
                    loc_cMensagem = "Existe Uma Referencia Antiga e Uma Referencia Nova Com o Mesmo C" + CHR(243) + "digo!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                loc_cSQL = "SELECT a.Cgrus, b.Cestoqs FROM SigCdPro a " + ;
                    "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                    "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(csContas.CprosNov))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") > 0
                    IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                        SELECT cursor_4c_LocalPro
                        loc_cEstoqsNov = ALLTRIM(NVL(cursor_4c_LocalPro.Cestoqs, ""))
                        USE IN cursor_4c_LocalPro

                        loc_cSQL = "SELECT a.Cgrus, b.Cestoqs FROM SigCdPro a " + ;
                            "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                            "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(csContas.CprosAnt))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro2") > 0
                            IF USED("cursor_4c_LocalPro2") AND RECCOUNT("cursor_4c_LocalPro2") > 0
                                SELECT cursor_4c_LocalPro2
                                IF ALLTRIM(NVL(cursor_4c_LocalPro2.Cestoqs, "")) <> loc_cEstoqsNov
                                    USE IN cursor_4c_LocalPro2
                                    loc_cMensagem = "Existe Uma Referencia Antiga e Uma Referencia Nova com Controle de Estoque diferente!!!"
                                    loc_lSucesso = loc_cMensagem
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_LocalPro2")
                                USE IN cursor_4c_LocalPro2
                            ENDIF
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            loc_cMensagem = "Erro na valida" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
        ENDTRY

        RETURN loc_cMensagem
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirPendencia - Insere linha em SigOpClC para rec?lculo posterior
    * Chamado no loop de processamento para cada produto/empresa
    *--------------------------------------------------------------------------
    FUNCTION InserirPendencia(par_cEmps, par_cCpros, par_dData)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = fUniqueIds()
            loc_cSQL = "INSERT INTO SigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves) VALUES (" + ;
                EscaparSQL(par_cEmps) + ", " + ;
                EscaparSQL(par_cCpros) + ", " + ;
                EscaparSQL(par_cEmps + par_cCpros) + ", " + ;
                FormatarDataSQL(par_dData) + ", " + ;
                EscaparSQL(THIS.this_cUsuar) + ", " + ;
                EscaparSQL(loc_cCidChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir pend" + CHR(234) + "ncia em SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarXLS - Importa pares de substitui??o de planilha Excel para csContas
    * Retorna n?mero de registros importados com sucesso
    *--------------------------------------------------------------------------
    FUNCTION ImportarXLS(par_cArquivoXLS, par_lCheckCadPro)
        LOCAL loc_nImportados, loc_oErro, loc_cSQL, loc_cCprosAnt, loc_cCprosNov
        loc_nImportados = 0

        TRY
            IF !FILE(par_cArquivoXLS)
                MsgErro("Arquivo Excel n" + CHR(227) + "o encontrado: " + par_cArquivoXLS, "Erro")
                loc_lSucesso = 0
            ENDIF

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF

            CREATE CURSOR cursor_4c_Importa (CprosAnt C(14), CprosNov C(14))
            INDEX ON CprosAnt TAG CprosAnt

            SELECT cursor_4c_Importa
            APPEND FROM (par_cArquivoXLS) TYPE XLS

            SELECT cursor_4c_Importa
            SCAN
                loc_cCprosAnt = ALLTRIM(cursor_4c_Importa.CprosAnt)
                loc_cCprosNov = ALLTRIM(cursor_4c_Importa.CprosNov)

                IF EMPTY(loc_cCprosAnt) OR EMPTY(loc_cCprosNov) OR loc_cCprosAnt = loc_cCprosNov
                    LOOP
                ENDIF

                IF !par_lCheckCadPro
                    loc_cSQL = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(loc_cCprosAnt)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") < 1
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        LOOP
                    ENDIF
                    IF !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        LOOP
                    ENDIF
                    IF USED("cursor_4c_TmpPro")
                        USE IN cursor_4c_TmpPro
                    ENDIF
                ENDIF

                SELECT csContas
                SET ORDER TO Duplica
                IF !SEEK(loc_cCprosAnt + loc_cCprosNov)
                    APPEND BLANK
                    REPLACE CprosAnt WITH loc_cCprosAnt, CprosNov WITH loc_cCprosNov
                    loc_nImportados = loc_nImportados + 1
                ENDIF
            ENDSCAN

            SELECT csContas
            SET ORDER TO
            GO BOTTOM

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao importar planilha Excel")
        ENDTRY

        RETURN loc_nImportados
    ENDFUNC

ENDDEFINE

