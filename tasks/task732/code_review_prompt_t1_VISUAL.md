# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEtq.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1743 linhas total):

*-- Linhas 73 a 93:
73: *   TornarControlesVisiveis               AddObject nasce com Visible = .F.
74: *   Destroy                               solta as referencias e repoe o menu
75: *
76: * ESCOPO DA FASE 4/8 - GRADE E BOTOES
77: * ------------------------------------
78: *   ConfigurarGrade                       grd_4c_Dados - geometria e aparencia
79: *                                         transcritas do dump
80: *   VincularGrade                         o vinculo de dados da grade em UM
81: *                                         bloco: ColumnCount / RecordSource /
82: *                                         ControlSource / headers / larguras /
83: *                                         ReadOnly das 4 colunas
84: *   CarregarDados                         o funil UNICO de carga e repintura -
85: *                                         o Select / Go Top / Grade.Refresh que
86: *                                         o legado repete no Init e no
87: *                                         GetBusca.LostFocus
88: *   ConfigurarBotoes                      cmd_4c_Saida, obj_4c_CmdEtiquetas e
89: *                                         obj_4c_CmdImprimir - so geometria,
90: *                                         sem Click/Valid (ver abaixo)
91: *
92: * O funil (CarregarDados) e o vinculo (VincularGrade) sao DOIS metodos e nao
93: * um: o vinculo eh caro e so precisa ser reaplicado quando o alias muda, e

*-- Linhas 99 a 107:
99: * ESCOPO DA FASE 5/8 - CAMPOS
100: * ----------------------------
101: *   ConfigurarContainerProcurar           Cnt_Procurar agora COM os dois
102: *                                         filhos: lbl_4c_Label4 ("Barra  :")
103: *                                         e txt_4c_Busca (o GetBusca do
104: *                                         legado) - geometria, fonte, cor e
105: *                                         Format transcritos do dump e da
106: *                                         classe fwget
107: *

*-- Linhas 395 a 404:
395:     * Legado (SIGOPETQ.Init), transcrito linha a linha:
396:     *
397:     *   Lparameters pForm
398:     *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
399:     *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
400:     *   ThisForm.poDataMgr = pForm.poDataMgr
401:     *   Select csRelatorio
402:     *   Go Top
403:     *   ThisForm.Grade.Refresh
404:     *   ThisForm.Grade.Column1.Text1.SetFocus

*-- Linhas 454 a 462:
454:             *-- Atribuido tambem a this_cTituloForm: FormBase.Init repoe o
455:             *-- Caption a partir dela antes de chamar InicializarForm, entao
456:             *-- as duas tem de concordar.
457:             THIS.Caption = "Consulta Etiquetas n" + CHR(227) + "o lidas"
458:             THIS.this_cTituloForm = THIS.Caption
459: 
460:             *-- Legado: Thisform.Tipo / Thisform.Op_Escolha = DIVERSAS
461:             THIS.this_cTipo      = "DIVERSAS"
462:             THIS.this_cOpEscolha = "DIVERSAS"

*-- Linhas 624 a 634:
624: 
625:             THIS.ConfigurarPageFrame()
626: 
627:             *-- Legado: lblSombra.Caption / lblTitulo.Caption = ThisForm.Caption
628:             THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
629:             THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
630: 
631:             *-- AddObject cria tudo com Visible = .F.
632:             THIS.TornarControlesVisiveis(THIS)
633: 
634:             *-- Legado: ThisForm.cmdEtiquetas.Visible = fChecaAcesso(...).

*-- Linhas 710 a 780:
710:     * linha so (regra CLAUDE.md #23). As Width/Height aqui ja sao as que o
711:     * Form Designer calculou, entao fixa-las eh reproducao fiel.
712:     *
713:     * ForeColor BRANCO em lbl_4c_LblTitulo eh uma das excecoes legitimas da
714:     * regra CLAUDE.md #12: o container eh OPACO e escuro (BackStyle = 1 +
715:     * BackColor RGB(100,100,100)), nao a textura clara das paginas de
716:     * cadastro.
717:     *
718:     * Os nomes migrados vem de tasks/task732/mapeamento.json (cntSombra ->
719:     * cnt_4c_Sombra, lblSombra -> lbl_4c_LblSombra, lblTitulo ->
720:     * lbl_4c_LblTitulo): eh esse arquivo que a validacao de fidelidade de UI
721:     * consulta, entao divergir dele reprovaria a tela sem haver defeito
722:     * visual. Oito outros forms do projeto chamam a faixa de cnt_4c_Sombra -
723:     * o que a regra CLAUDE.md #11 proibe eh DETECTAR cabecalho por nome, nunca
724:     * usar o nome que o mapeamento ja fixou.
725:     *==========================================================================
726:     PROTECTED PROCEDURE ConfigurarCabecalho()
727:         THIS.AddObject("cnt_4c_Sombra", "Container")
728:         WITH THIS.cnt_4c_Sombra
729:             .Top           = 0
730:             .Left          = 0
731:             .Width         = THIS.Width
732:             .Height        = 80
733:             .BackStyle     = 1
734:             .BackColor     = RGB(100, 100, 100)
735:             .BorderWidth   = 0
736:             .SpecialEffect = 0
737:             .Visible       = .T.
738:         ENDWITH
739: 
740:         *-- lblSombra: sombra preta, desenhada 1px abaixo do titulo
741:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
742:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
743:             .Top           = 18
744:             .Left          = 10
745:             .Width         = THIS.Width - 20
746:             .Height        = 40
747:             .AutoSize      = .F.
748:             .BackStyle     = 0
749:             .WordWrap      = .T.
750:             .Alignment     = 0
751:             .FontName      = "Tahoma"
752:             .FontSize      = 18
753:             .FontBold      = .T.
754:             .FontUnderline = .F.
755:             .ForeColor     = RGB(0, 0, 0)
756:             .Caption       = THIS.Caption
757:             .Visible       = .T.
758:         ENDWITH
759: 
760:         *-- lblTitulo: texto branco por cima da sombra
761:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
762:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
763:             .Top         = 17
764:             .Left        = 10
765:             .Width       = THIS.Width - 20
766:             .Height      = 46
767:             .AutoSize    = .F.
768:             .BackStyle   = 0
769:             .WordWrap    = .T.
770:             .Alignment   = 0
771:             .FontName    = "Tahoma"
772:             .FontSize    = 18
773:             .FontBold    = .T.
774:             .ForeColor   = RGB(255, 255, 255)
775:             .Caption     = THIS.Caption
776:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
777:             .Visible     = .T.
778:         ENDWITH
779:     ENDPROC
780: 

*-- Linhas 798 a 807:
798:     PROTECTED PROCEDURE ConfigurarMoldura()
799:         THIS.AddObject("shp_4c_Shape1", "Shape")
800:         WITH THIS.shp_4c_Shape1
801:             .Top           = 9
802:             .Left          = 548
803:             .Width         = 73
804:             .Height        = 55
805:             .BackStyle     = 0
806:             .BorderStyle   = 0
807:             .SpecialEffect = 0

*-- Linhas 840 a 861:
840:     * Column e Text1) - o dump legado declara a grade inteira somente
841:     * leitura, e o BO (SigOpEtqBO, cabecalho do arquivo) documenta o mesmo:
842:     * esta tela so EXIBE o cursor que o chamador montou.
843:     *==========================================================================
844:     PROTECTED PROCEDURE ConfigurarGrade()
845:         THIS.AddObject("grd_4c_Dados", "Grid")
846:         WITH THIS.grd_4c_Dados
847:             .Top           = 143
848:             .Left          = 4
849:             .Width         = 622
850:             .Height        = 378
851:             .FontName      = "Tahoma"
852:             .FontSize      = 8
853:             .TabIndex      = 1
854:             .Panel         = 1
855:             .GridLineColor = RGB(238, 238, 238)
856:             .RowHeight     = 16
857:             .ScrollBars    = 2
858:             .DeleteMark    = .F.
859:             .RecordMark    = .F.
860: 
861:             *-- ReadOnly do GRID vem ANTES do ReadOnly de cada COLUNA

*-- Linhas 872 a 892:
872:         *-- repintura (CarregarDados) precisa reaplicar quando o alias do pai
873:         *-- muda, e manter duas copias faria as duas divergirem na primeira
874:         *-- vez que alguem mexesse em uma delas.
875:         THIS.VincularGrade()
876: 
877:         THIS.grd_4c_Dados.Visible = .T.
878:     ENDPROC
879: 
880:     *==========================================================================
881:     * VincularGrade - liga a grade ao cursor resolvido (bloco UNICO do vinculo)
882:     *
883:     * Reune TODO o vinculo de dados da grade, na ordem obrigatoria (Problema 2
884:     * de FORMCOR_LICOES_APRENDIDAS + regra CLAUDE.md #41):
885:     *
886:     *   ColumnCount -> RecordSource -> ControlSource -> Header1.Caption -> Width
887:     *
888:     * A ordem nao eh estilo: RecordSource e ControlSource RESETAM os headers
889:     * para o default Column1..Column4 e devolvem as larguras ao default 90,
890:     * entao caption e largura tem de ser (re)escritos DEPOIS deles. Por isso
891:     * tambem o ReadOnly das colunas vem aqui e nao em ConfigurarGrade.
892:     *

*-- Linhas 927 a 969:
927: 
928:         loc_lSucesso = .F.
929:         loc_cCursor  = ALLTRIM(THIS.this_cCursorGrade)
930: 
931:         IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
932:             WITH THIS.grd_4c_Dados
933:                 *-- ColumnCount ANTES de RecordSource, e so se precisar
934:                 IF .ColumnCount != 4
935:                     .ColumnCount = 4
936:                 ENDIF
937: 
938:                 .RecordSource = loc_cCursor
939: 
940:                 *-- ControlSource de cada coluna
941:                 .Column1.ControlSource = loc_cCursor + ".CBars"
942:                 .Column2.ControlSource = loc_cCursor + ".Datas"
943:                 .Column3.ControlSource = loc_cCursor + ".DPros"
944:                 .Column4.ControlSource = loc_cCursor + ".pLocals"
945: 
946:                 *-- Headers RECONFIGURADOS imediatamente apos o ControlSource
947:                 *-- (RecordSource/ControlSource resetam Header1.Caption para o
948:                 *-- default ColumnN)
949:                 .Column1.Header1.Caption   = "Barra"
950:                 .Column1.Header1.Alignment = 2
951:                 .Column1.Header1.FontName  = "Tahoma"
952:                 .Column1.Header1.FontSize  = 8
953: 
954:                 .Column2.Header1.Caption   = "Data Entrada"
955:                 .Column2.Header1.Alignment = 2
956:                 .Column2.Header1.FontName  = "Tahoma"
957:                 .Column2.Header1.FontSize  = 8
958: 
959:                 .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
960:                 .Column3.Header1.Alignment = 2
961:                 .Column3.Header1.FontName  = "Tahoma"
962:                 .Column3.Header1.FontSize  = 8
963: 
964:                 .Column4.Header1.Caption   = "Local"
965:                 .Column4.Header1.Alignment = 2
966:                 .Column4.Header1.FontName  = "Tahoma"
967:                 .Column4.Header1.FontSize  = 8
968: 
969:                 *-- Width por ULTIMO (o mesmo reset de RecordSource/

*-- Linhas 1119 a 1166:
1119:             *-- 1) o alias do chamador pode ter mudado entre duas visitas
1120:             THIS.ResolverCursorDaGrade()
1121:             THIS.this_oBusinessObject.GarantirCursorRelatorio()
1122: 
1123:             loc_cCursor = ALLTRIM(THIS.this_cCursorGrade)
1124:             loc_cLigado = ALLTRIM(THIS.grd_4c_Dados.RecordSource)
1125: 
1126:             *-- 2) religa so se o vinculo nao eh mais o alias certo
1127:             IF EMPTY(loc_cLigado) OR UPPER(loc_cLigado) != UPPER(loc_cCursor)
1128:                 THIS.VincularGrade()
1129:             ENDIF
1130: 
1131:             *-- 3) Go Top do legado - SO quando par_lReposicionar (ver acima)
1132:             IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
1133:                 IF loc_lReposicionar
1134:                     THIS.this_oBusinessObject.PosicionarPrimeiro()
1135:                 ENDIF
1136:                 loc_lSucesso = .T.
1137:             ENDIF
1138: 
1139:             *-- 4) Grade.Refresh do legado - o passo que de fato pinta
1140:             THIS.grd_4c_Dados.Refresh()
1141: 
1142:             *-- SetFocus do legado, sob guarda de visibilidade (ver acima).
1143:             *-- O EOF fica num IF ANINHADO, nao num AND na mesma linha: EOF()
1144:             *-- sobre alias vazio/inexistente ESTOURA "Alias is not found"
1145:             *-- (medido no VFP9), e o aninhamento garante que ele so eh
1146:             *-- alcancado quando loc_lSucesso provou que o alias esta aberto -
1147:             *-- sem depender de o VFP curto-circuitar o AND.
1148:             IF loc_lSucesso AND THIS.Visible
1149:                 IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
1150:                     IF !EOF(loc_cCursor)
1151:                         THIS.grd_4c_Dados.SetFocus()
1152:                     ENDIF
1153:                 ENDIF
1154:             ENDIF
1155:         CATCH TO loc_oErro
1156:             loc_lSucesso = .F.
1157:             THIS.this_cMensagemErro = loc_oErro.Message
1158:             MsgErro(loc_oErro.Message + CHR(13) + ;
1159:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1160:                 "Procedure: " + loc_oErro.Procedure, ;
1161:                 "Erro em FormSigOpEtq.CarregarDados")
1162:         ENDTRY
1163: 
1164:         RETURN loc_lSucesso
1165:     ENDPROC
1166: 

*-- Linhas 1214 a 1278:
1214:     *==========================================================================
1215:     PROTECTED PROCEDURE ConfigurarBotoes()
1216:         *-- Botao de saida (Sa?da do legado)
1217:         THIS.AddObject("cmd_4c_Saida", "CommandButton")
1218:         WITH THIS.cmd_4c_Saida
1219:             .Top        = 4
1220:             .Left       = 553
1221:             .Width      = 75
1222:             .Height     = 75
1223:             .FontName   = "Comic Sans MS"
1224:             .FontSize   = 8
1225:             .FontBold   = .T.
1226:             .FontItalic = .T.
1227:             .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1228:             .Caption    = "<Esc> Sair"
1229:             .Cancel     = .T.
1230:             .TabIndex   = 3
1231:             .ForeColor  = RGB(90, 90, 90)
1232:             .BackColor  = RGB(255, 255, 255)
1233:             .Themes           = .T.
1234:             .Visible    = .T.
1235:         ENDWITH
1236: 
1237:         *-- cmdEtiquetas: CommandGroup com 1 botao interno (btnEtiquetas)
1238:         THIS.AddObject("obj_4c_CmdEtiquetas", "CommandGroup")
1239:         WITH THIS.obj_4c_CmdEtiquetas
1240:             .Top         = -1
1241:             .Left        = 398
1242:             .Width       = 85
1243:             .Height      = 85
1244:             .ButtonCount = 1
1245:             .AutoSize    = .T.
1246:             .BackStyle   = 0
1247:             .BorderStyle = 0
1248:             .Value       = 1
1249:             .TabIndex    = 64
1250:             .Visible     = .T.
1251:         ENDWITH
1252: 
1253:         WITH THIS.obj_4c_CmdEtiquetas.Buttons(1)
1254:             .Top        = 5
1255:             .Left       = 5
1256:             .Width      = 75
1257:             .Height     = 75
1258:             .FontName   = "Comic Sans MS"
1259:             .FontSize   = 8
1260:             .FontBold   = .T.
1261:             .FontItalic = .T.
1262:             .Picture    = gc_4c_CaminhoIcones + "geral_etiqueta_26.jpg"
1263:             .Caption    = "\<Etiquetas"
1264:             .ForeColor  = RGB(90, 90, 90)
1265:             .BackColor  = RGB(255, 255, 255)
1266:             .Themes     = .F.
1267:         ENDWITH
1268: 
1269:         *-- cmdImprimir: CommandGroup com 1 botao interno (btnImprimir)
1270:         THIS.AddObject("obj_4c_CmdImprimir", "CommandGroup")
1271:         WITH THIS.obj_4c_CmdImprimir
1272:             .Top         = -1
1273:             .Left        = 473
1274:             .Width       = 85
1275:             .Height      = 85
1276:             .ButtonCount = 1
1277:             .AutoSize    = .T.
1278:             .BackStyle   = 0

*-- Linhas 1284 a 1301:
1284: 
1285:         WITH THIS.obj_4c_CmdImprimir.Buttons(1)
1286:             .AutoSize   = .F.
1287:             .Top        = 5
1288:             .Left       = 5
1289:             .Width      = 75
1290:             .Height     = 75
1291:             .FontName   = "Comic Sans MS"
1292:             .FontSize   = 8
1293:             .FontBold   = .T.
1294:             .FontItalic = .T.
1295:             .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_32.jpg"
1296:             .Caption    = "\<Imprimir"
1297:             .ForeColor  = RGB(90, 90, 90)
1298:             .BackColor  = RGB(255, 255, 255)
1299:             .Themes     = .F.
1300:         ENDWITH
1301:     ENDPROC

*-- Linhas 1324 a 1336:
1324:     * OS DOIS FILHOS - a superficie de campos inteira desta tela
1325:     * ----------------------------------------------------------
1326:     * Nomes migrados de tasks/task732/mapeamento.json (Label4 ->
1327:     * lbl_4c_Label4, GetBusca -> txt_4c_Busca): eh esse arquivo que a
1328:     * validacao de fidelidade de UI consulta, entao divergir dele reprovaria a
1329:     * tela sem haver defeito visual.
1330:     *
1331:     * lbl_4c_Label4 - TRANSCRITO de SIGOPETQ.Cnt_Procurar.Label4: Top 17 /
1332:     * Left 11 / Width 43 / Height 17 / Tahoma 8 / ForeColor 90,90,90 /
1333:     * TabIndex 10 / Caption "Barra  :" (com os DOIS espacos antes dos dois
1334:     * pontos, como o legado escreve).
1335:     *
1336:     *   Alignment = 0 EXPLICITO, nunca 1: o rotulo vai da esquerda para a

*-- Linhas 1394 a 1433:
1394:     PROTECTED PROCEDURE ConfigurarContainerProcurar()
1395:         THIS.AddObject("cnt_4c__Procurar", "Container")
1396:         WITH THIS.cnt_4c__Procurar
1397:             .Top           = 86
1398:             .Left          = 5
1399:             .Width         = 174
1400:             .Height        = 54
1401:             .SpecialEffect = 0
1402:             .TabIndex      = 2
1403:             .Visible       = .T.
1404:         ENDWITH
1405: 
1406:         *-- Label4: a legenda do campo de busca. Criado ANTES do campo, como
1407:         *-- no dump - AddObject desenha o ultimo objeto por cima.
1408:         THIS.cnt_4c__Procurar.AddObject("lbl_4c_Label4", "Label")
1409:         WITH THIS.cnt_4c__Procurar.lbl_4c_Label4
1410:             .Top       = 17
1411:             .Left      = 11
1412:             .Width     = 43
1413:             .Height    = 17
1414:             .AutoSize  = .F.
1415:             .Alignment = 0
1416:             .FontName  = "Tahoma"
1417:             .FontSize  = 8
1418:             .ForeColor = RGB(90, 90, 90)
1419:             .Caption   = "Barra  :"
1420:             .TabIndex  = 10
1421:             .Visible   = .T.
1422:         ENDWITH
1423: 
1424:         *-- GetBusca: o campo de codigo de barras (classe fwget no legado)
1425:         THIS.cnt_4c__Procurar.AddObject("txt_4c_Busca", "TextBox")
1426:         WITH THIS.cnt_4c__Procurar.txt_4c_Busca
1427:             .Top               = 15
1428:             .Left              = 56
1429:             .Width             = 108
1430:             .Height            = 23
1431:             .FontName          = "Tahoma"
1432:             .FontSize          = 8
1433:             .Format            = "K"

*-- Linhas 1522 a 1530:
1522:     PROTECTED PROCEDURE ConfigurarEventos()
1523:         BINDEVENT(THIS.cnt_4c__Procurar.txt_4c_Busca, "LostFocus", ;
1524:             THIS, "ValidarBusca")
1525:         BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "BtnSaidaClick")
1526:         BINDEVENT(THIS.obj_4c_CmdEtiquetas.Buttons(1), "Click", ;
1527:             THIS, "BtnEtiquetasClick")
1528:         BINDEVENT(THIS.obj_4c_CmdImprimir.Buttons(1), "Click", ;
1529:             THIS, "BtnImprimirClick")
1530:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigOpEtqBO.prg):
*==============================================================================
* SigOpEtqBO.prg
*
* Business Object para SigOpEtq (Consulta Etiquetas nao lidas)
*
* Tabela SigOpEtq EXISTE no schema (PK cbars numeric(14,0)), mas este BO nao
* a consulta nem a grava. SigOpEtq.SCX eh o dialogo FILHO que o RELATORIO DE
* INVENTARIO (SIGREINR) abre quando o usuario escolhe o tipo de relatorio 5:
*
*     Do Form SigOpEtq With ThisForm
*
* CORRECAO DE FATO (fase final da task732): este cabecalho dizia, desde a
* Fase 1, que o pai era o "SigMvCab, movimentacao de itens", e citava
* sigmvcab.SCT. Estava ERRADO - foi palpite feito antes de o chamador ser
* procurado. Varridos os dumps de tasks\, a linha "Do Form SigOpEtq With
* ThisForm" aparece em UM unico arquivo, tasks\task125\
* sigreinr_form_codigo_fonte.txt, em quatro metodos dele (visualizacao,
* memail, impressao e documento), sempre no ramo TipoRelatorio.Value = 5.
* O SigMvCab nao chama esta tela em lugar nenhum. Deixar a frase antiga
* mandaria quem fosse diagnosticar a tela abrir o form errado.
*
* O form legado recebe UM parametro (pForm = form PAI), copia
* pForm.poDataMgr para si mesmo e liga a grade a um cursor que o PAI JA
* montou. O nome desse alias NAO eh "cursor_4c_Relatorio": o chamador
* migrado (sigreinrBO) PRESERVOU o nome legado e publica
* this_cCursorDados = "CsRelatorio". O valor abaixo eh so o DEFAULT para
* quando a tela eh instanciada fora do fluxo do chamador - quem resolve o
* alias de verdade eh FormSigOpEtq.ResolverCursorDaGrade(), em runtime, e
* escreve o resultado nesta property. Nao ha
* NENHUM SQLEXEC/AddCursor/Select...Into Cursor dentro do dump de SigOpEtq -
* confirmado em tasks\task732\comportamento.json (sqlQueries: [], totalQueries:
* 0). O Init so faz "Select csRelatorio / Go Top / Grade.Refresh".
*
* Dai o escopo deste BO: ele NAO consulta SigOpEtq (nem SigCdPro, de onde vem
* a descricao exibida na grade). Quem monta e popula o cursor eh o form PAI,
* antes de abrir esta tela. Tudo o que este BO faz eh LEITURA/NAVEGACAO no
* cursor recebido:
*
*   SIGOPETQ.Init                 copia Caption para os 2 labels da faixa,
*                                 liga poDataMgr, reposiciona a grade (Go Top
*                                 + Refresh) e foca a 1a celula
*   GetBusca.Valid                Seek por codigo de barras (CBars) no
*                                 cursor; nao achando, volta para o Recno
*                                 anterior (NAO limpa nem avisa)
*   GetBusca.LostFocus            Grade.Refresh + foca a 1a celula de novo
*   cmdEtiquetas (btnEtiquetas)   Do Form SigOpIpE With ThisForm (dialogo
*                                 NETO, cujo SCX segue em ProximasMigracoes\
*                                 - fora do escopo desta task)
*   cmdImprimir (btnImprimir)     Do Form SigMvDoc With SIGOPETQ + titulo
*                                 (impressao via form generico de documentos;
*                                 no sistema novo o ramo generico eh
*                                 FormSigOpEtqDoc, e os dois argumentos vem
*                                 das properties this_cArquivoRelatorio e
*                                 this_cTituloRelatorio deste BO)
*   Saida.Click                   ThisForm.Release, e mais nada - esta tela
*                                 nao desabilita o chamador ao abrir, logo
*                                 nao ha nada a reabilitar na saida. O
*                                 chamador (sigreinrBO.Visualizar/Imprimir)
*                                 segue vivo e volta a usar o cursor, por
*                                 isso nem o form nem este BO fecham um alias
*                                 que receberam de fora
*
* Por isso Inserir(), Atualizar() e ExecutarExclusao() ficam SEM override: o
* comportamento padrao herdado de BusinessBase (recusar a operacao e reportar
* pelo ExibirFalha do Salvar) ja eh o correto, porque esta tela nao grava
* nada - inventar INSERT/UPDATE aqui violaria a regra #22 do CLAUDE.md (a
* lista de colunas vem do schema, nunca de adivinhacao, e aqui nem ha
* operacao de escrita no dump para adivinhar). RegistrarAuditoria() fica
* herdado pelo mesmo motivo: a base so o chama em operacao de ESCRITA.
* ObterChavePrimaria() EH sobrescrito, porque a linha corrente da grade tem
* identidade - o codigo de barras (CsRelatorio.CBars).
*
* ESTRUTURA DO CURSOR DA GRADE (contrato com o form PAI)
* -------------------------------------------------------
* O csRelatorio que o PAI entrega (dump SIGOPETQ.Grade, 4 colunas):
*
*   CBars   <- codigo de barras da etiqueta (SigOpEtq.cbars numeric(14,0))
*   Datas   <- data de entrada/consulta da etiqueta (datetime)
*   DPros   <- descricao do produto (SigCdPro.dpros char(65), via JOIN
*              feito pelo PAI)
*   pLocals <- local do produto (SigOpEtq.locals char(10), idem acima)
*
* O Seek do GetBusca.Valid usa a TAG CBars - Seek(lcProd, csRelatorio,
* CBars) - logo o PAI tambem cria esse indice no cursor. Quando o pai NAO
* entrega o cursor, quem o cria (VAZIO, com esta MESMA estrutura e esta MESMA
* ordem de campos) eh GarantirCursorRelatorio() deste BO - fonte UNICA do
* CREATE CURSOR, para o placeholder da grade nunca divergir do cursor
* populado.
*
* DUAS CONDICOES DE CONTORNO DO CONTRATO
* --------------------------------------
* 1) O form migrado tem de ficar com DataSession = 1 (o default). Medido no
*    VFP9: DataSession = 1 significa a sessao CORRENTE, entao o dialogo roda
*    na sessao do pai e VE o cursor dele. DataSession = 2 criaria sessao
*    privada e o alias do pai ficaria invisivel - a grade abriria vazia.
* 2) Quem NAO criou o cursor nao pode fecha-lo: fechar o alias do pai
*    quebraria a tela de tras. Por isso this_lCursorProprio registra a
*    origem, e o Destroy() so fecha o que este BO mesmo criou.
*
* Fase 1/8 - declaracao das propriedades e Init().
* Fase 2/8 - CarregarDoCursor, ObterChavePrimaria, LimparDados, Destroy e os
*            metodos de navegacao/busca que espelham Init/Valid do legado.
*==============================================================================

DEFINE CLASS SigOpEtqBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Cursor da grade, recebido PRONTO do form PAI (csRelatorio no legado)
    *
    * this_cCursorRelatorio eh o alias que a grade consome. this_cTagBarras
    * guarda o nome da TAG usada no Seek por codigo de barras - mesmo nome
    * usado pelo GetBusca.Valid do legado, para nao espalhar o literal CBars
    * pelo form. O nome da COLUNA indexada por essa TAG eh CBars, escrito
    * literalmente nos pontos de leitura, junto das outras 3 colunas da grade.
    *--------------------------------------------------------------------------
    this_cCursorRelatorio = ""      && alias da grade (csRelatorio no legado)
    this_cTagBarras = ""            && TAG usada no Seek por CBars

    *--------------------------------------------------------------------------
    * Origem do cursor da grade
    *
    * .F. = veio do form PAI  -> este BO NAO pode fecha-lo
    * .T. = criado aqui vazio -> este BO fecha no Destroy()
    *--------------------------------------------------------------------------
    this_lCursorProprio = .F.

    *--------------------------------------------------------------------------
    * Valor digitado no campo de busca (Cnt_Procurar.GetBusca.Value)
    *--------------------------------------------------------------------------
    this_cBarraBusca = ""

    *--------------------------------------------------------------------------
    * Linha corrente da grade - espelha as 4 colunas do cursor csRelatorio
    *
    * A grade do legado eh somente leitura (Grade.ReadOnly = .T. e as 4
    * Column<N>.ReadOnly = .T.), entao estas propriedades sao de LEITURA:
    * servem para o form publicar a linha corrente sem ler o cursor direto.
    *--------------------------------------------------------------------------
    this_nCBars = 0                 && CBars   - codigo de barras (numeric(14,0))
    this_dDatas = {}                && Datas   - data de entrada da etiqueta
    this_cDPros = ""                && DPros   - descricao do produto
    this_cPLocals = ""              && pLocals - local do produto

    *--------------------------------------------------------------------------
    * Impressao da consulta (cmdImprimir do legado)
    *
    * No legado o botao Imprimir nao imprime direto: ele abre o dialogo
    * generico SIGMVDOC com dois parametros -
    *
    *   Do Form SigMvDoc With 'SIGOPETQ', 'Impressao da Consulta de Etiquetas'
    *
    * e o Init do SIGMVDOC guarda o 1o em NomeRepo e o 2o no Caption. Com
    * pRep <> 'SIGCDENT' (o caso desta tela) ele ESCONDE os campos de faixa de
    * Nota Fiscal, e a barra de botoes dele roda sobre o cursor CORRENTE:
    *
    *   visualizacao  -> Report Form &NomeRepo. Preview NoConsole
    *   impressao     -> Report Form &NomeRepo. To Printer Prompt NoConsole
    *   processamento -> Go Top
    *
    * Dai as duas propriedades abaixo: o nome-base do FRX (NomeRepo = o
    * proprio pRep, "SIGOPETQ") e o titulo do dialogo (pTit).
    *
    * this_cArquivoRelatorio eh NOME-BASE, sem path e sem ".frx" - quem
    * concatena gc_4c_CaminhoReports eh ExecutarReportForm. A grafia segue o
    * arquivo portado (projeto\app\reports\SigOpEtq.frx); o Windows nao
    * diferencia maiuscula de minuscula no nome, entao ela nao muda o alvo.
    *--------------------------------------------------------------------------
    this_cArquivoRelatorio = ""     && NomeRepo do SIGMVDOC legado (base do FRX)
    this_cTituloRelatorio = ""      && pTit do SIGMVDOC legado (Caption)

    *==========================================================================
    * Init - Inicializa Business Object
    *
    * DODEFAULT() eh chamado SEM argumento de proposito: passar um nome de
    * tabela faria BusinessBase instanciar um DataAccess, e esta tela nao tem
    * tabela proprietaria para consultar - o cursor da grade chega PRONTO do
    * form PAI (ver header).
    *
    * Por isso as duas propriedades herdadas ficam vazias - os nomes
    * corretos sao this_cTabela e this_cCampoChave (nunca this_cTabela /
    * this_cCampoChave).
    *
    * NAO chamar fChecaAcesso() (nem nenhuma das 12 funcoes de
    * Framework\sigacess.PRG) daqui: a versao que vence eh a do sigacess, que
    * abre conexao propria e PENDURA dentro do CREATEOBJECT. A visibilidade de
    * cmdEtiquetas/cmdImprimir eh resolvida no form.
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Visualizador de cursor recebido do pai: nao ha tabela propria
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        *-- Cursor da grade e a TAG que o form pai cria nele
        THIS.this_cCursorRelatorio = "cursor_4c_Relatorio"
        THIS.this_cTagBarras = "CBars"
        THIS.this_lCursorProprio = .F.

        *-- Campo de busca (ainda sem valor digitado)
        THIS.this_cBarraBusca = ""

        *-- Linha corrente da grade
        THIS.this_nCBars = 0
        THIS.this_dDatas = {}
        THIS.this_cDPros = ""
        THIS.this_cPLocals = ""

        *-- Impressao: os dois argumentos que o legado passa ao SIGMVDOC
        *-- ("SIGOPETQ" vira NomeRepo, usado como nome-base do FRX)
        THIS.this_cArquivoRelatorio = "SigOpEtq"
        THIS.this_cTituloRelatorio = "Impress" + CHR(227) + ;
            "o da Consulta de Etiquetas"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GarantirCursorRelatorio - assegura que o alias da grade existe
    *
    * O cursor eh do form PAI, mas o dialogo tem de abrir mesmo quando ele nao
    * foi entregue: sem alias a grade fica sem RecordSource e aparece como um
    * retangulo branco, sem cabecalho e sem coluna, SEM erro nenhum.
    *
    * Este metodo eh a FONTE UNICA do CREATE CURSOR deste alias: nenhum outro
    * ponto do Form ou do BO pode declarar essa estrutura, para o placeholder
    * da grade nunca divergir (em nome, tipo ou ORDEM de campos) do cursor que
    * o pai popula - o APPEND FROM do pai casa por NOME, e a grade liga
    * Column1..Column4 exatamente a CBars/Datas/DPros/pLocals.
    *
    * SET NULL ON antes do CREATE CURSOR porque Datas eh datetime NULL em
    * SigOpEtq e as colunas de descricao vem de JOIN: sem isso, um APPEND FROM
    * de dado vindo do SQL Server recusaria o NULL.
    *
    * Cursor ja aberto (veio do pai) eh respeitado como esta - nao recriar,
    * nao reindexar.
    *==========================================================================
    PROCEDURE GarantirCursorRelatorio()
        LOCAL loc_lSucesso, loc_cCursor, loc_cTag, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)
        loc_cTag = ALLTRIM(THIS.this_cTagBarras)

        TRY
            IF EMPTY(loc_cCursor) OR EMPTY(loc_cTag)
                THIS.this_cMensagemErro = "Alias ou TAG do cursor da grade n" + ;
                    CHR(227) + "o definidos."
            ELSE
                IF USED(loc_cCursor)
                    *-- Entregue pelo form PAI: nao eh nosso para recriar nem fechar
                    loc_lSucesso = .T.
                ELSE
                    SET NULL ON
                    CREATE CURSOR (loc_cCursor) ( ;
                        CBars   N(14, 0) NULL, ;
                        Datas   T        NULL, ;
                        DPros   C(65)    NULL, ;
                        pLocals C(10)    NULL)
                    SET NULL OFF

                    SELECT (loc_cCursor)
                    INDEX ON CBars TAG (loc_cTag)
                    SET ORDER TO TAG (loc_cTag)

                    IF USED(loc_cCursor)
                        THIS.this_lCursorProprio = .T.
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
                            CHR(237) + "vel criar o cursor da grade."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao preparar o cursor da grade:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - publica a LINHA CORRENTE da grade nas propriedades
    *
    * Sem argumento usa this_cCursorRelatorio; com argumento aceita o alias
    * que o chamador indicar (o pai pode ter batizado o cursor de outro jeito).
    *
    * IF EOF() OBRIGATORIO: em VFP, ler campo com o ponteiro em EOF nao da
    * erro - devolve o valor em branco do tipo. Sem o guard as propriedades
    * seriam ZERADAS e o metodo ainda devolveria .T., relatando sucesso sem
    * haver linha nenhuma; USED() sozinho nao cobre isso, porque o cursor esta
    * aberto e cheio e o que esta fora de lugar eh o PONTEIRO.
    *
    * Os campos sao lidos com guarda de EXISTENCIA (TYPE do nome qualificado)
    * porque a estrutura vem de FORA: o pai monta o cursor. Faltando CBars nao
    * ha linha identificavel e o metodo FALHA; faltando uma das tres colunas
    * descritivas, a propriedade fica no valor vazio do tipo e a leitura segue
    * - a grade exibiria a coluna em branco do mesmo jeito.
    *
    * TratarNulo recebe o VALOR PADRAO do tipo ("" / 0 / {}), nunca um codigo
    * de tipo: TratarNulo(col, "C") gravaria a string literal C quando a
    * coluna vier NULL.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lSucesso, loc_cCursor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
            loc_cCursor = ALLTRIM(par_cCursor)
        ENDIF

        TRY
            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + "] n" + ;
                    CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (loc_cCursor)

                IF EOF()
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiqueta corrente para carregar."
                ELSE
                    IF TYPE(loc_cCursor + ".CBars") = "U"
                        THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + ;
                            "] n" + CHR(227) + "o tem a coluna CBars (c" + ;
                            CHR(243) + "digo de barras)."
                    ELSE
                        THIS.this_nCBars = TratarNulo( ;
                            EVALUATE(loc_cCursor + ".CBars"), 0)

                        IF TYPE(loc_cCursor + ".Datas") = "U"
                            THIS.this_dDatas = {}
                        ELSE
                            THIS.this_dDatas = ConverterParaData( ;
                                TratarNulo(EVALUATE(loc_cCursor + ".Datas"), {}))
                        ENDIF

                        IF TYPE(loc_cCursor + ".DPros") = "U"
                            THIS.this_cDPros = ""
                        ELSE
                            THIS.this_cDPros = ALLTRIM(TratarNulo( ;
                                EVALUATE(loc_cCursor + ".DPros"), ""))
                        ENDIF

                        IF TYPE(loc_cCursor + ".pLocals") = "U"
                            THIS.this_cPLocals = ""
                        ELSE
                            THIS.this_cPLocals = ALLTRIM(TratarNulo( ;
                                EVALUATE(loc_cCursor + ".pLocals"), ""))
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao ler a etiqueta do cursor:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PosicionarPrimeiro - espelha o Select csRelatorio / Go Top do Init
    *
    * O form chama isto no Init e em todo ponto que repopula a grade; o
    * Grade.Refresh fica no form, porque repintar eh responsabilidade da UI
    * (e grade em pagina oculta nao pinta).
    *
    * Cursor vazio nao eh erro: eh o caso em que o pai nao conferiu nenhuma
    * etiqueta. As propriedades sao limpas para nao sobrar a linha de uma
    * carga anterior, e a mensagem fica disponivel para quem quiser exibir -
    * este metodo NAO abre dialogo por cursor vazio. A mensagem eh atribuida
    * DEPOIS do LimparDados porque o LimparDados da base zera
    * this_cMensagemErro.
    *==========================================================================
    PROCEDURE PosicionarPrimeiro()
        LOCAL loc_lSucesso, loc_cCursor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        TRY
            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + "] n" + ;
                    CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (loc_cCursor)
                GO TOP

                IF EOF()
                    THIS.LimparDados()
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiquetas a exibir."
                ELSE
                    loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao posicionar a grade de etiquetas:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarPorBarra - espelha LITERALMENTE o GetBusca.Valid do legado
    *
    *   lcProd = This.Value
    *   If Not Empty(lcProd)
    *       Select csRelatorio
    *       lnReg = Recno()
    *       If Not Seek(lcProd, csRelatorio, CBars)
    *           Go lnReg
    *       EndIf
    *   EndIf
    *
    * Tres comportamentos do legado que NAO se alteram aqui:
    *   (a) barra vazia nao faz NADA - nao move o ponteiro, nao avisa;
    *   (b) barra nao encontrada volta para a linha onde o usuario estava -
    *       NAO limpa o campo digitado e NAO abre dialogo (avisar e apagar o
    *       digitado deixaria o usuario sem como preencher);
    *   (c) nao ha consulta ao banco - a busca eh so no cursor em memoria.
    *
    * O valor digitado chega CARACTERE do TextBox e a coluna CBars eh
    * numeric(14,0), entao a chave do Seek eh convertida conforme o tipo REAL
    * da coluna no cursor (o pai eh quem a declara). Cursor com CBars
    * caractere eh aceito tambem: ali vale a comparacao de texto e, com
    * SET EXACT ON (config.prg), o Seek exige a barra inteira - mesmo criterio
    * do legado, que tambem procura o codigo completo.
    *
    * O Recno eh reposto so quando ainda eh valido: apos um Seek frustrado o
    * ponteiro vai para EOF, e o Recno gravado antes pode ser RECCOUNT()+1 se
    * a linha de partida ja era EOF - GO nesse valor estouraria "Record is out
    * of range".
    *==========================================================================
    PROCEDURE BuscarPorBarra(par_uBarra)
        LOCAL loc_lSucesso, loc_cCursor, loc_cTag, loc_cBarra
        LOCAL loc_uChave, loc_nReg, loc_lTemValor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)
        loc_cTag = ALLTRIM(THIS.this_cTagBarras)
        loc_cBarra = ""
        loc_lTemValor = .F.

        *-- Normaliza o que veio do TextBox (pode ser Caractere ou Numerico)
        *-- ISNULL testado ANTES de EMPTY: EMPTY(.NULL.) devolve .F. em VFP9
        IF PCOUNT() >= 1 AND !ISNULL(par_uBarra)
            DO CASE
                CASE VARTYPE(par_uBarra) = "C"
                    loc_cBarra = ALLTRIM(par_uBarra)
                    loc_lTemValor = !EMPTY(loc_cBarra)
                CASE VARTYPE(par_uBarra) = "N"
                    loc_cBarra = ALLTRIM(STR(par_uBarra, 14))
                    loc_lTemValor = (par_uBarra <> 0)
            ENDCASE
        ENDIF

        *-- Registra o que o usuario digitou, inclusive quando nao achar
        THIS.this_cBarraBusca = loc_cBarra

        TRY
            IF !loc_lTemValor
                *-- Legado: If Not Empty(lcProd) - barra vazia nao faz nada
                THIS.this_cMensagemErro = ""
            ELSE
                IF !USED(loc_cCursor)
                    THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + ;
                        "] n" + CHR(227) + "o est" + CHR(225) + " aberto."
                ELSE
                    SELECT (loc_cCursor)
                    loc_nReg = RECNO()

                    *-- Chave do Seek no tipo REAL da coluna indexada
                    IF TYPE(loc_cCursor + ".CBars") = "N"
                        loc_uChave = VAL(loc_cBarra)
                    ELSE
                        loc_uChave = loc_cBarra
                    ENDIF

                    IF SEEK(loc_uChave, loc_cCursor, loc_cTag)
                        loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                    ELSE
                        *-- Legado: Go lnReg - volta para onde o usuario estava
                        IF BETWEEN(loc_nReg, 1, RECCOUNT(loc_cCursor))
                            GO loc_nReg
                        ELSE
                            GO TOP
                        ENDIF

                        THIS.this_cMensagemErro = "Barra [" + loc_cBarra + ;
                            "] n" + CHR(227) + "o consta nesta consulta."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao procurar a barra na consulta:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ContarRegistros - quantas etiquetas a grade tem para exibir/imprimir
    *
    * Usado pelos botoes Etiquetas e Imprimir: o legado faz Select csRelatorio
    * e entrega o cursor ao form chamado, e um cursor sem linha nenhuma
    * geraria documento em branco.
    *
    * RECCOUNT nao move o ponteiro, entao a linha corrente da grade eh
    * preservada e nao ha Recno a repor.
    *==========================================================================
    PROCEDURE ContarRegistros()
        LOCAL loc_nTotal, loc_cCursor, loc_oErro

        loc_nTotal = 0
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        TRY
            IF USED(loc_cCursor)
                loc_nTotal = RECCOUNT(loc_cCursor)
            ELSE
                THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + "] n" + ;
                    CHR(227) + "o est" + CHR(225) + " aberto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao contar as etiquetas da consulta:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_nTotal = 0
        ENDTRY

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - helper canonico do projeto (Pattern #117)
    *
    * Faz as tres coisas que um REPORT FORM solto nao faz, e cada uma vem de
    * um defeito ja medido no projeto:
    *
    *   1. GUARD de existencia do FRX - sem ele, FRX ausente estoura uma
    *      mensagem que nao diz qual arquivo faltou.
    *   2. ISOLAMENTO de locale - os FRX legado Fortyus foram desenhados com
    *      SET POINT TO "." e REPORTBEHAVIOR 80; no default brasileiro do VFP9
    *      (POINT = ",") e no REPORTBEHAVIOR 90 os campos numericos saem como
    *      ******* porque as PICTURE 9,999.999 do FRX deixam de casar.
    *   3. RESTAURACAO do menu - o _MREPORT do PREVIEW corrompe o _MSYSMENU e
    *      o menu principal volta encolhido, sem os pads.
    *
    * O guard de cursor existe porque o FRX imprime da WORK AREA CORRENTE: as
    * expressoes dele sao Contas/CBars/Tipos/datas/cpros/DPros SEM prefixo de
    * alias (conferido no .frt portado). Quem seleciona o alias eh este
    * metodo - igual ao "Select csRelatorio" que o legado faz antes do Do Form.
    *
    * PROTECTED: so os tres metodos de acao abaixo o usam, e ele nao entra na
    * lista de metodos que o form chama de fora (regra CLAUDE.md #51).
    *
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *
    * RETURN unico, FORA do TRY (regra CLAUDE.md #1) - o resultado passa pela
    * flag loc_lSucesso e os caminhos de recusa a deixam em .F.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cFRX, loc_cCursor, loc_cModo
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig, loc_oErro

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        IF TYPE("gc_4c_CaminhoReports") != "C"
            gc_4c_CaminhoReports = ""
        ENDIF

        loc_cModo = UPPER(ALLTRIM(par_cModo))
        loc_cFRX  = FULLPATH(gc_4c_CaminhoReports + ;
            ALLTRIM(par_cRelatorioBase) + ".frx")

        IF !FILE(loc_cFRX)
            THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                CHR(227) + "o encontrado:" + CHR(13) + loc_cFRX
            MsgErro(THIS.this_cMensagemErro, "Imprimir")
            THIS.this_lErroExibido = .T.
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            loc_cCursor = ""
            IF VARTYPE(par_cCursorDados) = "C"
                loc_cCursor = ALLTRIM(par_cCursorDados)
            ENDIF

            IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor da consulta n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
                MsgAviso(THIS.this_cMensagemErro, ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.this_lErroExibido = .T.
                loc_lProsseguir = .F.
            ELSE
                IF RECCOUNT(loc_cCursor) = 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiquetas para imprimir."
                    MsgAviso(THIS.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_lErroExibido = .T.
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF
        ENDIF

        IF loc_lProsseguir
            TRY
                *-- "Select csRelatorio" + "Go Top": o FRX le a work area
                *-- CORRENTE, e o Go Top eh o PROCEDURE processamento do
                *-- SIGMVDOC, que roda antes de cada saida.
                SELECT (loc_cCursor)
                GO TOP IN (loc_cCursor)

                loc_cPointOrig = SET("POINT")
                loc_cSepOrig   = SET("SEPARATOR")
                *-- SET("REPORTBEHAVIOR") ja devolve NUMERICO: VAL() aqui
                *-- dispararia o erro 11, igual ao SET("Decimals").
                loc_nBehaviorOrig = SET("REPORTBEHAVIOR")

                SET POINT TO "."
                SET SEPARATOR TO ","
                SET REPORTBEHAVIOR 80

                DO CASE
                    CASE loc_cModo == "PREVIEW"
                        REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
                    CASE loc_cModo == "PRINTER_PROMPT"
                        REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                    CASE loc_cModo == "PRINTER"
                        REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
                ENDCASE

                SET POINT TO (loc_cPointOrig)
                SET SEPARATOR TO (loc_cSepOrig)
                SET REPORTBEHAVIOR (loc_nBehaviorOrig)

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Imprimir")
                THIS.this_lErroExibido = .T.
            ENDTRY

            *-- Repoe o menu principal depois do PREVIEW. Fica FORA do TRY
            *-- acima de proposito, para rodar tambem quando o REPORT FORM
            *-- abortou no meio e ja tinha trocado o _MSYSMENU.
            TRY
                SET SYSMENU TO DEFAULT
                RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                    popRelatorios, popFerramentas, popAjuda
                CriarMenuPrincipal()
            CATCH
                *-- Menu fora de escopo (probe/teste headless) - sem efeito
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Visualizar - PROCEDURE visualizacao do SIGMVDOC legado
    *
    *   Report Form &NomeRepo. Preview NoConsole
    *
    * Sem o ramo "If ThisForm.pcRep = 'SIGCDENT'" que recorta por faixa de
    * Nota Fiscal: aqui pRep eh "SIGOPETQ", logo aquele IF nao entra e o
    * relatorio sai sobre a consulta inteira.
    *
    * PUBLIC (sem PROTECTED): o dialogo de impressao chama de FORA da classe,
    * e nenhum nivel da heranca de BusinessBase declara este nome - se algum
    * declarasse PROTECTED, a chamada externa estouraria "Property VISUALIZAR
    * is not found" (regra CLAUDE.md #51).
    *==========================================================================
    PROCEDURE Visualizar()
        RETURN THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, ;
            "PREVIEW", THIS.this_cCursorRelatorio)
    ENDPROC

    *==========================================================================
    * Imprimir - PROCEDURE impressao do SIGMVDOC legado
    *
    *   Report Form &NomeRepo. To Printer Prompt NoConsole
    *
    * O PROMPT eh do legado: o dialogo de impressora do Windows abre para o
    * usuario escolher bandeja/copias antes de sair o papel.
    *==========================================================================
    PROCEDURE Imprimir()
        RETURN THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, ;
            "PRINTER_PROMPT", THIS.this_cCursorRelatorio)
    ENDPROC

    *==========================================================================
    * GerarExcel - 3o botao da barra do frmrelatorio ("Arquivos Email")
    *
    * O frmrelatorio legado gera o arquivo com o MESMO FRX, trocando so o
    * destino por "To File ... Ascii" - eh esse arquivo que segue anexado no
    * email. O nome leva a data para dois cliques no mesmo dia nao se
    * sobrescreverem.
    *
    * NAO delega ao ExecutarReportForm porque o destino eh outro comando (TO
    * FILE, com nome de arquivo), e nao um dos tres modos dele; os guards de
    * FRX e de cursor sao portanto refeitos aqui. O isolamento de locale e a
    * reposicao do menu nao entram: sem PREVIEW nao ha _MREPORT para corromper
    * o _MSYSMENU, e a saida ASCII nao passa pelas PICTURE do FRX.
    *==========================================================================
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cFRX, loc_cCursor
        LOCAL loc_cArquivo, loc_oErro

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        IF TYPE("gc_4c_CaminhoReports") != "C"
            gc_4c_CaminhoReports = ""
        ENDIF

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + ;
            ALLTRIM(THIS.this_cArquivoRelatorio) + ".frx")
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        IF !FILE(loc_cFRX)
            THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                CHR(227) + "o encontrado:" + CHR(13) + loc_cFRX
            MsgErro(THIS.this_cMensagemErro, "Arquivos Email")
            THIS.this_lErroExibido = .T.
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor da consulta n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
                MsgAviso(THIS.this_cMensagemErro, ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.this_lErroExibido = .T.
                loc_lProsseguir = .F.
            ELSE
                IF RECCOUNT(loc_cCursor) = 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiquetas para gerar o arquivo."
                    MsgAviso(THIS.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_lErroExibido = .T.
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_cArquivo = FULLPATH(gc_4c_CaminhoReports + ;
                    ALLTRIM(THIS.this_cArquivoRelatorio) + "_" + ;
                    STRTRAN(DTOC(DATE()), "/", "") + ".xls")

                SELECT (loc_cCursor)
                GO TOP IN (loc_cCursor)

                REPORT FORM (loc_cFRX) TO FILE (loc_cArquivo) NOCONSOLE ASCII

                IF FILE(loc_cArquivo)
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, ;
                        "Arquivos Email")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao gerar o arquivo " + ;
                        loc_cArquivo
                    MsgErro(THIS.this_cMensagemErro, "Arquivos Email")
                    THIS.this_lErroExibido = .T.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Arquivos Email")
                THIS.this_lErroExibido = .T.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - zera a linha corrente publicada e o campo de busca
    *
    * DODEFAULT() limpa this_cMensagemErro da base. NAO toca no cursor: o
    * conteudo da grade eh do form PAI.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_nCBars = 0
        THIS.this_dDatas = {}
        THIS.this_cDPros = ""
        THIS.this_cPLocals = ""
        THIS.this_cBarraBusca = ""
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - identidade da linha corrente
    *
    * PROTECTED igual a BusinessBase: medido no VFP9, PROTECTED na base
    * prevalece sobre override sem modificador, entao declarar publico aqui
    * nao abriria o metodo e so esconderia a restricao. De fora, ninguem
    * chama.
    *
    * A chave eh o codigo de barras - PK de SigOpEtq (cbars numeric(14,0)) e a
    * coluna indexada pela TAG do Seek. Barra zerada devolve vazio, para a
    * base nao registrar auditoria de linha sem identidade.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = ""

        IF THIS.this_nCBars <> 0
            loc_cChave = ALLTRIM(STR(THIS.this_nCBars, 14))
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Destroy - fecha SO o cursor que este BO criou
    *
    * Cursor entregue pelo pai (this_lCursorProprio = .F.) fica aberto: a tela
    * de tras continua usando aquele alias, e fecha-lo daqui quebraria o fluxo
    * de conferencia do pai.
    *
    * USE IN basta e eh seguro mesmo com buffer sujo - TABLEREVERT aqui
    * estouraria "Function requires row or table buffering mode" num cursor
    * criado com Buffering = 1.
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_cCursor

        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        IF THIS.this_lCursorProprio AND !EMPTY(loc_cCursor) AND USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        THIS.this_lCursorProprio = .F.

        DODEFAULT()
    ENDPROC

ENDDEFINE

