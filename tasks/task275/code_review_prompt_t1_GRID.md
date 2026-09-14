# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (10)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1104: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1119: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1142: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1169: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1300: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1306: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1515: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1538: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1604: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1636: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS GRID (1643 linhas total):

*-- Linhas 66 a 98:
66:             ELSE
67:                 *-- Placeholders para ControlSource em DataSession=2
68:                 *-- Fechados/substituidos pelos metodos do BO antes de cada SQLEXEC
69:                 SET NULL ON
70:                 CREATE CURSOR cursor_4c_Dados (Codigos C(20), Datas T)
71:                 CREATE CURSOR cursor_4c_Estoques ;
72:                     (nMarca N(1), cidchaves C(36), emps C(4), grupos C(10), contas C(15))
73:                 CREATE CURSOR cursor_4c_Disponivel ;
74:                     (cpros C(14), dpros C(65), codcors C(4), codtams C(4), ;
75:                      QtdEstoque N(10,2), QtdSaida N(10,2), QtdSaldo N(10,2))
76:                 CREATE CURSOR cursor_4c_Distribui ;
77:                     (emps C(4), grupos C(10), contas C(15), ;
78:                      QtdSaldo N(10,2), QtdDistr N(10,2), locals C(10))
79:                 CREATE CURSOR cursor_4c_CabOpera ;
80:                     (emps C(4), dopes C(20), numes C(10), datas T, grupos C(10), empdopnums C(40))
81:                 CREATE CURSOR cursor_4c_ItensOper ;
82:                     (cpros C(14), codcors C(4), codtams C(4), qtds N(10,2), locals C(10))
83:                 SET NULL OFF
84: 
85:                 THIS.ConfigurarPageFrame()
86:                 THIS.ConfigurarCabecalho()
87:                 THIS.ConfigurarSaida()
88:                 THIS.ConfigurarPaginaLista()
89:                 THIS.ConfigurarPaginaDados()
90: 
91:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = ;
92:                     "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
93:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
94:                     "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
95: 
96:                 *-- Page1 BINDEVENTs
97:                 LOCAL loc_oPg1 AS Object
98:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1

*-- Linhas 118 a 178:
118:                 BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(1), "Click", THIS, "BtnMarcarClick")
119:                 BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(2), "Click", THIS, "BtnDesmarcarClick")
120:                 BINDEVENT(loc_oSub1.cmd_4c_Processar,                  "Click", THIS, "BtnProcessarPage1Click")
121:                 BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "MouseUp",  THIS, "ChkMarcaMouseUp")
122:                 BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")
123: 
124:                 *-- SubPage2 (Distribuicao)
125:                 LOCAL loc_oSub2 AS Object
126:                 loc_oSub2 = loc_oPf1.Page2
127:                 BINDEVENT(loc_oSub2.cmd_4c_VoltarEst,      "Click",              THIS, "BtnVoltarEstClick")
128:                 BINDEVENT(loc_oSub2.cmd_4c_Salvar,         "Click",              THIS, "BtnSalvarClick")
129:                 BINDEVENT(loc_oSub2.cmd_4c_Filtrar,        "Click",              THIS, "BtnFiltrarClick")
130:                 BINDEVENT(loc_oSub2.img_4c_FigJpg,         "Click",              THIS, "ImgFotoClick")
131:                 BINDEVENT(loc_oSub2.txt_4c_CodGrupo,       "KeyPress",              THIS, "TxtCGrupoValid")
132:                 BINDEVENT(loc_oSub2.txt_4c_DsGrupo,        "KeyPress",              THIS, "TxtDGrupoValid")
133:                 BINDEVENT(loc_oSub2.txt_4c_ProdutoInicial, "LostFocus",              THIS, "TxtProdutoInicialValid")
134:                 BINDEVENT(loc_oSub2.grd_4c_Disponivel,     "AfterRowColChange",  THIS, "GrdDisponivelAfterRowColChange")
135:                 BINDEVENT(loc_oSub2.grd_4c_Distribui.Column3.Text1, "KeyPress", THIS, "GrdDistribuiQtdLostFocus")
136:                 BINDEVENT(loc_oSub2.grd_4c_Distribui.Column4.Text1, "Valid",     THIS, "GrdDistribuiLocalValid")
137:                 BINDEVENT(loc_oSub2.grd_4c_Distribui.Column4.Text1, "KeyPress",  THIS, "TxtLocalKeyPress")
138: 
139:                 *-- SubPage3 (Operacoes)
140:                 LOCAL loc_oSub3 AS Object
141:                 loc_oSub3 = loc_oPf1.Page3
142:                 BINDEVENT(loc_oSub3.cmdg_4c_ProcOper.Buttons(1), "Click",             THIS, "BtnProcOperClick")
143:                 BINDEVENT(loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas, "AfterRowColChange", THIS, "GrdCabOperasAfterRowColChange")
144: 
145:                 THIS.TornarControlesVisiveis(THIS)
146: 
147:                 *-- Disable pages 2 and 3 until estoques processed
148:                 loc_oPf1.Page2.Enabled = .F.
149:                 loc_oPf1.Page3.Enabled = .F.
150: 
151:                 *-- Initial date range = today
152:                 THIS.this_oBusinessObject.this_dDataInicial = DATE()
153:                 THIS.this_oBusinessObject.this_dDataFinal   = DATE()
154:                 loc_oPg1.txt_4c_DtInicial.Value = DATE()
155:                 loc_oPg1.txt_4c_DtFinal.Value   = DATE()
156: 
157:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
158:                     THIS.CarregarLista()
159:                 ENDIF
160:                 THIS.pgf_4c_Paginas.Visible = .T.
161:                 THIS.pgf_4c_Paginas.ActivePage = 1
162:                 IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
163:                     loc_oPg1.grd_4c_Grade.SetFocus()
164:                 ELSE
165:                     loc_oPg1.cmd_4c_Novo.SetFocus()
166:                 ENDIF
167: 
168:                 loc_lSucesso = .T.
169:             ENDIF
170:         CATCH TO loc_oErro
171:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
172:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm Formsigprdis")
173:         ENDTRY
174:         RETURN loc_lSucesso
175:     ENDPROC
176: 
177:     *==========================================================================
178:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)

*-- Linhas 392 a 435:
392:             .FontBold  = .T.
393:         ENDWITH
394: 
395:         loc_oPg1.AddObject("grd_4c_Grade", "Grid")
396:         WITH loc_oPg1.grd_4c_Grade
397:             .Left              = 24
398:             .Top               = 157
399:             .Width             = 870
400:             .Height            = 340
401:             .RecordSource      = ""
402:             .RecordSourceType  = 1
403:             .ColumnCount       = 2
404:             .DeleteMark        = .F.
405:             .RecordMark        = .F.
406:             .GridLines         = 1
407:             .ReadOnly          = .T.
408:             .Themes            = .F.
409:             .FontName          = "Tahoma"
410:             .FontSize          = 8
411:         ENDWITH
412:         WITH loc_oPg1.grd_4c_Grade.Column1
413:             .ControlSource   = "cursor_4c_Dados.Codigos"
414:             .Width           = 140
415:             .Header1.Caption = "Lote (C" + CHR(243) + "digo)"
416:         ENDWITH
417:         WITH loc_oPg1.grd_4c_Grade.Column2
418:             .ControlSource   = "cursor_4c_Dados.Datas"
419:             .Width           = 700
420:             .Header1.Caption = "Data/Hora"
421:         ENDWITH
422:     ENDPROC
423: 
424:     *==========================================================================
425:     PROTECTED PROCEDURE ConfigurarPaginaDados()
426:     *==========================================================================
427:         LOCAL loc_oPg2 AS Object
428:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
429: 
430:         loc_oPg2.AddObject("cmd_4c_VoltarLista", "CommandButton")
431:         WITH loc_oPg2.cmd_4c_VoltarLista
432:             .Caption  = CHR(171) + " Lista"
433:             .Left     = 5
434:             .Top      = 5
435:             .Width    = 80

*-- Linhas 550 a 613:
550:             .Height  = 40
551:         ENDWITH
552: 
553:         loc_oSub.AddObject("grd_4c_Estoques", "Grid")
554:         WITH loc_oSub.grd_4c_Estoques
555:             .Left             = 335
556:             .Top              = 207
557:             .Width            = 280
558:             .Height           = 244
559:             .RecordSource     = ""
560:             .RecordSourceType = 1
561:             .ColumnCount      = 4
562:             .DeleteMark       = .F.
563:             .RecordMark       = .F.
564:             .GridLines        = 1
565:             .Themes           = .F.
566:             .FontName         = "Tahoma"
567:             .FontSize         = 8
568:         ENDWITH
569:         WITH loc_oSub.grd_4c_Estoques.Column1
570:             .ControlSource   = "cursor_4c_Estoques.nMarca"
571:             .Width           = 30
572:             .Sparse          = .F.
573:             .Header1.Caption = ""
574:         ENDWITH
575:         loc_oSub.grd_4c_Estoques.Column1.AddObject("chk_4c_Marca", "CheckBox")
576:         WITH loc_oSub.grd_4c_Estoques.Column1.chk_4c_Marca
577:             .Caption = ""
578:             .Width   = 24
579:             .Height  = 17
580:         ENDWITH
581:         loc_oSub.grd_4c_Estoques.Column1.CurrentControl = "chk_4c_Marca"
582:         WITH loc_oSub.grd_4c_Estoques.Column2
583:             .ControlSource   = "cursor_4c_Estoques.emps"
584:             .Width           = 55
585:             .ReadOnly        = .T.
586:             .Header1.Caption = "Empresa"
587:         ENDWITH
588:         WITH loc_oSub.grd_4c_Estoques.Column3
589:             .ControlSource   = "cursor_4c_Estoques.grupos"
590:             .Width           = 90
591:             .ReadOnly        = .T.
592:             .Header1.Caption = "Grupo"
593:         ENDWITH
594:         WITH loc_oSub.grd_4c_Estoques.Column4
595:             .ControlSource   = "cursor_4c_Estoques.contas"
596:             .Width           = 90
597:             .ReadOnly        = .T.
598:             .Header1.Caption = "Conta"
599:         ENDWITH
600:     ENDPROC
601: 
602:     *==========================================================================
603:     PROTECTED PROCEDURE ConfigurarSubPaginaDistribuicao()
604:     *==========================================================================
605:         LOCAL loc_oSub AS Object
606:         loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
607: 
608:         loc_oSub.AddObject("cmd_4c_VoltarEst", "CommandButton")
609:         WITH loc_oSub.cmd_4c_VoltarEst
610:             .Caption  = CHR(171) + " Estoques"
611:             .Left     = 5
612:             .Top      = 5
613:             .Width    = 90

*-- Linhas 717 a 825:
717:         ENDWITH
718: 
719:         *-- Disponivel grid
720:         loc_oSub.AddObject("grd_4c_Disponivel", "Grid")
721:         WITH loc_oSub.grd_4c_Disponivel
722:             .Left             = 1
723:             .Top              = 141
724:             .Width            = 663
725:             .Height           = 327
726:             .RecordSource     = ""
727:             .RecordSourceType = 1
728:             .ColumnCount      = 7
729:             .DeleteMark       = .F.
730:             .RecordMark       = .F.
731:             .GridLines        = 1
732:             .ReadOnly         = .T.
733:             .Themes           = .F.
734:             .FontName         = "Tahoma"
735:             .FontSize         = 8
736:         ENDWITH
737:         WITH loc_oSub.grd_4c_Disponivel.Column1
738:             .ControlSource   = "cursor_4c_Disponivel.cpros"
739:             .Width           = 90
740:             .Header1.Caption = "C" + CHR(243) + "digo"
741:         ENDWITH
742:         WITH loc_oSub.grd_4c_Disponivel.Column2
743:             .ControlSource   = "cursor_4c_Disponivel.dpros"
744:             .Width           = 140
745:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
746:         ENDWITH
747:         WITH loc_oSub.grd_4c_Disponivel.Column3
748:             .ControlSource   = "cursor_4c_Disponivel.codcors"
749:             .Width           = 55
750:             .Header1.Caption = "Cor"
751:         ENDWITH
752:         WITH loc_oSub.grd_4c_Disponivel.Column4
753:             .ControlSource   = "cursor_4c_Disponivel.codtams"
754:             .Width           = 55
755:             .Header1.Caption = "Tam"
756:         ENDWITH
757:         WITH loc_oSub.grd_4c_Disponivel.Column5
758:             .ControlSource   = "cursor_4c_Disponivel.QtdEstoque"
759:             .Width           = 80
760:             .Header1.Caption = "Estoque"
761:         ENDWITH
762:         WITH loc_oSub.grd_4c_Disponivel.Column6
763:             .ControlSource   = "cursor_4c_Disponivel.QtdSaida"
764:             .Width           = 80
765:             .Header1.Caption = "Sa" + CHR(237) + "da"
766:         ENDWITH
767:         WITH loc_oSub.grd_4c_Disponivel.Column7
768:             .ControlSource   = "cursor_4c_Disponivel.QtdSaldo"
769:             .Width           = 80
770:             .Header1.Caption = "Saldo"
771:         ENDWITH
772: 
773:         *-- Distribui grid (Column3=QtdDistr editable, Column4=locals editable)
774:         loc_oSub.AddObject("grd_4c_Distribui", "Grid")
775:         WITH loc_oSub.grd_4c_Distribui
776:             .Left             = 664
777:             .Top              = 141
778:             .Width            = 234
779:             .Height           = 327
780:             .RecordSource     = ""
781:             .RecordSourceType = 1
782:             .ColumnCount      = 4
783:             .DeleteMark       = .F.
784:             .RecordMark       = .F.
785:             .GridLines        = 1
786:             .Themes           = .F.
787:             .FontName         = "Tahoma"
788:             .FontSize         = 8
789:         ENDWITH
790:         WITH loc_oSub.grd_4c_Distribui.Column1
791:             .ControlSource   = "cursor_4c_Distribui.emps"
792:             .Width           = 50
793:             .ReadOnly        = .T.
794:             .Header1.Caption = "Empresa"
795:         ENDWITH
796:         WITH loc_oSub.grd_4c_Distribui.Column2
797:             .ControlSource   = "cursor_4c_Distribui.QtdSaldo"
798:             .Width           = 55
799:             .ReadOnly        = .T.
800:             .Header1.Caption = "Saldo"
801:         ENDWITH
802:         WITH loc_oSub.grd_4c_Distribui.Column3
803:             .ControlSource   = "cursor_4c_Distribui.QtdDistr"
804:             .Width           = 65
805:             .Header1.Caption = "Qtd"
806:         ENDWITH
807:         WITH loc_oSub.grd_4c_Distribui.Column4
808:             .ControlSource   = "cursor_4c_Distribui.locals"
809:             .Width           = 55
810:             .Header1.Caption = "Local"
811:         ENDWITH
812: 
813:         *-- Product info panel (read-only) - bottom of page
814:         loc_oSub.AddObject("lbl_4c_LblGrupoP", "Label")
815:         WITH loc_oSub.lbl_4c_LblGrupoP
816:             .Caption   = "Grupo :"
817:             .Left      = 67
818:             .Top       = 474
819:             .Width     = 45
820:             .Height    = 15
821:             .AutoSize  = .F.
822:             .BackStyle = 0
823:             .FontName  = "Tahoma"
824:             .FontSize  = 8
825:         ENDWITH

*-- Linhas 995 a 1186:
995:         ENDWITH
996: 
997:         *-- grdCabOperas
998:         loc_oSub.pgf_4c_Operacoes.Page1.AddObject("grd_4c_CabOperas", "Grid")
999:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
1000:             .Left             = 5
1001:             .Top              = 5
1002:             .Width            = 880
1003:             .Height           = 280
1004:             .RecordSource     = ""
1005:             .RecordSourceType = 1
1006:             .ColumnCount      = 6
1007:             .DeleteMark       = .F.
1008:             .RecordMark       = .F.
1009:             .GridLines        = 1
1010:             .ReadOnly         = .T.
1011:             .Themes           = .F.
1012:             .FontName         = "Tahoma"
1013:             .FontSize         = 8
1014:         ENDWITH
1015:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1
1016:             .ControlSource   = "cursor_4c_CabOpera.emps"
1017:             .Width           = 55
1018:             .Header1.Caption = "Emp O"
1019:         ENDWITH
1020:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2
1021:             .ControlSource   = "cursor_4c_CabOpera.dopes"
1022:             .Width           = 110
1023:             .Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1024:         ENDWITH
1025:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3
1026:             .ControlSource   = "cursor_4c_CabOpera.numes"
1027:             .Width           = 80
1028:             .Header1.Caption = "N" + CHR(250) + "mero"
1029:         ENDWITH
1030:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4
1031:             .ControlSource   = "cursor_4c_CabOpera.datas"
1032:             .Width           = 130
1033:             .Header1.Caption = "Data"
1034:         ENDWITH
1035:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5
1036:             .ControlSource   = "cursor_4c_CabOpera.grupos"
1037:             .Width           = 100
1038:             .Header1.Caption = "Grupo Orig"
1039:         ENDWITH
1040:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6
1041:             .ControlSource   = "cursor_4c_CabOpera.empdopnums"
1042:             .Width           = 180
1043:             .Header1.Caption = "Emp+Op+Num"
1044:         ENDWITH
1045: 
1046:         *-- grdItnOperas
1047:         loc_oSub.pgf_4c_Operacoes.Page2.AddObject("grd_4c_ItnOperas", "Grid")
1048:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
1049:             .Left             = 5
1050:             .Top              = 5
1051:             .Width            = 880
1052:             .Height           = 280
1053:             .RecordSource     = ""
1054:             .RecordSourceType = 1
1055:             .ColumnCount      = 5
1056:             .DeleteMark       = .F.
1057:             .RecordMark       = .F.
1058:             .GridLines        = 1
1059:             .ReadOnly         = .T.
1060:             .Themes           = .F.
1061:             .FontName         = "Tahoma"
1062:             .FontSize         = 8
1063:         ENDWITH
1064:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1
1065:             .ControlSource   = "cursor_4c_ItensOper.cpros"
1066:             .Width           = 110
1067:             .Header1.Caption = "C" + CHR(243) + "digo"
1068:         ENDWITH
1069:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2
1070:             .ControlSource   = "cursor_4c_ItensOper.codcors"
1071:             .Width           = 60
1072:             .Header1.Caption = "Cor"
1073:         ENDWITH
1074:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3
1075:             .ControlSource   = "cursor_4c_ItensOper.codtams"
1076:             .Width           = 60
1077:             .Header1.Caption = "Tam"
1078:         ENDWITH
1079:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4
1080:             .ControlSource   = "cursor_4c_ItensOper.qtds"
1081:             .Width           = 90
1082:             .Header1.Caption = "Quantidade"
1083:         ENDWITH
1084:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5
1085:             .ControlSource   = "cursor_4c_ItensOper.locals"
1086:             .Width           = 110
1087:             .Header1.Caption = "Local"
1088:         ENDWITH
1089:     ENDPROC
1090: 
1091:     *==========================================================================
1092:     * METODOS DE NEGOCIO
1093:     *==========================================================================
1094: 
1095:     PROCEDURE CarregarLista()
1096:     *==========================================================================
1097:         THIS.this_oBusinessObject.this_dDataInicial = ;
1098:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value
1099:         THIS.this_oBusinessObject.this_dDataFinal = ;
1100:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value
1101:         THIS.this_oBusinessObject.Buscar("")
1102:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = ""
1103:         IF USED("cursor_4c_Dados")
1104:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 3
1105:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
1106:         ENDIF
1107:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
1108:     ENDPROC
1109: 
1110:     PROCEDURE AbrirNovoBatch()
1111:     *==========================================================================
1112:         THIS.this_cEscolha = "INSERIR"
1113:         THIS.this_cCodigos = ALLTRIM(TRANSFORM(fGerUniqueKey("SIGPRDIS"), "@L 9999999999"))
1114:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = THIS.this_cCodigos
1115:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "NOVO"
1116: 
1117:         IF THIS.this_oBusinessObject.BuscarEstoques()
1118:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1119:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1120:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1121:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1122:         ENDIF
1123: 
1124:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
1125:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .F.
1126:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
1127:         THIS.pgf_4c_Paginas.ActivePage = 2
1128:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1129:     ENDPROC
1130: 
1131:     PROCEDURE AbrirBatchExistente(par_cCodigos)
1132:     *==========================================================================
1133:         THIS.this_cEscolha = "ALTERAR"
1134:         THIS.this_cCodigos = par_cCodigos
1135:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = par_cCodigos
1136:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "EDITAR"
1137: 
1138:         THIS.this_oBusinessObject.InicializarLote(par_cCodigos)
1139: 
1140:         IF THIS.this_oBusinessObject.BuscarEstoques()
1141:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1142:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1143:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1144:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1145:         ENDIF
1146: 
1147:         *-- Pre-marcar estoques do lote
1148:         IF USED("cursor_4c_Estoques") AND USED("cursor_4c_LotePrDis")
1149:             LOCAL loc_cEmpEst AS String
1150:             SELECT cursor_4c_Estoques
1151:             GO TOP
1152:             DO WHILE !EOF("cursor_4c_Estoques")
1153:                 loc_cEmpEst = ALLTRIM(cursor_4c_Estoques.emps)
1154:                 SELECT cursor_4c_LotePrDis
1155:                 LOCATE FOR ALLTRIM(empds) = loc_cEmpEst
1156:                 IF FOUND()
1157:                     REPLACE nMarca WITH 1 IN cursor_4c_Estoques
1158:                 ENDIF
1159:                 SELECT cursor_4c_Estoques
1160:                 SKIP
1161:             ENDDO
1162:             GO TOP IN cursor_4c_Estoques
1163:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1164:         ENDIF
1165: 
1166:         *-- Carregar operacoes existentes
1167:         IF THIS.this_oBusinessObject.BuscarOperacoes(par_cCodigos)
1168:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = ""
1169:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.ColumnCount = 6
1170:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = "cursor_4c_CabOpera"
1171:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Refresh()
1172:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .T.
1173:         ENDIF
1174: 
1175:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
1176:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
1177:         THIS.pgf_4c_Paginas.ActivePage = 2
1178:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1179:     ENDPROC
1180: 
1181:     *==========================================================================
1182:     * HANDLERS DE EVENTOS
1183:     *==========================================================================
1184: 
1185:     PROCEDURE BtnEncerrarClick()
1186:     *==========================================================================

*-- Linhas 1230 a 1327:
1230:     PROCEDURE TxtDtFinalLostFocus()
1231:     *==========================================================================
1232:         THIS.CarregarLista()
1233:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
1234:     ENDPROC
1235: 
1236:     PROCEDURE BtnVoltarListaClick()
1237:     *==========================================================================
1238:         THIS.pgf_4c_Paginas.Visible = .T.
1239:         THIS.pgf_4c_Paginas.ActivePage = 1
1240:         THIS.CarregarLista()
1241:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1242:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
1243:         ELSE
1244:             THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
1245:         ENDIF
1246:     ENDPROC
1247: 
1248:     PROCEDURE BtnVoltarEstClick()
1249:     *==========================================================================
1250:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 1
1251:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1252:     ENDPROC
1253: 
1254:     PROCEDURE BtnMarcarClick()
1255:     *==========================================================================
1256:         IF USED("cursor_4c_Estoques")
1257:             SELECT cursor_4c_Estoques
1258:             REPLACE ALL nMarca WITH 1
1259:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1260:         ENDIF
1261:     ENDPROC
1262: 
1263:     PROCEDURE BtnDesmarcarClick()
1264:     *==========================================================================
1265:         IF USED("cursor_4c_Estoques")
1266:             SELECT cursor_4c_Estoques
1267:             REPLACE ALL nMarca WITH 0
1268:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1269:         ENDIF
1270:     ENDPROC
1271: 
1272:     PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1273:     *==========================================================================
1274:         NODEFAULT
1275:         IF USED("cursor_4c_Estoques")
1276:             SELECT cursor_4c_Estoques
1277:             REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
1278:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1279:         ENDIF
1280:     ENDPROC
1281: 
1282:     PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1283:     *==========================================================================
1284:         IF INLIST(par_nKeyCode, 13, 32)
1285:             IF USED("cursor_4c_Estoques")
1286:                 SELECT cursor_4c_Estoques
1287:                 REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
1288:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1289:             ENDIF
1290:         ENDIF
1291:     ENDPROC
1292: 
1293:     PROCEDURE BtnProcessarPage1Click()
1294:     *==========================================================================
1295:         IF THIS.this_oBusinessObject.PrepararCursoresDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
1296:             LOCAL loc_oSub2 AS Object
1297:             loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1298:             loc_oSub2.grd_4c_Disponivel.RecordSource = ""
1299:             IF USED("cursor_4c_Disponivel")
1300:                 loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1301:                 loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1302:             ENDIF
1303:             loc_oSub2.grd_4c_Disponivel.Refresh()
1304:             loc_oSub2.grd_4c_Distribui.RecordSource = ""
1305:             IF USED("cursor_4c_Distribui")
1306:                 loc_oSub2.grd_4c_Distribui.ColumnCount = 4
1307:                 loc_oSub2.grd_4c_Distribui.RecordSource = "cursor_4c_Distribui"
1308:             ENDIF
1309:             loc_oSub2.grd_4c_Distribui.Refresh()
1310:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .T.
1311:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 2
1312:             loc_oSub2.grd_4c_Disponivel.SetFocus()
1313:         ENDIF
1314:     ENDPROC
1315: 
1316:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
1317:     *==========================================================================
1318:         IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel")
1319:             LOCAL loc_cCpros AS String
1320:             SELECT cursor_4c_Disponivel
1321:             loc_cCpros = ALLTRIM(cursor_4c_Disponivel.cpros)
1322:             IF !EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.BuscarProduto(loc_cCpros)
1323:                 LOCAL loc_oSub2 AS Object
1324:                 loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1325:                 SELECT cursor_4c_Produto
1326:                 loc_oSub2.txt_4c_CdGrupo.Value      = TratarNulo(cgrus,  "C")
1327:                 loc_oSub2.txt_4c_DsGrupoP.Value     = TratarNulo(dgrus,  "C")

*-- Linhas 1345 a 1375:
1345:             THIS.this_oBusinessObject.CalcularSaldo(loc_cCpros, loc_cCodCors, loc_cCodTams)
1346:             LOCAL loc_oSub2 AS Object
1347:             loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1348:             loc_oSub2.grd_4c_Disponivel.Refresh()
1349:             loc_oSub2.grd_4c_Distribui.Refresh()
1350:         ENDIF
1351:     ENDPROC
1352: 
1353:     PROCEDURE GrdDistribuiLocalValid()
1354:     *==========================================================================
1355:         LOCAL loc_cLocal AS String, loc_nRes AS Number, loc_oLookup AS Object
1356:         LOCAL loc_lSucesso, loc_oErro
1357:         loc_lSucesso = .F.
1358:         TRY
1359:             loc_cLocal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2 ;
1360:                 .grd_4c_Distribui.Column4.Text1.Value)
1361:             IF !EMPTY(loc_cLocal)
1362:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1363:                     "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Codigos LIKE " + ;
1364:                     EscaparSQL(loc_cLocal + "%") + " ORDER BY Codigos", ;
1365:                     "cursor_4c_Locais", "Codigos", loc_cLocal, ;
1366:                     "Localiza" + CHR(231) + CHR(227) + "o")
1367:                 IF VARTYPE(loc_oLookup) = "O"
1368:                     loc_oLookup.AddColuna("Codigos",    "", "Localiza" + CHR(231) + CHR(227) + "o")
1369:                     loc_oLookup.AddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1370:                     loc_oLookup.Show()
1371:                     IF USED("cursor_4c_Locais") AND RECCOUNT("cursor_4c_Locais") > 0
1372:                         IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
1373:                             REPLACE cursor_4c_Distribui.locals WITH ALLTRIM(cursor_4c_Locais.Codigos)
1374:                         ENDIF
1375:                     ENDIF

*-- Linhas 1389 a 1427:
1389:     *==========================================================================
1390:         DO CASE
1391:             CASE par_nKeyCode = 9
1392:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.grd_4c_Disponivel.Column1.SetFocus()
1393:                 NODEFAULT
1394:             CASE par_nKeyCode = 115
1395:                 THIS.GrdDistribuiLocalValid()
1396:                 NODEFAULT
1397:         ENDCASE
1398:     ENDPROC
1399: 
1400:     PROCEDURE TxtProdutoInicialValid()
1401:     *==========================================================================
1402:         LOCAL loc_cCpros AS String, loc_nRec AS Number
1403:         loc_cCpros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.txt_4c_ProdutoInicial.Value)
1404:         IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Disponivel")
1405:             SELECT cursor_4c_Disponivel
1406:             loc_nRec = RECNO()
1407:             GO TOP
1408:             LOCATE FOR ALLTRIM(cpros) >= loc_cCpros
1409:             IF EOF()
1410:                 GO loc_nRec
1411:             ENDIF
1412:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.grd_4c_Disponivel.Refresh()
1413:         ENDIF
1414:     ENDPROC
1415: 
1416:     PROCEDURE TxtCGrupoValid()
1417:     *==========================================================================
1418:         LOCAL loc_cCodigo AS String, loc_nRes AS Number, loc_oLookup AS Object, loc_oErro
1419:         LOCAL loc_oSub2 AS Object
1420:         loc_oSub2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1421:         loc_cCodigo = ALLTRIM(loc_oSub2.txt_4c_CodGrupo.Value)
1422:         IF EMPTY(loc_cCodigo)
1423:             loc_oSub2.txt_4c_DsGrupo.Value = ""
1424:         ELSE
1425:             TRY
1426:                 IF USED("cursor_4c_GrpBusca")
1427:                     USE IN cursor_4c_GrpBusca

*-- Linhas 1501 a 1554:
1501:         ENDIF
1502:     ENDPROC
1503: 
1504:     PROCEDURE BtnFiltrarClick()
1505:     *==========================================================================
1506:         LOCAL loc_oSub2 AS Object, loc_cCGrupo AS String, loc_nRes AS Number, loc_oErro
1507:         loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1508:         loc_cCGrupo = ALLTRIM(loc_oSub2.txt_4c_CodGrupo.Value)
1509:         IF !USED("cursor_4c_Disponivel")
1510:             RETURN
1511:         ENDIF
1512:         IF EMPTY(loc_cCGrupo)
1513:             loc_oSub2.grd_4c_Disponivel.RecordSource = ""
1514:             loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1515:             loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1516:             loc_oSub2.grd_4c_Disponivel.Refresh()
1517:         ELSE
1518:             TRY
1519:                 IF USED("cursor_4c_DispFiltro")
1520:                     USE IN cursor_4c_DispFiltro
1521:                 ENDIF
1522:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1523:                     "SELECT DISTINCT a.cpros," + ;
1524:                     "  ISNULL(p.dpros,'') AS dpros," + ;
1525:                     "  a.codcors, a.codtams," + ;
1526:                     "  SUM(a.qtdos) AS QtdEstoque," + ;
1527:                     "  SUM(a.qtds) AS QtdSaida," + ;
1528:                     "  (SUM(a.qtdos) - SUM(a.qtds)) AS QtdSaldo" + ;
1529:                     " FROM SigPrDis a" + ;
1530:                     " INNER JOIN SigCdPro p ON p.cpros = a.cpros" + ;
1531:                     " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
1532:                     "   AND p.cgrus = " + EscaparSQL(loc_cCGrupo) + ;
1533:                     " GROUP BY a.cpros, p.dpros, a.codcors, a.codtams" + ;
1534:                     " ORDER BY a.cpros, a.codcors, a.codtams", "cursor_4c_DispFiltro")
1535:                 IF loc_nRes > 0
1536:                     loc_oSub2.grd_4c_Disponivel.RecordSource = ""
1537:                     loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1538:                     loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_DispFiltro"
1539:                     loc_oSub2.grd_4c_Disponivel.Refresh()
1540:                 ENDIF
1541:             CATCH TO loc_oErro
1542:                 MsgErro(loc_oErro.Message, "Erro Filtrar")
1543:             ENDTRY
1544:         ENDIF
1545:     ENDPROC
1546: 
1547:     PROCEDURE ImgFotoClick()
1548:     *==========================================================================
1549:         LOCAL loc_nRes AS Number, loc_cArquivo AS String, loc_oErro
1550:         IF !USED("cursor_4c_Disponivel") OR EOF("cursor_4c_Disponivel")
1551:             RETURN
1552:         ENDIF
1553:         TRY
1554:             SELECT cursor_4c_Disponivel

*-- Linhas 1590 a 1643:
1590: 
1591:     PROCEDURE BtnSalvarClick()
1592:     *==========================================================================
1593:         IF THIS.this_oBusinessObject.ProcessarDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
1594:             MsgInfo("Distribui" + CHR(231) + CHR(227) + "o salva com sucesso.", "Sucesso")
1595:             THIS.this_cEscolha = "ALTERAR"
1596:             THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption = "EDITAR"
1597:             *-- Switch to operacoes page
1598:             IF THIS.this_oBusinessObject.BuscarOperacoes(THIS.this_cCodigos)
1599:                 LOCAL loc_oSub3 AS Object
1600:                 loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
1601:                 loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = ""
1602:                 IF USED("cursor_4c_CabOpera")
1603:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.ColumnCount = 6
1604:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = "cursor_4c_CabOpera"
1605:                 ENDIF
1606:                 loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Refresh()
1607:                 loc_oSub3.Enabled = .T.
1608:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 3
1609:             ENDIF
1610:         ENDIF
1611:     ENDPROC
1612: 
1613:     PROCEDURE BtnProcOperClick()
1614:     *==========================================================================
1615:         LOCAL loc_oSub3 AS Object, loc_cCodObs AS String, loc_cObs AS String
1616:         loc_oSub3   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
1617:         loc_cCodObs = ALLTRIM(loc_oSub3.cntOperacao.txt_4c_CodObs.Value)
1618:         loc_cObs    = ALLTRIM(loc_oSub3.cntOperacao.edt_4c_Obs.Value)
1619:         MsgAviso("Processamento de opera" + CHR(231) + CHR(245) + "es n" + ;
1620:                  CHR(227) + "o implementado nesta vers" + CHR(227) + "o." + CHR(13) + ;
1621:                  "O lote j" + CHR(225) + " foi salvo em SigPrDis.", "Informa" + CHR(231) + CHR(227) + "o")
1622:     ENDPROC
1623: 
1624:     PROCEDURE GrdCabOperasAfterRowColChange(par_nColIndex)
1625:     *==========================================================================
1626:         IF USED("cursor_4c_CabOpera") AND !EOF("cursor_4c_CabOpera")
1627:             SELECT cursor_4c_CabOpera
1628:             LOCAL loc_cEmpDopNums AS String
1629:             loc_cEmpDopNums = ALLTRIM(cursor_4c_CabOpera.empdopnums)
1630:             IF !EMPTY(loc_cEmpDopNums) AND THIS.this_oBusinessObject.BuscarItensOperacao(loc_cEmpDopNums)
1631:                 LOCAL loc_oSub3 AS Object
1632:                 loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
1633:                 loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.RecordSource = ""
1634:                 IF USED("cursor_4c_ItensOper")
1635:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.ColumnCount = 5
1636:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.RecordSource = "cursor_4c_ItensOper"
1637:                 ENDIF
1638:                 loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Refresh()
1639:             ENDIF
1640:         ENDIF
1641:     ENDPROC
1642: 
1643: ENDDEFINE

