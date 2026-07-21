# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 520: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 542: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formale.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (963 linhas total):

*-- Linhas 115 a 183:
115:     * ConfigurarCabecalho - Container header cinza (cntSombra do legado)
116:     * Equivalente: SIGCDALE.cntSombra + lblSombra + lblTitulo + Shape1
117:     * cnt_4c_Sombra: Top=0, Left=0, Width=1000, Height=80, BackColor=RGB(100,100,100)
118:     * lbl_4c_Sombra: sombra preta (ForeColor preto) deslocada 1px
119:     * lbl_4c_Titulo: titulo branco (ForeColor branco) sobre a sombra
120:     * shp_4c_Shape1: separador decorativo direita (BackStyle=0, BorderStyle=0)
121:     *--------------------------------------------------------------------------
122:     PROTECTED PROCEDURE ConfigurarCabecalho()
123:         THIS.AddObject("cnt_4c_Sombra", "Container")
124:         WITH THIS.cnt_4c_Sombra
125:             .Top         = 0
126:             .Left        = 0
127:             .Width       = THIS.Width
128:             .Height      = 80
129:             .BorderWidth = 0
130:             .BackStyle   = 1
131:             .BackColor   = RGB(100, 100, 100)
132:             .Visible     = .T.
133:         ENDWITH
134: 
135:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
136:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
137:             .AutoSize      = .F.
138:             .FontBold      = .T.
139:             .FontName      = "Tahoma"
140:             .FontSize      = 18
141:             .FontUnderline = .F.
142:             .WordWrap      = .T.
143:             .Alignment     = 0
144:             .BackStyle     = 0
145:             .Caption       = THIS.Caption
146:             .Height        = 40
147:             .Left          = 10
148:             .Top           = 18
149:             .Width         = 769
150:             .ForeColor     = RGB(0, 0, 0)
151:             .Visible       = .T.
152:         ENDWITH
153: 
154:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
155:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
156:             .AutoSize      = .F.
157:             .FontBold      = .T.
158:             .FontName      = "Tahoma"
159:             .FontSize      = 18
160:             .WordWrap      = .T.
161:             .Alignment     = 0
162:             .BackStyle     = 0
163:             .Caption       = THIS.Caption
164:             .Height        = 46
165:             .Left          = 10
166:             .Top           = 17
167:             .Width         = 769
168:             .ForeColor     = RGB(255, 255, 255)
169:             .ToolTipText   = "T" + CHR(237) + "tulo"
170:             .Visible       = .T.
171:         ENDWITH
172: 
173:         *-- Shape decorativo: separador visual canto superior direito
174:         *-- Legado: Shape1 Top=7, Left=815, Height=41, Width=37
175:         THIS.AddObject("shp_4c_Shape1", "Shape")
176:         WITH THIS.shp_4c_Shape1
177:             .Top         = 7
178:             .Left        = 815
179:             .Height      = 41
180:             .Width       = 37
181:             .BackStyle   = 0
182:             .BorderStyle = 0
183:             .BorderColor = RGB(136, 189, 188)

*-- Linhas 232 a 297:
232:             .AutoSize    = .T.
233:             .ButtonCount = 5
234:             .Height      = 25
235:             .Left        = 128
236:             .Top         = 93
237:             .Width       = 744
238:             .Value       = 1
239:             .BackStyle   = 0
240:             .BorderStyle = 0
241: 
242:             WITH .Buttons(1)
243:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Estoque"
244:                 .BackStyle = 0
245:                 .Left      = 5
246:                 .Top       = 5
247:                 .AutoSize  = .T.
248:                 .ForeColor = RGB(90, 90, 90)
249:             ENDWITH
250: 
251:             WITH .Buttons(2)
252:                 .Caption   = "Grupo de Contas"
253:                 .FontName  = "Tahoma"
254:                 .FontSize  = 8
255:                 .BackStyle = 0
256:                 .Left      = 164
257:                 .Top       = 5
258:                 .AutoSize  = .T.
259:                 .ForeColor = RGB(90, 90, 90)
260:             ENDWITH
261: 
262:             WITH .Buttons(3)
263:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o"
264:                 .FontName  = "Tahoma"
265:                 .FontSize  = 8
266:                 .BackStyle = 0
267:                 .Left      = 289
268:                 .Top       = 5
269:                 .AutoSize  = .T.
270:                 .ForeColor = RGB(90, 90, 90)
271:                 .Themes    = .F.
272:             ENDWITH
273: 
274:             WITH .Buttons(4)
275:                 .Caption   = "Grupo de Produtos"
276:                 .FontName  = "Tahoma"
277:                 .FontSize  = 8
278:                 .BackStyle = 0
279:                 .Left      = 468
280:                 .Top       = 5
281:                 .AutoSize  = .T.
282:                 .ForeColor = RGB(90, 90, 90)
283:                 .Themes    = .F.
284:             ENDWITH
285: 
286:             WITH .Buttons(5)
287:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Financeira"
288:                 .FontName  = "Tahoma"
289:                 .FontSize  = 8
290:                 .BackStyle = 0
291:                 .Left      = 600
292:                 .Top       = 5
293:                 .AutoSize  = .T.
294:                 .ForeColor = RGB(90, 90, 90)
295:                 .Themes    = .F.
296:             ENDWITH
297:         ENDWITH

*-- Linhas 303 a 322:
303:     * ConfigurarGrade - Cria o grid com 7 colunas
304:     * Legado: grade_ale (Top=126, Left=18, Width=963, Height=460, ColumnCount=7)
305:     * Col1: TextBox Descricao (ReadOnly)
306:     * Col2-5: CheckBox flags (I/A/E/B) com Sparse=.F.
307:     * Col6: ComboBox Prioridade
308:     * Col7: EditBox Mensagem
309:     *--------------------------------------------------------------------------
310:     PROTECTED PROCEDURE ConfigurarGrade()
311:         LOCAL loc_oGrid
312: 
313:         THIS.AddObject("grd_4c_Dados", "Grid")
314:         loc_oGrid = THIS.grd_4c_Dados
315:         WITH loc_oGrid
316:             .Top                = 126
317:             .Left               = 18
318:             .Width              = 963
319:             .Height             = 460
320:             .ColumnCount        = 7
321:             .RowHeight          = 22
322:             .RecordMark         = .F.

*-- Linhas 342 a 429:
342:                 .BackColor   = RGB(255, 255, 255)
343:             ENDWITH
344:             .CurrentControl      = "Text1"
345:             .Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o"
346:             .Header1.Alignment   = 2
347:         ENDWITH
348: 
349:         *-- Coluna 2: CheckBox Inserir (I) - Sparse=.F. para mostrar em todas as linhas
350:         WITH loc_oGrid.Column2
351:             .Width      = 17
352:             .Movable    = .F.
353:             .Resizable  = .F.
354:             .Sparse     = .F.
355:             .ToolTipText = "Inserir"
356:             .AddObject("Check1", "CheckBox")
357:             WITH .Check1
358:                 .Caption    = ""
359:                 .BackColor  = RGB(255, 255, 255)
360:                 .Alignment  = 0
361:                 .Value      = 0
362:             ENDWITH
363:             .CurrentControl       = "Check1"
364:             .Header1.Caption      = "I"
365:             .Header1.Alignment    = 2
366:             .Header1.FontBold     = .T.
367:             .Header1.ToolTipText  = "Inserir"
368:         ENDWITH
369: 
370:         *-- Coluna 3: CheckBox Alterar (A)
371:         WITH loc_oGrid.Column3
372:             .Width      = 17
373:             .Movable    = .F.
374:             .Resizable  = .F.
375:             .Sparse     = .F.
376:             .ToolTipText = "Alterar"
377:             .AddObject("Check1", "CheckBox")
378:             WITH .Check1
379:                 .Caption   = ""
380:                 .Alignment = 0
381:                 .Value     = 0
382:             ENDWITH
383:             .CurrentControl       = "Check1"
384:             .Header1.Caption      = "A"
385:             .Header1.Alignment    = 2
386:             .Header1.FontBold     = .T.
387:             .Header1.ToolTipText  = "Alterar"
388:         ENDWITH
389: 
390:         *-- Coluna 4: CheckBox Excluir (E)
391:         WITH loc_oGrid.Column4
392:             .Width      = 17
393:             .Movable    = .F.
394:             .Resizable  = .F.
395:             .Sparse     = .F.
396:             .ToolTipText = "Excluir"
397:             .AddObject("Check1", "CheckBox")
398:             WITH .Check1
399:                 .Caption   = ""
400:                 .Alignment = 0
401:                 .Value     = 0
402:             ENDWITH
403:             .CurrentControl       = "Check1"
404:             .Header1.Caption      = "E"
405:             .Header1.Alignment    = 2
406:             .Header1.FontBold     = .T.
407:             .Header1.ToolTipText  = "Excluir"
408:         ENDWITH
409: 
410:         *-- Coluna 5: CheckBox Baixar (B)
411:         WITH loc_oGrid.Column5
412:             .Width      = 17
413:             .Movable    = .F.
414:             .Resizable  = .F.
415:             .Sparse     = .F.
416:             .ToolTipText = "Baixar"
417:             .AddObject("Check1", "CheckBox")
418:             WITH .Check1
419:                 .Caption   = ""
420:                 .Alignment = 0
421:                 .Value     = 0
422:             ENDWITH
423:             .CurrentControl       = "Check1"
424:             .Header1.Caption      = "B"
425:             .Header1.Alignment    = 2
426:             .Header1.FontBold     = .T.
427:             .Header1.ToolTipText  = "Baixar"
428:         ENDWITH
429: 

*-- Linhas 440 a 448:
440:                 .Style            = 2
441:             ENDWITH
442:             .CurrentControl    = "Combo1"
443:             .Header1.Caption   = "Prioridade"
444:             .Header1.Alignment = 2
445:         ENDWITH
446: 
447:         *-- Coluna 7: EditBox Mensagem
448:         WITH loc_oGrid.Column7

*-- Linhas 456 a 475:
456:                 .SpecialEffect = 1
457:             ENDWITH
458:             .CurrentControl    = "EditBox1"
459:             .Header1.Caption   = "Mensagem"
460:             .Header1.Alignment = 2
461:         ENDWITH
462: 
463:         BINDEVENT(loc_oGrid.Column6.Combo1, "InteractiveChange", THIS, "CboGradeComboChange")
464:     ENDPROC
465: 
466:     *--------------------------------------------------------------------------
467:     * ConfigurarPaginaDados - Area de acoes/dados do form OPERACIONAL
468:     * SIGCDALE nao tem Page2/Dados de cadastro CRUD; a "area de dados" desta
469:     * tela mapeia para o bloco de acoes sobre o registro em edicao:
470:     *   - Botoes cmd_4c_Confirmar / cmd_4c_Cancelar (delega a ConfigurarBotoes)
471:     *   - Ajuste do titulo do cabecalho conforme modo do form pai (INSERIR|ALTERAR)
472:     * Chamado apos ConfigurarPaginaLista para garantir que grid e OptionGroup ja
473:     * estao instanciados quando os botoes de acao forem bindados.
474:     *--------------------------------------------------------------------------
475:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 489 a 561:
489:         ENDCASE
490: 
491:         IF !EMPTY(loc_cSufixo) AND PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
492:             IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_Titulo", 5)
493:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption + loc_cSufixo
494:             ENDIF
495:             IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_Sombra", 5)
496:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption + loc_cSufixo
497:             ENDIF
498:         ENDIF
499: 
500:         *-- Habilitar/desabilitar Confirmar conforme codigo da conta recebido
501:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
502:             THIS.cmd_4c_Confirmar.Enabled = !EMPTY(THIS.this_cContas)
503:         ENDIF
504:     ENDPROC
505: 
506:     *--------------------------------------------------------------------------
507:     * ConfigurarBotoes - Cria botoes Confirmar e Cancelar
508:     * Legado: btnconfirma (Top=3, Left=850) e btnsair (Top=3, Left=925)
509:     *--------------------------------------------------------------------------
510:     PROTECTED PROCEDURE ConfigurarBotoes()
511:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
512:         WITH THIS.cmd_4c_Confirmar
513:             .Top             = 3
514:             .Left            = 850
515:             .Width           = 75
516:             .Height          = 75
517:             .Caption         = "Confirmar"
518:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
519:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
520:             .FontName        = "Comic Sans MS"
521:             .FontBold        = .T.
522:             .FontItalic      = .T.
523:             .FontSize        = 8
524:             .ForeColor       = RGB(90, 90, 90)
525:             .BackColor       = RGB(255, 255, 255)
526:             .Themes          = .T.
527:             .SpecialEffect   = 0
528:             .PicturePosition = 13
529:             .MousePointer    = 15
530:             .WordWrap        = .T.
531:         ENDWITH
532: 
533:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
534:         WITH THIS.cmd_4c_Cancelar
535:             .Top             = 3
536:             .Left            = 925
537:             .Width           = 75
538:             .Height          = 75
539:             .Caption         = "Encerrar"
540:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
541:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
542:             .FontName        = "Comic Sans MS"
543:             .FontBold        = .T.
544:             .FontItalic      = .T.
545:             .FontSize        = 8
546:             .ForeColor       = RGB(90, 90, 90)
547:             .BackColor       = RGB(255, 255, 255)
548:             .Themes          = .T.
549:             .SpecialEffect   = 0
550:             .PicturePosition = 13
551:             .MousePointer    = 15
552:             .WordWrap        = .T.
553:         ENDWITH
554: 
555:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
556:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
557:     ENDPROC
558: 
559:     *--------------------------------------------------------------------------
560:     * CarregarAlertas - Chama BO para popular crSigCdAle e vincula ao grid
561:     * Apos RecordSource, reconfigura headers (VFP9 reseta headers ao mudar RecordSource)

*-- Linhas 569 a 593:
569:                 THIS.grd_4c_Dados.ColumnCount = 7
570:                 THIS.grd_4c_Dados.RecordSource = "crSigCdAle"
571: 
572:                 *-- ControlSource: checkbox cols apos CurrentControl ja definido em ConfigurarGrade
573:                 THIS.grd_4c_Dados.Column1.ControlSource = "crSigCdAle.Descrs"
574:                 THIS.grd_4c_Dados.Column2.ControlSource = "crSigCdAle.inserirs"
575:                 THIS.grd_4c_Dados.Column3.ControlSource = "crSigCdAle.alterars"
576:                 THIS.grd_4c_Dados.Column4.ControlSource = "crSigCdAle.excluirs"
577:                 THIS.grd_4c_Dados.Column5.ControlSource = "crSigCdAle.baixas"
578:                 THIS.grd_4c_Dados.Column6.ControlSource = "crSigCdAle.prioridade"
579:                 THIS.grd_4c_Dados.Column7.ControlSource = "crSigCdAle.mensagems"
580: 
581:                 *-- Reconfigurar headers apos RecordSource (VFP9 reseta captions)
582:                 THIS.grd_4c_Dados.Column1.Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
583:                 THIS.grd_4c_Dados.Column2.Header1.Caption    = "I"
584:                 THIS.grd_4c_Dados.Column3.Header1.Caption    = "A"
585:                 THIS.grd_4c_Dados.Column4.Header1.Caption    = "E"
586:                 THIS.grd_4c_Dados.Column5.Header1.Caption    = "B"
587:                 THIS.grd_4c_Dados.Column6.Header1.Caption    = "Prioridade"
588:                 THIS.grd_4c_Dados.Column7.Header1.Caption    = "Mensagem"
589:                 THIS.grd_4c_Dados.Column2.Header1.Alignment  = 2
590:                 THIS.grd_4c_Dados.Column3.Header1.Alignment  = 2
591:                 THIS.grd_4c_Dados.Column4.Header1.Alignment  = 2
592:                 THIS.grd_4c_Dados.Column5.Header1.Alignment  = 2
593:                 THIS.grd_4c_Dados.Column6.Header1.Alignment  = 2

*-- Linhas 659 a 667:
659: 
660:     *--------------------------------------------------------------------------
661:     * BtnSalvarClick - Alias canonico do pipeline para o botao de confirmacao
662:     * O legado SIGCDALE usa btnconfirma (cmd_4c_Confirmar), sem botao "Salvar"
663:     * distinto. Este wrapper existe para compatibilidade com o contrato do
664:     * pipeline (validacao mecanica) e apenas delega para BtnConfirmarClick.
665:     *--------------------------------------------------------------------------
666:     PROCEDURE BtnSalvarClick()
667:         THIS.BtnConfirmarClick()

*-- Linhas 730 a 738:
730:     *--------------------------------------------------------------------------
731:     * BtnAlterarClick - Recarrega alertas do banco descartando edicoes em memoria
732:     * Semantica operacional: reverte alteracoes nao confirmadas + reforca foco
733:     * no grid para permitir edicao dos checkboxes/combobox/editbox
734:     *--------------------------------------------------------------------------
735:     PROCEDURE BtnAlterarClick()
736:         LOCAL loc_oErro
737: 
738:         TRY

*-- Linhas 889 a 898:
889:             loc_lHab = par_lHabilitar
890:         ENDIF
891: 
892:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
893:             THIS.cmd_4c_Confirmar.Enabled = loc_lHab AND !EMPTY(THIS.this_cContas)
894:         ENDIF
895:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
896:             THIS.grd_4c_Dados.ReadOnly = !loc_lHab
897:         ENDIF
898:         IF PEMSTATUS(THIS, "obj_4c_OptTabela", 5)

*-- Linhas 930 a 942:
930:         loc_lTemConta = !EMPTY(THIS.this_cContas)
931:         loc_lTemDados = USED("crSigCdAle") AND RECCOUNT("crSigCdAle") > 0
932: 
933:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
934:             THIS.cmd_4c_Confirmar.Enabled = loc_lTemConta
935:         ENDIF
936:         IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
937:             THIS.cmd_4c_Cancelar.Enabled = .T.
938:         ENDIF
939:         IF PEMSTATUS(THIS, "obj_4c_OptTabela", 5)
940:             THIS.obj_4c_OptTabela.Enabled = loc_lTemDados
941:         ENDIF
942:     ENDPROC


### BO (C:\4c\projeto\app\classes\aleBO.prg):
*==============================================================================
* ALEBO.PRG
* Business Object para Configuracao de Alertas por Conta (SigCdAle)
*
* Tabela Principal : SigCdAle - Alertas configurados por conta/operacao
*                    (pkchaves C(20) PK, dopes C, Tabelas C, inserirs N, alterars N,
*                     excluirs N, baixas N, priors N, mensagems text, datas T, dtalts T,
*                     contas C, grupos C, usuarios C)
*
* Logica: Form OPERACIONAL que configura quais alertas uma conta recebe
*         para cada tabela de referencia (SIGCDOPE/SIGCDGCR/SIGCDPRO/SIGCDOPD/SIGOPOPE).
*         Confirmar = DELETE todos os alertas da conta + re-INSERT apenas registros com
*         pelo menos um flag ativo (inserirs<>0 OR alterars<>0 OR excluirs<>0 OR baixas<>0).
*         O grid exibe uniao das 5 tabelas de referencia com LEFT JOIN em SigCdAle.
*==============================================================================

DEFINE CLASS aleBO AS BusinessBase

    *-- Identificacao da conta (parametro recebido pelo form)
    this_cContas              = ""    && IClis da conta selecionada (FK SigCdCli)

    *-- Campos da SigCdAle (registro atual)
    this_cDopes               = ""    && Codigo da operacao/grupo/produto (FK variavel)
    this_cTabelas             = ""    && Tabela de referencia (SIGCDOPE/SIGCDGCR/SIGCDPRO/SIGCDOPD/SIGOPOPE)
    this_nInserirs            = 0     && Flag permissao Inserir (0=nao, 1=sim)
    this_nAlterars            = 0     && Flag permissao Alterar (0=nao, 1=sim)
    this_nExcluirs            = 0     && Flag permissao Excluir (0=nao, 1=sim)
    this_nBaixas              = 0     && Flag permissao Baixar  (0=nao, 1=sim)
    this_nPriors              = 0     && Prioridade numerica (0=NORMAL, 1=URGENTE, 2=IMPORTANTE)
    this_cMensagems           = ""    && Mensagem de alerta (varchar/text)
    this_dDatas               = {}    && Data/hora de criacao
    this_dDtalts              = {}    && Data/hora de ultima alteracao
    this_cGrupos              = ""    && Grupo associado
    this_cPkChaves            = ""    && Chave primaria unica gerada por fUniqueIds()
    this_cUsuarios            = ""    && Usuario que realizou a configuracao

    *-- Descricao para exibicao (coluna Descrs do cursor, nao persiste em SigCdAle)
    this_cDescrs              = ""    && Descricao derivada da tabela de referencia

    *-- Modo de operacao herdado do form pai (INSERIR/ALTERAR)
    this_cPcEscolha           = ""    && Modo vindo de parentform.pcescolha

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdAle"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados de uma linha do cursor crSigCdAle
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes      = TratarNulo(Dopes,     "C")
                THIS.this_cDescrs     = TratarNulo(Descrs,    "C")
                THIS.this_cTabelas    = TratarNulo(Tabelas,   "C")
                THIS.this_nInserirs   = NVL(inserirs,  0)
                THIS.this_nAlterars   = NVL(alterars,  0)
                THIS.this_nExcluirs   = NVL(excluirs,  0)
                THIS.this_nBaixas     = NVL(baixas,    0)
                THIS.this_nPriors     = NVL(priors,    0)
                THIS.this_cMensagems  = TratarNulo(mensagems, "C")
                THIS.this_cGrupos     = TratarNulo(grupos,    "C")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,  "C")
                THIS.this_cContas     = TratarNulo(contas,    "C")
                THIS.this_cUsuarios   = TratarNulo(usuarios,  "C")

                IF VARTYPE(datas) = "T" OR VARTYPE(datas) = "D"
                    THIS.this_dDatas  = NVL(datas,  {})
                ELSE
                    THIS.this_dDatas  = {}
                ENDIF

                IF VARTYPE(dtalts) = "T" OR VARTYPE(dtalts) = "D"
                    THIS.this_dDtalts = NVL(dtalts, {})
                ELSE
                    THIS.this_dDtalts = {}
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para estado vazio
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cDopes      = ""
        THIS.this_cDescrs     = ""
        THIS.this_cTabelas    = ""
        THIS.this_nInserirs   = 0
        THIS.this_nAlterars   = 0
        THIS.this_nExcluirs   = 0
        THIS.this_nBaixas     = 0
        THIS.this_nPriors     = 0
        THIS.this_cMensagems  = ""
        THIS.this_cGrupos     = ""
        THIS.this_cPkChaves   = ""
        THIS.this_cUsuarios   = ""
        THIS.this_dDatas      = {}
        THIS.this_dDtalts     = {}
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAlertas - Popula os 5 cursores de referencia com LEFT JOIN SigCdAle
    * e une em crSigCdAle com INDEX ON Tabelas TAG Tabelas
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAlertas(par_cContas)
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_cContasEsc
        loc_lResultado = .F.
        THIS.this_cContas = ALLTRIM(NVL(par_cContas, ""))

        TRY
            loc_cContasEsc = EscaparSQL(THIS.this_cContas)

            *-- Movimentacao de Estoque (SigCdOpe)
            loc_cSQL = "SELECT OPE.dopes, OPE.Dopes AS Descrs, 'SIGCDOPE' AS Tabelas, " + ;
                "CASE WHEN ALE.inserirs IS NULL THEN 0 ELSE ALE.inserirs END inserirs, " + ;
                "CASE WHEN ALE.alterars IS NULL THEN 0 ELSE ALE.alterars END alterars, " + ;
                "CASE WHEN ALE.excluirs IS NULL THEN 0 ELSE ALE.excluirs END excluirs, " + ;
                "CASE WHEN ALE.baixas IS NULL THEN 0 ELSE ALE.baixas END baixas, " + ;
                "CASE WHEN ALE.priors = 1 THEN 'URGENTE' WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN ALE.mensagems IS NULL THEN '' ELSE ALE.mensagems END mensagems, " + ;
                "ALE.datas, ALE.dtalts, ALE.contas, " + ;
                "CASE WHEN ALE.grupos IS NULL THEN '' ELSE ALE.grupos END grupos, " + ;
                "CASE WHEN ALE.pkchaves IS NULL THEN '' ELSE ALE.pkchaves END pkchaves, " + ;
                "CASE WHEN ALE.priors IS NULL THEN 0 ELSE ALE.priors END priors, " + ;
                "CASE WHEN ALE.usuarios IS NULL THEN '' ELSE ALE.usuarios END usuarios " + ;
                "FROM SigCdOpe OPE " + ;
                "INNER JOIN SigOpCdc CDC ON CDC.Dopes = OPE.Dopes AND CDC.OpeInatvs = 0 " + ;
                "LEFT OUTER JOIN SigCdAle ALE ON OPE.Dopes = ALE.dopes " + ;
                "AND ALE.Tabelas = 'SIGCDOPE' AND ALE.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpe")

            *-- Grupo de Contas (SigCdGcr)
            loc_cSQL = "SELECT a.Codigos AS Dopes, a.Descrs, 'SIGCDGCR' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdGcr a " + ;
                "LEFT OUTER JOIN SigCdAle b ON SUBSTRING(b.Dopes, 1, 10) = a.Codigos " + ;
                "AND b.Tabelas = 'SIGCDGCR' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleGcr")

            *-- Grupo de Produtos (SigCdGrp -> SIGCDPRO)
            loc_cSQL = "SELECT a.Cgrus AS Dopes, a.Dgrus AS Descrs, 'SIGCDPRO' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdGrp a " + ;
                "LEFT OUTER JOIN SigCdAle b ON SUBSTRING(b.Dopes, 1, 3) = a.Cgrus " + ;
                "AND b.Tabelas = 'SIGCDPRO' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AlePro")

            *-- Movimentacao de Producao (SigCdOpd -> SIGCDOPD)
            loc_cSQL = "SELECT a.Dopps AS Dopes, a.Dopps AS Descrs, 'SIGCDOPD' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdOpd a " + ;
                "LEFT OUTER JOIN SigCdAle b ON b.Dopes = a.Dopps " + ;
                "AND b.Tabelas = 'SIGCDOPD' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpd")

            *-- Movimentacao Financeira (SigOpOpe -> SIGOPOPE)
            loc_cSQL = "SELECT a.Dopes AS Dopes, a.Dopes AS Descrs, 'SIGOPOPE' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigOpOpe a " + ;
                "LEFT OUTER JOIN SigCdAle b ON b.Dopes = a.Dopes " + ;
                "AND b.Tabelas = 'SIGOPOPE' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpOpe")

            *-- Unir os 5 cursores em crSigCdAle com estrutura identica
            IF USED("crSigCdAle")
                TABLEREVERT(.T., "crSigCdAle")
                USE IN crSigCdAle
            ENDIF

            SET NULL ON
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpe ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(RTRIM(Dopes) + " - " + RTRIM(Descrs), 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleGcr ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(RTRIM(Dopes) + " - " + RTRIM(Descrs), 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AlePro ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpd ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpOpe ;
            INTO CURSOR crSigCdAle READWRITE ORDER BY Tabelas, Dopes
            SET NULL OFF

            SELECT crSigCdAle
            INDEX ON Tabelas TAG Tabelas
            SET ORDER TO TAG Tabelas
            SET KEY TO "SIGCDOPE"
            GO TOP

            *-- Fechar cursores intermediarios
            IF USED("cursor_4c_AleOpe")
                USE IN cursor_4c_AleOpe
            ENDIF
            IF USED("cursor_4c_AleGcr")
                USE IN cursor_4c_AleGcr
            ENDIF
            IF USED("cursor_4c_AlePro")
                USE IN cursor_4c_AlePro
            ENDIF
            IF USED("cursor_4c_AleOpd")
                USE IN cursor_4c_AleOpd
            ENDIF
            IF USED("cursor_4c_AleOpOpe")
                USE IN cursor_4c_AleOpOpe
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao carregar alertas")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlertas - Salva configuracao de alertas da conta:
    *   1. Filtra crSigCdAle para registros com ao menos 1 flag ativo
    *   2. DELETE todos os alertas da conta no SQL Server
    *   3. Re-INSERT cada registro filtrado (INSERT direto via SQLEXEC)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlertas(par_cPcEscolha)
        LOCAL loc_lResultado, loc_oErro, loc_cSQL
        LOCAL loc_cDopes, loc_cTabelas, loc_nInserirs, loc_nAlterars
        LOCAL loc_nExcluirs, loc_nBaixas, loc_nPriors, loc_cMensagems
        LOCAL loc_cGrupos, loc_cPkChaves, loc_cUsuarios
        LOCAL loc_dDatas, loc_cContasEsc, loc_cPcEscolha
        loc_lResultado = .F.
        loc_cPcEscolha = UPPER(ALLTRIM(NVL(par_cPcEscolha, "")))

        TRY
            IF !USED("crSigCdAle")
                THIS.this_cMensagemErro = "Cursor de alertas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                MsgAviso(THIS.this_cMensagemErro, "Aviso")
            ELSE
                loc_cContasEsc = EscaparSQL(THIS.this_cContas)

                *-- Seleciona apenas registros com pelo menos um flag ativo
                SELECT Dopes, Tabelas, inserirs, alterars, excluirs, baixas, ;
                       prioridade, CAST(Mensagems AS CHAR(200)) AS Mensagems, ;
                       datas, dtalts, grupos, pkchaves, priors, usuarios ;
                    FROM crSigCdAle ;
                    WHERE inserirs <> 0 OR alterars <> 0 OR excluirs <> 0 OR baixas <> 0 ;
                    INTO CURSOR cursor_4c_AleSave READWRITE

                SELECT cursor_4c_AleSave
                GO TOP

                *-- DELETE todos os alertas existentes desta conta
                loc_cSQL = "DELETE FROM SigCdAle WHERE Contas = " + loc_cContasEsc
                SQLEXEC(gnConnHandle, loc_cSQL)

                *-- Re-INSERT cada registro ativo
                LOCAL loc_lErroInsert
                loc_lErroInsert = .F.
                SCAN
                    loc_cDopes     = ALLTRIM(NVL(Dopes,    ""))
                    loc_cTabelas   = ALLTRIM(NVL(Tabelas,  ""))
                    loc_nInserirs  = NVL(inserirs, 0)
                    loc_nAlterars  = NVL(alterars, 0)
                    loc_nExcluirs  = NVL(excluirs, 0)
                    loc_nBaixas    = NVL(baixas,   0)
                    loc_nPriors    = NVL(priors,   0)
                    loc_cMensagems = ALLTRIM(NVL(Mensagems, ""))
                    loc_cGrupos    = ALLTRIM(NVL(grupos,   ""))
                    loc_cUsuarios  = gc_4c_UsuarioLogado
                    loc_cPkChaves  = fUniqueIds()

                    IF loc_cPcEscolha = "INSERIR"
                        loc_dDatas    = GETDATE()
                        loc_cSQL = "INSERT INTO SigCdAle " + ;
                            "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                            "priors, mensagems, datas, contas, grupos, pkchaves, usuarios) " + ;
                            "VALUES (" + ;
                            EscaparSQL(loc_cDopes)     + ", " + ;
                            EscaparSQL(loc_cTabelas)   + ", " + ;
                            FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                            FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                            EscaparSQL(loc_cMensagems) + ", " + ;
                            "GETDATE(), "               + ;
                            EscaparSQL(THIS.this_cContas) + ", " + ;
                            EscaparSQL(loc_cGrupos)    + ", " + ;
                            EscaparSQL(loc_cPkChaves)  + ", " + ;
                            EscaparSQL(loc_cUsuarios)  + ")"
                    ELSE
                        *-- ALTERAR: preserva datas original se existir, gera dtalts
                        IF VARTYPE(datas) = "T" AND !EMPTY(datas)
                            loc_cSQL = "INSERT INTO SigCdAle " + ;
                                "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                                "priors, mensagems, datas, dtalts, contas, grupos, pkchaves, usuarios) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cDopes)     + ", " + ;
                                EscaparSQL(loc_cTabelas)   + ", " + ;
                                FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                                FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                                EscaparSQL(loc_cMensagems) + ", " + ;
                                FormatarDataSQL(datas)     + ", " + ;
                                "GETDATE(), "               + ;
                                EscaparSQL(THIS.this_cContas) + ", " + ;
                                EscaparSQL(loc_cGrupos)    + ", " + ;
                                EscaparSQL(loc_cPkChaves)  + ", " + ;
                                EscaparSQL(loc_cUsuarios)  + ")"
                        ELSE
                            loc_cSQL = "INSERT INTO SigCdAle " + ;
                                "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                                "priors, mensagems, datas, dtalts, contas, grupos, pkchaves, usuarios) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cDopes)     + ", " + ;
                                EscaparSQL(loc_cTabelas)   + ", " + ;
                                FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                                FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                                EscaparSQL(loc_cMensagems) + ", " + ;
                                "GETDATE(), "               + ;
                                "GETDATE(), "               + ;
                                EscaparSQL(THIS.this_cContas) + ", " + ;
                                EscaparSQL(loc_cGrupos)    + ", " + ;
                                EscaparSQL(loc_cPkChaves)  + ", " + ;
                                EscaparSQL(loc_cUsuarios)  + ")"
                        ENDIF
                    ENDIF

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        THIS.this_cMensagemErro = "Erro ao inserir alerta para " + loc_cDopes
                        MsgErro(THIS.this_cMensagemErro, "Erro ao salvar")
                        loc_lErroInsert = .T.
                        EXIT
                    ELSE
                        *-- Registra auditoria de cada linha inserida no batch
                        THIS.this_cPkChaves = loc_cPkChaves
                        THIS.RegistrarAuditoria(IIF(loc_cPcEscolha = "INSERIR", "INSERT", "UPDATE"))
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_AleSave")
                    USE IN cursor_4c_AleSave
                ENDIF

                IF !loc_lErroInsert
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao salvar alertas")
            IF USED("cursor_4c_AleSave")
                USE IN cursor_4c_AleSave
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro em SigCdAle
    * Usa as propriedades this_* previamente populadas (via FormParaBO ou setter)
    * Gera pkchaves via fUniqueIds(), datas via GETDATE()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cContas)
                THIS.this_cMensagemErro = "Conta n" + CHR(227) + "o informada"
            ELSE
                IF EMPTY(THIS.this_cDopes)
                    THIS.this_cMensagemErro = "C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informado"
                ELSE
                    IF EMPTY(THIS.this_cTabelas)
                        THIS.this_cMensagemErro = "Tabela de refer" + CHR(234) + "ncia n" + CHR(227) + "o informada"
                    ELSE
                        THIS.this_cPkChaves = fUniqueIds()
                        THIS.this_cUsuarios = gc_4c_UsuarioLogado

                        loc_cSQL = "INSERT INTO SigCdAle " + ;
                            "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                            "priors, mensagems, datas, contas, grupos, pkchaves, usuarios) " + ;
                            "VALUES (" + ;
                            EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cTabelas))   + ", " + ;
                            FormatarNumeroSQL(THIS.this_nInserirs, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nAlterars, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nExcluirs, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nBaixas,   0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nPriors,   0) + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cMensagems)) + ", " + ;
                            "GETDATE(), " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cContas))    + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cGrupos))    + ", " + ;
                            EscaparSQL(THIS.this_cPkChaves)           + ", " + ;
                            EscaparSQL(THIS.this_cUsuarios)           + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                        IF loc_nRet < 0
                            THIS.this_cMensagemErro = "Falha ao inserir alerta no SQL Server"
                        ELSE
                            THIS.RegistrarAuditoria("INSERT")
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarPorTabela - Aplica SET KEY TO na tabela de referencia selecionada
    * par_nOpcao: 1=SIGCDOPE, 2=SIGCDGCR, 3=SIGCDOPD, 4=SIGCDPRO, 5=SIGOPOPE
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarPorTabela(par_nOpcao)
        LOCAL loc_cChave, loc_oErro
        DO CASE
            CASE par_nOpcao = 1
                loc_cChave = "SIGCDOPE"
            CASE par_nOpcao = 2
                loc_cChave = "SIGCDGCR"
            CASE par_nOpcao = 3
                loc_cChave = "SIGCDOPD"
            CASE par_nOpcao = 4
                loc_cChave = "SIGCDPRO"
            OTHERWISE
                loc_cChave = "SIGOPOPE"
        ENDCASE

        TRY
            IF USED("crSigCdAle")
                SELECT crSigCdAle
                SET ORDER TO TAG Tabelas
                SET KEY TO loc_cChave
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

