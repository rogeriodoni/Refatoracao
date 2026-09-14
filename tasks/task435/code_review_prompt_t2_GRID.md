# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 573: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFUN.prg) - TRECHOS RELEVANTES PARA PASS GRID (3824 linhas total):

*-- Linhas 53 a 114:
53:             ELSE
54:                 *-- Criar cursores de trabalho locais (DataSession=2 privada)
55:                 SET SAFETY OFF
56:                 SET NULL ON
57: 
58:                 CREATE CURSOR TmpCera ( ;
59:                     Tubos    N(2,0),   ;
60:                     BCeras   N(12,2),  ;
61:                     Bases    N(12,2),  ;
62:                     Ceras    N(12,2),  ;
63:                     PMetals  N(12,2),  ;
64:                     CodCors  C(4)  NULL, ;
65:                     Obss     M     NULL, ;
66:                     TempMets C(15) NULL, ;
67:                     TempAmbs C(15) NULL, ;
68:                     TempTubs C(15) NULL, ;
69:                     TempAgus C(15) NULL, ;
70:                     CodArvs  C(10) NULL, ;
71:                     Descs    C(40) NULL, ;
72:                     Formulas M     NULL, ;
73:                     MetalNvs N(12,2),  ;
74:                     pmetalrs N(12,2),  ;
75:                     nStatus  N(1,0)    ;
76:                 )
77:                 INDEX ON STR(Tubos, 2) TAG Tubos
78: 
79:                 CREATE CURSOR TmpTrf ( ;
80:                     Dopes    C(20),  ;
81:                     Numes    N(6,0), ;
82:                     Tubos    N(2,0), ;
83:                     nNumes   N(10,0) ;
84:                 )
85:                 INDEX ON STR(Tubos, 2) + Dopes + STR(Numes, 6) TAG Tubos
86: 
87:                 CREATE CURSOR TmpNop ( ;
88:                     Nops       N(10,0),  ;
89:                     Cpros      C(14),    ;
90:                     Qtds       N(10,3),  ;
91:                     Tubos      N(2,0),   ;
92:                     Qtdos      N(10,3),  ;
93:                     Numes      N(6,0),   ;
94:                     EmpDopNums C(29),    ;
95:                     DtEnts     D         ;
96:                 )
97:                 INDEX ON STR(Tubos, 2) + STR(Nops, 10) TAG Tubos
98: 
99:                 SET NULL OFF
100: 
101:                 *-- Carregar tipos de arvore para lookup local
102:                 THIS.CarregarArvores()
103: 
104:                 *-- Montar interface
105:                 THIS.ConfigurarPageFrame()
106:                 THIS.ConfigurarPaginaLista()
107:                 THIS.ConfigurarPaginaDados()
108:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
109:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
110: 
111:                 *-- Valores iniciais dos filtros
112:                 THIS.this_cPEmps  = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
113:                 THIS.this_dDtIni  = DATE()
114:                 THIS.this_dDtFim  = DATE()

*-- Linhas 545 a 623:
545:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
546: 
547:         *----------------------------------------------------------------------
548:         * grd_4c_Dados - Grade principal de listagem
549:         * Original: Grade.Top=157, Left=12, Width=944, Height=434 -> comp +29 = 186
550:         * ColumnCount DEVE ser setado FORA do WITH (nao cria colunas dentro do WITH)
551:         *----------------------------------------------------------------------
552:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
553:         loc_oPagina.grd_4c_Dados.ColumnCount = 5
554:         WITH loc_oPagina.grd_4c_Dados
555:             .Top                = 186
556:             .Left               = 12
557:             .Width              = 944
558:             .Height             = 434
559:             .FontName           = "Tahoma"
560:             .FontSize           = 8
561:             .ForeColor          = RGB(90, 90, 90)
562:             .BackColor          = RGB(255, 255, 255)
563:             .GridLineColor      = RGB(238, 158, 162)
564:             .HighlightBackColor = RGB(255, 255, 255)
565:             .HighlightForeColor = RGB(15, 41, 104)
566:             .HighlightStyle     = 2
567:             .DeleteMark         = .F.
568:             .RecordMark         = .F.
569:             .RowHeight          = 16
570:             .ScrollBars         = 2
571:             .GridLines          = 3
572:             .ReadOnly           = .T.
573:             .RecordSource       = "cursor_4c_Dados"
574:             .RecordSourceType   = 1
575:         ENDWITH
576: 
577:         WITH loc_oPagina.grd_4c_Dados.Column1
578:             .ControlSource   = "cursor_4c_Dados.codigos"
579:             .Width           = 52
580:             .Alignment       = 2
581:             .Header1.Caption = "C" + CHR(243) + "digo"
582:         ENDWITH
583: 
584:         WITH loc_oPagina.grd_4c_Dados.Column2
585:             .ControlSource   = "cursor_4c_Dados.datas"
586:             .Width           = 75
587:             .Header1.Caption = "Data"
588:         ENDWITH
589: 
590:         WITH loc_oPagina.grd_4c_Dados.Column3
591:             .ControlSource   = "cursor_4c_Dados.usuars"
592:             .Width           = 80
593:             .Header1.Caption = "Usu" + CHR(225) + "rio"
594:         ENDWITH
595: 
596:         WITH loc_oPagina.grd_4c_Dados.Column4
597:             .ControlSource   = "cursor_4c_Dados.codmaqfs"
598:             .Width           = 80
599:             .Header1.Caption = "M" + CHR(225) + "quina"
600:         ENDWITH
601: 
602:         WITH loc_oPagina.grd_4c_Dados.Column5
603:             .ControlSource   = "cursor_4c_Dados.obss"
604:             .Width           = 330
605:             .Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
606:         ENDWITH
607: 
608:         BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")
609: 
610:         THIS.TornarControlesVisiveis(loc_oPagina)
611:     ENDPROC
612: 
613:     *==========================================================================
614:     PROTECTED PROCEDURE ConfigurarPaginaDados()
615:     *==========================================================================
616:         LOCAL loc_oPagina
617:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
618: 
619:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
620:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
621: 
622:         *----------------------------------------------------------------------
623:         * cnt_4c_Salva - Botoes Confirmar/Cancelar (Fase 4 adiciona os botoes)

*-- Linhas 883 a 905:
883:                 loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
884: 
885:                 *-- Re-definir ControlSources apos Buscar() recriar cursor_4c_Dados (autobind por posicao)
886:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
887:                     LOCAL loc_oGrd
888:                     loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
889:                     loc_oGrd.ColumnCount = 5
890:                     loc_oGrd.RecordSource          = "cursor_4c_Dados"
891:                     loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.codigos"
892:                     loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.datas"
893:                     loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.usuars"
894:                     loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.codmaqfs"
895:                     loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.obss"
896:                 ENDIF
897: 
898:                 *-- Ocultar aguarde
899:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
900:             ENDIF
901:         CATCH TO loc_oErro
902:             MsgErro("Erro em FormFUN.CarregarLista: " + loc_oErro.Message, "Erro")
903:             TRY
904:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
905:             CATCH

*-- Linhas 1085 a 1124:
1085:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1086:                         IF THIS.this_oBusinessObject.Excluir()
1087:                             THIS.CarregarLista()
1088:                             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1089:                                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1090:                             ENDIF
1091:                             loc_lSucesso = .T.
1092:                         ENDIF
1093:                     ENDIF
1094:                 ENDIF
1095:             ENDIF
1096:         CATCH TO loc_oErro
1097:             MsgErro("Erro em FormFUN.BtnExcluirClick: " + loc_oErro.Message, "Erro")
1098:         ENDTRY
1099: 
1100:         RETURN loc_lSucesso
1101:     ENDPROC
1102: 
1103:     *==========================================================================
1104:     PROCEDURE BtnBuscarClick()
1105:     *==========================================================================
1106:         TRY
1107:             THIS.CarregarLista()
1108:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1109:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1110:             ENDIF
1111:         CATCH TO loc_oErro
1112:             MsgErro("Erro em FormFUN.BtnBuscarClick: " + loc_oErro.Message, "Erro")
1113:         ENDTRY
1114:     ENDPROC
1115: 
1116:     *==========================================================================
1117:     PROCEDURE BtnSalvarClick()
1118:     *==========================================================================
1119:         LOCAL loc_lSucesso
1120:         loc_lSucesso = .F.
1121: 
1122:         TRY
1123:             THIS.SalvarDadosTubo()
1124:             THIS.FormParaBO()

*-- Linhas 1705 a 1727:
1705:                     SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
1706:                     GO TOP
1707:                 ENDIF
1708:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_Gradenop", 5)
1709:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_Gradenop.Refresh()
1710:                 ENDIF
1711:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
1712:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
1713:                 ENDIF
1714:             ELSE
1715:                 THIS.LimparCamposTubo()
1716:             ENDIF
1717:         CATCH TO loc_oErro
1718:             MsgErro("Erro em FormFUN.ChkTubo " + TRANSFORM(par_nTubo) + ": " + ;
1719:                 loc_oErro.Message, "Erro")
1720:         ENDTRY
1721:     ENDPROC
1722: 
1723:     *==========================================================================
1724:     PROCEDURE LimparCampos()
1725:     *==========================================================================
1726:         LOCAL loc_oCnt1, loc_oCnt2, loc_oCnt3, loc_n, loc_cNomeChk
1727: 

*-- Linhas 2153 a 2218:
2153:             .BackColor = RGB(240, 240, 240)
2154:         ENDWITH
2155: 
2156:         loc_oCnt.AddObject("grd_4c_Gradenop", "Grid")
2157:         loc_oCnt.grd_4c_Gradenop.ColumnCount = 5
2158:         loc_oCnt.grd_4c_Gradenop.RecordSource = "TmpNop"
2159:         WITH loc_oCnt.grd_4c_Gradenop
2160:             .Top          = 48
2161:             .Left         = 7
2162:             .Width        = 435
2163:             .Height       = 122
2164:             .FontName     = "Tahoma"
2165:             .FontSize     = 8
2166:             .ReadOnly     = .T.
2167:             .GridLines    = 1
2168:             .HeaderHeight = 17
2169:             .RowHeight    = 17
2170:             .RecordMark   = .F.
2171:             .DeleteMark   = .F.
2172:         ENDWITH
2173: 
2174:         WITH loc_oCnt.grd_4c_Gradenop.Column1
2175:             .Header1.Caption = "O.P."
2176:             .ControlSource   = "TmpNop.Nops"
2177:             .Width           = 60
2178:         ENDWITH
2179: 
2180:         WITH loc_oCnt.grd_4c_Gradenop.Column2
2181:             .Header1.Caption = "Produto"
2182:             .ControlSource   = "TmpNop.Cpros"
2183:             .Width           = 110
2184:         ENDWITH
2185: 
2186:         WITH loc_oCnt.grd_4c_Gradenop.Column3
2187:             .Header1.Caption = "Qtde"
2188:             .ControlSource   = "TmpNop.Qtds"
2189:             .Width           = 60
2190:         ENDWITH
2191: 
2192:         WITH loc_oCnt.grd_4c_Gradenop.Column4
2193:             .Header1.Caption = "Pedido"
2194:             .ControlSource   = "TmpNop.Numes"
2195:             .Width           = 50
2196:         ENDWITH
2197: 
2198:         WITH loc_oCnt.grd_4c_Gradenop.Column5
2199:             .Header1.Caption = "Data Entrega"
2200:             .ControlSource   = "TmpNop.DtEnts"
2201:             .Width           = 90
2202:         ENDWITH
2203:         BINDEVENT(loc_oCnt.grd_4c_Gradenop, "AfterRowColChange", THIS, "GradenopAfterRowColChange")
2204: 
2205:         loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
2206:         WITH loc_oCnt.txt_4c_Operacao
2207:             .Value     = ""
2208:             .Left      = 18
2209:             .Top       = 171
2210:             .Width     = 290
2211:             .Height    = 25
2212:             .ReadOnly  = .T.
2213:             .FontName  = "Tahoma"
2214:             .FontSize  = 8
2215:             .BackColor = RGB(240, 240, 240)
2216:         ENDWITH
2217: 
2218:         loc_oCnt.AddObject("cmd_4c_AdicionarNop", "CommandButton")

*-- Linhas 2291 a 2334:
2291:         ENDWITH
2292:         BINDEVENT(loc_oCnt.txt_4c_Trf, "KeyPress", THIS, "TrfLostFocus")
2293: 
2294:         loc_oCnt.AddObject("grd_4c_GradeTrf", "Grid")
2295:         loc_oCnt.grd_4c_GradeTrf.ColumnCount = 2
2296:         loc_oCnt.grd_4c_GradeTrf.RecordSource = "TmpTrf"
2297:         WITH loc_oCnt.grd_4c_GradeTrf
2298:             .Top          = 216
2299:             .Left         = 209
2300:             .Width        = 233
2301:             .Height       = 122
2302:             .FontName     = "Tahoma"
2303:             .FontSize     = 8
2304:             .ReadOnly     = .T.
2305:             .GridLines    = 1
2306:             .HeaderHeight = 17
2307:             .RowHeight    = 17
2308:             .RecordMark   = .F.
2309:             .DeleteMark   = .F.
2310:         ENDWITH
2311: 
2312:         WITH loc_oCnt.grd_4c_GradeTrf.Column1
2313:             .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2314:             .ControlSource   = "TmpTrf.Dopes"
2315:             .Width           = 155
2316:         ENDWITH
2317: 
2318:         WITH loc_oCnt.grd_4c_GradeTrf.Column2
2319:             .Header1.Caption = "Numes"
2320:             .ControlSource   = "TmpTrf.Numes"
2321:             .Width           = 55
2322:         ENDWITH
2323: 
2324:         loc_oCnt.AddObject("cmd_4c_RemoverTrf", "CommandButton")
2325:         WITH loc_oCnt.cmd_4c_RemoverTrf
2326:             .Caption         = ""
2327:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2328:             .PicturePosition = 4
2329:             .Top             = 297
2330:             .Left            = 165
2331:             .Width           = 40
2332:             .Height          = 40
2333:             .Themes          = .T.
2334:             .SpecialEffect   = 0

*-- Linhas 2723 a 2760:
2723:             .ForeColor = RGB(36, 84, 155)
2724:         ENDWITH
2725: 
2726:         loc_oCnt.AddObject("grd_4c_TmpTot", "Grid")
2727:         loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
2728:         WITH loc_oCnt.grd_4c_TmpTot
2729:             .Top                     = 49
2730:             .Left                    = 28
2731:             .Width                   = 354
2732:             .Height                  = 122
2733:             .FontName                = "Tahoma"
2734:             .FontSize                = 8
2735:             .ReadOnly                = .T.
2736:             .GridLines               = 1
2737:             .HeaderHeight            = 17
2738:             .RowHeight               = 17
2739:             .Column1.Header1.Caption = "Tipo " + CHR(193) + "rvore"
2740:             .Column1.Width           = 80
2741:             .Column2.Header1.Caption = "Metal Real"
2742:             .Column2.Width           = 80
2743:             .Column3.Header1.Caption = "Metal Novo"
2744:             .Column3.Width           = 80
2745:             .Column4.Header1.Caption = "Metal Ligado"
2746:             .Column4.Width           = 80
2747:             .RecordMark   = .F.
2748:             .DeleteMark   = .F.
2749:         ENDWITH
2750: 
2751:         loc_oCnt.AddObject("cmd_4c_Retornar", "CommandButton")
2752:         WITH loc_oCnt.cmd_4c_Retornar
2753:             .Caption         = "Retornar"
2754:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_26.jpg"
2755:             .PicturePosition = 13
2756:             .Top             = 5
2757:             .Left            = 415
2758:             .Width           = 75
2759:             .Height          = 75
2760:             .FontName        = "Tahoma"

*-- Linhas 2914 a 2933:
2914:                 "Selecionar Cor", ;
2915:                 .T., .T., "")
2916:             IF VARTYPE(loc_oBusca) = "O"
2917:                 loc_oBusca.mAddColuna("cgrus", "9999", "C" + CHR(243) + "digo")
2918:                 loc_oBusca.mAddColuna("descs", "X(30)", "Descri" + CHR(231) + CHR(227) + "o")
2919:                 loc_oBusca.Show()
2920:                 THIS.ValidarCor()
2921:             ENDIF
2922:         CATCH TO loc_oErro
2923:             MsgErro("Erro em FormFUN.AbrirLookupCor: " + loc_oErro.Message, "Erro")
2924:         ENDTRY
2925:     ENDPROC
2926: 
2927:     *==========================================================================
2928:     PROCEDURE ValidarCor(par_nKeyCode, par_nShiftAltCtrl)
2929:     *==========================================================================
2930:         LOCAL loc_oCnt5, loc_cCodCor, loc_nResultado, loc_lSucesso
2931:         loc_lSucesso = .F.
2932: 
2933:         TRY

*-- Linhas 3011 a 3030:
3011:                 "Selecionar " + CHR(193) + "rvore", ;
3012:                 .T., .T., "")
3013:             IF VARTYPE(loc_oBusca) = "O"
3014:                 loc_oBusca.mAddColuna("codigos", "X(10)", "C" + CHR(243) + "digo")
3015:                 loc_oBusca.mAddColuna("descs",   "X(40)", "Descri" + CHR(231) + CHR(227) + "o")
3016:                 loc_oBusca.Show()
3017:                 THIS.ValidarArvore()
3018:             ENDIF
3019:         CATCH TO loc_oErro
3020:             MsgErro("Erro em FormFUN.AbrirLookupArvore: " + loc_oErro.Message, "Erro")
3021:         ENDTRY
3022:     ENDPROC
3023: 
3024:     *==========================================================================
3025:     PROCEDURE ValidarArvore(par_nKeyCode, par_nShiftAltCtrl)
3026:     *==========================================================================
3027:         LOCAL loc_oPg2, loc_cCodArv, loc_cDescs, loc_lSucesso
3028:         loc_lSucesso = .F.
3029: 
3030:         TRY

*-- Linhas 3118 a 3137:
3118:                 "Selecionar " + CHR(193) + "rvore", ;
3119:                 .T., .T., "")
3120:             IF VARTYPE(loc_oBusca) = "O"
3121:                 loc_oBusca.mAddColuna("codigos", "X(10)", "C" + CHR(243) + "digo")
3122:                 loc_oBusca.mAddColuna("descs",   "X(40)", "Descri" + CHR(231) + CHR(227) + "o")
3123:                 loc_oBusca.Show()
3124:                 THIS.ValidarArvore()
3125:             ENDIF
3126:         CATCH TO loc_oErro
3127:             MsgErro("Erro em FormFUN.AbrirLookupArvoreDesc: " + loc_oErro.Message, "Erro")
3128:         ENDTRY
3129:     ENDPROC
3130: 
3131:     *==========================================================================
3132:     PROCEDURE CalcMetal()
3133:     *==========================================================================
3134:         LOCAL loc_oCnt5, loc_oPg2, loc_cCodArv, loc_cFormula
3135:         LOCAL loc_nBCeras, loc_nBases, loc_nCeras, loc_nPesoMetal, loc_nMetalNovo, loc_nPercs
3136:         LOCAL loc_lSucesso
3137:         loc_lSucesso = .F.

*-- Linhas 3464 a 3483:
3464:                     ENDIF
3465:                 ENDFOR
3466: 
3467:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
3468:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
3469:                 ENDIF
3470:             ENDIF
3471:             loc_lSucesso = .T.
3472:         CATCH TO loc_oErro
3473:             MsgErro("Erro em FormFUN.TuboLostFocus: " + loc_oErro.Message, "Erro")
3474:         ENDTRY
3475: 
3476:         RETURN loc_lSucesso
3477:     ENDPROC
3478: 
3479:     *==========================================================================
3480:     PROCEDURE TrfLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3481:     *==========================================================================
3482:         LOCAL loc_oCnt3, loc_cTrf, loc_nResultado, loc_lSucesso
3483:         LOCAL loc_nTuboAtual, loc_lRep, loc_nNNumes, loc_nT

*-- Linhas 3529 a 3548:
3529:                             ENDFOR
3530:                         ENDIF
3531: 
3532:                         IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5)
3533:                             loc_oCnt3.grd_4c_GradeTrf.Refresh()
3534:                         ENDIF
3535:                     ENDIF
3536:                     loc_oCnt3.txt_4c_Trf.Value = ""
3537:                     loc_lSucesso = .T.
3538:                 ELSE
3539:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o '" + loc_cTrf + ;
3540:                         "' n" + CHR(227) + "o encontrada.", ;
3541:                         "Opera" + CHR(231) + CHR(227) + "o")
3542:                     loc_oCnt3.txt_4c_Trf.Value = ""
3543:                 ENDIF
3544: 
3545:                 IF USED("cursor_4c_BuscaTrf")
3546:                     USE IN cursor_4c_BuscaTrf
3547:                 ENDIF
3548:             ENDIF

*-- Linhas 3610 a 3629:
3610:                                         loc_dDtEnt)
3611:                         ENDIF
3612: 
3613:                         IF PEMSTATUS(loc_oCnt3, "grd_4c_Gradenop", 5)
3614:                             loc_oCnt3.grd_4c_Gradenop.Refresh()
3615:                         ENDIF
3616:                     ENDIF
3617: 
3618:                     loc_oCnt3.txt_4c_Nop.Value  = 0
3619:                     loc_oCnt3.txt_4c_QtTb.Value = 0
3620:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3621:                         loc_oCnt3.txt_4c_Qtd.Value = 0
3622:                     ENDIF
3623:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
3624:                         loc_oCnt3.txt_4c_Pecas.Value = 0
3625:                     ENDIF
3626:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3627:                         loc_oCnt3.txt_4c_Operacao.Value = ""
3628:                     ENDIF
3629: 

*-- Linhas 3656 a 3682:
3656:             loc_oCnt3     = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3657:             loc_nTuboAtual = THIS.this_nTuboAtual
3658: 
3659:             IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5) AND USED("TmpTrf")
3660:                 SELECT TmpTrf
3661:                 IF !EOF("TmpTrf") AND TmpTrf.Tubos = loc_nTuboAtual
3662:                     DELETE
3663:                     SET FILTER TO
3664:                     PACK NOOPTIMIZE
3665:                     SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
3666:                     GO TOP
3667:                     loc_oCnt3.grd_4c_GradeTrf.Refresh()
3668:                 ENDIF
3669:             ENDIF
3670:             loc_lSucesso = .T.
3671:         CATCH TO loc_oErro
3672:             MsgErro("Erro em FormFUN.RemoverTrfClick: " + loc_oErro.Message, "Erro")
3673:         ENDTRY
3674: 
3675:         RETURN loc_lSucesso
3676:     ENDPROC
3677: 
3678:     *==========================================================================
3679:     PROCEDURE GradenopAfterRowColChange(par_nColIndex)
3680:     *==========================================================================
3681:         LPARAMETERS par_nColIndex
3682:         LOCAL loc_oCnt3, loc_lSucesso

*-- Linhas 3721 a 3758:
3721:                 GROUP BY TmpCera.CodArvs, TmpCera.Descs ;
3722:                 INTO CURSOR cursor_4c_TmpTot NOFILTER
3723:             ELSE
3724:                 SET NULL ON
3725:                 CREATE CURSOR cursor_4c_TmpTot ( ;
3726:                     CodArvs        C(10), ;
3727:                     Descs          C(40), ;
3728:                     PesoRealTotal  N(12,2), ;
3729:                     MetalNovoTotal N(12,2), ;
3730:                     PesoMetalTotal N(12,2) ;
3731:                 )
3732:                 SET NULL OFF
3733:             ENDIF
3734: 
3735:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Total
3736:             IF PEMSTATUS(loc_oCnt, "grd_4c_TmpTot", 5)
3737:                 loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
3738:                 loc_oCnt.grd_4c_TmpTot.RecordSource            = "cursor_4c_TmpTot"
3739:                 loc_oCnt.grd_4c_TmpTot.Column1.ControlSource   = "cursor_4c_TmpTot.CodArvs"
3740:                 loc_oCnt.grd_4c_TmpTot.Column2.ControlSource   = "cursor_4c_TmpTot.PesoRealTotal"
3741:                 loc_oCnt.grd_4c_TmpTot.Column3.ControlSource   = "cursor_4c_TmpTot.MetalNovoTotal"
3742:                 loc_oCnt.grd_4c_TmpTot.Column4.ControlSource   = "cursor_4c_TmpTot.PesoMetalTotal"
3743:                 loc_oCnt.grd_4c_TmpTot.Refresh()
3744:             ENDIF
3745: 
3746:             loc_oCnt.Visible = .T.
3747:             loc_oCnt.ZOrder(0)
3748:             loc_lSucesso = .T.
3749:         CATCH TO loc_oErro
3750:             MsgErro("Erro em FormFUN.BtnTotalClick: " + loc_oErro.Message, "Erro")
3751:         ENDTRY
3752: 
3753:         RETURN loc_lSucesso
3754:     ENDPROC
3755: 
3756:     *==========================================================================
3757:     PROCEDURE BtnCancelarTotalClick()
3758:     *==========================================================================

