# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 219: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 247: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 271: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprite.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1578 linhas total):

*-- Linhas 90 a 98:
90:             THIS.this_cArquivoTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
91: 
92:             *-- Titulo do form: "Empresa - Operacao - Numero - Itens"
93:             THIS.Caption = THIS.this_cEmp + " - " + THIS.this_cDop + " - " + ;
94:                            ALLTRIM(STR(THIS.this_nNum, 6)) + " - Itens"
95: 
96:             *-- Inicializar cursores no BO
97:             THIS.this_oBusinessObject.InicializarCursores()
98: 

*-- Linhas 150 a 225:
150:     PROTECTED PROCEDURE ConfigurarCabecalho()
151:         THIS.AddObject("cnt_4c_Sombra", "Container")
152:         WITH THIS.cnt_4c_Sombra
153:             .Top         = 0
154:             .Left        = 0
155:             .Width       = THIS.Width
156:             .Height      = 80
157:             .BackColor   = RGB(100, 100, 100)
158:             .BorderWidth = 0
159:             .Visible     = .T.
160: 
161:             .AddObject("lbl_4c_Sombra", "Label")
162:             WITH .lbl_4c_Sombra
163:                 .Top           = 18
164:                 .Left          = 10
165:                 .AutoSize      = .F.
166:                 .Width         = THIS.Width
167:                 .Height        = 40
168:                 .FontBold      = .T.
169:                 .FontName      = "Tahoma"
170:                 .FontSize      = 18
171:                 .FontUnderline = .F.
172:                 .BackStyle     = 0
173:                 .WordWrap      = .T.
174:                 .Alignment     = 0
175:                 .ForeColor     = RGB(0, 0, 0)
176:                 .Caption       = THIS.Caption
177:                 .Visible       = .T.
178:             ENDWITH
179: 
180:             .AddObject("lbl_4c_Titulo", "Label")
181:             WITH .lbl_4c_Titulo
182:                 .Top           = 17
183:                 .Left          = 10
184:                 .AutoSize      = .F.
185:                 .Width         = THIS.Width
186:                 .Height        = 46
187:                 .FontBold      = .T.
188:                 .FontName      = "Tahoma"
189:                 .FontSize      = 18
190:                 .BackStyle     = 0
191:                 .WordWrap      = .T.
192:                 .Alignment     = 0
193:                 .ForeColor     = RGB(255, 255, 255)
194:                 .Caption       = THIS.Caption
195:                 .ToolTipText   = "T" + CHR(237) + "tulo do Formul" + CHR(225) + "rio"
196:                 .Visible       = .T.
197:             ENDWITH
198:         ENDWITH
199:     ENDPROC
200: 
201:     *==========================================================================
202:     * ConfigurarBotoesAcao - Botoes de acao: Encerrar, Subniveis, Entrega
203:     *==========================================================================
204:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
205:         *-- Botao Encerrar (cmdsair original - Top=3, Left=725 no legado 800px)
206:         *-- Proporcional para 1000px: Left = 917 (padrao canonico)
207:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
208:         WITH THIS.cmd_4c_Encerrar
209:             .Top            = 3
210:             .Left           = 917
211:             .Width          = 75
212:             .Height         = 75
213:             .Caption        = "Encerrar"
214:             .Cancel         = .T.
215:             .ToolTipText    = "[Esc] Encerrar"
216:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
217:             .FontBold       = .T.
218:             .FontItalic     = .T.
219:             .FontName       = "Comic Sans MS"
220:             .FontSize       = 8
221:             .ForeColor      = RGB(90, 90, 90)
222:             .BackColor      = RGB(255, 255, 255)
223:             .Themes           = .T.
224:             .SpecialEffect  = 0
225:             .PicturePosition = 13

*-- Linhas 234 a 277:
234:         *-- Legado original Left=691 em form 800px - manter proporcao em 1000px: Left=891-200=691
235:         *-- Na verdade o form nao tem pageframe entao manteremos os valores originais
236:         *-- O form operacional nao usa PageFrame, entao nao ha compensacao de Top
237:         THIS.AddObject("cmd_4c_Subniveis", "CommandButton")
238:         WITH THIS.cmd_4c_Subniveis
239:             .Top            = 460
240:             .Left           = 691
241:             .Width          = 75
242:             .Height         = 75
243:             .Caption        = "\<Subniveis"
244:             .Picture        = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
245:             .FontBold       = .T.
246:             .FontItalic     = .T.
247:             .FontName       = "Comic Sans MS"
248:             .FontSize       = 8
249:             .ForeColor      = RGB(90, 90, 90)
250:             .BackColor      = RGB(255, 255, 255)
251:             .Themes           = .T.
252:             .SpecialEffect  = 0
253:             .PicturePosition = 13
254:             .MousePointer   = 15
255:             .WordWrap       = .T.
256:             .AutoSize       = .F.
257:             .Visible        = .T.
258:         ENDWITH
259: 
260:         *-- Botao Entrega (Top=460, Left=616 no legado)
261:         THIS.AddObject("cmd_4c_Entrega", "CommandButton")
262:         WITH THIS.cmd_4c_Entrega
263:             .Top            = 460
264:             .Left           = 616
265:             .Width          = 75
266:             .Height         = 75
267:             .Caption        = "\<Entrega"
268:             .Picture        = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
269:             .FontBold       = .T.
270:             .FontItalic     = .T.
271:             .FontName       = "Comic Sans MS"
272:             .FontSize       = 8
273:             .ForeColor      = RGB(90, 90, 90)
274:             .BackColor      = RGB(255, 255, 255)
275:             .Themes           = .T.
276:             .SpecialEffect  = 0
277:             .PicturePosition = 13

*-- Linhas 289 a 337:
289:         *-- shpProdutos: borda ao redor da area de grids (Top=113, Left=21)
290:         THIS.AddObject("shp_4c_Produtos", "Shape")
291:         WITH THIS.shp_4c_Produtos
292:             .Top         = 113
293:             .Left        = 21
294:             .Height      = 320
295:             .Width       = 757
296:             .BackStyle   = 0
297:             .BorderColor = RGB(90, 90, 90)
298:             .Visible     = .T.
299:         ENDWITH
300: 
301:         *-- Shape5: borda ao redor da area de descricao/observacao (Top=438)
302:         THIS.AddObject("shp_4c_Descricao", "Shape")
303:         WITH THIS.shp_4c_Descricao
304:             .Top         = 438
305:             .Left        = 21
306:             .Height      = 121
307:             .Width       = 584
308:             .BackStyle   = 0
309:             .Curvature   = 0
310:             .BackColor   = RGB(255, 255, 255)
311:             .BorderColor = RGB(90, 90, 90)
312:             .Visible     = .T.
313:         ENDWITH
314: 
315:         *-- Shape1: borda ao redor do botao Encerrar
316:         THIS.AddObject("shp_4c_CmdSair", "Shape")
317:         WITH THIS.shp_4c_CmdSair
318:             .Top         = 7
319:             .Left        = 917
320:             .Height      = 110
321:             .Width       = 90
322:             .BackStyle   = 0
323:             .BorderStyle = 0
324:             .BorderColor = RGB(136, 189, 188)
325:             .Visible     = .T.
326:         ENDWITH
327: 
328:         *-- shpDisps: indicador visual de disponibilidade (pequeno quadrado)
329:         THIS.AddObject("shp_4c_Disps", "Shape")
330:         WITH THIS.shp_4c_Disps
331:             .Top          = 441
332:             .Left         = 254
333:             .Height       = 14
334:             .Width        = 14
335:             .BackStyle    = 1
336:             .SpecialEffect = 0
337:             .BackColor    = RGB(255, 255, 187)

*-- Linhas 345 a 354:
345:     PROTECTED PROCEDURE ConfigurarGrdCabec()
346:         THIS.AddObject("grd_4c_Cabec", "Grid")
347:         WITH THIS.grd_4c_Cabec
348:             .Top              = 118
349:             .Left             = 26
350:             .Width            = 731
351:             .Height           = 35
352:             .ColumnCount      = 4
353:             .FontName         = "Arial"
354:             .AllowHeaderSizing = .F.

*-- Linhas 373 a 381:
373:                     .FontName   = "Tahoma"
374:                     .FontSize   = 8
375:                     .Alignment  = 2
376:                     .Caption    = "Produto"
377:                 ENDWITH
378:                 WITH .Text1
379:                     .FontName   = "Arial"
380:                     .BorderStyle = 0
381:                     .Margin     = 0

*-- Linhas 396 a 404:
396:                     .FontName   = "Tahoma"
397:                     .FontSize   = 8
398:                     .Alignment  = 2
399:                     .Caption    = ""
400:                 ENDWITH
401:                 WITH .Text1
402:                     .FontName   = "Arial"
403:                     .BorderStyle = 0
404:                     .Margin     = 0

*-- Linhas 419 a 427:
419:                     .FontName   = "Tahoma"
420:                     .FontSize   = 8
421:                     .Alignment  = 2
422:                     .Caption    = "Quantidade"
423:                 ENDWITH
424:                 WITH .Text1
425:                     .BorderStyle = 0
426:                     .Margin     = 0
427:                     .ForeColor  = RGB(0, 0, 0)

*-- Linhas 440 a 448:
440:                     .FontName   = "Tahoma"
441:                     .FontSize   = 8
442:                     .Alignment  = 2
443:                     .Caption    = "Valor"
444:                 ENDWITH
445:                 WITH .Text1
446:                     .BorderStyle = 0
447:                     .Margin     = 0
448:                     .ForeColor  = RGB(0, 0, 0)

*-- Linhas 462 a 471:
462:     PROTECTED PROCEDURE ConfigurarGrdItens()
463:         THIS.AddObject("grd_4c_Itens", "Grid")
464:         WITH THIS.grd_4c_Itens
465:             .Top              = 135
466:             .Left             = 26
467:             .Width            = 750
468:             .Height           = 275
469:             .ColumnCount      = 11
470:             .FontName         = "Arial"
471:             .AllowHeaderSizing = .F.

*-- Linhas 492 a 500:
492:                     .FontName   = "Tahoma"
493:                     .FontSize   = 8
494:                     .Alignment  = 2
495:                     .Caption    = ""
496:                 ENDWITH
497:                 WITH .Text1
498:                     .FontName   = "Courier New"
499:                     .BorderStyle = 0
500:                     .Margin     = 0

*-- Linhas 514 a 522:
514:                     .FontName   = "Tahoma"
515:                     .FontSize   = 8
516:                     .Alignment  = 2
517:                     .Caption    = "Produto"
518:                 ENDWITH
519:                 WITH .Text1
520:                     .FontName   = "Courier New"
521:                     .BorderStyle = 0
522:                     .Margin     = 0

*-- Linhas 537 a 545:
537:                     .FontName   = "Tahoma"
538:                     .FontSize   = 8
539:                     .Alignment  = 2
540:                     .Caption    = "Unidade"
541:                 ENDWITH
542:                 WITH .Text1
543:                     .FontName   = "Courier New"
544:                     .BorderStyle = 0
545:                     .Margin     = 0

*-- Linhas 559 a 567:
559:                     .FontName   = "Tahoma"
560:                     .FontSize   = 8
561:                     .Alignment  = 2
562:                     .Caption    = "Volume"
563:                 ENDWITH
564:                 WITH .Text1
565:                     .FontName   = "Courier New"
566:                     .BorderStyle = 0
567:                     .Margin     = 0

*-- Linhas 582 a 590:
582:                     .FontName   = "Tahoma"
583:                     .FontSize   = 8
584:                     .Alignment  = 2
585:                     .Caption    = "O"
586:                 ENDWITH
587:                 WITH .Text1
588:                     .FontBold   = .T.
589:                     .Alignment  = 2
590:                     .FontName   = "Courier New"

*-- Linhas 606 a 614:
606:                     .FontName   = "Tahoma"
607:                     .FontSize   = 8
608:                     .Alignment  = 2
609:                     .Caption    = "Original"
610:                 ENDWITH
611:                 WITH .Text1
612:                     .FontName   = "Courier New"
613:                     .BorderStyle = 0
614:                     .Margin     = 0

*-- Linhas 628 a 636:
628:                     .FontName   = "Tahoma"
629:                     .FontSize   = 8
630:                     .Alignment  = 2
631:                     .Caption    = "Baixada"
632:                 ENDWITH
633:                 WITH .Text1
634:                     .FontName   = "Courier New"
635:                     .BorderStyle = 0
636:                     .Margin     = 0

*-- Linhas 650 a 658:
650:                     .FontName   = "Tahoma"
651:                     .FontSize   = 8
652:                     .Alignment  = 2
653:                     .Caption    = "Saldo"
654:                 ENDWITH
655:                 WITH .Text1
656:                     .FontName   = "Courier New"
657:                     .BorderStyle = 0
658:                     .Margin     = 0

*-- Linhas 672 a 680:
672:                     .FontName   = "Tahoma"
673:                     .FontSize   = 8
674:                     .Alignment  = 2
675:                     .Caption    = "Unit" + CHR(225) + "rio"
676:                 ENDWITH
677:                 WITH .Text1
678:                     .FontName   = "Courier New"
679:                     .BorderStyle = 0
680:                     .Margin     = 0

*-- Linhas 693 a 701:
693:                     .FontName   = "Tahoma"
694:                     .FontSize   = 8
695:                     .Alignment  = 2
696:                     .Caption    = "Moeda"
697:                 ENDWITH
698:                 WITH .Text1
699:                     .FontName   = "Courier New"
700:                     .BorderStyle = 0
701:                     .Margin     = 0

*-- Linhas 715 a 723:
715:                     .FontName   = "Tahoma"
716:                     .FontSize   = 8
717:                     .Alignment  = 2
718:                     .Caption    = "Valor Total"
719:                 ENDWITH
720:                 WITH .Text1
721:                     .FontName   = "Courier New"
722:                     .BorderStyle = 0
723:                     .Margin     = 0

*-- Linhas 740 a 762:
740:     *==========================================================================
741:     PROTECTED PROCEDURE ConfigurarPaginaDados()
742:         *-- Label "Descricao Produto"
743:         THIS.AddObject("lbl_4c_DescricaoPro", "Label")
744:         WITH THIS.lbl_4c_DescricaoPro
745:             .Top        = 440
746:             .Left       = 30
747:             .FontSize   = 8
748:             .Caption    = "Descri" + CHR(231) + CHR(227) + "o Produto"
749:             .ForeColor  = RGB(90, 90, 90)
750:             .Visible    = .T.
751:         ENDWITH
752: 
753:         *-- TextBox somente-leitura para descricao do produto (Get_descr original)
754:         THIS.AddObject("txt_4c_Descr", "TextBox")
755:         WITH THIS.txt_4c_Descr
756:             .Top                  = 456
757:             .Left                 = 30
758:             .Width                = 396
759:             .Height               = 23
760:             .FontName             = "Tahoma"
761:             .FontSize             = 8
762:             .ControlSource        = "cursor_4c_Itens.DPros"

*-- Linhas 770 a 792:
770:         ENDWITH
771: 
772:         *-- Label "Observacao Produto"
773:         THIS.AddObject("lbl_4c_ObsPro", "Label")
774:         WITH THIS.lbl_4c_ObsPro
775:             .Top        = 481
776:             .Left       = 30
777:             .FontSize   = 8
778:             .Caption    = "Observa" + CHR(231) + CHR(227) + "o Produto"
779:             .ForeColor  = RGB(90, 90, 90)
780:             .Visible    = .T.
781:         ENDWITH
782: 
783:         *-- EditBox somente-leitura para observacao (Get_obs original)
784:         THIS.AddObject("txt_4c_Obs", "EditBox")
785:         WITH THIS.txt_4c_Obs
786:             .Top           = 496
787:             .Left          = 30
788:             .Width         = 396
789:             .Height        = 57
790:             .FontName      = "Tahoma"
791:             .FontSize      = 8
792:             .ControlSource = "cursor_4c_Itens.Obs"

*-- Linhas 798 a 835:
798:         ENDWITH
799: 
800:         *-- Label de disponibilidade do produto (so visivel se pDis=.T.)
801:         THIS.AddObject("lbl_4c_Disps", "Label")
802:         WITH THIS.lbl_4c_Disps
803:             .Top        = 441
804:             .Left       = 270
805:             .FontSize   = 8
806:             .Caption    = "Disponibilidade do Produto"
807:             .ForeColor  = RGB(90, 90, 90)
808:             .Visible    = THIS.this_lChecaDisps
809:         ENDWITH
810: 
811:         *-- Imagem do produto (inicialmente oculta, exibida por AfterRowColChange)
812:         THIS.AddObject("img_4c_FigJpg", "Image")
813:         WITH THIS.img_4c_FigJpg
814:             .Stretch    = 1
815:             .Top        = 443
816:             .Left       = 433
817:             .Width      = 166
818:             .Height     = 111
819:             .Visible    = .F.
820:         ENDWITH
821:     ENDPROC
822: 
823:     *==========================================================================
824:     * ConfigurarGrdRodape - Grid de rodape com totais por moeda (11 colunas)
825:     *==========================================================================
826:     PROTECTED PROCEDURE ConfigurarGrdRodape()
827:         THIS.AddObject("grd_4c_Rodape", "Grid")
828:         WITH THIS.grd_4c_Rodape
829:             .Top              = 404
830:             .Left             = 26
831:             .Width            = 749
832:             .Height           = 25
833:             .ColumnCount      = 11
834:             .FontName         = "Arial"
835:             .AllowHeaderSizing = .F.

*-- Linhas 855 a 863:
855:                     .FontName   = "Tahoma"
856:                     .FontSize   = 8
857:                     .Alignment  = 2
858:                     .Caption    = ""
859:                     .BackColor  = RGB(255, 255, 0)
860:                 ENDWITH
861:                 WITH .Text1
862:                     .FontName   = "Courier New"
863:                     .BorderStyle = 0

*-- Linhas 879 a 887:
879:                     .FontName   = "Arial"
880:                     .FontSize   = 8
881:                     .Alignment  = 2
882:                     .Caption    = ""
883:                     .BackColor  = RGB(255, 255, 0)
884:                 ENDWITH
885:                 WITH .Text1
886:                     .FontName   = "Courier New"
887:                     .BorderStyle = 0

*-- Linhas 902 a 910:
902:                 WITH .Header1
903:                     .FontSize   = 8
904:                     .Alignment  = 2
905:                     .Caption    = ""
906:                     .BackColor  = RGB(255, 255, 0)
907:                 ENDWITH
908:                 WITH .Text1
909:                     .FontName   = "Courier New"
910:                     .BorderStyle = 0

*-- Linhas 925 a 933:
925:                 WITH .Header1
926:                     .FontSize   = 8
927:                     .Alignment  = 2
928:                     .Caption    = ""
929:                     .BackColor  = RGB(255, 255, 0)
930:                 ENDWITH
931:                 WITH .Text1
932:                     .FontName   = "Courier New"
933:                     .BorderStyle = 0

*-- Linhas 947 a 955:
947:                 WITH .Header1
948:                     .FontSize   = 8
949:                     .Alignment  = 2
950:                     .Caption    = ""
951:                     .BackColor  = RGB(255, 255, 0)
952:                 ENDWITH
953:                 WITH .Text1
954:                     .FontName   = "Courier New"
955:                     .BorderStyle = 0

*-- Linhas 970 a 978:
970:                 WITH .Header1
971:                     .FontSize   = 8
972:                     .Alignment  = 2
973:                     .Caption    = ""
974:                     .BackColor  = RGB(255, 255, 0)
975:                 ENDWITH
976:                 WITH .Text1
977:                     .FontName   = "Courier New"
978:                     .BorderStyle = 0

*-- Linhas 993 a 1001:
993:                 WITH .Header1
994:                     .FontSize   = 8
995:                     .Alignment  = 2
996:                     .Caption    = ""
997:                     .BackColor  = RGB(255, 255, 0)
998:                 ENDWITH
999:                 WITH .Text1
1000:                     .FontName   = "Courier New"
1001:                     .BorderStyle = 0

*-- Linhas 1016 a 1024:
1016:                 WITH .Header1
1017:                     .FontSize   = 8
1018:                     .Alignment  = 2
1019:                     .Caption    = ""
1020:                     .BackColor  = RGB(255, 255, 0)
1021:                 ENDWITH
1022:                 WITH .Text1
1023:                     .FontName   = "Courier New"
1024:                     .BorderStyle = 0

*-- Linhas 1038 a 1046:
1038:                 WITH .Header1
1039:                     .FontSize   = 8
1040:                     .Alignment  = 2
1041:                     .Caption    = ""
1042:                     .BackColor  = RGB(255, 255, 0)
1043:                 ENDWITH
1044:                 WITH .Text1
1045:                     .FontName   = "Courier New"
1046:                     .BorderStyle = 0

*-- Linhas 1060 a 1068:
1060:                 WITH .Header1
1061:                     .FontSize   = 8
1062:                     .Alignment  = 2
1063:                     .Caption    = ""
1064:                     .BackColor  = RGB(255, 255, 0)
1065:                 ENDWITH
1066:                 WITH .Text1
1067:                     .FontName   = "Courier New"
1068:                     .BorderStyle = 0

*-- Linhas 1083 a 1091:
1083:                 WITH .Header1
1084:                     .FontSize   = 8
1085:                     .Alignment  = 2
1086:                     .Caption    = ""
1087:                     .BackColor  = RGB(255, 255, 0)
1088:                 ENDWITH
1089:                 WITH .Text1
1090:                     .FontName   = "Courier New"
1091:                     .BorderStyle = 0

*-- Linhas 1138 a 1151:
1138:             loc_oCtrl = THIS.Controls(loc_i)
1139:             IF VARTYPE(loc_oCtrl) = "O"
1140:                 *-- img_4c_FigJpg inicia oculta (gerenciada por AfterRowColChange)
1141:                 *-- shp_4c_Disps e lbl_4c_Disps dependem de this_lChecaDisps
1142:                 IF UPPER(loc_oCtrl.Name) = "IMG_4C_FIGJPG"
1143:                     LOOP
1144:                 ENDIF
1145:                 IF UPPER(loc_oCtrl.Name) = "SHP_4C_DISPS" OR ;
1146:                    UPPER(loc_oCtrl.Name) = "LBL_4C_DISPS"
1147:                     loc_oCtrl.Visible = THIS.this_lChecaDisps
1148:                     LOOP
1149:                 ENDIF
1150:                 IF UPPER(loc_oCtrl.Name) = "CNT_4C_SOMBRA"
1151:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0

*-- Linhas 1176 a 1190:
1176:     *==========================================================================
1177:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
1178:         *-- Encerrar
1179:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
1180: 
1181:         *-- Subniveis
1182:         BINDEVENT(THIS.cmd_4c_Subniveis, "Click", THIS, "CmdSubniveisClick")
1183: 
1184:         *-- Entrega
1185:         BINDEVENT(THIS.cmd_4c_Entrega, "Click", THIS, "CmdEntregaClick")
1186: 
1187:         *-- Grid itens: mudar linha atualiza imagem e descricao
1188:         BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", THIS, "GrdItensAfterRowColChange")
1189: 
1190:         *-- Duplo clique no produto abre consulta de produto

*-- Linhas 1472 a 1498:
1472:     * AjustarBotoesPorModo - Form viewer nao tem modos CRUD; sem alteracao
1473:     *==========================================================================
1474:     PROCEDURE AjustarBotoesPorModo()
1475:         IF VARTYPE(THIS.cmd_4c_Subniveis) = "O"
1476:             THIS.cmd_4c_Subniveis.Enabled = .T.
1477:         ENDIF
1478:         IF VARTYPE(THIS.cmd_4c_Entrega) = "O"
1479:             THIS.cmd_4c_Entrega.Enabled = .T.
1480:         ENDIF
1481:     ENDPROC
1482: 
1483:     *==========================================================================
1484:     * HabilitarCampos - Todos os controles sao somente-leitura neste viewer
1485:     *==========================================================================
1486:     PROCEDURE HabilitarCampos(par_lHabilitar)
1487:         LOCAL loc_lAtivo
1488:         loc_lAtivo = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1489:         IF VARTYPE(THIS.cmd_4c_Subniveis) = "O"
1490:             THIS.cmd_4c_Subniveis.Enabled = loc_lAtivo
1491:         ENDIF
1492:         IF VARTYPE(THIS.cmd_4c_Entrega) = "O"
1493:             THIS.cmd_4c_Entrega.Enabled = loc_lAtivo
1494:         ENDIF
1495:     ENDPROC
1496: 
1497:     *==========================================================================
1498:     * LimparCampos - Limpa os cursores e reseta a exibicao visual

*-- Linhas 1537 a 1550:
1537:     * eh feito diretamente em CarregarItens/AlternarPagina.
1538:     *==========================================================================
1539:     PROCEDURE BOParaForm()
1540:         THIS.Caption = THIS.this_oBusinessObject.this_cEmp + " - " + ;
1541:                        THIS.this_oBusinessObject.this_cDop + " - " + ;
1542:                        ALLTRIM(STR(THIS.this_oBusinessObject.this_nNum, 6)) + " - Itens"
1543:         IF VARTYPE(THIS.cnt_4c_Sombra) = "O"
1544:             THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
1545:             THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
1546:         ENDIF
1547:     ENDPROC
1548: 
1549:     *==========================================================================
1550:     PROCEDURE Destroy()


### BO (C:\4c\projeto\app\classes\sigpriteBO.prg):
*==============================================================================
* sigpriteBO.prg - Business Object para SIGPRITE (Itens de Ordem de Producao)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (consulta de itens de OP - somente leitura)
*==============================================================================

DEFINE CLASS sigpriteBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros de contexto da OP
    *--------------------------------------------------------------------------
    this_cEmp        = ""    && Empresa (char 3)
    this_cDop        = ""    && Operacao/Documento (char 20)
    this_nNum        = 0     && Numero da OP (numeric 6,0)
    this_cEmpDopNum  = ""    && Chave concatenada: PADR(cEmp,3)+PADR(cDop,20)+STR(nNum,6) = char 29
    this_lChecaDisps = .F.   && Flag: verificar disponibilidade do produto

    *--------------------------------------------------------------------------
    * Item corrente (linha selecionada em grd_4c_Itens)
    *--------------------------------------------------------------------------
    this_nCItens  = 0     && Sequencial do item (numeric 10,0)
    this_cCPros   = ""    && Codigo produto (char 14)
    this_cDPros   = ""    && Descricao produto (char 65)
    this_cObs     = ""    && Observacao (text)
    this_cCUnis   = ""    && Unidade (char 3)
    this_nVolumes = 0     && Volume (numeric 3,0)
    this_cOpers   = ""    && Tipo operacao (char 1)
    this_nQtdOs   = 0     && Quantidade original/SigMvItn.Qtds (numeric 9,3)
    this_nQtdBs   = 0     && Quantidade baixada/SigMvItn.QtBaixas (numeric 9,3)
    this_nQtdSs   = 0     && Quantidade saldo calculada (Qtds - QtBaixas)
    this_nUnits   = 0     && Preco unitario/SigMvItn.Units (numeric 15,6)
    this_cCMoes   = ""    && Codigo moeda/SigMvItn.Moedas (char 3)
    this_nTotas   = 0     && Valor total/SigMvItn.Totas (numeric 11,2)
    this_nDisps   = 0     && Disponibilidade do produto (numeric 9,3)

    *--------------------------------------------------------------------------
    * Controle interno
    *--------------------------------------------------------------------------
    this_cArquivo  = ""    && Caminho arquivo temporario para imagem do produto
    this_nImagems  = 0     && SigCdOpe.Imagems: 1=exibir foto produto, 0=nao

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        THIS.this_cTabela     = "SigMvItn"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROCEDURE InicializarCursores()
    *==========================================================================
        SET NULL ON
        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Itens (CItens n(10), CPros c(14), DPros c(40), ;
                Obs m(4), CUnis c(3), Volumes n(3), Opers c(1), ;
                QtdOs n(10,3), QtdBs n(10,3), QtdSs n(10,3), ;
                Units n(12,2), CMoes c(3), Totas n(12,2), Disps n(10,3))
        ENDIF
        IF USED("cursor_4c_Rodape")
            SELECT cursor_4c_Rodape
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Rodape (CPros c(14), Volumes n(3), ;
                QtdOs n(10,3), QtdBs n(10,3), QtdSs n(10,3), ;
                CMoes c(3), Totas n(12,2))
        ENDIF
        SET NULL OFF
    ENDPROC

    *==========================================================================
    PROCEDURE BuscarItens()
    *==========================================================================
        LOCAL loc_cSQL, loc_lResultado, loc_nRec
        loc_lResultado = .F.
        loc_nRec       = 0

        TRY
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF

            loc_cSQL = "SELECT a.CItens, a.CPros, a.DPros, a.Obs, a.CUnis, c.Volumes, " + ;
                       "a.Opers, a.Qtds AS QtdOs, a.QtBaixas AS QtdBs, " + ;
                       "(a.Qtds - a.QtBaixas) AS QtdSs, a.Units, a.Moedas AS CMoes, a.Totas " + ;
                       "FROM SigMvItn a, SigCdOpe b, SigCdPro c " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNum) + ;
                       " AND a.Dopes = b.Dopes AND a.CPros = c.CPros " + ;
                       "ORDER BY a.CItens, a.CPros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp") < 1
                MsgErro("Falha ao executar consulta de itens da OP.", "Erro SQL")
            ELSE
                IF USED("cursor_4c_Itens")
                    SELECT cursor_4c_Itens
                    ZAP
                ENDIF
                IF USED("cursor_4c_Rodape")
                    SELECT cursor_4c_Rodape
                    ZAP
                ENDIF

                *-- Popular cursor_4c_Itens (CItens = numero sequencial como no legado)
                SELECT cursor_4c_DadosTemp
                SCAN
                    loc_nRec = loc_nRec + 1
                    INSERT INTO cursor_4c_Itens ;
                        (CItens, CPros, DPros, Obs, CUnis, Volumes, Opers, ;
                         QtdOs, QtdBs, QtdSs, Units, CMoes, Totas, Disps) ;
                    VALUES ;
                        (loc_nRec, ;
                         cursor_4c_DadosTemp.CPros, ;
                         cursor_4c_DadosTemp.DPros, ;
                         NVL(cursor_4c_DadosTemp.Obs, ""), ;
                         cursor_4c_DadosTemp.CUnis, ;
                         cursor_4c_DadosTemp.Volumes, ;
                         cursor_4c_DadosTemp.Opers, ;
                         cursor_4c_DadosTemp.QtdOs, ;
                         cursor_4c_DadosTemp.QtdBs, ;
                         cursor_4c_DadosTemp.QtdSs, ;
                         cursor_4c_DadosTemp.Units, ;
                         cursor_4c_DadosTemp.CMoes, ;
                         cursor_4c_DadosTemp.Totas, ;
                         0)
                ENDSCAN

                *-- Popular cursor_4c_Rodape (totais por moeda)
                IF USED("cursor_4c_TotalTemp")
                    USE IN cursor_4c_TotalTemp
                ENDIF
                SELECT CMoes, SUM(Volumes) AS Volumes, SUM(QtdOs) AS QtdOs, ;
                       SUM(QtdBs) AS QtdBs, SUM(QtdSs) AS QtdSs, SUM(Totas) AS Totas ;
                  FROM cursor_4c_DadosTemp ;
                 GROUP BY CMoes ;
                  INTO CURSOR cursor_4c_TotalTemp READWRITE

                SELECT cursor_4c_TotalTemp
                SCAN
                    INSERT INTO cursor_4c_Rodape ;
                        (CPros, Volumes, QtdOs, QtdBs, QtdSs, CMoes, Totas) ;
                    VALUES ;
                        ("", ;
                         cursor_4c_TotalTemp.Volumes, ;
                         cursor_4c_TotalTemp.QtdOs, ;
                         cursor_4c_TotalTemp.QtdBs, ;
                         cursor_4c_TotalTemp.QtdSs, ;
                         cursor_4c_TotalTemp.CMoes, ;
                         cursor_4c_TotalTemp.Totas)
                ENDSCAN

                IF USED("cursor_4c_TotalTemp")
                    USE IN cursor_4c_TotalTemp
                ENDIF
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF

                IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
                    GO TOP IN cursor_4c_Itens
                ENDIF
                IF USED("cursor_4c_Rodape") AND !EOF("cursor_4c_Rodape")
                    GO TOP IN cursor_4c_Rodape
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao buscar itens")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCItens  = NVL(CItens, 0)
            THIS.this_cCPros   = ALLTRIM(NVL(CPros, ""))
            THIS.this_cDPros   = ALLTRIM(NVL(DPros, ""))
            THIS.this_cObs     = NVL(Obs, "")
            THIS.this_cCUnis   = ALLTRIM(NVL(CUnis, ""))
            THIS.this_nVolumes = NVL(Volumes, 0)
            THIS.this_cOpers   = ALLTRIM(NVL(Opers, ""))
            THIS.this_nQtdOs   = NVL(QtdOs, 0)
            THIS.this_nQtdBs   = NVL(QtdBs, 0)
            THIS.this_nQtdSs   = NVL(QtdSs, 0)
            THIS.this_nUnits   = NVL(Units, 0)
            THIS.this_cCMoes   = ALLTRIM(NVL(CMoes, ""))
            THIS.this_nTotas   = NVL(Totas, 0)
            THIS.this_nDisps   = NVL(Disps, 0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarInfoOperacao(par_cDopes)
    *==========================================================================
        LOCAL loc_cSQL, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_SigCdOpeInfo")
                USE IN cursor_4c_SigCdOpeInfo
            ENDIF

            loc_cSQL = "SELECT TOP 1 Imagems FROM SigCdOpe " + ;
                       "WHERE Dopes = " + EscaparSQL(PADR(par_cDopes, 20))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeInfo") > 0
                SELECT cursor_4c_SigCdOpeInfo
                IF !EOF()
                    THIS.this_nImagems = NVL(Imagems, 0)
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF USED("cursor_4c_SigCdOpeInfo")
                USE IN cursor_4c_SigCdOpeInfo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                "Erro ao carregar opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarImagemProduto(par_cCPros, par_cArquivo)
    *==========================================================================
        LOCAL loc_cSQL, loc_cFoto, loc_lResultado
        loc_lResultado       = .F.
        THIS.this_cArquivo   = ""

        TRY
            IF USED("cursor_4c_ImgPro")
                USE IN cursor_4c_ImgPro
            ENDIF

            loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(par_cCPros)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgPro") > 0
                SELECT cursor_4c_ImgPro
                IF !EOF() AND !EMPTY(FigJpgs) AND !ISNULL(FigJpgs)
                    CLEAR RESOURCES
                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFoto, par_cArquivo)
                    THIS.this_cArquivo = par_cArquivo
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_ImgPro")
                USE IN cursor_4c_ImgPro
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                "Erro ao carregar imagem do produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN PADR(THIS.this_cEmpDopNum, 29) + TRANSFORM(THIS.this_nCItens)
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida propriedades obrigatorias antes de Inserir/Atualizar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_cEmp)
            THIS.this_cMensagemErro = "Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cDop)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        IF THIS.this_nNum <= 0
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero da OP " + CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cCPros)
            THIS.this_cMensagemErro = "Produto " + CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF THIS.this_nQtdOs < 0
            THIS.this_cMensagemErro = "Quantidade n" + CHR(227) + "o pode ser negativa."
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cEmpDopNum)
            THIS.this_cEmpDopNum = PADR(THIS.this_cEmp, 3) + PADR(THIS.this_cDop, 20) + ;
                                    STR(THIS.this_nNum, 6)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigMvItn dos campos gerenciados pelo BO
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigMvItn " + ;
                       "(Emps, Dopes, Numes, EmpDopNums, CItens, CPros, DPros, Obs, " + ;
                       "CUnis, Opers, Qtds, QtBaixas, Units, Moedas, Totas, DtAlts) " + ;
                       "VALUES (" + ;
                       EscaparSQL(PADR(THIS.this_cEmp, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDop, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNum, 0) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCItens, 0) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCPros, 14)) + ", " + ;
                       EscaparSQL(PADR(LEFT(THIS.this_cDPros, 65), 65)) + ", " + ;
                       EscaparSQL(THIS.this_cObs) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCUnis, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cOpers, 1)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdBs, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCMoes, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotas, 2) + ", " + ;
                       "GETDATE())"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao inserir item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em SigMvItn dos campos gerenciados pelo BO
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigMvItn SET " + ;
                       "CPros    = " + EscaparSQL(PADR(THIS.this_cCPros, 14)) + ", " + ;
                       "DPros    = " + EscaparSQL(PADR(LEFT(THIS.this_cDPros, 65), 65)) + ", " + ;
                       "Obs      = " + EscaparSQL(THIS.this_cObs) + ", " + ;
                       "CUnis    = " + EscaparSQL(PADR(THIS.this_cCUnis, 3)) + ", " + ;
                       "Opers    = " + EscaparSQL(PADR(THIS.this_cOpers, 1)) + ", " + ;
                       "Qtds     = " + FormatarNumeroSQL(THIS.this_nQtdOs, 3) + ", " + ;
                       "QtBaixas = " + FormatarNumeroSQL(THIS.this_nQtdBs, 3) + ", " + ;
                       "Units    = " + FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                       "Moedas   = " + EscaparSQL(PADR(THIS.this_cCMoes, 3)) + ", " + ;
                       "Totas    = " + FormatarNumeroSQL(THIS.this_nTotas, 2) + ", " + ;
                       "DtAlts   = GETDATE() " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + " " + ;
                       "  AND CItens = " + FormatarNumeroSQL(THIS.this_nCItens, 0)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE em SigMvItn do item corrente
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvItn " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + " " + ;
                       "  AND CItens = " + FormatarNumeroSQL(THIS.this_nCItens, 0)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao excluir item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao excluir item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

