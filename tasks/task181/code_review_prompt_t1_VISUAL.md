# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 541: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2696 linhas total):

*-- Linhas 128 a 174:
128:     PROTECTED PROCEDURE ConfigurarPageFrame()
129:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
130:         WITH THIS.cnt_4c_Cabecalho
131:             .Top       = 0
132:             .Left      = 0
133:             .Width     = THIS.Width
134:             .Height    = 80
135:             .BackStyle = 1
136:             .BackColor = RGB(100,100,100)
137:             .BorderWidth = 0
138:             .Visible   = .T.
139: 
140:             .AddObject("lbl_4c_Sombra", "Label")
141:             WITH .lbl_4c_Sombra
142:                 .AutoSize  = .F.
143:                 .FontBold  = .T.
144:                 .FontName  = "Tahoma"
145:                 .FontSize  = 18
146:                 .WordWrap  = .T.
147:                 .Alignment = 0
148:                 .BackStyle = 0
149:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
150:                 .Height    = 40
151:                 .Left      = 10
152:                 .Top       = 18
153:                 .Width     = .Parent.Width
154:                 .ForeColor = RGB(0,0,0)
155:             ENDWITH
156: 
157:             .AddObject("lbl_4c_Titulo", "Label")
158:             WITH .lbl_4c_Titulo
159:                 .AutoSize  = .F.
160:                 .FontBold  = .T.
161:                 .FontName  = "Tahoma"
162:                 .FontSize  = 18
163:                 .WordWrap  = .T.
164:                 .Alignment = 0
165:                 .BackStyle = 0
166:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
167:                 .Height    = 46
168:                 .Left      = 10
169:                 .Top       = 17
170:                 .Width     = .Parent.Width
171:                 .ForeColor = RGB(255,255,255)
172:             ENDWITH
173:         ENDWITH
174:     ENDPROC

*-- Linhas 240 a 267:
240: 
241:         TRY
242:             *-- Label titulo da grade
243:             THIS.AddObject("lbl_4c_Lbl_titulo", "Label")
244:             WITH THIS.lbl_4c_Lbl_titulo
245:                 .AutoSize  = .T.
246:                 .FontBold  = .T.
247:                 .FontName  = "Tahoma"
248:                 .FontSize  = 8
249:                 .BackStyle = 0
250:                 .Caption   = " \<Etiquetas Selecionadas "
251:                 .Height    = 15
252:                 .Left      = 10
253:                 .Top       = 203
254:                 .Width     = 138
255:                 .ForeColor = RGB(90,90,90)
256:             ENDWITH
257: 
258:             *-- Grid principal
259:             THIS.AddObject("grd_4c_Dados", "Grid")
260:             WITH THIS.grd_4c_Dados
261:                 .Top          = 216
262:                 .Left         = 12
263:                 .Width        = 818
264:                 .Height       = 157
265:                 .RecordMark   = .F.
266:                 .DeleteMark   = .F.
267:                 .FontName     = "Tahoma"

*-- Linhas 284 a 292:
284:                         .FontName  = "Tahoma"
285:                         .FontSize  = 8
286:                         .Alignment = 2
287:                         .Caption   = "Produto"
288:                         .ForeColor = RGB(90,90,90)
289:                     ENDWITH
290:                     WITH .Text1
291:                         .FontName      = "Tahoma"
292:                         .FontSize      = 8

*-- Linhas 315 a 323:
315:                         .FontName  = "Tahoma"
316:                         .FontSize  = 8
317:                         .Alignment = 2
318:                         .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
319:                         .ForeColor = RGB(90,90,90)
320:                     ENDWITH
321:                     WITH .Text1
322:                         .FontName      = "Tahoma"
323:                         .FontSize      = 8

*-- Linhas 343 a 351:
343:                         .FontName  = "Tahoma"
344:                         .FontSize  = 8
345:                         .Alignment = 2
346:                         .Caption   = "Quantidade"
347:                         .ForeColor = RGB(90,90,90)
348:                     ENDWITH
349:                     WITH .Text1
350:                         .FontName      = "Tahoma"
351:                         .FontSize      = 8

*-- Linhas 372 a 380:
372:                         .FontName  = "Tahoma"
373:                         .FontSize  = 8
374:                         .Alignment = 2
375:                         .Caption   = "Refer" + CHR(234) + "ncia Fornecedor"
376:                         .ForeColor = RGB(90,90,90)
377:                     ENDWITH
378:                     WITH .Text1
379:                         .FontName      = "Tahoma"
380:                         .FontSize      = 8

*-- Linhas 400 a 408:
400:                         .FontName  = "Tahoma"
401:                         .FontSize  = 8
402:                         .Alignment = 2
403:                         .Caption   = "Parcelas"
404:                         .ForeColor = RGB(90,90,90)
405:                     ENDWITH
406:                     WITH .Text1
407:                         .FontName    = "Tahoma"
408:                         .FontSize    = 8

*-- Linhas 428 a 436:
428:                         .FontName  = "Tahoma"
429:                         .FontSize  = 8
430:                         .Alignment = 2
431:                         .Caption   = "Pre" + CHR(231) + "o"
432:                         .ForeColor = RGB(90,90,90)
433:                     ENDWITH
434:                     WITH .Text1
435:                         .FontName    = "Tahoma"
436:                         .FontSize    = 8

*-- Linhas 458 a 466:
458:                         .FontName  = "Tahoma"
459:                         .FontSize  = 8
460:                         .Alignment = 2
461:                         .Caption   = "Pre" + CHR(231) + "o De"
462:                         .ForeColor = RGB(90,90,90)
463:                     ENDWITH
464:                     WITH .Text1
465:                         .FontName    = "Tahoma"
466:                         .FontSize    = 8

*-- Linhas 476 a 556:
476:             ENDWITH
477: 
478:             *-- Botao Excluir item da grade
479:             THIS.AddObject("cmd_4c_Btnexcluir", "CommandButton")
480:             WITH THIS.cmd_4c_Btnexcluir
481:                 .Top             = 374
482:                 .Left            = 21
483:                 .Height          = 26
484:                 .Width           = 26
485:                 .Caption         = ""
486:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
487:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
488:                 .Themes          = .T.
489:                 .ToolTipText     = "Excluir item"
490:                 .FontName        = "Tahoma"
491:                 .FontSize        = 8
492:             ENDWITH
493:             BINDEVENT(THIS.cmd_4c_Btnexcluir, "Click", THIS, "BtnExcluirClick")
494: 
495:             *-- Botao Carregar itens da movimentacao
496:             THIS.AddObject("cmd_4c_BtnCarregar", "CommandButton")
497:             WITH THIS.cmd_4c_BtnCarregar
498:                 .Top             = 159
499:                 .Left            = 373
500:                 .Height          = 26
501:                 .Width           = 26
502:                 .Caption         = ""
503:                 .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
504:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
505:                 .Themes          = .T.
506:                 .FontName        = "Tahoma"
507:                 .FontSize        = 8
508:             ENDWITH
509:             BINDEVENT(THIS.cmd_4c_BtnCarregar, "Click", THIS, "BtnCarregarClick")
510: 
511:             *-- CommandGroup BTNREPORT: Imprimir + Encerrar
512:             THIS.AddObject("obj_4c_BTNREPORT", "CommandGroup")
513:             WITH THIS.obj_4c_BTNREPORT
514:                 .ButtonCount = 2
515:                 .BackStyle   = 0
516:                 .BorderStyle = 0
517:                 .Height      = 85
518:                 .Left        = 676
519:                 .Top         = -2
520:                 .Width       = 161
521:                 .AutoSize    = .T.
522: 
523:                 WITH .Buttons(1)
524:                     .Top        = 5
525:                     .Left       = 5
526:                     .Height     = 75
527:                     .Width      = 75
528:                     .FontBold   = .T.
529:                     .FontItalic = .T.
530:                     .WordWrap   = .T.
531:                     .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
532:                     .Caption    = "\<Imprimir"
533:                     .ForeColor  = RGB(90,90,90)
534:                     .BackColor  = RGB(255,255,255)
535:                     .Themes     = .F.
536:                     .Name       = "Imprime"
537:                 ENDWITH
538: 
539:                 WITH .Buttons(2)
540:                     .Top        = 5
541:                     .Left       = 81
542:                     .Height     = 75
543:                     .Width      = 75
544:                     .FontBold   = .T.
545:                     .FontItalic = .T.
546:                     .FontName   = "Comic Sans MS"
547:                     .FontSize   = 8
548:                     .WordWrap   = .T.
549:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
550:                     .Cancel     = .T.
551:                     .Caption    = "Encerrar"
552:                     .ForeColor  = RGB(90,90,90)
553:                     .BackColor  = RGB(255,255,255)
554:                     .Themes     = .F.
555:                     .Name       = "Sair"
556:                 ENDWITH

*-- Linhas 778 a 941:
778: 
779:         TRY
780:             *-- Secao Lista de Precos (Top 86-130)
781:             THIS.AddObject("lbl_4c_Label2", "Label")
782:             WITH THIS.lbl_4c_Label2
783:                 .AutoSize  = .T.
784:                 .FontBold  = .T.
785:                 .FontName  = "Tahoma"
786:                 .FontSize  = 8
787:                 .BackStyle = 0
788:                 .Caption   = " \<Lista de Pre" + CHR(231) + "os "
789:                 .Height    = 15
790:                 .Left      = 20
791:                 .Top       = 86
792:                 .Width     = 93
793:                 .ForeColor = RGB(90,90,90)
794:             ENDWITH
795: 
796:             THIS.AddObject("chk_4c_ChkLista", "CheckBox")
797:             WITH THIS.chk_4c_ChkLista
798:                 .AutoSize  = .T.
799:                 .Alignment = 0
800:                 .BackStyle = 0
801:                 .Caption   = "Carrega " + CHR(205) + "tens"
802:                 .Height    = 15
803:                 .Left      = 24
804:                 .Top       = 102
805:                 .Width     = 85
806:                 .Value     = 1
807:                 .FontName  = "Tahoma"
808:                 .FontSize  = 8
809:                 .ForeColor = RGB(90,90,90)
810:             ENDWITH
811: 
812:             THIS.AddObject("txt_4c_Lpreco", "TextBox")
813:             WITH THIS.txt_4c_Lpreco
814:                 .Format    = "K!"
815:                 .Height    = 22
816:                 .Left      = 132
817:                 .Top       = 105
818:                 .Width     = 294
819:                 .Value     = ""
820:                 .MaxLength = 30
821:                 .FontName  = "Tahoma"
822:                 .FontSize  = 8
823:             ENDWITH
824:             BINDEVENT(THIS.txt_4c_Lpreco, "KeyPress", THIS, "TxtLprecoKeyPress")
825: 
826:             THIS.AddObject("txt_4c_LPreco2", "TextBox")
827:             WITH THIS.txt_4c_LPreco2
828:                 .Format    = "K!"
829:                 .Height    = 22
830:                 .Left      = 132
831:                 .Top       = 128
832:                 .Width     = 294
833:                 .Value     = ""
834:                 .MaxLength = 30
835:                 .FontName  = "Tahoma"
836:                 .FontSize  = 8
837:             ENDWITH
838:             BINDEVENT(THIS.txt_4c_LPreco2, "KeyPress", THIS, "TxtLPreco2KeyPress")
839: 
840:             *-- Secao Movimentacoes (Top 154-195)
841:             THIS.AddObject("lbl_4c_Label4", "Label")
842:             WITH THIS.lbl_4c_Label4
843:                 .AutoSize  = .T.
844:                 .FontBold  = .T.
845:                 .FontName  = "Tahoma"
846:                 .FontSize  = 8
847:                 .BackStyle = 0
848:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
849:                 .Height    = 15
850:                 .Left      = 20
851:                 .Top       = 154
852:                 .Width     = 92
853:                 .ForeColor = RGB(90,90,90)
854:             ENDWITH
855: 
856:             THIS.AddObject("chk_4c_ChkOperacoes", "CheckBox")
857:             WITH THIS.chk_4c_ChkOperacoes
858:                 .AutoSize  = .T.
859:                 .Alignment = 0
860:                 .BackStyle = 0
861:                 .Caption   = "Carrega " + CHR(205) + "tens"
862:                 .Height    = 15
863:                 .Left      = 24
864:                 .Top       = 169
865:                 .Width     = 85
866:                 .Value     = 1
867:                 .FontName  = "Tahoma"
868:                 .FontSize  = 8
869:                 .ForeColor = RGB(90,90,90)
870:             ENDWITH
871: 
872:             THIS.AddObject("lbl_4c_Label5", "Label")
873:             WITH THIS.lbl_4c_Label5
874:                 .AutoSize  = .T.
875:                 .FontBold  = .T.
876:                 .FontName  = "Tahoma"
877:                 .FontSize  = 8
878:                 .BackStyle = 0
879:                 .Caption   = "Emp"
880:                 .Height    = 15
881:                 .Left      = 132
882:                 .Top       = 161
883:                 .Width     = 26
884:                 .ForeColor = RGB(90,90,90)
885:             ENDWITH
886: 
887:             THIS.AddObject("lbl_4c_Label6", "Label")
888:             WITH THIS.lbl_4c_Label6
889:                 .AutoSize  = .T.
890:                 .FontBold  = .T.
891:                 .FontName  = "Tahoma"
892:                 .FontSize  = 8
893:                 .BackStyle = 0
894:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
895:                 .Height    = 15
896:                 .Left      = 165
897:                 .Top       = 161
898:                 .Width     = 86
899:                 .ForeColor = RGB(90,90,90)
900:             ENDWITH
901: 
902:             THIS.AddObject("lbl_4c_Label7", "Label")
903:             WITH THIS.lbl_4c_Label7
904:                 .AutoSize  = .T.
905:                 .FontBold  = .T.
906:                 .FontName  = "Tahoma"
907:                 .FontSize  = 8
908:                 .BackStyle = 0
909:                 .Caption   = "C" + CHR(243) + "digo"
910:                 .Height    = 15
911:                 .Left      = 317
912:                 .Top       = 161
913:                 .Width     = 40
914:                 .ForeColor = RGB(90,90,90)
915:             ENDWITH
916: 
917:             THIS.AddObject("txt_4c_Emps", "TextBox")
918:             WITH THIS.txt_4c_Emps
919:                 .Format    = "K!"
920:                 .Height    = 23
921:                 .Left      = 132
922:                 .Top       = 174
923:                 .Width     = 31
924:                 .Value     = ""
925:                 .MaxLength = 3
926:                 .FontName  = "Tahoma"
927:                 .FontSize  = 8
928:             ENDWITH
929:             BINDEVENT(THIS.txt_4c_Emps, "KeyPress", THIS, "TxtEmpsKeyPress")
930: 
931:             THIS.AddObject("txt_4c_Dopes", "TextBox")
932:             WITH THIS.txt_4c_Dopes
933:                 .Format    = "K!"
934:                 .Height    = 23
935:                 .Left      = 165
936:                 .Top       = 174
937:                 .Width     = 150
938:                 .Value     = ""
939:                 .MaxLength = 20
940:                 .FontName  = "Tahoma"
941:                 .FontSize  = 8

*-- Linhas 949 a 1598:
949:                 .Format    = "K"
950:                 .Height    = 23
951:                 .InputMask = "999999"
952:                 .Left      = 317
953:                 .MaxLength = 6
954:                 .Top       = 174
955:                 .Width     = 52
956:                 .FontName  = "Tahoma"
957:                 .FontSize  = 8
958:             ENDWITH
959: 
960:             *-- Secao Tipo de Etiqueta (Top 415-615)
961:             THIS.AddObject("shp_4c_Shape3", "Shape")
962:             WITH THIS.shp_4c_Shape3
963:                 .Top           = 431
964:                 .Left          = 260
965:                 .Width         = 254
966:                 .Height        = 106
967:                 .BackStyle     = 0
968:                 .BorderWidth   = 1
969:                 .SpecialEffect = 1
970:             ENDWITH
971: 
972:             THIS.AddObject("lbl_4c_Label1", "Label")
973:             WITH THIS.lbl_4c_Label1
974:                 .AutoSize  = .T.
975:                 .FontBold  = .T.
976:                 .FontName  = "Tahoma"
977:                 .FontSize  = 8
978:                 .BackStyle = 0
979:                 .Caption   = " Tipo de Etiqueta "
980:                 .Height    = 15
981:                 .Left      = 23
982:                 .Top       = 415
983:                 .Width     = 99
984:                 .ForeColor = RGB(90,90,90)
985:             ENDWITH
986: 
987:             *-- Opt_Tipo: ButtonCount=1 provisorio; CarregarTiposEtiqueta() re-popula
988:             THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
989:             WITH THIS.obj_4c_Opt_Tipo
990:                 .ButtonCount   = 1
991:                 .BackStyle     = 0
992:                 .Value         = 1
993:                 .Height        = 182
994:                 .Left          = 13
995:                 .SpecialEffect = 1
996:                 .Top           = 431
997:                 .Width         = 240
998:                 .Themes        = .F.
999:                 WITH .Buttons(1)
1000:                     .AutoSize  = .F.
1001:                     .Width     = 197
1002:                     .Caption   = " \<a. Rabicho"
1003:                     .ForeColor = RGB(90,90,90)
1004:                     .Top       = 10
1005:                     .BackStyle = 0
1006:                     .Height    = 16
1007:                     .Left      = 9
1008:                     .Themes    = .F.
1009:                 ENDWITH
1010:             ENDWITH
1011: 
1012:             *-- Container Impressora (Cnt_Impressora: Top=539, Left=260, 254x74)
1013:             THIS.AddObject("cnt_4c__Impressora", "Container")
1014:             WITH THIS.cnt_4c__Impressora
1015:                 .Top         = 539
1016:                 .Left        = 260
1017:                 .Width       = 254
1018:                 .Height      = 74
1019:                 .BackStyle   = 0
1020:                 .BorderWidth = 0
1021: 
1022:                 *-- Opcao impressora: Allegro / Zebra ZPL / Zebra EPL
1023:                 .AddObject("obj_4c_Opcao_imp", "OptionGroup")
1024:                 WITH .obj_4c_Opcao_imp
1025:                     .AutoSize    = .F.
1026:                     .ButtonCount = 3
1027:                     .Height      = 24
1028:                     .Left        = 5
1029:                     .Top         = 3
1030:                     .Width       = 241
1031:                     WITH .Buttons(1)
1032:                         .AutoSize  = .T.
1033:                         .BackStyle = 0
1034:                         .Caption   = "Allegro"
1035:                         .ForeColor = RGB(90,90,90)
1036:                         .Left      = 2
1037:                         .Top       = 4
1038:                         .Width     = 51
1039:                     ENDWITH
1040:                     WITH .Buttons(2)
1041:                         .AutoSize  = .T.
1042:                         .BackStyle = 0
1043:                         .Caption   = "Zebra ZPL"
1044:                         .FontName  = "Tahoma"
1045:                         .FontSize  = 8
1046:                         .ForeColor = RGB(90,90,90)
1047:                         .Left      = 75
1048:                         .Top       = 4
1049:                         .Width     = 66
1050:                         .Themes    = .F.
1051:                     ENDWITH
1052:                     WITH .Buttons(3)
1053:                         .AutoSize  = .T.
1054:                         .BackStyle = 0
1055:                         .Caption   = "Zebra EPL"
1056:                         .FontName  = "Tahoma"
1057:                         .FontSize  = 8
1058:                         .ForeColor = RGB(90,90,90)
1059:                         .Height    = 15
1060:                         .Left      = 164
1061:                         .Top       = 4
1062:                         .Width     = 66
1063:                         .Themes    = .F.
1064:                     ENDWITH
1065:                 ENDWITH
1066: 
1067:                 *-- Labels de ajuste
1068:                 .AddObject("lbl_4c_LblSay2", "Label")
1069:                 WITH .lbl_4c_LblSay2
1070:                     .AutoSize  = .F.
1071:                     .FontName  = "Tahoma"
1072:                     .FontSize  = 7
1073:                     .BackStyle = 0
1074:                     .Caption   = "Vertical"
1075:                     .Height    = 13
1076:                     .Left      = 10
1077:                     .Top       = 29
1078:                     .Width     = 33
1079:                     .ForeColor = RGB(90,90,90)
1080:                 ENDWITH
1081: 
1082:                 .AddObject("lbl_4c_LblSay3", "Label")
1083:                 WITH .lbl_4c_LblSay3
1084:                     .AutoSize  = .F.
1085:                     .FontName  = "Tahoma"
1086:                     .FontSize  = 7
1087:                     .BackStyle = 0
1088:                     .Caption   = "Horizontal"
1089:                     .Height    = 13
1090:                     .Left      = 69
1091:                     .Top       = 29
1092:                     .Width     = 43
1093:                     .ForeColor = RGB(90,90,90)
1094:                 ENDWITH
1095: 
1096:                 .AddObject("lbl_4c_LblSay1", "Label")
1097:                 WITH .lbl_4c_LblSay1
1098:                     .AutoSize  = .F.
1099:                     .FontName  = "Tahoma"
1100:                     .FontSize  = 7
1101:                     .BackStyle = 0
1102:                     .Caption   = "Densidade"
1103:                     .Height    = 13
1104:                     .Left      = 128
1105:                     .Top       = 29
1106:                     .Width     = 55
1107:                     .ForeColor = RGB(90,90,90)
1108:                 ENDWITH
1109: 
1110:                 .AddObject("lbl_4c_LblSay20", "Label")
1111:                 WITH .lbl_4c_LblSay20
1112:                     .AutoSize  = .F.
1113:                     .FontName  = "Tahoma"
1114:                     .FontSize  = 7
1115:                     .BackStyle = 0
1116:                     .Caption   = "Velocidade"
1117:                     .Height    = 13
1118:                     .Left      = 188
1119:                     .Top       = 30
1120:                     .Width     = 55
1121:                     .ForeColor = RGB(90,90,90)
1122:                 ENDWITH
1123: 
1124:                 *-- Spinners de ajuste
1125:                 .AddObject("obj_4c_Spn_AjVerts", "Spinner")
1126:                 WITH .obj_4c_Spn_AjVerts
1127:                     .FontName          = "Tahoma"
1128:                     .Height            = 26
1129:                     .KeyboardHighValue = 999
1130:                     .KeyboardLowValue  = 0
1131:                     .Left              = 10
1132:                     .SpinnerHighValue  = 999
1133:                     .SpinnerLowValue   = 0
1134:                     .Top               = 42
1135:                     .Width             = 56
1136:                     .Value             = 0
1137:                 ENDWITH
1138: 
1139:                 .AddObject("obj_4c_Spn_AjHorzs", "Spinner")
1140:                 WITH .obj_4c_Spn_AjHorzs
1141:                     .FontName          = "Tahoma"
1142:                     .Height            = 26
1143:                     .KeyboardHighValue = 999
1144:                     .KeyboardLowValue  = -999
1145:                     .Left              = 69
1146:                     .SpinnerHighValue  = 999
1147:                     .SpinnerLowValue   = -999
1148:                     .Top               = 42
1149:                     .Width             = 56
1150:                     .Value             = 0
1151:                 ENDWITH
1152: 
1153:                 .AddObject("obj_4c_Spn_AjDenss", "Spinner")
1154:                 WITH .obj_4c_Spn_AjDenss
1155:                     .FontName          = "Tahoma"
1156:                     .Height            = 26
1157:                     .KeyboardHighValue = 20
1158:                     .KeyboardLowValue  = 1
1159:                     .Left              = 128
1160:                     .SpinnerHighValue  = 20
1161:                     .SpinnerLowValue   = 1
1162:                     .Top               = 42
1163:                     .Width             = 56
1164:                     .Value             = 20
1165:                 ENDWITH
1166: 
1167:                 .AddObject("obj_4c_Spn_AjVelos", "Spinner")
1168:                 WITH .obj_4c_Spn_AjVelos
1169:                     .FontName          = "Tahoma"
1170:                     .Height            = 26
1171:                     .KeyboardHighValue = 3
1172:                     .KeyboardLowValue  = 1
1173:                     .Left              = 188
1174:                     .SpinnerHighValue  = 3
1175:                     .SpinnerLowValue   = 1
1176:                     .Top               = 42
1177:                     .Width             = 54
1178:                     .Value             = 3
1179:                 ENDWITH
1180:             ENDWITH
1181: 
1182:             *-- Label "Impressora" (acima do container)
1183:             THIS.AddObject("lbl_4c_LblLabel3", "Label")
1184:             WITH THIS.lbl_4c_LblLabel3
1185:                 .AutoSize  = .T.
1186:                 .FontBold  = .T.
1187:                 .FontName  = "Tahoma"
1188:                 .FontSize  = 8
1189:                 .BackStyle = 0
1190:                 .Caption   = " Impressora "
1191:                 .Height    = 15
1192:                 .Left      = 271
1193:                 .Top       = 415
1194:                 .Width     = 74
1195:                 .ForeColor = RGB(90,90,90)
1196:             ENDWITH
1197: 
1198:             *-- Opt_Impressora (Visible=.F. - vestigial, sobrepoe Opt_Tipo)
1199:             THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
1200:             WITH THIS.obj_4c_Opt_Impressora
1201:                 .AutoSize      = .F.
1202:                 .ButtonCount   = 1
1203:                 .BackStyle     = 0
1204:                 .Value         = 1
1205:                 .Height        = 47
1206:                 .Left          = 260
1207:                 .SpecialEffect = 1
1208:                 .Top           = 431
1209:                 .Width         = 254
1210:                 .Themes        = .F.
1211:                 .Visible       = .F.
1212:                 WITH .Buttons(1)
1213:                     .AutoSize  = .F.
1214:                     .BackStyle = 0
1215:                     .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
1216:                     .ForeColor = RGB(36,84,155)
1217:                     .Height    = 16
1218:                     .Left      = 9
1219:                     .Style     = 0
1220:                     .Top       = 52
1221:                     .Width     = 210
1222:                     .Themes    = .F.
1223:                 ENDWITH
1224:             ENDWITH
1225: 
1226:             *-- Labels "Sistema" e "Windows" (acima do Get_Printer)
1227:             THIS.AddObject("lbl_4c_Label12", "Label")
1228:             WITH THIS.lbl_4c_Label12
1229:                 .AutoSize  = .T.
1230:                 .FontBold  = .T.
1231:                 .FontName  = "Tahoma"
1232:                 .FontSize  = 8
1233:                 .BackStyle = 0
1234:                 .Caption   = "Sistema"
1235:                 .Height    = 15
1236:                 .Left      = 270
1237:                 .Top       = 437
1238:                 .Width     = 48
1239:                 .ForeColor = RGB(90,90,90)
1240:             ENDWITH
1241: 
1242:             THIS.AddObject("lbl_4c_Label13", "Label")
1243:             WITH THIS.lbl_4c_Label13
1244:                 .AutoSize  = .T.
1245:                 .FontBold  = .T.
1246:                 .FontName  = "Tahoma"
1247:                 .FontSize  = 8
1248:                 .BackStyle = 0
1249:                 .Caption   = "Windows"
1250:                 .Height    = 15
1251:                 .Left      = 383
1252:                 .Top       = 437
1253:                 .Width     = 52
1254:                 .ForeColor = RGB(90,90,90)
1255:             ENDWITH
1256: 
1257:             *-- ComboBox Get_Printer (populado em CarregarImpressoras)
1258:             THIS.AddObject("cbo_4c_Get_Printer", "ComboBox")
1259:             WITH THIS.cbo_4c_Get_Printer
1260:                 .FontName      = "Tahoma"
1261:                 .FontSize      = 8
1262:                 .Height        = 23
1263:                 .Left          = 268
1264:                 .SpecialEffect = 1
1265:                 .Style         = 2
1266:                 .Top           = 453
1267:                 .Width         = 239
1268:                 .BoundColumn   = 1
1269:                 .BoundTo       = .F.
1270:                 .RowSourceType = 0
1271:                 .RowSource     = ""
1272:                 .ColumnCount   = 1
1273:                 .ColumnWidths  = "239"
1274:             ENDWITH
1275:             BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", THIS, "CboGetPrinterInteractiveChange")
1276: 
1277:             *-- Separadora (label + OptionGroup)
1278:             THIS.AddObject("lbl_4c_Lbl_Separador", "Label")
1279:             WITH THIS.lbl_4c_Lbl_Separador
1280:                 .AutoSize  = .T.
1281:                 .FontBold  = .F.
1282:                 .FontName  = "Tahoma"
1283:                 .FontSize  = 8
1284:                 .BackStyle = 0
1285:                 .Caption   = "Separadora :"
1286:                 .Height    = 15
1287:                 .Left      = 532
1288:                 .Top       = 417
1289:                 .Width     = 65
1290:                 .ForeColor = RGB(90,90,90)
1291:             ENDWITH
1292: 
1293:             THIS.AddObject("obj_4c_Opt_separador", "OptionGroup")
1294:             WITH THIS.obj_4c_Opt_separador
1295:                 .AutoSize      = .F.
1296:                 .ButtonCount   = 2
1297:                 .BackStyle     = 0
1298:                 .Value         = 1
1299:                 .Height        = 25
1300:                 .Left          = 601
1301:                 .SpecialEffect = 1
1302:                 .Top           = 412
1303:                 .Width         = 198
1304:                 .Themes        = .F.
1305:                 WITH .Buttons(1)
1306:                     .AutoSize  = .T.
1307:                     .BackStyle = 0
1308:                     .Caption   = "Sim"
1309:                     .ForeColor = RGB(90,90,90)
1310:                     .Height    = 15
1311:                     .Left      = 5
1312:                     .Top       = 5
1313:                     .Width     = 34
1314:                     .Themes    = .F.
1315:                 ENDWITH
1316:                 WITH .Buttons(2)
1317:                     .AutoSize  = .T.
1318:                     .BackStyle = 0
1319:                     .Caption   = "N" + CHR(227) + "o"
1320:                     .FontName  = "Tahoma"
1321:                     .FontSize  = 8
1322:                     .ForeColor = RGB(90,90,90)
1323:                     .Height    = 15
1324:                     .Left      = 70
1325:                     .Top       = 5
1326:                     .Width     = 37
1327:                     .Themes    = .F.
1328:                 ENDWITH
1329:             ENDWITH
1330: 
1331:             *-- Preco (label + OptionGroup 6 botoes)
1332:             THIS.AddObject("lbl_4c_Label8", "Label")
1333:             WITH THIS.lbl_4c_Label8
1334:                 .AutoSize  = .T.
1335:                 .FontBold  = .F.
1336:                 .FontName  = "Tahoma"
1337:                 .FontSize  = 8
1338:                 .BackStyle = 0
1339:                 .Caption   = "Pre" + CHR(231) + "o :"
1340:                 .Height    = 15
1341:                 .Left      = 561
1342:                 .Top       = 440
1343:                 .Width     = 36
1344:                 .ForeColor = RGB(90,90,90)
1345:             ENDWITH
1346: 
1347:             THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
1348:             WITH THIS.obj_4c_Opt_Preco
1349:                 .AutoSize      = .F.
1350:                 .ButtonCount   = 6
1351:                 .BackStyle     = 0
1352:                 .Value         = 1
1353:                 .Height        = 95
1354:                 .Left          = 601
1355:                 .SpecialEffect = 1
1356:                 .Top           = 439
1357:                 .Width         = 198
1358:                 .Themes        = .F.
1359:                 WITH .Buttons(1)
1360:                     .AutoSize  = .T.
1361:                     .BackStyle = 0
1362:                     .Caption   = "Sim"
1363:                     .ForeColor = RGB(90,90,90)
1364:                     .Height    = 15
1365:                     .Left      = 8
1366:                     .Top       = 7
1367:                     .Width     = 34
1368:                     .Themes    = .F.
1369:                 ENDWITH
1370:                 WITH .Buttons(2)
1371:                     .AutoSize  = .T.
1372:                     .BackStyle = 0
1373:                     .Caption   = "N" + CHR(227) + "o"
1374:                     .FontName  = "Tahoma"
1375:                     .FontSize  = 8
1376:                     .ForeColor = RGB(90,90,90)
1377:                     .Height    = 15
1378:                     .Left      = 61
1379:                     .Top       = 7
1380:                     .Width     = 37
1381:                     .Themes    = .F.
1382:                 ENDWITH
1383:                 WITH .Buttons(3)
1384:                     .AutoSize  = .T.
1385:                     .BackStyle = 0
1386:                     .Caption   = "Ideal"
1387:                     .FontName  = "Tahoma"
1388:                     .FontSize  = 8
1389:                     .ForeColor = RGB(90,90,90)
1390:                     .Height    = 15
1391:                     .Left      = 8
1392:                     .Top       = 28
1393:                     .Width     = 42
1394:                     .Themes    = .F.
1395:                 ENDWITH
1396:                 WITH .Buttons(4)
1397:                     .AutoSize  = .T.
1398:                     .BackStyle = 0
1399:                     .Caption   = "Atual"
1400:                     .FontName  = "Tahoma"
1401:                     .FontSize  = 8
1402:                     .ForeColor = RGB(90,90,90)
1403:                     .Height    = 15
1404:                     .Left      = 61
1405:                     .Top       = 28
1406:                     .Width     = 43
1407:                     .Themes    = .F.
1408:                 ENDWITH
1409:                 WITH .Buttons(5)
1410:                     .AutoSize  = .T.
1411:                     .BackStyle = 0
1412:                     .Caption   = "Pre" + CHR(231) + "o DE \ Por"
1413:                     .FontName  = "Tahoma"
1414:                     .FontSize  = 8
1415:                     .ForeColor = RGB(90,90,90)
1416:                     .Height    = 15
1417:                     .Left      = 8
1418:                     .Top       = 51
1419:                     .Width     = 87
1420:                     .Themes    = .F.
1421:                 ENDWITH
1422:                 WITH .Buttons(6)
1423:                     .AutoSize  = .T.
1424:                     .BackStyle = 0
1425:                     .Caption   = "Parcelamento"
1426:                     .FontName  = "Tahoma"
1427:                     .FontSize  = 8
1428:                     .ForeColor = RGB(90,90,90)
1429:                     .Height    = 15
1430:                     .Left      = 8
1431:                     .Top       = 73
1432:                     .Width     = 83
1433:                     .Themes    = .F.
1434:                 ENDWITH
1435:             ENDWITH
1436: 
1437:             *-- Peso (label + OptionGroup)
1438:             THIS.AddObject("lbl_4c_Label9", "Label")
1439:             WITH THIS.lbl_4c_Label9
1440:                 .AutoSize  = .T.
1441:                 .FontBold  = .F.
1442:                 .FontName  = "Tahoma"
1443:                 .FontSize  = 8
1444:                 .BackStyle = 0
1445:                 .Caption   = "Peso :"
1446:                 .Height    = 15
1447:                 .Left      = 565
1448:                 .Top       = 540
1449:                 .Width     = 32
1450:                 .ForeColor = RGB(90,90,90)
1451:             ENDWITH
1452: 
1453:             THIS.AddObject("obj_4c_Opt_peso", "OptionGroup")
1454:             WITH THIS.obj_4c_Opt_peso
1455:                 .AutoSize      = .F.
1456:                 .ButtonCount   = 2
1457:                 .BackStyle     = 0
1458:                 .Value         = 1
1459:                 .Height        = 25
1460:                 .Left          = 601
1461:                 .SpecialEffect = 1
1462:                 .Top           = 535
1463:                 .Width         = 198
1464:                 .Themes        = .F.
1465:                 WITH .Buttons(1)
1466:                     .AutoSize  = .F.
1467:                     .BackStyle = 0
1468:                     .Caption   = "Sim"
1469:                     .ForeColor = RGB(90,90,90)
1470:                     .Height    = 15
1471:                     .Left      = 5
1472:                     .Top       = 5
1473:                     .Width     = 41
1474:                     .Themes    = .F.
1475:                 ENDWITH
1476:                 WITH .Buttons(2)
1477:                     .AutoSize  = .F.
1478:                     .BackStyle = 0
1479:                     .Caption   = "N" + CHR(227) + "o"
1480:                     .FontName  = "Tahoma"
1481:                     .FontSize  = 8
1482:                     .ForeColor = RGB(90,90,90)
1483:                     .Height    = 15
1484:                     .Left      = 70
1485:                     .Top       = 5
1486:                     .Width     = 41
1487:                     .Themes    = .F.
1488:                 ENDWITH
1489:             ENDWITH
1490: 
1491:             *-- Composicao (label + OptionGroup)
1492:             THIS.AddObject("lbl_4c_Label10", "Label")
1493:             WITH THIS.lbl_4c_Label10
1494:                 .AutoSize  = .T.
1495:                 .FontBold  = .F.
1496:                 .FontName  = "Tahoma"
1497:                 .FontSize  = 8
1498:                 .BackStyle = 0
1499:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
1500:                 .Height    = 15
1501:                 .Left      = 531
1502:                 .Top       = 567
1503:                 .Width     = 66
1504:                 .ForeColor = RGB(90,90,90)
1505:             ENDWITH
1506: 
1507:             THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
1508:             WITH THIS.obj_4c_OptCompos
1509:                 .AutoSize      = .F.
1510:                 .ButtonCount   = 2
1511:                 .BackStyle     = 0
1512:                 .Value         = 1
1513:                 .Height        = 25
1514:                 .Left          = 601
1515:                 .SpecialEffect = 1
1516:                 .Top           = 562
1517:                 .Width         = 198
1518:                 .Themes        = .F.
1519:                 WITH .Buttons(1)
1520:                     .AutoSize  = .F.
1521:                     .BackStyle = 0
1522:                     .Caption   = "Sim"
1523:                     .ForeColor = RGB(90,90,90)
1524:                     .Height    = 15
1525:                     .Left      = 5
1526:                     .Top       = 5
1527:                     .Width     = 41
1528:                     .Themes    = .F.
1529:                 ENDWITH
1530:                 WITH .Buttons(2)
1531:                     .AutoSize  = .F.
1532:                     .BackStyle = 0
1533:                     .Caption   = "N" + CHR(227) + "o"
1534:                     .FontName  = "Tahoma"
1535:                     .FontSize  = 8
1536:                     .ForeColor = RGB(90,90,90)
1537:                     .Height    = 15
1538:                     .Left      = 70
1539:                     .Top       = 5
1540:                     .Width     = 41
1541:                     .Themes    = .F.
1542:                 ENDWITH
1543:             ENDWITH
1544: 
1545:             *-- Ordem (label + OptionGroup)
1546:             THIS.AddObject("lbl_4c_Label11", "Label")
1547:             WITH THIS.lbl_4c_Label11
1548:                 .AutoSize  = .T.
1549:                 .FontBold  = .F.
1550:                 .FontName  = "Tahoma"
1551:                 .FontSize  = 8
1552:                 .BackStyle = 0
1553:                 .Caption   = "Ordem :"
1554:                 .Height    = 15
1555:                 .Left      = 556
1556:                 .Top       = 594
1557:                 .Width     = 41
1558:                 .ForeColor = RGB(90,90,90)
1559:             ENDWITH
1560: 
1561:             THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
1562:             WITH THIS.obj_4c_OptOrdem
1563:                 .AutoSize      = .F.
1564:                 .ButtonCount   = 2
1565:                 .BackStyle     = 0
1566:                 .Value         = 1
1567:                 .Height        = 25
1568:                 .Left          = 601
1569:                 .SpecialEffect = 1
1570:                 .Top           = 589
1571:                 .Width         = 198
1572:                 .Themes        = .F.
1573:                 WITH .Buttons(1)
1574:                     .AutoSize  = .T.
1575:                     .BackStyle = 0
1576:                     .Caption   = "Produto"
1577:                     .ForeColor = RGB(90,90,90)
1578:                     .Height    = 15
1579:                     .Left      = 5
1580:                     .Top       = 4
1581:                     .Width     = 56
1582:                     .Themes    = .F.
1583:                 ENDWITH
1584:                 WITH .Buttons(2)
1585:                     .AutoSize  = .T.
1586:                     .BackStyle = 0
1587:                     .Caption   = "Nenhuma"
1588:                     .FontName  = "Tahoma"
1589:                     .FontSize  = 8
1590:                     .ForeColor = RGB(90,90,90)
1591:                     .Height    = 15
1592:                     .Left      = 70
1593:                     .Top       = 4
1594:                     .Width     = 63
1595:                     .Themes    = .F.
1596:                 ENDWITH
1597:             ENDWITH
1598: 

*-- Linhas 1632 a 1647:
1632:                             WITH .Buttons(loc_nI)
1633:                                 .AutoSize  = .F.
1634:                                 .Width     = 197
1635:                                 .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ;
1636:                                              ALLTRIM(cursor_4c_TiposEti.cEtiquetas)
1637:                                 .ForeColor = RGB(90,90,90)
1638:                                 .Tag       = ALLTRIM(STR(cursor_4c_TiposEti.nTipos))
1639:                                 .Top       = loc_nTop
1640:                                 .BackStyle = 0
1641:                                 .Height    = 16
1642:                                 .Left      = 9
1643:                                 .Themes    = .F.
1644:                             ENDWITH
1645:                             loc_nI      = loc_nI + 1
1646:                             loc_nTop    = loc_nTop + 20
1647:                             loc_nHeight = loc_nHeight + 20

*-- Linhas 2645 a 2655:
2645:         IF PEMSTATUS(THIS, "chk_4c_ChkOperacoes", 5)
2646:             THIS.chk_4c_ChkOperacoes.Enabled = .T.
2647:         ENDIF
2648:         IF PEMSTATUS(THIS, "cmd_4c_BtnCarregar", 5)
2649:         ENDIF
2650:         IF PEMSTATUS(THIS, "cmd_4c_Btnexcluir", 5)
2651:         ENDIF
2652:     ENDPROC
2653: 
2654:     *--------------------------------------------------------------------------
2655:     * AjustarBotoesPorModo - OPERACIONAL: sem modos CRUD; no-op


### BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):
*==============================================================================
* SIGPRETQBO.PRG
* Business Object - Impressao de Etiquetas Selecionadas
* Form OPERACIONAL - cursor local dbImpressao, sem tabela principal
*==============================================================================

DEFINE CLASS SigPrEtqBO AS BusinessBase

    *-- Sem tabela principal (form operacional)
    this_cTabela       = ""
    this_cCampoChave   = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro / entrada do usuario
    *--------------------------------------------------------------------------
    this_cEmps         = ""    && Empresa (3 chars)
    this_cDopes        = ""    && Operacao (20 chars)
    this_nNumes        = 0     && Numero do documento
    this_cLPrecos      = ""    && Lista de precos 1 (30 chars)
    this_cLPrecos2     = ""    && Lista de precos 2 (30 chars)

    *--------------------------------------------------------------------------
    * Configuracao da etiqueta (SigCdPam)
    *--------------------------------------------------------------------------
    this_nMaxTpEtis    = 0     && Numero maximo de tipos de etiqueta
    this_nTpEtiPads    = 0     && Tipo de etiqueta padrao
    this_nMaxImpEti    = 0     && Numero maximo de impressoras
    this_nImpEtis      = 0     && Impressora padrao
    this_cTpInstalas   = ""    && Tipo de instalacao
    this_nAjVerts      = 0     && Ajuste vertical padrao (SigCdPam)
    this_nAjHorzs      = 0     && Ajuste horizontal padrao (SigCdPam)
    this_cTpCBars      = ""    && Tipo de codigo de barras

    *--------------------------------------------------------------------------
    * Configuracao adicional (SigCdPac)
    *--------------------------------------------------------------------------
    this_nAjDens       = 20   && Ajuste de densidade padrao
    this_nAjVelos      = 1    && Ajuste de velocidade padrao
    this_nEtqSeps      = 1    && Etiqueta separadora (1=Sim, 2=Nao)

    *--------------------------------------------------------------------------
    * Opcoes de impressao (espelham controles do form)
    *--------------------------------------------------------------------------
    this_nImpPreco     = 1    && Tipo de preco a imprimir (1-6, opt_Preco.Value)
    this_lImpSepar     = .T.  && Imprimir separadora (opt_separador=1)
    this_lImpPeso      = .T.  && Imprimir peso (opt_peso=1)
    this_lCompo        = .T.  && Imprimir composicao (optCompos=1)
    this_nTipo         = 1    && Indice do tipo de etiqueta (Opt_Tipo.Value)
    this_nTpEti        = 0    && ID do tipo de etiqueta (SigCdTpe.nTipos via Tag)
    this_nTpImp        = 1    && Tipo impressora (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
    this_nAjVertsPrint = 0    && Ajuste vertical para impressao (Spn_AjVerts.Value)
    this_nAjHorzsPrint = 0    && Ajuste horizontal para impressao (Spn_AjHorzs.Value)
    this_nAjDensPrint  = 20   && Densidade para impressao (Spn_AjDenss.Value)
    this_nAjVelosPrint = 1    && Velocidade para impressao (spn_AjVelos.Value)
    this_cNomeImp      = ""   && Nome da impressora selecionada (crImpreV.impres)
    this_nImpres       = 0    && Numero de registro da impressora (RECNO crImpreV)
    this_cLp1          = ""   && Lista de precos 1 (passada ao SigOpEtq)
    this_cLp2          = ""   && Lista de precos 2 (passada ao SigOpEtq)
    this_nOrdem        = 1    && Ordem de impressao (1=Produto, 2=Nenhuma)

    *--------------------------------------------------------------------------
    * Campos do cursor dbImpressao (linha corrente)
    *--------------------------------------------------------------------------
    this_cReffs        = ""    && Referencia do fornecedor (dbImpressao.Reffs)
    this_nQtds         = 0     && Quantidade (dbImpressao.Qtds)
    this_nQtdeEtiq     = 0     && Quantidade de etiquetas (dbImpressao.QtdeEtiq)
    this_cPedido       = ""    && Numero do pedido (dbImpressao.Pedido)
    this_cObs          = ""    && Obs / lista de precos usada (dbImpressao.Obs)
    this_nParcelas     = 0     && Numero de parcelas (dbImpressao.Parcelas)
    this_cCpros2       = ""    && Codigo produto 2 (dbImpressao.Cpros2)
    this_cCpros3       = ""    && Codigo produto 3 (dbImpressao.Cpros3)
    this_cCpros4       = ""    && Codigo produto 4 (dbImpressao.Cpros4)
    this_cEmpos        = ""    && Empresa (dbImpressao.empos)
    this_cEmpdopnums   = ""    && Chave emp+ope+num (dbImpressao.empdopnums)
    this_nCitens       = 0     && Numero do item (dbImpressao.citens)
    this_nPesos        = 0     && Peso do item (dbImpressao.Pesos)
    this_cCodTams      = ""    && Codigo do tamanho (dbImpressao.CodTams)

    *--------------------------------------------------------------------------
    * Produto corrente (validado no grid)
    *--------------------------------------------------------------------------
    this_cCpros        = ""   && Codigo do produto (SigCdPro.CPros)
    this_cDpros        = ""   && Descricao do produto (SigCdPro.DPros)
    this_cDpro2s       = ""   && Referencia do fornecedor (SigCdPro.Dpro2s)
    this_cCunis        = ""   && Unidade do produto (SigCdPro.CUnis)
    this_nPVens        = 0    && Preco de venda (SigCdPro.PVens)
    this_nPrecoDe      = 0    && Preco De (SigCdPro.PrecoDe)
    this_nPesoMs       = 0    && Peso do produto (SigCdPro.PesoMs)

    *--------------------------------------------------------------------------
    * INIT - Configura BO sem tabela principal (form operacional)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            DODEFAULT()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracao - Carrega SigCdPam e SigCdPac
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, " + ;
                       "TpInstalas, AjVerts, AjHorzs, TpCBars " + ;
                       "FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") > 0
                IF !EOF("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    THIS.this_nMaxTpEtis  = NVL(nMaxTpEtis, 7)
                    THIS.this_nTpEtiPads  = NVL(TpEtiPads,  1)
                    THIS.this_nMaxImpEti  = NVL(nMaxImpEti, 5)
                    THIS.this_nImpEtis    = NVL(ImpEtis,    1)
                    THIS.this_cTpInstalas = NVL(TpInstalas, "")
                    THIS.this_nAjVerts    = NVL(AjVerts,    0)
                    THIS.this_nAjHorzs    = NVL(AjHorzs,    0)
                    THIS.this_cTpCBars    = NVL(TpCBars,    "")

                    THIS.this_nAjVertsPrint = THIS.this_nAjVerts
                    THIS.this_nAjHorzsPrint = THIS.this_nAjHorzs
                ENDIF
                USE IN cursor_4c_SigCdPam
            ENDIF

            loc_cSQL = "SELECT AjDens, AjVelos, EtqSeps FROM SigCdPac"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") > 0
                IF !EOF("cursor_4c_SigCdPac")
                    SELECT cursor_4c_SigCdPac
                    THIS.this_nAjDens   = IIF(EMPTY(NVL(AjDens,  0)), 20, NVL(AjDens,  0))
                    THIS.this_nAjVelos  = IIF(EMPTY(NVL(AjVelos, 0)), 1,  NVL(AjVelos, 0))
                    THIS.this_nEtqSeps  = NVL(EtqSeps, 1)

                    THIS.this_nAjDensPrint  = THIS.this_nAjDens
                    THIS.this_nAjVelosPrint = THIS.this_nAjVelos
                ENDIF
                USE IN cursor_4c_SigCdPac
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarConfiguracao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Carrega SigCdTpe em cursor cursor_4c_TiposEti
    * Retorna: numero de tipos encontrados (0 se nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_nTipos, loc_oErro, loc_cSQL

        loc_nTipos = 0

        TRY
            loc_cSQL = "SELECT nTipos, cEtiquetas, cOrdems, nSituas " + ;
                       "FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposEti") > 0
                loc_nTipos = _TALLY
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarTiposEtiqueta")
            loc_nTipos = 0
        ENDTRY

        RETURN loc_nTipos
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras disponiveis para o usuario
    * Popula cursor_4c_ImpTemp com campo Impres C(50)
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoras()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario

        loc_lSucesso = .F.

        TRY
            loc_cUsuario = EscaparSQL(gc_4c_UsuarioLogado)

            loc_cSQL = "SELECT b.Impres FROM SigSyImp a " + ;
                       "INNER JOIN SigCdmp b ON a.CImps = b.Impres " + ;
                       "WHERE a.UsuAcess = " + loc_cUsuario + ;
                       " AND b.nTpImpres = 2 " + ;
                       "UNION ALL " + ;
                       "SELECT c.Impres FROM SigCdAcG a " + ;
                       "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
                       "INNER JOIN SigCdmp c ON b.CImps = c.Impres " + ;
                       "WHERE a.Usuarios = " + loc_cUsuario + ;
                       " AND c.nTpImpres = 2"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") <= 0
                loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;
                           "WHERE nTpImpres = 2 ORDER BY Impres"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarImpressoras")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorListaPrecos - Popula dbImpressao via SigCdLpi
    * par_cLPrecos:      codigo da lista de precos
    * par_lCarregarItens: se .T. insere itens no cursor dbImpressao
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorListaPrecos(par_cLPrecos, par_lCarregarItens)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nVal, loc_nValDe
        LOCAL loc_cCPros, loc_cDPros, loc_cLPrecosItem, loc_cSQLPro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cLPrecos), 30))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaIten") <= 0
                MsgErro("Falha ao carregar itens da lista de pre" + CHR(231) + "os.", ;
                        "Erro CarregarPorListaPrecos")
            ELSE
                IF par_lCarregarItens
                    SELECT cursor_4c_ListaIten
                    SCAN
                        loc_nVal        = NVL(PVens,   0)
                        loc_nValDe      = NVL(PrecoDe, 0)
                        loc_cCPros      = ALLTRIM(NVL(CPros,   ""))
                        loc_cDPros      = ALLTRIM(NVL(DPros,   ""))
                        loc_cLPrecosItem = ALLTRIM(NVL(LPrecos, ""))

                        IF !BETWEEN(DATETIME(), VencIs, VencFs)
                            loc_cSQLPro = "SELECT PVens, PrecoDe FROM SigCdPro " + ;
                                          "WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))

                            IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProTemp") > 0
                                IF !EOF("cursor_4c_ProTemp")
                                    SELECT cursor_4c_ProTemp
                                    loc_nVal   = NVL(PVens,   0)
                                    loc_nValDe = NVL(PrecoDe, 0)
                                ENDIF
                                USE IN cursor_4c_ProTemp
                                SELECT cursor_4c_ListaIten
                            ENDIF
                        ENDIF

                        INSERT INTO dbImpressao ;
                            (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
                            VALUES ;
                            (loc_cCPros, loc_cDPros, 1, 1, ;
                             loc_cLPrecosItem, loc_nVal, ;
                             go_4c_Sistema.cCodEmpresa, loc_nValDe)
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_ListaIten")
                    USE IN cursor_4c_ListaIten
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarPorListaPrecos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorMovimentacao - Popula dbImpressao via SigMvItn
    * par_cEmps:          empresa (3 chars)
    * par_cDopes:         operacao (20 chars)
    * par_nNumes:         numero do documento
    * par_lCarregarItens: se .T. insere itens no cursor dbImpressao
    * Retorna: numero de itens carregados (-1 em erro, 0 se nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorMovimentacao(par_cEmps, par_cDopes, par_nNumes, par_lCarregarItens)
        LOCAL loc_nItens, loc_oErro, loc_cEdn, loc_cSQL
        LOCAL loc_nVen, loc_nValDe, loc_nPes, loc_cSQLPro
        LOCAL loc_cCPros, loc_cDPros, loc_nQtds, loc_nCitens

        loc_nItens = -1

        TRY
            loc_cEdn = PADR(ALLTRIM(par_cEmps), 3) + ;
                       PADR(ALLTRIM(par_cDopes), 20) + ;
                       STR(par_nNumes, 6)

            loc_cSQL = "SELECT CPros, DPros, Units, Qtds, Citens " + ;
                       "FROM SigMvItn " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvIten") <= 0
                MsgErro("Falha ao carregar itens da movimenta" + CHR(231) + CHR(227) + "o.", ;
                        "Erro CarregarPorMovimentacao")
                loc_nItens = -1
            ELSE
                loc_nItens = _TALLY

                IF loc_nItens >= 1 AND par_lCarregarItens
                    SELECT cursor_4c_MvIten
                    SCAN
                        loc_nVen     = 0
                        loc_nValDe   = 0
                        loc_nPes     = 0
                        loc_cCPros   = ALLTRIM(NVL(CPros, ""))
                        loc_cDPros   = ALLTRIM(NVL(DPros, ""))
                        loc_nQtds    = NVL(Qtds,   0)
                        loc_nCitens  = NVL(Citens, 0)

                        loc_cSQLPro = "SELECT PVens, PesoMs, PrecoDe FROM SigCdPro " + ;
                                      "WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))

                        IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProLocal") > 0
                            IF !EOF("cursor_4c_ProLocal")
                                SELECT cursor_4c_ProLocal
                                IF NVL(PVens,   0) > 0
                                    loc_nVen   = PVens
                                ENDIF
                                IF NVL(PrecoDe, 0) > 0
                                    loc_nValDe = PrecoDe
                                ENDIF
                                IF NVL(PesoMs,  0) > 0
                                    loc_nPes   = PesoMs
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_ProLocal
                            SELECT cursor_4c_MvIten
                        ENDIF

                        INSERT INTO dbImpressao ;
                            (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, ;
                             empdopnums, citens, Pesos, PrecoDe) ;
                            VALUES ;
                            (loc_cCPros, loc_cDPros, ;
                             loc_nQtds, loc_nQtds, ;
                             loc_cEdn, loc_nVen, ;
                             go_4c_Sistema.cCodEmpresa, ;
                             loc_cEdn, loc_nCitens, loc_nPes, loc_nValDe)
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_MvIten")
                    USE IN cursor_4c_MvIten
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarPorMovimentacao")
            loc_nItens = -1
        ENDTRY

        RETURN loc_nItens
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarListaPrecoNoItem - Aplica preco da lista ao registro corrente
    * de dbImpressao (deve ser chamado com cursor dbImpressao posicionado)
    * par_cLPrecos: codigo da lista de precos
    * par_cCpros:   codigo do produto
    * Retorna: .T. se preco foi aplicado
    *--------------------------------------------------------------------------
    PROCEDURE AplicarListaPrecoNoItem(par_cLPrecos, par_cCpros)
        LOCAL loc_lAplicado, loc_oErro, loc_cSQL, loc_nVal, loc_nValDe
        LOCAL loc_cLPrecosAplic, loc_cSQLPro

        loc_lAplicado = .F.

        TRY
            loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(par_cLPrecos, 30)) + ;
                       " AND CPros = "   + EscaparSQL(PADR(par_cCpros,   14))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LpiItem") > 0
                SELECT cursor_4c_LpiItem
                GO TOP

                IF !EOF()
                    loc_nVal          = NVL(PVens,   0)
                    loc_nValDe        = NVL(PrecoDe, 0)
                    loc_cLPrecosAplic = ALLTRIM(NVL(LPrecos, ""))

                    IF !BETWEEN(DATETIME(), VencIs, VencFs)
                        loc_cSQLPro = "SELECT PVens, PrecoDe FROM SigCdPro " + ;
                                      "WHERE CPros = " + EscaparSQL(PADR(par_cCpros, 14))

                        IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProPreco") > 0
                            IF !EOF("cursor_4c_ProPreco")
                                SELECT cursor_4c_ProPreco
                                loc_nVal   = NVL(PVens,   0)
                                loc_nValDe = NVL(PrecoDe, 0)
                            ENDIF
                            USE IN cursor_4c_ProPreco
                            SELECT cursor_4c_LpiItem
                        ENDIF
                    ENDIF

                    USE IN cursor_4c_LpiItem

                    REPLACE Obs     WITH loc_cLPrecosAplic, ;
                            PVens   WITH loc_nVal, ;
                            PrecoDe WITH loc_nValDe ;
                            IN dbImpressao

                    loc_lAplicado = .T.
                ELSE
                    USE IN cursor_4c_LpiItem
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro AplicarListaPrecoNoItem")
        ENDTRY

        RETURN loc_lAplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorCodigo - Valida / resolve CPros no SigCdPro
    * Suporta EAN13 (numerico) e pesquisa por CBars e CPros direto
    * Preenche props this_cCpros, this_cDpros, this_nPVens, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorCodigo(par_cValor)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL, loc_nCod, loc_cValorResolvido

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cValor)
                loc_cValorResolvido = par_cValor

                *-- Tentativa 1: resolver como EAN13
                loc_nCod = INT(VAL(par_cValor))
                IF loc_nCod > 0
                    loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro " + ;
                               "WHERE Ean13 = " + FormatarNumeroSQL(loc_nCod)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrEan") > 0
                        IF !EOF("cursor_4c_PrEan")
                            SELECT cursor_4c_PrEan
                            loc_cValorResolvido = ALLTRIM(CPros)
                        ENDIF
                        USE IN cursor_4c_PrEan
                    ENDIF
                ENDIF

                *-- Tentativa 2: resolver como codigo de barras (CBars)
                IF LEN(ALLTRIM(par_cValor)) <= 14
                    loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro " + ;
                               "WHERE CBars = " + FormatarNumeroSQL(INT(VAL(par_cValor)))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrBars") > 0
                        IF !EOF("cursor_4c_PrBars")
                            SELECT cursor_4c_PrBars
                            loc_cValorResolvido = ALLTRIM(CPros)
                        ENDIF
                        USE IN cursor_4c_PrBars
                    ENDIF
                ENDIF

                *-- Buscar dados completos por CPros resolvido
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE CPros = " + EscaparSQL(PADR(loc_cValorResolvido, 14))

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrDados") > 0
                    IF !EOF("cursor_4c_PrDados")
                        SELECT cursor_4c_PrDados
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrDados
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorCodigo")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorDescricao - Resolve DPros direto (busca exata)
    * Preenche props this_cCpros, this_cDpros, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorDescricao(par_cDpros)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cDpros)
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE DPros = " + EscaparSQL(par_cDpros)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrDescr") > 0
                    IF !EOF("cursor_4c_PrDescr")
                        SELECT cursor_4c_PrDescr
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrDescr
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorDescricao")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorReferencia - Resolve Dpro2s direto (busca exata)
    * Preenche props this_cCpros, this_cDpros, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorReferencia(par_cDpro2s)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cDpro2s)
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE Dpro2s = " + EscaparSQL(par_cDpro2s)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrRef") > 0
                    IF !EOF("cursor_4c_PrRef")
                        SELECT cursor_4c_PrRef
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrRef
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorReferencia")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEtiquetaIndividual - Verifica se produto usa etiqueta individual
    * Retorna: .T. se produto usa etiqueta individual E nao permite duplicata
    * (o form bloqueia a impressao desse produto nesse caso)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEtiquetaIndividual(par_cCpros)
        LOCAL loc_lEtqIndividual, loc_oErro, loc_cSQL

        loc_lEtqIndividual = .F.

        TRY
            IF !EMPTY(par_cCpros)
                loc_cSQL = "SELECT u.Etiqs, u.EtiqDups " + ;
                           "FROM SigCdPro p " + ;
                           "INNER JOIN SigCdUni u ON p.CUnis = u.CUnis " + ;
                           "WHERE p.CPros = " + EscaparSQL(PADR(par_cCpros, 14))

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniEtq") > 0
                    IF !EOF("cursor_4c_UniEtq")
                        SELECT cursor_4c_UniEtq
                        IF ALLTRIM(NVL(Etiqs, "")) = "S" AND NVL(EtiqDups, 0) <> 1
                            loc_lEtqIndividual = .T.
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_UniEtq
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro VerificarEtiquetaIndividual")
        ENDTRY

        RETURN loc_lEtqIndividual
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNDopesParaBOP - Busca NDopes de SigCdOpe para montar codigo BOP
    * Retorna: string NDopes (4 chars padded) ou "" se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterNDopesParaBOP(par_cDopes)
        LOCAL loc_cNDopes, loc_oErro, loc_cSQL

        loc_cNDopes = ""

        TRY
            IF !EMPTY(par_cDopes)
                loc_cSQL = "SELECT TOP 1 NDopes FROM SigCdOpe " + ;
                           "WHERE Dopes = " + EscaparSQL(par_cDopes)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeNDop") > 0
                    IF !EOF("cursor_4c_OpeNDop")
                        SELECT cursor_4c_OpeNDop
                        IF !EMPTY(NVL(NDopes, 0))
                            loc_cNDopes = PADL(TRANSFORM(NVL(NDopes, 0)), 4, "0")
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_OpeNDop
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ObterNDopesParaBOP")
        ENDTRY

        RETURN loc_cNDopes
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirEtiquetas - Chama SigOpEtq com os parametros de impressao
    * Retorna: .T. se impressao concluida com sucesso (incluindo Commit)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirEtiquetas()
        LOCAL loc_lSucesso, loc_oErro, loc_cBop, loc_cNDopes

        loc_lSucesso = .F.

        TRY
            loc_cBop = ""
            IF !EMPTY(THIS.this_cDopes) AND THIS.this_nNumes > 0
                loc_cNDopes = THIS.ObterNDopesParaBOP(THIS.this_cDopes)
                IF !EMPTY(loc_cNDopes)
                    loc_cBop = loc_cNDopes + PADL(TRANSFORM(THIS.this_nNumes), 6, "0")
                ENDIF
            ENDIF

            =SigOpEtq(gnConnHandle, ;
                      THIS.this_nImpPreco, ;
                      THIS.this_lImpSepar, ;
                      THIS.this_nTpEti, ;
                      THIS.this_nTpImp, ;
                      THIS.this_nAjVertsPrint, ;
                      THIS.this_nAjHorzsPrint, ;
                      THIS.this_nAjDensPrint, ;
                      .NULL., .NULL., .NULL., ;
                      THIS.this_cNomeImp, ;
                      .NULL., .NULL., ;
                      THIS.this_nAjVelosPrint, ;
                      THIS.this_lImpPeso, ;
                      loc_cBop, ;
                      THIS.this_cLp1, ;
                      THIS.this_cLp2, ;
                      .F., .F., ;
                      THIS.this_lCompo)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ImprimirEtiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades BO a partir de um alias de cursor
    * par_cAliasCursor: alias do cursor (normalmente "dbImpressao")
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCpros       = ALLTRIM(NVL(Cpros,       ""))
                THIS.this_cDpros       = ALLTRIM(NVL(DPros,       ""))
                THIS.this_cReffs       = ALLTRIM(NVL(Reffs,       ""))
                THIS.this_nQtds        = NVL(Qtds,      0)
                THIS.this_nQtdeEtiq    = NVL(QtdeEtiq,  0)
                THIS.this_cPedido      = ALLTRIM(NVL(Pedido,      ""))
                THIS.this_cObs         = ALLTRIM(NVL(Obs,         ""))
                THIS.this_nPVens       = NVL(PVens,     0)
                THIS.this_nPrecoDe     = NVL(PrecoDe,   0)
                THIS.this_nParcelas    = NVL(Parcelas,  0)
                THIS.this_cCpros2      = ALLTRIM(NVL(Cpros2,      ""))
                THIS.this_cCpros3      = ALLTRIM(NVL(Cpros3,      ""))
                THIS.this_cCpros4      = ALLTRIM(NVL(Cpros4,      ""))
                THIS.this_cEmpos       = ALLTRIM(NVL(empos,       ""))
                THIS.this_cEmpdopnums  = ALLTRIM(NVL(empdopnums,  ""))
                THIS.this_nCitens      = NVL(citens,    0)
                THIS.this_nPesos       = NVL(Pesos,     0)
                THIS.this_cCodTams     = ALLTRIM(NVL(CodTams,     ""))
                THIS.this_cDpro2s      = ALLTRIM(NVL(DPro2s,      ""))

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Adiciona nova linha ao cursor local dbImpressao
    * Retorna: .T. se inserido com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("dbImpressao")
                INSERT INTO dbImpressao ;
                    (Cpros, DPros, Reffs, Qtds, QtdeEtiq, ;
                     Pedido, Obs, PVens, PrecoDe, Parcelas, ;
                     Cpros2, Cpros3, Cpros4, empos, empdopnums, ;
                     citens, Pesos, CodTams, DPro2s) ;
                    VALUES ;
                    (THIS.this_cCpros, THIS.this_cDpros, THIS.this_cReffs, ;
                     THIS.this_nQtds, THIS.this_nQtdeEtiq, ;
                     THIS.this_cPedido, THIS.this_cObs, THIS.this_nPVens, ;
                     THIS.this_nPrecoDe, THIS.this_nParcelas, ;
                     THIS.this_cCpros2, THIS.this_cCpros3, THIS.this_cCpros4, ;
                     THIS.this_cEmpos, THIS.this_cEmpdopnums, ;
                     THIS.this_nCitens, THIS.this_nPesos, ;
                     THIS.this_cCodTams, THIS.this_cDpro2s)

                THIS.RegistrarAuditoria("I")

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza linha corrente do cursor local dbImpressao
    * Retorna: .T. se atualizado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("dbImpressao") AND !EOF("dbImpressao")
                SELECT dbImpressao

                REPLACE Cpros       WITH THIS.this_cCpros, ;
                        DPros       WITH THIS.this_cDpros, ;
                        Reffs       WITH THIS.this_cReffs, ;
                        Qtds        WITH THIS.this_nQtds, ;
                        QtdeEtiq    WITH THIS.this_nQtdeEtiq, ;
                        Pedido      WITH THIS.this_cPedido, ;
                        Obs         WITH THIS.this_cObs, ;
                        PVens       WITH THIS.this_nPVens, ;
                        PrecoDe     WITH THIS.this_nPrecoDe, ;
                        Parcelas    WITH THIS.this_nParcelas, ;
                        Cpros2      WITH THIS.this_cCpros2, ;
                        Cpros3      WITH THIS.this_cCpros3, ;
                        Cpros4      WITH THIS.this_cCpros4, ;
                        empos       WITH THIS.this_cEmpos, ;
                        empdopnums  WITH THIS.this_cEmpdopnums, ;
                        citens      WITH THIS.this_nCitens, ;
                        Pesos       WITH THIS.this_nPesos, ;
                        CodTams     WITH THIS.this_cCodTams, ;
                        DPro2s      WITH THIS.this_cDpro2s

                THIS.RegistrarAuditoria("A")

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o codigo do produto corrente em dbImpressao
    * Form OPERACIONAL: usa CPros como identificador do item corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = ""

        IF USED("dbImpressao") AND !EOF("dbImpressao")
            SELECT dbImpressao
            loc_cChave = ALLTRIM(NVL(Cpros, ""))
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Form OPERACIONAL sem tabela principal
    * Sem persistencia em LogAuditoria (cursor local nao eh auditavel)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

ENDDEFINE

