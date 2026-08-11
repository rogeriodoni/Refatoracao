# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [NAVEGACAO-PAGINA] Metodo 'BtnCancelarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFpm.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1272 linhas total):

*-- Linhas 69 a 77:
69:             THIS.this_oParentForm = par_oParentForm
70:             THIS.this_cFpags      = IIF(VARTYPE(par_cFpags) = "C", ALLTRIM(par_cFpags), "")
71: 
72:             THIS.Caption = "Valor M" + CHR(237) + "nimo/M" + CHR(225) + "ximo Cond.Pagto " + ;
73:                            ALLTRIM(THIS.this_cFpags)
74: 
75:             THIS.this_oBusinessObject = CREATEOBJECT("FpmBO")
76:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
77:                 MsgErro("Erro ao criar FpmBO." + CHR(13) + ;

*-- Linhas 119 a 130:
119:             THIS.ConfigurarPaginaDados()
120: 
121:             *-- 6. Propaga Caption para cabecalhos de ambas as paginas
122:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
123:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
124:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
125:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
126: 
127:             *-- 7. Carrega dados via BO e vincula grid ao cursor
128:             THIS.CarregarDados()
129: 
130:             *-- 8. Ativa Page1 (Lista) como padrao

*-- Linhas 153 a 170:
153:         TRY
154:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
155:             WITH THIS.pgf_4c_Paginas
156:                 .Top         = -29
157:                 .Left        = 0
158:                 .Width       = THIS.Width
159:                 .Height      = THIS.Height + 29
160:                 .PageCount   = 2
161:                 .Tabs        = .F.
162:                 .BorderWidth = 0
163: 
164:                 .Page1.Caption = "Lista"
165:                 .Page2.Caption = "Dados"
166:             ENDWITH
167:         CATCH TO loc_oErro
168:             MsgErro(loc_oErro.Message + CHR(13) + ;
169:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
170:                 "Procedure: " + loc_oErro.Procedure, "FormFpm.ConfigurarPageFrame")

*-- Linhas 183 a 234:
183:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
184:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
185: 
186:             *-- Page1: cabecalho escuro (topo) - compensacao PageFrame.Top=-29
187:             loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
188:             WITH loc_oPag1.cnt_4c_Cabecalho
189:                 .Top         = 0 + 29
190:                 .Left        = 0
191:                 .Width       = THIS.Width
192:                 .Height      = 80
193:                 .BorderWidth = 0
194:                 .BackStyle   = 1
195:                 .BackColor   = RGB(100, 100, 100)
196:                 .Visible     = .T.
197:             ENDWITH
198: 
199:             *-- Page1: container de botoes
200:             *-- Alinhado com botoes originais: cmdInserir.Left=457, cmdSair.Right=682
201:             loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
202:             WITH loc_oPag1.cnt_4c_Botoes
203:                 .Top         = 0 + 29
204:                 .Left        =  542
205:                 .Width       = 226
206:                 .Height      = 85
207:                 .BorderWidth = 0
208:                 .BackStyle   = 0
209:                 .Visible     = .T.
210:             ENDWITH
211: 
212:             *-- Page2: cabecalho espelhado
213:             loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
214:             WITH loc_oPag2.cnt_4c_Cabecalho
215:                 .Top         = 0 + 29
216:                 .Left        = 0
217:                 .Width       = THIS.Width
218:                 .Height      = 80
219:                 .BorderWidth = 0
220:                 .BackStyle   = 1
221:                 .BackColor   = RGB(100, 100, 100)
222:                 .Visible     = .T.
223:             ENDWITH
224: 
225:             *-- Page2: container de acoes (Fase 4 populara com Confirmar/Cancelar)
226:             loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
227:             WITH loc_oPag2.cnt_4c_BotoesAcao
228:                 .Top         = 4 + 29
229:                 .Left        = 457
230:                 .Width       = 226
231:                 .Height      = 85
232:                 .BorderWidth = 0
233:                 .BackStyle   = 0
234:                 .Visible     = .T.

*-- Linhas 253 a 298:
253:             loc_oCab = loc_oPag.cnt_4c_Cabecalho
254: 
255:             *-- Label sombra (preto sobre cinza escuro = efeito de sombra)
256:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
257:             WITH loc_oCab.lbl_4c_Sombra
258:                 .AutoSize   = .F.
259:                 .FontBold   = .T.
260:                 .FontName   = "Tahoma"
261:                 .FontSize   = 18
262:                 .BackStyle  = 0
263:                 .Caption    = THIS.Caption
264:                 .Height     = 40
265:                 .Left       = 10
266:                 .Top        = 18
267:                 .Width      = THIS.Width - 20
268:                 .ForeColor  = RGB(0, 0, 0)
269:             ENDWITH
270: 
271:             *-- Label titulo (branco sobre cinza = visivel)
272:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
273:             WITH loc_oCab.lbl_4c_Titulo
274:                 .AutoSize   = .F.
275:                 .FontBold   = .T.
276:                 .FontName   = "Tahoma"
277:                 .FontSize   = 18
278:                 .BackStyle  = 0
279:                 .Caption    = THIS.Caption
280:                 .Height     = 46
281:                 .Left       = 10
282:                 .Top        = 17
283:                 .Width      = THIS.Width - 20
284:                 .ForeColor  = RGB(255, 255, 255)
285:             ENDWITH
286: 
287:             *-- Grid grd_4c_Dados (GradeFPagto do original)
288:             *-- Original: Top=92, Left=114, Width=334, Height=260
289:             *-- Com compensacao PageFrame.Top=-29: Top = 92+29 = 121
290:             loc_oPag.AddObject("grd_4c_Dados", "Grid")
291:             WITH loc_oPag.grd_4c_Dados
292:                 .Top           = 92 + 29
293:                 .Left          = 114
294:                 .Width         = 334
295:                 .Height        = 260
296:                 .ColumnCount   = 4
297:                 .FontName      = "Tahoma"
298:                 .FontSize      = 8

*-- Linhas 313 a 321:
313:                         .FontName  = "Tahoma"
314:                         .FontSize  = 8
315:                         .Alignment = 2
316:                         .Caption   = "Parcelas"
317:                     ENDWITH
318:                     WITH .Text1
319:                         .BorderStyle = 0
320:                         .Margin      = 0
321:                         .ForeColor   = RGB(0, 0, 0)

*-- Linhas 335 a 343:
335:                         .FontName  = "Tahoma"
336:                         .FontSize  = 8
337:                         .Alignment = 2
338:                         .Caption   = "Valor M" + CHR(237) + "nimo"
339:                     ENDWITH
340:                     WITH .Text1
341:                         .BorderStyle = 0
342:                         .InputMask   = "999,999,999.99"
343:                         .Margin      = 0

*-- Linhas 358 a 366:
358:                         .FontName  = "Tahoma"
359:                         .FontSize  = 8
360:                         .Alignment = 2
361:                         .Caption   = "Valor M" + CHR(225) + "ximo"
362:                     ENDWITH
363:                     WITH .Text1
364:                         .BorderStyle = 0
365:                         .InputMask   = "999,999,999.99"
366:                         .Margin      = 0

*-- Linhas 380 a 388:
380:                         .FontName  = "Tahoma"
381:                         .FontSize  = 8
382:                         .Alignment = 2
383:                         .Caption   = "Emp"
384:                     ENDWITH
385:                     WITH .Text1
386:                         .BorderStyle = 0
387:                         .MaxLength   = 3
388:                         .Margin      = 0

*-- Linhas 394 a 411:
394: 
395:             *-- Botoes no cnt_4c_Botoes
396:             *-- Original: Inserir(Left=457), Excluir(Left=532), Sair(Left=607)
397:             *-- cnt_4c_Botoes.Left=457 => posicoes relativas: 0, 75, 150
398:             loc_oCnt = loc_oPag.cnt_4c_Botoes
399: 
400:             loc_oCnt.AddObject("cmd_4c_Inserir", "CommandButton")
401:             WITH loc_oCnt.cmd_4c_Inserir
402:                 .Left            = 0
403:                 .Top             = 3
404:                 .Width           = 75
405:                 .Height          = 75
406:                 .Caption         = "Inserir"
407:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
408:                 .FontName        = "Tahoma"
409:                 .FontSize        = 8
410:                 .FontBold        = .T.
411:                 .FontItalic      = .T.

*-- Linhas 419 a 433:
419:                 .AutoSize        = .F.
420:             ENDWITH
421: 
422:             loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
423:             WITH loc_oCnt.cmd_4c_Excluir
424:                 .Left            = 75
425:                 .Top             = 3
426:                 .Width           = 75
427:                 .Height          = 75
428:                 .Caption         = "Excluir"
429:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
430:                 .FontName        = "Tahoma"
431:                 .FontSize        = 8
432:                 .FontBold        = .T.
433:                 .FontItalic      = .T.

*-- Linhas 441 a 455:
441:                 .AutoSize        = .F.
442:             ENDWITH
443: 
444:             loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
445:             WITH loc_oCnt.cmd_4c_Encerrar
446:                 .Left            = 150
447:                 .Top             = 3
448:                 .Width           = 75
449:                 .Height          = 75
450:                 .Caption         = "Encerrar"
451:                 .Cancel          = .T.
452:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
453:                 .FontName        = "Tahoma"
454:                 .FontSize        = 8
455:                 .FontBold        = .T.

*-- Linhas 465 a 475:
465:             ENDWITH
466: 
467:             *-- BINDEVENTs para botoes
468:             BINDEVENT(loc_oCnt.cmd_4c_Inserir,  "Click", THIS, "BtnInserirClick")
469:             BINDEVENT(loc_oCnt.cmd_4c_Excluir,  "Click", THIS, "BtnExcluirClick")
470:             BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
471: 
472:             *-- BINDEVENT para grid: When/Valid via AfterRowColChange
473:             BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
474: 
475:         CATCH TO loc_oErro

*-- Linhas 491 a 540:
491:             loc_oCab  = loc_oPag2.cnt_4c_Cabecalho
492: 
493:             *-- Label sombra
494:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
495:             WITH loc_oCab.lbl_4c_Sombra
496:                 .AutoSize   = .F.
497:                 .FontBold   = .T.
498:                 .FontName   = "Tahoma"
499:                 .FontSize   = 18
500:                 .BackStyle  = 0
501:                 .Caption    = THIS.Caption
502:                 .Height     = 40
503:                 .Left       = 10
504:                 .Top        = 18
505:                 .Width      = THIS.Width - 20
506:                 .ForeColor  = RGB(0, 0, 0)
507:             ENDWITH
508: 
509:             *-- Label titulo
510:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
511:             WITH loc_oCab.lbl_4c_Titulo
512:                 .AutoSize   = .F.
513:                 .FontBold   = .T.
514:                 .FontName   = "Tahoma"
515:                 .FontSize   = 18
516:                 .BackStyle  = 0
517:                 .Caption    = THIS.Caption
518:                 .Height     = 46
519:                 .Left       = 10
520:                 .Top        = 17
521:                 .Width      = THIS.Width - 20
522:                 .ForeColor  = RGB(255, 255, 255)
523:             ENDWITH
524: 
525:             *-- Botoes Confirmar / Cancelar em cnt_4c_BotoesAcao
526:             *-- Mesmo padrao visual dos botoes de Page1
527:             loc_oCnt = loc_oPag2.cnt_4c_BotoesAcao
528: 
529:             loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
530:             WITH loc_oCnt.cmd_4c_Confirmar
531:                 .Left            = 0
532:                 .Top             = 3
533:                 .Width           = 75
534:                 .Height          = 75
535:                 .Caption         = "Confirmar"
536:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
537:                 .FontName        = "Tahoma"
538:                 .FontSize        = 8
539:                 .FontBold        = .T.
540:                 .FontItalic      = .T.

*-- Linhas 548 a 562:
548:                 .AutoSize        = .F.
549:             ENDWITH
550: 
551:             loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
552:             WITH loc_oCnt.cmd_4c_Cancelar
553:                 .Left            = 75
554:                 .Top             = 3
555:                 .Width           = 75
556:                 .Height          = 75
557:                 .Caption         = "Encerrar"
558:                 .Cancel          = .T.
559:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
560:                 .FontName        = "Tahoma"
561:                 .FontSize        = 8
562:                 .FontBold        = .T.

*-- Linhas 572 a 581:
572:             ENDWITH
573: 
574:             *-- BINDEVENTs para botoes de Page2
575:             BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
576:             BINDEVENT(loc_oCnt.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
577: 
578:         CATCH TO loc_oErro
579:             MsgErro(loc_oErro.Message + CHR(13) + ;
580:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
581:                 "Procedure: " + loc_oErro.Procedure, "FormFpm.ConfigurarPaginaDados")

*-- Linhas 653 a 664:
653:                 .Column3.ControlSource = "cursor_4c_FpagI.ValMaxs"
654:                 .Column4.ControlSource = "cursor_4c_FpagI.Emps"
655:             ENDWITH
656:             loc_oGrid.Column1.Header1.Caption = "Parcelas"
657:             loc_oGrid.Column2.Header1.Caption = "Valor M" + CHR(237) + "nimo"
658:             loc_oGrid.Column3.Header1.Caption = "Valor M" + CHR(225) + "ximo"
659:             loc_oGrid.Column4.Header1.Caption = "Emp"
660:             loc_oGrid.Refresh()
661:         CATCH TO loc_oErro
662:             MsgErro(loc_oErro.Message + CHR(13) + ;
663:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
664:                 "Procedure: " + loc_oErro.Procedure, "FormFpm.VincularGrid")

*-- Linhas 1067 a 1080:
1067:                 loc_cFpags = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cFpagsAtual, ""))
1068:                 IF !EMPTY(loc_cFpags)
1069:                     THIS.this_cFpags = loc_cFpags
1070:                     THIS.Caption = "Valor M" + CHR(237) + "nimo/M" + CHR(225) + ;
1071:                         "ximo Cond.Pagto " + loc_cFpags
1072:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
1073:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
1074:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
1075:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
1076:                 ENDIF
1077:             ENDIF
1078:             IF USED("cursor_4c_FpagI")
1079:                 THIS.VincularGrid()
1080:             ENDIF

*-- Linhas 1106 a 1115:
1106: 
1107:             *-- Botoes Inserir/Excluir seguem o modo (Encerrar sempre disponivel)
1108:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1109:             loc_oCnt.cmd_4c_Inserir.Enabled = loc_lHab
1110:             loc_oCnt.cmd_4c_Excluir.Enabled = loc_lHab
1111: 
1112:             *-- Se voltamos a habilitar edicao inline: reaplica politica por linha
1113:             IF loc_lHab AND USED("cursor_4c_FpagI") AND !EOF("cursor_4c_FpagI")
1114:                 THIS.GrdDadosAfterRowColChange(0)
1115:             ENDIF

*-- Linhas 1161 a 1185:
1161:             loc_oCntD = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1162:             DO CASE
1163:                 CASE loc_cModo == "VISUALIZAR"
1164:                     loc_oCntL.cmd_4c_Inserir.Enabled  = .F.
1165:                     loc_oCntL.cmd_4c_Excluir.Enabled  = .F.
1166:                     loc_oCntL.cmd_4c_Encerrar.Enabled = .T.
1167:                     loc_oCntD.cmd_4c_Confirmar.Enabled = .F.
1168:                     loc_oCntD.cmd_4c_Cancelar.Enabled  = .T.
1169:                 CASE loc_cModo == "DADOS"
1170:                     loc_oCntL.cmd_4c_Inserir.Enabled  = .F.
1171:                     loc_oCntL.cmd_4c_Excluir.Enabled  = .F.
1172:                     loc_oCntL.cmd_4c_Encerrar.Enabled = .T.
1173:                     loc_oCntD.cmd_4c_Confirmar.Enabled = .T.
1174:                     loc_oCntD.cmd_4c_Cancelar.Enabled  = .T.
1175:                 OTHERWISE   && LISTA (default)
1176:                     loc_oCntL.cmd_4c_Inserir.Enabled  = .T.
1177:                     loc_oCntL.cmd_4c_Excluir.Enabled  = .T.
1178:                     loc_oCntL.cmd_4c_Encerrar.Enabled = .T.
1179:                     loc_oCntD.cmd_4c_Confirmar.Enabled = .T.
1180:                     loc_oCntD.cmd_4c_Cancelar.Enabled  = .T.
1181:             ENDCASE
1182:         CATCH TO loc_oErro
1183:             MsgErro(loc_oErro.Message + CHR(13) + ;
1184:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1185:                 "Procedure: " + loc_oErro.Procedure, "FormFpm.AjustarBotoesPorModo")


### BO (C:\4c\projeto\app\classes\FpmBO.prg):
*------------------------------------------------------------------------------
* FpmBO.prg - Business Object para Valores Min/Max de Condicao de Pagamento
* Tabela: SigOpFpi
* Origem: SIGCDFPM.SCX (sub-form de SigCdFpm)
*------------------------------------------------------------------------------

DEFINE CLASS FpmBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela     = "SigOpFpi"
    this_cCampoChave = "fpags"

    *-- Campos de SigOpFpi
    this_cFpags      = ""  && char(12) - codigo da condicao de pagamento (FK)
    this_nNparcs     = 0   && numeric(2,0) - numero de parcelas
    this_nValmins    = 0   && numeric(11,2) - valor minimo
    this_nValmaxs    = 0   && numeric(11,2) - valor maximo
    this_cEmps       = ""  && char(3) - codigo da empresa

    *-- Contexto de edicao (recebido do form pai via parametro)
    this_cFpagsAtual = ""  && fpags da condicao em edicao (filtro do SQLEXEC)

    PROCEDURE Init()
        THIS.this_cTabela     = "SigOpFpi"
        THIS.this_cCampoChave = "fpags"
        RETURN DODEFAULT()
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cFpags
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorCondicao - Carrega registros de SigOpFpi para cursor do grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorCondicao(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_FpagI")
                TABLEREVERT(.T., "cursor_4c_FpagI")
                USE IN cursor_4c_FpagI
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_FpagI ;
                (fpags    C(12) NULL, ;
                 nparcs   N(2,0) NULL, ;
                 valmins  N(11,2) NULL, ;
                 valmaxs  N(11,2) NULL, ;
                 emps     C(3) NULL)
            SET NULL OFF

            INDEX ON fpags + STR(nparcs, 2) TAG fpags
            INDEX ON nparcs TAG nparcs
            SET ORDER TO

            loc_cSQL = "SELECT fpags, nparcs, valmins, valmaxs, emps " + ;
                       "FROM SigOpFpi " + ;
                       "WHERE fpags = " + EscaparSQL(par_cFpags) + ;
                       " ORDER BY nparcs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpagITemp") > 0
                SELECT cursor_4c_FpagI
                APPEND FROM DBF("cursor_4c_FpagITemp")
                IF USED("cursor_4c_FpagITemp")
                    USE IN cursor_4c_FpagITemp
                ENDIF
                SELECT cursor_4c_FpagI
                SET ORDER TO
                GO TOP
                THIS.this_cFpagsAtual = par_cFpags
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_FpagITemp")
                    USE IN cursor_4c_FpagITemp
                ENDIF
                MsgErro("Falha ao carregar parcelas da condi" + CHR(231) + CHR(227) + "o de pagamento.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BuscarPorCondicao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinha - Insere nova linha em branco no cursor local do grid
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinha(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            MsgAviso("Cursor de parcelas n" + CHR(227) + "o inicializado.", "Aviso")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT cursor_4c_FpagI
            INSERT INTO cursor_4c_FpagI (fpags, nparcs, valmins, valmaxs, emps) ;
                VALUES (par_cFpags, 0, 0, 0, "")
            GO BOTTOM
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InserirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinha - Marca linha corrente para exclusao no cursor local
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinha()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT cursor_4c_FpagI
            IF !EOF()
                DELETE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExcluirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteNparcs - Verifica se numero de parcelas ja existe no cursor local
    * Usado pelo form para validacao inline na grade
    *--------------------------------------------------------------------------
    PROCEDURE ExisteNparcs(par_nNparcs)
        LOCAL loc_lExiste, loc_nRecNoAtual
        loc_lExiste = .F.

        IF !USED("cursor_4c_FpagI") OR par_nNparcs <= 0
            RETURN loc_lExiste
        ENDIF

        SELECT cursor_4c_FpagI
        loc_nRecNoAtual = RECNO("cursor_4c_FpagI")

        SET ORDER TO fpags
        IF SEEK(cursor_4c_FpagI.fpags + STR(par_nNparcs, 2), "cursor_4c_FpagI", "fpags")
            SKIP
            IF !EOF("cursor_4c_FpagI")
                IF cursor_4c_FpagI.fpags + STR(cursor_4c_FpagI.nparcs, 2) = ;
                   cursor_4c_FpagI.fpags + STR(par_nNparcs, 2)
                    loc_lExiste = .T.
                ENDIF
            ENDIF
        ENDIF

        SET ORDER TO
        IF loc_nRecNoAtual > 0
            GO (loc_nRecNoAtual) IN cursor_4c_FpagI
        ELSE
            GO BOTTOM IN cursor_4c_FpagI
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConsistencia - Valida duplicidade de nparcs antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConsistencia()
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.

        IF !USED("cursor_4c_FpagI")
            RETURN loc_lValido
        ENDIF

        TRY
            SELECT nparcs, SUM(1) AS nTotal ;
                FROM cursor_4c_FpagI ;
                WHERE (nparcs > 0 OR valmaxs > 0) AND !DELETED() ;
                GROUP BY nparcs ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_ValidTT READWRITE

            IF RECCOUNT("cursor_4c_ValidTT") > 0
                MsgAviso("Dados Inconsistentes!!! N" + CHR(250) + "mero de parcelas duplicado.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF

            IF USED("cursor_4c_ValidTT")
                USE IN cursor_4c_ValidTT
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarConsistencia")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Persiste cursor local no SQL Server
    * Delete todos registros existentes e reinsere do cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlteracoes(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cFpags, loc_nNparcs, loc_nValmins, loc_nValmaxs, loc_cEmps
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            MsgAviso("Cursor de parcelas n" + CHR(227) + "o inicializado.", "Aviso")
            RETURN loc_lSucesso
        ENDIF

        TRY
            *-- Deletar registros existentes para esta condicao de pagamento
            loc_cSQL = "DELETE FROM SigOpFpi WHERE fpags = " + EscaparSQL(par_cFpags)
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Falha ao remover parcelas anteriores.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF

            *-- Reinserir do cursor local (apenas linhas validas: nparcs != 0 OU valmaxs != 0)
            IF loc_lSucesso
                SELECT cursor_4c_FpagI
                GO TOP
                DO WHILE !EOF() AND loc_lSucesso
                    IF !DELETED() AND (!EMPTY(cursor_4c_FpagI.nparcs) OR !EMPTY(cursor_4c_FpagI.valmaxs))
                        loc_cFpags   = cursor_4c_FpagI.fpags
                        loc_nNparcs  = cursor_4c_FpagI.nparcs
                        loc_nValmins = cursor_4c_FpagI.valmins
                        loc_nValmaxs = cursor_4c_FpagI.valmaxs
                        loc_cEmps    = cursor_4c_FpagI.emps

                        loc_cSQL = "INSERT INTO SigOpFpi " + ;
                                   "(fpags, nparcs, valmins, valmaxs, emps) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cFpags) + ", " + ;
                                   FormatarNumeroSQL(loc_nNparcs, 0) + ", " + ;
                                   FormatarNumeroSQL(loc_nValmins, 2) + ", " + ;
                                   FormatarNumeroSQL(loc_nValmaxs, 2) + ", " + ;
                                   EscaparSQL(loc_cEmps) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Falha ao inserir parcela nParcs=" + ;
                                    TRANSFORM(loc_nNparcs) + ".", "Erro")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                    SKIP
                ENDDO
            ENDIF

            IF loc_lSucesso
                THIS.RegistrarAuditoria("SALVAR")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SalvarAlteracoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cFpags  = TratarNulo(fpags, "C")
            THIS.this_nNparcs = TratarNulo(nparcs, "N")
            THIS.this_nValmins = TratarNulo(valmins, "N")
            THIS.this_nValmaxs = TratarNulo(valmaxs, "N")
            THIS.this_cEmps   = TratarNulo(emps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *-- ValidarDados: validacao inline feita no grid; satisfaz cadeia BusinessBase
    PROTECTED PROCEDURE ValidarDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Persiste uma linha de SigOpFpi.
    * Usa propriedades this_c*/this_n* populadas previamente por
    * CarregarDoCursor ou FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpFpi " + ;
                       "(fpags, nparcs, valmins, valmaxs, emps) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNparcs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmins, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmaxs, 2) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INSERIR")
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir parcela nParcs=" + ;
                                          TRANSFORM(THIS.this_nNparcs)
                MsgErro(THIS.this_cMensagemErro, "Erro em Inserir")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de SigOpFpi identificada por fpags+nparcs.
    * Usa propriedades this_n* populadas previamente por CarregarDoCursor ou
    * FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cFpags)
                THIS.this_cMensagemErro = "Chave fpags vazia."
                MsgErro(THIS.this_cMensagemErro, "Erro em Atualizar")
            ELSE
                loc_cSQL = "UPDATE SigOpFpi SET " + ;
                           "valmins = " + FormatarNumeroSQL(THIS.this_nValmins, 2) + ", " + ;
                           "valmaxs = " + FormatarNumeroSQL(THIS.this_nValmaxs, 2) + ", " + ;
                           "emps = " + EscaparSQL(THIS.this_cEmps) + " " + ;
                           "WHERE fpags = " + EscaparSQL(THIS.this_cFpags) + ;
                           " AND nparcs = " + FormatarNumeroSQL(THIS.this_nNparcs, 0)

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("ATUALIZAR")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar parcela fpags=" + ;
                                              ALLTRIM(THIS.this_cFpags)
                    MsgErro(THIS.this_cMensagemErro, "Erro em Atualizar")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove linha de SigOpFpi identificada por fpags+nparcs.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cFpags)
                THIS.this_cMensagemErro = "Chave fpags vazia."
                MsgErro(THIS.this_cMensagemErro, "Erro em ExecutarExclusao")
            ELSE
                loc_cSQL = "DELETE FROM SigOpFpi " + ;
                           "WHERE fpags = " + EscaparSQL(THIS.this_cFpags) + ;
                           " AND nparcs = " + FormatarNumeroSQL(THIS.this_nNparcs, 0)

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("EXCLUIR")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao excluir parcela fpags=" + ;
                                              ALLTRIM(THIS.this_cFpags)
                    MsgErro(THIS.this_cMensagemErro, "Erro em ExecutarExclusao")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

