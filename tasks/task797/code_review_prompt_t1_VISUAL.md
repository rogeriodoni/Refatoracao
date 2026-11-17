# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPRPS.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1018 linhas total):

*-- Linhas 26 a 34:
26: *             leitura - os get_* do legado tem When retornando .F. e o
27: *             valor vem so do form chamador. Mais BOParaForm(), funil
28: *             unico da transferencia BO -> tela, que reproduz as
29: *             atribuicoes "ThisForm.get_*.Value = ..." do Init legado.
30: *             Form FLAT: os campos sao filhos diretos do form, nao ha
31: *             ConfigurarPaginaDados porque o legado nao tem PageFrame.
32: *   Fase 6:   2a metade dos campos de identificacao (RPS, Operacao, Numero),
33: *             completando ConfigurarCamposIdentificacao() e BOParaForm().
34: *             SEM lookup e SEM container de botoes Salvar/Cancelar: o

*-- Linhas 40 a 61:
40: *   Fase 7:   SEM TRABALHO - medido, nao omitido. O legado (comportamento.json)
41: *             tem exatamente 1 botao (Commandgroup2, ButtonCount=1) e 1 unico
42: *             Click no dump inteiro: "Release Windows". Esse Click JA foi
43: *             portado na Fase 3 (cmd_4c_Encerrar + BINDEVENT ->
44: *             CmdEncerrarClick - ver ConfigurarPageFrame). Nao ha
45: *             Incluir/Alterar/Visualizar/Excluir no legado (sem
46: *             frmcadastro/Grupo_Op/pcEscolha, form raiz "form" puro) -
47: *             criar esses 4 handlers aqui inventaria funcionalidade que o
48: *             sistema legado nunca teve, violando o PILAR 1 e a regra de
49: *             nao fabricar stubs. Os 6 get_* tambem nao tem Valid/KeyPress/
50: *             LostFocus (so When -> Return(.F.), ja reproduzido por
51: *             ReadOnly+TabStop na Fase 5/6) e a grade e somente leitura (sem
52: *             AfterRowColChange/DblClick no legado). Re-auditado o par
53: *             BINDEVENT+handler existente: CmdEncerrarClick e PUBLIC (sem
54: *             PROTECTED); o delegate existe e faz THIS.Release() (sem valor
55: *             a devolver ao chamador, por isso Release() e nao Hide()); o
56: *             BINDEVENT roda DEPOIS do AddObject de cmd_4c_Encerrar; o ESC
57: *             continua coberto por .Cancel = .T.; e o .Picture
58: *             ("cadastro_sair_60.jpg") existe em vbmp\ (regra #25). Mesmo
59: *             eixo de FormSIGOPDVM/Formsigopecm (Click unico ja portado em
60: *             fase anterior).
61: *   Fase 8:   Consolidacao. O gate da Fase 8 foi RODADO standalone antes de

*-- Linhas 216 a 241:
216:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
217: 
218:             *-- Caption (sem acentos - nao precisa de CHR())
219:             THIS.Caption = "Follow Up de RPS"
220: 
221:             *-- Monta os controles de estrutura. Ordem OBRIGATORIA: os campos
222:             *-- de identificacao vem DEPOIS da moldura shp_4c_Shape1 criada em
223:             *-- ConfigurarPageFrame, senao a moldura desenharia por cima deles.
224:             THIS.ConfigurarPageFrame()
225:             THIS.ConfigurarGrid()
226:             THIS.ConfigurarCamposIdentificacao()
227: 
228:             *-- Propaga o titulo para os labels do cabecalho
229:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
230:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
231: 
232:             *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
233:             THIS.TornarControlesVisiveis(THIS)
234: 
235:             *-- Preenche os campos de identificacao com os parametros recebidos
236:             *-- na abertura (os "ThisForm.get_*.Value = ..." do Init legado).
237:             *-- NAO depende de conexao SQL - so le properties do BO -, por isso
238:             *-- roda tambem em validacao de UI e em modo de teste.
239:             THIS.BOParaForm()
240: 
241:             *-- Carga do historico: pulada quando o pipeline esta validando a UI

*-- Linhas 268 a 364:
268:     *                     ConfigurarCamposIdentificacao() - que roda DEPOIS
269:     *                     deste metodo, para os campos ficarem por cima da
270:     *                     moldura
271:     *   cmd_4c_Encerrar:  botao Encerrar (Cancel=.T. vincula ao ESC) - unico
272:     *                     botao do Commandgroup2 legado (ButtonCount=1),
273:     *                     achatado para CommandButton standalone
274:     *--------------------------------------------------------------------------
275:     PROTECTED PROCEDURE ConfigurarPageFrame()
276:         LOCAL loc_oCab, loc_oErro
277:         TRY
278:             *-- Cabecalho escuro (cntSombra original: Top=0 Left=0 W=800 H=80)
279:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
280:             loc_oCab = THIS.cnt_4c_Cabecalho
281:             WITH loc_oCab
282:                 .Top         = 0
283:                 .Left        = 0
284:                 .Width       = THIS.Width
285:                 .Height      = 80
286:                 .BorderWidth = 0
287:                 .BackStyle   = 1
288:                 .BackColor   = RGB(100, 100, 100)
289:             ENDWITH
290: 
291:             *-- Labels dentro do cabecalho (fora do WITH do container - WITH
292:             *-- aninhado com AddObject ignora propriedades silenciosamente)
293:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
294:             WITH loc_oCab.lbl_4c_Sombra
295:                 .FontBold  = .T.
296:                 .FontName  = "Tahoma"
297:                 .FontSize  = 18
298:                 .WordWrap  = .T.
299:                 .AutoSize  = .F.
300:                 .Alignment = 0
301:                 .BackStyle = 0
302:                 .Caption   = ""
303:                 .Height    = 40
304:                 .Left      = 10
305:                 .Top       = 18
306:                 .Width     = THIS.Width - 20
307:                 .ForeColor = RGB(0, 0, 0)
308:             ENDWITH
309: 
310:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
311:             WITH loc_oCab.lbl_4c_Titulo
312:                 .FontBold    = .T.
313:                 .FontName    = "Tahoma"
314:                 .FontSize    = 18
315:                 .WordWrap    = .T.
316:                 .AutoSize    = .F.
317:                 .Alignment   = 0
318:                 .BackStyle   = 0
319:                 .Caption     = ""
320:                 .Height      = 46
321:                 .Left        = 10
322:                 .Top         = 17
323:                 .Width       = THIS.Width - 20
324:                 .ForeColor   = RGB(255, 255, 255)
325:                 .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
326:             ENDWITH
327: 
328:             *-- Moldura decorativa em volta dos campos de identificacao
329:             *-- (Shape1 original: Top=94, Left=65, H=65, W=520)
330:             THIS.AddObject("shp_4c_Shape1", "Shape")
331:             WITH THIS.shp_4c_Shape1
332:                 .Top         = 94
333:                 .Left        = 65
334:                 .Height      = 65
335:                 .Width       = 520
336:                 .BackStyle   = 0
337:                 .BorderColor = RGB(90, 90, 90)
338:             ENDWITH
339: 
340:             *-- Botao Encerrar (Commandgroup2 original: Top=-2, Left=570;
341:             *-- Command1 relativo Top=5, Left=5 -> absoluto Top=3, Left=575)
342:             THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
343:             WITH THIS.cmd_4c_Encerrar
344:                 .Top        = 3
345:                 .Left       = 575
346:                 .Height     = 75
347:                 .Width      = 75
348:                 .FontBold   = .T.
349:                 .FontItalic = .T.
350:                 .FontName   = "Comic Sans MS"
351:                 .FontSize   = 8
352:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
353:                 .Cancel     = .T.
354:                 .Caption    = "Encerrar"
355:                 .ForeColor  = RGB(90, 90, 90)
356:                 .BackColor  = RGB(255, 255, 255)
357:                 .Themes     = .T.
358:             ENDWITH
359:             BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
360: 
361:         CATCH TO loc_oErro
362:             MsgErro(loc_oErro.Message + CHR(13) + ;
363:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
364:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPRPS.ConfigurarPageFrame")

*-- Linhas 380 a 389:
380:         TRY
381:             THIS.AddObject("grd_4c_Dados", "Grid")
382:             WITH THIS.grd_4c_Dados
383:                 .Top          = 164
384:                 .Left         = 65
385:                 .Width        = 520
386:                 .Height       = 202
387:                 .ColumnCount  = 4
388:                 .FontName     = "Tahoma"
389:                 .FontSize     = 8

*-- Linhas 553 a 585:
553:                     .Resizable = .F.
554:                 ENDWITH
555:                 loc_oGrid.Column1.Header1.Alignment = 2
556:                 loc_oGrid.Column1.Header1.Caption   = "Data/Hora"
557: 
558:                 WITH loc_oGrid.Column2
559:                     .Width     = 220
560:                     .Movable   = .F.
561:                     .Resizable = .F.
562:                 ENDWITH
563:                 loc_oGrid.Column2.Header1.Alignment = 2
564:                 loc_oGrid.Column2.Header1.Caption   = "Tipo Lan" + CHR(231) + "amento"
565: 
566:                 WITH loc_oGrid.Column3
567:                     .Width     = 80
568:                     .Movable   = .F.
569:                     .Resizable = .F.
570:                 ENDWITH
571:                 loc_oGrid.Column3.Header1.Alignment = 2
572:                 loc_oGrid.Column3.Header1.Caption   = "Usu" + CHR(225) + "rio"
573: 
574:                 WITH loc_oGrid.Column4
575:                     .Width     = 55
576:                     .Movable   = .F.
577:                     .Resizable = .F.
578:                 ENDWITH
579:                 loc_oGrid.Column4.Header1.Alignment = 2
580:                 loc_oGrid.Column4.Header1.Caption   = "N" + CHR(186) + " NF"
581: 
582:                 *-- Grid.ReadOnly propaga para as colunas - o ReadOnly da
583:                 *-- COLUNA vai DEPOIS do vinculo, senao o reset o sobrescreve
584:                 loc_oGrid.ReadOnly         = .T.
585:                 loc_oGrid.Column1.ReadOnly = .T.

*-- Linhas 639 a 647:
639:     *
640:     * ReadOnly = .T. - todos os get_* do legado tem "PROCEDURE When ->
641:     * Return(.F.)", ou seja o campo NUNCA aceita digitacao: o valor vem so do
642:     * form chamador (os "ThisForm.get_*.Value = ..." do Init legado,
643:     * reproduzidos em BOParaForm). NAO usar BINDEVENT(..., "When", ...) para
644:     * isso: BINDEVENT DESCARTA o retorno do delegate, entao um When ligado
645:     * por BINDEVENT nao bloqueia nada (regra CLAUDE.md #3) e o campo
646:     * continuaria digitavel. ReadOnly = .T. e a reproducao canonica de
647:     * "When -> .f." no sistema novo e PRESERVA a aparencia do legado - ao

*-- Linhas 663 a 691:
663:         TRY
664:             *-- Say6 "Empresa :" (Left=84, Top=103) + get_Emps (Left=136,
665:             *-- Top=100, W=31, MaxLength=3). Vao de 52px ate o campo.
666:             THIS.AddObject("lbl_4c_Label6", "Label")
667:             WITH THIS.lbl_4c_Label6
668:                 .Top       = 103
669:                 .Left      = 84
670:                 .Width     = 50
671:                 .Height    = 17
672:                 .AutoSize  = .F.
673:                 .BackStyle = 0
674:                 .WordWrap  = .F.
675:                 .Alignment = 0
676:                 .FontName  = "Tahoma"
677:                 .FontSize  = 8
678:                 .ForeColor = RGB(90, 90, 90)
679:                 .Caption   = "Empresa :"
680:                 .TabIndex  = 10
681:             ENDWITH
682: 
683:             THIS.AddObject("txt_4c__Emps", "TextBox")
684:             WITH THIS.txt_4c__Emps
685:                 .Top       = 100
686:                 .Left      = 136
687:                 .Width     = 31
688:                 .Alignment = 0
689:                 .FontName  = "Tahoma"
690:                 .FontSize  = 8
691:                 .MaxLength = 3

*-- Linhas 703 a 731:
703: 
704:             *-- Say3 "Tipo :" (Left=210, Top=104) + get_Tipos (Left=241,
705:             *-- Top=100, W=45, MaxLength=5). Vao de 31px ate o campo.
706:             THIS.AddObject("lbl_4c_Label3", "Label")
707:             WITH THIS.lbl_4c_Label3
708:                 .Top       = 104
709:                 .Left      = 210
710:                 .Width     = 30
711:                 .Height    = 17
712:                 .AutoSize  = .F.
713:                 .BackStyle = 0
714:                 .WordWrap  = .F.
715:                 .Alignment = 0
716:                 .FontName  = "Tahoma"
717:                 .FontSize  = 8
718:                 .ForeColor = RGB(90, 90, 90)
719:                 .Caption   = "Tipo :"
720:                 .TabIndex  = 10
721:             ENDWITH
722: 
723:             THIS.AddObject("txt_4c__Tipos", "TextBox")
724:             WITH THIS.txt_4c__Tipos
725:                 .Top       = 100
726:                 .Left      = 241
727:                 .Width     = 45
728:                 .Alignment = 0
729:                 .FontName  = "Tahoma"
730:                 .FontSize  = 8
731:                 .MaxLength = 5

*-- Linhas 739 a 767:
739: 
740:             *-- Say4 "Serie :" (Left=321, Top=104) + get_Series (Left=356,
741:             *-- Top=100, W=45, MaxLength=5). Vao de 35px ate o campo.
742:             THIS.AddObject("lbl_4c_Label4", "Label")
743:             WITH THIS.lbl_4c_Label4
744:                 .Top       = 104
745:                 .Left      = 321
746:                 .Width     = 33
747:                 .Height    = 17
748:                 .AutoSize  = .F.
749:                 .BackStyle = 0
750:                 .WordWrap  = .F.
751:                 .Alignment = 0
752:                 .FontName  = "Tahoma"
753:                 .FontSize  = 8
754:                 .ForeColor = RGB(90, 90, 90)
755:                 .Caption   = "S" + CHR(233) + "rie :"
756:                 .TabIndex  = 10
757:             ENDWITH
758: 
759:             THIS.AddObject("txt_4c__Series", "TextBox")
760:             WITH THIS.txt_4c__Series
761:                 .Top       = 100
762:                 .Left      = 356
763:                 .Width     = 45
764:                 .Alignment = 0
765:                 .FontName  = "Tahoma"
766:                 .FontSize  = 8
767:                 .MaxLength = 5

*-- Linhas 778 a 806:
778:             *-- get_NumRps.Value recebe pnNumRps NUMERICO no Init legado
779:             *-- (ThisForm.get_NumRps.Value = pnNumRps) - property do BO
780:             *-- correspondente (this_nNumRps) tambem e numerica.
781:             THIS.AddObject("lbl_4c_Label5", "Label")
782:             WITH THIS.lbl_4c_Label5
783:                 .Top       = 104
784:                 .Left      = 451
785:                 .Width     = 28
786:                 .Height    = 17
787:                 .AutoSize  = .F.
788:                 .BackStyle = 0
789:                 .WordWrap  = .F.
790:                 .Alignment = 0
791:                 .FontName  = "Tahoma"
792:                 .FontSize  = 8
793:                 .ForeColor = RGB(90, 90, 90)
794:                 .Caption   = "RPS :"
795:                 .TabIndex  = 10
796:             ENDWITH
797: 
798:             THIS.AddObject("txt_4c__NumRps", "TextBox")
799:             WITH THIS.txt_4c__NumRps
800:                 .Top       = 100
801:                 .Left      = 481
802:                 .Width     = 95
803:                 .Alignment = 0
804:                 .FontName  = "Tahoma"
805:                 .FontSize  = 8
806:                 .MaxLength = 12

*-- Linhas 816 a 844:
816:             *-- Top=128, W=150, MaxLength=20). Vao de 58px ate o campo.
817:             *-- 2a linha da moldura (Top~128/131, abaixo de Empresa/Tipo/
818:             *-- Serie/RPS, que ficam em Top~100/104).
819:             THIS.AddObject("lbl_4c_Label1", "Label")
820:             WITH THIS.lbl_4c_Label1
821:                 .Top       = 131
822:                 .Left      = 78
823:                 .Width     = 56
824:                 .Height    = 17
825:                 .AutoSize  = .F.
826:                 .BackStyle = 0
827:                 .WordWrap  = .F.
828:                 .Alignment = 0
829:                 .FontName  = "Tahoma"
830:                 .FontSize  = 8
831:                 .ForeColor = RGB(90, 90, 90)
832:                 .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
833:                 .TabIndex  = 10
834:             ENDWITH
835: 
836:             THIS.AddObject("txt_4c__Dopes", "TextBox")
837:             WITH THIS.txt_4c__Dopes
838:                 .Top       = 128
839:                 .Left      = 136
840:                 .Width     = 150
841:                 .Alignment = 0
842:                 .FontName  = "Tahoma"
843:                 .FontSize  = 8
844:                 .MaxLength = 20

*-- Linhas 855 a 883:
855:             *-- get_Numes.Value recebe pnNumes NUMERICO no Init legado
856:             *-- (ThisForm.get_Numes.Value = pnNumes) - property do BO
857:             *-- correspondente (this_nNumes) tambem e numerica.
858:             THIS.AddObject("lbl_4c_Label2", "Label")
859:             WITH THIS.lbl_4c_Label2
860:                 .Top       = 132
861:                 .Left      = 309
862:                 .Width     = 45
863:                 .Height    = 17
864:                 .AutoSize  = .F.
865:                 .BackStyle = 0
866:                 .WordWrap  = .F.
867:                 .Alignment = 0
868:                 .FontName  = "Tahoma"
869:                 .FontSize  = 8
870:                 .ForeColor = RGB(90, 90, 90)
871:                 .Caption   = "N" + CHR(250) + "mero :"
872:                 .TabIndex  = 10
873:             ENDWITH
874: 
875:             THIS.AddObject("txt_4c__Numes", "TextBox")
876:             WITH THIS.txt_4c__Numes
877:                 .Top       = 128
878:                 .Left      = 356
879:                 .Width     = 55
880:                 .Height    = 23
881:                 .Alignment = 0
882:                 .FontName  = "Tahoma"
883:                 .FontSize  = 8


### BO (C:\4c\projeto\app\classes\SIGOPRPSBO.prg):
*==============================================================================
* SIGOPRPSBO.prg - Business Object para Follow Up de RPS (SIGOPRPS)
* Tabela principal: SigCdFrp (log de acompanhamento/rastreamento do RPS)
*==============================================================================

DEFINE CLASS SIGOPRPSBO AS BusinessBase

    *-- Identificacao do RPS (parametros recebidos na abertura do form) ----
    this_cEmps   = ""    && char(3)  - Empresa
    this_cTipos  = ""    && char(5)  - Tipo do RPS
    this_cSeries = ""    && char(5)  - Serie do RPS
    this_nNumRps = 0     && N(12,0)  - Numero do RPS
    this_cDopes  = ""    && char(20) - Operacao (codigo)
    this_nNumes  = 0     && N(6,0)   - Numero da operacao

    *-- Cursor com o historico de acompanhamento (SigCdFrp) ----------------
    this_cCursorDados = "cursor_4c_Historico"

    *-- Dados do registro de historico corrente (populados por CarregarDoCursor) --
    this_cCidChaves  = ""    && char(20) - PK de SigCdFrp
    this_dDatas      = {}    && datetime - Data/Hora do lancamento
    this_cNfis       = ""    && char(8)  - Numero da NF
    this_cTransacaos = ""    && char(30) - Tipo de lancamento/transacao
    this_cUsuars     = ""    && char(10) - Usuario que gerou o lancamento

    *--------------------------------------------------------------------------
    * Init - Recebe a identificacao do RPS a ser acompanhado
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmps, par_cTipos, par_cSeries, par_nNumRps, par_cDopes, par_nNumes)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdFrp"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cEmps   = TratarNulo(par_cEmps, "")
            THIS.this_cTipos  = TratarNulo(par_cTipos, "")
            THIS.this_cSeries = TratarNulo(par_cSeries, "")
            THIS.this_nNumRps = TratarNulo(par_nNumRps, 0)
            THIS.this_cDopes  = TratarNulo(par_cDopes, "")
            THIS.this_nNumes  = TratarNulo(par_nNumes, 0)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar SIGOPRPSBO: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarHistorico - Consulta o historico de acompanhamento do RPS
    * (SigCdFrp), do mais recente para o mais antigo, e popula
    * THIS.this_cCursorDados (cursor_4c_Historico - RecordSource do grid).
    *
    * Transcricao LITERAL do Init do SCX legado: o filtro usa APENAS Emps,
    * Tipos, Series e NumRps - Dopes e Numes sao recebidos na identificacao
    * mas NAO entram no WHERE da consulta original, e isso nao foi alterado.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarHistorico()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        THIS.this_cMensagemErro = ""

        TRY
            loc_cSQL = "SELECT Datas, Transacaos, Usuars, Nfis " + ;
                       "FROM SigCdFrp " + ;
                       "WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Tipos = " + EscaparSQL(THIS.this_cTipos) + ;
                       " AND Series = " + EscaparSQL(THIS.this_cSeries) + ;
                       " AND NumRps = " + FormatarNumeroSQL(THIS.this_nNumRps, 0) + ;
                       " ORDER BY Datas DESC"

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar hist" + CHR(243) + ;
                    "rico do RPS: " + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao consultar hist" + CHR(243) + ;
                "rico do RPS: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas de SigCdFrp para as
    * properties this_* do registro de historico corrente.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
            THIS.this_dDatas      = TratarNulo(datas, {})
            THIS.this_cDopes      = TratarNulo(dopes, "")
            THIS.this_cEmps       = TratarNulo(emps, "")
            THIS.this_cNfis       = TratarNulo(nfis, "")
            THIS.this_nNumes      = TratarNulo(numes, 0)
            THIS.this_nNumRps     = TratarNulo(numrps, 0)
            THIS.this_cSeries     = TratarNulo(series, "")
            THIS.this_cTipos      = TratarNulo(tipos, "")
            THIS.this_cTransacaos = TratarNulo(transacaos, "")
            THIS.this_cUsuars     = TratarNulo(usuars, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria do registro de historico corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir/Atualizar/ExecutarExclusao - SIGOPRPS (Follow Up de RPS) eh
    * uma tela de CONSULTA somente leitura: o legado nao tem Incluir/Alterar/
    * Excluir (Commandgroup2 tem um unico botao, "Encerrar", e todos os
    * get_* do form tem When retornando .F., ou seja nunca entram em modo de
    * edicao). O comportamento padrao herdado de BusinessBase ja eh o
    * correto para estes tres metodos - nao ha necessidade de sobrescrever.
    *--------------------------------------------------------------------------

ENDDEFINE

