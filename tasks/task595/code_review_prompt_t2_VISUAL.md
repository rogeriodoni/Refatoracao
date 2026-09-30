# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1091 linhas total):

*-- Linhas 88 a 96:
88:     * delegar a inicializacao padrao (FormBase.Init -> InicializarForm)
89:     *--------------------------------------------------------------------------
90:     PROCEDURE Init(par_cFase, par_cUnidade, par_dData, par_nCodigo)
91:         THIS.Caption = "Capacidade Produtiva"
92: 
93:         IF VARTYPE(par_cFase) = "C"
94:             THIS.this_cFasePar = par_cFase
95:         ENDIF
96:         IF VARTYPE(par_cUnidade) = "C"

*-- Linhas 195 a 262:
195:         THIS.AddObject("cnt_4c_Container1", "Container")
196:         loc_oCnt = THIS.cnt_4c_Container1
197:         WITH loc_oCnt
198:             .Top           = 104
199:             .Left          = 8
200:             .Width         = 278
201:             .Height        = 36
202:             .BackStyle     = 0
203:             .BorderWidth   = 0
204:             .SpecialEffect = 0
205:             .Visible       = .T.
206:         ENDWITH
207: 
208:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
209:         WITH loc_oCnt.lbl_4c_Label1
210:             .FontBold  = .T.
211:             .FontName  = "Tahoma"
212:             .FontSize  = 8
213:             .BackStyle = 0
214:             .Caption   = "Fase :"
215:             .Height    = 17
216:             .Left      = 2
217:             .Top       = 8
218:             .Width     = 40
219:             .ForeColor = RGB(90, 90, 90)
220:         ENDWITH
221: 
222:         loc_oCnt.AddObject("txt_4c_Fase", "TextBox")
223:         WITH loc_oCnt.txt_4c_Fase
224:             .FontBold  = .T.
225:             .FontName  = "Tahoma"
226:             .FontSize  = 8
227:             .Height    = 23
228:             .Left      = 44
229:             .Top       = 5
230:             .Width     = 100
231:             .BackColor = RGB(255, 198, 140)
232:             .Value     = ""
233:             .ReadOnly  = .T.
234:         ENDWITH
235: 
236:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
237:         WITH loc_oCnt.lbl_4c_Label2
238:             .FontBold  = .T.
239:             .FontName  = "Tahoma"
240:             .FontSize  = 8
241:             .BackStyle = 0
242:             .Caption   = "Data :"
243:             .Height    = 17
244:             .Left      = 147
245:             .Top       = 9
246:             .Width     = 40
247:             .ForeColor = RGB(90, 90, 90)
248:         ENDWITH
249: 
250:         loc_oCnt.AddObject("txt_4c__Data", "TextBox")
251:         WITH loc_oCnt.txt_4c__Data
252:             .FontBold  = .T.
253:             .FontName  = "Tahoma"
254:             .FontSize  = 8
255:             .Height    = 23
256:             .Left      = 189
257:             .Top       = 5
258:             .Width     = 72
259:             .BackColor = RGB(255, 198, 140)
260:             .Value     = {}
261:             .ReadOnly  = .T.
262:         ENDWITH

*-- Linhas 274 a 422:
274:         THIS.AddObject("cnt_4c_Container2", "Container")
275:         loc_oCnt = THIS.cnt_4c_Container2
276:         WITH loc_oCnt
277:             .Top           = 104
278:             .Left          = 288
279:             .Width         = 504
280:             .Height        = 36
281:             .BackStyle     = 0
282:             .BorderWidth   = 0
283:             .SpecialEffect = 0
284:             .Visible       = .T.
285:         ENDWITH
286: 
287:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
288:         WITH loc_oCnt.lbl_4c_Label1
289:             .AutoSize  = .T.
290:             .FontBold  = .T.
291:             .FontName  = "Tahoma"
292:             .FontSize  = 8
293:             .BackStyle = 0
294:             .Caption   = "Capacidade:"
295:             .Height    = 15
296:             .Left      = 9
297:             .Top       = 10
298:             .Width     = 70
299:             .ForeColor = RGB(90, 90, 90)
300:         ENDWITH
301: 
302:         loc_oCnt.AddObject("txt_4c_Cap", "TextBox")
303:         WITH loc_oCnt.txt_4c_Cap
304:             .FontBold   = .T.
305:             .FontName   = "Tahoma"
306:             .FontSize   = 8
307:             .Height     = 23
308:             .InputMask  = "99999"
309:             .Left       = 81
310:             .Top        = 5
311:             .Width      = 63
312:             .BackColor  = RGB(255, 216, 176)
313:             .Value      = 0
314:             .ReadOnly   = .T.
315:         ENDWITH
316: 
317:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
318:         WITH loc_oCnt.lbl_4c_Label2
319:             .AutoSize  = .T.
320:             .FontBold  = .T.
321:             .FontName  = "Tahoma"
322:             .FontSize  = 8
323:             .BackStyle = 0
324:             .Caption   = "Utilizado:"
325:             .Height    = 15
326:             .Left      = 194
327:             .Top       = 10
328:             .Width     = 54
329:             .ForeColor = RGB(90, 90, 90)
330:         ENDWITH
331: 
332:         loc_oCnt.AddObject("txt_4c_Utz", "TextBox")
333:         WITH loc_oCnt.txt_4c_Utz
334:             .FontBold   = .T.
335:             .FontName   = "Tahoma"
336:             .FontSize   = 8
337:             .Height     = 23
338:             .InputMask  = "99999"
339:             .Left       = 250
340:             .Top        = 5
341:             .Width      = 63
342:             .BackColor  = RGB(255, 216, 176)
343:             .Value      = 0
344:             .ReadOnly   = .T.
345:         ENDWITH
346: 
347:         loc_oCnt.AddObject("lbl_4c_Label3", "Label")
348:         WITH loc_oCnt.lbl_4c_Label3
349:             .AutoSize  = .T.
350:             .FontBold  = .T.
351:             .FontName  = "Tahoma"
352:             .FontSize  = 8
353:             .BackStyle = 0
354:             .Caption   = "Saldo : "
355:             .Height    = 15
356:             .Left      = 366
357:             .Top       = 10
358:             .Width     = 42
359:             .ForeColor = RGB(90, 90, 90)
360:         ENDWITH
361: 
362:         loc_oCnt.AddObject("txt_4c__Sld", "TextBox")
363:         WITH loc_oCnt.txt_4c__Sld
364:             .FontBold   = .T.
365:             .FontName   = "Tahoma"
366:             .FontSize   = 8
367:             .Height     = 23
368:             .InputMask  = "99999"
369:             .Left       = 410
370:             .Top        = 5
371:             .Width      = 63
372:             .BackColor  = RGB(255, 216, 176)
373:             .Value      = 0
374:             .ReadOnly   = .T.
375:         ENDWITH
376: 
377:         loc_oCnt.AddObject("lbl_4c_Label4", "Label")
378:         WITH loc_oCnt.lbl_4c_Label4
379:             .AutoSize  = .T.
380:             .FontBold  = .T.
381:             .FontName  = "Tahoma"
382:             .FontSize  = 8
383:             .BackStyle = 0
384:             .Caption   = "Min"
385:             .Height    = 15
386:             .Left      = 147
387:             .Top       = 10
388:             .Width     = 22
389:             .ForeColor = RGB(90, 90, 90)
390:         ENDWITH
391: 
392:         loc_oCnt.AddObject("lbl_4c_Label5", "Label")
393:         WITH loc_oCnt.lbl_4c_Label5
394:             .AutoSize  = .T.
395:             .FontBold  = .T.
396:             .FontName  = "Tahoma"
397:             .FontSize  = 8
398:             .BackStyle = 0
399:             .Caption   = "Min"
400:             .Height    = 15
401:             .Left      = 316
402:             .Top       = 9
403:             .Width     = 22
404:             .ForeColor = RGB(90, 90, 90)
405:         ENDWITH
406: 
407:         loc_oCnt.AddObject("lbl_4c_Label6", "Label")
408:         WITH loc_oCnt.lbl_4c_Label6
409:             .AutoSize  = .T.
410:             .FontBold  = .T.
411:             .FontName  = "Tahoma"
412:             .FontSize  = 8
413:             .BackStyle = 0
414:             .Caption   = "Min"
415:             .Height    = 15
416:             .Left      = 476
417:             .Top       = 9
418:             .Width     = 22
419:             .ForeColor = RGB(90, 90, 90)
420:         ENDWITH
421:     ENDPROC
422: 

*-- Linhas 440 a 449:
440:         loc_oGrid = THIS.grd_4c_Dados
441: 
442:         WITH loc_oGrid
443:             .Top         = 139
444:             .Left        = 0
445:             .Width       = 801
446:             .Height      = 310
447:             .ColumnCount = 8
448:             .FontName    = "Arial"
449:             .DeleteMark  = .F.

*-- Linhas 652 a 674:
652:                 .Column8.ControlSource = loc_cCursor + ".UniPrdts"
653: 
654:                 *-- Headers e larguras (RecordSource acabou de resetar os dois)
655:                 .Column1.Header1.Caption = "Envelope"
656:                 .Column1.Width           = 80
657:                 .Column2.Header1.Caption = "O.P."
658:                 .Column2.Width           = 102
659:                 .Column3.Header1.Caption = "Seq"
660:                 .Column3.Width           = 24
661:                 .Column4.Header1.Caption = "Minutos"
662:                 .Column4.Width           = 65
663:                 .Column5.Header1.Caption = "Produto"
664:                 .Column5.Width           = 95
665:                 .Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
666:                 .Column6.Width           = 190
667:                 .Column7.Header1.Caption = "Cliente"
668:                 .Column7.Width           = 165
669:                 .Column8.Header1.Caption = "Unidade Prod."
670:                 .Column8.Width           = 80
671: 
672:                 *-- Operacoes com prioridade (Priors >= 999990) ficam pretas,
673:                 *-- as demais azuis - transcricao literal do SetAll do legado
674:                 .SetAll("DynamicForeColor", ;

*-- Linhas 702 a 729:
702:     * de consulta, aberto ja com todos os parametros pelo chamador.
703:     *--------------------------------------------------------------------------
704:     PROTECTED PROCEDURE ConfigurarBotoes()
705:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
706:         WITH THIS.cmd_4c_Sair
707:             .Top        = 4
708:             .Left       = 725
709:             .Width      = 75
710:             .Height     = 75
711:             .Caption    = "Encerrar"
712:             .Cancel     = .T.
713:             .FontName   = "Comic Sans MS"
714:             .FontBold   = .T.
715:             .FontItalic = .T.
716:             .FontSize   = 8
717:             .ForeColor  = RGB(90, 90, 90)
718:             .BackColor  = RGB(255, 255, 255)
719:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
720:             .Themes     = .T.
721:             .Visible    = .T.
722:         ENDWITH
723: 
724:         BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
725:     ENDPROC
726: 
727:     *--------------------------------------------------------------------------
728:     * BtnSairClick - Encerra o form (equivalente a ThisForm.Release do
729:     * legado). PUBLIC porque eh alvo de BINDEVENT (regra #3).

*-- Linhas 748 a 826:
748:         *-- fielmente aqui, sem inventar toggle para ele).
749:         THIS.AddObject("img_4c_FigJpg", "Image")
750:         WITH THIS.img_4c_FigJpg
751:             .Top     = 457
752:             .Left    = 459
753:             .Width   = 143
754:             .Height  = 105
755:             .Stretch = 1
756:             .Picture = ""
757:             .Visible = .F.
758:         ENDWITH
759: 
760:         THIS.AddObject("shp_4c_Shape4", "Shape")
761:         WITH THIS.shp_4c_Shape4
762:             .Top     = 455
763:             .Left    = 456
764:             .Width   = 148
765:             .Height  = 109
766:             .Visible = .F.
767:         ENDWITH
768: 
769:         *-- Say2 "Descricao Produto" + Get_descr
770:         THIS.AddObject("lbl_4c_Label2", "Label")
771:         WITH THIS.lbl_4c_Label2
772:             .Top       = 455
773:             .Left      = 92
774:             .Width     = 130
775:             .Height    = 15
776:             .AutoSize  = .F.
777:             .BackStyle = 0
778:             .Alignment = 0
779:             .FontBold  = .T.
780:             .FontName  = "Tahoma"
781:             .FontSize  = 8
782:             .ForeColor = RGB(90, 90, 90)
783:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto"
784:         ENDWITH
785: 
786:         THIS.AddObject("txt_4c_Descr", "TextBox")
787:         WITH THIS.txt_4c_Descr
788:             .Top       = 468
789:             .Left      = 90
790:             .Width     = 345
791:             .Height    = 23
792:             .FontBold  = .T.
793:             .FontName  = "Tahoma"
794:             .FontSize  = 8
795:             .ForeColor = RGB(0, 0, 0)
796:             .BackColor = RGB(255, 255, 198)
797:             .Value     = ""
798:             .ReadOnly  = .T.
799:         ENDWITH
800: 
801:         *-- Say1 "Quantidade" + Get_qtde
802:         THIS.AddObject("lbl_4c_Label1", "Label")
803:         WITH THIS.lbl_4c_Label1
804:             .Top       = 455
805:             .Left      = 11
806:             .Width     = 74
807:             .Height    = 15
808:             .AutoSize  = .F.
809:             .BackStyle = 0
810:             .Alignment = 0
811:             .FontBold  = .T.
812:             .FontName  = "Tahoma"
813:             .FontSize  = 8
814:             .ForeColor = RGB(90, 90, 90)
815:             .Caption   = "Quantidade"
816:         ENDWITH
817: 
818:         THIS.AddObject("txt_4c_Qtde", "TextBox")
819:         WITH THIS.txt_4c_Qtde
820:             .Top       = 468
821:             .Left      = 9
822:             .Width     = 74
823:             .Height    = 23
824:             .InputMask = "99999.999"
825:             .FontBold  = .T.
826:             .FontName  = "Tahoma"

*-- Linhas 832 a 891:
832:         ENDWITH
833: 
834:         *-- Say3 "Cliente" + Get_Cliente
835:         THIS.AddObject("lbl_4c_Label3", "Label")
836:         WITH THIS.lbl_4c_Label3
837:             .Top       = 494
838:             .Left      = 11
839:             .Width     = 60
840:             .Height    = 15
841:             .AutoSize  = .F.
842:             .BackStyle = 0
843:             .Alignment = 0
844:             .FontBold  = .T.
845:             .FontName  = "Tahoma"
846:             .FontSize  = 8
847:             .ForeColor = RGB(90, 90, 90)
848:             .Caption   = "Cliente"
849:         ENDWITH
850: 
851:         THIS.AddObject("txt_4c_Cliente", "TextBox")
852:         WITH THIS.txt_4c_Cliente
853:             .Top       = 507
854:             .Left      = 9
855:             .Width     = 425
856:             .Height    = 23
857:             .FontBold  = .T.
858:             .FontName  = "Tahoma"
859:             .FontSize  = 8
860:             .ForeColor = RGB(0, 0, 0)
861:             .BackColor = RGB(255, 255, 221)
862:             .Value     = ""
863:             .ReadOnly  = .T.
864:         ENDWITH
865: 
866:         *-- Say4 "Tempo Total do Envelope" + Get_tEnv
867:         THIS.AddObject("lbl_4c_Label4", "Label")
868:         WITH THIS.lbl_4c_Label4
869:             .Top       = 532
870:             .Left      = 11
871:             .Width     = 200
872:             .Height    = 15
873:             .AutoSize  = .F.
874:             .BackStyle = 0
875:             .Alignment = 0
876:             .FontBold  = .T.
877:             .FontName  = "Tahoma"
878:             .FontSize  = 8
879:             .ForeColor = RGB(90, 90, 90)
880:             .Caption   = "Tempo Total do Envelope"
881:         ENDWITH
882: 
883:         THIS.AddObject("txt_4c_TEnv", "TextBox")
884:         WITH THIS.txt_4c_TEnv
885:             .Top       = 545
886:             .Left      = 9
887:             .Width     = 74
888:             .Height    = 23
889:             .InputMask = "99999"
890:             .FontBold  = .T.
891:             .FontName  = "Tahoma"

*-- Linhas 901 a 922:
901:         *-- numeros JA SAO o auto-size calculado pelo Form Designer, entao
902:         *-- transcrever com AutoSize=.F. eh reproducao fiel (regra #23) -
903:         *-- AutoSize=.T. eh no-op em Label criado por AddObject.
904:         THIS.AddObject("lbl_4c_LabelPrioridade", "Label")
905:         WITH THIS.lbl_4c_LabelPrioridade
906:             .Top       = 457
907:             .Left      = 617
908:             .Width     = 160
909:             .Height    = 15
910:             .AutoSize  = .F.
911:             .BackStyle = 0
912:             .Alignment = 0
913:             .FontBold  = .T.
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916:             .ForeColor = RGB(90, 90, 90)
917:             .Caption   = "[ Opera" + CHR(231) + CHR(227) + "o com Prioridade ]"
918:         ENDWITH
919:     ENDPROC
920: 
921:     *--------------------------------------------------------------------------
922:     * GradeAfterRowColChange - Recarrega o painel de detalhe da linha

*-- Linhas 987 a 1036:
987:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
988:         loc_oCab = THIS.cnt_4c_Cabecalho
989:         WITH loc_oCab
990:             .Top         = 0
991:             .Left        = 0
992:             .Width       = THIS.Width
993:             .Height      = 80
994:             .BackColor   = RGB(100, 100, 100)
995:             .BackStyle   = 1
996:             .BorderWidth = 0
997:             .Visible     = .T.
998:         ENDWITH
999: 
1000:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
1001:         WITH loc_oCab.lbl_4c_Sombra
1002:             .Top       = 18
1003:             .Left      = 10
1004:             .Width     = 769
1005:             .Height    = 40
1006:             .AutoSize  = .F.
1007:             .BackStyle = 0
1008:             .WordWrap  = .T.
1009:             .Alignment = 0
1010:             .FontName  = "Tahoma"
1011:             .FontSize  = 18
1012:             .FontBold  = .T.
1013:             .ForeColor = RGB(0, 0, 0)
1014:             .Caption   = THIS.Caption
1015:         ENDWITH
1016: 
1017:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
1018:         WITH loc_oCab.lbl_4c_Titulo
1019:             .Top       = 17
1020:             .Left      = 10
1021:             .Width     = 769
1022:             .Height    = 46
1023:             .AutoSize  = .F.
1024:             .BackStyle = 0
1025:             .WordWrap  = .T.
1026:             .Alignment = 0
1027:             .FontName  = "Tahoma"
1028:             .FontSize  = 18
1029:             .FontBold  = .T.
1030:             .ForeColor = RGB(255, 255, 255)
1031:             .Caption   = THIS.Caption
1032:         ENDWITH
1033:     ENDPROC
1034: 
1035:     *--------------------------------------------------------------------------
1036:     * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles


### BO (C:\4c\projeto\app\classes\sigprcpdBO.prg):
*====================================================================
* sigprcpdBO.prg
*
* Business Object para Formsigprcpd (Capacidade Produtiva)
* Form OPERACIONAL (nao-CRUD): exibe, para um Envelope/Codigo de OP
* (SigCdPcz.codigos) em uma Fase/Setor e Unidade Produtiva, a capacidade
* de producao (minutos totais/utilizados/saldo, agregados a partir de
* SigCdPcp) e a grade de operacoes vinculadas (SigCdPco join SigCdCli),
* rateando o tempo de cada operacao pela proporcao apurada em SigCdPcg.
*
* Tabela principal para efeitos de ObterChavePrimaria/auditoria: SigCdPco
* (cidchaves char(20) - PK). Nao ha INSERT/UPDATE/DELETE no legado: o
* form apenas consulta e exibe - o comportamento padrao herdado de
* BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao) ja eh o
* correto para este BO.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigprcpdBO AS BusinessBase

    *-- Parametros recebidos do form/menu chamador (equivalentes a
    *-- LPARAMETERS pFase, pUnidade, pData, pCodigo do Init legado)
    this_cFases    = ""    && fases char(10) - Setor/Fase de producao
    this_cUniprdts = ""    && uniprdts char(10) - Unidade Produtiva (opcional)
    this_dDatas    = {}    && datas - Data de referencia da capacidade
    this_nCodigos  = 0     && codigos numeric(10,0) - Codigo do Envelope/OP (SigCdPcz)

    *-- Capacidade agregada (Container2: Capacidade/Utilizado/Saldo),
    *-- somada a partir de SigCdPcp para a Fase/Data/Unidade informadas
    this_nMinutos    = 0   && minutos numeric(9,1) - Capacidade total (minutos)
    this_nUtilizados = 0   && utilizados - minutos ja utilizados
    this_nSaldos     = 0   && saldos numeric(8,1) - Saldo disponivel (minutos)

    *-- Detalhe da linha corrente da grade (AfterRowColChange): dados do
    *-- produto e do cliente da operacao selecionada
    this_cCpros = ""    && cpros char(14) - codigo do produto da operacao
    this_cDpros = ""    && dpros - descricao do produto (SigCdPro.Dpros)
    this_nQtds  = 0     && qtds numeric(9,3) - quantidade da operacao
    this_cRclis = ""    && rclis - razao social do cliente (SigCdCli.Rclis)
    this_nTempU = 0     && tempU - tempo total do envelope (minutos)

    *-- Nome do cursor final que alimenta a grade (equivalente ao
    *-- zTmpPcpOp do legado)
    this_cCursorGrade = "cursor_4c_Grade"

    *-- Nome do cursor de detalhe do produto (equivalente ao CrTmpPro do
    *-- legado), populado por ObterDetalheProduto() a cada troca de linha
    this_cCursorProdutoDetalhe = "cursor_4c_ProdutoDetalhe"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPco"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigprcpdBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDados - Carrega a capacidade produtiva e a grade de
    * operacoes de um Envelope/OP (SigCdPcz.codigos), para uma
    * Fase/Setor, Data e (opcionalmente) Unidade Produtiva.
    *
    * Equivalente ao PROCEDURE Init do form legado SIGPRCPD: 4 consultas
    * remotas (validacao do envelope, capacidade agregada, "peso" por
    * envelope/sequencia em SigCdPcg, detalhe das operacoes em SigCdPco
    * + SigCdCli) seguidas de um SELECT local que agrupa o tempo das
    * operacoes por Fase+Unidade+Envelope+Sequencia (restrito as
    * combinacoes que tem "peso" em SigCdPcg) e de um SELECT local final
    * que rateia o tempo total do envelope (SigCdPcg.Minutos) entre as
    * operacoes proporcionalmente ao peso de cada uma.
    *
    * Parametros:
    *   par_cFase    - fases char(10), Setor/Fase de producao (obrigatorio)
    *   par_cUnidade - uniprdts char(10), Unidade Produtiva (opcional)
    *   par_dData    - datas, data de referencia da capacidade (obrigatorio)
    *   par_nCodigo  - codigos numeric(10,0), codigo do Envelope/OP (obrigatorio)
    *
    * Popula: this_nMinutos/this_nUtilizados/this_nSaldos (Container2) e
    * o cursor this_cCursorGrade, com as colunas do legado (nenvs, nops,
    * ordems, cpros, uniprdts, priors, pedido, cliente, rclis, tempu,
    * tempoo, temporeal).
    *
    * Retorno: .T. se sucesso, .F. se falha (mensagem em this_cMensagemErro)
    *====================================================================
    FUNCTION CarregarDados(par_cFase, par_cUnidade, par_dData, par_nCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cFiltroUnid, loc_cCursorGrade

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF VARTYPE(par_cFase) != "C" OR EMPTY(par_cFase) OR ;
                        VARTYPE(par_dData) != "D" OR EMPTY(par_dData) OR ;
                        VARTYPE(par_nCodigo) != "N" OR NVL(par_nCodigo, 0) <= 0
                    THIS.this_cMensagemErro = "Fase, Data e C" + CHR(243) + "digo do Envelope s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
                ELSE
                    THIS.this_cFases    = ALLTRIM(par_cFase)
                    THIS.this_cUniprdts = IIF(VARTYPE(par_cUnidade) = "C", ALLTRIM(par_cUnidade), "")
                    THIS.this_dDatas    = par_dData
                    THIS.this_nCodigos  = par_nCodigo

                    THIS.FecharCursoresTemporarios()

                    loc_cCursorGrade = THIS.this_cCursorGrade
                    loc_cFiltroUnid  = IIF(EMPTY(THIS.this_cUniprdts), "", " AND UniPrdts = " + EscaparSQL(THIS.this_cUniprdts))

                    *-- 1) Valida existencia do Envelope/OP (SigCdPcz)
                    loc_cSQL = "SELECT codigos FROM SigCdPcz WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pcz")

                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Envelope " + TRANSFORM(THIS.this_nCodigos) + " n" + CHR(227) + "o encontrado em SigCdPcz)"
                    ELSE
                        *-- 2) Capacidade agregada (SigCdPcp): Minutos/Utilizados/Saldos
                        loc_cSQL = "SELECT Codigos, SUM(minutos) AS Minutos, SUM(minutos - Saldos) AS Utilizados, SUM(saldos) AS Saldos " + ;
                            "FROM SigCdPcp " + ;
                            "WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                            " AND Datas = " + FormatarDataSQL(THIS.this_dDatas) + ;
                            " AND Fases = " + EscaparSQL(THIS.this_cFases) + ;
                            loc_cFiltroUnid + ;
                            " GROUP BY Codigos"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcpCap")

                        IF loc_nResultado < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Capacidade n" + CHR(227) + "o encontrada em SigCdPcp)"
                        ELSE
                            THIS.this_nMinutos    = NVL(cursor_4c_PcpCap.Minutos, 0)
                            THIS.this_nUtilizados = NVL(cursor_4c_PcpCap.Utilizados, 0)
                            THIS.this_nSaldos     = NVL(cursor_4c_PcpCap.Saldos, 0)

                            *-- 3) "Peso"/tempo total por envelope-sequencia (SigCdPcg)
                            loc_cSQL = "SELECT * FROM SigCdPcg " + ;
                                "WHERE datas = " + FormatarDataSQL(THIS.this_dDatas) + ;
                                " AND fases = " + EscaparSQL(THIS.this_cFases) + ;
                                " AND codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                                loc_cFiltroUnid + ;
                                " ORDER BY cidchaves"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pcg")

                            IF loc_nResultado < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Programa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada em SigCdPcg)"
                            ELSE
                                *-- 4) Detalhe das operacoes (SigCdPco + SigCdCli), com Pedido e
                                *-- Cliente ja concatenados no SQL Server (RTRIM no lugar do STR
                                *-- posicional do legado, que aqui so serve para exibicao)
                                loc_cSQL = "SELECT a.*, " + ;
                                    "RTRIM(a.dopes) + '-' + RIGHT('     ' + CONVERT(VARCHAR(6), a.numes), 6) AS Pedido, " + ;
                                    "RTRIM(a.contas) + '-' + RTRIM(b.rclis) AS Cliente, " + ;
                                    "RTRIM(b.rclis) AS Rclis " + ;
                                    "FROM SigCdPco a INNER JOIN SigCdCli b ON a.contas = b.iclis " + ;
                                    "WHERE a.codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                                    " AND a.fases = " + EscaparSQL(THIS.this_cFases) + ;
                                    IIF(EMPTY(THIS.this_cUniprdts), "", " AND a.uniprdts = " + EscaparSQL(THIS.this_cUniprdts)) + ;
                                    " ORDER BY a.uniprdts, a.seqs, a.nenvs"
                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pco")

                                IF loc_nResultado < 1
                                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o encontradas em SigCdPco)"
                                ELSE
                                    *-- 5) Agrupa localmente o total de minutos por Fase+Unidade+
                                    *-- Envelope+Sequencia, restrito as combinacoes que existem em
                                    *-- SigCdPcg (equivalente ao zTmpPcpOp3 do legado). Chave
                                    *-- POSICIONAL: Fases/UniPrdts sao char(10) nos dois cursores e
                                    *-- STR() fixa a largura dos numericos - NAO fazer ALLTRIM aqui
                                    *-- (regra: chave posicional concatenada quebra em silencio).
                                    SELECT a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, SUM(a.Minutos) AS Minutos ;
                                        FROM cursor_4c_Pco a, cursor_4c_Pcg b ;
                                        WHERE a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            b.Fases + b.UniPrdts + STR(b.Nenvs, 10) + STR(b.Seqs, 2) ;
                                        GROUP BY a.Fases, a.UniPrdts, a.Nenvs, a.Seqs ;
                                        INTO CURSOR cursor_4c_PcoAgrupado READWRITE

                                    *-- 6) Grade final: rateia o tempo total do envelope (b.Minutos)
                                    *-- proporcionalmente ao peso de cada operacao (a.Minutos/c.Minutos).
                                    *-- TempoReal transcreve fStoM((a.minutos*60)/(c.minutos*60)*(b.minutos*60))
                                    *-- do legado (SIGFUNCS.PRG) via ConverterSegundosParaMinutos() -
                                    *-- ver comentario da funcao mais abaixo. Guard IIF(c.Minutos=0,...)
                                    *-- evita erro de divisao por zero que o legado nao previa.
                                    SELECT a.*, b.Minutos AS TempU, c.Minutos AS TempoO, ;
                                        ConverterSegundosParaMinutos(IIF(NVL(c.Minutos, 0) = 0, 0, (a.Minutos * 60) / (c.Minutos * 60) * (b.Minutos * 60))) AS TempoReal ;
                                        FROM cursor_4c_Pco a, cursor_4c_Pcg b, cursor_4c_PcoAgrupado c ;
                                        WHERE a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            b.Fases + b.UniPrdts + STR(b.Nenvs, 10) + STR(b.Seqs, 2) ;
                                          AND a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            c.Fases + c.UniPrdts + STR(c.Nenvs, 10) + STR(c.Seqs, 2) ;
                                        ORDER BY b.Ordems, a.UniPrdts, a.Seqs, a.Nenvs ;
                                        INTO CURSOR (loc_cCursorGrade) READWRITE

                                    loc_lSucesso = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterDetalheProduto - Busca descricao e imagem (base64) do produto
    * de uma linha da grade (SigCdPro), para exibicao ao trocar a linha
    * selecionada. Equivalente a parte de consulta do AfterRowColChange
    * do legado - decodificar o base64 e gravar o JPG em disco eh
    * responsabilidade do Form (camada de UI), nao do BO.
    *
    * Parametro: par_cCpros - cpros char(14), codigo do produto
    * Popula: cursor this_cCursorProdutoDetalhe (colunas Dpros, FigJpgs)
    * Retorno: .T. se encontrou o produto, .F. caso contrario
    *====================================================================
    FUNCTION ObterDetalheProduto(par_cCpros)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF VARTYPE(par_cCpros) != "C" OR EMPTY(par_cCpros)
                    THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado."
                ELSE
                    IF USED(THIS.this_cCursorProdutoDetalhe)
                        USE IN (THIS.this_cCursorProdutoDetalhe)
                    ENDIF

                    loc_cSQL = "SELECT FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + EscaparSQL(ALLTRIM(par_cCpros))
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProdutoDetalhe)

                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Produto " + ALLTRIM(par_cCpros) + " n" + CHR(227) + "o encontrado em SigCdPro."
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ObterDetalheProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega o detalhe da LINHA CORRENTE da grade
    * para as propriedades do BO. Equivalente a parte de LEITURA do
    * AfterRowColChange do form legado SIGPRCPD (dump, linhas 1231-1240):
    *     ThisForm.Get_descr.Value   = CrTmpPro.Dpros
    *     ThisForm.Get_qtde.Value    = zTmpPcpOp.Qtds
    *     ThisForm.Get_cliente.Value = zTmpPcpOp.Rclis
    *     ThisForm.Get_tEnv.Value    = zTmpPcpOp.TempU
    * O legado termina o handler com "Select zTmpPcpOp" - reproduzido aqui
    * pelo SELECT (loc_cAlias), para a area de trabalho corrente continuar
    * sendo a da grade quando o metodo retorna (o SQLEXEC do lookup de
    * produto troca a area corrente no meio do caminho).
    *
    * Metodo PUBLIC de proposito: quem chama eh o handler de
    * AfterRowColChange do Form, de FORA da classe. PROTECTED falharia em
    * runtime com "Property CARREGARDOCURSOR is not found", e o
    * PEMSTATUS(oBO, "CarregarDoCursor", 5) que costuma cercar a chamada
    * devolveria .T. sem proteger (so verifica existencia, nao escopo).
    *
    * Parametro: par_cAliasCursor - alias do cursor da grade. Omitido ou
    *            vazio, assume THIS.this_cCursorGrade.
    * Popula: this_cCpros, this_nQtds, this_cRclis, this_nTempU (da linha
    *         corrente da grade) e this_cDpros (lookup em SigCdPro).
    * Retorno: .T. se a linha foi lida - inclusive grade VAZIA, que apenas
    *          limpa o detalhe; .F. so se o cursor da grade nao existe.
    *
    * NOTA sobre retorno .T. com this_cMensagemErro preenchido: falha
    * APENAS no lookup da descricao do produto NAO invalida a leitura da
    * linha. Nesse caso this_cDpros fica vazio, a mensagem eh PRESERVADA
    * para o caller exibir se quiser, e o retorno continua .T.
    *====================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                ALLTRIM(par_cAliasCursor), THIS.this_cCursorGrade)

            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
            ELSE
                SELECT (loc_cAlias)

                THIS.LimparDetalhe()

                IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
                    *-- Grade sem linha posicionada: o detalhe fica limpo. O
                    *-- legado nunca chega aqui, porque a grade so dispara
                    *-- AfterRowColChange com uma linha valida selecionada.
                    loc_lSucesso = .T.
                ELSE
                    *-- Leitura por EVALUATE com guarda de TYPE() != "U": coluna
                    *-- ausente no cursor estouraria "Variable X is not found"
                    *-- em RUNTIME, compilando limpo. TratarNulo cobre o valor
                    *-- NULL (2o argumento eh o valor PADRAO, nao codigo de tipo).
                    *-- Tipos conferidos em docs\schema.sql (SigCdPco):
                    *-- cpros char(14), qtds numeric(9,3); Rclis vem do
                    *-- RTRIM(b.rclis) e TempU do SigCdPcg.Minutos numeric(9,1).
                    IF TYPE(loc_cAlias + ".Cpros") != "U"
                        THIS.this_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Cpros"), ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".Qtds") != "U"
                        THIS.this_nQtds = TratarNulo(EVALUATE(loc_cAlias + ".Qtds"), 0)
                    ENDIF

                    IF TYPE(loc_cAlias + ".Rclis") != "U"
                        THIS.this_cRclis = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Rclis"), ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".TempU") != "U"
                        THIS.this_nTempU = TratarNulo(EVALUATE(loc_cAlias + ".TempU"), 0)
                    ENDIF

                    *-- Descricao do produto (SigCdPro.Dpros), como o legado faz
                    *-- inline no AfterRowColChange. O cursor de detalhe fica
                    *-- disponivel para o Form ler FigJpgs e gerar o JPG (a
                    *-- decodificacao base64 eh responsabilidade da UI).
                    IF !EMPTY(THIS.this_cCpros)
                        IF THIS.ObterDetalheProduto(THIS.this_cCpros)
                            IF TYPE(THIS.this_cCursorProdutoDetalhe + ".Dpros") != "U"
                                THIS.this_cDpros = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorProdutoDetalhe + ".Dpros"), ""))
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Repoe a grade como area corrente (o SQLEXEC do lookup
                    *-- selecionou o cursor de detalhe) - "Select zTmpPcpOp".
                    IF USED(loc_cAlias)
                        SELECT (loc_cAlias)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * LimparDetalhe - Zera as propriedades de detalhe da linha (produto,
    * quantidade, cliente e tempo do envelope). Usado no inicio de
    * CarregarDoCursor e quando a grade nao tem linha posicionada, para o
    * painel inferior nao exibir o detalhe da linha ANTERIOR.
    *
    * PUBLIC de proposito: o Form tambem limpa o painel ao recarregar a
    * grade (chamada de FORA da classe - mesma razao de CarregarDoCursor).
    *====================================================================
    PROCEDURE LimparDetalhe()
        THIS.this_cCpros = ""
        THIS.this_cDpros = ""
        THIS.this_nQtds  = 0
        THIS.this_cRclis = ""
        THIS.this_nTempU = 0
    ENDPROC

    *====================================================================
    * FecharCursoresTemporarios - Fecha os cursores intermediarios desta
    * consulta antes de recarregar (evita "Table buffer contains
    * uncommitted changes" numa segunda chamada a CarregarDados).
    *====================================================================
    PROTECTED PROCEDURE FecharCursoresTemporarios()
        LOCAL loc_cLista, loc_nI, loc_cNome

        loc_cLista = "cursor_4c_Pcz,cursor_4c_PcpCap,cursor_4c_Pcg,cursor_4c_Pco," + ;
            "cursor_4c_PcoAgrupado," + THIS.this_cCursorGrade

        FOR loc_nI = 1 TO OCCURS(",", loc_cLista) + 1
            loc_cNome = ALLTRIM(GETWORDNUM(loc_cLista, loc_nI, ","))
            IF !EMPTY(loc_cNome) AND USED(loc_cNome)
                USE IN (loc_cNome)
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Este BO eh somente-consulta (form legado
    * SIGPRCPD nao tem INSERT/UPDATE/DELETE - o comportamento padrao
    * herdado de BusinessBase, que recusa Inserir/Atualizar/
    * ExecutarExclusao, ja eh o correto). Metodo mantido apenas por
    * padrao arquitetural; chave conceitual eh o codigo do Envelope/OP.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDPROC

ENDDEFINE

*====================================================================
* ConverterSegundosParaMinutos - Converte um valor em SEGUNDOS para o
* formato decimal Minutos.Segundos (ex.: 755 segundos -> 12.35, ou
* seja, 12 minutos e 35 segundos), usado na coluna "Minutos" da grade
* (Column4, InputMask "9999.99").
*
* Transcricao literal de Function fStoM(pHor) em SIGFUNCS.PRG (Framework
* legado Fortyus, C:\4install\FortyusMC\Fortyus\SIGFUNCS.PRG:188-190):
*   Return Round(Int(pHor/60) + Abs(pHor-(Int(pHor/60)*60))/100, 2)
* Nome novo por exigencia do PILAR 3 - contrato numerico identico ao
* original (mesma entrada/saida para qualquer valor).
*
* Funcao GLOBAL (fora do DEFINE CLASS) para poder ser chamada por nome
* dentro da lista de colunas de um SELECT VFP local, igual ao fStoM(...)
* do legado - config.prg carrega este .prg via ADIR (*BO.prg) e a torna
* disponivel no PATH de procedures do sistema.
*====================================================================
FUNCTION ConverterSegundosParaMinutos(par_nSegundos)
    LOCAL loc_nMinutos

    IF VARTYPE(par_nSegundos) != "N"
        RETURN 0
    ENDIF

    loc_nMinutos = INT(par_nSegundos / 60)
    RETURN ROUND(loc_nMinutos + ABS(par_nSegundos - (loc_nMinutos * 60)) / 100, 2)
ENDFUNC

