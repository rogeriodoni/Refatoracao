# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroAcessoEmpresas()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarUniversoEmpresas()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarSelecaoParaGerar()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ContarSelecionados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Operacoes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRNSE.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2071 linhas total):

*-- Linhas 50 a 181:
50:     this_lEmLookupEmpresa = .F.
51: 
52:     *--------------------------------------------------------------------------
53:     * Init - Delega para FormBase.Init() -> InicializarForm()
54:     *--------------------------------------------------------------------------
55:     PROCEDURE Init()
56:         RETURN DODEFAULT()
57:     ENDPROC
58: 
59:     *--------------------------------------------------------------------------
60:     * InicializarForm - Cria o BO e monta o layout completo (cabecalho,
61:     * painel de criterios, grade de operacoes e botoes de acao), fechando com
62:     * o estado inicial do Init legado: ".AjustaControles(.t.)", ou seja
63:     * criterios LIBERADOS e Limpar / Gerar Arquivo / botoes de marcacao da
64:     * grade DESABILITADOS (os CommandGroup nascem Enabled = .T. no AddObject,
65:     * entao sem esta chamada o usuario consegue acionar "Gerar Arquivo" com a
66:     * grade vazia).
67:     *--------------------------------------------------------------------------
68:     PROTECTED PROCEDURE InicializarForm()
69:         LOCAL loc_lSucesso, loc_oErro
70:         loc_lSucesso = .F.
71: 
72:         TRY
73:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRNSEBO")
74: 
75:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
76:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
77: 
78:                 *-- Cursores (cursor_4c_Operacoes/cursor_4c_Municipios) tem de
79:                 *-- existir ANTES do Grid ser configurado - regra #41
80:                 *-- (Column.ControlSource de cursor inexistente derruba Init)
81:                 THIS.this_oBusinessObject.CriarCursoresAuxiliares()
82: 
83:                 THIS.ConfigurarPageFrame()
84:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
85:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
86:                 THIS.TornarControlesVisiveis(THIS)
87: 
88:                 *-- Defaults do Init legado:
89:                 *--     .getDtIni.Value   = Date()
90:                 *--     .getDtFin.Value   = Date()
91:                 *--     .cmbCidades.Value = [RJ - Rio de Janeiro]
92:                 *--     .getDirs.Value    = [C:\]
93:                 *-- carregados pelo par LimparCampos() -> BOParaForm(), com as
94:                 *-- properties do BO como FONTE UNICA dos criterios. Os mesmos
95:                 *-- valores aparecem no .Value de cada AddObject (o controle
96:                 *-- precisa nascer com o tipo certo - TextBox de data com {} /
97:                 *-- DATE(), nunca ""), mas quem manda a partir daqui eh o BO:
98:                 *-- sem esta chamada, this_nProcessados/this_cCidade ficariam
99:                 *-- em branco e o DO CASE de Processamento() nao casaria com
100:                 *-- municipio nenhum.
101:                 THIS.LimparCampos()
102: 
103:                 *-- Estado inicial do Init legado (.AjustaControles(.t.)) e
104:                 *-- primeira pintura da grade vazia (regra #21a - popular ou
105:                 *-- esvaziar cursor NAO repinta a grade sozinho)
106:                 THIS.AjustarBotoesPorModo(.T.)
107:                 THIS.AtualizarGrade()
108: 
109:                 loc_lSucesso = .T.
110:             ELSE
111:                 MsgErro("Erro ao criar SIGPRNSEBO. VARTYPE retornou: " + ;
112:                         VARTYPE(THIS.this_oBusinessObject), "Erro")
113:             ENDIF
114:         CATCH TO loc_oErro
115:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
116:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
117:             loc_lSucesso = .F.
118:         ENDTRY
119: 
120:         RETURN loc_lSucesso
121:     ENDPROC
122: 
123:     *--------------------------------------------------------------------------
124:     * ConfigurarPageFrame - Entry point de layout do form OPERACIONAL. Este
125:     * form nao usa PageFrame (legado sem BaseClass: pageframe) - mantido so
126:     * como ponto de entrada unico (padrao Formsigprnfe/Formsigprila), na
127:     * ordem de desenho do legado: cabecalho, criterios, grade e botoes.
128:     *--------------------------------------------------------------------------
129:     PROTECTED PROCEDURE ConfigurarPageFrame()
130:         THIS.ConfigurarCabecalho()
131:         THIS.ConfigurarPainelCriterios()
132:         THIS.ConfigurarGrade()
133:         THIS.ConfigurarBotoesAcao()
134:     ENDPROC
135: 
136:     *--------------------------------------------------------------------------
137:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra original).
138:     * Posicoes/tamanhos EXATOS do layout.json (PILAR 1), exceto Width do
139:     * container (canonico THIS.Width, nao o 1068 do dump legado).
140:     *--------------------------------------------------------------------------
141:     PROTECTED PROCEDURE ConfigurarCabecalho()
142:         LOCAL loc_oCab
143: 
144:         THIS.AddObject("cnt_4c_Sombra", "Container")
145:         WITH THIS.cnt_4c_Sombra
146:             .Top         = 0
147:             .Left        = 0
148:             .Width       = THIS.Width
149:             .Height      = 80
150:             .BackStyle   = 1
151:             .BackColor   = RGB(100, 100, 100)
152:             .BorderWidth = 0
153:             .Visible     = .T.
154:         ENDWITH
155:         loc_oCab = THIS.cnt_4c_Sombra
156: 
157:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
158:         WITH loc_oCab.lbl_4c_LblSombra
159:             .Top       = 18
160:             .Left      = 10
161:             .Width     = 769
162:             .Height    = 40
163:             .AutoSize  = .F.
164:             .WordWrap  = .T.
165:             .Alignment = 0
166:             .BackStyle = 0
167:             .FontBold  = .T.
168:             .FontName  = "Tahoma"
169:             .FontSize  = 18
170:             .ForeColor = RGB(0, 0, 0)
171:             .Caption   = THIS.Caption
172:         ENDWITH
173: 
174:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
175:         WITH loc_oCab.lbl_4c_LblTitulo
176:             .Top       = 17
177:             .Left      = 10
178:             .Width     = 769
179:             .Height    = 46
180:             .AutoSize  = .F.
181:             .WordWrap  = .T.

*-- Linhas 195 a 240:
195:     * O legado (SIGPRNSE.SCX) coloca estes controles DIRETO na Form, sem
196:     * container - posicoes/tamanhos EXATOS do dump (PILAR 1).
197:     *--------------------------------------------------------------------------
198:     PROTECTED PROCEDURE ConfigurarPainelCriterios()
199:         *-- Situacao: Nao Processadas (1) / Ja Processadas (2)
200:         THIS.AddObject("obj_4c_OptProcessados", "OptionGroup")
201:         WITH THIS.obj_4c_OptProcessados
202:             .ButtonCount = 2
203:             .BackStyle   = 0
204:             .BorderStyle = 0
205:             .Top         = 100
206:             .Left        = 127
207:             .Width       = 235
208:             .Height      = 15
209:             .Value       = 1
210:             .Visible     = .T.
211:         ENDWITH
212:         WITH THIS.obj_4c_OptProcessados.Buttons(1)
213:             .FontName  = "Tahoma"
214:             .FontSize  = 8
215:             .BackStyle = 0
216:             .Caption   = "N" + CHR(227) + "o Processadas"
217:             .Left      = 5
218:             .Top       = -1
219:             .AutoSize  = .T.
220:             .ForeColor = RGB(90, 90, 90)
221:             .Themes    = .T.
222:         ENDWITH
223:         WITH THIS.obj_4c_OptProcessados.Buttons(2)
224:             .FontName  = "Tahoma"
225:             .FontSize  = 8
226:             .BackStyle = 0
227:             .Caption   = "J" + CHR(225) + " Processadas"
228:             .Left      = 126
229:             .Top       = -1
230:             .AutoSize  = .T.
231:             .ForeColor = RGB(90, 90, 90)
232:             .Themes    = .T.
233:         ENDWITH
234: 
235:         *-- Periodo (De / Ate)
236:         THIS.AddObject("lbl_4c_Label1", "Label")
237:         WITH THIS.lbl_4c_Label1
238:             .Top       = 123
239:             .Left      = 79
240:             .AutoSize  = .T.

*-- Linhas 345 a 473:
345:         ENDWITH
346: 
347:         *-- getDEmps: descricao da empresa (SigCdEmp.Razas). O legado tem
348:         *--   PROCEDURE When -> Return Empty(ThisForm.getCEmps.Value)
349:         *-- ou seja: so se entra neste campo enquanto o CODIGO esta vazio
350:         *-- (preenchido o codigo, a descricao eh resultado do lookup e nao
351:         *-- entrada do usuario). BINDEVENT em "When" nao bloqueia (o retorno do
352:         *-- delegate eh descartado - regra #3), entao a regra eh aplicada por
353:         *-- .ReadOnly no funil THIS.AjustarCamposDependentes().
354:         THIS.AddObject("txt_4c_DEmps", "TextBox")
355:         WITH THIS.txt_4c_DEmps
356:             .Top               = 145
357:             .Left              = 168
358:             .Width             = 305
359:             .Height            = 23
360:             .Format            = "K"
361:             .Themes            = .F.
362:             .SpecialEffect     = 1
363:             .BorderColor       = RGB(90, 90, 90)
364:             .DisabledBackColor = RGB(255, 255, 255)
365:             .DisabledForeColor = RGB(36, 84, 155)
366:             .Value             = ""
367:             .ToolTipText       = "Empresa Para Filtro das Notas"
368:             .TabIndex          = 7
369:             .Visible           = .T.
370:         ENDWITH
371: 
372:         *-- Municipio (RJ / SP)
373:         THIS.AddObject("lbl_4c_Label3", "Label")
374:         WITH THIS.lbl_4c_Label3
375:             .Top       = 175
376:             .Left      = 70
377:             .AutoSize  = .T.
378:             .Alignment = 0
379:             .BackStyle = 0
380:             .FontName  = "Verdana"
381:             .FontSize  = 8
382:             .ForeColor = RGB(90, 90, 90)
383:             .Caption   = "Munic" + CHR(237) + "pio :"
384:             .TabIndex  = 8
385:             .Visible   = .T.
386:         ENDWITH
387: 
388:         *-- cmbCidades: RowSource FIXO do SCX (nao vem de SigCdMun - o cursor
389:         *-- cursor_4c_Municipios/LocalUfs do Init legado serve ao arquivo
390:         *-- gerado, nao a este combo). A lista eh regra de negocio: cada item
391:         *-- corresponde a um PROCEDURE de geracao (PrcRJRioDeJaneiro /
392:         *-- PrcSPSaoPaulo), e Processamento() casa por ALLTRIM do texto -
393:         *-- NAO acrescentar nem reordenar item.
394:         THIS.AddObject("cbo_4c_CmbCidades", "ComboBox")
395:         WITH THIS.cbo_4c_CmbCidades
396:             .Top               = 171
397:             .Left              = 134
398:             .Width             = 339
399:             .Height            = 22
400:             .Style             = 2
401:             .RowSourceType     = 1
402:             .RowSource         = "RJ - Rio de Janeiro,SP - S" + CHR(227) + "o Paulo"
403:             .ColumnWidths      = "60"
404:             .FontName          = "Courier New"
405:             .FontSize          = 8
406:             .Themes            = .F.
407:             .SpecialEffect     = 1
408:             .BorderColor       = RGB(90, 90, 90)
409:             .DisabledBackColor = RGB(255, 255, 255)
410:             .DisabledForeColor = RGB(36, 84, 155)
411:             .Value             = "RJ - Rio de Janeiro"
412:             .TabIndex          = 9
413:             .Visible           = .T.
414:         ENDWITH
415: 
416:         *-- Pasta do Arquivo (diretorio + botao de escolha)
417:         THIS.AddObject("lbl_4c_Label5", "Label")
418:         WITH THIS.lbl_4c_Label5
419:             .Top       = 200
420:             .Left      = 25
421:             .AutoSize  = .T.
422:             .Alignment = 0
423:             .BackStyle = 0
424:             .FontName  = "Verdana"
425:             .FontSize  = 8
426:             .ForeColor = RGB(90, 90, 90)
427:             .Caption   = "Pasta do Arquivo :"
428:             .TabIndex  = 10
429:             .Visible   = .T.
430:         ENDWITH
431: 
432:         *-- getDirs: o legado declara
433:         *--   PROCEDURE When -> Return .f.
434:         *-- isto eh, o campo NUNCA aceita digitacao - a pasta se escolhe SO
435:         *-- pelo botao ao lado (GETDIR). Por isso .ReadOnly = .T. aqui nao
436:         *-- contraria a regra "campo auto-preenchido nao eh ReadOnly": o SCX
437:         *-- bloqueia a entrada explicitamente. O botao continua gravando o
438:         *-- valor por codigo (BtnDirsClick), que ReadOnly nao impede.
439:         THIS.AddObject("txt_4c_Dirs", "TextBox")
440:         WITH THIS.txt_4c_Dirs
441:             .Top               = 196
442:             .Left              = 134
443:             .Width             = 421
444:             .Height            = 23
445:             .Format            = "K"
446:             .Themes            = .F.
447:             .SpecialEffect     = 1
448:             .BorderColor       = RGB(90, 90, 90)
449:             .DisabledBackColor = RGB(255, 255, 255)
450:             .DisabledForeColor = RGB(36, 84, 155)
451:             .ReadOnly          = .T.
452:             .Value             = "C:\"
453:             .ToolTipText       = "Diret" + CHR(243) + "rio / Pasta de Grava" + CHR(231) + CHR(227) + "o do Arquivo"
454:             .TabIndex          = 11
455:             .Visible           = .T.
456:         ENDWITH
457: 
458:         THIS.AddObject("cmd_4c_BtnDirs", "CommandButton")
459:         WITH THIS.cmd_4c_BtnDirs
460:             .Top           = 192
461:             .Left          = 558
462:             .Width         = 32
463:             .Height        = 30
464:             .Picture       = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
465:             .Caption       = ""
466:             .ToolTipText   = "Carregar o Diret" + CHR(243) + "rio / Pasta de Grava" + CHR(231) + CHR(227) + "o do Arquivo"
467:             .PicturePosition = 13
468:             .ForeColor     = RGB(90, 90, 90)
469:             .BackColor     = RGB(255, 255, 255)
470:             .Themes        = .T.
471:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
472:             .TabIndex      = 12
473:             .Visible       = .T.

*-- Linhas 500 a 595:
500:             .Visible         = .T.
501:         ENDWITH
502: 
503:         BINDEVENT(THIS.cmd_4c_BtnDirs, "Click", THIS, "BtnDirsClick")
504:         BINDEVENT(THIS.cmd_4c_BtnSelecionar, "Click", THIS, "BtnSelecionarClick")
505:         BINDEVENT(THIS.txt_4c_CEmps, "KeyPress", THIS, "ValidarEmpresaCEmps")
506:         BINDEVENT(THIS.txt_4c_DEmps, "KeyPress", THIS, "ValidarEmpresaDEmps")
507:         BINDEVENT(THIS.txt_4c_CEmps, "DblClick", THIS, "CEmpsDblClick")
508:         BINDEVENT(THIS.txt_4c_DEmps, "DblClick", THIS, "DEmpsDblClick")
509:         BINDEVENT(THIS.txt_4c_CEmps, "InteractiveChange", THIS, "AjustarCamposDependentes")
510: 
511:         *-- Estado inicial da dependencia getDEmps.When (codigo vazio ->
512:         *-- descricao liberada)
513:         THIS.AjustarCamposDependentes()
514:     ENDPROC
515: 
516:     *--------------------------------------------------------------------------
517:     * AjustarCamposDependentes - Regras de dependencia entre campos de criterio
518:     * que no legado moram no When de cada controle:
519:     *
520:     *   getDEmps.When -> Return Empty(ThisForm.getCEmps.Value)
521:     *   getDirs.When  -> Return .f.
522:     *
523:     * Como BINDEVENT descarta o retorno do delegate (regra #3), um When ligado
524:     * por BINDEVENT nao bloquearia nada - a regra eh aplicada por .ReadOnly.
525:     * Metodo PUBLIC porque eh chamado de FORA da classe pelo BINDEVENT de
526:     * InteractiveChange e pelos harness de teste.
527:     *
528:     * Chamado no FUNIL (regra #40): no fim do ConfigurarPainelCriterios, no fim
529:     * do AjustarBotoesPorModo e depois de cada caminho que resolve a empresa
530:     * (validacao exata e picker) - quem RESTRINGE tem de LIBERAR no caminho de
531:     * volta, senao limpar o codigo deixaria a descricao travada para sempre.
532:     *--------------------------------------------------------------------------
533:     PROCEDURE AjustarCamposDependentes()
534:         LOCAL loc_lCodigoVazio
535: 
536:         IF !PEMSTATUS(THIS, "txt_4c_CEmps", 5) OR !PEMSTATUS(THIS, "txt_4c_DEmps", 5)
537:             RETURN
538:         ENDIF
539: 
540:         loc_lCodigoVazio = EMPTY(ALLTRIM(THIS.txt_4c_CEmps.Value))
541: 
542:         THIS.txt_4c_DEmps.ReadOnly = !loc_lCodigoVazio
543: 
544:         *-- getDirs nunca aceita digitacao (When = .F. no legado) - reafirmado
545:         *-- aqui porque AjustarBotoesPorModo mexe no Enabled deste campo
546:         IF PEMSTATUS(THIS, "txt_4c_Dirs", 5)
547:             THIS.txt_4c_Dirs.ReadOnly = .T.
548:         ENDIF
549:     ENDPROC
550: 
551:     *--------------------------------------------------------------------------
552:     * BtnDirsClick - btnDirs.Click do legado: abre GETDIR() e grava a pasta
553:     * escolhida no campo de diretorio.
554:     *--------------------------------------------------------------------------
555:     PROCEDURE BtnDirsClick()
556:         LOCAL loc_cDir
557: 
558:         loc_cDir = ALLTRIM(THIS.txt_4c_Dirs.Value)
559:         loc_cDir = ALLTRIM(GETDIR(loc_cDir, ;
560:             "Selecione o Diret" + CHR(243) + "rio / Pasta De Grava" + CHR(231) + CHR(227) + "o do Arquivo", ;
561:             "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rios", 2))
562: 
563:         IF !EMPTY(loc_cDir)
564:             THIS.txt_4c_Dirs.Value = loc_cDir
565:         ENDIF
566:     ENDPROC
567: 
568:     *--------------------------------------------------------------------------
569:     * ObterFiltroAcessoEmpresas - Devolve a condicao WHERE (sobre SigCdEmp, sem
570:     * alias e sem o prefixo "WHERE"/"AND") que delimita as empresas que o
571:     * usuario logado PODE enxergar. Reproduz o universo do fAcessoEmpresa
572:     * legado (Framework\sigacess.PRG:732-790), que NAO eh "todas as linhas de
573:     * SigCdEmp":
574:     *
575:     *   1) llBlq = SigCdPam.BlqmEmps -> ligado, so a empresa corrente entra na
576:     *      lista (_Empr do legado -> go_4c_Sistema.cCodEmpresa);
577:     *   2) lista base = SigCdEmp INNER JOIN SigCdAcE (acesso do usuario),
578:     *      "Where b.Usuarios = <usuario logado>";
579:     *   3) llRst = (Reccount([crAr3]) < 1 Or llTot) -> usuario SEM nenhuma
580:     *      linha de acesso, OU usuario 4CONTROL, cai para SigCdEmp inteira.
581:     *
582:     * O "And a.Ativas = 1" do legado depende do 7o argumento (pAtv); a chamada
583:     * deste form tem 6 argumentos, entao pAtv eh .F. e o filtro NAO entra aqui.
584:     *
585:     * Coluna de empresa conferida em docs/schema.sql (regra #48 - o prefixo da
586:     * tabela NAO decide): SigCdEmp usa cemps/razas e SIGCDACE usa cemps (SEM o
587:     * C inicial) - nao espelhar o nome de um lado no outro.
588:     *
589:     * Devolve "" quando nao ha restricao nenhuma a aplicar.
590:     *--------------------------------------------------------------------------
591:     PROTECTED FUNCTION ObterFiltroAcessoEmpresas()
592:         LOCAL loc_cUsuario, loc_cEmpAtual, loc_lBloqueia, loc_lTudo
593:         LOCAL loc_cFiltro, loc_cRestricao, loc_nResultado, loc_oErro
594: 
595:         loc_cUsuario  = ""

*-- Linhas 673 a 1231:
673:             MsgErro("Erro ao apurar o acesso " + CHR(224) + "s empresas:" + CHR(13) + ;
674:                     loc_oErro.Message + CHR(13) + ;
675:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
676:                     "Procedure: " + loc_oErro.Procedure, "Erro")
677:             loc_cFiltro = ""
678:         ENDTRY
679: 
680:         RETURN loc_cFiltro
681:     ENDFUNC
682: 
683:     *--------------------------------------------------------------------------
684:     * CarregarUniversoEmpresas - Abre cursor_4c_EmpUniverso (Cemps/Razas) com
685:     * as empresas permitidas, para o match EXATO do Valid legado
686:     * (Seek(pChv, [crAr3], [Cemps]/[Razas])). Roda na data session PRIVADA do
687:     * form (DataSession = 2), por isso o cursor fica acessivel aos metodos
688:     * daqui - o picker, que vive na sessao default, recebe o mesmo filtro por
689:     * par_cFiltro em vez de depender deste cursor.
690:     *
691:     * Retorna .T. quando o cursor existe e tem ao menos uma linha.
692:     *--------------------------------------------------------------------------
693:     PROTECTED FUNCTION CarregarUniversoEmpresas(par_cFiltroAcesso)
694:         LOCAL loc_cFiltro, loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
695: 
696:         loc_lSucesso = .F.
697: 
698:         *-- O filtro pode vir pronto de quem ja o apurou (o picker precisa do
699:         *-- MESMO texto para repassar ao FormBuscaAuxiliar) - sem isso as duas
700:         *-- consultas de ObterFiltroAcessoEmpresas rodariam duas vezes por
701:         *-- abertura de lookup.
702:         loc_cFiltro = IIF(VARTYPE(par_cFiltroAcesso) = "C", par_cFiltroAcesso, ;
703:                           THIS.ObterFiltroAcessoEmpresas())
704: 
705:         TRY
706:             IF USED("cursor_4c_EmpUniverso")
707:                 USE IN cursor_4c_EmpUniverso
708:             ENDIF
709: 
710:             loc_cSQL = "SELECT cemps AS Cemps, razas AS Razas" + ;
711:                        "  FROM SigCdEmp" + ;
712:                        " WHERE 1 = 1" + ;
713:                        IIF(EMPTY(loc_cFiltro), "", " AND (" + loc_cFiltro + ")") + ;
714:                        " ORDER BY cemps"
715: 
716:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpUniverso")
717: 
718:             loc_lSucesso = (loc_nResultado > 0 AND USED("cursor_4c_EmpUniverso") ;
719:                             AND RECCOUNT("cursor_4c_EmpUniverso") > 0)
720: 
721:             IF loc_lSucesso
722:                 SELECT cursor_4c_EmpUniverso
723:                 GO TOP
724:             ENDIF
725:         CATCH TO loc_oErro
726:             MsgErro("Erro ao carregar as empresas dispon" + CHR(237) + "veis:" + CHR(13) + ;
727:                     loc_oErro.Message + CHR(13) + ;
728:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
729:                     "Procedure: " + loc_oErro.Procedure, "Erro")
730:             loc_lSucesso = .F.
731:         ENDTRY
732: 
733:         RETURN loc_lSucesso
734:     ENDFUNC
735: 
736:     *--------------------------------------------------------------------------
737:     * ValidarEmpresaCEmps - getCEmps.Valid do legado:
738:     *   =fAcessoEmpresa(Usuar, 'C', This.Value, getCEmps, getDEmps, poDataMgr)
739:     * modo LOOKUP de 6 argumentos - regra "fAcessoEmpresa NAO EXISTE": a funcao
740:     * nao foi portada, entao o contrato dela eh reproduzido aqui (universo
741:     * restrito por SIGCDACE/BlqmEmps + match exato + picker).
742:     *
743:     * Ligado a "KeyPress" e SO age em Enter(13)/Tab(9)/F4(115) - sem esse teste
744:     * o picker subiria a CADA tecla digitada (regra #47).
745:     *--------------------------------------------------------------------------
746:     PROCEDURE ValidarEmpresaCEmps(par_nKeyCode, par_nShiftAltCtrl)
747:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
748:             RETURN
749:         ENDIF
750: 
751:         IF THIS.this_lEmLookupEmpresa
752:             RETURN
753:         ENDIF
754: 
755:         THIS.ResolverEmpresa("C", (par_nKeyCode = 115))
756:     ENDPROC
757: 
758:     *--------------------------------------------------------------------------
759:     * ValidarEmpresaDEmps - getDEmps.Valid do legado:
760:     *   =fAcessoEmpresa(Usuar, 'D', This.Value, getCEmps, getDEmps, poDataMgr)
761:     * mesmo contrato, procurando por Razas (modo 'D') em vez de Cemps.
762:     *--------------------------------------------------------------------------
763:     PROCEDURE ValidarEmpresaDEmps(par_nKeyCode, par_nShiftAltCtrl)
764:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
765:             RETURN
766:         ENDIF
767: 
768:         IF THIS.this_lEmLookupEmpresa
769:             RETURN
770:         ENDIF
771: 
772:         THIS.ResolverEmpresa("D", (par_nKeyCode = 115))
773:     ENDPROC
774: 
775:     *--------------------------------------------------------------------------
776:     * CEmpsDblClick / DEmpsDblClick - duplo clique no campo abre o picker
777:     * direto, com o que ja estiver digitado como prefixo.
778:     *
779:     * NAO ligam a guarda this_lEmLookupEmpresa: eles DELEGAM para o funil
780:     * AbrirBuscaEmpresa, que eh quem liga e desliga a flag (regra #47 - irmao
781:     * que delega nao pode ligar a flag, senao o wrapper devolveria sem abrir
782:     * nada e o duplo clique ficaria morto).
783:     *--------------------------------------------------------------------------
784:     PROCEDURE CEmpsDblClick()
785:         THIS.AbrirBuscaEmpresa(ALLTRIM(THIS.txt_4c_CEmps.Value), "C")
786:     ENDPROC
787: 
788:     PROCEDURE DEmpsDblClick()
789:         THIS.AbrirBuscaEmpresa(ALLTRIM(THIS.txt_4c_DEmps.Value), "D")
790:     ENDPROC
791: 
792:     *--------------------------------------------------------------------------
793:     * ResolverEmpresa - Funil unico dos dois campos de empresa, reproduzindo o
794:     * corpo do fAcessoEmpresa:
795:     *
796:     *   a) pChv vazio  -> "If llRet" do legado: LIMPA os dois controles e nao
797:     *                     abre picker nenhum (F4 com campo vazio abre a lista);
798:     *   b) match EXATO dentro do universo permitido -> preenche codigo E
799:     *      descricao (o legado le crAr3.Cemps/crAr3.Razas apos o Seek);
800:     *   c) nao casou   -> abre o picker com o digitado como prefixo. NAO exibe
801:     *      "nenhuma empresa encontrada" nem apaga o que o usuario digitou
802:     *      (regra #50) - o proprio picker eh o retorno visual.
803:     *
804:     * O match eh EXATO de proposito: auto-preencher o primeiro registro que
805:     * apenas CONTEM o digitado eh o anti-padrao do fAcessoContas (Erro16).
806:     *--------------------------------------------------------------------------
807:     PROCEDURE ResolverEmpresa(par_cModo, par_lForcarPicker)
808:         LOCAL loc_cModo, loc_lForca, loc_cValor, loc_lAchou, loc_oErro
809: 
810:         loc_cModo  = IIF(VARTYPE(par_cModo) = "C" AND UPPER(ALLTRIM(par_cModo)) == "D", "D", "C")
811:         loc_lForca = (VARTYPE(par_lForcarPicker) = "L" AND par_lForcarPicker)
812:         loc_lAchou = .F.
813: 
814:         loc_cValor = IIF(loc_cModo == "D", ALLTRIM(THIS.txt_4c_DEmps.Value), ;
815:                                            ALLTRIM(THIS.txt_4c_CEmps.Value))
816: 
817:         *-- (a) campo vazio: o legado limpa pObC e pObD e devolve
818:         IF EMPTY(loc_cValor) AND !loc_lForca
819:             THIS.txt_4c_CEmps.Value = ""
820:             THIS.txt_4c_DEmps.Value = ""
821:             THIS.txt_4c_CEmps.Refresh
822:             THIS.txt_4c_DEmps.Refresh
823:             THIS.AjustarCamposDependentes()
824:             RETURN
825:         ENDIF
826: 
827:         *-- (b) match exato no universo permitido
828:         IF !loc_lForca
829:             TRY
830:                 IF THIS.CarregarUniversoEmpresas()
831:                     SELECT cursor_4c_EmpUniverso
832:                     IF loc_cModo == "D"
833:                         LOCATE FOR UPPER(ALLTRIM(cursor_4c_EmpUniverso.Razas)) == UPPER(loc_cValor)
834:                     ELSE
835:                         LOCATE FOR UPPER(ALLTRIM(cursor_4c_EmpUniverso.Cemps)) == UPPER(loc_cValor)
836:                     ENDIF
837: 
838:                     IF FOUND("cursor_4c_EmpUniverso")
839:                         THIS.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_EmpUniverso.Cemps)
840:                         THIS.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpUniverso.Razas)
841:                         loc_lAchou = .T.
842:                     ENDIF
843:                 ENDIF
844:             CATCH TO loc_oErro
845:                 MsgErro("Erro ao validar a empresa:" + CHR(13) + ;
846:                         loc_oErro.Message + CHR(13) + ;
847:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
848:                         "Procedure: " + loc_oErro.Procedure, "Erro")
849:             ENDTRY
850: 
851:             IF USED("cursor_4c_EmpUniverso")
852:                 USE IN cursor_4c_EmpUniverso
853:             ENDIF
854:         ENDIF
855: 
856:         IF loc_lAchou
857:             THIS.txt_4c_CEmps.Refresh
858:             THIS.txt_4c_DEmps.Refresh
859:             THIS.AjustarCamposDependentes()
860:         ELSE
861:             *-- (c) nao casou (ou F4): picker filtrado pelo prefixo digitado
862:             THIS.AbrirBuscaEmpresa(loc_cValor, loc_cModo)
863:         ENDIF
864:     ENDPROC
865: 
866:     *--------------------------------------------------------------------------
867:     * AbrirBuscaEmpresa - FUNIL do picker de empresa. Liga a guarda de
868:     * reentrancia e delega o corpo a AbrirBuscaEmpresaExec: o picker eh MODAL,
869:     * tira o foco do campo e redispara o proprio KeyPress, e os dois campos
870:     * (codigo e descricao) chamam o MESMO funil - sem a guarda abrem dois
871:     * dialogos empilhados. A flag eh liberada DEPOIS do ENDTRY para valer
872:     * tambem quando o corpo estoura, e o corpo fica num metodo separado porque
873:     * ele tem saidas antecipadas (regra #47 - set/clear em volta de um corpo
874:     * com RETURN trava a flag ligada e MATA o lookup pelo resto da vida do
875:     * form).
876:     *--------------------------------------------------------------------------
877:     PROCEDURE AbrirBuscaEmpresa(par_cValor, par_cModo)
878:         LOCAL loc_oErro
879: 
880:         IF THIS.this_lEmLookupEmpresa
881:             RETURN
882:         ENDIF
883: 
884:         THIS.this_lEmLookupEmpresa = .T.
885: 
886:         TRY
887:             THIS.AbrirBuscaEmpresaExec(par_cValor, par_cModo)
888:         CATCH TO loc_oErro
889:             MsgErro("Erro na busca de empresa:" + CHR(13) + ;
890:                     loc_oErro.Message + CHR(13) + ;
891:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
892:                     "Procedure: " + loc_oErro.Procedure, "Erro")
893:         ENDTRY
894: 
895:         THIS.this_lEmLookupEmpresa = .F.
896:     ENDPROC
897: 
898:     *--------------------------------------------------------------------------
899:     * AbrirBuscaEmpresaExec - Corpo do picker (equivale ao fwBuscaSel que o
900:     * fAcessoEmpresa abre quando o Seek falha).
901:     *
902:     * O FormBuscaAuxiliar vive na data session DEFAULT e este form tem
903:     * DataSession = 2, entao um cursor montado AQUI nao seria enxergado la e o
904:     * picker abriria VAZIO. Por isso o cursor eh populado pelo proprio Init do
905:     * FormBuscaAuxiliar - dentro da sessao dele - recebendo a restricao de
906:     * acesso no 9o argumento (par_cFiltro), e o resultado volta por
907:     * PROPRIEDADE (cCodigoSelecionado / cDescricaoSelecionada, preenchidas por
908:     * Mostrar()), nunca pela leitura do cursor.
909:     *
910:     * 1o argumento = gnConnHandle (regra #36 - passar a tabela ali desloca
911:     * todos os argumentos e o picker abre vazio).
912:     *--------------------------------------------------------------------------
913:     PROTECTED PROCEDURE AbrirBuscaEmpresaExec(par_cValor, par_cModo)
914:         LOCAL loc_cModo, loc_cValor, loc_cCampo, loc_cTitulo, loc_cFiltro
915:         LOCAL loc_oBusca, loc_lProsseguir
916: 
917:         loc_cModo  = IIF(VARTYPE(par_cModo) = "C" AND UPPER(ALLTRIM(par_cModo)) == "D", "D", "C")
918:         loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")
919:         loc_cCampo = IIF(loc_cModo == "D", "razas", "cemps")
920: 
921:         *-- Titulo do fwBuscaSel legado
922:         loc_cTitulo     = "Empresas"
923:         loc_lProsseguir = .T.
924: 
925:         *-- Apurado UMA vez e reusado nas duas pontas: a checagem de universo
926:         *-- vazio (aqui, na sessao privada) e o picker (na sessao default).
927:         loc_cFiltro = THIS.ObterFiltroAcessoEmpresas()
928: 
929:         *-- Universo vazio: nao ha picker para abrir. A mensagem eh o unico
930:         *-- retorno possivel - e NAO se apaga o que o usuario digitou
931:         *-- (regra #50).
932:         IF !THIS.CarregarUniversoEmpresas(loc_cFiltro)
933:             MsgAviso("Nenhuma empresa dispon" + CHR(237) + "vel para o usu" + CHR(225) + "rio.", ;
934:                      loc_cTitulo)
935:             loc_lProsseguir = .F.
936:         ENDIF
937: 
938:         IF USED("cursor_4c_EmpUniverso")
939:             USE IN cursor_4c_EmpUniverso
940:         ENDIF
941: 
942:         IF loc_lProsseguir
943:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
944:                 "SigCdEmp", ;
945:                 "cursor_4c_BuscaEmpresa", ;
946:                 loc_cCampo, ;
947:                 loc_cValor, ;
948:                 loc_cTitulo, ;
949:                 .F., ;
950:                 .T., ;
951:                 loc_cFiltro)
952: 
953:             IF VARTYPE(loc_oBusca) = "O"
954:                 *-- Campos lidos por Mostrar() para devolver o escolhido
955:                 loc_oBusca.this_cCampoCodigo    = "cemps"
956:                 loc_oBusca.this_cCampoDescricao = "razas"
957: 
958:                 IF loc_oBusca.this_lAchouRegistro
959:                     *-- regra #37: o Init ja resolveu sozinho (match exato de 1
960:                     *-- registro). NAO exibir o dialogo por cima do campo ja
961:                     *-- resolvido e NAO mexer no que o usuario digitou.
962:                     loc_oBusca.Release()
963:                 ELSE
964:                     *-- Ordem das colunas igual a do fwBuscaSel legado:
965:                     *--   modo C -> Codigo, Nome | modo D -> Nome, Codigo
966:                     IF loc_cModo == "D"
967:                         loc_oBusca.mAddColuna("razas", "", "Nome")
968:                         loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
969:                     ELSE
970:                         loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
971:                         loc_oBusca.mAddColuna("razas", "", "Nome")
972:                     ENDIF
973: 
974:                     IF loc_oBusca.Mostrar()
975:                         THIS.txt_4c_CEmps.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
976:                         THIS.txt_4c_DEmps.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
977:                     ENDIF
978:                     *-- Cancelar / ESC: preserva o digitado (regra #50). O
979:                     *-- legado zera os campos nesse caso, mas apagar o que o
980:                     *-- usuario escreveu o impede de corrigir o valor.
981:                     loc_oBusca.Release()
982:                 ENDIF
983:             ENDIF
984:         ENDIF
985: 
986:         THIS.txt_4c_CEmps.Refresh
987:         THIS.txt_4c_DEmps.Refresh
988:         THIS.AjustarCamposDependentes()
989:     ENDPROC
990: 
991:     *--------------------------------------------------------------------------
992:     * ConfigurarGrade - Grade de notas candidatas (GrdOperacoes do legado,
993:     * ligada a cursor_4c_Operacoes - equivalente a csOperacoes) + o editbox
994:     * de erros (getErros) e o rotulo "Erros dos Dados" (Say6). Posicoes/
995:     * tamanhos/colunas EXATOS do dump (PILAR 1) - o pColuna do legado
996:     * (Init/With .grdOperacoes) eh quem define largura/ControlSource reais,
997:     * nao apenas os headers do SCX.
998:     *--------------------------------------------------------------------------
999:     PROTECTED PROCEDURE ConfigurarGrade()
1000:         THIS.AddObject("grd_4c_Dados", "Grid")
1001:         WITH THIS.grd_4c_Dados
1002:             .Top               = 230
1003:             .Left              = 21
1004:             .Width             = 929
1005:             .Height            = 346
1006:             .HeaderHeight      = 19
1007:             .DeleteMark        = .F.
1008:             .RecordMark        = .F.
1009:             .ReadOnly          = .F.
1010:             .ScrollBars        = 2
1011:             .AllowHeaderSizing = .F.
1012:             .AllowRowSizing    = .F.
1013:             .ColumnCount       = 11
1014:             .RecordSource      = "cursor_4c_Operacoes"
1015:             .Visible           = .T.
1016:         ENDWITH
1017: 
1018:         WITH THIS.grd_4c_Dados.Column1
1019:             .Movable   = .F.
1020:             .Resizable = .F.
1021:         ENDWITH
1022:         THIS.grd_4c_Dados.Column1.AddObject("Check1", "CheckBox")
1023:         WITH THIS.grd_4c_Dados.Column1.Check1
1024:             .Caption  = ""
1025:             .AutoSize = .T.
1026:         ENDWITH
1027:         THIS.grd_4c_Dados.Column1.CurrentControl  = "Check1"
1028:         THIS.grd_4c_Dados.Column1.Sparse          = .F.
1029:         THIS.grd_4c_Dados.Column1.ReadOnly        = .F.
1030:         THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_Operacoes.SelImp"
1031:         THIS.grd_4c_Dados.Column1.Width           = 15
1032:         THIS.grd_4c_Dados.Column1.Header1.Caption = ""
1033: 
1034:         THIS.grd_4c_Dados.Column2.ControlSource  = "cursor_4c_Operacoes.Numes"
1035:         THIS.grd_4c_Dados.Column2.Width           = 52
1036:         THIS.grd_4c_Dados.Column2.Header1.Caption = "C" + CHR(243) + "digo"
1037: 
1038:         THIS.grd_4c_Dados.Column3.ControlSource  = "cursor_4c_Operacoes.Datas"
1039:         THIS.grd_4c_Dados.Column3.Width           = 80
1040:         THIS.grd_4c_Dados.Column3.Header1.Caption = "Data"
1041: 
1042:         THIS.grd_4c_Dados.Column4.ControlSource  = "cursor_4c_Operacoes.Valos"
1043:         THIS.grd_4c_Dados.Column4.Width           = 104
1044:         THIS.grd_4c_Dados.Column4.Header1.Caption = "Valor"
1045: 
1046:         THIS.grd_4c_Dados.Column5.ControlSource  = "cursor_4c_Operacoes.Notas"
1047:         THIS.grd_4c_Dados.Column5.Width           = 75
1048:         THIS.grd_4c_Dados.Column5.Header1.Caption = "Documento"
1049: 
1050:         THIS.grd_4c_Dados.Column6.ControlSource  = "cursor_4c_Operacoes.Usuars"
1051:         THIS.grd_4c_Dados.Column6.Width           = 85
1052:         THIS.grd_4c_Dados.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
1053: 
1054:         THIS.grd_4c_Dados.Column7.ControlSource  = "cursor_4c_Operacoes.ContaOs"
1055:         THIS.grd_4c_Dados.Column7.Width           = 85
1056:         THIS.grd_4c_Dados.Column7.Header1.Caption = "Origem"
1057: 
1058:         THIS.grd_4c_Dados.Column8.ControlSource  = "cursor_4c_Operacoes.ContaDs"
1059:         THIS.grd_4c_Dados.Column8.Width           = 85
1060:         THIS.grd_4c_Dados.Column8.Header1.Caption = "Destino"
1061: 
1062:         THIS.grd_4c_Dados.Column9.ControlSource  = "cursor_4c_Operacoes.Emps"
1063:         THIS.grd_4c_Dados.Column9.Width           = 37
1064:         THIS.grd_4c_Dados.Column9.Header1.Caption = "Emp"
1065: 
1066:         THIS.grd_4c_Dados.Column10.ControlSource  = "cursor_4c_Operacoes.Opers"
1067:         THIS.grd_4c_Dados.Column10.Width           = 37
1068:         THIS.grd_4c_Dados.Column10.Header1.Caption = "E / S"
1069: 
1070:         THIS.grd_4c_Dados.Column11.ControlSource  = "cursor_4c_Operacoes.Dopes"
1071:         THIS.grd_4c_Dados.Column11.Width           = 242
1072:         THIS.grd_4c_Dados.Column11.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1073: 
1074:         THIS.grd_4c_Dados.FontName = "Courier New"
1075:         THIS.grd_4c_Dados.SetAll("Movable", .F., "Column")
1076:         THIS.grd_4c_Dados.SetAll("Resizable", .F., "Column")
1077:         THIS.grd_4c_Dados.Column2.ReadOnly  = .T.
1078:         THIS.grd_4c_Dados.Column3.ReadOnly  = .T.
1079:         THIS.grd_4c_Dados.Column4.ReadOnly  = .T.
1080:         THIS.grd_4c_Dados.Column5.ReadOnly  = .T.
1081:         THIS.grd_4c_Dados.Column6.ReadOnly  = .T.
1082:         THIS.grd_4c_Dados.Column7.ReadOnly  = .T.
1083:         THIS.grd_4c_Dados.Column8.ReadOnly  = .T.
1084:         THIS.grd_4c_Dados.Column9.ReadOnly  = .T.
1085:         THIS.grd_4c_Dados.Column10.ReadOnly = .T.
1086:         THIS.grd_4c_Dados.Column11.ReadOnly = .T.
1087:         THIS.grd_4c_Dados.SetAll("DynamicForeColor", ;
1088:             "IIF(EMPTY(ALLTRIM(cursor_4c_Operacoes.Erros)), RGB(0,0,0), RGB(255,0,0))", "Column")
1089: 
1090:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1091:         BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "KeyPress", THIS, "CheckSelImpKeyPress")
1092:         BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "MouseDown", THIS, "CheckSelImpMouseDown")
1093:         BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "MouseUp", THIS, "CheckSelImpMouseUp")
1094:         BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "Click", THIS, "CheckSelImpClick")
1095: 
1096:         *-- Erros dos Dados (Say6 + getErros)
1097:         THIS.AddObject("lbl_4c_Label6", "Label")
1098:         WITH THIS.lbl_4c_Label6
1099:             .Top       = 580
1100:             .Left      = 21
1101:             .AutoSize  = .T.
1102:             .Alignment = 0
1103:             .BackStyle = 0
1104:             .FontName  = "Verdana"
1105:             .FontSize  = 8
1106:             *-- Branco TRANSCRITO do dump (Say6.ForeColor = 255,255,255): este
1107:             *-- rotulo fica sobre a faixa escura do rodape de new_background.jpg,
1108:             *-- nao sobre a textura clara das Pages de cadastro (regra #12)
1109:             .ForeColor = RGB(255, 255, 255)
1110:             .Caption   = "Erros dos Dados"
1111:             .TabIndex  = 18
1112:             .Visible   = .T.
1113:         ENDWITH
1114: 
1115:         THIS.AddObject("obj_4c_GetErros", "EditBox")
1116:         WITH THIS.obj_4c_GetErros
1117:             .Top               = 595
1118:             .Left              = 21
1119:             .Width             = 929
1120:             .Height            = 77
1121:             .Themes            = .F.
1122:             .SpecialEffect     = 1
1123:             .BorderColor       = RGB(90, 90, 90)
1124:             .DisabledBackColor = RGB(255, 255, 255)
1125:             .DisabledForeColor = RGB(36, 84, 155)
1126:             .ReadOnly          = .T.
1127:             .ControlSource     = "cursor_4c_Operacoes.Erros"
1128:             .TabIndex          = 19
1129:             .Visible           = .T.
1130:         ENDWITH
1131:     ENDPROC
1132: 
1133:     *--------------------------------------------------------------------------
1134:     * GradeAfterRowColChange - AfterRowColChange legado do GrdOperacoes:
1135:     * reflete o Erros da linha corrente no editbox abaixo da grade.
1136:     *--------------------------------------------------------------------------
1137:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1138:         THIS.obj_4c_GetErros.Refresh
1139:     ENDPROC
1140: 
1141:     *--------------------------------------------------------------------------
1142:     * CheckSelImpKeyPress/MouseDown/MouseUp/Click - Check1 da Column1 do
1143:     * legado: alterna SelImp manualmente (Gather Memvar), com o guard do
1144:     * When legado (so alterna linha SEM erro - Erros vazio) e NODEFAULT para
1145:     * suprimir o toggle nativo do CheckBox (regra "Grid CheckBox toggle").
1146:     *--------------------------------------------------------------------------
1147:     PROCEDURE CheckSelImpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1148:         IF INLIST(par_nKeyCode, 13, 32)
1149:             THIS.AlternarSelImpLinhaAtual()
1150:             NODEFAULT
1151:         ENDIF
1152:     ENDPROC
1153: 
1154:     PROCEDURE CheckSelImpMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1155:         THIS.AlternarSelImpLinhaAtual()
1156:         NODEFAULT
1157:     ENDPROC
1158: 
1159:     PROCEDURE CheckSelImpMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1160:         NODEFAULT
1161:     ENDPROC
1162: 
1163:     PROCEDURE CheckSelImpClick()
1164:         NODEFAULT
1165:     ENDPROC
1166: 
1167:     *--------------------------------------------------------------------------
1168:     * AlternarSelImpLinhaAtual - Corpo comum dos handlers do Check1 (regra
1169:     * do When legado: so alterna se a linha nao tiver erro de validacao).
1170:     *--------------------------------------------------------------------------
1171:     PROCEDURE AlternarSelImpLinhaAtual()
1172:         IF !USED("cursor_4c_Operacoes") OR EOF("cursor_4c_Operacoes")
1173:             RETURN
1174:         ENDIF
1175: 
1176:         IF !EMPTY(ALLTRIM(cursor_4c_Operacoes.Erros))
1177:             RETURN
1178:         ENDIF
1179: 
1180:         SELECT cursor_4c_Operacoes
1181:         REPLACE SelImp WITH !SelImp
1182:         THIS.grd_4c_Dados.Refresh
1183:     ENDPROC
1184: 
1185:     *--------------------------------------------------------------------------
1186:     * ConfigurarBotoesAcao - cmdBtnGrade (Marcar Tudo / Desmarcar /
1187:     * Documento) e cmdBtnForm (Limpar Sele" + CHR(231) + "ao / Gerar Arquivo
1188:     * / Sair do Processo). Posicoes/tamanhos/captions/icones EXATOS do dump
1189:     * (PILAR 1 + regra "Icone: TRANSCREVER, nunca inventar").
1190:     *--------------------------------------------------------------------------
1191:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1192:         THIS.AddObject("obj_4c_CmdBtnGrade", "CommandGroup")
1193:         WITH THIS.obj_4c_CmdBtnGrade
1194:             .ButtonCount = 3
1195:             .BackStyle   = 0
1196:             .BorderStyle = 0
1197:             .Top         = 339
1198:             .Left        = 957
1199:             .Width       = 43
1200:             .Height      = 135
1201:             .Value       = 1
1202:             .Visible     = .T.
1203:         ENDWITH
1204:         WITH THIS.obj_4c_CmdBtnGrade.Buttons(1)
1205:             .Top         = -1
1206:             .Left        = -1
1207:             .Height      = 45
1208:             .Width       = 45
1209:             .FontName    = "Verdana"
1210:             .FontSize    = 8
1211:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1212:             .Caption     = ""
1213:             .ToolTipText = "Selecionar"
1214:             .ForeColor   = RGB(36, 84, 155)
1215:             .BackColor   = RGB(255, 255, 255)
1216:             .Themes      = .F.
1217:         ENDWITH
1218:         WITH THIS.obj_4c_CmdBtnGrade.Buttons(2)
1219:             .Top         = 45
1220:             .Left        = -1
1221:             .Height      = 45
1222:             .Width       = 45
1223:             .FontName    = "Verdana"
1224:             .FontSize    = 8
1225:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1226:             .Caption     = ""
1227:             .ToolTipText = "Desmarcar"
1228:             .ForeColor   = RGB(36, 84, 155)
1229:             .BackColor   = RGB(255, 255, 255)
1230:             .Themes      = .F.
1231:         ENDWITH

*-- Linhas 1243 a 1286:
1243:             .BackColor   = RGB(255, 255, 255)
1244:             .Themes      = .F.
1245:         ENDWITH
1246:         BINDEVENT(THIS.obj_4c_CmdBtnGrade, "Click", THIS, "CmdBtnGradeClick")
1247: 
1248:         THIS.AddObject("obj_4c_CmdBtnForm", "CommandGroup")
1249:         WITH THIS.obj_4c_CmdBtnForm
1250:             .ButtonCount   = 3
1251:             .BackStyle     = 0
1252:             .BorderStyle   = 0
1253:             .Top           = -2
1254:             .Left          = 742
1255:             .Width         = 251
1256:             .Height        = 110
1257:             .SpecialEffect = 1
1258:             .BorderColor   = RGB(136, 189, 188)
1259:             .Value         = 1
1260:             .Visible       = .T.
1261:         ENDWITH
1262:         WITH THIS.obj_4c_CmdBtnForm.Buttons(1)
1263:             .Top             = 5
1264:             .Left            = 11
1265:             .Height          = 75
1266:             .Width           = 75
1267:             .FontBold        = .T.
1268:             .FontItalic      = .T.
1269:             .FontName        = "Comic Sans MS"
1270:             .FontSize        = 8
1271:             .WordWrap        = .T.
1272:             .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
1273:             .Caption         = "Limpar Sele" + CHR(231) + CHR(227) + "o"
1274:             .ToolTipText     = "Limpar a Sele" + CHR(231) + CHR(227) + "o da Grade Abaixo"
1275:             .PicturePosition = 7
1276:             .ForeColor       = RGB(90, 90, 90)
1277:             .BackColor       = RGB(255, 255, 255)
1278:             .Themes          = .F.
1279:         ENDWITH
1280:         WITH THIS.obj_4c_CmdBtnForm.Buttons(2)
1281:             .Top             = 5
1282:             .Left            = 86
1283:             .Height          = 75
1284:             .Width           = 75
1285:             .FontBold        = .T.
1286:             .FontItalic      = .T.

*-- Linhas 1314 a 1706:
1314:             .BackColor       = RGB(255, 255, 255)
1315:             .Themes          = .F.
1316:         ENDWITH
1317:         BINDEVENT(THIS.obj_4c_CmdBtnForm, "Click", THIS, "CmdBtnFormClick")
1318:     ENDPROC
1319: 
1320:     *--------------------------------------------------------------------------
1321:     * CmdBtnGradeClick - Click legado do cmdBtnGrade: Marcar Tudo (1),
1322:     * Desmarcar (2), Documento (3 - abre FormSigMvExp sobre a operacao
1323:     * corrente da grade).
1324:     *--------------------------------------------------------------------------
1325:     PROCEDURE CmdBtnGradeClick()
1326:         LOCAL loc_oForm, loc_oErro
1327: 
1328:         IF !USED("cursor_4c_Operacoes")
1329:             RETURN
1330:         ENDIF
1331: 
1332:         DO CASE
1333:             CASE THIS.obj_4c_CmdBtnGrade.Value = 1 AND THIS.obj_4c_CmdBtnGrade.Buttons(1).Enabled
1334:                 *-- Marca Tudo (so as linhas SEM erro de validacao)
1335:                 SELECT cursor_4c_Operacoes
1336:                 REPLACE ALL SelImp WITH .T. FOR EMPTY(ALLTRIM(Erros))
1337:                 THIS.AtualizarGrade()
1338: 
1339:             CASE THIS.obj_4c_CmdBtnGrade.Value = 2 AND THIS.obj_4c_CmdBtnGrade.Buttons(2).Enabled
1340:                 *-- Desmarcar
1341:                 SELECT cursor_4c_Operacoes
1342:                 REPLACE ALL SelImp WITH .F.
1343:                 THIS.AtualizarGrade()
1344: 
1345:             CASE THIS.obj_4c_CmdBtnGrade.Value = 3 AND THIS.obj_4c_CmdBtnGrade.Buttons(3).Enabled
1346:                 *-- Documento: "Do Form SigMvExp With csOperacoes.Dopes, 'C',
1347:                 *-- csOperacoes.Numes, csOperacoes.Emps, .t." do legado
1348:                 IF !EOF("cursor_4c_Operacoes")
1349:                     loc_oForm = .NULL.
1350:                     TRY
1351:                         loc_oForm = CREATEOBJECT("FormSigMvExp", cursor_4c_Operacoes.Dopes, "C", ;
1352:                             cursor_4c_Operacoes.Numes, cursor_4c_Operacoes.Emps, .T.)
1353:                     CATCH TO loc_oErro
1354:                         MsgErro(loc_oErro.Message + CHR(13) + ;
1355:                                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1356:                                 "Procedure: " + loc_oErro.Procedure, ;
1357:                                 "Erro ao abrir documento")
1358:                         loc_oForm = .NULL.
1359:                     ENDTRY
1360: 
1361:                     *-- Show() de form MODAL fica FORA do TRY (regra #29): com
1362:                     *-- ele dentro, qualquer erro de runtime do FormSigMvExp
1363:                     *-- salta para o CATCH, a referencia LOCAL cai e a tela
1364:                     *-- fecha sozinha
1365:                     IF VARTYPE(loc_oForm) = "O"
1366:                         loc_oForm.Show()
1367:                     ENDIF
1368:                 ENDIF
1369:         ENDCASE
1370:     ENDPROC
1371: 
1372:     *--------------------------------------------------------------------------
1373:     * BtnSelecionarClick - btnSelecionar.Valid legado (ThisForm.Selecionar).
1374:     * Fica SO com as validacoes de tela (datas, empresa, diretorio,
1375:     * confirmacao de reprocessamento), transcritas LITERALMENTE do legado; a
1376:     * carga de dados e a repintura da grade sao delegadas ao funil unico
1377:     * THIS.CarregarLista().
1378:     *--------------------------------------------------------------------------
1379:     PROCEDURE BtnSelecionarClick()
1380:         LOCAL loc_lNaoProcessadas, loc_cEmps, loc_dDtIni, loc_dDtFin, loc_cDir
1381: 
1382:         loc_lNaoProcessadas = (THIS.obj_4c_OptProcessados.Value = 1)
1383:         loc_cEmps           = PADR(ALLTRIM(THIS.txt_4c_CEmps.Value), 3)
1384:         loc_dDtIni           = THIS.txt_4c_DtIni.Value
1385:         loc_dDtFin           = THIS.txt_4c_DtFin.Value
1386:         loc_cDir             = ALLTRIM(THIS.txt_4c_Dirs.Value)
1387: 
1388:         IF !loc_lNaoProcessadas
1389:             IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Notas Fiscais J" + CHR(225) + " Processadas Anteriormente?" + CHR(13) + ;
1390:                             "Este Processo Poder" + CHR(225) + " Sobrepor Registros no Arquivo Gerado e Pode" + CHR(13) + ;
1391:                             "Causar Duplicidade ou Mesmo Cancelamento das Notas Anteriores!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
1392:                 THIS.obj_4c_OptProcessados.Value = 1
1393:                 RETURN
1394:             ENDIF
1395:         ENDIF
1396: 
1397:         IF EMPTY(loc_dDtIni)
1398:             MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!", "Dados Inv" + CHR(225) + "lidos")
1399:             THIS.txt_4c_DtIni.SetFocus
1400:             RETURN
1401:         ENDIF
1402: 
1403:         IF EMPTY(loc_dDtFin)
1404:             MsgAviso("Data Final Inv" + CHR(225) + "lida!!!", "Dados Inv" + CHR(225) + "lidos")
1405:             THIS.txt_4c_DtFin.SetFocus
1406:             RETURN
1407:         ENDIF
1408: 
1409:         IF loc_dDtFin < loc_dDtIni
1410:             MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!", "Dados Inv" + CHR(225) + "lidos")
1411:             THIS.txt_4c_DtFin.SetFocus
1412:             RETURN
1413:         ENDIF
1414: 
1415:         IF EMPTY(loc_cEmps)
1416:             MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", "Dados Inv" + CHR(225) + "lidos")
1417:             THIS.txt_4c_CEmps.SetFocus
1418:             RETURN
1419:         ENDIF
1420: 
1421:         IF EMPTY(loc_cDir) OR !DIRECTORY(loc_cDir)
1422:             MsgAviso("Pasta do Arquivo Inv" + CHR(225) + "lida!!!", "Dados Inv" + CHR(225) + "lidos")
1423:             THIS.cmd_4c_BtnDirs.SetFocus
1424:             RETURN
1425:         ENDIF
1426: 
1427:         THIS.CarregarLista()
1428:     ENDPROC
1429: 
1430:     *--------------------------------------------------------------------------
1431:     * CarregarLista - FUNIL UNICO de carga da grade de operacoes: equivale ao
1432:     * trecho de DADOS do "PROCEDURE selecionar" legado (a consulta de notas de
1433:     * saida + a gravacao das linhas de controle em SigPcOoL ficam no BO) e ao
1434:     * seu fechamento:
1435:     *
1436:     *     ThisForm.AjustaControles(.f.)
1437:     *     ThisForm.grdOperacoes.Column1.SetFocus
1438:     *     ThisForm.grdOperacoes.Column1.Refresh
1439:     *     ThisForm.grdOperacoes.Refresh
1440:     *
1441:     * Le os criterios da tela (fonte unica - os TextBox sao o que o usuario
1442:     * acabou de digitar, nunca uma property guardada de um lote anterior) e,
1443:     * tendo o BO populado o cursor, trava os criterios, libera os botoes de
1444:     * marcacao / Limpar / Gerar Arquivo e repinta pelo funil AtualizarGrade().
1445:     *
1446:     * Falhando a carga, o estado da tela NAO muda: os criterios continuam
1447:     * liberados para o usuario corrigir o filtro (o legado faz o mesmo, com
1448:     * AjustaControles(.t.) em cada caminho de erro do selecionar).
1449:     *--------------------------------------------------------------------------
1450:     PROCEDURE CarregarLista()
1451:         LOCAL loc_lResultado, loc_oErro
1452:         LOCAL loc_lNaoProcessadas
1453: 
1454:         loc_lResultado = .F.
1455: 
1456:         TRY
1457:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1458:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + ;
1459:                         "vel.", "Erro ao carregar a sele" + CHR(231) + CHR(227) + "o")
1460:             ELSE
1461:                 *-- Le os criterios da tela UMA vez, pelo hook (FONTE UNICA):
1462:                 *-- dai em diante quem responde pelo filtro sao as properties
1463:                 *-- do BO, inclusive para o Processamento mais adiante
1464:                 THIS.FormParaBO()
1465: 
1466:                 loc_lNaoProcessadas = (THIS.this_oBusinessObject.this_nProcessados = 1)
1467: 
1468:                 *-- BuscarNotasPendentes mantem a assinatura por parametro
1469:                 *-- (contrato da Fase 2) e reatribui as mesmas properties ao
1470:                 *-- entrar - passar as properties de volta eh idempotente e
1471:                 *-- evita que as duas copias do filtro divirjam
1472:                 loc_lResultado = THIS.this_oBusinessObject.BuscarNotasPendentes( ;
1473:                     THIS.this_oBusinessObject.this_cEmps, ;
1474:                     THIS.this_oBusinessObject.this_dDtIni, ;
1475:                     THIS.this_oBusinessObject.this_dDtFin, ;
1476:                     loc_lNaoProcessadas, ;
1477:                     THIS.this_oBusinessObject.this_cDiretorio)
1478: 
1479:                 IF loc_lResultado
1480:                     *-- AjustaControles(.f.) do legado: criterios travados e
1481:                     *-- botoes de grade / Limpar / Gerar Arquivo liberados
1482:                     THIS.AjustarBotoesPorModo(.F.)
1483:                     THIS.AtualizarGrade()
1484:                     THIS.grd_4c_Dados.Column1.SetFocus
1485:                 ENDIF
1486:             ENDIF
1487:         CATCH TO loc_oErro
1488:             MsgErro(loc_oErro.Message + CHR(13) + ;
1489:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1490:                     "Procedure: " + loc_oErro.Procedure, ;
1491:                     "Erro ao carregar a sele" + CHR(231) + CHR(227) + "o")
1492:             loc_lResultado = .F.
1493:         ENDTRY
1494: 
1495:         RETURN loc_lResultado
1496:     ENDPROC
1497: 
1498:     *--------------------------------------------------------------------------
1499:     * AtualizarGrade - FUNIL UNICO de repintura da grade (regra #21a): encher
1500:     * ou esvaziar o cursor NAO faz a grade se redesenhar, e o legado sempre
1501:     * fecha cada caminho com "Go Top" + "ThisForm.GrdOperacoes.Refresh". Sem
1502:     * passar por aqui a grade fica visualmente desatualizada com o cursor
1503:     * correto, e o sintoma ("a tela nao traz dados") manda o diagnostico para
1504:     * SQL/cursor/permissao.
1505:     *
1506:     * Repinta tambem o editbox de erros, que exibe o Erros da linha corrente
1507:     * (mesmo efeito do AfterRowColChange legado) - depois de um ZAP a linha
1508:     * corrente deixa de existir e o texto antigo continuaria na tela.
1509:     *--------------------------------------------------------------------------
1510:     PROCEDURE AtualizarGrade()
1511:         LOCAL loc_oErro
1512: 
1513:         TRY
1514:             IF USED("cursor_4c_Operacoes")
1515:                 SELECT cursor_4c_Operacoes
1516:                 GO TOP IN cursor_4c_Operacoes
1517:             ENDIF
1518: 
1519:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1520:                 THIS.grd_4c_Dados.Column1.Refresh
1521:                 THIS.grd_4c_Dados.Refresh
1522:             ENDIF
1523: 
1524:             IF PEMSTATUS(THIS, "obj_4c_GetErros", 5)
1525:                 THIS.obj_4c_GetErros.Refresh
1526:             ENDIF
1527:         CATCH TO loc_oErro
1528:             MsgErro(loc_oErro.Message + CHR(13) + ;
1529:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1530:                     "Procedure: " + loc_oErro.Procedure, ;
1531:                     "Erro ao atualizar a grade")
1532:         ENDTRY
1533:     ENDPROC
1534: 
1535:     *--------------------------------------------------------------------------
1536:     * LimparSelecao - Par do "Zap In csOperacoes" + "ThisForm.AjustaControles
1537:     * (.t.)" do legado: esvazia a grade, devolve os criterios a edicao e
1538:     * repinta pelo funil. Quem DESABILITA tem de REABILITAR no caminho de
1539:     * volta (regra #40) - sem isto a tela fica travada apos gerar o arquivo.
1540:     *--------------------------------------------------------------------------
1541:     PROCEDURE LimparSelecao()
1542:         LOCAL loc_oErro, loc_cSafety
1543: 
1544:         *-- SET SAFETY eh ESCOPADO POR DATA SESSION: este form tem
1545:         *-- DataSession = 2 e, medido no VFP9, a sessao privada nasce com
1546:         *-- SAFETY = ON mesmo com o SET SAFETY OFF do main.prg (sessao 1 = OFF,
1547:         *-- sessao privada = ON). Com SAFETY ON o ZAP abre o dialogo modal
1548:         *-- "Zap ... Are you sure?" e a tela CONGELA esperando um clique que o
1549:         *-- usuario nao ve - exatamente o que aconteceria ao clicar "Limpar
1550:         *-- Selecao" e ao terminar de gerar o arquivo (Processamento tambem
1551:         *-- chama este metodo). Guardar/restaurar em volta do ZAP, e restaurar
1552:         *-- tambem no CATCH para o SET nao vazar na sessao privada.
1553:         loc_cSafety = SET("SAFETY")
1554: 
1555:         TRY
1556:             IF USED("cursor_4c_Operacoes")
1557:                 SELECT cursor_4c_Operacoes
1558:                 SET SAFETY OFF
1559:                 ZAP
1560:                 IF loc_cSafety = "ON"
1561:                     SET SAFETY ON
1562:                 ENDIF
1563:             ENDIF
1564: 
1565:             THIS.AjustarBotoesPorModo(.T.)
1566:             THIS.AtualizarGrade()
1567:         CATCH TO loc_oErro
1568:             IF loc_cSafety = "ON"
1569:                 SET SAFETY ON
1570:             ENDIF
1571: 
1572:             MsgErro(loc_oErro.Message + CHR(13) + ;
1573:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1574:                     "Procedure: " + loc_oErro.Procedure, ;
1575:                     "Erro ao limpar a sele" + CHR(231) + CHR(227) + "o")
1576:         ENDTRY
1577:     ENDPROC
1578: 
1579:     *--------------------------------------------------------------------------
1580:     * AjustarBotoesPorModo - Equivalente a ajustacontroles(pTip) do legado:
1581:     * par_lCriteriosLiberados = .T. libera os criterios de tela e desabilita
1582:     * Limpar/Gerar Arquivo/marcacao da grade; .F. eh o inverso (apos
1583:     * Selecionar com sucesso).
1584:     *--------------------------------------------------------------------------
1585:     PROCEDURE AjustarBotoesPorModo(par_lCriteriosLiberados)
1586:         *-- Metade "controles de criterio" do ajustacontroles legado (as dez
1587:         *-- primeiras linhas do With ThisForm)
1588:         THIS.HabilitarCampos(par_lCriteriosLiberados)
1589: 
1590:         *-- Metade "botoes de acao" (as cinco linhas com "Not pTip")
1591:         THIS.obj_4c_CmdBtnForm.Buttons(1).Enabled  = !par_lCriteriosLiberados
1592:         THIS.obj_4c_CmdBtnForm.Buttons(2).Enabled  = !par_lCriteriosLiberados
1593:         THIS.obj_4c_CmdBtnGrade.Buttons(1).Enabled = !par_lCriteriosLiberados
1594:         THIS.obj_4c_CmdBtnGrade.Buttons(2).Enabled = !par_lCriteriosLiberados
1595:         THIS.obj_4c_CmdBtnGrade.Buttons(3).Enabled = !par_lCriteriosLiberados
1596:     ENDPROC
1597: 
1598:     *--------------------------------------------------------------------------
1599:     * HabilitarCampos - Liga/desliga os CONTROLES DE CRITERIO da tela. Eh a
1600:     * primeira metade do ajustacontroles(pTip) legado, transcrita na mesma
1601:     * ordem e com o mesmo sinal (aqui pTip = par_lHabilitar):
1602:     *
1603:     *     .optProcessados.Option1.Enabled = pTip
1604:     *     .optProcessados.Option2.Enabled = pTip
1605:     *     .getDtIni.Enabled               = pTip
1606:     *     .getDtFin.Enabled               = pTip
1607:     *     .getCEmps.Enabled               = pTip
1608:     *     .getDEmps.Enabled               = pTip
1609:     *     .cmbCidades.Enabled             = pTip
1610:     *     .btnSelecionar.Enabled          = pTip
1611:     *     .getDirs.Enabled                = pTip
1612:     *     .btnDirs.Enabled                = pTip
1613:     *
1614:     * Separado de AjustarBotoesPorModo (que faz a outra metade, a dos botoes de
1615:     * acao) para haver UM lugar que responde "o usuario pode mexer nos filtros
1616:     * agora?" - os dois continuam andando juntos pelo funil, nunca em separado.
1617:     * PUBLIC porque eh chamado de FORA da classe pelo harness de teste
1618:     * (PEMSTATUS so verifica existencia, nao escopo - regra #3).
1619:     *--------------------------------------------------------------------------
1620:     PROCEDURE HabilitarCampos(par_lHabilitar)
1621:         THIS.obj_4c_OptProcessados.Buttons(1).Enabled = par_lHabilitar
1622:         THIS.obj_4c_OptProcessados.Buttons(2).Enabled = par_lHabilitar
1623:         THIS.txt_4c_DtIni.Enabled                     = par_lHabilitar
1624:         THIS.txt_4c_DtFin.Enabled                     = par_lHabilitar
1625:         THIS.txt_4c_CEmps.Enabled                     = par_lHabilitar
1626:         THIS.txt_4c_DEmps.Enabled                     = par_lHabilitar
1627:         THIS.cbo_4c_CmbCidades.Enabled                = par_lHabilitar
1628:         THIS.cmd_4c_BtnSelecionar.Enabled             = par_lHabilitar
1629:         THIS.txt_4c_Dirs.Enabled                      = par_lHabilitar
1630: 
1631:         *-- Reaplica as dependencias de When no FUNIL: este metodo acabou de
1632:         *-- mexer no Enabled de getDEmps/getDirs, e sem isto a descricao da
1633:         *-- empresa voltaria editavel com o codigo preenchido ao liberar os
1634:         *-- criterios (regra #40)
1635:         THIS.AjustarCamposDependentes()
1636:     ENDPROC
1637: 
1638:     *--------------------------------------------------------------------------
1639:     * CmdBtnFormClick - Click legado do cmdBtnForm: Limpar Sele" + CHR(231) +
1640:     * "ao (1), Gerar Arquivo (2 - checa selecionados e delega para
1641:     * Processamento), Sair do Processo (3).
1642:     *--------------------------------------------------------------------------
1643:     PROCEDURE CmdBtnFormClick()
1644:         *-- Guard do legado, que fica ANTES do Do Case e vale para o botao 2
1645:         *-- independentemente do Enabled dele: sem nenhuma linha marcada nao ha
1646:         *-- o que gerar
1647:         IF THIS.obj_4c_CmdBtnForm.Value = 2
1648:             IF !THIS.ValidarSelecaoParaGerar()
1649:                 RETURN
1650:             ENDIF
1651:         ENDIF
1652: 
1653:         *-- Despacha para o handler NOMEADO de cada botao do cmdBtnForm. Os
1654:         *-- tres existem como metodo proprio (e nao so como ramo deste DO CASE)
1655:         *-- porque sao a superficie de acao da tela: eh por eles que o harness
1656:         *-- de teste e qualquer chamada externa acionam Limpar / Gerar Arquivo
1657:         *-- / Sair sem ter de simular o Value do CommandGroup.
1658:         DO CASE
1659:             CASE THIS.obj_4c_CmdBtnForm.Value = 1 AND THIS.obj_4c_CmdBtnForm.Buttons(1).Enabled
1660:                 THIS.BtnCancelarClick()
1661: 
1662:             CASE THIS.obj_4c_CmdBtnForm.Value = 2 AND THIS.obj_4c_CmdBtnForm.Buttons(2).Enabled
1663:                 THIS.BtnProcessarClick()
1664: 
1665:             CASE THIS.obj_4c_CmdBtnForm.Value = 3
1666:                 THIS.BtnEncerrarClick()
1667:         ENDCASE
1668:     ENDPROC
1669: 
1670:     *--------------------------------------------------------------------------
1671:     * ContarSelecionados - Quantas linhas da grade estao marcadas para
1672:     * processamento. Transcreve a consulta do legado (cmdBtnForm.Click):
1673:     *
1674:     *     Select SelImp, Count(1) as Selecionados From csOperacoes
1675:     *      Where SelImp Group By SelImp Into Cursor csSeles
1676:     *
1677:     * Metodo proprio porque a contagem eh consultada em DOIS pontos (o guard do
1678:     * CommandGroup e o do botao de acao) - duplicar o SELECT faria as duas
1679:     * copias divergirem no primeiro ajuste de criterio.
1680:     *--------------------------------------------------------------------------
1681:     PROTECTED FUNCTION ContarSelecionados()
1682:         LOCAL loc_nSelecionados
1683: 
1684:         loc_nSelecionados = 0
1685: 
1686:         IF USED("cursor_4c_Operacoes")
1687:             IF USED("cursor_4c_Contagem")
1688:                 USE IN cursor_4c_Contagem
1689:             ENDIF
1690: 
1691:             SELECT SelImp, COUNT(1) AS Selecionados FROM cursor_4c_Operacoes ;
1692:                 WHERE SelImp GROUP BY SelImp INTO CURSOR cursor_4c_Contagem
1693: 
1694:             IF USED("cursor_4c_Contagem")
1695:                 loc_nSelecionados = TratarNulo(cursor_4c_Contagem.Selecionados, 0)
1696:                 USE IN cursor_4c_Contagem
1697:             ENDIF
1698:         ENDIF
1699: 
1700:         RETURN loc_nSelecionados
1701:     ENDPROC
1702: 
1703:     *--------------------------------------------------------------------------
1704:     * ValidarSelecaoParaGerar - Guard do "Gerar Arquivo": exige ao menos uma
1705:     * linha marcada na grade. Transcreve o bloco que abre o cmdBtnForm.Click
1706:     * legado:

*-- Linhas 1727 a 1866:
1727:         loc_lValido = (THIS.ContarSelecionados() >= 1)
1728: 
1729:         IF !loc_lValido
1730:             MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Encontrado!!!", ;
1731:                      "Sem Lan" + CHR(231) + "amentos")
1732:         ENDIF
1733: 
1734:         RETURN loc_lValido
1735:     ENDPROC
1736: 
1737:     *--------------------------------------------------------------------------
1738:     * BtnCancelarClick - Handler do btnLimpar legado ("Limpar Sele" + CHR(231)
1739:     * + CHR(227) + "o", cmdBtnForm botao 1). Eh o CANCELAR desta tela: desfaz a
1740:     * selecao em andamento (esvazia a grade) e devolve os criterios a edicao,
1741:     * sem gravar nada - nao ha Page2 de Dados nem modo de edicao a abandonar.
1742:     *
1743:     *     Case (This.Value = 1) And This.btnLimpar.Enabled
1744:     *          ThisForm.AjustaControles(.t.)
1745:     *          Zap In csOperacoes
1746:     *
1747:     * As duas linhas moram no funil LimparSelecao(), que tambem repinta a
1748:     * grade (regra #21a) - Processamento() reusa o mesmo funil no fim.
1749:     *--------------------------------------------------------------------------
1750:     PROCEDURE BtnCancelarClick()
1751:         THIS.LimparSelecao()
1752:     ENDPROC
1753: 
1754:     *--------------------------------------------------------------------------
1755:     * BtnProcessarClick - Handler do btnCopiar legado ("Gerar Arquivo",
1756:     * cmdBtnForm botao 2), a ACAO da tela:
1757:     *
1758:     *     Case (This.Value = 2) And This.btnCopiar.Enabled
1759:     *          ThisForm.Processamento()
1760:     *
1761:     * Repete o guard de "nenhuma linha marcada" para ser auto-suficiente:
1762:     * chamado direto (harness de teste, ou qualquer caminho que nao passe pelo
1763:     * CommandGroup), nao pode gerar arquivo vazio nem gravar controle em
1764:     * SigPcOoL sem nota selecionada.
1765:     *
1766:     * Reaplica FormParaBO() antes de processar porque o municipio escolhido eh
1767:     * o que decide a prefeitura destino (DO CASE de Processamento): os
1768:     * criterios estao travados desde o Selecionar, entao reler eh idempotente,
1769:     * mas garante que o BO responda pela TELA e nao por um lote anterior.
1770:     *--------------------------------------------------------------------------
1771:     PROCEDURE BtnProcessarClick()
1772:         IF !THIS.ValidarSelecaoParaGerar()
1773:             RETURN
1774:         ENDIF
1775: 
1776:         THIS.FormParaBO()
1777:         THIS.Processamento()
1778:     ENDPROC
1779: 
1780:     *--------------------------------------------------------------------------
1781:     * BtnEncerrarClick - Handler do btnSair legado ("Sair do Processo",
1782:     * cmdBtnForm botao 3), cujo Click no SCX eh uma linha so:
1783:     *
1784:     *     ThisForm.Release
1785:     *
1786:     * Sem confirmacao e sem gravar nada: o legado nao pergunta, e acrescentar
1787:     * um "deseja sair?" seria inventar comportamento (PILAR 1). Os cursores
1788:     * morrem junto com a sessao privada (DataSession = 2).
1789:     *--------------------------------------------------------------------------
1790:     PROCEDURE BtnEncerrarClick()
1791:         THIS.Release()
1792:     ENDPROC
1793: 
1794:     *--------------------------------------------------------------------------
1795:     * Processamento - PROCEDURE processamento do legado, transcrito na mesma
1796:     * ordem:
1797:     *
1798:     *     If llOks
1799:     *         If (ThisForm.poDataMgr.Commit() < 1)
1800:     *             =MessageBox([Favor Reinicializar o Processo!!!], ...)
1801:     *             llOks = .f.
1802:     *         EndIf
1803:     *         ThisForm.AjustaControles(.t.)
1804:     *         Zap In csOperacoes
1805:     *         ThisForm.btnSelecionar.Click(.t.)
1806:     *     EndIf
1807:     *     If Not llOks
1808:     *         ThisForm.poDataMgr.RollBack()
1809:     *     EndIf
1810:     *
1811:     * O par Commit/RollBack NAO eh detalhe de infra - eh um passo com caminho
1812:     * de falha proprio, e nesta instalacao a conexao nasce com
1813:     * SQLGETPROP(h, "Transactions") = 2 (transacao MANUAL). Sem o SQLCOMMIT,
1814:     * as linhas de controle que BuscarNotasPendentes grava em SigPcOoL ficam
1815:     * presas na transacao aberta e SOMEM, sem erro nenhum na tela - as notas
1816:     * voltariam a aparecer como "nao processadas" no lote seguinte, apesar de
1817:     * o arquivo TXT ja ter sido entregue a prefeitura. O guard loc_lManual
1818:     * deixa o par inerte se a conexao estiver em auto-commit, e vai em IF
1819:     * ANINHADO porque VFP9 nao faz curto-circuito em AND.
1820:     *
1821:     * O "btnSelecionar.Click(.t.)" final do legado NAO eh reproduzido porque
1822:     * eh no-op: no dump, btnSelecionar tem APENAS "PROCEDURE Valid"
1823:     * (ThisForm.Selecionar()) e nenhum Click, entao a chamada cai no Click da
1824:     * classe base commandbutton, que nao tem codigo.
1825:     *--------------------------------------------------------------------------
1826:     PROCEDURE Processamento()
1827:         LOCAL loc_cCidade, loc_lSucesso, loc_lManual
1828: 
1829:         *-- Municipio pela property do BO, que FormParaBO acabou de carregar a
1830:         *-- partir do combo - o legado le "lcCid = ThisForm.cmbCidades.Value"
1831:         *-- aqui mesmo, mas ter DOIS pontos lendo a tela foi o que deixou
1832:         *-- this_cCidade declarada e nunca preenchida
1833:         loc_cCidade  = ""
1834:         loc_lSucesso = .F.
1835:         loc_lManual  = .F.
1836: 
1837:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1838:             MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + ;
1839:                     "vel.", "Erro ao gerar o arquivo")
1840:             RETURN
1841:         ENDIF
1842: 
1843:         loc_cCidade = ALLTRIM(THIS.this_oBusinessObject.this_cCidade)
1844: 
1845:         IF TYPE("gnConnHandle") = "N"
1846:             loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
1847:         ENDIF
1848: 
1849:         DO CASE
1850:             CASE loc_cCidade == "RJ - Rio de Janeiro"
1851:                 loc_lSucesso = THIS.this_oBusinessObject.GerarArquivoRJ()
1852: 
1853:             CASE loc_cCidade == "SP - S" + CHR(227) + "o Paulo"
1854:                 loc_lSucesso = THIS.this_oBusinessObject.GerarArquivoSP()
1855:         ENDCASE
1856: 
1857:         IF loc_lSucesso
1858:             *-- "If (poDataMgr.Commit() < 1)" do legado: efetiva os INSERT em
1859:             *-- SigPcOoL feitos durante a selecao
1860:             IF loc_lManual
1861:                 IF SQLCOMMIT(gnConnHandle) < 1
1862:                     MsgErro("Favor Reinicializar o Processo!!!", ;
1863:                             "Falha na Conex" + CHR(227) + "o (Commit)")
1864:                     loc_lSucesso = .F.
1865:                 ENDIF
1866:             ENDIF

*-- Linhas 1881 a 2071:
1881:     * FormParaBO - Transfere os CRITERIOS da tela para as properties do BO.
1882:     *
1883:     * Nao eh convencao importada de form CRUD: o bloco existe no legado, so
1884:     * sem esse nome. O "PROCEDURE selecionar" abre lendo os sete controles
1885:     * para variaveis locais, com normalizacao propria -
1886:     *
1887:     *     llNPr = (ThisForm.optProcessados.Value = 1)
1888:     *     lcEmp = Padr(ThisForm.getCEmps.Value, 3)
1889:     *     ldDtI = ThisForm.getDtIni.Value
1890:     *     ldDtF = ThisForm.getDtFin.Value
1891:     *     lcDir = ThisForm.getDirs.Value
1892:     *
1893:     * - e o "PROCEDURE processamento" faz o mesmo com o municipio
1894:     * (lcCid = ThisForm.cmbCidades.Value). Centralizar aqui da um ponto UNICO
1895:     * de leitura: antes, CarregarLista e Processamento liam a tela cada um por
1896:     * sua conta e this_nProcessados / this_cCidade / this_cDescEmps ficavam
1897:     * declaradas no BO e nunca preenchidas.
1898:     *
1899:     * Os TextBox sao a FONTE UNICA - eh o que o usuario acabou de digitar,
1900:     * nunca uma property guardada de um lote anterior.
1901:     *
1902:     * Normalizacoes transcritas do legado, NAO inventadas:
1903:     *   - PADR(...,3) no codigo da empresa: SigCdEmp.Cemps eh char(3) e o
1904:     *     legado compara com a coluna padded (regra #42 - a largura faz parte
1905:     *     do valor);
1906:     *   - ConverterParaData nas duas datas: o TextBox entrega DATE e as
1907:     *     colunas de origem sao datetime; TTOD() aqui estouraria erro 11 em
1908:     *     RUNTIME (regra #16);
1909:     *   - ALLTRIM no municipio: Processamento() casa o texto por igualdade
1910:     *     exata, igual ao "Alltrim(lcCid) = [RJ - Rio de Janeiro]" do legado.
1911:     *
1912:     * PROTECTED porque FormBase ja declara o hook como PROTECTED e VFP9 nao
1913:     * permite ALARGAR o escopo de metodo herdado.
1914:     *--------------------------------------------------------------------------
1915:     PROTECTED PROCEDURE FormParaBO()
1916:         LOCAL loc_lSucesso
1917:         loc_lSucesso = .F.
1918: 
1919:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1920:             WITH THIS.this_oBusinessObject
1921:                 .this_nProcessados = THIS.obj_4c_OptProcessados.Value
1922:                 .this_cEmps        = PADR(ALLTRIM(THIS.txt_4c_CEmps.Value), 3)
1923:                 .this_cDescEmps    = ALLTRIM(THIS.txt_4c_DEmps.Value)
1924:                 .this_dDtIni       = ConverterParaData(THIS.txt_4c_DtIni.Value)
1925:                 .this_dDtFin       = ConverterParaData(THIS.txt_4c_DtFin.Value)
1926:                 .this_cCidade      = ALLTRIM(THIS.cbo_4c_CmbCidades.Value)
1927:                 .this_cDiretorio   = ALLTRIM(THIS.txt_4c_Dirs.Value)
1928:             ENDWITH
1929: 
1930:             loc_lSucesso = .T.
1931:         ENDIF
1932: 
1933:         RETURN loc_lSucesso
1934:     ENDPROC
1935: 
1936:     *--------------------------------------------------------------------------
1937:     * BOParaForm - Caminho inverso: pinta na tela os criterios guardados nas
1938:     * properties do BO. Equivale ao bloco de atribuicoes do Init legado
1939:     * (.getDtIni.Value = Date() etc.), com a diferenca de que os valores vem do
1940:     * BO em vez de literais espalhados - e por isso serve tambem de ponto de
1941:     * RECARGA, que o legado nao tem.
1942:     *
1943:     * Guardas:
1944:     *   - optProcessados eh 1-based (1 = Nao Processadas, 2 = Ja Processadas) e
1945:     *     NAO booleano: valor fora de 1..2 cairia em "nenhum botao marcado", de
1946:     *     onde o usuario nao consegue sair sem clicar. Fora da faixa, volta ao
1947:     *     default 1 do legado;
1948:     *   - municipio em branco NAO sobrescreve o combo: o ComboBox eh Style = 2
1949:     *     (somente selecao) e atribuir "" o deixaria sem item escolhido, com o
1950:     *     DO CASE de Processamento() nao casando com nenhuma prefeitura;
1951:     *   - ReadOnly nao atrapalha: txt_4c_Dirs eh ReadOnly por desenho (When
1952:     *     = .f. no legado) e ReadOnly so bloqueia DIGITACAO, nao atribuicao por
1953:     *     codigo.
1954:     *
1955:     * Fecha reaplicando AjustarCamposDependentes() porque acabou de mexer no
1956:     * codigo da empresa, que comanda o ReadOnly da descricao (regra #40).
1957:     *--------------------------------------------------------------------------
1958:     PROTECTED PROCEDURE BOParaForm()
1959:         LOCAL loc_lSucesso, loc_nProcessados, loc_cCidade
1960:         loc_lSucesso = .F.
1961: 
1962:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1963:             WITH THIS.this_oBusinessObject
1964:                 loc_nProcessados = IIF(BETWEEN(.this_nProcessados, 1, 2), .this_nProcessados, 1)
1965:                 loc_cCidade      = ALLTRIM(.this_cCidade)
1966: 
1967:                 THIS.obj_4c_OptProcessados.Value = loc_nProcessados
1968:                 THIS.txt_4c_CEmps.Value          = ALLTRIM(.this_cEmps)
1969:                 THIS.txt_4c_DEmps.Value          = ALLTRIM(.this_cDescEmps)
1970:                 THIS.txt_4c_DtIni.Value          = ConverterParaData(.this_dDtIni)
1971:                 THIS.txt_4c_DtFin.Value          = ConverterParaData(.this_dDtFin)
1972:                 THIS.txt_4c_Dirs.Value           = ALLTRIM(.this_cDiretorio)
1973:             ENDWITH
1974: 
1975:             IF !EMPTY(loc_cCidade)
1976:                 THIS.cbo_4c_CmbCidades.Value = loc_cCidade
1977:             ENDIF
1978: 
1979:             THIS.AjustarCamposDependentes()
1980:             loc_lSucesso = .T.
1981:         ENDIF
1982: 
1983:         RETURN loc_lSucesso
1984:     ENDPROC
1985: 
1986:     *--------------------------------------------------------------------------
1987:     * LimparCampos - Devolve os criterios aos valores com que o legado abre a
1988:     * tela, no BO (fonte unica) e depois na tela, via BOParaForm():
1989:     *
1990:     *     .getDtIni.Value   = Date()
1991:     *     .getDtFin.Value   = Date()
1992:     *     .cmbCidades.Value = [RJ - Rio de Janeiro]
1993:     *     .getDirs.Value    = [C:\]
1994:     *
1995:     * Empresa (codigo e descricao) nasce em branco - o legado nao a preenche no
1996:     * Init - e optProcessados fica em 1 ("Nao Processadas"), o Value que o SCX
1997:     * declara no controle.
1998:     *
1999:     * Chamado SO no InicializarForm. NAO entra em LimparSelecao(): o "Limpar"
2000:     * do legado (btnLimpar) faz apenas "Zap In csOperacoes" + AjustaControles
2001:     * (.t.) - esvazia a GRADE e reabre os criterios, mantendo o que o usuario
2002:     * tinha digitado neles. Resetar os filtros ali seria inventar
2003:     * comportamento que o legado nao tem e obrigaria a redigitar o periodo e a
2004:     * empresa a cada lote.
2005:     *
2006:     * PROTECTED: FormBase ja declara o hook como PROTECTED (escopo herdado nao
2007:     * se alarga em VFP9).
2008:     *--------------------------------------------------------------------------
2009:     PROTECTED PROCEDURE LimparCampos()
2010:         LOCAL loc_lSucesso
2011:         loc_lSucesso = .F.
2012: 
2013:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2014:             WITH THIS.this_oBusinessObject
2015:                 .this_nProcessados = 1
2016:                 .this_cEmps        = ""
2017:                 .this_cDescEmps    = ""
2018:                 .this_dDtIni       = DATE()
2019:                 .this_dDtFin       = DATE()
2020:                 .this_cCidade      = "RJ - Rio de Janeiro"
2021:                 .this_cDiretorio   = "C:\"
2022:             ENDWITH
2023: 
2024:             loc_lSucesso = THIS.BOParaForm()
2025:         ENDIF
2026: 
2027:         RETURN loc_lSucesso
2028:     ENDPROC
2029: 
2030:     *--------------------------------------------------------------------------
2031:     * TornarControlesVisiveis - Torna visiveis os controles criados via
2032:     * AddObject (nascem Visible=.F.), recursando em Pages de PageFrame e em
2033:     * containers filhos.
2034:     *--------------------------------------------------------------------------
2035:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2036:         LOCAL loc_i, loc_p, loc_oControl
2037: 
2038:         FOR loc_i = 1 TO par_oContainer.ControlCount
2039:             loc_oControl = par_oContainer.Controls(loc_i)
2040: 
2041:             IF VARTYPE(loc_oControl) = "O"
2042:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2043:                     loc_oControl.Visible = .T.
2044:                 ENDIF
2045: 
2046:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
2047:                     FOR loc_p = 1 TO loc_oControl.PageCount
2048:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
2049:                     ENDFOR
2050:                 ENDIF
2051: 
2052:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5)
2053:                     IF loc_oControl.ControlCount > 0
2054:                         THIS.TornarControlesVisiveis(loc_oControl)
2055:                     ENDIF
2056:                 ENDIF
2057:             ENDIF
2058:         ENDFOR
2059:     ENDPROC
2060: 
2061:     *--------------------------------------------------------------------------
2062:     * Destroy - Encerramento padrao (restauracao de menu herdada de FormBase).
2063:     * Sem fechamento explicito de cursor: o form tem DataSession = 2 (sessao
2064:     * privada), entao os cursores criados nas proximas fases
2065:     * (cursor_4c_Operacoes e afins) morrem junto com a sessao.
2066:     *--------------------------------------------------------------------------
2067:     PROCEDURE Destroy()
2068:         DODEFAULT()
2069:     ENDPROC
2070: 
2071: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRNSEBO.prg):
*====================================================================
* SIGPRNSEBO.prg
*
* Business Object para Integracao de NFS-e Municipal (SIGPRNSE)
* Form OPERACIONAL - selecao de notas de servico ainda nao enviadas
* e geracao de arquivo TXT para as prefeituras do Rio de Janeiro e
* de Sao Paulo
* Tabela principal: SigMvNfi (cidchaves PK, empdopnums char(29))
* Tabelas relacionadas: SigMvCab, SigCdCli, SigCdSer, SigCdEmp,
*                        SigCdMun, SigCdUfs, SigPcOoL
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRNSEBO AS BusinessBase

    *-- Propriedades de filtro (controles do form)
    this_nProcessados = 0     && optProcessados.Value - 1=Nao Processadas / 2=Ja Processadas
    this_cEmps        = ""    && getCEmps.Value - codigo da empresa para filtro (char 3)
    this_cDescEmps    = ""    && getDEmps.Value - razao social da empresa (preenchido via fAcessoEmpresa)
    this_dDtIni       = {}    && getDtIni.Value - data inicial do periodo selecionado
    this_dDtFin       = {}    && getDtFin.Value - data final do periodo selecionado
    this_cCidade      = ""    && cmbCidades.Value - "RJ - Rio de Janeiro" ou "SP - Sao Paulo"
    this_cDiretorio   = ""    && getDirs.Value - pasta de gravacao do arquivo gerado

    *-- Dados da empresa, carregados em BuscarNotasPendentes a partir de
    *-- SigCdEmp (Select TpEmps, Cgcs, IMs, Empofs, CodOpers, Dirs)
    this_nTpEmps    = 0       && SigCdEmp.TpEmps - 1=CPF / 2=CNPJ da empresa
    this_cCgcs      = ""      && SigCdEmp.Cgcs - CPF/CNPJ da empresa (sem mascara)
    this_cIms       = ""      && SigCdEmp.IMs - Inscricao Municipal da empresa
    this_nEmpofs    = 0       && SigCdEmp.Empofs - Regime Especial de Tributacao
    this_cCodOpers  = ""      && SigCdEmp.CodOpers - Codigo do Servico Federal

    *-- Controle de resultado do processamento / geracao de arquivo
    this_cArquivoGerado    = ""    && caminho completo do arquivo TXT gerado
    this_nTotalLinhas20    = 0     && contador de linhas Tipo 20 (RJ - notas de saida)
    this_nTotalLinhas40    = 0     && contador de linhas Tipo 40 (SP - notas convencionais recebidas)
    this_cMensagemRetorno  = ""    && ultima mensagem de erro/retorno das operacoes SQL

    *-- Dados da operacao (nota fiscal candidata) carregados a partir da linha
    *-- corrente do cursor csOperacoes (populado pelo Form.Selecionar, a partir
    *-- de SigMvNfi + SigMvCab + SigCdCli + SigCdSer) - usados para montar o
    *-- registro de controle gravado em SigPcOoL via Inserir()/Atualizar()
    this_lSelImp     = .F.    && csOperacoes.SelImp - .T. = nota marcada para processamento
    this_cEmpsOp     = ""     && csOperacoes.Emps   - empresa da nota (SigMvNfi.emps)
    this_cDopesOp    = ""     && csOperacoes.Dopes  - documento da operacao (SigMvNfi.dopes)
    this_nNumesOp    = 0      && csOperacoes.Numes  - numero da operacao (SigMvNfi.numes)
    this_dDatasOp    = {}     && csOperacoes.Datas  - data de emissao da nota
    this_nValosOp    = 0      && csOperacoes.Valos  - valor total da nota
    this_cNotasOp    = ""     && csOperacoes.Notas  - numero da NF impressa
    this_cUsuarsOp   = ""     && csOperacoes.Usuars - usuario que gerou a operacao na origem
    this_cContaOsOp  = ""     && csOperacoes.ContaOs - conta de origem da operacao
    this_cContaDsOp  = ""     && csOperacoes.ContaDs - conta de destino da operacao
    this_cOpersOp    = ""     && csOperacoes.Opers  - tipo da operacao ('S'=Saida / 'E'=Entrada)
    this_cErrosOp    = ""     && csOperacoes.Erros  - mensagens de validacao acumuladas

    *-- Registro de controle gravado em SigPcOoL - tabela em que este BO
    *-- efetivamente grava (SigMvNfi so eh LIDA, nunca alterada por este form)
    this_cCidChaves        = ""    && SigPcOoL.cidchaves - PK, gerada via fUniqueIds() (regra #22)
    this_cEmpDopNumsOp     = ""    && SigPcOoL.empdopnums - Emps(3) + Dopes(20) + Str(Numes,6), POSICIONAL (regra #42)
    this_lReprocessamento  = .F.   && .T. quando optProcessados = 2 (Ja Processadas) - grava marca "LANCAMENTO REFEITO"

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            *-- SigPcOoL eh a tabela de controle onde Inserir()/Atualizar()
            *-- efetivamente gravam (marca de nota ja enviada a integracao);
            *-- SigMvNfi (comentario de cabecalho do BO) eh so a origem lida.
            THIS.this_cTabela     = "SigPcOoL"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGPRNSEBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a linha corrente do cursor csOperacoes
    * (populado pelo Form ao selecionar as notas ainda nao enviadas ou ja processadas)
    * para as propriedades this_*Op, usadas em Inserir()/Atualizar().
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_lSelImp    = SelImp
        THIS.this_cEmpsOp    = TratarNulo(Emps, "")
        THIS.this_cDopesOp   = TratarNulo(Dopes, "")
        THIS.this_nNumesOp   = TratarNulo(Numes, 0)
        THIS.this_dDatasOp   = TratarNulo(Datas, {})
        THIS.this_nValosOp   = TratarNulo(Valos, 0)
        THIS.this_cNotasOp   = TratarNulo(Notas, "")
        THIS.this_cUsuarsOp  = TratarNulo(Usuars, "")
        THIS.this_cContaOsOp = TratarNulo(ContaOs, "")
        THIS.this_cContaDsOp = TratarNulo(ContaDs, "")
        THIS.this_cOpersOp   = TratarNulo(Opers, "")
        THIS.this_cErrosOp   = TratarNulo(Erros, "")

        *-- chave concatenada POSICIONAL (regra #42) - NUNCA ALLTRIM nas partes
        THIS.this_cEmpDopNumsOp = PADR(THIS.this_cEmpsOp, 3) + PADR(THIS.this_cDopesOp, 20) + STR(THIS.this_nNumesOp, 6)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Grava em SigPcOoL o registro de controle que marca a nota
    * (csOperacoes/SigMvNfi carregada em CarregarDoCursor) como enviada para a
    * integracao SIGPRNSE. Espelha o INSERT do legado (PROCEDURE selecionar):
    *   Insert Into SigPcOoL (Tipos, Emps, Dopes, Numes, Empds, Dopeds, Numeds,
    *     Datas, Usuars, Produtos, Processos, cIdChaves, EmpDopNums, EdnDests)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cCidChaves    = fUniqueIds()
            THIS.this_cEmpDopNumsOp = PADR(THIS.this_cEmpsOp, 3) + PADR(THIS.this_cDopesOp, 20) + STR(THIS.this_nNumesOp, 6)

            loc_cSQL = "INSERT INTO SigPcOoL (Tipos, Emps, Dopes, Numes, Empds, Dopeds, Numeds, " + ;
                       "Datas, Usuars, Produtos, Processos, cIdChaves, EmpDopNums, EdnDests) VALUES (" + ;
                       EscaparSQL("SIGPRNSE") + ", " + ;
                       EscaparSQL(PADR(THIS.this_cEmpsOp, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDopesOp, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumesOp, 0) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       "0, " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(PADR(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, ""), 10)) + ", " + ;
                       EscaparSQL(IIF(THIS.this_lReprocessamento, "LAN" + CHR(199) + "AMENTO REFEITO", "")) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNumsOp) + ", " + ;
                       EscaparSQL("") + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao gravar controle de integra" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gravar controle de integra" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o registro de controle em SigPcOoL identificado por
    * THIS.this_cCidChaves. O legado NUNCA atualiza SigPcOoL (cada selecao -
    * inclusive reprocessamento - grava um cIdChaves NOVO via fUniqueIds(),
    * regra #22); este metodo cobre o contrato padrao de
    * BusinessBase.Salvar()/EditarRegistro() para corrigir um registro ja
    * gravado, sem inventar regra de negocio que o legado nao tem.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cMensagemErro = "Registro de controle sem chave para atualizar"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cEmpDopNumsOp = PADR(THIS.this_cEmpsOp, 3) + PADR(THIS.this_cDopesOp, 20) + STR(THIS.this_nNumesOp, 6)

            loc_cSQL = "UPDATE SigPcOoL SET " + ;
                       "Emps = " + EscaparSQL(PADR(THIS.this_cEmpsOp, 3)) + ", " + ;
                       "Dopes = " + EscaparSQL(PADR(THIS.this_cDopesOp, 20)) + ", " + ;
                       "Numes = " + FormatarNumeroSQL(THIS.this_nNumesOp, 0) + ", " + ;
                       "Datas = GETDATE(), " + ;
                       "Usuars = " + EscaparSQL(PADR(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, ""), 10)) + ", " + ;
                       "EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNumsOp) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar controle de integra" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar controle de integra" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do registro de controle gravado em SigPcOoL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursoresAuxiliares - Cria os cursores locais que o Form precisa
    * ANTES de ligar o Grid (regra #41 - Column.ControlSource de cursor
    * inexistente derruba o Init):
    *   cursor_4c_Operacoes  - equivalente a csOperacoes do Load legado:
    *     grade de notas candidatas, com SelImp editavel pelo usuario.
    *   cursor_4c_Municipios - equivalente a LocalUfs do Init legado:
    *     Select Distinct a.Codigos, a.Descs, b.Estados From SigCdMun a,
    *     SigCdUfs b Where a.UFIBGEs = b.UFIBGEs - usado por GerarArquivoRJ
    *     para resolver Cidade/UF de Presta" + "cao do Servico.
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursoresAuxiliares()
        LOCAL loc_lSucesso, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Operacoes")
                CREATE CURSOR cursor_4c_Operacoes (SelImp L, Emps C(3), ;
                    Dopes C(20), Numes N(6, 0), Datas D, Valos N(12, 2), ;
                    Notas C(10), Usuars C(10), ContaOs C(10), ContaDs C(10), ;
                    Opers C(1), Erros M)
                *-- Os CINCO tags do Load legado, na MESMA ordem: em VFP9 o
                *-- ultimo INDEX ON passa a ser a ordem CONTROLADORA, entao
                *-- criar so o primeiro deixaria a grade exibindo por
                *-- Emps+Dopes+Numes em vez de por ContaDs (Destino), que eh
                *-- a ordem em que o legado apresenta as notas.
                INDEX ON Emps + Dopes + STR(Numes, 6)                TAG Operacao
                INDEX ON DTOS(Datas) + Emps + Dopes + STR(Numes, 6)  TAG Data
                INDEX ON Notas + Emps + Dopes + STR(Numes, 6)        TAG Nota
                INDEX ON ContaOs + Emps + Dopes + STR(Numes, 6)      TAG Origem
                INDEX ON ContaDs + Emps + Dopes + STR(Numes, 6)      TAG Destino
            ENDIF

            IF !USED("cursor_4c_Municipios") AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT DISTINCT a.Codigos, a.Descs, b.Estados " + ;
                    "FROM SigCdMun a, SigCdUfs b " + ;
                    "WHERE a.UFIBGEs = b.UFIBGEs", "cursor_4c_Municipios")
                IF loc_nResultado >= 0 AND USED("cursor_4c_Municipios")
                    SELECT cursor_4c_Municipios
                    INDEX ON Codigos TAG Codigos
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao criar cursores auxiliares")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNotasPendentes - Equivalente ao PROCEDURE selecionar do legado
    * (SIGPRNSE.SCX), a partir do ponto em que os filtros de tela JA foram
    * validados pelo Form (datas, empresa, diretorio, confirmacao de
    * reprocessamento). Carrega TpEmps/Cgcs/IMs/Empofs/CodOpers de SigCdEmp
    * (usados depois por GerarArquivoRJ/GerarArquivoSP), monta o universo de
    * notas candidatas (SigMvNfi + SigMvCab + SigCdCli + SigCdSer, excluindo
    * - ou so trazendo, se reprocessamento - as que ja tem controle gravado
    * em SigPcOoL para 'SIGPRNSE'), valida cada nota (mesmas checagens do
    * legado - preservadas LITERALMENTE, inclusive a reincidencia do campo
    * Ceps nas checagens de Endereco/Bairro/Cidade/UF, que e bug do legado e
    * nao desta migracao - regra #17) e grava o controle de selecao em
    * SigPcOoL via THIS.Inserir() (reaproveita o contrato ja usado pelo
    * Salvar do BO).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarNotasPendentes(par_cEmps, par_dDtIni, par_dDtFin, par_lNaoProcessadas, par_cDiretorio)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cSQL, loc_nResultado, loc_cErr, loc_oErro
        LOCAL loc_cSafety
        loc_lSucesso = .F.
        loc_cSafety  = SET("SAFETY")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        THIS.this_cEmps            = PADR(ALLTRIM(par_cEmps), 3)
        THIS.this_dDtIni           = par_dDtIni
        THIS.this_dDtFin           = par_dDtFin
        THIS.this_cDiretorio       = ALLTRIM(par_cDiretorio)
        THIS.this_lReprocessamento = !par_lNaoProcessadas

        loc_lProsseguir = .T.

        TRY
            THIS.CriarCursoresAuxiliares()

            *-- Dados da empresa (usados so por GerarArquivoRJ/GerarArquivoSP)
            loc_cSQL = "SELECT TpEmps, Cgcs, IMs, Empofs, CodOpers, Dirs " + ;
                       "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmps)

            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")
            IF loc_nResultado < 0 OR !USED("cursor_4c_Empresa") OR EOF("cursor_4c_Empresa")
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar os dados da empresa: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_Empresa
                THIS.this_nTpEmps   = TratarNulo(cursor_4c_Empresa.TpEmps, 0)
                THIS.this_cCgcs     = TratarNulo(cursor_4c_Empresa.Cgcs, "")
                THIS.this_cIms      = TratarNulo(cursor_4c_Empresa.IMs, "")
                THIS.this_nEmpofs   = TratarNulo(cursor_4c_Empresa.Empofs, 0)
                THIS.this_cCodOpers = TratarNulo(cursor_4c_Empresa.CodOpers, "")
                USE IN cursor_4c_Empresa

                *-- Universo de notas candidatas (regra #22/#42 - EmpDopNums eh
                *-- chave POSICIONAL, Emps(3)+Dopes(20)+Str(Numes,6))
                loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Operas, a.Nfis, a.Series, a.Emis, " + ;
                           "b.Obses, a.Cancelas, a.TotProds, a.VCofins, a.TpTribSers, a.PrestServs, " + ;
                           "a.CodBenefs, a.CodSrvFis, a.VDeducoes, a.VDscConds, a.VDscIConds, " + ;
                           "a.OutRetens, a.ISSRetidos, a.TipoNFs, a.VCsll, a.VInss, a.VIrf, a.VPis, " + ;
                           "a.VTotIss, b.Usuars, b.ContaOs, b.ContaDs, c.TpClis, c.Cpfs, c.InscMuns, " + ;
                           "c.Rgs, c.Razaos, c.RClis, c.Endes, c.Nums, c.Compls, c.Bairs, c.Cidas, " + ;
                           "c.Estas, c.Ceps, c.Tel1s, c.eMails, c.OptSimples " + ;
                           "FROM SigMvNfi a, SigMvCab b, SigCdCli c, SigCdSer d " + ;
                           "WHERE a.Emis BETWEEN " + FormatarDataSQL(THIS.this_dDtIni) + ;
                           " AND " + FormatarDataSQL(DATETIME(YEAR(THIS.this_dDtFin), MONTH(THIS.this_dDtFin), DAY(THIS.this_dDtFin), 23, 59, 59)) + ;
                           " AND a.Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                           " AND a.EmpDopNums = b.EmpDopNums" + ;
                           " AND b.ContaDs = c.IClis" + ;
                           " AND LEFT(a.Series, 3) = d.Cods" + ;
                           " AND d.TpServicos IN (1, 3)" + ;
                           " AND a.EmpDopNums " + IIF(par_lNaoProcessadas, "NOT ", "") + ;
                           "IN (SELECT o.EmpDopNums FROM SigPcOoL o WHERE o.Tipos = 'SIGPRNSE')"

                IF USED("cursor_4c_NotasOrigem")
                    USE IN cursor_4c_NotasOrigem
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NotasOrigem")
                IF loc_nResultado < 0 OR !USED("cursor_4c_NotasOrigem")
                    THIS.this_cMensagemErro = "Falha ao consultar as notas: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_NotasOrigem
                GO TOP
                IF EOF("cursor_4c_NotasOrigem")
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o Foram Encontrados Dados Com os Filtros Informados!!!"
                    MsgAviso(THIS.this_cMensagemErro, "Sele" + CHR(231) + CHR(227) + "o de Notas")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("cursor_4c_Operacoes")
                    THIS.CriarCursoresAuxiliares()
                ENDIF
                *-- SET SAFETY eh ESCOPADO POR DATA SESSION e este BO roda
                *-- DENTRO da sessao privada do FormSIGPRNSE (DataSession = 2),
                *-- que nasce com SAFETY = ON apesar do SET SAFETY OFF do
                *-- main.prg (medido no VFP9: sessao 1 = OFF, privada = ON).
                *-- Sem o guard, este ZAP abre o dialogo modal "Zap ... Are you
                *-- sure?" e a tela CONGELA ao clicar "Selecionar Notas", sem
                *-- erro e sem log. O restore tambem vai no CATCH do metodo,
                *-- para o SET nao vazar na sessao privada.
                SELECT cursor_4c_Operacoes
                loc_cSafety = SET("SAFETY")
                SET SAFETY OFF
                ZAP
                IF loc_cSafety = "ON"
                    SET SAFETY ON
                ENDIF

                SELECT cursor_4c_NotasOrigem
                SCAN WHILE loc_lProsseguir
                    loc_cErr = ""

                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Razaos)) AND EMPTY(ALLTRIM(cursor_4c_NotasOrigem.RClis))
                        loc_cErr = loc_cErr + "O Nome e a Raz" + CHR(227) + "o Social da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Series))
                        loc_cErr = loc_cErr + "A S" + CHR(233) + "rie da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Nfis))
                        loc_cErr = loc_cErr + "O N" + CHR(250) + "mero da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    *-- As 6 checagens abaixo repetem Ceps no legado (PROCEDURE
                    *-- selecionar, SIGPRNSE.SCX) para os rotulos de Endereco/
                    *-- Bairro/Cidade/UF - bug de copia-e-cola do legado,
                    *-- preservado por fidelidade (regra #17 - transcrever,
                    *-- nunca reescrever a regra de negocio).
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Ceps))
                        loc_cErr = loc_cErr + "O CEP da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Ceps))
                        loc_cErr = loc_cErr + "O Endere" + CHR(231) + "o da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Ceps))
                        loc_cErr = loc_cErr + "O Bairro da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Ceps))
                        loc_cErr = loc_cErr + "A Cidade da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Ceps))
                        loc_cErr = loc_cErr + "A UF da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(cursor_4c_NotasOrigem.Emis)
                        loc_cErr = loc_cErr + "A Data de Emiss" + CHR(227) + "o da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(STRTRAN(cursor_4c_NotasOrigem.CodSrvFis, ".", "")))
                        loc_cErr = loc_cErr + "O C" + CHR(243) + "digo do Servi" + CHR(231) + "o Municipal da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(cursor_4c_NotasOrigem.TotProds)
                        loc_cErr = loc_cErr + "O Valor dos Servi" + CHR(231) + "os da Nota Est" + CHR(225) + " Zerado;" + CHR(13)
                    ENDIF

                    INSERT INTO cursor_4c_Operacoes (SelImp, Emps, Dopes, Numes, Datas, Valos, ;
                            Notas, Usuars, ContaOs, ContaDs, Opers, Erros) VALUES ;
                            (EMPTY(loc_cErr), cursor_4c_NotasOrigem.Emps, cursor_4c_NotasOrigem.Dopes, ;
                            cursor_4c_NotasOrigem.Numes, ConverterParaData(cursor_4c_NotasOrigem.Emis), ;
                            cursor_4c_NotasOrigem.TotProds, cursor_4c_NotasOrigem.Nfis, ;
                            cursor_4c_NotasOrigem.Usuars, cursor_4c_NotasOrigem.ContaOs, ;
                            cursor_4c_NotasOrigem.ContaDs, cursor_4c_NotasOrigem.Operas, loc_cErr)

                    SELECT cursor_4c_Operacoes
                    GO BOTTOM
                    THIS.CarregarDoCursor("cursor_4c_Operacoes")
                    IF !THIS.Inserir()
                        loc_lProsseguir = .F.
                    ENDIF
                    SELECT cursor_4c_NotasOrigem
                ENDSCAN
            ENDIF

            loc_lSucesso = loc_lProsseguir
        CATCH TO loc_oErro
            *-- Restaura a SAFETY tambem na falha: se o erro estourou entre o
            *-- SET SAFETY OFF e o restore do ZAP, o SET ficaria vazado na
            *-- data session privada do form
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro ao selecionar notas")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoRJ - Transcricao literal de PROCEDURE prcrjriodejaneiro
    * (SIGPRNSE.SCX) - leiaute TXT da NFS-e da Prefeitura do Rio de Janeiro,
    * versao 3.1 (27/05/2014). Le cursor_4c_NotasOrigem (LocalNotas) e
    * cursor_4c_Operacoes (csOperacoes, apenas SelImp = .T.), separadas por
    * Operas = Saida ('S' -> registro Tipo 20) e Entrada ('E' -> registro
    * Tipo 40), fechando com o rodape Tipo 90.
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivoRJ()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cArq, loc_cDir, loc_nR20, loc_nR40, loc_nTsr, loc_nTdd, ;
              loc_nTdc, loc_nTdi, loc_cFim, loc_cTip, loc_cCpf, loc_cIms, loc_cDtI, loc_cDtF, ;
              loc_cStr, loc_cSer, loc_cNot, loc_cEmi, loc_cSts, loc_cTpT, loc_cCpW, loc_cImT, ;
              loc_cIeT, loc_cNmT, loc_cEdT, loc_cTeT, loc_cNeT, loc_cCeT, loc_cBaT, loc_cCdT, ;
              loc_cUfT, loc_cCcT, loc_cT1T, loc_cEmT, loc_cTts, loc_cCps, loc_cUps, loc_cRet, ;
              loc_cOSN, loc_cInC, loc_cCsF, loc_cCdB, loc_cCsM, loc_nAlq, loc_cAlq, loc_cVal, ;
              loc_cVde, loc_cVds, loc_cVdi, loc_cCof, loc_cCsl, loc_cIns, loc_cIrf, loc_cPis, ;
              loc_cOut, loc_cIss, loc_cRtd, loc_cObs, loc_cTpn, loc_cNdt, loc_oErro
        loc_lSucesso = .F.
        loc_lProsseguir = .T.

        TRY
            IF USED("cursor_4c_NfS")
                USE IN cursor_4c_NfS
            ENDIF
            SELECT a.* FROM cursor_4c_NotasOrigem a, cursor_4c_Operacoes b ;
                WHERE a.Operas = "S" AND ;
                      a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                      b.SelImp ;
                INTO CURSOR cursor_4c_NfS READWRITE

            IF USED("cursor_4c_NfE")
                USE IN cursor_4c_NfE
            ENDIF
            SELECT a.* FROM cursor_4c_NotasOrigem a, cursor_4c_Operacoes b ;
                WHERE a.Operas = "E" AND ;
                      a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                      b.SelImp ;
                INTO CURSOR cursor_4c_NfE READWRITE

            loc_nR20 = 0
            loc_nR40 = 0
            loc_nTsr = 0
            loc_nTdd = 0
            loc_nTdc = 0
            loc_nTdi = 0
            loc_cFim = CHR(13) + CHR(10)

            loc_cTip = IIF(THIS.this_nTpEmps = 1, "1", "2")
            loc_cCpf = PADL(CHRTRAN(THIS.this_cCgcs, ".-/ ", ""), 14, "0")
            loc_cIms = PADL(CHRTRAN(THIS.this_cIms, ".-/ ", ""), 15, "0")
            loc_cDtI = DTOS(THIS.this_dDtIni)
            loc_cDtF = DTOS(THIS.this_dDtFin)

            loc_cDir = ALLTRIM(THIS.this_cDiretorio)
            loc_cArq = loc_cDir + ALLTRIM(loc_cIms) + "_" + ;
                       LEFT(CHRTRAN(TTOC(DATETIME()), "/: ", "--_"), 16) + ".TXT"

            STRTOFILE("", loc_cArq, .F.)
            IF !FILE(loc_cArq)
                THIS.this_cMensagemErro = "O Arquivo " + CHR(34) + loc_cArq + CHR(34) + " N" + CHR(227) + "o Pode Ser Criado!!!"
                MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
                        "Verifique Suas Permiss" + CHR(245) + "es de Cria" + CHR(231) + CHR(227) + "o e Tente Novamente!!!", ;
                        "Erro Na Cria" + CHR(231) + CHR(227) + "o do Arquivo")
                loc_lProsseguir = .F.
            ENDIF

        IF loc_lProsseguir
            *-- 3.2. Registro Tipo 10 - Cabecalho
            loc_cStr = "10" + "003" + loc_cTip + loc_cCpf + loc_cIms + loc_cDtI + loc_cDtF + loc_cFim
            STRTOFILE(loc_cStr, loc_cArq, .T.)

            *-- Notas de Saida -> Registro Tipo 20
            SELECT cursor_4c_NfS
            SCAN
                loc_cSer = PADR(ALLTRIM(cursor_4c_NfS.Series), 5)
                loc_cNot = PADL(ALLTRIM(cursor_4c_NfS.Nfis), 15, "0")
                loc_cEmi = DTOS(cursor_4c_NfS.Emis)
                loc_cSts = IIF(cursor_4c_NfS.Cancelas, "2", "1")

                loc_cTpT = PADL(cursor_4c_NfS.TpClis, 1, "0")
                loc_cTpT = IIF(loc_cTpT == "0", "3", loc_cTpT)
                loc_cCpW = PADL(CHRTRAN(cursor_4c_NfS.Cpfs, ".-/ ", ""), 14, "0")
                IF loc_cCpW == "00000000000000"
                    loc_cTpT = "3"
                ENDIF
                loc_cImT = PADL(CHRTRAN(cursor_4c_NfS.InscMuns, ".-/ ", ""), 15, "0")
                loc_cIeT = PADL(CHRTRAN(cursor_4c_NfS.Rgs, ".-/ ", ""), 15, "0")
                loc_cNmT = ALLTRIM(cursor_4c_NfS.Razaos)
                loc_cNmT = PADR(IIF(EMPTY(loc_cNmT), ALLTRIM(cursor_4c_NfS.RClis), loc_cNmT), 115)
                loc_cEdT = PADR(ALLTRIM(cursor_4c_NfS.Endes), 125)
                loc_cTeT = ALLTRIM(LEFT(loc_cEdT, AT(" ", loc_cEdT)))
                loc_cTeT = PADR(IIF(EMPTY(loc_cTeT), "RUA", loc_cTeT), 3)
                loc_cNeT = PADR(ALLTRIM(cursor_4c_NfS.Nums), 10)
                loc_cCeT = PADR(ALLTRIM(cursor_4c_NfS.Compls), 60)
                loc_cBaT = PADR(ALLTRIM(cursor_4c_NfS.Bairs), 72)
                loc_cCdT = PADR(ALLTRIM(cursor_4c_NfS.Cidas), 50)
                loc_cUfT = PADR(ALLTRIM(cursor_4c_NfS.Estas), 2)
                loc_cCcT = PADL(CHRTRAN(cursor_4c_NfS.Ceps, "-", ""), 8, "0")
                loc_cT1T = PADR(CHRTRAN(cursor_4c_NfS.Tel1s, ".-", ""), 11)
                loc_cEmT = PADR(ALLTRIM(cursor_4c_NfS.eMails), 80)

                loc_cTts = PADL(cursor_4c_NfS.TpTribSers, 2, "0")
                loc_cCps = loc_cCdT
                loc_cUps = loc_cUfT
                IF SEEK(cursor_4c_NfS.PrestServs, "cursor_4c_Municipios", "Codigos")
                    loc_cCps = PADR(UPPER(ALLTRIM(cursor_4c_Municipios.Descs)), 50)
                    loc_cUps = PADR(UPPER(ALLTRIM(cursor_4c_Municipios.Estados)), 2)
                ENDIF

                loc_cRet = PADL(THIS.this_nEmpofs, 2, "0")
                loc_cOSN = IIF(cursor_4c_NfS.OptSimples == "S", "1", "0")
                loc_cInC = IIF(INLIST(loc_cTts, "03", "04"), "1", "0")
                loc_cCsF = PADR(THIS.this_cCodOpers, 4)
                loc_cCdB = PADL(ALLTRIM(cursor_4c_NfS.CodBenefs), 3, "0")
                loc_cCsM = PADR(STRTRAN(cursor_4c_NfS.CodSrvFis, ".", ""), 6)

                loc_nAlq = (cursor_4c_NfS.VTotIss / cursor_4c_NfS.TotProds) * 100
                loc_cAlq = PADL(CHRTRAN(STR(loc_nAlq, 9, 2), ". ", ""), 5, "0")
                loc_cVal = PADL(CHRTRAN(STR(cursor_4c_NfS.TotProds, 20, 2), ". ", ""), 15, "0")
                loc_cVde = PADL(CHRTRAN(STR(cursor_4c_NfS.VDeducoes, 20, 2), ". ", ""), 15, "0")
                loc_cVds = PADL(CHRTRAN(STR(cursor_4c_NfS.VDscConds, 20, 2), ". ", ""), 15, "0")
                loc_cVdi = PADL(CHRTRAN(STR(cursor_4c_NfS.VDscIConds, 20, 2), ". ", ""), 15, "0")
                loc_cCof = PADL(CHRTRAN(STR(cursor_4c_NfS.VCofins, 20, 2), ". ", ""), 15, "0")
                loc_cCsl = PADL(CHRTRAN(STR(cursor_4c_NfS.VCsll, 20, 2), ". ", ""), 15, "0")
                loc_cIns = PADL(CHRTRAN(STR(cursor_4c_NfS.VInss, 20, 2), ". ", ""), 15, "0")
                loc_cIrf = PADL(CHRTRAN(STR(cursor_4c_NfS.VIrf, 20, 2), ". ", ""), 15, "0")
                loc_cPis = PADL(CHRTRAN(STR(cursor_4c_NfS.VPis, 20, 2), ". ", ""), 15, "0")
                loc_cOut = PADL(CHRTRAN(STR(cursor_4c_NfS.OutRetens, 20, 2), ". ", ""), 15, "0")
                loc_cIss = PADL(CHRTRAN(STR(cursor_4c_NfS.VTotIss, 20, 2), ". ", ""), 15, "0")
                loc_cRtd = IIF(cursor_4c_NfS.ISSRetidos = 1, "1", "0")

                loc_cObs = ALLTRIM(STRTRAN(STRTRAN(TratarNulo(cursor_4c_NfS.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_cObs = IIF(EMPTY(loc_cObs), "Servi" + CHR(231) + "os Prestados", loc_cObs)

                loc_nTsr = loc_nTsr + cursor_4c_NfS.TotProds
                loc_nTdd = loc_nTdd + cursor_4c_NfS.VDeducoes
                loc_nTdc = loc_nTdc + cursor_4c_NfS.VDscConds
                loc_nTdi = loc_nTdi + cursor_4c_NfS.VDscIConds

                *-- 3.3. Registro Tipo 20 - Detalhe
                loc_cStr = "20" + "0" + loc_cSer + loc_cNot + loc_cEmi + loc_cSts + loc_cTpT + ;
                           loc_cCpW + loc_cImT + loc_cIeT + loc_cNmT + loc_cTeT + loc_cEdT + ;
                           loc_cNeT + loc_cCeT + loc_cBaT + loc_cCdT + loc_cUfT + loc_cCcT + ;
                           loc_cT1T + loc_cEmT + loc_cTts + loc_cCps + loc_cUps + loc_cRet + ;
                           loc_cOSN + loc_cInC + loc_cCsF + SPACE(11) + loc_cCdB + loc_cCsM + ;
                           loc_cAlq + loc_cVal + loc_cVde + loc_cVds + loc_cVdi + loc_cCof + ;
                           loc_cCsl + loc_cIns + loc_cIrf + loc_cPis + loc_cOut + loc_cIss + ;
                           loc_cRtd + loc_cEmi + SPACE(15) + SPACE(15) + SPACE(5) + ;
                           PADL("", 15, "0") + SPACE(30) + loc_cObs + loc_cFim

                loc_nR20 = loc_nR20 + 1
                STRTOFILE(loc_cStr, loc_cArq, .T.)
            ENDSCAN

            *-- Notas de Entrada -> Registro Tipo 40
            SELECT cursor_4c_NfE
            SCAN
                loc_cTpn = PADL(ALLTRIM(cursor_4c_NfE.TipoNFs), 2, "0")

                loc_cSer = PADR(ALLTRIM(cursor_4c_NfE.Series), 5)
                loc_cNot = PADL(ALLTRIM(cursor_4c_NfE.Nfis), 15, "0")
                loc_cEmi = DTOS(cursor_4c_NfE.Emis)
                loc_cSts = IIF(cursor_4c_NfE.Cancelas, "2", "1")

                loc_cTpT = PADL(cursor_4c_NfE.TpClis, 1, "0")
                loc_cTpT = IIF(loc_cTpT == "0", "3", loc_cTpT)
                loc_cCpW = PADL(CHRTRAN(cursor_4c_NfE.Cpfs, ".-/ ", ""), 14, "0")
                IF loc_cCpW == "00000000000000"
                    loc_cTpT = "3"
                ENDIF
                loc_cImT = PADL(CHRTRAN(cursor_4c_NfE.InscMuns, ".-/ ", ""), 15, "0")
                loc_cIeT = PADL(CHRTRAN(cursor_4c_NfE.Rgs, ".-/ ", ""), 15, "0")
                loc_cNmT = ALLTRIM(cursor_4c_NfE.Razaos)
                loc_cNmT = PADR(IIF(EMPTY(loc_cNmT), ALLTRIM(cursor_4c_NfE.RClis), loc_cNmT), 115)
                loc_cEdT = PADR(ALLTRIM(cursor_4c_NfE.Endes), 125)
                loc_cTeT = ALLTRIM(LEFT(loc_cEdT, AT(" ", loc_cEdT)))
                loc_cTeT = PADR(IIF(EMPTY(loc_cTeT), "RUA", loc_cTeT), 3)
                loc_cNeT = PADR(ALLTRIM(cursor_4c_NfE.Nums), 10)
                loc_cCeT = PADR(ALLTRIM(cursor_4c_NfE.Compls), 60)
                loc_cBaT = PADR(ALLTRIM(cursor_4c_NfE.Bairs), 72)
                loc_cCdT = PADR(ALLTRIM(cursor_4c_NfE.Cidas), 50)
                loc_cUfT = PADR(ALLTRIM(cursor_4c_NfE.Estas), 2)
                loc_cCcT = PADL(CHRTRAN(cursor_4c_NfE.Ceps, "-", ""), 8, "0")
                loc_cT1T = PADR(CHRTRAN(cursor_4c_NfE.Tel1s, ".-", ""), 11)
                loc_cEmT = PADR(ALLTRIM(cursor_4c_NfE.eMails), 80)

                loc_cTts = PADL(cursor_4c_NfE.TpTribSers, 2, "0")

                loc_cOSN = IIF(cursor_4c_NfE.OptSimples == "S", "1", "0")
                loc_cCsF = PADR(THIS.this_cCodOpers, 4)
                loc_cCdB = PADL(ALLTRIM(cursor_4c_NfE.CodBenefs), 3, "0")
                loc_cCsM = PADR(STRTRAN(cursor_4c_NfE.CodSrvFis, ".", ""), 6)

                loc_nAlq = (cursor_4c_NfE.VTotIss / cursor_4c_NfE.TotProds) * 100
                loc_cAlq = PADL(CHRTRAN(STR(loc_nAlq, 9, 2), ". ", ""), 5, "0")
                loc_cVal = PADL(CHRTRAN(STR(cursor_4c_NfE.TotProds, 20, 2), ". ", ""), 15, "0")
                loc_cVde = PADL(CHRTRAN(STR(cursor_4c_NfE.VDeducoes, 20, 2), ". ", ""), 15, "0")
                loc_cIss = PADL(CHRTRAN(STR(cursor_4c_NfE.VTotIss, 20, 2), ". ", ""), 15, "0")
                loc_cRtd = IIF(cursor_4c_NfE.ISSRetidos = 1, "1", "0")

                loc_cObs = ALLTRIM(STRTRAN(STRTRAN(TratarNulo(cursor_4c_NfE.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_cObs = IIF(EMPTY(loc_cObs), "Servi" + CHR(231) + "os Prestados", loc_cObs)

                loc_nTsr = loc_nTsr + cursor_4c_NfE.TotProds
                loc_nTdd = loc_nTdd + cursor_4c_NfE.VDeducoes

                *-- 3.6. Registro Tipo 40 - Declaracao de Notas Convencionais Recebidas
                loc_cStr = "40" + loc_cTpn + loc_cSer + loc_cNot + loc_cEmi + loc_cSts + loc_cTpT + ;
                           loc_cCpW + loc_cImT + loc_cIeT + loc_cNmT + loc_cTeT + loc_cEdT + ;
                           loc_cNeT + loc_cCeT + loc_cBaT + loc_cCdT + loc_cUfT + loc_cCcT + ;
                           loc_cT1T + loc_cEmT + loc_cTts + SPACE(54) + loc_cOSN + loc_cCsF + ;
                           SPACE(11) + loc_cCdB + loc_cCsM + loc_cAlq + loc_cVal + loc_cVde + ;
                           SPACE(30) + loc_cIss + loc_cRtd + loc_cEmi + SPACE(15) + SPACE(15) + ;
                           loc_cObs + loc_cFim

                loc_nR40 = loc_nR40 + 1
                STRTOFILE(loc_cStr, loc_cArq, .T.)
            ENDSCAN

            *-- Registro Tipo 90 - Rodape
            loc_cNdt = PADL(CHRTRAN(STR(loc_nR20 + loc_nR40, 20, 0), ". ", ""), 8, "0")
            loc_cStr = "90" + loc_cNdt + ;
                       PADL(CHRTRAN(STR(loc_nTsr, 20, 2), ". ", ""), 15, "0") + ;
                       PADL(CHRTRAN(STR(loc_nTdd, 20, 2), ". ", ""), 15, "0") + ;
                       PADL(CHRTRAN(STR(loc_nTdc, 20, 2), ". ", ""), 15, "0") + ;
                       PADL(CHRTRAN(STR(loc_nTdi, 20, 2), ". ", ""), 15, "0") + loc_cFim
            STRTOFILE(loc_cStr, loc_cArq, .T.)

            THIS.this_cArquivoGerado = loc_cArq
            THIS.this_nTotalLinhas20 = loc_nR20
            THIS.this_nTotalLinhas40 = loc_nR40

            MsgInfo("O Arquivo " + CHR(34) + loc_cArq + CHR(34) + " Foi Gerado!" + CHR(13) + ;
                    "Notas de Sa" + CHR(237) + "da: " + ALLTRIM(STR(loc_nR20, 10)) + CHR(13) + ;
                    "Notas de Entrada: " + ALLTRIM(STR(loc_nR40, 10)), "Processamento Finalizado")
        ENDIF

            loc_lSucesso = loc_lProsseguir
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro ao gerar arquivo (Rio de Janeiro)")
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_NfS")
            USE IN cursor_4c_NfS
        ENDIF
        IF USED("cursor_4c_NfE")
            USE IN cursor_4c_NfE
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoSP - Transcricao literal de PROCEDURE prcspsaopaulo
    * (SIGPRNSE.SCX) - leiaute TXT da NFS-e da Prefeitura de Sao Paulo,
    * versao 3.4 (10/07/2014). So processa Notas de Saida (Operas = 'S'),
    * fechando com o rodape Tipo 9.
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivoSP()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cArq, loc_cDir, loc_nRg2, loc_nTsr, loc_nTdd, loc_cFim, ;
              loc_cTip, loc_cCpf, loc_cIms, loc_cDtI, loc_cDtF, loc_cStr, loc_cTpT, loc_cCpW, ;
              loc_cImT, loc_cIeT, loc_cNmT, loc_cEdT, loc_cTeT, loc_cNeT, loc_cCeT, loc_cBaT, ;
              loc_cCdT, loc_cUfT, loc_cCcT, loc_cEmT, loc_cSer, loc_cNot, loc_cEmi, loc_cTts, ;
              loc_cVal, loc_cVde, loc_cCsM, loc_cMps, loc_nAlq, loc_cAlq, loc_cRtd, loc_cPis, ;
              loc_cCof, loc_cIns, loc_cIrf, loc_cCsl, loc_cObs, loc_cNdt, loc_oErro
        loc_lSucesso = .F.
        loc_lProsseguir = .T.

        TRY
            IF USED("cursor_4c_NfS")
                USE IN cursor_4c_NfS
            ENDIF
            SELECT a.* FROM cursor_4c_NotasOrigem a, cursor_4c_Operacoes b ;
                WHERE a.Operas = "S" AND ;
                      a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                      b.SelImp ;
                INTO CURSOR cursor_4c_NfS READWRITE

            loc_nRg2 = 0
            loc_nTsr = 0
            loc_nTdd = 0
            loc_cFim = CHR(13) + CHR(10)

            loc_cTip = IIF(THIS.this_nTpEmps = 1, "1", "2")
            loc_cCpf = PADL(CHRTRAN(THIS.this_cCgcs, ".-/ ", ""), 14, "0")
            loc_cIms = PADL(CHRTRAN(THIS.this_cIms, ".-/ ", ""), 8, "0")
            loc_cDtI = DTOS(THIS.this_dDtIni)
            loc_cDtF = DTOS(THIS.this_dDtFin)

            loc_cDir = ALLTRIM(THIS.this_cDiretorio)
            loc_cArq = loc_cDir + ALLTRIM(loc_cIms) + "_" + ;
                       LEFT(CHRTRAN(TTOC(DATETIME()), "/: ", "--_"), 16) + ".TXT"

            STRTOFILE("", loc_cArq, .F.)
            IF !FILE(loc_cArq)
                THIS.this_cMensagemErro = "O Arquivo " + CHR(34) + loc_cArq + CHR(34) + " N" + CHR(227) + "o Pode Ser Criado!!!"
                MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
                        "Verifique Suas Permiss" + CHR(245) + "es de Cria" + CHR(231) + CHR(227) + "o e Tente Novamente!!!", ;
                        "Erro Na Cria" + CHR(231) + CHR(227) + "o do Arquivo")
                loc_lProsseguir = .F.
            ENDIF

        IF loc_lProsseguir
            *-- 3.2. Registro Tipo 1 - Cabecalho
            loc_cStr = "1" + "002" + loc_cIms + loc_cDtI + loc_cDtF + loc_cFim
            STRTOFILE(loc_cStr, loc_cArq, .T.)

            *-- Notas de Saida -> Registro Tipo 6
            SELECT cursor_4c_NfS
            SCAN
                loc_cTpT = PADL(cursor_4c_NfS.TpClis, 1, "0")
                loc_cTpT = IIF(loc_cTpT == "0", "3", loc_cTpT)
                loc_cCpW = PADL(CHRTRAN(cursor_4c_NfS.Cpfs, ".-/ ", ""), 14, "0")
                IF loc_cCpW == "00000000000000"
                    loc_cTpT = "3"
                ENDIF
                loc_cImT = PADL(CHRTRAN(cursor_4c_NfS.InscMuns, ".-/ ", ""), 8, "0")
                loc_cIeT = PADL(CHRTRAN(cursor_4c_NfS.Rgs, ".-/ ", ""), 12, "0")
                loc_cNmT = ALLTRIM(cursor_4c_NfS.Razaos)
                loc_cNmT = PADR(IIF(EMPTY(loc_cNmT), ALLTRIM(cursor_4c_NfS.RClis), loc_cNmT), 75)
                loc_cEdT = PADR(ALLTRIM(cursor_4c_NfS.Endes), 50)
                loc_cTeT = ALLTRIM(LEFT(loc_cEdT, AT(" ", loc_cEdT)))
                loc_cTeT = PADR(IIF(EMPTY(loc_cTeT), "RUA", loc_cTeT), 3)
                loc_cNeT = PADR(ALLTRIM(cursor_4c_NfS.Nums), 10)
                loc_cCeT = PADR(ALLTRIM(cursor_4c_NfS.Compls), 30)
                loc_cBaT = PADR(ALLTRIM(cursor_4c_NfS.Bairs), 30)
                loc_cCdT = PADR(ALLTRIM(cursor_4c_NfS.Cidas), 50)
                loc_cUfT = PADR(ALLTRIM(cursor_4c_NfS.Estas), 2)
                loc_cCcT = PADL(CHRTRAN(cursor_4c_NfS.Ceps, "-", ""), 8, "0")
                loc_cEmT = PADR(ALLTRIM(cursor_4c_NfS.eMails), 75)

                loc_cSer = PADR(ALLTRIM(cursor_4c_NfS.Series), 5)
                loc_cNot = PADL(ALLTRIM(cursor_4c_NfS.Nfis), 12, "0")
                loc_cEmi = DTOS(cursor_4c_NfS.Emis)
                loc_cTts = IIF(cursor_4c_NfS.TpTribSers = 1, "T", ;
                            IIF(cursor_4c_NfS.TpTribSers = 2, "I", ;
                            IIF(cursor_4c_NfS.TpTribSers = 3, "F", ;
                            IIF(cursor_4c_NfS.TpTribSers = 4, "C", ;
                            IIF(cursor_4c_NfS.TpTribSers = 5, "E", ;
                            IIF(cursor_4c_NfS.TpTribSers = 6, "J", "T"))))))

                loc_cVal = PADL(CHRTRAN(STR(cursor_4c_NfS.TotProds, 20, 2), ". ", ""), 15, "0")
                loc_cVde = PADL(CHRTRAN(STR(cursor_4c_NfS.VDeducoes, 20, 2), ". ", ""), 15, "0")
                loc_cCsM = PADR(STRTRAN(cursor_4c_NfS.CodSrvFis, ".", ""), 5)
                loc_cMps = PADL(ALLTRIM(cursor_4c_NfS.PrestServs), 7, "0")

                loc_nAlq = (cursor_4c_NfS.VTotIss / cursor_4c_NfS.TotProds) * 100
                loc_cAlq = PADL(CHRTRAN(STR(loc_nAlq, 9, 2), ". ", ""), 4, "0")
                loc_cRtd = PADR(IIF(cursor_4c_NfS.ISSRetidos = 1, 2, 1), 1)
                loc_cPis = PADL(CHRTRAN(STR(cursor_4c_NfS.VPis, 20, 2), ". ", ""), 15, "0")
                loc_cCof = PADL(CHRTRAN(STR(cursor_4c_NfS.VCofins, 20, 2), ". ", ""), 15, "0")
                loc_cIns = PADL(CHRTRAN(STR(cursor_4c_NfS.VInss, 20, 2), ". ", ""), 15, "0")
                loc_cIrf = PADL(CHRTRAN(STR(cursor_4c_NfS.VIrf, 20, 2), ". ", ""), 15, "0")
                loc_cCsl = PADL(CHRTRAN(STR(cursor_4c_NfS.VCsll, 20, 2), ". ", ""), 15, "0")

                loc_cObs = ALLTRIM(STRTRAN(STRTRAN(TratarNulo(cursor_4c_NfS.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_cObs = IIF(EMPTY(loc_cObs), "Servi" + CHR(231) + "os Prestados", loc_cObs)

                loc_nTsr = loc_nTsr + cursor_4c_NfS.TotProds
                loc_nTdd = loc_nTdd + cursor_4c_NfS.VDeducoes

                *-- 3.3. Registro Tipo 6
                loc_cStr = "6" + "RPS  " + loc_cSer + loc_cNot + loc_cEmi + loc_cTts + ;
                           loc_cVal + loc_cVde + loc_cCsM + loc_cAlq + loc_cRtd + loc_cTpT + ;
                           loc_cCpW + loc_cImT + loc_cIeT + loc_cNmT + loc_cTeT + loc_cEdT + ;
                           loc_cNeT + loc_cCeT + loc_cBaT + loc_cCdT + loc_cUfT + loc_cCcT + ;
                           loc_cEmT + loc_cPis + loc_cCof + loc_cIns + loc_cIrf + loc_cCsl + ;
                           PADL(0, 15, "0") + PADL(0, 5, "0") + SPACE(10) + PADL(0, 12, "0") + ;
                           PADL(0, 12, "0") + loc_cMps + SPACE(200) + loc_cObs + loc_cFim

                loc_nRg2 = loc_nRg2 + 1
                STRTOFILE(loc_cStr, loc_cArq, .T.)
            ENDSCAN

            *-- Registro Tipo 9 - Rodape
            loc_cNdt = PADL(CHRTRAN(STR(loc_nRg2, 20, 0), ". ", ""), 7, "0")
            loc_cStr = "9" + loc_cNdt + ;
                       PADL(CHRTRAN(STR(loc_nTsr, 20, 2), ". ", ""), 15, "0") + ;
                       PADL(CHRTRAN(STR(loc_nTdd, 20, 2), ". ", ""), 15, "0") + loc_cFim
            STRTOFILE(loc_cStr, loc_cArq, .T.)

            THIS.this_cArquivoGerado = loc_cArq
            THIS.this_nTotalLinhas20 = loc_nRg2
            THIS.this_nTotalLinhas40 = 0

            MsgInfo("O Arquivo " + CHR(34) + loc_cArq + CHR(34) + " Foi Gerado!" + CHR(13) + ;
                    "Notas de Sa" + CHR(237) + "da: " + ALLTRIM(STR(loc_nRg2, 10)), "Processamento Finalizado")
        ENDIF

            loc_lSucesso = loc_lProsseguir
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro ao gerar arquivo (S" + CHR(227) + "o Paulo)")
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_NfS")
            USE IN cursor_4c_NfS
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

