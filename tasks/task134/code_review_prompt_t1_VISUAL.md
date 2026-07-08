# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 269: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 292: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 316: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 353: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdAco.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1170 linhas total):

*-- Linhas 115 a 162:
115:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
116:         loc_oCnt = THIS.cnt_4c_Cabecalho
117:         WITH loc_oCnt
118:             .Top         = 0
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackStyle   = 1
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
129:         WITH loc_oCnt.lbl_4c_LblSombra
130:             .Top       = 18
131:             .Left      = 10
132:             .Width     = 769
133:             .Height    = 40
134:             .FontBold  = .T.
135:             .FontName  = "Tahoma"
136:             .FontSize  = 18
137:             .WordWrap  = .T.
138:             .Alignment = 0
139:             .BackStyle = 0
140:             .Caption   = "Acompanhamento de Material por Grupo"
141:             .ForeColor = RGB(0, 0, 0)
142:             .Visible   = .T.
143:         ENDWITH
144: 
145:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
146:         WITH loc_oCnt.lbl_4c_LblTitulo
147:             .Top       = 17
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 46
151:             .FontBold  = .T.
152:             .FontName  = "Tahoma"
153:             .FontSize  = 18
154:             .WordWrap  = .T.
155:             .Alignment = 0
156:             .BackStyle = 0
157:             .Caption   = "Acompanhamento de Material por Grupo"
158:             .ForeColor = RGB(255, 255, 255)
159:             .Visible   = .T.
160:         ENDWITH
161:     ENDPROC
162: 

*-- Linhas 168 a 204:
168:         THIS.AddObject("cnt_4c_Aguarde", "Container")
169:         loc_oCnt = THIS.cnt_4c_Aguarde
170:         WITH loc_oCnt
171:             .Top           = 287
172:             .Left          = 117
173:             .Width         = 516
174:             .Height        = 139
175:             .SpecialEffect = 0
176:             .Visible       = .F.
177:         ENDWITH
178: 
179:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
180:         WITH loc_oCnt.lbl_4c_Label1
181:             .Top       = 28
182:             .Left      = 206
183:             .Width     = 105
184:             .Height    = 29
185:             .FontBold  = .T.
186:             .FontSize  = 14
187:             .Caption   = "Aguarde..."
188:             .ForeColor = RGB(255, 0, 0)
189:         ENDWITH
190: 
191:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
192:         WITH loc_oCnt.lbl_4c_Label2
193:             .Top       = 79
194:             .Left      = 135
195:             .Width     = 242
196:             .Height    = 27
197:             .FontBold  = .T.
198:             .FontSize  = 14
199:             .Caption   = "Processando Dados ......"
200:             .ForeColor = RGB(0, 0, 160)
201:         ENDWITH
202:     ENDPROC
203: 
204:     *==========================================================================

*-- Linhas 217 a 226:
217:                           "CNT_4C_AGUARDE",    ;
218:                           "CNT_4C_CABECALHO",  ;
219:                           "SHP_4C_SHPRP",      ;
220:                           "CMD_4C_CMDRPVIEW",  ;
221:                           "CMD_4C_CMDRPPRINT")
222:                     LOOP
223:                 ENDIF
224: 
225:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
226:                     loc_oControl.Visible = .T.

*-- Linhas 253 a 277:
253:         *-- Shape de fundo para area de botoes de relatorio (oculto ate processar)
254:         THIS.AddObject("shp_4c_ShpRp", "Shape")
255:         WITH THIS.shp_4c_ShpRp
256:             .Top         = 7
257:             .Left        = 552
258:             .Width       = 229
259:             .Height      = 110
260:             .BackStyle   = 0
261:             .BorderColor = RGB(136, 189, 188)
262:             .Visible     = .F.
263:         ENDWITH
264: 
265:         *-- Botao Processar (sempre visivel apos TornarControlesVisiveis)
266:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
267:         WITH THIS.cmd_4c_Processar
268:             .Top             = 3
269:             .Left            = 500
270:             .Width           = 75
271:             .Height          = 75
272:             .Caption         = "Processar"
273:             .FontName        = "Comic Sans MS"
274:             .FontBold        = .T.
275:             .FontItalic      = .T.
276:             .FontSize        = 8
277:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 283 a 300:
283:             .WordWrap        = .T.
284:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
285:         ENDWITH
286:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
287: 
288:         *-- Botao Visualizar relatorio em tela (oculto ate processar)
289:         THIS.AddObject("cmd_4c_CmdRpview", "CommandButton")
290:         WITH THIS.cmd_4c_CmdRpview
291:             .Top             = 3
292:             .Left            = 650
293:             .Width           = 75
294:             .Height          = 75
295:             .Caption         = "V" + CHR(237) + "deo"
296:             .FontName        = "Comic Sans MS"
297:             .FontBold        = .T.
298:             .FontItalic      = .T.
299:             .FontSize        = 8
300:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 307 a 324:
307:             .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
308:             .Visible         = .F.
309:         ENDWITH
310:         BINDEVENT(THIS.cmd_4c_CmdRpview, "Click", THIS, "BtnCmdRpviewClick")
311: 
312:         *-- Botao Imprimir relatorio (oculto ate processar)
313:         THIS.AddObject("cmd_4c_CmdRpPrint", "CommandButton")
314:         WITH THIS.cmd_4c_CmdRpPrint
315:             .Top             = 3
316:             .Left            = 575
317:             .Width           = 75
318:             .Height          = 75
319:             .Caption         = "Impressora"
320:             .FontName        = "Comic Sans MS"
321:             .FontBold        = .T.
322:             .FontItalic      = .T.
323:             .FontSize        = 8
324:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 331 a 361:
331:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
332:             .Visible         = .F.
333:         ENDWITH
334:         BINDEVENT(THIS.cmd_4c_CmdRpPrint, "Click", THIS, "BtnCmdRpPrintClick")
335: 
336:         *-- CommandGroup de saida equivalente a Encerrar (posicao top-right no form 800px)
337:         THIS.AddObject("obj_4c_CmdGprocessa", "CommandGroup")
338:         WITH THIS.obj_4c_CmdGprocessa
339:             .Top           = -2
340:             .Left          = 720
341:             .Width         = 85
342:             .Height        = 85
343:             .ButtonCount   = 1
344:             .BackStyle     = 0
345:             .BorderStyle   = 0
346:             .Themes        = .F.
347:             .AutoSize      = .T.
348:             .SpecialEffect = 1
349:             .BorderColor   = RGB(136, 189, 188)
350:         ENDWITH
351:         WITH THIS.obj_4c_CmdGprocessa.Buttons(1)
352:             .Left            = 5
353:             .Top             = 5
354:             .Width           = 75
355:             .Height          = 75
356:             .Caption         = "Encerrar"
357:             .FontName        = "Comic Sans MS"
358:             .FontBold        = .T.
359:             .FontItalic      = .T.
360:             .FontSize        = 8
361:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 372 a 412:
372:         *-- Listbox de grupos para filtro (Arquivos no legado)
373:         THIS.AddObject("obj_4c_Arquivos", "ListBox")
374:         WITH THIS.obj_4c_Arquivos
375:             .Top           = 122
376:             .Left          = 84
377:             .Width         = 169
378:             .Height        = 79
379:             .FontName      = "Tahoma"
380:             .FontSize      = 8
381:             .ForeColor     = RGB(90, 90, 90)
382:             .BackColor     = RGB(255, 255, 255)
383:             .RowSourceType = 1
384:             .Sorted        = .T.
385:         ENDWITH
386:         BINDEVENT(THIS.obj_4c_Arquivos, "InteractiveChange", THIS, "ArquivosInteractiveChange")
387: 
388:         *-- Label "Grupos :" (Label7 no legado)
389:         THIS.AddObject("lbl_4c_Label7", "Label")
390:         WITH THIS.lbl_4c_Label7
391:             .Top       = 124
392:             .Left      = 34
393:             .Width     = 48
394:             .Height    = 15
395:             .Caption   = "Grupos :"
396:             .FontName  = "Tahoma"
397:             .FontSize  = 8
398:             .ForeColor = RGB(90, 90, 90)
399:             .BackStyle = 0
400:         ENDWITH
401: 
402:         *-- Grid principal (GrdF no legado) - 10 colunas mapeadas para csRel
403:         THIS.AddObject("grd_4c_Dados", "Grid")
404:         loc_oGrd = THIS.grd_4c_Dados
405:         WITH loc_oGrd
406:             .Top                = 205
407:             .Left               = 34
408:             .Width              = 732
409:             .Height             = 272
410:             .ColumnCount        = 10
411:             .FontName           = "Verdana"
412:             .FontSize           = 8

*-- Linhas 429 a 482:
429:             .Column1.ControlSource   = "csRel.Mat2s"
430:             .Column1.Width           = 80
431:             .Column1.Alignment       = 0
432:             .Column1.Header1.Caption = "Material"
433: 
434:             .Column2.ControlSource   = "csRel.Dcompo2s"
435:             .Column2.Width           = 130
436:             .Column2.Alignment       = 0
437:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
438: 
439:             .Column3.ControlSource   = "csRel.CUnis"
440:             .Column3.Width           = 27
441:             .Column3.Alignment       = 2
442:             .Column3.Header1.Caption = "Unid"
443: 
444:             .Column4.ControlSource   = "csRel.QtdMins"
445:             .Column4.Width           = 63
446:             .Column4.Alignment       = 2
447:             .Column4.Header1.Caption = "Qt.Minima"
448: 
449:             .Column5.ControlSource   = "csRel.Qtds"
450:             .Column5.Width           = 63
451:             .Column5.Alignment       = 2
452:             .Column5.Header1.Caption = "Saldo Atual"
453: 
454:             .Column6.ControlSource   = "csRel.QtdReqs"
455:             .Column6.Width           = 65
456:             .Column6.Alignment       = 2
457:             .Column6.Header1.Caption = "Requisi" + CHR(231) + CHR(227) + "o"
458: 
459:             .Column7.ControlSource   = "csRel.QtdPedcs"
460:             .Column7.Width           = 65
461:             .Column7.Alignment       = 2
462:             .Column7.Header1.Caption = "Ped.Compra"
463: 
464:             .Column8.ControlSource   = "csRel.QtdComps"
465:             .Column8.Width           = 65
466:             .Column8.Alignment       = 2
467:             .Column8.Header1.Caption = "Compra"
468: 
469:             .Column9.ControlSource   = "csRel.QtdEmphs"
470:             .Column9.Width           = 65
471:             .Column9.Alignment       = 2
472:             .Column9.Header1.Caption = "Empenho"
473: 
474:             .Column10.ControlSource   = "csRel.QtdPfins"
475:             .Column10.Width           = 70
476:             .Column10.Alignment       = 2
477:             .Column10.Header1.Caption = "Pos.Final *"
478:         ENDWITH
479: 
480:         *-- Propriedades visuais pixel-perfect (BackColor por coluna, ReadOnly, DynamicForeColor)
481:         THIS.ConfigurarGrdDados(loc_oGrd)
482:     ENDPROC

*-- Linhas 488 a 518:
488:     *==========================================================================
489:     PROTECTED PROCEDURE ConfigurarPaginaDados()
490:         *-- Label3: formula de Pos.Final (rodape pixel-perfect do legado)
491:         THIS.AddObject("lbl_4c_Label3", "Label")
492:         WITH THIS.lbl_4c_Label3
493:             .Top       = 487
494:             .Left      = 117
495:             .Width     = 585
496:             .Height    = 15
497:             .Caption   = "( * ) Pos.Final = Saldo Atual + Requisi" + CHR(231) + CHR(227) + "o + " + ;
498:                          "Ped.Compra + Compra - Empenho - Qt.M" + CHR(237) + "nima"
499:             .FontName  = "Tahoma"
500:             .FontBold  = .T.
501:             .FontSize  = 8
502:             .ForeColor = RGB(90, 90, 90)
503:             .BackStyle = 0
504:         ENDWITH
505: 
506:         *-- Label4: nota sobre marcadores [*] (peso medio)
507:         THIS.AddObject("lbl_4c_Label4", "Label")
508:         WITH THIS.lbl_4c_Label4
509:             .Top       = 507
510:             .Left      = 118
511:             .Width     = 372
512:             .Height    = 15
513:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o = [ * ]   Calculado pelo Peso M" + CHR(233) + "dio do Material"
514:             .FontName  = "Tahoma"
515:             .FontBold  = .T.
516:             .FontSize  = 8
517:             .ForeColor = RGB(90, 90, 90)
518:             .BackStyle = 0

*-- Linhas 530 a 539:
530:             THIS.this_oBusinessObject.this_lProcessamento = .F.
531:         ENDIF
532:         THIS.shp_4c_ShpRp.Visible      = .F.
533:         THIS.cmd_4c_CmdRpview.Visible  = .F.
534:         THIS.cmd_4c_CmdRpPrint.Visible = .F.
535:         THIS.BtnProcessarClick()
536:     ENDPROC
537: 
538:     *==========================================================================
539:     * BtnAlterarClick - Atualiza dados do relatorio (re-processamento)

*-- Linhas 603 a 612:
603:         ENDIF
604: 
605:         THIS.shp_4c_ShpRp.Visible      = .F.
606:         THIS.cmd_4c_CmdRpview.Visible  = .F.
607:         THIS.cmd_4c_CmdRpPrint.Visible = .F.
608:         THIS.grd_4c_Dados.Refresh
609:     ENDPROC
610: 
611:     *==========================================================================
612:     * BtnProcessarClick - Processa dados e popula grid

*-- Linhas 642 a 651:
642:                 ENDIF
643:                 THIS.grd_4c_Dados.Refresh
644:                 THIS.shp_4c_ShpRp.Visible     = .T.
645:                 THIS.cmd_4c_CmdRpview.Visible  = .T.
646:                 THIS.cmd_4c_CmdRpPrint.Visible = .T.
647:                 THIS.obj_4c_Arquivos.SetFocus
648:             ELSE
649:                 MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + "o!!!", "Aviso")
650:             ENDIF
651:         ENDIF

*-- Linhas 1054 a 1080:
1054:         IF VARTYPE(THIS.shp_4c_ShpRp) = "O"
1055:             THIS.shp_4c_ShpRp.Visible = loc_lProcessado
1056:         ENDIF
1057:         IF VARTYPE(THIS.cmd_4c_CmdRpview) = "O"
1058:             THIS.cmd_4c_CmdRpview.Visible = loc_lProcessado
1059:         ENDIF
1060:         IF VARTYPE(THIS.cmd_4c_CmdRpPrint) = "O"
1061:             THIS.cmd_4c_CmdRpPrint.Visible = loc_lProcessado
1062:         ENDIF
1063:     ENDPROC
1064: 
1065:     *==========================================================================
1066:     * HabilitarCampos - Habilita/desabilita controles conforme estado
1067:     *   Form OPERACIONAL: controla o listbox de grupos (apenas quando ha
1068:     *   dados processados). Botao Processar permanece sempre habilitado.
1069:     *==========================================================================
1070:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1071:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O"
1072:             THIS.obj_4c_Arquivos.Enabled = par_lHabilitar
1073:         ENDIF
1074:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
1075:             THIS.cmd_4c_Processar.Enabled = .T.
1076:         ENDIF
1077:     ENDPROC
1078: 
1079:     *==========================================================================
1080:     * LimparCampos - Limpa dados processados e reseta estado do form


### BO (C:\4c\projeto\app\classes\SigPdAcoBO.prg):
*==============================================================================
* SigPdAcoBO.prg - Business Object: Acompanhamento de Material por Grupo
* Form Operacional - sem tabela principal unica (multi-tabelas)
* Tabelas: SigMvEst, SigCdPro, SigMvCab, SigMvItn, SigCdGrp, SigCdPam, SigCdEmp
*==============================================================================

DEFINE CLASS SigPdAcoBO AS BusinessBase

    *-- Controle de estado do processamento
    this_lProcessamento  = .F.

    *-- Parametros de operacoes carregados de SigCdPam
    this_cDopEmphs   = ""
    this_cDopReqcs   = ""
    this_cDopPedcs   = ""
    this_cDopComps   = ""
    this_cDopTrfCps  = ""

    *-- Cabecalho do relatorio
    this_cTituloRel   = ""
    this_cSubTitulo   = ""
    this_cNomeEmpresa = ""

    *-- Filtro corrente
    this_cGrupoAtual  = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO (form operacional sem tabela CRUD unica)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor de parametros para this_*
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDopEmphs  = TratarNulo(DopEmphs,  "C")
            THIS.this_cDopReqcs  = TratarNulo(DopReqcs,  "C")
            THIS.this_cDopPedcs  = TratarNulo(DopPedcs,  "C")
            THIS.this_cDopComps  = TratarNulo(DopComps,  "C")
            THIS.this_cDopTrfCps = TratarNulo(DopTrfCps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave unica
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Executa primeira geracao do relatorio
    *   Form operacional de relatorio: a operacao "Inserir" equivale a executar
    *   o processamento inicial que monta o cursor csRel com saldos atuais,
    *   parametros e empresa. Retorna .T. se o processamento foi bem sucedido
    *   e o cursor csRel ficou disponivel para o Grid.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_oListbox)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Garante parametros e cursores prontos
            IF EMPTY(THIS.this_cDopEmphs) .AND. EMPTY(THIS.this_cDopReqcs) .AND. ;
               EMPTY(THIS.this_cDopPedcs) .AND. EMPTY(THIS.this_cDopComps) .AND. ;
               EMPTY(THIS.this_cDopTrfCps)
                THIS.CarregarParametros()
            ENDIF

            IF !USED("csRel") .OR. !USED("csCab")
                THIS.CriarCursorRelatorio()
            ENDIF

            *-- Executa processamento real (popula csRel + listbox de grupos)
            loc_lSucesso = THIS.Processar(par_oListbox)

            IF loc_lSucesso
                THIS.this_lProcessamento = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Re-executa processamento do relatorio
    *   Form operacional de relatorio: a operacao "Atualizar" equivale a
    *   recalcular saldos atuais. Zera csRel, reprocessa do zero e mantem
    *   o filtro de grupo corrente. Usado quando o usuario clica "Processar"
    *   apos primeira execucao para refletir mudancas em estoque.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_oListbox)
        LOCAL loc_lSucesso, loc_cGrupoAnterior
        loc_lSucesso = .F.
        loc_cGrupoAnterior = THIS.this_cGrupoAtual

        TRY
            *-- Limpa filtro previo para nao interferir no SCAN do Processar
            IF USED("csRel")
                SELECT csRel
                SET KEY TO
                ZAP
            ENDIF

            *-- Reprocessa carregando saldos atuais
            loc_lSucesso = THIS.Processar(par_oListbox)

            IF loc_lSucesso
                THIS.this_lProcessamento = .T.

                *-- Restaura filtro de grupo se havia um ativo
                IF !EMPTY(loc_cGrupoAnterior) .AND. USED("csRel")
                    THIS.FiltrarPorGrupo(loc_cGrupoAnterior)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de operacao de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DopEmphs, DopReqcs, DopPedcs, DopComps, DopTrfCps " + ;
                       "FROM SigCdPam"

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF !EOF("cursor_4c_Pam")
                    THIS.CarregarDoCursor("cursor_4c_Pam")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - Carrega nome da empresa logada para this_cNomeEmpresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresa()
        LOCAL loc_cSQL, loc_cCodEmp
        loc_cCodEmp = go_4c_Sistema.cCodEmpresa

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp"

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(loc_cCodEmp)
                IF FOUND()
                    THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp) + " - " + ALLTRIM(TratarNulo(Razas, "C"))
                ELSE
                    THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp)
                ENDIF
            ELSE
                THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorRelatorio - Cria cursores csRel e csCab para o relatorio
    *                        Estrutura IDENTICA a do Load original
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorRelatorio()
        IF USED("csCab")
            USE IN csCab
        ENDIF
        IF USED("csRel")
            USE IN csRel
        ENDIF

        CREATE CURSOR csCab (cbemp C(60), cbtit C(100), cbsubtit C(100))
        APPEND BLANK

        SET NULL ON
        CREATE CURSOR csRel ( ;
            Cgrus    C(3)    NULL, ;
            Mats     C(10)   NULL, ;
            Dcompos  C(30)   NULL, ;
            Qtds     N(10,3) NULL, ;
            QtdMins  N(10,3) NULL, ;
            CUnis    C(3)    NULL, ;
            QtdReqs  N(10,3) NULL, ;
            QtdPedcs N(10,3) NULL, ;
            QtdComps N(10,3) NULL, ;
            QtdEmphs N(10,3) NULL, ;
            QtdPfins N(10,3) NULL, ;
            QtdPfMs  N(12,3) NULL, ;
            Flags    L       NULL, ;
            Mat2s    C(10)   NULL, ;
            Dcompo2s C(30)   NULL, ;
            Seqs     C(1)    NULL, ;
            PesoMs   N(12,3) NULL  ;
        )
        SET NULL OFF

        INDEX ON Cgrus + Mats + Seqs TAG GruMat
        INDEX ON Mats + CUnis TAG Mats
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Processa saldos e movimentacoes por grupo de material
    *             Popula cursor csRel. par_oListbox recebe grupos encontrados.
    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_oListbox)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCodEmp, loc_cEmpGE
        LOCAL loc_nX, loc_cOperBusca, loc_cCampo, loc_cEdI, loc_cEdF, loc_qtMin
        LOCAL loc_cCPros_s, loc_cDPros_s, loc_cCUnis_s, loc_cCGrus_s, loc_cCUniPs_s
        LOCAL loc_nQMins_s, loc_nPesoMs_s, loc_nSqtds_s, loc_nSPesos_s
        LOCAL loc_cCPros_o, loc_cCUnis_o, loc_cCUniPs_o, loc_cCGrus_o, loc_cDPros_o
        LOCAL loc_nQMins_o, loc_nPesoMs_o, loc_nQtdDiff_o

        loc_lSucesso = .F.
        loc_cCodEmp  = go_4c_Sistema.cCodEmpresa

        TRY
            *-- Prepara titulo e cabecalho do relatorio
            THIS.this_cTituloRel = "Relat" + CHR(243) + "rio de Acompanhamento de Material por Grupo"
            THIS.this_cSubTitulo = " "
            THIS.CarregarEmpresa()

            IF USED("csCab")
                SELECT csCab
                REPLACE cbemp    WITH THIS.this_cNomeEmpresa, ;
                        cbtit    WITH THIS.this_cTituloRel,   ;
                        cbsubtit WITH THIS.this_cSubTitulo
            ENDIF

            *-- Zera ou (re)cria csRel
            IF USED("csRel")
                SELECT csRel
                ZAP
            ELSE
                THIS.CriarCursorRelatorio()
            ENDIF

            *-- Carrega grupos validos (crGrupo com index por Cgrus)
            loc_cSQL = "SELECT Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE NOT GruEstPs = '" + SPACE(10) + "' AND " + ;
                             "NOT ConEstPs = '" + SPACE(10) + "'"

            IF USED("crGrupo")
                USE IN crGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crGrupo") < 1
                MsgAviso("Falha na conex" + CHR(227) + "o (crGrupo)", "Aviso")
                loc_lSucesso = loc_lSucesso
            ENDIF
            SELECT crGrupo
            INDEX ON Cgrus TAG Cgrus

            *-- Carrega combinacoes Grupos/Estos para busca no estoque
            loc_cSQL = "SELECT DISTINCT GruEstPs AS Grupos, ConEstps AS Estos " + ;
                       "FROM SigCdGrp " + ;
                       "WHERE NOT GruEstPs = '" + SPACE(10) + "' AND " + ;
                             "NOT ConEstPs = '" + SPACE(10) + "'"

            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrp") < 1
                MsgAviso("Falha na conex" + CHR(227) + "o (crSigCdGrp)", "Aviso")
                loc_lSucesso = loc_lSucesso
            ENDIF

            *-- Cria cursor acumulador de estoque (writable) com campos necessarios
            IF USED("pEstoque")
                USE IN pEstoque
            ENDIF
            SET NULL ON
            CREATE CURSOR pEstoque (CPros C(10) NULL, Sqtds N(10,3) NULL, sPesos N(12,3) NULL)
            SET NULL OFF

            IF RECCOUNT("crSigCdGrp") = 1
                *-- Grupo unico: busca estoque diretamente
                SELECT crSigCdGrp
                GO TOP
                loc_cEmpGE = loc_cCodEmp + crSigCdGrp.Grupos + crSigCdGrp.Estos

                loc_cSQL = "SELECT CPros, Sqtds, sPesos FROM SigMvEst " + ;
                           "WHERE EmpGruEsts = " + EscaparSQL(loc_cEmpGE) + " AND NOT Sqtds = 0"

                IF USED("cursor_4c_EstTemp")
                    USE IN cursor_4c_EstTemp
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstTemp") < 1
                    MsgAviso("Falha na conex" + CHR(227) + "o (pEstoque)", "Aviso")
                    loc_lSucesso = loc_lSucesso
                ENDIF

                SELECT cursor_4c_EstTemp
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO pEstoque FROM MEMVAR
                ENDSCAN
            ELSE
                *-- Multiplos grupos: acumula em pEstoque
                SELECT crSigCdGrp
                SCAN
                    loc_cEmpGE = loc_cCodEmp + crSigCdGrp.Grupos + crSigCdGrp.Estos

                    loc_cSQL = "SELECT CPros, Sqtds, sPesos FROM SigMvEst " + ;
                               "WHERE EmpGruEsts = " + EscaparSQL(loc_cEmpGE) + " AND NOT Sqtds = 0"

                    IF USED("cursor_4c_TmpEst")
                        USE IN cursor_4c_TmpEst
                    ENDIF

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEst") < 1
                        LOOP
                    ENDIF

                    SELECT cursor_4c_TmpEst
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO pEstoque FROM MEMVAR
                    ENDSCAN
                ENDSCAN
            ENDIF

            *-- Preenche listbox de grupos (Cgrus-Dgrus)
            IF TYPE("par_oListbox") = "O" .AND. !ISNULL(par_oListbox)
                par_oListbox.Clear()
                SELECT crGrupo
                GO TOP
                SCAN
                    par_oListbox.AddItem(ALLTRIM(crGrupo.Cgrus) + "-" + ALLTRIM(crGrupo.Dgrus))
                ENDSCAN
            ENDIF

            *-- Popula csRel com saldo atual de estoque por produto/unidade
            SELECT pEstoque
            GO TOP
            SCAN
                loc_cCPros_s = pEstoque.CPros

                loc_cSQL = "SELECT DPros, CUnis, CGrus, QMins, cUniPs, PesoMs " + ;
                           "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(loc_cCPros_s))

                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro") <= 0 .OR. EOF("crSigCdPro")
                    LOOP
                ENDIF

                SELECT crSigCdPro
                loc_cDPros_s  = TratarNulo(DPros,  "C")
                loc_cCUnis_s  = TratarNulo(CUnis,  "C")
                loc_cCGrus_s  = TratarNulo(CGrus,  "C")
                loc_cCUniPs_s = TratarNulo(cUniPs, "C")
                loc_nQMins_s  = TratarNulo(QMins,  "N")
                loc_nPesoMs_s = TratarNulo(PesoMs, "N")

                *-- Produto deve pertencer a um grupo valido
                IF !SEEK(crSigCdPro.CGrus, "crGrupo", "Cgrus")
                    LOOP
                ENDIF

                SELECT pEstoque
                loc_nSqtds_s  = TratarNulo(Sqtds,  "N")
                loc_nSPesos_s = TratarNulo(sPesos,  "N")

                *-- Linha unidade primaria (Seqs='1')
                SELECT csRel
                IF !SEEK(loc_cCPros_s + loc_cCUnis_s, "csRel", "Mats")
                    APPEND BLANK
                ENDIF

                REPLACE Qtds     WITH Qtds + loc_nSqtds_s, ;
                        QtdMins  WITH loc_nQMins_s, ;
                        Mats     WITH loc_cCPros_s, ;
                        Mat2s    WITH loc_cCPros_s, ;
                        Dcompos  WITH loc_cDPros_s, ;
                        Dcompo2s WITH loc_cDPros_s, ;
                        CUnis    WITH loc_cCUnis_s, ;
                        CGrus    WITH loc_cCGrus_s, ;
                        Seqs     WITH "1"

                *-- Linha unidade alternativa por peso (Seqs='2')
                IF !EMPTY(loc_cCUniPs_s) .AND. loc_nPesoMs_s <> 0
                    loc_qtMin = ROUND(loc_nQMins_s / loc_nPesoMs_s, 0)

                    SELECT csRel
                    IF !SEEK(loc_cCPros_s + loc_cCUniPs_s, "csRel", "Mats")
                        APPEND BLANK
                    ENDIF

                    REPLACE Qtds     WITH Qtds + loc_nSPesos_s, ;
                            QtdMins  WITH loc_qtMin, ;
                            Mats     WITH loc_cCPros_s, ;
                            Dcompos  WITH loc_cDPros_s, ;
                            CUnis    WITH loc_cCUniPs_s, ;
                            CGrus    WITH loc_cCGrus_s, ;
                            PesoMs   WITH loc_nPesoMs_s, ;
                            Seqs     WITH "2"
                ENDIF
            ENDSCAN

            *-- Processa 5 tipos de operacao: Empenho(1), Requisicao(2),
            *   PedidoCompra(3), Compra(4), TransferenciaCompra(5->QtdComps)
            FOR loc_nX = 1 TO 5
                DO CASE
                    CASE loc_nX = 1
                        loc_cOperBusca = THIS.this_cDopEmphs
                        loc_cCampo     = "QtdEmphs"
                    CASE loc_nX = 2
                        loc_cOperBusca = THIS.this_cDopReqcs
                        loc_cCampo     = "QtdReqs"
                    CASE loc_nX = 3
                        loc_cOperBusca = THIS.this_cDopPedcs
                        loc_cCampo     = "QtdPedcs"
                    CASE loc_nX = 4
                        loc_cOperBusca = THIS.this_cDopComps
                        loc_cCampo     = "QtdComps"
                    CASE loc_nX = 5
                        loc_cOperBusca = THIS.this_cDopTrfCps
                        loc_cCampo     = "QtdComps"
                ENDCASE

                IF EMPTY(loc_cOperBusca)
                    LOOP
                ENDIF

                loc_cEdI = loc_cCodEmp + loc_cOperBusca + STR(0,      6)
                loc_cEdF = loc_cCodEmp + loc_cOperBusca + STR(999999, 6)

                loc_cSQL = "SELECT b.EmpDopNums, b.CPros, b.Qtds, b.QtBaixas, " + ;
                           "c.Cgrus, c.QMins, c.Dpros, c.CUnis, c.cUnips, c.PesoMs " + ;
                           "FROM SigMvCab a, SigMvItn b, SigCdPro c " + ;
                           "WHERE a.EmpDopNums BETWEEN " + EscaparSQL(loc_cEdI) + " AND " + EscaparSQL(loc_cEdF) + " AND " + ;
                                 "a.EmpDopNums = b.EmpDopNums AND " + ;
                                 "NOT ((b.Qtds - b.QtBaixas) = 0) AND " + ;
                                 "b.CPros = c.CPros " + ;
                           "ORDER BY b.EmpDopNums, b.CPros, b.Qtds, b.QtBaixas, " + ;
                                    "c.Cgrus, c.QMins, c.Dpros, c.CUnis"

                IF USED("crOperacao")
                    USE IN crOperacao
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crOperacao") < 1
                    LOOP
                ENDIF

                SELECT crOperacao
                SCAN
                    IF !SEEK(crOperacao.Cgrus, "crGrupo", "Cgrus")
                        LOOP
                    ENDIF

                    loc_cCPros_o   = crOperacao.CPros
                    loc_cCUnis_o   = crOperacao.CUnis
                    loc_cCUniPs_o  = TratarNulo(crOperacao.cUnips, "C")
                    loc_cCGrus_o   = crOperacao.Cgrus
                    loc_cDPros_o   = TratarNulo(crOperacao.Dpros,  "C")
                    loc_nQMins_o   = TratarNulo(crOperacao.QMins,  "N")
                    loc_nPesoMs_o  = TratarNulo(crOperacao.PesoMs, "N")
                    loc_nQtdDiff_o = TratarNulo(crOperacao.Qtds, "N") - TratarNulo(crOperacao.QtBaixas, "N")

                    *-- Linha unidade primaria
                    SELECT csRel
                    IF !SEEK(loc_cCPros_o + loc_cCUnis_o, "csRel", "Mats")
                        APPEND BLANK
                        REPLACE QtdMins  WITH loc_nQMins_o, ;
                                Mats     WITH loc_cCPros_o, ;
                                Dcompos  WITH loc_cDPros_o, ;
                                Mat2s    WITH loc_cCPros_o, ;
                                Dcompo2s WITH loc_cDPros_o, ;
                                CUnis    WITH loc_cCUnis_o, ;
                                CGrus    WITH loc_cCGrus_o, ;
                                PesoMs   WITH loc_nPesoMs_o, ;
                                Seqs     WITH "1"
                    ENDIF

                    DO CASE
                        CASE loc_cCampo = "QtdEmphs"
                            REPLACE QtdEmphs WITH QtdEmphs + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdReqs"
                            REPLACE QtdReqs  WITH QtdReqs  + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdPedcs"
                            REPLACE QtdPedcs WITH QtdPedcs + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdComps"
                            REPLACE QtdComps WITH QtdComps + loc_nQtdDiff_o
                    ENDCASE

                    *-- Linha unidade alternativa por peso
                    IF !EMPTY(loc_cCUniPs_o) .AND. loc_nPesoMs_o <> 0
                        loc_qtMin = ROUND(loc_nQMins_o / loc_nPesoMs_o, 0)

                        SELECT csRel
                        IF !SEEK(loc_cCPros_o + loc_cCUniPs_o, "csRel", "Mats")
                            APPEND BLANK
                            REPLACE QtdMins  WITH loc_qtMin, ;
                                    Mats     WITH loc_cCPros_o, ;
                                    Dcompos  WITH loc_cDPros_o, ;
                                    CUnis    WITH loc_cCUniPs_o, ;
                                    CGrus    WITH loc_cCGrus_o, ;
                                    PesoMs   WITH loc_nPesoMs_o, ;
                                    Seqs     WITH "2"
                        ENDIF

                        DO CASE
                            CASE loc_cCampo = "QtdEmphs"
                                REPLACE QtdEmphs WITH QtdEmphs + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdReqs"
                                REPLACE QtdReqs  WITH QtdReqs  + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdPedcs"
                                REPLACE QtdPedcs WITH QtdPedcs + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdComps"
                                REPLACE QtdComps WITH QtdComps + loc_nQtdDiff_o
                        ENDCASE
                    ENDIF
                ENDSCAN
            ENDFOR

            *-- Calcula posicao final e flag de alerta (linhas Seqs='2' em peso)
            SELECT csRel
            SCAN
                IF Seqs = "2"
                    REPLACE QtdReqs  WITH ROUND(QtdReqs  / PesoMs, 0), ;
                            QtdPedcs WITH ROUND(QtdPedcs / PesoMs, 0), ;
                            QtdComps WITH ROUND(QtdComps / PesoMs, 0), ;
                            QtdEmphs WITH ROUND(QtdEmphs / PesoMs, 0), ;
                            Dcompo2s WITH PADC("*", 35)
                ENDIF
                REPLACE QtdPfins WITH (Qtds - QtdMins + QtdReqs + QtdPedcs + QtdComps - QtdEmphs)
                REPLACE Flags    WITH IIF(QtdReqs > 0 .AND. QtdPfins > 0, .T., .F.)
            ENDSCAN

            THIS.this_lProcessamento = .T.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarPorGrupo - Aplica filtro SET KEY no cursor csRel pelo grupo
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarPorGrupo(par_cGrupo)
        THIS.this_cGrupoAtual = ALLTRIM(LEFT(par_cGrupo, 3))

        IF USED("csRel")
            SELECT csRel
            SET ORDER TO TAG GruMat
            SET KEY TO THIS.this_cGrupoAtual
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCabecalhoRelatorio - Atualiza subtitulo no cursor csCab
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarCabecalhoRelatorio(par_cSubTitulo)
        THIS.this_cSubTitulo = par_cSubTitulo
        IF USED("csCab")
            SELECT csCab
            REPLACE cbsubtit WITH par_cSubTitulo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores auxiliares criados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(9), loc_i
        loc_aCursores(1) = "cursor_4c_Pam"
        loc_aCursores(2) = "cursor_4c_Emp"
        loc_aCursores(3) = "crGrupo"
        loc_aCursores(4) = "crSigCdGrp"
        loc_aCursores(5) = "pEstoque"
        loc_aCursores(6) = "crOperacao"
        loc_aCursores(7) = "crSigCdPro"
        loc_aCursores(8) = "cursor_4c_EstTemp"
        loc_aCursores(9) = "cursor_4c_TmpEst"

        FOR loc_i = 1 TO 9
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

